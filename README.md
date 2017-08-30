<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Django Programming](#django-programming)
- [时间](#时间)
- [模板标签（templates tags）](#模板标签templates-tags)
- [Django代码模块](#django代码模块)
- [ModelForm与Form](#modelform与form)

<!-- /TOC -->

# Django Programming


**class Meta**

> 通过一个内嵌类 "class Meta" 给你的 model 定义元数据
> Model 元数据就是 "不是一个字段的任何数据" -- 比如排序选项, admin 选项等等.
> 下面是所有可能用到的 Meta 选项. 没有一个选项是必需的. 是否添加 class Meta 到你的 model 完全是可选的.

	db_table
	本模块在数据库中对应的表的名字:

	db_table = "pizza_orders"

	若不提供该参数, Django 会使用 app_label + '_' + module_name 作为表的名字.

	若你的表的名字是一个 SQL 保留字, 或包含 Python 变量名不允许的字符--特别是连字符 --没关系. Django 会自动在幕后替你将列名字和表名字用引号引起来.


	permissions
	要创建一个对象所需要的额外的权限. 如果一个对象有 admin 设置, 则每个对象的添加,删除和改变权限会人(依据该选项)自动创建.下面这个例子指定了一个附加权限: can_deliver_pizzas:

	permissions = (("can_deliver_pizzas", "Can deliver pizzas"),)

	这是一个2-元素 tuple 的tuple或列表, 其中两2-元素 tuple 的格式为:(permission_code, human_readable_permission_name). .



	verbose_name
	是该对象的一个可读性更好的唯一名字:

	verbose_name = "pizza"

	若未提供该选项, Django 则会用一个类名字的 munged 版本来代替: CamelCase becomes camel case.

	verbose_name_plural
	对象名字的复数:

	verbose_name_plural = "stories"

	若未提供该选项, Django 会使用 verbose_name + "s".



**装饰器--permission_required**

	from django.contrib.auth.decorators import permission_required

	@permission_required



**from rest_framework import serializers**

	# 在序列化对象里添加自定义内容
	# 该 Serializer 类定义了 ServerSerializer 中需要序列化/反序列化的各项。而其中的 create() 和 update() 函数会在 Serializer.save() 时相应调用。
	from rest_framework import serializers
	class ServerSerializer(serializers.ModelSerializer):



**models.Model**

> models.Model 表明Post是一个Django模型，所以Django知道它应该被保存在数据库中。

	class Post(models.Model):


**get_object_or_404()**

>详情视图（view）中，我们通过使用get_object_or_404()快捷方法来检索期望的Post。这个函数能取回匹配给予的参数的对象，或者当没有匹配的对象时返回一个HTTP 404（Not found）异常。



**get_absolute_url() && reverse()**

Django的惯例是给模型（model）添加get_absolute_url()方法用来返回一个对象的标准URL。在这个方法中，我们使用reverse()方法允许你通过它们的名字和可选的参数来构建URLS。编辑你的models.py文件添加如下代码：

	from django.core.urlresolvers import reverse
	Class Post(models.Model):
	    # ...
	    def get_absolute_url(self):
	        return reverse('blog:post_detail',
	                        args=[self.publish.year,
	                              self.publish.strftime('%m'),
	                              self.publish.strftime('%d'),
	                              self.slug])





#时间

**DateTimeField**

	#timezone.now 今天的日期
    publish = models.DateTimeField(default=timezone.now)
	#auto_now_add=True
	# 这个参数的默认值也为False，设置为True时，会在model对象第一次被创建时，将字段的值设置为创建时的时间，以后修改对象时，字段的值不会再更新。该属性通常被用在存储“创建时间”的场景下。与auto_now类似，auto_now_add也具有强制性，一旦被设置为True，就无法在程序中手动为字段赋值，在admin中字段也会成为只读的。
    created = models.DateTimeField(auto_now_add=True)
	# 这个参数的默认值为false，设置为true时，能够在保存该字段时，将其值设置为当前时间，并且每次修改model，都会自动更新。因此这个参数在需要存储“最后修改时间”的场景下，十分方便。需要注意的是，设置该参数为true时，并不简单地意味着字段的默认值为当前时间，而是指字段会被“强制”更新到当前时间，你无法程序中手动为字段赋值；如果使用django再带的admin管理器，那么该字段在admin中是只读的。
    updated = models.DateTimeField(auto_now=True)




# 模板标签（templates tags）

> Django有一个强大的模板（templates）语言允许你指定数据的如何进行展示。它基于模板标签（templates tags）， 例如{% tag %}, {{ variable }}以及模板过滤器（templates filters），可以对变量进行过滤，例如 {{ variable|filter }}。你可以通过访问 https://docs.djangoproject.com/en/1.8/ ref/templates/builtins/ 找到所有的内置模板标签（templates tags）和过滤器（filters）。

**{% load staticfiles %}**

[管理静态文件（CSS、图片等）](http://python.usyiyi.cn/translate/django_182/howto/static-files/index.html)
[开发环境中静态文件的管理与访问](https://shenxgan.gitbooks.io/django/content/publish/2015-07-21-django-static.html)


**通过{% extends %}模板标签（template tag）**


**{{ post.body|truncatewords:30|linebreaks }} -- truncatewords  linebreaks**

> truncatewords用来缩短内容限制在一定的字数内，linebreaks用来转换内容中的换行符为HTML的换行符。只要你喜欢你可以连接许多模板标签（tempalte filters），每一个都会应用到上个输出生成的结果上。
> linebreaks 用```<p>```或```<br>```标签包裹变量



**{% with %}**

> {% with %} 标签（tag）允许我们分配一个值给新的变量，这个变量可以一直使用直到遇到{% endwith %}标签（tag）。
> {% with %}模板（template）标签（tag）是非常有用的，可以避免直接操作数据库或避免多次调用花费较多的方法。



**pluralize 模板（template）过滤器（filter）**

	{% with comments.count as total_comments %}
	  <h2>
	    {{ total_comments }} comment{{ total_comments|pluralize }}
	  </h2>
	{% endwith %}

> 根据total_comments的值，我们使用pluralize 模板（template）过滤器（filter）为单词comment显示复数后缀。模板（Template）过滤器（filters）获取到他们输入的变量值，返回计算后的值。我们将会在第三章 扩展你的博客应用中讨论更多的模板过滤器（tempalte filters）。
>
> pluralize模板（template）过滤器（filter）在值不为1时，会在值的末尾显示一个"s"。之前的文本将会被渲染成类似：0 comments, 1 comment 或者 N comments。Django内置大量的模板（template）标签（tags）和过滤器（filters）来帮助你以你想要的方式来显示信息。






**HttpRequest.build_absolute_uri(location)¶**

> 返回location 的绝对URI。如果location 没有提供，则设置为request.get_full_path()。
>
> 如果URI 已经是一个绝对的URI，将不会修改。否则，使用请求中的服务器相关的变量构建绝对URI。





**'string'.format()构建自定义字符串**


**ForeignKey加上related_name**


	class Post

	class Comment(models.Model):
	    post = models.ForeignKey(Post, related_name='comments')



> 以上就是我们的Comment模型（model）。它包含了一个外键将一个单独的帖子和评论关联起来。在Comment模型（model）中定义多对一（many-to-one）的关系是因为每一条评论只能在一个帖子下生成，而每一个帖子又可能包含多个评论。related_name属性允许我们给这个属性命名，这样我们就可以利用这个关系从相关联的对象反向定位到这个对象。定义好这个之后，我们通过使用 comment.post就可以从一条评论来取到对应的帖子，以及通过使用post.comments.all()来取回一个帖子所有的评论。如果你没有定义related_name属性，Django会使用这个模型（model）的名称加上*_set*（在这里是：comment_set）来命名从相关联的对象反向定位到这个对象的manager。





--------

# Django代码模块



**在管理站点中添加你的模型（models） 让我们在管理站点中添加你的blog模型（models）。编辑blog应用下的admin.py文件，如下所示：**

	from django.contrib import admin
	from .models import Post

	admin.site.register(Post)



**定制models的展示形式 现在我们来看下如何定制管理站点。编辑blog应用下的admin.py文件，使之如下所示：**

	from django.contrib import admin
	from .models import Post

	class PostAdmin(admin.ModelAdmin):
	    list_display = ('title', 'slug', 'author', 'publish',
	                    'status')
	admin.site.register(Post, PostAdmin)



>我们使用继承了ModelAdmin的定制类来告诉Django管理站点中需要注册我们自己的模型（model）。在这个类中，我们可以包含一些关于如何在管理站点中展示模型（model）的信息以及如何与该模型（model）进行交互。list_display属性允许你在设置一些你想要在管理对象列表页面显示的模型（model）字段。
>让我们通过更多的选项来定制管理模型（model），如使用以下代码：

	class PostAdmin(admin.ModelAdmin):
	    list_display = ('title', 'slug', 'author', 'publish',
	                    'status')
	    list_filter = ('status', 'created', 'publish', 'author')
	    search_fields = ('title', 'body')
	    prepopulated_fields = {'slug': ('title',)}
	    raw_id_fields = ('author',)
	    date_hierarchy = 'publish'
	    ordering = ['status', 'publish']



**数据库中检索信息并且与这些信息进行交互**

[https://docs.djangoproject.com/en/1.8/ref/models/ ](https://docs.djangoproject.com/en/1.8/ref/models/ )

创建对象 打开终端运行以下命令来打开Python shell：

	python manage.py shell

然后依次输入以下内容：

	>>> from django.contrib.auth.models import User
	>>> from blog.models import Post
	>>> user = User.objects.get(username='admin')
	>>> post = Post.objects.create(title='One more post',
	                        slug='one-more-post',
	                        body='Post body.',
	                        author=user)
	>>> post.save()

每一个Django模型（model）至少有一个管理器（manager），默认管理器（manager）叫做objects。你通过使用你的模型（models）的管理器（manager）就能获得一个查询集（QuerySet）对象。获取一张表中的所有对象，你只需要在默认的objects管理器（manager）上使用*all()*方法即可，如下所示：

	>>> all_posts = Post.objects.all()

使用filter()方法 为了过滤查询集（QuerySet），你可以在管理器（manager）上使用filter()方法。例如，我们可以返回所有在2015年发布的帖子，如下所示：

Post.objects.filter(publish__year=2015)

使用exclude() 你可以在管理器（manager）上使用exclude()方法来排除某些返回结果。例如：我们可以返回所有2015年发布的帖子但是这些帖子的题目开头不能是Why:

	Post.objects.filter(publish__year=2015).exclude(title__startswith='Why')


删除对象 如果你想删除一个对象，你可以对对象实例进行下面的操作：

	post = Post.objects.get(id=1)
	post.delete()


修改管理器的原始查询：
管理器自带的 查询集返回系统中所有的对象。例如，使用下面这个模型：
... Book.objects.all() 语句将返回数据库中所有的 Book 对象。
你可以通过重写Manager.get_queryset() 方法来覆盖管理器自带的Queryset。get_queryset() 会根据你所需要的属性返回查询集。

例如，下面的模型有两个管理器，一个返回所有的对象，另一个则只返回作者是Roald Dahl 的对象：

	# First, define the Manager subclass.
	class DahlBookManager(models.Manager):
	    def get_queryset(self):
	        return super(DahlBookManager, self).get_queryset().filter(author='Roald Dahl')






**URL带参数映射到view中**

	urlpatterns = [
	    # post views
	    url(r'^$', views.post_list, name='post_list'),
	    url(r'^(?P<year>\d{4})/(?P<month>\d{2})/(?P<day>\d{2})/(?P<post>[-\w]+)/$',
	        views.post_detail,
	        name='post_detail'),
	]

第一条URL模式没有带入任何参数，它映射到post_list视图（view）。第二条URL模式带上了以下4个参数映射到post_detail视图（view）中。让我们看下这个URL模式中的正则表达式：

year：需要四位数
month：需要两位数。不及两位数，开头带上0，比如 01，02
day：需要两位数。不及两位数开头带上0
post：可以由单词和连字符组成


**现在你需要将你blog（应用）中的URL模式包含到项目的主URL模式中。编辑你的项目中的mysite文件夹中的urls.py文件，如下所示：**

	from django.conf.urls import include, url
	from django.contrib import admin

	urlpatterns = [
	    url(r'^admin/', include(admin.site.urls)),
	    url(r'^blog/', include('blog.urls',
	        namespace='blog',
	        app_name='blog')),
	]


通过这样的方式，你告诉Django在blog/路径下包含了blog应用中的urls.py定义的URL模式。你可以给它们一个命名空间叫做blog，这样你可以方便的引用这个URLs组。



**页码**



**html->href->view+参数=render(html)**

	#blog应用下urls.py名称为post_share的url链接
    <p>
      <a href="{% url 'blog:post_share' post.id %}">Share this post</a>
    </p>



**#判断表单的数据是否通过验证，如果通过验证就放到cleaned_data里面存起**

	def post_share(request, post_id):
	    """

	    """
	    #Retrieve the post by id
	    post = get_object_or_404(Post, id=post_id, status='published')
	    #sent = False

	    if request.method == 'POST':
	        #Form was submitted
	        form = EmailPostForm(request.POST)
	        if form.is_valid():
	            #Form fields passed validation
	            cd = form.cleaned_data



**发送邮件（build_absolute_uri/get_absolute_url/format/send_mail）**

    post_url = request.build_absolute_uri(post.get_absolute_url())
    subject = '{} ({}) recommends you reading "{}"'.format(cd['name'], cd['email'], post.title)
    message = 'Read "{}" at {}\n\n{}\'s comments: {}'.format(post.title, post_url, cd['name'], cd['comments'])
    send_mail(subject, message, 'o2414834@163.com', [cd['to']])


	#get_absolute_url
    def get_absolute_url(self):
		#blog应用中url的name为post_detail + 参数构成完整url
        return reverse('blog:post_detail', args=[self.publish.year,
            self.publish.strftime('%m'),
            self.publish.strftime('%d'),
            self.slug])



**模型同步到数据库**

	你刚创建的这个新的Comment模型（model）并没有同步到数据库中。运行以下命令生成一个新的反映了新模型（model）创建的数据迁移：

	python manage.py makemigrations blog

	你会看到如下输出：

	Migrations for 'blog':
	  0002_comment.py:
	    - Create model Comment
	Django在blog应用下的migrations/目录中生成了一个0002_comment.py文件。现在你需要创建一个关联数据库模式并且将这些改变应用到数据库中。运行以下命令来执行已经存在的数据迁移：

	python manage.py migrate
	你会获取以下输出：

	Applying blog.0002_comment... OK
	我们刚刚创建的数据迁移已经被执行，现在一张blog_comment表已经存在数据库中。



# ModelForm与Form

**利用 Model 生成 Form，提高 Model 复用性**

	定义 ModelForm

	举一个书籍管理例子

	# Model
	class Article(models.Model):
	    title = models.CharField(max_length=20, unique=True)
	    author = models.ForeignKey('Author')
	这个 Model 中定义了两个字段

	title
	储存书籍标题
	数据类型是 char
	最大长度 20
	数据库唯一值限制，即不能储存两本相同标题的书
	author
	储存书籍的作者
	数据类型是外键，指向 Model Author
	下面我们用 ModelForm 构建表单

	# ModelForm
	class ArticleForm(forms.ModelForm):
	    class Meta:
	        model = Article
	和下面手动构建表单的代码等效

	class ArticleForm(forms.Form):
	    title = forms.CharField(max_length=20)
	    author = forms.ModelChoiceField(queryset=Author.objects.all())



**创建项目和应用命令**

	Django Project Setup
	Create and activate a virtualenv:

	$ mkdir django-puppy-store
	$ cd django-puppy-store
	$ python3.6 -m venv env
	$ source env/bin/activate
	Install Django and set up a new project:

	(env)$ pip install django==1.11.0
	(env)$ django-admin startproject puppy_store
	Your current project structure should look like this:

	└── puppy_store
	    ├── manage.py
	    └── puppy_store
	        ├── __init__.py
	        ├── settings.py
	        ├── urls.py
	        └── wsgi.py



	Django App
	Start by creating the puppies app and installing xx inside your virtualenv:

	(env)$ cd puppy_store
	(env)$ python manage.py startapp puppies
	(env)$ pip install xx



	INSTALLED_APPS = (
	    ……
	    'puppies',
	)

	启动程序，自定义监听主机和端口
	python manage.py runserver 0.0.0.0:8000

	你的项目可能会出现如下提示

	You have 13 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
	Run 'python manage.py migrate' to apply them.
	此时，你可以先使用python manage.py migrate命令，

	----out---
	……
	……

	使用migrate命令
	再使用python manage.py runserver命令。


	---修改modules后要执行的命令--
	python manager.py makemigrations
	python manage.py migrate
