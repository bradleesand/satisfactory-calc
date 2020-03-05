import React from "react";
import PropTypes from "prop-types";
import ReactDOM from "react-dom";
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

    render() {
        return (
            <div>
                <RD3Component data={this.state.d3}/>
            </div>
        )
    }
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
    const parent = document.getElementById('process-tree');
    if (parent) {
        ReactDOM.render(<ResourceGraph/>, parent);
    }
});
