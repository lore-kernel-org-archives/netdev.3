Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794304032;
	b=CIDgP/90O5QBoZN/nrIWEsDxwl0OxNYLDjKAmhuKwW55rrFrn9dA3aBQtk/C8xS4g2SB
	 OUdWZ2KOFMqiz6jzDA2lAdn+CXyiI8fGgDooLYevpuz9T1IvtB9LEHRp4PSJKrXckPphx
	 86I9a7Q7e3Y439ahhRXt7XYcN7OFnQaTgrAPIQcm31M7ttx8VjTqmevuKJFct+pHxn+L+
	 3V6vyaiLcPapQlSO+LMbxTvjyZyg600nPsehH0ROII5qlEXsZsnlpdSYj6JdeW31N83Uk
	 0kXQ9O/dsA80zAdajWCO/4jQ6+VWYHIgXn+79bi1Hyc5juHyDfdqv/hI9nVG2ubM+bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304032;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zt/BHNH+I2yWBdX8GNHyVjOeeBEz6+8cpdVThS6XiFo=;
	b=gyclGRgS7ZgXkuoAQZEuVlTcDAoUUxPV7mMxK3x/pvauLX33ZCxkUyPmdW8DD+6CSnZD
	 9tDVr6t0RyAqqNyTm7X6M50r2XJ0J2TQtSS/4cyvbzbE07fwYejWtH2O3oOWxlxXbI1iZ
	 x3SiXK4BqZb+FG3cUHq6CC/QQtk1FbkrgC6gkXsuWAaGTHQ5OMpKlM0wTmAGU023+4WNR
	 +4nN7+05IyDehKUxdpf1CsIr0GeI63q7MegzgzErFq6vSY1CWtz/bPBif1s+a57qGiPW9
	 t2MibB9Ifvf7qU5fP9O1A0zm8XQoQsPQLnHdd/JPV5t1IHsFDlH+oXGs/fNvs6BgDoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=P6j+K4QV;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=aNzf5MoW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC15606A93B;
	Tue, 10 Nov 2026 09:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC15606A93B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=P6j+K4QV;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=aNzf5MoW
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7kdlx2247763;
	Tue, 10 Nov 2026 04:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=zt/BHNH+I2yWBdX8GNHyVjOeeBEz6+8cpdVThS6XiFo=; b=P6j+K4Q
	VOQVChLMHWF2G/1qpQWawo4tLQ4iGsCR3VyKqbczwL8HYvjyP1RvsHDNcwHH4Wlj
	Jse7T/y7McXkaEp55ABSBDFLcSkL+nNXv+lZ3GgbUK9YAYH2kgaoTwNIDHE+vMG9
	9VfgcVDIGAOgtiQpKE6b+K0gSUP7CNfxFZdVzcan0rGrFbPvQh5McJW4hey5v07W
	VBthBXv2cQyShHcdk5cuEXDyxMGUdWK527/HOnHViH1HBqPIlOCwbO6EYu9l+XJz
	bpD9nWH3JwnZ1tgIPwJye7gKmY/ccrz7zhwWxAuTIPexVBug4BSIFXpYUtFpaX1F
	xmYEOFB16Dn9bYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zt/BH
	NH+I2yWBdX8GNHyVjOeeBEz6+8cpdVThS6XiFo=; b=aNzf5MoW5Q+DWWXd7jwhj
	JS3AVd8C9TE18j04h4G6y0h/FTmZuGkWAfO4/X6LFCpSk0dicEbov1SO/bTeKHTi
	Oh31SBSIPsiYxShUZCGXxGfBP/AgXwD7MU6JDrv/vRo+dFPDToTKKAwYLTkYs6ZJ
	Z/d1OFqUJlDjIBUC6zeZ7LF8ZZJOURgsBUDstE3XRIXkim7VgsPUQT3B5hsUg6vr
	v8dkkHe9aGZvIXs9M+pRWXM1mjr8Tj5p87XQQNIF/GibR5R/75Sn9it3JLOcVuSr
	EZmp2hOC0dJIxD5sEaFAiNWCB2K5v/nhc4Ts+Yq7zyaT6oDdbueH6SScilI6Iavi
	w==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013060.outbound.protection.outlook.com [40.107.201.60])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4huwpuh7pm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 04:46:58 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3KVYMx4p3JDw7jKvs3lDBZuwxrr9HPbJ2mHqEskBUg9uNGcYEYSDQQVfQpq0WIWtGq8zHagTAr5Rplmn5ckQOeJxFe6l1mDDuZkT7dR2d6pxHsWLmM/ZfUkBqLfJVR2WQoUANqGPb4CZ7yQTW13SteVEVPMDMg55EhcOy6rshjiDwmffsvmQaFCSVxufp/AaWK6EQF9/ON0x3Luqa2I7M5kxjCp9qfR3qanaRRQYz6OkD1D9ozAJf3swZUXq6/BNQWENKcFun5gsUP8XHKG7Ac7cGGz7zuHFcGCDbaS66LJWrrxlxUej40pJJLLC6PfaqL0hfA2N8K8I3lA7Q5bFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt/BHNH+I2yWBdX8GNHyVjOeeBEz6+8cpdVThS6XiFo=;
 b=pxdXA72bUKSEpqyqVlXoxOw6sx5XCZ8ZKe//KmCkLvf03i34vAINSliJP3/9HcVGSAkl2D4+y16Pa7I30gUGnFNdtX963dajzHWZu1p8YhatFtvz1BI24gDaR+eqjdoS3fMAV+JfeA6DbIxurObbr1VbQsAj1AvvUy3giNhDHuN2nIYk3PKwL7/SimaS594RR0NDgdga2P+yMQcJQkOtRjhM/ofmb7weK1hIBa1VCw9DdVCnXK50f/ohMOgh9AqRSgIEGnkTH6sDGeeOCT59XtTUmlfgHHu4vGucaEd+KGe/6IoD4ByGk2Mhmn+UM6136Fe4y87ouTTxUd5bKxJ29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by PH0PR03MB6381.namprd03.prod.outlook.com (2603:10b6:510:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 09:46:54 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 09:46:54 +0000
Date: Tue, 10 Nov 2026 10:46:51 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Ciprian Regus <ciprian.regus@analog.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: phy: adin1100: Add separate driver
 entries for ADIN1110/ADIN2111
Message-ID: <avLn_px8NNonpMc-@analog.com>
References: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
 <20261109085952.105331-5-iustin.stolniceanu@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109085952.105331-5-iustin.stolniceanu@analog.com>
X-ClientProxiedBy: CPBP307CA0020.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:2::6)
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|PH0PR03MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 478a7a2a-8c9f-407c-ef59-08df3f0f8dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003|10067099003|261102123227099003|261021135927099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	IaL/yofsSgznv0glTYjtiAkFClDnZow4z4eHNltg6kkziaAAjXFl3slFTy7HOx1S80gJR8PoRyg0WQIlJ+ACPaMBANAnXvtLDTOISEF3BeCgksZ9fz082C46WUBSCh88XF9AD23MAOmIKZWsBviBUjoSX08S6yqLmYwzywmxEGFVA0ul7Mi6AfeRHnLdP0kvBs8l8N9tOqe1lKTMK5jiCgt8gGH2qZk/B6BnNaEIXkJKERLK2cLrgQp4FXpNf/3wcnz+6ZeLOMF28wrwNWfKqXyVrQBBRELr1U1ZJhtmsjngk2HbuesyhOz86nDbO9H91Jy4/RW+XlrIvXp3oKXv3zLmBFxlzVBsTFhL/hfayOrXLzBJbPISR3YPNoJ/8PSd9VcmBiCYoN1yao5AtfhhpK7ViOs5OK3JF7+53z5g/DKGN2IYvvPKCJ62C5PNbc780qd15uAEAUcM5at0pJMnauK5sG9wj7veGnX5gxcGarLEuwpsgFfUph3Uo0cuRwp8BqUTrhfFyjp7sggsQni2zlUe09xX9CX4E+5EBUsTzL+7+amFXNMUyEtXPNsBOy3fe12O/aJ08zs2dhtkehtQkeBG1yAPuUnDjxxNMLTnaW+qHW6BijFyOVbTMUjHYjCev+uW71KrlLTjDBpB19BLcXyCxe96gI+WojekX0uQbK0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(261102123227099003)(261021135927099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHhvUnV4QlRKRDVCSVFwU2FiU0N6M1B4ZlZKZXV0ODFLenVDRG0rRjFqWHdO?=
 =?utf-8?B?dnhNQkM5OU52UU1IbXlUYVkySGdCelVZVk1JVkwwYi9ZODJLakY1RkRHRWx1?=
 =?utf-8?B?N0pxMHUzM05yUEZsWlhHWkZzL0xjRUJkc2ZvdG1Cc25US054Si9qdDFqZjUr?=
 =?utf-8?B?VmRMb3FNTlhEcHpyNitjYVYySHdqbENMaVZGMFdjdTh1ckNZa0V6NkdHNHFj?=
 =?utf-8?B?Y0hrdEhyangwdC9IcjBkdkFiLzRoMmVOT2h1RVBTdllIbVlGT0dZUEFRWitZ?=
 =?utf-8?B?ckxvVmtyQy9NZ1haM0tpdEdSKzFVS1A1aVJZYlk4eTB0dGtwb1VPR1FsTTIv?=
 =?utf-8?B?RVZyKzVscUJzMXZ2QkVUeEdpeUhpRVVlU01SRksvOW1hbkZOQTRzWjgwWFRI?=
 =?utf-8?B?b0c4TTRCVXhENTFNWUZya3ZCa3pwS1hpd0YrQXpDYUtSKy93Rm1KSFpsT0xi?=
 =?utf-8?B?aElkeElEaUllYWp2c25sN3I2d0o2b2RFY1pVSVRmTVpTamJGUXV3dldscm5M?=
 =?utf-8?B?T0lLL1diOXJsQWVRWmMrWlkwNjU5L0txZ0Zxek1MRnRDK0FWdGJnUnAvcXFm?=
 =?utf-8?B?Wk1UYjkrRFVxaDRtbTc4anBlTnI4U212OHFZZ3JlOUYyR1FmbjhHTDR5RFhO?=
 =?utf-8?B?Mk8rRnFlYVRraGtpVjZaVjZtZGJIZmwwTWxaUHc0MWxDZWZzUCtOUFRmWlhT?=
 =?utf-8?B?Yi9JQzFpaWdkS2R3djhYS3JlY0dQT1VJNjg1dkxXdHF3L3ROblV6K1JHTy9T?=
 =?utf-8?B?a2NadW9uM3p5aGhiN1VpaFpNU0V5ZWMrYWJsVk4veTliTHBSdjFFWmp5ck1O?=
 =?utf-8?B?RFdDaDNNZXIxaUlmWHdpMkc4YVZuWU1QUWdoZnc1MGlQUk0vZkpkL0duVEhj?=
 =?utf-8?B?ZTF4SmRLcms4dlowbHdjV3J1am1HaEhmb1JYK3c3bnBhYXRmVTU4UElpL3p3?=
 =?utf-8?B?YTJ3NjR5UW9zNEQweTB6cjRHMlBjaUpKOC92ajBmMFV6VjFFUTFBRVFGYkJO?=
 =?utf-8?B?cEcxOTZSYUROMVprTHdLS1M3eXk4Vkh5R21nN1p3c1NSc2J5dDFleHZ4a2Fs?=
 =?utf-8?B?WlV4ZFh4SzZrYXRBTjJvekEyZTRzNjhrU29EdVdYVnNkb1hnYXd3cnlYUzJN?=
 =?utf-8?B?VWRBeUE1ZDZ3TDdjUFNOMENBL2RRU1RnTVh6bHlXcC9sNW9vTVlMK2VsTVh3?=
 =?utf-8?B?STFOQzlOZVp0NkpqYWdic1hVNjIxT0ozWEVRU1hmK2pPeXQ5VDA2OFJLSjg4?=
 =?utf-8?B?bnRKcVl5cGRpNUlsT2I2UHhkSXkxdm9RaXJaZ01VNlZDQS80QjY3aXdnVk9G?=
 =?utf-8?B?eTlIVDY2M2pab2lETGdoSytCbE1KYUx5VS92QTRCYTNlTzB2VThjbVV0WjRi?=
 =?utf-8?B?NnBhRStXUnB6dERjZGJ4cE1Kc0hCUHR1WXJmd251STdxbldyTDZMdXNYNzMr?=
 =?utf-8?B?UC9oeUc1VjZtMEx5LysrKzgrL0YyOEJPMnhJT05PdXIxcUo4OTF6R1hUYjc3?=
 =?utf-8?B?U0xjZWc1TzkzM3UyTHVLWnZ4L0R1RlA3akdxNnlmbmNxUVE5a0VqYXRGYzY4?=
 =?utf-8?B?U1oxc0E4L3FMbVNyYmNLUFVzK0FHbTEzUURFckYvaEtjWlRkWXhONWlQdURp?=
 =?utf-8?B?MjhtWW1KSDQwU2tqYyt2bkJOQms1MUJXQWlWbjM0T0wwd1lHNG5YR0hNTkNN?=
 =?utf-8?B?UGYxeURaaHpwTkxsK3JtRXVNZkdVOEt4Vi92ZUlMRDdBb2ROejFkU2pMemZn?=
 =?utf-8?B?Y0RNYlZPeWxxK0grVVpRM0xjTVdYVzlmUllVMFljcXJvdWpOd1R1b21JZ29O?=
 =?utf-8?B?dnR4TitkRGJtMXh6TUxSZHlJS3dXcStyNmlpdFNSQUFWTHFTNFZLc2lSNE9T?=
 =?utf-8?B?eU5KSk5YNXZmQWZsZm5hZFJGV1ZjMG1GbG1MWUh5Y2VXOU94Z1p1OExmUElw?=
 =?utf-8?B?UGovdlB4NS9aUE9ENU9WN09YKy9vM0ZiUEtoM1ZvdDAzWnMwUUZjUUtGOHNW?=
 =?utf-8?B?dURtaFllZlM2ZlR3STNraHNTMVp6VjdXTDJwTG9lYUszT2FmNFdyVWVIVEhh?=
 =?utf-8?B?ZDdmMm43Vy9UalZISitzcTFXSnA0VHk0SElINWtIZ2xnelhWL0lLUmdHQmZW?=
 =?utf-8?B?aGZIem11cTY4RHI4c1J1TGI5RDZtQ1NrMk1nOWljYzVuUzJZaE5naE9KUDQw?=
 =?utf-8?B?QVhidEhnTlkrM2hCZkt0aEhaUEd2Q0ttTzBzNndhRUtSUTRhdE81OVVrMFk5?=
 =?utf-8?B?TU9qTTlKaHJSK2thN1BvMEpyUTkwb2ZRYmN2L3hqN0l2OHNtc3ZPOWpXbjMx?=
 =?utf-8?B?SFR2V3FLSmJNUXhUWVVyVVZaSlhqRlNndkJXU0ZzUnlxQjFQaEM1dz09?=
X-Exchange-RoutingPolicyChecked:
	3EMlP9o8jLNVmI6dQUVVPVghpWKJ6uDMOpzZwVSPzjdbxnJW8Ksbk9erwvmLq+k/Tryz38qeQz5fT2Ko6J6/EZmgzfJKMMn0RoO9wkn6pqrSKgqN+EWU4T/J3ScD+JNYIwBiPuB6U7uEzxSn2smumsJP3chr9d2b9eLuY2RorNDFY8N6o3Fn5Lsp2tsooUVZa4I5x6GPitDxE5QaMmAHZ6PV6BDTiNx6QHuwobU0QFbrrBcrNdb4yNQX6rYxLP7+9FOr5aUnXt/huvLqLnwmTpd9oB0o43GoeoHw2/AUUkvIG5fS94GC8wyDTHFnG/pbXbC9+lvrm2VkSfyKbr3Jjw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478a7a2a-8c9f-407c-ef59-08df3f0f8dd1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:46:54.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owSJm70YnIsbbJumNA22CJBX2ctgqF3q9L2XDLCz9akQjGbC0wWqePckGBuyWydKCXyOSOVq9uQ+M/xXitQGMZkBT2fBVYnYXFtpNiON+1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6381
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfXwGVB3F+qOdlH
 9TqspTrcOka8dvM4lz1W9ZjTRO/ZOy6iVWqDO1Jf3lJG3TOr/lJb+DxJv4kOj6tkjvDDVyIL6bp
 O8kACWu9R3wW2R5yiqdOJ2OaoiyrhJ+JVPMZPqBVyzSrqksZ9MWoWDuHTby84SErOMmY26AGmNg
 BjwhACIQxPhEVFx+Qn+QqNYcSxYKiNUf+g1LRCDmsXENKjtnLItbagqzVtg2Y9bIHL6Z1ySSi2+
 zZYKYQEMFbLzEgS806shIXgweIqS4nouWRTsELfdxFz0/I0dCFEam4PKLkho40b0VTjSXRFF6nc
 wzEm5vQJh7ySbPFNjKq5oypM7Arn/8ZCFu39QPb1dkHRGuKp4LDbyxzQcG3D/cXYSBSUSRN3jK1
 5K1ejEkMz5BIRQr4SEBYkq65YnTYNhk12+vSV6qBcK6jDqRINsRpl9kLNRiW/1ny6aeQOttpcdj
 yk63Gnp433s2v5BOn7Q==
X-Proofpoint-ORIG-GUID: Ehc3H9kYABkW1aQgm8zWKYtwlM8zOIXy
X-Authority-Analysis: v=2.4 cv=OtjaWC/t c=1 sm=1 tr=0 ts=6af2e812 cx=c_pps
 a=qSo88s0AsKk38onbse8luQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=zxEQS6XK7lXgnggOeKMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ehc3H9kYABkW1aQgm8zWKYtwlM8zOIXy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfX4AFGFAJB0Nbu
 y3lHHJXvVyRb7akvL7JwY3Dwe5pl7osEjuiYNgoBpbCvgqyXyk199eMwtXgmIj7gjaK6q43CPiP
 LXOypdobpZ4vzusKljk0onRDk9R2Zu8daw8I1zLrso/k9nRBPFqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100038

On Mon, Nov 09, 2026 at 10:59:49AM +0200, Iustin Stolniceanu wrote:
> The ADIN1100, ADIN1110 and ADIN2111 report different model numbers in
> bits [9:4] of PHY_ID2 (0x8, 0x9 and 0xa), with the silicon revision in
> bits [3:0]. A single phy_driver entry with the 0xffffffcf mask currently
> binds all three by ignoring bits [5:4] of the model number.
> 
> Use one phy_driver entry per device, matched with PHY_ID_MATCH_MODEL(),
> as is already done in the mdio_device_id table. This allows device
> specific callbacks to be set in a following patch. The callbacks are
> unchanged, so this is not a functional change apart from the reported
> driver name.
> 
> Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>

Reviewed-by: Alvin Šipraga <alvin.sipraga@analog.com>

> ---
>  drivers/net/phy/adin1100.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
