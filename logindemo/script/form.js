function checkAll() {
    for (var i = 0; i < frm.elements.length; i++) {
        if ((frm.elements[i].name != 'allcheck') && (frm.elements[i].type == 'checkbox')) {
            console.log(frm.elements[i].name)
            console.log(frm.elements[i].type)
            frm.elements[i].checked = frm.elements.allcheck.checked;
        }
    }
}