Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794571678;
	b=oM/kQXbh2WYiat3laZiiJ7ZQ9F0OUORzyz06TclACSif8xtZED2SGyiBVklytjfjf8bU
	 1Vba2QoGPyhrktYASGvusiGOaZKPhLkcXJdUzpkvaFiYz5FA1Uo3bl0YfJ1/sengQWloG
	 KbgZtDTjgXygul+M6DTkUH+O5tyQJj4xLuxLlmVi+PLXSw7l1bX7kcevJWOOhJyRTdZeQ
	 Wzj+HtU88z6KRQhWxMU2QKjvPhYz7en23Rz5Rcx7zabA4vo8owqQkvJ7EOj/dMTh8UNk5
	 jBGLBz0ETXyYBy2zMVqbiI67SglSoW1zS4kij0gxpmowuS/LDnHamZMCYvGZWjv7TAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571678;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=abw+vwiEvzO+ka5rKBnmI5Fey1tDDXMm29+EptfjvQw=;
	b=ERha8WWIoRTTsATYNFZi2nwWxpHYLhpHH/shtOVDlTkDVwoPSSbRtfqXH7hoGTLMc7Bc
	 RV+j6eHYB95qGK8keXnQiLndsHxG7lQAw44f2R3luGadqwxv3E9z1cuGedmMeOSfJtnty
	 afVz2MgKkMLUu0ksz7fRcThKp+8iKn4sZeMv6qJnSd+Lei6E5B2DmFqdKGQVS4hAQE48m
	 zd3gZQJnfIwe8jluaxPSUQfzOFMvEdBr8CQIRQrPYyMSzvMJkT1pqZV3Fn71jGh+joN53
	 VQV6cP3r5qs519GUBxxKYf4JQsqo1YrdTWkFO7COoG40eo/ZO9ivHcV/ssUmAhmRDDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ZyrEpTsj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.69
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010069.outbound.protection.outlook.com [52.101.229.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF63606A8C0;
	Fri, 13 Nov 2026 12:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF63606A8C0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ZyrEpTsj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5PuHLiAzItlHYw+Gf2yrftwG9ibhB0y2la9vA1X6U+wjxTkBlUvgNZU5y+pP1umkSpGtzvcIVP0MBdivfYF0IlOHZ3JEZh6GSp3w5Gx8Rwi5+06LV0rT3JWTHYjW09nZ8sM9rZh0FaFfSRPnFf2hfnpQQ8S1WO282vKmCELVHQYQlb++Gylaxelj4PajWyhKhIfsKhc9+u+QEII90RDjIWz6WJ2zCo0iol7FJe2CypnPmvrsxeaHh1CPdTjxOdHpATsppZ+HkwT+Ib+ELIRV3usOSftNxxbChxSRbiGJdTdDPfcCZtia6VTDdBsydMg171Fb+7VwCuZZ1JiEqJ/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abw+vwiEvzO+ka5rKBnmI5Fey1tDDXMm29+EptfjvQw=;
 b=g652HiZtizM1YP7SYfHZr3oJ0uX2KPSOFexJXvYW75p/exAS8FvWsXC9PtcOizdf+p78FhMnKhl2e4Zbt/u8gBhx9bKUpkNJNUnrCyuNm/RHX2TiopadC3p43wXXXOi8Mur61p9T5Ux2QouWew+0yVxKhNCYSWAyiCT/877TDrfKEAnpIgOjv9rbrkCOktEk7lSODOA1Dy6l1Wh7AQA/JX1irjQaG23lI3tWXy6uxifMxym5aDjmqieCiRIbiL3tTnAbwZg/D2qaCSsST6LFOzKFdlNq6VmqNlXR0x44mEYKFjSB4Ss780GvEEKjN5Au2ac4bAdiDNVePqVkzfzTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abw+vwiEvzO+ka5rKBnmI5Fey1tDDXMm29+EptfjvQw=;
 b=ZyrEpTsjHu4z6bh+1NczW3tJhqZEwJC649+uVR4TCY3PYMvyn/7absHz5xzLI9bVtV0KPCN+/QoO9M8GLP+iG1YAR0U+AFzAwsMRkoQip6pqdu+RjM3HcyseBRNAHeEmJXnE9YGXMx+3y1fXHdXaY4J5uLxDuUtnkkDEAdVs9xY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TYCPR01MB9371.jpnprd01.prod.outlook.com
 (2603:1096:400:197::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:07:53 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:07:53 +0000
Date: Fri, 13 Nov 2026 13:07:33 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: dinghui1111 <dinghui1111@163.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, dinghui@lixiang.com,
	xiasanbo@lixiang.com, yangchen11@lixiang.com,
	liuxuanjun@lixiang.com, biju.das.jz@bp.renesas.com,
	tomm.merciai@gmail.com
Subject: Re: Re: [PATCH net v6 0/4] net: stmmac: fix RX descriptors and XSK
 TX on resume
Message-ID: <avb8awzz2GctuiiQ@tom-desktop>
References: <cover.1794311618.git.dinghui@lixiang.com>
 <avXreY2EBUuQ2gpU@tom-desktop>
 <49f3c430.2255.1a1d2c0f857.Coremail.dinghui1111@163.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49f3c430.2255.1a1d2c0f857.Coremail.dinghui1111@163.com>
X-ClientProxiedBy: AS4P192CA0013.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::18) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
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
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TYCPR01MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a4d3fb-7476-4881-0111-08df417ebee6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|23010399003|366016|22082099003|18002099003|6133799003|261009223027099003|261009221227099003|3023799007|56012099006|11063799006|4143699003|261102123227099003|261026140227099003|261026121527099003|261021135927099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|261021123027099003|38350700014|260925022911599003|260925021911599003|260925021311599003|10067099003;
X-Microsoft-Antispam-Message-Info:
	x/lCbe/9MYKsqtOmDBA2BCeR8DXRDwKJ84UvfJmt5hKWJJFLKqGC7q2eM+4zqN8sTYqjFKIMpKs5lJOrqJLDceeSX48KwvMusRC1S1aAvZ5+qxDsPJLVVVamQc5J4LEfrvlXkj59XRrmEX5DwRlcjGVTe/PZ1FaRtf0iHK2rSKH29dr+x6d6c4F2jt/JIsIhyYiin3XIq+jVImHdprWkTCmJ+e38y+69AeQM8aKvpS9rGEBQDVahbFlT4sViYIIhCGzY9eoPkjr8AvFD6FRombhbmos1sJDfTQMZtiZjp+13wBdBvodUoADW9r8njR5zylRHHrpNI1JK+8QtLqUmB10f8/Mz/IscxbuobK0NU/+pOUxz1p/j8ZIR23FruhZGPaZWYcQ1srvIa36JWo7Xw5iXydLBOZV/AYKYySJ9ptgjaFi4KUlmHl8hhD7g9GhKBdtn8cB4mhvwFkjw8Dz8IRyVWSXjyc1FQUr2/mRTvU3maJsB5eJvWwE9IYBi3ufpe/SsJrnZk912G647NXfsrtMNf2zc5G5BlzmWzmWempAafHoDblHsx9/JvbkqM8joZ+e4XJ1VYZ9QHXKnzxnoNSH0ZNtRekvagViCzRDmZFmINrfptX5AKddml3rzw/6u5TP81mz1N9kFxskOWfdpkrYvb8uLYqXj3CZyZDj8zPc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(261009221227099003)(3023799007)(56012099006)(11063799006)(4143699003)(261102123227099003)(261026140227099003)(261026121527099003)(261021135927099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261021123027099003)(38350700014)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1BwczR0RU50MnVsWUpBSElqZkRaeU1iS0hYem4yWEVxdjlzdnVCeE9HZHpI?=
 =?utf-8?B?OTVvbC9TOWFGZW1KcTMzQTREa3JTcE55cDBreUc5TExXRWhMMTdxczREVUxQ?=
 =?utf-8?B?dUMwYUYrNjRwSzZvSHMzNGFwRkVFMFRtSWRiZHVob1lUTFp4R3VvV1BSNkFK?=
 =?utf-8?B?RVQ0aVRuU3NNb0ZtZVMrQ3ZsZVJKbU8yMzZYS1JLTlNpc2cxMnlOSndFeExN?=
 =?utf-8?B?OThsU0J1M2lYOHZEdENqa2UzUngzY0xLYksraG1pNGU1K2F2VmNaMFFoekFt?=
 =?utf-8?B?dzBDNWZmUW9nbmJpMGxsV0FramYvMFlsaWdqM2hWQWVlb0FOOVZ6QVNJZ2px?=
 =?utf-8?B?dmhnM0ZMQUl3NFdjR0RPa1VXcmd3UlFPRGt0c0lhUUJGRjhFaFJRbjlKSVVx?=
 =?utf-8?B?Q2IwZkRLMzFub0NnK0FHcHpEL3VMOGNZaHhsQVY3Wkg4d3RYL3dzRVhiWDk0?=
 =?utf-8?B?NGtHZmNqZU9nb2JZMkVFL3hiRy9iYXVpYWpmRHM0VXZuUExSSW55UTNicFY3?=
 =?utf-8?B?QWRxdjVPNXpyYzJHR1pqVFlmUkhETkU2YzM1S3NiUzljRGZ5QUdKMWcwSnVn?=
 =?utf-8?B?NzRiaEJmcU5tNkkxSkJodDY4dHI5RnZaR1N5Mm9DUVUrQXpWRk1NWDF3WXp1?=
 =?utf-8?B?U1lqcGNqdFFxYjZpek1rbUNDdzJvcGQrZHVmd3dlemJkVU43NEJXSThpcXNM?=
 =?utf-8?B?TjFjMTB1MFB5aDlQVDRUdHIwWTM3U2YwQzd4b0VScXJtMHErZ2NVSnBDTS9S?=
 =?utf-8?B?ZlJBQllOZXpSbC92RkdyWXBUb0M5OFRjVTRZM1R4S0FPTXAzWjlTQUdUSmwy?=
 =?utf-8?B?MEtiQjBJYXI0ZGVNZ1JBblF6ZkIwQVdqRng4YW1hMERGUUNEd0JDSCtrNGNE?=
 =?utf-8?B?dFFweGVyei9lQitCY2E3ZEF3b1ozTjBqc3Fwenp4ay9QUEFiNmFZVTBMRkUy?=
 =?utf-8?B?Sm9FV000L3JZekhRZm1DcnA3Uyt4QlkvMk9RdkN0amNwVXhpU0g3UjF2WHpx?=
 =?utf-8?B?d3VUTGIyL1ZrY256MnhFcXNuV3A0eXZZVzZmRXI1YmhhRFpieExoYnVjMmIx?=
 =?utf-8?B?dCt2QWNDYlNKMHlGa2FlOW85WWxZMzNPZmsvL1BYdDNYZTg4UjRyK2VnWFhR?=
 =?utf-8?B?bU1sNFZwcTFWTXRGZjNuQXN2TXhHcGsvR3Z0UUk2c1NQbXJBak5FYzdqY2NU?=
 =?utf-8?B?UkVUb0xpaCtRSW9UNmllYVJYcDh5NlptZWZNSWJ1OUszSy9UMkp4NGRUNVFB?=
 =?utf-8?B?bnJVWUU4K2ZDdjA1YkxaWG40K0R1VEEvNDFxQTZJaWxBeVNrRWI5dUR1UVE5?=
 =?utf-8?B?TU41TUJ3TmloamNYb29sNllDSmxaNDFkck1GM3VPUS9BTlJ4eVRqb09Cd1VR?=
 =?utf-8?B?YzVENkJHaDNwcnJ1cDkvbkdPOUF2Q0FiUnlLR3RHY0xGellPZUpHUWQ2VkZN?=
 =?utf-8?B?NDFxcEk4WWl1eWc5SEFXWURPRHBaazhkeVVkVTNrVVlYSFNFK2xWd1BOdEk3?=
 =?utf-8?B?cWl2M1plNnBlQVp4UjN1b002d2JCNVNtaVdTQ3BiY1JDSHNTNW9JNXBBUzdw?=
 =?utf-8?B?ZVVoWDdhMzNwYnMrMG5RbENnU0gwQXlJWGtjaFpyamFlaHpFR2JwalY3bHJJ?=
 =?utf-8?B?SlZ5cG5kL3cxNy9mN1JnaERRUWpkNURQWTB6SXBraDRQOTlXVDhvV2M3SS9B?=
 =?utf-8?B?cjNxd3ppUFF2NGN1MmRkT3dJRnZxeTM4OVE1QklMRHRManZ4a2lPWDRYamZZ?=
 =?utf-8?B?ZUhNWHpNZjFRWVFVR1QycXlTSTd1cFNyMEJ4SThLWlJQUjlma1RnVkRZNVNB?=
 =?utf-8?B?VEFWTytrYmJ2RXcyR25mT2lZTmVHdlFKR3czYWNRZk45cDJwZHN4VmRiZkFE?=
 =?utf-8?B?Z2owT0FNbm15aXIrV0tLOWxJRlRBUnJlSXhIa1FmakxUSWxxU0taUmNDdUtW?=
 =?utf-8?B?OGNEVkZ2aGQ1OHVyNlFjcnJSNGd4NVR4K3BneTE0NVNvZWV4Unk2VnFWcEFu?=
 =?utf-8?B?Y3Y3TWNGUnVSS1hlVjdWVUVBanlyK2ZnTkdWY2tjUmJPS3Q4TFcwQ2JKM2E2?=
 =?utf-8?B?THJiVThBdXcwdmgxQ3VRcnRKSzFXK3NpaExISUZkMHJmMlIza0o4amt1Nldr?=
 =?utf-8?B?elhwUExOTURpNWpHRXRHUnVBS1dqUXBTK1JCY0U5eUlITlZCNzkwd00zS0Z5?=
 =?utf-8?B?a2FmNTdITUVMV0RhWEcyVXBzUU9lekx4blA3VUMySXhCUVdiUFgxeTlrdDlk?=
 =?utf-8?B?YlBod0NYcXJSLytrNEFyVzgzakNIYzM4Nkp4ZmlKUER3Z05acXZWdzZzMmlr?=
 =?utf-8?B?eE5ia0VHd1k4RHlrS1ZJdTY5dWU2V0pEQyt5Nk9XTjkvUmFwUDd1dGJGZGU0?=
 =?utf-8?Q?HbChx4MJ35A+DhIqShDVLt1cMdEEzu2VY4D3O?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a4d3fb-7476-4881-0111-08df417ebee6
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:07:53.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsQ84dri4E2XMs6nOOvI3rruXkgH6NpPI1GOogRBzHRzM2CWKjVbdS4YhUKF8d3jdVAh/GoI2L7N2jDWy2c4G8wdVAO0a6hlAit+4mO4aHpge4oh10g14gSFwJLTnR6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9371

Hi Ding Hui,
Thanks for your comments.

On Fri, Nov 13, 2026 at 10:33:44AM +0800, dinghui1111 wrote:
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2026-11-13 00:38:17, "Tommaso Merciai" <tommaso.merciai.xr@bp.renesas.com> wrote:
> >Hi Ding Hui,
> >Thanks for your series.
> >
> >On Tue, Nov 10, 2026 at 08:38:51PM +0800, Ding Hui wrote:
> >> From: Ding Hui <dinghui@lixiang.com>
> >> 
> >> This series restores RX descriptor addresses overwritten by hardware
> >> writeback between disabling NAPI and stopping RX DMA during suspend. It
> >> also fixes an AF_XDP TX-only resume stall found while testing the series.
> >> 
> >> Patch 1 honors RX allocation flags. Patch 2 keeps unfilled XSK slots
> >> CPU-owned and tracks pending refills explicitly, including an empty ring
> >> and short refills. Patch 3 restores RX addresses from retained buffers,
> >> rebuilds chain pointers and initializes descriptor control fields. It
> >> publishes a contiguous XSK prefix and recomputes the tail and pending
> >> region. Patch 4 restores the bound XSK TX pool after TX buffer cleanup;
> >> otherwise zero-copy transmission can stop after resume.
> >> 
> >> The earlier commit 9c63faaa931e ("net: stmmac: re-init rx buffers when mac
> >> resume back") was reverted by 00423969d806 after a Jetson TX2 suspend/resume
> >> regression. This series retains existing buffers and DMA mappings instead
> >> of recycling and reallocating every buffer. Jetson TX2 has not been tested.
> >> 
> >> Hardware validation used backports on our XGMAC platform with a vendor
> >> kernel based on Linux 6.12.41, not these upstream commits as-is:
> >> - Receiving iperf traffic from a PC while suspending and resuming caused a
> >>   fatal bus error after resume in almost every run without the RX fix.
> >>   The same test no longer showed that failure with the fix.
> >
> >
> >I'm testing this series on the Renesas RZ/G3E.
> >On my setup I'm receiving iperf traffic from a PC while suspending and
> >resuming (s2idle):
> >
> >[ 46.745703] renesas-gbeth 15c30000.ethernet end0: Link is Up - 100Mbps/Full - flow control rx/tx
> >
> >Before this patch I'm seeing (during resume phase):
> >
> >[ 73.919151] rzv2h-icu: BUS error k=1 status=0x00000040
> >
> >Which I don't see anymore applying your series.
> >But after some suspend/resume cycle I'm seeing the following:
> >
> >[  262.878939] PM: suspend entry (s2idle)
> >[  262.883075] Filesystems sync: 0.000 seconds
> >[  262.888229] Freezing user space processes
> >[  262.894080] Freezing user space processes completed (elapsed 0.001 seconds)
> >[  262.901046] OOM killer disabled.
> >[  262.904275] Freezing remaining freezable tasks
> >[  262.910033] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> >[  262.974153] renesas-gbeth 15c30000.ethernet end0: Link is Down
> >[  263.183095] SError Interrupt on CPU3, code 0x00000000be000011 -- SError
> >[  263.183154] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Tainted: G   M                7.4.0-rc2-00101-g8c75c70989f1 #6 PREEMPT(full)
> >[  263.183204] Tainted: [M]=MACHINE_CHECK
> >[  263.183217] Hardware name: Renesas SMARC EVK version 2 based on r9a09g047e57 (DT)
> >[  263.183235] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >[  263.183271] pc : stmmac_tx_timer_arm+0x60/0xa4
> >[  263.183333] lr : stmmac_xmit+0xd4c/0x1650
> >[  263.183383] sp : ffff8000834435b0
> >[  263.183396] x29: ffff8000834435b0 x28: ffff0000c0298ac0 x27: ffff0000c1498ce0
> >[  263.183454] x26: 0000000000000001 x25: 00000000000021c0 x24: 0000000000000001
> >[  263.183501] x23: ffff0000c0298cc0 x22: 0000000000000280 x21: 000000000000010e
> >[  263.183549] x20: 0000000000001388 x19: ffff0000c0299648 x18: ffff0000ff7e01bc
> >[  263.183597] x17: 00000000000a03c8 x16: 003fffffffffffff x15: c15e9f4d40b0ba44
> >[  263.183644] x14: ffff800080c377c4 x13: f39e923bc472b73f x12: fbdb674df0d86e0f
> >[  263.183692] x11: 5a679e689a9836bb x10: 0ca385496fded8a0 x9 : 00000000200005ea
> >[  263.183739] x8 : 0000000000030000 x7 : 000000000000010f x6 : ffff800080c39340
> >[  263.183786] x5 : ffff0000c0298cc0 x4 : 0000000000000000 x3 : 00000000000013c0
> >[  263.183831] x2 : ffff0000c029ad00 x1 : ffff0000c029ab00 x0 : 000000000000203b
> >[  263.183885] Kernel panic - not syncing: Asynchronous SError Interrupt
> >[  263.183912] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Tainted: G   M                7.4.0-rc2-00101-g8c75c70989f1 #6 PREEMPT(full)
> >[  263.183961] Tainted: [M]=MACHINE_CHECK
> >[  263.183973] Hardware name: Renesas SMARC EVK version 2 based on r9a09g047e57 (DT)
> >[  263.183990] Call trace:
> >[  263.184003]  show_stack+0x18/0x24 (C)
> >[  263.184048]  dump_stack_lvl+0x34/0x8c
> >[  263.184103]  dump_stack+0x18/0x24
> >[  263.184153]  vpanic+0x380/0x3ac
> >[  263.184204]  nmi_panic+0xf0/0x108
> >[  263.184252]  arm64_serror_panic+0x70/0x80
> >[  263.184294]  arm64_is_fatal_ras_serror+0x3c/0xac
> >[  263.184336]  do_serror+0x5c/0x70
> >[  263.184374]  el1h_64_error_handler+0x34/0x54
> >[  263.184433]  el1h_64_error+0x78/0x7c
> >[  263.184472]  stmmac_tx_timer_arm+0x60/0xa4 (P)
> >[  263.184526]  stmmac_xmit+0xd4c/0x1650
> >[  263.184580]  dev_hard_start_xmit+0x8c/0x104
> >[  263.184622]  sch_direct_xmit+0x8c/0x35c
> >[  263.184668]  __dev_queue_xmit+0x808/0xf2c
> >[  263.184706]  ip_finish_output2+0x458/0x5ac
> >[  263.184749]  __ip_finish_output+0x1dc/0x26c
> >[  263.184789]  ip_finish_output+0x34/0x148
> >[  263.184828]  ip_output+0x70/0x114
> >[  263.184866]  __ip_queue_xmit+0x164/0x410
> >[  263.184906]  ip_queue_xmit+0x14/0x20
> >[  263.184945]  __tcp_transmit_skb+0x548/0xe30
> >[  263.184993]  __tcp_retransmit_skb.part.0+0x2a4/0x950
> >[  263.185041]  tcp_retransmit_skb+0x50/0x104
> >[  263.185086]  tcp_retransmit_timer+0x430/0xb68
> >[  263.185135]  tcp_write_timer_handler+0x180/0x1f0
> >[  263.185185]  tcp_write_timer+0x130/0x17c
> >[  263.185232]  call_timer_fn.isra.0+0x24/0x80
> >[  263.185278]  __run_timers+0x228/0x270
> >[  263.185319]  timer_expire_remote+0x50/0x68
> >[  263.185365]  tmigr_handle_remote_up+0x1b4/0x280
> >[  263.185408]  __walk_groups_from+0x3c/0x9c
> >[  263.185449]  tmigr_handle_remote+0xd8/0xf8
> >[  263.185492]  run_timer_softirq+0xec/0xfc
> >[  263.185535]  handle_softirqs+0x128/0x2b4
> >[  263.185577]  __do_softirq+0x14/0x20
> >[  263.185614]  ____do_softirq+0x10/0x1c
> >[  263.185656]  call_on_irq_stack+0x30/0x48
> >[  263.185698]  do_softirq_own_stack+0x1c/0x28
> >[  263.185742]  __irq_exit_rcu+0xf0/0x11c
> >[  263.185782]  irq_exit_rcu+0x10/0x1c
> >[  263.185821]  el1_interrupt+0x40/0x60
> >[  263.185873]  el1h_64_irq_handler+0x18/0x24
> >[  263.185928]  el1h_64_irq+0x78/0x7c
> >[  263.185965]  default_idle_call+0x28/0x44 (P)
> >[  263.186008]  do_idle+0x240/0x2f0
> >[  263.186051]  cpu_startup_entry+0x34/0x3c
> >[  263.186093]  secondary_start_kernel+0x13c/0x15c
> >[  263.186148]  __secondary_switched+0xc0/0xc4
> >[  263.186203] SMP: stopping secondary CPUs
> >[  263.186233] Kernel Offset: disabled
> >[  263.186243] CPU features: 0x0,40000000,00400028,01180a02,0800e21b
> >[  263.186269] Memory Limit: none
> >[  263.544217] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
> 
> >
> Yes, I think this is another defect in the `stmmac` driver related to the suspend/resume process.
> I discovered it a few months ago and implemented a fix for it on our platform.
> 
> 
> The race occurs because stmmac_suspend() stops the network TX queues before disabling NAPI,
> while TX completion processing can wake those queues again.
> The current suspend sequence is:
>   netif_device_detach(ndev);
>   stmmac_disable_all_queues(priv);
>   /* Cancel timers, stop DMA, and suspend the hardware. */
> netif_device_detach() clears the device’s __LINK_STATE_PRESENT bit and stops all TX queues by setting __QUEUE_STATE_DRV_XOFF.
> However, TX NAPI may still be running at this point. In stmmac_tx_clean(), if a TX queue is stopped and enough descriptors are
> available, the driver calls netif_tx_wake_queue(). This clears __QUEUE_STATE_DRV_XOFF without checking whether the device has
> been detached or is being suspended。
> The following interleaving is therefore possible:
>   Suspend path                         TX NAPI / networking stack
>   ------------                         --------------------------
>   netif_device_detach()
>     Stop all TX queues
>                                        stmmac_tx_clean()
>                                          Wake a stopped TX queue
>   stmmac_disable_all_queues()
>     Disable NAPI
>   Stop DMA and suspend the hardware
>                                        A timer triggers an outgoing packet
>                                        sch_direct_xmit()
>                                          Observe an unstopped TX queue
>                                          Call stmmac_xmit()
>                                        Access unavailable MAC/DMA registers
>                                        Potential asynchronous SError
> 
> 
> For the normal skb transmit path, both conditions must therefore be established before shutting down the hardware:
> TX NAPI can no longer wake the queues.
> All TX queues are stopped, and any in-flight stmmac_xmit() calls have completed.
> 
> 
> 
> 
> >Which I was able to fix with:
> >
> >--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >@@ -8606,6 +8606,9 @@ int stmmac_suspend(struct device *dev)
> >
> >        stmmac_disable_all_queues(priv);
> >
> >+       /* NAPI may have woken a TX queue after netif_device_detach() */
> >+       netif_tx_disable(ndev);
> >+
> >        for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
> >                hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> >
> >This issue IMHO looks similar to the one fixed by
> >commit 7e87508b5c4d ("net: bcmgenet: stop Tx NAPI before disabling the queues").
> >
> >Are you getting the same? What do you think?
> >Thanks in advance.
> >
> I previously resolved this by swapping the order of the calls to `netif_device_detach` and `stmmac_disable_all_queues`.
> However, there is still a separate synchronization gap: stopping a TX queue does not wait for an already-running stmmac_xmit()
> to finish. Reordering the calls so that NAPI is disabled before netif_device_detach() prevents NAPI from reopening the queues,
> but a concurrent transmitter may have already passed the queue-state check and entered the driver. Suspend can then proceed
> toward hardware shutdown while that transmitter is still accessing the device.
> So, I believe the perfect solution would be the modification you’ve proposed. Could you please submit your changes?

Thanks for sharing.
Can you please rebase your series on top of latest net-next/main and send
another version? In this way I will send my patch on top of your work.

This could be a valid plan for you?
Thanks in advance.

Kind regards,
Tommaso

> 
> >Kind regards,
> >Tommaso
> >
> >> - Native XDP/AF_XDP zero-copy RX continued after two suspend/resume cycles
> >>   with the receive socket kept open.
> >> - Zero-copy TX-only, with no RX fill buffers, is tested ok after one suspend/resume
> >>   cycle, with no fatal bus error.
> >> - Pausing the receive application with SIGSTOP and resuming it with SIGCONT
> >>   recovered RX without recreating the socket.
> >> - xdpsock is used for native XDP testing.
> >> 
> >> Additional testing would be welcome for RX sockets initially supplied with
> >> 0/1/8/15 fill buffers, replenishment in batches below 16, and those states
> >> across suspend/resume. These differ from TX-only with no RX fill buffers.
> >> Legacy descriptor cores, GMAC4, chain mode, timestamp-specific descriptor
> >> paths, multiple XSK queues and long suspend/resume runs remain untested.
> >> 
> >> Missing page_pool buffers are still allocated during resume. Allocation
> >> failure returns -ENOMEM without restarting DMA and leaves the device
> >> detached. This adds a trigger for existing resume error-recovery problems;
> >> full close/open recovery, including NAPI and platform power handling, is
> >> separate work. The Medium-severity AI review on failure recovery is not
> >> fully resolved by this revision.
> >> 
> >> Changes in v6:
> >> - Add a separate fix to restore the bound XSK TX pool after resume cleanup,
> >>   addressing TX-only stalls found during XGMAC validation.
> >> - Factor resume descriptor work into one TX queue loop and one RX loop,
> >>   following Thomas's review, and use common error cleanup.
> >> - Restore addresses and chain pointers before initializing RX control fields,
> >>   preserving legacy fields and RIWT/IOC policy without a separate OWN loop.
> >> - Add format-specific RX ownership clearing for unfilled XSK descriptors.
> >> - Track pending XSK refills independently of circular index equality; retry
> >>   short refills and prevent consumption of unfilled descriptors.
> >> - Restore a populated XSK prefix and retain later attached buffers for refill;
> >>   recompute the allocation count, initial tail and pending region.
> >> - Select XSK buffer size independently of the initial allocation count.
> >> - Discard any partially assembled RX frame before resetting the RX ring after resume.
> >> 
> >> Link to v5:
> >> https://lore.kernel.org/netdev/20261025100636.613670-1-dinghui1111@163.com/
> >> 
> >> Changes in v5:
> >> - Target net and add Fixes tags to both patches.
> >> - Split the allocation-flags fix into a separate patch, with a Fixes tag
> >>   identifying the page_pool conversion that stopped honoring the flags.
> >> - Share page_pool and XSK buffer preparation with the RX refill paths.
> >> - Allocate missing secondary pages even when the primary page exists,
> >>   using the current baseline's buffer2 capability check.
> >> - Condense the reinitialization kernel-doc to two paragraphs.
> >> - Restore descriptor addresses before the final dma_wmb()/OWN pass.
> >> - Clarify that unavailable XSK slots remain CPU-owned and may stop DMA
> >>   with RBU, rather than claiming that hardware skips them.
> >> - Power down legacy SerDes if RX descriptor restoration fails.
> >> 
> >> Link to v4:
> >> https://lore.kernel.org/netdev/20260627122533.1165324-1-dinghui1111@163.com/
> >> 
> >> Changes in v4:
> >> - Document the return value of stmmac_reinit_rx_descriptors().
> >> 
> >> Link to v3:
> >> https://lore.kernel.org/netdev/20260604144557.3175399-1-dinghui1111@163.com/
> >> 
> >> Changes in v3:
> >> - Allocate missing page_pool buffers with GFP_KERNEL and abort resume
> >>   on allocation failure.
> >> - Try to allocate missing XSK buffers and clear descriptors when the
> >>   fill ring cannot supply a buffer.
> >> - Restore OWN after programming addresses and rebuilding chain pointers.
> >> - Honor the flags argument of stmmac_init_rx_buffers().
> >> - Restore RX descriptors after stmmac_clear_descriptors().
> >> 
> >> Link to v2:
> >> https://lore.kernel.org/netdev/20260526022620.501229-1-dinghui1111@163.com/
> >> 
> >> Changes in v2:
> >> - Introduce a helper to restore addresses from existing RX buffers.
> >> - Update the commit message.
> >> 
> >> Link to v1:
> >> https://lore.kernel.org/netdev/20260515053856.2310369-1-dinghui1111@163.com/
> >> 
> >> Ding Hui (4):
> >>   net: stmmac: honor allocation flags when initializing RX buffers
> >>   net: stmmac: track unfilled XSK RX descriptors explicitly
> >>   net: stmmac: restore RX descriptor buffer addresses on resume
> >>   net: stmmac: restore the XSK TX pool on resume
> >> 
> >>  .../ethernet/stmicro/stmmac/dwmac4_descs.c    |   6 +
> >>  .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |   6 +
> >>  .../net/ethernet/stmicro/stmmac/enh_desc.c    |   6 +
> >>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   3 +
> >>  .../net/ethernet/stmicro/stmmac/norm_desc.c   |   6 +
> >>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 +
> >>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 277 +++++++++++++-----
> >>  7 files changed, 228 insertions(+), 78 deletions(-)
> >> 
> >> 
> >> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
> >> -- 
> >> 2.34.1
> >> 
