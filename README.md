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
