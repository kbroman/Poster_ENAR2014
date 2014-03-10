
navbar = (location) ->
  totalw = 1000

  width = 800
  height = 90
  spacer = 150
  leftgap = totalw-width
  radius = 30
  regcolor = "slateblue"
  hilitcolor = "Orchid"
  curcolor = "Purple"

  widthleft = 100
  maincolor = "Lavender"
  mainhilit = "Violet"
  textjit = height*0.15

  svg = d3.select("div#navbar").append("svg")
          .attr("width", totalw)
          .attr("height", height)


  if location >= 0
    svg.append("a") # hyperlink
         .attr("xlink:href", "..")
       .append("rect")
         .attr("x", 0)
         .attr("y", 0)
         .attr("height", height)
         .attr("width", widthleft)
         .attr("stroke", "none")
         .attr("fill", maincolor)
         .on "mouseover", () ->
             d3.select(this).attr("fill", mainhilit)
         .on "mouseout", (d,i) ->
             d3.select(this).attr("fill", maincolor)

    svg.append("text")
         .attr("y", height/2 - textjit)
         .attr("x", widthleft/2)
         .attr("fill", "black")
         .style("font-size", "20pt")
         .attr("dominant-baseline", "middle")
         .attr("text-anchor", "middle")
         .text("main")
         .style("pointer-events", "none")

    svg.append("text")
         .attr("y", height/2 + textjit)
         .attr("x", widthleft/2)
         .attr("fill", "black")
         .style("font-size", "20pt")
         .attr("dominant-baseline", "middle")
         .attr("text-anchor", "middle")
         .text("page")
         .style("pointer-events", "none")


  # gray background
  svg.append("rect")
     .attr("x", leftgap)
     .attr("y", 0)
     .attr("height", height)
     .attr("width", width)
     .attr("stroke", "none")
     .attr("fill", d3.rgb(230, 230, 230))

  directories = ["1a", "1b", "1c", "1d", "2a", "2b"]

  xscale = d3.scale.ordinal()
             .domain(d3.range(directories.length))
             .rangePoints([leftgap+spacer, leftgap+width], 1)

  svg.selectAll("empty")
     .data(directories)
     .enter()
     .append("a") # hyperlink
        .attr("xlink:href", (d) ->
          return d if location < 0
          "../#{d}")
     .append("circle")
     .attr("id", (d,i) -> "circ#{i}")
     .attr("cy", height/2)
     .attr("cx", (d,i) -> xscale(i))
     .attr("r", radius)
     .attr("stroke", "none")
     .attr("fill", (d,i) ->
           return curcolor if i==location
           regcolor)
     .on "mouseover", (d,i) ->
         return d3.select(this).attr("fill", (d,i) -> hilitcolor) if i != location
     .on "mouseout", (d,i) ->
         d3.select(this).attr("fill", () -> 
           return curcolor if i==location
           regcolor)

  # drop link for "current" circle 
  svg.select("circle#circ#{location}")
     .style("pointer-events", "none")

  svg.selectAll("empty")
     .data(directories)
     .enter()
     .append("text")
     .attr("y", height/2)
     .attr("x", (d,i) -> xscale(i))
     .text((d) -> d)
     .attr("fill", "white")
     .style("font-size", "20pt")
     .attr("dominant-baseline", "middle")
     .attr("text-anchor", "middle")
     .style("pointer-events", "none")

  svg.append("text")
     .attr("x", leftgap+spacer/2)
     .attr("y", height/2)
     .attr("fill", "black")
     .style("font-size", "20pt")
     .text("Figure:")
     .attr("dominant-baseline", "middle")
     .attr("text-anchor", "middle")
     
    
