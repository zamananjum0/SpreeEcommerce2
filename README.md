# Spree Ecommerce
### 1. Cài đặt Spree
[Link: https://github.com/spree/spree](https://github.com/spree/spree)
- Ruby version 2.3.1 trở lên ( Hiện tại đang dùng 2.4.0)
- Rails version 5.0 trở xuống (Hiện tại đang dùng 5.0.3): `rails _5.0.3_ new shop --database=postgresql`
- Yêu cầu cài gem `brew install imagemagick`
```ruby
gem 'spree', '~> 3.2.0'
gem 'spree_auth_devise', '~> 3.2.0.beta'
gem 'spree_gateway', '~> 3.2.0.beta'
gem 'nokogiri', '~> 1.7', '>= 1.7.2' # Nếu báo lỗi yêu cầu cài thì thêm vào

## Bundle cài gem
bundle install

## Chạy các lệnh sau
rails g spree:install --user_class=Spree::User
rails g spree:auth:install
rails g spree_gateway:install

bundle exec rake railties:install:migrations # Tạo các file migrations
bundle exec rake db:migrate # Tạo TABLE
bundle exec rake db:seed # Tạo dữ liệu mẫu
bundle exec rake spree_sample:load # Load sản phẩm mẫu
```
- **Kiểm tra version đầy đủ như yêu cầu trên trước khi cài, để tránh gặp lỗi**
### 2. Cấu trúc bố trí thư mục
#### 2.1. LAYOUT
[Document view: http://guides.spreecommerce.org/developer/view.html](http://guides.spreecommerce.org/developer/view.html)
> Tất cả file html nằm trong thư mục: `app/views/spree/`

- Tạo file application trong thư mục layouts:
`app/views/spree/layouts/spree_application.html.erb`
- Tạo thư mục shared để ghép các template partial:
*Chú ý: các file nằm trong thư mục shared thì có prefix `_tên_file.html.erb`*
`app/views/spree/layouts/_header.html.erb`
`app/views/spree/layouts/_footer.html.erb`
- Các trang con thì sẽ tạo thư mục riêng và trong mỗi thư mục đó sẽ có file html.erb
```ruby
=begin
app
|-- assets
    |-- images
    |   |-- spree
    |       |-- frontend
    |       |-- backend
    |-- javascripts
    |   |-- spree
    |       |-- frontend
    |       |   |-- all.js
    |       |-- backend
    |           |-- all.js
    |-- stylesheets
    |   |-- spree
    |       |-- frontend
    |       |   |-- all.css
    |       |-- backend
    |           |-- all.css
=begin
```

#### 2.2. ASSETS
[Document Assets: http://guides.spreecommerce.org/developer/asset.html](http://guides.spreecommerce.org/developer/asset.html)
- **CSS**: 
	- Frontend: `app/assets/stylesheets/spree/frontend/all.css (hoặc all.scss)`
	- Backend: `app/assets/stylesheets/spree/backend/all.css (hoặc all.scss)`
- **JS**: 
	- Frontend: `app/assets/stylesheets/spree/frontend/all.js (hoặc all.coffee)`
	- Backend:  `app/assets/stylesheets/spree/backend/all.js (hoặc all.coffee)`
- **Images**:  
	- Frontend: `app/assets/images/`
	- Admin: `app/assets/images/admin/`

#### 2.3. CONTROLLER
[Document Controller](http://guides.spreecommerce.org/developer/logic.html)

**Chú ý:** Tên controller phải có dạng `name_controller_decorator.rb`
```ruby
# Tên file: home_controller_decorator.rb
Spree::HomeController.class_eval do
  def index
  
  end
en
### HOẶC
module Spree
  HomeController.class_eval do
    def index
    
    end
  end
end
```

#### 2.4. MIGRATE
`bundle exec rails g migration add_xxx_to_xxx price:decimal`

**ROUTES**: 
```ruby
# config/routes.rb 
Spree::Core::Engine.routes.draw do
  get "/sale" => "home#sale"
end
```

#### 2.5. MODEL
[Document Model](http://guides.spreecommerce.org/developer/logic.html)
Tạo file model theo đường dẫn: `app/models/spree/product_decorator.rb`
**Phải có tiền tố _decorator**
```ruby
module Spree
  Product.class_eval do
    def get_list
        
    end
  end
end
```

#### 2.6. UNIT TEST
`spec/models/spree/variant_decorator_spec.rb`
**Phải có tiền tố _decorator_spec**
```ruby
require 'spec_helper'

describe Spree::Variant do
  describe "#price_in" do
    it "returns the sale price if it is present" do
	end

    it "returns the normal price if it is not on sale" do
    end
  end
end
```
### 3. Thao tác với Config file
`config/initializers/spree.rb`
```ruby
Spree.config do |config|
	config.setting_name = 'value'
end
# Gọi config
Spree::Config[:setting_name]
```
Ví dụ 1 số config mặc định:
``` ruby
# Set logo frontend: assets/images/frontend/
  config.logo = 'logo.png'
# Set logo admin: assets/images/admin
  config.admin_interface_logo = 'logo.png'
```
### 4. Thao tác với Deface Overrides
Thư mục này có tác dụng overrides view thông qua **ID** - **Class** của element hoặc là **data-hook**
[Link document: https://github.com/spree/deface](https://github.com/spree/deface)
