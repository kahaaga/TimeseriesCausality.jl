"""
    DiscreteSystemModel{T, N}

An abstract type that represents a set of model parameters of type T for a discrete dynamical system
consisting of `N` variables.

As a minimum, such types always include a field `dt` (an integer giving the sampling time step, which 
is the `dt` argument to `DynamicalSystems.trajectory`) and a field `ui` field (giving the initial 
condition). Hence, we define a discrete model system by (1) its parameters, (2) its initial condition, 
(3) its sampling step (always an integer).

Concrete subtypes must implement the following methods:

- **[`DiscreteDynamicalSystem(x::DiscreteSystemModel)`](@ref)**: Create a 
    `DiscreteDynamicalSystem` from the model.
- **[`get_dt`](@ref)**: Returns the time step.
- **[`get_ui`](@ref)**: Returns the initial condition.
- **[`get_nvars`](@ref)**: Returns the number of variables.
- **[`interaction_matrix`](@ref)**: Returns the interaction matrix for the model (respecting the 
    coupling parameter for that particular model).

Concrete subtypes *may* implement the following methods:

- **[`rand`](@ref)**. If implemented for a discrete system model of type `SM`, 
    returns an instance of the model with randomised parameters.
"""
abstract type DiscreteSystemModel{T, N} <: AbstractSystemModel{T, N} end 


""" 
    DiscreteDynamicalSystem(x::ContinuousSystemModel) -> DiscreteDynamicalSystem

Convert a system model to a `ContinuousDynamicalSystem` by connecting 
its equations of motion to it parameters.
"""
DiscreteDynamicalSystem(x::DiscreteSystemModel)
