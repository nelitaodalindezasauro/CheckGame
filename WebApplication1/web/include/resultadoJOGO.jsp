<%@page import="model.gpu"%>
<%@page import="model.Jogo"%>
<%@page import="util.ConjuntoResultados"%>
<%@page import="util.MySQL"%>
<%@page import="DAO.gpuDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.JogoDAO"%>

<html>
    <jsp:include page="headerResult.jsp"/>
    <body background="../background.jpg">

        <jsp:include page="menusupResult.jsp"/>

        <div class="container">
            <div class="row-fluid">
                <br><br><div class="pagination">Voce pode precisa de uma das determinadas placas de video para jogar o jogo selecionado:<br>
                    <%
                        String jogo = request.getParameter("dropJOGO");
                        int req;
                        MySQL db = new MySQL();

                        String sql = "select requisito from jogo where nome =\"" + jogo + "\"";
                        ConjuntoResultados linhas = db.executaSelect(sql);
                        while (linhas.next()) {
                            req = (linhas.getInt("requisito"));

                            String sql2 = "select nome from gpu where capacidade >=" + req + " ";
                            ConjuntoResultados linhasas = db.executaSelect(sql2);
                            while (linhasas.next()) {
                                String gpu = (linhasas.getString("nome"));
                                out.print(gpu + "<br>");
                            }
                        }
                    %>
                </div>
                <div class="pagination">
                    <br><br><br><br>
                    Comente esse jogo!
                    <form name="comentarios" action="../bd/cadastroComentario.jsp">
                        <input type="text" autofocus name="comentario" value="">
                        <input type="hidden" name="idJogo" value="<%
                            int idJogo = 0;
                            MySQL pid = new MySQL();
                            String pegarID = "select id from jogo where nome =\"" + jogo + "\"";
                            ConjuntoResultados resultados = pid.executaSelect(pegarID);
                            while (resultados.next()) {
                                idJogo = (resultados.getInt("id"));
                                out.print(idJogo);
                            }
                               %>" />
                        <input type="submit" value="Enviar" />
                    </form>
                </div>
            </div>
            <div class="pagination">
Coment�rios:
<%
MySQL lsc = new MySQL();
                            String comentario = "select comentario from comentarios where idJogo =\"" + idJogo + "\"";
                            ConjuntoResultados result = lsc.executaSelect(comentario);
                            while (result.next()) {
                                String coment = (result.getString("comentario"));
                                out.print("<br>"+coment);
                            }
%>
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>

</html>