# Fleetio Take Home Application

## Basic Implementations

### 1. Created Pagination on Main View:
#### -Vehicles Data pulled with all required info displayed 
#### -When use scrolls all the way down the table and pulls, a Spinner will appear at the bottom and new paginated data will load

### 2. Display functional map based on current vehicle location, with a pin. This is displayed on the details page when user selects a row

### 3. Filtered Vehicles to show up in ascending order by name


## Additional Implementations:

### 1. Refresh to Reload/Update from API:
#### - If user pulls table in downward motion, a refresh circle appears above the table. This will fetch data to refresh/pull new data if there are any changes

### 2. Image Caching:
#### - All Vehicles Images are loaded quickly and are cached, images can be reloaded by refreshing if there is new image data

### 3. Search for vehicles by name:
#### - All vehicles can be searched for by name in a search bar

### 4. Empty states:
#### - When table is empty, there are empty states. Either loading, no search results, or no data
#### - all data that returns null from server is handled by empty states (images, maps, etc.)

## ** IMPORTANT: Details view is scrollable, more info as user scrolls **
