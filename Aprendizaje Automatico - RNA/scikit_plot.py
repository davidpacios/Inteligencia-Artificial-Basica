"""scikit_plot.py: Plot scikit-learn MLPs"""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from matplotlib import pyplot as plt
import numpy as np
from math import cos, sin, atan

__author__ = "Lorenzo Vaquero Otal"
__credits__ = ["Lorenzo Vaquero Otal"]
__date__ = "2021"
__version__ = "1.0.0"
__maintainer__ = "Lorenzo Vaquero Otal"
__contact__ = "lorenzo.vaquero.otal@usc.es"
__status__ = "Prototype"


# Thanks to https://stackoverflow.com/a/37366154
# This imitates neuralnet's plot() from R
# Don't take this code as a reference, as it is ugly.

class Neuron():
    def __init__(self, x, y, coef=None, intercept=None, is_bias=False):
        self.x = x
        self.y = y
        self.coef = coef
        self.intercept = intercept
        self.is_bias = is_bias

    def draw(self, neuron_radius):
        if self.is_bias:
            color = 'blue'
        else:
            color = 'black'
        circle = plt.Circle((self.x, self.y), radius=neuron_radius, fill=False, color=color)
        plt.gca().add_patch(circle)
        
        if self.is_bias:
            plt.gca().text(self.x, self.y, '1', color='blue', fontsize='xx-large')


class Layer():
    def __init__(self, network, number_of_neurons, number_of_neurons_in_widest_layer, coefs=None, intercepts=None, is_last=False):
        self.vertical_distance_between_layers = 6
        self.horizontal_distance_between_neurons = 2
        self.neuron_radius = 0.5
        self.number_of_neurons_in_widest_layer = number_of_neurons_in_widest_layer
        self.previous_layer = self.__get_previous_layer(network)
        self.y = self.__calculate_layer_y_position()
        self.is_last = is_last
        self.neurons = self.__intialise_neurons(number_of_neurons, coefs=coefs, intercepts=intercepts, is_last=self.is_last)

    def __intialise_neurons(self, number_of_neurons, coefs=None, intercepts=None, is_last=False):
        neurons = []
        x = self.__calculate_left_margin_so_layer_is_centered(number_of_neurons)
        for iteration in range(number_of_neurons):
            if not is_last and iteration == number_of_neurons-1:
                coef = None
                intercept = None
                is_bias = True
            else:
                coef = coefs[:, iteration] if coefs is not None else None
                intercept = intercepts[iteration] if intercepts is not None else None
                is_bias = False
            neuron = Neuron(x, self.y, coef=coef, intercept=intercept, is_bias=is_bias)
            neurons.append(neuron)
            x += self.horizontal_distance_between_neurons
        return neurons

    def __calculate_left_margin_so_layer_is_centered(self, number_of_neurons):
        return self.horizontal_distance_between_neurons * (self.number_of_neurons_in_widest_layer - number_of_neurons) / 2

    def __calculate_layer_y_position(self):
        if self.previous_layer:
            return self.previous_layer.y + self.vertical_distance_between_layers
        else:
            return 0

    def __get_previous_layer(self, network):
        if len(network.layers) > 0:
            return network.layers[-1]
        else:
            return None

    def __line_between_two_neurons(self, neuron1, neuron2, coef_id=0):
        if neuron2.is_bias:
            color = 'blue'
        else:
            color = 'black'
        
        angle = atan((neuron2.x - neuron1.x) / float(neuron2.y - neuron1.y))
        x_adjustment = self.neuron_radius * sin(angle)
        y_adjustment = self.neuron_radius * cos(angle)
        line = plt.arrow(neuron2.x + x_adjustment, neuron2.y + y_adjustment,
                         neuron1.x - x_adjustment - (neuron2.x + x_adjustment), neuron1.y - y_adjustment - (neuron2.y + y_adjustment),
                         color=color, head_width=0.25, head_length=0.5, length_includes_head=True)
        plt.gca().add_line(line)
        
        # Calculate the angle of the line
        fig_x, fig_y = plt.gcf().get_size_inches()
        pB = np.array((neuron2.x, neuron2.y))
        pA = np.array((neuron1.x, neuron1.y))
        dx, dy = pA-pB
        # --- retrieve the 'abstract' size
        x_min, x_max = plt.xlim()
        y_min, y_max = plt.ylim()
        # --- apply the proportional conversion
        Dx = dx * fig_x / (x_max - x_min)
        Dy = dy * fig_y / (y_max - y_min)
        # --- convert gaps into an angle
        angle = (180/np.pi)*np.arctan( Dy / (Dx + 1e-8))
        
        weight = neuron1.coef
        
        if weight is not None:
            plt.gca().text((1.25*neuron1.x + 0.75*neuron2.x) / 2.0 - 0.1,
                              (1.25*neuron1.y + 0.75*neuron2.y) / 2.0,
                              '{:.4f}'.format(weight[coef_id]), rotation=angle,
                              color=color)

    def draw(self, layerType=0):
        for i, neuron in enumerate(self.neurons):
            neuron.draw( self.neuron_radius )
            if not self.is_last and i == len(self.neurons) - 1:
                continue
            
            if self.previous_layer:
                for coef_id, previous_layer_neuron in enumerate(self.previous_layer.neurons):
                    self.__line_between_two_neurons(neuron, previous_layer_neuron, coef_id=coef_id)
        # write Text
        x_text = self.number_of_neurons_in_widest_layer * self.horizontal_distance_between_neurons
        if layerType == 0:
            plt.text(x_text, self.y, 'Input Layer', fontsize = 12)
        elif layerType == -1:
            plt.text(x_text, self.y, 'Output Layer', fontsize = 12)
        else:
            plt.text(x_text, self.y, 'Hidden Layer '+str(layerType), fontsize = 12)

class NeuralNetwork():
    def __init__(self, number_of_neurons_in_widest_layer):
        self.number_of_neurons_in_widest_layer = number_of_neurons_in_widest_layer
        self.layers = []
        self.layertype = 0

    def add_layer(self, number_of_neurons, coefs=None, intercepts=None, is_last=False):
        layer = Layer(self, number_of_neurons, self.number_of_neurons_in_widest_layer,
                      coefs=coefs, intercepts=intercepts, is_last=is_last)
        self.layers.append(layer)

    def draw(self, figsize=None):
        plt.figure(figsize=figsize)
        for i in range( len(self.layers) ):
            layer = self.layers[i]
            if i == len(self.layers)-1:
                i = -1
            layer.draw( i )
        plt.axis('scaled')
        plt.axis('off')
        plt.title( 'Neural Network architecture', fontsize=15 )
        plt.show()

class DrawNN():   
    def __init__(self, neural_network):
        self.model = neural_network
        
        layer_sizes = []
        for i in range(self.model.n_layers_ - 1):
            layer_sizes.append(len(self.model.coefs_[i]))
        
        layer_sizes.append(self.model.n_outputs_)
        self.neural_network = layer_sizes
        
        self.coefs = self.model.coefs_
        self.intercepts = self.model.intercepts_

    def draw(self, figsize=None):
        widest_layer = max( self.neural_network )
        network = NeuralNetwork(widest_layer)
        for i, l in enumerate(self.neural_network):
            coefs = self.coefs[i-1] if i > 0 else None
            intercepts = self.intercepts[i-1] if i > 0 else None
            is_last = i == len(self.neural_network) - 1
            if not is_last:  # We add an "artificial" neuron (bias)
                l = l + 1
            if coefs is not None:
                coefs = np.append(coefs, np.expand_dims(intercepts, axis=0), axis=0)
            
            
            network.add_layer(l, coefs=coefs, intercepts=None, is_last=is_last)
        network.draw(figsize=figsize)

def plotMLP(model, figsize=None):
    network = DrawNN(model)
    network.draw(figsize=figsize)
    
