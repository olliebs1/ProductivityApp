from flask_restful import Resource


class Register(Resource):
    def get(self):
        return {"message": "getting user"}

    def post(self):
        return {"message": "Registering user"}
