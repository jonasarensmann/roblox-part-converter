<script lang="ts" setup>
import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';

const canvas = ref<HTMLCanvasElement>();

const props = defineProps({
    parts: {
        type: Array,
        required: true
    }
})

console.log(props.parts)

onMounted(() => {
    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    camera.position.set(50, 0, 0);
    const renderer = new THREE.WebGLRenderer({ canvas: canvas.value });
    renderer.setSize(window.innerWidth, window.innerHeight);

    props.parts.forEach((part: any) => {
        console.log(part);
        const geometry = new THREE.BoxGeometry(part.size.X, part.size.Y, part.size.Z);
        const material = new THREE.MeshBasicMaterial({ color: parseInt(`0x${part.color}`) });
        const cube = new THREE.Mesh(geometry, material);
        cube.position.set(part.position.X, part.position.Y, part.position.Z);
        cube.rotation.set(part.rotation.X, part.rotation.Y, part.rotation.Z);
        scene.add(cube);
    });

    const controls = new OrbitControls(camera, renderer.domElement);

    camera.position.z = 5;

    function animate() {
        requestAnimationFrame(animate);

        controls.update();

        renderer.render(scene, camera);
    }

    animate();
});
</script>

<template>
    <div>
        <canvas ref="canvas"></canvas>
    </div>
</template>