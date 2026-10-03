Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F943175;
	Sat,  3 Oct 2026 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791026872; cv=fail; b=CbKTygkk3rgIK0AKX7qtGLij1Jjg9sY8oddSBjS/90JPpQHwkeq4cr/tQMuavE0v2f9zBOXdtczRXpspH7gaaSjKFKZ1SLM5FoibcvCa+Vq9/pPxjA5H4mOpdapVwDFy/Dlf5sDvirvmhVrDoFQ3l4PjKE8HhPZ32vY6DqDPfUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791026872; c=relaxed/simple;
	bh=XXlkwyHHdfDGeMN5iw/6HY5ULP2b3gcfZu96DGNMxCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uETEG/NMjRTIKw0d+3McisK5OKp7REFPbnTscEFTEUp33uG10hmWNWHMyd93ta6R2EGAZyH9SAzrwmqGTgFKj/KqZFXQj+r3+aMenQ+rvbGhMUMQF9HboKhVJrpQbRh97eftljbL64DU9mZOxeqknv/moJjaJRG5ov8UiwxE+Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=f0BGbCQ3; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="f0BGbCQ3"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693AwoEn1690795;
	Sat, 3 Oct 2026 07:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FnYGB
	UA3vThnjoBYSVgD0HrY+EyscEPCXc+WlkB64lc=; b=f0BGbCQ3dDGoDpZ6+yx50
	mRypSXJOwOQSnRS5yCUaQVqF5V8NB7UwpySG1YJ+gZvUldWjdMb8yMbFFSMNlehW
	7+cPTKbUfsC6M/x8yin+5bYu9v2KwW8PoLKyhQY6HUeukUU676VdJtoptGTnHGh7
	z5aK0VZl1sOfz3SOiY7P77jRy/UhFhMangioG/+S27jU+tSyyWvNjK2nu1ctWITt
	vc187eCU26axHF3lpPn45PFFhFEdFN/8vwccaBR4S2I8fpm+Tm8JOx+2Y+slp4Th
	/qYO8rPBOsLhePGffGo0fxH3TV+OwQpD5vH8H3dkMELnNevidMQODarFIb6IPWXm
	Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h2suf1qn6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 07:27:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PT/dWeo1P2ZoxZiTvB1nYnEiqgKm5F0pWq6IQa1rmysvVbhVCa1+5L005vZXUW18wdJqK07rMl8gidfhyxvN5PSgh76wUlIU00FcUekTKs1vaWYI9HbsXow8oR3GfGsT7JoVE2ILu9wAHbyxZxBhsR2Kfe3BtxqnPWl0V8bhUBCDL8Ex4/YV/mqCsM3W7nEk5K6z1a232uwhOtd1JmNVaW1sC21CoY8b7DVwzRhrhZ1HShBPGLLHMdxM4aLq9/6NCXFmieAvLGKdzVsCcY2lixcuMBc7Fcn/W0d0r3ffLlTNd6dG23zEnNcLWBHCS+131aiyAPLg8Qg9+DZx0NlI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnYGBUA3vThnjoBYSVgD0HrY+EyscEPCXc+WlkB64lc=;
 b=WgN8yIwMlwNZ4ene3vP3824NFgMvTwhzwZcfV4ZiJu/yHu442cVgf83wUHpvXZ9dIvQqp2WR6bz1KNKwwQ/OljfWfmbrUsRBPD3cl/kFNIqKJHxiWRkxg1ekeA9x3FNpNaajer6FHIsmxvb13q0IVH1x7H+v+PPegneKIgOLkX8jhCv/L432ggrHC0qVk4LcVUmdys0iRuKVIxtR85pza4HoNjsFTOxfMjhGfZIo+gF5SI83N7AGfrQx6vhf9kO7tfgfL7x50/1k+ttzAEB9cvtU14iALktZPaLWQJig80VZEi4JvxaahnxmOpFX3+paBgru8GkbGTuIzK4re0Xzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by DS0PR03MB7678.namprd03.prod.outlook.com (2603:10b6:8:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Sat, 3 Oct
 2026 11:27:30 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0451.026; Sat, 3 Oct 2026
 11:27:29 +0000
Date: Sat, 3 Oct 2026 13:27:26 +0200
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8365mb: define masks
 using BIT() and GENMASK()
Message-ID: <asDmigQLCrVQSioU@analog.com>
References: <20261002-realtek_bit-v1-1-771fb0e39083@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002-realtek_bit-v1-1-771fb0e39083@gmail.com>
X-ClientProxiedBy: MM0P280CA0039.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::31) To BN9PR03MB5977.namprd03.prod.outlook.com
 (2603:10b6:408:132::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|DS0PR03MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ddc3eb-94c2-450d-41f4-08df21414f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Zjd0IKuFWJFUC2NyRlAtWuCGUhbjbARPGjRUsQ8wtlB2Ll0nhsuNffwAs0+rIHqeynoqVq7/xdI68JIa0V0spz/n0PszZAYmSoklRMXkD7KdDiWpimAW3xLqIcZZf+cuo1W8rkkePBhZMhzygM9MC3cApdvJq7LeDuy1OSDVLCqVYR1adAvZvNlD98f40ECsKrQTB0qx2Oqa3iqgoT8ZiKn5F4cVfyuUGUJ8BO5kMAY9em9uI3nd6bRQkmo9ikdqZXCF5mm106AvW9p1yIVvfWcXLD37dlWLmH0cefsjO0EqdtoHGcPaq9tYnRU8eHAYxknV8KsmX/NkZe9pIyj9cfH6goF3rDO5dj4NypC0OHSxvjl34sEgPVNY1VXyuVf4RRUH5syW4nUG5OJeqL35HKoBFuzTytWPJ0a833+sMQO1jFl7PXgHRokBnZd/WhTM2D0A3ONT3AhgKBpUh0igKLC9SGkXjHzUglxj5evDE+sZaRLgZdjYzLYkmDiFbRwNhG+9e3LjMGwq22qm0DwdtJpqZhnlU818Lswjn+TkTq1EnhhVj2AoVmwBMauXuiXW9qL452qTNSr1HlAICBH1Kg2l+z8/2BdoSugMUQWgkUAAbxLZtme4+3oh6u71slOS+yehvaPioWBAPxpdvm4SkW/GFArYe1Tb0dzeEq9SIhA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emtjYmt2WWtIdkdaVXQzMDdPRFh6TUc2UEJmYUp6OGd0bGRUeDdoMFRySHkx?=
 =?utf-8?B?Rlh3akNUOEc5S3IzbGdOeFpveXM2T3VTcmRnOVU0MlZ1VWFQM3VUSXBTV0tJ?=
 =?utf-8?B?ZG9obStHSXlZemRJZStOUW5JOTNaTTAzN05iYXFleWh3ZmMrSHdDNlY3ZlYz?=
 =?utf-8?B?L3lzTHVtdDdrb3V4WWd1c2l3bWhZTGpxS3V2clF5Q0RneExuT3NLMDJpdGtW?=
 =?utf-8?B?QWRFYlBPenFuZk0rQ0lIUFlHZnVKTitVOUgyeDZvYWJlbDlwbVQ0SE96bkVX?=
 =?utf-8?B?RFhzYURCTmJTSTZzNUpiU2FkMkFCQnFmNWNBZmYxRmVFN1ROaUNaOUh6M2VV?=
 =?utf-8?B?OVJ5WHhjTjhVRXVOTmI4aTZMUkROZzhORUVhUmErNkc4TTM2a0FkNWpRQmU2?=
 =?utf-8?B?eTIvTzFuaVAyenBvSUVGeVJ2NjJTRlBkWi9vSVhiZ1NaMlY0b09tM1d6MFl5?=
 =?utf-8?B?Y0dNejgycnAzS21ZZUt1Qnhha1NtNUJUbTRyeHdVZ0x3K0VibC9WR3RRRkpC?=
 =?utf-8?B?S252LytCSXJCcnI1UmlmZ0w4M3BKcnpDOGtmcmwrdmkyb3hrMTJCRDhNNUJC?=
 =?utf-8?B?eGRlUzR0RnIzMVFoalF2VGpIMG5ISkE4QkVNOU1oa2lIL3d6eFEybXo0TDk3?=
 =?utf-8?B?VzN3VWlTNkcvRHVoZUhEM0JxZHJ2NU5KL2JIcXQzZVZvRnJIUi91cXlvZGV6?=
 =?utf-8?B?ejFkd0Y2ek5uZkFWcWJBUnl5THdkNkl5MlVzTkNVaVRYcFpYRU94WVdtc1Vp?=
 =?utf-8?B?Qlg0QmxGT2ZxMkNHbGhOQ2U2NHdwM0UrM3JuNW8wYVVvWktDMTdOZEdqTlM2?=
 =?utf-8?B?UWZzTlJxbmpQSEVCL0F2ZTIwUXc5cEVGMDlVN1R2azU1bll5MlFQSGJIQlBx?=
 =?utf-8?B?ams3T3BhU3NkUjJLdTBLWEZidkwrRGcvUlRpNUM2L1c5eDFQaitzeHlpc1BY?=
 =?utf-8?B?cXZobzNJUXBzRDl5UlhGRU9rSWFJbEU0cTliK1pWTFZOclJndUNSYXE3Z0xm?=
 =?utf-8?B?RXZFTFRxaG4rRmVKOUtLSTdGTzdxNkJLZFJ6THZhMzJEeERQNndrdE0xWWVI?=
 =?utf-8?B?MFJrQisrY1dOMVl3Y21BYzdONms1eENjbDZCWUdMWWM4R2x3N1drUjVJQk5t?=
 =?utf-8?B?cTJTNENkUVdDaFBvZVYrWU9qZFNTRzZXMW1CSFhzc1BJYS9vSkthYk9Nclcr?=
 =?utf-8?B?RE1sWm9uUmxvL3dmdWxmTTVuNkY5dnNHY1RMbGJ0ZlBQTXNiRndXQklrbElF?=
 =?utf-8?B?VlhuTGdxRitnVzJIanF3TXBhRnlxQmdJZm1KQ2RHcTBjWC9oc0s5bjhORzV0?=
 =?utf-8?B?VE9MR0tWN091T1dQbXA4RVlWVGpncys5WnVmUzVSbFFaWDZIbUZwbjdVNGNm?=
 =?utf-8?B?djZnWXc4RkZrdnBuTEdqbkkxU0wweDV6Q1ZBSDY1UFN0RnZEWDNNZjlzaSty?=
 =?utf-8?B?TmhHRncyWkQ4K2svNFQwdjNyRUN1RXJEc2VULzVqbWJjNCsxVmpYZkRaWE1X?=
 =?utf-8?B?c2Y2dFJKRFRsNXp4MzFMc2l0bmFmSkNBM3NtUlhxd1VvYXNlZlhzREtFSWFp?=
 =?utf-8?B?S0lhUDVSK1dsU0JMNlpHVzloMFdFTWczL1JXeUpwVFJaYlJkazliSU93cnNq?=
 =?utf-8?B?QjRmRjhxbTAyZHdQbEpNUnExdUN4YzdsbTVRdDVzSnlUcnNxam5Xd08xVkRt?=
 =?utf-8?B?aWpPTXdkODJ0eFlQcU0vaUVjbTd4Q1BjK2hFSWk3N25MNWJyYUdKQnY5UWNk?=
 =?utf-8?B?ZHlhb3ZsajNsSU5oZEpDS0dvZDNWYTdpNGpNMEFoVXd3UUxnVk15cytEV1NV?=
 =?utf-8?B?RDAwRy9VcklQQzBPMUlxK2V3UjZQeTNaVndkUlhCbWcvQ1AraEFTWndGM2NG?=
 =?utf-8?B?TkhsKzF5RkRoeE0rdTZyZVo1dktlb0tHRjV1LzVWU0MwMk5OcEVkbGtpU3FD?=
 =?utf-8?B?bXY5OEw1cEZWeUsxVE5SRlBMaEFTVGhCZFJrWXkrczRsWWMzaks4ZmVib0h2?=
 =?utf-8?B?QjF2Y2xBYVNEUC9ibUVVUkd2cXgzNXVOYXFRbFlBQnhJMVlXMEs3MjNBZkc0?=
 =?utf-8?B?aGFLT2hVU29NK09GVWQ0cys5Q0lScVYrN1BXTlU0enhDeERlVm1IVVhxSDNB?=
 =?utf-8?B?d2pCUnZvdUw5M1grOEd3KzJWWFhIZEUwNWhsc3RYN1c1LzFTa29tcVlwMVF2?=
 =?utf-8?B?THZiWHRhcDZUUHFqZThYbkJXUE1qZzcwMjZQQzlhZFl1WnlPa29tSkNNZDlB?=
 =?utf-8?B?SU9UVVRhQWNpS2RSdm9lMG9NSXZMSUh1NzRNbWE2U0VnclVqLzVxTjFaOWEy?=
 =?utf-8?B?aHZZQW9LNVhOTEJpL3owemRzY3JQRFR5cTY1dnYxQ1R6RUhUMWdVUT09?=
X-Exchange-RoutingPolicyChecked:
	sYhlRSbHC8FNuKdAyUKvMY0zusfBODinYCrvoPyFEEnpmUJnh1bjZH8hxGhDAd7xq6Itl4JMIgkurZ1vCGyHiJzlf0tmG89Ps8dxL1yu9pRrpqCEw0RBt3yTaNthzgmG6U2yhNasgzZ1f33gBtiKo7yFwvge4g92njESJRVipNB3mS+40Uv1bKTF/9Fezflwxpx11p+epN0EYntDtUaKNe84px+zHPg9pPqz1z1JAG8nZlN+8cN7/h279OsNJKSHCXymvUp3Xmva7n/RQM32fdyQwcevaTQxygNxRyyHtAXskN4LmUZf0CCApBK4aW6DYZoRSSHSyZzAxR7sDN3+bQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ddc3eb-94c2-450d-41f4-08df21414f2b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 11:27:29.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0AK0Gnk87gu+y/C1guFSvwg9cUO5gmjyamDisN4i3m5Lo66wPFDShRjFpYeKjw9AKZtMEx+RL8pWKG4VbszDr9qmqlGaZqU8bFTNj6S/k8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7678
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA0NSBTYWx0ZWRfX4Zq5mV+M5PhG
 0o/094EtAJYVQnOWuZ4UZSOEmI46OYaON4J2UdbwNurYnmE5hnhGKTm4aw6t/15tH6MdZxfP8GL
 u66Jgh0Lj0aRWT5yeqDseKtTsbsfLx2q2erto7EfsgF/ZXp02+QH
X-Proofpoint-GUID: 6_kcerBGM87Zh3pWGwZ8NS0BnurWTSzx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA0NSBTYWx0ZWRfXz5sLfMzlGbGA
 dxQJ12f3h5dNPSoLIZ+DY/fV36fkjD/Ku/LaJmCuK9/d3oHo15LX+6DdwkT5Eod0DLcLHRyLlP5
 ubQl7Wty9cJSaHRCwMwkJOArJKNPp6hO051OvPiSPmQKIyOvN/RTf1utFDvIcD6p+VVaQH8fODE
 jQFtAT8IioLRGYrcYfC7aiVxFc4ICz8RFS/NJXFnfC3AkPov9xp6B3tiykk7eWLuviYYcxSVIIR
 aBWOC+Mm6JHUdP5FpibP/XZ04OjSNfji2UqFpPWurZtZXKEDajgNzVJ3DuXl7MZlZM588AyiJ6H
 U1UfMTmSB2S+n4oy5QjuO9+Mn1e7wtBWaWrfmPdKUo1IQqKdnMIybNqKUuDrut4eRSGHwyvYm0Q
 qzhiqQ+t+dse8ct3jwQP7U0+OmJy1rtKNyRABERfWSw5LozZofM+sLVSZ3hwmGxAH+AkY9FmrpD
 j+g65qqyu6SLunP5dCw==
X-Authority-Analysis: v=2.4 cv=Aa4kjHXG c=1 sm=1 tr=0 ts=6ac0e6a3 cx=c_pps
 a=kVQeibrV0jayZGAE3rze0w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=gOSMq8lg1QLOs-hzb4sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6_kcerBGM87Zh3pWGwZ8NS0BnurWTSzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610030045

On Fri, Oct 02, 2026 at 11:14:57AM -0300, Luiz Angelo Daros de Luca wrote:
> Refactor register bitmask definitions to use the standard BIT() and
> GENMASK() macros instead of hardcoded hexadecimal values. This improves
> code readability, reducing the chance of errors such as unintentional
> gaps or overlaps.
> 
> Introduce RTL8365MB_PORT_MASK as an alias for GENMASK(10, 0) to replace
> the repetitive 0x07FF values used across various port-related bitfields.
> 
> This is a pure refactoring patch; no functional changes are introduced.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 168 ++++++++++++++++---------------
>  drivers/net/dsa/realtek/rtl8365mb_vlan.c |   4 +-
>  2 files changed, 87 insertions(+), 85 deletions(-)
