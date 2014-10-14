Epub to other formats
==================

This project is a tool for reuse the epub books, converting it to other formats.

In this first version, the first format to convert will be a format HTML5 with some special characteristics, we will convert to a special HTML5, a HTML5 that can be annotateit using this other project [https://github.com/albertjuhe/annotator_nodejs_store] (https://github.com/albertjuhe/annotator_nodejs_store).

The samples for the conversion are books from the [Guttenber project](guttenberg project).

##Installation

- Install a XSL processor, for example Saxon
- Java 1.6 or sup.

##Execution

To convert a epub file to HTML5 you have to call the file epub2html5 file as follow:

"Adventures of Huckleberry Finn" epub:

```xml
epub2html5 [epub_name] [output_format]
epub2html5 pg76 HTML5
```

This command will convert the epub pg2591.epub to HTML5 format and generates the output in the output_process variable defined in the bat file.

By default the system will search the [epub_name].epub in the input_process folder, defined in the .bat file.

In all cases the main xsl file will be main.xsl. For example HTML5/main.xsl and etc..
 

