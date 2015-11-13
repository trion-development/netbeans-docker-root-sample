#include <TApplication.h>
#include <TCanvas.h>
#include <TF1.h>
#include <TRandom.h>
#include <TRandom3.h>
#include "simple.h"

void MyApp::DoDraw() {
    gRandom = new TRandom3(0);
    TCanvas* c = new TCanvas("newC", "newC", 200, 200);
    TF1 *f1 = new TF1("f1", "sin(x)/x", 0, gRandom->Rndm()*10);
    f1->SetLineWidth(3);
    f1->Draw();
    c->SaveAs("ex.pdf");
}

int main(int argc, char **argv) {
    MyApp* app = new MyApp(200, 200);
    app->DoDraw();
    return 0;
}