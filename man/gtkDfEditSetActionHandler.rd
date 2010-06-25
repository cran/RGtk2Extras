\name{gtkDfEditSetActionHandler}
\alias{gtkDfEditSetActionHandler}
\title{Editor change handling.}
\usage{gtkDfEditSetActionHandler(object, func.name, handler=NULL, data=NULL)}
\description{Function to call when grid is changed}
\details{IF set to NULL, no handler is called.}
\arguments{
\item{object}{The RGtk2DfEdit object}
\item{func.name}{The name of the spreadsheet function to monitor.}
\item{handler}{Function to call when column clicked. Signature varies, see 
below. If NULL (default) no handler is called.}
\item{data}{Optional data to pass to the function.}
}
\note{
The following function names and signatures for the handler can be used. 
"Selection" means a cell range is selected and a selection rectangle is drawn.
                                  
Selection: function(rows, cols, data=NULL) 

ChangeCells: function(df, nf, row.idx, col.idx, do.coercion=T, data=NULL)

SetFactorAttributes: function(df, idx, info, data=NULL)

CoerceColumns: function(df, theClasses, col.idx, data=NULL)

ChangeColumnNames: function(df, theNames, col.idx, data=NULL)

ChangeRowNames: function(df, theNames, row.idx, data=NULL)

DeleteRows: function(df, row.idx, data=NULL) 

InsertRows: function(df, nf, row.idx, data=NULL)

InsertNARows: function(df, row.idx, data=NULL)

DeleteColumns: function(df, col.idx, data=NULL) 

InsertColumns: function(df, nf, col.idx, data=NULL)

InsertNAColumns: function(df, col.idx, NA.opt="", data=NULL)   

df is the current data frame before the change is applied.

nf is the new data frame being passed to the function, if any.

do.coercion is the flag which tells the editor whether to coerce the new frame 
(nf) to the type of the old data frame or not.

theClasses and theNames are the new classes or new names being applied to the 
function.

idx is the indices at which to insert or change new columns or rows, or column 
or row names.

theNames and theClasses must have the same length as idx, and when "nf" is 
present nf must have the same number of rows as idx if InsertColumns is called, 
and the same number of columns as idx if InsertRows is being called.

info is a list of form list(levels, contrasts, contrast.names). contrasts and 
contrast.names may or may not be present.

NA.opt is an optional NA to pass to InsertNAColumns to coerce to a particular
type, for example NA.opt=NA_real_ will make the NA columns inserted numeric.
}

\examples{
obj <- dfedit(iris)

obj$setActionHandler("ChangeCells", 
  handler=function(df, nf, row.idx, col.idx, do.coercion, data) {
   print(paste("Cells changed at R", if(!missing(row.idx)) row.idx, ", C", 
if(!missing(col.idx)) col.idx, sep=""))
}, data=obj)

obj$setActionHandler("SetFactorAttributes", data=obj, 
  handler=function(df, col.idx, info, data) {
print(paste("factor changed at", col.idx, "new levels", paste(info$levels, 
collapse=", ")))
})

obj$setActionHandler("CoerceColumns", data=obj, 
  handler=function(df, theClasses, col.idx, data) {
print(paste("columns", col.idx, "coerced to", theClasses))
})

obj$setActionHandler("ChangeColumnNames", data=obj, 
  handler=function(df, theNames, col.idx, data) {
print(paste("column names at", col.idx, "changed to", theNames))
})

obj$setActionHandler("ChangeRowNames", data=obj, 
  handler=function(df, theNames, row.idx, data) {
print(paste("row names at", row.idx, "changed to", theNames))
})

obj$setActionHandler("DeleteRows", data=obj, 
  handler=function(df, row.idx, data) {
print(paste("rows at", row.idx, "deleted"))
})

obj$setActionHandler("InsertRows", data=obj, 
  handler=function(df, nf, row.idx, data) {
print(paste("rows inserted at", row.idx))
print(nf)
})

obj$setActionHandler("InsertNARows", data=obj, 
  handler=function(df, row.idx, data) {
print(paste("rows inserted at", row.idx))
})

obj$setActionHandler("DeleteColumns", data=obj, 
  handler=function(df, col.idx, data) {
print(paste("columns at", col.idx, "deleted"))
})

obj$setActionHandler("InsertColumns", data=obj, 
  handler=function(df, nf, col.idx, data) {
print(paste("cols inserted at", col.idx))
})

obj$setActionHandler("InsertNAColumns", data=obj, 
  handler=function(df, nf, col.idx, NA.opt, data) {
print(paste("cols inserted at", col.idx))
})

obj$setActionHandler("Selection", data=obj, 
  handler=function(row.idx, col.idx, data) {
  print(paste(paste(length(row.idx), "R", sep=""), "x", paste(length(col.idx), 
"C", sep="")))
})

obj$setActionHandler("RowClicked", data=obj, 
  handler=function(idx, data) print(obj[idx,]))

obj$setActionHandler("ColumnClicked", data=obj, 
  handler=function(idx, data) print(obj[,idx]))
}
