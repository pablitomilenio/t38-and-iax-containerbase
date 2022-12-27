import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.MimeConstants;

/*..*/

// Step 1: Construct a FopFactory by specifying a reference to the configuration file
// (reuse if you plan to render multiple documents!)
FopFactory fopFactory = FopFactory.newInstance(new File("C:/Temp/fop.xconf"));

// Step 2: Set up output stream.
// Note: Using BufferedOutputStream for performance reasons (helpful with FileOutputStreams).
OutputStream out = new BufferedOutputStream(new FileOutputStream(new File("C:/Temp/myfile.pdf")));

try {
    // Step 3: Construct fop with desired output format
    Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, out);

    // Step 4: Setup JAXP using identity transformer
    TransformerFactory factory = TransformerFactory.newInstance();
    Transformer transformer = factory.newTransformer(); // identity transformer

    // Step 5: Setup input and output for XSLT transformation
    // Setup input stream
    Source src = new StreamSource(new File("C:/Temp/myfile.fo"));

    // Resulting SAX events (the generated FO) must be piped through to FOP
    Result res = new SAXResult(fop.getDefaultHandler());

    // Step 6: Start XSLT transformation and FOP processing
    transformer.transform(src, res);

} finally {
    //Clean-up
    out.close();
}