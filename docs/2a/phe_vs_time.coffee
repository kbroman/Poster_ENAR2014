# phe_vs_time.coffee
#
# Interactive plot with a set of curves measured over time
#
# two linked scatterplots: 0 vs 60 and 60 vs 120, also linked to curve for an individual

# function that does all of the work
draw = (data) ->
  d3.select("p#loading").remove()
  d3.select("div#legend").style("opacity", 1)

  # times to plot in scatterplots
  times2plot = [[60,120], [120, 180]]

  # point sizes
  radius = 3
  bigRadius = 8

  # dimensions
  height = 375
  width = 375
  pad = {left: 120, top: 30, right: 40, bottom: 60, inner:10}
  width2 = width*2 + pad.left + pad.right
  heights = [height, height, height]
  widths = [width, width, width2]

  # colors
  blue = "slateblue"
  red = "Orchid"
  lightGray = d3.rgb(230, 230, 230)
  darkGray = d3.rgb(200, 200, 200)
  medGray = d3.rgb(205, 205, 205)
  bgcolor = lightGray
  pink = "hotpink"
  altpink = "#E9CFEC"
  purple = "#8C4374"
  labelcolor = "black"
  titlecolor = "blue"
  maincolor = "blue"

  # size of data set
  times = (t/60 for t in data.time) # time in hours
  nTimes = data.phe[0].length
  nInd = data.phe.length

  # min and max phenotype
  min = 999
  max = 0
  for phe, i in data.phe
    for p in phe
      min = p if p? and min > p
      max = p if p? and max < p

  # average
  ave = []
  for i in [0...nTimes]
    ave[i] = 0.0
    n = 0
    for j in [0...nInd]
      if data.phe[j][i]?
          n += 1
          ave[i] += data.phe[j][i]
    ave[i] = ave[i]/n

  ## SVG
  totalh = (height + pad.bottom + pad.top)*2
  totalw = (width + pad.left + pad.right)*2

  svg = d3.select("div#chart")
          .append("svg")
          .attr({height: totalh, width: totalw})

  panels = []
  panels[0] = svg.append("g").attr("id", "scatter1")
  panels[1] = svg.append("g").attr("id", "scatter2")
                 .attr("transform", "translate(#{width+pad.left+pad.right},0)")
  panels[2] = svg.append("g").attr("id", "timecourse")
                 .attr("transform", "translate(0,#{pad.top+pad.bottom+height})")

  chart = []
  for i in [0..1]
    chart[i] = scatterplot().xvar(times2plot[i][0])
                            .yvar(times2plot[i][1])
                            .height(heights[i])
                            .width(widths[i])
                            .margin(pad)
                            .xlab("Tip angle at #{times[times2plot[i][0]]} hrs")
                            .ylab("Tip angle at #{times[times2plot[i][1]]} hrs")
                            .axispos({xtitle:40, ytitle:60, xlabel:5, ylabel:5})
                            .pointcolor(blue)
    panels[i].datum(data.phe).call(chart[i])
    chart[i].pointsSelect()
        .on "mouseover", (d,i) ->
          d3.selectAll("circle.pt#{i}").attr("fill", "Orchid").attr("r", bigRadius)
          pathIndNoIntxn(i)
          title2.text("ind #{i+1}")
        .on "mouseout", (d,i) ->
          d3.selectAll("circle.pt#{i}").attr("fill", blue).attr("r", radius)
          d3.select("path#path_hilit").remove()
          title2.text("")

  # curves in panel C
  pathInd = (ind) ->
    panels[2].append("path")
             .attr("class", "indpath")
             .datum(data.phe[ind])
             .attr("d", curve)
             .attr("fill", "none")
             .attr("stroke-width", 2)
             .attr("stroke", medGray)
             .attr("opacity", 0.7)
             .on "mouseover", () ->
                d3.selectAll("circle.pt#{ind}").attr("fill", "Orchid").attr("r", bigRadius)
                pathIndNoIntxn(ind)
                title2.text("ind #{ind+1}")
             .on "mouseout", () ->
                d3.selectAll("circle.pt#{ind}").attr("fill", blue).attr("r", radius)
                d3.select("path#path_hilit").remove()
                title2.text("")

  pathIndNoIntxn = (ind) ->
    panels[2].append("path")
             .attr("class", "indpath")
             .attr("id", "path_hilit")
             .datum(data.phe[ind])
             .attr("d", curve)
             .attr("fill", "none")
             .attr("stroke-width", 3)
             .attr("stroke", blue)
             .attr("opacity", 0.7)
             .style("pointer-events", "none")

  # last chart (with dummy data)
  pad.inner=0
  chart[2] = scatterplot().xvar(0)
                          .yvar(1)
                          .height(heights[2])
                          .width(widths[2])
                          .margin(pad)
                          .xlab("Time (hrs)")
                          .ylab("Tip angle")
                          .axispos({xtitle:40, ytitle:60, xlabel:5, ylabel:5})
                          .xlim(d3.extent(times))
                          .ylim([min, max])
                          .pointsize(0)
                          .xNA({handle:false, force:false})
                          .yNA({handle:false, force:false})
  panels[2].datum(data.phe[0..2]).call(chart[2])

  title2 = panels[2].append("text")
                    .attr("x", pad.left+width2/2)
                    .attr("y", pad.top*0.7)
                    .attr("fill", blue)
                    .attr("text-anchor", "middle")

  # curve for average
  curve = d3.svg.line()
              .x((d,i) -> chart[2].xscale() (times[i]))
              .y((d) -> chart[2].yscale() (d))


  for i in d3.range(nInd)
    pathInd(i)

  panels[2].append("path")
           .datum(ave)
           .attr("d", curve)
           .attr("stroke", purple)
           .attr("fill", "none")
           .attr("stroke-width", 2)

  panels[2].append("text")
           .text("ave")
           .attr("fill", purple)
           .attr("y", chart[2].yscale()(ave[nTimes-1]))
           .attr("x", width2+pad.left+pad.right*0.1)
           .style("dominant-baseline", "middle")
           .attr("text-anchor", "start")

# load json file and call draw function
d3.json("phe_vs_time.json", draw)
