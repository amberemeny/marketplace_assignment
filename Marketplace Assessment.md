# Marketplace Assessment
## Setup
### Application Initiation

~~rails new marketplace_assessment -dpostgresql~~
~~database.yml update~~
~~bundle add devise~~
~~rails g devise:install~~
~~follow devise instructions~~
~~rails g devise User~~
~~rails g migrate AddFieldstoUser username fname lname~~
~~edit devise views, and controller strong parameters~~
~~rails g model Address user:references unitno street suburb state postcode:integer
rails g controller Addresses new create update destroy
rails g migrate AddAddresstoUser address:references
rails g model Listing name price:decimal user:references species information
rails g controller Listings index new create show edit update destroy
rails g Model Order user:references listings:references datetime:datetime completed:boolean
rails g migration AddOrdertoListing orders:references
rails g migration orders_listings~~
bundle add rolify
bundle add cancancan
rails generate cancan:ability
rails generate rolify Role User
rails generate rolify Role Admin
- follow cancancan and rolify tutorial
- rails active_storage:install
- follow cloudinary tutorial

### Views

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
### Functionality and Features
### Sitemap
### Screenshots
### Target Audience
### Tech Stack
## Development
### User Stories
### Wireframes
### ERD
### High Level Components
### Third-Party Services
### Database
### Task Tracking


 


<!--stackedit_data:
eyJoaXN0b3J5IjpbMTAyMzMwNjU0M119
-->