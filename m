Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793880572;
	b=D06mynrYPR/K47uh4xxb887vUfik2EPc7zaTQsP2+rtmO7s4vn0JLP10XG709fGItJkh
	 d8pCUDH6hjOoX9Q16XXEXpbMQQxGfpJXCZ7ZSHzXgNfjngSDYk5KUffSFjLWQxAc8pnki
	 C+JYKCO0712NXxmzOKtozpscmV7Et6Hu/To/mBLA6Y3AWUq/yUsPNWvrHTeIdaeu5AD+k
	 U269Y2pojY/8SERJGX5a9VKCsNncWvortdPzTpOFHXA0zFUSvb808egWQWXxEfiV1WQ/Y
	 ptV7b+FFGlWHPv3jJA560R846pUHpRqOCR8wg9eKgutJVVcpfhdWe1v7vILadRSJ4Sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880572;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uN0tHABIN2Bl27MU4YVGZdpYEJD/9ssw7EFxSHgCVKU=;
	b=hq7a+2xLz0D1mCke5TopmH0U7eR+qsKAuHl7XZm/SmCiAVa92+BusYI6yVYgkH38t7Lh
	 gQjR0FykuGynRQa0N6fAtYo+0GHDO8+1mqny/rNR6wVg6ov+el024R98O5Tf0JZms8dCo
	 75q6U2sJ3dmhg02uXt2uw6TeHM2nDSjgSAfMuXC3P0KjFblJ32Rx/V05cUQg5sDCXm1vr
	 vQUSd8m11a/vBmddV4N7R+yupOspxbpXWmRq490KQJgu8bS48CQapqwlA/lE5VF23qJpr
	 JIjz6bDfvniQqfv4cvG/V8YNMy8cHd02ZFSB9a//qaFHIqM3MQ8mvw1kUvogS8SNDfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=CTiedrWn;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=lKu8G91i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5D606D834;
	Thu,  5 Nov 2026 12:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14A5D606D834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=CTiedrWn;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=lKu8G91i
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59ugOC1875057;
	Thu, 5 Nov 2026 07:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=uN0tHABIN2Bl27MU4YVGZdpYEJD/9ssw7EFxSHgCVKU=; b=CTiedrW
	nA4JVZTI9Ad9osERF2n2uP9z0GAURd+Xohx0l80pBKkYKmTvDUcPrA03B/SVV890
	ggaY3+vo2eFlHLnlqvXvM+OIV6e4ynT3DoVjdvqNOS7LEsq57J4zl0g8Ltn/cvk8
	zth52llKi+M4bsvqAdTFBsnFgP+7Bk4w/HLH7ntkcwG9TXyjhzlLqZo0rld0Y715
	9pGMAJl8V7RnVUguUUo+bfBgLAQr4w2wYQCS7aKvLYqxWVldHDYVvHbwfv+kkBh+
	Sn+NndnzE3F+FFPeSMhKSYHHxrCu21X+OHeMJBWF7iOa0Ezkh3GjSp06Ih1WWk4y
	JpmyX4Y/6ebsuDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uN0tH
	ABIN2Bl27MU4YVGZdpYEJD/9ssw7EFxSHgCVKU=; b=lKu8G91iHGd5sjoqdvWDD
	h+M/CQIffXYBB8RWrdMz89yfuzEU0KhfWG3er2UFb2+sFozdPGnSI60sBvLTYXwS
	TG9g6GerJTRwWkX7yjs5tWcQcQz8aj6n7lpFSCM1C4aVrLyewveyfUU0QB8s0oZx
	YEejRknFVF5YvECJwr5QVHgWPWxziH4TWKPMTWafEpkQ+4kVsh6ooLS8q7ctgxRv
	oyHyr9iHF0vzVgDvV1E4pABsHcE5hHiXswsvuU3x8FypcmEoUXJI42PFrHFQOx81
	BBZVqWQdyUM3nF4U9Nb1Ka43UJbHpmN8QfKl6NWJkSXxqlXjpvD1B5cj9r6Kt+pR
	Q==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hr873dy31-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 07:09:13 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmmhS5LKgozZiql0/IMbxEsuEp2IVlAAkWto6rb+MCJ7gpgt8zNlc8IgDkKqxaaInQXcI0m2rvtVSNR8hmt5UPz142DqDsz3RMRHTPz91A3BGQRzeB3hvDQ35cRBtRe14q5+ZhAGetrUYqhcVT32UDQfxLJIrb2/ZTyXz3Y4CyWRZI6fnmk98RDxQs6tc3h32dFuuXyQ5nPC6wP1z6k2sNZCOt4464r1o+nLTm8hOd28sj4lseetUbwlD9xniW5fm+oVLGoLjeuffIV164rgTNGHaV8M0WGOyF9HEovL6Z0wog8RjVkOsVVqGXsPM1VW3hkdPu+o5cBVZGa86Lvv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN0tHABIN2Bl27MU4YVGZdpYEJD/9ssw7EFxSHgCVKU=;
 b=cpeVFxbhDvNYNnKIMUXHGmQEBYLQOKrjM/a1En0U3orbBYnE9bxXFCv899t+EigDfAmLdrSsXpVJLhGExdNab7ft8TqQfNcP4B8X2FZJVRgcglGW8PzvAGeCeIL9wVcJL3WFIbJvNYha5yc/EpVxqyLuWvn2k7l9xytfoZaKrYQLto9ljupSwfk+4vufsqW49mTgXEzKIUKnToXjbyucdxRy7qwc6eR+OoKkW7Ps1DAjdhHOsv/BqZXAvW6KkS95gQ/I0nobPAItwYInQeuvNPIqTYh+FYZOYbkzScFtt7XP36juhu6azbK2biZ40GBcF6/KNxqZ+Qq140E3J7HaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by LV8PR03MB7328.namprd03.prod.outlook.com (2603:10b6:408:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 12:09:12 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 12:09:10 +0000
Date: Thu, 5 Nov 2026 13:09:08 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux@armlinux.org.uk, luizluca@gmail.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 08/10] net: dsa: realtek: rtl8365mb: re-latch
 the family D SerDes
Message-ID: <auxxZrjXd_8OrzD5@analog.com>
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <3ecac0ea-830b-47a0-931a-67fea637f0c3@yahoo.com>
 <ausrVrtHQHvac9bV@analog.com>
 <e3036c42-8c31-49e2-8ab5-cbc5b8771e51@yahoo.com>
 <auxDYMASk8J0SZRW@analog.com>
 <6460689d-ef3a-462c-a5b7-df3c2c843f86@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6460689d-ef3a-462c-a5b7-df3c2c843f86@yahoo.com>
X-ClientProxiedBy: CPCP307CA0003.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::12)
 To BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|LV8PR03MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ff8155-cec8-4790-7029-08df3b359987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|11063799006|4143699003|56012099006|261022105027099003|261021121427099003|261022075727099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ck++rUIyaW4IYtjZIss7qmNWZr27W+TC3/oxwg4Tguem3dykSUAbDN7LP3YTiSY8S7YOzI+Caj5E+Pj1DXACW8C2EfQkr2H4fT21e4/xPbZGUJ5IJDYjYEcONpSiYJLEouLQd11BHfYBHNcJpZvpJnwfFjbCBMZVNOv29jqe0NpRsQVwHyZXnnIuPa+nybCBH32E+inpL6WlC/qoidgyFBGBmoPlgtW+x9yTtpjr2NSgUED/Pj56J+okLolHWM26P9LrBzTGHC3kecb911a8PoGh54DW/fcFua9pzSHP/jXDVjPmWDHQp1q6W42tQ5ynyl8iS0ohkTTtp6LKDH9boCeqt8HzVFqw8dUM3NrfB88ed5OzzvB7Xvp2kn5Kt5GUTLh5xBZAGFUqcK3/u3FMxrmZtASCKNBtyqOR6n3KQXx/PVsjqn37umhNt0+Jjxnr8yUlFE73ic6jbkSzxjRFqugkH1Ml+vbSxspj7ye8nKmW7pxMgBGoOexGUtHoHmeRqS4P+nU1CwbwkzgOEAijlHInmLG10F9i0Od82lHBAXAjOXZqhA5Ggn8vRg2ysGiOcadNJrPu4xDEzswRJUoCdw3xsuDOaiLqmW4/ouiilYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHhyRFBVcnUwL1hzQlAxVE9OSlUzb25zK0t1c05ubmZkZ1kvekUwZytEclZW?=
 =?utf-8?B?aU5VWnNZWU5UbTlVVGtzb3lGb2lDbmJWVmpxNGVjbjZ1Vk5FS3NmNXFKYzBp?=
 =?utf-8?B?MmRmbExGWi9wLzg0YUVyUE1ON2x5UzJoNStOZWZ5M3NxdjE2akF1RkNYNWlo?=
 =?utf-8?B?N1dUMStIa0c1TldYZ3QvRjBsdmZ4b0k1aFZuZzEwNThFVm5BbmdrMG9HaitJ?=
 =?utf-8?B?alhTYUtNTjNHZmVoUEdNYXE3QkNtVU1aZk5na1VzS2F5RU1LK3hBYUtTeGpX?=
 =?utf-8?B?Qk1wMExJTldKTkFJbjVRMFl1NjdwdUJCNFZ0aEROZGl3dmV4cHUyMnJyTTkx?=
 =?utf-8?B?c0VVNjV2eDk1OEZPdENHc2VqbldyVHVwY09wVzBKa2wxN01CUjcxbm0yMXZh?=
 =?utf-8?B?bHlKclZ1eUprRW9GbzR2YWFSeUIxeWd5Tk1ENVUzd0FrUy82NTJMLzVMSkZM?=
 =?utf-8?B?UXRseGFIOWlBYThHOTdsM1MwMml3TWRFaGo3eHpHTTVMZzc1ekRIYkVsRG5l?=
 =?utf-8?B?bkorN2ZiLzlpTk1FRzdvS24zL3pzalN5ditNVGRSbWg4K0ZpVXQrakpTMmx2?=
 =?utf-8?B?eWFBSXpSQkZsQmx2UjJ5K2RaYm40KzhkekdJS2s3V3g0YVBONzJjZm5rWC9z?=
 =?utf-8?B?STlNWFBBZDFGZktpaHFwY2lpaE13bGVNQXNhOFZPdHpSQlFEcXZ6SmxKVnlq?=
 =?utf-8?B?RzJIaTRURmFwbWdBMTJXdDVlK0xsM2MveWdjcFFVbjl0d1NkK25SMFRQM3kz?=
 =?utf-8?B?VW9IczVxOEZJdnZtRWgyMlBKckgvRjNNeUdOaU14SjFERUR5RGpYM2daeE8z?=
 =?utf-8?B?Vk5Pbk1JUEVEY1hZNnZVUnY1aTJGMjN2SkFSK2x6YlB5WUtBZVpYVDJYZ3BD?=
 =?utf-8?B?RDZHYXk0VGR6cllWSE1NUmlOdjdIU2RkQUtqQzRGWWtWWTBnaE1yc3dVL05t?=
 =?utf-8?B?MHh1MlduS0Y4aFhVTmpQVkxMMnVlcTQyOXNWSmYvZUZjaXlPUXZSelNtelZy?=
 =?utf-8?B?WlJvUk5PZ2NLRGxyQi9Pc2NvSEcrU0xnYzU1RlQzdnhSTElmWTA4bE8zR1Ro?=
 =?utf-8?B?cUhLWXJaNE9HVlBZL3ltRFRFdmN5K0NTYTNBeHFXMW1qNDRKNFlIZUJOcW1z?=
 =?utf-8?B?Z25OUWlYNmswajl2bjh5VWtjTm5kbzNVdHdsMGs5bEZsZTRLQkozRjFSdzl5?=
 =?utf-8?B?MU1SNkFYTkxjOHljSmZnMGVYQ2JPK1FIdnllckp5WnlmenJxYjlUM2JvK1h5?=
 =?utf-8?B?VERkVVBGWlJKUjRsRkZyUlpGYk00dzdicHdGRm9ZM2Q3MTJrY0FkeFc5UzBK?=
 =?utf-8?B?cTZhTnZQR2YwRnFuTVZtR1JiNGlBMm9ROTllb2pIZ21jd3FGSlZhM3N3bDdU?=
 =?utf-8?B?UTRZNEdxZ3A3NUJ6UkkwTE9TZWRXekRiRDV5c1lCSWxpWnpoK3Jjbk5xVzd4?=
 =?utf-8?B?U2x4M2JBZklkUFNhUWU0eFZSOVBhUUpqc21ROEZ1MmozY3prQmVzS29TUVRi?=
 =?utf-8?B?QjJjRUMvWkxMZVFKTWM4WjFmS0JxWHA4YUhyV3ZUZWMvSVV3MWRYNjd0VGRs?=
 =?utf-8?B?dlcvZTg2Tk9tdDhaWjdqTW9aNVJKTGVtRlA0SmdOejdTL01RdzF1Mlh0SHlF?=
 =?utf-8?B?ZHZybDlRYVY3T2FzQU5lRnIwZU5kWjZwVXphRURJMnlOWGRIeExFeTE2dEVo?=
 =?utf-8?B?d3VaQmYwUS94VnZnUkRPb01GM3lFRlhGcEIwOGpZZnJCNCt1am1GVnhtUi9L?=
 =?utf-8?B?WndEdHNrbDltYUZiS25wUnJlOFZpdWlXL0NsUGJ4YTJ6YVV1TG9McDRueFBp?=
 =?utf-8?B?QytqTkJ3MlI2RFBHR240TE9uQ1VabUp3Q0VJc0RNL05KU0hZQlhJS25ZcFh3?=
 =?utf-8?B?c1BnY0w0eFgrZ2x2M0MyMWJxT2NkaFZBQm9QbVpLdlhsa1dYUkFDZHRMWmJJ?=
 =?utf-8?B?YXc3RGUxWmMvdytXdTlxL2VEMWgrMTY1MTdFNUZqMlJUUm9NcFFjcVNLOXNE?=
 =?utf-8?B?bjRuTVdXTXhCbmg5b3k4RlBybTl4ZHBVVFQyUzhqQ2RPcVhROHgrLytOaC9S?=
 =?utf-8?B?N3hCaVN4dmdUMXl2b0VKYTlzeHE5UWYwQzdMTEVXdWJLVkx1amdOSldDOUdZ?=
 =?utf-8?B?STZHaUVSdlFQU0c1eFBRNDdrTUFhVGpRYngrMjFWOFEybG9pUG9FdkhOOWJE?=
 =?utf-8?B?NGpDMGpDbk5JaDQ2U3NoQlVRUTdmSmpaZUxzd216WmlyRVRqNDdJdGNrQmhy?=
 =?utf-8?B?ZExmdmZPck1yN0hWeGdMbzBDalNSSzlldzc5NWZUZnhlN29hcjNmbWVCakox?=
 =?utf-8?B?bEJtTFNzZ0E0aG9aMW1OeTZEczVTQVJzSFlzS0RKNjZPazNSUjMzZz09?=
X-Exchange-RoutingPolicyChecked:
	UGxqqwfVyVxh7IiNxY+wswgKh+f1jNvkoTtOgl+eGD2PBfyZHch1SXPlrmU9buWXA1x8QScLb0jmslqvfSAlZhnaifhI0Z9QezfJLbvQCll3qStAVJGnwdQPEd1rJyU+l6ct+llN0Zdsh9VHpfsKu3FEOZ/PLFuRhCM/zPgEXAQ5A/7K/Mg25xxtupuvGO7JDKVyu8vNaXoJII7LvHJH9I295Cv86oTL2oOcmKSBjkMVTuXNoAcEOLyplnPETVmliA50hPQCneYgE4dRTk0A5cZ4K3VxQSDA/PaeZiVpkE5hnK4KavxXtMJo28YFmfyv0smVz4Tg8DoBhVmj4bELcw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ff8155-cec8-4790-7029-08df3b359987
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 12:09:10.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7xnCuxqcqBOwvIXAt9THcY/VuEWAtqVJCshpvbguFRtvbp2mYN1paDpbCtRL4JUviAOkQeNqGvnZrfwmbzN5et3iEf5vibrL9seVo2gk7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7328
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0OCBTYWx0ZWRfX3W6liok6s1AB
 5rRSRGl4UUWGdWJaGQV17AKcIE6mtb1OlFsuKi/PSG23izEBlU8dWNytQWhX0cZtGnoJyBUdtTR
 B6qKvCBeO5yM+vSo1NAV3DdiQs5LvpwfH457XX5NKaeABN/H74JX
X-Proofpoint-GUID: nejpa69-DVP-FbduQJEZmPmknMGJn1s0
X-Authority-Analysis: v=2.4 cv=S4tMU4sP c=1 sm=1 tr=0 ts=6aec71e9 cx=c_pps
 a=0dUMnQhOFwHl/g2jU5Tm3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=VwQbUJbxAAAA:8 a=5KkSQNevKZK3fKG6NQkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nejpa69-DVP-FbduQJEZmPmknMGJn1s0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0OCBTYWx0ZWRfX9nhzpNBBnNsg
 05/glTUo0rbrp+R0/b0VqrOi2+12AGwm+wxdM+oYfqnQ2fmvtHb7LTOx0IWa7uGehouSuuzEhah
 lU4rXcwFtkMda6jH/h8eiRMqmYSyA2vOD5dhjx4/mXToDIIk7Q7XLr+s8UTN9tqvPtdGrU2Q6qt
 JPTm/dwOsbdC64+yeKo+3RGU5lnLMp+NpxPah87HupycZ2SM/ho5KGDWGxUq1XbX/tqWr3mMvIe
 XOW0oNJh7Wzr2gp/NWvtoQf6X045U9s40S2bkOACBygDtBCGEuzZPpqC4SKcHlNk2IdfVpV+x8D
 6Tlv8GtssFlHOkF5jF8gL4gynIGsWcF5MNFhQo5e8BIfWtzxPhjo7woyOybFvhFcY5lelU2eq2R
 LFsa9cbTyNdYV0+FruVOq5Ij67qfpcqVsUgG965BfvSWK7FSwXp+LSBB7HFxevPLo1p5fotPRRy
 2STSIANnwyt/oxC+xzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050048

On Thu, Nov 05, 2026 at 11:24:08AM +0100, Mieczyslaw Nalewaj wrote:
> On Thu, Nov 05, 2026 at 09:52:53AM +0100, Alvin Šipraga wrote:
> > On Thu, Nov 05, 2026 at 08:18:49AM +0100, Mieczyslaw Nalewaj wrote:
> > > rtl8365mb_sds_write() and rtl8365mb_sds_read() now take
> > > sds_lock with guard(mutex)(&mb->sds_lock), so the goto out_unlock paths
> > > and the explicit mutex_unlock() are gone and every error path is a plain
> > > return.
> >
> > I've spent too much time out of netdev recently:
> >
> > https://kernel.org
> >
> > Andrew here gives some input on netdev maintainters' view of guard().
> >
> > So perhaps you can ignore my comment to this patch after all.
> 
> Thanks for the heads-up and for sharing Andrew's input.
> 
> However, please note that guard(mutex) is already used for sds_cfg_lock in
> several other functions within this patch, namely pcs_config(),
> pcs_disable(), conduit_state_change(), and teardown().
> 
> To maintain a consistent coding style across the whole patch, should I keep
> guard(mutex) as it is, or would you prefer that I convert all of them back
> to the classic mutex_lock()/mutex_unlock() pattern for v9?
> 
> Both rtl8365mb_sds_write() and rtl8365mb_sds_read() are very short and the
> lock always spans until the final return, so they shouldn't suffer from the
> over-protection issues Andrew mentioned, but I am happy to change the whole
> file back to explicit locking if that is preferred for netdev.

After considering what Andrew said, and the fact that none of the
current driver code uses guard()s, I would suggest being consistent and
not using them at all.

Kind regards,
Alvin
