Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793765059;
	b=n89t9xmNAcuSYqIqb/09Cw5aLyOEWTvWzn0ve+9bgvnsMEQ0xVE1XZ2AgmO0wMCMDxO4
	 oMZ7j7CMWG1eqcFbZ3k3RF9TaP2Q4FSneILM3JDk1/UFYA3unVfRvMhLtZknXYUm+jSAJ
	 Enzq0hEZ1UujN3hi/dKyeYRoO1C1fOkNzha5lKZsaikK9S+s5e422vNW4/hVKF2M6fAeQ
	 Ju9OXhX4+ZJYNGwQQWLokXttXXpuMjYuUb2a7ZXp15OZS9iT4FQkaSSU020dN+o5a+dcQ
	 8w2J1JGcwEz3fgnMrfDkFBG+pvp6mDZu+0+bK61VvlW6TDaOaIk2x70YUOTY46oKD1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765059;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/VrXBIBfTOrDfyHQ3hCRTEvNxSkSYJ7e8YpXTat4qNw=;
	b=KVYbe1NBOzqSQiPRUJ6xrlJq844yDHxmmNH0jlEFuIUSpQCRpPJCBOZCJ4PnPCM2SicA
	 MiaD/LC8lpSJiGh6wh+0QYLBb2xE2TFrazQb+kU2XNsm3PbT0scqF/7atF9nFTwMv0OPM
	 FqECNqAGiZqDjl0AoSVBSdk8khdJihq6V1Lo5iXBOBMsB17FW7iIyU1D1JYsm4H+XcQhy
	 kUJkal2qunMsPn/BTzRQL4t8oRAalNMce3BZzPkwe23o/gLFKuu1aQf2apwbSIaUPGjz5
	 N6Ge+prj8SaouJarVFLM8S6xMxKgF2Lm7BaVbmP6Psq6OliPPuZIyQg7Yyb/NDl5Tkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=YFojipF4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.24
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6800606A332;
	Wed,  4 Nov 2026 04:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6800606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=YFojipF4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSzhCQM9j+hxKV4K8EJBNEA/wEIj/C6TrCKD+BGk8B3+ei7YoXOtG0ygEUcJuYufx4SZZgAHjd/Tfax8vqYjZZaIv9Pn4sY1HLU4y0PEhsb+3wBAy3GDo802QjReNj5QXtgy0IrxBURsgumpwTFYNvdKCFAPu/XcVvaSIS5/lFO4JfpmMxrvRjzQjspSU0B4WwMhVwRT8OLvmhEgxbxfCgT2HnAwbxdcCpCVM7YUbIT64NNndHcwsc13jUD6iczlHdp5K0+xDyMQT6V8eQ0eqoS2fH1zhP9qprA86fA/XHGHmitvJNem0/Cx6YmHgF3bXq8sJhMUM1LVx/aGPVIn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VrXBIBfTOrDfyHQ3hCRTEvNxSkSYJ7e8YpXTat4qNw=;
 b=ixKF0el8MKj1YL+ZHaVFCfWGMBbkEGrOL+ycvpinmGvu2QZBb4a8yIYli+RV6TTaOOG2BSMVmH4EBv63vbcHDhpE9ym4FUmcyh9PoSWNvcPhHfKs2cFWw2wsDYuo8iRUqtFNfDHeoUpfznyGwgs1xKtduzRCtrqR4bqLrHwf8+QK07Muy8EWaTnI3n6ma/bLfbhtAxUM9PLdaq+3LmnJjw6bzEXvmAq8bFFPCfHKrMXEJslSO35dzolC/4LXt1JcsBzf9gVlz0r2zlGeRbOVL0+TC0hMVgL5r+OLJm53lnqSArGZYUrxTfYgakGdqDaLYRAI1QbV2zSGONDyYjYztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VrXBIBfTOrDfyHQ3hCRTEvNxSkSYJ7e8YpXTat4qNw=;
 b=YFojipF4T/QlIiHLM4tnhOi2kCiiaoF+s8gZbOsRXovtqf3VqDkeEV+SXt/HofVbMfNmKUT3qjkQLK0lx0tVRJiCoDL8HsB5u8r9W2FfmAY4WCP8ZndoSOgxbsGOgvcWdoiCBDpdVq1XW3DTd6KCmmasggl+tCLaQJ6ooJcS0Eamvf5IT8AruMU/uPOj26x/O+Zp4wUsCN/WyNVUM30q0Cm52QQqFvUbaONpKyiF9QrbcopeAgyHaKioklkgsmn4qzYKznO3fORLcLQA2rQ0bDvyYzltvTTc5/tOdbPDYLiarkeHBOzF5NaBdYVQRHdKuz/UwSOpCRsxocuM0PYFPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MN2PR03MB4958.namprd03.prod.outlook.com (2603:10b6:208:1ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 04:04:04 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0569.010; Wed, 4 Nov 2026
 04:04:04 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] dt-bindings: net: altr,socfpga-stmmac: Add altr,socfpga-stmmac-agilex5-tsn compatible
Date: Tue,  3 Nov 2026 20:03:19 -0800
Message-ID: <20261104040320.18077-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261104040320.18077-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20261104040320.18077-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a03:505::13) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|MN2PR03MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 535a8027-f828-488a-b17a-08df3a28a968
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|22082099003|55112099003|56012099006|261102123227099003|18002099003|10067099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|11063799006|261026121527099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	QdybVZ8/PxGjI0aMR1bX21bJ80TIduk8c6ZgBaVdAghqRkqd4DFNnqqP5X1yI1w3VTWLf+QEfWy7L+C8VD4sCXyYJd5Y3AA83d7E4trfMAL0j5TwFnvkmjd2OQxSaxUa/JxbWVgSFoFlQAF5tfYgOoDPepMQIRsrPsOY3pZtwWrXpNqMCz4XkRJY/7Bp80MV6WR2IRE4+FMVJ+89FDfLH2CR5KiXgbQCjVtZExLEa2DslD7m3gbge8Kn25ikxdMCbQFKTP05Fa7Lgp2LCX3ZPw+T8DZdS9gMNMAK9Cf4tSrZya5i/tH/cqOvLI7Tk7lksZj4DwzigeLB/dIk4fcTf3kpTst8C2oRFo+YtnpxLz53VSSqrIKlyDj7g4gwAq4rQ25fXVevQjQcmdOUpGyiWHGHGU+cvQz4aKt5UUkBnuFq1xhs7bX1R61AiRyPLKgzBpKar7f1iHIB34Ec8pmY//fZW7+RUHsqBugI1lmK4OfgaK6zSvDfmGGIqd/jf3+X0ek21v8fNjLCIT9ce8eywvJEkTye1RAIrd4ReQY7rbiOlKXRsrPDot1XZNs/QtBX8adU5UpEbwYgQx9KLziCHHAoBprnouRvFyeCBGhhFQf6Z84j8Yox7Flh5kKQzN4gUkV5I2UVz+b5rB4nHARdIAZdtR+jYoClKL1mgyY9Rsg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(22082099003)(55112099003)(56012099006)(261102123227099003)(18002099003)(10067099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sRrAvz8urWSaLZaEEhCU8/vJrtcCxNhP/DBur3ImqvqaV2lgllaVbjNe0TRJ?=
 =?us-ascii?Q?sFPqH6c38KJJ/5RQLBtMw8Yxp4ScrUkog6I0JdALoPAa2QaYp49X3QQ4kgGk?=
 =?us-ascii?Q?SnW3Z74jOmWHH+0qnhvRS6GEflU3EqGCGfVa4PcAVqa+m7i2ZT6Z3eRTAtxp?=
 =?us-ascii?Q?SltWMS6oVQkTK9NEY44Gej1sNgg7CJEBsw1AmQixkECkXDvkN1SPw1CZLrpc?=
 =?us-ascii?Q?LZLgFTDkwGFXoeYdrlO1pgGdbDGsqZ+DOscQP/9PJOccT6jsu3coI/SPJDym?=
 =?us-ascii?Q?VhBbWlsDDGAWJ2RnNkuHkKjcm6p77Q3brpvX4UopKPen9aK7Z1cDA0wy6rnZ?=
 =?us-ascii?Q?y25oEMmaUTIrB7sacru1HyZ0Ttxnc2Qfrqh1z32AGEy77G9PEMhHBkRcZtmG?=
 =?us-ascii?Q?5rhqcRJ2nrAo6IaZ/NFHrz/Kfp+D4TG9tuiExoA++PPzA+0oSLGYodMT/C8i?=
 =?us-ascii?Q?/CL36k7B6gQXBudl73ipICxIZ353yiJJ1fDmxsoBBgIdMzOALKI8vKTDu+WJ?=
 =?us-ascii?Q?ZIll+Ixbhf7hCwxGLvRGQ/3IQpMqGWy49wz8GgajDhH9SEQDApB+wTtnpA1N?=
 =?us-ascii?Q?DSX3/Og+ykRx8v9N3WylHMzp22sPZPtcOjR8Puv5X31TdypluceWsU0JZSxq?=
 =?us-ascii?Q?a4fs2bRS46Az3pzrh5pBUo+4RSV1+FNOprrEdKR7XEoAKXwzpuoLxHXNMtSi?=
 =?us-ascii?Q?BpgDjs2a5pRIQ/7HEs3aksw7JmjJoUf0p5KZL+6qF0Ph0MZAFXFnAmwzgHmc?=
 =?us-ascii?Q?NGXmg/s/eOybB+1Q59a/qz2jx/ZoAFHcKESk4RWaYmVMLs+bByIVo/tmkUda?=
 =?us-ascii?Q?KbY18efoMWVA9NC8BRG4ZE1j3D2Rd9AiZXBN45fxiGUkaNudqQRcZPH/Xrfe?=
 =?us-ascii?Q?BDG03ADau2lcVtpCFHzYfSUNy6QxLMe3Qi+Ijcysvq0QZPWqpWMC4zeoQQ0i?=
 =?us-ascii?Q?rv4zLX6LCe/am6UlaXRttd4BdVUorFjL2dB1vTb5/Vz/zNAcEdcU3bBotPbo?=
 =?us-ascii?Q?8Tkgh/b+KRFnkrI4ECo0kFvXLs/ebpszOdS6o6s8z2IQYUFg2g/IAqtzhFKC?=
 =?us-ascii?Q?Z9NHOZNfcHYY1ywQV3ysgc3IZeCwLB5pGSfC7DxaIIAj+tha1TLT18rhDfJG?=
 =?us-ascii?Q?inkvbQre+pt80B2a5gd4XveIAHEyFQxEj0qdN0ZHJlno58zqxXOeSIRj2F6V?=
 =?us-ascii?Q?vAQkTKp3SDfzFwxN7SNPClTDEiTUvcnzBwTc4lieZdWh++zODa0kIYCfOuMl?=
 =?us-ascii?Q?QhgfHy0JPgYKn4XOaV3dJDk57AxOoQqMa1rUvgDhokCuqsu3z5zNeWCMwUA+?=
 =?us-ascii?Q?Fg5LXHpEVBW23+6/g74r9AeTYQS7riu6MNK8H3yWi3QlGnrUqfOIpc34GQSM?=
 =?us-ascii?Q?USOjs6vbj5htRLy54DTz2Fs8s45WWgPXqjGNqEKpVHhJteJnRZGKsnIln6VV?=
 =?us-ascii?Q?qGYIctCnBqvHK2XH0vnCFfpqd/puWW+uFi94CkZ5TssEjtKP2osh6xdxrXl+?=
 =?us-ascii?Q?qIb3KKObbFf9sOBha8W/35tKsnYvlO56tmTsdHkph4qVzNVE05Zc2I02NPOt?=
 =?us-ascii?Q?n4uixDXGRfUlsw/yQp6noFM12PGqMMAx4NkRzRBvzyoPo1Ts5jNIGlC9hh3l?=
 =?us-ascii?Q?MXTofy8+AMlzC9fqSW0pSzUQrt9w9b2XBl1JiACJgiV779a+hX4YJkFVh+8Y?=
 =?us-ascii?Q?72pceKSkv5xCWJSQDpoj5agv5FackKfgMl5Rl+eOtuQ36LA7JRta7JTCso6m?=
 =?us-ascii?Q?KlsTBS+zOTKQzo5Kt0TgDy3oGbk/SbYy1jxM7O6Cnv2LIMqL+B2fO0JM24Vd?=
X-MS-Exchange-AntiSpam-MessageData-1: 6laqWgBmlINWkg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535a8027-f828-488a-b17a-08df3a28a968
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 04:04:03.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfziOG2INI7ffu28ecWl/xee59K8sXR6ZrFL/AVy+S3j4jKld/17zVbDd9yEOmSlCD4KefkfX6cZ0mTRYyihLw84olEwBcm585CI+qm1kC7r5Dy4jlM49V4LlQgw08sAGtLVdOSHsYZZv+OVYzOHkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4958

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Agilex5 SoCDK TSN Config2 gmac1 path includes an FPGA soft-IP
GMII-to-RGMII converter between the DWXGMAC and the PHY. The converter
provides the RGMII TX/RX delays and presents GMII toward the MAC, unlike
a plain altr,socfpga-stmmac-agilex5 port with no such converter.

Add altr,socfpga-stmmac-agilex5-tsn for that integration in the same
compatible items entry as altr,socfpga-stmmac-agilex5 (shared
snps,dwxgmac-2.10). Do not use altr,socfpga-stmmac-agilex5 as a DT
fallback for the TSN port; the converter presents GMII to the MAC and
supplies the RGMII delays, unlike a plain Agilex5 GMAC port.

The TSN port uses the same DWXGMAC-2.10 core as the plain Agilex5 port,
so extend the interrupt/interrupt-names/dma-coherent conditional to
match the new compatible as well; otherwise a TSN node would incorrectly
fall into the single-interrupt, non-coherent else branch.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Previously patch 3 of the v6 board series; split out for net-next.

v2: Extend the interrupt/interrupt-names/dma-coherent allOf conditional to
    match altr,socfpga-stmmac-agilex5-tsn, per Jakub Kicinski / netdev bot.
v6: Put altr,socfpga-stmmac-agilex5-tsn in the same enum as
    altr,socfpga-stmmac-agilex5, per Krzysztof Kozlowski.
v5: Drop altr,socfpga-stmmac-agilex5 fallback and rewrite commit message
    to explain hardware incompatibility, per Krzysztof Kozlowski.

 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml     | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index ce1bd5f2c470..a6ffd7b98c1d 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -22,6 +22,7 @@ select:
           - altr,socfpga-stmmac
           - altr,socfpga-stmmac-a10-s10
           - altr,socfpga-stmmac-agilex5
+          - altr,socfpga-stmmac-agilex5-tsn
 
   required:
     - compatible
@@ -42,7 +43,9 @@ properties:
           - const: snps,dwmac-3.74a
           - const: snps,dwmac
       - items:
-          - const: altr,socfpga-stmmac-agilex5
+          - enum:
+              - altr,socfpga-stmmac-agilex5
+              - altr,socfpga-stmmac-agilex5-tsn
           - const: snps,dwxgmac-2.10
 
   clocks:
@@ -178,7 +181,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: altr,socfpga-stmmac-agilex5
+            enum:
+              - altr,socfpga-stmmac-agilex5
+              - altr,socfpga-stmmac-agilex5-tsn
     then:
       properties:
         interrupts:
-- 
2.43.7

