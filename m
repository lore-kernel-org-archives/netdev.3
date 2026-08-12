Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608233FF1B5;
	Wed, 12 Aug 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525916; cv=fail; b=AZTgEkK9AXP6NMeNLydmJki0MsirCB5lC7dtXGNsUKKMm/I+CIzFDc/cUunXPd0JRRl5m7L7rju1IVGQSsl1Z2PGunJRWL4PhwOSUJ1hHScNpX4d4iT2SqXJtzg9yPRAhWRoLlP40SsaDhOMPP02tAoXPmhn+X/CfymNA37nXEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525916; c=relaxed/simple;
	bh=xsVPRDjTOVotwn++NRE/mqfE7svTIzfFUdhA+6sLxrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbrNgs4wzFCw/pUv8fEhNuaNP1aisjau/xL4KJwo/CVK2LSn3NY1p/i+Rb9JPGHE9tZSFLAkG4uA+WviL7dwbvRdJi97ry4w0gLseAcpKkrFGTM9w48SFrBpqrXVN3zEkyj75lY5TOYp3v8ESkaMFEIdWkGqMfc+7TXZMNZxdmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UZm6B7bj; arc=fail smtp.client-ip=52.101.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UZm6B7bj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhv+5pmpZK+sZoAoTmUzfv60p6xRvkzFroNUGtEYMCcosZs5YG2yKSA7xEqK/xHkYHseZruv44d1yIP/RsJIcLY2xVVCRnBqNlm+ZSOQig6WpLkUBtjTCXWafW/Hwsjmm+qAoCSJSKaBL61Uhbfd3j6MhAjSFI3vsTg3jemOmHoQTIB4WE/L3Gu8IhO0wMpwC5h0quRRDL7sBIdKpM4DAc8Szi5+P1eXBhY07ioPJEn4AME7E0a3wJPvJ4cdueZr8DGiwlOiUPcydE7raYLk7ow2wAYo1wklWc5zLG2mhJIOrnMRV73SumbTmWCF4jCwArFvJUHfFvF0IkUDW3097A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnHOydzApuUPByCJABj5rby/l4pch6UoOzCkXDJge60=;
 b=JVF4vlIu/9ZfgEFYyA05AUcaZ/dWDPrg7zfVvB/qHYaycY2fV3k1pzHKY0ZZdmyrmAZ4fGVWw4lL1JZ8gN1ebSGI3IH17WBFUlKwd5TwMAAsCrdttAur+Mwvry1nNQpTbgisLPGcMk1O8Knk9Nl3Btj7juwuiPy4fou0X7DsriYDPgATlG2mRMOARw2VumkMoFm1Req/lZjSnJDy5cjNTZ4lM90hUTXr3EYUYyGRfc+W4DfnNKglnCXw+30dN+hUokpiUum5JQudGKuUwTEiS2b9v5vOIeDKudbOfQMiZScgLqLwezFDn48TU8zjV1y3OKyFPZyfYdtt+C0IykxwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnHOydzApuUPByCJABj5rby/l4pch6UoOzCkXDJge60=;
 b=UZm6B7bj+EK6H0cGQLWnBUwn6fkSnCm4kKMSY2aDwav1rT1hBwbGtzFsNM0KKd/n8piI/jm9ChWPV7G2ajb9BlQiz9AWWxMds1heEK28Px+UBT9yzmFGlnNjNz/R8p0yMm9HMdLQLXz31ZelNBIuLUH3L8H9IX1Je+m6iSbQOBp/ZYlMEuHdqZ1Oe75IVI86RuGEt8ucoFW8sCooecmA7U8vms/igYC0oaPkc8SYLRKqd/NTGJ+TbdZBD6V+MtVCoHv1+ZI4sL/ghZJFM+M1e6Pq2NskfSUv1I2GNhChivfgSZVSnPwqFeNNCD/huMsfCuBLKL1ThpO35Pgn/zELPg==
Received: from AS9PR06CA0605.eurprd06.prod.outlook.com (2603:10a6:20b:46e::8)
 by MI9PR10MB992184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:8b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 09:11:48 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:46e:cafe::77) by AS9PR06CA0605.outlook.office365.com
 (2603:10a6:20b:46e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 09:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 09:11:48 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 12 Aug
 2026 11:17:17 +0200
Received: from localhost (10.252.2.245) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 12 Aug
 2026 11:11:47 +0200
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
Subject: [net-next,PATCH v2 4/5] arm64: dts: st: add 3v3 regulator to ethernet on stm32mp257f-dk
Date: Wed, 12 Aug 2026 11:11:21 +0200
Message-ID: <20260812091122.566439-5-christophe.roullier@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000043:EE_|MI9PR10MB992184:EE_
X-MS-Office365-Filtering-Correlation-Id: ceaa22a6-a2b6-4997-7956-08def851bd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|18002099003|10067099003|921020|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	jMpC+UMBr/nW4HoBLwn/ycR/tijwsYfluBJ65iHAYbfEG6s8FOtI5jt0P29j3+XJQCmtHjQAgjU/OrY6LT9zBHyMdRPzZSQJyW6vyYwRXCl+g601lLE+ClbP6qJ/NH8msJJwqG5qvj+rJzJUAVDPf7uwFwseK3ikKBE9SR3vj5Jpz5JVt6eTqXUXLIlSXrG6Mrm7Swe+FaMsUNi1EPASgO2fU11USFe7TiwThRFcEkhSbDnniWbRXyLU3VsUU63zJK+1e/V1vJkQQ2ZXWHzle94KVjZnbmT2wj4qwYPWtAmZUVx2i1feIH1WMWiG1PM2I5ScyWtA/ay/PR0uXdu633cYNiBb2iC+Dg/HwH4dYiWm0AzdI2pRMh9xjHfOKXYeWPIGbB18rkD6ub0+q5Z3Czpc951ZvLKo3G7hvknxf4OXwsVjiJo4W5WgkvdklzsHvPuSVq1e1Ev2vvK9Otgt5NdTDtBKW5rbhehG+IcAyHEzxbGEF5w272Tb0ScYnVa3IhXDKXlTJ3Z7YeHKMX9j8+r4gr7GTtfYgnZ3WRrEwUqS2lGO6kXHqdNWSD9BgbEx4Vmr9haEOEhFtiYLX7iXUGuiLOoeiawnoorywRtdKijFV4ufGwo367bPGoJr23GKj+ZJd686AeS2q56oENmzfscviUHErMOPUO2/DYqdt7kI2UaN89bO6JntCjAQPQ66hLp+Xs0LLFNL5sLWMF7AJ8tXbfgfx3+i3pTqBzXBexYzbOz4LgtImU/Vzw5OlHza
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(18002099003)(10067099003)(921020)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tpivD+BroOWcihdQNDSDdmhBAunZJ3HWP4G3W9ySYhyy085NERjQZ89Z3XK/xNAH2udanWBPPNTXn6eNJcfG3xz5XB7KsctcW9CkxwaSB34gWHTlyG1R+bVAzkGZ2sj/ybDvt6lv3QGZ0SxtsaCPnKx/fdW6oIZuHSuLXx1QY0EwhpP15lkDjjnEjxPgTTHpnFYo1B1DCqASYn+w+mhSrMA1/UjmO7YFIHb+1Ez7vaxeTK5qakZigL1um95CkE2543xn6zQgXgdeoPxdgpC3ArZw+gvCH+lD4Ei28G8BTzKc7UWKB0a/Hj6sbtnqoCCaSVmXxSFp2ZJ5AjK4M+evCo7dx2UdWtqNzXOC2sukMvIJRulzprlwo5SSKo9nmj3w2uDEbX6zh3QcDe0bE3lHqud4VWabDfWyQxL5eAVOJlD6zYZG826cGe5eidhdnFs+
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:11:48.5838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaa22a6-a2b6-4997-7956-08def851bd63
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB992184

The Ethernet PHY is supplied by 3v3 PMIC regulator, add it to Ethernet
node.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index 8daf3dfd51339..e98a773448ee9 100644
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

