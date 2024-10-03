part of 'contact_cubit.dart';

abstract class ContactState {}

final class ContactInitial extends ContactState {}

class ChangeIndex extends ContactState {}

class UpdateSearchQuery extends ContactState {}


class GetFavorite extends ContactState {}

class ChangeFavorite extends ContactState {}

class Databasecreate extends ContactState {}

class GetDataSuccess extends ContactState {}
class GetDataError extends ContactState {}

class AddContactError extends ContactState {}

class ChangeFavoriteError extends ContactState {}

class UpdateSearchQuerySuccess extends ContactState {}
class UpdateSearchQueryError extends ContactState {}

class DeleteContactError extends ContactState {}
