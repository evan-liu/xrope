package xrope
{
    /**
     * @author eidiot
     */
    public interface IMultiLineLayout extends ILayoutGroup
    {
        /**
         * Align of each line.
         */
        function get lineAlign():String;
        /**
         * @private
         */
        function set lineAlign(value:String):void;
    }
}