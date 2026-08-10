Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD937F8DD;
	Mon, 10 Aug 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367447; cv=fail; b=FsbD7Lq61Wy6SW1g1Lcgsfeb6WsISxAMOPmo8vORc+tNnltp4DBlBPxcx/KhPf8pmdbShCfPEzB/K+30cfBTh1yIt4OqQvnGUqQ32KY+1GNv6ZtdabNH3NxsVIQk5kJlMxYZA7qRE662y3d5KD6dCdFpNEQZtSxMiCicDwS+CAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367447; c=relaxed/simple;
	bh=upoOLoV438gjxxBLAx6QM2c4thxAVYdbpUyGQRmOa6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0E3H74oIwUrrOYcwtCFkb9cBH7n31BkHKNN50tha4zrx8pIHYRLR2cvny/Id3ktLOKarFaUDZKcDRuXIYBmtNgi1YWYdpAhpLrZyV0L3EcAj/xy7236u3WjpWQNLN2BLJf7XQkzXZ4io90Z6QNuVIq3h6PDWxbrSZn9Y5WlWTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=P4ZGzk2P; arc=fail smtp.client-ip=40.107.159.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="P4ZGzk2P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeilD4qhEwJkU2yxiYfz3qMLCLGImIgXTS0Rfw3yngs0CTy5NKFyeLWenNynb9A3Vv9ntVwWCngzWOrf+ufDMeQkyDc4kbtdFLiAWGDrkEMqEVVx7bY9AlvWjwJpI1GvcidOvEAIZU7xmoF2mqytvosJP4jP1NIxKO8jta8Oumx2amg9ZJfqZdlRvL1hjErGS4aiMoBl69A08g/VnB9Lur2uXM8+1nyILwQoJ3Uo6+DKxdewB3p0r+wX/EWOlwdSTHyFWGJ//e1/ZqwgbgpfCJjYoSvVmvhyTRmWmXfYr59yDAWzALBF9eGe6/sbptD5hoZhiWxm1bji4+hdozh1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fztU8m3MhYy8ptCoILS5OqZgo/t0IA++3B4AcS4zWN0=;
 b=SIg9fDYBPtOmGbnzPCD+avLBHZ/qUsvRqsLt/plm8i/RzpHGpRipefSIq1ceoJOe8hPP5IyrcKe4PUIvcCbmLheibxuZKprpfxsvfz286jK5w1MgY2PS5Wvrf5Sn6Zk0BYyw0WeNoBkUBNMFVmIVwuH0+AfTqhW4Q+kNEIgDWGa25tPwNlo0+pQXlH7/kHc1wU3CIfQUuuJ6PQk98IGyPP3nphFK9H+YIxIUwUvh6gvTNJEk0zGbQUYcLcbTtAvMrhQe1hpOeTSS9e1Qyri9ZtMuLj8sKZA7is2c1pXJU4+8AP+kjoqhcHd37PG2112XwlAAQ3YK3G28fAJbK2IUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fztU8m3MhYy8ptCoILS5OqZgo/t0IA++3B4AcS4zWN0=;
 b=P4ZGzk2PTQV1vnc0FXNK12cczLhY/KPkd+9gMU+A3iavN5EGRQsrKQapw1EIDYqvs0ZhuD+h7kcfpc2nMXTwVnqQ+eb8Zjf3x1HejwHVvAaz4jgf/177AD9JsIkw0DxajaljvSYCUubR6gq2kJfrReLUzbVeI+PP7GGJBeq/anShl3uWAGhNz41EEVq37oLXrXYTWYYgodSM4zWxWb+ZdELjhIrxec3XDPpMO9BYx4sMA/96aoHdxzGwpxtzNE3cJ78FGgiQSjEJaLxt5EUMUuqc3FxFwynqNHatgwLP+Uj7BnWZsuGwRh/Rd+jSBAF/SBkHmdUguuvNdLz6z33Jow==
Received: from AS9PR05CA0093.eurprd05.prod.outlook.com (2603:10a6:20b:498::18)
 by AS5PR10MB8269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:67e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:10:42 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:20b:498:cafe::79) by AS9PR05CA0093.outlook.office365.com
 (2603:10a6:20b:498::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 13:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 13:10:42 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 10 Aug
 2026 15:15:36 +0200
Received: from localhost (10.48.87.235) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 10 Aug
 2026 15:10:41 +0200
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
Subject: [PATCH 1/3] arm64: dts: st: add 3v3 regulator to ethernet on stm32mp235f-dk
Date: Mon, 10 Aug 2026 15:10:30 +0200
Message-ID: <20260810131032.455435-2-christophe.roullier@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C716:EE_|AS5PR10MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e7ccb7-1ebf-4682-60ca-08def6e0c846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|921020|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YwkPw26VLv9z2XTH1VgkP9o2gFkDAIOAROuWEFG9cUFMggxwEwiA0FypSx/0+Sbvu9/Ggal5RM+r/L3qkU/z+4Xub7L5LFCIZlOQP4UWoAN/ESScERrHQljab8h5sPBOtyY/rxZstBzyGg+BVoyuTZSFh3sB4R/7plU1TQOt9D1zBAZNly/I5z/kR+4vYmJnaAYzkoilhzN9pSfqzrKKvq9alR1lWeYjLxzCKmbh0dZsumL03CuNI/ORzzmFcSD1bU8JeHay3Oy4UKhgBRJ/oPXSxM8Jj+mTTryxFia79eW4xsIXOk8FtDNND7osoxdGY70t4r71ntsRz1v4ApX0ZsiU0CHsFJTHg7qj4KhMfEBOU7E41w8R48+E/Ch1j5h0DX8b2N4j9KscDq2gmN4zvg3gjUg0QOMZ7mZV9dpyfVzQtuaFGhHHxr0QVUQD6sUrAMS1xYMYMDghY/djpS2L3ZeGzJsKsDIDQ8ly66yKgIKwiuYulkD7wO/hx18fvRxiRh0I4doCXoNhAYqgKnp09M3BeY4HkqSyB7amURbuvjsZg8aM84JnPuaIKsfXCyT/0GI3luKGq2gTkDS4e1HtzpeGcSG4o4+QOWHquWnpkHT7MdxvlDWTR7JaYN0JNIaP+yeSq1+YwJgoD43Jow9vpqUhDqy5bvHzVosKipphr/tQRjZ0pfidy/EQZupsswwmMQKzQ5bcrg0F1inJ+pZuvRipnZLZtwUnMQjMCIqiJeD1XSjj40v008wzXvtachFo
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(921020)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hqAiCk3HgliolMbU98KfBliMRC3RX6tqeFGI/PEHPdDkkbTkL60TrHVzTNqdcqThcLUmPQmNFU3lbL7i3akBLu7C5XOJHMkkWJwqLvpnYC7mSZ3FxFQRTVCBkw87pyuPaE2lxzCSk4wpJnysV2FyY7PBYBVSyCeQn7b83oEll87PoDKdDxhGqq5J1PG4wt1kXuF2dqFE4AVPzbWPJ38pecDNP8VW+g9Rkbw9q7/xJ/13JW/ZWq3BfMwYc8gMo/iJXzICT+kpGc+6rVJ03hwPNnLxZgfCQ0hquVy9X9kEijyp+MdOblm+N4XpmdwlLO+CUWclu6RZoN9u3GrFuDwocVRyPcXnywdhP59cTBUA9Xyz48+3GEK5I4ljht5Ff1RsgimSXJIIwtogeeEQhVIjQjti7TT2EPVTFIV8jHBeuJ+5PsytVrIiY1RTPbxrgvik
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:10:42.5284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e7ccb7-1ebf-4682-60ca-08def6e0c846
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8269

The Ethernet PHY is supplied by 3v3 PMIC regulator, add it to Ethernet
node.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
index dd4efbe5a46e..fb49cd2da2c6 100644
--- a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
@@ -137,6 +137,7 @@ &ethernet1 {
 	pinctrl-names = "default", "sleep";
 	phy-handle = <&phy1_eth1>;
 	phy-mode = "rgmii-id";
+	phy-supply = <&scmi_v3v3>;
 	status = "okay";
 
 	mdio {
-- 
2.43.0

