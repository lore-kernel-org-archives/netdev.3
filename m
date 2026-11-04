Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784413;
	b=4Xj2PP5y3d3AOH+etE3kVsiUdy35c7oyO/ViVVsjXoP2zUuh2gFOqxf7En2ri+LnkqQl
	 gAm+Z8RlhguPxynMSuqiDcMkNyQhthUEBIpPcB3QVqKSa0FwX38+MZogce+ZgWg8j2YyQ
	 1lW7wmMsCs4iIkGAGMdtoXyWFRQbUXuwWaafZbi5fcE8JcAXlk+yva/mo/BK7xQnNpN43
	 +xWTsvRaG4LkYRgvzCnKqOQCHNf6ZcX0Nbs6L7K/7xKZoqwUgQ0oJLVyyZYfy3ZePVvEO
	 2Kj6opdcOX6MszoGQHZ1Sf3N4X8S4Wy29eH53z0xzlWaEJaR2ejvc+lL19WFRo+bA/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784413;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=dNt33f0lPXUGVjd4RjIPp3s7kYQaYGmYbx5TxdAcS3Q=;
	b=tQT37YGOs96pX6NSX7FGJ+jLd0Hy8yxnHrR29pp+ewrDHxS7smqVNdMSzh0GYKw71LGs
	 35D9Q4R+rNkyYUSr5dT0XJv93y2RI+bc2NM/CDrrwt7khPBU189oPToKXlVdztBrKfF2t
	 WpeqeCEgvWlk5eMockbK3eLW5GNrx5GRuWSlSzy7/F6cRoyGk4De+4R9jLJNc/3x35Sm8
	 SmI4WvweVrb69yHTZqKyJRqKfTJQHTjX0I8920L7CyF1LEYNI+rez+HMnI1V6xt0lDrl3
	 NWyF9bwrRbG0mU5cdKXjM+WKcwU1fvMUpVzT8lz6vdhhBkzk17dyRLsQko/56vM59pA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lOUI6GVy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.38
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4841A606A330;
	Wed,  4 Nov 2026 09:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4841A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=lOUI6GVy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpSVUTd28fgzIWZfEJ8VNYv7qPWxytAHaranxWXm86ts9DTxxpwdnGk+vVfMRv1tLQK2VKAPKugqOQL6dQxJvW+i78fbBOwKenJKv6wC2b+0wiEuFVKuTbZMWgB2CVsc1nOkn8YK7B0oRMrUC+V59TZlko9GRyyxScXqflGGC4YC44mlY5jgWyZwkglkGCdwhDhYznkgbeBitf/jNwvbusJ5QSyx6YxbAqZ5FtsZEd+OV3K7SEAVstnylBzEza60a2wrWvjZOi2Vj7fu+nFFn6EGrf56O/sAxxe5Da3b+zO1L5f3hQiRbnZMV2msBWvYa3BxMNkV0UEm+2wfWOoegg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNt33f0lPXUGVjd4RjIPp3s7kYQaYGmYbx5TxdAcS3Q=;
 b=HJewqN/6anLlef0t5lQXFCnWV80EUEOeffDmOW7pvQoygnGTSUfIwf84JHSbrfkMEPAHrhSPsUiP3gKSC56W2di78dvVHCsDYq46UTr3DyJvrSzFIchxAhpdbcc417Q7Ob2yFf5Wgfu669NyzZLIWZwcgn7aXPP0p541sXtLwq5tOu0GEWZQ6PAVqvS6Rvyi7P8Fc8rcJ3P7vYsLfIQFMAlAh9YI1LAkYi8Uxw9WyfaDAgKod0TdBCid7u43wRHMDFp031jcGL4pRi7G+REepPQRz1+CUhpfa/q4qALq3JhuUNJMFoNqQHnkcJxragniFrrdSibalvc6Vj7abThXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNt33f0lPXUGVjd4RjIPp3s7kYQaYGmYbx5TxdAcS3Q=;
 b=lOUI6GVyCLYmMwGVrpkXXW9G5AvNaqfWs8TPR51EsZ6iBoESWJBiGWzfpHzeWbMCTortNzGb3DkdRz1SbvVY0m/V/oato7Mr/nkxa08SszzE47ZqEVBcwBBXVWq0MtT0Ng9aJx4ZwiQ9uQWh3PYYIaPlx5XN2LFtfXbnG1Krpb+LK9i3p4XTfB27hdw2+WYZ8Q65QxpiGNbu/ZTbr6usU7fZjVmjHNhtmWcA2bhXm91qJkO3n2J8T2g4cpjuQ10kaqfLzUF+JH89nJgG2sjnGQQMWuBIYpfl44I9fSc7RhSSijhTMuTD4bt13ybEJoaWzTJ0zi/9rXn01UHXWhgi/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from BR2PPF9D47B45B4.eurprd04.prod.outlook.com (2603:10a6:2d0::cd)
 by AS8PR04MB7494.eurprd04.prod.outlook.com (2603:10a6:20b:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 09:26:50 +0000
Received: from BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 ([fe80::6e42:6ee4:6b13:69cd]) by BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 ([fe80::6e42:6ee4:6b13:69cd%7]) with mapi id 15.21.0546.021; Wed, 4 Nov 2026
 09:26:49 +0000
From: xiaoning.wang@oss.nxp.com
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH net-next 1/4] dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX952 platforms
Date: Wed,  4 Nov 2026 17:22:14 +0800
Message-ID: <20261104092217.1730351-2-xiaoning.wang@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104092217.1730351-1-xiaoning.wang@oss.nxp.com>
References: <20261104092217.1730351-1-xiaoning.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0074.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::10) To BR2PPF9D47B45B4.eurprd04.prod.outlook.com
 (2603:10a6:2d0::cd)
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
X-MS-TrafficTypeDiagnostic: BR2PPF9D47B45B4:EE_|AS8PR04MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4abf4e-0006-426d-2738-08df3a55c137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|261021121427099003|261009223027099003|261026121527099003|11063799006|10067099003|56012099006|22082099003|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	p0O62XE/x8b5Uu8geCyt0kd014mEVSvKIjvuAvK7/yQX7XZVrCx9xsb3FKxoYzNgyz1TFKtqyk0mNs0bv6ddiZcV8JqJJpyBLBWbucbLDGzW4QmofHmIO/bEPzN4jgmG0jtgkiWKeP9RK/1Bx9DhxA9kEKNjn3gYxAPW8FAWIgFRQKH9s8FXfi1/jO7yUgWd29SyMj29rWSVOWa9ROsiOARpsnQeZpJcYVNJzpyfyEPoCaBkPHeKcqM7t3dWGOWrMYokEKPyZVqauF7TVeRAg7vf1nuSMM2B+k5IPUoFtoDwMWM+b10+YWoY+Phn4okdRjX48R450a3EnIS74HQWOhobMU0hf6vVKiTJiIjLka4s8ZwoKiGthyOPf7myJvq19Tdi9araJOls52ndd/R5vy0gUuNYbdmeR+8IipoIXov9S85gxhivq+8V7OicIEFPVYlVtRd1TjG1yg8o23PPU48VXANFcpVkuktkg7A087wW0Tnc5mKAGhCoiOfBY3Zs6pblWj3Epz6AfuxaAqOEotnz5rqetJmrOrS0T2SJv0u/vpC7CZZMpXVR3wqZwpTU6jmHtM/DYo9jz/ZXmuq/u3ety6wq1gIUimBdkYeSsrxvAHtMvQeYBS2QJS6l/a6/mdrHU7mZKecLFVJnpgHLv3MrutkJEgc9Ec0msCFRWls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BR2PPF9D47B45B4.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(261021121427099003)(261009223027099003)(261026121527099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UiqnlHvny0UKdD0CZAZC7TaWz78QEFFchZJEGbeDOQbyddWsntaZ8EcuQGU7?=
 =?us-ascii?Q?kWn9NrJ+6bcivlG+VfhGSWRzjLfZFCWu8EGykfF29xZqY2S2+sGuV2Ag5Go8?=
 =?us-ascii?Q?PmSyE4JdyANgacuTzcFfSxMkAN6AMJPuCEFKj5DwxDzgLYKYABxqR50xb6hJ?=
 =?us-ascii?Q?0T0OWR8l+rLoBiquvc+P+z189UkzIlAYDjdv9bQfdcZp2pBwR82/ILgEb8JR?=
 =?us-ascii?Q?C1nA12RXZVQcPJyprGt9J0zqV0yoBEpKjZX1dOaIfSUuhZtFTb6Onm8el7pX?=
 =?us-ascii?Q?4e4eyo/e9RboDPGf0pPPm2an2XXm32ypxALgcg9L+D8t5KHnLZ8fwqv4E92/?=
 =?us-ascii?Q?rd4jntvTsXgFX71hTEC8O/EjxPJAADevPvfqaINVcWn19GLrlMICRFz+z4xZ?=
 =?us-ascii?Q?JEKH7BOWLVtlfF/04L7P6Is5Vr6AWkEGnOEV83vojRMSeuagNcFUgwZFsvlU?=
 =?us-ascii?Q?QeoIpYQl2eUtJPwz5w1MumbiuMymY0Jwxq133pfjjrcG0sIasYcGRLkUJ7FS?=
 =?us-ascii?Q?CrxnNaKEnbsWNyDR5ehSRJAUHgN5ULv28Rf0K/RBwqdCup2IhgTbBr8baRnU?=
 =?us-ascii?Q?adHYVMXSV9plKSntkDMVDSdm3rTao/j3+7li93wnLsPsx6hehPUyRVmjjE8P?=
 =?us-ascii?Q?y79tqD3AMy6ZLrTmf3lWpinYjqzEP6EbRA+4CCEvQ0VrgwBuagWdksQLO6Ih?=
 =?us-ascii?Q?BunnwE4NK/UtKrdCbJPra2lL31kNUcvOGsMSEVqWNv4QcG0PhnIFSw50U9Qo?=
 =?us-ascii?Q?POgd/T+ACTJ/bkAyuzwJ2NzfjmlACPqNcaSiC0oGiDPExphfFDnYOxiXDbMZ?=
 =?us-ascii?Q?pizOLlyvhNG5gZn0LP5iGedTGJ2eteb9QUBoDvyVa/ettgLMD7hagafYGIde?=
 =?us-ascii?Q?gFk47/KI7mlKl+5NlEWluGTCA20jcFjwUYGaVk8ttJN+2qpiSCqRyAlxG/KR?=
 =?us-ascii?Q?xARISUqBFjxPo3gTinZinyNrJ+gKZSz3BdaIkH0qdgt+r1ydO+zoXJRHLl75?=
 =?us-ascii?Q?OGSagLhRHWnNlB/yhlb7hFk9jJIRvOdSILaxvmB5REYpeuq4wcAObpCDpmIm?=
 =?us-ascii?Q?GCnRbH6gfSiNXTjzFlsKClwupGe+oLVUi4lvI6EpUsnYR8atGIwxAFVRQotZ?=
 =?us-ascii?Q?0+L107bUY6h3TFN80AkK9X5iV7D6fhm+zJDUHoX4V08wK4fKeTvWY6uWjUxL?=
 =?us-ascii?Q?DJO53Uwn4STQaZuS+r1jjvFlvL9ZEg9S9/HfogD8nqZafGgcRUdq1WyJkvW9?=
 =?us-ascii?Q?0YfI8gN6I7ZrT4A610oVlaNpv9H4ccrHtXH2TBngPTRgpwmJNJawfz/wehrD?=
 =?us-ascii?Q?cdgbdOQtkgMZP1wVioW7FU14MluWz8C/zyA0atWOEUfdilML9xqzQ4TCWS7O?=
 =?us-ascii?Q?PK1i9vzQ/Nvkm6WbVuA1PHS6j53r/TI5PSkM27g2wtukyA14RRfcEe7D0+1M?=
 =?us-ascii?Q?4L3TstMCMoS82wLcH+a/f3qKmJAI/ZZmrTw7LGejkAcD6ZupQCwajlvKv1dt?=
 =?us-ascii?Q?J0h+JcF+7pUYsDV8gODE1mdMTFMbt8X6A3+/ZQBDYEDedJD5gpd47GcFkrXx?=
 =?us-ascii?Q?gg0wO5KQd8YFxJ7QHzdIAO4axETgCBAZ0L2qHp8qqMtmRcpMFKSPgGoROObK?=
 =?us-ascii?Q?zfXvDdliOHBul0Nw/hjpq6RCAnPvoROTMAuQPZXj9kz+qtfgBt+1adDu6fnR?=
 =?us-ascii?Q?KEFSXmXC24JA2+vQ4eqVPFn4gZ4PcvTGI0CPhMc29tNRntlE4KfWhnU0tpt4?=
 =?us-ascii?Q?Hs8lE5p3L38zD0rXEyMHdx3pTnEyMBfrIUw7KLUSoh68d5qb7gMw2Gw0Vpkq?=
X-MS-Exchange-AntiSpam-MessageData-1: y/kdPKGZxBRxyA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4abf4e-0006-426d-2738-08df3a55c137
X-MS-Exchange-CrossTenant-AuthSource: BR2PPF9D47B45B4.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:26:49.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shF19vslbFN7qFe8zIK/0med7M1gtqloBBmb7R+mnBVRIkKqjgrT0KB8aS45j6dYBqXdfvWkZKiRxRCzArDu7QTbd2RE0O9/qYEoW+mJDajcH7QHYbhrEPL0iOjbmKrS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7494

From: Clark Wang <xiaoning.wang@nxp.com>

Add the compatible string "nxp,imx952-netc-blk-ctrl" for i.MX952
platforms.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
index deea4fd73d76..c443fe0b4693 100644
--- a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
@@ -23,6 +23,7 @@ properties:
     enum:
       - nxp,imx94-netc-blk-ctrl
       - nxp,imx95-netc-blk-ctrl
+      - nxp,imx952-netc-blk-ctrl
 
   reg:
     maxItems: 3
-- 
2.43.0

