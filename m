Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793720208;
	b=TC3IGyQIpk08Fp+68O7RVxgbtsqkVlumk+lAMBY7fcHmSS9J1oxas04LJb2T801T9ji8
	 xMC8dtYByXOYKePHtNk/wZox2GLyQdgeSWFE481QOPpcXTQI4RjMEuUTZPRIkkZ+vOmE5
	 yRVqFGAv6wH1LSLKD8BzHZsFrwr9zLcHmV1Kp5pDjmYYWttTWtGL3uAwdQ7gS5TRmLUdG
	 WNBtcfaeusqnbvgUlypaFym4P/VbhIqRkfomQWMPycm25jOarRQ7/Rat497mY6akPg1FO
	 //BtmwTaBSfAKvLXSt+LKdvMXIJJXXAh+chxevUw11pw0yAhaqN/FShWiYGwKuladjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720208;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fKDkHvMgD3AbUJsmxnryjrd+k6m0bOUb1vCpdwdXo+8=;
	b=BAvkVfZDOu76K6x7k5CLMCqoX5wWffldmwHYphtiG7C89tZJCTdz1sneCJaa6Iy/8bAv
	 QPI/LrX70lKFb78OqlzNL4SE433E0R949L88AUUBP8Iu23F+6gkmGOPie7dV/u73z1f7b
	 xi1cFY2YOgNb8hyNyV/JL2Pwmwfp7dSiiP9TeXJJtnaX6Mjn/Ky13BFYLfYlnLQMDsr44
	 BR104sXE6WEpijfiHKNAedwiVRTJW0yHBuv1ZeW8DPPnZjierY8FBONDPHKPIxtHrVxse
	 wFpL08Fqs9F/b7+CleXpHuFxwy1QPg0ppagvDx4B6cPiU0NXueF6kPdv1b0Qwh0z04w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="IWCHaY/y";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=uS6TBgMf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C0606A324;
	Tue,  3 Nov 2026 15:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D2C0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=IWCHaY/y;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=uS6TBgMf
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E6ciT2097165;
	Tue, 3 Nov 2026 10:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=fKDkHvMgD3AbUJsmxnryjrd+k6m0b
	OUb1vCpdwdXo+8=; b=IWCHaY/ynZYRaiPPIET/NMbmeZ9PBPcymt9Ir2Bad1SG1
	hNVSVkFaVPUcDsx5pc4ocpzrGTzScFKPcHup1yo6EwcqQtQuMIX5Rh2kj/mJxBpr
	HlPBG/76QIkI32mwJpoVAC2mDlwgELYdjNZTDjTZ4FW+zNxmOf+6JNclFWzNk5sC
	rDb50CUNjac3VgnCrxOnnRqkdAgnBqOih64UBqdnbFKVgKuXVic+Y5XSzXZWGO99
	is79i+WU6tYUGWB7f7aJnortpRL87lmvgwBRmxmiYD3D4H/otrGt9sdaTCgy1vCa
	ahsRpMZLfszcDw7CItmL/WDgpeeQkUHLDgwz4EFyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=fKDkHvMgD3AbUJsmxnryjrd+k6m0b
	OUb1vCpdwdXo+8=; b=uS6TBgMfhYPCDRJpTMuTORiN9WxuiIdViOEfXmtgDG5j5
	gGfKLRRI8AxABW3wG1p1kmkYe4XDji6GTVwK6WzG1hTL7NPA9pGmwf4B//KDChTX
	ME3X74C/hLu6G/I+0Ry2LAxDVIy9j1yHXyZ9akluboEVl5cWp2XmNjqdkImUM6sY
	66T86kDXTi/T4aVA1hd6fVX/Ydse95oJtGlv07LZQuX4vWlpi7AgzX0UDx5cBfb9
	LcEYgWgBq7eHbBJTPb4Jss++Vdok8Z3UuxF63OawDAbyKvlINfSNLQdQ6Jr2ywHS
	MVexJh5ZBxzlQJz2KP4sSHQ76zUme0MLyUKLxIbCg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hq0wyn873-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 10:36:17 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlZNYwQJl1a7s8NzR9yKiPH1c41lTh1NRcY6n9O5pcNrHGcrS9spYeiVAz5A70oKK33flhSX0G1v+xho0N4VJQca8eA6nWw/yrTMeQq9MPOGOMtSqnzfr0FiQDkzqlQmEtBNRmWE87fBdXhPWEDxlxLwLnreNRkEDFg2BOS7fm565PjrKVIJvtz4FboWve1Q3mi2RPA/oQLLecnG0BddyC1K66D/kBohOoXFXWZnnupsIWVnEPdXhsZYctFc2CTKSxicPWyCtRyINBUW32RA+iP/6v9cimUOvNuHoG+x7+Cgn3sUbPyhcQ0RCAssooVLddHTNgtvGDBiPf30gTJPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKDkHvMgD3AbUJsmxnryjrd+k6m0bOUb1vCpdwdXo+8=;
 b=xYwlUz/lG934IBSEu3SrUxB1dX/iLUzqaUvD+aE1VMiqz44U1GIYJ+pqvz9wcm2CAla0zwAFcalZzGwacIxpqfEwXXwqXm/B/GghATRsi7AQUk/6h+4RbN0POtARfEq/nLLyVwP/PY4UmtW0ObiGSu+dORF9pWf61bXK6ZzFJoEMpqqImo7OdOFDdNL5y3rEulslJWjLAj4Pv+oRtYY7Mssk/6hcC32ipnCVBoWe/KOnGdZHCnadCgrw7DJgmDGZvwnv+3yi2iP2GT1PJKUu1nB9LOhsQZF62lpdbKZj1PDkzDQcQCrGE3W2UaOcyCeipZRaqRiqdE8wLw8eXhOjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by BLAPR03MB5394.namprd03.prod.outlook.com (2603:10b6:208:294::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 15:36:15 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:36:15 +0000
Date: Tue, 3 Nov 2026 16:36:12 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 09/10] net: dsa: realtek: rtl8365mb: make
 L2/LUT access work on family D
Message-ID: <aun7hiSq4MF5BXOc@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <88239c31-e161-4623-8dbb-db39f506af6f@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88239c31-e161-4623-8dbb-db39f506af6f@yahoo.com>
X-ClientProxiedBy: CPAP307CA0007.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::12) To BN9PR03MB5977.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|BLAPR03MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7002f9-72dc-4698-0583-08df39c0325e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|261028144727099003|261026121527099003|261026140227099003|261009223027099003|261022105027099003|261102123227099003|261021123027099003|261022075727099003|261021135927099003|261021121427099003|56012099006|11063799006|4143699003|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GYmmhcPwEREwTzFYTEuIRYq9FMr+BgLbl3OaHijXhnzSDAk8R1TFrUuFdC1dOpcWRDq5kw3tFKFNCPpP2/HNtaOvYEPX0Bp3TCxnvbiHekKGXgNpBEyT5RxejA9zlAWXvbXa6w4Mu9Jhxt4v97s0ns+v0Hh4QIaXJC4miciln6LQlKh9r//lCUSZhNlqOupM3+aTpvhwWo64HSWbLLRH0UFDhu9Cs/jZmnvnKSaDtpRYnN2anhAHM9yWJmVeTTQFhNr1K6Txt7I+XE11EVpC5Rv+thKflIHKGC464K2ZyMFgP5yj5+P3naAlt+IK1t+eHkul/EflYLpRJqFCXaRz8GwTW9yfze8AcenoN+Jgt9XZ7jQ8uamZ0/ybN4q01+D5h1JoTdjQnP8gLw2uBTdeC/bOJsyYBMYhjX+EkG2SWmpprnDO/QZXIsXEUGTJXbT7WBCVKmz0EBwLiOiFgfLE82L/XhreOBw069NBhc+MQMyTtDNhKNTumyiDD4wZVuC9QGiigqBhzPxet6wR55pCEd13hZSA/9d3b2IiK4bGbwDAZk99lCMHlwqi3Dh2Z/nKn6/c+pfcjUZfM8qNs9Yf6FffwlmO+Zk27vJGiWqe8JPjuoK5OiovYnzNztOyHdjljMfQ+x0EsSa9U1s00GnH2HA7KtFv7447HP5WghYacEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(261028144727099003)(261026121527099003)(261026140227099003)(261009223027099003)(261022105027099003)(261102123227099003)(261021123027099003)(261022075727099003)(261021135927099003)(261021121427099003)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjQxdXp2SEpDd0tXN0M1TThrQWhIWS9PMWZ1NldLU0F0Uy8zWnJPaXNTOUhJ?=
 =?utf-8?B?OWt5K0JMZlNWR2V4UjgveTZacGw1N09YM3ZmVWtRYnBsUnVFMU15VWQxdkhw?=
 =?utf-8?B?YzRxRlFRUlA5VXVwY2ZWVnk5L0RLRGc1QVBXYmJ4aWVhMzlndXM4RVlHdWYz?=
 =?utf-8?B?TXZMaGdVaGZHNlUxUy80Y09GRVJEOFhuRzhWRXczZ2ZxRkNzU1hhSlIxVFF6?=
 =?utf-8?B?b0hMRk9PWjBzZTQvRkUrRVgybVBObU5aZXZncmFnaUxFVkVidzZKcHFEZ3Yx?=
 =?utf-8?B?by95R2pmcXVuMWx4NERnNnE0RHFqYURHV1poZHdWallFZkZ0c0tUaDk3amkw?=
 =?utf-8?B?NlA2c1QvdWhibUdXS0p2c3J6YU0yd1B3bkdEM01CMmRxODBnd0o0UTc2RjNx?=
 =?utf-8?B?V0I1alFoNDJQMzRneis3azNBUElET0xJRFJNTEo1SWRFV2Vxd3FTTEtJMmRu?=
 =?utf-8?B?N2pFSmxBajhxa1J5TVJKY0lSbEFEYVFWUmZNQzlUckxSMEgvdDN6V0tYSjBQ?=
 =?utf-8?B?bXpyMmc2UlFydThSWDVJTlB0ZFdzTlM4djhkN21BbW9DeWtDdE54a3Y5eWtG?=
 =?utf-8?B?cWRxOFlEZk0zVWZ3MWU3VmlEaitaTTZaZnhCMVB6cGU5RFZuYkFKbWg5QXYx?=
 =?utf-8?B?ZG5lZUxPQW5WT2tlRWM3dXRKN0pqUU9sbEg5dlFseXRiZEtnMm9YcHp3Umsr?=
 =?utf-8?B?QmcwOFVuNU50Qy9HZVIrSDNiVzZ4QS9jVVJ0RTFGVHhuUUQ0VWo5Y1FOVFE4?=
 =?utf-8?B?NEZvRmlhUjlMMENkZlQxMm1qZkNPZmhnOVlvVUdyTVo2ejJJbUFEV0Y1ZHZL?=
 =?utf-8?B?ZDBPRXgwMjRhU2llejlpNnliUm5Zc0orUDdBMkVzNndhOGpubmRTK2kzcHZa?=
 =?utf-8?B?N1BudDNONVh3Z2J3ZlZjcDhCVW83bWhsUnZUeHVaN3p3Q0FDekcvNVhSa3ZP?=
 =?utf-8?B?eVI4UVpOVVc2N01DaWFTWWhLM09wdlkvL3hUVHRQTGJ2ZFRHSUdFYThoR3Y2?=
 =?utf-8?B?UFBaYkgyMmg4MjVXalZmZWM3YWk3MVFhc0ZYdFhTZ28zWXNPaVFOYkFyVnFG?=
 =?utf-8?B?a01FUWIwcHFqVDJ4MHo0eTk5ZlRrTmgzNUpYWXpJOVJzMmFGdGpXU1BzQ1k3?=
 =?utf-8?B?Zy9JU1FtQnArZE42MCtydFJyOHZPWFBraHhEaDc0MGVKSXd2aHdIRDMvZ2t0?=
 =?utf-8?B?WmpNL3kxLzBNZ3dwd0JHT3pxSEd0V1dSQ3U3eGdtY01XMExtNzJaQnIybitl?=
 =?utf-8?B?S0VCQlp2Z285SmxFZnQvZUdnbmFKWFdtYzJabEl0UTVMK2NHRnVvTk44TmlP?=
 =?utf-8?B?czFJT1FtSEF3YkVNVnJDbGFSZDlqY3BteTQ3VmVRZ0szcFZDV0Eyak5OUTJk?=
 =?utf-8?B?Qi9xc25IRktUUGNOanBKMEN3SUxiSXBsN3JNaExLTVArYnU5MUdSQ0tRQ3VN?=
 =?utf-8?B?eXZ6U2JaWU1vWGRSNlp3QmJpSElkSUhnZllWYURla0JEamZFU0RDOVlzTXVp?=
 =?utf-8?B?NldGcmUramFUOHQ0aE9JZ0ZpSTNxZXMxUGVoS3V5bGxLWUNlcUFWaEdieW1q?=
 =?utf-8?B?YXZRN3ZEMEtrcXNDT0Yxc2xwVlJwc2VxcWxPM2MyUnM4SlkrMkVsaXlCNWpD?=
 =?utf-8?B?U2ttbE9pS21neUtqWHMyOGFWUUNtT2tkRU50MzMwR3B4QjJTYnhUdUxlM1VD?=
 =?utf-8?B?RnA3UG1GZExKK3BPMkNYaFFHc3BZVXBzQkhYa24vSmxPeENBK25zUW1zemZC?=
 =?utf-8?B?THZKaGhFMWRVWGRQdkxXQzg4bnpLbEZTL2s1d1ZSR1A5bzE1ZksreDhnS3B1?=
 =?utf-8?B?OERJRzZrMHV3MEVwaUh4dUVQRmlHZVBMeHhycTdod01vY0tDaW9qUXI5Nmhm?=
 =?utf-8?B?MnlVL3lPaWlNaGN3WkI2dFlEOWFEbStMMU5hdk1YcXppVW0wWWl0dkxVRUtj?=
 =?utf-8?B?V296Y2U0RldYbm1LcFlxODNzRjVpbjJONkRaVjBjVm5qTTVRbE1KMlVlMU5L?=
 =?utf-8?B?UU9mUHlzaStBSk1CbXplUVJucDV5RFVEL0FrWkxmRCtWek1HRCtGUjh1RUgw?=
 =?utf-8?B?TU14OUx4OTVSazdCNUZvMXFHUzI5Y1U4MEN2bkxIWTJzVUQzTlhRRTBoSXV4?=
 =?utf-8?B?UlVaeDFiNGpNSFo4VlVuOTJrZGVEQ2dpbHNzTmlNQWVWKzgwVGpjUmtOYk1I?=
 =?utf-8?B?STgyM1hWY1hyK1UzYStoSE5yM2FmU2VtdHBSWWFMRmlGWHVkSlFuNnRJWlpU?=
 =?utf-8?B?cFl5WlNHbGRURzJyRk1pRUZidjNNVk5HSjVjNXEycktJbHZiUWVOajdTeVAw?=
 =?utf-8?B?VHIxVlhYTGZlSWNmTDdwS1VNRUJwNnptZ25NeW5iaCtHWEJsN1k3dz09?=
X-Exchange-RoutingPolicyChecked:
	YgmbPJQoS4AJchNGJhqBbovQkmqg7Bs8xub6AyKrVmuX1skG423USVgwlYZ2FVmzd3vbQm6+VkSCh7XNS7gjzjJmpAe7TyC47SS5/ZqJ3UaFh18ilkX+MV3P4kmOhIG/uk9Q2i38uxka9TtgKfA1K1j1DbqqAPkmKkDhwbAzdvsVFPwqPe6/LHlUt6j5lYu0dIj1p6+KUfY67Ams59apL4bB+SCLOO31K4bBUUIwSPPB0X7TQRryAHGdsttDwBYFAwd4mYWZ2AUozc5xuWK0LsPexoLz2nHeLdRk0/DZB+mvtBf09QI6bfLq7O3QdAFdK/2lybHzkFXJfHplOFgGeg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7002f9-72dc-4698-0583-08df39c0325e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:36:15.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHTFc+QzAxsXCwEYHsMHNzOFqbqVMEKU0AV14GyNyEQ+AZMIV+vtbWPlq4aepRcMJShmYxaBSRb7yXWApUtlLhVlMrT9GHgtx2UDSTwv16E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5394
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfXy2NCwp8c0bUZ
 q4HhMq7RCBVeyBYTdbKT4E/DeAIfyH7OEmcBoqRCG2rtYn1o30PxayTDoNJ6mjpaFDKb2obqzdw
 40XNeeA096UWuUN0wmLmJ91QEPB+ewoXK86jb3GMUXAoStljHUj5yjygbegb67XYghYLpJzZgAB
 XVxIyiFcrp+O6iGA//sDZpJpnwiXd30+u4BVV9MiNQPDDVVI1wEmHYEQc2vZpY8Re2zvPDDLyGV
 w42cEU/BFZA2YDrdgAEsmVoWxRs9pz0kj9fktzsR+GSoubGgop38naiv40TMY5fzSbGYuGGEAMH
 UUETtZevaQ2jwC7fXfQMAtvAoGBOk46rGUm/loJGPW0fxO4zVUXut+6F/U7kmOrFx1yT4QXVcML
 v9fNmwcu621bw6t4+YEGKVKywHQPwq0KMpdLhk5dZ9KtkqgarDChVsyX+juPtQHAAi71LMpUG+p
 1c66Bls0fHEUmrq1RYQ==
X-Authority-Analysis: v=2.4 cv=MqbHeGae c=1 sm=1 tr=0 ts=6ae9ff71 cx=c_pps
 a=vOU3FABhAvw2ezUnG/KEAA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=CjxXgO3LAAAA:8 a=k7Ien0_I_WYOBHo1vdcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -NsC3oF3xjGVlT8-QwgnB7W8230K55DY
X-Proofpoint-ORIG-GUID: -NsC3oF3xjGVlT8-QwgnB7W8230K55DY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfX5RKZHiLO9rS2
 U+80hvDACXF+gXN69om29TA6Hy4brpmc93ts3li67/dxpExXX4W851Y56QgiK4G3AGW1ye49GEV
 IrGBLVYL0E/f1W4IXKcwnRQraPpBxRDyfnyymrHKcS4AWsyblzwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030062

On Mon, Nov 02, 2026 at 03:44:36PM +0100, Mieczyslaw Nalewaj wrote:
> The L2 lookup table on family D switches (e.g. RTL8367S-VB) differs
> from family C in ways that make the current FDB/MDB code misbehave:
> 
>  - An L2 entry is 5 words instead of 6, with a different field layout
>    in words 3 and 4 (port, age, static and multicast member bits).
>  - There is no EFID and no per-bridge FDB isolation. The register at
>    0x0A32, used as the per-port EFID register on family C, is the LUT
>    aging timer on family D, so writing an EFID there corrupts it.
>  - In the table access interface, the SPA field is 3 bits wide and the
>    address register is 12 bits wide, with no address extension bit.
>  - Only ports 0..7 are present in the LUT and there is no
>    FLUSH_PORT_EXT register.
> 
> Teach the table and L2 code about these differences, selecting the
> layout at runtime with rtl8365mb_get_family(). Family C behaviour is
> unchanged.
> 
> Specifically:
> 
>  - rtl8365mb_table: use the family D port mask and address width, and
>    read the hit address from status bits [11:0].
>  - rtl8365mb_l2: add family D unicast/multicast entry (de)serialisers
>    behind *_any() wrappers, pass the proper entry size to the table
>    layer, reject ports above 7, report SVL (FID) entries with VID 0.
>    Use age 6 for static unicast entries as the vendor code does, and
>    look an entry up before deleting it so that a missing entry is not
>    allocated by the delete.
>  - rtl8365mb_main: make port_set_efid() a no-op on family D, add a LUT
>    init step that clears IPMC_HASH and BCAM_DISABLE and programs the
>    aging timer, and do not advertise fdb_isolation or
>    max_num_bridges. Traffic between bridges is then isolated by the
>    port isolation masks only.
> 
> Register layouts were taken from the family D register description;
> the code itself is an independent implementation.
> 
> No chip uses family D before the last patch of the series, so this code
> is unreachable until then.
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_l2.c    | 216 ++++++++++++++++++++--
>  drivers/net/dsa/realtek/rtl8365mb_main.c  |  46 ++++-
>  drivers/net/dsa/realtek/rtl8365mb_table.c |  46 ++++-
>  3 files changed, 276 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
> index 0494d8a..a7613e2 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_l2.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c
> @@ -8,9 +8,12 @@
>  
>  #include "rtl8365mb_l2.h"
>  #include "rtl8365mb_table.h"
> +#include "rtl8365mb.h"
>  #include <linux/regmap.h>
>  
>  #define RTL8365MB_L2_ENTRY_SIZE			6
> +#define RTL8365MB_D_L2_ENTRY_SIZE		5
> +#define RTL8365MB_D_L2_MAX_PORT			7
>  
>  #define RTL8365MB_L2_UC_D0_MAC5_MSK		GENMASK(7, 0)
>  #define RTL8365MB_L2_UC_D0_MAC4_MSK		GENMASK(15, 8)
> @@ -58,6 +61,21 @@
>  #define RTL8365MB_L2_MC_D5_MBR_HI2_MSK		GENMASK(7, 7)
>  #define   RTL8365MB_L2_MC_MBR_HI2_MSK		GENMASK(10, 10)
>  
> +/* Family D unicast (auto-learn / static) entry */
> +#define RTL8365MB_D_L2_UC_D3_VID_MSK		GENMASK(11, 0)
> +#define RTL8365MB_D_L2_UC_D3_IVL_MSK		BIT(13)
> +#define RTL8365MB_D_L2_UC_D3_PORT_LO_MSK	GENMASK(15, 14)
> +#define RTL8365MB_D_L2_UC_D4_PORT_HI_MSK	BIT(0)
> +#define RTL8365MB_D_L2_UC_D4_AGE_MSK		GENMASK(3, 1)
> +#define RTL8365MB_D_L2_UC_D4_STATIC_MSK		BIT(6)
> +
> +/* Family D multicast entry */
> +#define RTL8365MB_D_L2_MC_D3_VID_MSK		GENMASK(11, 0)
> +#define RTL8365MB_D_L2_MC_D3_IVL_MSK		BIT(13)
> +#define RTL8365MB_D_L2_MC_D3_MBR_LO_MSK		GENMASK(15, 14)
> +#define RTL8365MB_D_L2_MC_D4_MBR_HI_MSK		GENMASK(5, 0)
> +#define RTL8365MB_D_L2_MC_D4_STATIC_MSK		BIT(6)
> +
>  /* Port flush command registers - writing a 1 to the port's MASK bit will
>   * initiate the flush procedure. Completion is signalled when the corresponding
>   * BUSY bit is 0.
> @@ -258,6 +276,130 @@ static void rtl8365mb_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc, u16 *data)
>  	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_D5_MBR_HI2_MSK, val);
>  }
>  
> +static bool rtl8365mb_l2_is_d(struct realtek_priv *priv)
> +{
> +	return rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
> +}

Shouldn't this be a top-level function, like rtl8365mb_is_d()?

> +
> +static size_t rtl8365mb_l2_entry_size(struct realtek_priv *priv)
> +{
> +	return rtl8365mb_l2_is_d(priv) ? RTL8365MB_D_L2_ENTRY_SIZE :
> +					 RTL8365MB_L2_ENTRY_SIZE;
> +}
> +
> +static void rtl8365mb_l2_mac_to_data(const u8 *m, u16 *data)
> +{
> +	data[0] = (m[4] << 8) | m[5];
> +	data[1] = (m[2] << 8) | m[3];
> +	data[2] = (m[0] << 8) | m[1];
> +}
> +
> +static void rtl8365mb_l2_data_to_mac(const u16 *data, u8 *m)
> +{
> +	m[5] = data[0] & 0xff;
> +	m[4] = data[0] >> 8;
> +	m[3] = data[1] & 0xff;
> +	m[2] = data[1] >> 8;
> +	m[1] = data[2] & 0xff;
> +	m[0] = data[2] >> 8;
> +}

From the diff it would seem that this is specific to the D family, since
you only use it in those functions. But looking over my crappy original
code for the C family, it's quite the same is it not? Can't you update
the C family functions to use these helpers too?

> +
> +static void rtl8365mb_d_l2_data_to_uc(const u16 *data,
> +				      struct rtl8365mb_l2_uc *uc)
> +{
> +	rtl8365mb_l2_data_to_mac(data, uc->key.mac_addr);
> +	uc->key.vid = FIELD_GET(RTL8365MB_D_L2_UC_D3_VID_MSK, data[3]);
> +	uc->key.ivl = FIELD_GET(RTL8365MB_D_L2_UC_D3_IVL_MSK, data[3]);
> +	uc->key.fid = 0;
> +	uc->key.efid = 0;
> +	uc->port = FIELD_GET(RTL8365MB_D_L2_UC_D3_PORT_LO_MSK, data[3]) |
> +		   (FIELD_GET(RTL8365MB_D_L2_UC_D4_PORT_HI_MSK, data[4]) << 2);
> +	uc->age = FIELD_GET(RTL8365MB_D_L2_UC_D4_AGE_MSK, data[4]);
> +	uc->is_static = FIELD_GET(RTL8365MB_D_L2_UC_D4_STATIC_MSK, data[4]);
> +}
> +
> +static void rtl8365mb_d_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc,
> +				      u16 *data)
> +{
> +	memset(data, 0, RTL8365MB_L2_ENTRY_SIZE * 2);
> +	rtl8365mb_l2_mac_to_data(uc->key.mac_addr, data);
> +	data[3] = FIELD_PREP(RTL8365MB_D_L2_UC_D3_VID_MSK, uc->key.vid) |
> +		  FIELD_PREP(RTL8365MB_D_L2_UC_D3_IVL_MSK, uc->key.ivl) |
> +		  FIELD_PREP(RTL8365MB_D_L2_UC_D3_PORT_LO_MSK, uc->port & 0x3);
> +	data[4] = FIELD_PREP(RTL8365MB_D_L2_UC_D4_PORT_HI_MSK,
> +			     (uc->port >> 2) & 0x1) |
> +		  FIELD_PREP(RTL8365MB_D_L2_UC_D4_AGE_MSK, uc->age) |
> +		  FIELD_PREP(RTL8365MB_D_L2_UC_D4_STATIC_MSK, uc->is_static);
> +}
> +
> +static void rtl8365mb_d_l2_data_to_mc(const u16 *data,
> +				      struct rtl8365mb_l2_mc *mc)
> +{
> +	rtl8365mb_l2_data_to_mac(data, mc->key.mac_addr);
> +	mc->key.vid = FIELD_GET(RTL8365MB_D_L2_MC_D3_VID_MSK, data[3]);
> +	mc->key.ivl = FIELD_GET(RTL8365MB_D_L2_MC_D3_IVL_MSK, data[3]);
> +	mc->member = FIELD_GET(RTL8365MB_D_L2_MC_D3_MBR_LO_MSK, data[3]) |
> +		     (FIELD_GET(RTL8365MB_D_L2_MC_D4_MBR_HI_MSK, data[4]) << 2);
> +	mc->is_static = FIELD_GET(RTL8365MB_D_L2_MC_D4_STATIC_MSK, data[4]);
> +	mc->igmpidx = 0;
> +	mc->priority = 0;
> +	mc->fwd_pri = 0;
> +	mc->igmp_asic = 0;
> +}
> +
> +static void rtl8365mb_d_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc,
> +				      u16 *data)
> +{
> +	memset(data, 0, RTL8365MB_L2_ENTRY_SIZE * 2);
> +	rtl8365mb_l2_mac_to_data(mc->key.mac_addr, data);
> +	data[3] = FIELD_PREP(RTL8365MB_D_L2_MC_D3_VID_MSK, mc->key.vid) |
> +		  FIELD_PREP(RTL8365MB_D_L2_MC_D3_IVL_MSK, mc->key.ivl) |
> +		  FIELD_PREP(RTL8365MB_D_L2_MC_D3_MBR_LO_MSK, mc->member & 0x3);
> +	data[4] = FIELD_PREP(RTL8365MB_D_L2_MC_D4_MBR_HI_MSK,
> +			     (mc->member >> 2) & 0x3f) |
> +		  FIELD_PREP(RTL8365MB_D_L2_MC_D4_STATIC_MSK, mc->is_static);
> +}
> +
> +static void rtl8365mb_l2_data_to_uc_any(struct realtek_priv *priv,
> +					const u16 *data,
> +					struct rtl8365mb_l2_uc *uc)
> +{
> +	if (rtl8365mb_l2_is_d(priv))
> +		rtl8365mb_d_l2_data_to_uc(data, uc);
> +	else
> +		rtl8365mb_l2_data_to_uc(data, uc);
> +}

Can't we have:

rtl8365mb_l2_data_to_uc() # same as before at all callsites

call into either:

rtl8365mb_c_l2_data_to_uc()
rtl8365mb_d_l2_data_to_uc()

instead?

Right now it looks quite asymmetric. And the _any() is confusing when
reading the code downstairs. (One wonders, what does "any" mean? Of
course, it's obvious when you read this function.)

Even though family C is the originally supported family, I guess D is an
equal citizen, so it's good to keep things in this driver symmetric.

> +
> +static void rtl8365mb_l2_uc_to_data_any(struct realtek_priv *priv,
> +					const struct rtl8365mb_l2_uc *uc,
> +					u16 *data)
> +{
> +	if (rtl8365mb_l2_is_d(priv))
> +		rtl8365mb_d_l2_uc_to_data(uc, data);
> +	else
> +		rtl8365mb_l2_uc_to_data(uc, data);
> +}
> +
> +static void rtl8365mb_l2_data_to_mc_any(struct realtek_priv *priv,
> +					const u16 *data,
> +					struct rtl8365mb_l2_mc *mc)
> +{
> +	if (rtl8365mb_l2_is_d(priv))
> +		rtl8365mb_d_l2_data_to_mc(data, mc);
> +	else
> +		rtl8365mb_l2_data_to_mc(data, mc);
> +}
> +
> +static void rtl8365mb_l2_mc_to_data_any(struct realtek_priv *priv,
> +					const struct rtl8365mb_l2_mc *mc,
> +					u16 *data)
> +{
> +	if (rtl8365mb_l2_is_d(priv))
> +		rtl8365mb_d_l2_mc_to_data(mc, data);
> +	else
> +		rtl8365mb_l2_mc_to_data(mc, data);
> +}
> +

The above comment applies to all these _any() functions.

Kind regards,
Alvin
