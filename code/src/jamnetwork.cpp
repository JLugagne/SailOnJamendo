#include "jamnetwork.h"

JamNetwork::JamNetwork(QQuickItem *parent) :
    QQuickItem(parent)
{
    connect(&m_manager, &QNetworkConfigurationManager::onlineStateChanged, this, &JamNetwork::isOnlineChanged);

    emit isOnlineChanged();
}

bool JamNetwork::isOnline() const
{
    return m_manager.isOnline();
}
