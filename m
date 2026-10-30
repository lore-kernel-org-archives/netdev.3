Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793371937;
	b=qOFLNEBIj8l4w+EU3TZqQcAsQH5AWt9kO1ib/SwegbI4i9KSQtkoDPitShDPOSZRGJmU
	 LAw1FlS5bP9oe2zEMF4xU/ZKNlDGgC+39ndJ811aAj9uSENWp/v6YrovFT/61LOYQ1m6y
	 JN/rLsVE/pZfu/kKjxaHyzsFKnRvrTzYIekF/gWRn2O4axJevcDpyPvYtGOq3Pf3I0jOj
	 a+AZEqhPGQqyV6P5UUtJjI5z12sCvqWGWj6cfPx8hi7b62GMJBPGeqyZbHOkyq0WB7MC4
	 scMB39Eoq+GfmxHOB88u0Dz5ObwwDaeofZaTgFntWbIhz/Zkjw/Uls1jXBMIU2UPASQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371937;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+FE89L4Y8jG4q3VU8WYblS2b7i+0MgBqnI6lgaEqry0=;
	b=EylQZhpIMdRztzu5RNactgNo6fdfiCIGuCTvEnGNuimN0Lh+51n87umgooeVvATXBHnZ
	 74wBML+mF7HFemZi40Nj2jjmqKS62Xz/xHLuRifJMHhbcJFeNZr4NpBRp/LspO46PAnDy
	 b8owJ+NAcYUowuiY3WmNjaLOYQH5X03b69puccKlgfTPrQzfW4jRpbjekuLkb+ggIrVH7
	 PPMXZ6zOJILzBYy8evf4WOrcNJQ6ogUG4mIr5cyLctDeAXl23pQ5Mbso3Vo8utEqqDYZ3
	 eUt6/z6Z7F2SHWDP7KpM9tsye9qojJoPjvZfnNQGdy/50M+htCZwuXnzeHKGmJRCVSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X28Y5Z4z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.42
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852E606A31F;
	Fri, 30 Oct 2026 14:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1852E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X28Y5Z4z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+sKSaTsXwnWuiz/qneS8/piwT3PYqPPCH9b775Rw4YLUgGVFq0g6ySVtXtwCgeYjnTzWGZ3fO5/w/Oq9M9Gk08os9XOC2yOb/LiFS2pwoGslMEbk5yKjlvuHNs5IA6PjTgVFhVX/oIfZu06pDCnz52yR3pnLX5kQpHxuYfT2yGcFDVmgR2OTz/v+1LoYrrjEN4FG0o3Ff+ADQIIJP6KmK4Euk6wE2dJ3ME78qR7+KmOatLpnI1F8ulzgW0Qdd2tQguHB/kxnURvViOz11nG/EbCvJJRsWF6qbUsMiGTo3LEOrd2WSVvg2n3iiZwNNQJ3NHG7xLttQZ8H20FLTUXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FE89L4Y8jG4q3VU8WYblS2b7i+0MgBqnI6lgaEqry0=;
 b=aE+0cAG1t/YTwqQWsf+Oe4cJLnW9CReKOLZVvEVpgotq2VBJQkGScGv3iYIvdiP2xNorGWck/OodQDOaiyyHeO9yMKgbbEqocTinmMPoQgdTIW8LezvcKB45gCRBkdxBPMVp8foUTJi/fRpJqgkYqqoE/TaJWZNsugduSAzU8UKO+7yMfrzW1XKYhP9tYKwni99mqG1G8Gy3FVnnJeLuTj47+XtnaFtMj9YKtMP+zkg8D5fZkf/kZnf1GSgpvnZNXTYPWD7fonZB30rugGOZ541Z4JUfprrbAxSfaLym88CGg0VihoecBXEP13Loe1QfVexelEudVRFkguxKxwrMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FE89L4Y8jG4q3VU8WYblS2b7i+0MgBqnI6lgaEqry0=;
 b=X28Y5Z4zJF5D37bS/cFvANbcfxiQIZyt8bwRD8qFSx/+/VTuaA5kpHzqPy9wv+IX/XGyxCughHnQ1BqyUSKVpDwgoB1DsjZvVDweGnrfcJYOQ7NWpa8StBJ8gZIyVOG5I6X+xZCsQPfmdIqdPN/nEeKzLckqpzEwFrMNFhZoCZ0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:52:08 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087%6]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 14:52:08 +0000
Message-ID: <c5ac697a-d5d8-4797-8dc3-967e00c47670@amd.com>
Date: Fri, 30 Oct 2026 14:52:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/3] sfc: ptp: avoid racing PPS timestamp updates
To: netdev-bot+sashiko@kernel.org
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, alucerop@amd.com,
 pieter.jansen-van-vuuren@amd.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20261026123023.3566549-4-alex.austin@amd.com>
 <179336481210.3134.2636807043421655737@kernel.org>
Content-Language: en-GB
From: "Austin, Alex (DCCG)" <alex.austin@amd.com>
In-Reply-To: <179336481210.3134.2636807043421655737@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0210.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::17) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: a265a954-ab54-45ac-b4c3-08df36955ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|10067099003|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	xhDGqShr7evvJW2nnvEjZe9A3IWwT4+Ivp3d4ggGep5GN5My+5L85aDglh6ZJ+P/6Z2DbgFMT9dehbMA9UCnTpPBK5TFFwvuCK80+yJQf7juPLHzR/ZVtHrC/Q9cNV4ZXQhFKxvcr62m+AEcw1M98+BMnT7Pynipc0A3xjF4q19kYvc5tKEKgedfz0TEp1W/OAY/PziqQYi+Cc31l9m79FtBYjL1vrR+Bm2dXWYg6PWPfO8wp9SetZgw8qOhIkb6bYedwCDoYOu8k2iwJLLvm+b77F1x3oIuEgorwQg6XZs1jfDKcB5uecP+7Zp0Gh7X7MpnkDR59RooliExr1qyTphlA/2lOQ1TGcaHSRsXaoI6o62SLql1m+n0cURcSovFl2pEiPz4OpsGSeiJ08Nrr9PSqyO8uOvHBX0gA9yoCOKobYGtEuUwckCPDN7k0Y2y5RtMlshySfobT98SF3R7almZiJi+nLfiDgfTKZDM72wRnUGD5nw8CzI3mQy29MisKcT1RLYhwQQth+X7eh6YDGNrAr2jvSjmq3Y2Zd49vpjE056K4leTVU1CJkf/imaWXHGAtaEzknGvsax8SbQmXtUKNtMRSb1ToWux6re+oIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4283.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rlg4OTBnUUxBVzNuMUNsMmhZc2g3SnNXQy9aMFk2cm52VUFCYklScU0yTkdK?=
 =?utf-8?B?M2ZTTnVBNzV4QXI3ZjNVT1NYSWhCV0VIQWFlTzUwbEZwME9neERqUklCVytT?=
 =?utf-8?B?TTQ1d0R1OFpIM0oybE8rTHdJck9QUnUxdVh4VzlOcFI5RG45MkNIWFd4ei9O?=
 =?utf-8?B?VGllZ2t1Q0kvVERKQWdWcFBKV3FHaE9DUExkTGpzNjluNWw1ajViL0llRDJj?=
 =?utf-8?B?eTdrN3NFV2NFbG9wdTR1R0RpaUZwR3VnSFdtSDlXOFY1ZHJ3ZGFTY1FqZTdl?=
 =?utf-8?B?OVBLWVk2UUJEVTdXd0NyWmZaem1LQkV5UzVFZzVocStTakh5Z1VubWxVQzY4?=
 =?utf-8?B?V2J6akovWXR2dktFM2cyL0RmTFV2MkZLRFJyQlFnVlhkNXlUMzNYeWhnb2Y0?=
 =?utf-8?B?N3F0WHYyc00yazVvMGJxMXR6aVEwMmNCYjBuSHBGY1NKQnc1R05hQVRUY2Nv?=
 =?utf-8?B?akMwTTJsdVUvSWwvK1F5Nm9zcXl1aEUzMXE2NGtGdGoyV2xHWGhuVHA0Tjcw?=
 =?utf-8?B?dXFiTVBrdi9xU29qUHR1UTkzRFJCNnp1aHczRzdkOW9MYTduc2Q1Y2J3K3Bi?=
 =?utf-8?B?SnNackpxR3JUN3ExVFZuV2ZNVlRTc1JOQUF4OEFRS2JmOWgreGJVZlJsNFAy?=
 =?utf-8?B?LzBQbWM1b0FBVExubWFSTDE3V2dMVDM2YkRCWXFXOEZIL0ozS3l6OGp3SFo2?=
 =?utf-8?B?ajV4MG9rUW8zT0NUNUhFcmRKQklBWWJoSzhNMG43NEVnRzFCVzBteTA3Ujkz?=
 =?utf-8?B?Uk1nTTFoSXpaSDNjcnpSSEZVVnR3cEttN2NDNkNjUDRqRThDVlk2aXRhVEpR?=
 =?utf-8?B?U1dQRlcwYWhWb2lBWW0rYmxVTkdtYzFFUk5FSjF0Z0QzTjJnN09iQjdrLzRt?=
 =?utf-8?B?WGpwdm9uZ20zTjNRLzRXeWpIZGhERndqb0dNZlZYMkd2NUpzSTMxWkRHOGVM?=
 =?utf-8?B?SHJJSHB6U3RhNkM3VmRZd2NYZHlVTFBQZE54Y2hxa2hCeFhYb04zMkZMYnlF?=
 =?utf-8?B?cmNIWkxxUk1ScWQ4WVlWSHBaOUhxdDNoc2RzSWswb3ZBWHdwS0ZHOFJRRjlk?=
 =?utf-8?B?ZTRiTTNKenhXZFpyWVNISEIyU2pBdlluMVRtZVRoTXJENGN2SysrRFVYeW5q?=
 =?utf-8?B?OUtPT2FIVHlnaGc2LzgrdlNUYTFWdGFHa3crUERxM1h1a2xaNzNLVkVlUXFl?=
 =?utf-8?B?OHBYdi9hcDJTS05DOWhhVm51QkVRbFdLUUpqS09yWlBGd3cxNTFiUzBWejNs?=
 =?utf-8?B?anpqZDQ4S2xVYUU0UytrSDV6WlU3VW1ZdGI5NHdMeHRYMFY5aUdOaWhxU2w2?=
 =?utf-8?B?RVh0emJKa1hValNzMzBjWmpqblo5NGF3NmU1b09oMkJmQkFMblVUbk1UZjd6?=
 =?utf-8?B?ekRwVWIwYUhqWUxuLzBvem9ZUzJOdXMyekY2UlVjbjFLL1pQd2RrY1pmWno2?=
 =?utf-8?B?WlV5R3hJZVl6Y05XNjJxVnFLSkhMM1p3S0R6aFpQa3ZJRDhReE5MbWljOS85?=
 =?utf-8?B?anRZUmVQakFnOXF6eDhPeHlRZUptWVhid2s2dmdrU2gwc0NRb2N1MHljVktj?=
 =?utf-8?B?ZDhqaGNUazJLbjVmZ2dCQ1I0UUs3akZISk53S1FhcjdhVW1rcXhTM09URk03?=
 =?utf-8?B?anptY1J5clpFVGxjSmdGNjdjV2hSczFKYitXd3AweVJkb3VqMmVKbjlQTWFI?=
 =?utf-8?B?VlE2NDBCUnhXNndzclZGMTM2YmdqYWtOdis3QkZwODBKWXhnbk9URm1CUUZp?=
 =?utf-8?B?WkY4MVpZMGdWTWplcndxZjY2VEZvc3NOQWVEcEtVd2grVnMzb3hZK0tiYmFr?=
 =?utf-8?B?ZjNrR3RMWmd4KzNuakZjZHg1dVRoTmE2UmsrWkJiU0dBNmJXNFFRMy9LOU5C?=
 =?utf-8?B?R0dMOHhDaXJuV3AxckdCUDJYN2FHN2RyaDJ5NmNtUUswV1VjUGJPLzZuUzFZ?=
 =?utf-8?B?R0FRVmVtbjBDNWhNQUd3WnhtSHYvT3RnbnczY0lFU1M4WmJIWUlnYk9kcmpJ?=
 =?utf-8?B?cGRrVXo1eHhJWkNaUXV2SFI0bmN0SElVWFNjbWFQbWhqcTl0QVdFWmlFcHZO?=
 =?utf-8?B?VE5uUUVadlgzOHM2ek1mVWF6MGVvbG9vYVZHbVlaM21MakdMMzJiSG02VHBY?=
 =?utf-8?B?czU5dmFOdkNZVzVTelRhZmZmRnhERzBxc2srSWJsTGhtOW5RVnJkV3BnT2Jz?=
 =?utf-8?B?WUVrK1JWcHZaZXJSRUN1bEN4Sms2L0ZYVW4vVEkvZ2hQUHR1WW1BL3lhV0ZG?=
 =?utf-8?B?cVNtWU9PQVgvai9yczkrQks0TDA3b0p2K2dxcWh4RE9ER2FtQU5IUTZvTk14?=
 =?utf-8?Q?KHrifJj1yMSWe0+EJu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a265a954-ab54-45ac-b4c3-08df36955ef2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:52:08.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksqUy8/zWnRel6fpYi7WgRe79YPFhCQ4NJyCQ5E7wpoV1kc911PRdwc//l2N8CqwoWTa6+QuI5xN/y1kjzcXlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909


On 30/10/2026 12:53, netdev-bot+sashiko@kernel.org wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] This patch removes the shared ptp->host_time_pps race from
>   drivers/net/ethernet/sfc/ptp.c, but the same race is still present in…
>
> --
>
> sfc: ptp: avoid racing PPS timestamp updates
>
> This patch removes the shared host_time_pps field from struct
> efx_ptp_data in sfc/ptp.c. efx_ptp_synchronize() now returns the PPS
> timestamp through storage owned by the caller. The PPS worker therefore
> no longer copies a field that a concurrent SIOCSHWTSTAMP-driven
> synchronization could be rewriting.
>
>> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
>> index e26269fae38d6..37511f234d76d 100644
>> --- a/drivers/net/ethernet/sfc/ptp.c
>> +++ b/drivers/net/ethernet/sfc/ptp.c
> [ ... ]
>
>> @@ -1500,14 +1504,15 @@ static void efx_ptp_pps_worker(struct work_struct *work)
>>  {
>>       struct efx_ptp_data *ptp =
>>               container_of(work, struct efx_ptp_data, pps_work);
>> +     struct pps_event_time host_time_pps = {};
>>       struct efx_nic *efx = ptp->efx;
>>       struct ptp_clock_event ptp_evt;
>>
>> -     if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS))
>> +     if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS, &host_time_pps))
>>               return;
>>
>>       ptp_evt.type = PTP_CLOCK_PPSUSR;
>> -     ptp_evt.pps_times = ptp->host_time_pps;
>> +     ptp_evt.pps_times = host_time_pps;
>>       ptp_clock_event(ptp->phc_clock, &ptp_evt);
>>  }
> [Severity: Medium]
> This fixes the race in sfc/ptp.c. Is the same race still present in the
> Siena copy of this code, drivers/net/ethernet/sfc/siena/ptp.c? That file
> also descends from the Fixes target 7c236c43b838, and this patch doesn't
> touch it.
>
> In siena/ptp.c, efx_ptp_process_times() still writes the shared field:
>
> drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_process_times() {
>     ...
>         /* Set PPS timestamp to match NIC top of second */
>         ptp->host_time_pps = *last_time;
>         pps_sub_ts(&ptp->host_time_pps, delta);
>     ...
> }
>
> The Siena efx_ptp_pps_worker() copies it after synchronization returns,
> with no lock held:
>
> drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_pps_worker() {
>     ...
>         ptp_evt.type = PTP_CLOCK_PPSUSR;
>         ptp_evt.pps_times = ptp->host_time_pps;
>         ptp_clock_event(ptp->phc_clock, &ptp_evt);
> }
>
> Meanwhile, the SIOCSHWTSTAMP path can run another synchronization:
>
> efx_siena_ptp_change_mode()
>     efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS * 2)
>         efx_ptp_process_times()
>             ptp->host_time_pps = *last_time;
>
> Can this give the partially updated PPS timestamp that the commit message
> describes, but for Siena NICs?
>
> Siena also looks more exposed than sfc was before this series. The Siena
> efx_ptp_synchronize() takes no phc_lock or any other mutex. The
> WRITE_ONCE(*start, 0) handshake runs before efx_siena_mcdi_rpc_start(),
> and the ptp->timeset[] processing runs after efx_siena_mcdi_rpc_finish().
> Could two concurrent synchronizations clobber each other's state there
> too?
>
> The earlier patch in this series, "sfc: ptp: serialize host and MC
> synchronization transactions", seems to have handled that only for sfc.
>
> Should the same caller-owned out-parameter change, along with the
> serialization, also be applied to siena/ptp.c? If not, could the commit
> message say why Siena is left out?
>
> [ ... ]


As before, I think we should tackle Siena issues in a different patchset.

> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026123023.3566549-1-alex.austin%40amd.com
