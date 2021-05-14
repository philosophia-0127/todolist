class TodolistsController < ApplicationController

  def new
    @list = List.new
  end

  def create
    # １. データを新規登録するためのインスタンス作成
    list = List.new(list_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
    list.save
    # ３. トップ画面へリダイレクト
    # redirect_to '/top'
    redirect_to todolist_path(list.id)
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to todolist_path(list.id)
  end

  def destroy
    list = List.find(params[:id])  # データ（レコード）を1件取得
    list.destroy  # データ（レコード）を削除
    redirect_to todolists_path  # 投稿一覧画面へリダイレクト
  end

  private #一種の境界線
  # コントローラに「def list_params...」を直接書いてしまうと、アクションとして認識されてしまいます。
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
#ストロングパラメータは、フォームの入力値をコントローラのcreateやupdateに渡す役割があります。
#さらにハッキングなどで不正に入力値を奪われないために、controllerの中でしか呼び出せないようにする役割もあります。

end
