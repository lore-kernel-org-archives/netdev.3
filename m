Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794478199;
	b=otS8Ytug0HbJow6NWmVrwK8J8O181AU4z/SmsNppUQZfhGxZSTKqtUfQssgviWl+GtG2
	 Nhsiv/KecVXhY6H9YsundUdo5bAfMIJJQD9u6GEqYnm4lT1iNZA+hokDoJJ7aSCAeH7DR
	 EdInYN8iqrLAc52e+LpL7BUcqgYHXq70toDKZkU2jICnWDYFtwapa4oqVcvRU9084II3V
	 2q1AsD+L2m5NImd6JRxdGSXvdB0bRmSxW7sEjbiEZGpki7tAXaRyTOBV58VBIcGcKE1Cc
	 0/szkoJ1pq+8sBFADFC5MddrJ6pE4gymYyZ/dRxOpjaSccIhFVIfLd3uPFoEDVWqN0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478199;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=09830S51JqWpFaEyY9D9c+3iuHevt9aUw8rtsVGEl7k=;
	b=dJfKXjZhn6ceCgXETTgnJ+AK3dgrplgZYRogVDJXeNJ8PNfcVskom2HArcXoz3loBu85
	 ACtzivLgK0ON5xFqCE+u+IFxS3ffTGjFL0CvwuYevbL5Y0vCVNNDyKAxz+DinrENT45Rm
	 juxzMu9lje9Urt/J1kQU99StTxplj4+ARuvuKTiY62mk48kUFJyXliZKwBr9cj3kfR101
	 IblnxA8B/RiEM2cUAn0TKKcgcv2JAabolY/CdReKrkDwL6cPsiOSQiSsnhKHzQDlBRJ/9
	 z8HIQM4FRlTrIbblVpeN7AcQv4jQiczZ9yyxTW+kJWFqyZbxprbSsKj5K7vZb4bG1sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=23o4+Y4h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.27
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43455606A321;
	Thu, 12 Nov 2026 10:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43455606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=23o4+Y4h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNfnP45vucrqc66aToNIvEzpt8lwIaCvvInviJfkt+DeNGzLmNkiCG2/uCt3gHteza7O6bMRJkPnyiN7hxZxhbhWzKn9j2z28gzXbYmLTlgsgA4O4grDyMZJKLaw8DDe/tY21dgMlOXF/0xUmVMIEHOgEUAOmOybs1KgnG3kN5A2au+sUwDmYbMCT/MrWn3cgqIMjY+LbkyCkOxgZTcZ6Zd/l6V69XNpznEBO+AgS/IYDtuiesLsxw4p7yX/raTJhSaRdkKwv+sTXIAnSGmwWSojVLqkhKPVS551Y5UByLWWLj0uVNp0BBa0RI6OdEbxkd8wiKhqHpvM1c1ib4mT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09830S51JqWpFaEyY9D9c+3iuHevt9aUw8rtsVGEl7k=;
 b=bmI1xgZNO/j2z1uH1/FCIkY+lSaiaU9pvAJKjXMiWMye+lyefKHIRqIll1ENvfPnG06SFuRN57kUtMhLmJ6GQBGOBTwRkdxhBNcRpo9p1PhG6kWhEjY4BTOqdD6AXQtbhMd9aXOEgzTjPJzHEI9p+vxnoHxjdMnvPzEYBY1llmX4EEg9D0WKWkGVMfQA7sDXNYGpPz7hc1o0hHgiaInAg/v+TImVZBkQPmLOAznlGThKFMs9V758ybiqWsUHS38YcAAVq+aN1d/pOC2E69lL1iGxOwvuHLKyC7bK6BuheYWfqsvzkh+H/8LzFZwdyziVFWF2zab0xFhSMXvPU39hPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09830S51JqWpFaEyY9D9c+3iuHevt9aUw8rtsVGEl7k=;
 b=23o4+Y4hmDQw4A3bM8bRy7Qx9YlUgKCDLkpKCbtiRQL0Cs/PSsXeYKQKc3pHwVvv/d9KzDDKWg/stGAC2NjJU3XqXSPBakUAvVa5Qtnu7cJVWtBZy+inKHEPQb1582K4zjZdL/kv1m300CrEcMz88bHR5NT3BdqcVONHPHOBhuQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by IA0PPF4D923B935.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Thu, 12 Nov
 2026 10:09:33 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%7]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 10:09:33 +0000
Message-ID: <14e6511e-3878-4e14-8c25-7db5c179db8e@amd.com>
Date: Thu, 12 Nov 2026 15:39:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] net: macb: Add TSN CBS TC offload support
To: Charles Perry <charles.perry@microchip.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
 <20260909142056.1433875-5-vineeth.karumanchi@amd.com>
 <avMxXCDMQMh5180r@MON-LT-C78453.mchp-main.com>
Content-Language: en-US
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <avMxXCDMQMh5180r@MON-LT-C78453.mchp-main.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0155.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::17) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|IA0PPF4D923B935:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca8239e-8f7a-4a51-b768-08df40a50c7b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|261102123227099003|11063799006|56012099006|4143699003|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261026121527099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	I9rkR0fvZYpFF5gDtqIYLbC/xeMAW3iH8fmu7k+HqdknAFtMro6vM3uLGE/TJDcDn1l/bG9xfv+GAxzvYSz5K5FszACxTxhEfAkYhHCHchj3pOwp341ec+UQK5iN+PjwlCwJak8gWEcZ2br18ZeMdsAYL5tJGAYeMy+xNSOH1D8GbhAg6YE5VomIhee0nif/vTiEVPCVr/tNyqYURCMiUFpCe0QigzGPkAUxZDpoe5C82zWj3EUju1porB1E+YQMp7nCGJD81lCNcI/bgW1djTfO4tNiqHzR+/mQqoZxFDc1oq4/E+KEOgzbaC+MdgqdmljDsDyd5HWdrV9AqQ80iusIPiRwcb/Tp/CdrCc7tSLNzg8DUpC0X+be1uGBTUX0Xk+9fBt0iDme3kassw1hPomGmSW/GaCJye8scukBgcrn9BXkusqKIPxSUVou4B9VQwlKI1TM8tP+HNHkLHdn/uhepdrQtNlgDLk7U6o1nS671PjXxXLlqUrtvnYoehjPmpv6z0dZsu3K5EqEZW6xt7hJY7LDo9AseqNsx3qsB/b0MjhQqwd3XIn5Z+a2jSrhWUJ9bLoKURP2SlUs6OMkCu30Bcmp1pDjvbb7HbhneV1A4/6a5TzdgIHJf8R0Jg2xtbGEC7ej1gMzAFxN3+T7tKBzsQCCO/48aL88H+niSPQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(261102123227099003)(11063799006)(56012099006)(4143699003)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXRaTDB2ZUhQRnl2YjlsYkk0blJjSktjSHd6RkVkcTQ3VVBESDBQckIyZUFx?=
 =?utf-8?B?WUpETldFK1d0bkxmVE4zdG1ENWpkYWNwZUZrL0VwUTRGaHZXOWt2My8xRld5?=
 =?utf-8?B?UTBMTHFxWFBFRHpjcTExL3J6TzBUT2tiSnVwNHd6c09BTWFKVFkxUVZVZ0tn?=
 =?utf-8?B?NzdaaGdIbXVnMXZLVnQrb29rcjZUSWFKVkdST3gxanB5dm56TVZTQTJ1elAz?=
 =?utf-8?B?ZFpCSThlMVk5TVZ0b2R5d1VLcXBCZzJ1SmdJZnhKVkQrYU9hQW8yUUdHajJB?=
 =?utf-8?B?eUZsVE9xWmJZNmtmUjFRN1Q5VUVvZy9ZSnR3R2l4QjFxbFErZXZ5ZlRsRDhB?=
 =?utf-8?B?MFFCOWNwckRuY3VLWEY1TEJUNTZDZnJmL3FZSXdwdlhKZmRjWXVhWWxmZjlR?=
 =?utf-8?B?b0QzODViUDAwb3krRWdISndadHlmVEpGejV0Sk94czlnWThSY2hldUJDTU1x?=
 =?utf-8?B?RnpQUWIrcGRDVDlTZ3d1Vmdlc1lpcGFrdUhIN0V5UE1kMmhsTThJZlVNVE9W?=
 =?utf-8?B?SXdzN3gwb09MdlpHcHpOVzhBZXRKSHpMdFJYQ2lIeVk0Ti8ydXo3UHJkS205?=
 =?utf-8?B?VllkVTB5MUY3S0ZiWG5nelhGQ1JPUGtuMnRYZGpWTnM1OGFXVFI0Q1hVb2sx?=
 =?utf-8?B?MktWOUtyNjh2U05mVE1LenRnM25ya3RMMm01TDdlQTNGTUZIRlVqNHFPL2Ur?=
 =?utf-8?B?NTVtVVBJUmRqaG1odDBad1pibmJISDlFUE1nVmpyeGRMMmFqd25NUm1Wc2Zo?=
 =?utf-8?B?ck1sZy8vdVhvQ0xzOFJRUkFtZ0tjWjN5ZzdGZk1EcXhsVDNHcDZoR1R0SS9i?=
 =?utf-8?B?TGxRRVNDV1NESU1EaUZvUWNRdXgyNE11ZmlqeUllTEJPU3NOUzBpZkNsNmZT?=
 =?utf-8?B?d3M2TmNVTzZISGhCZ2owZ3lVK04vV2RvRDc4K2ZIYmhxWW5LRjJGam9TaDNl?=
 =?utf-8?B?bzI0ZXBtSmNoRGR5M1VnSnR6WFBaOFZUVHNvMTV2MnB3UnMzaHQzZGxpclFa?=
 =?utf-8?B?STVrcFVqaGpxQnlwc2RVTmRZTEUvVXYzWncwaGdmNmxHL2MxYS9zQTluazlw?=
 =?utf-8?B?ZmZEWXc3aGlOQ2dYNWVobWxySzUvYlR0eGt6THpRQzh1MTZDWmI0VTV0L085?=
 =?utf-8?B?SGdYbHBiK0x6bzRFTlI3eU5Fc0pDbmdINkpRekpjeC9NYWticTQ2blFING5Y?=
 =?utf-8?B?eUJQWm5rYjhvUmJuUW90ckJmMEJEQnp6R1I3THpGWVA4Q0hnMEtaZkgzN0RN?=
 =?utf-8?B?OERWOEFibFVWUGpSYUN3MWhIaTUyUm5ucnN0L3BhUFpiZXdwdW1CeDJ1WmRK?=
 =?utf-8?B?MzNINWZnaXpPd1NtdnpNS2hUVUpva2txVGgwZnFNM21mdzFBYjBzNWcxZFZZ?=
 =?utf-8?B?T0taOGpKT25ka0xmd05YaDJnazZ0dkRUdnJHTktTN1h6a3g0QndTNldWeWtK?=
 =?utf-8?B?UndQRXVZandWclZZeTZkNTluaGlNTy8xZGo2VWhacVg1SEF6ZC9zeTMvWlUw?=
 =?utf-8?B?YUhlalQyNUhmSUVKRVNXU2huMHR3T1dBL2UxeldlNXYyNTFiZ3FtL29yNEtz?=
 =?utf-8?B?OFFVdUJ4dXhXVlk2MXBlWDkrWWxFY3FORW1FNmFDY3lISFFvWkQyYnR1N05q?=
 =?utf-8?B?eTVEVmx4ZStZeHlXV3pGRVA2SEx4ZkRkMUFlNnhsbXlmSTVGdkdKMU53SE9T?=
 =?utf-8?B?MlJtaUZvdWpqVjNXbHRWb1R6YWJOY2FOc0tLOUhtdzdLSEpWY1dKUXZpVnZy?=
 =?utf-8?B?QWI5cW5jbkMvUnV4NVhKTTJGTE12ZEVpc0dhY2gzOU1ETkNpZ0svSnV1UWM4?=
 =?utf-8?B?dVVuQlBsbis1UnpNdjRDN040SlpIZmNlblJNRGNVcDl4SXBsMDJzOWREQ1FE?=
 =?utf-8?B?eWdVWmJWVHhpbUJUVjVKR3RhVmUrYXZVUE1lcVJnNTl1YmtycUNiMng3eWlV?=
 =?utf-8?B?cmdQM1Z1dHphMmFNVjc3SUJjK2FLamN5OThxNkRDcmFHV3p4K1dpYXdQL2Q3?=
 =?utf-8?B?STZlUDR5YkNvTDZjQjAzbGZEbzVYVTBvOUZqMmpOYkV4czBPNWVUMnN2cHJT?=
 =?utf-8?B?VzBlYUsyazJnK21LVFJScnkrbjU2RUJoY1QxUDdSOGRzMFczaVhQVDdUTkhC?=
 =?utf-8?B?UFAzZG9vR1k4M3VjU1FYeDBXcjdyeFdoMVlkYk42dVJsaTNyTnRQYi9Wa3kr?=
 =?utf-8?B?aW5pWnNJSjVBYUlhZlZDS2FHMkl1UDZRb0RETGp6cjBUNncyNGNzN0FDdTNP?=
 =?utf-8?B?bWlQZFNLbks1eXZNZU9IdXNRVnE1NVZ3a3hoU0dET1dHdDF1RVF1VEd1UDRx?=
 =?utf-8?Q?sXe3gnjdMwf4Y9vT2N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca8239e-8f7a-4a51-b768-08df40a50c7b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:09:33.4458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5SMnYXFh5GGRwmREfspZh8jJQurhf6qbVQX+U+IG4GudKInmFJdfLEhPCAspmpl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF4D923B935

Hi Charles,

On 11/10/2026 8:29 PM, Charles Perry wrote:
> Hello Vineeth, 
> 
> On Wed, Sep 09, 2026 at 07:50:56PM +0530, Vineeth Karumanchi wrote:
>> Add Credit-Based Shaper (CBS/IEEE 802.1Qav) TC offload support for
>> time-sensitive networking on GEM hardware. CBS is restricted to the
>> two highest-priority queues: Queue A (num_queues - 1) and Queue B
>> (num_queues - 2), matching hardware capability.
>>
>> Validate that idleslope is positive and does not exceed the link
>> speed, preventing negative values from bypassing the bounds check
>> due to signed-to-unsigned promotion.
>>
>> The idle slope register value is computed differently based on hardware
>> variant:
>>
>>   High-speed GEM: scale idleslope linearly to the full 32-bit register
>>   range relative to link speed.
>>
>>   Standard MACB: convert the kbps idleslope into the register's native
>>   unit, which depends on the interface width:
>>     - 1G (8-bit GMII):    bytes/sec,   scale kbps by 1000/8 (125)
>>     - 10/100M (4-bit MII): nibbles/sec, scale kbps by 1000/4 (250)
>>
>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
>> ---
>> Changes in v2:
>> - macb_cbs_get_queue_params() now returns the idleslope register offset
>>   (u32 *idleslope_reg) instead of a bool flag, and the idleslope is
>>   programmed via bp->macb_reg_writel(), dropping the per-queue if/else
>>   that open-coded gem_writel(CBS_IDLESLOPE_Q_A/Q_B).
>> - Expanded the idleslope kbps-to-hardware-unit conversion comment.
>> - Zero-initialize kset in macb_cbs_add() so an unpopulated link speed
>>   reads as 0 and is rejected; reorder locals to keep the declarations
>>   in reverse-christmas-tree order.
>> - Rebased on net-next, which renamed the struct net_device pointer to
>>   "netdev" (was "dev"/"ndev").
>>
>>  drivers/net/ethernet/cadence/macb.h      |   9 ++
>>  drivers/net/ethernet/cadence/macb_main.c | 116 +++++++++++++++++++++++
>>  2 files changed, 125 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
>> index f5359549f3d4..20faeba77d6d 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -184,6 +184,9 @@
>>  #define GEM_DCFG8		0x029C /* Design Config 8 */
>>  #define GEM_DCFG10		0x02A4 /* Design Config 10 */
>>  #define GEM_DCFG12		0x02AC /* Design Config 12 */
>> +#define GEM_CBS_CONTROL		0x04BC /* CBS Control Register */
>> +#define GEM_CBS_IDLESLOPE_Q_A	0x04C0 /* CBS IdleSlope Queue A */
>> +#define GEM_CBS_IDLESLOPE_Q_B	0x04C4 /* CBS IdleSlope Queue B */
>>  #define GEM_ENST_CONTROL	0x0880 /* ENST control register */
>>  #define GEM_USX_CONTROL		0x0A80 /* High speed PCS control register */
>>  #define GEM_USX_STATUS		0x0A88 /* High speed PCS status register */
>> @@ -224,6 +227,12 @@
>>  #define GEM_ENST_ON_TIME(hw_q)		(0x0820 + ((hw_q) << 2))
>>  #define GEM_ENST_OFF_TIME(hw_q)		(0x0840 + ((hw_q) << 2))
>>  
>> +/* Bitfields in CBS_CONTROL */
>> +#define GEM_CBS_ENABLE_QUEUE_A_OFFSET	0
>> +#define GEM_CBS_ENABLE_QUEUE_A_SIZE	1
>> +#define GEM_CBS_ENABLE_QUEUE_B_OFFSET	1
>> +#define GEM_CBS_ENABLE_QUEUE_B_SIZE	1
>> +
>>  /* Bitfields in ENST_CONTROL */
>>  #define GEM_ENST_DISABLE_QUEUE_OFFSET	16
>>  
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index 67150ff03066..00c1c619dea8 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -99,6 +99,10 @@ struct sifive_fu540_macb_mgmt {
>>  
>>  #define MACB_MDIO_TIMEOUT	1000000 /* in usecs */
>>  
>> +/* CBS port transmit rate factors: 1000/interface_width */
>> +#define MACB_CBS_PORT_RATE_1G		125	/* 1000/8 for GMII (8-bit) */
>> +#define MACB_CBS_PORT_RATE_10_100M	250	/* 1000/4 for MII (4-bit) */
>> +
>>  /* DMA buffer descriptor might be different size
>>   * depends on hardware configuration:
>>   *
>> @@ -4492,6 +4496,116 @@ static int macb_setup_taprio(struct net_device *netdev,
>>  	return err;
>>  }
>>  
>> +static int macb_cbs_get_queue_params(struct macb *bp, u8 queue_num,
>> +				     u32 *enable_bit, u32 *idleslope_reg)
>> +{
>> +	/* Queue A is highest priority (num_queues - 1) */
>> +	if (queue_num == bp->num_queues - 1) {
>> +		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_A);
>> +		*idleslope_reg = GEM_CBS_IDLESLOPE_Q_A;
>> +		return 0;
>> +	}
>> +
>> +	/* Queue B is second highest priority (num_queues - 2) */
>> +	if (queue_num == bp->num_queues - 2) {
>> +		*enable_bit = GEM_BIT(CBS_ENABLE_QUEUE_B);
>> +		*idleslope_reg = GEM_CBS_IDLESLOPE_Q_B;
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int macb_cbs_add(struct net_device *netdev,
>> +			struct tc_cbs_qopt_offload *qopt)
>> +{
>> +	u32 enable_bit, idleslope, speed_kbps, ctrl, idleslope_reg;
>> +	struct ethtool_link_ksettings kset = {};
>> +	struct macb *bp = netdev_priv(netdev);
>> +	int err;
>> +
>> +	err = macb_cbs_get_queue_params(bp, qopt->queue, &enable_bit, &idleslope_reg);
>> +	if (err) {
>> +		netdev_err(netdev, "CBS: Queue %d not eligible (only top 2 queues support CBS)\n",
>> +			   qopt->queue);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* idleslope is calibrated for the current link speed; CBS is not
>> +	 * reprogrammed on link-speed changes, so it must be reconfigured
>> +	 * if the link speed changes.
>> +	 */
>> +	phylink_ethtool_ksettings_get(bp->phylink, &kset);
>> +
>> +	if (!kset.base.speed || kset.base.speed == SPEED_UNKNOWN) {
>> +		netdev_err(netdev, "CBS: Invalid link speed\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	speed_kbps = kset.base.speed * 1000;
>> +
>> +	if (qopt->idleslope <= 0 || (u32)qopt->idleslope > speed_kbps) {
>> +		netdev_err(netdev, "CBS: invalid idleslope %d (must be 1..%u kbps)\n",
>> +			   qopt->idleslope, speed_kbps);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* qopt->idleslope is in kbps; convert to the units the hardware
>> +	 * register expects:
>> +	 * - High-speed GEM: fraction of port bandwidth, scaled to the full
>> +	 *   32-bit register range
>> +	 * - Standard MACB: the register counts bytes/sec in 1G (8-bit GMII)
>> +	 *   mode and nibbles/sec in 10/100 (4-bit MII) mode, so scale kbps
>> +	 *   by 1000/8 (125) or 1000/4 (250) respectively
>> +	 */
>> +	if (bp->caps & MACB_CAPS_HIGH_SPEED)
>> +		idleslope = DIV_ROUND_UP_ULL((u64)qopt->idleslope * U32_MAX, speed_kbps);
>> +	else
>> +		idleslope = (u32)qopt->idleslope * (kset.base.speed >= 1000 ?
>> +					       MACB_CBS_PORT_RATE_1G : MACB_CBS_PORT_RATE_10_100M);
>> +
> 
> PIC64-HPSC, which has MACB_CAPS_HIGH_SPEED, doesn't have the first idle
> slope calculation method which scales to the full 32 bits register range.
> It uses nibble/sec for 10/100M, byte/sec for 1G, 2.5bytes/sec for 2.5G,
> 5bytes/sec for 5G and 10bytes/sec for 10G.
> 
> Is it possible that you have another design config bit for the "full 32
> bits register range" method used here?
> 

The Cadence GEM revision `r1p14f2` in our implementation uses linear
scaling across the full 32-bit idleSlope register range, as confirmed by
Cadence support. However, the register description specifies only the
second, speed-dependent formula, which does not match our observations.

I couldn’t find a configuration bit that distinguishes between these
behaviors. Which Cadence IP revision is used in PIC64-HPSC?

I can follow up with Cadence support to determine how software can
identify which encoding applies.

Thanks,
-- 
🙏 Vineeth

