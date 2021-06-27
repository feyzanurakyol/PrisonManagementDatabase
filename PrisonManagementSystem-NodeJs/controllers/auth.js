
exports.register = (req, res) => {
    console.log(req.body);
    res.send({message: "done"});
}