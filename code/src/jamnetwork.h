#ifndef JAMNETWORK_H
#define JAMNETWORK_H

#include <QQuickItem>
#include <QNetworkConfigurationManager>

class JamNetwork : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(bool isOnline READ isOnline NOTIFY isOnlineChanged)
public:
    explicit JamNetwork(QQuickItem *parent = 0);

signals:
    void isOnlineChanged();

public slots:
    bool isOnline() const;

private:
    QNetworkConfigurationManager m_manager;

};

#endif // JAMNETWORK_H
