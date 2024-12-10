There are a few problems with the Chinook database what we have to deal with. 
It was not designed for a multi-user system like the one we are creating.
Ideally we would spend a lot of time working with database designers to fix these problems,
but for this project we'll do our best with the time we have.

One issue that I noticed is that the database does not allow customers to create their own play lists.
We will not address this issue, but if we wanted to create an API that allows users to create their own play lists, the
current design would need some modification.

Also, the database includes a **customer** table, and an **employee** table, 
but these tables do not include passwords that can be used for logins. We want users to log in
with a password. Further, a customer may have an ID that is the same as an employee's ID. We will need all users
to have a unique ID.

To deal with these problems, we are going to add two tables to the database. 
We'll add a **userrole** table and each user will be assigned to one of the following 'roles':
1. **Admin** users will have full permissions to modify any data in the database
1. **Employee** users will be able modify data relating to customers, albums, artists, genres, tracks, etc. but will not be able to see or manage other employees
1. **Customer** users will only be able to modify data that relates to themselves, which basically means creating invoices which
allows them to purchase tracks, and accessing the tracks that they have purchased.

**I probably should add a userID foreign key to both the Customer and Employee tables**

Run these queries to create and populate the **userrole** table:
```sql
CREATE TABLE userrole (
  UserRoleId int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  UserRoleName varchar(30) NOT NULL,
  UserRoleDescription varchar(200) NOT NULL
);

INSERT INTO userrole (UserRoleId, UserRoleName, UserRoleDescription) VALUES
(1, 'Admin', 'Elevated permissions to manage the system'),
(2, 'Employee', 'For users who are employees'),
(3, 'Customer', 'For users who are customers');
```

In order to assign passwords and unique IDs to the various types of users (Admins, Employees, and Customers),
we'll create a **user** table by running this query (don't worry about the UserSalt column, we'll discuss it later): 
```sql
CREATE TABLE user (
  UserId int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  UserPassword char(255) NOT NULL,
  UserEmail char(255) NOT NULL,
  UserSalt char(32) NOT NULL,
  UserRoleId INT NOT NULL DEFAULT '3',
  UserActive boolean NOT NULL DEFAULT true,
  FOREIGN KEY (UserRoleId) REFERENCES userrole(UserRoleId)
);
```
Note that it includes a **UserRoleId** column, which is a foreign key that points to the
**userrole** table, which indicates that every user must be assigned a role.

To populate this table, we'll start with an 'admin' user by running this query: 
```sql
INSERT INTO `user`( `UserPassword`, `UserEmail`, `UserSalt`, `UserRoleId`, `UserActive`) 
VALUES 
('test123','admin@chinookcorp.com','xxx',1,true);
```
And now we'll pull all the current employees and add them to the **user** table
with this query:
```sql
INSERT INTO `user`( `UserPassword`, `UserEmail`, `UserSalt`, `UserRoleId`, `UserActive`) 
SELECT 'test123',Email,'xxx',2,true FROM employee;
```
For now, every user will be assigned a password of 'test123'.

Note that we are setting the UserRoleId to 2, which is the 'Employee' role.

Finally, we'll pull all of rows from the customer table (and assign them a UserRoleId of 3):
```sql
INSERT INTO `user`( `UserPassword`, `UserEmail`, `UserSalt`, `UserRoleId`, `UserActive`) 
SELECT 'test123',Email,'xxx',3,true FROM customer;
```