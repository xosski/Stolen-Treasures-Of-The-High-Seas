<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:clr="http://schemas.microsoft.com/soap/encoding/clr/1.0" SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
<SOAP-ENV:Body>
<a1:CookieContainer id="ref-1" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_domainTable href="#ref-3"/>
<m_maxCookieSize>4096</m_maxCookieSize>
<m_maxCookies>300</m_maxCookies>
<m_maxCookiesPerDomain>20</m_maxCookiesPerDomain>
<m_count>5</m_count>
<m_fqdnMyDomain id="ref-4"></m_fqdnMyDomain>
</a1:CookieContainer>
<a2:Hashtable id="ref-3" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<LoadFactor>0.72</LoadFactor>
<Version>44</Version>
<Comparer xsi:null="1"/>
<HashCodeProvider xsi:null="1"/>
<HashSize>7</HashSize>
<Keys href="#ref-5"/>
<Values href="#ref-6"/>
</a2:Hashtable>
<SOAP-ENC:Array id="ref-5" SOAP-ENC:arrayType="xsd:anyType[3]">
<item id="ref-7" xsi:type="SOAP-ENC:string">pinterest.com</item>
<item id="ref-8" xsi:type="SOAP-ENC:string">www.pinterest.com</item>
<item id="ref-9" xsi:type="SOAP-ENC:string">.pinterest.com</item>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-6" SOAP-ENC:arrayType="xsd:anyType[3]">
<item href="#ref-10"/>
<item href="#ref-11"/>
<item href="#ref-10"/>
</SOAP-ENC:Array>
<a1:PathList id="ref-10" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_list href="#ref-12"/>
</a1:PathList>
<a1:PathList id="ref-11" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_list href="#ref-13"/>
</a1:PathList>
<a2:SortedList_x002B_SyncSortedList id="ref-12" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_list href="#ref-14"/>
<_root href="#ref-15"/>
<SortedList_x002B_keys href="#ref-16"/>
<SortedList_x002B_values href="#ref-16"/>
<SortedList_x002B__size>0</SortedList_x002B__size>
<SortedList_x002B_version>0</SortedList_x002B_version>
<SortedList_x002B_comparer href="#ref-17"/>
<SortedList_x002B_keyList xsi:null="1"/>
<SortedList_x002B_valueList xsi:null="1"/>
</a2:SortedList_x002B_SyncSortedList>
<a2:SortedList_x002B_SyncSortedList id="ref-13" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_list href="#ref-18"/>
<_root href="#ref-19"/>
<SortedList_x002B_keys href="#ref-16"/>
<SortedList_x002B_values href="#ref-16"/>
<SortedList_x002B__size>0</SortedList_x002B__size>
<SortedList_x002B_version>0</SortedList_x002B_version>
<SortedList_x002B_comparer href="#ref-20"/>
<SortedList_x002B_keyList xsi:null="1"/>
<SortedList_x002B_valueList xsi:null="1"/>
</a2:SortedList_x002B_SyncSortedList>
<a2:SortedList id="ref-14" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<keys href="#ref-21"/>
<values href="#ref-22"/>
<_size>1</_size>
<version>1</version>
<comparer href="#ref-23"/>
<keyList xsi:null="1"/>
<valueList href="#ref-24"/>
</a2:SortedList>
<xsd:anyType id="ref-15">
</xsd:anyType>
<SOAP-ENC:Array id="ref-16" SOAP-ENC:arrayType="xsd:anyType[0]">
</SOAP-ENC:Array>
<a2:Comparer id="ref-17" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<CompareInfo href="#ref-25"/>
</a2:Comparer>
<a2:SortedList id="ref-18" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<keys href="#ref-26"/>
<values href="#ref-27"/>
<_size>1</_size>
<version>1</version>
<comparer href="#ref-23"/>
<keyList xsi:null="1"/>
<valueList href="#ref-28"/>
</a2:SortedList>
<xsd:anyType id="ref-19">
</xsd:anyType>
<a2:Comparer id="ref-20" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<CompareInfo href="#ref-25"/>
</a2:Comparer>
<SOAP-ENC:Array id="ref-21" SOAP-ENC:arrayType="xsd:anyType[16]">
<item id="ref-29" xsi:type="SOAP-ENC:string">/</item>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-22" SOAP-ENC:arrayType="xsd:anyType[16]">
<item href="#ref-30"/>
</SOAP-ENC:Array>
<a1:PathList_x002B_PathListComparer id="ref-23" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
</a1:PathList_x002B_PathListComparer>
<a2:SortedList_x002B_ValueList id="ref-24" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<sortedList href="#ref-14"/>
</a2:SortedList_x002B_ValueList>
<a4:CompareInfo id="ref-25" xmlns:a4="http://schemas.microsoft.com/clr/ns/System.Globalization">
<m_name id="ref-31">vi-VN</m_name>
<win32LCID>0</win32LCID>
<culture>1066</culture>
<m_SortVersion xsi:null="1"/>
</a4:CompareInfo>
<SOAP-ENC:Array id="ref-26" SOAP-ENC:arrayType="xsd:anyType[16]">
<item id="ref-32" xsi:type="SOAP-ENC:string">/</item>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-27" SOAP-ENC:arrayType="xsd:anyType[16]">
<item href="#ref-33"/>
</SOAP-ENC:Array>
<a2:SortedList_x002B_ValueList id="ref-28" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<sortedList href="#ref-18"/>
</a2:SortedList_x002B_ValueList>
<a1:CookieCollection id="ref-30" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_version>0</m_version>
<m_list href="#ref-34"/>
<m_TimeStamp>2017-09-20T14:31:01.6029024+07:00</m_TimeStamp>
<m_has_other_versions>true</m_has_other_versions>
<m_IsReadOnly>true</m_IsReadOnly>
</a1:CookieCollection>
<a1:CookieCollection id="ref-33" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_version>0</m_version>
<m_list href="#ref-35"/>
<m_TimeStamp>2017-09-20T14:31:01.6029024+07:00</m_TimeStamp>
<m_has_other_versions>true</m_has_other_versions>
<m_IsReadOnly>true</m_IsReadOnly>
</a1:CookieCollection>
<a2:ArrayList id="ref-34" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_items href="#ref-36"/>
<_size>4</_size>
<_version>6</_version>
</a2:ArrayList>
<a2:ArrayList id="ref-35" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_items href="#ref-37"/>
<_size>1</_size>
<_version>2</_version>
</a2:ArrayList>
<SOAP-ENC:Array id="ref-36" SOAP-ENC:arrayType="xsd:anyType[4]">
<item href="#ref-38"/>
<item href="#ref-39"/>
<item href="#ref-40"/>
<item href="#ref-41"/>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-37" SOAP-ENC:arrayType="xsd:anyType[4]">
<item href="#ref-42"/>
</SOAP-ENC:Array>
<a1:Cookie id="ref-38" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-43">.pinterest.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2018-08-12T17:14:34.0000000+07:00</m_expires>
<m_name id="ref-44">_auth</m_name>
<m_path id="ref-45">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-08-17T17:14:33.5641396+07:00</m_timeStamp>
<m_value id="ref-46">1</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-47">.pinterest.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-39" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-48">.pinterest.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2018-08-12T17:14:34.0000000+07:00</m_expires>
<m_name id="ref-49">_pinterest_sess</m_name>
<m_path id="ref-50">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-08-17T17:14:33.5641396+07:00</m_timeStamp>
<m_value id="ref-51">&#34;TWc9PSYvNHdOT2xkM3RvY2RRUk5ZM2VxcFdENDdyRWFPKzRyQzlPc0JXcitlVlY0dVFNNkV5dGhqZENmVkVpUEgveTFxQXl5TWc4dGVsbE1MMkl1UWlMK0NnY2dGR3luQmhzUU95dC83cTk1S3ZkZ3RJcWRHTk5qdFpsWmhhQVZaN1NnbE41ZWdKK2VFU0o3dllUVk1MdnU0czBxUC9vWTVuUUJXd0tOUExQVGZxWjJVZ2ZNTGtFSlRrSFVkeVpUL2pWN1l4OUR1dFlMTE91WHNpMVBOcGJBdnl5ZDlROFRWWWZ5Q0ZJM1JzNi81anEwVTRXNXZHZDErZkgrSXc4Uk5xWjllempiTmdzb3lQMytsZHFIWkdkV1dnT3p5ck9jTklOYjgzVURwS29MTVFtN0FxUjhLbUFER2FiQ3JrSDRaRXN2REtxVlZENUFIcTc5a1pTNWUrbDNlN3hWYWNSNzdjNnJEbzZEN3NOWU16UUc0c2t5SEZpbVpMeHNCbHV6QkExUGNlaVRuNVVLZk5Cb28xOWVxMjJvL0FTVWNURkMyRXBXOXlLTnpEU2lzQ1daRUpNZ0Jocjdja0tpdGJOVWhCOU9lODR1VXA3bjRNdEVTR1EwZzhrWk1JTWdkRnA4MGFnU2JzOHZpQkhOQXh1Yz0mdHhGQmh3MWRVNzVHNy81MTc0TUdnNjcxVUc4PQ==&#34;</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-52">.pinterest.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-40" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-53">.pinterest.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2027-08-15T17:14:34.0000000+07:00</m_expires>
<m_name id="ref-54">_b</m_name>
<m_path id="ref-55">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-08-17T17:14:33.5636484+07:00</m_timeStamp>
<m_value id="ref-56">&#34;ASvX09s7g/1G4bdCozPdm+5SH3V4XSU0Cd2rPUpK3KoROS1CbX0igupYJHSwH5HdvD0=&#34;</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-57">.pinterest.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-41" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-58">.pinterest.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2020-08-16T17:14:36.0000000+07:00</m_expires>
<m_name id="ref-59">_pinterest_pfob</m_name>
<m_path id="ref-60">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-08-17T17:14:34.8705107+07:00</m_timeStamp>
<m_value id="ref-61">disabled</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-62">.pinterest.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-42" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-63">www.pinterest.com</m_domain>
<m_domain_implicit>true</m_domain_implicit>
<m_expires>2018-08-16T17:14:34.0000000+07:00</m_expires>
<m_name id="ref-64">csrftoken</m_name>
<m_path id="ref-65">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-08-17T17:14:33.5641396+07:00</m_timeStamp>
<m_value id="ref-66">0hwU7SQctOFeTrBYRc96dBvDi0O5WeN9</m_value>
<m_version>0</m_version>
<m_domainKey href="#ref-4"/>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
</SOAP-ENV:Body>
</SOAP-ENV:Envelope>
