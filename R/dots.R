
labels = c(paste0("1", letters[1:4]), paste0("2", letters[1:2]))
color <- "slateblue"

for(i in labels) {
  pdf(paste0("../Figs/dot", i, ".pdf"), height=1.02, width=1.02, pointsize=16)
  par(mar=rep(0,4), bty="n")
  plot(0,0, cex=10, pch=16, col=color, xlab="", ylab="", xaxt="n", yaxt="n")
  text(0,0, i, col="white", cex=2.5)
  dev.off()
}
 
