<script setup></script>

<template>
  <div class="md:w-1/2 lg:w-2/5">
    <h2 class="text-center text-3xl font-black">Seguimientos Pacientes</h2>

    <p class="text-center text-lg mt-5 mb-10">
      Añade Pacientes y Administra sus <span class="text-indigo-600"> Seguimientos </span>
    </p>

    <form action="" class="bg-white py-10 px-5 rounded-lg shadow-md">
      <div class="mb-5">
        <label for="mascota" class="block text-gray-700 uppercase font-bold"
          >Mascota Paciente</label
        >
        <input
          type="text"
          id="mascota"
          placeholder="Nombre de la mascota"
          class="border-2 border-gray-200 w-full p-2 mt-2 placeholder-gray-400 rounded-md"
        />
      </div>

      <div class="mb-5">
        <label for="propietario" class="block text-gray-700 uppercase font-bold"
          >Nombre Propietario</label
        >
        <input
          type="text"
          id="propietario"
          placeholder="Nombre del propietario"
          class="border-2 border-gray-200 w-full p-2 mt-2 placeholder-gray-400 rounded-md"
        />
      </div>

      <div class="mb-5">
        <label for="email" class="block text-gray-700 uppercase font-bold">Email</label>
        <input
          type="email"
          id="email"
          placeholder="Email del propietario"
          class="border-2 border-gray-200 w-full p-2 mt-2 placeholder-gray-400 rounded-md"
        />
      </div>

      <div class="mb-5">
        <label for="alta" class="block text-gray-700 uppercase font-bold">Alta</label>
        <input
          type="date"
          id="alta"
          class="border-2 border-gray-200 w-full p-2 mt-2 placeholder-gray-400 rounded-md"
        />
      </div>

      <div class="mb-5">
        <label for="sintomas" class="block text-gray-700 uppercase font-bold">Sintomas</label>
        <textarea
          id="sintomas"
          class="border-2 border-gray-200 w-full p-2 mt-2 placeholder-gray-400 rounded-md h-40"
        ></textarea>
      </div>

      <input
        type="submit"
        class="bg-indigo-600 w-full p-3 text-white uppercase font-bold hover:bg-indigo-700 cursor-pointer transition-colors"
        value="Registrar Paciente"
      />
    </form>
  </div>
</template>
