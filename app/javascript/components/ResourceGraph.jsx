import React from "react";
import PropTypes from "prop-types";
import drawDag from '../packs/drawDag';
import rd3 from 'react-d3-library';

const RD3Component = rd3.Component;

class ResourceGraph extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            d3: null
        };
    }

    componentDidMount() {
        this.updateDag();
        window.addEventListener('resize', this.updateDag.bind(this));
    }

    componentWillUnmount() {
        window.removeEventListener('resize', this.updateDag.bind(this));
    }

    componentDidUpdate(prevProps, prevState, snapshot) {
        if (!_.isEqual(this.props.dagData, prevProps.dagData)
            || !_.isEqual(this.graphConfig(prevProps), this.graphConfig(this.props))) {
            this.updateDag();
        }
    }

    updateDag() {
        let d3 = this.state.d3;
        if (d3) {
            d3.removeChild(d3.firstChild);
        } else {
            d3 = document.createElement('div')
        }
        this.setState({d3: drawDag(d3, this.props.dagData, this.graphConfig())});
    }

    graphConfig(props = this.props) {
        return {
            nodeRadius: props.nodeRadius,
            width: props.width || this.refs.container.clientWidth,
            height: props.height,
            padding: props.padding,
        };
    }

    render() {
        return (
            <div ref='container'>
                <RD3Component data={this.state.d3}/>
            </div>
        );
    }
}

ResourceGraph.propTypes = {
    dagData: PropTypes.array, // TODO spec

    nodeRadius: PropTypes.number,
    width: PropTypes.number,
    height: PropTypes.number,
    padding: PropTypes.number,
};
ResourceGraph.defaultProps = {
    nodeRadius: 50,
    // width: 1100,
    height: 800,
    padding: 10,
};

export default ResourceGraph
