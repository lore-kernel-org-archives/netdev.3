Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794321940;
	b=eNBsdjex6TCN3WPkh413/1nsD29cKzus6vXSXJD19wtXsxotuWeX4A4PwS8quXfOH4wi
	 YFqffgbl5JJx8FE5W9rUtgRBA9iS9g7Y2GiZDEAiubxNa/0C8JjWfduuT01RNNzp19HGi
	 OGZV6R2ERKy657pyJbD7K888Hsab7pKrIWLCqlC4wZLX2dDnEQReFtgxS6YK19j6RXnon
	 hjlidmRDiyjSkiXKwDqxHsKx/fQgT0/U43IchBTSnBCuj/GDWrsgT7mQ5Dw5aDRW5uwcg
	 9a4ig5ZAESy696bgEpaPuaRYLkTLxakyFmNqu5kxQaER80kXvHHOqQh219oS+l0mN/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321940;
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
	bh=KwhHN6og26iZpiNRf8PcnS79OR7OdPoX1f5BXPzAn+w=;
	b=iAlbRJomIuI3SiWsrMuK00RabA06i5VyFR1Ht+ubEAkKZDOmtPaijzQJWyGr4iARS/xF
	 mmq5e/7F3acpW8X8c5YoTEOj4lfYdgerwqmej495vKLd1Sjlc7gp2qXq2ElBfUP/tT11R
	 +ahqy8ucwaiR6V0WwHiUeM+WEgvv+wBpyB7m39VBc8K8W63+4rlEgVtbQwchMkQ9KpnMb
	 PwUMtUbrHd5LcyTtNkCn0MS3HZFCjh9BUYfjpGgGEHKBOGvYpdGMthr/4HAmdvvXvtx2O
	 p3bba5J1eehObuOHpqIaalx0Jp7JjpgDWJVEb+EWs0wCfl9M34oa0S6DmrztEQimVDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=U+xoK84B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.37
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6260A2619
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27B6260A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=U+xoK84B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbOO+eW0H6KjeIgjDaqc+5CUKcAgOTDRpqXDpd8fTNR9GF3D6XuBHDfiGe47plXn6e/K4K0uE5xUvBLLhlc4fmRbUUN2bX27x7owwxdOGtRgJzv8fv+Wx/qXa6Q3bvL1m+a77S2SZ+FWXe7Zp35d+KIIrBsmzE4gvWo1kRTWdST3k2bxEVkpMrKlL6WFN/gwK0/IQ3xfszlbKeQdh2scbalp5sRC+hTgkDLq2h12KGoIgdQv3PxhC841G3Y/0VOO14cjOKKSTU2RBpL7U0Wn1jfc/6sC0pKxreORZfIYr2YvUMgkL3IPTVe4DZvp2wt8egzjXZ/+2Yr6+NCwZq84Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwhHN6og26iZpiNRf8PcnS79OR7OdPoX1f5BXPzAn+w=;
 b=R32BAKXDW3cbgoJMvVwRnHaNpQglyiwk9ipCWuV+LCL9jucPkaJd6c9tg8N9x+mw1RgFJG/7+6gQIcEa4KEtekyRPvNh9aGtlDpdcqhX01IHg8pkMciwwCnOGHKXTRboEaBDlNEuzrGhWDDs5dNx7pn7mlZcrLeotM7jkVxyurPeBpbaHOzPKhU/IJgeAVMOfJIhrgNYIWsF2bGrRbHxsP3l7PxGmnnDJh+E+FX1cHIFW95G3fOdkF/CulGXAbs+uyTRDvZc9tdIhj9dWcoT4okIvlXn++Zp6iiR/XWRVJ3vjv5xpE0Crk6GjX8qWE6GASKjlCXODGv6ZbfyiKMyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwhHN6og26iZpiNRf8PcnS79OR7OdPoX1f5BXPzAn+w=;
 b=U+xoK84BafN32upO5rdSjbDodlD9PDkuP/Wv7TwveA0Usqmgk1a+6HQoAwzmfWqALRvk1E1xDJp7GPshLWGDTOzdJ0oe4BO0Aiih+zFcnk3GuiHPMvTj/D+5QJkOLi4DswMSee50IHZ2xHngtqQfYX0/ki0CZOMb5eusUtvYs5PYbIKphAN4/9pqSJbzq9HnkG3QdQ0QIpGnVLmSnwSwxIN+uJYeIN64D1Bb+IuljUeLEdg9i8ZgvG0MoxIxUj5H9o5i79BHAyfjOkLbZnsw+OczExFHYtJAhilBb6btr+hkQlZyG5y1+1Ue/h+BnxjtpsOfsXL2mTN4EA2/Z4sMww==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15) by PH7PR12MB6719.namprd12.prod.outlook.com
 (2603:10b6:510:1b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:45:35 +0000
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f]) by IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f%5]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 14:45:35 +0000
Message-ID: <4271b227-a36d-4856-a297-b1fa678eb187@nvidia.com>
Date: Tue, 10 Nov 2026 16:45:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Question: net/mlx5e kTLS TX TIS reuse vs in-flight WQEs
To: Rishikesh Jethwani <rjethwani@everpuredata.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Boris Pismenny <borisp@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org
References: <20261022181751.1349984-1-rjethwani@purestorage.com>
 <fc0da060-5bf5-4289-8814-d25e6c422673@nvidia.com>
 <CAKaoeS1hj9XuM7ojLBCjGA=EXc2M-b+eRjC2Sk=8L_8XYeJ18w@mail.gmail.com>
 <4796023b-10ae-4172-afa8-9c7541844314@nvidia.com>
 <CAKaoeS3hDE5q7XGtPy4XKmGL54-+7Y-H9JyMcdz94FiQW2_ffw@mail.gmail.com>
 <9a8e3e1a-977a-4e48-ba9a-2b71700f6924@nvidia.com>
 <CAKaoeS2YkHyrLHwbF0SAE7UtmhknmKEy+16VedDNLt5AMwthZg@mail.gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <CAKaoeS2YkHyrLHwbF0SAE7UtmhknmKEy+16VedDNLt5AMwthZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1PEPF000008C6.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::428) To IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15)
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
X-MS-TrafficTypeDiagnostic: IA4PR12MB932075:EE_|PH7PR12MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a772db6-fa02-4233-9e19-08df3f394716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|56012099006|22082099003|18002099003|11063799006|10067099003|261026140227099003|261026121527099003|261021123027099003|261022105027099003|261022113327099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	+RMr8zcsBIvY3+saY95b+TNCr8Q2q5HRQ7bEWO1czwBrJZ28kq/g1VqUwxjY4rXlUfeUDzjvyr2yxuOLhd7bBZiprmyhqWAdKL6ebvYEorYnNOQ7LWiaxWSonQ7APoYOEeVclcISwAxhxgBho1XRxY81tjanAQwh0MO7MYl9/IPInSr6XzKwNLhIesi31++Jry1SRAEjwgzT2I2v/auFhwriotIn49nUzzWNY0ClSWIg5hxDPrBxEKw/NJLs4AJofEWA3Sbq28ropvNBsthdDyPeIXqDcgWqtYhtZYnRN8WDj2lk81IQMtGnxt49zBBISZAN2ON6On5Q2QcspAt0s31mzLZq1GD61ehxlW4tQ4Z6SmKRzCpvZNnXuLeIWeJs2uBlaB8XdsVmKYWcx84y6pkBfDwTgyGBOqfd+vnIou0YP5WUoDK7LuDaKC62HbMiC8ek82XZ1xDoFmfXOt9WGw25Gd+pl9kBKXT5WW+U50lpWi9PmUFWS08Lv17iVNwzAXK5hOmV/cy6JNkl7vZpCHFKIPQ5d/RGrPc3Xagl1aAfXl/Z4n1WWKXOo2lEuv/I6oBvoI6dQrii5sMfapvUnFbS6Nd9uEZMeZmt6uN7mUmYWpI4A7hSHVd4pLAMwsctBrdfix1qWUzvVd6aPFkTBtCZJ/fCJ+QKfhR48JY2P5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB932075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(22082099003)(18002099003)(11063799006)(10067099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022105027099003)(261022113327099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnhVVHhVd0hHOFpoOS9wclVyUkYreWFxRFJVRXQzRDdxdnIvSFJiUEVGQkY3?=
 =?utf-8?B?SXNHWjdwNHdkdEI4OWV3SG9mQnRNblZUamcxTjkvOVlHUThIK3JwZURubFBm?=
 =?utf-8?B?T0N2aHU2YXJob1kyTkQ1NEZCRDJTZUg5OGFkMm9YQWpRUmM2YTR2UHU3ZnNu?=
 =?utf-8?B?UkZMUVlyT2phd01kU2dLWW9uQnJZMDdCcHMvbFplWXZnUFAxTzFabGJGUU5j?=
 =?utf-8?B?SEJoVXg0VWxxaW5kZmlxZ21BcXVIbDJCbGRuZWpPejVrd0hEMDBsZHFwdytC?=
 =?utf-8?B?UjFMenl6NWVCMWZ3WGhrUDNBSFJRRmpVOXB0dFR5Q1l3MlhhbVhncW41OUdv?=
 =?utf-8?B?akxsOHE0QmZWb2Y2OEtvdEp3Sm5Cb0hoSnd3NWtBRTVIaVZUS1gyUFkzc0VW?=
 =?utf-8?B?WjRLQlIvVytzMHpxUnNWMVRPVFNxMkVSQlF6TFoyMlRaTFZ4VHRmaDFwaURi?=
 =?utf-8?B?UXgyYzhYQzVqUW5LQ0VCUVRoMFNrSmg2dUdER3pxNVc3M2Z2ZWdBMWlxSFR3?=
 =?utf-8?B?MTlkQ2V6VTkrc0NLUnpJRVNQenEwRTVWQXBMQXlTeGEzenQ1RnJyc2JnaExT?=
 =?utf-8?B?c2Q4Ymh6Qk5EM1l3U1JWdnRVVURMeUFteHNGSndJQWFrZ3Z1OEhZU0JGelNv?=
 =?utf-8?B?OUl0VGtieWxmdlFaV0xycERiT090K21GbTB5QjJlL2tySm9QT0crUmZHcmV5?=
 =?utf-8?B?RE1rT1hJTWZaMVRTcC9BR1UzeS92KzJzdStTQnorZHhVc2FLRTJmWTF4bkxz?=
 =?utf-8?B?U1AxUmtLN2NnWXlOcVptdmE1bjQ3Y0Fta2ZhdkJSY0pCVTZzQjg5T05vQWNV?=
 =?utf-8?B?VEt4ZlIwTU5FWkx1TnlTL3BVS05CUjlmdTFGdFpmNUh1S3hKUDhqbjA5RUZ6?=
 =?utf-8?B?WGJwUGc4VzFDT2ZpY2VGaFg4MzdURjJReWJ5YnU4VUFzcThGWGY2dWdzaGYv?=
 =?utf-8?B?dlhqK2E0NllRV014aUF3SG51Y3d6eFNYbjBjVGh1cWhsMU1SYWRxeThyd1Zr?=
 =?utf-8?B?bVd2MUlQMDRxeFJXbFczNEsyYzRrK1c0Z1lNdDBYR2tXdVNrckRIeDJaZ0d3?=
 =?utf-8?B?NU9VamNIamsvQUUxdXNUU2tvSldTTmRYVDhBdGZ6U1E3ME4yVFZxRHphODJq?=
 =?utf-8?B?TWp4WGpLMGhKb04vY1BHOHcvSVFIdFBmSXY0OGlWK3lQYjRPeFhvenFOeG9a?=
 =?utf-8?B?VUFORkdUN3VneFJFUW1IT1ZTcmQySGFYa3hsT1RYSkpNcXBzK1lvVjViRkVE?=
 =?utf-8?B?dVgyeS90RVkvT0lnN2t2TWY1ZFBVcFpTZE5TWlZiMGFpNzVzQzRnQ2hnQnEw?=
 =?utf-8?B?dElQby9TK0xVclgrQkZYWmVjVGJWL1ErcjBQRWhoQzZPdjJlbnR4UVpmSFZx?=
 =?utf-8?B?aXpSNzZMSjhyb1BCeUwzOUJZNWhvTTd0c3VXeVJtNWFrbjI5emJxdkdoZlcx?=
 =?utf-8?B?MGpxNHZRVkJLYW9TMzIwV3VyYWo0SktKTWJ0b01ab1RzTFFUc3g1VnQzZjQx?=
 =?utf-8?B?Ni85RUdCbVY3eFBDWVdFWGVXeHViK3JqZjlnaEczS1g1QTJpNG5wUnc2czBR?=
 =?utf-8?B?UFpWWm5sTU1RdjcvZDNZNjd5NUUvRXVwK1M0SmhmUlovTmp4OThLWXZBMWhs?=
 =?utf-8?B?NVhqai9ENjBhdWl2enBGdktaUmR5MFhHNlZMcURSaG82UHAxWjlyek1sdmta?=
 =?utf-8?B?dlZpVjRvbFlzOHdXOVFBcWhBZjVQWjgxVE55UlBmdGhqeEpCWWNMOE5teGkr?=
 =?utf-8?B?WGdtVEtrV3ozNWRxa3F5bTVRZEJZZDA1S3J5RG5PNFdRbDJ4M2JTSzZVQkpa?=
 =?utf-8?B?NXBzWDB5WFdiMzBuK202WmtaODUwakplUmlSVjdaUlVjdFNUT25sZmRJYzht?=
 =?utf-8?B?emhzcVlXRFpCeFcvekMwZmpkQ2JUUnVWMGtZYUdMcEFSOVQzYXArUU9wRm50?=
 =?utf-8?B?NElIckJqVHY4VlJRQlBCRmRaSURKajVoOHVWZmF3RFRUZFBraG5VT0J3L0Vz?=
 =?utf-8?B?L2NNREFmM3MzN2pFQUdIVnlmVlRGS0FremIwVE9tT0ZPKy9uQkZJUDRlR3Jh?=
 =?utf-8?B?SjBjWFBtd2FPM2RFQW14UmllaXpJTk1WQndOVTBXaVEzOG9uT2NQNjlRbS9u?=
 =?utf-8?B?YXFvV3BnZzFyVDQzNmlTa3B3TjQxU3JoaDY5ZEwxck9tdTRVNTJsZDhqVk1N?=
 =?utf-8?B?SmNlVFZIK29vYzZ0TlNDcHRkMmw0WHIzdmk3cDNLSmV3L0h2Z2tyU0NpcUNz?=
 =?utf-8?B?ODhzbnN6WktrVUZCODhMMXZxTTAzOVk1dysxYjdOZnV4OFdkcFUwc3luT2Rl?=
 =?utf-8?Q?8QKKTdw9o0kMvkLgYR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a772db6-fa02-4233-9e19-08df3f394716
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB932075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:45:34.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pNIFNO5EZFVakn+gkLeyYuiqkZElbPPugUNnHZmglfjWeMoDX8DzGmkKxCZGdrNqNDVaDyZUYct1tQZMo3vxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6719


On 10/11/2026 1:21, Rishikesh Jethwani wrote:
 > Thanks. I've now reviewed the seven-patch RFC [1]. The held-skb,
 > full-resync and pass-through changes cover the points I raised. I've
 > replied on patches 7 and 4 with two remaining holes in the one-SQ
 > guarantee: the selection-time ownership transfer, and the PTP SQs in
 > the drain.

Thanks for the review. Agreed on both, replied there.

 > The DEK question is still open: once all old-key WQEs have retired, may
 > the old DEK be destroyed or returned for reuse while an idle TIS still
 > names it? This needs to cover both standalone DEKs and pooled IDs reused
 > by another connection. A flushed replacement need not have installed
 > the new key, and deletion can return the still-bound TIS to its pool.
 > The resync fix restores the context on its next use, but does not by
 > itself establish that releasing the old DEK before then is safe.
 >
 > Please keep that HW/FW answer explicit. Until it is settled, I cannot
 > treat a flush/close alone as sufficient to release a still-named DEK;
 > the conservative alternative is to retain the possible bindings until
 > a successful replacement or TIS destruction, including through pooling.

Double checking. Will update.

 > Agreed. I'll replace v18's live TX del+add with the new callback and
 > implement mlx5e_ktls_rekey_tx() on the revised fixes.

Sounds good.

 > The delayed decrypted-clone case remains a separate core follow-up.

[...]

 > I'll Cc you when I post it.

Thanks, please do.

 > I do need patch 7, with the selection-time fix from my reply to it, as
 > a rekey dependency. Patches 1-6 alone do not cover egress skbedit or a
 > cached queue overwritten by another device on the route. A fenced
 > replacement on SQ B cannot order itself against old-key WQEs still on
 > SQ A. Keeping patch 7 in net-next is fine; I'll base rekey on it as
 > well as the net fixes.

Right, I missed those cases. Rekey depends on patch 7 too, and v2 of
the RFC will carry the selection-time fix.

Thanks,
Tariq
