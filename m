Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792761308;
	b=shW6u4gEyCXVApU2xc06faLcOJxhwmYlDFRfz3y8yFeygJ73CorMKqvtV2KS+/jEs2+G
	 bw1XlC8NDn4fUZkxwJWEKyJ/93OZg7WR1049lI3+Oeax5kqLMMuSptZRtNOiNKKQ3mGzd
	 sD10ibg0p8ucqUk8oLzNsYqS/TXNjTJ/KXrijwCs89XmOmWis/P3BgyAlnADIKBzlY9wc
	 A73Nyd4jkKoXtepN4Gdv/ROxT2C1ip3pzpl+h+OVFAbz5BmQJxn0BhVz8bE96o/p/6M/z
	 UVC9fcTtf1ifqCRfd8a6usEP2bIZh7so4ICroKucvHQnziT3FkGPSytXi7AxCRi9eUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761308;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bwbHRAsrNNN/8whEZgLoj+OFIjZDkdvmA0PglfzTrEc=;
	b=kyi4H47WFNXKjigrH2AKAfYkQw7nS1an3DGbMSi5gkL7lWOHy0v5v3CIeC4YkGqKBMs4
	 FIwIm0YKVTjeuZ6dwkMAJTZweyzvTw5VIZsindIhsCJnE8yDdVNoYHNXwgW0kv6KBDRNJ
	 fdbUx0UO5blJuOqFJ5ilu/eKO+gYDs6dmRr1fGoj99zb7ORi9TBf9hpTid/qSV77i+nnZ
	 V2exvJ81JJONFZ9gm8WrE2mISxCUmS1D6PuZJidGULR/DmSda1+LwY4I0DSA1RXwOv4Cr
	 ZhOY0mYPxhl6JdswbfCuk+YW3WFmo2kyyNjrI5SQC2fmbsjShHhMBmCjVQdXLCokz+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rp47p6Dz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.57
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D2606A31D;
	Fri, 23 Oct 2026 13:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A80D2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rp47p6Dz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPlll4y3kjKzD4zJNpBJhLZUWlPVDLagNHiRp+0Zv2A6gt2LJz2mrgOkgWgeyJfS1XM8ifQ9WJSFXV+0WIvl517LxMlXDeri1JOXqd4idKOwoGTHcJl+o1Q2eOHjbjGEGyucmmsgtjVrMiTVMZO9W2aWOGL8TlY+3rNC5p5weJANh8nVqZG1rq8mhlv130dhipgst6NqFUVXr7uLsqkA1swJSXRc+J/huvwmhYxAGGXaOYJDwnnDQctqijAWBLfnjoVfkR50EeuVnqwuQ5c89k5s4XzeJMQSD3JB1lsAN++sOByig2Qnx1eDdPYjyB27L2BxjYfd29rlu3auwWEipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwbHRAsrNNN/8whEZgLoj+OFIjZDkdvmA0PglfzTrEc=;
 b=dBLVvXhYbiTPcBa9x9CGOn+0RgUupP4g7SNvCDLbtkgf+PGII04DLvjewNLVgWUoiyu6nt1QZIxPPBPNol3r8OyoT2lXl28Pt3F/F0YyzVKpYov1EJ/iPwgdTiKvO0IxXQAGwWE0+37ZXmIhhKHBDbv7lBG/iBROjd78LU73iP7WGlO1nPOBhSHVT/on/3BthtFO0ICO3bneyIeAID4slS9Qe+w82fqkCtoQAIgE3tGBFtWkCgQeERcogj4S2lSFD7jcF2o28Su6MtWfsO8TK1audjKnC0JjvO13m5MjekBrE1/bqdmLK3477dL0BgQ2bW/rOot3u1cILUvW4SIHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwbHRAsrNNN/8whEZgLoj+OFIjZDkdvmA0PglfzTrEc=;
 b=rp47p6Dzw2u675eu8xWibPWcg8H/JBwSrHOiAXXmyeFgFBFtp9oHMIsibcrrHiTy++lwdRZEvdlHvafB0F6SKMsRsTr8zrzOgFcXV+pElQA9H2GMjNAt919/VkiIz0mW/NHRGCUUXzLZjwo8Z96C/+rh+QOgChXlM2xLWQ/+dnWq6gwY8VMHbKQ2Zh5f0ncJWgG/TdJTveABoGX7xRHAmiQE4J2o/Z5TW8xQRXWetOToUCZUBuZcvp4xC+Gy8TvPWv7yjlYIpDyFPWZEevBSki3GyfkFkOlBHrAgyjJQwlhzzfSjyIGA+7P4QPvPfDZNMHHye4aytyjj9q1biMVkTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by IA6PR12MB074433.namprd12.prod.outlook.com
 (2603:10b6:208:5fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 13:15:04 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 13:15:04 +0000
Message-ID: <d6c14ede-1cfd-4800-a8bf-5093ab8c000a@nvidia.com>
Date: Fri, 23 Oct 2026 15:14:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: mlx5e:zero-prefix corruption during TCP DMA-BUF RX - help
 requested
To: jiabin deng <dengjiabin2023@gmail.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, linux-kernel@vger.kernel.org
References: <CAFxp=AY2cVRQrZvB9WNnigbsobuw11NMG-cagHx0_V+ur2ToFw@mail.gmail.com>
 <e4054f5a-e60c-4253-bccf-d05cc7c615b7@nvidia.com>
 <CAFxp=AapgUYLUhipVjR8oM0fRDSLDX60AQf0UP8=U4M1ASqmOA@mail.gmail.com>
 <e6a557b3-2986-486d-9679-e7a4fd1cee5c@nvidia.com>
 <CAFxp=AbmdmTsj4ugjxdKhRR=LJuuC1yr7DFnLCSgOpC2g9470g@mail.gmail.com>
 <atZKOtjrb9HKSNHF@dtatulea-c5.nvidia.com>
 <CAFxp=AYqVgR_Eahz2QsC=cCdxo5GmTwdHcgBdXRGf9P+v0OJxQ@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAFxp=AYqVgR_Eahz2QsC=cCdxo5GmTwdHcgBdXRGf9P+v0OJxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::12) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|IA6PR12MB074433:EE_
X-MS-Office365-Filtering-Correlation-Id: 521edfea-f057-440d-34ce-08df3107a69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|10067099003|11063799006|56012099006|4143699003|261022113327099003|261022105027099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	zX8k6vSItw+pJ0IsrZg54ggnV85aB2VJ8fOVTBIYQ6vCmm38sWaz4ZFtwyrzAt8VOcKcjB1OA0J0JXED/1bzMNTMNCnH1KeyEcsKQba54HdvpzHaEIHzRCaFffyELLcsUK/8i7c/0IqYm/y0E8pVbFx0jv5POXLvIfTlcEc8Pc5F9hhCHZejClyl2rfqcYRQ3cuFBu9fIQKc1X9lFao2dExnKgkfRiNQQjaOvKHTSE9t5Lc32plcPurPCTnhalIBufNZR1stmqBeSRRaMXSyGJGIkSpo6nTGykWtzHjLMCPRUFoJPFhOfnZnAYUnmxtnm1B2j8LFSSv43XiSuONQfvwOC1fogjgh6FS1b9+2Mz5VS7CVl0nrbs526ux9ObICDNYMR5Bd9QYo6VV9grG/TXtVFY/NOMHT9/GOSkP5u9nHuvinBoU/zBN9mkX5pm37BCfncl0F5Mti+w5yY1XAPvjX0sw6eg2suARqIfqZPGOg6IqbCrcMUGS7Qv/CUHFrVDe+vlSYQXpTmqThJODvPdqHMr1bfIByKzXP4Nw46/HGNIOcR+TFawc3FnFf3EI63v2Uf7ol1XehXZHx6cJH5Kxjfx+KrkRzRIUjkwRGVl+/Si6MlJFvcdWz3PSn/Ng/SagIGS+c6AEpAbMHDGc348a7tyRpaFNbthQ+QT25DYU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkFVTHFPT1gyUHE0Tk5qZFJkRU92cGRib2xXaWxqbHI0R1dZMVg1SkpOMFdB?=
 =?utf-8?B?NStIMlIzUG9NVUZndm1INGhrNjRwYjhFc25sSzZ4cmQ3VkNMNFN6NnJ1a2lY?=
 =?utf-8?B?dnBhWVlOYkY4R2dHOHViRVd0UWNBaEExL3NyckdqdDVucWRROHlBN3QycEJz?=
 =?utf-8?B?NFB6ZUhSUmtTOFlvT3pZc2FRYjRzdVhEZWNPT21CNHhUR2JybVdheFVZT0N0?=
 =?utf-8?B?SWwxK1ZRNlpaMzdKeGRVWHZwWGxRVWZQSXB0VFdhTmNENCtabWJFbFlhVndS?=
 =?utf-8?B?c1BoMEFrRkpic1FNS0RLUU84MEY3bkxqUERGVGc3OE9pUDRRNmZWY2lrYWNx?=
 =?utf-8?B?M1BCVFV0Qnp3Ny9TcHhpdmJLZzQ4b2ZKeXpPRnhSWmVDNFBUdStFaWNMb3U5?=
 =?utf-8?B?UHY0dHN2Z1Frak5vN3RoZDVFbmN1RWRCOFZIWWo0YlRSUFpIWmNoUmdSMk90?=
 =?utf-8?B?RDZnV3hwRkgrUU9xK3ZEQ3Y3OXFpT3BPazlWNGo4SitEeEhwMHZGRHBqb2ov?=
 =?utf-8?B?eCtIWm9zTDYzQTAzeGF0UUJ2RXE0eHh4MEI5RDkwRzFYSVBRNE5IRCtYQnlw?=
 =?utf-8?B?b1ZjcUsxRU5WcTlYM2luNHlHTHVXQU9tUnV1eklCdGFvTTkrSjZ2NVY5UEdK?=
 =?utf-8?B?YldBTjFXQzhFUytWK0FFamRGbldwc1g3VElUV0U1SmhaV2hVUGt5bUVDNG1U?=
 =?utf-8?B?d3VxLytOcGNETFRNUEd6bEl3anNGZ2hTeGF3clplNUVXaXBtWnY1bEIzMkR4?=
 =?utf-8?B?NnZnZ1pTd1hTUDJUbUtBUC9WWTFqZmZ2cldieHVTRkpMakxBTUo5aDBvV0Yy?=
 =?utf-8?B?alJZT09VVk9PWDV0STMwdmFEWjB6TE5BSGFHd3JtQk0wL2F1dXhQKzRIWGx5?=
 =?utf-8?B?TkQwenZFQXlNMFpXeGcrQzlGaUwzSmVkZWZqTVJHbUQ5eUVoSDZQUW5HLy8x?=
 =?utf-8?B?Z2pWblZqbGZpempOR1Z2bmpxWUxGSHhMR3NMdkxjUWkwZ2VPbVB6SlRrWGFh?=
 =?utf-8?B?aDJkWCt2RytIaTU0WWJWVUM1L2xpYXdDZ2U1a1BiY0NYMFFWcVR0K0psVWdD?=
 =?utf-8?B?U21WRzlPMnB3bytQY1d5MXB3SjIvSlZRTzF0Q2dXQnY4NzZHRjJFUTF3czJz?=
 =?utf-8?B?SXRmZlJZNWMxSiszRFVpQXhMWnBaU0J5NjliWHV6OG5GeDViamFMbjB6dkZx?=
 =?utf-8?B?RDBwdGxMc3ErUzNQVTV2eWZCU1VWZExJeHdXQVFML2YyM3NGU3YrYUMrUXBn?=
 =?utf-8?B?Tlc4c0hqYWxDamtmSUZuenRVS3VYbWkwdC9JUWFTbFVoRkVBeThjb3VGWkpk?=
 =?utf-8?B?dlp6MUVGL1JSTGFaMGxFTXh1SjllWjYrcE9ZVk8rVGRQNGdtbzBLTVlUcEgw?=
 =?utf-8?B?THRpNnE5aG1Fb2VSaEptR3F5c2JtN1dBU2dZbHB5VWFDUHYrdHVlajBqOHll?=
 =?utf-8?B?VDZvaGxxc2RZTXo3aE1nVzd4aG5nTHpCZkJEdGVGRjBmQ2FNUFBqaGRmUnZw?=
 =?utf-8?B?dFJmM3lhSXBuZmZKWHFlQVFteVFWUjQrZ1VTQytkZlB5OXhmNmluRkhUTERq?=
 =?utf-8?B?ZmNYK2htektucFVoQTBaaDArNThocnY3NHJGamMxcTBYNDlxSVovRHVHcGp5?=
 =?utf-8?B?L2FmYW1qUGNrbDBZSGxDaVZjcVI5MHAvZ0lhbHo5bWFaWis2NVNOT3oyTkJ0?=
 =?utf-8?B?N3l0V0ZyOUxPeFFJN1YvVitZbkgzSnJRbzlEN2QwVkFrdWRLa09UMndYM0ti?=
 =?utf-8?B?bnRTdjBrWU91dGpuUUFMWTVwTXRqVmtTbzRzN2FZVURRR2lYbkFuQXFSZXc5?=
 =?utf-8?B?OVJJcWFCRTkvenJXSUlIMUttQmh1S3l2MUxaNGJRcjA2bFBHZU1vUmREYWxQ?=
 =?utf-8?B?akVKaTNHT3grUS94anhZT2lZT2lQMVE4R0xuYnBzeE1TNUd3TC9SdUxmRHVl?=
 =?utf-8?B?UUVHNHB4eGNCZmt5Z0UzM0JNZlVOb3FIenBlbytMWVFwcE56aHFUa3UyZys5?=
 =?utf-8?B?dnJYMldUQjhwMHBiRjZMNE5lNmR0eFNKejV5R2wyY0tLbGJoT2p2U1FUTERF?=
 =?utf-8?B?eGkvUnBGTDZSanFiTDFEdzRvUTViTFo1MHhzVXBhVlJEaEVBMUthZU0zTU9x?=
 =?utf-8?B?OTBiV21NL1p3NzJKUTRxbjBvcnR4d2NZSnFPemtiaGJObEZGUHh2SW5wNXl2?=
 =?utf-8?B?N2F1UkJpbGoyU1dISkh2T0V4aHVraWFYWjU5bmJUTHQ4dHdlVGNvelRlbGlj?=
 =?utf-8?B?OWlDWUdHNXBjaDBwbUNQdjVMN2xjY2d1VDJJM3JxMzlMaDNoQmVlTTN3NjBY?=
 =?utf-8?B?bmhsZWI3bVB6ajFDVGFFaVVpYVBySHU4RXErSUVydnFNMUlhVUk5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521edfea-f057-440d-34ce-08df3107a69e
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 13:15:04.1637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CAv6wCaaMw7JgFMcYxXp85tvE37qkIduBp8VmqYjnlyRSGbZtfHayMGKODNfWTUXzE/6sjADssOo25RlBZ/3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR12MB074433

On 21.10.26 07:19, jiabin deng wrote:
> Hi Dragos,
> 
> I applied your suggested change to `rq_end_pad_mode()` on the receiver
> and reran the standalone GPU-memory reproducer I sent previously. With
> MTU set to 1500, the single-direction test covered eight message
> sizes, with 50 transfers per size, for a total of 400 transfers.
> 
> All 400 transfers completed successfully. Full payload comparisons
> found zero failing cases, zero incorrect bytes, and zero corrupted
> intervals. The zero-prefix corruption observed in the earlier tests
> did not recur in this patched run.
> 
> Thank you for continuing to investigate this issue and for suggesting
> the fix. I also greatly appreciate the time and effort you and the
> other maintainers dedicate to the open-source community. As a student,
> I am excited to have the opportunity to contribute to the community
> and to learn from this process.
> 
Thank you for your good analysis and fast response!

> I would be happy to help prepare a formal patch with the test results.
> Would you prefer to submit the fix yourself, or would it be helpful
> for me to prepare and submit it based on your suggested change?
> 
I am still waiting for input from the HW folks to understand if this
change is needed for all SHAMPO cases or only specific P2P DMA
cases.

I think you should submit the fix as you did most of the work. Just
give me some time to check the above. I'll ping you hopefully next
week.

Thanks,
Dragos
