package com.dz015.expressions.tokens.filterfunction
{
    import com.dz015.expressions.shuntyard.InfixToPostfixConverter;

    import mx.collections.ArrayCollection;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.runners.Parameterized;

    Parameterized;

    [RunWith("org.flexunit.runners.Parameterized")]
    public class FilterFunctionTests
    {

        private var _data:ArrayCollection;

        public function FilterFunctionTests()
        {
        }

        [Before]
        public function createDataProvider():void
        {
            _data = new ArrayCollection();

            for ( var i:uint = 0; i < 10; i++ )
            {
                if ( i > 4 )
                {
                    _data.addItem( new FilterFunctionTestObject( i, i / 2, 1, 2 ) );
                }
                else
                {
                    _data.addItem( new FilterFunctionTestObject( i, i * 2, 2, 1 ) );
                }
            }
        }

        public static function testFilters():Array
        {
            return [
                [ "income=1", 1 ],
                [ "income-outgoing>0", 5 ],
                [ "weighting=2 or weighting=1", 10 ],
                [ "weighting=2 and weighting=1", 0 ],
                [ "income-outgoing>0 and weighting=2", 0 ],
                [ "income-outgoing>0 or weighting=2", 10 ]
            ];
        }

        [Test(dataProvider="testFilters")]
        public function testFilter( filter:String, nPassing:uint ):void
        {

            var converter:InfixToPostfixConverter = new InfixToPostfixConverter( new FilterFunctionTokeniser( new FilterFunctionOperatorTokenFactory() ) );
            var filterer:FilterFunctionVMSimulator = new FilterFunctionVMSimulator( converter.convert( filter ).stack );
            _data.filterFunction = filterer.filterFunction;
            _data.refresh();
            assertEquals( "Data is not filtered correctly", nPassing, _data.length );
        }

    }
}
