% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RECORDS-get_recordId_details.R
\name{get_recordId_details}
\alias{get_recordId_details}
\title{Get details for a ChemSpider record}
\usage{
get_recordId_details(
  recordId,
  fields = "all",
  apikey,
  id = TRUE,
  simplify_formula = FALSE,
  coerce = FALSE
)
}
\arguments{
\item{recordId}{A valid (integer) ChemSpider ID.}

\item{fields}{Either a single character string, a character vector, or a character list stating which fields to return. Alternatively, \code{"all"} returns all possible \code{fields}. \code{fields} is NOT case sensitive, but see details for a list of possible entries.}

\item{apikey}{A 32-character string with a valid key for ChemSpider's API services.}

\item{id}{\code{logical}: Should the \code{id} column (i.e., the \code{recordId}) be part of the output? Defaults to \code{TRUE}.}

\item{simplify_formula}{\code{logical}: Should formula strings be simplified? Defaults to \code{FALSE}.}

\item{coerce}{\code{logical}: should the list be coerced to a data.frame? Defaults to \code{FALSE}.}
}
\value{
A \code{data.frame} if multiple columns are returned, or a vector of the appropriate type if only one \code{field} is returned.
}
\description{
This function returns record details from ChemSpider.
}
\details{
"Call this endpoint with a Record ID as an integer.\cr
\cr
The available fields are: SMILES, Formula, InChI, InChIKey, StdInChI, StdInChIKey, AverageMass, MolecularWeight, MonoisotopicMass, NominalMass, CommonName, ReferenceCount, DataSourceCount, PubMedCount, RSCCount, Mol2D, Mol3D."
}
\examples{
\dontrun{
## Get the record details for caffeine
recordId <- 2424L
apikey <- "A valid 32-character Chemspider API key"
get_recordId_details(recordId = recordId, 
                     fields = c("SMILES", "Formula", "MolecularWeight", "CommonName"), 
                     apikey = apikey)
}
}
\seealso{
\url{https://developer.rsc.org/compounds-v1/apis/get/records/{recordId}/details}
}
\author{
Raoul Wolf (\url{https://github.com/RaoulWolf/})
}
