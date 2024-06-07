package com.emergentes.controller;

import com.emergentes.bean.BeanEstudiante;
import com.emergentes.entidades.Estudiante;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            BeanEstudiante dao = new BeanEstudiante();
            
            Estudiante e = new Estudiante();
            int id;
            
            String action = (request.getParameter("action") != null) ? request.getParameter("action") : "view";
            
            switch (action) {
                case "add":
                    request.setAttribute("estudiante", e);
                    request.getRequestDispatcher("frmestudiante.jsp").forward(request, response);
                    break;
                case "edit":
                    
                    id = Integer.parseInt(request.getParameter("id"));
                    try {
                        e = dao.buscar(id);
                    } catch (Exception ex) {
                        System.out.println("Error al obtener registro " + ex.getMessage());
                    }
                    // Colocar como atributo
                    request.setAttribute("estudiante", e);
                    // Transferir el control a frmaviso.jsp
                    request.getRequestDispatcher("frmestudiante.jsp").forward(request, response);
                    break;
                case "delete":
                    id = Integer.parseInt(request.getParameter("id"));
                    System.out.println(id);
                    try {
                        dao.eliminar(id);
                    } catch (Exception ex) {
                        System.out.println("Error al eliminar: " + ex.getMessage());
                    }
                    response.sendRedirect("MainController");
                    break;
                case "view":
                    List<Estudiante> lista = new ArrayList<Estudiante>();
                    try {
                        lista = dao.listarTodos();
                    } catch (Exception ex) {
                        System.out.println("Error al listar "+ex.getMessage());
                    }
                    request.setAttribute("estudiantes", lista);
                    request.getRequestDispatcher("estudiante.jsp").forward(request, response);
                    break;
                default:
                    break;
            }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre =  request.getParameter("nombre");
            String apellidos =  request.getParameter("apellidos");
            String email =  request.getParameter("email");
            String fechaNaciemiento = request.getParameter("fechaNacimiento");
            
            
            BeanEstudiante dao = new BeanEstudiante();
            Estudiante e = new Estudiante();
            
            e.setId(id);
            e.setNombre(nombre);
            e.setApellidos(apellidos);
            e.setEmail(email);
            SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
            Date f = formateador.parse(fechaNaciemiento);
            e.setFechaNacimiento(f);
            
            if (id == 0){
                try {
                    // Nuevo
                    dao.insertar(e);
                } catch (Exception ex) {
                    System.out.println("Error al insertar "+ ex.getMessage());
                }
            }
            else{
                try {
                    // Edición
                    dao.editar(e);
                } catch (Exception ex) {
                    System.out.println("Error al editar" + ex.getMessage());
                }
            }
            response.sendRedirect("MainController");
        } catch (ParseException ex) {
            Logger.getLogger(MainController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void mostrar() {
        BeanEstudiante dao = new BeanEstudiante();
        List<Estudiante> lista = dao.listarTodos();

        for (Estudiante item : lista) {
            System.out.println(item.toString());
        }
    }

    private void editar(int id) {
        try {
            BeanEstudiante dao = new BeanEstudiante();
            Estudiante e = dao.buscar(id);
            
            e.setNombre("CARLA EDITADO");
            e.setApellidos("FLORES EDITADO");
            e.setEmail("carlaeditado@gmail.com");
            SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaNacimiento = formateador.parse("1990-01-01");
            e.setFechaNacimiento(fechaNacimiento);
            
            dao.editar(e);
        } catch (ParseException ex) {
            Logger.getLogger(MainController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void nuevo() {
        try {
            BeanEstudiante dao = new BeanEstudiante();
            Estudiante e = new Estudiante();
            e.setNombre("CARLA");
            e.setApellidos("PEREZ");
            e.setEmail("carlaramosperez@gmail.com");
            
            SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaNacimiento = formateador.parse("1997-04-20");
            e.setFechaNacimiento(fechaNacimiento);
            
            dao.insertar(e);
        } catch (ParseException ex) {
            Logger.getLogger(MainController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void eliminar(int id) {
        BeanEstudiante dao = new BeanEstudiante();
        dao.eliminar(id);
    }

}
