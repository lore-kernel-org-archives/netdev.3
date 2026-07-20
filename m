Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E13CB2F6;
	Mon, 20 Jul 2026 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535954; cv=fail; b=MFoaFgAO7Su5ztAODSaOLJOThhSNTgyIgCa8HZ65CmWWU/6LHiPuQHzsUDKSihewgVJrVsnyy9ID22EPqcHKd58/yPhR0E0j2EqaZ6i2NYXNosdwbfJSCTCSVWNH2YHnJAebCne4FZy1VvrSeBJJ6mQj1/eH5BJIy0tWOcvKb+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535954; c=relaxed/simple;
	bh=kK8drwBcxUddTgUEqIbx/HTDiMxnpgiQuCnnszewhuE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pureFF9yWvmVKrAomQ8XdHc0O7KzLgJ8zaToZbgUJk0DxWKMfLcNcUicASodnoRYa2kCN2yoy6N0xr0XW9uzo6+v+kKcC8LIVPz2nKbP6qliNpxKkruLFuEaw9DCAwwYPhq5rIyiQAGZwaS8qJTJUsHfwunI3zVMLEbNh03KMCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=gLalkQ5f; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gLalkQ5f"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K8J2QK3738364;
	Mon, 20 Jul 2026 08:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=zr8h8ARSFTWuiHYd+HktqbPEH1minY0I3MW1JACxRIc=; b=
	gLalkQ5fc5PtsvSJ30r+0sh5892i8ROqRWVgAl9YJ6vEzLigRx4ivm4maUbVzTJY
	phawZjV2Ls4CT77FLIFwqmU9UclWyxQZgTOSfFOnekv4+enMSgAMCYSghBCuRxEA
	hmbF+b9eMuabr9E3V/hfbgTkggv0EYc44X6mThaVIzWRyc5ytN/YDMaS23348/dI
	AS7oGayvJeVACLIosUNgpdjUIM6ewgTXVHVJbhJvEPDdwXI4KS+EnAY1DVNPtNUX
	aBkchJ59No0qXC84QnGCOWTmRvf8u90h0SQWJoc7NQDQ7SJTSVy6ZbOyrPdcn8ns
	BCcqChBilEhtcYtg4bmBEA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fg0f5a09s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:25:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnAVgWYDs1xLTs27L34ENDMbngGCSllLh3g7sWOwYzYanR5WoxhEppljf3yopkpFaMLBFkwP9yBJuYnuii6d73GRoxjUEzzSmI49oVo9Ov/4FBDT2eL6yGIAOOoH/XDVQxX+Whjf2CMt14FPlfHUXVz+42//l67j/qfuZw7uQ6I829JUS60HOh25aBjddTBLR3EcLIVPc61ntlrWsctadEonBNw3zus3gFuy514+xbdu4M4szeAK+iFrsi3wK+pAgxu22bwFnWBznSu5ljp5Etl/y/McGkQKhDhxULqX3BhXMrpkDJMsun0rFxQ7cl6oT9jDDFLp+ksV8dpzx6NpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr8h8ARSFTWuiHYd+HktqbPEH1minY0I3MW1JACxRIc=;
 b=vPrBiH8cZzTjq5RXkGXD5+Vv2tcsjvcZmidZX7QFMDCPI0pE0wa1PK5UuvcxY/KQjXuRXSQpXNY9SFRST1nB1nLYYOzpcdzDr2J/ek6kQ6h4cNCI03cte303P4udRe7pukc95y/rb+z6llO0VDVytjNtx3sj1orW5B6oB/RhHjQf+vODlenpdWbaieTkDzE+xK/rmkJiNj/iMiKSKkEJUQKnlNpIv3Da4FcRAr28TpPgemFlrBlUgtMgzWPw02BrfjCOWff5acEeSlQdaGwvPhMxsj1ahPOsRAgHyJRCf1gbJqdaG7B6EF06LaQ1EQGQtfKU/2RvmRSzH7Zb/FNNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by SN7PR11MB7707.namprd11.prod.outlook.com (2603:10b6:806:322::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:24:56 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 08:24:56 +0000
Message-ID: <62b4a61c-1572-43ae-b5d9-edf0b298340f@windriver.com>
Date: Mon, 20 Jul 2026 16:24:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: erspan: set lltx to avoid sch_direct_xmit
 deadlock
To: Ido Schimmel <idosch@nvidia.com>, edumazet@google.com
Cc: dsahern@kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260713151435.1815104-1-yun.zhou@windriver.com>
 <20260720075352.GA2233846@shredder>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260720075352.GA2233846@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|SN7PR11MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fbc2ab-1877-4af1-8486-08dee6386181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xW9P0rMlIvTPcIajytnPvcA+co9rvyg9wPWiG1YVrnrz0TMViHVFDNZ2xuupJ/va7fR0+LKTezDI2D/aqo0eBmO/Us5WVii0Wb/FKchpKX24vxdWQC6AUaZQYNOJ5P651t6J4eZojD/vzr+ne0mZi8rArjCB0vc6H98dWy2gTlE+qB9neBCnfIG7he+FF8hQBjKARoGjK+HC0IlU51si4oOZZG/u7isgw3x2hLrLR2GY4PgbUsRatcuqeLCXziAM+zby9mz0O1lzn4w5pIOmWxFa1HhhsF1G6GMvNSCrs1IxyY2GTkOcD1SOs+RTDGh8gnuqVhYmzNvXcWnejc/VT/mjQZXXlDSyGZuGvIL38GsoJ0cwC0CrQmHSCGaUFQUgimNs2cr2CYQ63BshH7OiVseCsaSholsrYdhO/vxk0iZ1NhcH9NWUyJQ0RC+214c8iKiJRH2AdYjhW1L0b72swSc6mnxhWbW56hmCqWselFFZHkxysFn2q5++U4F1UQLzs1Hi+Z1yLRII5V6XDp1oLMgj89bECxL4VAcLOE1he0oHlK1hdtZmxRrvDxEu8EAOiYxMrG7Je+2cNVemOjuw6IZTKDAmjVuBPuPUBGR1W78FOLpRarW2Pi/tUpQEQ/Li1xfNMcmCKGdRp2jwAl3megFuI/4rlO/dfeH/B/POMY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFBybVBKd3dNR3FlRXBCZnVYZG9tUFg1MzRYQk1xaS9qTzEvYlc5ZjBvUk5k?=
 =?utf-8?B?WW5LKzQxVERHSkthVlJ4OW1Ba0pLbytHb3o5aXZZc2w0OFlvN3ExenlHdVBK?=
 =?utf-8?B?NjJIOW5LRlF6MmlndExIOGd1cGQyR2NwYlBxR294L2dpcUFWekVBNmVsUFIz?=
 =?utf-8?B?UFpobnFVLzhWbEhKK0E3dnRCdzNid01weEIyT3BiSEhkMStsV2s0bXVTdlhP?=
 =?utf-8?B?c3hmbExjUXRMb3hWTDlCNmRXcnR6dmd5ZVBObURpYUJndFVHdXJlZGpQMzJa?=
 =?utf-8?B?K2RDb24yTlh1NWJ5RWJKR0E4bUY2RzlCRUFjdm04eXBjOUZQNUtsN0lQNTlN?=
 =?utf-8?B?U1NXSFE1RVl0MWtOdjFZQ0dWNGZvVlB4RE1GSkVnSDRxR2lEOEJRSmd4WUl5?=
 =?utf-8?B?cDkwODhHckd5MmlwU2pQR1BlYlJYeVBuSXpVd1E0SjdycGQ1MEFjc05qRG9X?=
 =?utf-8?B?R0ZYV0hDZVNiOUlqa09JekgwWkI0RFVTUWsrNzRzcFNMc0RLejdzYit5T2c5?=
 =?utf-8?B?UTVuU28wYmtRcld5Vm5CMVJ5MnNoTjRRTVMwZUttOXgzZzZ6R2lNNmtFR3Vo?=
 =?utf-8?B?STZjRDM4TjFFb0dDQ0FFcTJZZitjNCt0YWxPUWFCcmVZV0RXellOQWV4b2RI?=
 =?utf-8?B?R0NSVE5NSmg0UTlld0hsZGZURGE4WUZxdXNQbVRTYi82MHlIcjBMZVVqZVF1?=
 =?utf-8?B?aFJaNWRlUStEenNRUEhKOTNJTXo5dk5JL2ZwaW1QbUthSXNKdXpVam90SEt3?=
 =?utf-8?B?VUJpUDJ4WTlZSHhrbEpTdGVvaTBqOXUvbnNTdkxINGVqdVBxNmpZS1pwbDNH?=
 =?utf-8?B?eGFGdXB2UFNkZUdnaUNDd0VKWUlXREtPdk1zZWRYWGZ4NlFuUXl0bytzcUJs?=
 =?utf-8?B?TmdXY1VuNnBWdjhuemFmZGd3WCtZdXpvVjhyVUdUek9FM000OTdvVjFPZ25V?=
 =?utf-8?B?NVVENGMyZFRodGdKM0VieTdvc21iem9nQ1o1N1I2a2VGK1ZuZ0s3K3RmcDVj?=
 =?utf-8?B?NkY4TlFYNnQwMkhZV25jVTJNYUt3T212NDJjY0lST1JHczJreWVHU2liMng2?=
 =?utf-8?B?dmp3eVE4YW1ERXZtU2xMZHpyTUljdytNYmJqKzV2Z2pZTVVYa1gvS05zeHU4?=
 =?utf-8?B?S2gveUN4YzVDMmtBSTBpRzRWUUgxRmo1US9IaVBnUG5aSERBS0dkUnlhVlk2?=
 =?utf-8?B?bEV2YTBQd2V5ZHlJRE5LY1ZyT0VENkVwV0ZSc1kxeWNMTy9BMXhPTjY5bzI3?=
 =?utf-8?B?ZSs0MHpqVnV5Rm5XWTkrb2k2eGx2blNqT0NtRC8yck13bVM4Y1FTRlpRUzJJ?=
 =?utf-8?B?ekx6UEZvaUdBQUZ1ZzNwVjFDNVVCdmdXZVA2TytXMU4xRHpDTWRwTWxhOXpI?=
 =?utf-8?B?aUs5VW45eTVDL0ZVU1l0b2tXYVVpNGluRDkxVnNxaGJmZXVlVzhrS0xMWEUr?=
 =?utf-8?B?K0ZjV1BCZHdDOGs0WkgzaFZ0b3lPaVByTUNqYVQ4TjE4UlY4UHcva0NWTDRV?=
 =?utf-8?B?UVZnb0RNR2RCR3VVU0I2YURhd3RPSWZ2V3lFKzFyR3hJdGlPeVpBUnRQL0Ji?=
 =?utf-8?B?UVVPalJnZG01RG90Zlp6T08ybWw5d0ljbldqbWh0MzNVTVNwcWdOT0x1VC80?=
 =?utf-8?B?NnRhQ2NTb1lJWHM1OS9XdG5TeWVteTJ0WDVPdUlITEkzbklRNm1xSlREU2kz?=
 =?utf-8?B?K2xJU0treGhVdHRiTTMybzlGelUreXU5Zkc1a3l3OXkrdmVvdEpmZUp6OC9C?=
 =?utf-8?B?RllYZzhQVGkydXRGY2h4ZTBIeXdTelRmL3dwSGNxYVUyWEk4WEJlbjBhbmVL?=
 =?utf-8?B?enJZaXEwOWVrSjhNWk5ZVmFmTFRIMk1qN0pSTGVRWTF4dkpUc1BCS2dVSll3?=
 =?utf-8?B?WFRlNnV1dVJFQ1VEaGxOSzM5RzdyVHRkZVNwUEhJaFNOZy9hV1VNbVJKalpO?=
 =?utf-8?B?YWR0T3BqbHlRczVQWVRJTGpyRFFZY0VnYlk3NjNDMnRKaTNQRjhHczJWTDFN?=
 =?utf-8?B?WmdjZlVaUlovZG5BRkZOaTlmcVlTTExlb0xhb0JRZlRnd2YxMUpoSVhhMzhY?=
 =?utf-8?B?ME9VTXVGZEVtZFNhejlrcUNnR3diMmVuTFd0VUZyZkUvSkJrdkptSFE2Slla?=
 =?utf-8?B?TTN4N21yL3ZpTGhNMS9ONUZMaWk4clpXaVZaN1dOWTNFZ1JlZTJPQUdjdUxR?=
 =?utf-8?B?RlVWcEVaN0VzOVlWUkhrakt3UmN2K3hEM1ZxU1IwVHE5RmNBSEYxOTRFQlc4?=
 =?utf-8?B?OXBwSWFPcksrWTZVbGtJSWFFVm9oMVhRa0d5M0NmYXJqVHViMkVnT0x2ZUUv?=
 =?utf-8?B?bGplUjg5d2daYmpvZzlvcjhodVYvRTlXNmxHRngwL0ZGMDdFQXFQQT09?=
X-Exchange-RoutingPolicyChecked:
	fI0aDhzX0VIw0sOZpZIS+I4H759WS8uEJ50FwnG8MbliPA6n/6lghfcXwSkVdtBilnPAq346Mfu1R11TZLDuguxkzrh3VcA3INZc7FpSkbaKMdYJJ7LoWtx8YuFnS59xhCcMn38F8ekaEM9GUcgg2w37v9hZnwBxr9i9SrQ/n2NuLTO98g806I8PM6oRemOlvh687Q/DvDOu4pcpKw7HoV+8mVTiilTdDZG4kSCmMzS/W1Gu6EpOQtSBWABpl9gy8TS1JRFVR2kJUl+cuTTwp2esBlCSB9hrFOxe97mEfTHfXUFCK26op+0LLNWmdzgyTLz9Y8I0sEReFDjAplHsuw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fbc2ab-1877-4af1-8486-08dee6386181
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:24:56.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UxPlOynkbKxglhv6b6q0QMWAx9WC1bqzQIKXNSYR0Y57d2cxp8OlaLV7M1yYfyMGoMfBGJGkt+abg31QXrXJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7707
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MSBTYWx0ZWRfXwTejw/b5q4MX
 cCil+zHKzNBGnI3HgIeqPY4Pov0MdaRLzufOvhR7/QwQFduVcRV+LH9UOfmixHHvgGlf5iRecOW
 4W1VIm9WIwKtWAwQBLp/8iB2K2xRDTniajCbaGtZaVfwo2BboTb/zfGG2mbUvrC9UuW7itz0KaV
 qPI7kEZdqvLxMxAIGARVbMAUTUuCLR4Ufs/Ho3cZxnv59VYxFjq6ftzTii2d3yH5OLkmyAi9PCq
 6n0ox80VJi1kw/F0+5z2cFRm42FY8ewMXARYGR8yDzPzpHulyzFbINjyRsYBkKObs70C5auOdJC
 nYSTq+NQYe6juwvePFOsbDPk4TL+686xtpID9kRNym7NjHC4EkCalPJctcspv30Jm5vzp8Dlkvv
 IjQFlnEE5/I6VnnKz5WubbfIzb89asP6nPG2r7dILrso323o+RkMuRK9T1wMJ6rfNxHCLJZ+Ymv
 ErMdnkpYiy5lV9Rg+Fg==
X-Proofpoint-GUID: tEkj63StrK3a1K07_8Z7CaWr4xhlE4Aq
X-Proofpoint-ORIG-GUID: tEkj63StrK3a1K07_8Z7CaWr4xhlE4Aq
X-Authority-Analysis: v=2.4 cv=IM0yzAvG c=1 sm=1 tr=0 ts=6a5ddb5e cx=c_pps
 a=0Qqeoa/8LQ4SOC89qm8Uhg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=mhuot2Qyt4ZrMN8WR7QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MSBTYWx0ZWRfX8fB154NwwnaW
 aGPubL5UIiS0aLV5afp9eN3sZYrpxykPNZ3BLvWjS3JTaTGEw9h8Qxc3soSHM5lhTtBQm+GAd9T
 b7jO4DHx01umrodvvTHoR6drmSlrc69b9F0zjI24mUVR8cOD5ArH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200091



On 7/20/26 15:53, Ido Schimmel wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Mon, Jul 13, 2026 at 11:14:35PM +0800, Yun Zhou wrote:
>> erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
>> nested acquisition of _xmit_lock on the underlay device while already
>> holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
>> the same lockdep class, creating an ABBA deadlock:
>>
>>    sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>>    ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
>>
>> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
>> This is safe as erspan_xmit() has no shared mutable state: o_seqno is
>> atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
>> the sibling device with identical xmit structure, already sets lltx.
> 
> erspan_xmit() (unlike gre_tap_xmit()) is performing non-atomic
> __clear_bit() on shared tunnel flags and KCSAN will probably flag it.
> 
> Eric had a patch [1] that changes erspan_xmit() to use a private copy of
> these flags. I think it's better to wait for Eric's patch to be merged
> before setting lltx.
> 
> Eric, can you please submit v2 of your patch to net?
> 
> Also, doesn't ip6erspan suffer from the same problem? Please try to
> reproduce and fix.
> 

Yes, ip6erspan has the same problem. I will fix it in v3.

Thanks,
Yun
