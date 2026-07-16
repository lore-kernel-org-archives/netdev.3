Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E2344D9B;
	Thu, 16 Jul 2026 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168440; cv=fail; b=lHq9KS2gCmYAxtf+DyMvlYw1TKvb4zMmIKFbJNuouWF29u1l3fV8nwvvIip9UWVLvjk/CTZjE6X7NmTkWiX8+tiHdmLrGXAXAmjQNOjaPZcv6D1U/LQHPEun1y23pw2iFZCN+MS0xWnUmjDNM6pA5WTRzbqI0baiwZlpQXkHlxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168440; c=relaxed/simple;
	bh=/3ataOWxj0mL4BXqZ9L6LsrPqjMbiHsvzKkCCb2G4fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AP2tBJH1p1wG8GxtuWRuSqOfjJ6PKLYH+2nvP9uVceGuXqnZOB7AfSkKJ9BoWifPtGHqdt5ehaLLLpCFb9jHQ6SvtR8koLdDUMQxe9nik2GnogLqJ24eMU5aNHpYmCEych5JTE5Tmx1yxduDagx4yfSHdvdUyXfQpvRKrPpOMNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cUsGEB17; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cUsGEB17"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHNQS+uCNUdaGVO/m5kguxyezo+lqXirLoxFHsl4aQGaxu3d/5yMWPL3qbP1TAwFpe2y/2GCTzKcYhhksoQaSWHWNQC1y8K7cMrUPH6Rcvas0KVnMRGBb4BMXNKcnB5P9Xib+DL8ke5Q4vv+Kq12N6D16W5bsdl3VNyzxKGsWQly7aZfGRtnTzEYVMp2cuHtDNAinsMdzA9zC/97K2NVT5riian98ciE2AiWb80mx6zJjm9UnBBn+YmAojJCpaBIrr20ch1QBQqNk2lcLOFQB83Mqfhyy/En9fK68lDHf/0QoXH7BviTd0iOIz3lyOAwicNoB/2Rxm1K4d+pODjhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moL0ri6QyBkfQ53ZY1ahhuWRD57R6Bf4Tf7lHb+JP8I=;
 b=LUC1Wyxqx2qStC12/Ow7b7HAtJT3McflYhx6AbNTMDCM1r7nrXufcXlMF9ejoP2+keDaSHX63Oy+GrfqbQRVqGJe5bB1Zw5Tkt+xUU5g7e8EF31O+vam/yjhmttI5pVRexoj5w7ojZa0GiNwgOqKUayzyXrBDHXFQ+YdSpSS24wi7+DSnYYquXngQQs37zYJzTTQuQtVJt0nRT4uFOacUHlo7y8NEpjDAQV5PX87zUevUAysCkYRgWxUJrsGONeu4qXNhO/M5nRoi0Ybu72mNQG5dAo2M9P148EWlCp/dFXCdBtrIVRqqk5vU6Q6/62PJnpPG+sMx2k8HiHopbXDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moL0ri6QyBkfQ53ZY1ahhuWRD57R6Bf4Tf7lHb+JP8I=;
 b=cUsGEB172lkvNWkF65tpeG1Lyjr/HvT/2sMO7iS932GCnPpev5vBv71mHYisESGwVnftfbgTosiMDZd2Ns+PbVFTnaztqETBwJA2ElrTbrQ/4AYR3PI+SpHPHcbROncTDxTtcOYP4MJgid8gyIm9dgql56KfHLuMQ8GazUZHCoRQqWxFFOrJW3OgnhvjRhqpOtQh3kuzmwDVq/raxQJYhXrL1XF1lk1FytIU8R3SdD7wR/61zfoatfHBV9o7Ni1MHC2ZwxXkGmQX0aZt0AIhzQtSFvjRXfTAvzXYC0czxoA4vPyAfNBSMbBf9e14Er2etJsFrHKR69xPsDAqULBH1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CH7PR03MB7884.namprd03.prod.outlook.com (2603:10b6:610:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 02:20:32 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 02:20:32 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] dt-bindings: net: altr,socfpga-stmmac: Add altr,socfpga-stmmac-agilex5-tsn compatible
Date: Wed, 15 Jul 2026 19:19:31 -0700
Message-ID: <20260716021932.20037-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|CH7PR03MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f215eac-11ae-443b-3f3d-08dee2e0cf8d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	p5BuYiydr/J1ddXkx4L09L93ELh8rFlNH2pgJ3AjxfNbjaWFSOmnuEH2VY6oqxk3dyME122QLf6evvsZokxWUpRild9p3HZLgC7fRyMoAl5SrJsNQxttcR9G3yM7CiwQKRi+Hk5zrEPHrOftQBhJqJYA4bxL5XXn3s5Ez3Y91Z0zZ7zZQ1SOqEBlzQZF1iXWGkkxglFoQ3gFYtUm0skgIWmtTiC7QkPoTv6wmHkqZYkEmMtphma0xbj0OtYaHTtBMSFP1VAzsIfgDUbfL2sCexLTTEoecnMwqeFqPplD71zBkSkOWwpfT65ThydIhERIZQV6aKHMgRycdEaES2h2jTXeBHFrw31ADsF5JJ7OaXyQyO+H18lquKofOfHby1iHY1OIdwBtg+SCTKbS5iF6yudncFJ7YaRyngHCKhE7KHtE3I7bXqw4ZukaoekKOTLiXPcoNMqkwMKj/mh0KSkDxRZJwAb3+/86p/UTFcM9yalP7UMjC1GAiN2eSVxO/OzJMRn4isSKAPc7HBhhf87RSc3LJ+GqofYDZxuFff5mRREnhBT6voa8j0Fw66vsW+RirsN/SW67gPYNXHNAponr1eGc3aMeecwFegKKm2zwNL8uxvvIImK7/Fs4J6XkHW3j5pmu8z7SWVV6kq9XPPmCW1Eq7gufjBD9rcww0Kt29hI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eTRQIqSro6X6qhcPyNQPZlBTJF2sO8dWJ2eiQPJoUlA/ZkipoG1bWBB7uIWl?=
 =?us-ascii?Q?xA2l0J0R8k0D4jY1fxFkM2kVvVVL8nvHOth3/4H7e1D0Z/D/A8DhHVlosAuZ?=
 =?us-ascii?Q?F5m68IbV4RGwqLbKegtawlwVgwtIzdyeKzVttcCLh3Fn78vvjMY15kzlgtql?=
 =?us-ascii?Q?ZW48ZVxnz78lItTfcYlwuXKpN4jcnvQO8mAS5jFH5+lJpd+QAeyvwc82H28F?=
 =?us-ascii?Q?UbFy0bRK4bVtfMYUhBUEyGR1bhDAlcT/KYq7QXf/OuNjLPSOVMFIMamN781E?=
 =?us-ascii?Q?q5Blg1wXXZqmFyYFhLjAKX8Kw9o2AJWj5KxZFUoSPY4MeArpINUdHXjj5WRC?=
 =?us-ascii?Q?8gBf1B2IsBc/CH2h9f+uU4oRU8GdV3qNuJEowONAXO9C4gal8xOJZPr28ec5?=
 =?us-ascii?Q?NQc6W2CNbJw08hosQ/iUyuLs6oJYPeyI88WTU6N1Kc+OIBUvBTOmLcJRepW0?=
 =?us-ascii?Q?04CuQbXfc3RVNKnMfhPPiMlrjpnP/a7ooOoAe7WY8T7HJkC0BDiVLUq2xWp6?=
 =?us-ascii?Q?42uZIrGQVlZP+ilm7hd3lbFH1hPOVRCRcKlewNByTnTORafpv49Lb/jSoCAo?=
 =?us-ascii?Q?4ZY07WY1LeRnlnsBU3W/27qPiRE8yrQUZoxiF5wTH+dSag24f8SydR1HPTzn?=
 =?us-ascii?Q?Cm5G1UpUk6Ah5gN02s6Y77Ns5U2Uz45+fLBpUQaWL8KsEJfIQ8xaK5JjvUW4?=
 =?us-ascii?Q?Cx6H/bicQcGM49K+mKPCcBeXWwI1+kt7lCWSe3SKzApbE1626/QE502Qn5NM?=
 =?us-ascii?Q?kXfhk4FwKxc8DeZiOgEHX31il9jMewiOBCzlLuf3SFGcjbPs492Z64zSwvls?=
 =?us-ascii?Q?N9xFPgUGrBBB4mGOFjIDeZAuuzr50edpLM26byZkFusp8VYEfc/UUlm2SXeX?=
 =?us-ascii?Q?3QxhtDF4oeC3V+Qkzj1mx33M3vAUReIWk5QQtvkHcVxFrq0YofU8f/8vjn04?=
 =?us-ascii?Q?JdUecoPojC12+KxMikHZUk+AdRgh7hhPttAmoAOvBFMp+ztmf4SPtZTdt2o7?=
 =?us-ascii?Q?YqJwngC+rCc8+3XLvxGZYbRXwMTwqkgA4ECqYOJ3/CTyRr0RJQdd6unJA0Gm?=
 =?us-ascii?Q?JxzLUEsHBjF1Us36R4EUXmb1X/3mRMu0dD8H9hbWTI4CrewC2/rJp8HgPNUi?=
 =?us-ascii?Q?9g7fQrTBd+NhSDvJTy77LwnizYHdUMdMr7+2t6T8L09eRB3xYQMKZuLr26nV?=
 =?us-ascii?Q?jKa2LFB5M/npizUWzqnUSZKcY/FaofSGMyZhXQo4y+ELkKRHKn5uTsq1d8x8?=
 =?us-ascii?Q?0WOC3rMDAu2/V2BgbvYFwbkLKUjD22Lpoit30J0gmvi/qt+8xtYHqHZ8IO2n?=
 =?us-ascii?Q?IkB8Y/MCB52g9BIyg+KApyYVeE4G/63fXUP/cGb/SCCqjhEftuyU7l2+MPAc?=
 =?us-ascii?Q?vLM5BXhxZ5ypVM3DIyB0raAmY08qMNqv6WfpGur0FiH27jkMAWnuNQT92Cg1?=
 =?us-ascii?Q?rHA6X5cO7rnYv9OXnYHzGbMbZeG+ZmuDxz7KkV2Cd6wApjJpjpEcnTIxwlFA?=
 =?us-ascii?Q?1iN3BjmWdY9oX6nuvW2YiKnKIv7AehjTY/YMR5n95eaucKtJcJWjbkI7OTGY?=
 =?us-ascii?Q?J0y8E36/Ui5R4haZM5d1WdD8EiLkbaUq1dgP0bdHGBwBXAkIwd4HEnnF3zLu?=
 =?us-ascii?Q?pE2ob9e/qPAxqbxwwzpYUHXPB83Qk1wKRCdXH4b7LakcdBFBvsaSkphX9L1I?=
 =?us-ascii?Q?26+IyOMdfArZ2yXj0nOu+6SSa8hRIOedrf2ERH3IZsiOZDD0pBSOjN+eKABx?=
 =?us-ascii?Q?dAOIdnReWxV8xD0PMaGseohVLwBkTSk7FF2dNGfKh4+WBRSeyouUd8U28eID?=
X-MS-Exchange-AntiSpam-MessageData-1: lpoeXDHjkCDdaw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f215eac-11ae-443b-3f3d-08dee2e0cf8d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 02:20:31.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9nhvL6VWgvpvJIr3BaAcYsuo5mEYzZPx84WzXSSjsZLMx+r7UEp80qeoLpIiXklAFj6erMymOt7OPkj4V39XyDvf2qpadrUkD3iozTLdUsTmTXx4s6bhhmj25qTCUNCoFI8vj6FT9YCDH7nWXaYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7884

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Agilex5 SoCDK TSN Config2 board uses a GMII-to-RGMII converter
implemented as FPGA soft IP between gmac1 and its PHY. This converter
provides the RGMII TX/RX clock delays. Document a new compatible string
for this MAC variant so the driver can detect it and configure the
interface accordingly.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
v4: No changes from v2.

 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index 63084f762373..81f030986fa3 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -24,6 +24,7 @@ select:
           - altr,socfpga-stmmac
           - altr,socfpga-stmmac-a10-s10
           - altr,socfpga-stmmac-agilex5
+          - altr,socfpga-stmmac-agilex5-tsn
 
   required:
     - compatible
@@ -46,6 +47,10 @@ properties:
       - items:
           - const: altr,socfpga-stmmac-agilex5
           - const: snps,dwxgmac-2.10
+      - items:
+          - const: altr,socfpga-stmmac-agilex5-tsn
+          - const: altr,socfpga-stmmac-agilex5
+          - const: snps,dwxgmac-2.10
 
   clocks:
     minItems: 1
-- 
2.43.7

