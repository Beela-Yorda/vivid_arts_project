import uuid
import boto3
from flask import Flask, render_template, request, redirect
from werkzeug.utils import secure_filename

app = Flask(__name__)

# Configure AWS credentials
s3 = boto3.client(
    's3'
)

# S3 bucket name
BUCKET_NAME = 'my-vivid-bucket'

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload():
    if request.method == 'POST':
        img = request.files['photo']
        
        if img:
            # Generate a unique filename
            filename = secure_filename(img.filename)
            unique_filename = str(uuid.uuid4()) + '_' + filename
    
            # Upload file directly to S3 without saving locally
            s3.upload_fileobj(
                Fileobj=img,
                Bucket=BUCKET_NAME,
                Key=unique_filename
            )
    return redirect("/contact")

@app.route('/contact')
def contact():
    return render_template('contact.html')

if __name__ == '__main__':
    app.run(debug=True, port=8000)
