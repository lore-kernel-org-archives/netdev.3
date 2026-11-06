Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793975332;
	b=GZpAYg6QnFw4SQvW6bZbf7DQtNoyBueQ01663vpuuhT4XAYdGCf1nP5C/tLsgPodqDAh
	 d4VHZpe3yox5xXURMzCtaJJGT5N8VRhUBk0AgjC9fIk6n3TQW+glctDbrkfMn517YId53
	 LsnLuU+tmW/aownx3SLtoiiZwMXJGNOr7DNC/g2WlfhedYMgP4fC+DXQcm4V32n5jgLZl
	 lXS72kApSTRf48hnwEeyjhTxL0+pDDOA5SdBET7AKuXlLMZmUteiXa5xkQ4IA2L+uk9RT
	 tIgrtz0K7xlbEYI24LDidSeHpwRoPxpZTidObhFmYVlkLeGJPup6dKq29GQxWUqFWiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975332;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2jI4Uva3gRyYoTpZfZ41X6p1LLIN/8biuV9eq3Q5Uo4=;
	b=o7rCAXn/5MNR4xIt9D4gITAoFDBGG2xODnk0h8gy7AN6nIEsrHmR9rfF0pWtT8ZkH/Zx
	 8iC5tD2OD0c0iL07tZ4pF0MX9Iyq0Ao/lM3fGWfkMiXHkUWXEcxOc3LgbmiZFhycRHNmR
	 94StkArb+OJSFbNLZzYA8fDG2XOYyQhc+Equv8CRmG3lcolt2k/xRWpx5JKcIRKfZHxuX
	 MIlh1R/Ups9aIWDKf6/WE0moKJvpgRtLwFycc0aIrBNDFJZmONP91B95e5vHv5I7+Ats7
	 qvpxGKvvOfhN0I1/02//3FXUZM9ZJ7I00BRacnmWY3lc4P8HlJsBkoQB5O4LqGXNY1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=qVaJCrzz;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="n6E/3UiN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08576606A326;
	Fri,  6 Nov 2026 14:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08576606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=qVaJCrzz;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=n6E/3UiN
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6EQrmi2850567;
	Fri, 6 Nov 2026 09:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=2jI4Uva3gRyYoTpZfZ41X6p1LLIN/
	8biuV9eq3Q5Uo4=; b=qVaJCrzzx3DGIWhZcZf7GGA0iEe5xh569sQRIGT0Cuzre
	++bedON1usKqsJijrTB11FhBpv0PoLiHbB4ZcMwYqhjUMgxKEcgmKArdKK1X5pGX
	NebasnGheJGVe6EyFbIxix+MHcXI8qoq32S8F3GNc8RO4kZhoN0ZiXcuU+IbRHxP
	UGU5VI6NbdQ+tYhjG2mbu/Om+FA6MNUgre1ADITeeRyRYRl7w5MHQcqnd26ejcoL
	2PX6lITNR269v0W80J2qO1xeUGwSjBAbuIqckBU94TcbGex8BAkxgPsr01C+Ya6C
	uCZ+kH8vsZ7PJIIoluwMx1qeSgN0pyElhx5mpmmfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=2jI4Uva3gRyYoTpZfZ41X6p1LLIN/
	8biuV9eq3Q5Uo4=; b=n6E/3UiNtGjEp9eXYFYPp1oMNs10EMsi/OmeTkO0o64KW
	fdP3haiOQq2jueCAUcEgLg+sDpP5HqCTpHvvtAFA8mWn24eH989TfRU5tEkiwmyG
	MmoQU6FynEKyuYoJka2Y6p6tMjYOzXEgyHHY6092mKyBWGn4ibewfiLWIJblfUfw
	bDjGlEo2rZuBby/feQvc2c5eHCiaZXk9rwEO3MuO3QL5x5BHMXL/rJ7fjz0IxyCK
	UCaZFPLPGOYxzb5LjA7wD6EGJr/+z/MW5UQrU7hLPy2ni9PWYfVLvB3biqQqaaTN
	zkxKxdMezAjCAyMHR2+cFYnU4TPZReMXmDVzXX9Ew==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3pwm752-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 09:28:37 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV8LRk+VhVcf1zIKY0kUGjHY8EpC4+o5jXijJAMdiLnkFGS10Vg49VaZITW0NlUhZB3XXZqMNBy5R+Vjl2v7I/tC2u8s5gjr5x8cGqc+zYQLqCMEmxeDmO7pWZeuK1ZrzugqPvkMBqTw3gRBv88aNs1eeNjn4sLmQGq3QbblfPWUormAIcLkZL8Fd0du2LQySBraMcDdEQ9Ep0oMvEGvOqC1q5iUQkcqv0DCn+xlALA8mY/p14uiP6PshwYNXw5zqWZqZaI6rBNEY1Y6k4rT1C/HnnjUkfTga2w9odAEpwVY1PCPxdlJsuZNfreBqjRMUGnkPXVGlA7PBpNKVAQu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jI4Uva3gRyYoTpZfZ41X6p1LLIN/8biuV9eq3Q5Uo4=;
 b=vt+AOsQ2fK6aQaDV5Lgy71Uej5Uz35U5v1u0MBl5LQc8ISL4c1mDfoHz/s7DV8LJlnkUkrKB4uAK1kdbl8nbFhrQMt5BTkU5yU7N0kNUslIexL9jkRxxdUpDyrNS/q9TCtOIswO9/+4PiA2b5PJQPE7lybVNm4pwUb4SOG2QPoFLW5NNd5hHz0K8qkiaz1rUGMCAMRrjrzvuO6s1iAVb4Q86oUvKHXH29ulDWn8fovWg4MxKT/nsp1bpVqCWaAYosDZNN/MEvBXMCDiC9aF1SCZlFO5mw7JNH+WIyDM1FmjeovzpYTsASOJQAENQDgEEa1PbAntKnbsBZD7q/0CEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by MW4PR03MB6393.namprd03.prod.outlook.com (2603:10b6:303:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 14:28:34 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 14:28:34 +0000
Date: Fri, 6 Nov 2026 15:28:30 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
Message-ID: <au3hdMxLSilNxhnK@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <3ecac0ea-830b-47a0-931a-67fea637f0c3@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ecac0ea-830b-47a0-931a-67fea637f0c3@yahoo.com>
X-ClientProxiedBy: CPBP307CA0007.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::10) To BN9PR03MB5977.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|MW4PR03MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8ae963-29fe-410e-d589-08df3c123cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|10067099003|4143699003|11063799006|5023799004|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ilDmMFavlte87NFE7JQizWRXoyPD448e8mxj1sxUMe5vNtNOxXvuUjcWzCq48Nhk+iuNeSsWNU7vxDvLqn4rFBpdCkvYt2lIEWmV2MwEFo9MeYJDbF6NPB2aR/rYs41EsAR0daVNqjPkcxU+cF9VGIwL6Ava1swfBP4gCrywrHHvHkgGyKK50U2lLMcwZD8BaSJL+jzGh9nAdIaAmDLtIXPfk4+3f77b1JkrupeJbfqbxMhmtR4ZgjVJry9MHhtjFkGIqR8McyKueprDDgdIw9kYz+FKLjb1TXsXwMscf6QmANi3wWdJFIlap2EKo1ig4wjbm0nXwVpJqoOxh/QCSu4Kjz8lu1i8P7mKSLmgMaCO3yfC6yyxf2087KuIG4ArapQX4zcaKzSv8hFXJr5wYi5y4c3xwyb0U8rhBWlMItH+qfdBsB7tZLY/ONBVUp1UHjrmQ+XBOqsg4NDXxt8hVdG7k5Ajr9DWFhjmr0z21d9YvgL8eGUD2lxFrR7f3aGKSDiScYru5SkLKPlpDZT3csqJSCNDXtqxzTm9H7aQJ1GsXemwPKNwuyDarf+pv3uODtnNwGiEYSF2RRmO3LTmHCEg9Uk2UUgLb3y8W1ycBJh8FnWh2pXWbriaFhTtKtORx7kWVQCnjJhAovSHg12Wubqq18AmQTe8QxZ1tpjVbm4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(5023799004)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDMrZVhxb01wOGFUWjgvWEEwWis3VDUwd0FnSnpMTDhnRjBEbnEwTGlGNjRp?=
 =?utf-8?B?MUNieHJ1em56eFBWTkp1RjFEWlVTYmUycVJFVWNhWHNveWgyKzgwZXVaN2oz?=
 =?utf-8?B?NWtzenQ3SmF5aDVSUy94RnBPTWJsR2NycmZwT0g0alkwQ3JLd1k5TXpGZi83?=
 =?utf-8?B?Q0RUb0JuU2RJMURNNXYraDBpVTI1bVVSVERSLzBSMFRDbkJCMXFQdkpNVS81?=
 =?utf-8?B?L0o1aWJIWUlmUGFWQnR1VklyTDNHUGdxRWhYdGdlYXdXTngyc2Rkd3EvWCtQ?=
 =?utf-8?B?Q3NCQXZncEp0VHkxbXJ0N3NLbDJDcXY4NG1EWGdCa3VpSlo4dDVvdEcvZHZR?=
 =?utf-8?B?RmRlMDlNSDMvbkx5a2xHOXZoZUIySmdHTHVXMGVTV1V3VmRjUTlmLzl4UHRE?=
 =?utf-8?B?VGhXSGNJTnFPbkNnbWhrdkNaRWxwZkFETUJvUzNjTkN0UVYrb0l2bDBwd2oz?=
 =?utf-8?B?WENVVXlldW9JZVR3RjhBRGMxWVpLUWdtRTBQQlhtK0F1aFpTVzV2NUprQUY4?=
 =?utf-8?B?V1p5bWxucHZPZDZNU1ZrMm5GcnIxUVNMd1ZJTVRSUUJnT0U5NnZSQytyN0tI?=
 =?utf-8?B?NWd6d01zdEIyMUpRQXBhWUFReHprMUlHazdCOFoxaThHTnB5a1dvQ0s3TStG?=
 =?utf-8?B?V1FUQ2pZL25RM0Z5ek9YTCtrdzdvNjJlQW53Mm4zaldJM3h3UDc0V1hIaDlv?=
 =?utf-8?B?MVFBYTVDYjlaVjhwMWg1QXBYWENSbERBbFpmTFp3Y0gzb2NRRjFSWEpjYTg3?=
 =?utf-8?B?UTdHSTlGS2VjS1FCU0k4ejl0VXgrdUlUL3VrVmxSc2tXaDJIaEE3b1hpdGhj?=
 =?utf-8?B?R1B4ZCtEbVFvMGNLakJOSjJpSXBzRTEzU0xTOHg5VGl1dzNPVmp0d1JrODY1?=
 =?utf-8?B?RWFuTno5Qk5Oa1NjcjVRWkZ6aDgwVENTR3lpL0dmeFRwOVR5VXhsYVdVSFJ5?=
 =?utf-8?B?NGo0bStQdnRxZUpzM3g5alhPRnErYjRqWDZhSUwrdE43OStJYjBSVEl5U3Mx?=
 =?utf-8?B?ZmZ3SGVqVytrdWVpSk1rWUVHZWpYdUU5TEtab1JNWE5kS3hkMVd1dHpISitD?=
 =?utf-8?B?YTZmRW9pNmFnSXZPcTQ0SWhCb0JjK0ZxVlNiQklnU1pJaGw5NWkzUit4MXBp?=
 =?utf-8?B?RXFWbzYwcUNicmsxNmlRTXp0WHA4Q0tYeW05aUtjREpSLzFkSEU1dGF4VGRT?=
 =?utf-8?B?dVhXOFNQaEZuTDAxVFJQL2doSEtvYWErK1E3QkxFenhwQzhkVDBHVVBBNW9j?=
 =?utf-8?B?eEFxcm5IS0dPRHVadTY4SW1LbzlscituTHR1L3IvMHMwVVhIMjIxNWwxMVAy?=
 =?utf-8?B?bnFBRS9ucThqRWxBbS93UER5OXY3VEhkMmFZQzZiRnpKaGEyNmlYQzR5blpp?=
 =?utf-8?B?VEFkaWVHaHFVYWlMakJTOHQ4SmZlVEgzRVBuOU5laVNuc0I3bXVpRW1Tb0wx?=
 =?utf-8?B?NGxrOUVxVGVwcDBDWjYrWkNzUlpTRWc1Rk50bVdaUTNOanozNmpMZitOdVZs?=
 =?utf-8?B?VFhvUlBhanZQa2hBUjVtZjhwcUk4bUtxODB0dUJSVlcwaDV6TkpwMHMvdUs3?=
 =?utf-8?B?OXEvZ1BJcXhCbnQzWkczRVdnaFR6b2ZWNjBTQVgrc2xuaWhjZnNWRm15SGZu?=
 =?utf-8?B?aTl4WlpsQ214MGoySEg5NS9QRUlUZWtieUlmNzRTM3ZvSXNjWVdqSm4vZ1Jt?=
 =?utf-8?B?ckJPdHBkK2UyZ0dJU01OcGJ0eGRhT3I5Zi9tMXVTN3l0TUpNZndKMFQ3cU1w?=
 =?utf-8?B?MlZVNDNDZk5EWjlMY1NxUVN1cXV4N2RmS1dTMlU0T1VYVGZOa1BkSmJJeE9v?=
 =?utf-8?B?d29MUGxSRldIRUNYM0lxZ3RVUDcyVCtONlk5Ui8wd0xhdWp1VnRkaGp4Vk9m?=
 =?utf-8?B?WThUb2FjUE9kMWJONlZqZGF0Qytja0pQZzdFVnJVVzJDREFNSlpFTTIrYU5O?=
 =?utf-8?B?K000QmxuR0ZlV1c1bUI2YWNoV2ppQWxEaTdTUUpSbS9qdlZmVGtlZmQ3Y01M?=
 =?utf-8?B?VW9SYjZaL2NvNTRNbUJ2SUF6cW1PdWk2Q2Z0dTVGOW03aUxxQ0l1cVNIOTk4?=
 =?utf-8?B?dDI5RU95S2s2T1I2dk9uQ0RvaUhQT2dLUFBUMXdXaExrLzFRSzdYMm5JYWMr?=
 =?utf-8?B?MWtQVmozd2NRUWdNN3hNODF4QXFNV3Zabkg2OXJtWHZBaWZVNGhLVW5PMVdL?=
 =?utf-8?B?OXBKVlJ4OVZSYlFNSGxndWdFTlEwbG05MTdhTGlTb3ozZTY3SElZSDR4aE92?=
 =?utf-8?B?OTlONG5pWjhPT3FoTFNDREthbnZuRGhtM20yZVk3K0twSy9QNitQNk1tbTlS?=
 =?utf-8?B?OC81WUpGUDh6UmdpV3E4MDM4YVYvR3hXMFIxTCttZ043TmpZUUF4QT09?=
X-Exchange-RoutingPolicyChecked:
	R0MUU+TuRkag10NjlBYFwQOFpSQCQmQkrk5aeMLzRQ6+FeU3X+coyZQBiqITf/oko26WJmlZMh/BXxs7CYGQEks8JtsPJbTgQh2xzc1AA760IJ8SVU9Lf8tnmid/28EwA5UgubzsPrqQMAhOdmVEiL2ffu35o1qonuZrT7pvHRIvZqow+b2+kJ7K0AWJwQy6daKJS2Dfkz8y8G/RIq+mY+CFOjWRPVHdUPDVZOnmjmBthI4RkIu3ePYfTYBrUgq7x1tSEjrrNRWQ7/uiVrP91kqBBtqWh+3Bp6/ZF7KzKrgmNh3HhEYIqlGe60Ui3Ate/fmeIeKeyCmquwHkIG3vtA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8ae963-29fe-410e-d589-08df3c123cf1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 14:28:34.3737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rFX3HAJf3r5feSnnyplnVIzDSS0wgWMDp/jtLAxh8xTy3bvhx2Pa7SXXwgy3ynBhcyaBkfpK1hzCH4lqwFoszG2gpHx4zOsOqV8N4lB1Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6393
X-Proofpoint-GUID: BKvkle4LyiwUivNuCMqI1i39IQ2miMcX
X-Proofpoint-ORIG-GUID: BKvkle4LyiwUivNuCMqI1i39IQ2miMcX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NyBTYWx0ZWRfXzLmS4rpEHpZ6
 yFPvIKuJg1ii1IjQwxKXBDSJcsdsvs4I1b4GLCK5+XOuicWFs7gvq1gYhAR1whakn9CycRvi3XD
 Lg/j4WkerodQDrL2yERHaJHqyPieqlXoTjBbj96+gIV7pwtadcpz
X-Authority-Analysis: v=2.4 cv=d9BgWhjE c=1 sm=1 tr=0 ts=6aede415 cx=c_pps
 a=z/rjtr9/JqYX5j7IdmSYkQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=yPe-Hl8F5_h26fvcC2gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NyBTYWx0ZWRfX74fUFytwcoce
 YhHsya+PlJhBs9gLUF2ST0N50PAussMmIJzLAppCd4gV4DCM0emuE2bEycD3DSTXCjz2YgzXetT
 gG45rUdbJg3usYiA9JrgQlOLa2b7TFTiJRFI7wBc5KQnU4mxWiWR682mVH6RvrlIDLknUeLgg8f
 uSQC4bJXLTrayOZuV2PuY1lwNnMOQy6Ja8R67Dpfg3RHWLWVfH38ZU6kWAUueODEnYFaAxXRGl0
 6bsGzI57mZpYWlMLXLTSmfmwlt5AnR3qi52R0ALjbiYnZlfEMwdQDAAUeLO6XqiT94DB1dEQrp2
 AOU/sbMP6eDTR7nvbiLCPy+xJcRQQLWQU3eEgBguiNtwrT01ibfUQzTcijKPa79CNoN1hG4vzAw
 yd9oYMDh3J2jpM/yoUXhje6Sy0gsvzOaA0NXdgEmGcFjfq6alzDTVF78bKcerpfVjouHGGRbYt2
 QXRzQdzr9dekUNYg3tQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060057

On Mon, Nov 02, 2026 at 03:43:45PM +0100, Mieczyslaw Nalewaj wrote:
> The family D receiver latches on the DISABLE -> HSGMII edge in SDS_MISC
> rather than on the value, and it will not latch until the MAC at the

I don't understand this at all, should it be obvious what you mean by
"edge" and "latch" here? I would assume you are talking about interrupts
but it's not clear.

> other end of the trunk has brought its own half of the link up. If it
> does not latch, the trunk reports 2.5Gbps/Full on both sides but moves
> no frames: the CPU MAC transmits, the switch CPU port counts no octets,
> and there are no CRC, alignment or FIFO errors.
> 
> The two ends can be seconds apart, e.g. on an IPQ5018 board:
> 
>   5.27  rtl8365mb: configuring for fixed/2500base-x   <- pcs_config()
>   7.72  ipq5018-gmac-dwmac eth0: configuring for fixed/2500base-x
>   8.02  ipq5018-gmac-dwmac eth0: Link is Up - 2.5Gbps/Full
>   8.56  SerDes latches
> 
> pcs_config() runs seconds before the far-end MAC even starts
> configuring, so a single edge driven from there is not enough: the
> receiver has nothing to latch onto yet. Neither is pcs_link_up(),
> which is seconds early for the same reason. phylink does not help
> either - it never calls rtl8365mb_pcs_get_state() for this port in
> the first place, since mb->pcs.poll only arms phylink's own poll for
> in-band links, and this CPU port is a fixed link.

OK, I'm out of the loop regarding the SerDes stuff. But I find this
patch quite baroque and the reasoning hard to follow, with a lot of
strange terminology (episode, latch, "value"?). Maybe it's just me.

Is the shortcoming/issue you are addressing one of DSA when a SerDes is
used in the CPU link? Or is it rather some hardware oddity?

Can we use interrupts instead of polling?

The notifier block, extra locking, etc. gives me the creeps and seems
like a lot of infrastructure to solve something I don't
understand. Sorry if my questions are dumb, but I need a better
explanation of the whole problem to review this properly.

> 
> There is no local signal that predicts when the far-end MAC will
> bring up its half of the link (bit 8 of the SDS link-status word
> does not change ahead of it), so the work cannot wait for it; it can
> only tell afterwards, from the link-status bit, whether an edge took.

You talk about "it" and "work" but it is unclear what you mean. You've
added some scheduled work in this patch but you do not make that
apparent in the commit message here.

> 
> The far-end MAC starts when its conduit is brought up, which DSA
> reports through ->conduit_state_change(), so an episode of re-latch
> attempts starts there. Only the conduit of the CPU port that carries
> the SerDes (port 6) is considered: the chip can have a second CPU
> port on RGMII, and its conduit says nothing about the SerDes link.
> pcs_config() only arms the work, and starts an episode itself if that
> conduit is already up. The work re-arms itself after each edge; the
> next run checks whether the edge took, rather than waiting on a poll
> that will not come. When the conduit goes down the work is stopped, so
> a link without a far end is not reported as lost and not parked every
> 10 s.

I'm basically wondering here if this is not something that DSA or
phylink could help with?

[...]

Cutting the rest for now!

Kind regards,
Alvin
