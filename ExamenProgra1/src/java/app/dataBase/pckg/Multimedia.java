package app.dataBase.pckg;

public class Multimedia {
    private String descripcion;
    private String url;
    private String titulo;
    private String tipo;

    //aqui estan los atributos que se almacenan en multimedia
    public Multimedia(String descripcion, String url, String titulo, String tipo) {
        this.descripcion = descripcion;//inicialiiza la descripcion q
        this.url = url;//inicialiiza el url
        this.titulo = titulo; //inicialiiza el titulo 
        this.tipo = tipo; //inicialiiza el tipo
    }

    //y los metodos getter y setter que es para obtener y establecer cada uno 
    
    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
}
