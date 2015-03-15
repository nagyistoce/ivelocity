# iVelocity #

## What is iVelocity ##

iVelocity is a **light template engine** that support **iOS and VTL**.

It will useful to generate a html from template file and NSDictionary data in iOS.
And JSON can easy to become a NSDictionary to use.
Now, the iOS App is more easy than ever!

[iVelocity Data Flow](http://b213.photo.store.qq.com/psu?/d78acf19-b696-4715-93c8-84d318954d97/kq9rA54xJVR1NgBljsC9oB1zLrrNtO0m80BVHLzWSL4!/b/Yd5o*n5wHAAAYkBzAX8VHQAA)

## Test Example ##
```
Template:  <test1>#set($b[0]=1)</test1><test2>#set($b[1]=2)</test2>
Render Result: <test1></test1><test2></test2>

Template: <test3>#foreach($a in $b) $a #end</test3>
Render Result: <test3> 1  2 </test3>

Template:  <test3>#if(1)<yes>#else<no>#end</test3>
Render Result: <test3><yes></test3>
```

## How to use in Your Project ##

> Use:
```
      - (int) initWithTemplate:(NSString *)temp  // VTL String
                              withKey:(NSString *)key    // VTL String Name, used for cache.
			  forceFlush:(BOOL)mustflush; // YES: parse the VTL even if cache match!
                                                                       // NO: used the cached object if match.
```
> to load a VTL(velocity template file).

```
     - (int) initWithFile:(NSString *)filename  // xxx.vm file that support VTL
                forceFlush:(BOOL)mustflush;      // YES: parse the VTL even if cache match!
                                                                  // NO: used the cached object if match.
```
to load a VTL from File base on resources in iOS.

> Then generate render result by:
```
     - (RenderStatus) renderBlockWithData:(NSMutableDictionary *)dictionaryData 
							returnString:(NSMutableString *)strResult;
```
> the result is return by strResult. and the data is saved or modified in dictionaryData.

> If you has confused with the syntax of template file that parsed by iVelocity, can use
> print method to print the syntax structure in Console.
```
    - (void) print;
```

check the version of iVelocity.
```
   + (NSString *) version;
```
## How to Download Code ##

```
svn checkout http://ivelocity.googlecode.com/svn/trunk/ ivelocity-read-only
```

## Snap Shot ##

[Test App Snap Shot](http://b210.photo.store.qq.com/psu?/d78acf19-b696-4715-93c8-84d318954d97/X6DiShPxpaLyl5PhWZ7wzTlIndALC.blH*efDd5n2fE!/b/YSWtNH2NnwAAYvIbMH0InwAA)

## Q/A ##

(1) Q:If the data is from more than one dictionary?
> A: iVelocity support more than one dictionary. for example:
> VTL: $a,$b,$c
> call render with dictionary1(a,b)
> call render with dictionary2(a,c)
> the result $a use dictionary2, but $b use dictionary1, $c use dictionary2.

