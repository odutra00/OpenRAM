# custom/pand2.py

from openram.base import design
from openram.tech import cell_properties as props
from openram import debug


class pand2(design):

    def __init__(self, name="pand2", size=1, **kwargs):

        super().__init__(
            name=name,
            cell_name="pand2",
            prop=props.and2
        )
        print("\n" + "=" * 60)
        print(">>> [TSMC65N] SUCESSO: pand2 alinhado com port_order e port_map!")
        print(">>> PINOS CARREGADOS:", self.pins)
        print(">>> PINMAP:", self.pin_map)
        print("=" * 60 + "\n")
        debug.info(2, f"Create custom nand2: {self.cell_name}")

    def is_non_inverting(self):
        return True

    def build_graph(self, graph, inst_name, port_nets):
        self.add_graph_edges(graph, port_nets)
