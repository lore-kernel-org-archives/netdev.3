Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793796041;
	b=f8LRJcSbEluJDydlkXoUZ1iL4UpiAghZEdR6wa8//vaTrP+Dp9Tux95UiEMBF9ERs5MT
	 jxIj5sMrhJvgnP8lwiqnWjV6HXuIqBnad2rITt76mx3QAa5DNCEzYA8U8FogJvL/jTPx4
	 +o27JiEhLWzgtbNdrsmZ7+ewxdT8tVIHrlWQ+6VV7QfMLxjRFFQmXKSbcv33Upc685Zoo
	 9Ug6qlFZVxvoKLtpcKjqic6hllrDaozSAJyvYcNf06Q6LVzBhan2PkfZKrTWmYjKrGQmY
	 i6aCG8C7Dx0HoB9PTsZWOZnMwSuJIk6tXylAxj6NiYbU2BgZpVpTPmtV7fvhtRubi+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796041;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5tYU6p3qyVq35RI06K9kh8kQr9SUNnuUyKxyll0ltYo=;
	b=PpfOa0QeWjZLoN+RG1HWRZ8+G4G5We5J5igRLe8cqR831p9GfqOMOlGEg7cwAnF1teTX
	 0vhbVR4qmeAbP8tEQwI8jQdt7jvyh68B/V7u5bQTe0cZNo6LiMkNhR16VOGDhABXUEFVj
	 hWD89+I3JkL+WhgXwcFDNSKi4O3SWICp4hRTutxVJ3AGgpfjYYnwx1CKc2shZAQ/KY+d0
	 N6iF2Gsm0dgIDUTcPE8Keqq+kXzx0rsE9phZHK5u9qYHgcI0lWqcgqoBGwPnBK6/Aef8S
	 /Vps9LKAF2wbqibfN7p73AY7E2Q2I4cg0ZPkJfcSOBNM5FdMEFl58gD7Foh3BlzrM4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=JxfTkJYa;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=q0r7PyEw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9C606A326;
	Wed,  4 Nov 2026 12:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA9C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=JxfTkJYa;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=q0r7PyEw
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bc9kj1243079;
	Wed, 4 Nov 2026 07:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=5tYU6p3qyVq35RI06K9kh8kQr9SUN
	nuUyKxyll0ltYo=; b=JxfTkJYat1cxgmZ5fHXusQPm4454cu7wAAT/5Ft6pxzv6
	Y9+FPIYrrZE/3OahX7cfwJK1hp7DiAX/sFHqFdbTk41mREVWRLk6QEBrQ4HmngWV
	LR+20aTsjjfACfvGcx3QlPed2Lfr8B9TAYpeaoUFCn6+vF9nZyahkQ3lbx46Wmno
	wY5MQc8Rr+jCdpImSTVDF3lohU9Z3ZyRErHDMyW0TqAguMlBekGSjNHdcV21NgFp
	2NtSwZtKcM+600o3zjCNzdibIf518bm+u02ja7PnMCa8XVu8M+KM6d2qQyQDJvbs
	lF5P2amzdbOlAkIasdPsi8gME0aK33iIweO8KqrNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=5tYU6p3qyVq35RI06K9kh8kQr9SUN
	nuUyKxyll0ltYo=; b=q0r7PyEwHMZdrMQxEG8RmLYuzadTgT0bTTzAIPMCs/17U
	iocma12DnEuhf+0Bv9iYSs6rvcbFkMOgsRAb3EHGU53b40sF3HRBfraM0L55WgCx
	EYDbRP5RUY7KpWfO2/FG2L+kiMd+4qsGXnwosm3xCTWRYj54L7e5HACK/BmAoKMv
	OzAKKB7kURtDvELo+ug2XHBvfGQ4VM3jtlne5M78nnm1XjkjDpvqQiVHTevWNTTB
	dS61BdV3dAjRQfjK1qsF3B0mRKg1YITvRR/cYUdHoDWNNRAZoq/RGShAWSWta4Kq
	xcH7N+UuhR65JR/vHrQJzaoKOH5iGus1vlaEnVSAg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hqnfhmw1b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 07:40:05 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQqsw978GiQe/mo8vWhA4aMELzeszQvY7yBGe40Ry5DG+Cmw8rJ4pda8Ts6emAk78bGdOqZ0JVjM/sFtVrSqZIB4YB5ZWPl03Gm93EQj1Vv0fhg4tulE294sjrAT63CSXVrTb323bzf/8k9tABpX8fWfe/LS8KM71m63jHINJevaYwmM+n7EdCJg/NuqvvQNEZqtfLGkI9GjVP0V/QNQNJ2bQVI20jpNFd4ikFkp/YO3HpyziPNOihzaNKllc58N6EkDG59IYuFuTAKUgo2p7srZFquXIyQvBvR34LIXkDAFdRl/h3eeF0u+71S6kJ/JCJMpM4+apw6eC1H3/inAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tYU6p3qyVq35RI06K9kh8kQr9SUNnuUyKxyll0ltYo=;
 b=B4GkpYkkh0YskP0+BEtTBc1qrwbut5vyyzDfnYmNLGCFLEPBn6VPfYr3V7bGohsm9zylQVWU44GdjyWHiYnGrS/veN8NzeA1Jeb3BhFFuU20SXmDMNGYmLO2Df7TWbhRFJTzcYSuJ2Gryej3GNMgpArRYB3rfQL+PqRyNqjCKa0KgjZvKzshrShmCpn4T3CUJHg8n08P65Q9aDbclrVERP4tpS4UfK/bOcwTMiN8tx/f+e3Pz7F7KPJT+6jSZbbEEhsbYSnpQjSb5K+0h5NVt8fy9mt6zXrClpPlNNf53o3ZgRNwY04Dt4/AK+MaQ/UPHFBLXyVwrMlcvQ5ZFS7mdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
 by DS7PR03MB8104.namprd03.prod.outlook.com (2603:10b6:8:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 12:40:03 +0000
Received: from DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed]) by DM4PR03MB5981.namprd03.prod.outlook.com
 ([fe80::7af0:3071:4d42:63ed%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 12:40:03 +0000
Date: Wed, 4 Nov 2026 13:39:59 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 04/10] net: dsa: realtek: rtl8365mb: set
 RGMII mode for family D
Message-ID: <auskP2mSY4sCRa6x@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <2befac48-25eb-4c1b-9632-2f3237d68a3d@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2befac48-25eb-4c1b-9632-2f3237d68a3d@yahoo.com>
X-ClientProxiedBy: CPAP307CA0002.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:3::6)
 To DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24)
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB5981:EE_|DS7PR03MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: c52592ff-8217-405e-6b29-08df3a70bf46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022105027099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bn4c/EApC03soXS7+kUtp23XavYKZG3//izVbQUIbISuzfK3wSG0I02KO1lbkbFKsj1QZtQVlZSZfCg8hDN5GKIpzRL6YQ3rhIHrl+CPCYFDHBYFCTMI2GIW2eF0GQB7F2MYb5VNQY9TKAfIeq3BHsnlc1DgnmI/gNyA6NbqDqnlL8dk6StdYdyQBCitAyIXThZC2qiqVnuhpZsjs8r9HzLZyr7tcwD7PruSBo4gZLuODV8P6cnK+Ac7Nq6AivpRY5lEp47vTu1Alzwhi7RIeAVBq7WTgNfRVCY3QkIeJEYnU/tWbIVlQMtKhgAmL9acr3LRNAIH0Ash/TEx1o6ZZI0BPmO3jAGrP2tPIwfmig3WbvXBUfiFRxsro2tCH8CQbASbGKOn0cQlt3/Sbi1G560OWS6UyG36Ia3BzJhRoDxjEXq2HL4npYEUnjjg7vtEGu+GTqezdrI0W3KftDubs1m9UH6hZgiJBoVtbqO8iShSIbm7D5hDr5XAefyZSyvi5kr3fHUlw+Gxq4DrlKeQdxaPUTjpaOfNuhq6bJ2URj3/G64m4sQuKA88dKR0gF7GkJDme3hjVwp3xwFNiVtSqfKRBaKY+8XRl7N4soDGXMeNc/7bc2OIEQQNON265P2I2Z1BArFa5yp2hq76DjmFvh/3tlaVYfir+key4QDNiVU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB5981.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDFmN2lSd2VueFFpOFFUZlJ4Y215bGxqaTdSSW04VTE3TXZQelpDeDJmWWp0?=
 =?utf-8?B?VTFNY0lPNENOdStFMVA2cCs3UHVIWVBMQkZtZHVIRVFxK1NHSldiK2d6OEZG?=
 =?utf-8?B?WUgvMktGbHhTVmR4a1h1MGZkeW9zcnlPNXdqZkJjVjZYaGdaT1RwRUYrVlNp?=
 =?utf-8?B?N2lhb0RqckR6b1ViMlRKZEpib1F3ZnVFYkpGeUxlWHZBNURtVThCenpaUnFW?=
 =?utf-8?B?U29OblA4VVB5amVDMVkweXZWQ0pBVG9OaG9LY1psdkN6dG9vQmJmaTVzMWFs?=
 =?utf-8?B?V05uajhrRFBhQThLdDhiZVlKQU9sQ3Q4bTcrZWpleEdoZ3I3L2tsL2UzdWFr?=
 =?utf-8?B?VU5ldkxPSyt5SXE5VTE0WDlkdURRSzNBaUV4RnErdDZSdUl5eVNtaEVRMWZx?=
 =?utf-8?B?ZGZubEdDSFk5a2ttRVBqSWNzVGl2ZW9Ma1U0M2ZPaDVhMlFXYVZJMm5PNXgw?=
 =?utf-8?B?SmlXQ25xczVQTnNmeXJQWndNRy9LNFU2WGNlY1RNOVVBVFRBM3FVdDVRYW9U?=
 =?utf-8?B?YnQxbW9RN2pQQmc3cGk0SE01bkJhWG55eHhCWGN3ZkE2TWxSdXlCWHFRd241?=
 =?utf-8?B?UmZ5b3BQcFpXLzNyRUhMdzJ2MXpwZ0VNaXdlNkRway8wTHYyOHk4ZGUrU0dB?=
 =?utf-8?B?ZWdRYXZMOHZsYjFTZHBYdmVCQjgyWGNJT04wYUpOWUxLZUZCQUdoaDQvMUxY?=
 =?utf-8?B?U3RHSDRDNE9INTdXVFAyeVQ0bUJCTG1zdkk1RjhnNlVhc2JlbmhsN1RUZzNk?=
 =?utf-8?B?UzRjQmJ0WTIyNjZTMkt1UEcxc1dsSkJ4dWYrc1p3NmxwSkxEaGJPY1Ird240?=
 =?utf-8?B?OTl0TWRzak14ZmpKTkg5YmhKRGxBR3lRc3FEL3pib0NyVWhoZzdXeHBXMEdo?=
 =?utf-8?B?VzlVMVFkK0loVW0ybm9hem1aMlJEVVJ5UVFBQm9oV2hLRVN2d1Rrd3ZTN3FH?=
 =?utf-8?B?Wm8wNFIwWVhNRk5zeVFvMVdXdnR0NUxVcWQ4aVdSVnNIRThuYTN5cmpWTEhm?=
 =?utf-8?B?ME5rOGdmb1NjN1g5VUVoNlZ4TU9SWk00eFEzenBjd0pKOHZwdSs0em91b2NZ?=
 =?utf-8?B?ZithempLM0xkUDAwdlVEOVd4RU5NVm1Ta0hEbGV2dXljNkRHTHpFVFIxZ2Fh?=
 =?utf-8?B?V1gzWkFHMmpIN05JTm43eXc2WFQzdGlFYWpKdTBaOUo1RUUwWVoxcEx6WXdm?=
 =?utf-8?B?QVdOTDNzNUhPTHVKakxUSm92VHJNamkvcHRkeTFJczBaRlp2R3JPcy9UaFVx?=
 =?utf-8?B?aWNBdlFabGtGTFJRdG9MUGpLSHZQbW9xRDNxajBnSWcyQjJYb2R4OENIcnpM?=
 =?utf-8?B?RDBxOHRQajREd0gzc3c2TjVUZTVsNFVMYWhGS0tzU2t0aWxDUlQyMWQxK3hG?=
 =?utf-8?B?YmFHREFzMXFWeEl5NUwxK2w1WXV0NTd1eEZ4TkxZQ29uaHRSZVRaMVdFeFNV?=
 =?utf-8?B?YmJJbWNtanVxMVp1a0lHTDVJVUlkeW1tYlJ1N0xsa2hCYnVDVDhMR05ORU5R?=
 =?utf-8?B?eTJpZlBzVzByellpRCtPcFpIZlAwRFpOYkFRZURoZkJ6UnhQd01vc1d3VTNm?=
 =?utf-8?B?SGdFVXRwQVRTRlUzUW9rMWp1QWMyYXpnN3dJQ3dHaWpETDd3bHJOL3F3Ukhs?=
 =?utf-8?B?d0ttV3ZNZ0dLcFpDUDV4WVNFTkpUUjZqVVh6a2JPTTV2dXBVTWJoM1ErZU9u?=
 =?utf-8?B?NUREM1ZGWDNuN21TZFhEbXRha2xHOUdMMmZ6TTFMWHcrRFJGemxKOS9vME9y?=
 =?utf-8?B?b3FCL0xVOEsvckhWYldkcXovRmNjLzYxMDJJOFlZcTc3a1NqL29PQWFGK1Nn?=
 =?utf-8?B?aUFqOU95NEttZEI4dE5MYk5Ca1EzTFl3S0EzMjFURk0xdkV5VVZza05EbHlN?=
 =?utf-8?B?WCtQSzRLRmFjYW54cXRHby81WFNYT0tCTEx6QUNWSzV1NU5TTklRRk5INWxR?=
 =?utf-8?B?MGhYQVE1emdDMlk5N1pCRTBHU0JBSlNFckVJV2hjemV0ajIvVG5sTU1FekFE?=
 =?utf-8?B?WHN5d0twcjN1emhNdExSN2hWL09Xa1hDaDgwcXhsaHlDNmpxM2J1dTQ3RUlh?=
 =?utf-8?B?Uy85QTFaTG9JQXV3VnBidlUxUmdJbjZxNXpQT1htNURkMkk5dGs5TXJZc0I0?=
 =?utf-8?B?K1VRbCt3YzZmV1IrQVZ2ZDVoeGYvN1ZFNFREQVR1a1BQMS9Vb1hCcnFIa2JB?=
 =?utf-8?B?SElpdjBFR0gvakRVWW5BQVFDWDVqeFlvVC94bHlaYWhaTnp3T2lUZnB4OGRi?=
 =?utf-8?B?MkRkZm5OMHorLzhiMzhZbURGLy90YkJtbU1sMVdQVisxeTdQY3ViVmEvaVNT?=
 =?utf-8?B?NHVHRUZBVkZDS3NFb0JaMjZZTnpOTHJFRm9mQVEzNXM1c0M3VERuQT09?=
X-Exchange-RoutingPolicyChecked:
	BrofIQ20DeThGEiyRZG5+mzns0E9DWUADXxb4jCAQbHsuddsetF9z/IVkkgR49RMvlwhEavpULlOkZ7SdhOTnDDt+zO+R6EmByxFxIXsOM68j7xOgMKGafinkDZL9/DNx81TghEXQlDt0nM6XHZSKlyRxJJJLcwYga2eEtzF9mXzhnnzZAvHJPLn2Z8gXoRMgwjJ53T2ZN+CMm12FLyCF8D2lFdOjPGWijHMOoUvDbYv5PEu+cibOfA62rXA7hYXg0sTGJAMUIomdVu13SonmKdw0bmayg6CU7EbzEzauYTe5d3UMSWIh5Y6n3ooOVtghsR9VzXVXXdylRjyLJcgdQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52592ff-8217-405e-6b29-08df3a70bf46
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB5981.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:40:03.3689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2h06Fo9sEflMnG84aIomtrbR+5u63bIxegewP+hjuINnNxTFiCP5X7mY+l1kC4vBAvKNSstfL2V8OKr0XESZIuwtJofPW66yOeHfm+UgrfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8104
X-Authority-Analysis: v=2.4 cv=I6Pw19gg c=1 sm=1 tr=0 ts=6aeb27a5 cx=c_pps
 a=boTDQTO5XcRoDQ12XycLVw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=CjxXgO3LAAAA:8 a=VwQbUJbxAAAA:8 a=RuatNGMrKUgVgGHaPdEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vXEc4b7LCa2LJPLfnRvbm0sGFP879zZ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MCBTYWx0ZWRfXy1fyG5C4VKoi
 542xKEOK8Ei/Kh7RVBRbgrfInaC4Y9r9cclL+SXCRDHy2L9CZidHWT7nUOlxLBSbvl4z1QZvfdB
 oa/+hjzD/EaSE+mnaMeRHNYQOMBmtZ5JViPZvBnps+FldezOxa4Rjk5yZ7DMqaObhxm9ijf4+w9
 gXaQrUSr4C4+dEqtgXpif4OlScceMRZwnfbmyElwVBQAk7i7Etiu2oOsEsOZQi70NuYGPBRwHNm
 WMLMuH3iPgioui3bGDPLstPz11eorGlQJ16OjmlBc2V5axGH8cn/Lmsv1x7NY4MHPcMDvYx4+JT
 WyRg68jbOP2CTRww7lUehrO7mkNJpBokmJWCMPgndUl4CfbBWQnpoG7VU857JWBuFs6U8YTBzij
 zMu1lXI8kNW9AGPNG3Ej3qV47AybV3dKsexSUbsJin/1EviL7AaaqjHTwcKszHsDdbT+HrgccCf
 +Vq9bzJzeMr1DmU17Sg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MCBTYWx0ZWRfX1TwaCrojMqdj
 /bzCQv0arq/51dTLV7XP4UBWFxa9vVa9SugGa3tqP6PZ44D7vCZ8yfa3QwEQa/E9HKDe5xBSVlL
 fmGsaLBBmxuhgE0SR4QlQKovWYZ5eKMU7ca4FV2rszdernbxDr/h
X-Proofpoint-ORIG-GUID: vXEc4b7LCa2LJPLfnRvbm0sGFP879zZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040050

On Mon, Nov 02, 2026 at 03:39:47PM +0100, Mieczyslaw Nalewaj wrote:
> On family D, RGMII on extension interface 1 needs two things that the
> other families do not: the EXT1 RGMII TX clock delay field in
> EXT_TXC_DLY (0x13f9, bits [5:3]) must be cleared, and the pin mux in
> the top-level configuration register must be set up.
> 
> The vendor RGMII setup for EXT1 clears the RGMII field of EXT_TXC_DLY
> (0x13f9, bits [5:3]) in addition to programming TXDELAY in RGMXF.
> Do the same. The init jam table writes 0x0090 to this register, which
> leaves the field at 2, so without the clear an extra TX delay would be
> applied on top of tx-internal-delay-ps. Clearing it makes
> tx-internal-delay-ps the only source of TX delay.

Should we not just clear it with the jam table then? It would save some
code here, which is just undoing what the jam table did anyway. Or am I
missing something? If you deviate from the vendor driver's jam table
then a comment inline or in its own commit could be appropriate. But
either way it seems it would save some code here?

> 
> If the internal MAC4 block occupies extension 1, do not advertise RGMII
> for port 7 in phylink_get_caps(), so the configuration is refused before
> any EXT1 register is touched. This mirrors the vendor RTL8367D API, which
> returns an error for RGMII on port 7 when UTP port 4 uses the RGMII
> interface. The driver logs a warning naming the conflict. When MAC4 does
> not own the pins, bind the RGMII/MII pins to MAC7. SerDes 1, which shares
> the pins, is always disabled. The TX delay field, the pin mux and the
> SerDes 1 disable are all programmed before RGMII is selected, so the
> shared pins are never driven by RGMII and SerDes 1 at the same time.
> 
> The family D branch is not reachable until the chip table entry is
> added in the last patch.
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 72 +++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 2dabc4d..d69eed0 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -332,6 +332,12 @@
>  #define   RTL8365MB_SDS_OPTION_ARM_KEY		0x0249
>  #define RTL8365MB_SDS_OPTION_REG		0x13C1
>  
> +#define RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK		GENMASK(4, 0)
> +/* Shared "disable" encoding for both SDS_MISC's and SDS1_MISC0's
> + * 5-bit mode fields.
> + */
> +#define RTL8365MB_D_PORT_SDS_MODE_DISABLE		0x1f
> +
>  /* Embedded DW8051 microcontroller control registers. The microcontroller
>   * can run firmware to manage the SerDes link, but this driver keeps it in
>   * reset and disabled: phylink already performs the link management that
> @@ -465,6 +471,20 @@
>  #define   RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK		GENMASK(5, 4)
>  #define   RTL8365MB_PORT_MISC_CFG_CONGESTION_SUSTAIN_TIME_MASK	GENMASK(3, 0)
>  
> +/* EXT_TXC_DLY holds a 3-bit TX clock delay per external interface, for
> + * RGMII ([2:0] EXT0, [5:3] EXT1, [8:6] EXT2) and separately for GMII.
> + * Only the EXT1 RGMII field is used here, and it is cleared in RGMII
> + * mode so that tx-internal-delay-ps is the only TX delay applied.
> + */
> +#define RTL8365MB_D_REG_EXT_TXC_DLY				0x13f9
> +#define   RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK			GENMASK(5, 3)
> +
> +#define RTL8365MB_D_REG_TOP_CON0				0x1d70
> +#define   RTL8365MB_D_MAC7_SEL_EXT1_MASK			BIT(13)
> +#define   RTL8365MB_D_MAC4_SEL_EXT1_MASK			BIT(12)
> +
> +#define RTL8365MB_D_REG_SDS1_MISC0				0x1d78
> +
>  /**
>   * enum rtl8365mb_vlan_egress_mode - port VLAN egress mode
>   * @RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL: follow untag mask in VLAN4k table entry
> @@ -1261,6 +1281,33 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
>  	if (ret)
>  		return ret;
>  
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
> +	    extint->id == 1) {
> +		ret = regmap_update_bits(priv->map,
> +					 RTL8365MB_D_REG_EXT_TXC_DLY,
> +					 RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK, 0);
> +		if (ret)
> +			return ret;
> +
> +		/* Bind the RGMII/MII pins to MAC7. MAC4 does not own them:
> +		 * RGMII is not advertised otherwise, see
> +		 * rtl8365mb_phylink_get_caps().
> +		 */
> +		ret = regmap_update_bits(priv->map,
> +					 RTL8365MB_D_REG_TOP_CON0,
> +					 RTL8365MB_D_MAC7_SEL_EXT1_MASK,
> +					 RTL8365MB_D_MAC7_SEL_EXT1_MASK);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(priv->map,
> +					 RTL8365MB_D_REG_SDS1_MISC0,
> +					 RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK,
> +					 RTL8365MB_D_PORT_SDS_MODE_DISABLE);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = regmap_update_bits(
>  		priv->map, RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(extint->id),
>  		RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(extint->id),
> @@ -1773,6 +1820,8 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
>  		rtl8365mb_get_port_extint(ds->priv, port);
>  	struct realtek_priv *priv = ds->priv;
>  	struct rtl8365mb *mb = priv->chip_data;
> +	u32 data;
> +	int ret;
>  
>  	config->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
>  				   MAC_10 | MAC_100 | MAC_1000FD;
> @@ -1802,8 +1851,27 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
>  	 * which remain unimplemented.
>  	 */
>  
> -	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII)
> -		phy_interface_set_rgmii(config->supported_interfaces);
> +	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII) {
> +		/* On family D the EXT1 pins are shared with MAC4 (UTP port 4).
> +		 * If MAC4 owns them, RGMII on this port cannot work.
> +		 */
> +		if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
> +		    extint->id == 1) {
> +			ret = regmap_read(priv->map, RTL8365MB_D_REG_TOP_CON0, &data);
> +			if (ret)
> +				dev_warn(priv->dev,
> +					 "failed to read TOP_CON0, RGMII on port %d disabled: %pe\n",
> +					 port, ERR_PTR(ret));
> +			else if (data & RTL8365MB_D_MAC4_SEL_EXT1_MASK)
> +				dev_warn(priv->dev,
> +					 "port %d: EXT1 is owned by MAC4, RGMII disabled\n",
> +					 port);

I am a little confused about everything that's going on here, but it's
probably just me. Could you perhaps explain the two scenarios and the
order in which you expect things to happen? I'm sort of wondering when
this warning might be emitted. Part of me also wonders if you can't
avoid doing a regmap_read() here in phylink_get_caps.

> +			else
> +				phy_interface_set_rgmii(config->supported_interfaces);
> +		} else {
> +			phy_interface_set_rgmii(config->supported_interfaces);
> +		}
> +	}
>  
>  	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_SGMII &&
>  	    mb->sds_supported)
> -- 
> 2.53.0
> 
