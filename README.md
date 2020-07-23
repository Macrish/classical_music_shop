# CLASSICAL MUSIC SHOP

In this application, I will to:

* CHANGE SQLite to MySQL

* create DB throw the .sql file

* create records in DB

* Nested resources

* if server doesn't run

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
  
  ===========

default: &default

  &nbsp;&nbsp; adapter: mysql2
  
  &nbsp;&nbsp; encoding: utf8mb4
  
  &nbsp;&nbsp; pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  
  &nbsp;&nbsp; username: r4r
  
  &nbsp;&nbsp; password: USER_PASS
  
  &nbsp;&nbsp; socket: /var/run/mysqld/mysqld.sock
  
  

development:

  &nbsp;&nbsp; <<: *default
  
  &nbsp;&nbsp; database: classical_music_shop_development
  

test:
  &nbsp;&nbsp; <<: *default
  
  &nbsp;&nbsp; database: classical_music_shop_test

production:

  &nbsp;&nbsp; <<: *default
  
  &nbsp;&nbsp; database: classical_music_shop_production
  
  &nbsp;&nbsp; username: classical_music_shop
  
  &nbsp;&nbsp; password: <%= ENV['CLASSICAL_MUSIC_SHOP_DATABASE_PASSWORD'] %>
 
  ===========

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

* c1 = Composer.create(first_name: 'Johannes', last_name: 'Brahms')

* c1.works.create(title: 'Sonata for Cello and Piano in F Major')

* w1 = Work.find(1)

* w1.editions.create(description: 'Urtext', publisher: 'RubyTunes, Inc.', year: 1977, price: 23.50)

# Nested resources

Вложенные ресурсы нужны в моем приложении для того, чтобы достать связанные все editions
с work

Ресурсы никогда не должны быть вложены глубже, чем на 1 уровень

# if server doesn't run

Нужно проверить log/development.log, исправить все ошибки и снова запустить сервер

Если проблема влияет на БД, нужно остановить сервер и перезапустить его, если
уверены, что это не усугубит ситуацию.
