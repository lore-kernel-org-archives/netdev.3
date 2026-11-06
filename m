Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793978184;
	b=5k6frgC2N0CN24KpLKJgSJxbX9Fs0fsc5liDoEuhImwlXBc7yEKAysnjrydj0CjskyFl
	 LWmgyox3q3FBnPTTqdg/nDKGcrhY9bW2ceR45Nd6cknapsQkoTrYw3xS1yuMpgIZ1I5Oy
	 CQ6ztrK0JsP5g5KBis0UbtmHMZ3BGbJxOPLgYWRjNi8JT5D9yMGjWh+1D8V7i3V9/MoL6
	 p/+jzoSJ3/VIPxxixmvQJqoQA2IuuytnMfRDMphsB64QkXfN2mchZsEe9Yi026xNj1FLR
	 kY8Q0nkuJzr4HwZHNgfLGnXJ0+wXM2+RMEmEmAvQuo9XepC73ClSRxLmVfxGpIrKNNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978184;
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
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iB7Pn7ZjNaCPYHl73b08lUbHbJla8BtxupCQjlCKCrM=;
	b=tX+x6hzRSxauIHJRHNr209rKmtlivlH4VZIbPQa+rWMn26Zu8kP5Ly/C5W8i3dzH+Wzk
	 ESHdEGE1L5lBbk1x7t5/jlEZActdbtBTLUw/DOQWC7SQpFk4ZqZe/pZgeY6WfIZlRAegD
	 TROzEqfqZTk0o1SyWZAcAgry+ckQqvbYwC683rQmm/0DDhJAqAHT8AxilKHZCdyitu4M0
	 5cn4wSVUxvemvwCIxz3CYltK8Xp56Y8XRs11vFnxsEZc6xoFfF10AtLRf66AfnDWhkupV
	 rWHLajlW55l6RX0bd3T7aMz+LclLvh+6+o4WkpbqPokGec9Ho3ScknlWsakS/Y4Ct8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=temperror header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=e0OkT47L;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=AxsdsEwe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F800606A338;
	Fri,  6 Nov 2026 15:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F800606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=e0OkT47L;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=AxsdsEwe
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F2UpM2482312;
	Fri, 6 Nov 2026 10:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=iB7Pn7ZjNaCPYHl73b08lUbHbJla8
	BtxupCQjlCKCrM=; b=e0OkT47Lz4Ey08tF5UTpp5NyxWVVRmNQia0Vbtum4HWgD
	0vgjARJVw/9gIPlIEX/SYz0asgC28agtpa2F6yQEpK7UhGsZzfs7LZg7aBseWLmM
	KJj2d5aWWoZ0LN4t06GfCnr1t564igDBNfIWwsaK288CR+Psm238qYovAVN54vsY
	3eKcRtRN8mjzPV+X6TnlGkgAkUnVIwEdgdyMMPaq3GgNxgsXC90IBuOXpwThY3AU
	iHqkSx7HMiMTSmVmmuEfRX0HFsY+YakgDZWIvP3CDz7ER+zGXKC9+0Vl5KB01KgA
	BkHy+VM/P3WyQ6FdM1fZa/JlRiUB6pD2ASAMe4HyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=iB7Pn7ZjNaCPYHl73b08lUbHbJla8
	BtxupCQjlCKCrM=; b=AxsdsEwemWgSp1tDvozj+HcwZfsD3FqNS+KncrqP+ewVx
	O0DX/t62J0Q02ynKYO53AE2BNMNtDLKdxch4MiNPxRZkMSiDHyLAs3KZNDExgegt
	0Lwkmk3rUYhf12xVO6NmocVUhPdcUwhP5XAm9hMkZCC0SszMO+ZM0cLR3Gkh8fIR
	x7Rcrkk3JbN/Fdkms5ru++ESfumtPT7vm1ZDwS9ncG0n57aofATtfFvy6hog0mKf
	Hcow5AuLr7QVO+FLBP5AaMpnalFDR24MdZewGbQPzU3b3/i8Yfve+ggVTF1aLKl7
	0nT/tutFchrRb6hFtNFwHxIo8zEeH1U5kmKZT0Hvw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3pxvdgj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 10:16:00 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVJUVC3gC7gKFYyREbbXAfGkLrGzp7Hn5aC3BjnWDnZYHQrK+4u+WPpJr9H2D+STSuizRJ+HeBXA/aCGGFFEnQeXbXcb0Cq5DBxAEdYofip7ublSjz1lMXBdQBIqv7BiBalKC4+O2PG/i/ttoDR9H7iVnIFAAS3NTT4Xn/wab4Z/01pSY0yY42UF2UN1qnfqOTzAGAZT+rb7GSTLmkB0J43XsNY1vCzwK0mN73ElZ5Vu+GeWVbGjwjtrbGW7P22d2yLtFnymBMgAWGcVfEaLR4Q8G/7ckjdtZrKUjF/7U02SBmtKUQpltK7TcsSrI9QuVMHXbvpAEHL5nQDRrVDXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB7Pn7ZjNaCPYHl73b08lUbHbJla8BtxupCQjlCKCrM=;
 b=coj0P0vcJnlvEIaK0/bULsaUsV/cF8gctvP+9Gi7lhLVnNxW5STvIPr0Ye9r7AK3GCNvwgS0GFmVuamPVbprnH2EFt580c2GIgV4vVK/YGa+fNK021rhBzdd5NvY2YBNAR2s0yNZBIaKSBnrCn5a7VE69r1khMgDj2AVX2//vr3SEFWNKAQaGcJhVBLYv0oLjpejnVSNZLGHIM73xzKrwnBjvQkGl5Ln2w5j/r2piwwMG7qLqh4p8KTmjB/OVZb3YMbTOw2XH9fd6kZhn5jw5tlDEpC5WqraXtQHXNy2gLHphI+qTzwJ0S+ZBW5b/en7eDFL3DCYOKhUuE/sKPf8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by IA5PR03MB989604.namprd03.prod.outlook.com (2603:10b6:208:60a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 15:15:58 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 15:15:58 +0000
Date: Fri, 6 Nov 2026 16:15:55 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 04/10] net: dsa: realtek: rtl8365mb: set
 RGMII mode for family D
Message-ID: <au3t3XC2b0ZGLN4A@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <2befac48-25eb-4c1b-9632-2f3237d68a3d@yahoo.com>
 <auskP2mSY4sCRa6x@analog.com>
 <82c96971-be5b-4c11-b20f-c4b074181515@yahoo.com>
 <aux1v3R-efbWF2GD@analog.com>
 <e66204e5-ac33-4a35-8d36-6f37372da97f@yahoo.com>
 <au3WTtBo3qk4nQvf@analog.com>
 <014d5582-8ce2-46dc-911b-397862492421@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <014d5582-8ce2-46dc-911b-397862492421@yahoo.com>
X-ClientProxiedBy: CPAP307CA0004.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::17) To BN9PR03MB5977.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|IA5PR03MB989604:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f83739-b93b-4aa8-b055-08df3c18dc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|22082099003|18002099003|10067099003|4143699003|11063799006|261026140227099003|261028144727099003|261026121527099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	a415HcCeQ2Iqv1gQa8ZI1O6pnTt4mgzKMBMHVfuKOd5v3/apdnfFJZmNHHugw9NmctjGc2xBU2ucOf0XzX6CfTXbJdDA+ZgSsV+jZ1WcTvqazuzPApPLyaVgETzUzxKWtmTDauaCnobU7e5afoINIzgvSCdn1yxXVcBeMxmbUiE/dpBMMZ7QGT5NgSyiK3H9C+tUmFQGRXOlmErEQJ/E1PD5o7rIioId6DMJQqKxJnYXhDf0Z5Melufh+Ll7aC7QAwnFrJcpGF3T5BmiWj10AowRSoQrD/kVJg9U2RbQBwTE5vq/MXhfN1bL6DI/tie4gAjlP2qSqbt+QDuGc/m9KQsTsWvNQS5EXfGAaFmaWGnfQ2whPqJNanrmcrvfcMg1OGr2XagTrWfy314StP14QoPgNVjuI6tlJXcLzrzUUOdcO4AmGsoqN8pCqUtXXopmbWCvJuG+ZX5j1OnNRdsjhtsXzPLEL3EW385y8OzQRsvvnXVsDAZJ1eHdAG/NsMFG0SKMM5hT0j3Jj3mxGJiD+xZG0B+beRZm6QrjQ3CxmBwfEIbfS/zlj3jj+7KtYcLmiTlnLZfrOTG/31KCKiQIMQ7tou296zLwL5gKsvNzN6hHyMaG7ZCSzWHrhHP3MEWbWsgRx7PbUPQrA4wilgcXTTlZg5Uj4VvXiO+KO7Y3wOE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEdUNEpxN0ZzRDcrdW9sNlV1MTZ5cGZNQ3NoZUFmZkszRWxrWG45RThQcWt2?=
 =?utf-8?B?ZWJ0VWVhaHhmeHp2Qzg5N3VNYmQvVy9rWUVsTkxOeUpBUWFsNTJTZVQzZnJm?=
 =?utf-8?B?aHJSKzZHUFdLZUNMVjVoTWxybEZLN0JqZ3Q2bmlPMXdoc05FMVZGOHFMSlpM?=
 =?utf-8?B?RzNNcVdjZEZvOU9jU2xjbnkwQ3h5Wkl6ZFZHU1R1QlpPV0duQkRFbEpzQzht?=
 =?utf-8?B?bU8wQkpxb0x2MFZFaVhmSis0U0xWYmp1QmpQU1U2cFJMWEVJT3k3RFg4VEo0?=
 =?utf-8?B?YzRWTW94Ykp1MnhVTllEVTFFdkc2SFRNUWUzZldIcENGRVZ4ZG1OcUVzMDFS?=
 =?utf-8?B?NFMwMFdIUm95NmVUYVVwbW4yMkJQR3NNbnVPc3dmVENvZENNN2RYUkVabmxh?=
 =?utf-8?B?V2RqTE5Vc3pwZEJhRGJHclFMcWxGWVFiNmFscVJqOGljZGNUZEExTklOdFFW?=
 =?utf-8?B?b1VBaWVqZXlIeXdFdjZTMExMeHhBS3doMlRPMmgzWXJVQUdSRlFxSDRweEIw?=
 =?utf-8?B?UjJGaWQzd0lVVWlUT3ByOTNPZUdXci8zb2xXVnFkU3I3YlhQUVdwWHpIK3oy?=
 =?utf-8?B?ejE3N0xob2FwRVpzaE5mSGk2TWRlS1dJLzVPNU9Bck1jeDgrc0xiek04azRF?=
 =?utf-8?B?b0VnejhHMlZndnRVWDdiODhJTWIrWnc0LytyNmtndWliM0NnN0txenBrNGVq?=
 =?utf-8?B?L2tzTEMrNWVxUkoxTG4wc1ExVytVeWRrL2FjcjJNRlhoUHFlVHpHRkhrWHRP?=
 =?utf-8?B?ejNFMEliMUNZSksvTGlZYS9oemtaQUdWYkNpcmtPbW1iL1lYNTZaTm1JMll1?=
 =?utf-8?B?NjRadngveTB3QkRkVm5yVHFEK3d0a1Y3N3U1bFgxbGV5TytucWhoYks5dWh2?=
 =?utf-8?B?V2RsbjlGUWE2YzlCVHBrVzFTUmFldG5lMzgrK0hmVHU4TXdNOTJRZjN0MXdy?=
 =?utf-8?B?ZGJRTHFCSXd4QU4vMVJHTjBSMmN6N0ttNnNacHlUdVVPVTRHNWNCZVhLa3dx?=
 =?utf-8?B?Mklvdjk1aHhwZm1MMGlXY1k2SmVGam83OTY5YmJUMS83R3dvcnBpRnNVQUdl?=
 =?utf-8?B?bzZGekZaaU40TU9Fa1U3MHJta2huMTV3emRDcUNMVXBSQXRzN2VwNTZBZkll?=
 =?utf-8?B?QUl4c0w3RnNHbHNEemFoa0VYNXFHajE3VmM5aEErUEZPS0FWekJWUzJuMWUy?=
 =?utf-8?B?NVplai8zTGhDSC9RL3dJREZsbjd4NnBQcU5FTExCcm8yRk1PRnBmVkV2R3c0?=
 =?utf-8?B?SG96dzB4MndORmx5SWNCYWVlN3ZtdGhGK1ZxTzQ1UGRyK1JEWFFVemFucGVD?=
 =?utf-8?B?TE15VHpjN2VINzMvd3lhUTlPZTJEVlU5b0puNUFuYWpzQnRPZnV6QzZOU2JR?=
 =?utf-8?B?RGV3Z2dldlZ4Rm9TOWJrdk1JV09PQm9LZnAxWlRRTUgwNzlEeGpwSjBPam1G?=
 =?utf-8?B?Y291NE1RRTJaWTBUWmxKelhMWUpqZFR2ZHV2bi9pTzZZOTJkdndWancvTVBL?=
 =?utf-8?B?WnAxM0Z5OCtPV3RzY3JJcnFJWlgzSFovMnZ2R3Z3RWdwSmNxMWlsMjhHSGFD?=
 =?utf-8?B?STczMDhaVnFwSGo3NUJtaHBGWjA2RzFscGFaakxRdE9oTHBURE1yeVgrK1B2?=
 =?utf-8?B?d3hTL296YldVUVUzL09FQVN0YjdHeTFXbDE3ekwrRG5YVW56cTFMZjA1KzV3?=
 =?utf-8?B?RllvcnlQbUVNV0MrWEM2WVlzOVAvSHJ2ZDdheWFJaUNDVk14TTZXY2hhZis5?=
 =?utf-8?B?UUFLWVNpdjVwaWNHeUZPYnhubTVpRUhRK2gyZ0ZMYk5BU2U3MHZTeXhtdG5K?=
 =?utf-8?B?dDlFTFJXOHNyWUlQRFluWWJ6bUxvaXltL1RJMHhjc2hkUFdWYkpyQTd1OGpM?=
 =?utf-8?B?NEphNk51L01BRDRjMTNLK20yZmxRRHJvNk42czU1cWs1cGlnY3FEaytENEYx?=
 =?utf-8?B?end0TmhOWklTb1UyVGJaQWRzZTIzTHo4VTFkcHBCaVRxQTg1NGlTY2tmWnNv?=
 =?utf-8?B?NWNTTkVNQzVhYndzcXY5ZWFsVEQ5TGcvMFBObzRqQ1JTZzFvQmxwMnczaWtT?=
 =?utf-8?B?ZnlaeEVhS3FBaXVYRktvcXdQUDhmSXo4TUZWYW9BNDV5WGxwZ1pKZ1RkWm9a?=
 =?utf-8?B?Ykk1ZmxFc1V2ZXJ2SHcyblJ4RkpwcTBHZ0EwU2dDVUJJckxCQUQ1eGJIQm1N?=
 =?utf-8?B?aGRUcFZIb3laNDZFVmFUVVZFdXl5QXhPd3hOZmVvaW1MUkV0WTdocW5lV0Fw?=
 =?utf-8?B?eEZIdVVvQVI2cUNZTVByZ2tYYmw4RkNHeXoyM3JuM2g1NkdVTlZhdXM3ZHhD?=
 =?utf-8?B?OTg1bENBcFhPdFRyei9CQWo0bHhHaU82Q0lqcTNveUEwaUt4MVROZz09?=
X-Exchange-RoutingPolicyChecked:
	Qm3ElJ59yT5o4Vn6pruCTV+llggRnvLzI/U5IFg+ikVswMma8AlYn8R1GB1EJAzJSgGgIroywzNJA8ZXG1I08I94cNRTRZMMSU2DGZ4yk8adnTRO5tY2FaScNc8qxTztXed3jbhrm/EYJmeKZhSKfYu/iAxGjgEUp4Jt64BsrNcavHnu4PzOP90g7j6CEC+AKpl+/zPwsGkwzwvfvFQL4dZSMuKGq+2PoQHlsgFyiD+yfkeSWweetcAE59ZfDvXvq9XGMkfKiVy4j7aSFmNWq+TMHl+JHfACwANl66Bqd3HX5FqdcUmi6EyqDY4xKMcCwGXLEiciFMqzLIs/PjFX5A==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f83739-b93b-4aa8-b055-08df3c18dc23
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:15:58.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfyoZBL/22s26CTVTBVbp57HGEAeTCHWZ5RXZV+FUsKjD1wrjSOdseYFpfeooIBwdtiJCQi0MwKKicZHMzgu/cTPzA7ZqwFA7F7Wk3m2Mps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR03MB989604
X-Authority-Analysis: v=2.4 cv=DOQacCNb c=1 sm=1 tr=0 ts=6aedef30 cx=c_pps
 a=BYzTVJwijQ+wlo0xVi9Hgw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=4qDvdSDEFFGyJudmUBIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RJ_WsS90fYhkvH84dnReR-TKpimjovTO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX4hA+jRZ2XgLD
 KFjOfaCUKApADL6W3wBg2H8ctyKHhMSJ2hsowZm+tjlSQfzbbH/ysYe4oi12sNI1FyqrH8avx77
 2I035OFHmhytuwJvTmd49+eMAVChVF2ObRs4/7RUcJvBOciC6Qqnygg/zWr4aGwqBoYZ3n7+Ize
 LtgZ7nYbxrgX2smqqqBUyAygGqi9rwDHSjFTBnUUj5SZsffr5RyecR6nn09mR7s0XdGOaN2GM++
 p4vKKM7RYq6aNHE9rL8/veuA0CUxx5p4V/2OFsE7o/RSxTkmbrnbNuzEt7oKvvDBRmSxjUC/KoP
 mlmv2EIrs5HFcu28wQPm4pHy/srcaWWobub30gC/jv0925hQD0iYdH32Cnm7lWkoM/+vmGkXjS9
 ASY+7J2x6afR1aDkeUkPmj0aLEmIPD0uvz1iBXdU/mT/WkdUc9ZQIKnFR0ho3K0+SNAUFZv3ure
 /IMjEA6neoIGj00PuGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfXz+WpC6kCPDBz
 Mq5hjmiPMTeKpdGVw/KZF9ZMtnU1DI1eWeOmqoS28HAq2uGpmyKqMj5nWJBVoKSHzLf6er2G03O
 552XlQlRMxBt9mxfA+a1Y48aH4+/AMVdnhCi1/tiJmIIZe2QiWiY
X-Proofpoint-GUID: RJ_WsS90fYhkvH84dnReR-TKpimjovTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

On Fri, Nov 06, 2026 at 03:56:18PM +0100, Mieczyslaw Nalewaj wrote:
> > So maybe just check in the switch registers, when it comes out of reset,
> > whether the default state of MAC4_SEL_EXT1 is 0. If yes then I think we
> > can just ignore this problem altogether, advertise RGMII capability on
> > port 7 (i.e. use EXT1), and be done with it.
> 
> I do not have the hardware, so I cannot read the reset default of
> MAC4_SEL_EXT1 myself. Could someone with a board read bit 12 of
> TOP_CON0 (0x1d70) right after reset and confirm it is 0? If it is,
> the check is unnecessary and I will drop it.

If you don't have the HW, how are you testing these patches...?

I think we will need a Tested-by: tag from someone(s) with both a family
C and D to get this series in, if you are unable to test things
yourself.

Please also do not submit anything if it has not been tested. Maybe it
was, but then please get that person's Tested-by and put them on
CC. Otherwise maintainers might merge this assuming it was tested, if
you got the reviews... It is a basic assumption that non-RFC stuff has
been tested when posted to the list.

Kind regards,
Alvin
