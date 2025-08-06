# Md2tex Allows You to Convert Your Markdown File into LaTeX

# How to Use
1. Download the MATLAB m-files to your local folder. You can use git clone, curl, iwr command, or click the download zip button on the website.
2. Copy your markdown files to the folder where you downloaded your m-files.
3. Launch Matlab, in the command window, type the following commands: `cd <m-files path>`, `md2tex_matlab('<your md file name>')`.
4. The .tex file will appear in the same folder named result.tex.

You can also use MATLAB Online instead. Just copy the md2tex_matlab.m and the md file to MATLAB Drive, and type the commands mentioned above.

If you are a user of Octave, follow these steps:
1. Download the md2tex files to your local folder as mentioned above.
1. Copy your md file into the folder where you downloaded the md2tex.
1. Launch Octave and in the command window type: `cd <md2tex path>`.
1. Type: `md2tex_octave('<your md file name>')`.
1. The output file will appear in the same folder named result.tex.

# About Format in Md File
## Heading and Author
Each level of headings in Markdown should be put on a new line. At most four levels of heading are supported (when with the notitle argument. Any further level of heading would not be converted.

If your MD file contains only one heading 1 at the first line, you can add the argument with title as the second argument, if you want to make it the title. In this case, the only heading 1 in md file will be converted to a title in latex file. And the heading 2 in md file would be converted into a section, heading 3 to the subsection, heading 3 to the subsubsection. And at most 4 levels of title can be converted into tex file.

The default is notitle, in this case, the heading 1 is converted to a section, heading 2 to a subsection, and heading 3 to a subsubsection. And at most 3 levels of heading would be converted.

You can also add the author name, e.g., `md2tex('<file name>','withtitle','< author name>'`.
## List
Any list must be put in a new line and no line breaks in your list items. Do NOT add any additional space at the beginning or end of these items.
## Table
Any row of a table should be put in a new line, and do not add additional space at the beginning or end of a row.
# Features not supported
Those non-supported are:
- Emoji
- Picture with URL (for latex engine could not download the picture from the Internet, so use your local picture instead).
- Head ID and link to Head ID.
