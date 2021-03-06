import * as d3_base from 'd3';
import * as d3_dag from 'd3-dag';

const d3 = Object.assign({}, d3_base, d3_dag);

export const layerings = {
    "Simplex (slow)": d3.layeringSimplex(),
    "Longest Path (fast)": d3.layeringLongestPath(),
    "Coffman Graham (medium)": d3.layeringCoffmanGraham(),
};

export const decrossings = {
    "Optimal (slow)": d3.decrossOpt(),
    "Two Layer Opt (medium)": d3.decrossTwoLayer().order(d3.twolayerOpt()),
    "Two Layer (fast)": d3.decrossTwoLayer(),
};

export const coords = {
    "Vertical (slow)": d3.coordVert(),
    "Minimum Curves (slow)": d3.coordMinCurve(),
    "Greedy (medium)": d3.coordGreedy(),
    "Center (fast)": d3.coordCenter(),
};

const stratify = d3.dagStratify();

const drawDag = function (parent, dagData, {
    nodeRadius = 50, width = 1100, height = 800, padding = 10,
    layering = "Longest Path (fast)", decross = "Optimal (slow)", coord = "Center (fast)",
}) {
    const viewBox = [
        -nodeRadius - padding,
        -nodeRadius - padding,
        width + (2 * nodeRadius) + (2 * padding),
        height + (2 * nodeRadius) + (2 * padding),
    ].join(' ');

    const layout = d3.sugiyama()
        .size([width, height])
        .layering(layerings[layering])
        .decross(decrossings[decross])
        .coord(coords[coord]);

    const svgSelection = d3.select(parent).append('svg')
        .attr('width', width)
        .attr('height', height)
        .attr('viewBox', viewBox)
    ;

    // const svgSelection = d3.select(svgNode);
    const defs = svgSelection.append('defs'); // For gradients

    // Use computed layout
    const dag = stratify(dagData);
    layout(dag);

    const steps = dag.size();
    const interp = d3.interpolateRainbow;
    const colorMap = {};
    dag.each((node, i) => {
        colorMap[node.id] = interp(i / steps);
    });

    // How to draw edges
    const line = d3.line()
        .curve(d3.curveCatmullRom)
        .x(d => d.x)
        .y(d => d.y);

    // Plot edges
    svgSelection.append('g')
        .selectAll('path')
        .data(dag.links())
        .enter()
        .append('path')
        .attr('d', ({data}) => line(data.points))
        .attr('fill', 'none')
        .attr('stroke-width', 3)
        .attr('stroke', ({source, target}) => {
            const gradId = `${source.id}-${target.id}`;
            const grad = defs.append('linearGradient')
                .attr('id', gradId)
                .attr('gradientUnits', 'userSpaceOnUse')
                .attr('x1', source.x)
                .attr('x2', target.x)
                .attr('y1', source.y)
                .attr('y2', target.y);
            grad.append('stop').attr('offset', '0%').attr('stop-color', colorMap[source.id]);
            grad.append('stop').attr('offset', '100%').attr('stop-color', colorMap[target.id]);
            return `url(#${gradId})`;
        });

    const arrow = d3.symbol().type(d3.symbolTriangle).size(nodeRadius * nodeRadius / 5.0);
    svgSelection.append('g')
        .selectAll('path')
        .data(dag.links())
        .enter()
        .append('path')
        .attr('d', arrow)
        .attr('transform', ({
                                source,
                                target,
                                data
                            }) => {
            const [end, start] = data.points;
            // This sets the arrows the node radius (20) + a little bit (3) away from the node center, on the last line segment of the edge. This means that edges that only span ine level will work perfectly, but if the edge bends, this will be a little off.
            const dx = start.x - end.x;
            const dy = start.y - end.y;
            const scale = nodeRadius * 1.15 / Math.sqrt(dx * dx + dy * dy);
            // This is the angle of the last line segment
            const angle = Math.atan2(-dy, -dx) * 180 / Math.PI + 90;
            return `translate(${end.x + dx * scale}, ${end.y + dy * scale}) rotate(${angle})`;
        })
        .attr('fill', ({target}) => colorMap[target.id])
        .attr('stroke', 'white')
        .attr('stroke-width', 1.5);

    // Select nodes
    const nodes = svgSelection.append('g')
        .selectAll('g')
        .data(dag.descendants())
        .enter()
        .append('g')
        .attr('transform', ({x, y}) => `translate(${x}, ${y})`);

    // Plot node circles
    nodes.append('circle')
        .attr('r', nodeRadius)
        .attr('fill', n => colorMap[n.id]);

    // Add text to nodes
    const links = nodes.append('a').attr('href', d => d.data.link);

    links.append('text')
        .text(d => _.split(d.data.label, "\n")[0])
        .attr('font-weight', 'bold')
        .attr('font-family', 'sans-serif')
        .attr('text-anchor', 'middle')
        .attr('alignment-baseline', 'middle')
        .attr('fill', 'black');

    links.append('text').attr('dy', '1em')
        .text(d => _.split(d.data.label, "\n")[1])
        .attr('font-weight', 'bold')
        .attr('font-family', 'sans-serif')
        .attr('text-anchor', 'middle')
        .attr('alignment-baseline', 'middle')
        .attr('fill', 'black');

    return parent;
};

export default drawDag;
