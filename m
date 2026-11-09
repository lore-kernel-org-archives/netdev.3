Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794216121;
	b=lfLsqJyXWAshFVngS/+e0RN6NrMylRRv2eO4q340RdfVZNAy4Ro3bwlFi3T5H66nCijP
	 JCt4ACHGhYu32fxB7SAEyC1wQPnkkplLHqPxYMqIGzckI6siFDG3NmGvsdnWgm64+OC9K
	 IBE8YibiAAG9IiOBdmTxaimIqjYLT604Y0w9nFRKzlNdCTNusqaQlSAZSVh+OrWbB8qIH
	 1AfNB0ep+/4ZLqFr3Hk4V3N+9QcwitzXWKuuQGb+wiU8oe39cWCbpoK55iNF+PajTYYLC
	 9RsbWSg8sy3/RPstZJSNaeRWaBVSC44F0v+DkvH39mM7CaG4cr7V1mxlPPoHowNYFvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216121;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
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
	bh=xQRRyIC+6/XWs4N/lFb0enmycPYzagR07aPHxB2Wzqg=;
	b=XjJ70Tuh4bxB6tUOyFi+kcbYmX+EMSUlmv5qGw2dHSjnk0YpW9ifDq2S2gRkmbwtZ5Tq
	 G2z2QCooi9XQl0rPLlZaNCAc6bIrUkfxCHldVGInStnMC9/u/qMrZhQZDhsu/fzpUVPAE
	 QCIPQIF1blsYvA5nBzdWsYU4a3e6/sO6dMonBwptxpBA2etbzC7WPou1DLeU60TxxMXhn
	 MZSr7pz17A47ENaEw1U1Eo3j8qaB1Nu/CXY+Uwy4Hke3e/eDBkCUfYMbgaLJPJHrRlm/R
	 zLQSupz83Ox4vbUbUBozhEBgzgN9/+muio/ChIU0a0BkcvXphKf0iiiiFWavVjA4XQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fy9XTqjX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.54
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20972606A335
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 09:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20972606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fy9XTqjX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IROfwAkR7E0oMbleYLyQBnkSTgDmkQX0gG+kLiAxfhyweGK0oXsMxRGxjkkixBhIPk8PwGlbyj/+mhBZR4fDzyZdcbvWHeCi2vW9a3Gm0BB1s19DRSszBJ17NiKGB/IHO/uA9AP0xJboQLMXyJX/01fr+8HwWZseYkUl3CrA8SGKEisBLfo+q+o7lwvCE272gi36Zt/rJuez9Cxh/Cl5K3tLT8QbzgsaSFg+RfrHny83HoWnzbEUFrc2s2p95R76BmyLkNBi+g/7T68rmasiN5vMpH+r4cZbeUJyixqlJDfNthoYVJ1f9+r8qWrHfV+BQXUiRLjZNWlyGLvndknH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQRRyIC+6/XWs4N/lFb0enmycPYzagR07aPHxB2Wzqg=;
 b=mzno/s6ykm/KE55CxUHLfedpqc5K57QHktmpeK3Uzu0DPcQZT8c+ioaDEs/G2XoWq0VK47aeOkBIdiFboiBV6tMbdUVpz5zt9jwexsvUmM3hjxNWL3n1rQbEtsZa3lRhmSN182UNJakac6MHHbKYhZ/5tmbG5+z//ezt+b1p9naD7nvMYbbQ8TaOqRjkU7EcCMjPYRpHvcm0aFy5Dbm/Mjgn+0OJuJSwwwapM0Hh0Ee7cuzZsZJevIfaJHPX8gix3NV68RqU1NPSi0hatW3sQb2fd6fUhXsr/lTmgecs0z/gMoWNudaKFcq6FMBAmr0u5wNfTxnVyWknJtxIxbrTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQRRyIC+6/XWs4N/lFb0enmycPYzagR07aPHxB2Wzqg=;
 b=Fy9XTqjXlXKTG9/u6GWs5XbBmbE9h/PinV0g+5BVqViBPvgTJEGH04WW+zquBBtXhjGrzFp4OlCB08l47BQHed57eD/lKNHYmqbFeS4HTKMc9aIcmom+KSiub1F/54cZd6FXdfKlX+aSzOnLF8K8jGDxBsPu2+ki3Lawxf0++wRAWOAcmADlZ3WcgJ/IWJCWBDR6dNXwz19yzxLhbIpr1P16XBBYaP5+rcHeSoSsaLJgz2GVKA5hC/Fxw4URIhMBMXF8M4wS1JER1pOcsyl1Oq2D072NiFCEQWzWvjUxWEn+0smEH5WpcOvVWm1emLD+6jcoRcr33xW0xpBl3W8/+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15) by IA1PR12MB6140.namprd12.prod.outlook.com
 (2603:10b6:208:3e8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 09:21:28 +0000
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f]) by IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 09:21:28 +0000
Message-ID: <fa110faa-1947-424b-9197-0c6add014fe9@nvidia.com>
Date: Mon, 9 Nov 2026 11:21:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Question: net/mlx5e kTLS TX TIS reuse vs in-flight WQEs
From: Tariq Toukan <tariqt@nvidia.com>
To: Rishikesh Jethwani <rjethwani@everpuredata.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Boris Pismenny <borisp@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org
References: <20261022181751.1349984-1-rjethwani@purestorage.com>
 <fc0da060-5bf5-4289-8814-d25e6c422673@nvidia.com>
 <CAKaoeS1hj9XuM7ojLBCjGA=EXc2M-b+eRjC2Sk=8L_8XYeJ18w@mail.gmail.com>
 <4796023b-10ae-4172-afa8-9c7541844314@nvidia.com>
 <CAKaoeS3hDE5q7XGtPy4XKmGL54-+7Y-H9JyMcdz94FiQW2_ffw@mail.gmail.com>
 <9a8e3e1a-977a-4e48-ba9a-2b71700f6924@nvidia.com>
Content-Language: en-US
In-Reply-To: <9a8e3e1a-977a-4e48-ba9a-2b71700f6924@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15)
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
X-MS-TrafficTypeDiagnostic: IA4PR12MB932075:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f827d35-77a5-42fb-96c3-08df3e42d579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|5023799004|4143699003|11063799006|56012099006|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	McUyABVLkjAMs6d2jTxyRM2K+ICiGBdHgtFAk0IXvRYLsEBGMO2lRPIJG3teUTLHg8Mue3HNVhYVjv0McMYEBroC557Yn0T4Ibcf6I0fYxBC1F0DbAI/UIjGuZDkZZ/N14Er0FUZRrPJ+rfuhNxBHzMVeT+uKbsTG+6x+17SOu65GjSgoaRzfaqWi6GaCUj7+9XFxu8UVpAyaGv+k7gKkfTkp4fACaa9pi91z3psBJRo+6EukIOfLNnwJzf5lYQenNMzb8wh4E/xJUkJJYiRqXZELlpAwzGljW9bEBWE+1eUohDvRzPp3sio9adBTAknG1qIayr6TKk/fiJDGMnzpYbaXsrbQ2RWr0yDr88sOdteXRRKspa0PDX2J05Ct0Su6u3aC5iBRU6WBLGKbb5ZC6PPd7stDAyg/STM8S6zd+bAVz6IPqo2xVR0DzSAj0CKwIgoqTjHKzaSPdQ233K7TP+hkYbc5H9gSzBHiW06Si88wos5TviYax7VIAayFouhNfRzfzQvKVj6nbptAwAgMGv2xd37kPAKDjAa9KdnDdi5R0ajdt7RHYf93Q+8ODo9BhH0Df+mBKeplzMrWNTxN+ILF9Hut2L9debnUA5g/8ULY6z3RYG+QfhLIoCy7m0Q8pCKkaIjsEXqyNFH5++VyFryWMYy77GZNaL9y6MGPMQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB932075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(5023799004)(4143699003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGMzZnlLTkllazkwTGM4dGpTbmVMZzlPWE96Znh0eStjd2lIVVcvN3pTbjJX?=
 =?utf-8?B?bmk1dHoyS2hBZ3BGYUsrWVcwZitWVkpBYTJoR0c0ZWM4VkNmT2RLR0xWSmly?=
 =?utf-8?B?TDZseHNBZWlHaEh6eldZbm50aS8zN3pXa2pKZVNwSXh4OCtlUk1VYUJYWmU1?=
 =?utf-8?B?aDZHbmIrTXRKTFFaOWVERkVwUGhCYS9iMnhaeFdCNWFnRWxUNStvUHR0bWxT?=
 =?utf-8?B?WXk1dlVQR3BXQlQrc3RXTWpQc0FLaUMyYTBhNmNUSzY1UVMydzRKYVJ2WitL?=
 =?utf-8?B?bzlKSjRkaENGd2RLTU0zUnJxaktvTmx4eHRKanNDYm1kWmFWU2NBa2hKT1Rl?=
 =?utf-8?B?ZTJ4K1g4VXlWTXY4emY5YnhvREI4Qnkxa3RkWGZFNmZlUitjdEZKU29kMytm?=
 =?utf-8?B?MW05WHNBd0ZmSUpjSGV4TUNKT2R2WVppcjJpVldGL1lKbHhiREFYSmNpS0Yv?=
 =?utf-8?B?M1V4RXpsVzlSVDFzWndROUMzd3ZleGZBSTY1aDhVMzdIL2p4cFVibVhFSmgx?=
 =?utf-8?B?dTNlRm5zWFEra3djN0tNcWQzbzBmaWxwc1ZMT3BlT2J6YkhwUGk5Rk9pb0Fn?=
 =?utf-8?B?bTFSUXZzeUNTbmxtTmtBTkpUSm9iUGRGMWNucis4OTh0VWdkM2tHY2VIZnBp?=
 =?utf-8?B?NHc3eEVJOXNuMy9SNHhTelQ5M2E0OTlIV2U0NzhzdUxsK0RFd1RZQ2I2Y0lu?=
 =?utf-8?B?aXpvSVBxa1BMalcwcmhwbDVheVFQc0picUFkeUhnVkkyM3l4VStmN2xHblg4?=
 =?utf-8?B?c09Yd0dnVkV1c2N2bjEvbnk2TFgyOFdGSzZKckNvOXlLaU1nTnlueEU2bjZ0?=
 =?utf-8?B?dzdoWU9VdFExVDZiVnN6K1hhVUJDeXVqMjJMQnE5OTZCWHJYTDI2MUNKMldO?=
 =?utf-8?B?c3JPL01FWWtmWnZpekx5VStyTCtxVVh0T0dObEVSZUIyYkZSU1JZdldoVHZT?=
 =?utf-8?B?T0dmUkRCYVVGd1ZQaGZlWmY2M2c1Q2d1TWRYdEMzY1lMcm43UjVSZjdCbTAx?=
 =?utf-8?B?RGZsZnJ6K0FaWG5ENS9MNjJJRWdiVW5PWUEwSytORnFRMjZ4ZmVLQnk3WjZC?=
 =?utf-8?B?SmF0WndjZy95OTQrRThIRXU4L1dVcnl0alhYWmJIQ05GUGxOVm45TTRhR0lp?=
 =?utf-8?B?ZEJQYnA5ZU5DeTM1QlhKZ3dBZVNHTTBGVjRBOG9NQ0N4QmduRnVtYmp0WEZz?=
 =?utf-8?B?bEZON1RFYmpmbDlBZXJEYmJqcis3WWNjTFZLS21QWXQyRVRaUHMxQ013bWRD?=
 =?utf-8?B?bmczbkFaU1hOUmJRT2JjNDZXTS9JNlhLM2YvWjV5eGMyT21oejB4cEM2MVow?=
 =?utf-8?B?YjZsMWU5VHpVWnVDTEdCbVlyMC9NWVFpZlBQQ21HS1ozZ0ZuRXQ3ZWVsYllU?=
 =?utf-8?B?KzFrZVA5YUltdG9xVjVWalNtQlhMNDJuY2l6YndnS2dIdUwvYUdvckY2RmR1?=
 =?utf-8?B?WnlreTAwZ2plMWZjV1RRNmNwdEd5RXFiaWltTEhtTnU0eXUrOWF6TmdZb3Nl?=
 =?utf-8?B?Z0d0NHFwTzBlTVNPRlJrRXAvNGpvMThKZ3QwTmk1RHh6RFFROE9jZStVWkI0?=
 =?utf-8?B?Nkx6THI4Tlgxb3FDV3ZlenZpY0F3a1p2Z1ppTjVhVXZ0VWpSUWkxb2hSTVE5?=
 =?utf-8?B?UkpLZ0Jhanpob1pkM0NTb1k2aWUrUFNkUmxOZnJReXZkcEliSlBROHIzeWhl?=
 =?utf-8?B?SVNUUWVhWk5ZNytDcEFvUnV4UU9MZThpTk5uRnVib2pxOFI5K2xEY1UwTGZp?=
 =?utf-8?B?QmJDc2ZiSWJ1NDBteWh5bjFQVm5wdithUGtHTW9tc2JER1Z5LzNHZXRBeEU0?=
 =?utf-8?B?cWFXd0hQdjg1UTdHVHBsbnVVRHYrQlh4T0dra05LaXJPdHN2TnU2V2puMGg1?=
 =?utf-8?B?NG5XWkg0YUFLZjRWbXcvRUczMU0zemxsam9YSU92cEVXTERZYmxwK0t1dlhW?=
 =?utf-8?B?UTRNNUxLUWtJc0RudHl3QWc1TEh4aVpIUzRQSWVoREVtTys3TU1EY1RVWFEz?=
 =?utf-8?B?UUxhd0RacVlVN2V5M1RvS3pJeGlUVjlrUFhIc1I2QmtHZFowTU55VGVhRkl1?=
 =?utf-8?B?bExHekpWMkFRQ0k1bUFWOEYzcGF5NDNPNVdlMnlSeUtvNkZyQ2hpYk5PVFFx?=
 =?utf-8?B?L0YwRDI0ZkdwQzJ3MTFBWDdBYjBaM3JSdU4rZTlNTGRxMTd3T1p4bVljTTRr?=
 =?utf-8?B?bEwyVlhhN01CZ3laSkdWTE1oSWlkOGtwUnJHTzROYnpXRWE1dlJESVF1VURu?=
 =?utf-8?B?dDBFWTNFN25TbE4rK3RMSWU5b0NEMkc0ZGpaWXNLNnY0MHFXV1NSdWk0NlI3?=
 =?utf-8?Q?1r9iJZafUF14TnxZJb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f827d35-77a5-42fb-96c3-08df3e42d579
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB932075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:21:28.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFcfbsb4ZGLlC5oAX9CfN/f+hgSsh/bR7MTxX6N/+vufrOo9o1CILQ4rJbDuFmvx+eptX93iB936Xj0VbptPrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140


On 08/11/2026 21:45, Tariq Toukan wrote:
 > I'm re-running the ConnectX-6 Dx tests with the changes, and will
 > share the RFCs once they pass.

They pass, with one change to the drop below.

 > An skb on another TX queue moves the connection only if no other skb
 > of its socket is in flight

This also dropped on legitimate stack moves: the next skbs, queued
behind the first one on the new TX queue, hold sk_wmem_alloc when it
reaches the driver. So a move that the TX queue selection allows, only
while nothing else of the socket is in flight, now hands over the new
TX queue right there, and the check at xmit is left for skbs that
bypass the selection, like tc skbedit. No drops without forced moves
now.

I'll share my patches shortly.

Thanks,
Tariq
