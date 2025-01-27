*** Settings ***
Library    Kellanova_Library.py
*** Keywords ***
Catalogimage
    Compare Images    default_path=    compare_path=    log_file_path=
    Sleep    0.5 seconds
    Create Pdf    default_folder=    current_folder=    output_pdf_path=
    Sleep    0.5 seconds
    Imagecomparsion Html Report    pdf_path=    input_file=    output_html_path=
    Sleep    0.5 seconds
Productimage
    Compare Images    default_path=    compare_path=    log_file_path=
    Sleep    0.5 seconds
    Create Pdf    default_folder=    current_folder=    output_pdf_path=
    Sleep    0.5 seconds
    Imagecomparsion Html Report    pdf_path=    input_file=    output_html_path=
    Sleep    0.5 seconds
Wheretobuyimage
    Compare Images    default_path=    compare_path=    log_file_path=
    Sleep    0.5 seconds
    Create Pdf    default_folder=    current_folder=    output_pdf_path=
    Sleep    0.5 seconds
    Imagecomparsion Html Report    pdf_path=    input_file=    output_html_path=
    Sleep    0.5 seconds
    

