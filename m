Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022120.outbound.protection.outlook.com [40.107.193.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810B4E430B;
	Tue, 29 Sep 2026 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705634; cv=fail; b=eAmpRq34LlipURZN2yBYWrpCjN8EdiiJd4B+z24krAg1K69DTyjB/ukjIsrpFicyCM2YHoJv9PaC6pGpnAeIdg+DTDE5OznXpPEfwMOUpxdxG45Q2oPkZwD3vlaUhpVVBGK83RXwFMKQDxxxdGLReEJn2Y7LBlfx6DXWAUVAsRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705634; c=relaxed/simple;
	bh=gcH6iD4cH67/yhDMKRPUb7TAkkmepRdp9fdbuS0r2vU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BvG4O3kg322LERIlv+suLF/MgJ3+d1nKhIkiNCoRY0a63mWpLwInpBBjnMeVQMHjnLunfxBCYDps9u3m3gEDK9xKayYS+hnhphc3O+e0RAKuVFUH2yjSb31Vs7wjBc4QSIBR0Z0D0WcwFa7VrFRYgJ1bifxluXSdzBBSGoEJljs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reliablecontrols.com; spf=pass smtp.mailfrom=reliablecontrols.com; dkim=pass (2048-bit key) header.d=reliablecontrols.com header.i=@reliablecontrols.com header.b=YDjRqiPb; arc=fail smtp.client-ip=40.107.193.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reliablecontrols.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reliablecontrols.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reliablecontrols.com header.i=@reliablecontrols.com header.b="YDjRqiPb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXEQ9KoeI+wiiDGvrzrjO6bA5ZeHsspzY143DV+NUeTNvMFZvsZRDeNS9UByOmCQrIF9vxFG4bun3z/83TRHYIqTZkFzxB/wzjYQQUz4rjI2Ur84zuJisQX80pmnTMi9kBCblIB2g/dxN3mpAbEknXtzBkOFAvkJc9SnmT0Ku5waHOFCW3LcyPugTCf04zoL+TtmbdwYfs5ijmKsHX1/niQ4jbh9nqNP2pxa50xkX9swwy3BDp+NhDIKyGsD2XMb7EF09DfI9R/+9KGCBaWmfe4HVlfn2/EZkfLXhKHU+zd3DhchlreEP6bXyl6Gs9ccsbfOZankOlYcdDOF7awz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fadR1FGztDypFxwErksH0CX7KWRfihN9NZY1EN8cvh4=;
 b=CKHCOJ/rU4akuyXMwcgI7sZeHkOCWVSW4K0V39TyBbWOTr1uZOf0JJ+96S0SnD6tjLJg8gAae0CXpTX/cyVf2D+eZCkFo1jehR31iXjqselL4exgLMyqm1jXpURdBeBbzuNQ/znBUdLg39uMTcMVYcvW7sBsJ804Kwoe327qMgzqNqL3/ltzmwvI/nv1Ci9m/hAKZmW9nLDpuu+LHT0xyVoBiM2pJU4289DzvleOvvnz47Yt7nhCQlbHHiw47c1nK4LGW/YrYHk6O4twe+Umfle0v4fOFUReOMa161TooDtFMv9SQ5Trd+F6kodEbh7thtVUVteLCHNyQzqhRH8v5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reliablecontrols.com; dmarc=pass action=none
 header.from=reliablecontrols.com; dkim=pass header.d=reliablecontrols.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=reliablecontrols.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fadR1FGztDypFxwErksH0CX7KWRfihN9NZY1EN8cvh4=;
 b=YDjRqiPbV9p7ky0A5IlOZQqVr4bYJse8YBnylv55WJa4FO9U+rv2G5K9aXmWCGsp0E/8UYeGzI9ygmOqZ6ICoT9FkB2Gk+QuXqNQ3ne1Pt80E1Yw+0NAQVwh0cmi49QT+7ez+ntV1w1v5nBFI6XfcpDuutGyUXAyu9xhuo4JryR4ytFd0qt9Hv/3Z+TYV5N0eZnmYMjmJ+mp1gefC+JeJxzZstaPez39nwQbcAjfVvjpkAOk6Aee2yEYSKhhpApCbuBn4qtIg9dbTCVFXKXKvSGi8A4a11iFVov1GoPYtya32KdCfAVf+3zhvRXZI0vo0sOt0enlxJO781cQN0X5lw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=reliablecontrols.com;
Received: from YQBSPRMB0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:69::15)
 by YTZPR01MB11816.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:16e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 18:13:49 +0000
Received: from YQBSPRMB0024.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a6e8:6bb:e075:7c3a]) by YQBSPRMB0024.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a6e8:6bb:e075:7c3a%4]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 18:13:49 +0000
Message-ID: <e6315e1d-5a13-40be-a2e3-82695fbaecb7@reliablecontrols.com>
Date: Tue, 29 Sep 2026 11:13:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] net: pcs: rzn1-miic: Validate dtb
 configuration values
To: netdev-bot+sinfo@kernel.org
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260928-miic-validate-dtb-v2-0-1ee3d33748e9@reliablecontrols.com>
 <179063075707.31693.10158252953196019880@kernel.org>
Content-Language: en-US
From: Kyle Hendry <khendry@reliablecontrols.com>
In-Reply-To: <179063075707.31693.10158252953196019880@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:303:6b::17) To YQBSPRMB0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:69::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBSPRMB0024:EE_|YTZPR01MB11816:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d5e526-2bcf-4a8c-3f38-08df1e5568ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	dyZa8sLTznwInKTV5fOAoHuGvV6sXW8cWjjUvAUd3YlZ6FzuD1I/aL1Dz0vUFTO8Mi9VPLwEiFvzfE4pnKhqtu5xVpHBdlliCLsu6WKFGoPTxCgAiUDHF7ULn5Nqat5vWhzay0Uyhuel6dpwkrMetayHW/XEtZr3CC6syuQmOvcxzSQlfFrjR7G3p/Lmur3n0t38Yp1Xn/4YlupyYbwlMNu3MG6ba+MQvF6l91ZeHPkfOqA9EiHJT75p6A3S+52DnVs1T5e9KHiC/B6vqGpqnge0hr+fkg4S5uQ3larkQ47M4mTSF7j7hk4m0mJwBHlOwD7vkbBNiaFaXR43rgZWoaqZZRdwEJ+RF/IMfwtyOXNUcRf1vBW1MouXiRhbDzkY4LtyrVlS1wTxAQGmJUYqGIHND0l3Ew3MNwlQ9T/CdZZoB6FUctzge7TCtP8JQkf3g4R3nL0LSdsr+72kEgmobJJquRzQxtNMAm1F1s/I+LESZ5L9iQmb6wryghV6LiCbkuQxzeJq/r1Y9qBY0ktlcE/Rf4FubsPDyXThO400E2q+noOLM2z8HLPq8QRsm5jl62/yePmhATc4TsK9uiqK1PYcsTnU+pHX08gvBFw0ipAhUZ91dLwTm+6jDaI68NvK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBSPRMB0024.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlNXODVWRVJhL0tzTkk0N1BWdmpjRWdOYlJaeXhOb0cxbkw4cjR4eUJBUW1O?=
 =?utf-8?B?OFBYZ2xyMWN3dXV1ZGNTbGxRTVhZSDhwTFdnM2c1Z2JHWm41US80M0ZHSC9r?=
 =?utf-8?B?VHRnOG5jazZ5RDRWMmM4MTlwSVFGL1NiSWRVZmZydExkSVAwZTJNOWlReFNF?=
 =?utf-8?B?MjBYTmZubHFzM09kOHh2a2VEdUQrTnB6VXVtc1ZvTGoxWUdUL2ZqNy9qcnVs?=
 =?utf-8?B?VU9VZmNEd1E3ZmZuZWVab0dWN2drWmk0eDl5ZDB4Rld4Z29mZ1N1OTF3WkJH?=
 =?utf-8?B?TWNhbERoVit3WStpK0RZTk15UUh2K1c0WlJoWGZsaVZFMFJxZmNUY1htRlhE?=
 =?utf-8?B?L0h3dU82Z0NFNUhtSkw3RXdRdzZHNlI1YkVMUndmaTFqV3dOYUdLR2tsUlor?=
 =?utf-8?B?bmZGWlJ2MmZpLzVzTmdINFRUdVdDbFV3MFp2ZlEyemQ2R05oeFJ3a3c4YURi?=
 =?utf-8?B?L29VRENEeTF2RFZKQXdiU3ZwRlhwV1Q1Q0R2c1I3VUlyTG9LZDhlTWozTnRa?=
 =?utf-8?B?TUtWZDdmRjlENDBUVDlrdFkvZ3ZONDJnMFZZVmVOc1RPdEtxRkJ4QTByaGty?=
 =?utf-8?B?WGRBbG4zcXd0NEtUMThOaXRqQklES05YZkY5V0NId2F0K2o3R0F5ZUVOemJX?=
 =?utf-8?B?UjBXbFpVTzl0a0FFRkoyaE83dmsxbHBEKzl2OTBXaklDZzN5S2ZnSkdGTXJt?=
 =?utf-8?B?WERCRUZ6OVQ2cWhpZEE0bXFtK2VpR3d6cXUxMFhmL0lqelQ5b01NVzZKaHRt?=
 =?utf-8?B?UkFSYWlvSnlWbXVtb0RJOWZCWGY0Ym5LNEt6TDdLRTUzbWZGSytnYWZWd2Fr?=
 =?utf-8?B?blNaUXp5ekRoUW9RNkkrZ2hCdThZZCtYWWpKdG5TUTRmeCtzR0YwVFlmWFBl?=
 =?utf-8?B?ZXFxb2o1M0RGR25zU1RYbC9tQmlkQlZXWXJhVVRpeDFyVWdkWDFmcy9tM0Rw?=
 =?utf-8?B?WkRTMTVscnFvK2tJNTl3dHdnb1R4TmJwV3QyS0EyQW9XN0hJeDBGMWErQ2Vh?=
 =?utf-8?B?OWxCdC9PV0h0eG0rM2tVU2hzT21DSWltRUpidzc3clI0TStQeGM5WXY3QjYv?=
 =?utf-8?B?a09kb1BEVHVkM3V1dVNDaE9pTEtkSWlycWdzaERETkFiaEtzeGc0V3p0VlJt?=
 =?utf-8?B?MU5zZmxqMnN3WVBrNEpoOGVTb2tRN1o4TXZaSjJSOThoSjYvOUJhdjRlSS9N?=
 =?utf-8?B?RzltOGhaaUloVUlkYSs2Nzd4aDlsdUErVThBcDdLQTMwUG94bk9WTHZJa0JT?=
 =?utf-8?B?MGZGbmNJMWJ6ZHF4VHpCZjl6ajcycTJMeUVHN2dLa2hJZjFtdkM4Sm5Yc0lp?=
 =?utf-8?B?bUdQczcxWG50SzZzNWpGZjI0VXpVQXZLQTJXRURuR1RzTFQ1Z2g0ZEdRSzhV?=
 =?utf-8?B?SGUyVlBuSlZlZXN2NzUxUjhTeG5WMW9GVmQwbnloNDY2UGFzcVZuemhyZE1X?=
 =?utf-8?B?NnE0RVZjMGZSZDlRNFB5UHd4QjVMTDN2cmZpWmZyODdMOTRESVVPU29pcVB4?=
 =?utf-8?B?WTczRVk0WDhEUEZaUCtqQy93M1NUMGxCVEtFSHFWTjdYYWd2Q2RKOHA1bUNn?=
 =?utf-8?B?TEpYTGRKWXR1OGp1RG1JZHQ4OWZHMU4rMnNYcjY5WEFzU0RBbnBkVUJYTnBO?=
 =?utf-8?B?WEp5WXR1cnE0U2NRaEdNOVYwN1lTZGtoQlhSRG1XNjVMWlJCZDFOMVVmWUtx?=
 =?utf-8?B?OXdmWk9XcnB3S1pueWZlck1ZeGpRTWVFMG9qVFIwN3dTYjRUcDh1Qm5QUGZP?=
 =?utf-8?B?UTEvSjhtRUxyVERGVlpjbDlEeS9qRnBzN3dLTXQvQ1AyOWVqS1JiZmtlL3Z1?=
 =?utf-8?B?Z1V5WWJXZTFlKzBvZUNLeUMvYmdFWlZQT3RyejIxdmdqam1zc2FvZ2tIQ0Jl?=
 =?utf-8?B?ZmVpdjZpdUg4OHpXdWczT2xjTzUwekJIZlgvSHdmNlRqdk1XUVIyVWpFbU1v?=
 =?utf-8?B?M3Y3SGhxaTZiQ1pETTFzcjJaNVZWeU9rWWxqeEtDRlNabVJPK2FkVEpOc1hz?=
 =?utf-8?B?UDRBOENubTVtQzRqV2hQSzhFZm02cXNsZTR2Vmxzb29NWHVtRUlKelZhTmJY?=
 =?utf-8?B?T2IxSXQ2VldMdG9FblBsdkJ3bGx0N1M5Q0ZMSVlDMVgxK3E0Vmlvd3FpSWx0?=
 =?utf-8?B?cHNONDZvV21ibitNeitsUGVFUGVvb1JLUmcxd0xvOFRXeVk5cXBrWi9qMi9K?=
 =?utf-8?B?eTBla3JuNFhIK3VGdFhvMENENk5yaHFqRlBNNTR5Yi84WkFwRGFoUFhmUzZC?=
 =?utf-8?B?WUJUaCtBbEc3T3UxRUdvVmI5QTZUNGxERnpJcU5qbnowWFlTdHJ3N3M3M3p4?=
 =?utf-8?B?dEltUkd1a1ZJbUw4NEVibFdqQ3RpS01QSnhBcGhOaXpmRDZOOGxyZStKdkhw?=
 =?utf-8?Q?e6CPsGdolFe6zyKY=3D?=
X-OriginatorOrg: reliablecontrols.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d5e526-2bcf-4a8c-3f38-08df1e5568ff
X-MS-Exchange-CrossTenant-AuthSource: YQBSPRMB0024.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:13:49.4687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70dc28cd-aa9f-493c-abf3-5c1ff69c0ddc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fey4NqnZtqhwg/rtKgHOcrKgvAJu73dzHaJN1lyWG7rn5pINp+NFHaIxdjP2sqZqeIlmw6ZxxL5T2Kd6YRokU4/BvDBVD45MKar7eHXTCek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTZPR01MB11816

On 28-Sep-26 14:25, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

On the RZ/N1D I can trigger a KASAN slab-out-of-bounds error by defining 
miic 6 in the dts. I can also trigger a KASAN global-out-of-bounds error 
by configuring a miic input with a value outside the defined range.

I don't have a RZ/T2H to test with, but after investigating the sashiko 
reviews [1], [2] I agree that there is still a bug when checking for 
miic_port_max. If the value in rzt2h_miic_of_data is correct and being 
used as intended I can resubmit the patch using conf_conv_count instead. 
If the fixes tags were added inappropriately, I can remove them and 
resubmit this series.

[1] 
https://lore.kernel.org/all/178955899323.22033.2372714834297554596@kernel.org/
[2] 
https://lore.kernel.org/all/178955899447.22033.5754427139793967412@kernel.org/
