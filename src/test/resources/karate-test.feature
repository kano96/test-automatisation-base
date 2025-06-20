@REQ_HU_1 @karate @API @marvel @characters
Feature: Test de API Marvel Characters

  Background:
    * configure ssl = true
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/kano96/api/characters'

  @id:1 @ObtenerTodosLosPersonajes
  Scenario: T-API-HU-1-CA1 El endpoint de Obtener todos los personajes devuelve un código 200
    Given url baseUrl
    When method GET
    Then status 200
    * print response

  @id:2 @ObtenerUnPersonajePorID
  Scenario: T-API-HU-1-CA2 El endpoint de obtener personaje por ID devuelve un código 200
    Given url baseUrl + '/3'
    When method GET
    Then status 200
    * match response.alterego == 'Peter Parker'
    * print response

  @id:3 @ObtenerUnPersonajePorIDFallido
  Scenario: T-API-HU-1-CA3 El endpoint de obtener personaje por ID devuelve un código 404 cuando el ID no existe
    Given url baseUrl + '/9999'
    When method GET
    Then status 404

  @id:4 @CrearPersonaje
  Scenario: T-API-HU-1-CA4 El endpoint de crear personaje devuelve un código 201
    Given url baseUrl
      * def body = read('data/new-character.json')
    And request body
    When method POST
    Then status 201
    * match response.name == 'Flash3'
    * print response

  @id:5 @CrearPersonajeNombreDuplicado
  Scenario: T-API-HU-1-CA5 El endpoint de crear personaje devuelve un código 400 cuando el nombre es duplicado
    Given url baseUrl
    * def body = read('data/new-character.json')
    * print body
    And request body
    When method POST
    Then status 400

  @id:6 @CrearPersonajeConCamposIncorrectos
  Scenario: T-API-HU-1-CA6 El endpoint de crear personaje devuelve un código 400 cuando los campos son incorrectos
    Given url baseUrl
    * def body = read('data/new-character.json')
    * body.name = ''
    And request body
    When method POST
    Then status 400

  @id:7 @ActualizarPersonaje
  Scenario: T-API-HU-1-CA7 El endpoint de actualizar personaje devuelve un código 200
    Given url baseUrl + '/2'
    * def body = read('data/update-character.json')
    And request body
    When method PUT
    Then status 200

  @id:8 @ActualizarPersonajeNoExiste
  Scenario: T-API-HU-1-CA8 El endpoint de actualizar personaje devuelve un código 404 cuando el ID no existe
    Given url baseUrl + '/999'
    * def body = read('data/update-character.json')
    And request body
    When method PUT
    Then status 404

  @id:9 @EliminarPersonaje
  Scenario: T-API-HU-1-CA9 El endpoint de eliminar personaje devuelve un código 204
    Given url baseUrl + '/11'
    When method DELETE
    Then status 204

  @id:10 @EliminarPersonajeNoExiste
  Scenario: T-API-HU-1-CA10 El endpoint de eliminar personaje devuelve un código 404 cuando el ID no existe
    Given url baseUrl + '/999'
    When method DELETE
    Then status 404