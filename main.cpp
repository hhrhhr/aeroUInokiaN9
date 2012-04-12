#include <QtGui/QApplication>
#include <QGraphicsObject>
#include "qmlapplicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.setMainQmlFile(QLatin1String("qml/aeroUInokia/mainLoader.qml"));

    QGraphicsObject *item = viewer.rootObject();
    QObject::connect(item, SIGNAL(loadCompleted()), &viewer, SLOT(setOrientationAuto()));

    viewer.showExpanded();

    return app->exec();
}

