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

  # 新規登録フォーム
  def new
    @entry = Entry.new(posted_at: Time.current)
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.author = current_member
    if @entry.save
      redirect_to @entry, notice: "記事を作成しました。"
    else
      render "new"
    end
  end

  # 編集フォーム
  def edit
    @entry = current_member.entries.find(params[:id])
  end

  def update
    @entry = current_member.entries.find(params[:id])
    @entry.assign_attributes(entry_params)
    if @entry.save
      redirect_to @entry, notice: "記事を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @entry = current_member.entries.find(params[:id])
    @entry.destroy
    redirect_to :entries, notice: "記事を削除しました。"
  end

  def like
    @entry = Entry.published.find(params[:id])
    current_member.voted_entries << @entry
    # publishedスコープで下書き以外の記事を取り出し、
    # Memberモデルのvoted_entriesに対して << で関連付けます。
    redirect_to @entry, notice: "投票しました。"
  end

  def unlike
    current_member.voted_entries.destroy(Entry.find(params[:id]))
    redirect_to :voted_entries, notice: "削除しました。"
  end

  def voted
    @entries = current_member.voted_entries.published.order("votes.created_at DESC")
                .paginate(page: params[:page], per_page: 15)
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :body, :posted_at, :status)
  end



end
