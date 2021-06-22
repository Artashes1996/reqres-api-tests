Feature: Check CRUD operation for user

  Background: Define Payloads

    Given def createUserBody = 'file:src/test/java/data/create-user.json'
    Given def updateUserBody = 'file:src/test/java/data/update-user.json'

  Scenario: 1. Create User, 2. Update User, 3. Delete User

# Get User

    Given url reqres_host + '/api/users/2'
    When method get
    Then status 200

#Assert Key Types

    Then match response.data.id == 2
    Then match response.data.email == 'janet.weaver@reqres.in'
    Then match response.data.first_name == 'Janet'
    Then match response.data.last_name == 'Weaver'
    Then match response.data.avatar == 'https://reqres.in/img/faces/2-image.jpg'

    Then match response.support.url == 'https://reqres.in/#support-heading'
    Then match response.support.text == 'To keep ReqRes free, contributions towards server costs are appreciated!'

# Create User

    Given def jsonFile = read(createUserBody)
    Given url reqres_host + '/api/users'
    When method post
    Then status 201

    #Assert Key Types

    Then match response.id == '#string'
    Then match response.createdAt == '#string'

    * def store_id = response.id

#   Update User

    Given def jsonFile = read(updateUserBody)
    Given url reqres_host + '/api/users/' + store_id
    When method post
    Then status 201

    #Assert Key Types

    * print 'STORE ID ' + store_id
    * print 'ID ' + response.id
    Then match response.id == '#string'
    Then match response.createdAt == '#string'

#   Delete Created User

    Given url reqres_host + '/api/users/' + store_id
    When method delete
    Then status 204