import environment_8_puzzle as environment
from collections import defaultdict
from queue import PriorityQueue
import heapq
from utils import track
import time

inital_state = environment.initial_state
explored = defaultdict(tuple)
frontier = PriorityQueue()

root_node = environment.Node(state=inital_state,)
frontier.put((root_node.cost, root_node))



def check_frontier(state, current_node):
    f = 0
    for i in frontier.queue:
        # print(i)
        if(i[1].state == state):
            if(i[1].cost > current_node.cost +1):
                i[1].cost = current_node.cost+1
                i[1].parent = current_node     
            
            return True

    return False

@track
def my_func():
    while not frontier.empty():
        current_node = frontier.get()[1]
        if(environment.Node.goal_test(current_node)):

            break

        else:
            explored[   tuple(map(tuple, current_node.state))   ] = 1      # 1 = visited
            possible_states = environment.Node.successor(current_node)
            
            for i in possible_states:
                if (explored[ tuple(map(tuple, i))  ] == 1):
                    continue
                
                else:
                    if (check_frontier(i,current_node)):
                        continue            
                    else:
                        new_node = environment.Node(parent=current_node, state=i, cost=current_node.cost+1,visited =  [*current_node.visited]+[current_node])
                    
                    frontier.put((new_node.cost, new_node))

    final_states = []
    if(current_node.parent != None):
        while (current_node.parent != None):
            final_states.append(list(current_node.state))
            current_node = current_node.parent
            # print()

        final_states.append(inital_state)

        for i in range(len(final_states)-1,-1,-1):
            for j in final_states[i]:
                print(j)
            print()

    else:
        print("No possible path.")



@track
def depth_d(d):

    depth = d
    depth_states = []
    de = []
    qs = []

    while not frontier.empty():
        current_node = frontier.get()[1]

        if(len(current_node.visited) == depth):
            depth_states.append(current_node.state)
            de.append(len(current_node.visited))
            qs.append(frontier.qsize())
            continue

        if(environment.Node.goal_test(current_node)):
            break

        else:
            explored[   tuple(map(tuple, current_node.state))   ] = 1      # 1 = visited
            possible_states = environment.Node.successor(current_node)
            
            for i in possible_states:
                if (explored[ tuple(map(tuple, i))  ] == 1):
                    continue
                
                else:
                    if (check_frontier(i,current_node)):
                        continue            
                    else:
                        new_node = environment.Node(parent=current_node, state=i, cost=current_node.cost+1,visited =  [*current_node.visited]+[current_node])
                    frontier.put((new_node.cost, new_node))


    # print(depth_states)
    p = 0
    for i in depth_states:
        print(de[p])
        for j in i:
            print(j)
        print()
        print()
        p+=1
    print(qs)



if __name__ == '__main__':

    start = time.time()
    depth_d(8)
    print("time = ",time.time()-start)
