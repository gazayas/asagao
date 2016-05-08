class EntriesController < ApplicationController

  before_action :login_required, except: [:index, :show]

  # 記事の一覧
  def index
    if params[:member_id]
      @memmber = Member.find(params[:member_id])
      @entries = @member.entries
    else
      @entries = Entry.all
    end
    @entries = @entries.readable_for(current_member)
      .order(posted_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  # 記事詳細
  def show
    @entry = Entry.readable_for(current_member).find(params[:id])
  end

  def new
  end

  def edit
  end
end
