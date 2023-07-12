#ifndef APPLICATIONSMODEL_H
#define APPLICATIONSMODEL_H
#include <QAbstractListModel> 

class ApplicationItem {
public:
    ApplicationItem(QString ID, QString title, QString url, QString iconPath);

    QString ID() const;

    QString title() const;

    QString url() const;

    QString iconPath() const;

private:
    QString m_ID;
    QString m_title;
    QString m_url;
    QString m_iconPath;
};

class ApplicationsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        IDRole = Qt::UserRole + 1,
        TitleRole ,
        UrlRole,
        IconPathRole
    };
    explicit ApplicationsModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    void addApplication(ApplicationItem &item);
    Q_INVOKABLE void addApplication(int pos, QString id, QString title, QString url, QString iconPath);
    QList<ApplicationItem> getSaveData();
    void cloneData();

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<ApplicationItem> m_data;
    QList<ApplicationItem> m_savedData;
};

#endif // APPLICATIONSMODEL_H
