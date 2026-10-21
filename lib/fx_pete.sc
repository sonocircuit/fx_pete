FxPete : FxBase {

    *new { 
        var ret = super.newCopyArgs(nil, \none, (
            frzTime: 0.2,
            frzGate: 0
        ), nil, 0.5);
        ^ret;
    }

    *initClass {
        FxSetup.register(this.new);
    }

    subPath {
        ^"/fx_pete";
    }  

    symbol {
        ^\fxPete;
    }

    addSynthdefs {
        SynthDef(\fxPete, {|inBus, outBus|
            var frzMax = 4;
            var frz = DelayC.ar(LocalIn.ar(2), frzMax, Lag.kr(\frzTime.kr(0.2), 0.02));
            var snd = XFade2.ar(In.ar(inBus, 2), frz, (Lag.kr(\frzGate.kr(0), 0.02) * 2) - 1);
            LocalOut.ar(snd);
            Out.ar(outBus, snd);
        }).add;
    }

}