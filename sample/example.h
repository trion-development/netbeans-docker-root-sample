/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   example.h
 * Author: karsten
 *
 * Created on 8. Oktober 2015, 15:41
 */

#ifndef EXAMPLE_H
#define EXAMPLE_H

#include <TF1.h>
#include <TCanvas.h>
#include <TRandom.h>
#include <TGFrame.h>
#include <TRootEmbeddedCanvas.h>

class TGWindow;
class TGMainFrame;
class TRootEmbeddedCanvas;

class MyMainFrame : public TGMainFrame {
private:
   TRootEmbeddedCanvas *fEcanvas;
public:
   MyMainFrame(const TGWindow *p, UInt_t w, UInt_t h);

   virtual ~MyMainFrame() {
      Cleanup();
   }

   void DoDraw() {
      // Draws function graphics in randomly choosen interval
      TF1 *f1 = new TF1("f1", "sin(x)/x", 0, gRandom->Rndm()*10);
      f1->SetLineWidth(3);
      f1->Draw();
      TCanvas *fCanvas = fEcanvas->GetCanvas();
      fCanvas->cd();
      fCanvas->Update();
      fCanvas->SaveAs("ex.pdf");

   }
   ClassDef(MyMainFrame, 0)
};


#endif /* EXAMPLE_H */

