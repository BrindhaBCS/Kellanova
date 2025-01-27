import os
import shutil
from PIL import Image
from fpdf import FPDF
import re
import os
from datetime import datetime
# import fitz  # pip install pymupdf
import base64
import datetime
from PIL import Image
# from reportlab.pdfgen import canvas #pip install reportlab
import textwrap


class Kellanova_Library:    
    def __init__(self):
        self.name = "report"

    def copy_images(self, source_dir, target_dir):
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

    def delete_specific_files_in_folder(self, folder_path):
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

    def extract_and_txt(self, file_path):
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


    def generate_report_html(self, input_file, output_file, report_name):
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

    def compare_images(self, default_path, compare_path, log_file_path):
        images1 = sorted([f for f in os.listdir(default_path) if f.endswith('.png')])
        images2 = sorted([f for f in os.listdir(compare_path) if f.endswith('.png')])

        common_images = set(images1) & set(images2)
        if not common_images:
            with open(log_file_path, "a") as log_file:
                log_file.write("No matching images found in both folders.\n")
            return

        with open(log_file_path, "a") as log_file:
            for index, image_name in enumerate(sorted(common_images), start=1):
                path1 = os.path.join(default_path, image_name)
                path2 = os.path.join(compare_path, image_name)
                try:
                    image1 = Image.open(path1).convert("RGB")
                    image2 = Image.open(path2).convert("RGB")
                    diff = ImageChops.difference(image1, image2)

                    if diff.getbbox():
                        # Highlight the differences with a thinner border
                        highlighted_image = image2.copy()
                        draw = ImageDraw.Draw(highlighted_image)
                        mask = diff.convert("L").point(lambda x: 255 if x > 0 else 0)
                        diff_boxes = mask.getbbox()
                        draw.rectangle(diff_boxes, outline="red", width=1)  # Thinner border

                        output_path = os.path.join(compare_path, f"{image_name}")
                        highlighted_image.save(output_path)
                        log_file.write(f"WARN: {image_name} is different.\n")
                    else:
                        log_file.write(f"PASS: {image_name} is identical.\n")
                except Exception as e:
                    log_file.write(f"WARN: {image_name} is different.\n")

    def create_pdf(self, default_folder, current_folder, output_pdf_path):
        try:
            default_images = sorted(
                [f for f in os.listdir(default_folder) if f.endswith('.png')], 
            )
            current_images = sorted(
                [f for f in os.listdir(current_folder) if f.endswith('.png')], 
            )

            if not default_images or not current_images:
                raise ValueError("No PNG files found in one or both folders.")

            if len(default_images) != len(current_images):
                raise ValueError("The number of files in both folders is not the same.")

            pdf_canvas = canvas.Canvas(output_pdf_path, pagesize=(595.27, 841.89))  # A4 size in points (72 DPI)
            pdf_canvas.setTitle("Image Comparison")

            page_width, page_height = 595.27, 841.89  # A4 dimensions
            margin = 110  # Leave margins at top and bottom
            image_y_offset = 450  # Initial vertical offset for the first image on each page
            image_gap = 250  # Vertical gap between image pairs
            image_height = 200
            image_width = 200

            for i in range(len(default_images)):
                if i % 2 == 0:
                    # Header Titles for each page
                    pdf_canvas.setFont("Helvetica-Bold", 14)
                    pdf_canvas.drawCentredString(
                        page_width / 2,
                        page_height - margin,
                        "Default Image (Left)                           Compare Image (Right)"
                    )

                # Calculate vertical position for images
                image_y = image_y_offset - (i % 2) * image_gap

                # Add default image (Left)
                pdf_canvas.drawImage(
                    os.path.join(default_folder, default_images[i]),
                    page_width / 4 - image_width / 2,
                    image_y,
                    width=image_width,
                    height=image_height
                )

                # Add compare image (Right)
                pdf_canvas.drawImage(
                    os.path.join(current_folder, current_images[i]),
                    3 * page_width / 4 - image_width / 2,
                    image_y,
                    width=image_width,
                    height=image_height
                )

                # Add file names under images
                pdf_canvas.setFont("Helvetica", 10)
                default_name_lines = textwrap.wrap(default_images[i], width=30)
                compare_name_lines = textwrap.wrap(current_images[i], width=30)

                default_text_y = image_y - 20
                compare_text_y = image_y - 20

                for line in default_name_lines:
                    pdf_canvas.drawCentredString(page_width / 4, default_text_y, line)
                    default_text_y -= 12

                for line in compare_name_lines:
                    pdf_canvas.drawCentredString(3 * page_width / 4, compare_text_y, line)
                    compare_text_y -= 12

                # Add a new page after every two pairs
                if i % 2 == 1 or i == len(default_images) - 1:
                    pdf_canvas.showPage()

            pdf_canvas.save()
            print(f"PDF created successfully at {output_pdf_path}")

        except Exception as e:
            print(f"Error: {e}")

    def imagecomparsion_html_report(self, pdf_path, input_file, output_html_path):
        def convert_pdf_to_html_with_images(pdf_path):
            if not os.path.exists(pdf_path):
                raise FileNotFoundError(f"The PDF file {pdf_path} does not exist.")

            current_time = datetime.datetime.utcnow().strftime('%d-%m-%Y Time: %H:%M:%S UTC')
            # Temporary store images
            temp_folder = "temp_images"
            os.makedirs(temp_folder, exist_ok=True)

            # Open PDF
            pdf_document = fitz.open(pdf_path)
            html_content = f"""
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Symphony Report</title>
                <style>
                    body {{ font-family: Arial, sans-serif; }}
                    h1 {{ text-align: center; }}
                    .pdf-page {{ text-align: center; margin-bottom: 20px; }}
                    .pdf-image {{ width: 100%; max-width: 800px; display: block; margin: 0 auto; }}
                </style>
            </head>
            <body>
                <h1>PDF Report</h1>
                <h2>Generated on: {current_time}</h2>
            """

            # Convert
            for page_num in range(len(pdf_document)):
                page = pdf_document[page_num]
                pix = page.get_pixmap()
                image_path = os.path.join(temp_folder, f"page_{page_num + 1}.png")
                pix.save(image_path)

                # Convert image to Base64
                with open(image_path, "rb") as img_file:
                    encoded_image = base64.b64encode(img_file.read()).decode('utf-8')
                    html_content += f"""
                    <div class="pdf-page">
                        <img src="data:image/png;base64,{encoded_image}" class="pdf-image" alt="PDF Page {page_num + 1}">
                    </div>
                    """
            # Close PDF document
            pdf_document.close()

            html_content += """
            </body>
            </html>
            """

            return html_content

        # Create the report
        def create_report(pdf_content, output_html_path, input_file):
            pass_count = 0
            warn_count = 0
            current_time = datetime.datetime.utcnow().strftime('%d-%m-%Y Time: %H:%M:%S UTC')

            if not os.path.exists(input_file):
                print(f"Error: The input file '{input_file}' does not exist.")
                return

            try:
                with open(input_file, 'r') as file:
                    lines = file.readlines()
                    for line in lines:
                        line = line.strip()
                        if line:  # Only count non-empty lines
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
                    <title>Symphony Report</title>
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
                            width: 60%;
                            margin: 0 auto;
                            border-collapse: collapse;
                        }}
                        th, td {{
                            padding: 8px;
                            border: 1px solid #ddd;
                            text-align: left;
                        }}
                        th {{
                            background-color: #f4f4f4;
                        }}
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
                        .hidden {{
                            display: none;
                        }}
                    </style>
                    <script>
                        function showContent(page) {{
                            var mainPage = document.getElementById('main-page');
                            var pdfPage = document.getElementById('pdf-page');
                            
                            if(page === 'pdf') {{
                                mainPage.classList.add('hidden');
                                pdfPage.classList.remove('hidden');
                            }} else {{
                                mainPage.classList.remove('hidden');
                                pdfPage.classList.add('hidden');
                            }}
                        }}
                    </script>
                </head>
                <body>
                    <div class="header">
                        <img src="https://symphony4cloud.com/static/media/logo-1.a84c61ed3670ed0777c8.png" alt="Logo">
                        <div class="title">
                            AI Powered Automation Report
                        </div>
                    </div>

                    <div class="title-text">
                        <h1>Final Report of Club Crackers Site</h1>
                        <h2>Report Generated: {current_time}</h2>
                    </div>

                    <!-- Main content -->
                    <div id="main-page" class="content">
                        <h3>PDF Report Content</h3>
                        <div id="pdf-display">
                            <!-- Default message or placeholder -->
                            <p>Please select a report to view the PDF.</p>
                        </div>
                        <div>
                            <label for="pdfreport">PDF Report:</label>
                            <select id="pdfreport" name="pdfreport" onchange="showContent(this.value);">
                                <option value="">-- Select a Report --</option>
                                <option value="pdf">View PDF Report</option>
                            </select>
                        </div>
                    </div>

                    <!-- PDF content page -->
                    <div id="pdf-page" class="content hidden">
                        <div>
                            <!-- Display the HTML content of the converted PDF -->
                            {pdf_content}
                        </div>
                    </div>

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
                with open(input_file, 'r') as file:
                    lines = file.readlines()
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

                html_content += """
                    </table>
                </div>

                <div class="footer">
                    <p>Report of &copy; @2025</p>
                </div>
                </body>
                </html>
                """
                
                output_dir = os.path.dirname(output_html_path)
                if not os.path.exists(output_dir):
                    os.makedirs(output_dir)

                with open(output_html_path, 'w') as file:
                    file.write(html_content)
                print(f"Report generated successfully: {output_html_path}")
            except Exception as e:
                print(f"Error processing the report: {e}")
        converted_pdf_html_content = convert_pdf_to_html_with_images(pdf_path)
        # Create the report including PDF content and log data
        create_report(converted_pdf_html_content, output_html_path, input_file)
