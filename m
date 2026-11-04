Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793783027;
	b=duCkbFx0rLDntTOHbOX2pWUMVzQcEjXpxCoBDNbjgSqZesGaoITwtDysQWRiZovwCMtp
	 sKNEptbtKVJ+Cp5HVbofQPB4VOeUnq0FvazxGbhjJaqzwtZMisFtzm3bSCaVnZKI8tZYs
	 2YlUKcgrV7KTJ2VOXkcd5na2/t/0Rho9kiiITdf8p7EGC3V8CWHL5mEBvI8PUdgulKxsP
	 Wya0z7fYlE7PeC14SrMkyWJCqQ4OYlFfNypUGe1eALCqX8IZKbgRhaP9uGoQmbDKbSVk3
	 w4ltF8EXfzzX/L+opm3WSW7vpO8Lb4PUAdcG10KCdC2p7gk15FH2qXLOsfNVB5iUqVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783027;
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
	bh=JQJlu4Eu705KNYlVvd6QIRtjIbYoI9QZx5iQyxAATKw=;
	b=F/VFVrl8aR5qYCH9KVsEPOPRgMbbu1CCPe7Ml0gVkZleIsd0XfJxwZNjIa60Pg8q65V0
	 alTjG26b2eRsaMBUWjxN8fZL4oAn9/QGNFDINONBOr6wu/kZoIvsc5NVtXSI3fMyQb/kn
	 tGovbdYIRPBbxPixx9LwgF6D+58jFdfKUL1fRa8+tOUhf5o6YbHerKBVKWISicGDMU2Ch
	 NDP6NtJgFzq0kMMAdTFPtTN4wpXCxcM8M4T0efBnefolHwYtvTqk9tIlQJFaAPozwDIlO
	 zixXv3vDizB/MgR4yT69ZZ4apsR5vT68dijaE44X3XOpAR2f6S5ARz8HOM+y48nGrWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="gy/VpIhK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.7
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3B606A326;
	Wed,  4 Nov 2026 09:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28F3B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gy/VpIhK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL6ip/AFaVBANiB+UB6HcktYhM0FXUBzhXTJeaY7cSS3Jriw5218IBQu0rp77wblmj/Sk1FBJSg5gesAVIvQBNjrvT3ese1FzD1WXh3nfkbRsPd0RCnGEe7ShYa7qEda+apMuAW5MBQrJpKJfQe32k2T7VuCxwSC0fVzNuEcvxLCDWSLL+oN0S+lSWCRSXb6qcNQ/a4FHNvytBHHng8ZsxMhZwvY4c2M60yvaPULDQwhsTgGaHMLKFXzVmcvWJTJWX23xc1D3fiu50jjLNX65SWndtucsJGfKEvKbOzKrQGLfhn8ivAxzhzFypHp94/9BttohOM8t/4hGmYS4dlTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQJlu4Eu705KNYlVvd6QIRtjIbYoI9QZx5iQyxAATKw=;
 b=GS5LVuGvdmbGdd6j7m/a/3q8+HXGfm3GQJKLhZ6Q2QWMc2tTESSs6KQHYVO0ZF7DRuBcphYflW0mVAWLF+SvoyAe+5az+C7CTRatJs3q1ftcfN5efilm+rHazkzeDBlGniXmjgxWvZ5QyChH7v8jNQWNx2Jqk5zEOenc3DiLEr3kZqviYcNMY7XFHH0Av5YDSk3opjYtVk+1SXkNy08IFKuTLTPE/8WEXjXAr1JkjR7CJpFh62FHbZypIhHDW0My40B8uXl7r9n+Nx3TiNbe4hYqqCP/QxjWuR4jFKMyPTsKFS9Vt4eg0o90PuP6ddNZA6/VERQOA2zaURhw0nVmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQJlu4Eu705KNYlVvd6QIRtjIbYoI9QZx5iQyxAATKw=;
 b=gy/VpIhKcbHb1VdZfl4GmJf9Lpk266ZvjK1xJFIevwherGeQYOyYxMyOA0awvf/WX0ev4nT1XQ0Maiz3m7f1scK05/H4Pr+xMpzl0f/GOjk7M3H5QTmDkJq1orHhJYiP8NqTGyvI+Ney4Bu/gDsaUBYm+LnbmunW5KzOnkS9sd8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by DSVPR12MB999123.namprd12.prod.outlook.com (2603:10b6:8:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:03:44 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 09:03:44 +0000
Message-ID: <00010302-9cce-4733-942d-bc4930dcc3c7@amd.com>
Date: Wed, 4 Nov 2026 14:33:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dma: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Michal Simek <michal.simek@amd.com>, Stephan Gerhold <stephan@gerhold.net>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, Frank Li <Frank.Li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>, Li Youhong <liyouhong@kylinos.cn>,
 Joe Damato <joe@dama.to>, Arnd Bergmann <arnd@arndb.de>,
 bui duc phuc <phucduc.bui@gmail.com>, Yicong Hui <yiconghui@gmail.com>,
 Simon Horman <horms@kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>
Cc: imx@lists.linux.dev, vkoul@kernel.org
References: <20261102191922.4044912-1-Frank.Li@oss.nxp.com>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <20261102191922.4044912-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::21) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|DSVPR12MB999123:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc5995b-b626-4759-c6a9-08df3a528723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10067099003|22082099003|18002099003|56012099006|261022105027099003|11063799006|921020|261021121427099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	M1096serL62Mr5LrqmYsBUO9j7CTc5w331ZWFxam9Fb5NBtK3qgnzokKyEJRFndIc78SdABnS6DmbT5rmRfI8SEcekUprUGo0JT6qeZqYrxVMhCBMpD/BuaqDoB03PGCyYczswZ6DObzQ2NGWR4hRpYENXkthcLpCHGvNgVvYgweKc0aUIWUpSdS8diII3G9OlEGhd56FA/YNZNwB8IsewgnQxXk6tmafsZhOg1pUVIczFJ5uC8bLzenri5qMU2461Cy3Dv/pW3ytileZ2r5poH1WVGDmk4CYuEJYH9eRNv5MN/qNByKHrDsNY+LRqe620aPaXzIc82gnrL3toEYI+3ZLkXqLLA4rj1lU2ziJUMPw/hUhBvKatQFjsWqc6DFdmATXitBzHl85/hC7/EoMDiZ4NNj08abWtSmupNAeyxADrH4I75ooJHxr2b8JyynE6th7UMtsX6wmfLortcheTkah+nCim25KoR/IQvTnmgXerOwDCSJ9wzBs1RTgP48pan63DksjBMRVvUcwXCurJwS8bzb6XnqPfAPPDl6GGXP7n7w/t/X0FoliYzGB4N02hHXxPMuI5z2X3TOTxKnif1AKnzEM3dgA33G4t6BulKU2EPrfzaN+7a2z4CFnvMP6ll8MoVYNmOC7VIBICgz2wTq932DjTXfalhp/3K/YeKGW+dS/wWWCIs//5q1dSTFUHTYVKiA3hkSs0rkLwAZfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006)(261022105027099003)(11063799006)(921020)(261021121427099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261009223027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RStkRWJQdHVZM3IzUjR5ejRIeEovZ1ZWdWF4eUhtYVpXbWNyTGZzTVBvMCtX?=
 =?utf-8?B?S3N4UEpRYWdoZWdXMjVmM3ZCcWl1ZDhaYjI4RHhONkFBSC9Ubm5TdEJ1eDg4?=
 =?utf-8?B?ZXFBaEJBRG8xK05jbWJENW9USFNicVF6c2xKRjVVek93bWdlbjh2RUJBNFA0?=
 =?utf-8?B?Z01laHp0aysvZk10ekdmRldmbWJYWElSYlJibVV5cjRXZGhWOVJiR0N0NEhP?=
 =?utf-8?B?M0UrWjFUdXQxUUxPdkF3SHVNNXlWZEVUVGlvVGVXY1AwTDUzSWRta0xWOENa?=
 =?utf-8?B?cGhSMEROR2ZhUjBGWm9LOFdJVloxSE1MdmVnU2wvanUyclNBdVVJZ0M2WmRo?=
 =?utf-8?B?NmwwNXc4djVsYVNMaHN0OEVkeUdlNGtzWWlGTkQwck5vRUUyWEJyVUVhMEVx?=
 =?utf-8?B?bFBjb1BMYUNFQnlMYlRLVUxOTTgzeEJzU2NsMnZwNFhHaFIxbDZwSk1wMy9z?=
 =?utf-8?B?RE13U01kcU1qbEhaY0J4b09pOUFwSWJybEtQdjV2YkM5MzdYc0ZjaHhyTmh5?=
 =?utf-8?B?eVROU081Y0xSQmtFRXVnUURuejNmQ3ZxOFdtQlh0V253WXY3U040ZzM5eVcr?=
 =?utf-8?B?c0ZhanpscmxVQ3pORUNSemkxYVVwZGxQTzhoNUZ1amtUQVJqcDBFNDcrcE9E?=
 =?utf-8?B?bG1aOWt3MkJ4K0FPbkNqN2N3aHBqZy9RdUhCZzdBWHZkOVhoc0t5eHBaL1o4?=
 =?utf-8?B?QUlIUTBYYVlyQ3lRdXYwQlFmTjFBOEJ2TnNXZ0ZKV1cvbFlVZ3N1RVZlWXhF?=
 =?utf-8?B?S3lIL3owakcvZ09QOWNmSFVHdzJTc0V5ejJIbHFlK2gweXlsTnVYZlRLT2ho?=
 =?utf-8?B?WVhEK05WbHlLOXJUS3A5ekYwWWxMU3g4MWdBUHlzeXFNdlgxZ3dLNXZFYTJi?=
 =?utf-8?B?RElsOXh2dHgzTjM4dkdYZ1k2M2hJVm15L09GcWc2b3JRY1FzdndmS1lRKzB4?=
 =?utf-8?B?NmRPWXZSb0NCN3JINjJsRGpwQnB1NTRiVXdIYmJlOTE3Z0tNeHZ6QnRJaXlL?=
 =?utf-8?B?Uk1xS1RoZmpNSnZOdzFrcmlYaXFsV1dDbHkvTlpTOVMxd0ZTSitDU1NFdlZh?=
 =?utf-8?B?RWVoV0xBVVd6UnVXbHhvN1lOZlFnVEc4M3BMc1UySEVSbFNRTjMraVljbldJ?=
 =?utf-8?B?K3ZYc1VrYzZ4OUE1WUtNdHpDMzNSMDQrbkVtNTRsdkZDZ2Q4Y1lYVGVEYnZt?=
 =?utf-8?B?YlArL0FoSUhtRGNoSzdhWTJXUFRYRFliRUw5L3U0a3JwNzhENkZkWlQ1V0wx?=
 =?utf-8?B?VEYxTlZuUFh1aDFsdkg5WHFwU0d3TG5nNndPYjBZSGpRaDBmNEd1ZmYwb0NO?=
 =?utf-8?B?M1gyRlExbTB1bXdDU0RmNEwrY3JzaTJNNFBOdXc2TDM3VE15Z1VDeXBjeUh0?=
 =?utf-8?B?ejRTUSsrNERDbWQ2dndtUTNhVEFBVkFzQnpYWmVoNS9JendWYWxPaG00TU5r?=
 =?utf-8?B?dG1SMHJqaXdPWFdGaVBKY1d0UkdhcHcxSjU0bDRnVktNU1JmSjRJRE9LT3JF?=
 =?utf-8?B?cUFPakpESHJaMGdyWTZtcXdlc3J2R2FFaXJBMHRvelNWN3dvNDUzcGQxQ25L?=
 =?utf-8?B?ZWxsRDZRam45T1ZpZU9DeE02Q2I2dGZ0TjdrSHRnQU12UG9ZSi9NYVY4OW9O?=
 =?utf-8?B?KzlUQ0ZjWG1YVGJCWGp0MVJKemVzTkZCczJ6VWF5bCtsL3RvU0ZteVJTTjdS?=
 =?utf-8?B?SGxnNy9FTGFHSVdlb3A2emxDRHh2eEl3V2IxTGl0ODhFL2VheDRuWHJpOGZE?=
 =?utf-8?B?SSt4TkRHdVFJSHNjSExncGluM28xZDZsc29zcVJqS0tXdS9XbkNYbkxlUFhl?=
 =?utf-8?B?ZnVnRVNIYUUzMmV6MVl6VVdlUE1mTDJQbnhUb3JTblpKME9TYm92WlRwangx?=
 =?utf-8?B?SlBGcjFxNERISWliQmtiRG9SS3NNYXhKMkdOVXM2QTl2Ky9waHdhMFpSMzJ4?=
 =?utf-8?B?TlpJSXpnZW1NRENzQVBnV003YnloczlFd3hLWU5MOWhaWExtZmxnTXFITFBm?=
 =?utf-8?B?a2pLNFZmYld4RUtTMXhncWNDaVdwcTdmL0lPdjlrZmZBaVZSY1NndE1jZ1o3?=
 =?utf-8?B?bjZwczFPNXNUOTFuNlVvWWd0RTRtV1Jpb1dxcFRHSU9rMjlQNWxKalp2SXg1?=
 =?utf-8?B?YmF1b1lsamRkVTlQNmtJSlZxNWxNSkY3QklHSDdBSGN3Y2V3ZHN0eUpzcFcw?=
 =?utf-8?B?V0ZGak0vaHpaSGoxdU1qQ1lNWWJhQ2FPckJOQTFNeFhqRnZzTFJJdUNzblR4?=
 =?utf-8?B?cjJJbGJuUTVzK3psZzdpTG52aWdqTk9LVGgzNlhoeS9qSDhYWGxMWGNDdDlL?=
 =?utf-8?Q?F1gzSlDrwOCBQTq3yx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc5995b-b626-4759-c6a9-08df3a528723
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:03:44.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfSVdhtF5bNMlwpeCoPnQ0hAKMVsXri2bh+izg60ItUCS9ZoyMjwnpgs8fBUpoglBjBCVOyMpWMelcz5qyIKCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999123



On 11/3/2026 12:49 AM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across net drivers.
> 
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>

Thanks!
Suraj

> ---
>   drivers/net/ethernet/allwinner/sun4i-emac.c       |  3 +--
>   drivers/net/ethernet/micrel/ks8842.c              |  6 ++----
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c |  6 ++----
>   drivers/net/wwan/qcom_bam_dmux.c                  | 10 ++++------
>   4 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
> index 09b2abdfc9e84..d7ee42b2c1976 100644
> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
> @@ -303,8 +303,7 @@ static int emac_dma_inblk_32bit(struct emac_board_info *db,
>   		goto prepare_err;
>   	}
>   
> -	desc->callback_param = req;
> -	desc->callback = emac_dma_done_callback;
> +	dmaengine_desc_set_callback(desc, emac_dma_done_callback, NULL, req);
>   
>   	cookie = dmaengine_submit(desc);
>   	ret = dma_submit_error(cookie);
> diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
> index f0d6bfc6025ca..c68abd4643e72 100644
> --- a/drivers/net/ethernet/micrel/ks8842.c
> +++ b/drivers/net/ethernet/micrel/ks8842.c
> @@ -453,8 +453,7 @@ static int ks8842_tx_frame_dma(struct sk_buff *skb, struct net_device *netdev)
>   	if (!ctl->adesc)
>   		return NETDEV_TX_BUSY;
>   
> -	ctl->adesc->callback_param = netdev;
> -	ctl->adesc->callback = ks8842_dma_tx_cb;
> +	dmaengine_desc_set_callback(ctl->adesc, ks8842_dma_tx_cb, NULL, netdev);
>   	dmaengine_submit(ctl->adesc);
>   
>   	netdev->stats.tx_bytes += skb->len;
> @@ -567,8 +566,7 @@ static int __ks8842_start_new_rx_dma(struct net_device *netdev)
>   			goto out;
>   		}
>   
> -		ctl->adesc->callback_param = netdev;
> -		ctl->adesc->callback = ks8842_dma_rx_cb;
> +		dmaengine_desc_set_callback(ctl->adesc, ks8842_dma_rx_cb, NULL, netdev);
>   		dmaengine_submit(ctl->adesc);
>   	} else {
>   		err = -ENOMEM;
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 8a50cad1c104f..7e83c4b5f1931 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1014,8 +1014,7 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
>   
>   	skbuf_dma->skb = skb;
>   	skbuf_dma->sg_len = sg_len;
> -	dma_tx_desc->callback_param = lp;
> -	dma_tx_desc->callback_result = axienet_dma_tx_cb;
> +	dmaengine_desc_set_callback(dma_tx_desc, NULL, axienet_dma_tx_cb, lp);
>   	/* Claim the ring slot only after the steps above that can fail.  The
>   	 * completion callback can't run before dmaengine_submit().
>   	 */
> @@ -1565,8 +1564,7 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
>   	skbuf_dma->skb = skb;
>   	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
>   	skbuf_dma->desc = dma_rx_desc;
> -	dma_rx_desc->callback_param = lp;
> -	dma_rx_desc->callback_result = axienet_dma_rx_cb;
> +	dmaengine_desc_set_callback(dma_rx_desc, NULL, axienet_dma_rx_cb, lp);
>   	lp->rx_ring_head++;
>   	dmaengine_submit(dma_rx_desc);
>   
> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index cc6ace8d64371..1479f8362e04e 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> @@ -195,9 +195,8 @@ static bool bam_dmux_skb_dma_submit_tx(struct bam_dmux_skb_dma *skb_dma)
>   		return false;
>   	}
>   
> -	desc->callback = bam_dmux_tx_callback;
> -	desc->callback_param = skb_dma;
> -	desc->cookie = dmaengine_submit(desc);
> +	dmaengine_desc_set_callback(desc, bam_dmux_tx_callback, NULL, skb_dma);
> +	dmaengine_submit(desc);
>   	return true;
>   }
>   
> @@ -477,9 +476,8 @@ static bool bam_dmux_skb_dma_submit_rx(struct bam_dmux_skb_dma *skb_dma)
>   		return false;
>   	}
>   
> -	desc->callback = bam_dmux_rx_callback;
> -	desc->callback_param = skb_dma;
> -	desc->cookie = dmaengine_submit(desc);
> +	dmaengine_desc_set_callback(desc, bam_dmux_rx_callback, NULL, skb_dma);
> +	dmaengine_submit(desc);
>   	return true;
>   }
>   

