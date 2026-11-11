Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794415655;
	b=GQpqaN5zqfvNZyXDbY4jDxcAb8pFYFOu715FZFtw8E3aAnH/JhB6b37+pZ/88yr1eamh
	 tVmBYiOahOyr2/N9UC8ffL9EsAPI3fYh+Jq9iP8v+czy9tXcZLRHN09Oc3K+OljZAAu9u
	 2jAC8WV/zyTZ6Ikfz9/3c7BE9MnBm9nlx+5kp0lBihzWmxbwvlsr12Y10YVNj6us0Pu0p
	 XPx9fDfDtNk8zsUg8w1IXFt53fhiAlT6r1TkpMCcTXuol+3Dq+NfPkVqFEJuZFnoq7EYn
	 4nEvTmatNzQjy519HJ/eOT7TmmXornM2j/9jF4dxQXchQmaT6PZlskvpEgDTTf2TAUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415655;
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
	bh=EMiAQBOiUz2ChvkBt8DRBDunBPlqeujwYF4d3JR2Pto=;
	b=lD8qxIcg2oEh6QlJVBUCmSK7Ifwc0QT6lOs1/Hqpn+QfX9X6RDRTH6Aes09cqcojEfJ8
	 2e6xAi3XXMKkzxTqvDWIx0v7okqM2ToqbQkbCLO+a+TC1ifrjrAeAMG7/Cgh+yfAFceC0
	 LgtWuZOzUOQg/jXam2sTXNsVwdG1bE1ltJRIDft8BM7ge83O82qwZ7T6UBBeajPsqVWNi
	 unFJC+8as3GUYfK2ep2+cAA4tutngMh+jvOTV1whbvWYlkrAYfHnRK1/wufjVjYCcTWxO
	 7f1C39As+Fpk0DFZHUg80RBdFzNNeVVOlkk1uLKo+a6p10qQVSuva6jQyP+gGLhtZ7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gcore.com;
	spf=pass smtp.mailfrom=gcore.com;
	dkim=pass header.d=gcore.com header.i=@gcore.com header.a=rsa-sha256 header.s=selector1 header.b=DMoDdxwP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.98
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021098.outbound.protection.outlook.com [40.107.130.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD177606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD177606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gcore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gcore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gcore.com header.i=@gcore.com header.a=rsa-sha256 header.s=selector1 header.b=DMoDdxwP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHAlGdB5E5iwZt5uvFV+owXZofs6UJ3nOpc8E16J7aRzilSYqtirOb2NRj73lKkAl9nKB56kGp8CwJsGmanQYS11f50oWnPpxpSHZC4AH6DmtX6Ie0KcUK4OhCSECl697XRGqlAwevtiKnf5uVNOI2PTIsUtJm6WQKjfmEJpLOrxys0BQUK8isu8KnsJE9BvL40LrNJcn2J7wWzGuk/VWd4Q/qrAslAPoRHw94kt6QUmApsjTGHhoYuM6YVmxKvB5JtSK8oO9CTa8RA4LISpUOX+B595A/U8UfqvEvyBpeRj07wB0aPeCrL+DQS1+FZjzdnbyM7gIqEyu8ci2nTZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMiAQBOiUz2ChvkBt8DRBDunBPlqeujwYF4d3JR2Pto=;
 b=wb33Q/eC2aHbwn7HVYdp0v2hgnabNHBt9hVLgxm7B3GpbKe/BSLdwTbEGHgYiqZMpk1uRq2o8mUfPnXG/BAZBLuDB+Oj7c+DDVYB1dNx/+rOVXfAHjlHtsTsdwI7cwDh2MQ4NOdUnYL3MznmZchc7HYD/TI5EkLAFuhQJLyPtMqOGqJ3IS/w5AS1Jv2qBoIML1tyMyL3L/YrJpch2vlsDG1wgC8S2ASj0PIgNZA9IGTOpuiOqMlgdc98I9QJhkMNlVvZFqoAKokwM8X38rIJ0uLuJheIRi/9Bk9ldGfeuCHWS5OnMqZvGc8Iwo26J5YLcGCexYrXY/U9zPxopNNXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gcore.com; dmarc=pass action=none header.from=gcore.com;
 dkim=pass header.d=gcore.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gcore.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMiAQBOiUz2ChvkBt8DRBDunBPlqeujwYF4d3JR2Pto=;
 b=DMoDdxwPLcI09HPWRyauqOE3UoTPIdX1ZlkwXppU5YP8JXOAuaoDXolHnxWLQO3UkeSNsp1kiINaQ5sEHXsxY/SenA9gSYg74wNsMb+2JPusTDHJ1KCNph4W9l1ZvpxQLwPiPn8emCy5dBRzHG+b8+9LtOP1GvhMJQCePsJXKajFKpKnkubq4B6YM2laxUKnoRr/MQJPDjt/NO1Ci43MxQK/SJ37CARgOg08SLRNGPlHxoe/K9dQRtH9VeYW0ZXnI8g/je8DXQbRDUUd1rQAYpUkyw8ux99jWtHP9+JkSFk5XHkXR6UcvXTiRAXw0477247Kb9Z8+2870kYuVJKGmg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gcore.com;
Received: from VI0PR02MB10572.eurprd02.prod.outlook.com (2603:10a6:800:203::5)
 by PR3PR02MB6043.eurprd02.prod.outlook.com (2603:10a6:102:2f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 16:47:30 +0000
Received: from VI0PR02MB10572.eurprd02.prod.outlook.com
 ([fe80::6eb6:a37b:93aa:fe19]) by VI0PR02MB10572.eurprd02.prod.outlook.com
 ([fe80::6eb6:a37b:93aa:fe19%3]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 16:47:30 +0000
Message-ID: <1ef4ead0-998b-498d-b581-353519be1e9b@gcore.com>
Date: Wed, 11 Nov 2026 11:47:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: add SO_BYPASS_RFS to exclude a socket
 from RFS and aRFS
To: netdev@vger.kernel.org
Cc: sashiko-reviews@lists.linux.dev, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, Kuniyuki Iwashima <kuniyu@google.com>
References: <20261109014547.81555-1-vitaly.zuevsky@gcore.com>
 <sashiko-outbox-205984@kernel.org>
Content-Language: en-GB
From: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>
In-Reply-To: <sashiko-outbox-205984@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0026.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::14) To VI0PR02MB10572.eurprd02.prod.outlook.com
 (2603:10a6:800:203::5)
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
X-MS-TrafficTypeDiagnostic: VI0PR02MB10572:EE_|PR3PR02MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 5723bb55-20b3-4cfd-41f8-08df401379bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|22082099003|18002099003|10067099003|11063799006|5023799004|4143699003|56012099006|261028144727099003|261026121527099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003|261022075727099003|261102123227099003|261026140227099003|260925021911599003|260925021311599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	skqSp4gVBVMYr2ZaVctxGeUvWJ0XNlYb5jSzqiO+SI7Pajn/m4jtHtv2CWsQWUx6ovTTL0ZhLTfb1EDySAAyUfsz8aHzxOf7Sbs+/VOlY/pofv/7NTbQCVRsGlQlf3FgKmzMUpvsp3ajs7nz2v5yrycpZK/l2rrnYwByNfMB67bvbw/DzBXwdi2zkKuNRgqTxoJ1H3/UCH7jxlepFAnggS9Wg8WM74Dzon+ktxkpelaoJmISNkvYWWohg2JqVsny0j7RcZ+iUJ0PFnaS05Rbwtvv0sb/A1qokYxJVoa1mLwITIz2ZYhgGUHAcqmREHL5elei7CtRGEb4ja3PzELnDax07cBx1lscQ2y+PC6bk80B3wcR5Gp9yzACl9SH2G68G8YCHemGpvqVw4LctzYdHvSCxH87ur73qnoj1/pMTVskjbwTVdHfd1HRVIE4aQJBmFCamIEZ4jAm2yoGQMyWkceB9FunDD59oWZFawN5bQT6krFoaGMlTCcQd6RQlX20s5oChHP3p3AAUQqK2ifdOUM4YNz7n2e09wQN1EqmwPQ7KErv5jF7hxsP4yLcMkJYYxhZl5uPWpUqDhP0aRrpmbf2LTMrK3jWQn4NZYdwhFoTbajAcI/ViOQIZ4wh21V5ZFUJccIL2Ao7vsZzKlO/P7KrXsawf3L/sP1trQKfSA8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10572.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022075727099003)(261102123227099003)(261026140227099003)(260925021911599003)(260925021311599003)(260925022911599003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDgwZjhIM2pUeHlpbDNha0k3d1dabTkvZGRTdmgzOHAwVmtrZzFGSUd6Wjhp?=
 =?utf-8?B?VDhuVklGZXNhSy9ZNEpMYmVxb3JDTkpRL2pIK2w4eHFuZjFmaDM4eDVDamcw?=
 =?utf-8?B?WktXYlBveXoxVjhoN0NpM2RhQXZSTU9BK1FuN3lzbGNsUVN1bXlsMXVQUDRn?=
 =?utf-8?B?cHd0SlhxNmt0Z1p4TWppdG55Tm11NDBzNjZrRTJHNkdIZmdnTkZmcGV4SWc4?=
 =?utf-8?B?SnpxVTdWMk1GNnVXQVN1NEJhNkRJWUdLN1M5cGpXYTMyVmZBNUdKWWl2SUdV?=
 =?utf-8?B?Z05KZWxqeFVhSzhpMjU5NFNTSCtJUVAzcWZCbEpBckIvL2xEeFlIWExYMXFM?=
 =?utf-8?B?Si9ER2huS093MExGb0pqYkZHMEY2WjYrME1nR3RxR3gvem80N2NpcUNLZEpO?=
 =?utf-8?B?Uy85WEhFUUw0dE5OcVNSVW5mK1dsVGQxS2ZRODc3eUc0ODdsOTIrMmRaUXhF?=
 =?utf-8?B?R2dqRGdNRmtyWGhlbkY2YVVNTHBKdytjVE5tRVduUlp4YW4xaFZjMXpRWWpC?=
 =?utf-8?B?Tlp4WTgxdlhlMDUzL3I2akN3L2Z5MUdqQTYzVkRDY2tkWk4xemYydE93NklC?=
 =?utf-8?B?ekVCc1k4TWMrTWJWMmFSZDhLanU1QkhsQk1tcERYUFlmL3ljM1dxK0wrOXRT?=
 =?utf-8?B?b1hkNm4xSjVxdVNON2dGSTMvSm1FeXh2Qk1QcnRXUkhNTWJreCtWcWhrRGtq?=
 =?utf-8?B?ZkpWd1EvQURMc3phWTEwUXFraklZQ0NxbVMzTWd5d3kzQ1JDcGNpaW41MlFM?=
 =?utf-8?B?OUU4aXA1MHhKVm1tNEUremNKTzNkU0t6U09VRkx5d2w1cnI3MTFzNFNtaUww?=
 =?utf-8?B?MkN0TWs2YTBWQU5HU0JVSVVPTVVpeVBKU2VJQ1NBcHZ5UHV3dS9IK3cvTWhM?=
 =?utf-8?B?QXFMcmNPcGw3YTJJTHVIUHRhWk5jMXN1eW5vVk1jWUxia0plK2xROW1kdkRs?=
 =?utf-8?B?VjQ4M3c1VkFybEZJdUMxMVJ0NXA3bTY0eXhwbWxpVEJMZkQvOTZSYzdldlVi?=
 =?utf-8?B?S2U4S3RCejF6ZVh1ZDJvT3piRkNSSWxaekkrTCs5Q3Z3TnBGY2VqYXRCRnNi?=
 =?utf-8?B?SlFkeDJoUlFTWXhBSFFJbWpCY1RPV2YzNTJUT0hpZUN4aVBaSEV1YkNQa3RP?=
 =?utf-8?B?aHhROCtMQmZYdmpKeFJqK0JGSXVvZzY1M0FvSkZwazhWYlZweVhtTWVXeWVj?=
 =?utf-8?B?NzZDL2tmTnlteDZLZVBPZDJ2Yk5YcnhFSCtXeVVqelI2enJnU1J2U0dsUzlN?=
 =?utf-8?B?ZXVjcklQSFYvRTVqTTJJVlNCVWxWOXBYNDdJSFgyeTZXRXd4Y2Y4UlBrb3o5?=
 =?utf-8?B?RnQvazA4eUxJZk1Gc0ZnSWlFalZBWElycG5SRkV0bUVYakhBbHJBU1M1UFRk?=
 =?utf-8?B?dDErNzQxWDVyYnROUFoydXc2cEpFRHJHdXZEcGthZjZoUzFCVUcwejBFamN6?=
 =?utf-8?B?SEN0VGZoMEt1VnMxcERKZUgzMktTS1d5Y0Z6OElrTWIxdmlvdG50ZFFkMWdD?=
 =?utf-8?B?UXd5T2k1ZDMyM3dJK3dIbEp2eE9PaU9BMlk4Rk5kMy9PUitHQXVSYS9PaUpI?=
 =?utf-8?B?NkNPQm03anlPaSsvMGJBcnpIbWVMMXR3TUFWaXNKczNPZjFCdXlvUllQNlk0?=
 =?utf-8?B?NWRSWjdYQTNGMkkya2s0Q0VxS1ZrRGFqbDBOQVFnK3JaRC9YT0pZNERhYklE?=
 =?utf-8?B?YVNORnREc3hROGpVZkgrTGIwVS9GOUxWMy9mVDBJenEwNm5JTHpGbS9SWGkz?=
 =?utf-8?B?TUhxeDd5dFVIZnVqVUJiVVVjaURzbEtXL3BDV3F0UVJ5cG91SmxmRWRHQTBE?=
 =?utf-8?B?RFE1aERIVW9WRzVVdjV4UDJLZzdQQXIrcUFjdVlVbWlrTDlzbGJnYkR0VDF0?=
 =?utf-8?B?cXZzZjYxZ3hPK0FzTll2UDNNcVdTaW9DSUNtZ2ZYWVdtMzhBb2FaOXllZDRD?=
 =?utf-8?B?UmdlMDdBcmJNNzJUdDdRRU80WXRRdGE0aDJVWjJESGVoOXYyZVNGUFdkMUNs?=
 =?utf-8?B?ak5BaVZ1ZW12dTBaamM4b0MwSE9lTndSdEhVYld1MjVuUDZOeGl3UGlMRHdZ?=
 =?utf-8?B?UkppSEo0T3RpTG1kVWZRaWpoUzlSQ3pvTVFydlVtcmRES0NxamNUWmUrUVl5?=
 =?utf-8?B?SVE4RGRsQ0YrMlBwcndxVW41WHorK2VvbExWcXViTjVWWHpBLzgrTnJnYm5E?=
 =?utf-8?B?Q0FZTXBsU0duYnd2QjdkZnRUL011cXhlS1dRRXZ3cFEvQVJza1dYOFJZemFN?=
 =?utf-8?B?dWxrdTQwUktjN2E0dG1aTVU2c2tycmF2SkkzS3Y3aVllbHNoWnVSaEFtUVoz?=
 =?utf-8?B?bkQ1WVczQ0dlbnlqTkJXY3NtdGpJcnJVMlRhZlBWUFlUbXNLMCtHQT09?=
X-OriginatorOrg: gcore.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5723bb55-20b3-4cfd-41f8-08df401379bc
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10572.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:47:30.3162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fc8b6b47-53ef-4529-aea4-8c6c20a851cf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnyaQm8958en9hmGC9ADzTXAVcDtoe9n3fsckpMPZAYcw5pcl/5HmHR1PWONxLrooEm+431tcTYuGeyiKM+6NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6043

On 09/11/2026 20:45, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] net: race in sk_setsockopt() deleting RFS flow before setting
>    sk_bypass_rfs
> It also noticed 1 related pre-existing issue this patch does not
> introduce:
> - [Medium] net: file descriptor leak in sk_getsockopt() [1]
> --
> 
> commit 0bb55ec9420355430d450dec603d8adf895ff281
> Author: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>
> 
> net: add SO_BYPASS_RFS to exclude a socket from RFS and aRFS
> 
> This commit adds the SO_BYPASS_RFS boolean socket option and a skc_bypass_rfs
> bit in struct sock_common to exclude a socket from RFS and aRFS flow recording
> and deletion.
> 
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index e2401d735c5a7..00808217aebf1 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
> [ ... ]
>> @@ -1597,6 +1598,14 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>>   		reuseport_update_incoming_cpu(sk, val);
>>   		break;
>>   
>> +#ifdef CONFIG_RPS
>> +	case SO_BYPASS_RFS:
>> +		if (valbool)
>> +			sock_rps_delete_flow(sk);
>> +		sk->sk_bypass_rfs = valbool;
>> +		break;
>> +#endif
>> +
>>   	case SO_CNX_ADVICE:
>>   		if (val == 1)
>>   			dst_negative_advice(sk);
> 
> [Severity: Medium]
> Can a concurrent receive or send re-record the flow between
> sock_rps_delete_flow() and setting sk->sk_bypass_rfs?
> 
> Callers such as inet_recvmsg() invoke sock_rps_record_flow() without
> holding the socket lock:
> 
> CPU0                              CPU1
> sk_setsockopt(SO_BYPASS_RFS, 1)
>    sock_rps_delete_flow(sk)
>      _sock_rps_delete_flow(sk)
>                                    inet_recvmsg()
>                                      sock_rps_record_flow(sk)
>                                        /* sk->sk_bypass_rfs is still 0 */
>                                        _sock_rps_record_flow(sk)  <-- re-records flow
>    sk->sk_bypass_rfs = 1;
> 
> Once sk->sk_bypass_rfs is set, sock_rps_delete_flow() returns early, so
> the re-recorded entry stays in rps_sock_flow_table while SO_BYPASS_RFS is
> enabled and is not cleared when the socket closes.  Setting
> sk->sk_bypass_rfs before calling _sock_rps_delete_flow() would avoid
> leaving a stale entry if a concurrent reader races with setsockopt().

The record path is lockless by design and the table holds hints; a 
recvmsg() racing with the setsockopt() can leave one, which is tolerated 
like any other stale entry. Reordering narrows race-window at a cost of 
dropping the wrapper, consider:

sk->sk_bypass_rfs = valbool;
if (valbool) _sock_rps_delete_flow(sk);

|CPU0: setsockopt       |CPU1: recvmsg
                         |CPU1: test bit -> 0
|CPU0: bit = 1          |CPU1: preemted
|CPU0: delete slot      |CPU1: preemted
                         |CPU1: record   -> hint written

