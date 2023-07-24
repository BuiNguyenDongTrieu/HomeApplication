#include "applicationsmodel.h"
#include <QDebug>

ApplicationItem::ApplicationItem(QString ID, QString title, QString url, QString iconPath)
{
    m_ID = ID;
    m_title = title;
    m_url = url;
    m_iconPath = iconPath;
}

QString ApplicationItem::ID() const
{
    return m_ID;
}

QString ApplicationItem::title() const
{
    return m_title;
}

QString ApplicationItem::url() const
{
    return m_url;
}

QString ApplicationItem::iconPath() const
{
    return m_iconPath;
}

//************************************************************************************************************
//************************************************************************************************************

ApplicationsModel::ApplicationsModel(QObject *parent)
{
    Q_UNUSED(parent)
}

int ApplicationsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant ApplicationsModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    const ApplicationItem &item = m_data[index.row()];
    if (role == IDRole)
        return item.ID();
    else if (role == TitleRole)
        return item.title();
    else if (role == UrlRole)
        return item.url();
    else if (role == IconPathRole)
        return item.iconPath();
    return QVariant();
}

void ApplicationsModel::addApplication(ApplicationItem &item)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data << item;
    endInsertRows();
}

void ApplicationsModel::addApplication(int pos, QString id, QString title, QString url, QString iconPath)
{
    ApplicationItem item(id, title, url, iconPath);
    //qDebug() << pos << " " << id << " " << title << " " << url << " " << iconPath;
    m_savedData[pos] = item;
}

QList<ApplicationItem> ApplicationsModel::getSaveData()
{
    return m_savedData;
}

void ApplicationsModel::cloneData()
{
    for (int i = 0; i < m_data.count(); i++) {
        m_savedData << m_data[i];
    }
}

QHash<int, QByteArray> ApplicationsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IDRole] = "ID";
    roles[TitleRole] = "title";
    roles[UrlRole] = "url";
    roles[IconPathRole] = "iconPath";
    return roles;
}

