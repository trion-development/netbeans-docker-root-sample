#ifndef SIMPLE_H
#define SIMPLE_H
class MyApp {
public:
    MyApp(UInt_t w, UInt_t h){}
    virtual ~MyApp() {}
    void DoDraw();
    ClassDef(MyApp, 0)
};
#endif /* SIMPLE_H */
