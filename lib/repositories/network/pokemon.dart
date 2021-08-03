part of graphql_client;

class PokemonRequestFailure implements Exception {
  final String errorMessage;

  PokemonRequestFailure(this.errorMessage);
}

class PokemonRepository {
  final GraphQLClient _graphQLClient = getGraphQLClient();

  Future<List<Pokemon>> getAllPokemon({int limit = 10}) async {
    try {
      final result = await _graphQLClient.query(
        QueryOptions(
            document: gql(PokemonQuery.getAllPokemon),
            variables: PokemonQuery.getAllPokemonVariables(limit: limit)),
      );
      if (result.hasException) {
        final _exception = result.exception;
        String? _graphQLException;
        String? _linkException;
        if (_exception != null) {
          if (_exception.graphqlErrors.isNotEmpty) {
            _graphQLException = _exception.graphqlErrors.toString();
          }
          if (_exception.linkException is HttpLinkServerException) {
            _linkException = _exception.linkException.toString();
          }
        }
        throw PokemonRequestFailure(
            'graphQL exception = $_graphQLException \n link exception = $_linkException');
      }
      final data = result.data?['pokemons'] as List;
      return data.map((e) => Pokemon.fromJson(e)).toList();
    } catch (e, s) {
      throw PokemonRequestFailure(e.toString());
    }
  }

  Future<Pokemon> getPokemonByIdOrName(
      {String id = '', String name = ''}) async {
    try {
      final result = await _graphQLClient.query(
        QueryOptions(
            document: gql(PokemonQuery.getPokemonByIdOrName),
            variables:
                PokemonQuery.getPokemonByIdVariables(name: name, id: id)),
      );
      if (result.hasException) {
        throw PokemonRequestFailure(result.exception.toString());
      }
      final data = result.data?['pokemon'] as Map<String, dynamic>;
      return Pokemon.fromJson(data);
    } catch (e, s) {
      throw PokemonRequestFailure(e.toString());
    }
  }
}
