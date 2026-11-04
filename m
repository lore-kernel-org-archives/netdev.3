Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793794849;
	b=PTrktX7KsqLG2QbgmetdD+3mxzABWGJiCrnp9s6XysiDSygXLKs0wHJrhtetYR/EWpKK
	 3fKItO3f7bcpP5OPqGClqmZu5rZhXEze+2JFPjk7DzNV+iLKwCMaD7lWzLgLKp5mFDqa8
	 T/ewgcD5b9K6oNM0pbOhkQwn4WgZAWBpFKDL7iVZHH2ryyaB1U7zwQOUv0NyDQcsmZ8fh
	 z5SPoqq8MveHhDavs/2dNUBJcVQRkCMjl6zaWXdXUluT8W+4xY7hrrTbIs5yyumJ35jiA
	 Wo9dcGl1mn9lJsBYuHK/16qFclSfWGUKx1NwKArmCXOYJfkf751Hj10sUD51ShFQNAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794849;
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FFbEGH401l041OIw1JpxiX4qghmNFTYv5ostWUmOYNg=;
	b=Uz4ikof9Md93+LJMyOmhGm69Bq6SvyNI80eCtWVHt8aBWlpV2r9VGQpcNEj3e9yBz6Y7
	 b9e5QOy6/pkzt4lSA+DQFL98bRVMUiL87+lOq4gHVBaniyGwm6MenbAhLJZq82dYxu38d
	 iThv/av9VEcLgHIYDbrsQKO438oDbqppcp55lAvPVUaYytaIpkzbR0TJ2WZwTtXb13ktw
	 LdAfOLw0O7hf8NKEceLnY8cTzB0SoHu/8z+1oxeIJU3MJCm1NueyHrdiD0JvNa08yHEDe
	 XMfzuwJz/1PnlzSsjnKbtsmuxqYsztSwLrstXJ4FvpBiH/YlTZYNRscA99mcbHi0ITQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OP1RBYqi;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=qpCehPk7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2557606A326;
	Wed,  4 Nov 2026 12:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2557606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OP1RBYqi;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=qpCehPk7
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bar8u983083;
	Wed, 4 Nov 2026 07:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=FFbEGH401l041OIw1JpxiX4qghmNF
	TYv5ostWUmOYNg=; b=OP1RBYqiigMdKHFq9c/PW7MrJFlpy9UVknY+iKde82mql
	5m+mgi96LBmjkFIFIOVdfntlSGTJAUeyKyDqUeVSDKSHaAwrrOFFLl6kGem4upeR
	lhrYdBaLMXHjIyYt+RKyZwXC+2UDtADpru/ejvSVPR56h4Za87OUdTy75WV8Yt4k
	pfQagE87kinEpbJOhCB0Ce7ZXtjTSX6STkZOu22ojl/8jP3fmMGw9tpZzOYE0sby
	LQQk4RyGyu37y1thN/13ABOzhUY9Fi0EOJcNlMfiKKv5+msJmNWXCCGdUHHSNyZA
	RdN+VUdYDjiYaTCNJlWcjueC2Cd1PdOV9jZJ+fUMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=FFbEGH401l041OIw1JpxiX4qghmNF
	TYv5ostWUmOYNg=; b=qpCehPk7jHXmY5KHa4eiz7qIr6XppajWrFVA2YWYh8mbZ
	YmWWc6Xuuo8/hPfnmWNtxumsA08v9b6lPA+C+FC5ZBLYEeigfjHWUhP6/1yajtum
	HHiy6TLuo5W4sYyUHhqxKaMiLCIgxl21okeXH/Wk2/Mym10JlMwq4biMYykrarP/
	ob8rOJbihbxhO4fbTeEZq/PYrsY3IyMTeW4hsWKViDwzE3EzbKy2BA1McEOBy/g/
	XiaLfIM8K9+47nfpV3Y75AwoYay0WBXY6zSkNvDja64QUcWuk4XKbNg4Z97Q7HqZ
	NEXHo2ccdW9nedmxZw6SNnjGlioGRQqQjQ6ptxDRQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hqkb253sb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 07:20:20 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY/NzewR5JCdOgONTqL4R6lMe7wdA5KhVyWVBEhX0Q3oBjJP/QVo+uatysxl5KD2AQsiCLIOhGaAubXFzrZgwQczv05+vWnOP03nV4EYd/gvdEJsOEhFpbdzZ0fYEhw6pgv1jc4A9f4SqCCV6gZJVDPnPlKmRJdLOp3G24ukyhby6DXK0bTWpWgJZmyeZQ80L9ov/LohyopyNRhobJlTg2vlLUpQoKtK/WYrq2Su51/UsHYuei2fxIY67SmLRnVZwhTVrjw2qzYFMpUrCr4IbVIMF2FR+7Vdn71gsNPLR0Ahkoi8N0qW0dfUcvQpX/fv7rsOMVy6HdpA6DXkzhPj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFbEGH401l041OIw1JpxiX4qghmNFTYv5ostWUmOYNg=;
 b=JDh5i6SohJD8sjPyxOaPMYu1WBD4Wjqr8D7eXZzkcOiUVC6dpqHwZONMgsoXRYl+L0DeNTYqinzxQZPboB7Sva3rlc+KKSF3jFKSFquni55IWmOAPyc4Uykd3k9nNePkz5YBd1VdvJAk5lIMRGuiBOEh50MtYjwMJP0QvdGcBUwEtlXhCovXIDPKFkx5eYJ/xfqM3/eakzPotXetyL3NwoXPiNlAnQHHMf3EzghEHQAVep+YkpqJ5UJUbb7zyHemTpogFmqQM1CuDNkK28k+gvXjKNGCX5jqbLlyHx15TItBAeXDSLVOfg8BxodPLwibMaVGOhZsd5pnIFx4/W0ZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by LV4PPF3BC8B6302.namprd03.prod.outlook.com (2603:10b6:40f:fc02::20a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 12:20:18 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 12:20:17 +0000
Date: Wed, 4 Nov 2026 13:20:14 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 03/10] net: dsa: realtek: rtl8365mb: set
 speed for family D
Message-ID: <ausWDFnyjSgnN0GS@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <d7f64039-b629-48eb-a985-dbcb2cc53774@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7f64039-b629-48eb-a985-dbcb2cc53774@yahoo.com>
X-ClientProxiedBy: CPAP307CA0006.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::14) To BN9PR03MB5977.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|LV4PPF3BC8B6302:EE_
X-MS-Office365-Filtering-Correlation-Id: f447ac43-07b1-4f47-6007-08df3a6dfcb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261022113327099003|261022105027099003|261022075727099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	fpAxVxTyy04z97lH5nXyrDtHfIapuP7nmXsGsFFh6RkDYHC3BitNSBxwAGhJiEzL8Kqil/yZMSXW+gaPLcwxnQQj6BNzADHwvd3WCr/bR6F54RnuvhyvoPXTmx8dCYzkjZlE6wg0efkaPIH07L1UmItw7mOlEJtfntK6xL/WlqbvdxTMWZ8fbhaDEzzZJLlsWu1lO6uBmRxiumeIcAoBHe7QXEZHe3eGxYHzOIfQLpSTIeXwY6UJU8Xf9Pq7GRkFQ9x6bUhD6BMN6yvirPc38f2fdhhwzlvQZ+3z6L4wCgFRzEnB72V46LLHnXZrOeYNMIDWKnn5aWuCR7sCHzuB8ed+oF+RqysEfF1quWPDrWGi1ATrln5LMaV5hS3gkM5Y13hQey4WUL7/dMqEAEToxvGscVYaswPbVEI99R6/iWrU1Hplj2fq1CrF93m9TAIt4tbErGuii7iUmCjgK+wXMlvXYW9c4bKopyzT05ehAKByhgM0ek4f49lt97kGHEvyhDJoKdLp+SJZ4+vk7X/RGwOQcxqzMYjLGqTca5b4ytJoEeCvBt7DgUWDTrwaBYdvJC4SOpW4ZV78bs4VbkwAiFkfJ/i1/xI0Zka47x0VXpHrVoasz6Sn/jqBIfbQqRUCxZPJnd9OgfCjJ2xfoEd1P2LdrOLVTfZPKgj1Rvp61to=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261022113327099003)(261022105027099003)(261022075727099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUs2RXZFQkZ4RDM2blB6LzBBczl6V3cvcHZhUytVY1AwYW1SbG52LzZ2b3Zm?=
 =?utf-8?B?eXRqbzVVSXp6dGJIU3dKOWlrSGRsVVBVaGowQlJQazl2MGRmL25XRG12aVhB?=
 =?utf-8?B?TjliN1pGVXE3SnZ3WkQySFNaMkEySkhUaDJIL0ZBMkNYRHlwaXJQVEo3VDRE?=
 =?utf-8?B?aDVteWtwanBocjB4RW5iOXUyTE5sUE9DVUNOUmRheEpYYjc3R21aRU4yUU01?=
 =?utf-8?B?cmQxc0Y0b2Y4b2hpcUo3TzlyUEdSYW1VNE13UXl5M0ZnNi9MbTVHYnZWRFVw?=
 =?utf-8?B?VnJ2WmZub05rMVBwbWxHdUs4YmpGdmdRYjc3bzhGUnkvVVVjY1BUMU1lWEFu?=
 =?utf-8?B?eVo1QU9QVG1tZmlTaTk1elh3dVJKMzM3bDVsWllPTEt4YXRqWWJMdHQzQmxw?=
 =?utf-8?B?WFc5ZjNnb2ZsN1FVZ29aOVFybTNLSUQxYW9OcDVnU2pXU29SdmsyT1didVFv?=
 =?utf-8?B?cWZ0ZFhYQlIzZ25KMHM3T2NSajNKWHJCU0EwbzJhQkFyQXZlMUVHbUgyM2sz?=
 =?utf-8?B?d1Vkd2hZTW4wVVl3d2R3eEtLOGgwUlJQbkU0OHJQM1pPSDBneHNqTWRmaU5E?=
 =?utf-8?B?WnVwbjJQR05EOXJ3NUMvbHA3bUhlck5ka2YrZUhjVElHZjhXYmtwc1JxV2V2?=
 =?utf-8?B?UXpZWnBLcktrUXpNMXIzTlpqYURWd3owWjc2ai9aYjQ0aVczaG05MFAwb0U1?=
 =?utf-8?B?Mmg1cEVYL1JQOEtzdE02ZzNodW15aXdKQzJ6M2FObFpNdDd0QzZ6dlVqZlVE?=
 =?utf-8?B?ZG1GLzJMQjM1a2RrcmlwV1E3WWtqSy9teE5iUXBoNWFSUHhoOCtmS3FVa3U3?=
 =?utf-8?B?OXVWVVlzYkxVTzhuYzJNZStRRmlSOStad1BJOE9veWFWZktQcUo2OSswK1Zn?=
 =?utf-8?B?eGZBeC80R2xkK3FTZlVGRHlySVN1TEtEOG9uZ2RGNnRSU1BxL2dqZmloL2U3?=
 =?utf-8?B?NXk1RndkNTFmK2t5RzMvYVNxbXZ1aHBYUlFZUCtqa0gzTDI2ZW1TWWxxZkUx?=
 =?utf-8?B?QVBWaG16N2puK0h1WDYzNE1YcWFCT2Z4bEJ0YXc5dG02OG5ZSE1kRExCWkFu?=
 =?utf-8?B?VUc1bGJURTdBdkQvTWJtTGhxWDBJMlJ5U1IzZUIyc0ZMQ0NWZTA1RjJYVlJ0?=
 =?utf-8?B?TnAxK095ZGhaU1UzOUxtNStBWkgxb294bWRuSFlPRmw0ak5GaTRtV0xzME9R?=
 =?utf-8?B?anlQZHVyY3pLelZUWDZ0VlVYVVlhVGlWZVRyN1hxM1lDZkpRMnJzL2E3VWNq?=
 =?utf-8?B?bTlFb1hUNnZXZk0vY24zcjZHa1F6aWl5RllzcWoxSDFSdXZFejE0c2hxVWp6?=
 =?utf-8?B?dDkzZG5KQldVNHZjbEk0Q2x5NmkzdFVOQktUZTJDblFTRXlFdXZaMTVTWXFz?=
 =?utf-8?B?OWRtR05XM1R5RDg2OVlUdkpYNERvcGg1b2tQUXI3cmh4a3RaeXErdGpadFdN?=
 =?utf-8?B?OWQ5R0FnVjRyR3ZwU0ZsMHZYWGttd2RnWU50bVdKaE5aQmw0M2VIQ290dTda?=
 =?utf-8?B?N2lXQURlMElvL3BxNTMwVFp6VTRVTlhsczh5c2xzc2pQU21DbDM0RGdZZlFo?=
 =?utf-8?B?T1ltVUNkUGlZRHFWSVhJVnkvd1d4T0lJWkZwcnZQUHNDMzFDU0xSRWhaMVNw?=
 =?utf-8?B?dUlHd3cvdnQ5cENHbVM4WkQzbGpvV1hSWURIckdwVXFZV0t5SDBYK0FtNU96?=
 =?utf-8?B?bzlodDZVZHNTNk0rb21yamhtQUNDejUxK2JMR1RzWXZsN21FY2NDK3lhVU96?=
 =?utf-8?B?TVIzMlF5S1VvaFZ2V2xqdUlubll4NC9WSmxZYytpRXVWNENLdVJYaTRUTTJF?=
 =?utf-8?B?Vjc5eGJaczZGOXRLcUtlSVBPQ0xSU3ZEd1FFZWtsR3M3a1FxckszNUNDeS81?=
 =?utf-8?B?V2hyZHhveWR3R21vbjhRaXFISFhsYWhEaUhVL2ZmdlhzWlduU3F2dWNsS21Q?=
 =?utf-8?B?R3UxVWRpYlNYWTV1U1dlTExhUFRCNDlqaWR4aFl0TFFBcWRkOXFCZXRKaGZr?=
 =?utf-8?B?QnJGbUQ4TmM3OGU1UjVMSU9EMTFmNUV0S1JJbnJvQWFiNDFidFM1TVZtNWds?=
 =?utf-8?B?MytRUVNzUXlNamdlWE91WHdJOWVBcEE4djFQL09kMnFpRjVwNWZSY2lERWdQ?=
 =?utf-8?B?bVZiU3FRbjFxOXcvWDMzRnRjU0RYalp5YUxxMmRlQjJuL0kxc3hPNkhDZ1Zq?=
 =?utf-8?B?YVpsOStUcnRYZE9yN3l5UHBlVmc0TVBsN0tlOW9XRHpWMXdTcVJOaGd4QUFJ?=
 =?utf-8?B?a2JVMi93aEpodDF6WXloRjV5WUVvamo4MWxFVU1VemlESHZZR0p5M21GQVM4?=
 =?utf-8?B?SmhCY0RITWdmWnVORWRGTVBkWjJYZGdtYXo5SFZqWm5GV0dkWi9YQT09?=
X-Exchange-RoutingPolicyChecked:
	V/mGM3TyVXvh4b5ScQDEQteouliauu7xEhb0TpmFxja9o3r7X7nPNQBk4kCXVutsliq/3+s8EGOOQV+nkkHZOfs+baXwoboHAY+3X4P2eRDt0DbKsaJnn5+syye56zG4Tr5Gy6ZtQIgaqM+mTGEbX1D4UYiu8YBcS4KyF9fbkoNKf8JvOSstV9mDARqJ/dBAjByaMvjZ92zW95XTmw2deAWbEfLjqo+riMVdEWLkB5Z7yt72orWexyTN14ikyynkb+MWrgIk9XP3imGPDX5Z4QhN3THfgzleFrsz7npklxbYsTKAPbKOxetsHDzlgo0pcIz71Tk6pTN5WCiJ3iCtpQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f447ac43-07b1-4f47-6007-08df3a6dfcb5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:20:17.8538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6451c9hk4o5hLyVnuuR7o5if5TNQ9G1IvsvP7DDBh1AJJPYyBqLp2IRWagRR37DmHdhx7id+3Hy2VGWF2qAjHdmh+nXpY/67whRnYOotKBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPF3BC8B6302
X-Proofpoint-GUID: eZPOFXgX5G8ixFrLOUJzRxsBynz4CmKI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0OCBTYWx0ZWRfX852j65wdnuHg
 e3bYEovgzT/nXfW3gBzOlwvoTAVBQ4a5PF1DLTOtemq+FMQXsJmT6T3hpCguOpxFwxJEgY22XnS
 yYT/PeqlBux43E03NzFVFIoh9I/fqZF3SR1yzNv83MyO0ingRyzD
X-Authority-Analysis: v=2.4 cv=EOOTQFZC c=1 sm=1 tr=0 ts=6aeb2304 cx=c_pps
 a=nBoeifw3k4y6eW1CqgP3Vw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=CjxXgO3LAAAA:8 a=VwQbUJbxAAAA:8 a=1Syl8OlgiryVV_blONIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eZPOFXgX5G8ixFrLOUJzRxsBynz4CmKI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0OCBTYWx0ZWRfX7gKKY5IMfkUR
 G16mA2q9nRgR33QioBnsTcxuFlN7QTgShy3K6YudVamDsT5kZWj1HIWzh7ldd5e9GGhuNNY54SV
 bkH2C1O2/07Q1/e9WAbUpwuvtDHyDg+EHOLiHW+IQ4JG6bN3uUYegdy2O3zm+ZG2qzHWvmSqaWV
 VvGuNuf4/5P1Ps8ir+Y0+0ENIl/ey1HA44Ip8mToFY9dy9+84nQ3ASxivSImtCBrZBf9Kho6FAS
 fK6kTOf3Yi1WacgsEKt4HqBsV0X34jCAixGCYP5TTT/mjEkrNAPQchiLmGxIdX/zHYnf8EehR20
 nmKkjQMvglp8K1jYt28iK1OpmXnxbh2u+4eZQt5xZD1kc8N20S2EDRwV1Y4wOX8YzkTKKDsHzHA
 H4q2cobW6du7yp/am0SUcx4189vLwsHSFjvNNJ6BZDGOWWc7j/U95UbbyMphZhGhoiFwh+FHxwD
 OZZRG7WeFmw8V2Ww9cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040048

On Mon, Nov 02, 2026 at 03:38:53PM +0100, Mieczyslaw Nalewaj wrote:
> On family C hardware, forcing a 2.5 Gbps link speed requires relying
> strictly on the HSGMII SerDes configuration block, while forcing a dummy
> 1 Gbps value inside the standard digital interface register. Family D
> introduces a dedicated hardware link speed value (5) for 2500M. The speed
> bitfield width has been expanded to 3 bits, splitting the most significant
> bit into a new separate register field (FORCE_SPEED2), which maps directly
> to a distinct per-port digital interface force layout.
> 
> On family D the forced-mode configuration (link, duplex, pause, speed)
> is written to a per-port register at 0x12c0 + port instead of the
> per-extint register. The bit positions of TXPAUSE, RXPAUSE, LINK, DUPLEX
> and the low two speed bits are the same as on family C; the upper speed
> bits go to bits 13:12 (FORCE_SPEED2), so FORCE_EN (bit 12 on family C)
> is not set. A second per-port register at 0x12c8 + port enables the
> forced mode: the vendor RTL8367D API writes 0xFFFF there when the MAC
> is forced and 0 otherwise. This driver always forces the MAC, as on
> family C, so it writes 0xFFFF on every call, including link down.
> 
> The family D branch is not reachable until the chip table entry is
> added in the last patch.
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 82 ++++++++++++++++++++----
>  1 file changed, 69 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 840db5a..2dabc4d 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -344,6 +344,7 @@
>  #define RTL8365MB_PORT_SPEED_10M	0
>  #define RTL8365MB_PORT_SPEED_100M	1
>  #define RTL8365MB_PORT_SPEED_1000M	2
> +#define RTL8365MB_D_PORT_SPEED_2500M	5

I'm starting to doubt the value of these macros now that I see this _D
exception too. Maybe it's more straightforward to inline the values in
the function.

>  
>  /* External interface force configuration registers 0~2 */
>  #define RTL8365MB_DIGITAL_INTERFACE_FORCE_REG0		0x1310 /* EXT0 */
> @@ -361,6 +362,28 @@
>  #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_LINK_MASK		BIT(4)
>  #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK		BIT(2)
>  #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK		GENMASK(1, 0)
> +/* Width of the FORCE_SPEED field, bits[1:0] */
> +#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_WIDTH		2

We don't have any other _WIDTH macros so my instinct is that you can
dispose of this...

> +
> +/* bits[13:12]; bit 13 reserved, no defined speed value uses it yet */
> +#define   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_SPEED2_MASK	GENMASK(13, 12)
> +
> +#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_BASE		0x12c0
> +#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG(_port) \
> +		(RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_BASE + (_port))
> +
> +#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_BASE		0x12c8
> +#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_EN(_port) \
> +		(RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_BASE + (_port))
> +
> +/* Per-port force-mode enable. The vendor RTL8367D API
> + * (dal_rtl8367d_port_macForceLink_set()) treats it as an on/off switch for
> + * the whole forced configuration: all bits set when the MAC is forced, zero
> + * when it is not. The meaning of the individual bits is not documented.
> + * This driver always forces the MAC, as on family C, so all bits are set
> + * on every call, including link down.
> + */
> +#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_ALL_MASK	GENMASK(15, 0)

Ahh, at this rate, maybe the ext_config_forcemode() should just be split
into two functions per family. Since you're now writing to completely
different registers depending on the family, which are only somewhat
similar. Can you try it and see how it looks?

I'd then also update the "old" C register macros to have the
RTL8365MB_C_ prefix. That way we have an approach in the driver where
non-common registers are labelled by their family.

And as above, you can then just inline the values for r_speed and
r_speed2. It's not pretty but the global macros do not really help IMO.

Again, try it out, if you don't like it, then I guess this is still OK.

Kind regards,
Alvin
