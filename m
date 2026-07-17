Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010004.outbound.protection.outlook.com [52.103.12.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B637AA98;
	Fri, 17 Jul 2026 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259837; cv=fail; b=H85TPwTcUyi4MK6IATfhICahWT9HBPW0W9eFJDffce1r65gptpMje0RwgYVSRuJ755zMM0j2G1jL9Flbn7kC8u4cCUOVj6Js2p/+mfAhcGjhsg3Xd8JELD9BTLaQ9qvmEltOCKV2uovQ/FiK2i0C6OUeNL7wcjt6F2HD/Gpritg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259837; c=relaxed/simple;
	bh=gp5CIgmSfCUUQeyhP44yCJJyyOsgyZvE3pMTQDTtOgk=;
	h=From:Date:Message-ID:In-Reply-To:References:To:Cc:Subject:
	 Content-Type:MIME-Version; b=n0PclQBG8FQOK2WaY50vyYmfAomPrD4okr5nw/aUbUqa60PWeqHH8avOiOweUEdq2dU5ju3A2qzwUHTyj2vu4WN3tn8aBGMiic+dTB6DWPNwBvAQJtXsIx9SvOrd1iaidA/5AT/QaypG0XFj1RH8sVQeAF1UjMpL8p1C0f+OI7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jEoQ0k7V; arc=fail smtp.client-ip=52.103.12.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jEoQ0k7V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ik+BXes82awwChLQW91vTP5s4uIqWTELDv5F+nzfj/iIMumJoON9XABiAlwPx5KHfy57xqqh9ehZzTOM3t8fvzxsPLdafgfi9siGoe1/aIwNCAxfdBnhC7pQJhGMY7VV14LfFD2f50CJdbY+gYcXpAbmUQWr9uLAST6PqGdThxFoJut1GFoHrxYwCsw5kMWR7dLHcMz8O0ehplUuLhY5Nwpi61raSU8zTnqGJ+jQSsiuBvNQsAzblqT74/0Afbxof07KFW3j7Co2/VdWrSS18lUGBOnv8zCgiAbMUhbp5cA4X0AWYinS8j1LfF2ODbGLqsDn9bxpmk6OSX7/3k0JLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VR3LEi4uLUifQrGEn7/OyBrPjnvcetzHG+1tq3Vn3w=;
 b=y+2wvQjX9In7rzB+QS20eAdE9TLhLKpRlSjbU9jt5FmpQ9sGP5zeUJOlHQWNc/VkCZdYeaE9DxIhDB1taGqp3rxXi7Pf0+HH6kCvNo2CqHrhZ0OHG6JdbHl0qPA6wU2O+FJHqG1UTV2bJVaU9ABo3NY00+IDuWyxLbHtkwlAIw1SD/znrUkcScNKtVAzoWOhuHOP53NhUxA8QcQ7yS1ZB84DD7BWMXqNCjRwKG/5yK3/gR2lGtyb0tI7XnAVIPorAPaExiQf+f9ST9XrOwEUagZf82jCWso7+DozhSCr5AUAKO2m0C7VpDAFLGt0DpIpgEEZHw0blvYhyTJS4cFhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VR3LEi4uLUifQrGEn7/OyBrPjnvcetzHG+1tq3Vn3w=;
 b=jEoQ0k7VmZ3SpYcc/cskkUNnEUkBD7QinvzoVOjLWV/psZUgylcIqJzcYjFrsSOTR0Q+G+LWcRQlMAe4LfFHm98p0sONlayLTnArlNAbrziY0PLYECyXMFZQ3EUshjjInf0WQCkQriXAUAbHCNLZTIsf6XpJJLOXAUTOQlmdnev8u6DJ/jGvPNgZ3pqhN/YfxvglL1LN8WcZu7ZIdY/grbvXs9kLevES3OCAJB2pG07QhlUo2gBVpE0sMbwICA/3oR1UeHivSNaBbsnKoqayxpNsdLC6NtIJ2yHl5ueyLdBwGc0fXaYLnmDLLfy1Iw4nQIW99eN3sTFfsp0vRB0+Ew==
Received: from MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
 by DSWPR19MB796710.namprd19.prod.outlook.com (2603:10b6:8:3b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:43:53 +0000
Received: from MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374]) by MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 03:43:53 +0000
From: Liu Changjie <liucj1228@outlook.com>
Date: Fri, 17 Jul 2026 11:44:03 +0800
Message-ID:
 <MN0PR19MB6091F865EF7FE6AC1EE41C10ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
In-Reply-To: <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
References: <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luo Jie <jie.luo@oss.qualcomm.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] dt-bindings: net: Add Maxio MAE0621A PHY
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::14) To MN0PR19MB6091.namprd19.prod.outlook.com
 (2603:10b6:208:382::21)
X-Microsoft-Original-Message-ID:
 <df7aa19880c54356b921eab791f92075.1784259843215269.tspi3m-maxio-v2-1@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR19MB6091:EE_|DSWPR19MB796710:EE_
X-MS-Office365-Filtering-Correlation-Id: be8b6c89-7aed-4262-cee8-08dee3b59f36
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|23021999003|5072599009|37011999003|51005399006|8060799015|15080799012|41001999006|19110799012|24021099003|26104999009|440099028|3412199025|40105399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnxMGKpde4Dl34mOdeSOYeHO7U1IEqVjgH9mCPUutiuQVzpsoEsruvP6SImu?=
 =?us-ascii?Q?F4dtmmKNGxss+xF08qs3WIbgBdal70FXDF/GjAYPwXMyLe9H8eiiP3w7j+VY?=
 =?us-ascii?Q?dF3XFauF64zOu6Ho7/AwQSYLImeafHovgnrtL0+AcbB71kxsoQiv3mvxfqB6?=
 =?us-ascii?Q?Y1w4mfUrquOxyMWfVKEdMCQRkGMtAAMPoa80PNzW1H9448aKOrEV1cDCdPyj?=
 =?us-ascii?Q?ViHlVeaR31FQfU+eQ4tpbh1MlRsvMUi0VlbXoGzT7rKLPGVi4oIowYFoeyGK?=
 =?us-ascii?Q?HAqN/FAIZB+dlE8/3di12YHKeWK1QUw09QIoBsBuW58qmDCER/xjoZxmBPdA?=
 =?us-ascii?Q?0OPk88bgEyJ+o0CvLHohvAJGP20uqgBhRGTWx34sTlCDjntIZuvjdXFz75O9?=
 =?us-ascii?Q?8qAlXjWdqSgmeQrLIsZvRh8tK540Hxic7ybnq4q1XAKn5UVubyZfJ0rQHSmw?=
 =?us-ascii?Q?zYN6q/7q9DboR3UCMYKdIVkeU4ptU5wcXGAF5BEkIwRWzGxilDM9X0hK2QTf?=
 =?us-ascii?Q?Ns3k/gHDdUAvsQGrAjE8b6rtV8OHnZpjitxjWRdCBEJn7bS1IftJYkGrYGnA?=
 =?us-ascii?Q?aAZkOMcI5W2uKvSmqJboR/Q8AM4mni5mypQt2nNmD9wbVU1SD9NGJzysmFre?=
 =?us-ascii?Q?JkdsYi9u+g0OT7C2RiRpQDQZmgAQweHBlPiIjyh5XnxlXmyfn6hSAOG92bh9?=
 =?us-ascii?Q?+A3vt1f9nz4IER8o99inJVETGpLFLANbv2Pa9cNqwJmbslOKQdKxPRQKNQt7?=
 =?us-ascii?Q?iUYV+XRSmEImIqrLf+Shnlsu4rbr3y/sA/xH7jW2JElYXIUnLrHHMXrP/CIS?=
 =?us-ascii?Q?IwjCJ7pXa+ZP9vEGw4sw5lnUPbn4UYv0WvS2rHCsTBynrdihsy8Nv4uFXq5K?=
 =?us-ascii?Q?6nioJMczeh9OgJpSr5tY/ywm8s1+/bDcIcqYOqYJV2Vrkj5Sh61E9Ft+vtir?=
 =?us-ascii?Q?OVHu0QTy3SgoJtxZ3kidy3RoiEqaRfvlyj3D3n6i7QQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dqjTcRQdiqqR5+ydFRwL1glQD+8gzQN7CKh4vbO4BcOjhxFqmgVe8jXT2djK?=
 =?us-ascii?Q?K0J2KhPAGanlRLJeOFMpC13wZ+7aI++pqQD++KbsnP7A96K4aU3LyH8bRai/?=
 =?us-ascii?Q?Jz1lhk8d9zSTpKvqqnZyY28ey6cLZJeBnKcdtgIsUT1LIcEJO8AdSNR9JUsX?=
 =?us-ascii?Q?V8A3NNniwcbeokEuj3YjMxJ/8OK1TL2IFK1kAl21VIPb8+6Wud7HgAGJGL86?=
 =?us-ascii?Q?HNL7L5KVgQJ0hakODjk8dmdrA9RKbSp9jCG7p7mUfgpTP5cuiGlt1/Q3KFG1?=
 =?us-ascii?Q?TvR9auNUbmd93JH5q34Va7ZyfGo172S9PAE5tZGcu1Sqmvnmh+1tzLhhWSJG?=
 =?us-ascii?Q?QbVIFz9PfGja5I8lOPfNjV6qwfUlGkym1/zdhxSTWty6+8URZamtqYpcWVUi?=
 =?us-ascii?Q?JCrDhDVmc4g5Kmhnh69OIUKDKyV0TTSaPeKI9KVKkyM0HbJVbimdehxQCCbK?=
 =?us-ascii?Q?bOABqZY2VNs9o8QtKFtPMeQok0xu0iLFU6lfHRd4PLSx+SARCTvPXfLqd/Kx?=
 =?us-ascii?Q?mCx9P3FOpPwQ8aG4Y2bc3DevxiR7mdUC7/TBYJ6wQNsRPrMCVLauWAuHMiXr?=
 =?us-ascii?Q?YBh41a1etuJvhIHZbRwRAB2DXN0ijm3Mpri5IUlFtDe9vbQOiD7StimqMeZ7?=
 =?us-ascii?Q?+rvSkxF8KUnUntvHgvw0kvbBFvWLQ7irTcVMzeYQuiCt+xDApDOsiHNSnWwh?=
 =?us-ascii?Q?fKzy3fWsXU/NDAwfRPMi2jwjAvR/GOtKF0Z7M0SzqKcEpEhomf0BMRRuie7g?=
 =?us-ascii?Q?cgoZW1sNgEaz4cz8+WrmIfwsVXpSp6x+vc6Mw/dNbVFqTUParGdoieGr9MAy?=
 =?us-ascii?Q?Wjyay0ZkNEalx/hy7tsC8rdn0lzVQWXHx1vefkc69dKpoSFUCMQgkMaoI9xk?=
 =?us-ascii?Q?H4aMDkAkv5hCsnHLQDVcAHe0kFS7jNgmqj9ZHsU9FPsmERHMgYHjxFXLq7Ji?=
 =?us-ascii?Q?Rm75fCo9oBNbLkk7e6EgyL9cBSE08l9jG0YZx/rSYoR0LWBZkl7RtV8M+8Rc?=
 =?us-ascii?Q?Q1yOQm6fa7J/5ayVBQAxsDTRealdQxNOEmVWDKq0X4u7FmE8SqQrEnN41DQP?=
 =?us-ascii?Q?zc4zCZpZnQzP+tawaG4gq+Qx12wOsgmPsVfjWskCMc1/QW7x4v5Q0DAZz9px?=
 =?us-ascii?Q?bnsgjUtJsuC52TCCn+EoEGeLSPOYMWLfg4uC6eCXMvpvFArNV2IoYIXyQiHd?=
 =?us-ascii?Q?oEAn8ZGw/S4d8FyHERypJYiHZWSO5UnxVAw3nA7RbkfIgCWzmB0fHqH0/0IR?=
 =?us-ascii?Q?pQwPeeEgoaL8V/HXsnsslNr7SuOuJ3knz0uYrTVhbXAB5VwLthagLOjfkhMK?=
 =?us-ascii?Q?pndx95nTDtxQRVh2qDBRJYm/X2D1UWAk31hLWf5QTvsRi6ixZceOkFtvcPMs?=
 =?us-ascii?Q?xRpMsIjpPnKcRPLN13v0Wl7xWwacfoZKoLRMmF1wzVA7j2nLUw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8b6c89-7aed-4262-cee8-08dee3b59f36
X-MS-Exchange-CrossTenant-AuthSource: MN0PR19MB6091.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:43:53.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR19MB796710

Document the MAE0621A PHY ID and its optional 125 MHz CLKOUT
setting. Boards which do not provide the property retain the hardware
strap or bootloader configuration.

Only the 125 MHz setting is exposed because it is the only setting
exercised on hardware.

Signed-off-by: Liu Changjie <liucj1228@outlook.com>
---
 .../bindings/net/maxio,mae0621a.yaml          | 38 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/maxio,mae0621a.yaml

diff --git a/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml b/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
new file mode 100644
index 000000000..f1ea54583
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/maxio,mae0621a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxio MAE0621A Ethernet PHY
+
+maintainers:
+  - Liu Changjie <liucj1228@outlook.com>
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    const: ethernet-phy-id7b74.4412
+
+  maxio,clk-out-frequency-hz:
+    description:
+      Selects a 125 MHz clock on the CLKOUT pin. If the property is absent,
+      the hardware strap or bootloader configuration is preserved.
+    const: 125000000
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-id7b74.4412";
+            reg = <1>;
+            maxio,clk-out-frequency-hz = <125000000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 396044f36..eeaf0b7a1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1013,6 +1013,8 @@ patternProperties:
     description: MaxBotix Inc.
   "^maxim,.*":
     description: Maxim Integrated Products
+  "^maxio,.*":
+    description: Maxio Technology (Hangzhou) Co., Ltd.
   "^maxlinear,.*":
     description: MaxLinear Inc.
   "^maxtor,.*":
-- 
2.55.0

