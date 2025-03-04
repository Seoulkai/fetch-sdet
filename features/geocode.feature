Feature: Geocoding API interface


   Scenario Outline: City and State with country
      When the <city>, <state> and <country> are given
      Then the response contains latitude and longitude

   Examples:
      | city     | state | country |
      | Portland | OR    | US      |
      | Seattle  | WA    | US      |
        

   Scenario Outline: City and state without country
      When the <city> and <state> are given without a country
      Then the response does not contain latitude and longitude

   Examples:
      | city     | state |
      | Portland | OR    |
      | Seattle  | WA    |


   Scenario Outline: Invalid city and state
      When the <city>, <state> and <country> are given
      Then the response does not contain latitude and longitude

   Examples:
      | city      | state | country |
      | Nowhere   | AB    | US      |
      | Somewhere | CD    | US      |


   Scenario Outline: Zip code
      When the <zip code> is given
      Then the response contains latitude and longitude

   Examples:
      | zip code |
      | 12345    |
      | 98601    |


   Scenario: Invalid zip code
      When an invalid zip code is given
      Then the response returns a 404 error


   Scenario: Missing API key, direct
      When a direct request is made without an API key
      Then the response returns a 401 error


   Scenario: Missing API key, postal
      When a postal code request is made without an API key
      Then the response returns a 401 error