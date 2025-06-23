# Md2tex Allows You Convert Your Markdown File into Latex
## How to Use
1. Download to your local fold, suppose you download to you $HOME, just type following command in terminal: `mkdir ~/md2tex`, `git clone https://github.com/Anugs-Z-Wong/md2tex_matlab.git ~/md2tex`, if you do not use `git`, you could use `curl` in Linus or `iwr` command in Windows Powershell, or just download the files in the website.
2. Copy your markdown files to the folder you download.
3. Lanch the [Matlab](https://www.mathworks.com/products/matlab.html), in the command window, type following commands:`cd ~/md2tex`, `md2tex_matlab('<your md file name>')`, for using arguments, please refer next section.
4. The tex file will appear in the same folder named `result.tex`.

If you do not use Matlab, you can use the [Matlab Online](https://www.mathworks.com/products/matlab-online.html) instead, just copy the `md2tex_matlab.m` and the md file you want to convert to [Matlab Drive](https://www.mathworks.com/products/matlab-drive.html), and type the commands mentioned above.

If you are the user of [Octave](https://octave.org/), follow these steps:
1. Download the md2tex files to your local folder just as mentioned above.
1. Copy your md file into the folder where you download the md2tex.
1. Lanch Octave and in command window type: `cd ~/md2tex`.
1. Type:`md2tex_octave('<your md file name>')`.
1. The output file will appear in the same folder named `result.tex`.
## About Format in Md File
### Heading and Author
Each level of headings in markdown should be put at a new line. At most four levels of heading is supported. Any further level of heading would not be converted in latex file.

If your md file just contains only one heading 1, you can add the argument `with title` as the second argument, in this case, the only heading 1 in md file will be convert to title in latex file. And the heading 2 in md file would be converted into section, heading 3 to the subsection, heading 3 to the subsubsection.

The default is `notitle`, in this case, the heading 1 is converted to section, heading 2 to subsection, and heading 3 to subsubsection.

You can also add the author name, e.g., `md2tex('<file name>','withtitle','<autor name>'`. The author name will not appear in your PDF output after compiling the tex file converted by md2tex unless with `withtitle` argument.
### List
Any list must be put in a new line and no line break in your list items. Do not add any additional space at the begin or end of these items.
### Table
Any row of a table should be put in a new line, and do not add additional space at begin or end of a row.
### Features not Supported
The non-supported are:
1. Emoji
1. Picture with URL (for latex engine could not download the picture from Internet, so use your local picture instead).
1. Head ID and link to Head ID.
