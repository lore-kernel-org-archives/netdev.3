Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020095.outbound.protection.outlook.com [52.101.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1E345D5D2;
	Tue,  1 Sep 2026 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247692; cv=fail; b=MsvRQE0vro9RlQWp6CoOAFHCPXYoNNvz7yLMURmMKCyu+jjTaZ61AcP6o32jlSBFoWpnicuh2MlCCnnev8nsCqLl2+bb4dG6ATl5k6R+Nf+6R3f6+tzwjQgCRmOcG5bzWJc1cxRf1mC8E0NxYA/+1vDBgDDJxabbrXprzmbu/Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247692; c=relaxed/simple;
	bh=0t7DaziZncJ21Vl96jkoE7bw2Lmcr0UCA0V3jQHU6Us=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rLUOE7M/Tda8zacKi7WokjeXsR5+La3iA+i9R5qqerWQu1FnGAO+6PRTFv78glTSF49s8o5tHbXd2dGOUlDHsdXyaQGiQ5uBU7vwUNMEGbtQ2vqn4CucnkOwRYJeS7dZir+akHHxG+ZwnSdo9pNX2CI7JmN/6J5PImxaHpf6fds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=zmK6KOy5; arc=fail smtp.client-ip=52.101.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="zmK6KOy5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9UYx4OqceM7D4c9DYeDMBaLemYlJV6k5msvtoQO6n7oyg1KoRAC0Ux21ADwsjxUjCVAJl+8lb54lLhOXJNIgesIwYTqukAS2kTGdXeBGvt9grcnca0R1eJuZxpSpo/Rz1ZaAFBwJs/xgOYOjZVe5r/3Nwc/4aasMCm6UOMfo6/su3kmxFJySl+L9b7s+N92YK+wJ0As7V56vPujaVopqB2Gu44y1dKaaQCCjrO/uTlRBBWF4gsWlJTRP4Pi8nz5mgJy+1oHsXP22SRsSm8x+hIc0N/KEO0YpzR3O02zp00rivwaQNxs1j1Cqn9S3d9Jmn91mQ+Nhd9JPY6bs+eR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t7DaziZncJ21Vl96jkoE7bw2Lmcr0UCA0V3jQHU6Us=;
 b=di35pFLpL0bxpPqKhGES/MCb9/nWXgoq3cV+CCUSBgKPaSm0nEc2rnxuIehqdwCRjpz/Liu9wVbwicjMQVmOo5HXc+lcc9MkznZVedAxv7K6c4N4k0S+EMYTYMd7zlRAvfouRWjcZ3oLT0caVKl8cZgMyGGpKpFybJx3/THgNQoyG0opU10NN/vE6rZIX5k0mqoNMXLUPEeA857/rMQ0SpFXPc19onFGr431UNVqWqne0T0trs7J6n1jLoJ5a1HxdlrL9ycY2cUtj9PJow5iio7GF/jIb8+vV739BUvnfeybmQ7WTelxS79bXeSJak8b78UlbZDruK3MEVnNyKjbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t7DaziZncJ21Vl96jkoE7bw2Lmcr0UCA0V3jQHU6Us=;
 b=zmK6KOy5Fw7gc6pc7FtSR8jZCXtT2ppYYKyq5ra4dYo1LVPaLM/jsUSTC/sJViSlPSvT/JmIdO4YqyYWmEtsRYVXBj0rllZ3w7FS6A8PvnvNbZL4uAgA10WUSV9l0f0FfvAy4mJU22LsfG2vvG3xHEn+CQJqpPfVJdNwftGU1IMKBMzJ3qKXr7Kemu78URdxYnyvsIULo7dpQMgC2sHwAIGO3UkyXKWNTH5Sz6DUUhfCmgGoSj6S5Gklzu3dzP3Iyc76wacK0LKXF0p9DyWC4WjJndhvJXKTjF1giXpSvGX7VWdCCmWl+QhBhRyxcQJHRGSgE+obnj+2uSNoX7p7zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DB9PR06MB8092.eurprd06.prod.outlook.com (2603:10a6:10:291::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 07:27:59 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:27:59 +0000
Message-ID: <e2feeb88-8e4d-4b00-93db-2305a59b77ce@vaisala.com>
Date: Tue, 1 Sep 2026 10:27:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: dsa: microchip: enable the SGMII port of
 the KSZ9897S
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tristram Ha <tristram.ha@microchip.com>, Nicolai Buchwitz <nb@tipi-net.de>,
 Jerry Ray <Jerry.Ray@microchip.com>
References: <20260831-ksz9897-sgmii-port-v3-1-2376aa4edf11@vaisala.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20260831-ksz9897-sgmii-port-v3-1-2376aa4edf11@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0008.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:12::13) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|DB9PR06MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1072fe86-1dec-4256-f516-08df07fa8cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	zsTzAwJdQUPY7o1COU2ZiGcLbkFXqZ+QTw+21N3ZtERL8jvxX5zndxBjUswBVBytCo4DTyDrYEviy0VUqTX6/obfQKUOJg6e9v1hDFI3YyysIvW8vIz1gSZmSdTbo465/FmBpyWHUWIVFFNaUbDqdY95KJjreqFf3vueG08WDtN58IXlJDjkBUaMZF4PsHV1gFSonKbd5bp6dKl9/Hbp3koi7C8YmczS9E4MtBEzqkTuraHfx5Y4NhuM08tMgIhzklxJM1xQ8g7fxQR97KRD+sCcqhuBz9/hWsatg9fGz9we4uHdQtvMyuOm00FtrjpJVGpnrLhNaEgxeihEtNZRmDg8WY2a8yZ4JdqdBulOFWPDXrzwdPODBh7M7+eM5Y8lQ9IauHg/Y1JQDNpXmVlj6YyNxA9pHKBh8qdzRIjzi+LQFcoVL9BSFoYEaeqAS/XiWyMSeqgJ33ii51fXmMcUxZ9JniPfTrRsBm3RMZPhFzBzizFk1xfH1Mr7rQPZiQKiMc9um9tZFPwIZCzPvtFh8hJ7x1H6peE9JR3GOWCUFpW7L/vISip1n7TaPrQ8unMMm2Zl9dVk28Xj8Jr5tvpS6bv8P+y2lsrx4pEM6WMsfJ/2Z6jYJ4pX0myUdvN4YZx7Dgxld/8c1trFs17kI47OkHJ1P094uxccyfV5d6Gp3ys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHJ6YXFhWmN4c21acjByNDZ5YVlxR2Z2WmVOS1kyT09PalZZd20vYkFuOXEx?=
 =?utf-8?B?ZTAvMmlHdmtsWnZlRURYUjd1WWNlc3BXUUpkQ2dScEdtdkFMMis3dmhSRHhp?=
 =?utf-8?B?dHpQaVBSL3kzdGEyR3RFdVQ0Kzg4bHNJZWJGb1BBMnVuU2ZvTWN6dUNVWmY3?=
 =?utf-8?B?UVVjbVFZblNpdmJhTU1OMHpXSWtQSFRXcUpKM3RxV3hPOEVUaE1pQUF6clNx?=
 =?utf-8?B?N214U0VkdTBac0JpaDVUUUJpRklick5UZjhqUTRaUjZNb0dpc3pVLzN5ZDJv?=
 =?utf-8?B?NXJxQ0pVMnlQY3YycHo4bUVmRzFNUXdpQnRKYUxVYlVoZzQxdWMxVjdFNm1s?=
 =?utf-8?B?SUdDSVFBRkkxZEsweENOZ3daMkhIWkNHYjUzRlZIS3VIZGpjMklwNVZiblp1?=
 =?utf-8?B?T1ZaR1RibDBVN0lNNTVoUHh1bkZiWHN4Ym5BWGNCTUc4VDM3V3AxeE45WGZU?=
 =?utf-8?B?RlZPTjR5M3pmRUtHd0pMTTZ6QkltelMvMnlEb0ljRDBmbWFzb3lXMHd3ZEF0?=
 =?utf-8?B?cnA0bnc3MStTRms3NFByZ2xVQWpuWlU4VmxLcVpPaG1HNHJJOU83M0VHS0hw?=
 =?utf-8?B?L2Rnc0JBMldLZnk1S3JoSmpuNVoxcWk0UDN1YVE3eE1nUHQxSHlkY1EwN0tw?=
 =?utf-8?B?eThNQ3Zxb1Y3eDJ3UXZkTStOSWY4MktnS3ZkNnUxekpnUnhSRTg4UzdpN2Yr?=
 =?utf-8?B?Tzh3SkU3eit5ajhqUjh5dEorQWxFZFNqaERIOEplYit2M2hGOTh3eHVkaUNT?=
 =?utf-8?B?QTRHbEtyTTBxd1B0YnIzWlhKT05obnd4RG8rYlVQcVRKWGhDZFk5dzQ1d0VD?=
 =?utf-8?B?cFpYREZoQVc5M2F6TFdKcHpBUlFHK05TNnl0dkJicm5nWmRjdUQ0RnZaRVpl?=
 =?utf-8?B?Y1REWjZRdUZiWDdaYmlTTXNyWE9sNlBveDNNWEk0MURudERJZ3czRkJjamtj?=
 =?utf-8?B?blhuVmx2TnFwYlV1aFJXUWNHNm0xK0lsRnIxRHBTRk8xT24ySDR0M1p5eHpL?=
 =?utf-8?B?NUo0NlV3eTh2V2VQZEFrbWhMd3VOek9xc3Y0L0V2V0xaKzZYeEJ0S2piU0Rt?=
 =?utf-8?B?NCswMmpnak1ZUG5wNDFvRllJeUd1NG96NjdNTVFyZEdzcnowRnd1VTJMTUpt?=
 =?utf-8?B?cTFCZDU1aFNGeXRia2I2OFhUYTA1Q2xHakZJTTR2K0tMMFR4eEkxcmVkb3Y5?=
 =?utf-8?B?UlRYNzFpaVFDODJnT0IybnB1YmpTeUVxU2Z6SEM4S1hqM0I5TXh5RmZTUTc1?=
 =?utf-8?B?OWxKQXFOOWNXL2RIR3FFdXEzYS9WbFo5aGkya1hpU3FLb0xkeDlGUWhoTGg2?=
 =?utf-8?B?ZHpYRTk1c2s0SDRxVkJxOVBrSlBnalBpbXd0MXF2ejVrRi9hbzlTMmpnRjlO?=
 =?utf-8?B?ckI2Z1plVVNuSURCektoUnhDREI4UEpWQUFpdGtxdHc0MGloempoNldHdFNI?=
 =?utf-8?B?S0FsN2pDcHhLV1RHSmhFd1BwQjV1Z0pSM2FCYlVibWZMa0p4VFlsNEQ5VTly?=
 =?utf-8?B?VTIwZGJQaVkxT1NzUkdaYkNUajRUdUNqazNOMnQ0Um5sVGZCN2VNY2tIUWpR?=
 =?utf-8?B?QVFJeFB6WWRyVklNK21XU3NmVEE1NXlRN1VEUVVpNzY2VDE2cmtRdmtod1ZE?=
 =?utf-8?B?RVRoMkNjZHE2dEdqeGxCTXFRbHROQ1hFeXozK29GOXJITU5pVm1pTGxaazM4?=
 =?utf-8?B?NEJjTU0vNmUrZnhKN1F1Z2RmNmkzV09iWHduWWVWclNDT2lHK0dKdmw5NUVD?=
 =?utf-8?B?NjNkN0N5eEU4VTd3YjliYWZMcTIvR2pmeUgwdFlIOFEydmVIV2YwUlYxTXhB?=
 =?utf-8?B?RUZEQ01CVVNUa2ZHWWVKcDZNRS9CZkNPczg2ZVlQTXdNd3F3Rlc1WDl3azBY?=
 =?utf-8?B?VG1pdTdoSWhES25KNTQ2ZHV3emJWaEtUU2hkYi9RYVJIcjIxYzQ3RmIyTVcw?=
 =?utf-8?B?eFdSQjI4Zlc5bGFQT09CZXZ5YzhTb0JwQU1EcXNMQUNTQnNpRnJ4dks3M0FE?=
 =?utf-8?B?eGdMcmpmOVlldGJPakpqZWJLOW9JNWplSmtlWmlZaXVqZHJwekZNS1NsUnRw?=
 =?utf-8?B?amtwSDNlek5aN3hWOXZnbmpHWEdLcnZCOEsxUE8vODRCcWVROGVzdlRFM3JP?=
 =?utf-8?B?ZVdCZUpvOW9RNldINjViWEE5LzJ5cThXUXhpS1huajdwOE5oWEw1eVVvaTE3?=
 =?utf-8?B?dlNTcmtkV3pZc0xWeGlYVjI0anh3TmxaaHZoVFRmMzExMm4zdllJVFRYNTdk?=
 =?utf-8?B?NXpBRlVWV1BYR1pqdUgzUUJUT0Z0MDdkYVZORS93cXVZQnFuYkdqU1RhWVla?=
 =?utf-8?B?eTR4QnRqbVV0UEsrcklVbHhwZjVqOUlmdUg1K0pTbzU0RXZvN0FJQ2Nsanlm?=
 =?utf-8?Q?c8qm2Y/rESNWQ8Ic=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1072fe86-1dec-4256-f516-08df07fa8cab
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:27:59.4080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raNxRLmZVifZDod1cWkakfjf1jMhtgDo9ozdzMpSXJV2uCKYuEdSsephEL2wldEGhaP4tRklklnTPKsy0KV44bPocvFZI70N4FUEpeQA5Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8092



On 8/31/26 08:10, Tapio Reijonen wrote:
> The variants do differ in the read-only bit 7 of the port 7 XMII control
> 0 register, which reads one on the KSZ9897S and zero on the KSZ9897R.

Microchip support have now confirmed this with their internal team:
register 0x7300 reads 0xF8 on the KSZ9897S and 0x78 on the KSZ9897R.
The two values differ in bit 7 only, which is the bit this patch tests.

That closes the one gap in my testing. I have no KSZ9897R sample, so the
"this does not break the R" half was reasoned from the two data sheets
and the driver code; it is now confirmed by the vendor.

Tapio
