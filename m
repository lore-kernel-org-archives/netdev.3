Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazhn15011023.outbound.protection.outlook.com [52.102.171.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6174457A2;
	Wed, 29 Jul 2026 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.171.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318704; cv=fail; b=U4ki0v/LlCbcF8+NL2ih6OWSgRVhsygyS45Vq8gqpQkMLEOaeSPYi3BJngCeiTEwszCxH0zjxf/Ds70uGXFYCpka8f0ExXbqvgzxE5bjTaVXHIBsIzVFpaBJmZ7Kq8anz1Be9w6V7+lPgSV15SJ5HGikkuVmhiewDhJb3dtArXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318704; c=relaxed/simple;
	bh=hlc45IAqYD8KnZEghy+QYCZ5gMjjMpxrg7YLj9U8EjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVA/7rpgUtAHcEZlA8XZt0A0g+0oKl3JK8LL3UBFUTGvh1cp63ECDnf3w47/gC0FO0JJIkpn8nz0I3HKjLdvRy5nPPUm4pW105Mr3Xmi0MtwasNM8NAodNTYtImfp7lUbEnjEa2mnrlviC+c8UTGPfnfCkRv9dfYEfvc7C48LOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mY+cK71m; arc=fail smtp.client-ip=52.102.171.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mY+cK71m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RH/RSyADi4Gtk1x8zbNle79A5j+o/RF5WHpF1d/cuNaPNcuXlcChaZ8jTiBia/hniblaMN4LxBLhrpaqMFCGAcooozG0VGwS2D9gkyLWhZ7iFrYcIk10nuuAG3/YziZrQJNKV5qs8C7cwUpmKsK+vgZHivbO4+pbb4oPfz5eMLlFnJpWcR51HNM65SBLFLziDNHOeFM1sRW5mh//Q9bJa1OsC/hVa78WRNd+48F72FWtdwdlgiBtLOA+XwpMWB5rTKLg0EPQGztvnT5NmdHjjZCGHc1wPRsQ/j52nHV7UCHfsvn71qG1Nuu/qx25opTpU7nxiPUFHhYRlqH77sWvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMXF+e6dz6AQNMTpMZjafjUojKkWdq8R1RecLLKSSqQ=;
 b=Aau+71GTqovFlY5JIG+s9f60dU2RH+ydKNWr3zFKOfUDSgMJseoXNrIimMegLRR74nDwHZHAoI5tr6MsAAKUUqjz0kdGvJLHD8XoVo8dU4EqIWNCVK7xr3NPstlsZYXPNvIHfje/B0csSSc0I5U3PVAmUlBuJLK1WG7ZbxJRY4njw3Gd4PlDm85g9ljwpTRfVKjAHl6DScpQIJGOJuG6x+vKQc6M5rnYkM0pjGwoUz2QlScJGkuRwsTZ7pNwDSwTb/FjsOQ05LVxa+ue4ydbstY2IJ9TUbsw7UZtLnE0YxKVvpMB6yOFPforMZSt0933KqUeQOWKIuZh08q7DRng3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=altera.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMXF+e6dz6AQNMTpMZjafjUojKkWdq8R1RecLLKSSqQ=;
 b=mY+cK71mBbd7BNBDXpgai924UU1ftPZfKyqo7IDcB3TkZ+vQI/MrXdz0PdIiViFZm4JMLAhX6L2mcpcBK41cQRjRhzW0FUDmAjqO8KgTts0krj4B/UStmsmeF3pbrmw4Q8xB4j9L2iRcSQmH5Z8KIDPJbPf84VD5M2Fp+pEYGz0=
Received: from TY6P286CA0040.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b7::9)
 by OS3PR01MB8116.jpnprd01.prod.outlook.com (2603:1096:604:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 09:51:38 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7:cafe::60) by TY6P286CA0040.outlook.office365.com
 (2603:1096:405:3b7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 09:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 09:51:38 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.40])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id A7980300041D;
	Wed, 29 Jul 2026 18:51:30 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	jun.ann.lai@intel.com,
	yi.fang.gan@intel.com,
	boon.khai.ng@altera.com,
	matthew.gerlach@altera.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH net 2/5] net: stmmac: Enable double VLAN processing only when supported
Date: Wed, 29 Jul 2026 09:51:06 +0000
Message-ID: <20260729095110.164157-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|OS3PR01MB8116:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e92bf1e7-3481-4d93-8b86-08deed56fbf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|23010399003|36860700016|376014|7416014|82310400026|1800799024|921020|56012099006|11063799006|10067099003|22082099003|18002099003|12100799066;
X-Microsoft-Antispam-Message-Info:
	QomMmHFqxxbYy8vmsSCDPgKMW7wq3PP/MTHIFCW+y67YGVxhhAaAWsFhA1RZWXUYtHgqvI3uloGv8c687Y0ElJAbLTsSaQ6mDxl8lW3dnl0C3oEUK17hbeSv8zwhUMoYh76W2q65qBOxe0HJ+wTgon5GYDXsRgu9N5iRzrK7zqpgWEbdzD9NHlACfwV+yhL3weJdebaCcl+sGg/2s0zd0Nr/73s1aoEu06LGxzPGAclZTvQm3ZTxzMnPfhjjFc4jWX5gRX+EKzliLEYB0NawTWYJi5Djw4aULaDaJek00lsyNeCj/tm9v6tbIth53S3j8AE9R86LriUKVgI0eR0LyOsqNQXoDh0OsHjZBQOnN1Mt1tQMxvKY9b06B+mZsSbX891sYovjUEQoKNIxtcSgo+A03JplNxZzdjgJu6Y5G6IvyAyLmxUqzVO7jyA0A2gIQHUblhraNU2OcDfav0tipZkGN0aFx/bJ1bZJ+f1zkWxodH7wTGBFTka93g3Lb+NAYOIGGp+wIdk9iIYIikp0VPd8w/EawYl526QUfZJ9COenFDua/fC82qgtt87PlHched19kl9V1Hn1NPpOizAT9+MJGLCGMmUZd0g3Sw4UGaC7FU1Sf3biqQORCZUYdwooyvKVx4a+HAj2Ti6mPS6jcxJ1iULdA9j5/sIzps8xylxyl20rCtoDghTFAR0RDs96iUNX3kloTnUO8puVfEGXyfm+QWm8p1OkjawwPALZ1jVDA8MjNit6npGqAbKLgL31
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(34020700016)(23010399003)(36860700016)(376014)(7416014)(82310400026)(1800799024)(921020)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6QswS14GIPnMQ3RK1nV/EAGuusHsAAOg2TLZ91JikhJFPmm1dcywrYitRBp4xBV0OuyOPZsv9Vyp/i3aLfimvmoKlxnbrpSVRXqlDCTdNbrqPFrSzCoeXJ+vaU3HsSAqKktTICTVxfSz9tbWDE3IHP8eMkpQsZWo9mG3zMTsGsy8Zkt/X/SrExatz3Z9d/IhcXJVniV1OB2+yRjKzt17YLk8D2bJeYr+MScWbgqae/kBcjrXstpRI7Y559kYEmM6hElGvFwm+LLh/YuZsBT9NQTZGHA0uBBRnurQ6Om30pip/O51QXawwQMMZXOea9urH9OcDqBCXgy5TvUJqayS6xkIcelxGHkGo+6LluIrcKZ36g+5cPWIMAOcPAqqNrsO850XadztIBtmIkQPuPXsqBdpB3zVOUwOY7GUiUHEqF3UdJz0S+N1kYasMsQOKSAD
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:51:38.2762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e92bf1e7-3481-4d93-8b86-08deed56fbf4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8116

stmmac_vlan_update() turns on double/S-VLAN processing whenever an
802.1ad VLAN is registered, without checking whether the MAC actually
supports double VLAN processing. That capability is reported in
dma_cap.dvlan.

This was found while investigating a separate bug in the double VLAN RX
stripping path. The outer 802.1ad tags were unexpectedly stripped by the
MAC (because the ESVL bit was set).

Check dma_cap.dvlan before enabling EDVLP/ESVL/DOVLTC bits, so that double
VLAN processing is enabled only on supported hardware.

Fixes: 3cd1cfcba26e ("net: stmmac: Implement VLAN Hash Filtering in XGMAC")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fc9f1342ea45..ecb8eb7e29ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6802,6 +6802,9 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 	if (!netif_running(priv->dev))
 		return 0;
 
+	if (!priv->dma_cap.dvlan)
+		is_double = false;
+
 	return stmmac_update_vlan_hash(priv, priv->hw, hash, is_double);
 }
 
-- 
2.34.1

