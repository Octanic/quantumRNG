namespace Hello {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation GenerateRandomBit() :Result{
        //aloca um qubit
        using(q = Qubit()){
            //coloca o qubit em superposição
            H(q);

            //Agora o qubit tem 50% de chance de ser 0 ou 1.
            //Medir o valor do qubit, redefine-o para o estado zero e retorna o valor medido:
            return MResetZ(q);
        }
    }

    operation SampleRandomNumberInRange(max: Int) : Int{
        mutable output = 0;

        repeat {
            mutable bits = new Result[0];
            for (idxBit in 1..BitSizeI(max)){
                set bits +=[GenerateRandomBit()];
            }
            set output = ResultArrayAsInt(bits);

        } until (output <= max);

        return output;
    }

    @EntryPoint()
    operation SampleRandomNumber() : Int{
        let max = 50;
        Message($"Mostrando um número aleatório entre 0 e {max}");

        return SampleRandomNumberInRange(max);
    }
}

