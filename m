Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794303797;
	b=w3eH37lJbK0vn5byOe7hCw8vwufuXvYttQ4h51SO7yZLxJuHpjY2ANpLL0toHJO8wtX7
	 Sr8BJP7xIwwih+rI6B2c9DPosC+dK8f56aD8qfMST/KPfpybeJD5DkSGztDLAc2Lf79Y+
	 tP7H81mVOAqU0zt7E4hcs/sFqBZ5BYIGS6VszasC5wBAwZlfbRXkYwHlo6RP2/0bY/isl
	 ogoD0CIY6cn0KzqZZ9kuOauQ+FrzcwDmi9zngn1RkCQIIO6Orffih9fTmw4/TGl5hK8bC
	 uAj9/vPIdLjZO/NzdmUwUfkMqXpYG5FW4vHw7oYi8hRRRM7oNAuNi/2Csj/x5tzDY3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303797;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=osjHsBT7GD7T4bNrjiFHy3K9kGONjjUqb10dwo8EjeM=;
	b=i7ZXrFF5Em1j+ZXc4K5lwwyaQxw2Jo6DRlguZKldIbHfpxZVWDBKFyDq3zYRye1VLXGt
	 7e/aI0CKRZHSM9hl8pZnbbWl8uFuJWtB3KcUEY/fqhnNRY4sA9LLtICWZWRHKAmB6kaEc
	 pI6J1WBvAo9efpSpndgdtKUb7rwbEI+jUqaEh5L7wshlZ/c7Y/tEq0MiFKaCTvw91Qc8G
	 VTXlxdsUKMfOgvy8uBb09TTSIyUfrtk1RJ6MmzJcxA/Or6jIOsgXIQ8F3cyaQRTaKx94S
	 wEQW+roFzsMRbJgofeRsRHxpEukMlAYBclEq3yzlyLQ0Dr4Fo8E0paTi7fU5zaxYbjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Tk61WP9+;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="aVPnX/lf";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581AD606B14B;
	Tue, 10 Nov 2026 09:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581AD606B14B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Tk61WP9+;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=aVPnX/lf
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7kUhv354984;
	Tue, 10 Nov 2026 04:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=osjHsBT7GD7T4bNrjiFHy3K9kGONjjUqb10dwo8EjeM=; b=Tk61WP9
	+j57Ve3P+miNxEYaI1a8syfrnad68YtWF1RQjY+ZlQ97AUcnttAzOSXNeOI+NT6z
	x4iKtBtZW84C7g4aHepGueEqohdDODAEJOCEl5XT4jsiDTUkwdV0clsMOYhgQhl7
	B5CsQkrHLg+gDk95bKthnLvF1JkkxOe9eFCCe8jRVk/KlFMvWel0lYnrfcB0RWs1
	Cw/3jrh+g5hpccg4IbGs9RDvMoslcdjCmYxqLoGykS4EzN4L2RGxPaa4SlTp12tn
	bwwq/S/eoR3YMzJPTdi0cZG0oC6usL6nBPSq5HaiIu1RdPC9bIY5FRsmXa8rwu91
	bcfQQdzwZCgTClA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=osjHs
	BT7GD7T4bNrjiFHy3K9kGONjjUqb10dwo8EjeM=; b=aVPnX/lfc6yoNkj9ojSrw
	+BW/uGkWl/ClQPEDmBZKCgDjvdkdSghNS+dQo3/+iozjlGNJYtPZyYGZ8PyLFyhC
	yhfHN+eRFW/KrijHIUP/+YLY2Z9WbRGQxephGMXiKejuMqcIIXUx7DEQjtOdaIu1
	1mCZrIFh1/20djcVuuGwnFA9a1naikOVNVK3kdvzcyzR888QX2iGbpsPaml7/2li
	Ds/hV0MlWVp2uQX4gB7uFrnLfoUu5f2rXMebGxJ94LOFbVtZXEMhCgptU7BkS4rR
	oVRtI98VA8Ceibc59Lb6JZus0hdWSwuuf0wjUhaPm7es6emE98oMqMpvwLZzPe4B
	g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4huwnq11du-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 04:42:33 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4MjkotodkWp8my32myX/PVF1s/mh6KV/UoWesrBlQqykLSjAI+ajtrzcZvxeC0DYKe+K+fjKsfnCFOl877XEazRVbv/zkaGDjCgIiWjxG4tFGfpgMcy74u+h0Qn0GlzSFOz+VcTD/ZmHMRP76pQs+7r4XIsAELEAxQtUX8vdHbM8/s9mEA8pulJ9OXK8UqZeSM2dEn0/5OveEnv6zUWWCfOJUbzTeffCARtWRCT2zSaPBvSpSSPQ1GGWfC5qHQ16lFWrR2sjykUurqJGQbirExQp7AvmflUMIyuFQZCTKKZkyMaT2sU+O3cKd0TYBYsoPoLvxAeoYQiXKRHFF8Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osjHsBT7GD7T4bNrjiFHy3K9kGONjjUqb10dwo8EjeM=;
 b=qwEDPfvphqmh0wR1Px2OhI0nNk2a3z216wnaXWkfrNpCC1fSbN9pBCEQ5aWbp2H3+lMFYDL9oRIx1S7aXg6Lgw9eu6/lGHx7tgfLRBa/ePjQJneuCaeO3+3Qtg8EF5XCUuBXRqVILw2fJjAZVhZB+w1Nnu4l5y/qgX8n9X7y+Kf0d1UjqKZlkFZzpFaWcrNYuVsH7owpJcLMrQqxUDVYzIwYGqstMs8cDVo+pbestxJ78NpaFEBX0HlPj4ZuzS03xyUed4RiPzQxLPuFTmsO/VvHVJGz4PLXUQ008ROKL++aJ646jdfRpRQ9pGSxdXli4mU6NZTBsB3AL9xZ6Ni7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by SA1PR03MB6545.namprd03.prod.outlook.com (2603:10b6:806:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 09:42:30 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 09:42:29 +0000
Date: Tue, 10 Nov 2026 10:42:27 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Ciprian Regus <ciprian.regus@analog.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/7] net: ethernet: oa_tc6: Forward declare
 struct mii_bus
Message-ID: <avLm5tcUKM70-0vd@analog.com>
References: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
 <20261109085952.105331-2-iustin.stolniceanu@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109085952.105331-2-iustin.stolniceanu@analog.com>
X-ClientProxiedBy: CPBP307CA0022.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::11) To BN9PR03MB5977.namprd03.prod.outlook.com
 (2603:10b6:408:132::11)
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|SA1PR03MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 945cb9f8-6e1e-40c0-3bb0-08df3f0eefe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|4143699003|11063799006|56012099006|261021121427099003|261021135927099003|261026121527099003|10067099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iuSM6QULZ8fc35IA8u1B0mtgPlQ/FvhOx6arDZYopdGX4lUquVKw6gw4/tcaCodxKEoQ8CplZov55dnqWy2T+N+WUk+hkU9YRH1064YbDsvdcoukcBJIDO1Y2hM1fp4QmdEYuw4oaOlxXyNChyR2lyDitMb37Df6snmq7PbKZZkfMc9kSc8es0kCZuzUAUDkWOExG3Pt5iMxIKRlQvuFn8rL0YUyZQx9D1qfBpnH4Z/O8NSP6zcbQpLW0oqtY5BruEFoQ8bS6GaW8lannZfdqjgSfdJpC4VZrgsNytV08kXipVHNYME++oOFY5BGSJVKnjkcqy6ZAKbrWPxzGj2hGPnQaHrYBavaabKAeFEJzIXmfBIRSWaWjFjk+oRkKbMAI5NzSP9ZTI8W3Gf9O7KT1V29Rc/xfvay4KJs1yqyr/vWLYeOQflo3QAaHD5TFp+kstcIPTJ8KqycLfKTFwrrmypIP5i6ZTqU/fSlVUYnZajssC2mnYBY9DDr4UP9wjx1O3YI5LAObiDjRrZVduxmceR5DwNhZMenMtLCmxqhZzsn5lnOj1zJ/sxuys5hBmzXcIPH1ioharh0/XpPT9ffkrr1Nshiwrcan37SeoJXUIjuOGDqXplNafwSatVhBKNDxY6LK8cRfR7WXxFCC0UMs345g0opwDOUy1x8q6fUfrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261021135927099003)(261026121527099003)(10067099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWVYcWhQYlpqT1lJdWhCSTlKdENYZGVaSlRVQjk3N2M1bXNFdEMrMEY5bzhu?=
 =?utf-8?B?RkVwVHE5V2Nidjlkc0c0c3ppWldHQ2JxVXByd1FWVVZJanNGdzZqWVpEb3Q1?=
 =?utf-8?B?MTdWTUpmVG84ejBsbFdHYlNzcjdONnBUTFhseWxMR05QYXBFUTQ4ZUhFWWRQ?=
 =?utf-8?B?c3JtTFovRnQvSFpQQmhOdWRyT3BKRExTNmpQY05UUmJQSWZXSG5rUUFyREVt?=
 =?utf-8?B?SGVuMisrZ2Z1WTdZdnMvT2YvcFA1UWhIZUVGVk9JTzc2VTczc2djbE4wbnEv?=
 =?utf-8?B?UWhsbmFwclZYN2pMakVBVFdQUWNzQW1zR2FEc2FMYVMxTGFabjhNY1FlRXo2?=
 =?utf-8?B?Kyt5RFk1VTI5QzVvTitwUUNVQmg4VURIcS9tY2hUSlRIWkx6N3hZMnh1eE81?=
 =?utf-8?B?ODM2RjhPbE9aY1kzZEFOK00xUXQwOHR3Nk9QRXQvQkRMS3F6clAyNHdrT25x?=
 =?utf-8?B?bDhCRnJvdHNRdWFyTnFVbDljYW5uQnFXenIyV0xqcHhpZEV4WXdMaW4xR291?=
 =?utf-8?B?ekNqS0JWazBQKzM5dkEwWHJUanNGY0tsczZCS2lpYnQvdy8yMjBsRUIrVUM4?=
 =?utf-8?B?OGg2REEvZngyWUU4SU1NaHl0b25wdmhRZXZjSVhyR2R2RjVsWUxvd1YrajhI?=
 =?utf-8?B?aHAvdUFxMFpXdDFIMjFlc09qU3JnL3JtRzJmRkdDaWdaMitDMGQ5WC96RW9h?=
 =?utf-8?B?a09WOW9DV2NWbUd4YkFzRmpJcHU0dzEyQTJrZEl0aDFIcFdFQTVjdmFPZEZ1?=
 =?utf-8?B?N1VmWEFNQ0hYVGhZRFprQW5aaG4yMEdkbkxxcHdTa0xObEg3OXNTUUh0VkpJ?=
 =?utf-8?B?NzV2Wk84cUJBdHJ5QWRnYnlleEdQVEdrRGRBVmp5MkkxeTBOTk1iUXU2bG5K?=
 =?utf-8?B?b3E0K05WWHl4aUd1NnZ1UVZxb3gzL1hTZS9rTWxQK0JiS3QzQnhlYmh4RjI1?=
 =?utf-8?B?dHZSVW43V2ZvUFMydHZzRHh4cXQ3TVJQU0UwdVl6alpWaVJnM1h2c2ROVTRZ?=
 =?utf-8?B?QXduaTZHZjZSSFlqUG9EYy9SY3RJekMyUlhFUnpsRXVTeVlzeEF5M3lZZ2NE?=
 =?utf-8?B?eTBzRzRScG1hWlY4dzZtYnQ1dXAwa3VJTGFETy9Ra1Q2Ry9jRXBYWWhESitP?=
 =?utf-8?B?bWhJSlVLdnNZcjd2WXJGamRCMVF4WnpxeWRSbGwvbHdHNWh3NXB5aG1GV0Jp?=
 =?utf-8?B?YmhMT2d5R05TUmswYUdpSldiSThNZkxVMTRZQjhlOHhMSU1ZMmNtaDc2cDZn?=
 =?utf-8?B?WkkrTWU5REExcnFCNDhZVi9aWkZaTEl4MExDSGh5TGxSVCtoZ3l4VjRVVmFU?=
 =?utf-8?B?dFlrdWlDMWFWQXRWN1FpWUpxSHE4WkEyQkhucDRtUGNMQ0x1WG9peGVnQzVF?=
 =?utf-8?B?bHVLcU9LRldsSDdRMmxvQjFLUm9IMFM0NUg3eUNnZkNybldUOFNmeU1GbUxD?=
 =?utf-8?B?Ukc5Q3hITmZzYmxTU0lDV1lQNytWWG81UExGWHFIUEd1ZGlidDF5bXJnOWxD?=
 =?utf-8?B?d2NYU1hERS9RK2UxMWtUV1puU0pQVkNJcE9ueWt0K1U0OWdBN29wTHByMFBl?=
 =?utf-8?B?aVpZcHZ4MWVvQUF4aWRlcmxQZ0p0bFZtNHk5MW8rZVBYdVVDY0RXYzd3OFp4?=
 =?utf-8?B?Y1AxNkdqSHV4UEZqTlF6RU5IWER0L2J1NDVYaEtmQU9rVTBQRFRlZTBTV2ht?=
 =?utf-8?B?SEg1MXFoV1RRc1VWRnhSclBGS1ZjTlpaZ0FzRXNEUWhadzJqK2RZZlJSMzRZ?=
 =?utf-8?B?TDNxNmNnVlJabVVtVXRqRVlkeHpmN3pkQUljQW5ITEFxRTVzQVlJaW4zRkRl?=
 =?utf-8?B?L2Z4a1hGbnBmakJzTlJwQ3haZUhhN2owY05oWGp0RjhqQ0cvbHU3M25HaFdj?=
 =?utf-8?B?bTE2M3R2QzgyR3RBa3NnSEpJR0tpNWQ0aHdSTVRpSjdUUTJIRGszaGlKaXMx?=
 =?utf-8?B?eFkva0JUTWs5M2w0RVJRZlhHS1JXektoY29HNmlnTElsWXpJbW1oTVBNV0p2?=
 =?utf-8?B?WlMyaGpYOWp5R21kazJ4SGt1YitvK1p0R0hjL1krS2UyZm1nYUhDT2lxek1L?=
 =?utf-8?B?S0FKeEJab2pPN29hS1g0dEdqUmc1SWVJeFR5bFdSZVRYWFIrTDVMZzh2UDhP?=
 =?utf-8?B?RUcvQ1V5SHJUN2VMOTVuRURKSGRVUDlGbWFIQjNoN2VrZWd4NnVSdXVkLzBh?=
 =?utf-8?B?L3lnM1JUWis0U0Y2eFFId1ZaWWpyUnZCYTZ1eThkSEFhMkNRMmh4QUNaNDdX?=
 =?utf-8?B?ZU9FOFM1RHBhalZSQlZSYzhXVHBRbWZSMzZLaWdtTFFFTHphcGNZMk9oMzZU?=
 =?utf-8?B?ZGc3aVI2WWx2UFp0QTNPMXIxRDhZb3FMQmZpWHkwUXowR3g4YXdoUT09?=
X-Exchange-RoutingPolicyChecked:
	QK2wOxeWgAyHwy1I0DN2urqKcCZGF8aNSH8SBmqbPnZkS/qApqDIK4yM1nPjzEXjNs6Eyw5thiD1sNsuufQcL90J0mOhrQE/iHoMvvEg6my9BEijGBkbAH+6pEiAc7sH19AP8RR5b7whdvl2Drb4GPF80Ijeidtcr0vDfVKPEm3KFnXy2Z91ShlgCjsKctRVOITn2obK4fSRn8IzStYXIcNo+U9BDwauEij+x+tqKzEYCTZ34J+qrLymhj1n04UE+Cr9lrM20n6miMBST0tnM40qXLV8UArgQkIHxKMgsksCf4pj+/04qj7IPUnXrohKYsUVufgN2TcwivNMOMDo9Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945cb9f8-6e1e-40c0-3bb0-08df3f0eefe8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:42:29.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLc7WJuoRpMXr1hSByFYpcIlASHP4atZ3dHV8COUexF1volXGLUjEXzz1f0qkMvcWiqVEt0ErImcMCpxCE2mqZksgaPh2TUOA3gZXW4ujto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6545
X-Authority-Analysis: v=2.4 cv=RtVQvymK c=1 sm=1 tr=0 ts=6af2e709 cx=c_pps
 a=V3ntuBz9Vw3KuD7vyzUphg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=gAnH3GRIAAAA:8 a=BVe7Ikh9eDo-0YvHFzcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfX8fs3kUxV4nZy
 qHQEzsFwecw9fMnEcfWKOnHJQ48jnu42s9e39TPOsr7HN+Vn3wNiF82MkBx3InsloZCB3KHBVWK
 q+3YBgVuoqH7YeDnUVlyItQXC+FOVG3AlAlVM2a4ZyoBKLGpA0vm+z9UMTq6fdo/nzXwfQK4TsU
 /BbJcv3YeMk4BSnXql53CzvzSGuMJz6GGlTr07tM7iZ5KgcI5PVAavJ1IwzYmKBGHh7JJn9/e46
 oSISzIC7FrCltnMCfX+6/2kso4E8ssvUTY4DNOZ7ECK4gHwcBD5hB6M3OMd8H3BFDoH+c7kPUCo
 Zi+RA3RgalsxVnpgb4H430iZU0qnGhH2wVDo2KgkFWZzBzzSiH0Bhup8Lz9ZYkJq4PN3c05KOAw
 j8OcMxJhpYb4Q56494cDJzeL2aCP97dtp9rybj/mIyYJuo6o1awCRthW7233yfbIkBhTH9eLgwG
 nb1OJf8pCP7j5XyfyrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfX6t5QjyqckzPs
 0uuxhwMMCKjcoFJu6qkKSYX0/ClIYGBEefycWDX4PdcLcBxIDUFdqSLcRejB/1uXckkHWP2cFGE
 6rXMx79MgSH0HKVHXSPWeDF1qElWsMiHApRIKjiMWI7evsgpgd3u
X-Proofpoint-GUID: 7M7DdWOIKF0krWnkmlmaGRrMWi83HaSX
X-Proofpoint-ORIG-GUID: 7M7DdWOIKF0krWnkmlmaGRrMWi83HaSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100038

On Mon, Nov 09, 2026 at 10:59:46AM +0200, Iustin Stolniceanu wrote:
> The Clause 45 MDIO accessors in oa_tc6.h take a struct mii_bus pointer,
> but the header does not declare the type. A file that includes oa_tc6.h
> before linux/phy.h or linux/mdio.h gets a "'struct mii_bus' declared
> inside parameter list" warning, which is an error with CONFIG_WERROR.
> 
> lan865x and adin1140 are not affected, as they include one of those
> first. The adin1110 driver, which gets OA TC6 support later in this
> series, does not, and hits the warning.
> 
> Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

> ---
>  include/linux/oa_tc6.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
> index 27f652d4920b..6eac6b842156 100644
> --- a/include/linux/oa_tc6.h
> +++ b/include/linux/oa_tc6.h
> @@ -64,6 +64,7 @@
>  #define OA_TC6_PHY_C45_AUTO_NEG_MMS5		5	/* MMD 7 */
>  #define OA_TC6_PHY_C45_POWER_UNIT_MMS6		6	/* MMD 13 */
>  
> +struct mii_bus;
>  struct oa_tc6;
>  
>  enum oa_tc6_quirk_flag {
> -- 
> 2.43.0
> 
