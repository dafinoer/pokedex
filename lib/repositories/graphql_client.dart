library graphql_client;

import 'package:Pokemon/models/pokemon.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'network/pokemon.dart';
part 'queries/pokemon.dart';

GraphQLClient getGraphQLClient() {
  final HttpLink _link = HttpLink(
    'https://graphql-pokemon2.vercel.app/',
  );

  final DefaultPolicies _policies = DefaultPolicies(
      query: Policies(
          fetch: FetchPolicy.cacheAndNetwork,
          cacheReread: CacheRereadPolicy.mergeOptimistic));

  return GraphQLClient(
      cache: GraphQLCache(), link: _link, defaultPolicies: _policies);
}
