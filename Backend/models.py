from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()


class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer(), primary_key=True)
    username = db.Column(db.String(), unique=True)
    api_key = db.Column(db.String())
    firstname = db.Column(db.String())
    lastname = db.Column(db.String())
    password = db.Column(db.String())
    emailaddress = db.Column(db.String())

    def __init__(self, api_key, firstname, lastname, emailaddress, password, username):
        self.api_key = api_key
        self.username = username
        self.firstname = firstname
        self.lastname = lastname
        self.password = password
        self.emailaddress = emailaddress

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return {
            'api_key': self.api_key,
            'id': self.id,
            'username': self.username,
            'firstname': self.firstname,
            'lastname': self.lastname,
            'password': self.password,
            'emailaddress': self.emailaddress,
        }


class Task(db.Model):
    __tablename__ = 'tasks'

    id = db.Column(db.Integer(), primary_key=True)
    user_id = db.Column(db.Integer(), db.ForeignKey('users.id'))
    note = db.Column(db.String())
    completed = db.Column(db.Boolean(), default=True, nullable=False)
    repeats = db.Column(db.String())
    deadline = db.Column(db.String())
    reminders = db.Column(db.String())

    def __init__(self, user_id, note, completed, repeats, deadline, reminders):
        self.user_id = user_id
        self.reminders = reminders
        self.note = note
        self.completed = completed
        self.deadline = deadline
        self.repeats = repeats

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return {
            'user_id': self.user_id,
            'id': self.id,
            'repeats': self.repeats,
            'deadline': self.deadline,
            'note': self.note,
            'completed': self.completed,
            'reminders': self.reminders,
        }
