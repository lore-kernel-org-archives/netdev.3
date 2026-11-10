Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794304115;
	b=uV3UJoUI0b89Ql1ZJJfPHZQY66oyrQNqgoSIYPEYTEamulolTO0uBhWNuhynPw3c1FDk
	 EPHLW1/2JUTGbynlhnN0KBH7LJKWVO1cYS9i3WhdMGRJsa0K9I9ZcZyurPnRxbvMNxM2C
	 NY2QkqWA3DShZXwdTaAOWfBaWjC0tVnjh19Y/NibfIyZUDgt6jxXxicsNbJe8Nc40MbAR
	 1pYN1djS+GXRahOw9mXCX6dbwKzLC7viwMTGJFPX0e8FiUOmmWBt59Ju+23KF8n0R0e5+
	 gBCgfl2vo/GBGiGjscbh7pwCxftmX/0y6hFXZ/2JMrv3dMJjBUehkniASs4iq9Fo5rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304115;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AJpAP3o7v0y1o04gc9J9PrhQOe0GjM64PFHVVGlnw1o=;
	b=DzH1swpiK+OifBVaJ2Z+9vXmhJued1LMc67jqh4i+1JMEoSjPFES9PBsZ6ZTtql8QcWh
	 VMhzGluJbtLMfGn0UUE4YVE7vrtZeJGjmhhhwAuPZehoxOEOp2RrJqUon3K9FgowteKKv
	 cgbPmJW7vYVhum/jeI3moZize5pY7zRGhjm+SNO2LVxd28jgXNdkXI/HKHuL0bjgkXTPU
	 vPheH0f+uGZkVKzlyo8MTgJ+SWvUtd1vFQpoJkqUSX8LOw1UAl2W4efSCxiphs6pCgRWq
	 GQTR0QzNZxIgqszfHsPhrcLUqyxb89SeKbt0KPul4S02dzZNLWj5CqzhUrqIyjK9EeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=g4cqKSns;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=DJMFmTkl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506CC606A321;
	Tue, 10 Nov 2026 09:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 506CC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=g4cqKSns;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=DJMFmTkl
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7kRsx862636;
	Tue, 10 Nov 2026 04:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=AJpAP3o7v0y1o04gc9J9PrhQOe0GjM64PFHVVGlnw1o=; b=g4cqKSn
	s3H7zETJSxmmatNmXVH/6GrnjEZd2fByWXSql1gvKwbIQckolN2TPHUaLVTw/bdp
	8lCsEEJcy5VEj3NgzX4D+2doxqo/Fp3eiFevdULYhiDM0EpR2xBOunOBDplPojbg
	KZVe1vgji+eRnr6Lg0cfEmBVflCEHUzYaafvVHNcj0B/HYKurm11NrZGNPEBIFP5
	hnzupv/WzQ5LTufuYMHDyy3CU98wg2VAda5Nhhz9RDalac6VMBRqRDz2nk1VZim9
	5tJOB8MTftlU5BernZ94u+PTwUrqTGQaX1Bj/LUdYxhgF9mIhpKRFC/NYko0Whu3
	TVYWoMwSGi7OcUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AJpAP
	3o7v0y1o04gc9J9PrhQOe0GjM64PFHVVGlnw1o=; b=DJMFmTklEU1BtiorVuNQo
	c5PEiTnDwb0c99SyH1vfautCOrAg+vGJipzVWZaT4q5a9Kg9wZRBVc0eFKO84Edb
	61+lX7VUo0uwy5VELPlry89YPigboXRCh+RYBRI6WJrksVG9jgnc5c673um3BkYs
	tGtJI9pBKL750AwlPjTbxhyhsxVLtGKO3oCxTKE6taNsrAKG+MXjsPCEJ/UnXgSo
	njnl1GQWSqeQnsWeeLkAFvuo1ThKSH/jcqQs5H2DUToFLfMo1uFPGMQo9+e54aFm
	+CIGue/YrdiY3ZQY8UURiAUVS/GOM+RXHbMM2oc1HLcFHDM/jJ+I8i1KzKRw5i0V
	Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hut1qj9wf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 04:48:18 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaq4XOag56KJ5NEnYsPk5C+MN0JCu2zqvNqHiaAiE4dOEePvUZK3jjAwranudqbvSBz4snf6pLvXJOddc/Av36UyA/eIKHFAKrF+l4Zqn/Rc7+Q46Lq90TgXoa1jfuxPwp3NykPZ5kyzwLpw06RURlR7xdbZKCjofr8pOFufmhIimMHP2FXYElKA69P1UDkMFF3aooZuCes3hc3aZ5Ay3HNqFv45SY0CambzdoAnIMG5zVai4ceMlPpq6ppmC5pf1Psx479yh1tfDBqJP4Bbeoz691g/6fU9qOIqHmntp/tb0gMCjnCZzomXERHw24j7VvxPpHaVxwHYQzvQPGwx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJpAP3o7v0y1o04gc9J9PrhQOe0GjM64PFHVVGlnw1o=;
 b=Iv0QDNZmbzOEv1WqxAqRDGV+5AsdsrQ7OdLtqgPIuouOWx1H9UFnUuih9CX3aJbFASgR6kzLzsTeA3DQuV2yvLLcsKDbum4WbvI3tq9IRL0WdEkcSgIpOwc3e3pkyafjUUohzawnuimfCVQX430hIZ/BVkslDadaC7x2SPmLm1irT8ELI/Z6HUT5NT0jiuu9+CsnSoYvzZXDjUfj+ew35+eMKE09zPBANv4R/IOUwpJiblyd+6PvNMgu4YZ8LsxyJOuIvgpOTezuR5Qd1Kli6lecALW0EMJwq+Nal48xxH84j8epBDeMcyDfPlojzwoE9nEyzZrviHCWzkxY9mP2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by PH0PR03MB6381.namprd03.prod.outlook.com (2603:10b6:510:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 09:48:14 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 09:48:14 +0000
Date: Tue, 10 Nov 2026 10:48:11 +0100
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
Subject: Re: [PATCH net-next v2 5/7] net: phy: adin1100: Skip the soft reset
 on ADIN1110/ADIN2111
Message-ID: <avLoU3JJJ2YvR5OE@analog.com>
References: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
 <20261109085952.105331-6-iustin.stolniceanu@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109085952.105331-6-iustin.stolniceanu@analog.com>
X-ClientProxiedBy: CPBP307CA0006.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::16) To BN9PR03MB5977.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|PH0PR03MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f05c69-964a-443f-d922-08df3f0fbd12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003|3023799007|10067099003|261102123227099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	r/CHuh9SIJKMLYzYZCQeEB5RmWPJ+6iBkxrKddi+CyXyjiK3plfRE7Lkm1A5blVNveh04f8SoeBxW/A/CdrFP46sWU/Vimsdn6LrKtHR7VeWNy2Kaqyl5CWobTPDxkN0c9GXAcntd5XBLlIqDNHNu0WasJB46pBdAtjCEcXp3Z0NGBehPwUAEEOfBnmMHsl+Mp+rWYdZRlaiXh35yXxtqCnTjdgLVGyTPY9h9QePFO+HJ+iVKbA0h3LHaTWcpcHoXvQ7qJHw4Orz1EdsdORqRXXGE4c2ZeuEM5dAgLim9LEeqhq8wkKfaiziNHhoYn1Dy/3qsUDQSBmMoFvyfSB1kDb5CgTr6z2oiEPRHQzmO58dUw6qjuMyYP1OX7xo/QfT+z7p96g5lUOAEoxp0uwZzi+reFxHSb+hLuUj21zgLAK7EkjEmjT9XLTwmhOmkelUKbHWKnoMKmhelc3h0thGtA8C9uDRLttw7OO9BZdWuVfU7vs+uma8JvT2UN9dtsdwUnkfmBLdn2Hh7kS1mrSQ/uq394TdQM/AA5/1n6dB1euafzVdNJYKZ81/q1fCV7yEngQ7qiKCk06CZNvs1CTX1jCb6Ih7wmbxwGtXIS6Cf3Ju2ZTPa0Xf7ajH6s8f6OA3zZyej4/zrbLk3H6lk0c6unVHvuZdWC6CAgn1POQs+zY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(261102123227099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1BWSDh4S2tHOGJicm0raGQ2SUNZeGNiQUFPRllmUjVtc0JrUFhoRHRUVStp?=
 =?utf-8?B?S0R6cDAwQzdCckdKU2l3cDQydG01VEtqVS9HejFSUWVUQ2hvYTFzem10SlQx?=
 =?utf-8?B?dFZISEpWOUVTN0ZSV0NUKzR3aFc5Q29zQVREOGo5NlNHcklTRHBDUmhXVlla?=
 =?utf-8?B?d1c1QSszMFdCazBObVpGZUtpUHpRdGVDN3p5NFZZZWgyVGxqTWF5TEN4SnJo?=
 =?utf-8?B?WmlRdEJ3V25qWmE5czE3WWlaaUtXSG5Na0JXZ0EyM05EdldjSHAyMm9iakRi?=
 =?utf-8?B?dld3TTQzcVZaUEJoTGFUTzBvTVFFTGovNFIrRjRyQzc3cnEreXpjeG8yL1M4?=
 =?utf-8?B?elR1OHpXYkpZaFd0d1M4ai9ZUGJMOFZGbHgvZE1OQ20za0luM1Y5dCtlbkJw?=
 =?utf-8?B?Z3VkSjlZQkU5MnBEMUtNTGtOeHZpVWVsakpJN0lKVUZKa3B5NFY4a1VWQnBB?=
 =?utf-8?B?Y21FT2U3cTNZc1ZqVm9NcWFMQWIwTnBNcUVKaURwOTJHZ2RadndXS2Q3YkdZ?=
 =?utf-8?B?SjEvYk1aM215SHREbTBmSXJDVVdVYlZjN1pVMU1IdzhrWHVOTmVLRDN1VnJi?=
 =?utf-8?B?ZG1adEV2aTJjRDJqeVcyQmRielQya2MrSmJKeUpkSjJWQVVCTmt5UVNKYTlk?=
 =?utf-8?B?L1k2QnppV3R6dDBLK3JFdWNKZDhVcFpuQmZZTGRjZDBTbmpkaVA5eUkyZm0y?=
 =?utf-8?B?ZS8xcTBvVG1sYmhRR1EweHBpQVBRY05iaFgrOWpOck9RTEwxUlJHclplTHVV?=
 =?utf-8?B?dWgydnkwUWxmSVpCV3NQa3RGaHJuT01MNGxpaG9CYUErWmZBeDZ2UkpqczRr?=
 =?utf-8?B?eEJDZTdEM0tyU1d2YmxuaWYvZzRIbVgvRnlCb3IvL1pxdmdtUkJDU01qalZm?=
 =?utf-8?B?bFM3MlpxWlpoYUJNNXhmWGQ1WnVSelE0UmUrZ2p0NmUvQ3FBaFBxbWNaT2JV?=
 =?utf-8?B?MlV3Uk1VeDUxeW8vb1hmMldjc043UVBmbnhyeklwK0pLUlZGalRxUUJSTjA1?=
 =?utf-8?B?dEdJNE50aTYyTDVON0ZwNVY1NTNrbHlOZFo0OHQvQ0JqKzZjMmtZUFBDa1hT?=
 =?utf-8?B?cFRPOHFnL0RkdHVrUUREVFZkcmNBMmpFR0FERVF3UDB6OHhnV1l1R0xiQjlQ?=
 =?utf-8?B?U1RJc2lDY3FkTGJwNVFSWTZKSE1vWHlKMFVDK0doMWFUNVlULzB3Yi9HMTlp?=
 =?utf-8?B?Mnd2Ulk2STVKNWx0ZnpHeHcxZSs1QlBFYW42bWdsSW5PL04vOXNUUlByWnZL?=
 =?utf-8?B?ZmdtSjJNTWZDNnZIc2lmS0Z3dnk1bWJjazNqU1l2aS8xN1IzNzhsNGZLWlZ6?=
 =?utf-8?B?Y2xVbnIxbjVwdWg1d0x0NE8ySFVVNkNmTGxnaVB5UGlxR1FFbkJ1SVNBSDJS?=
 =?utf-8?B?Q2E3RVpoVjBVVkt5b0dDN1pQajVTNnhOd2JTdkE1TU5WckpDTWQ1clFxZ3BF?=
 =?utf-8?B?TE1nOGxaMS9ZVDFIdDZUSkd0Sk9EU0o5WitWOVY1dzJXM0RoWDRWSytmTVV2?=
 =?utf-8?B?VmlJM2VEaDA5OHJtSitPa25wMnBWdm90YVVmVzNFekxFZFFqejNuazNJbDlH?=
 =?utf-8?B?M3psTVJlaUNDbit1SlJ1bkd4TVY1bWIwaVdRNjI5bHNnaWRWN1Yvb3pNci9X?=
 =?utf-8?B?VkJrUHBUZGMyTTlWd2hjM3hKNVBDVDdrUlVlMmJRNFEwNG4vWEQwK0gvVnZn?=
 =?utf-8?B?NlJQMG5jaE16QzBtTE1jdXRBQ0RZNndZeHh1eGJOQ2d6aDc1OXZoRU0xM21o?=
 =?utf-8?B?OWY2NStzc1pvZ3FNS2VPdDg1aXRQSmJOVy9zcWdXTGtWWTRFUmpXUFExS2FI?=
 =?utf-8?B?VE81TGFmaUpVa1RSMFBmS05WQXBJMVdvc3ZrTU9JaG9xd3hpUTFURmJuazBO?=
 =?utf-8?B?Z0xUTTNsQktDOUZQQllCRUhnVzlHUnc3Wjg1ZGc2TStQdDNOdmg4ZXU2andC?=
 =?utf-8?B?Q1FERVl4T01kdnRIcjJLM0JTRHl0Unc2cGFXTHNQUU5ZWVJFU3ZHcXAyUmJk?=
 =?utf-8?B?ZVVoUkNxbklKK1gxWG5JWVd0eTFkR3pKYU5jRlcvYk0xT0taUWhCSldTQ05i?=
 =?utf-8?B?T2lyVUdibS94RElYcGZ4dm5KZDAzNWpmb01TeE02WGR4LzBHTEV1MDlpWEto?=
 =?utf-8?B?ZmlWbW9KNDNQNHRlMS9ETHcycm9vUituUklMdG9UaGRXYzJIVWhjOUk3cXh5?=
 =?utf-8?B?dWluK1RGN3VMZFJvcEUxZHY3NHhtY0syVzRoQUd1WEZCdFRjMXJreHZqZGxr?=
 =?utf-8?B?YnJKZGJCR050WU9TV3ZaYWZvQmtCNjBCUlR6OWxZdVcxUjkvTElzcnFUYVIw?=
 =?utf-8?B?bTU4Skp3WmtzblZHSXc0eFdnV05vdGZWNkFMUFk2aWFEUDc2RjhyZz09?=
X-Exchange-RoutingPolicyChecked:
	f1orRBumRh91VNPi6rwD4icBZkAN0Euo2OvspSE7pTw03eteF+JhiAhca83fKJXh4v9Vc1UJXncVsA8WQW6ynT/VL+LE0E26RK/5RxvETy6mmMQrcwQn4tWzc+vGJWsi8SkdBXhv0zemLOsi75OZ9vXHox+UzfSMkjmD/w+j6aPTTV68G5e0y53T1u2wFPIdFJ4wJ+5qrA8usdUHauwR3xo4iUH5zCh+aKJslhWDjNPkRDNPUwtyX7d3sK02BW8k/ZJylQQ0PEkCdwxmiMzL6IfAc/pUIQSHvGafpBy29QNQUFGFAh6RdtYByZzlwGsim1WWP0qBvWnFu6C6Jcp/Uw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f05c69-964a-443f-d922-08df3f0fbd12
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:48:14.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q929z9a89Ka7xOk+9KmZAqf2xTTOvVXKGn0ESn8/jfyVjxU+u3rsVnSKtan3ICnMgsI5i51k03Y5baWfOXngO14gt+9W8+LeV6+1mJUm9Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6381
X-Proofpoint-GUID: BlpWliFwfu6CMBC6Zk2lRX56vJqbkMe7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfX9jsrFkvdaQ1I
 run8nzLTpfJ1AacpXLIzQjoOPfKSYV38e768F+sDgZUJjohf6G2+52g/9drKe+xg/Vqa0kqo6Xs
 EIeqJosc8LZGXxU8b586lpeEUMTQiQaKsRadyTQveQSHMMAmIFq+
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfXzHhBo+a3Xkvn
 /magWxkrp3baAhhjCdYA4c3uJi9nNOCEq7SCf3B65BgVkytAFjSKqpbl9YZzPgqrawiJ/RkwrvM
 lVuIYGWxd6EH2R2XReQXXPegmmNmV+9jub3lUeQC5y0HYnSGpg7HotNxgNgd4XUsXi+oD/FbwpF
 sISJLJWaBncn3XF554pnEXmpqJar4lTrSL6O9tnNKlhbncg++vtlhrFknUzFHZ3TE5uwfVabGsT
 ah4xmJapguYRuopedA9z/Mcf4Bv5YkERYVwAwqW6EPtVQInhTLs39T8/nwpGjhW3qP1bKcwOer3
 rSimDNtveyPmczY/My+/c0/iRk0A4gAPm9zg3Q8k2aC1zoXB8fneKr8vfywWJ1Pq8oEGaCcyPzu
 VZy9byxHe2CBTn2F+y5XfZGa9aW4p8wit7EbA9l+Hhkf36WnplWjw0ZE8RmHYIHnOXH12sQDKGL
 UscRcLtwdMkUvo3yZmQ==
X-Proofpoint-ORIG-GUID: BlpWliFwfu6CMBC6Zk2lRX56vJqbkMe7
X-Authority-Analysis: v=2.4 cv=GpnXaU1C c=1 sm=1 tr=0 ts=6af2e862 cx=c_pps
 a=skQXzUdJ1yZbsxdDph07EQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gAnH3GRIAAAA:8 a=41uZVQQKMuXa_9dTNC0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100038

On Mon, Nov 09, 2026 at 10:59:50AM +0200, Iustin Stolniceanu wrote:
> The ADIN1110 and ADIN2111 MAC-PHYs integrate the ADIN1100 PHY and use
> this driver. On these devices, CRSM_SFT_RST resets the whole chip, not
> only the PHY, undoing the configuration done by the MAC driver before
> the PHY is attached. MDIO reads also return stale data until the reset
> completes.
> 
> This is not an issue with the generic SPI protocol, where the adin1110
> driver configures the MAC in ndo_open, after phy_connect(). The OPEN
> Alliance TC6 protocol support, added in a following patch, configures
> the device in oa_tc6_init() before the PHY is attached, and the
> configuration would be lost.
> 
> The MAC driver already resets the chip before attaching the PHY, so
> don't set .soft_reset for these devices.
> 
> Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

> ---
>  drivers/net/phy/adin1100.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
> index b946cb86b6c4..ddb91b0e7081 100644
> --- a/drivers/net/phy/adin1100.c
> +++ b/drivers/net/phy/adin1100.c
> @@ -341,7 +341,6 @@ static struct phy_driver adin_driver[] = {
>  		PHY_ID_MATCH_MODEL(PHY_ID_ADIN1110),
>  		.name			= "ADIN1110",
>  		.get_features		= adin_get_features,
> -		.soft_reset		= adin_soft_reset,
>  		.probe			= adin_probe,
>  		.config_aneg		= adin_config_aneg,
>  		.read_status		= adin_read_status,
> @@ -357,7 +356,6 @@ static struct phy_driver adin_driver[] = {
>  		PHY_ID_MATCH_MODEL(PHY_ID_ADIN2111),
>  		.name			= "ADIN2111",
>  		.get_features		= adin_get_features,
> -		.soft_reset		= adin_soft_reset,
>  		.probe			= adin_probe,
>  		.config_aneg		= adin_config_aneg,
>  		.read_status		= adin_read_status,
> -- 
> 2.43.0
> 
