const express = require("express");
const fileUpload = require("express-fileupload");
const { OutgoingMessage } = require("http");
const { exec } = require("child_process");
const path = require("path");
const app = express();
const fs = require('fs')
const ts = require('log-timestamp');

app.use(
  fileUpload()
);

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "/express/modes.html"));
});

app.get("/styles", (req, res) => {
  res.sendFile(path.join(__dirname, "/express/styles/all.css"));
});

app.get("/ptxt", (req, res) => {
  res.sendFile(path.join(__dirname, "/express/plaintext.html"));
});


const path_og = __dirname + "/uploads/" + "outgoing.pdf";

app.get("/ulform", (req, res) => {
  res.sendFile(path.join(__dirname, "/express/sendpdf.html"));

  fs.unlink(path_og, (err) => {
    if (err) {
      //console.error(err)
      return
    }
    //console.log("removed old outgoing fax file");
  })

});

app.post("/upload", (req, res) => {
  var recipient_tel = req.body.telnr;
  var exec_string = "/usr/bin/sendfax -n -d " + recipient_tel 
                    +" /home/root/website/uploads/outgoing.pdf";

  if (!req.files) {
    return res.status(400).send("No files were uploaded.");
  }
  if (!req.body.telnr) {
    return res.status(400).send("A telephone number must be specified.");
  }

  const file = req.files.myFile;
  const path = __dirname + "/uploads/" + "outgoing.pdf";

  file.mv(path, (err) => {
    if (err) {
      return res.status(500).send(err);
    }

    exec(exec_string, (error, stdout, stderr) => {

      if (error) {
          console.log(`error: ${error.message}`);
          return;
      }
      if (stderr) {
          console.log(`stderr: ${stderr}`);
          return;
      }
      console.log(`stdout: ${stdout}`);

    });

    //console.log("the location of the file that I am sending is: "+path);
    console.log(exec_string);
    return res.send("I am sending the fax now to: "+recipient_tel);

  });
});

const port = 3000
app.listen(port, () => {
  console.log(`Fax App listening on port ${port}`)
})
