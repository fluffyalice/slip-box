class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  def index
    if session[:selected_note].nil?
      session[:selected_note] = current_user.notes.where(thread_id:0).first
      if session[:selected_note].nil?
        session[:selected_note] = create_root_card
      end
      session[:current_thread_id] = session[:selected_note][:thread_id]
      session[:branch_mode] = false
    end
    
    get_search
    get_thread
    get_branches
  end

  # GET /notes/1
  def show
  end

  # GET /notes/new
  def new
    @note = current_user.notes.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      if session[:make_branch_link]
        session[:selected_note].links_to << @note
        session[:make_branch_link] = false
      end
      redirect_to notes_url

    else
      render :new
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      redirect_to notes_url
    else
      render :edit
    end
  end

  # DELETE /notes/1
  def destroy
    if session[:selected_note][:thread_id] == 0
      message = "Can't Destroy Root Note"
    else
      session[:selected_note].destroy
      message = "Note Destroyed"
    end
    return message
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = current_user.notes.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def note_params
    params.require(:note).permit(:title, :content, :reference_id, :type_id, :tag_ids => []).merge(last_edit: DateTime.now, thread_id: session[:target_thread_id], position: session[:target_position])
  end

  def create_root_card
    root_type = current_user.types.create(type_name:"Root Type", colour_code: "#ebd35e")
    root_ref = current_user.references.create(author:"Myself!", title: "Unreferenced")
    root_card = current_user.notes.new(title:"Root Card", content:"This is the Root Card", thread_id:0, position:0, last_edit:DateTime.now)
    root_card.type = root_type
    root_card.reference = root_ref
    root_card.save!
    return root_card
  end

  def search
    session[:tag] = params[:tag]
    session[:reference] = params[:reference]
    session[:keyword] = params[:keyword]
    get_search
    redirect_to notes_url
  end

  def actions_manager

    temp = session[:selected_note]
    session[:selected_note] = current_user.notes.where(id:params[:main_form]).first
    redirect = notes_url

    if params[:commit] == "Go To Thread"
      session[:previous_thread_id] = session[:current_thread_id]
      session[:current_thread_id] = session[:selected_note][:thread_id]

    elsif params[:commit] == "Edit"
      redirect = edit_note_path(session[:selected_note])
      session[:target_thread_id] = session[:selected_note][:thread_id]
      session[:target_position] = session[:selected_note][:position]

    elsif params[:commit] == "Delete"
      message = destroy

    elsif params[:commit] == "Start Link From Note"
      session[:link_from_note] = session[:selected_note]

    elsif params[:commit] == "Land Link To Note"
      message = create_link

    elsif params[:commit] == "Undo Linking Mode"
      session[:link_from_note] = nil

    elsif params[:commit] == "Show Note Branches"
      session[:branch_mode] = true

    elsif params[:commit] == "Start Subthread"
      message, redirect = start_subthread

    elsif params[:commit] == "Previous Thread"
      temp = session[:current_thread_id]
      session[:current_thread_id] = session[:previous_thread_id]
      session[:previous_thread_id] = temp

    elsif params[:commit] == "Add Card To Right"
      message, redirect = create_on_thread
      
    elsif params[:commit] == "Show Thread Branches"
      session[:branch_mode] = false

    elsif params[:commit] == "Remove Link"
      message = remove_link(temp)
    end

    redirect_to redirect, notice: message
  end

  # get the results of the search
  def get_search

    if session[:tag].nil? or session[:reference].nil? or session[:keyword].nil?
      session[:tag] = ""
      session[:reference] = ""
      session[:keyword] = ""
    end

    wordnil = true
    if !session[:keyword][0].nil?
      session[:keyword] = "%"+ActionView::Base.full_sanitizer.sanitize(session[:keyword].downcase).truncate(40)+"%"
      wordnil = false
    end
    tagnil = session[:tag][0].nil?
    refnil = session[:reference][0].nil?

    if !wordnil and !tagnil and !refnil #111
      @current_search = current_user.notes.joins(:notes_tags).where("lower(notes.title) LIKE ? AND notes_tags.tag_id = ? AND notes.reference_id = ?", session[:keyword], session[:tag], session[:reference]).order(:last_edit).reverse_order
    elsif wordnil and !tagnil and !refnil #011
      @current_search = current_user.notes.joins(:notes_tags).where("notes_tags.tag_id = ? AND notes.reference_id = ?", session[:tag], session[:reference]).order(:last_edit).reverse_order
    elsif !wordnil and tagnil and !refnil #101
      @current_search = current_user.notes.where("lower(notes.title) LIKE ? AND notes.reference_id = ?", session[:keyword], session[:reference]).order(:last_edit).reverse_order
    elsif !wordnil and !tagnil and refnil #110
      @current_search = current_user.notes.joins(:notes_tags).where("lower(notes.title) LIKE ? AND notes_tags.tag_id = ?", session[:keyword], session[:tag]).order(:last_edit).reverse_order
    elsif wordnil and tagnil and !refnil #001
      @current_search = current_user.notes.where("notes.reference_id = ?", session[:reference]).order(:last_edit).reverse_order
    elsif wordnil and !tagnil and refnil #010
      @current_search = current_user.notes.joins(:notes_tags).where("notes_tags.tag_id = ?", session[:tag]).order(:last_edit).reverse_order
    elsif !wordnil and tagnil and refnil #100
      @current_search = current_user.notes.where("lower(notes.title) LIKE ?", session[:keyword]).order(:last_edit).reverse_order
    else #000
      @current_search = current_user.notes.all.order(:last_edit).reverse_order
    end
    return @current_search
  end

  # return the branch relative to the thread
  def get_branches
    if session[:branch_mode]
      @current_branches = session[:selected_note].links_to
    else
      get_thread
      @current_branches = []
      @current_thread.each {|note| @current_branches.push(*note.links_to)} 
    end
    return @current_branches
  end

  # return the current thread
  def get_thread
      @current_thread = current_user.notes.where(thread_id:session[:current_thread_id]).order(:position)
      return @current_thread
  end

  def start_subthread
    get_thread
    if @current_thread.any?{|note| note[:id] == session[:selected_note][:id]}
      max_thread = current_user.notes.maximum("thread_id")
      session[:target_thread_id] = max_thread + 1
      session[:target_position] = 0
      session[:make_branch_link] = true
      redirect = new_note_path
    else
      message = "Selected card must be in Thread Navigator"
      redirect = notes_url
    end
    return message, redirect
  end 

  def create_on_thread
    if session[:selected_note][:thread_id] != 0
      get_thread
      if @current_thread.any?{|note| note[:id] == session[:selected_note][:id]}
        @current_thread.each {|note| note.increment!(:position) if note[:position] > session[:selected_note][:position]} 
        position = session[:selected_note][:position]
        session[:target_thread_id] = session[:current_thread_id]
        session[:target_position] = position + 1
        session[:make_branch_link] = false
        redirect = new_note_path
      else
        message = "Selected card must be in Thread Navigator"
        redirect = notes_url
      end
    else
        message = "Can't create a thread for the Root Card, add branches instead"
        redirect = notes_url
    end
    return message, redirect
  end 

  # creates a unidirectional skip-link between two notes
  # they are different because skip links don't appear in the browse tree
  def create_link
    if session[:link_from_note][:id] != session[:selected_note][:id]

      if !session[:link_from_note].links_to.any?{|note| note[:id] == session[:selected_note][:id]}
        session[:link_from_note].links_to << session[:selected_note]
      else
        message = "Link already exists"
      end

    else
      message = "Can't link card to itself"
    end

    session[:link_from_note] = nil
    return message
  end

  # removes a unidirectional skip-link between two notes
  def remove_link(note_from)
    get_branches
    if @current_branches.any?{|note| note[:id] == session[:selected_note][:id]}

      if session[:branch_mode]
        note_from.links_to.delete(session[:selected_note])
      else
        @current_thread.each {|note| note.links_to.delete(session[:selected_note])} 
      end

    else
      message = "Selected card must be in Branch Navigator"
    end
    return message
  end

end
