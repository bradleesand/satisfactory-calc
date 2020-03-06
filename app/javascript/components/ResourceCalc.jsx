import React from "react"
import PropTypes from "prop-types"
import ResourceGraph from "./ResourceGraph";
import Spinner from "./Spinner";

class ResourceCalc extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            dagData: null,
            amount: 1
        };
    }

    componentDidMount() {
        this.getDag();
    }

    updateAmount(e) {
        this.setState({amount: e.target.value}, this.getDag.bind(this));
    }

    getDag() {
        $.getJSON(this.props.treePath, {amount: this.state.amount}, dagData => this.setState({dagData}))
    }

    render() {
        let graph = <Spinner/>;

        if (this.state.dagData) {
            graph = <ResourceGraph dagData={this.state.dagData}/>;
        }

        return (
            <React.Fragment>
                <input type={'number'} value={this.state.amount} onChange={this.updateAmount.bind(this)}/>
                {graph}
            </React.Fragment>
        );
    }
}

ResourceCalc.propTypes = {
    resourceId: PropTypes.number.isRequired,
    treePath: PropTypes.string.isRequired,
};

export default ResourceCalc
