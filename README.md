# LocationMAP-System

## Description
The LocationMap project is a database management system designed to store and manage information related to spatial data in indoor environments. It enables the organization and retrieval of data concerning various projects, including user management, object categorization, fingerprint creation, building management, and points of interest (POIs).

## Queries

### 1. System Administrator (SA) Functions

**Q1: Add/Update/Display Location Manager (LM) and Regular User (RU) Details**  
Description: A form that allows the search and management of the data of both LMs and RUs. The System Administrator (SA) must be able to execute all functions of LMs and RUs.

---

### 2. Location Manager (LM) Functions

**Q2: Manage Object Types**  
Description: Each LM can add, delete, or update an object type in the system. Deletion and updating are permitted as long as integrity rules (defined beforehand) are not violated (e.g., a fingerprint cannot remain orphaned).

**Q3: Manage Fingerprint**  
Description: Each LM can create a fingerprint. They can then search for and add or delete objects from it. The evolution of a fingerprint is recorded in the database (date and user who made each change for auditing purposes).

**Q4: Manage Buildings/Floors**  
Description: Each LM can create a building and can search for, add, or delete floors in it. Once a floor is created in a building, it can be searched so that points of interest (POIs) and/or fingerprints can be added or deleted from it. Deletion of a floor is only permitted if it contains no POIs or fingerprints. Deleting a building is allowed if all its floors can be deleted.

**Q5: Manage Facilities**  
Description: Each LM can create a facility and assign buildings to it. A building cannot belong to two different facilities. Deleting a facility is permitted at any time without needing to delete the buildings it contains.

---

### 3. Regular User (RU) Functions

**Q6: List Fingerprints**  
Description: A report of the fingerprints (location and number of objects) recorded by a user, sorted by the number of objects.

**Q7: Find Most Popular Object Types**  
Description: This function allows an RU to find the most popular type(s) of objects. In the case of a tie, all types in the first position are displayed. The most popular type is defined as the one found in the most fingerprints.

**Q8: Number of POI Types per Floor**  
Description: The system should display the number of POIs per type for each distinct floor.

**Q9: Average Number of Objects per Type**  
Description: This function can find the average number of objects across all fingerprints per object type.

**Q10: Find Large Floors**  
Description: The system should be able to display the floors that have a number of POIs above the average number of POIs across all floors.

**Q11: Find Smaller Floors**  
Description: A report of the floors with the minimum number of POIs.

**Q12: Find Fingerprints with Common Object Types**  
Description: This search should return fingerprints that have exactly the same types of objects.

**Q13: Find Common Object Types**  
Description: The aim here is to find which other fingerprints have (at least) the object types of a selected fingerprint. This query is the basis of geolocation functionality (finding x,y,z given a set of objects).

**Q14: Find the k Object Types with the Fewest Participations**  
Description: This search should return the k types of objects with the fewest appearances in fingerprints. The k is a parameter provided by the user.

**Q15: Object Types Present in Every Fingerprint**  
Description: With this function, the user can find types of objects that are contained in all fingerprints.

**Q16: Find Count of Objects within a Bounding Box**  
Description: The user with this function can find the count of a specific type of object (given as a parameter) within a bounding box (given as parameters). A bounding box is defined as the rectangular space between two diagonal points (given as coordinates X1, Y1 and X2, Y2), including all floors that may exist within it.

**Q17: Find Bounding Box of a Building**  
Description: The user with this function can find the bounding box (coordinates X1, Y1 and X2, Y2) that includes all POIs of a given building (provided as a parameter).

**Q18: Find Nearest (Nearest Neighbor - NN) POI**  
Description: With this function, the user can find the nearest POI relative to specific coordinates X, Y, and a floor provided as parameters. For simplicity, consider each floor to be 3 meters on the Z-axis, with floor 0 always at coordinate Z=0.

**Q19: Find k Nearest (k Nearest Neighbor - kNN) POI**  
Description: Similar to the previous function, but the k is also given as a parameter, and the response is a list of the k nearest POIs. Be cautious of tie cases (e.g., what happens if 2 or more POIs are exactly the same distance from the input coordinates).

**Q20: Find All k Nearest (All k Nearest Neighbor - AkNN) POI of a Floor**  
Description: Similar to the previous function, but the parameter is a floor of a building, and the response is a list of the nearest POI for each POI of the floor (the list contains pairs of POIs P,N where P is some POI of the floor and N is the nearest POI to P).

**Q21: Total Count of Objects in Fingerprint Path**  
Description: A report that finds all paths starting from a specific fingerprint F (where F is the fingerprint ID provided by the user) and gives the count of all unique objects along the path (it is possible that two neighboring fingerprints may contain the same object). The path is defined as the ordered set of fingerprints where two consecutive fingerprints are less than X meters apart (where X is a parameter provided by the user). A path cannot have cycles (the same fingerprint cannot appear more than once in the path).

---

### User Roles

- **System Administrator (SA)**: Responsible for managing the overall system and its users.
- **Location Manager (LM)**: Manages the locations, buildings, and associated data.
- **Regular User (RU)**: Interacts with the system to retrieve information and manage basic tasks.

---
