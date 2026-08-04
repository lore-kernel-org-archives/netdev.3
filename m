Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31213E49C5;
	Tue,  4 Aug 2026 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849671; cv=fail; b=bcnq8fgO2ncm7zdIJarTsw/ro9jj2qZKXpTYb7PVFlG0DsJARuwQfnPU83xGiXESgMrUodB+ckDJ7ftvRb3K8xsviWx5WrqMmJ58VgkLqz/AYMmZrYyYPTc8+S+zJdA0vwZE0jWGCDno+YD0ApG93wCdM7ypp2dgy2lISAa6CwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849671; c=relaxed/simple;
	bh=LOGyBiY93MlRwT4U+sn0g06I5mR0WD4gonjEVrL12Dk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLqfbt7+3ZT5vu7yIODWi50jl5f8U/Wy0iOYUjYVgRQ+JfypSktO3G4TcPc9XGLF+n0CaoLAczNC0pFoP+EtAYtvL8dxumtj4oPpKo4XCP1FNz0qZoVPW2LW8KOem0RnQuAoPD9r7qi2k4GlRGoPA4GkdT/OqeVc75asViEQHbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Bf04mgXU; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Bf04mgXU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWeIqlIA4y0W7PhkDIqV9TRnoBgbL9olkD5mMg43rc82GtPkqDZU6MIOW2qDi795hm269RT8AZ580HhNvtl3ghErvnsQxKhiCeCap5Ph5v898oLD5OFLzwEEnAuVZS488QlUfe0Yr8KO/t4LsPPecAS8g208ToMl7CCcDjwdYu3CLMjFcnRXRinM7yUMyVwketnWBbfFsEh55RJ4ZL9FyESPAV4q2xvnoOZDHKgNsHz79Uf/McGPyH8KPu6/QD/T0jWOsqQTL+f59pnfxbsS7jAWhBhzNd3w8xFzZdgA2XqKOdQaCcDdfmwAUFm4GOPsHB9kKhOvX3OIfWNHwQybAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1+3Xl/LvEsHpsuuIQyCRhwtoW1+jd+HCRIxs4HZPvw=;
 b=vBBvXOdbPvL1NcIaDHQuB3hU/rVZJGSuWctxwlahefOpqNr1YS0HFXO+l20VZ/G4dkqZWMffFoHl8hHHZXKktUyYpkeCgVKBcoRNOu90XHErZIKziUWEmSilVHpN4TlfO6OiiMMCEkvcQQ/2Amm4vD+PbkTBVKAzT35dSB5LKfPyei3dCO72a/F7OXxywhi+k8zkUbBAefxSehb0RZQZKGbsafAveNyzvWE7qssdegfVAr0uzYa8vCfNiUckwNKKgHRIGiwJsARTzCenMf6euLGDxjY2X2lQqJABcOPpY5bfJj+S4sdnu/eZI1SQW594v2NgPwv+QBJ+8JWeJdFBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1+3Xl/LvEsHpsuuIQyCRhwtoW1+jd+HCRIxs4HZPvw=;
 b=Bf04mgXUpvJnb5Lr8QHkkV2RZ0nXnSBjnuxdqf0o81ksaMXn7xvdDy0oZTBJjglO6rxYnJuXAQCrTC/76+uMY4tSzsLh4ZYNLS4ULaDQQgFZegmZpDiClAHPAyGTWMswCGAe/gdVIycGMgI+PTMtwkL21UyP9ZyBQJDcs1D08AKc1WmEaXOKjsVAETcd4Rm220i3P0qUcT3JueK2yt00GhDp5I4jiX1qSDDpxXOzh55zdBc6IDiKGZqmpx4EvUVMKpRt1yyEAz7LwrfYh0nQZSMtrM1Q6NzjOMrlN45XkYkcvoBS6Ue4gd4Df9guOa+39IOx16J1Hsor6hpWY+auLQ==
Received: from DB9PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::29) by VI0PR10MB9349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:2b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 13:21:05 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::55) by DB9PR01CA0024.outlook.office365.com
 (2603:10a6:10:1d8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 13:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 4 Aug 2026 13:21:04 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 4 Aug
 2026 15:25:56 +0200
Received: from localhost (10.48.87.235) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 4 Aug
 2026 15:21:04 +0200
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
Subject: [PATCH 2/4] arm64: dts: st: add 3v3 regulator to ethernet on stm32mp257f-dk
Date: Tue, 4 Aug 2026 15:20:50 +0200
Message-ID: <20260804132052.205273-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804132052.205273-1-christophe.roullier@foss.st.com>
References: <20260804132052.205273-1-christophe.roullier@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|VI0PR10MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: de734e86-6c9a-450f-4caf-08def22b3cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|10067099003|921020|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AySw0D4H1Bf+9lk9UIAOSlstGklXhsj5RMQobQp+m8A9Nd0uLleRBhl1cdiTyZTuyC0So/+6a7diEOOc7q9gVAio2HXO5iVyNd9MmepmJcuf1niEwGESiyUYoI4qWAua1lNhXXMmkBCnlUsF8wpffU2QlK98BA978td7TIZIb1uSevHVwfosaMx6KQjyqrSvfu4IWAXcmBCO5TBhlhHS6ykgC3VJpadvMW7nMHtDDRVso4Djft/REU9qzjJtoHKq4lP7Fg6/mbfCP4gsvvuIKOGv+Qu06gKQN2HtLddXh6bgXE/h4ENRejIJxPpCIavX20ETnAtmAbThkkeX9JCQcEhVpfLCfGsKc4EABgESpT1E0GVch1qUH/KZW8TY2MdfkPpEi4q0w5mS7KGw3fofSBWht2rjOrpJHPlcq/Q6kvCrT5tf8U4EEBJyOvDxaUZ1mMHX3D/Vkkp5RSmt4Z3OoKKq7b100WjdFyP94Ita7CV5i63V4ak95AOIVZQExRPclCmbmCl4G3jPGxLjUhwTA8JwPassjtUsYQRxAlDHHlnasF9gFmhiKBpczGShu/rrylvAMeOaVMZ4Gya6w3OS2oPAJObGYQobmlpemRj6WY2Y3kv01/m0msx7/wEDPJrYR2X7v2amFjA1T/blxjGJAmTrNIyy9gP3K61Z3YsRD0kTX7IIZOCkHSMHPxXuFNsJDlVzetkkFDU5no1iZAwZ+usuFMicCzhNALWdjnUoy1cxxLYN7/qVB3lEoOR8/hzw
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(10067099003)(921020)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WIifp8ucfcBPbGS5eE9PPjy9rs+ZhtjzO0y8lgYha5HRslZY7uje+ycRUqmPihqOuMdD6BJczGmCkB5jorXTLPriis/TcqwV/XtW9yUnR+APqptknngUaca+zAFavOIMMFL/icR9meDrN/S/ba1KFZWFOYZOIaELM4gl2KzeBtI0QaM0/8kMrABXQU9zPHrWysqIpESJjsyGf6UHID+OSiKQEY8WO18xWr2OuuzZjpu9LnFBj/lDxAORl/LdcnmWCezbpb0NyS8wIUNGFQvdkn5uW1KU0Lx/ChmwiO3MFEMxQJbh4Q13UGq+vGkvzhiF9+tqfSimIVNFohm16UNq9IurP40GDIvIiXkY62Aj3MoKHhnZuZJfUcLjMaiQtCRZCGDYIPs2OfiMq4djOq/9qI4/pU4HcC9u7hx78D/XikMvEcgMtXTLdVui8p1zjdf9
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:21:04.8467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de734e86-6c9a-450f-4caf-08def22b3cbe
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9349

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

