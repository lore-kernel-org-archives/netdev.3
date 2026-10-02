Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975F47DD58;
	Fri,  2 Oct 2026 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934603; cv=fail; b=si6FuD54UqQ7BAxXLXySfo0oOY+DzzFs7l9ZaIkWg6oV0OHBGqORZT7H2JSEHnnukhk1HPl6S+upeUw4dKalqKWANMiszD7grm0k24i+m44KRh3/C/uI4yf4bR9XolHtYLHyfr2U5cd8wwVB6PGs072E1CpRcdzlSm858TTpsVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934603; c=relaxed/simple;
	bh=4RgRZZsoIibvbWIazDAq/k5HyobMS00E0OL/Eojqbi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Dx0g0PpIRyCVrpbb+43VNRtf873HaHpqI1lMn7iSEEUQov4hDrzmgZ5qNf514seQq4bUSpD0VVPRkKsseCfaUc3SqkSdVEV//1pOWeSj5RU2sbHuhIzbb2mF21+GTN9z+Xb1s8Io9FB0lzEANX+WJgMZPwzXLVQFxVGIyQh5SF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=LU/kzWFQ; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="LU/kzWFQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRL6iZcxfm1Bl8euu4OS+aOb7l+txW680wQTmwtaZ5Vb59xSyGcZQkH/yftq+H4qTHzOG2qzRjSr4plqElu4cvTC36tpFq/SpGuwhgQDh36xCFTzT8PRQcRbVN8dPNGUVsNb6+O56UgplOlwfBzkNwZ3QTfaLMXSUo0oIbq9acllUE8zVZvYhUZbXvMV41mvr7TnvY2ahg6BZPnZjKM0Vp7hbwFaiSEIkI4tEzOAzHL1F169n7N82BfvXV03AOLFckJwlJ2vBuccz5x9B8L3BdQCHIL/E0c7byzaCKjAHQH3z6q5+8C6GfpFH9XOlVI9ZJ6np3ceHYO7FFKYreRFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO/JWJZYJhVL+dckY4yF9dKx+Ps6AEKtVB3hnkqHnes=;
 b=JdPYeST8KmNgMlJ5wypGAEvX3va4Y1vE+GM+StE4jtpYe4f0GKS7E7K5kPFmVqU9d6fjHprQV5rgbqEMT9NvvkfQbUte8w7IA7Eat1KKGXz2f50gi0oHYfjRssMaqTpTP4ZrfnlB0ZvqMBoJF7DTeEVnBW1zxIN/ehZ87Nqz9XhKlnyrd8Sheta5Pz7hI4EhewMDJKnsmNUrTBzcKlZBaxGVkN/GEGvgFBJDHn5MUMPQfNdQ2n4N3lHZGyOg3kOk9f2kvEaKj2zt67A8R0iGT0kgpj6UxGKF3N+ES9Kvomu2H8e5aCLmP8Nf3BqFKehmBr/lqfb0UzB3105bwhhUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO/JWJZYJhVL+dckY4yF9dKx+Ps6AEKtVB3hnkqHnes=;
 b=LU/kzWFQYGLoS8ovL2ZyQ8YY966k/KzZWtelXsEIO66nEE2XmRZdQ2gwZORx8Rg4SCI37TOuYDnPDZ74N8k3vrbZNyRtJ56lao06SgtObDYPl3N6P1o82YU4g8qmbpas9r40VRqibLQUi3jn9jKWwrh8GRkVb3WzJEYej7xgtfs=
Received: from PR3P192CA0029.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::34)
 by PA4PR02MB7119.eurprd02.prod.outlook.com (2603:10a6:102:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 09:49:54 +0000
Received: from MI3PEPF0000849B.eurprd03.prod.outlook.com
 (2603:10a6:102:56:cafe::1a) by PR3P192CA0029.outlook.office365.com
 (2603:10a6:102:56::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Fri, 2
 Oct 2026 09:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF0000849B.mail.protection.outlook.com (10.167.240.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 09:49:52 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 2 Oct
 2026 11:49:49 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 11:49:49 +0200
Received: from pc67698-2615.sto.se.axis.com (pc67698-2615.sto.se.axis.com [10.133.4.43])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id E8F5215A3;
	Fri,  2 Oct 2026 11:49:49 +0200 (CEST)
Received: by pc67698-2615.sto.se.axis.com (Postfix, from userid 22105)
	id DBDC358FB1BA; Fri,  2 Oct 2026 11:49:49 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Fri, 2 Oct 2026 11:49:12 +0200
Subject: [PATCH v2 1/5] ARM: dts: axis: artpec6: avoid _ in node names
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261002-b4-artpec6-cleanup-v2-1-8452b5d045ad@axis.com>
References: <20261002-b4-artpec6-cleanup-v2-0-8452b5d045ad@axis.com>
In-Reply-To: <20261002-b4-artpec6-cleanup-v2-0-8452b5d045ad@axis.com>
To: Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson
	<lars.persson@axis.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>
CC: <linux-arm-kernel@axis.com>, <kernel@axis.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Henrik Grimler <henrik.grimler@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=4RgRZZsoIibvbWIazDAq/k5HyobMS00E0OL/Eojqbi0=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqv34tQZc/yXlTHf/TzxWTMJhBDWwn4EGUrPynE
 33uo+eC0U6JATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCar9+LQAKCRCwB25JC3Fh
 a7veCACmAUSWk5QqHqbHcAcfP5CgqY6aRFxpA1dmjxcqwd+BPLObhr+XSXcsoIqiDo3CKnVmG49
 YNoQNLHWYyfiliWHcremUS8Evl5oak1WHNmQXZmbaKVjhX+f7ZXZ08u11D7ZXhrR8/YCmFCWDFW
 AP1E7xeA5VhbYr46EjlT7HAPYDEdqxrqDMv3Bw5x7PTPmvLrY9Ah5+EtUtQjoel387lg67kUNOa
 GBBBuBA0m94QKtHYlQC96olanL+qbEKpIOw8b3PAvlJjVYmC2XxPkFqtP4JgpQ75il+EBDdRZVc
 Al4X/Vw8EdLqOUnLkQp5/Y/7vS4LbKSofax9HF9PkgPSuEhI
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000849B:EE_|PA4PR02MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 654efb6e-69a5-4561-cd72-08df206a81cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hHzHd6FQMB7xkYw3e4ICttjQdYKpf4TPheVSI6s16ZnD/kCzt5MhQoXSzbWvdskcjNkfNgFwbHmxbrCYb10+5qXrDAo7J+srCHZ7dIr+m2Xtz7iD+qgO0vL9KYIdt5iqv8DvAhnGcOU6BbF3gNZZTQENlYzUmQUQYroqStSIJ/K8jBQ+M/L8Gc/+hDX985J7MmRZCP8pyc82kxW11koOUxVLbIlR5sSa1tlV+bc6669j2jUfps6SE6zC/he4BkDe6cYWySmQTt9XMeHKRGf+vV4uekgcwMJr7OfRo/hiCiiS8gKtmXTgvKKOEl0CX+yX8wSeXlSKFX1Ox0dMux0lGpzz/sDZJuWMRrBPoTdTcPvhA/K4GYHKiwnkmq7pG1WlUVAANr9d3gOxZTODda309NMTPyXa8tKStRFttyv9gZu4vH2z/mP7x+OcGQg1QGaj9fiGMjQStNvjah/fNCEH1XFxPdolDapMZBeXyOTOSfeZxdyD+fSizgDob/XHR8LMZp5Z/3zKa1s+J+hDHv5/G+kYaJjw5rFiMGj4kSnHjvmAHyxqgvy+d5PXA3TvARtyUn78qe0qVqkdtCWtOWOewGmdeNB0us0o5gaFYO5j4ojirbY/SIIzZdQuAWRXeuYdMhBTSGm7d15xNBvIKWYo4qnBZoaS6JP4aUVAvAe+J8SK82RWApEuQFV1Ud4lZKU6rJpHK0f4PMqLz7NJJ+6K+Q==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	srFSpVWP61iBjnpbN5zOxs0NfqluBQIIa2gVvMvrcynMKRrvJbyar7o9VjuVartiNvT3J4I8Ef8hz0ty0oqKu7Wo5lQKJJb0lbsP65crvcSFAijBmfZWiaW/JRxwkyEi+fh+vZUBcdlTlZH78s7dvcADSzq/m4oC72Fwr67sXznTdAAGxOPLwv+QJ9baYqqmQUZT8XRYodOBoxRq2pzglz5ZUUcIk8mbo3L4u1BiAYzjrXc3pfHwnyVuQNpWChQOFTiGQEd6yDb0TJOcDj0bL5Yf5RDbRlqKCWNAri8fGyr/G2sK4CZxq2vK7EsAn1gRjcpfU82DAJZwuRfsAh9OUS5+hVmtYfLUvQ2u1E/m9coYJEGiWCFUBExH5ZkvgszGPU82RmeodxobzgeDzhjFKIIkAOl4eqenSY3Tu9maopx74KsnjDcuv5ADylfPfxGW
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 09:49:52.5652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 654efb6e-69a5-4561-cd72-08df206a81cd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000849B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7119

Node names should preferably not use _, use - instead. Fixes
dt-check-style strict mode warnings:

  axis/artpec6.dtsi:91: [node-name] node name "ext_clk" is using discouraged style
  axis/artpec6.dtsi:97: [node-name] node name "eth_phy_ref_clk" is using discouraged style
  axis/artpec6.dtsi:189: [node-name] node name "pcie_ep" is using discouraged style

Changes have been tested on the ARTPEC-6 development board and do not
break anything.

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index 037157e6c5ee..ce642dcc754e 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -88,13 +88,13 @@ scu@faf00000 {
 	};
 
 	/* Main external clock driving CPU and peripherals */
-	ext_clk: ext_clk {
+	ext_clk: ext-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <50000000>;
 	};
 
-	eth_phy_ref_clk: eth_phy_ref_clk {
+	eth_phy_ref_clk: eth-phy-ref-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <125000000>;
@@ -186,7 +186,7 @@ pcie: pcie@f8050000 {
 		status = "disabled";
 	};
 
-	pcie_ep: pcie_ep@f8050000 {
+	pcie_ep: pcie-ep@f8050000 {
 		compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
 		reg = <0xf8050000 0x2000
 		       0xf8051000 0x2000

-- 
2.43.0

