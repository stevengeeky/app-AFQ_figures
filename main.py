# -*- coding: utf-8 -*-
"""
Created on Fri Jul 14 14:53:50 2017

@author: lindseykitchell
"""



import glob
import os
import json
import numpy as np
from dipy.viz import window, actor




with open('config.json') as config_json:
    config = json.load(config_json)

pwd = os.getcwd()
os.mkdir(pwd + "/images")
##os.chdir(pwd + "/surfaces")
#
#print('looking for ' + config["AFQ"] + "/tracts/*.json")
print config["AFQ"]
for file in glob.glob(config["AFQ"] + "/tracts/*.json"):
#for file in glob.glob("tracts/*.json"):
    with open(file) as data_file:    
        tract = json.load(data_file)
    bundle = []
    for i in range(len(tract['coords'])):
        templine = np.zeros([len(tract['coords'][i][0][0]),3])
        templine[:,0] = tract['coords'][i][0][0]
        templine[:,1] = tract['coords'][i][0][1]
        templine[:,2] = tract['coords'][i][0][2]
        bundle.append(templine)
        
    renderer = window.Renderer()
#    renderer.clear()
#    renderer.projection('parallel')
    stream_actor = actor.streamtube(bundle, colors=tract['color'],linewidth=1)
#    
#    renderer.set_camera(position=(-176.42, 118.52, 128.20),
#                        focal_point=(113.30, 128.31, 76.56),
#                        view_up=(0.18, 0.00, 0.98))
    renderer.set_camera(position=(-5.58, 84.98, 467.47),
                        focal_point=(-8.92, -16.15, 4.47),
                        view_up=(0.05, 0.98, -0.21))
    renderer.add(stream_actor)
    
#    show_m = window.ShowManager(renderer, size=(800, 700))
#    show_m.initialize()
#    show_m.render()
#    show_m.start()
    window.snapshot(renderer, fname='images/'+tract['name']+'.png', size=(600, 600), offscreen=True,
             order_transparent=False)

#    window.show(renderer, size=(600, 600), reset_camera=False)
#    window.record(renderer, out_path= 'images/'+tract['name']+'.png', size=(600, 600))
    
   

