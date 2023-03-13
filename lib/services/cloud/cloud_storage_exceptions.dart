// This file contains all the exceptions that can be thrown by the cloud storage service

class CloudStorageException implements Exception {
  const CloudStorageException();
}

// User collection
class CouldNotCreateUserException extends CloudStorageException {}

class CouldNotGetAllUsersException extends CloudStorageException {}

class CouldNotUpdateUserException extends CloudStorageException {}

class CouldNotDeleteUserException extends CloudStorageException {}
