import React from "react";
import PropTypes from "prop-types";
import ReactDOM from "react-dom";
import * as d3 from 'd3';
import drawDag from './drawDag';
import rd3 from 'react-d3-library';

const RD3Component = rd3.Component;

class ResourceGraph extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            dagData: $('#process-tree').data('dag'),
            d3: ''
        };
    }

    componentDidMount() {
        this.setState({d3: drawDag(document.createElement('div'), this.state.dagData)});
    }

    example() {
        var node = document.createElement('div');

        var width = 960,
            height = 500;

        var svg = d3.select(node).append("svg")
            .attr("width", width)
            .attr("height", height);

        var defs = svg.append("defs");

        defs.append("clipPath")
            .attr("id", "circle1")
            .append("circle")
            .attr("cx", 350)
            .attr("cy", 200)
            .attr("r", 180);

        defs.append("clipPath")
            .attr("id", "circle2")
            .append("circle")
            .attr("cx", 550)
            .attr("cy", 200)
            .attr("r", 180);

        return node
    }

    render() {
        return (
            <div>
                <RD3Component data={this.state.d3}/>
            </div>
        )
    }

    //
    // render() {
    //     const nodeRadius = this.props.nodeRadius;
    //     const width = this.props.width;
    //     const height = this.props.height;
    //     const padding = this.props.padding;
    //     const viewBox = [
    //         -nodeRadius - padding,
    //         -nodeRadius - padding,
    //         width + (2 * nodeRadius) + (2 * padding),
    //         height + (2 * nodeRadius) + (2 * padding),
    //     ].join(' ');
    //     return (
    //         // <svg ref='svg' width={width} height={height} viewBox={viewBox}/>
    //         <div>Hello Resource Graph</div>
    //     );
    // }
}

ResourceGraph.propTypes = {
    nodeRadius: PropTypes.number,
    width: PropTypes.number,
    height: PropTypes.number,
    padding: PropTypes.number,
};
ResourceGraph.defaultProps = {
    nodeRadius: 50,
    width: 1100,
    height: 800,
    padding: 10,
};

export default ResourceGraph

document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
        <ResourceGraph/>,
        document.getElementById('process-tree')
    )
});
