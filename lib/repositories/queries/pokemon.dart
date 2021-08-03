part of graphql_client;

class PokemonQuery {
  static const getPokemonByIdOrName = r'''
  query pokemon($id: String, $name: String){
    pokemon(id: $id, name: $name) {
      id
      number
      name
      weight {
        minimum
        maximum
      }
      height {
        minimum
        maximum
      }
      classification
      types
      resistant
      attacks {
        fast {
          name
          type
          damage
        }
        special {
          name
          type
          damage
        }
      }
      weaknesses
      fleeRate
      maxCP
      evolutions {
        id
        image
        name
      }
      evolutionRequirements {
        name
        amount
      }
      maxHP
      image
    }
  }
''';

  static Map<String, dynamic> getPokemonByIdVariables({String id = '', String name = ''}) {
    return {'id': id, 'name': name};
  }

  static const getAllPokemon = r'''
  query pokemons($first: Int!){
    pokemons(first: $first){
      id
      number
      name
      weight {
        minimum
        maximum
      }
      height {
        minimum
        maximum
      }
      classification
      types
      resistant
      attacks {
        fast {
          name
          type
          damage
        }
        special {
          name
          type
          damage
        }
      }
      weaknesses
      fleeRate
      maxCP
      evolutions {
        id
        image
        name
      }
      evolutionRequirements {
        name
        amount
      }
      maxHP
      image
    }
  }
''';

  static Map<String, dynamic> getAllPokemonVariables({int limit = 10}) {
    return {'first': limit};
  }
}
