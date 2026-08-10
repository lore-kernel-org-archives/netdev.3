Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889437DAAD;
	Mon, 10 Aug 2026 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367448; cv=fail; b=L9bg8j+UEPae/NLPW9bBGQ0ObTSI6vdahJkbEQBk5ReCovcWnT/L3H9LigYBpMW9oAJ1CdhNGw71IKiYvtAemS++R/zXtawRbI04GwwvCT3E8EzKbpGrv1dC0vHr5UFQdqHX/kK+7WCfocU2FZ6HlHg/6LQNc9KorVpKedGE/OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367448; c=relaxed/simple;
	bh=LOGyBiY93MlRwT4U+sn0g06I5mR0WD4gonjEVrL12Dk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZf7dUGe4Ay86gCumShfkgh7LiT4fmqQYrSJS+UQnrzdviyKGKuaSnXs6jDkVI/wLVghasJ3FJeUUPa0C4T+rAaNQq3clmXGE5v7ikdaVe0X3n46aXz6KCRn5tOQvC7Us4ee9LpmmONG+lIYoqCAlNvBmhWwoUpNdS5usMwNIEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Q2e6klYd; arc=fail smtp.client-ip=52.101.72.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Q2e6klYd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIwEpBNMTcseckg1KCqrTl68PLpKOjKSeYNSK1wZgibgblr5Y2gh5V3AkiHNK0Jlpl/0i91fR+yFAvKPaGmYUSbNz/I6kTeu1qECrZ8FOK2ez0AIGaRcZbw0xZZ2rlC3uYG1bvjL2MHgsKeLs0IjlSSDvjF4PIQu2A9gh9/cHvhjTo2RZa+hQyO813oJdQUd6uMQ4P6bxJQC6MWOvoYxf5cBaBmmEdC4ZRKhfFjYPUvRJFY9/D/fFVHrtHjsskQGBzQjGrYMI8xX7igKi0/Lzk5XmYd8NRMuS7rcbgoyOoACn0yu83zGH6Rv4fDt23iwgY+2+qp514w62PV0z4bLuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1+3Xl/LvEsHpsuuIQyCRhwtoW1+jd+HCRIxs4HZPvw=;
 b=B0WKjPuvSnXAKGVE2lcw9pzfHQTlFD/VOLR5Fim4vHSt20SyRd6lhbvhr2vk0BJ3ZRhsyySz96vj1d0BfMyo/rbG/NeWSm839xchamk6zf3vIl4XfmfyZZPCE2a5NidSgjPA7oPAD38aahDUvYQZhOfZu0taaN8hCnGb9/yZn2YsWg1VTVPfCNgI2AzIJTvOg68u3t6VNvJziCJ+4k4e8amnKCRZ1h97KQnv2HL3iqc1KN49AaY5DGf855dbfwDMWQWzi0q0hQnZ3tIw+fCH11PQeFevdLaRVUGfyZhN9L8/RubJkZF5w8ucd6E6jH7weRiBUPGDC7TM0uA+alf8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1+3Xl/LvEsHpsuuIQyCRhwtoW1+jd+HCRIxs4HZPvw=;
 b=Q2e6klYdcOMnFp8QUFOKO5Og1pxlEr+MO7sgdkySvPXn/fw7TNsGWp95Xo+fz3pEUOOZkvWSPqomWVBVG4HLPkWRsu3f9PJKNZXn7aiKmnHchfrVMIJBIlK7pU1RADWj3wAHh2QMNiouOoIyL6r2UQNAx7besg4h/pQx1z1YDMWc1/l2V+/EPCos27qF71xMQXbAuzKBzGVY+BkfOvIdLRzifWr24ZgNbahWcq8Vy2wU3pn7fd36DWhxtKC2ydVlWm3baXSslFlxevGN5vmnRPr7oIG9342RtPQ6/VJtTNKzgj8INr/afq48gh7sxxVycV6iTUsMuAttYCTjO5SzxQ==
Received: from DU7PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::15) by GVUPR10MB9678.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:35f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:10:43 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::18) by DU7PR01CA0025.outlook.office365.com
 (2603:10a6:10:50e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 13:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 10 Aug 2026 13:10:43 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 10 Aug
 2026 15:16:11 +0200
Received: from localhost (10.48.87.235) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 10 Aug
 2026 15:10:42 +0200
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
Subject: [PATCH 2/3] arm64: dts: st: add 3v3 regulator to ethernet on stm32mp257f-dk
Date: Mon, 10 Aug 2026 15:10:31 +0200
Message-ID: <20260810131032.455435-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810131032.455435-1-christophe.roullier@foss.st.com>
References: <20260810131032.455435-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|GVUPR10MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 0419573d-a437-4f79-8705-08def6e0c898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|921020|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G/xxsKwZAMTKkgD+d1RRYOkuzIUhgo3z2F0nuT3adYAbhARjaCtcMyq7y8i+YrG8MjguIqG5Ih0AINQGLn4HGNQDFnQMjv/kWo3OMd8I130p/Su037J1KEgda7hrRcS5M83VAUy5r0fg9SVRwPPYbEkKloGYDn+QJ6D7IUlgm3mZ3CagCk8KRziai7cHi0CU6FQOdKICxe8u+J3sOGoX4E0/F1pqVvXAg5iZ72eXagcPjsfWIDVVU3RpE0G8Qt36uI5NsCTlnjUj5Gp7OvcTPSH7hhLM5ATSc51Dd6mAuXrzXOQj7VSwtNlkT4+SDfeQ0PHAUOtFY1DHQhrG/qvS38keZHH3jTlGlt+KpZpbpfnjN7fQoQknvUPFoqSnYFVcetANXeR2KENN8KjpjeHTEm1ycNo0hqEsDgWcds09CeDwbwp59dCaVUC+JjNY0VWTQK9ohI6rmy9UY/U/+PSCB+BOB0zsanZ7xHS1TwV34+K/DjXk9O6CEKiwRyVpqBnBKnNIspcgh9TWMAY3spvqCVGxmiwQH4tBSwd5PUdAdu31oUhwrHeTafbL58mMz6h8JvccruhhlWiCyCDp5H1Ga3QlEETTqLNNorUaVOhye+71UgMaK//yJSowUymkIjClN7a08MlZyKdQZ/8ayOkFTHQ/m1fo0mpqMsra9vGg8Qj/3+rkIv49tYTCjWdjEdQUU8crPEN7Bdjwfo21gSP09P767jhjXMx7uxliZFeSKeXxfAHlv8VocFr085Q32bMj
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y+2grz65sKTsBdH4DSQTSDyJVOIMsZexmm2aDJ372Lr+D5chrmTnD+gN4u2jNWFLDHV6fTKbOFff0SFHkKL7lYyB6224zW1n+h4n9CYhkMBFXW6ru+/34JJuHWvKyWqWzsauUTKigfltgway2/9WDQ6DVvPW55J5dnj54Wqs/fbTqhXFObSfgCLUV9l3ztrrBs1ypn89q04f8hiBPpuZCFeiTwiaBxnWicyX5nfMdPsah5m18B3sTXE5UWjtiP1zB6KExK95+mTps4vw61ggjovMm/0A607rllFK0TqkgKgjdwLw5q8yQKaZyMN5Gvw4wvdnEVRLpwqK04NV7e7LX/Zz8Pu+mDJVF+pZ0V6CZSOdL10T6jh08yYy1v4wRiQ9FneeK30EbVRs6SYd8ew57MiJifeSqpFQZ0a0R6+Y/pkLYA6fYS2MD3NrbIDSVQSJ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:10:43.0367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0419573d-a437-4f79-8705-08def6e0c898
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9678

The Ethernet PHY is supplied by 3v3 PMIC regulator, add it to Ethernet
node.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index 8daf3dfd5133..e98a773448ee 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -144,6 +144,7 @@ &ethernet1 {
 	pinctrl-names = "default", "sleep";
 	phy-handle = <&phy1_eth1>;
 	phy-mode = "rgmii-id";
+	phy-supply = <&scmi_v3v3>;
 	status = "okay";
 
 	mdio {
-- 
2.43.0

