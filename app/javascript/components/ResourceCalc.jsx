import React from "react"
import PropTypes from "prop-types"
import ResourceGraph from "./ResourceGraph";
import Spinner from "./Spinner";
import * as dagOpts from "../packs/drawDag";

class ResourceCalc extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            dagOptions: {
                layering: "Longest Path (fast)",
                decross: "Optimal (slow)",
                coord: "Center (fast)",
            },
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
        if (this.state.amount) {
            $.getJSON(this.props.treePath, {amount: this.state.amount}, dagData => this.setState({dagData}))
        }
    }

    updateDagOptions(optionName) {
        const that = this;
        return e => {
            that.setState({dagOptions: _.set(_.cloneDeep(this.state.dagOptions), optionName, e.target.value)});
        }
    }

    dagOptionsForm() {
        return [
            <select className='form-control col-sm-3' value={this.state.dagOptions.layering}
                    onChange={this.updateDagOptions('layering')}>
                {_.keys(dagOpts.layerings).map(k => <option value={k}>{k}</option>)}
            </select>,
            <select className='form-control col-sm-3' value={this.state.dagOptions.decross}
                    onChange={this.updateDagOptions('decross')}>
                {_.keys(dagOpts.decrossings).map(k => <option value={k}>{k}</option>)}
            </select>,
            <select className='form-control col-sm-3' value={this.state.dagOptions.coord}
                    onChange={this.updateDagOptions('coord')}>
                {_.keys(dagOpts.coords).map(k => <option value={k}>{k}</option>)}
            </select>,
        ];
    }

    render() {
        let graph = <Spinner/>;

        if (this.state.dagData) {
            graph = <ResourceGraph dagData={this.state.dagData} dagOptions={this.state.dagOptions}/>;
        }

        return (
            <React.Fragment>
                <div className='row'>
                    <input type='number' className='form-control col-sm-3' value={this.state.amount}
                           onChange={this.updateAmount.bind(this)}/>
                    {/*{this.dagOptionsForm()}*/}
                </div>
                <div className='row'>
                    <div className='col-sm-12'>
                        {graph}
                    </div>
                </div>
            </React.Fragment>
        );
    }
}

ResourceCalc.propTypes = {
    resourceId: PropTypes.number.isRequired,
    treePath: PropTypes.string.isRequired,
};

export default ResourceCalc
