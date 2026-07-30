Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011031.outbound.protection.outlook.com [52.103.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2A3C197E
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396673; cv=fail; b=MBIJlMLmR56hA1l3UjHqFyvpQflqIhkGtsCBrocT3CANPd9mSxbVhB3aPkUUYUYFFbj5whfqfqG8VEwedoxgt1Qckw+I0bZJoO61WYqdG8Zrw1KpScubyIShgStpHXJb3/pXJ1lLjvafW9/zmEjR537S06XLZk4hFgCETCMykY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396673; c=relaxed/simple;
	bh=xMuMpsW+ngBYPuZ45SchG7ajbtWtv+KChNpSHuMsvhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N2LlEjaVfdweCzDTUgQS59dcmU/TFJ+h5MjSamiLWseUHTAsHuM6WmPp6/qp8F4iCZ4PEL/IqeAMdnsiH5snayKcgmclcKPEwtLWc47o00VohoybPNp2gW/HpDMwo8pq7n/AB5hWLtj+1VyxsNkyW5pdRuZwaBosZWbMxUc/ti0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LCLmQ9GJ; arc=fail smtp.client-ip=52.103.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LCLmQ9GJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4YZBVLi/+uOLmVAGfXlVzwqN49UV0hFu3KOAP+Rz4PIGeXHpNJDbHOE1sbAzMKLvRpkjlmA5HH0453aPF5tm0HMXpQiDvliJQ1+CUzhJuagAmPpPXelxAD1pKNr8EEclzfXbv30AUc2CFRmKkg/9UXnDxi5+mfWT9ytyKPkl3FrHBIwALKebu5Duwkb0o7Bcy+qb0Ez8a+eMNS5HinYsfyIS+lqKTzNx7/+OKI3bFYV4io5EwfZIYetO2+2BccR/91Oi4ngGMJiCNg6/z0ZgRK5mkBraolirCNLtIWGZwoGT44ozw2UeKFs4hT3wEIGw9NtJkc+83YtbgyRsjsg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMuMpsW+ngBYPuZ45SchG7ajbtWtv+KChNpSHuMsvhk=;
 b=dKKeJQ0W5zG1mWKI9Qtw7+BReWuV6KgW/NdTKtYD4v32KM0zE4KkZ9pizvnXdcDdLnw3rT+0U+uWg/8yYnYB3XbwEhFLsgqEHuylHvVxPZv74aAFFZwb7qXKzmS8oOPu/VtP19XNtyp2+EdETlftRJcwz7eZX7MksG4f5739Fkc+pr+o68cPbQLcbkW3mTL0agHsh8NZAJiyadGI/pG5Y21m8nr/ZNis36akePakFUTLnZi+/McvPnSqDVqHT64DukxER/nWeAtLmTZ3MOtJOZPrwPDfDpcWtmyEjUYU1HZTd2bJ6tF/loU/vwbnw+Cjzlig4KMZHkCXpibg+PDiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMuMpsW+ngBYPuZ45SchG7ajbtWtv+KChNpSHuMsvhk=;
 b=LCLmQ9GJyvPGHjndqgkEPhbUgiSp8TlC5Dwty8n8bSUzeskSSVuF5oT5e+Lf8o3dwA/TB15UE04p06A5Q0Cflym34cF8Xy0lJqXU1ChxqiEERbvjXxXXVZ39tfAPAxexn/XydSdFWqawsL+svD3gxHffmPWefQZnXXMKdpfc2tPKI5o1JInJEjOXesO6Lr+eo63CibepKxQ0DJ5flpveW5IRtMHmedN+dRSJPo+9kgGwewU/u9ATmned55jztRc7Z7ORh0jp8YGylpqbQQsoWpDHqskl+WW4kxEDAHMOoXKo8p06nyFmXaa0p6MfC1LoeU8ggrvbBIce11NWRSmg8w==
Received: from TYWPR01MB8559.jpnprd01.prod.outlook.com (2603:1096:400:170::12)
 by OS3PR01MB8270.jpnprd01.prod.outlook.com (2603:1096:604:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 07:31:07 +0000
Received: from TYWPR01MB8559.jpnprd01.prod.outlook.com
 ([fe80::9c39:42d9:c678:8bfe]) by TYWPR01MB8559.jpnprd01.prod.outlook.com
 ([fe80::9c39:42d9:c678:8bfe%4]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 07:31:05 +0000
Message-ID:
 <TYWPR01MB85592DA75CC2ED8B830D72ECBBC92@TYWPR01MB8559.jpnprd01.prod.outlook.com>
Date: Thu, 30 Jul 2026 15:30:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/sched: reject overly deep qdisc hierarchies
To: Janis Edvarts Lacis <janislacis06@gmail.com>, enjou1224z@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, vega@nebusec.ai
References: <99183398d8534a2bd65e8819cde9dae92dd97114.1785304107.git.milkory@outlook.com>
 <20260729162436.119656-1-janislacis06@gmail.com>
From: Zijie Huang <milkory@outlook.com>
In-Reply-To: <20260729162436.119656-1-janislacis06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0058.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::11) To TYWPR01MB8559.jpnprd01.prod.outlook.com
 (2603:1096:400:170::12)
X-Microsoft-Original-Message-ID:
 <671f5e70-f9e4-461e-b314-56df90d0dbe3@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWPR01MB8559:EE_|OS3PR01MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f12034-9811-421d-0677-08deee0c83bb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|39105399006|8060799015|19110799012|24071999003|25031999004|12121999013|15080799012|23021999003|24021099003|25010399006|4140399003|6090799003|5072599009|20031999006|40105399003|41105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGgxOXJMQ0JiRzFnMWpHU0t4ZTNHeW5ua0lUSkMzR2U1bWVvZS94bGlaRXBS?=
 =?utf-8?B?NW9IUjZoM0F2SXJOVUoxNDNHZ01DTnNIMWJ3VVV5OUNrZHFOMXorZlFBeWJ0?=
 =?utf-8?B?NlQ2RU0ydGZqcEdDbXVtQ2xycVQ0QzhtSkNlN1J4bzNIbGF2NC9IcXNDSXFM?=
 =?utf-8?B?MFVFM2hEQzlyc2NJdTZpOWVMa1FqbzA1eWwrQTVYQlRVZURVQWNTRldVYzcw?=
 =?utf-8?B?b0RMN3I2TDdpbUZnR0pma2JoK2dFc2RWNWw5VndFWE05dFczY2hHWXNGTzRC?=
 =?utf-8?B?K0NCVVdXQk5uZGdWeVRBRzByWSswckMzQVpiN3lJdk0vT0xXWjZJUEpkQlBv?=
 =?utf-8?B?VGRVUjlEL3kxcytWR1RtbjQzbFR1OGhyN0NHWDFWUTlsL3ExY1ZXbWY2QUVW?=
 =?utf-8?B?STAwS292dTRMNDVRTi83TkloL2lHcmRRZnVqMDFvTmVWZVVkZGtWU2Y5dS9Z?=
 =?utf-8?B?Z0NNL1d5WFZidDMwRkk0UW9SSzVkS2Z2QVdWcDB0VEU4SlRIdzlVZDlnc3Ji?=
 =?utf-8?B?azh2UkM3S1o4L2s2bE5XOUxOdWIvd0FaYlFmYW9iWDIzaVV6NWd0S2NpVnY0?=
 =?utf-8?B?S2poOUpZS3d4VjZ0OGczUmhIWWd6cWpQSmk0S29tV3g1aDRHRFlmT2trSktP?=
 =?utf-8?B?NzljUW9zTThxYW5RdkhGRWZ5VUc3amtpQzJuOHFoVE5nLzI5ZGNhbExzSGxo?=
 =?utf-8?B?WndGZkZmN2l4V3ZubHN3Q3hKVG9yUnorcCsvQm1MVFkrRXU1SnZoNnBMNThu?=
 =?utf-8?B?QWVZWm84U0NtYlhaQ0h3L0w1cGZGbW9vd2xpMndOdUtkSVBoRDM2ZlVOckZo?=
 =?utf-8?B?RVo1dk1URnNpK0pFWWUyaHQybW9YVkE2WEF2WFlEUEdWaE03OHlzb2xkUXh0?=
 =?utf-8?B?ZlF1cUlDYnJ5MGQ2VDBFdDBWS0pnNzFUUjhDNlIrZC9MakRXTWRzNEdjSmh3?=
 =?utf-8?B?amxCNGxyVkwwcnFuMmxqbVBiTWJlV0xBSEMrUUFrTGRjeW01UnpoT21DdHV5?=
 =?utf-8?B?UFFuWHpPOGhkTjI5Z2xWMkxGUGc2Vm5jTzUzTWdWTWZxTkRNaWtMMWVnQUY5?=
 =?utf-8?B?Lys5TGQ4bWg5QkptOFlwU2NNd0JQdlFnTCtZUE90UkE1T2tLOURCTVVFRFJu?=
 =?utf-8?B?T0RhZEg4SE1lM1k5aUFSUXFlOTcwK0J6Q1V5WHpEWXVKYWVsMnJjQVpjMUhs?=
 =?utf-8?B?SFdNME40SHBpVSsrNW9WOEk3TEtnY3pCTDUwV3NFbG5CZjEzcjlrTUxOd2Qw?=
 =?utf-8?B?U0hHRVEzZjUxTE9FdmhOMmNsTEk0STZ1d3FaUEVlVDVHL1JnMWd0czJFT3Ja?=
 =?utf-8?B?OG96VnFFVlRUMjBGeThTQ3kyTFl0R3dSUXprcm5mcjczVGZiZW0vdWpDVFU5?=
 =?utf-8?B?NWpmTG5DMGRXMGJyZndsTVZISUM2eUpZYWFobVZ4WWsyZkFUUUlqajllZVRC?=
 =?utf-8?B?MkFBcnovcFJLRS9nRGtXb0tXUDJnaW45MUhqWGhLTExOWUdwcFZSSDhpRkJK?=
 =?utf-8?Q?jC11zK4xw7dV/XVPVbsvRV2oHfK?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHNqRnVVcmhRQ3U3NzJxT0J3cHBMdTZjT1laSEpxalNiWXZJdzBuM0dMelNm?=
 =?utf-8?B?c2lkMy8wNk4yTDgvV0xOWW91cWZMUlg3Qm0yUkQzdFRuSGErYWJvKzhkczlG?=
 =?utf-8?B?RloxdTV4OWd5cWFyZGxaMHBReVR6V0c5c3hFUHNHUGtsczJYVXBoVVpja244?=
 =?utf-8?B?NDNSMFdKSnluY3NqUzZRU3lWcjR5L0VVVTdVMGFPWFBqdUhDQ2t0cllpYjNK?=
 =?utf-8?B?d0RDcG9EamtPUGtyNWpya1VkMEsrKzA1cUY4RGtuMjlnVWZ3OEYrRDdOUnJz?=
 =?utf-8?B?aFJIRzN4a3E5L3g1WnhxZ29BMzhPNFNxRDNUSndLVkJQT1NzY0hNVndsUVMy?=
 =?utf-8?B?b2pnSWd4aVRXMStPUFBpVHM1T3RTUWpmWmZFK0pOcnJJSXMrc2NjNWI2MjJo?=
 =?utf-8?B?OUdIb1EzOU5uSG85c094ejNKMU5IWkhEV2lmY2RsYlRPMTQ3M0pLOU12YUV6?=
 =?utf-8?B?eC9LRXRPN3FwcHJmRTBlZ1VYUVRxbm10T25jcFQ4ZFdDODEwa0dRblZad2VF?=
 =?utf-8?B?aUpxakE4T24rS0VGc24vZVA5aXlrVzN4MEpSQXBwVzNzc0daeU9SWXNtN0F4?=
 =?utf-8?B?aCsxZFRXandzcXZqWUJSOFZHUEx3Umt2czhxWktETVIycGtVeVBuZzVwMW5B?=
 =?utf-8?B?azQ3YnBwcno0L1dCTW9RcWVYOFNsYjdZU2Y0YXY4dkpmaE5EdmxHR3NDdzZK?=
 =?utf-8?B?S2tNRVZVdHMzVTZCLy9PdlZicDNINllqbGdxdGtCSGNDUXNlanhwM3ZsZTMy?=
 =?utf-8?B?VGJJeXBmd3VNYk9seVZPK0xpL1NkY2NON0dDMFQ4L3IrTGtVNEFxS01EN1BY?=
 =?utf-8?B?L0V3bTE3aWk5SFZxdzgxZ0s0UzE3QnNud2tYY0M0UklEZ01qNEJVcEFuQ1N6?=
 =?utf-8?B?bjRsNDRWZERpZXlaYnFPQ3dMSHdxcHB3cnNUd2VWcHFtYTRKMUd2bVVrUkdy?=
 =?utf-8?B?aTFRZWtIeSszelh3QnYxbFdTeTgxN1FZbXBncjdpZHBhVlFLZW4xNkw3azM1?=
 =?utf-8?B?STFUYTBsNHFOTi91SGdEL1RqVXp3MFlJcWdmdjRBRDYvQUphVVFIbzZONTZM?=
 =?utf-8?B?Z3QySVdiTlFKbEFpNTNNMFNua25wSFlqKzk4SDc0Unp1NVBKSEN4L3Z0WFZx?=
 =?utf-8?B?Wk0xTjViMzhpL2ozNlZrTi9hZm9RR2lnd1pKajVGbzlXZk5FTjY1ZDVrOHJP?=
 =?utf-8?B?VHpvV0lqR2tScFlzK0ZMN0hGWms1bVF5SVVtRnEybHpmWEEzbjVOM2ZPSEpL?=
 =?utf-8?B?SFd3Ni9OaU5hRnBNUkNPQmVtcEVIQ1NzUWJ6Qk95emFKS25RRnE2T211aGNC?=
 =?utf-8?B?eVpEWmpSclVXS2M2a0E0YXZCVkljZm1MQkh6MTRNYzdlMDI1MENiSWJsVnZG?=
 =?utf-8?B?RWlkMTVOaVlyWUhLbmU0aUtBYkhOcE1jamZ6TjQ4NDh4djZQa0JIN21rd3FI?=
 =?utf-8?B?eFQ2SzBCb2Y2YlM0M2pYTUFMWUJMQzBJVmQyamlXWXczZWxQTkV5OTdRb1BT?=
 =?utf-8?B?QTAzY1ZxSEkwZG1rZVE1ZzRVdjk2UjZxM09kYnBxcE9EeGUwNDVGTVNzekZn?=
 =?utf-8?B?MDZrR2wvUU9CYm9pNTFxQXUxL3FRU1Y2U25KNnlOalVkUmRsNkxiNjJuM3Ax?=
 =?utf-8?B?MmdkZ05KR0NYbmllaktiTEJJdEJzb3p1c3dWaTcrRDU1eisyeDZTVlU4OFJy?=
 =?utf-8?B?eDV5U2thejhkc3VlblZEVStEMlRVRUJ1WG03dnc2OXZxQmtWb0JVSzdrMzh0?=
 =?utf-8?B?Uk1PSXlOajR2MGJJWUFoYVh3NDM2WkJHOXJBMmh5eU9CaGtja2JSTHpGcjFo?=
 =?utf-8?B?WGpubE16T1pXb0tLSmJMajI2NG9hUzBPQUpUa2N0cFVtYnBSakNLYlFPMmZ0?=
 =?utf-8?B?NHhsS3dIeFVPUlk1YTRrT3E3L3gralFVSVpJV2RGcFp4SHhZVXhBRmdqY09Q?=
 =?utf-8?Q?JLCP0GYLDQUuIogOVn0GzBpsAuMBNIyJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f12034-9811-421d-0677-08deee0c83bb
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8559.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 07:31:05.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8270

On 7/30/2026 12:24 AM, Janis Edvarts Lacis wrote:
> This appears to introduce a new qdisc hierarchy depth limit of 7, how
> was this value chosen as the 'too deep' level?

The effective depth limit is 8. This value matches the existing qdisc
hierarchy limit in check_loop(), which is used to prevent loops and deep
qdiscs when regrafting an existing qdisc.
