#' Read numbering.xml in the docx
#'
#' @param file docx file path
#'
#' @return numbering
#' @export
#'
#' @examples
#' \dontrun{
#' read_numbering("reference.docx")
#' }
read_numbering <- function(file){
  tmpdir = fs::file_temp()
  officer::unpack_folder(file = file, folder = tmpdir)
  x <- xml2::read_xml(fs::path_abs(fs::path(tmpdir, "word/numbering.xml")))

  fs::dir_delete(tmpdir)

  x
}


write_numbering <- function(numbering_xml, org_docx, new_docx){

  tmpdir = fs::file_temp()
  officer::unpack_folder(file = org_docx, folder = tmpdir)

  xml2::write_xml(numbering_xml,
                  fs::path_abs(fs::path(tmpdir, "word/numbering.xml")),
                  format="format_whitespace")

  officer::pack_folder(new_docx, folder = tmpdir)

  fs::dir_delete(tmpdir)
}

