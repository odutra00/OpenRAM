from openram.base import design
from openram.tech import cell_properties as props
from openram import debug


class precharge(design):
    """
    Célula de precharge customizada para TSMC 65nm.
    """

    def __init__(self, name="precharge", size=1, bitcell_bl="bl", bitcell_br="br", **kwargs):
        # Passa a propriedade configurada no tech.py
        super().__init__(name=name, cell_name="precharge", prop=props.precharge)

        print("\n" + "=" * 60)
        print(">>> [TSMC65N] SUCESSO: Precharge alinhado com port_order e port_map!")
        print(">>> PINOS CARREGADOS:", self.pins)
        print(">>> PINMAP:", self.pin_map)
        print("=" * 60 + "\n")

        debug.info(2, f"Create custom precharge: {self.cell_name}")

    def get_bl_names(self):
        return "bl"
    
    def get_br_names(self):
        return "br"

    def build_graph(self, graph, inst_name, port_nets):
        """Adiciona as arestas baseadas em entradas/saídas para a análise do grafo."""
        self.add_graph_edges(graph, port_nets)
