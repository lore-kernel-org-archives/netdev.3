Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793967179;
	b=ZjHN9BiNPaDX9+/Y0UQ7uMqVkyfHoyioApO0Y2qxtVLf6iB+AHIRDDCbxrPZA6/cff7z
	 UTlsVXiPMIHf7fgWGU81s35m3bk547pGP4qLVoJMKd3xvWsu6pdHcNMx0YO1e/Cewjsdj
	 OOo3FEnJ90Lz8dFR6yDcoHVBA0HhTlacve+XCW3pANrqnHGR9O9CmjB8U37Ij/1e8EB5L
	 tgXcsJfBSMUnc0E5t9Ku43UOddGmpxlzHw63FfHuknjhm1CqgK345iiLWOhKWuWqD5/PA
	 ki/xJtRKH9ajLKLteDuyAlsnOO23+GpT7ilXl/ucJ+nvIO2/+0K0UcAYsLRA3INnVew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967179;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/ws3n2Ex0HAo6x7rNz/zwQsLr4dU4k9GYgo4KS3HmBI=;
	b=WjuMeFDsSN68yUTs9ZaHXHZcB2JUSYKYqQ4ycvh2W/OlNgN3cBAm9fTun9zpsGGDZQH2
	 38ujxHVp5C6E/+8E8IFhZIie+vUcAGL70n6YpcKkwRvjktZ2Wz07O0CvsJ1IYNM4BHDRn
	 IkI/MXnk/aiZ4kf8x33CkayRpKPofqaw9Miy7+a31+J61PZk3AetHmKiSha0uQn04+79b
	 NlqGMQlxmBz6kEJxpfX9XsrZdV154Y8ziIWtdty7L9ln67QWaOZooU/rFFDvbksXMHETh
	 5PCJ1Ua8BZs1QVDzo4J0jTgp3eFuwFxQVeFK2FTfsqDQQaki/vdBpuTElYYIbBI//mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OoHwF8fw;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=hxtsE4Pr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE9606D807;
	Fri,  6 Nov 2026 12:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46EE9606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=OoHwF8fw;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=hxtsE4Pr
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AQOl02363523;
	Fri, 6 Nov 2026 07:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=/ws3n2Ex0HAo6x7rNz/zwQsLr4dU4k9GYgo4KS3HmBI=; b=OoHwF8f
	wJqj5tvkOh3NmrFpnjpAotRCXQ9d8v2lND4DU2dAnWFc94RN+E5Ubtli4rOaBy7A
	xdO8/xtKXufsaiuz+Z5H09DVO7oTi+247QOBNtMg+WMWf8Ze3/X9E7N5DLlrEZd1
	CvlSAz1TDferKfrbjrA2LRoDofySxWhLETXmp82HTJhx65vFukFIlwOIFxSaKHL+
	T/mbkbsxf3ASKpML0V34BLesRtySK3Yjx5yjnKq6G3uYh8xJFGRv4jS28B16ZRBe
	BdiJuhaxByZbtMgw7smMBn7C4SJAJ9Sae74HHjMHvr+fnOY81ZAuJ5gCIy/Wm7T2
	h1l2POoMj6VgZvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/ws3n
	2Ex0HAo6x7rNz/zwQsLr4dU4k9GYgo4KS3HmBI=; b=hxtsE4Prf+5K2SXxaJ3kU
	iZK3fTPVKQWldakEI/c6nvw9zBBKRjWnxFTlcrRMdLMatEHUvSyCMle3w0+hDX9R
	WRatYQr8N9yOLDHGApUHYeo0gcSMRyxXYPbaeQedivDvdoODcnv9bDdcAiA8v8ml
	4g4uKA94Y7+y1HjEFbl77pJGn3fL2bN4cSIyN659rQjOwAR9m/6MHXwY079vCcJL
	b09q3ac6tLVP0W72FX72+/K66ymZPDKLgndHUvqvDqp4roQKtSztMi5weDEqWfmW
	EfC2MPdzne+PWAgwwllrSdGY+FXyfJ59zpgCpBceSW82pn8CF3BdxQcI4jgrc0Jd
	g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3pwkg1h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 07:12:45 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbvPyn+bSPtQtpLS0228hu/Dz3gilTFd7sCsx11GAnLVF7gMcXcKqrNQcBr0/G0bEmj69TtCXSN1+gGslAb0M85Od+FE20BU83rkk4jvgJlJmlg2VUXo/S89RdFrbj/hdtEN80JHJlSUDnPbF3qRfPGyweB3wJoavCssGyEihAGeQinoVePTPL+GKD0Hr7YGQnzlcs7fOZ4+18U9bPPityKfokoPop7PZPdhRuQfbLNEHXda9PMySMx/1dvA4oa1oNnv2G3uyE39s0zxgSsflje/prj7sRfCvVG2QocimyLCGQ+89B9JnuWapBeSy57Y9JF6PecBzPvaIq2H1vIxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ws3n2Ex0HAo6x7rNz/zwQsLr4dU4k9GYgo4KS3HmBI=;
 b=BI6SW4JKd4+kQhidqsVKQSZMbB2BXb2U648jcmyD6141qTBJ4upTKWw3ijo/sd6LFWW+YSPGiqk/IezWCsUucWd6ud0ds5JV+xAcr89rRdutGAPGou4bNBbWORnjIq1J6sSJlphO2Hy/arMNLz5Mx+/lNxtfU6MotB0ooFLvaK+qzXjs+8raz1iMYQBY4SjHGFAVignWLeCTP5YvQocJECLhW0uIB+hwu0PdABt3CjvHaq15ozg3BfKSaB41yuHCnnVAeBrGEFOOvjNOn24QiTq3P5eHS1NPR2/KnbgUVOa7ZnCmA4dNj0ArGOypjfS2PpxpyuhGGdu6aUdpmuHolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BN9PR03MB5977.namprd03.prod.outlook.com (2603:10b6:408:132::11)
 by CH9PR03MB867119.namprd03.prod.outlook.com (2603:10b6:610:354::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 12:12:43 +0000
Received: from BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3]) by BN9PR03MB5977.namprd03.prod.outlook.com
 ([fe80::9687:b756:5de3:28f3%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 12:12:43 +0000
Date: Fri, 6 Nov 2026 13:12:40 +0100
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
To: "Stolniceanu, Iustin" <Iustin.Stolniceanu@analog.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "Schmitt, Marcelo" <marcelo.schmitt@analog.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Regus, Ciprian" <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next 4/5] net: ethernet: adi: adin1110: Add OA TC6
 protocol support for ADIN1110
Message-ID: <au3C27DWOcZiMLxb@analog.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-5-iustin.stolniceanu@analog.com>
 <aus-LdkVRPxR6lFu@analog.com>
 <IA3PR03MB84531C29DE02BFFDE950BA43F2762@IA3PR03MB8453.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA3PR03MB84531C29DE02BFFDE950BA43F2762@IA3PR03MB8453.namprd03.prod.outlook.com>
X-ClientProxiedBy: CPAP307CA0009.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::15) To BN9PR03MB5977.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BN9PR03MB5977:EE_|CH9PR03MB867119:EE_
X-MS-Office365-Filtering-Correlation-Id: a4df71b2-02f9-4e4d-6779-08df3bff4277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|4143699003|56012099006|261021135927099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AM5ytFxImRqjArmyjYo+I5w3zICdQ6ZojxYNwQlKgZN6kzJtdgSO6yKYy3neNEnJ/sywpGkxUhxV6SRC3MTEK6Q29Jp3ugQSFnysO+Sw80OERg7nZiIJrg5KkWwhm6pP+L8WGLIfhz6RwdRC4NTVKHj+oBDjAAIT65GqN1eNrmnV98DNDRz6+D74lbmPYNqJKPmhLOaRmh0QMW6blwcQSWb+zcUUV2GNWx9DgGT/on5SlRl7k1Ogk1ER/xSJIspGO6c0pLBHCgMQyrXD72+DTIgU+Aatf0rai51u8aTU6Z8J5yBsv0tgFZLrJtWvb2RPDBVz9SEF4eI7+eyN3QbxxtIfcvFzH3hXw5aOqpxAcVglr3/52ENrF+0MEu2stVNqO1IsudFNcf3rDfI3Y3XbHnVTkRbZlG6zivFDDdwXHUvH2G7xGwbnSKNzhDiYqTYqecaNrP9ggPefj0lwjaQ4FwXfNCkAJ70q+wRCz6OX7zlG4MxwJPNi4O48LOv6iVnu6UqjhLeixjFvcyAhV1Ha/e/18YbQ3dVgto6IQ29v6cQ5eZKDqRutETNFdjqFZ86w9BQ+2583KKZleSTcFsBloFicu1/OQuM3fJ9Kimx+9Q4HyYDzQaNnt57HmWWDmTT/Qpgv98Ou4VU/ozGxojW9X2x43SRxlDwy6p//SXXTzKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB5977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261021135927099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHJKSW9scXFFR25GK1gwWjJ4ME9pbU1IVzREbDNGTU5HYk5oUXQ4R0Z4bEFX?=
 =?utf-8?B?Zk9KQ2g2WklicWFvK1ZpYmVrUHlPa0xXM1hiWGI1bDVZSHArRnRtNDA4Z2dz?=
 =?utf-8?B?QXZURkI4d0ZJbTFBUmtVSFdMVnpIVHBUK2x4OExFRnE2ZEllSEJ4QzhxdU8v?=
 =?utf-8?B?MEpmeCtNQW1BUVo2SDZNMXdQU1ZJRE83dnZ1eGN5YkpqeGdyNFRtS1pVVlpQ?=
 =?utf-8?B?RzNOYXQ1LzczTkgzSDlVZjE5TWswbjBFSTNZL0l3cEhEenlUN2NjWDNtTHM3?=
 =?utf-8?B?RW4vT2pweFpCZlE2dzNxWHpzTERkeEFsbkl6eG41U0FmR01HbjR6cHNHRTA3?=
 =?utf-8?B?TVVTN3ExcEd0QnJEU3Ayb1R4VGZram1GQVFRWE1hMVRNa1M1dEZVR3ExYzd1?=
 =?utf-8?B?UVVFSVRnSDd3M0ttL0NNZUJVRDNpVnNxZk9GUllSVUVxSXpGVkphWlQ3QTFi?=
 =?utf-8?B?R3lJZzBEZWdDNW1uc3NhNy9tQ0RQS1liR1N2eDF4SWV0Q0VjZWFnclBPWllq?=
 =?utf-8?B?RzBkbllXQ3ZzbFA1YkRScjdaTWNsQjJtK29mWm1LQ3BYaDlrUUswcVNiMC9o?=
 =?utf-8?B?YXV4LzNuelpIcGUwek53TFA4SVZrUFcrd1RPanRqTGl1djVBY2hIN1hyVXda?=
 =?utf-8?B?K3YzWTE1SXlweHRoQUpoQjd0UHFaK1BpdTZlZzVxZU40Y3kzS0JMdFpJTW9s?=
 =?utf-8?B?ZmdsRGdjSWVwREYrWlllcnlzVW5ocjJGelN5VDhwRXl0S2Fkc05iUmY3SDcv?=
 =?utf-8?B?OElYcW96alBiUGJEM1RXSlViaGFabFllYnBBQ1dyOWJkeEFUZkVjQnpPVFpv?=
 =?utf-8?B?eHpqbDBXTmU3WkNMWkNoYWJpckxEb2NmdVRTdlM3eG9Fczl6cHJ1U3BDdUV4?=
 =?utf-8?B?VHQxQjFIMzBRSVp1UFZWQmR2QnBROXlwRzR4bnpSK2VKNlQrdW84QkFjc1Bo?=
 =?utf-8?B?MHFMVHI5WjFCZUtOTVNaZ3MvbWkwMXd0Y2d1Uy9pbVlBVVZIeHdCODdocG9o?=
 =?utf-8?B?K0ZBN1ViV0VINldBNWVYaHl5bEw4ZGZycUVnM3JMRGJXQVlmSExJN20vU0NU?=
 =?utf-8?B?T1ZsUXJUUzVCa1dRYjdudzc3UDVGenNEcmluQjI3ZlZJc0VrdHlpK2U1bmI3?=
 =?utf-8?B?MlFqTkhGaUx2WGZJQVFjRGUzaVRjUjN1V29SVG13Z0xacVdFV21CRmpERUho?=
 =?utf-8?B?UUYxYXFpVzhPSTBwbXloWElsWGlRc2VTTFU3NnBXWnB6OWhtNVdEUldEUE1p?=
 =?utf-8?B?Q09lR1RuOVVtNFhJNnRielZMMy8rUjF4QWpKMnhMT2Q3YzZTUXRETGRHMlJS?=
 =?utf-8?B?QUlmTDduLzJ6V2JSNlg4NVRORnNpeVlSL1dGdElvWWJ2UTZzQ1hmSHEyUzJW?=
 =?utf-8?B?VGQyVWlrOEpQT2txR1BsZk93Q0VET3g4U3FLVnUvVnlxdktpREx5YXFXSlBo?=
 =?utf-8?B?N0t4dGlxbUF5NldLcmYyOURiT3FxUjhjU1lyZ1llRmhhQXNjenNsbGdHWTJq?=
 =?utf-8?B?THRYM1ozYTBsV3V3c3dvTWNIMEVxWGVyUWJGUHo4aWx6NGdaaHdDYUIvQVhm?=
 =?utf-8?B?VHNPbERUQWdEelVpazJLUlJRVVQ2eHM1WHJUclI0SGovU0t1WTFkM0d3YnRR?=
 =?utf-8?B?N0tObUVVOTFJeWwySy84NG1uNFpyK0IvTkd5V0tNU2daSGNoODNBdkpCTmpl?=
 =?utf-8?B?aDZ2QTVoWUNMUmpzY0dVejVmczNoazVlOVF4NllVZCtLL0ZUTENweFRSRkEx?=
 =?utf-8?B?RlRhclJteHVLYklpQThXNFpzL013YU5JV1hRVUkyN3F3NUkxYmU1MGg5Y3px?=
 =?utf-8?B?b2k0UkE2WllSYmxzVUdOWWhyVWk4Q3pMWjhlT3R4dE1ZSVlMU0cybkVDaWZG?=
 =?utf-8?B?cWVLQk5oNnNZUjh2OVpsOG8xL093VURmcVFRaXBMZWpSV0I5OW1mVjd2aHBt?=
 =?utf-8?B?YUQxUm9MMkJraTRVMHBjSkE1MlRnUmhmSE15dGpXQkRRZ3JqUGtiSm9WdVdF?=
 =?utf-8?B?eEZpa1MwMUY1LytzclFVeDNOUkVIY3BtMnB3OCtJbTVxZzRWMlIrcVpXam84?=
 =?utf-8?B?aGwrM3g0S1ZobENXeGRXYjArUGQ2U2k2RjVKd3U1VWRORERSK2ZhSlRIdm10?=
 =?utf-8?B?cU5WQ1RmeXJDRVZvRnpRWEhMaDJHS0VmZ1NKUHZIZGxCMnFUc0lBMUlQNFlY?=
 =?utf-8?B?dXNsbGtKNGI5elpTK0RVbG9ML0JSbnoybkxuQWJyeCtQZXZoaGNCYkVRV1hZ?=
 =?utf-8?B?WlA5SzhlY1FoQ3BxQUlKY2ZpNi9ZMDFOSU56RTQrL0FHYkh3dmdTUFJJQjNB?=
 =?utf-8?B?RTdoWk5WSDQ5d3M4V3AvTktOdGZiYmdYbnQ0a2hSZGdib1VFbWpFZz09?=
X-Exchange-RoutingPolicyChecked:
	x4oDT2OQNZH9yehMLiMtEGj2ja1uVwzMidOCclLI2G4W+W7mXOVNmPyKdhrqEt9BjCYYPeD7hpxC88NFlZERy8gOzRh3oxx1VWL7KWSVOjCVskrXuNtU2B3CDAPrYXL7jNrd84SVhjoRiwAFctlYp8cINg7wnpnGUFj1oSWDlOr2vsxqUNViFaY3vwjLYGduNsrGkDUVLjhvW6Ln+7cbREXv5NHRXaf5PoX2GjjvA9GxHQ7w3oO40Nx3jwbTKbBZ1R3I6h2zbUQ63HtP2qbK/WfPmaiPF35ek+FxM1rzV3HrY4cwUpZ7xhzhckZ7+ftVf/vkrEQan1h4BKmZvU1o7Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4df71b2-02f9-4e4d-6779-08df3bff4277
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB5977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 12:12:42.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wlgqdd7xEQFwYil3ia/X/cc34jqzCp8OfAeX/vNjm8nGYoS9mt9GoQqDL40N/g369zp4UbIHzGoguey0XXucGk4lLcj/dbs+mEqpgmQrJVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR03MB867119
X-Proofpoint-GUID: db6ctywLS3Bl8Kaz3CLv2TCPoTTr8_P-
X-Proofpoint-ORIG-GUID: db6ctywLS3Bl8Kaz3CLv2TCPoTTr8_P-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0OCBTYWx0ZWRfX1uNX/Cv3urhJ
 MtXQYOz+qmOVc9AU9zP9jii0CTb42UYQ5xyElWPjuQVJy2Ye7mByUMLHHEcf8ktrQnA/uHoRz0s
 fFXDqEEjDK1o8BO710j5yoX+YvjvjdPGQxKWHLQTmwFAaB3U+G9A
X-Authority-Analysis: v=2.4 cv=d9BgWhjE c=1 sm=1 tr=0 ts=6aedc43d cx=c_pps
 a=8TTB3MyXo5LrYHl2kKBanA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=VWgTmMWYi9jNEn9pX-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0OCBTYWx0ZWRfX/EbvQbIQ0MsI
 qsJj9y/KDFMIfofCPWzEaEMKfAkXm2VuEp2l1DIZtBbe6G2YLfkssCSF0rnmAAXrsary8LHImYI
 /1pDHPhbnQUnvICt/eBpB1mZ3nYuUPwD64c4zVecXBk8dC7nnGKZEe9biVTa8j3LT0gYxG9oNS1
 BdIx+T9gFCvHti34XnxpGb1XFZUNS4AdjFZNCLPzrNab7tmxhkIA/0Hm+/4UchAFDVSrOXcQmmf
 2MeIdgJnKMt/KDkqkJdJtKOIxNcLDSwnOHOAaCFOVKsxMwD/++DROtAw5RU1dRmz59jS+ZxWpZz
 +UWbNIctfnaoajQCPncjdWf6APu+j6NJODLxxY3lCDHUElmUAG4H9lfRvUPWsgg7P9hJSpABOYa
 pWDMnLtsYDzSrjfQ2Gkj88sMnH02O131GulxLj0DVSc6zXCwNb9oXygBfO51q5bN/EltVBLmgDJ
 PtPBE56RCfTC58egTfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060048

On Fri, Nov 06, 2026 at 11:43:07AM +0000, Stolniceanu, Iustin wrote:
> On Wed, Nov 04, 2026 at 03:26:07PM +0100, Alvin Šipraga wrote:
> > For the above, it wasn't quite clear to me why you don't call
> > adin1110_port_set_forwarding_state()?
> 
> It does the same as the generic adin1110_net_open(), which also only 
> sets the port state and the MAC address. The extra step in 
> adin1110_port_set_forwarding_state() is adin1110_setup_rx_mode(), but 
> the core calls ndo_set_rx_mode_async right after ndo_open, which already 
> does that with the right flags. On the first open port_priv->flags is still 0, 
> so calling it from open would briefly turn off broadcast reception. 
> The hardware forwarding branch only applies to the ADIN2111. 

OK, makes sense. I still feel like the probe path could be a bit more
unified so as to avoid this duplication, but maybe it's more
straightforward to achieve when tc6 support is added for ADIN2111.

> 
> 
> > Would it make sense to use the async mode for the non-tc6 case as well?
> > Then you can drop the work there and have the same ndo callback for both.
> 
> It would, but it changes the generic SPI path, which is out of scope 
> for this series, and that path needs its own regression testing 
> (including ADIN2111). I'd prefer to do it as a separate follow-up after this 
> series, if that's OK.

Fair enough.

> > > +struct mii_bus;
> >
> > A mistake here? Doesn't seem related.
> 
> It is needed. adin1110.c includes oa_tc6.h before linux/phy.h, and the
> Clause 45 MDIO prototypes in oa_tc6.h use struct mii_bus. Without the
> forward declaration a W=1 build fails with "'struct mii_bus' declared
> inside parameter list". I've explained this in the v2 commit message.

Sounds like this should be a separate patch. Since no drivers are
affected by it right now (I guess because they include linux/phy.h
before oa_tc6.h), it can probably just go into net-next as an earlier
patch in this series?

Kind regards,
Alvin
