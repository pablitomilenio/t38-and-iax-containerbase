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


// faxstat -d | grep '66'


app.get("/sendprot", (req, res) => {
  res.write("SENDING PROTOCOL\r\n\r\n");
  var faxID = 0;

  exec_string = "cat ./prot/out.txt | awk '{print $4}'";
  exec(exec_string, (error, stdout, stderr) => {
    faxID = stdout;
    res.write (`Last fax ID-Number: ${faxID} \r\n\r\n`);
  });

  exec_string = `faxstat -d | grep ${faxID}`;
  exec(exec_string, (error, stdout, stderr) => {
    faxID = stdout;
    res.write (`Last fax ID-Number: ${faxID} \r\n\r\n`);
  });

  res.end("chau");
});

app.get("/status", (req, res) => {
  res.write("STATUS PAGE\r\n\r\n");

  exec_string = "sudo /usr/sbin/asterisk -rx 'sip show peers' | grep online | awk '{print $5}'";
  exec(exec_string, (error, stdout, stderr) => {
    res.write(`Number of online SIP Peers: ${stdout} (should be 2. Below 2 means timeout of the fritzbox. Then wait 15 min.) \r\n\r\n`);
  });
  
  exec_string = "sudo /usr/sbin/asterisk -rx 'iax2 show peers' | grep online | awk '{print $4}'";
  exec(exec_string, (error, stdout, stderr) => {
    res.write(`Number of online IAX Modems: ${stdout.substring(1,2)} \r\n (should be 1) \r\n\r\n`);
  });

  exec_string = "faxstat -s | grep '0:' | awk '{print $1}'";
  exec(exec_string, (error, stdout, stderr) => {
    res.write(`ID of old faxes pending in the queue?: '${stdout}' (should be emtpy ''. Use the faxrm tool to remove faxes from the queue) \r\n\r\n`);
  });

  exec_string = "ping -c1 fritz.box | grep 'seq=1' | awk '{print $1}'";
  exec(exec_string, (error, stdout, stderr) => {
    res.end(`Milliseconds response from the Fritz!Box: ${stdout} (should be ideally between 5 and 15. Too slow responses mean the fax will not go through) \r\n\r\n`);
  });
});


app.post("/upload", (req, res) => {
  var recipient_tel = req.body.telnr;
  var exec_string = "/usr/bin/sendfax -n -d " + recipient_tel 
                    +" /home/root/website/uploads/outgoing.pdf > /home/root/website/prot/out.txt";

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
