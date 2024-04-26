from app import create_app

# Import the Config class from config.py
from config import Config  

# Create the Flask application with the provided configuration
app = create_app()

# Run the Flask application
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000 ,debug=True)
