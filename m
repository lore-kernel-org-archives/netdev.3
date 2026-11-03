Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717131;
	b=WsCkgtl007GyDqc5CydYwDf0FkvYgNGFxlsXaI8pFtFeqkt7vKCpyHpnwtjgdoXzUMIf
	 YwyjiovnrRxaUXD/j880yZQoArIeBA16M9ixAIi+BC7GhTLN+Z9UvMnwhV/bt4q04281/
	 PvsZWTDYOziRRiForKQ/AQ1F2/uPQ6FVbXAAeTJxYDo0VAIvKB8ZoHNKFzi/Q0b5N5Ekn
	 XwI/k2WDm146YSGGwtESCCrrPPLBzb6rgeciMBQ5r7KmEqv/GLs/u2cK4rcSqaU5KyHw3
	 zRlO2Pjf2nO43umlviGLaWdqvJKYPIOOdb9K1G5QgDsmCPtJJ+sjE6R8voMlnixqfCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717131;
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
	bh=YQYepSwU/cLvIj7VN9avFqZ/rm/JuU/f8/W3WMxlLNo=;
	b=TRewjwIIlq0fsf/FhHXhjnD3RvL3zC5Vft8tB7K7FXDgBvs7CwZTmSotGjmyZ8dYt6KU
	 M3gmFXSMHkFdxuqwJEsTuZylDGkakkGCGfeyU+X+M0UYeiMaRtFlkzN2hwzaP+8nR1CpK
	 b0grj/chsQJ1hvWcAjNWlwwBAGYFbbkJ9q3L2uKrcTYguX7WDqiZuPR3OGbN/xBpU4lSy
	 TG/blbZySCX1P6Res2CdITEJgC3wYotwzi83X8S9XwQx0EMKoZqxmXWap/b/XCjasb7SK
	 qtv7GXEJDya0FlGJJS5KWGHMVfvMI8rZcNkTEAqF8xZ8jfV17disESMMejlz4U+n8Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c3Qfgw7g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.13
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB3606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5DB3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c3Qfgw7g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1TU0ColR/Rrs2KwNCNTY8eOYrfRAeiAh1WMR0xcTJbH4WiH065hSr9N9AxrgVfynzIyRWaQLoYA//F9spUPnZGz8qCGB6G5paZgOXhGboLatfZ3dRRo1I0PwAQdyNbasHvwCPA75ewDzdsF6YK5USiXIyLO4yoT9UtchST1+Fc5Td48kA211m32ECtTZje6Y1CcRlRusA3oB0kO90dsY6VKmRF1zGpSyNkRtY4xHNJ1uSOuUK9W9Cu3BZej2ADEDK+MKdKbI+pYk79pwpMVdz4iT1+eQv4RQlOO9qAEajHDAjeJ9MPH8+JL03uQY5E+8EAdM1HkvZ+lPCwdcBZ+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQYepSwU/cLvIj7VN9avFqZ/rm/JuU/f8/W3WMxlLNo=;
 b=c8aDjzHxqK2QjmSu2G/edHRoQ5RRjhxoBpc+acMcsQYqpDcxg0wpy2XEDzYCrWOw/xJay4ktc6fmGqca4UNBwCa1UHpzSbBT8JrM//c3IfWiOEkaZbXuUst6gpC2wbty9FmNNPJP8fn73yPvDiaHAbh5x96erh9tL/YDyyCacNFk/VQn8NnFKQjG6XoDvzLh1Fzbl2w6DoEWXGN7Onwq+/uBBTOZsvSy+scUwTM+7dN7cuS90SwEnZi5JCii51JYLKOQhAkSDBC6bjwXOtxAR8VEmbT3uNZcges3ahj38R9r/j8idZe3UWh+9FUfOMBSyuouAyerS2V2fYNc7jXNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQYepSwU/cLvIj7VN9avFqZ/rm/JuU/f8/W3WMxlLNo=;
 b=c3Qfgw7gqV6f5XiA94F8BpdlNW02oTJXree0fEX+oYd79+gmHuVnexpIo690uhALkLh4PjWfgjTawGbyZ/kn9ITt07xSWlmn7vOGti1C3tCw6qamo10ed6I65DfuQz9M66u4I/dvVuEVHMkn5SXN1fz2+4e/vbudoP96bWW+w9t/RAbFGhs3kp8ZlM+7LNKwaHvRjrhRHQnrQolUQ/O2bQTAXN7skA0g83BzLbEORkGCrPiBRdg/94TBG2kOLouOo0xloi+EGeh9PTtNw26tYvC2We3D2QZFoEwpzUC8dMjhFRuzZKeAnUYFwTDxcCh8i2pK+YopwD287IIUYwJ5vA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 (2603:10b6:207:12d::15) by MW4PR12MB6681.namprd12.prod.outlook.com
 (2603:10b6:303:1e1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 14:45:27 +0000
Received: from IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f]) by IA4PR12MB932075.namprd12.prod.outlook.com
 ([fe80::5a6f:1f74:6ccb:cf2f%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 14:45:27 +0000
Message-ID: <fc0da060-5bf5-4289-8814-d25e6c422673@nvidia.com>
Date: Tue, 3 Nov 2026 16:45:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Question: net/mlx5e kTLS TX TIS reuse vs in-flight WQEs
To: Rishikesh Jethwani <rjethwani@purestorage.com>, tariqt@nvidia.com
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Boris Pismenny <borisp@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org
References: <20261022181751.1349984-1-rjethwani@purestorage.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20261022181751.1349984-1-rjethwani@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To IA4PR12MB932075.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA4PR12MB932075:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3147cf-dfb1-4092-04f9-08df39b919ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|5023799004|11063799006|22082099003|18002099003|261102123227099003|6133799003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	B6t76T+CkH/pH1DA0NY24eJcxgm4MHv5tYTK5Sey9dMArhnWbHZkN4D20v82tJvyjMq022C1NwDFPyp4t/mFD+Dh7vgbEFW2XM3KPBh4mgv7cyHDK8BLuAw21asM41xZl+fe36v3edwtHtHnTGo6k/z7uYaBXlZ82w2C9GxjcRE5lOKJcdUspIF6xAtZGwdwcWJZWON7I5x5Vvr5rbQbwHeCWtgoPUSNiuPdeTxtRAQoXSm8kqWE97RrFuQEW/LNMECKAMeD+Txhviae+O4E8bk6FjstwfyDu7RTV1Ci2DyqDZvHu2kjEsg0TOl8jytGWASBQentAA5DVX7f+C2AZhGeQswAtULzLrnspDESIr+TCiK0LI5KbFknwCBJhW1DGZL9lmxMEJ0nxaUaPiNgXWKRQmmgsFEMRvjERxf5Y4Cgg4D2nlXR9VcKCUIotZ0k1PFyTiXof6FUoNv6Zo8DC/vvGPB2SzrDKeT7ske+Y8mEmAxhsXC0CgJt4e5b+K5G4C3nIohV/Ix5TnrwwvSdHzdgX+WtzI0omoB2J3w0Klo2TgWZht7RU2p3EoeD0bT39fsA6QuosaTC08Tzu5t1yxSAwsadiC3ukKkWGBHQ2j9GStLl2RBP3gxKpY/1/k++IpAD/hDqy2oaFc4qegOCFxRlYeSFN2xy1A1WAJ/deF0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB932075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(5023799004)(11063799006)(22082099003)(18002099003)(261102123227099003)(6133799003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXNXWFZ0N1BSVjQwRXduekZFdkRLc0hsbzdHWDIraWloYUZucGlublNwVDUr?=
 =?utf-8?B?Z3FiMkdBdmx2U0ZpNTZoZytnWEIxelBScjczQyttM2xLS2k4R3NxNUNHOW5p?=
 =?utf-8?B?bmNPVWJxakpoK2c5VThOVUxCNEVaRThIWHAxYzNoSk8xZURSYUluYUtlT1g0?=
 =?utf-8?B?aWNRemlkQ2FETW5WKzA1djlNUWFIK0pvL2psbW9zbnhqSkdaNmVoT2hmL05K?=
 =?utf-8?B?SFpvdlN0dkRBSHorZXNjcWRtdzZ3eHowSkhCQmd0QkRvTlF3M2tXYngrNXc4?=
 =?utf-8?B?QnNOd1JGMGUvdldmekhWQ25LeTY0Z1BVL0x4L1JmU2VISzRsTFVtNTBkRlZQ?=
 =?utf-8?B?NWxJbm1Lcm4xekh1Ukc1K2tqekJLU1Y5TEhHMTUwQ3VaSjZxSExncDRiRGRI?=
 =?utf-8?B?L1dXTndWeEw5amV3d2d1cnh2ckRoSmN3R0NBbG1wVW41SDBrZE1ZdlpWeHBy?=
 =?utf-8?B?eloybEhzMVNpOWFmRzkwNmt0Y1h4bHo1YmdoUmxidUFPNnY4eXNGSUFNcWhw?=
 =?utf-8?B?Nk1JREI2YTFmUkVsWnRIcU9LQUdvd29EVDR2KzNFYzhUc0NEUTlGa3RLeVpO?=
 =?utf-8?B?cWdTTVhucmx5Nm40bkwrcjkvVzNGWXc0Y2M5Rm16SGMrZmFtQW8yZVpjWXlR?=
 =?utf-8?B?aE52R3o3QTBnWHhPekFNbk1PRWZsTzduOVk1WWpWQ0dzMmZnTUFybXkveDhW?=
 =?utf-8?B?cXlJSWJCR3ZhYVp6OENxNkVHRjFxQmliWkRsWTdNaSt3MHUyOVJDTXV4TWUz?=
 =?utf-8?B?ZE54SW1CWEZISjdBME9CbXc2RDdFSzM1NG1JU241MVYzYXdyM2FaS204UHVE?=
 =?utf-8?B?bCtiRFZBRWdQSFBWWlBheUFJdDdEUGFuTDVXVmFLMmxTbE5kL2NXMUVXRjlB?=
 =?utf-8?B?ZG01Rk5ZY05oNFVqYnRvdzYrOHpuKzlGUFc3WVZsYjNtSFgzWjhaZkliZVd3?=
 =?utf-8?B?U1FqekJVb1dnWTVCM1dqaVg5R0lQK2RlVFg3cW8wQ05YRFBJQ3JTajd3cENz?=
 =?utf-8?B?cW1tUWdRZTdwVGx6eXBsNWZ6aXJWTHUrK3hRTm94OGlZemswNUJIRDNjVTh5?=
 =?utf-8?B?Q1hBdnBqTUNWYzZXOFhGUnNvSkNxdmYyazFBR0V4UnNjL1BwWTNUbVUrTlhk?=
 =?utf-8?B?YnlORG0xdk9LN1FCTzhhUDBMQ2hrV1RwM3RlMlowaG9HR28vQTBDQjhRQzYx?=
 =?utf-8?B?V1B3M3Z5SFBZVVhKUTBXb0lDRmRtQjZ0eWNzRHlKNDhmR3E2cjRtOGR6eDNY?=
 =?utf-8?B?aFljM2Vselk2ZXduNG9xY08vRUhZUWVaN3JsYk0wZGI4Q25QbFZseUdOOTgy?=
 =?utf-8?B?QUx1OG8rdGtWa2c5dGl1dkFlVnpldFZZZFA5VGlQMGhkbDJuaTFneTFzL3Ri?=
 =?utf-8?B?N3JybkY0RkgrMlJsR0x4RTFQZ3VuMTRWbWh6SmU0TXI4MW95eHR2R2hSMUU4?=
 =?utf-8?B?YWt3MmRWVHVmMUt4dFNLcmJFekhmMHFiYXJhcElYcmZ3VXR0clJsYWgrWVhz?=
 =?utf-8?B?UjcrcUZaWWE5MzFqWjRTd01VdDQ3ZENEWUdHVjloTmI0QmpyVDRpN29wV0pR?=
 =?utf-8?B?VFBSS0ZoN25VSzQvRkxBMWlyNEFJYjFVdTJlZVNJaW91SGkxdXRGdGhTV0t0?=
 =?utf-8?B?eDZNeVlwMjFKaDZpMWhMZkVjN2Y1ZEc4MndBL2RTMmR1Ym9TRkFVZUp2YzFi?=
 =?utf-8?B?WDNCOEpFOVZISVhPaFhXUkxLb2tCbHU3L0tZaHNGaG5JSk1LK1dra3kyelMv?=
 =?utf-8?B?V0Z6OGNKMGhsVTRycG0wQTd4T2pBQ3RZTUZCVENZdWNUTEQ1bW1lSk1RT1U1?=
 =?utf-8?B?MmJYaGdwdnJlZk50WWRtVmdjYk9CQlVkYlNsUW5XNXZsSHc1eGh0bENxNkZ4?=
 =?utf-8?B?bkliaFpYcTFLYnRnSTBtMEQ1VzNhMWpldzBKRmRaQ0x1L1NnWU9QNG1uNTN1?=
 =?utf-8?B?ZGs5SlNCeThQM2pDSkVNRGxWYzBWVEp4ZDdtQ3MvVy9nc0dDYUZsL3hNWmI2?=
 =?utf-8?B?MDFuRHVJVGpLUmRMMXRkbE9UMXRpakxzcGVoTnNTMDBJWTB5OWdVMVF5RXIx?=
 =?utf-8?B?c3FhL3hGUWx4c0tDblJBUHBjTExuZWw5dEppT0ZDc3RIMTNUUDdTOE1wYitX?=
 =?utf-8?B?ellvQ05KOTRkVkhUaG9nY3d1bUFMSWFYcExSRHhxZlFFSzU0Y1QrbThYb0to?=
 =?utf-8?B?OG9xNXdLakpXWmZPRnowL0xna2sxQ0drVFd6Q2V2ODJ2a25LNFlsTlptZlMw?=
 =?utf-8?B?VmNaZ2R3L0htTFMxQ2RNckJ6NEVUMUd3TmdNd0NHZnV1K3NKU1B0dDJZTXVj?=
 =?utf-8?B?Smlpb05KT2RXV3hoWS9JYzBZVys3amQxQU9SWHFMTFlVVnZVRXVlUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3147cf-dfb1-4092-04f9-08df39b919ac
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB932075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:45:27.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRmq3GIdQxyYLWZrrFT7g3wI3IXTxDrRF2zGP4SPUTX9Nnd+tjEBr3uV7kJwDPP0DUGXqjHPFPMeHyQazad1jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681



On 22/10/2026 21:17, Rishikesh Jethwani wrote:
> Hi Tariq,
> 

Hi Rishikesh,

Good analysis, and thanks for the detailed write-up.

> Could a DUMP/SEND WQE from an old owner on SQ A read or update TIS
> state after SQ B has reinitialised that TIS for a new owner?
> 

Short answer: Yes, in principle it could, once del runs on a live socket 
as in your series. Today, only parameter/DUMP WQEs of a dropped skb can 
be left behind (item 1 below): a pending SEND holds sk_wmem_alloc, so 
the socket is not destructed before it completes.

The TIS is a function-global object, not bound to an SQ: a WQE that 
references its TISN reads/updates its state whenever that WQE executes, 
from whichever SQ it was posted on, and the hardware provides no 
cross-SQ ordering for such accesses. Details below, and at the end a 
proposal for the way forward, on which I'd appreciate your feedback.

> The existing TIS pool predates live rekey. My TLS 1.3 TX KeyUpdate
> series (v17 [1]; v18 in preparation) calls tls_dev_del() and then
> tls_dev_add() on a live socket, and the question arises through this
> sequence:
> 
>    1. A spurious RTO retransmit of old-key data is posted on SQ A.
>    2. While that data remains unacknowledged, setsockopt(TLS_TX) starts
>       rekey and installs the rekey validator, which stops admitting new
>       plaintext to hardware offload. An ACK covering all remaining
>       old-key data marks rekey ready before the driver observes the
>       retransmit's SQ completion. A subsequent sendmsg() enters rekey
>       completion.
>    3. Rekey completion calls synchronize_net(), which waits for CPU
>       transmit paths, not SQ completions, so a WQE on a stalled or
>       backlogged SQ A can still be pending. mlx5e_ktls_del_tx() then
>       releases the DEK and immediately calls pool_push(). DEK
>       reclamation uses batched SYNC_CRYPTO; returning the TIS does not
>       wait for synchronization covering its old DEK.
>    4. Before re-adding the offload, TLS allocates the new SW-fallback
>       AEAD. In that interval another connection's mlx5e_ktls_add_tx()
>       can pop the returned TIS and use it on SQ B. The same socket can
>       also reach SQ B on re-add: with the retransmit queue empty, TCP
>       sets ooo_okay even while the retransmitted skb still holds
>       sk_wmem_alloc, so queue selection may move the flow.
>       mlx5e_ktls_handle_tx_skb() posts the new owner's initial
>       parameters with skip_static_post=false, fence_first_post=false:
>       static parameters unfenced, progress parameters fenced, then a
>       fence NOP.
> 

Your reading of the driver is accurate on all points. In particular,
mlx5e_ktls_del_tx() returns the TIS to the pool with no completion
tracking. The same goes for the DEK: the batched SYNC_CRYPTO guards
against stale cached keys when a DEK object is reused, but nothing
waits for pending WQEs before that, and without bulk DEK support the
DEK is destroyed right away. So the DEK needs the same lifetime
guarantee as the TIS.

The same-socket exposure is also broader than the ooo_okay disjunct:
the RTO and PLB rehash paths reset the dst, which clears the cached
TX queue, and txq_reselection_ms lets a busy flow re-pick its queue
periodically, both regardless of ooo_okay. So one connection's WQEs
can be in flight on two SQs today, even without rekey.

> An unobserved completion does not by itself mean the WQE still accesses
> the TIS; that is the hardware ordering question. The same question
> applies on SQ A: resync fences its first parameter update, initial
> setup does not, and I do not know what either guarantees against
> earlier WQEs that reference the TIS.
> 

The fence modes in the WQE ctrl segment (FM field; the parameter WQEs
use Initiator_Small_Fence) are all defined in terms of previous WQEs
on the same SQ: a fenced WQE waits until earlier WQEs on that SQ are
no longer in execution. Even the strongest mode (Strong_Ordering)
orders only against previous WQEs of the same SQ. No fence mode, and
no other WQE-level primitive, orders against outstanding work on
another SQ.

So within one SQ, the fenced first parameter WQE of a resync does
guarantee that earlier WQEs referencing the TIS are done executing
before the context is modified. The unfenced static parameters of the
initial setup are safe only because, under the current lifetime
contract, the previous owner's WQEs are known to be complete by the
time the TIS leaves the pool. Across SQs, nothing is ordered.

> The normal close path has additional ordering. tls_dev_del() runs
> from work queued by tls_device_sk_destruct(), which itself runs from
> __sk_free(), i.e. only once sk_wmem_alloc reaches zero. For
> transmitted mlx5 skbs, SQ completion calls napi_consume_skb(), which
> invokes tcp_wfree() to release that accounting, and parameter and DUMP
> WQEs preceding a posted SEND on the same SQ are retired by that SEND's
> completion. For successful transmissions, this gives close-time
> ordering without an explicit drain in del_tx. WQEs posted without a
> subsequent SEND, and SQ error/reset paths, need separate lifetime
> guarantees. Live rekey does not wait for socket destruction.
> 

Correct, including the completion detail: parameter and DUMP WQEs do
not request CQEs of their own, so they are retired only when a later
CQE-generating WQE on the same SQ completes. And you have a point
about WQEs posted without a subsequent SEND: the error paths of
mlx5e_ktls_handle_tx_skb(), and a DMA mapping failure of the SEND
itself in mlx5e_sq_xmit_wqe(), drop the skb after parameter/DUMP WQEs
were posted for it. Its wmem is then released while those WQEs are
still pending. That is a narrow, pre-existing hole in the
destruct-time argument, independent of rekey. SQ error/reset is
covered: mlx5e_free_txqsq_descs() runs only once the SQ was moved out
of RDY, when the hardware is done with it.

> Was the recycling fence relying on this socket-lifetime ordering, or
> does it independently protect against outstanding work on another SQ?
> c4dfe704f53f ("net/mlx5e: kTLS, Recycle objects of device-offloaded
> TLS TX connections") says the fence ensures context modification does
> not interfere with existing traffic. Does that cover old SEND, DUMP
> and parameter WQEs on another SQ, including work the device has not
> yet executed?
> 

It relies on the socket-lifetime ordering. The fence in c4dfe704f53f
addresses the same-SQ pipelining: the new owner's data must not be
transmitted before the context update has completed, and the update
must not interfere with WQEs in execution on that SQ. It does not, and
cannot, cover WQEs pending on another SQ; those were assumed complete
by the destruct-time contract you describe, or stopped by the channel
teardown. Live rekey via del+add breaks that assumption.

> If reuse must wait, would retaining the TIS and DEK until all
> referencing work has completed or been definitively stopped suffice,
> including during SQ error/reset?
> 

Yes, that is the right condition: every WQE referencing the TIS (or
the DEK) has either completed - a CQE of a later WQE on the same SQ
retires it, as the completions of an SQ are in order - or its SQ was
moved out of RDY and its descriptors were reclaimed in
mlx5e_free_txqsq_descs(), which covers the error/recovery and
teardown paths.

As for how to get there, here is what I have in mind, in three parts.
Feedback is welcome on all of them, and in particular on the third,
as it affects your series.

1. Pre-existing, independent of rekey: the stranded WQEs above.
    Rather than adding completion tracking for the TIS, I'd restore the
    socket-lifetime contract in the driver: an skb dropped after WQEs
    were posted for it is not freed right away, but held by a NOP that
    requests a completion, so that the skb and its wmem are released
    only once all WQEs posted ahead of it are retired (or the SQ is
    reset). mlx5e_ktls_del_tx() stays as is. I intend to send this as a
    fix to net.

2. Pre-existing, and a dependency of rekey: TX queue stability. I'd
    like to address the queue moves above in the stack, opt-in: a
    driver whose TX offload keeps per-connection state updated by queue
    execution declares it with a tlsdev_ops flag, and for sockets
    offloaded to it, the TX queue is re-selected only once
    sk_wmem_alloc has drained. That is, ooo_okay keeps only its wmem
    condition, and while wmem is held, a dst reset does not clear the
    cached queue and txq_reselection_ms does not expire it. With (1), a
    drained wmem means that no work referencing the connection state is
    pending on any SQ. txhash rethink and PLB still fire, and their
    network-level repathing (e.g. the IPv6 flowlabel) is unaffected;
    only the local queue switch waits until the driver drains. Other
    drivers, and non-offloaded sockets, keep today's behavior.

3. Rekey. Releasing the TIS of a live connection to the pool, as
    del+add does, requires that no old-key work is still pending, which
    the driver cannot cheaply tell. I see two directions:

    a. Keep the TIS, and replace the key in place through a new tlsdev
       op (say, tls_dev_rekey()). With (2), the new parameters are
       posted on the same SQ as all old-key WQEs, fenced, so they take
       effect only after them, and the pool is not involved. The driver
       keeps the replaced key until it is no longer in use. For that,
       the op would be called only once all data sent with the current
       key was acknowledged, which, as I understand it, your rekey
       completion already waits for, and which is needed anyway, as the
       device cannot retransmit old-key data after the switch.

    b. Keep del+add, and have the TLS core call tls_dev_del() only once
       sk_wmem_alloc has drained. With (1), that guarantees no pending
       work references the TIS or the DEK. The cost is a potentially
       long wait on a backlogged or paused queue, during which new data
       is held back or sent in SW.

    Tracking SEND completions per connection in the driver would also
    work, but means per-packet accounting for a rare event.

    I lean towards (a). Would it fit your series, or do you see reasons
    to keep del+add?


> I have not reproduced a failure; the reuse is visible in the driver,
> but I have not established the hardware ordering guarantee. A PRM
> reference, or a statement of which completion must precede reuse,
> would settle it.
> 

Thanks,
Tariq

> Thanks,
> Rishikesh
> 
> [1] https://lore.kernel.org/netdev/20260917224355.2288021-1-rjethwani@purestorage.com/

