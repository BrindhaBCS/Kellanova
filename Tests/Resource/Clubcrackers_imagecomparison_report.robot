*** Settings ***
Library    Kellanova_Library.py
*** Keywords ***
Kellanova_Current_image
    Compare Images    default_path=C:\\Kellanova\\Kellanova_Default_image\\    compare_path=C:\\Kellanova\\Kellanova_Current_image\\    log_file_path=C:\\Kellanova\\Kellanova_Current_image\\Kellanova_comparison_log.txt
    Sleep    0.5 seconds
    Create Pdf    default_folder=C:\\Kellanova\\Kellanova_Default_image\\    current_folder=C:\\Kellanova\\Kellanova_Current_image\\    output_pdf_path=C:\\Kellanova\\Kellanova_Current_image\\Kellanova_comparison_log.pdf
    Sleep    0.5 seconds
    Imagecomparsion Html Report    pdf_path=C:\\Kellanova\\Kellanova_Current_image\\Kellanova_comparison_log.pdf    input_file=C:\\Kellanova\\Kellanova_Current_image\\Kellanova_comparison_log.txt    output_html_path=C:\\Kellanova\\Kellanova_Current_image\\Kellanova_comparison_log.html
    Sleep    0.5 seconds

    

