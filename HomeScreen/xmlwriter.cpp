#include "xmlwriter.h"
#include <QDebug>

XmlWriter::XmlWriter(QString filePath, ApplicationsModel &savedData, QObject *parent) : QObject(parent)
{
    QString path = ("/home/trieubnd/Documents/QT_Projects/ĐỒ ÁN CUỐI KHÓA/Sample Functionality-20230412T084319Z-001/Sample Functionality/Code sample/HomeScreen/" + filePath);
    this->filePath = path;
    model = &savedData;
}

void XmlWriter::saveDataAppMenu()
{
    QDomDocument document = convertData(model->getSaveData());
    writeXML(document);
}

QDomDocument XmlWriter::convertData(QList<ApplicationItem> listApp)
{
    QDomDocument document;
    QDomElement root = document.createElement("APPLICATIONS");
    document.appendChild(root);

    for (int i = 0; i < listApp.count(); i++)
    {
        QDomElement app = document.createElement("APP");
        ApplicationItem item = listApp[i];

        app.setAttribute("ID", item.ID());
        root.appendChild(app);
        //*********************************************************************************************************

        QDomElement title = document.createElement("TITLE");
        app.appendChild(title);

        QDomNode str_title = document.createTextNode(item.title());
        title.appendChild(str_title);
        //*********************************************************************************************************

        QDomElement url = document.createElement("URL");
        app.appendChild(url);

        QDomNode str_url = document.createTextNode(item.url());
        url.appendChild(str_url);
        //*********************************************************************************************************

        QDomElement icon_path = document.createElement("ICON_PATH");
        app.appendChild(icon_path);

        QDomNode str_icon_path = document.createTextNode(item.iconPath());
        icon_path.appendChild(str_icon_path);

    }
    return document;
}

void XmlWriter::writeXML(QDomDocument document)
{
    QFile f(filePath);
    if (!f.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qDebug() << "Cannot open file---->XmlWriter";
        return;
    }

    QTextStream stream(&f);
    stream << document.toString();
    f.close();
}




