Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794303258;
	b=wVIC8Zc0KLcD+NGWy3ypT/bhZDmqYgIT8cU3Dz4kjeK5Xi5Inbfkwe7/+7xUHjSLlMY2
	 AiPFDlYiMBMskze+veVCY8PsEoGfwJjJYqYpvCvmVf1t/FJaWYhoBi5AIJ1mMQjV+ALY2
	 yNhU2YIBeieh4XuaaagzAskFp677hxeeFplI1eXv/izD6xWWqz2/wBovyt0s1/mNd2gig
	 u0QT4eLLVZ9rqPn/ncGnAZMvoUo6N8ngMj8v+y1WbTLQ2KMiBm9Sk2dLjjo04toIAGEYN
	 +aYol31rW/birAqdigqNBd4XxYfIw2alKZuPjkvSwmn4FRWVBFIdSNPT2gcZdjdveCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303258;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5A03h2LVFuLZahGJ0rRpD6x6uFhh9GIWQVRBy0xNulc=;
	b=Szdab45Mp+rv35ASf+s5oh0g4fZwZkU3EEPCxA1QCsdHYiVMbV3JsrJrlvYHDpWLmZdY
	 MfknXs+kxN/NT5amWF1OiKLuPsl1XBUsAC+DH4QspKre3OOeWVWU95nWgsKsWzmswxN5n
	 jz8sGCHHb6bJThw4Y+bTg0gaZzhdJRGDHzEPocWSIS63CY+kgOTZhleWS3pSU2dgydzvY
	 XXi+NkK3WLAicmMb/TuDmtoljoea5inAnVmuNtKrCfbwh0XWwaSyjKxzZO21EQklCqQLB
	 3M1q7X7hcqezpS0LI5SnO7NvTkWlSF32CZSC2MUFXiK368tnY2iZ9QqypcF4z2icctg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=TkPeoV1k;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=1nBNtCGo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3826606C66F;
	Tue, 10 Nov 2026 09:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3826606C66F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=TkPeoV1k;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=1nBNtCGo
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7kR4L1511903;
	Tue, 10 Nov 2026 04:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=5A03h2LVFuLZahGJ0rRpD6x6uFhh9
	GIWQVRBy0xNulc=; b=TkPeoV1kbi9lFLfk+0FFzYIwwj7AewZktxFyoVmnM5D76
	1h/NHWIVho1BqmUE4tfrf+5IOL0psIfEDgDnad8kZFHnrcZlJGiRJ4WGyVGCGf4B
	rgUTEZIhLFrgoAYDvO0rvEIgt9ad//56VLxYWW0lscPpMz8uxNuKhIur8/veOnLc
	T/5N04JDHVrEQfJv/3y0CkzSAJFsgZ08CDn494SmF2aJts3EY1F+jbUC5dsHhNzX
	uCWYODAOB60BMxLWZdY+L3doVgmq2NnjIwYqZ/3dZCp5Cxw0+KFWFNecn+vsixkM
	8B3JCYBpvwZEeka7U3v1QZmm7ndyc+5VBl9aKTFOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=5A03h2LVFuLZahGJ0rRpD6x6uFhh9
	GIWQVRBy0xNulc=; b=1nBNtCGo5sOKa9WsxS4uDDsVXZqiqXDhthald73kQGdf9
	LHDGZiPcYf43FJp8I9wb+AK9DtUkQbfosmSA0yeg3tWBbXasQXQoo/Zb6e3ZCQvz
	5ParORl9m6TyOGxSccdYRTVtDE6xRwZD9eBT79ZflFJEtEakql1K5CyasfDzYD5O
	Z6jhQO9IGSSSZICQNwEypcCyYlMKQSLMWvBUiby1lwSRxm03rsTWhq/Q6z1PT3bB
	Ksi6boBzYwMUe2Krcj+Lh2zAvQZa2/lDVEorU/4b/11GREMNCEDPmmywpg9BZ9RP
	vKM0lMz3n1cfoJvAZLjiNutYVvbVuIb3DY9Z5ERKg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4husyvj87x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 04:33:39 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXri99ABJIsS9gWmo65GXU6zu4gif3y6JqQCFdyuQqYXMjS2BNlfArwyEPO4qys2xkh6lbOiZHTieFULLiToalucJCe2togvzTZmBjOuIA9of0cocS1WEFZNoSZT9GJSuedQ964WsLXEMsiqnGnAZQ1LSiPDQGTVRNx+M6+9Y/jwG1ILRW3Ji96oIJJ46P1XKDEX8N3Fm1YRHkTRrbcftm/haH+N7bKUpz7VgToELA30LXUJe9WeG4FIOOvtXSu5WxQ3nClZGVWyZqgmpzM6f2nBfm3YBonTeBXvzuxCtRgBBfx4wEb8DBk+jUwK4w2qfy4m0oJw/PUnF1tm28TOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A03h2LVFuLZahGJ0rRpD6x6uFhh9GIWQVRBy0xNulc=;
 b=B5PxfRvqrWuBqyg9zGcz56CVOcKn91i02MTioZZpUZlb1oCebanq4m2hLiQsgDcKgirzrXdWW3yJE0H/ETcVyTOS4jFnqNrKXSb9nKcYNGqvEH8P3KjeiKKuSYlRgxOaBY5LVA/Tn2yeck9Dt2DzZauuVoAQJ/xfgQ9aKmAFkh47e814OUsxmXzoKznMIKe6X2/LbOCpMDntHdyeMvFNNgX2lKZl0pftd73wCdBJvlrGCQ2RQlBki/xWEWS+xW7xZ7mKe9VX1Pt+7g+ccRdwLx08HxZjufC0m+N/TbMqTyF3JT509HIRPZFLFQW6eZEORXaNoHjJFFGYPea+GzALBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by SJ0PR03MB7126.namprd03.prod.outlook.com (2603:10b6:a03:4e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 09:33:35 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 09:33:34 +0000
Date: Tue, 10 Nov 2026 10:33:30 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Johan Alvarado <contact@c127.dev>
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>, gabonpivovich@gmail.com,
        linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gusfmora@gmail.com, kuncy7@gmail.com,
        fabianotassotti@gmail.com
Subject: Re: [PATCH net-next v9 08/11] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
Message-ID: <avLkYrPN97sU7HKH@analog.com>
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
 <39e46930-0d24-46d6-8861-5dd309bb7640@yahoo.com>
 <1e8da5e3-0d1c-4ce6-bb3c-4b9b7a5789a6@c127.dev>
 <f84cfedb-b551-4316-8d2b-4d6e06fc151b@yahoo.com>
 <b68807e4-1470-4f4b-8975-e8a70dffd011@c127.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b68807e4-1470-4f4b-8975-e8a70dffd011@c127.dev>
X-ClientProxiedBy: MM0P280CA0098.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::30) To BN9PR03MB5977.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|SJ0PR03MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f3a73d-d859-4a57-9cef-08df3f0db043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|18002099003|22082099003|4143699003|5023799004|56012099006|261028144727099003|10067099003|11063799006|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	JLFwKgCSEpglK4rdnzSPOKrSb4aN6h9Z6p0a0A+wMnw2xhOKJZ4+PSBGcWwqJM9WAX7insMi2rh5R/rrDHk0t2rdm5QT3Nz7U0PIV/Iy1o1CBFjSdFfgGZRNMTBDBcoFu1V0QA3D6bXDEQLl73BoXovY+RUAXYJnxdgKRs3YDHpd2r5uyxSyTgR8rYwQ/q9UCshFrI+ZM1VfgPt1E4AOz7BiY4x6NgdFb8Z8RygQC9Qf/h2W1JusBGEhAqLkOTaE3KtPvOXXf69+ILNOV98EX5t06ayObEB4b6zRKgpZgX6ET+HRt9o4FDdNVncJsstwYfSmAh5xcqL2N2bysaahtMIuFS6WDxhOKa4i0z3dt4wetPviPaMcuO23LicyivRtjfrQoYw2FgOArqy6u8gdbjoGhcy1ebsjIllOS+AIT8e4N1ZoAnnQGECRBEsiTkbSOcKdWnqItsZ2hoEQXUW2Qf7UQgH0c1/DFwI7MTZ34vH1sM/fxf8tg+dOM4KdLvQGqSE92YE5QAww0076HsrK1hFdBqunQGZPnkG4X2FjrxCHlNjuHtDlnU5ofY3YFzI90k8BWubrZLOEUPOvoyLtRp8lFNGkXkS6qCtA7yAyBe4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006)(261028144727099003)(10067099003)(11063799006)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVdiL3F2YldxakI0YmIwdEk1MERCaWVNQ3gzMDRwTjNzRFZRaHk0WW4xQjhG?=
 =?utf-8?B?Z21aKzBRVEh6QmxEaGUvWGo5UzFjcFY2Rk03N05NTzdBT0JIbnRQcGVZMnVF?=
 =?utf-8?B?U1ZoRnFoNlZYdm9TaENCTTZYa2lITnhpQ01xamFYTmNUSUVUVko5UVNhd1pF?=
 =?utf-8?B?aFpFV0g5UEJBelFHLzFZZTdJc3dMNHc5c29YMXZERVBDbWtqR0tZZVdpQW51?=
 =?utf-8?B?L2swODh3cmdKeUIxQzJ3akRHaUpjVFo5QUl3OUFpUWN5U3ZRTE9OYitNanVu?=
 =?utf-8?B?SDJJb1A5MGV6VXcvM1Q1YmtiaS94NUVpb0pzeDRYR0x6VDRjQ1FEcjVSU1FI?=
 =?utf-8?B?Rk8wN1p6U1lXU1grM0hxVlppWlJ1czBEREljKzNGSU5BaHNaNnQ2ajI3bFcw?=
 =?utf-8?B?MGV2SUlncHZYckxHaXAvS2xpTndyU3Ivc25jSGMwVW9ZVnNyZ0xmdUlJN0Ri?=
 =?utf-8?B?K1dJaUFLOS9odDhUbzRPd3BleGowSTVIbHRUNnY1VEVDczVPUUsxS2VuVkZI?=
 =?utf-8?B?VGpzWlpKcE1WZStsTURXZjdwVzJYRVFiS2hwakpkT1p4RnBMVWxKTXFLUVJy?=
 =?utf-8?B?MnM0ZTdVTCsyeUVwUGFlbER5d0tCYjVyZmd4Ui9MUkFVVGdWS2M2QzI4bTlo?=
 =?utf-8?B?RlVLN1lmTEk4dWdUaUs4akJQQU96dWZwQnpPZ2NLWmw2T2Q1aVFDeGNZU040?=
 =?utf-8?B?WUw4emxndEJ3MVRaM0xhNDVGYnpBSDREUjUrUmJFazhtSStVbmU5K0owd1p4?=
 =?utf-8?B?OEFCcWpEeXVsUTk0aTRPTW1iSmhCT3FWRktuT0NSdHg0WlN6aW1sOWNXeE5a?=
 =?utf-8?B?dWdVUmJLckhaMWhTV29heDJRRzhnbGw2bmM3Z3BEKy90emxEZWQ1ODR3Rmln?=
 =?utf-8?B?YWNQZWhmU0IxM1VKeDM3d2xKbU16UURiNTRLK0RyS1BJV2pIQ1BRclR4RHNj?=
 =?utf-8?B?N2hzTENrYTVEeXM2blQxQjY4RFk3ZktHd0lmS1VwRjlSUkxMVkFyUzVqQmZ0?=
 =?utf-8?B?UkhVWHJjcDZDUGE1bVpGVWRucmtzK2tJUXZuV0Z2R3VTTERuQnY0bTdiVzVZ?=
 =?utf-8?B?T1NLb3I3dTZzYmlzOExPOW9oelRucWlXVzlXdFREMzZQWlBMb01tUG4rNGdp?=
 =?utf-8?B?WnZsdk9Bc080VmdneXhFU2xZaU0wbzUxYmZYenBoTWsvYkF5TWdxNmZob1Vn?=
 =?utf-8?B?UUJOTkZyT3JwMkh5MTA5VURUeUY1TFd5b2RMWnVOaFF2TzI4N09rV05pdHgr?=
 =?utf-8?B?azVlbHhUMjkwWmJoMUJzanU5c3dWRllkN0I0bjU4ZHp6OXV6QTFYUnJlOUJ6?=
 =?utf-8?B?c1FmQ0dLWlpUL2RpRWpmWnl3NnJIUDBCUmRpTVJPRGYyN0NLeHlERlRYNGRn?=
 =?utf-8?B?Qyt6M2NLVVNyTGw2UkpxZ0tCaTJaZThISzNnZ1I2OEtYY3BVbEoxY1BScnhY?=
 =?utf-8?B?dWVwRFpLbWtZRFlVMzAwUEtxV3FJaDhsbkYwalBjclNNZnlWOUNWOGpscWox?=
 =?utf-8?B?SkRpdC9LTGdTbDlQVHh1aXIvby9KeklvdS9FY3A2cmdrUDArS2ZVY0pEYUVF?=
 =?utf-8?B?K2lPNWN0MkVvVHdtOUZVaG5xYkY0K2dJTjR4YmlMb1o2MkF5RTQ0NmlHaW9r?=
 =?utf-8?B?Tm93Z0JxSUdTYWEwWTNSek83U3dlemNGSTd2ZVpCcUZWalBYYXlpWWVYM0tR?=
 =?utf-8?B?azFmYXZTYWxKMWx0T0FvT20zM3p1blAxT1J6bzF0cG1zdmluZ3ExaGlIUDkv?=
 =?utf-8?B?SHlMZ2l3ejZya0ZCUG9rQnd1cVJmQnRIMU1UUnYrYmU1aWtkdzdOSjZaTFQ4?=
 =?utf-8?B?U09sM3dSSjRmcTZWaWJMY2pHOGIxb08za0lBTGxrUWZOOVFqNHYxNGtyTlhk?=
 =?utf-8?B?bTJEWlFUK1VpNDMrSUQwaVRHa0lNZE03bDBUUkxBS3FKd2JQZ2N5VDNISkU3?=
 =?utf-8?B?ZitkdlZvcm8yUXZwWjVmQ3ZuVXlwMlJGN25CVW91Q1BHSWx4cS9TMnlGa0pl?=
 =?utf-8?B?OExOa3N1N1ZlU1h5L0cvb0RPZ0dTeDg0Tm1hQjBzVkhTUk9OM044b3pzQjlL?=
 =?utf-8?B?NDlqMjhscjlCUTQ3NklpM3AxSVd2WnFabSt6cTFuaGg4OVZmMmt6T0k4cUF0?=
 =?utf-8?B?L0prc2F3ckZNL3BTY0pZTHlKTSsrVVBkT21PaDBxbmZaemZvUWhQUnlZMnFF?=
 =?utf-8?B?RDlsN09ZSmkzeDBjdDRBYzFENS85M1NDem5NYk0vc2tTaUhqRmZpdFFPejZh?=
 =?utf-8?B?TXIxR3EycTR5Nll5R1VacHpPZmk1S05UblJFczltRVAxWTVOblBXUk9CMEdm?=
 =?utf-8?B?d2FMS1JkQ0xSWHlxbUNEakFNNjZtM2U2THBMbmdnTUgydWFRc3h0QT09?=
X-Exchange-RoutingPolicyChecked:
	ScS2UC17sanQWJ59iv0UBGcfstvjXVDvs8oFbYMjaX64Y3Eu995ID78lwt7CgvYTnZEL/opMoj6GS0R4/zCuXx/wbaLaSt7oDmFcgzReRv5EV2O7vPm14KRgldvw83ljIvDBTlGzUIGu8yoK1HQT+Il9A/pwXHVN8jZdlW8VMMlE2x4sZ8RRSvAjjIMVfEZakqPLjqOVlGqn4a/OQFqL9zfUq4UBMNEHL0XfZSmVWPT5yxyRhB6WKdraJi44/c9F6MWkL7JPvp5C+0+NE6ayIB7Yh1D/ct7xzXilLnyZ2JevJwQcwePn1d4nt+ScrLDZymBbsnpvIqcwRHcIos3Mgg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f3a73d-d859-4a57-9cef-08df3f0db043
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:33:34.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+0+SHki0g+PCh2mb4NgCDNL00Bgbg3mSCvQWz7/g3d3Gtvlr4TtO2+vATgQ6NTHCZo9TKsEEe3MuqxfqZTVd4Qm4PKR/8UHgWwFuE5JXCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7126
X-Authority-Analysis: v=2.4 cv=RrNQvymK c=1 sm=1 tr=0 ts=6af2e4f3 cx=c_pps
 a=8tq6Qs2DEm6oQ1m+I15oQA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=NEAV23lmAAAA:8 a=2siYSm93Zkb0VfClUlcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfXw6oWfM3ZK3Ab
 /XPZrk6FGQSFbbwSULBbyXdtH4idwmVRRSlRsEqeDurnpHpZk0ZVHVrneHtFQXQf08iiYDIFXzz
 9u296hQa9xTkTOZGpdobXg7lFmze2De70vSjXMg8Ff8wuFhCKl556d9zk8NJU0GfUgnkILBDqZE
 Oyz59yEOXE/sAXIM0+YiWfIjXh6g5xlG5mKYwTUX9VV5WfCTvw2X0Oz/69gcdPRosQylU2ou3yf
 SR+M/TI6q4xVlCPD6Wp0gSJU0ScW3F7YgLVfneckZY11hI43yA1OVZcyAdnDKghxGZ/mWwpjemA
 dosf6wIjbb4LHztZh6TjTrn0uUg91AgeW2wZc7fqnH40/CTNeiGkKXyOXY0Hl91Ew9Ma7HMNI/W
 /sUD+CDKy8CVLkH8PDWyptbOAebVmMSJE3TocFK4IhqImNnDJ1e5BItf+Kbn6rEJo4P/grFSrsA
 iOKb+Lf88LB/pEUWoWA==
X-Proofpoint-ORIG-GUID: pdk9jVGQeJGDgL6CAOQXdke03bIQHR3_
X-Proofpoint-GUID: pdk9jVGQeJGDgL6CAOQXdke03bIQHR3_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfX9Hfb1doR4kb2
 XUYT6QrCiFwdFpgJ/omkIEUnMiZ3VLVLXTMtw9P6mBYiBCGpTqxWPbDjFqEnwT5Ht4BGGgtUfEV
 42Dm3JSLrNN/vEbbPO3ZeOqQjaY4/EQpOV58eQW+k1k2UE4FXPme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100037

On Tue, Nov 10, 2026 at 12:49:04AM -0500, Johan Alvarado wrote:
> Hi Mieczyslaw, Alvin, Oleg,
> 
> Thanks for holding off. I could reproduce the symptom here and I'm now
> fairly sure the cause is on the SoC side, not in rtl8365mb.
> 
> Setup: Mercusys MR80X v2 (IPQ5018 + RTL8367S, family C), CPU port 6 at
> 2500base-x, booting from NAND with a real config in a reboot loop. A
> boot counts as broken when CPU port receives nothing, or frames with FCS
> errors, while both ends report 2.5Gbps/Full. Both flavours happen.
> 
> Results, same rtl8365mb code in all of them:
> - OpenWrt 6.18 stack (stmmac dwmac-ipq5018 + the qca-uniphy PCS):
>   18 of 51 boots broken.
> - Older stack (qca-nss-dp + qca-ssdk, 6.12): 0 of 16.
> - 6.18 stack, switch SerDes brought up only once the conduit is up
>   (the OpenWrt ordering patch): 0 of 16.
> - 6.18 stack, UNIPHY mode sequence moved to the GMAC probe, nothing
>   changed in the switch driver: 0 of 32.
> 
> The bootloader hands the UNIPHY over in SGMII (1.25G line rate), and the
> qca-uniphy PCS only programs it from pcs_config(), which on this board
> runs at the first ndo_open of the conduit. The switch
> brings its SerDes up in HSGMII at DSA setup, about two seconds earlier,
> so its receiver trains against a transmitter at the wrong line rate.
> I read the UNIPHY mode registers at probe and at each pcs_config() on
> every boot: SGMII until the first open, SGMII+ after it, identical on
> good and broken boots. About a third of the boots end up with a
> receiver that does not recover when the far end later switches to
> SGMII+.
> 
> Some checks that point at the switch receiver, not at the MAC/PCS:
> - Broken boot: A full UNIPHY re-sequence on the SoC side does not cure
>   it. Unbinding and binding the switch driver cures it every time.
> - Switch SerDes brought up against an already programmed UNIPHY: 21 of
>   21 good, even with a UNIPHY PLL reset one second later. The PLL
>   reset on a settled link is harmless (12 of 12), so I don't think the
>   10 s health check in patch 8 covers a real case.
> 
> So the "far end not up yet" in the commit message is, at least on this
> SoC, "far end up at the wrong line rate". Once the far end is in the
> right mode before the switch comes up, the receiver latches on the first
> try and nothing needs to be re-latched. The two second gap in the
> reported timeline (5.27 switch pcs_config, 7.72 eth0 configuring) is the
> same window I see.
> 
> This is a family C board and I can't say whether the family D receiver
> behaves the same. But the reported log is the same SoC with the same
> OpenWrt stack, so the wrong-mode far end is present in that setup too.
> Oleg, could you check this on the AX55 before the first ifup of the
> conduit? A single register read tells:
> 
>   devmem 0x98218    # UNIPHY MISC2: 0x70 = SGMII, 0x50 = SGMII+
> 
> If it reads 0x70 there, patch 8 is working around the same thing.
> 
> The fix on the SoC side is one commit in the OpenWrt PCS driver, about
> 50 lines: run the mode sequence at GMAC probe, before the switch
> probes. Rebased on current OpenWrt main, so it should apply to the
> AX55 tree as is:
> 
>   https://github.com/c127dev/openwrt/commit/50e49862d2ba1abd0c93b64403c776af200323fb
> 
> Oleg, if the AX55 can take it, a reboot loop with that commit and
> without patch 8 would settle this. I'll open the OpenWrt PR once that
> is confirmed.
> 
> Neither dwmac-ipq5018 nor pcs-qca-uniphy is in mainline, so none of
> this can be reproduced on a mainline kernel. That's why I'd rather not
> have the workqueue, the extra locks and the reboot notifier in
> rtl8365mb for it.

Thanks for looking into this Johan.

I guess if this can be fixed on the SoC side (which Oleg can hopefully
check on family D), then we can drop this patch from the series
altogether. Correct?

Kind regards,
Alvin
