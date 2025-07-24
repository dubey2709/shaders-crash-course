import * as THREE from 'three'
import { addPass, useCamera, useGui, useRenderSize, useScene, useTick } from './render/init.js'
// import postprocessing passes
import { SavePass } from 'three/examples/jsm/postprocessing/SavePass.js'
import { ShaderPass } from 'three/examples/jsm/postprocessing/ShaderPass.js'
import { BlendShader } from 'three/examples/jsm/shaders/BlendShader.js'
import { CopyShader } from 'three/examples/jsm/shaders/CopyShader.js'
import { UnrealBloomPass } from 'three/examples/jsm/postprocessing/UnrealBloomPass.js'

import vertexShader from './shaders/vertex.glsl'
import fragmentShader from './shaders/fragment.glsl'

import vertexPars from './shaders/vertex_pars.glsl'
import vertexMain from './shaders/vertex_main.glsl'
import fragmentPars from './shaders/fragment_pars.glsl'
import fragmentMain from './shaders/fragment_main.glsl'

import colorfulTexture from './images/image.jpg'

const startApp = () => {
  const scene = useScene()
  const camera = useCamera()
  const gui = useGui()
  const { width, height } = useRenderSize()

  // settings
  const MOTION_BLUR_AMOUNT = 0.725

  // lighting
  const dirLight = new THREE.DirectionalLight('#526cff', 0.6)
  dirLight.position.set(2, 2, 2)

  const ambientLight = new THREE.AmbientLight('#4255ff', 0.5)
  scene.add(dirLight, ambientLight)




  // meshes
  const geometry = new THREE.IcosahedronGeometry(1,400)
  // console.log(geometry);
  const material = new THREE.MeshStandardMaterial({
    onBeforeCompile: (shader) => {
      material.userData.shader = shader
      shader.uniforms.uTime = {value : 0}
      
      const parseVertexString = /* glsl */'#include <displacementmap_pars_vertex>'
      shader.vertexShader = shader.vertexShader.replace(
      parseVertexString, 
      parseVertexString + vertexPars)

      const mainVertexString = /* glsl */'#include <displacementmap_vertex>'
      shader.vertexShader = shader.vertexShader.replace(
      mainVertexString, 
      mainVertexString + vertexMain)

      console.log(shader.vertexShader)

      console.log(shader.fragmentShader)

      const mainFragmentString = /* glsl */'#include <normal_fragment_maps>'
      shader.fragmentShader = shader.fragmentShader.replace(
        mainFragmentString,
        mainFragmentString + fragmentMain)

      const parseFragmentString = /* glsl */'#include <bumpmap_pars_fragment>'
      shader.fragmentShader = shader.fragmentShader.replace(
        parseFragmentString,
        parseFragmentString + fragmentPars)
    } 
  })

  console.log(material);

  const ico = new THREE.Mesh(geometry, material)
  scene.add(ico)

  // ico.position.set(0,0,-5);









  // GUI
  const cameraFolder = gui.addFolder('Camera')
  cameraFolder.add(camera.position, 'z', 0, 10)
  cameraFolder.open()

  // postprocessing
  const renderTargetParameters = {
    minFilter: THREE.LinearFilter,
    magFilter: THREE.LinearFilter,
    stencilBuffer: false,
  }

  // post-processing
  addPass(new UnrealBloomPass(new THREE.Vector2(width,height), 0.7, 0.4, 0.4))

  useTick(({ timestamp, timeDiff }) => {
    const time = timestamp / 5000;
    material.userData.shader.uniforms.uTime.value = time;
  })
}

export default startApp
