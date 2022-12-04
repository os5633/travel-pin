import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelpin/support/cache/cache.dart';
import 'package:travelpin/support/failure.dart';

import 'base_repository.dart';
import 'model/models.dart';

class AuthenticationRepository extends BaseRepository {
  AuthenticationRepository({
    CacheClient? cache,
    GoogleSignIn? googleSignIn,
    firebase_auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @visibleForTesting
  static const memberCacheKey = '__member_cache_key__';

  Stream<MemberDefault> get member {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      log(']-----] AuthenticationRepository::authStateChanges.firebaseUser [-----[ $firebaseUser');
      final MemberDefault member =
          firebaseUser == null || firebaseUser.isAnonymous
              ? MemberDefault.empty
              : firebaseUser.toMember;
      _cache.write(key: memberCacheKey, value: member);
      return member;
    });
  }

  MemberDefault get currentMember {
    return _cache.read<MemberDefault>(key: memberCacheKey) ??
        MemberDefault.empty;
  }

  Future<void> signInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;

      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInWithGoogleFailure();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signInByAnonymously() async {
    log("]-----] AuthenticationRepository::signInByAnonymously [-----[ ");
    if (_firebaseAuth.currentUser == null) {
      await _firebaseAuth.signInAnonymously();
    }
  }
}

extension on firebase_auth.User {
  MemberDefault get toMember {
    return MemberDefault(
      id: uid,
      email: email,
      name: displayName,
      photoUrl: photoURL,
    );
  }
}
