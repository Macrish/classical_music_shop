# CLASSICAL MUSIC SHOP

In this application, I will to:

* CHANGE SQLite to MySQL

* create DB throw the .sql file

* create records in DB

* Nested resources

* if server doesn't run

* customers with fields in table called title, first_name, middle_initial, and last_name.
  How to display all field in a view template?
 
* Загрузка файла из корневого каталога  

* modify editions in DB & add new publishers table

* many-to-many relations

* add records to DB in many-to-many relations

* add to publisher - editions (publisher has_many :editions)

* Soft vs. hard model enhancement
# change SQLite to MySQL

https://blog.bigbinary.com/2019/04/30/rails-6-has-added-a-way-to-change-the-database-of-the-app.html

**** мы уже создали приложение, теперь заменим БД

+ rails db:system:change --to=mysql

+ rails db  #Access denied for user 'root'@'localhost'

+ sudo mysql #ok

+ mysql> create database classical_music_shop_development;

Query OK, 1 row affected (0,00 sec)

+ mysql> grant all privileges on classical_music_shop_development.* to 'r4r'@'localhost' identified by 'USER_PASS';

Query OK, 0 rows affected, 1 warning (0,04 sec)

**** Если последняя команда не сработала нужно ввести следующую команду

+ mysql> SET GLOBAL validate_password_policy=LOW;

+ mysql> grant all privileges on classical_music_shop_development.* to 'r4r'@'localhost' identified by 'USER_PASS';

**** Если Нужно создать БД для тестой БД и для продакшина

**** Нужно заменить в config/database.yml# MySQL. Versions 5.5.8 and up are supported.

**** config/database.yml содежит следующий код
  
```
default: &default

  adapter: mysql2
  
  ncoding: utf8mb4
  
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  
  username: r4r
  
  password: USER_PASS
  
  socket: /var/run/mysqld/mysqld.sock
  

development:

  <<: *default
  
  database: classical_music_shop_development
  

test:
  <<: *default
  
  database: classical_music_shop_test

production:

  <<: *default
  
  database: classical_music_shop_production
  
  username: classical_music_shop
  
  password: <%= ENV['CLASSICAL_MUSIC_SHOP_DATABASE_PASSWORD'] %>
```

&nbsp;&nbsp;  username: r4r

&nbsp;&nbsp;  password: USER_PASS

**** при создании в консоли mysql БД для разных сред нужно проверить чтобы названия созданной БД в консоли совпадала с 

**** database каждого enviroment

+ mysql> FLUSH PRIVILEGES;
+ mysql> exit;

# create DB throw the .sql file
+ create .sql file in root project

enter next commands:

+ mysql -u r4r -p < classical_music_shop.sql

+ rails db:migrate

# create records in DB
```
c1 = Composer.create(first_name: 'Johannes', last_name: 'Brahms')
c1.works.create(title: 'Sonata for Cello and Piano in F Major')
w1 = Work.find(1)
w1.editions.create(description: 'Urtext', publisher: 'RubyTunes, Inc.', year: 1977, price: 23.50)
```
# Nested resources

Вложенные ресурсы нужны в моем приложении для того, чтобы достать связанные все editions
с work

Ресурсы никогда не должны быть вложены глубже, чем на 1 уровень

# if server doesn't run

Нужно проверить log/development.log, исправить все ошибки и снова запустить сервер

Если проблема влияет на БД, нужно остановить сервер и перезапустить его, если
уверены, что это не усугубит ситуацию.

# customers with fields in table called title, first_name, middle_initial, and last_name. How to display all field in a view template?

view
```
<p>Hello, <%= @customer.title + " " + @customer.first_name + " " +
@customer.middle_initial + ". " +
@customer.last_name" %></p>
```
но такой вид записи не удобен, если нужно сделать изменения в каждой вьюхе

or 

```
class Customer < ActiveRecord::Base
   def nice_name
       title + " " + first_name + " " +
       (if middle_initial then middle_initial + ". " else "" end) +
       last_name
   end
 end
```

тогда отображение во вьюхе будет выглядеть следующим образом
```
<p>Good morning, <%= @customer.nice_name %>.</p>
```

# Загрузка файла из корневого каталога 

```
require 'config/environment.rb'
files = Dir["../file*"].sort
files.each do |file|
    m = YAML.load(File.read(file)
```
Conversion script to load legacy YAML data into a Rails application database
```
 require 'config/environment.rb'

 #1 инициализация пустого хэша
 mnums = {}
 files = Dir["../file*"].sort
 
 #2 имена файлов хотят отсортировать в алфавитном порядке в массив файлов
 files.each do |file|

     #3 Для каждого файла скрипт создает Руби объект на снове чтения файла YAML. 
     # YAML сериализует данные Ruby в строковую форму
     m = YAML.load(File.read(file))
     num = m['number']
     prev = m['previous']
     
     #4 скрип ищет пользователя и если не находит создает нового
     user = User.find_by_name(m['username'])
     unless user
        user = User.new
        user.name = m['username']
        user.save
 end

 #5 создается сообщение, где id будет хранится в mnums
 # это необходимо для сопоставление старой последовательности нумерации сообщений с новой
 message = Message.new
 message.save
 mnums[num] = message.id

 #6 поля нового объекта сообщения инициализируются в соответствующие
 # значения из файла: пользователь, номер, тело, заголовок и дата
 message.user = user
 message.number = num
 message.body = m['body']
 message.title = m['title']
 message.date = m['date']

#7 если предыдущее смс существует, находим его и добавляем в поле previous для нового сообщения
 if prev
   message.previous = Message.find(mnums[prev])
 end

#8 сохранение сообщение в БД
 message.save
end
```
# Chapter 14
Модели сущностей Rails - это классы Ruby
Рассмотрим экземпляр модели ActiveRecord 
##Обзор возможностей экземпляра модели
Экземпляр класса модели - Composer, Work...
имеют определенные возможности - выполнение методов,
которые можно вызвать.

Возможности экземпляров моделей Rails получаем:
* наследование, вызов методов экземпляра суперкласса
(ActiveRecord :: Base или другого класса)
* Automatic creation of accessor and other methods
(от accessor и других методов на основе полей в соответствующей
таблице БД(объекты Composer имеют title и title = method))

Каждый экземпляр модели Composer отвечает на сообщение title, 
Эз-ры так же отвечают на title= (у них есть сеттер)
* Semi-automatic creation of accessor and other methods
(has_one :composer , in the case of the Work class)

"Есть ассоциация" один ко многим " это значит:
rails c 
```
has_many :works
belongs_to :composer
```
также в таблице works имеется поле - composer_id
* программное добавление методов экземпляра, добавленных в модель

###Inherited and automatic ActiveRecord model behaviors
Объект модели ActiveRecord, такой как экземпляр класса Composer, уже
при создании имеет много функциональных возможностей.

rails c 
```
$ ruby script/console
Loading development environment.
>> ActiveRecord::Base.instance_methods.size
=> 180
```
ЖЦ объекта ActiveRecord: save , update , and destroy.

ЖЦ метода класса: new , create , find , and delete.

Создать новый объект Ruby
```
b = Bicycle.new
```
Объекты ActiveRecord допускают такую ​​же обработку.
```
c = Composer.new
```
Разница между объектом ActiveRecord и типичным объектом Ruby - объект
ActiveRecord явдяется объектом Руби, с другой стороны
с помощью этого объекта можно делать записи в БД.

Некоторые функции ActiveRecord на уровне классов выполняют действия с данными:
например Composer.delete(идентификатор) - удаляет запись с БД
(даже не нужно создавать соответствующий экземпляр)

# modify editions in DB & add new publishers table

Было
```
create_table "editions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "work_id", null: false
    t.string "description", limit: 30
    t.string "publisher", limit: 60
    t.integer "year"
    t.float "price"
  end
  ```
Нужно убрать publisher, добавить publisher_id, оставить title
Добавляю миграцию:
```
class AddPublisherRefToEditions < ActiveRecord::Migration[6.0]
    def change
        add_reference :editions, :publisher, foreign_key: true
        add_column :editions, :title, :string, limit: 100
    end
end
```
При rollback t.string "publisher" в editions не вернется

# many-to-many relations
любое произведение(work) может быть для любого количества инструментов, и для любого инструмента может быть написано любое количество произведений. 

This mechanism—the entity_id field, coupled with the appropriate associations—
 drives the one-to-many relationships.

Если инструменты и произведения стоят в ряду многие-ко-многим
относительно друг друга, то в записи инструмента не может быть одного поля work_id.
Это означало бы, что для каждого инструмента есть одна и только одна работа, которую
которому он принадлежит.

 Также в таблице работ не может быть поля instrument_id.
 
rails g migration CreateInstrumentsWorks
```
 class CreateInstrumentsWorks < ActiveRecord::Migration[6.0]
   def change
     create_table :instruments_works do |t|
       t.belongs_to :instrument
       t.belongs_to :work
     end
   end
 end
```
В модели Инструмент добавляем и для модели Работа аналогично
```
has_and_belongs_to_many :works
```
#add records to DB in many-to-many relations
создаём композитора и добавляем ему произведение
cоздаём инструмент и добавляем ему произведение
```
c1 = Composer.create(first_name: 'Johannes', last_name: 'Brahms')
c1.works.create(title: 'Sonata for Cello and Piano in F Major')
cw = c1.works.last

i = Instrument.create(name: 'violin', family: 'viole')
v = Instrument.first

v.works << cw
v.works << cw
# отобразить все произведения, которые использует этот инструмент
v.works

# отобразить все инструменты, которые использует произведение
cw.instruments 
```

#add to publisher - editions (publisher has_many :editions)
```
p = Publisher.create(name: "Tanya", city: "***", country: "Urk")
#choose work_ed = work(1).editions(1)
p.editions << work_ed
```
# Soft vs. hard model enhancement
Метод в классе ActiveRecord выполняет одно из 2х:
* ищет один или несколько объктов ActiveRecord на основе существующих
                                  данных
* преобразует данные в ранее не существующую форму

Пассивные методы - извлекаю инфу
Активные - преобразую её
```
class Composer < ActiveRecord::Base
    has_many :works

    def editions
        works.map {|work| work.editions }.flatten.uniq
    end

    def whole_name
        first_name + " " +
        (if middle_name then middle_name + " " else "" end) +
        last_name
    end
end 
```
works.map {|work| work.editions }.flatten.uniq - soft method,
эти издания уже существуют и извлекаем их последовательно
просматривая произведения(work) композитора.

С этого момента все экземпляры композитора будут откликаться на 
editions возвращая массив содержащий все editions
editions - пример Soft programmatic enhancement

whole_name - создает новый объект(строку), содержащую
существующие данные, но напрямую они не соответсвуют какому-либо отдельному свойству объкта
whole_name - пример hard programmatic enhancement(улучщения).

--

Soft programmatic enhancement - расширяет доступ Композитора к другой
существующей информации.
hard programmatic enhancement предполагает создание новых данных

 Если в проекте много Soft p. eh. нужно улушить класс, ведь все эти методы могут быть
 не нужны, а вместо этого добавить ассоциации
 
 В 15 главе, напишем Soft methods:
       The Work model
       
+ Which publishers have published editions of this work?
       
```
def publishers
  editions.map { |e| e.publisher.name }.uniq
end
```
       
+  What country is this work from?
```
def country
    composer.country
end
```
+ Which publishers have published editions of this work?
```
def publishers
    editions.map {|e| e.publisher}.uniq
end
```
+ What key is this work in?
```
def key
    kee
end
```

  #####The Customer model
+ Which customers have ordered this work?
```
def ordered_by
    editions.orders.map {|o| o.customer }.uniq
end
```
+ What open orders does this customer have?
```
def open_orders
    #устарело #orders.find(:all, :conditions => "status = 'open'")
    orders.where(status: 'open')
end
```
+ What editions does this customer have on order?
```
def editions_on_order
    open_orders.map {|order| order.edition }.uniq
end
```
+ What editions has this customer ever ordered?
```
def editions_on_order
    open_orders.map {|order| order.edition }.uniq
end
```
+ What works does this customer have on order?
```
def works_on_order
    editions_on_order.map {|edition| edition.works }.flatten.uniq
end
```
+ What works has this customer ever ordered?
```
def work_history
    edition_history.map {|edition| edition.works }.flatten.uniq
end
```
  #####The Composer model
+ What editions of this composer’s works exist?
```
def editions
    works.map {|work| work.editions }.flatten.uniq
end
```
+ What publishers have editions of this composer’s works?
```
def publishers
    editions.map{|edition| edition.publisher }.uniq
end
```
  
  Самые быстрые запросы в БД - SQL, потому что когда мы пишем запрос на Ruby
  сначала этот запрос переводится в SQL и только потом получет доступ к БД.

#### Улучшения функциональности модели
* предварительная установка свойст строки
До
```
def nice_instruments
   instrs = instruments.map {|inst| inst.name }
end
```
После
```
ordered = %w{ flute oboe violin viola cello piano orchestra }
instrs = instrs.sort_by {|i| ordered.index(i) || 0
```
также инструменты можно поместить в константу, но Конст будет
обновляться вручную

Далее можно задать условие что произведение допустим написано для нескольких инструментов
```
case instrs.size
when 0
    nil
when 1
    instrs[0]
when 2
    instrs.join(" and ")
else
    instrs[0..-2].join(", ") + ", and " + instrs[-1]
end
```
* расчет периода работы

* предоставление клиенту большей функциональности

