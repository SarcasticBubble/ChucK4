// Rachael Nordby -- 2/26/2024 -- Assignment 4
<<< "Rachael Nordby">>>;

SndBuf bass => Pan2 bassPan => dac;

string bass_samples[4];
me.dir()+"/audio/kick_03.wav" => bass_samples[0];
me.dir()+"/audio/kick_01.wav" => bass_samples[1];
me.dir()+"/audio/kick_05.wav" => bass_samples[2];
me.dir()+"/audio/kick_04.wav" => bass_samples[3];

SndBuf snare => Pan2 snarePan => dac;
string snare_samples[2];
me.dir()+"/audio/click_05.wav" => snare_samples[0];
me.dir()+"/audio/snare_04.wav" => snare_samples[1];

SndBuf hiHat => Pan2 hatPan => dac;
SndBuf fx => Pan2 fxPan => dac;

me.dir()+"/audio/hh_01.wav" => hiHat.read;

me.dir()+"/audio/stereo_fx_02.wav" => fx.read;

0.0 => float genGain;
genGain => bass.gain => snare.gain => hiHat.gain;

.45 :: second => dur tempo;
4 => int MOD;



0 => fx.pos;
3 :: second => now;
27::second + now => time stop;
-1.0 => float bassPanning;
while(now < stop)
{
    0 => fx.pos;
    0.4 => fx.gain;
    Math.random2f(0.6, 1.8) => fx.rate;
    1 => fx.loop;
    for (0 => int beat; beat < 20; beat++)
    {
        Math.random2(0,3) => int bassPick;
        Math.random2f(0.2,0.8) => bass.gain;
        bassPanning => bassPan.pan;
        bass_samples[bassPick] => bass.read;
        tempo => now;
        if( beat % MOD == 2 || beat % MOD == 0 )
        {
            Math.random2(0,1) => int snarePick;
            Math.random2f(0.6,1) => snare.gain;
            snare_samples[snarePick] => snare.read;
        }
        Math.random2(0,1) => int shouldHat;
        if(shouldHat == 1)
        {
            0.8 => hiHat.gain;
            0 => hiHat.pos;
        }
       bassPanning + 0.2 => bassPanning;
       if(bassPanning > 1.0)
       {
            -1.0 => bassPanning;
       }
       
    }
}







