const {
    Employees,
} = cds.entities('opensap.MD')


const checkRead = async (req,next)=>{
    const entity = await next();
    if (entity.length) {
        const filtered = entity.filter((entry) => {
            return entry.partnerRole === 1;
        });
        return filtered;
    } else {
        return singleCheck(entity, req);
    }
}

module.exports = async (srv) => {

    srv.on('READ','Employees', checkRead);

}