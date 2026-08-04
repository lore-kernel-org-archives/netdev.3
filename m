Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5838D3624A9;
	Tue,  4 Aug 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849672; cv=fail; b=vF6HrT3XhW8iHHbj7TKXgQdShoIJxjSRJGhw7puTo9I2/zC3gahA2oAkLhV7AOZT9mrt/l1pLHHPNLrWbbo5KAAZjMxS8UMDHadZ8AJqUuVNf93xsSpJrw7fkBoC3BSP8TLWg0oeofbEjDBOSUfmRD2OMlg3hv6mBa/6HqWBYIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849672; c=relaxed/simple;
	bh=ExmFmxlywe4/e0+PyDy24pSNcCLaVakAPvslEC0nDZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KoAqFtjTC0NA8JAYYrh/yFnIvq69kUYE05oyLWXTPnQcSjvoE1bUo2FxuzctkSqMsD7yi6tKFnVuJQj1115isA8wNAhLjeEWH7n9BUpiJ6+ewO1JGlr/lJjz3E9Hj1qzrIeu3ZKRu1rxwWhzXoBeuzmG/0gfV6TlnArPnMAlTCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WyVNF+fZ; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WyVNF+fZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvYlSW4q0ccMmZuL+lh154E8jQGmxtwHBxpZn0V/lv8p+Dd0fqA8IFlC38iEyHd9OFpRjVuxegvk3gL/cpGK86Fu5YYH08z4NAzQihJxgOyi9lYrIL7VQP0XlCz2CpcjwyZc2WQHL4UWGkdZSZBHcCS07s/IynggmDDUSZISBJJ0AlSm/JnRw9O+Vi+BTjGRawMm0EfuL/Wt2pnDuVU8a175IddNQzd6kpbkq2UATNj9vIn+bITXvyQQqPLi1RTRkmtnn2S2hRnTY9QSj/T6Kn+SjTXrX+l9wyJmRc4OMDvrLaAbNdXGzMioS+yiXIWgUgpRMRGwdJJiz5rA7tJooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWexkUeOGuWBKqgj2Nl5jb1rbGHLSkuAx7Drml0pnJI=;
 b=vcx6ugRW8TpW4xVXrtI5wAVdFVwnjwl+8ZLxDjh8R2UE+jT07Qwy1lesw8UR8wL57syb1v9AKyAhy/FUcwpdAy+fYlkX9DV44hQu1/X4xzitbZKHgd1l8DUnzn4dJSv+GRRMkvBekFjOK6UjgyJRuiw8Cx8okAfsubH4gzmEOkL6fzkdhvrQisSywkuZV2oN+j32aGoKu5niUyeaspMby5BHx6H1cawaN4FJ2zNloujlgnlx+OnX5DdX0+nqGrb4CVkNYPShqsz01pNkCO4uIFxQWy0Jt5mWlq8AIQUh9EHpGBkVgh7W8YB6Ndo5SRyQbX1DpSbVulflHKF//x79EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWexkUeOGuWBKqgj2Nl5jb1rbGHLSkuAx7Drml0pnJI=;
 b=WyVNF+fZRGv66JGI8tcD2Lfkj0TnMJ5Ic0ITAOCfCO5pMzsXiKvnIHDq0k4m/dCbFfBHN4OMxHQc64JaOsb9Hi9MH2ES+rGUoqSKwZriJEgbJgM9aq4Nbk2VI8/Y/wwdKHSfD6hbWUyk4zVRfT73rxSJZx7C3GB09YugkVtde8Z0RppUfwaMvDGEFbgqDPgmnp2woZZ/zBfHn+3YBCg0jLWlu/YRDEj4qf7pneBiA1V2dA6M55ovxd6bKZ4K2ob+j5wO7GnnAhBVxpNawnyiBDq//0GL/hJ7MIfVftltXANbu+nrDtIRb/LU6AsGCfoUE22HEU6Qxg/x0W05eaILzw==
Received: from DU2PR04CA0075.eurprd04.prod.outlook.com (2603:10a6:10:232::20)
 by DUZPR10MB8267.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 13:21:03 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::1e) by DU2PR04CA0075.outlook.office365.com
 (2603:10a6:10:232::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 13:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 4 Aug 2026 13:21:03 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 4 Aug
 2026 15:25:55 +0200
Received: from localhost (10.48.87.235) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 4 Aug
 2026 15:21:02 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, <linusw@kernel.org>,
	<antonio.borneo@foss.st.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Some improve for STM32MP2X and fix for stmac_main
Date: Tue, 4 Aug 2026 15:20:48 +0200
Message-ID: <20260804132052.205273-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C2:EE_|DUZPR10MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dc840c-fc95-4dcf-0760-08def22b3bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|82310400026|36860700016|10067099003|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Xk0NCFYPhsE1SUbCU1g73QQWnEY9Lw49J3skh4W3wC33iq9jkMAxlJTvd+wxCdvwZ8KiXaGT36MFw+yk5v6wGUD/0COu0uhDOrMXnNjMA/dktMHdaazXsJqQsBbi6+K5rK8xd/TE5JBbsrMIsIUGcjg+x+cvUUvhmqxnKuuUFPYv8l7Xxbp7VT6XUT66ZLJqNhoIHjmmFGdXRn8RJpvQKflHqMmjdS7GrezunVcvrdeUSnFFeOL9gYqJHUSyCamjayuxqJx28Gbuv/j/2LvdmNPyNhaHofNPeIXex2e9Ytikf2LbfG0cmArtZ+xOuRvvksrcO+tTm+a8QcgUggTf69jrky1W40ynFEi4++6Px2FmwCtf0rWhRN3j/DiwAhLb2a6eVnrEsZaYjCbBXzWF1wRycHR0loAbeLWlWwd/K0cl3jYuDFT05Pl6QKCrksjFPeYK2dDsaE6ZuWlmdRY7P2E0m/3XIyZ8TQEBWyYjAu7RAlaAi80W0Ry1TJfAhVUI3rCkymibaKK1K9rsYDE5b+pNsQ/iLpbFQzl9r3/vaI7//8X1h94yxCSvq/xcFephS4O2OwEbO8WFbgutbr0S8ClQCVZH/t7VxPXWE3yRsVMib6InFPD1bRgeTkicUdkGLtn2lSoPTAe0PFjNV6LZ3ibdDSDA7T4IDyOU7mr6QDJfFsUcYLlBj7u8fvt/ZBbiWjX0bmPGndygdvGsdJ3eRrk+np8qWEyx/uu8piugW9d0RCvxBlTGkJWetqEF5etw
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3ZvmflGwAERcVBYhicMjVLCOe7obkYntyCba+9jZb9zbCBmwjYNWXlzvNaHdRxYNktZoerLDRusdh7MCUJR8RmBA/UbMmRVp5kCcR1n4MoLTI4Me/g2HqasEf5V//S+r8w+Lo00nrRirzdPazEkyuxEhXze6RGlEJ7M93gqo180n5EQzX8V5n3abJeo3hTfJok9uK5w3RaaFclob4b7Ln6WvmWZa0B/resiCgNFR86ARNWtorNTqg0E0M+YHRUg6Mag5qFbz6clkQ2pyu6F8hlv+WkE1r/BtJvoes2g6WlECt4bbYFLGX+/8atmXMAFTXp5QW0ZoR6LlxIxPzv+NQp9r86usOoW5dIG8AKwunaOgmWpQ0VH8899uVoD2sl7GCKImfcFOCq+Z52ne2HkLYCpVggyez2O2fht02vWfcMGYn2fJv1opKj86EqIkcbrP
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:21:03.5110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dc840c-fc95-4dcf-0760-08def22b3bf0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8267

Add PHY Regu for MP23/MP25-DK
Increase deassert value for PHY Reset for MP25-EV1
Fourth commit fix bad cleaning when error during stmmac_mdio_register,
already review on series pushed on 18/02/2026

Christophe Roullier (4):
  arm64: dts: st: add 3v3 regulator to ethernet on stm32mp235f-dk
  arm64: dts: st: add 3v3 regulator to ethernet on stm32mp257f-dk
  arm64: dts: st: increase deassert of PHY reset in stm32mp257f-ev1
  net: stmmac: manage error case during stmmac_dvr_probe

 arch/arm64/boot/dts/st/stm32mp235f-dk.dts         | 1 +
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts         | 1 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 4 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.0

