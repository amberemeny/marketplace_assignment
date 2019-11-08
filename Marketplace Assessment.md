# Marketplace Assessment
Github repo: [https://github.com/amberemeny/marketplace_assignment](https://github.com/amberemeny/marketplace_assignment)
Heroku deployment: 
## Identifying the Problem

I have chosen to develop a marketplace called The Green Market as my assessment. This web-based application aims to solve a problem I have identified as a horticulture hobbyist and rare plant collector. 
Typically, when a consumer wants to purchase a new plant, they think to go to Bunnings or a nursery. Plants sold in these places are mass-produced and can often be in bad shape. It's also a lot less likely to find uncommon species as rare plants are sometimes harder to grow, making it a less viable option to mass-produce. 
When I decide to purchase a new plant, I prefer to go directly to other plant enthusiasts who focus much more on growing a select few plants to sell. I usually use marketplaces such as eBay, Facebook, Gumtree and personal websites to find sellers. However, this poses many problems:
Having so many plants across multiple platforms, with sellers of various experience encourages many discrepancies in price, species labeling and quality. Because all plants are not in a single marketplace, sellers are not always able to gauge market pricing for their wares. 
> For example: I was looking for a price of a very sought after, rare plant called a Monstera "Thai Constellation". According to news articles it is incredibly expensive but I wanted to see the prices that were being offered locally. On Gumtree, a seller in Victoria was offering a single rooted leaf of questionable quality for $700. To compare, a week or so later I found a local Queensland seller through Facebook private groups offering well-cared-for baby plants for $200. 

From this experience it is easy to deduce that because of the varying portals to sell plants, it's difficult to accurately price wares for what they are actually worth, and price inflation among rare plants is a growing problem.
## The Solution
By identifying the problems facing the plant hobbyist community, I was able to come up with a proposal for a centralized marketplace specializing in indoor and collectible plants. 
Implementing such a website will allow collectors across all experience levels to come to a single place to purchase and sell their plants. Having a single website for such a purpose will help sellers view other similar plants for sale to label and price their wares appropriately, hopefully combating market inflation.
## Application Information
### Purpose
The Green Market aims to be an accessible platform for consumers from various backgrounds to use to buy or sell houseplants. 
### Functionality and Features
### Sitemap
### Screenshots
### Target Audience
This application aims to target those who collect plants as a hobby or source of income.
### Tech Stack
I used the following programs to develop my application:
 - Visual Studio Code
 - Stackedit.io
 - Figma
 - 
 I personally coded using the following languages:
 - Ruby
 - HTML
 - CSS
 - Javascript
## Development
### User Stories
The user stories I have developed revolve around three key consumer roles: admin, buyer and seller. Admin refers to someone maintaining and monitoring the application usage. Seller refers to a consumer that uses the application to sell their plants and buyer refers to someone who purchases the plants listed by the seller.
#### As a *Seller* I want to be able to:
- create an account so my details can be associated with my actions.
- edit my account so I can alter my details if they change. 
- delete my account so I no longer have my details stored.
- create a listing so I can add my plant's details.
- upload a picture to my listing so the buyer can see what I am selling. 
- edit a listing so I can change the details or correct any mistakes.
- delete a listing so I can remove a plant that I no longer want to sell. 
- view my listings on one page so I can easily see all of the plants that I have for sale.
- **to be implemented** - see a buyer's postal address so I can send their purchase to the right address.
- **to be implemented** - see a buyer's email so I can contact the buyer directly to ask any questions or address any problems.
- **to be implemented** - contact the Admin directly to submit a bug report or vocalise a problem with the application.
#### As a *Buyer* I want to be able to: 
-  create an account so my details can be associated with my actions.
- edit my account so I can alter my details if they change. 
- delete my account so I no longer have my details stored.
- create a postal address so the buyer will know where to send my purchase.
- edit my postal address so I can change the details or correct any mistakes.
- view all of the plants for sale so I can easily choose what I want to buy.
- view the details of each plant listing so I can find out more information about it.
- add a plant to my order so I can purchase it.
- remove a plant from my order if I no longer wish to purchase it.
- **to be implemented** - view the sellers email address after purchase so I can ask questions or communicate problems with the payment or shipping.
- **to be implemented** - contact the Admin directly to submit a bug report or vocalise a problem with the application.
#### As an *Admin* I want to be able to: 
- view all of the plants for sale so I can easily identify and inappropriate listings.
- edit a listing so I can change the details, correct any mistakes or alter inappropriate details.
- delete a listing so I can remove a listing that is not appropriate for the application.
- view a list of all orders so I can monitor user interaction and purchases.
- **to be implemented** - contact the buyer or seller directly to communicate issues or notify them of inappropriate conduct. 

### Wireframes
### Entity Relation Diagram
![Alt](https://github.com/amberemeny/marketplace_assignment/blob/master/docs/ERD.png?raw=true)
### High Level Components
#### Models
The marketplace application utilises 4 primary models: User, Address, Listing, and Order. The User model was created using Devise, and the minor Role model as well as associated join table was generated using Rolify.
  The models were designed around the flow of the application where the consumer would create an account, creating a new User entry. They would then add a plant for sale which would create a new Listing entry with the associated user_id. Another user would also create an account, but instead of creating a listing, would instead add an existing Listing item to an Order belonging to the buyer's user_id. If an Order entry for that User had not been created before, one would be added. Just through these steps, A seller can have many listings, a buyer can have an order, and each order can have many listings which, in turn belong to its seller.
  The Address model is quite simple and each User can add a single Address to their account through the edit profile view. It acts as a seperate entry to store a User's postal address.
  The Role model created through Rolify is used to assign admin or user roles to each User. The assigned role is then used to implement authorisation throughout the application. For example, only a User with the admin role has the power to view an index of all the orders created.
#### Controllers
  The application uses 4 controllers in addition to Devise generated controllers to process logic and implement the views. I have included links to each controller file where I have heavily commented each method to explain its function.
  
- **Addresses Controller** - The Addresses controller deals with the creation and editing of a User's Address entry. 
 An entry can not be deleted by a user directly but it can be destroyed from the database or console.
[https://github.com/amberemeny/marketplace_assignment/blob/master/src/app/controllers/addresses_controller.rb](https://github.com/amberemeny/marketplace_assignment/blob/master/src/app/controllers/addresses_controller.rb)
 - **Listings Controller** - The Listings controller handles the creation, modification, deletion and indexing of a User's Listing entry. 
 [https://github.com/amberemeny/marketplace_assignment/blob/master/src/app/controllers/listings_controller.rb](https://github.com/amberemeny/marketplace_assignment/blob/master/src/app/controllers/listings_controller.rb)
 - **Orders Controller** - The Order controller deals with the creation, adding of a Listing to an Order, and checkout processing. 
   An index of all orders is only accessible by a User with the admin role and a User can only view and act on their own orders. This is made possible using Rolify authorisation.
[https://github.com/amberemeny/marketplace_assignment/blob/master/src/app/controllers/orders_controller.rb](https://github.com/amberemeny/marketplace_assignment/blob/master/src/app/controllers/orders_controller.rb)   
 - **Pages Controller** - The pages controller is a very simple file without a related model and with only one method. It's index method directs to the index view that essentially acts as a home page for the application.
 [https://github.com/amberemeny/marketplace_assignment/blob/master/src/app/controllers/pages_controller.rb](https://github.com/amberemeny/marketplace_assignment/blob/master/src/app/controllers/pages_controller.rb)
### Third-Party Services
The following third-party services were utilized in the development of this application:
 - **Heroku** - used to host the application for testing and deployment.
[https://www.heroku.com/](https://www.heroku.com/)
- **Github** - used for version control and project managment.
[https://github.com/](https://github.com/)

The following Ruby on Rails gems were also implemented in the application:
- **Devise** - used for creating the user model and authentication.
[https://github.com/plataformatec/devise](https://github.com/plataformatec/devise)
- **Rolify** - used for assigning users various roles and authorizing the actions they can carry out in the application.
[https://github.com/RolifyCommunity/rolify](https://github.com/RolifyCommunity/rolify)
- **Cloudinary** - used for hosting and manipulating user uploaded images.
[https://github.com/cloudinary/cloudinary_gem](https://github.com/cloudinary/cloudinary_gem)
[https://cloudinary.com/](https://cloudinary.com/)
- **Stripe** - used for secure checkout of user orders and to handle payment.
[https://github.com/stripe/stripe-ruby](https://github.com/stripe/stripe-ruby)
[https://stripe.com/](https://stripe.com/)
### Database
#### Database Relations
- An address belongs_to a user & a user has an address: A one-to-one relationship where an address can belong to only one user and a user may only have one postal address. 
- A listing belongs_to a user & a user has_many listings: a one to many relationship where a single user can create as many listings as they like but a listing can only be created by a single user.
- A listing has_many orders, through listings_orders & an order has many listings, through listings_orders: a many-to-many relationship where a listing can be associated with many orders when it is added to a user's order, and that user's order can contain many listings.
- Listing has_one_attached image: a one to one relationship using cloudinary to upload and relate a single image to a listing.
- An order belongs_to a user & a user has_one order: a one-to-one relationship where a user can have an order and that order can only have one user associated with it.
	- I would like to note for the above relationship that I would plan to change this to a one to many so that a user can have many orders and maybe even view a history of their completed orders.

#### Schema
```javascript
create_table "active_storage_attachments", force:  :cascade  do |t|
t.string  "name", null:  false
t.string  "record_type", null:  false
t.bigint  "record_id", null:  false
t.bigint  "blob_id", null:  false
t.datetime  "created_at", null:  false
t.index ["blob_id"], name:  "index_active_storage_attachments_on_blob_id"
t.index ["record_type", "record_id", "name", "blob_id"], name:  "index_active_storage_attachments_uniqueness", unique:  true
end

create_table "active_storage_blobs", force:  :cascade  do |t|
t.string  "key", null:  false
t.string  "filename", null:  false
t.string  "content_type"
t.text  "metadata"
t.bigint  "byte_size", null:  false
t.string  "checksum", null:  false
t.datetime  "created_at", null:  false
t.index ["key"], name:  "index_active_storage_blobs_on_key", unique:  true
end

create_table "addresses", force:  :cascade  do |t|
t.bigint  "user_id", null:  false
t.string  "houseno", null:  false
t.string  "street", null:  false
t.string  "suburb", null:  false
t.string  "state", null:  false
t.integer  "postcode", null:  false
t.datetime  "created_at", precision:  6, null:  false
t.datetime  "updated_at", precision:  6, null:  false
t.index ["user_id"], name:  "index_addresses_on_user_id"
end

create_table "listings", force:  :cascade  do |t|
t.string  "name"
t.bigint  "user_id", null:  false
t.string  "species"
t.text  "info"
t.decimal  "price"
t.datetime  "created_at", precision:  6, null:  false
t.datetime  "updated_at", precision:  6, null:  false
t.index ["user_id"], name:  "index_listings_on_user_id"
end

create_table "listings_orders", force:  :cascade  do |t|
t.bigint  "listing_id", null:  false
t.bigint  "order_id", null:  false
end 

create_table "orders", force:  :cascade  do |t|
t.bigint  "user_id", null:  false
t.datetime  "datetime"
t.boolean  "completed"
t.datetime  "created_at", precision:  6, null:  false
t.datetime  "updated_at", precision:  6, null:  false
t.index ["user_id"], name:  "index_orders_on_user_id"
end

create_table "roles", force:  :cascade  do |t|
t.string  "name"
t.string  "resource_type"
t.bigint  "resource_id"
t.datetime  "created_at", precision:  6, null:  false
t.datetime  "updated_at", precision:  6, null:  false
t.index ["name", "resource_type", "resource_id"], name:  "index_roles_on_name_and_resource_type_and_resource_id"
t.index ["resource_type", "resource_id"], name:  "index_roles_on_resource_type_and_resource_id"
end

create_table "users", force:  :cascade  do |t|
t.string  "email", default:  "", null:  false
t.string  "encrypted_password", default:  "", null:  false
t.string  "reset_password_token"
t.datetime  "reset_password_sent_at"
t.datetime  "remember_created_at"
t.datetime  "created_at", precision:  6, null:  false
t.datetime  "updated_at", precision:  6, null:  false
t.string  "username", null:  false
t.string  "fname", null:  false
t.string  "lname", null:  false
t.bigint  "address_id"
t.index ["address_id"], name:  "index_users_on_address_id"
t.index ["email"], name:  "index_users_on_email", unique:  true
t.index ["reset_password_token"], name:  "index_users_on_reset_password_token", unique:  true
end

create_table "users_roles", id:  false, force:  :cascade  do |t|
t.bigint  "user_id"
t.bigint  "role_id"
t.index ["role_id"], name:  "index_users_roles_on_role_id"
t.index ["user_id", "role_id"], name:  "index_users_roles_on_user_id_and_role_id"
t.index ["user_id"], name:  "index_users_roles_on_user_id"
end

add_foreign_key "active_storage_attachments", "active_storage_blobs", column:  "blob_id"
add_foreign_key "addresses", "users"
add_foreign_key "listings", "users"
add_foreign_key "orders", "users"
add_foreign_key "users", "addresses"
end
```
### Task Tracking
I used Github's integrated project tracking to help organize my tasks and track issues. 
[https://github.com/amberemeny/marketplace_assignment/projects/1](https://github.com/amberemeny/marketplace_assignment/projects/1)


 


<!--stackedit_data:
eyJoaXN0b3J5IjpbMTk3OTM3MTUyLC0zNjU5OTc1OTksMTI0Mz
U1ODE0NywtNTU1MTg4OTY1LDEwMjMzMDY1NDNdfQ==
-->