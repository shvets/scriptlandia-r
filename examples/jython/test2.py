"""\
A simple demonstration of creating a swing tree widget from a
Python dictionary.
"""
import java
import javax
from pawt import swing
from pawt import awt

sampleData = {
  'PyObject': {
        'PyInteger':None,
        'PyFloat':None,
        'PyComplex':None,
        'PySequence': {
          'PyArray':None,
          'PyList':None,
          'PyTuple':None,
          'PyString':None,
        },
        'PyClass': {
          'PyJavaClass':None,
        },
  },
  'sys':None,
  'Py':None,
  'PyException':None,
  '__builtin__':None,
  'ThreadState':None,
}
Node = swing.tree.DefaultMutableTreeNode
def addNode(tree, key, value):
  node = Node(key)
  tree.add(node)
  if value is not None:
    addLeaves(node, value.items())
def addLeaves(node, items):
  items.sort()
  for key, value in items:
    addNode(node, key, value)
def makeTree(name, data):
  tree = Node("Sample Tree")
  addLeaves(tree, data.items())
  return swing.JTree(tree)
def exit(e): 
  java.lang.System.exit(0)
if __name__ == '__main__':
  tree = makeTree('Some JPython Classes', sampleData)
  button = swing.JButton('Close Me!', actionPerformed=exit)
  f = swing.JFrame("GridBag Layout Example");
  p = swing.JFrame.getContentPane(f)
  gb = awt.GridBagLayout()
  p.setLayout(gb)
  
  c = awt.GridBagConstraints();
  c.weightx = 1.0;
  c.fill = awt.GridBagConstraints.BOTH;
  
  gb.setConstraints(tree, c);
  c.gridx = 0;
  c.gridy = awt.GridBagConstraints.RELATIVE;
  gb.setConstraints(button, c);
  p.add(tree)
  p.add(button)
  f.pack();
  f.setSize(f.getPreferredSize());
  f.show();

java.lang.Thread.currentThread().join();