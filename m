Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793984431;
	b=txauPuzqNH6GW+XCz5+MrSpLN7b1c14G9q8MgPCLvT7YDj9NCJV1oqVbIb5SndIbhsjR
	 jzwFu1dO0cc87Pl1Zt9XilUUi+bF5vNyvmQ6GOaWuELIG4ptjvJ4smtNW3tvzEM8fdkk1
	 AK8jBeArAXnTQSDqYcUs/oGTaSfBDEH0r8mMNMsWqmcPzIk2/IgJ51M1+GdSaa1e0QqA2
	 0nZuDWRFf4EGYKIGcl6ueiLqXJVNxXCgyCxQH+xH01UxAqY3TmFzrOkOPwYiISnZr2VE2
	 WeGu7dvUS/npNdMQTWWsNi3glIZX2GWNY3TMYx7BhzBNEZjFzEqAPao1Lyw1ylU8EDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984431;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sG/qirus5IXpKPqDaFk/TvgIHbw4SlX/ypuwL9jdnqQ=;
	b=4C1dGowncSiKU3jkveoRgvny1Kd91f7wuU/l6fYPaOgG7WlUrK0323oqZipIii5IybJa
	 XeLVJSUVh+S/Epcwhehv7Zgq3IOz6SLpHZb1E9cMZvkOj6IiCwbmEkkcGV2qyD0VaQd+X
	 NdSC+tdory2leT8q+GVlZYp37txEJHPNnPt1aZemD3kFrP8a/UnDmYhNe/IDpyNGLTasd
	 cZPvaukYqnefyKo+eT6zzpo5Ble5B40X9b/1ddd8ti/bve5Dml0uQt5/O/PAeMGW1Rwnn
	 fVEOGI1pp07cblD6qZGci4LMAkOy4nZfM/0WRLyDWpABHRx76n1tNBquh8jyM0HsYkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Z0WyfeHL;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=FB6ysEbA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AEF606A33B;
	Fri,  6 Nov 2026 17:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83AEF606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Z0WyfeHL;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=FB6ysEbA
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4ERf833106;
	Fri, 6 Nov 2026 11:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=sG/qirus5IXpKPqDaFk/TvgIHbw4SlX/ypuwL9jdnqQ=; b=Z0WyfeH
	LlilYD9MZLj0XpSqb17n1N2doCXMFH7qmVVkghO/MC0T8WSuKv3XMvx7cyuf38OO
	kzBc1iykFlJQEkFu9vuQ0SiN1TsYvms8pwcgymt8S/wJe3IeSQK1TpSMrkPNiU2A
	SM8HKBhwpUoXvlkDMLIhBNsRRCepxvcIROLR6NXhPAi3U5ERImLNyEbz9hC5gw+P
	GFoK7sQrhUTHXyP1R1oB1BM8oPHbJA4F18boZqlANHc/z4mtZOXHSYi4TOn3y7GS
	RGe+udIraJ/dzqQPUy5Fy+86WwzkM5jRkqeNAhECJMhQ7PzJ3xZH04D3O6m/xGaY
	yUJX1c5BKUOOo9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sG/qi
	rus5IXpKPqDaFk/TvgIHbw4SlX/ypuwL9jdnqQ=; b=FB6ysEbAY6+Ulq8h9h/NX
	mfc930u4j+URY7o5hlZeNeJ32YSO2RmsHEb7cns3vHExZhjRTxtZ4+2+DHDurilT
	nye+Y0u+cebZtUaelNqxw9C/6QJtZLpAYg0V1nSje7x8aUEPP1fL1MKgaZRB7GxY
	1pLdCaFDAyQt251Fa/zZ0fsClCT0KW5f7O6SwoHJPgvhqZygRaGJyNJO6ybZp3aW
	NTj/ANGGa+Zlkykb/nCgOOKJ+SCoCaC7B64PdOoPDvve7cRKg+JNc0n/Go6TvmjB
	jxRC9yctJhYpDhQ/WHBhQBkAGFZ7U+oxPztbpFjeQmo4/gKcPcHpku3+uxjMw77B
	w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012055.outbound.protection.outlook.com [40.107.200.55])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3q05a8j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:59:42 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0+NTU7hpIQrrIMEx9LHJMH7pvp6kA5ovfPJtD5iFeZYW9prtpmEfW4TejcNtlPJjp0lULKLu3FaL3SkVZnWBJMDZ8+RpJUenhyD51pISvN+8eIGGK/l0p/SniR+LelaHVjJjRBvdZH7km0d/jZOdyF1av+2xrm5Jp7e/PTdUT1AyNUrt6YNBsMAzd/ppes1cOrd2S4xndOBpf/2NkLYWaqGhjeBDv+vrDlPMiQ6VeQJ2BaNJZfZRE4fSbpuoe2Wa0BoILcRsGRDq8RGohzgDQXM/Q4wiESegd00lSxBUJNnDIj6FvsbhxuehCFOANN6DdGu4mfIH/xI/nKkL0BhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG/qirus5IXpKPqDaFk/TvgIHbw4SlX/ypuwL9jdnqQ=;
 b=DXKMpzVIWdamVHzfq8vwrpjvUkiOzbYfLlrGZAL68ToOKWKrjGqTy8kIoX9A2sHBARM9DgWMYlvf6PpCRqo8GFHFeNaYedzWgxNlqPypyDeM2cMynJnohu1n1VpkGWmIMKNLvPNx8ayt3m7hLE8cQdf1Q8uyiJ3K4rjRr6Qf3Z7lclRoMIw+esfCMgwOTxRiF3GRvXrgwxN0wtV4Yei4toGmHVzunCf3RE8Zw407h8mii0v/0CfbtH8XJZqLBaWixJVbCOQV/MqotU7Cjxb8PovOHIdfUAx1tj2dLx+jRFNGblBBRiniWQvONV80ILSHxBzVc5J/gYGCJhtsFWkrnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6048.namprd03.prod.outlook.com (2603:10b6:5:393::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 16:58:39 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 16:58:39 +0000
Date: Fri, 6 Nov 2026 17:00:05 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>, Chen Ni <nichen@iscas.ac.cn>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lennart Franzen <lennart@lfdomain.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: ethernet: adi: adin1110: mask the RX IRQ of
 the port being stopped
Message-ID: <au4HUh8r06PzhnZO@nsa>
References: <20261106-adin1110-net-stop-v3-1-yuehongwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261106-adin1110-net-stop-v3-1-yuehongwu@cmss.chinamobile.com>
X-ClientProxiedBy: MA4P292CA0001.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::20) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: f18b58b1-d4eb-4652-f412-08df3c2734b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|261026121527099003|56012099006|11063799006|261021121427099003|261009223027099003|261021123027099003|261102123227099003|261026140227099003|261028144727099003|261022105027099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	OzUVHRF4iGG6UIA/i+nCtSebQY3BzpEEfrXNMvr9EJRly0pPWLn1QDMCan4FUSDi0LsyuK8umJ3yv1zkHfMwaJSq1w5ohWmyRV6Ev7SyyLIHJ5rg6O5SO7zfW6Uxwk3whIfNU0xBmVa/PlWgsbqbE7Lql61brtSl4knrH9nxOrBD4J0pwoG5C2tFslCgWjrvawd8zGxDqMqD1LH2yjvGnhQzfTXN/xv1qeQNlhKssoWhcgAGufvKq6CROtlqkiK44spf6/njfLag2evxgLzDPASrC0LR1AY4wJzQ7u2wDkL7PCRKKKf4P44f1QEYMb/C3YDzyJMuOgipcCdRD5rCtPM0padbQy/Smnzkn2YmT+TowcZNJl8BS9W5EaZBKlr8EaXOKnN7sC4M79AGhgOX0EFu59xIimS23l7aQ+UD+iADK1i3zDGHvmknrC3ShX7Knc7Ojw+xruEROHNIrlSAQSDnFMLkBzzTRQhVQsk+dY1Rlrpzen02wvo7Cvnfz35+D/aP2RdWbfW06aDU8uvpCHRwMREMgMoutMeJrKYiUmzAR0cBzwZ3yqrg1NlXRdi+k/+AlXP9toJBhJnuo7oqc4vmDJpEpW64r/tD5C6pk11KhmMiNKXEByhhpK0W3Um4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(261026121527099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261022105027099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elk5eVJpeDdhSlVnRFF6bDF0L2E2cjd2eTVvTHFqQ2Fjc1R5ODg0MXc3WU0w?=
 =?utf-8?B?cDZ3L2Z6aUdJMWxhTXBEenBQWStRZVNtd1dNeGI3RXlmTVBOM2ZsOHpWak9E?=
 =?utf-8?B?SnkzOHVjRUthYWlwazlPcngrOW9XUHZ2WXc1Q3JlMW1FTE0yaEluU01ZTEc0?=
 =?utf-8?B?bDBMR1kvdUhnbk1SSzdnTWlSSWYrRU5hQ0tmNjZsUWx0czBzT1JjTkM5THNq?=
 =?utf-8?B?NDB0Y1RvM0FUTWRLVXdQTHB6RkhuV3c3STlZZEo5M3Jqc3Q2QjJnRHB0RGY3?=
 =?utf-8?B?VzUzZEhPQy9sc0kwMmkrb0pEQnFTTkRKOG5YODAxYlBobXY1dHpwc3RSZ2V5?=
 =?utf-8?B?SzdNcWZnWGdHNkllc0RHQUwvZkxCSXVlTmxMOWJUMFhmL29ZKzVDbnZ6Q21B?=
 =?utf-8?B?UXlaWWozYjU0d3ZyWi9sa0lmQjlMYmprNVJwcWd4MXBDWXJyVTEvZUNXQVlZ?=
 =?utf-8?B?a2xRaGlvbmZMZmtSdVdhNnA2eGtEMzVhdDRjMFZrZHdXaHQ5S3M3bmtET0Fl?=
 =?utf-8?B?K2gzUEJQeW15OVFZem93WlNCVDJ6OE0yQ2RIWjQxdW9BOTBCc2VnQVFyUXdx?=
 =?utf-8?B?c0gvNGdBQ3dZeU1IN2JvOWx2WVNaMVZqdytOdTZ0QTB6ci90K0tuMnZxcFlh?=
 =?utf-8?B?dVNDN1JTL3dyeTZuUFE3WTMybndocnFvOWVWSUNlc2tEcnZEZXVQYUxsZ05r?=
 =?utf-8?B?Wk5CU2NvVklDQkhhc1BpNVNDb2RabjBKcFJJWDNlZFJzeWl4KzZmV0NXY3Ex?=
 =?utf-8?B?azNvSkpzYng3Q0VMM2ZUL1NYVUY1OE5wM0tuRE1JK1ZyM1hRR0ZFSVpiYjBV?=
 =?utf-8?B?T0hZdFkzTkhsWmJNd3pHUHM4alViNmlQSTZHK09uOU1FdjYrb2tHVG1EQ3F5?=
 =?utf-8?B?L2RTU3pqZEhoQnZNM2tVbUZtZ1RNT3BLbmNrS0V6OE42bVR4WHh1NUV5YURm?=
 =?utf-8?B?Ky9nb2tTa2d4ZE8wRlZyeDI3UEE3SWxRanNtaHhneUJIazJXVkZXekM4cDQw?=
 =?utf-8?B?V0xLVkpQTkU5eXJuTEV6NE85WVNOYTRIZDc0SmhpelgxZUpQcVJ6M1p2dWw2?=
 =?utf-8?B?eHZhZzJyVUR1dXRkVjJvMzAvUi9pV2doUFE3YnJwOUxnM0dlWG1jdjlhYXQy?=
 =?utf-8?B?NmxYdWROT2pGTGxjL0VzSE5sU3lNbkMzS0pPeEd4bmdQY2JQSFhtVWFDUlNR?=
 =?utf-8?B?dTkxUTFOR3hKZ1dNbzJRQ2orWkxwaThGVytpTWJVZWxLNEFEZEF2ODBPSGtB?=
 =?utf-8?B?cnZpNERNMlJUME1sRE5zeVNBdGdKUFRMckZLa1ZjZU5aYlhSTlFQU3oxS2xS?=
 =?utf-8?B?UEo2NVVTblYwSk4rbHVuZDU0c3lwYUs2WlpqSXdoR3IxR2ZnU2JDRE1WVXZl?=
 =?utf-8?B?L3NIQnA4V2MrcThGSVp4ay8zYkM1dWhLR0pGSnZBa0RLU3BWakFQWkhZY0ZK?=
 =?utf-8?B?TEV1Q0FFdFZicTljVkd0OFk1bmJiaVJzbndCOEZMT1VHVzVIUFBySkUrUlZ2?=
 =?utf-8?B?Y3hXTVJ0MEdyNysyc0ZJc3JhNktHSytEQ0xnSnVRK2FqVkNWRTYxTEVpKzQr?=
 =?utf-8?B?am4zUEhBQXBYQTJucDBlbWlCRnVOSUROS3hYYmlhWmhvSm1aOVRyNEJUdXFH?=
 =?utf-8?B?K05yYjhONTNhUFFBdmpOR2tvU0tKcDYzcTgwdUh5NmROU3JmUUQyUCtnSEI5?=
 =?utf-8?B?bklxYmpEMUczYlBhKzA0cllSQkt1T3JRdmtDQnpkQ2dCMjJncm1jQm5KTDRo?=
 =?utf-8?B?UmFvRFNPdVkyQ1ljclJuSlQ2TVpYdXZhOWhPeXVGcEJmREZEbGppdUJiZ1FF?=
 =?utf-8?B?M0IvVlFDaloxYXZVUWQzU1lYVThZSGdQT0tZRmptT2NwMHczaHdFYkxBL21U?=
 =?utf-8?B?Q3lRK1pBSmNMVEpPN0Y3MVFTRjkxVUhtQXpEc3ZCV2ljQ2NsYnVOU3VXaWZB?=
 =?utf-8?B?K1FNYjNYeVdSbER0cVJKdnBWZnNrdEdWUktDMStSc0hQSkhJUU5BSHpaLzNE?=
 =?utf-8?B?QU9aMml1em56YnhYd2huSnhNM2RlME1pdHJzSlZKZ0Qzekx1c291Y1Fnd1h3?=
 =?utf-8?B?OVBOcUt6N3V5ckFZQ2VIYnRhT3JNQ3Y3cHR0dmJLSjdEMTE3S2xJeW8xQ1hk?=
 =?utf-8?B?ZGRMaHZpWm9iSGQ3UXUzeHc2MDZuT0JOL3FERUJYZ2ZIUFFUZ3FodlJvSThu?=
 =?utf-8?B?ditGZ212MDhibmFPR0pBVEZUMHFlWFUweUxQSWR3Q0hYVVFXeVhaMU1iZDVi?=
 =?utf-8?B?ZVhFNkI4ZkFkTFZVazA1VmRQVk5TWlN6bEdvRFlFMFBiTUhHOVNIak9OQVF2?=
 =?utf-8?B?RVg1VlRVSWZLdmhpbzF4UDhUR1hyQXl5Vjk2WkYveTNkT3djOHpEdz09?=
X-Exchange-RoutingPolicyChecked:
	MchnJdHDCvhEgq4WrhOJjRKXF8hKG8B8/6QfJNxLDtuuV2WJ4Qe6vv+78YeUHmIKes+8G7+7mEr05XWAt6nNQLX1x4ilCfsjek6qBfXWuoWrnmEQWR1E+APL4/7SRUUsD4mNfRcvUv5R6Q6lYEZ08hbPExkKfN98siK45xy/4JYj37GqHws1SZKc2tchyYtPw3KvlWcsPCjHz4iM94lpsFPS4KVwpY85nnuXHl4Y1xWfwWfGAUD8JUTJxQj9EuhNsVTfaSibDqP2VyT3cHoLSBWbxnW+6gXvdygGkSIUCu/UVUkcq58XrU7DzLfeYpCMWlNMQVJxTdf9JP/3eSU+yw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18b58b1-d4eb-4652-f412-08df3c2734b7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:58:39.7618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4Ho36nsyqhOr6YSUzzaOr1Y4ZNfYA6w5BLm6TrJAPbHg0P+Vy/COf9IyySgMNPL4oe0u/+HzRoJKZayPUixTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6048
X-Proofpoint-ORIG-GUID: Dk9bsymFRalA_q9EVStS87dacbTRDt0N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NyBTYWx0ZWRfXxBF02ap0ltLc
 DeyPrkXRfx/hgm1D8V0kJHv7Ogw6O4KoNgMe8Pwxs5b+hIxy139Et63qr+cqJqrOPU5U6mcIMMn
 O6qpyBZclVtjOrBm0Gn8UVLhhHkvQykg7+WO9FXSoa6UTWnnO67c
X-Authority-Analysis: v=2.4 cv=Lt8HWXdc c=1 sm=1 tr=0 ts=6aee077e cx=c_pps
 a=JQIjQaBRt2POjw1IEeT7Rg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=VwQbUJbxAAAA:8 a=R5C9hjxsAAAA:8 a=gAnH3GRIAAAA:8 a=E1QDd6-czLpIgmbbpnQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Dk9bsymFRalA_q9EVStS87dacbTRDt0N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NyBTYWx0ZWRfX7dM98Ym3JYpZ
 WakpakYK1OhPS+kmpUAFmXbSq6hef7FwXNL57T5JZ8mUehaJo3UxJMwHpLdjbJ9ucrHcsSspJhy
 2UrU3HC+xy1hzlrWwFMnRTnf5ELFvv6Vw3yHrHAIpA5XbmLbHO/2jzfVLfwVJuQcQAORVbs354N
 pZm5+Wk9aMFG2PgfHQKprW8nuUVwkoPzEu9Ib35JgGUiwBDjCjFxZUj2qM0sKdYHE0tb5K5vmS3
 CM7fQwFiJDvh8Bkqg1aPcZJcdnghCQK+qa7ZTBoKEV05sJNELmiQXO3vuJ3qbo+i2JVHWrMUqKC
 atqRYVzFYCA7aga/+OanWFoV8fIgLIu7udiOUc3uE94jiZmots8ce4gdcTR7SIYAtX70eP+ufof
 vndau6nSqm3ivUGnyMtYdXAT1oQNxK2HH5Pka+RqCUzzzulOlqZ8Jw4sP4dUGJSTuje0bvtcWOL
 SVXSGH5lBDR3iB/o5/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060067

On Fri, Nov 06, 2026 at 10:02:51AM +0800, Yuehong Wu wrote:
> adin1110_net_stop() programs the RX-ready interrupt mask of the wrong
> port: it uses ADIN2111_RX_RDY_IRQ (the second port's bit) when stopping
> port 0 and ADIN1110_RX_RDY_IRQ (the first port's bit) when stopping
> port 1, while adin1110_port_rx_ready() uses the opposite mapping, port 0
> -> ADIN1110_RX_RDY and port 1 -> ADIN2111_P2_RX_RDY.
> 
> The port being stopped therefore keeps its own RX interrupt enabled
> while the peer's is masked.  On ADIN2111 that stalls RX on the peer port;
> on ADIN1110 the RX interrupt is never masked at all.  As the interrupt is
> level triggered and adin1110_read_frames() skips the FIFO while
> netif_oper_up() is false, the stopped port also keeps re-raising its
> interrupt with nobody draining the FIFO.
> 
> Swap the two bits so the port being stopped masks its own interrupt.
> 
> Found by code review while comparing the bit mapping against
> adin1110_port_rx_ready().  I do not have access to ADIN1110 or ADIN2111
> hardware, so this was only compile-tested (CONFIG_ADIN1110=m, x86_64),
> not exercised on a device.
> 
> Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
> Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
> ---

LGTM. But looking at the commit message, I suspect you're also missing
an Assisted-by tag :). Anyways:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> v2 -> v3: no code change.  Cc the ADI commit-signers that
> get_maintainer.pl reports once a git history is available (Nuno Sa,
> Heiner Kallweit, Chen Ni).  Thanks to Andrew Lunn for pointing out that
> Nuno was missing.
> 
> v2:
> - Cc the netdev maintainers, as flagged by the cc_maintainers CI check on v1.
> - Explain how the issue was found and that the change was only compile-tested,
>   no hardware access (netdev guideline for patches found by code review).
> v1: https://lore.kernel.org/all/20261103-adin1110-net-stop-1-yuehongwu@cmss.chinamobile.com/
> 
>  drivers/net/ethernet/adi/adin1110.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
> index 53fac3d..abdc160 100644
> --- a/drivers/net/ethernet/adi/adin1110.c
> +++ b/drivers/net/ethernet/adi/adin1110.c
> @@ -945,7 +945,7 @@ static int adin1110_net_stop(struct net_device *net_dev)
>  	u32 mask;
>  	int ret;
>  
> -	mask = !port_priv->nr ? ADIN2111_RX_RDY_IRQ : ADIN1110_RX_RDY_IRQ;
> +	mask = !port_priv->nr ? ADIN1110_RX_RDY_IRQ : ADIN2111_RX_RDY_IRQ;
>  
>  	/* Disable RX RDY IRQs */
>  	mutex_lock(&priv->lock);
> -- 
> 2.43.0
> 
> 
> 
