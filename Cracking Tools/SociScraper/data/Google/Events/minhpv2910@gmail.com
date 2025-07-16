<SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:clr="http://schemas.microsoft.com/soap/encoding/clr/1.0" SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
<SOAP-ENV:Body>
<a1:CookieContainer id="ref-1" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_domainTable href="#ref-3"/>
<m_maxCookieSize>4096</m_maxCookieSize>
<m_maxCookies>300</m_maxCookies>
<m_maxCookiesPerDomain>20</m_maxCookiesPerDomain>
<m_count>25</m_count>
<m_fqdnMyDomain id="ref-4"></m_fqdnMyDomain>
</a1:CookieContainer>
<a2:Hashtable id="ref-3" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<LoadFactor>0.72</LoadFactor>
<Version>45</Version>
<Comparer xsi:null="1"/>
<HashCodeProvider xsi:null="1"/>
<HashSize>17</HashSize>
<Keys href="#ref-5"/>
<Values href="#ref-6"/>
</a2:Hashtable>
<SOAP-ENC:Array id="ref-5" SOAP-ENC:arrayType="xsd:anyType[7]">
<item id="ref-7" xsi:type="SOAP-ENC:string">.youtube.com</item>
<item id="ref-8" xsi:type="SOAP-ENC:string">google.com</item>
<item id="ref-9" xsi:type="SOAP-ENC:string">google.com.vn</item>
<item id="ref-10" xsi:type="SOAP-ENC:string">.google.com</item>
<item id="ref-11" xsi:type="SOAP-ENC:string">accounts.google.com</item>
<item id="ref-12" xsi:type="SOAP-ENC:string">.google.com.vn</item>
<item id="ref-13" xsi:type="SOAP-ENC:string">youtube.com</item>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-6" SOAP-ENC:arrayType="xsd:anyType[7]">
<item href="#ref-14"/>
<item href="#ref-15"/>
<item href="#ref-16"/>
<item href="#ref-15"/>
<item href="#ref-17"/>
<item href="#ref-16"/>
<item href="#ref-14"/>
</SOAP-ENC:Array>
<a1:PathList id="ref-14" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_list href="#ref-18"/>
</a1:PathList>
<a1:PathList id="ref-15" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_list href="#ref-19"/>
</a1:PathList>
<a1:PathList id="ref-16" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_list href="#ref-20"/>
</a1:PathList>
<a1:PathList id="ref-17" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_list href="#ref-21"/>
</a1:PathList>
<a2:SortedList_x002B_SyncSortedList id="ref-18" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_list href="#ref-22"/>
<_root href="#ref-23"/>
<SortedList_x002B_keys href="#ref-24"/>
<SortedList_x002B_values href="#ref-24"/>
<SortedList_x002B__size>0</SortedList_x002B__size>
<SortedList_x002B_version>0</SortedList_x002B_version>
<SortedList_x002B_comparer href="#ref-25"/>
<SortedList_x002B_keyList xsi:null="1"/>
<SortedList_x002B_valueList xsi:null="1"/>
</a2:SortedList_x002B_SyncSortedList>
<a2:SortedList_x002B_SyncSortedList id="ref-19" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_list href="#ref-26"/>
<_root href="#ref-27"/>
<SortedList_x002B_keys href="#ref-24"/>
<SortedList_x002B_values href="#ref-24"/>
<SortedList_x002B__size>0</SortedList_x002B__size>
<SortedList_x002B_version>0</SortedList_x002B_version>
<SortedList_x002B_comparer href="#ref-28"/>
<SortedList_x002B_keyList xsi:null="1"/>
<SortedList_x002B_valueList xsi:null="1"/>
</a2:SortedList_x002B_SyncSortedList>
<a2:SortedList_x002B_SyncSortedList id="ref-20" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_list href="#ref-29"/>
<_root href="#ref-30"/>
<SortedList_x002B_keys href="#ref-24"/>
<SortedList_x002B_values href="#ref-24"/>
<SortedList_x002B__size>0</SortedList_x002B__size>
<SortedList_x002B_version>0</SortedList_x002B_version>
<SortedList_x002B_comparer href="#ref-31"/>
<SortedList_x002B_keyList xsi:null="1"/>
<SortedList_x002B_valueList xsi:null="1"/>
</a2:SortedList_x002B_SyncSortedList>
<a2:SortedList_x002B_SyncSortedList id="ref-21" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_list href="#ref-32"/>
<_root href="#ref-33"/>
<SortedList_x002B_keys href="#ref-24"/>
<SortedList_x002B_values href="#ref-24"/>
<SortedList_x002B__size>0</SortedList_x002B__size>
<SortedList_x002B_version>0</SortedList_x002B_version>
<SortedList_x002B_comparer href="#ref-34"/>
<SortedList_x002B_keyList xsi:null="1"/>
<SortedList_x002B_valueList xsi:null="1"/>
</a2:SortedList_x002B_SyncSortedList>
<a2:SortedList id="ref-22" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<keys href="#ref-35"/>
<values href="#ref-36"/>
<_size>1</_size>
<version>1</version>
<comparer href="#ref-37"/>
<keyList xsi:null="1"/>
<valueList href="#ref-38"/>
</a2:SortedList>
<xsd:anyType id="ref-23">
</xsd:anyType>
<SOAP-ENC:Array id="ref-24" SOAP-ENC:arrayType="xsd:anyType[0]">
</SOAP-ENC:Array>
<a2:Comparer id="ref-25" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<CompareInfo href="#ref-39"/>
</a2:Comparer>
<a2:SortedList id="ref-26" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<keys href="#ref-40"/>
<values href="#ref-41"/>
<_size>1</_size>
<version>1</version>
<comparer href="#ref-37"/>
<keyList xsi:null="1"/>
<valueList href="#ref-42"/>
</a2:SortedList>
<xsd:anyType id="ref-27">
</xsd:anyType>
<a2:Comparer id="ref-28" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<CompareInfo href="#ref-39"/>
</a2:Comparer>
<a2:SortedList id="ref-29" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<keys href="#ref-43"/>
<values href="#ref-44"/>
<_size>1</_size>
<version>1</version>
<comparer href="#ref-37"/>
<keyList xsi:null="1"/>
<valueList href="#ref-45"/>
</a2:SortedList>
<xsd:anyType id="ref-30">
</xsd:anyType>
<a2:Comparer id="ref-31" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<CompareInfo href="#ref-39"/>
</a2:Comparer>
<a2:SortedList id="ref-32" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<keys href="#ref-46"/>
<values href="#ref-47"/>
<_size>1</_size>
<version>1</version>
<comparer href="#ref-37"/>
<keyList xsi:null="1"/>
<valueList href="#ref-48"/>
</a2:SortedList>
<xsd:anyType id="ref-33">
</xsd:anyType>
<a2:Comparer id="ref-34" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<CompareInfo href="#ref-39"/>
</a2:Comparer>
<SOAP-ENC:Array id="ref-35" SOAP-ENC:arrayType="xsd:anyType[16]">
<item id="ref-49" xsi:type="SOAP-ENC:string">/</item>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-36" SOAP-ENC:arrayType="xsd:anyType[16]">
<item href="#ref-50"/>
</SOAP-ENC:Array>
<a1:PathList_x002B_PathListComparer id="ref-37" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
</a1:PathList_x002B_PathListComparer>
<a2:SortedList_x002B_ValueList id="ref-38" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<sortedList href="#ref-22"/>
</a2:SortedList_x002B_ValueList>
<a4:CompareInfo id="ref-39" xmlns:a4="http://schemas.microsoft.com/clr/ns/System.Globalization">
<m_name id="ref-51">vi-VN</m_name>
<win32LCID>0</win32LCID>
<culture>1066</culture>
<m_SortVersion xsi:null="1"/>
</a4:CompareInfo>
<SOAP-ENC:Array id="ref-40" SOAP-ENC:arrayType="xsd:anyType[16]">
<item id="ref-52" xsi:type="SOAP-ENC:string">/</item>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-41" SOAP-ENC:arrayType="xsd:anyType[16]">
<item href="#ref-53"/>
</SOAP-ENC:Array>
<a2:SortedList_x002B_ValueList id="ref-42" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<sortedList href="#ref-26"/>
</a2:SortedList_x002B_ValueList>
<SOAP-ENC:Array id="ref-43" SOAP-ENC:arrayType="xsd:anyType[16]">
<item id="ref-54" xsi:type="SOAP-ENC:string">/</item>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-44" SOAP-ENC:arrayType="xsd:anyType[16]">
<item href="#ref-55"/>
</SOAP-ENC:Array>
<a2:SortedList_x002B_ValueList id="ref-45" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<sortedList href="#ref-29"/>
</a2:SortedList_x002B_ValueList>
<SOAP-ENC:Array id="ref-46" SOAP-ENC:arrayType="xsd:anyType[16]">
<item id="ref-56" xsi:type="SOAP-ENC:string">/</item>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-47" SOAP-ENC:arrayType="xsd:anyType[16]">
<item href="#ref-57"/>
</SOAP-ENC:Array>
<a2:SortedList_x002B_ValueList id="ref-48" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<sortedList href="#ref-32"/>
</a2:SortedList_x002B_ValueList>
<a1:CookieCollection id="ref-50" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_version>0</m_version>
<m_list href="#ref-58"/>
<m_TimeStamp>2017-09-19T16:06:57.4022146+07:00</m_TimeStamp>
<m_has_other_versions>true</m_has_other_versions>
<m_IsReadOnly>true</m_IsReadOnly>
</a1:CookieCollection>
<a1:CookieCollection id="ref-53" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_version>0</m_version>
<m_list href="#ref-59"/>
<m_TimeStamp>2017-09-19T15:56:12.6617096+07:00</m_TimeStamp>
<m_has_other_versions>true</m_has_other_versions>
<m_IsReadOnly>true</m_IsReadOnly>
</a1:CookieCollection>
<a1:CookieCollection id="ref-55" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_version>0</m_version>
<m_list href="#ref-60"/>
<m_TimeStamp>0001-01-01T00:00:00.0000000+07:00</m_TimeStamp>
<m_has_other_versions>true</m_has_other_versions>
<m_IsReadOnly>true</m_IsReadOnly>
</a1:CookieCollection>
<a1:CookieCollection id="ref-57" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_version>0</m_version>
<m_list href="#ref-61"/>
<m_TimeStamp>2017-09-19T15:56:12.6617096+07:00</m_TimeStamp>
<m_has_other_versions>true</m_has_other_versions>
<m_IsReadOnly>true</m_IsReadOnly>
</a1:CookieCollection>
<a2:ArrayList id="ref-58" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_items href="#ref-62"/>
<_size>9</_size>
<_version>9</_version>
</a2:ArrayList>
<a2:ArrayList id="ref-59" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_items href="#ref-63"/>
<_size>7</_size>
<_version>7</_version>
</a2:ArrayList>
<a2:ArrayList id="ref-60" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_items href="#ref-64"/>
<_size>6</_size>
<_version>6</_version>
</a2:ArrayList>
<a2:ArrayList id="ref-61" xmlns:a2="http://schemas.microsoft.com/clr/ns/System.Collections">
<_items href="#ref-65"/>
<_size>3</_size>
<_version>5</_version>
</a2:ArrayList>
<SOAP-ENC:Array id="ref-62" SOAP-ENC:arrayType="xsd:anyType[16]">
<item href="#ref-66"/>
<item href="#ref-67"/>
<item href="#ref-68"/>
<item href="#ref-69"/>
<item href="#ref-70"/>
<item href="#ref-71"/>
<item href="#ref-72"/>
<item href="#ref-73"/>
<item href="#ref-74"/>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-63" SOAP-ENC:arrayType="xsd:anyType[8]">
<item href="#ref-75"/>
<item href="#ref-76"/>
<item href="#ref-77"/>
<item href="#ref-78"/>
<item href="#ref-79"/>
<item href="#ref-80"/>
<item href="#ref-81"/>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-64" SOAP-ENC:arrayType="xsd:anyType[8]">
<item href="#ref-82"/>
<item href="#ref-83"/>
<item href="#ref-84"/>
<item href="#ref-85"/>
<item href="#ref-86"/>
<item href="#ref-87"/>
</SOAP-ENC:Array>
<SOAP-ENC:Array id="ref-65" SOAP-ENC:arrayType="xsd:anyType[4]">
<item href="#ref-88"/>
<item href="#ref-89"/>
<item href="#ref-90"/>
</SOAP-ENC:Array>
<a1:Cookie id="ref-66" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-91">.youtube.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2018-05-21T03:48:10.0000000+07:00</m_expires>
<m_name id="ref-92">PREF</m_name>
<m_path href="#ref-49"/>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-09-19T15:55:09.2910312+07:00</m_timeStamp>
<m_value id="ref-93">f1=50000000</m_value>
<m_version>0</m_version>
<m_domainKey href="#ref-7"/>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-67" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-94">.youtube.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>0001-01-01T00:00:00.0000000+07:00</m_expires>
<m_name id="ref-95">YSC</m_name>
<m_path id="ref-96">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:55:09.2920316+07:00</m_timeStamp>
<m_value id="ref-97">iSB7oKTS6Ek</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-98">.youtube.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-68" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-99">.youtube.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2018-05-21T03:48:10.0000000+07:00</m_expires>
<m_name id="ref-100">VISITOR_INFO1_LIVE</m_name>
<m_path id="ref-101">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:55:09.2920316+07:00</m_timeStamp>
<m_value id="ref-102">ViS26k8QNVs</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-103">.youtube.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-69" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-104">.youtube.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-105">SID</m_name>
<m_path id="ref-106">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.0956982+07:00</m_timeStamp>
<m_value id="ref-107">LwVun8_EaQe__WtpBciCT-mtoprENxdMjqG5payA6rjmknN82tfQnfq28itop0_BgxvWeA.</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-108">.youtube.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-70" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-109">.youtube.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-110">HSID</m_name>
<m_path id="ref-111">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.0956982+07:00</m_timeStamp>
<m_value id="ref-112">AlxWBztjc9xHLBFPu</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-113">.youtube.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-71" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-114">.youtube.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-115">SSID</m_name>
<m_path id="ref-116">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.0956982+07:00</m_timeStamp>
<m_value id="ref-117">AP5XSKOTNsuEOYbTv</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-118">.youtube.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-72" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-119">.youtube.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-120">APISID</m_name>
<m_path id="ref-121">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.0956982+07:00</m_timeStamp>
<m_value id="ref-122">ccnX1G7bhoky7WZJ/AVeDkFvhwdCW7xtQ4</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-123">.youtube.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-73" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-124">.youtube.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-125">SAPISID</m_name>
<m_path id="ref-126">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.0956982+07:00</m_timeStamp>
<m_value id="ref-127">yP1zFuEta4WTUl7C/AMlyhjTXhw0_BucW9</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-128">.youtube.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-74" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-129">.youtube.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:14.0000000+07:00</m_expires>
<m_name id="ref-130">LOGIN_INFO</m_name>
<m_path id="ref-131">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.9574129+07:00</m_timeStamp>
<m_value id="ref-132">AFpGGQUwRQIhAPQC9k18k8Brj1d1pHNoRxpLBOEGKb9ENf3M1CYawLsjAiAdnXheKfmrnNgVELLrc4BA3DXbktgMcgv_4kjLTYxL3A:QUVrbWRPYXNyakZQNFdGVTU4ODlRVy1iYTZoTEl5WlAwTjROMmxubXFIcEpYWmw3LVd0OTRWSHFMSjRCZzN1VEQ1aXplZzlqbE53dWNpUXlkWmo5eW42b05qRFNRZFpwbWJzTHg0R0h4ZGdLN2h3NFpob0gybGtpSzBYdk92TkIxb05VdG1zVW53ZEEwUjFXbkhPMElVWUVmalRmNG9BbGZMaFhHQnpxbWNUUXZaYkNpb3pMTVlz</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-133">.youtube.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-75" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-134">.google.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-135">SID</m_name>
<m_path href="#ref-52"/>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:12.5802518+07:00</m_timeStamp>
<m_value id="ref-136">LwVun8_EaQe__WtpBciCT-mtoprENxdMjqG5payA6rjmknN82tfQnfq28itop0_BgxvWeA.</m_value>
<m_version>0</m_version>
<m_domainKey href="#ref-10"/>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-76" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-137">.google.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-138">HSID</m_name>
<m_path id="ref-139">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:12.5802518+07:00</m_timeStamp>
<m_value id="ref-140">AWea3nRLQ_zzvgff4</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-141">.google.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-77" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-142">.google.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-143">SSID</m_name>
<m_path id="ref-144">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:12.5802518+07:00</m_timeStamp>
<m_value id="ref-145">A2-G1XnJJHjmUWaWh</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-146">.google.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-78" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-147">.google.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-148">APISID</m_name>
<m_path id="ref-149">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:12.5802518+07:00</m_timeStamp>
<m_value id="ref-150">ccnX1G7bhoky7WZJ/AVeDkFvhwdCW7xtQ4</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-151">.google.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-79" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-152">.google.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-153">SAPISID</m_name>
<m_path id="ref-154">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:12.5802518+07:00</m_timeStamp>
<m_value id="ref-155">yP1zFuEta4WTUl7C/AMlyhjTXhw0_BucW9</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-156">.google.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-80" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-157">.google.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2018-03-21T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-158">NID</m_name>
<m_path id="ref-159">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:12.5802518+07:00</m_timeStamp>
<m_value id="ref-160">112=PD4Hox8DhAK_gIxqSKZb47N3ufymuXa9B0NGpw5NOUaQW9Ft5xxU7ZOhWIGi_euS6sOgBlhx63R01dOnNv-wAWp2kmgr6SBAJKI2qbO5wrSzKhYKG0wIHrNAihkntNQSwpTD1hi1qRDUpxAdl0gE3LegGtOO0SebR77qBHyuUwOsNA</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-161">.google.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-81" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-162">.google.com</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2017-12-18T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-163">SIDCC</m_name>
<m_path id="ref-164">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:12.8535460+07:00</m_timeStamp>
<m_value id="ref-165">AE4kn7_SuYDbyK_eUmjthz9k2kG2dLwS9vYPN1H87oh0RY_ISMceG1J_ZF_c8Auef-WgWFFGdosVSfXoVy9D</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-166">.google.com</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-82" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-167">.google.com.vn</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:14.0000000+07:00</m_expires>
<m_name id="ref-168">SID</m_name>
<m_path href="#ref-54"/>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.3555057+07:00</m_timeStamp>
<m_value id="ref-169">LwVun8_EaQe__WtpBciCT-mtoprENxdMjqG5payA6rjmknN82tfQnfq28itop0_BgxvWeA.</m_value>
<m_version>0</m_version>
<m_domainKey href="#ref-12"/>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-83" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-170">.google.com.vn</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:14.0000000+07:00</m_expires>
<m_name id="ref-171">HSID</m_name>
<m_path id="ref-172">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.3555057+07:00</m_timeStamp>
<m_value id="ref-173">AlxWBztjc9xHLBFPu</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-174">.google.com.vn</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-84" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-175">.google.com.vn</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:14.0000000+07:00</m_expires>
<m_name id="ref-176">SSID</m_name>
<m_path id="ref-177">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.3555057+07:00</m_timeStamp>
<m_value id="ref-178">AP5XSKOTNsuEOYbTv</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-179">.google.com.vn</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-85" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-180">.google.com.vn</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:14.0000000+07:00</m_expires>
<m_name id="ref-181">APISID</m_name>
<m_path id="ref-182">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.3555057+07:00</m_timeStamp>
<m_value id="ref-183">ccnX1G7bhoky7WZJ/AVeDkFvhwdCW7xtQ4</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-184">.google.com.vn</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-86" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-185">.google.com.vn</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2019-09-19T15:56:14.0000000+07:00</m_expires>
<m_name id="ref-186">SAPISID</m_name>
<m_path id="ref-187">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>false</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.3555057+07:00</m_timeStamp>
<m_value id="ref-188">yP1zFuEta4WTUl7C/AMlyhjTXhw0_BucW9</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-189">.google.com.vn</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-87" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-190">.google.com.vn</m_domain>
<m_domain_implicit>false</m_domain_implicit>
<m_expires>2018-03-21T15:56:14.0000000+07:00</m_expires>
<m_name id="ref-191">NID</m_name>
<m_path id="ref-192">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>false</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:13.3555057+07:00</m_timeStamp>
<m_value id="ref-193">112=US4bg-e6loj4fZ2xM4ESt1RJUui_5sKgDwI_PL29FEfV4UvQBt7vjsybVlvFPnCnYmE-qgNm5H0pvIZas_y-OSUuJRjdGEBHuy6XY4i_71OqjT_yEArCWI13Ot2jYOEU</m_value>
<m_version>0</m_version>
<m_domainKey id="ref-194">.google.com.vn</m_domainKey>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-88" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-195">accounts.google.com</m_domain>
<m_domain_implicit>true</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-196">GAPS</m_name>
<m_path id="ref-197">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:12.5802518+07:00</m_timeStamp>
<m_value id="ref-198">1:igLiber6x0a8rskE-htpeC14UIanNcdyNenZXPZKlX9JX3NRshDCjTTPiP44FoYQX7_Kzggs2peyimid-W63AItqzFG8Yw:fdR-IwdzNXcOsJod</m_value>
<m_version>0</m_version>
<m_domainKey href="#ref-4"/>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-89" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain id="ref-199">accounts.google.com</m_domain>
<m_domain_implicit>true</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-200">LSID</m_name>
<m_path id="ref-201">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:12.8535460+07:00</m_timeStamp>
<m_value id="ref-202">s.VN|s.youtube|youtube:LwVun4LHDIsXf5nYFXy4P8TWNP6gc5ZIa9zJaS3jk7WUX2WtXeqYKiw3uzUq9ep2-0-vcA.</m_value>
<m_version>0</m_version>
<m_domainKey href="#ref-4"/>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
<a1:Cookie id="ref-90" xmlns:a1="http://schemas.microsoft.com/clr/nsassem/System.Net/System%2C%20Version%3D4.0.0.0%2C%20Culture%3Dneutral%2C%20PublicKeyToken%3Db77a5c561934e089">
<m_comment href="#ref-4"/>
<m_commentUri xsi:null="1"/>
<m_cookieVariant>Plain</m_cookieVariant>
<m_discard>false</m_discard>
<m_domain href="#ref-195"/>
<m_domain_implicit>true</m_domain_implicit>
<m_expires>2019-09-19T15:56:13.0000000+07:00</m_expires>
<m_name id="ref-203">ACCOUNT_CHOOSER</m_name>
<m_path id="ref-204">/</m_path>
<m_path_implicit>false</m_path_implicit>
<m_port href="#ref-4"/>
<m_port_implicit>true</m_port_implicit>
<m_port_list xsi:null="1"/>
<m_secure>true</m_secure>
<m_httpOnly>true</m_httpOnly>
<m_timeStamp>2017-09-19T15:56:12.5802518+07:00</m_timeStamp>
<m_value id="ref-205">AFx_qI6uvBGbBuAzpLYQRLhpWVouMSKqD9AatmXEGLq2RHRrh3nTL2RUe-qcyrImV7hhIugC9G-LxiuZpeQljyfmPIuyrdZNCTtU_G2FWVZKVeW9-8aoanJ0mbEKG-W4Lhiu4iRvz1zT</m_value>
<m_version>0</m_version>
<m_domainKey href="#ref-4"/>
<IsQuotedVersion>false</IsQuotedVersion>
<IsQuotedDomain>false</IsQuotedDomain>
</a1:Cookie>
</SOAP-ENV:Body>
</SOAP-ENV:Envelope>
