from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()


class User(db.Model):

    __tablename__ = 'users'
    __table_args__ = tuple(db.UniqueConstraint(
        'id', 'username', name='my_2uniq'))

    id = db.Column(db.String(), primary_key=True, unique=True)
    username = db.Column(db.String(), primary_key=True)
    firstname = db.Column(db.String())
    lastname = db.Column(db.String())
    password = db.Column(db.String())
    emailaddress = db.Column(db.String())

  def __init__(self, id, api_key, firstname, lastname, email, password, username):
        self.id = id
        self.api_key = api_key
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
        self.username = username


  def __repr__(self):
    return '<id {}>'.format(self.id)

  def serialize(self):
    return {
      'id': self.id,
       'username': self.username,
      'firstname': self.firstname,
      'lastname': self.lastname,
      'password': self.password,
      'email': self.email,
      'api_key': self.api_key
    }


    def get(self):
        return {"message": "Hello, World!"}
