Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011071.outbound.protection.outlook.com [40.107.130.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086AB349B1C;
	Wed, 12 Aug 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525989; cv=fail; b=KKETLJQgpKWuQEK61rx/WGdUEU8HHlCWhCcNrdZ5asA4ZWolaY8/OcB0u+rzIBgIzlW18LglqQfupb2RCH8C1H67N8cL4KB6c82jr/ipUAQFcOSr086aqRpo4HXvOz+xIlP95ue64gBKDUV3NCFCxxwdEU0q4Nmi+FQZ6Zb7/24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525989; c=relaxed/simple;
	bh=hR6pcZkIGHyUTxkt7Hx5EM+OzKe/tEUiEn1qxnMB6o0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCcVvS4Vvuq+Ag0ysEDQgCHOTz9L0H5oZo6dVMMC4pTzd7OdsvOb+Y6faFELSVD1km9Z2noqDeJ+hl20/T8pFoHuC5vTF8D97NpdJsq9BNPIHph2ieowYQx5AreHAsEJveHal1xYy+4+wudwYgOfY542DM0rqrjuKZzYBTmS6hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=k0RJgCHk; arc=fail smtp.client-ip=40.107.130.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="k0RJgCHk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3eO6V2LlSAmFcjE9I+PvBC0EEGviHtlINGrYFdbqPM8bNppjJskOxd5P9Tvo3OygAjbM9I9nLRFZsQzFv5EcJzBAp049vppxliXWqcMrlDW+LSImL7Blc8T7s9DGRKg8WnBgIqLBaM9nYKkFfRBtM1RCmNnvUYdybcvF2WJH6QXbJ/SLCYNdFw9F05Gx1OjzajK2f/kZkqmGMTB3cKoEWCQLhZYKuki+MbIXPiWtJvHKYjloGIXwlx0rHQQRymOf2HccWfvna+g58rfjwNHIqbCObEeMfDr+hDjB4bvmXZwxG2nhY0Q6vJhWJrKSguFMBqJDdEAPKw1LfffpGLfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+WdBCWsBsUc58o3sxhmDZoSeuNDFxGwmreDlnlmfHo=;
 b=MLDsTpHcp8Hd/kKLqT10tUFdgzu/zuh6e9lOXaQJA6mXv/JyBzD10HCGKU/kqLF7C01NCTk3Dnb/PO81BNO9sjh6xZEdUs+nFceilJDu3mv4fAGh6dPSkalYxwIU5YTvI0RoqEoiLK+ZFw6NyyBMEhwp7G1PH8vpx3xZX5xe4EtRunG7eqdNsQddTmUsoskrXbTwiS1PKPG7upTNnchswszw51IwBBP7nEO9C58B8HNdRVENhOrIlM8wjeiaXLvHUn3ctWDeidKMDi0C1PUlGP71X0MaQl2PwuwWVjADkuvnktLLCqEJ5U1PsUdD3zjDmBnGUfaP7C4RUDxRnlphZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+WdBCWsBsUc58o3sxhmDZoSeuNDFxGwmreDlnlmfHo=;
 b=k0RJgCHkb1NXfZFZaulMCXbHuTFYQNau4efv0+MenWork88MedPnuYKBdeGnSgVHzmyaulXxI8gvw8WbPyQxI3iGpoGl/NNDl7WlpepMrRFC9jEoZ48X/cqiHUzKwWmrUMVPw8Eh9wPMlHN92LafK0U3P8fKYXpOKbGE2HILLLB9fimzsgqktKPCmdazoRh96FsGZcCU1wik/rPjGKN6OPty+8OEP8I8iw/LHwdmcrR15vWxSWNWRE1e0RFJ9tTam144Viu0QlQGGaX6r8QLdQ7F2cVWMoOLwa15Y59gDUE/KpBwiI42Op7nwMqCMg3TS9BtoNZYdflbM0F7AvdrGA==
Received: from DU6P191CA0041.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::21)
 by AS2PR10MB7251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:608::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 09:12:59 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::46) by DU6P191CA0041.outlook.office365.com
 (2603:10a6:10:53f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 09:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 09:12:58 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 12 Aug
 2026 11:17:54 +0200
Received: from localhost (10.252.2.245) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 12 Aug
 2026 11:12:58 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Alexandre Torgue" <alexandre.torgue@foss.st.com>, <linusw@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next,PATCH v2 5/5] arm64: dts: st: increase deassert of PHY reset in stm32mp257f-ev1
Date: Wed, 12 Aug 2026 11:11:22 +0200
Message-ID: <20260812091122.566439-6-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812091122.566439-1-christophe.roullier@foss.st.com>
References: <20260812091122.566439-1-christophe.roullier@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|AS2PR10MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d525a0-53a7-4154-0eff-08def851e73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|1800799024|82310400026|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H92n/3BUHujvpAwgNKFsi1XwVM5Gcp9Mo3nninbbEjVIMNdQiURO1WZe7OglWwJcNeGzlYrq3En3s92TsnfTmwIEgRLi43qK0WvBc821gHHjZgXuU4XEiaz2PsB0SZbZaPT1Rno41x6u41lWZvaBRBgnxqcn1OYpsYJ7V8bwFFdZAdEZWZaISkTABKjkWCVIUGBompwnp5KYWTly1i9qopV5qYWuLjim3Cn3wp2wCi0543t0TWH8pQZLe1K6mIqm4+DX3nkHoZTpHwJMTvoIal/5OR3CmTrOOR82ljU9W+7HYM3fe7bvgV+9TTd5yo8+nvsnrXemBMRI6/qgcmy2MdpJcjQ3i3rqz4Edu3udWwZm4ATTB5vRxlU0mjH+dQ7t5Uv4Qe4CNf6xRwreQXlFElZ1u5//6X3JizKb0qw0qj4EACbZdPP+n1HFPWm4iXKI+of+GaG2hdvcYtUm3VLjY6pQmwvpl6CMSQz5TKbn2LuCF3K2/rKjioVTtqgQ7uW0FKOPaPcDTCdi3yXYlktmybH5t5buhq8JCa22rGSlT5t1E18ElCjjRH0Bln1O9EzDBJ/vF3Vwf1f66kM7HLMVebnPJg64fy44klS/42JJlNwb5bm7F+APltnEkTr+vo67Sdlq3dyWsVTTJ0A0W4x6un5Oxnx7VliY31OmQhbPpaLWoB8oJo4Q1jeXE2os03CQ81xQI+Xf7qQ5Mu2udP3Stu44bC72S7VbVQu2HHvWp7agAYuZgA2r4SkaWaCdddTm
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HDiflqcjmSzra3opQBNjTevrb3ya0Cn1pyx1FW6HdCLRFnz6tpARJDxBQkTUyr5/ziXkOd3SNFahymmymj+dOX5jlWOMrBNaJPcgjTqcI89E6HUWsCA8foJHmu73k/6q+oesG/lllxH2NV4GlYYu5o3PvFvFSXfv3IpUA0mIK6n5ZrOzPhHh4nvWmhUQBVGvw7AC/G4XUk/AfRVsmac554KXdJqNDpOkxOAj+AN51HOT+DK6X7RmqD6mEf9nnR744Z9v5aKL6op724rXoUYRTUP0PRQT0eN8reXfeTA6M+6veBLxH2TKGrKrNjXYoi1dgmZQSDfyHZx8mUvSdztrzm+ZX3ZWD87s0qPOnHD/OTAZaIKpBqUsks50c+KAcyAfZIv682MgFzfTUZD79k2NzSqLA0gO3rOHtNuu2MZyE67tbdOXQlbCEhTaRojbLft8
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:12:58.7480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d525a0-53a7-4154-0eff-08def851e73b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7251

The RTL8211F has a PHYRSTB pin to reset the chip.
For a complete PHY reset, this pin must be asserted low for
at least 10ms for the internal regulator.
Wait for at least 80ms (for internal circuits setting time) before
accessing the PHY register.
All registers will return to default values after a hardware reset

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 14e033f365e39..a41ab55aa8cb5 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -247,7 +247,7 @@ phy0_eth2: ethernet-phy@1 {
 			compatible = "ethernet-phy-id001c.c916";
 			reg = <1>;
 			reset-assert-us = <10000>;
-			reset-deassert-us = <300>;
+			reset-deassert-us = <80000>;
 			reset-gpios = <&gpiog 6 GPIO_ACTIVE_LOW>;
 		};
 	};
-- 
2.43.0

