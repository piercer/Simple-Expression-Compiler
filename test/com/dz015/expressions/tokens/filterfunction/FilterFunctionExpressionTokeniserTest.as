package com.dz015.expressions.tokens.filterfunction
{
    import com.dz015.expressions.tokens.*;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertTrue;

    public class FilterFunctionExpressionTokeniserTest
    {

        private var _tokeniser:IExpressionTokeniser;

        public function FilterFunctionExpressionTokeniserTest()
        {
        }

        [Before]
        public function setup():void
        {
            _tokeniser = new FilterFunctionTokeniser( new FilterFunctionOperatorTokenFactory() );
        }

        [Test]
        public function testSimpleString():void
        {
            var result:Vector.<Token> = _tokeniser.tokenise( "2" );
            assertEquals( "Wrong number of tokens returned with simple string", 1, result.length );
            assertEquals( "Wrong token value returned with simple string", "2", result[0].value );
            assertEquals( "Wrong token type returned with simple string", Token.LITERAL, result[0].type );
        }

        [Test]
        public function testBinaryOperations():void
        {
            var result:Vector.<Token> = _tokeniser.tokenise( "2+3-yVal" );
            assertEquals( "Wrong number of tokens returned with simple string", 5, result.length );
            assertEquals( "Wrong token returned with simple string", "2", result[0].value );
            assertEquals( "Wrong token type returned with simple string", Token.LITERAL, result[0].type );
            assertEquals( "Wrong token returned with simple string", "+", result[1].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[1].type );
            assertEquals( "Wrong token returned with simple string", "3", result[2].value );
            assertEquals( "Wrong token type returned with simple string", Token.LITERAL, result[2].type );
            assertEquals( "Wrong token returned with simple string", "-", result[3].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[3].type );
            assertEquals( "Wrong token returned with simple string", "yVal", result[4].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[4].type );
        }

        [Test]
        public function testBigWords():void
        {
            var result:Vector.<Token> = _tokeniser.tokenise( "apple/orange" );
            assertEquals( "Wrong number of tokens returned with simple string", 3, result.length );
            assertEquals( "Wrong token value returned with simple string", "apple", result[0].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[0].type );
            assertEquals( "Wrong token value returned with simple string", "/", result[1].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[1].type );
            assertEquals( "Wrong token value returned with simple string", "orange", result[2].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[2].type );
        }

        [Test]
        public function testFunctions():void
        {
            var result:Vector.<Token> = _tokeniser.tokenise( "y+3*sin(x)" );
            assertEquals( "Wrong number of tokens returned with simple string", 8, result.length );
            assertEquals( "Wrong token value returned with simple string", "y", result[0].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[0].type );
            assertEquals( "Wrong token value returned with simple string", "+", result[1].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[1].type );
            assertEquals( "Wrong token value returned with simple string", "3", result[2].value );
            assertEquals( "Wrong token type returned with simple string", Token.LITERAL, result[2].type );
            assertEquals( "Wrong token value returned with simple string", "*", result[3].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[3].type );
            assertEquals( "Wrong token value returned with simple string", "sin", result[4].value );
            assertEquals( "Wrong token type returned with simple string", Token.FUNCTION, result[4].type );
            assertEquals( "Wrong token value returned with simple string", "(", result[5].value );
            assertEquals( "Wrong token type returned with simple string", Token.LEFT_BRACKET, result[5].type );
            assertEquals( "Wrong token value returned with simple string", "x", result[6].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[6].type );
            assertEquals( "Wrong token value returned with simple string", ")", result[7].value );
            assertEquals( "Wrong token type returned with simple string", Token.RIGHT_BRACKET, result[7].type );
        }

        [Test]
        public function testGreaterThan():void
        {
            var result:Vector.<Token> = _tokeniser.tokenise( "y>3" );
            assertEquals( "Wrong number of tokens returned with simple string", 3, result.length );
            assertEquals( "Wrong token value returned with simple string", "y", result[0].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[0].type );
            assertEquals( "Wrong token value returned with simple string", ">", result[1].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[1].type );
            assertEquals( "Wrong token value returned with simple string", "3", result[2].value );
            assertEquals( "Wrong token type returned with simple string", Token.LITERAL, result[2].type );
        }

        [Test]
        public function testLessThan():void
        {
            var result:Vector.<Token> = _tokeniser.tokenise( "y<3" );
            assertEquals( "Wrong number of tokens returned with simple string", 3, result.length );
            assertEquals( "Wrong token value returned with simple string", "y", result[0].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[0].type );
            assertEquals( "Wrong token value returned with simple string", "<", result[1].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[1].type );
            assertEquals( "Wrong token value returned with simple string", "3", result[2].value );
            assertEquals( "Wrong token type returned with simple string", Token.LITERAL, result[2].type );
        }

        [Test]
        public function testLessThanOrEquals():void
        {
            var result:Vector.<Token> = _tokeniser.tokenise( "y<=3" );
            assertEquals( "Wrong number of tokens returned with simple string", 3, result.length );
            assertEquals( "Wrong token value returned with simple string", "y", result[0].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[0].type );
            assertEquals( "Wrong token value returned with simple string", "<=", result[1].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[1].type );
            assertEquals( "Wrong token value returned with simple string", "3", result[2].value );
            assertEquals( "Wrong token type returned with simple string", Token.LITERAL, result[2].type );
        }

        [Test]
        public function testGreaterThanOrEquals():void
        {
            var result:Vector.<Token> = _tokeniser.tokenise( "y>=3" );
            assertEquals( "Wrong number of tokens returned with simple string", 3, result.length );
            assertEquals( "Wrong token value returned with simple string", "y", result[0].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[0].type );
            assertEquals( "Wrong token value returned with simple string", ">=", result[1].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[1].type );
            assertEquals( "Wrong token value returned with simple string", "3", result[2].value );
            assertEquals( "Wrong token type returned with simple string", Token.LITERAL, result[2].type );
        }

        [Test]
        public function testStringLiteral():void
        {
            var result:Vector.<Token> = _tokeniser.tokenise( "y='c'" );
            assertEquals( "Wrong number of tokens returned with simple string", 3, result.length );
            assertEquals( "Wrong token value returned with simple string", "y", result[0].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[0].type );
            assertEquals( "Wrong token value returned with simple string", "=", result[1].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[1].type );
            assertEquals( "Wrong token value returned with simple string", "c", result[2].value );
            assertEquals( "Wrong token type returned with simple string", Token.LITERAL, result[2].type );
        }

        [Test]
        public function testNotEquals():void
        {
            var result:Vector.<Token> = _tokeniser.tokenise( "y!='c'" );
            assertEquals( "Wrong number of tokens returned with simple string", 3, result.length );
            assertEquals( "Wrong token value returned with simple string", "y", result[0].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[0].type );
            assertEquals( "Wrong token value returned with simple string", "!=", result[1].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[1].type );
            assertEquals( "Wrong token value returned with simple string", "c", result[2].value );
            assertEquals( "Wrong token type returned with simple string", Token.LITERAL, result[2].type );
        }

        [Test]
        public function testBooleans():void
        {
            var result:Vector.<Token> = _tokeniser.tokenise( "x=true" );
            assertEquals( "Wrong number of tokens returned with simple string", 3, result.length );
            assertEquals( "Wrong token value returned with simple string", "x", result[0].value );
            assertEquals( "Wrong token type returned with simple string", Token.SYMBOL, result[0].type );
            assertEquals( "Wrong token value returned with simple string", "=", result[1].value );
            assertEquals( "Wrong token type returned with simple string", Token.OPERATOR, result[1].type );
            assertEquals( "Wrong token value returned with simple string", true, result[2].value );
            assertTrue( result[2].value === true );
            assertEquals( "Wrong token type returned with simple string", Token.LITERAL, result[2].type );
        }

    }
}
