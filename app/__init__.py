from flask import Flask


app = Flask(__name__)

from app import views
# from flask.ext.login import LoginManager
#
# login_manager = LoginManager()
# login_manager.init_app(app)
# login_manager.login_view = '/login'

# @login_manager.user_loader
# def load_user(user_id):
#     return User.get(user_id)