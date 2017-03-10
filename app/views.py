from app import app


@app.route('/index', methods=['GET', 'POST'])
def get_index():
    return 'Hello World'

