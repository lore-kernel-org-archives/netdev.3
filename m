Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63244BCAE;
	Wed,  9 Sep 2026 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941170; cv=fail; b=oPacv2eckRYkTTvLfJb4QHC+KMhOub6NafY5QL1r6Gblns+b/sw6yMWDrUO+AlsLgA6CXnfL6IJ1nRoAXWyuq6ugBfuSYFMx8wBk3ZezOhs9dkmmgpkrUkUAyj5hy5CGvMZCJ7AKjXa6c+9IoTZWGNhL5q9GcbBry6ZSRRZjVYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941170; c=relaxed/simple;
	bh=wW6NYAj7DqffwOygaeIbR41u+Pw3qbmpnqLTkZzs7Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AIhv7KAOGNHv7IoqbXhWBLVXOWLi6oy9TLlXlB7uxhC4fHnazEjUS6y2mSUOmNQO8TwDz6fdHC3PDpI2VoKEULDVGMfoH3oGvVNvxBf1l+y/X1P8nKIONt3rdUmV0wcZbYLwOWQPRC/HWAvzPIsz/fnbRrT9KANoVG/KSSouoXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cfQsB4dI; arc=fail smtp.client-ip=40.107.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cfQsB4dI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0w7IQSKdAG5EIQmHFvynSPAL89R58/ArWB0AX6A5ZH6fF4HpPDy28PzWr8zHl70RMs6+Ke8Bu/XvKlNKoDYaY1bbHwyssOdM7d3qHDg2Op1tqDKNU8bjyFWAFn7t76GGV2Jus5iBt5yyBcC3Ipde3e7zCfBqOZE30s00B5e3e/arFTNsB2n4rpBOiVky9GvlJY9rlWH58B5iu2um5J0RsKrolYRx6eL/DUPQeA/Sav2j+GYTU+5IwyBCkckTr0yBBiYCTxyc2YT5S7gsaJTgdFbL0BD22yHpRlX0Sezv8gb6CpDRKHIJY1d2IJeglXr/3C5xrA/nEJ5u6ptbRyqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvfFMZf498Lb1Oyw9KVVYtUYSD83Ajok/L4/Ow1lUTA=;
 b=xVbyWiETm/ncHEQOBE0I3DiD9EaGGPpZy9sppDN9qGA6sxBV8t3PgTm0kMCFM2GAicU5g1X/xNz/tpSsKZI6qrnXXXx3EWTurjx2/CcksysfAioRQRoJU6z/YNtM5abdvFbnthyRBpvfw/H0zaLVGH0fQ+2kZQikGObNOFDnh3c70U0NJ/dCF1aHjwnec1her7PFUSznQaqFwOlsfjxTBsiaCFumvn5GwcdCSc0Cx7CPbEaaG5m9P6RBOFiC8sASQQ1XVyHcf3q2GgQjEM/fto7htsTUynqrYRNK03rEt9SF52WjB9AHEPcffaZIoGCmbS14PUI+N/8L3PsllJ5h3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvfFMZf498Lb1Oyw9KVVYtUYSD83Ajok/L4/Ow1lUTA=;
 b=cfQsB4dIV1sa8RnKcRPF81DoW46ohqcMDV/+so2azHkXKBob0Uj26GnSid6LSvHnZwg5TL04IcLaBVAqOrtwVkIeMQjqLbxLPtr0xAJvBSLP8muXWNxJmCPbLk1XffPC3g98gx2JsdWzrIJn+jWK6oWvaS3ZL4DKGk2LMI0WRs7H5bBNEI27nO/6bgWTHcF0jpUJtdRD4YSSI+qVCKcjRKhs5EX4DzZxVjvBW3Xi742fc7w8QyPM8zrGUONh4jgiQ/1L38tdO/+vg819x48IUg7NtK5fGKJLMveiUNN6nMvnmePgx5FL/leBxptospLUpOUjmx6dWIR3MooJ2tKHcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB6480.namprd03.prod.outlook.com (2603:10b6:510:b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 08:06:02 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 08:06:02 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: net: snps,dwmac: allow stmmaceth-ocp reset name
Date: Wed,  9 Sep 2026 01:05:59 -0700
Message-ID: <20260909080559.2028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f2505b-0703-4501-9bf8-08df0e493071
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|3023799007|55112099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	8MLcQFKvJdO+1Y70NYniJkB37j4qdf8za5A9qwLRHbEzGnrFt+5p7svTCNYyFLQhtuSmJR29mjpgkboo2R0UYIU5RuEiyJFGnM2s48K2C4TsjTbDDkPsCvKi/qPHRuUnmJtmYqyN0wqM1CR1J1Kx5Rb8eb1OGGknmxjNDYKhI6ojU+N/QrhHPN+XJLlVqGkX5sBdbZC398Bw2nUvnvBz33GYFtnDIYxBMR6h7/zvws8eTpl/utESY2ZyElBB43uSWYcK4k6tkOqTIRZIX61osriIvZf0TQgO/PfpG6fi+8sJ+b/bHVRTrro0lFw/u8uGUQF5PZ54Dv/PqLSBgPi+TS3fAOsFaqbCZOSEJrJ4R/2rEVxn/10auSN1JWyNrf4f9rAdfJSM/oZ+Kvfinq3Jp3uGrvwunsn06caq/N4TGCxu1hCcNJlHiouR8IYcd0pYHua8DA9u5rZRqFyXMO4aP5+/V/gnGBJBhlOdHBbAuT54ZF/2RzLA55HbIU1Yf9BJ1zslpWBCFiI6o/zEbQnnkFOGKCWoa+6/ayTIM3hv8o1/XEg45ATq+hM1GxVqW/WJlmJfK3EaY/4oOavOubJGgZQ48zoGWuS1zOPnD9OQ9hdF1PpyCSQfQbIz/QzdL3+MWbc9yv1q2E7a744dR/NXzu8xgWT/447mrXFDpN3NjU53nR/UYtiTi8Oc6C9VBO0pVbNO9EFIQgmBNrB2zoNjdA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(3023799007)(55112099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CPYezuFF2biPMBZLMq2HI9T7TJzphjk4HFCdSAoeVT95jhTjlwO8N4yfs29r?=
 =?us-ascii?Q?cpa9YtW5YvqlhyflPOjnSdELsIVsDTBm4Rx4/1mlkZXtXdzepWuPNtqxe+06?=
 =?us-ascii?Q?6ZVbkfn0v8Ltnde2g0HeKBUVqm5UAcUN/vfQGxFnKNybnjRaRs4v/xzfxZoB?=
 =?us-ascii?Q?qGTmrhYummTt9pQCIJ6gxOwSCFr380tyCSgVG+WV5lZ78tmu/PJr7orHRDBh?=
 =?us-ascii?Q?WbwbTBpFVG+8ZSMgqcbVV+mAWXop7LJOzDNe2N4wxUXtm42qZATNqNAueKzb?=
 =?us-ascii?Q?oVrpuL5F3nEWTeFn0vA6htJq193Pw9VSLkWeoEzlDqCIIz6OkIp+Glq7jkE8?=
 =?us-ascii?Q?LDsuS9SqpiK++UjkC+1j36kTxuRF8X26qh+T4q5mc9yDQ1lavgsIHSTkpWDD?=
 =?us-ascii?Q?VuIXQIcOevdFkZg2SbOSE/4CrQmPMJ8p+cHbLKEzu0H8IRxxx2SqPNw9dj0N?=
 =?us-ascii?Q?S7mEoMYq5x11mfgDHZaqi/3oQsteprC4El2gyB18yOsKOOw6fQV4VqhtyVrB?=
 =?us-ascii?Q?CfJ0ThkJdBxilNc7559KSTbji4876fK5FtSadxrIYyEAllO6dEfXp3DUw/pa?=
 =?us-ascii?Q?OZnFcahNdZW5HCrpaun0ZKSEuirkbwzzRq/BY5aX6sGMaO6CL/QAeF+qRcyX?=
 =?us-ascii?Q?SP/Wr6PM2qvSqmt2OjoX4yElblam6j/bJIJPMAJ3Z4OjB3fE2oiphAbf76mg?=
 =?us-ascii?Q?7zqMYEMMZzNvn0kW/z4+wjTt3BQK3E+IGyeZM4fx++HQEGyIEP0JQi6vrlmL?=
 =?us-ascii?Q?aeyGrcrKeumFCAd+MGFMw/V/NBKBkSVY5KocJaq7B0SQJld0STCojGUR9M9F?=
 =?us-ascii?Q?h+uuSEnuW6yeoIdoqvKSHhC6i11+Sh+v6jFxBlUiGgQAAdt4E7cpxVE3cObJ?=
 =?us-ascii?Q?+A1jgqJL3ciAkAqib0J8+df51fY5USKAxQejQY9gSnYnjNhqOHqfztp6hojb?=
 =?us-ascii?Q?hhFUBdxB7vTrWz417BfBkxXjsNUDasj/zrJFhbHxrdQiHGH4BiZaUK9Wgkw6?=
 =?us-ascii?Q?L4jwYauWIYNBKFH0lFhfxBu1sDggMdaPYusesldQLMg3SUsjd2yoRK0dzX2+?=
 =?us-ascii?Q?SRusSsVAzYULcOZt0MhcEQ9C59lkvigvTUnTYrSwRaOUr0cD1f5tZ5cuSDoN?=
 =?us-ascii?Q?JjnUqXTTAs3njCra039/Uo2swtMaK2sMd1rkATk+FOXNmZAtaZDAORULopRK?=
 =?us-ascii?Q?PeqmVrsJvnEpIkn6VIOwkKnePW33dQwfe09IX0IGSbe8lDhDfHGVZgGjl/Ml?=
 =?us-ascii?Q?M50rBww6DoAIoXohEMVJk6KXIYBw/WqcaYiFQowZdKBEg4tQRpqr3HkBAVzZ?=
 =?us-ascii?Q?/2OTWEg6QvIPH3EuJfSxWa/kywF/03s6HL2y8SQMpnTLxdaCtFqFT1m15m4V?=
 =?us-ascii?Q?SJJhKMVmJlY415vf7RaanHko2XCA+9GXrPhDSeDu42NIl1cebkbJ0ylSPklQ?=
 =?us-ascii?Q?SCNUWQFOxbrE2VCI2gj1WAEa2w4NKFYFCscd+FARjb5xsO/7zvfLz8H4sFi+?=
 =?us-ascii?Q?hESqkVuCcKefVxJ2aL7O9dqWTlfAVHWi+O1m5eKa1PoHB3eb9dPqsLogSfUF?=
 =?us-ascii?Q?6Sss/B24RVz2SceZvgNJJygsKhKRWmQ1ZJFJXvfDCmj1xQkfXYU5MFXyLXOp?=
 =?us-ascii?Q?BbLr3gEl4lN7Mf2bmQcUGAFb/xXDJvSkhjSBAq1VsZga0jjFHedV3ldxZgs+?=
 =?us-ascii?Q?RnY0US7BF2dURtFFhLhOS91bGsJqze+pKjin+xopHhKfDW9qlABULMqlSjj2?=
 =?us-ascii?Q?EHaF1bEp2+J9J/28T8mJjmuWy+3vHu84TVwMhsxmXdE8IRQBQtbO+yKmQcib?=
X-MS-Exchange-AntiSpam-MessageData-1: BTRHY/i1k/T/lA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f2505b-0703-4501-9bf8-08df0e493071
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 08:06:02.1113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VFoOBg7o1E/gh7FbKiAu6pa+TwxCXo3ElhjPTTilrUThLyLoCcN62G6pconNY2CR0fvhwZiyU/rOJHVv+DryR+AVbGMU9+SSGkNS0oF+3vqfrcgHuJfDXboFoejoaU0kvNRGmdGjHdYXznyibwlug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6480

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Arria10 SoCFPGA DWMAC nodes use reset-names = "stmmaceth",
"stmmaceth-ocp", which matches what dwmac-socfpga looks up for the
OCP reset. The generic snps,dwmac binding only allowed "ahb" as the
second reset name, so Arria10 DTS failed schema validation.

Allow "stmmaceth-ocp" as an alternative second reset name and drop
the related TODO from the Altera SoCFPGA DWMAC binding.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml          | 2 --
 Documentation/devicetree/bindings/net/snps,dwmac.yaml         | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index db93436c96fa..d8f90d36d246 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -13,8 +13,6 @@ description:
   This binding describes the Altera SOCFPGA SoC implementation of the
   Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, Agilex5 and Agilex7
   families of chips.
-  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
-  # does not validate against net/snps,dwmac.yaml.
 
 select:
   properties:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2449311c6d28..c7f1a7c11c8d 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -174,7 +174,7 @@ properties:
     minItems: 1
     items:
       - description: GMAC stmmaceth reset
-      - description: AHB reset
+      - description: AHB or OCP reset
 
   reset-names:
     oneOf:
@@ -182,7 +182,7 @@ properties:
           - enum: [stmmaceth, ahb]
       - items:
           - const: stmmaceth
-          - const: ahb
+          - enum: [ahb, stmmaceth-ocp]
 
   power-domains:
     maxItems: 1
-- 
2.43.7

