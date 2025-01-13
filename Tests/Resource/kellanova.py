import os
import shutil
from PIL import Image
from fpdf import FPDF
import re
import datetime
import os
import re


def copy_images(source_dir, target_dir):

    # Ensure the target directory exists

    if not os.path.exists(target_dir):

        os.makedirs(target_dir)

    # Supported image formats by PIL (Pillow)

    image_formats = ('.jpeg', '.jpg', '.png', '.gif', '.bmp', '.tiff', '.webp')

    # Iterate over files in the source directory

    for file_name in os.listdir(source_dir):

        file_path = os.path.join(source_dir, file_name)

        # Check if it's a file and if it has a valid image format

        if os.path.isfile(file_path):

            try:

                with Image.open(file_path) as img:  # This will fail if the file is not a valid image

                    if file_name.lower().endswith(image_formats):

                        target_path = os.path.join(target_dir, file_name)

                        shutil.copy(file_path, target_path)

                        print(f"Copied: {file_name}")

            except Exception as e:

                print(f"Skipped: {file_name} - Not a valid image file or format not supported. Error: {e}")



def delete_specific_files_in_folder(folder_path):
    try:
        if os.path.exists(folder_path):
            for filename in os.listdir(folder_path):
                file_path = os.path.join(folder_path, filename)
                if os.path.isfile(file_path) and (filename.endswith('.png') or filename.endswith('.jpg')):
                    os.remove(file_path)  # Delete the file
                    print(f"Deleted {file_path}")
                else:
                    print(f"{file_path} is not a .png or .jpg file.")
        else:
            print(f"The folder '{folder_path}' does not exist.")
    except Exception as e:
        print(f"An error occurred: {e}")

def extract_and_txt(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    formatted_lines = []

    for line in lines:
        match = re.match(r'^(PASS|WARN):\s*"(.+)"', line.strip())
        if match:
            status = match.group(1)  # Either PASS or WARN
            message = match.group(2)  # The message inside the quotes
            formatted_lines.append(f'{status}: "{message}"')
    return "\n".join(formatted_lines)


def generate_report_html(input_file, output_file, report_name):
    if not os.path.exists(input_file):
        print(f"Error: The input file '{input_file}' does not exist.")
        return

    pass_count = 0
    warn_count = 0
    current_time = datetime.datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S UTC')

    try:
        with open(input_file, 'r') as file:
            lines = file.readlines()
            for line in lines:
                line = line.strip()
                # Only count non-empty lines
                if line:
                    if 'PASS' in line:
                        pass_count += 1
                    elif 'WARN' in line:
                        warn_count += 1

        html_content = f"""
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Club Crackers Report</title>
            <style>
                body {{ font-family: Arial, sans-serif; }}
                h1, h2 {{ text-align: center; }}
                .pass {{ color: green; }}
                .warn {{ color: red; }}
                .pass-circle {{ 
                    width: 30px; height: 30px; background-color: green; 
                    border-radius: 50%; display: inline-block; margin-left: 10px;
                }}
                .warn-circle {{ 
                    width: 30px; height: 30px; background-color: red; 
                    border-radius: 50%; display: inline-block; margin-left: 10px;
                }}
                .header {{
                    background-color: rgb(21, 2, 166);
                    color: white;
                    padding: 20px 0;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    align-items: center;
                    position: relative;
                }}
                .header img {{
                    width: 165px;
                    margin-bottom: 10px;
                }}
                .content {{
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    flex-direction: column;
                    margin-top: 20px;
                }}
                .title-text {{
                    text-align: center;
                    font-size: 12px;
                    margin-top: 20px;
                }}
                table {{
                    width: 80%;
                    border-collapse: collapse;
                    margin: 20px 0;
                }}
                th, td {{
                    padding: 8px;
                    border: 1px solid #ddd;
                    text-align: left;
                }}
                th {{ background-color: #f4f4f4; }}
                .count-box {{
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    gap: 20px;
                    margin: 20px 0;
                }}
                .count-item {{
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    font-size: 18px;
                }}
            </style>
        </head>
        <body>
            <div class="header">
                <img src="https://symphony4cloud.com/static/media/logo-1.a84c61ed3670ed0777c8.png" alt="Logo">
                <div class="title">
                    AI Powered Automation Report
                </div>
            </div>

            <div class="title-text">
                <h1> {report_name} </h1>
                <h2>Report Generated: {current_time}</h2>
            </div>

            <div class="content">
                <div class="count-box">
                    <div class="count-item"><strong>PASS Count:</strong> {pass_count} <span class="pass-circle"></span></div>
                    <div class="count-item"><strong>WARN Count:</strong> {warn_count} <span class="warn-circle"></span></div>
                </div>

                <table>
                    <tr>
                        <th>Seq</th>
                        <th>Message</th>
                    </tr>
        """
        counter = 1
        for line in lines:
            line = line.strip()
            if line:  # Ensure non-empty lines are processed
                row_class = ""
                if 'PASS' in line:
                    row_class = "pass"
                elif 'WARN' in line:
                    row_class = "warn"
                
                # Add each line with the correct class based on 'PASS' or 'WARN'
                html_content += f'<tr><td>{counter}</td><td class="{row_class}">{line}</td></tr>\n'
                counter += 1

        html_content += f"""
                </table>
            </div>

            <div class="footer">
                <p>Report of &copy; {datetime.datetime.now().year}</p>
            </div>
        </body>
        </html>
        """
        output_dir = os.path.dirname(output_file)
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)

        with open(output_file, 'w') as file:
            file.write(html_content)
        print(f"Report generated successfully: {output_file}")
    except Exception as e:
        print(f"Error processing the report: {e}")