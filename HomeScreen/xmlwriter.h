#ifndef XMLWRITER_H
#define XMLWRITER_H

#include <QObject>
#include <QtXml>
#include <QFile>
#include "applicationsmodel.h"

class XmlWriter : public QObject
{
    Q_OBJECT
public:
    explicit XmlWriter(QString filePath, ApplicationsModel &savedData, QObject *parent = nullptr);
    Q_INVOKABLE void saveDataAppMenu();

private:

    void writeXML(QDomDocument document);

    QDomDocument convertData(QList<ApplicationItem> listApp);
    QString filePath;
    ApplicationsModel * model;
};

#endif // XMLWRITER_H
