
# Laravel
vim .env
```
DB_CONNECTION=mysql
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=app01DB
DB_USERNAME=db01owner
DB_PASSWORD=Kokouya723$
```

【 migrationコマンド 】
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
# postsテーブル作成 (artisanファイルは Laravelで作成したprojectのルートにある)
php artisan make:migration create_posts_table --create=posts

# table posts作成
php artisan migrate

エラ－回避)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[PDOException]
could not find driver

# php-mysqlndをつっこむ
sudo yum --enablerepo=remi-php70,epel install -y php-mysqlnd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# table確認
mysql -u root
use app01DB;
desc posts;

php artisan make:model Post;


**既存テーブルに変更を加える**
php artisan make:migration add_column_summary_to_posts_table --table=posts;

vim database/migrations/2016_05_07_102509_add_column_summary_to_posts_table.php
--------------------
 13     public function up()
 14     {
 15         Schema::table('posts', function (Blueprint $table) {
 16             $table->string('title');
 17             $tanle->text('body');
 18         });
 19     }
 20
 21     /**
 22      * Reverse the migrations.
 23      *
 24      * @return void
 25      */
 26     public function down()
 27     {
 28         Schema::table('posts', function (Blueprint $table) {
 29             $table->dropColumn('title');
 30             $table->dropColumn('body');
 31         });
 32     }
--------------------

php artisan migrate

**適用されているmigrate確認**
php artisan migrate:status

**1個前の変更を戻す**
php artisan migrate:rollback

エラ－回避)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[Symfony\Component\Debug\Exception\FatalThrowableError]
Fatal error: Class 'AddColumnSummaryToPostsTable' not found

# これを叩くと直る(理由はわからん)
sudo php /usr/local/bin/composer dump-autoload
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――

【tinker コマンド】
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
# 対話的にコマンドを実行する
php artisan tinker

# インスタンス生成し、postsテーブルへinsert
$post = new App\Post();
$post->title = 'title 1';
$post->body = 'body 1';
$post->save();

# createメソッドを使い、postsテーブルへinsert
App\Post::create(['title'=>'title 2', 'body'=>'body 2']);

エラー回避)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Illuminate\Database\Eloquent\MassAssignmentException with message 'title'

#app/Post.phpに以下を設定する必要ある。
protected $fillable = ['title', 'body'];
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Postモデルの値を全て取得
App\Post::all()->toArray();


# 条件とソート順を指定
App\Post::where('id', '>', 1)->orderBy('created_at', 'desc')->get()->toArray();

# 1レコード目のみ抽出(sqlのlimit)
App\Post::where('id', '>', 1)->take(1)->get()->toArray();

# id = 3 のレコードを取得
$post = App\Post::find(3);

# 更新
App\Post::find(1)->update(['title'=>'title 3 updated again']);

# レコードの削除
$post->delete();
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――


sudo vim app/Http/routes.php


ルーティングは下に一番下にあるやつを実行する
Route::get('/', function() {});

URLのパラメータを取得
Route::get('/{name}', function($name) {
  return $name;
});


index.blade.php


Route から Controller 呼び出し
Route::get('/', 'PostsController@index');

Viewへの値渡し。
― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ―
Controller
return view('posts.index', ['posts', $posts]);  または
return view('posts.index')->with('posts', $posts);

・View
@foreach($posts as $post)
    <p style="font-style: bold;">{{$post->title}}</p>
@endforeach

※{{}}で囲むとエスケープされる


<p style="font-style: bold;">{!! nl2br(e($post->body)) !!}</p>
{!! !!} エスケープしないで表示
e()  エスケープ
nl2br() 改行をbrへ変換
― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ― ―
