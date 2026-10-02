Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0EF358375;
	Fri,  2 Oct 2026 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934604; cv=fail; b=TU8MmB/NqxCzY3wsUjxNpa1Yc+S1cJVpL+qmsE41jt56/Hz6HwLgXASb3jyVKMZy10kWiWMKoR2fmRss9y0JOGmtwNEHIuUPHFW/W2l/ujDWv4OhARc26u+rxg8l62FbIIyfCkP9HVp6ITXG0yXhICvXSMVFo98SeR6U1wn5g2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934604; c=relaxed/simple;
	bh=q4JKUv/j5hGh+7cWjiOM9XtUHGpWmSi3kNQFfQoFLlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BZu9N9U3014pJg7h0gq3GGrZdT2KptuitxKCE9KMbMpkTesJwdw4YetV6uZ/aVayqRfQXRvhAuZCBoHqm25UnumeYjZORp/wQmZV5VfOqjt42HLWqsOWkViiydj3JVTtl3xUKrOwLhi+9I9EkcYx/Fy8rZXpAzFBFO6GUXE172U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=bZMEvP1z; arc=fail smtp.client-ip=40.107.159.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="bZMEvP1z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1Gvz8N8uQlzWbxaiaP65fy0x6aSYfckcwVrpaVMWFQBfC/mg3eIIy4yPG1E6iX64eTpMMOVIX2XOG65nowzbZshBV68Kc87tPOGfl+Ekdn95F6iPYiOyqlLMmyy35clifre7M3AvTitDWpW3cMJMR6JwJs0jCfuXQ8CxIcCjI0gKb4K+gDOkOcaLPLX4ati/dnnMMVktIF83wwf+63UMu+Oj4H5JgakmbMGCrtTm2brJsvguE/lD5MFZJ61OGtQOZXJzBtFUo/X768RT5zU/8fEUqJkkxkfILvjqUYekRnWOvK/ey2HmGNhaHN6ox8kFDEj9GBTuxoVaqxzP2ok0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iADhX27oBCBYtEfCC5Ts3swyGfUCc5JM6NA1FNdZ0mE=;
 b=mXjaJu1na8f5Bj5SiakEjFh55OBUaG/EidO7HT/OKAWQsRZyvIUQpr8JFlEn6WnruQw8vsxuj/jmeweBTMTf8UEQw++DLLWa65+BdkCzmqdizIHvEDjvQ+Nv65whAAMdlUDfZVMF35dlcdKracCOBZukBRTQWWnSVkU/WHN4as5KPNpp1p2kasF+oVbW0dlHYwUZbdrZ/+q2c2LN2XRUoW78lmiwaqwu5M61Jn8WYzVEskzu6CDxHGs15dR+86v41KFvrzqM4v6enUHn1L8powWB0Jrdge9NPxRKAWWeXGOOILbE7C7knjlBd8YsP5M8UvvcriZwyCKRS4C4ST8xvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iADhX27oBCBYtEfCC5Ts3swyGfUCc5JM6NA1FNdZ0mE=;
 b=bZMEvP1zCquBt9THNwX/MFxwyg9xQKvLYKOe3shss1idNqvd/0hgY2mdM9RZmD0OdZbtdngfWKw1m//SoTmQF/zV12Jtp8NMnv81x8Y0zbJWZESe+1NbUKTobZzSjtn7e1FOjdTj4e5wBh0ccBbcZTWXqWTfgo0HQdVoxesk8vw=
Received: from PA7P264CA0199.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::19)
 by GVXPR02MB11540.eurprd02.prod.outlook.com (2603:10a6:150:322::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 09:49:54 +0000
Received: from ZR1PEPF0000E460.eurprd04.prod.outlook.com
 (2603:10a6:102:36d:cafe::af) by PA7P264CA0199.outlook.office365.com
 (2603:10a6:102:36d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 09:49:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 ZR1PEPF0000E460.mail.protection.outlook.com (10.167.241.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 09:49:53 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 2 Oct
 2026 11:49:50 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 2 Oct
 2026 11:49:50 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 2 Oct 2026 11:49:49 +0200
Received: from pc67698-2615.sto.se.axis.com (pc67698-2615.sto.se.axis.com [10.133.4.43])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id EBBE62833;
	Fri,  2 Oct 2026 11:49:49 +0200 (CEST)
Received: by pc67698-2615.sto.se.axis.com (Postfix, from userid 22105)
	id DEB85590CC67; Fri,  2 Oct 2026 11:49:49 +0200 (CEST)
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Fri, 2 Oct 2026 11:49:14 +0200
Subject: [PATCH v2 3/5] ARM: dts: axis: artpec6: use multiple tuples in
 regs and ranges
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261002-b4-artpec6-cleanup-v2-3-8452b5d045ad@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2426;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=q4JKUv/j5hGh+7cWjiOM9XtUHGpWmSi3kNQFfQoFLlQ=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqv34zuaImajiyfyvNfWlxwSvq/Vle+oL3NX2VQ
 sseMzWWLsCJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCar9+MwAKCRCwB25JC3Fh
 azrGB/0bJJoVo8TZA+PRjJMiaRUCS2fC3VAEX4lql7p5Qt43V3CrelbqCIAP1Kedc8WNfEhG1et
 jcvmLrkqg9teW3MfuWw6MjmYbKUYp0Oc0+EPxzPdlGKvBO6pL+5FWd4RA5vg/3CYbDrxPrnXhPs
 gfHHigPIEZDTet7GuaZvoCuOcUxJzRH8HOaMa8i5+ZG8tSTLyTeOahPZiihPQECFAsCytc+t/+4
 zKC4n/PL8asJCynLUi5mpfZZG/VsUSMT1JUppFtTeFY3J24dIm4yyNFK22rwlOoi9+tS7hCZxzo
 WcXYsThyEF5rNP/gpYyKTIvU2VUiFHHgW3Bfgq4VxUMFvq44
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E460:EE_|GVXPR02MB11540:EE_
X-MS-Office365-Filtering-Correlation-Id: edf66233-e21e-45af-738c-08df206a822e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	SPDFVAMfp0e5ecP6lgmz6AKCRKDGJe1rcaUziWH77CewFF1eqTZ6SnFZu0iEEf0Akqm4/Q4ybo2d4OXcHpYhqmGee7pDdmWk5Uo/1uQE9Yeze8QXpY0yEfGsx64B4TdgphssQqvDkvdCXBvpWqWh6iv9Qa6YnB/lkWCILG7IaNpQS+AgutFQ0eOe5yRWGtcU4R/NIO1jIsp71FYTYWoRPX/ZlNa4/YF24WxxUN3ETz1MpL4Lfx5bTbbUk2v7wfZ/JjH1UdZ3Q/FPMp6zYcFzj1QozpKcvuehgrQcLgTl1rqBU9k+JgOJwmmfAjrxxgiRNG96Ex+uIaYIzY446dTNfpfFb5xFz9FuPO4/bdgID0WV/vds2ieTWGh3ZA5VfHPXcG+zMH8DQYI+wKdVILhQjTqu+OE+Sm7jpiu+w31GCuvAfLO+IodY7UREt86uddRp4SVr9F7YvzIAxLMQAhFgkYBP905tGkPYFOO/vb3Ck8QEnad+2jRIo+c71UoYRBOOh+H467ZekhfDzk7xAO4GZ6TLRBvelAB7zqKITw54zp7WEhhCdGfCf9DSJVVeRaICO2RhldUJT2pCWZgfOA/IzOeLHtU7sBU/8nBelVgFTv6QVKWO5hYy89+de8Szcnsz48Snp13B0kICh8yCIo/vMa7gtxIvDHGoOcucexQ+UTxTcVWZ/R68MQ5fvjt+UkY84l0tyK2yoqfnT2UEl1HCsw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oi/oofpS/RW4ETWd04av4bmrA8TsDxuPIBup62s/gXBRXLiPXXUpOn6ebQwnXgOkD/60rVGmVlZFwJfXvUKMOqC52jF+Lt7YbzatccV+eJpIrperTHM8xSKQOBD30/zHeJbKPXRcyE178GSIb7tXlhdeQWI1RTuYeg/cp0csX42/6HwFpCMy4G+SQNT+ninGG5JAkWQ8X8kQR/ACMcs2Ge+LigkFhwZPWa3+xgBm7hWMdFdt9a3svizuqTu/SIzN0y0DEYqFrp4/Ocx8uurBXZAnMA89FfVc7R4W1X7D1SuyuRmZw1cfVfRMxHcuf8fKyb1OHbi99Y/2KPR3b+vSRh0s8rHpBnVVZ5BmVw5DHfj1Psyt9dsQBH9q45WSgh4ULaP7WYOuq86qao+j7kbIfPhRzgetYid6+VAd0mDeN0yoO40H5dwHPaVFyDZmf7yj
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 09:49:53.2103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf66233-e21e-45af-738c-08df206a822e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E460.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB11540

When #size-cells > 1 it is preferred to have each entry as its own
tuple, to make it easier to identify addresses and sizes. Update
artpec6.dtsi to use preferred style to increase readability.

While at it, also move the inline comments in the pcie node to the
same lines as the entries and shorten one of them a bit to fit under
100 chars.

These changes fix indent-consistent and continuation-alignment
warnings from dt-check-style in strict mode, e.g. warnings like:

  axis/artpec6.dtsi:170: [indent-consistent] indent mismatch (expected depth 2 * '\t')
  axis/artpec6.dtsi:172: [continuation-alignment] continuation should align to column 26 (to < or ")

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6.dtsi | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index d6610f62ca25..2f75a9df0963 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -161,17 +161,15 @@ pmu {
 	 */
 	pcie: pcie@f8050000 {
 		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
-		reg = <0xf8050000 0x2000
-		       0xf8040000 0x1000
-		       0xc0000000 0x2000>;
+		reg = <0xf8050000 0x2000>,
+		      <0xf8040000 0x1000>,
+		      <0xc0000000 0x2000>;
 		reg-names = "dbi", "phy", "config";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
-			  /* downstream I/O */
-		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000
-			  /* non-prefetchable memory */
-			  0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>;
+		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000>,          /* downstream I/O */
+			 <0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>; /* non-prefetchable */
 		num-lanes = <2>;
 		bus-range = <0x00 0xff>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
@@ -188,10 +186,10 @@ pcie: pcie@f8050000 {
 
 	pcie_ep: pcie-ep@f8050000 {
 		compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
-		reg = <0xf8050000 0x2000
-		       0xf8051000 0x2000
-		       0xf8040000 0x1000
-		       0xc0000000 0x20000000>;
+		reg = <0xf8050000 0x2000>,
+		      <0xf8051000 0x2000>,
+		      <0xf8040000 0x1000>,
+		      <0xc0000000 0x20000000>;
 		reg-names = "dbi", "dbi2", "phy", "addr_space";
 		num-ib-windows = <6>;
 		num-ob-windows = <2>;

-- 
2.43.0

