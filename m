Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazhn15010016.outbound.protection.outlook.com [52.102.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E6F442122;
	Wed, 29 Jul 2026 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318720; cv=fail; b=Fr90W8to+SmU2Rr/BFCxY9+OqExY3gJnOV+Ap0FDEJJ2t/LVrysNzbVHGfnwWYkoHpBbVLG3RqkONscBjcChMQ8CeIO/kQ1QiA4VmRglMWq/FtojWWYhII6x6ttRcprtKAaJd/xdCYIdwwJDhRIR1UdsxawGJxC2ThnsqhpNh2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318720; c=relaxed/simple;
	bh=REVS6g/Z/Rr/8fvX1+ifne4MOpE5cUxKjileQOXqRPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6ss2Nv7GhAXkYyNNALRlVrbnU+w1Rjd8fAdsUkl+DVSxivcvrtKPcBqWBFysajmJ1tKa+79Nq6yy+e52C8sEKj5b+zZuCiNcT3MrgQd4vsgGLNbxDzlHYzzGiNQSuxBVP7Uf26rIcoFEtlcpgo3QI8uY1nmuz7d1K1+qWkkhuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=CLYATLM0; arc=fail smtp.client-ip=52.102.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="CLYATLM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvO2Cf9pqkREMjrkH3PIJPPRqGcj6jVz8b0Er5oHYI4NMi+6IrdqHFMft5SXagjQecyvU6zgBTk4bKBKd1QRYiGG3yjGocm7aJraqOy+dpW02F2tlHbHkoNmi0Q5ZSByv+fZE7/lutXDSxjjmUyWMVLk8LnESvyKoCTY4KletwaAYvNlir6M/JdMYTxC5vzI5igwE8gDiZpMHyVtamBGpWG7/5GW/HMCsEkA2GLS8cHu6rC1hTZ31rJg7j8VCTQGlcLF64qty2GR+KU7wZdbfRHx5oXxcxijQSBUU2GzOnaddHHuvdGHI2e4f5cmkW+tvIUKcJh6GSaz1G/FpW+1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCHLXqw/QhUoGfrNSEpz2KW5IP/e54mwFhYmAbyYQXY=;
 b=wvoW4i7AgKhkJwMQm/A+CyI9dRvMLklAbTLEiXrQg2QVwYHnhy/hSL0n/p6eI6Dqwg4k3q3kSj4goVPT/bgOh/lW5EdM0rHgb0AO+cMtDE+pOGEyjIygowM+WTPdjeeIFVOaxrZw9QqgvmPk/O9QVJjmJ6W7/VK9i/xMaBQZc1Qbhesy/aBzuItGQWFmQhwikAjTz6q9YQln8Z69ezdKxemsIh+yI4epqfUk4TsyM+Njzxcd9Q45CzHcEKtw0vazv7QLxNQpGBxhATpOFKPxJxvqL6PEG7bZB6tSmhi3gdYAomtRydDyJmtckepQyv3vBMg2V+2tpeZIDc6R1qNeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=altera.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCHLXqw/QhUoGfrNSEpz2KW5IP/e54mwFhYmAbyYQXY=;
 b=CLYATLM0D1Hpddup9hn+03gvdI1wptmFt1D93n0TqUhB10LG7J7dScUQBj6yVsN7ePv3t0L7PUSAxfKRgd8IWeHnkPMYWsiF/AwSDs33Z8bzFFrICGMB2IUhevob2tH9i3MJ9Ea6yNXFbCBxukRho5CpP5D+hbIBU+IJvpfO06o=
Received: from TY6PR01CA0040.jpnprd01.prod.outlook.com (2603:1096:405:3bd::16)
 by OSZPR01MB8500.jpnprd01.prod.outlook.com (2603:1096:604:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:51:55 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bd:cafe::a9) by TY6PR01CA0040.outlook.office365.com
 (2603:1096:405:3bd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 09:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 09:51:54 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.40])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 4D6BB300027E;
	Wed, 29 Jul 2026 18:51:46 +0900 (JST)
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
Subject: [PATCH net 4/5] net: stmmac: Disable double VLAN stripping on dwmac4
Date: Wed, 29 Jul 2026 09:51:08 +0000
Message-ID: <20260729095110.164157-5-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|OSZPR01MB8500:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c6aacfc7-5581-4ef2-ec32-08deed5705e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|34020700016|23010399003|376014|7416014|10067099003|56012099006|11063799006|22082099003|3023799007|18002099003|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	1/r+mujwM6YNyJUT+bE/bnW6g8SXPO1EW71GrOcyS5KQJy7miboNvw5S9fQG1Re/ojFnJcvMKjeiaSiJ55kI89BXYRbGS3kcApnHyPrFEGYklTwsAhScTMvdJMSpU53sHkTrgA4/UT5IM8tcw+ygR1trHyJRdGlIKfbBj3ABPIivlDdf4qDGBz1KqV4TQ42s2Yjs4Jheui9O1n+pQx3g9WuJ4ZE5FNvrHAGZxBiEer8ZW/GUtjrhdt+Tz/6pa7J1hp1n0bUhvqOr8TS039I72ST5cy+LlzSamaIJNKlWBwD9veF/AtkLSvgHgmI+ge6T/SKJv1LGQYSA2aOaoKwEJJXRAWLUMS384D2Q0+HR4M/uZxP7SYhmbukoXBvafiebSvCxu1ayopiIVsSyw1e/ArgbkmC0Oku1g/pH9cFtlRB9LC8wjO5VKhFRwGWFvh7MjUQVEOyUg7EcCMY1f/GON17bSuUQeW5TGtNcZvnaaj/NDebNpCSkVVKfcIne1Wxzh9W4AKZrHOeYCBHHlQapZWjRhULPYj+I86hd6PIgmM2viLBVoE2rnr1vI+6JE5JeJOH7IAwpQpNNdYCxOx5f4QirKHwliTNIFuJXWFlOElu6YtQ1+J0+iMJy0hNcEl/lGtVnure0VNcUkvjj1m7WhDy+HxmowyJawppDS5KT7wPW3horzbvf0/Qj2E4xvOaeMLDZB0DhtZzaLGkUwrd97AtBxxbZFhoDhiEWz8kyP3XKav8odsKcBYmCxuB/OHqX
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(34020700016)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(22082099003)(3023799007)(18002099003)(921020)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y5osrrS3dV7xhmyO/e2ZCdtK72UodXtfLV6yfQ1BvOr6wTS7dgjWUr52UFPM5SD8X0zoZiWVR04g38C9LA1Y6snUkUmnFVAnGK3WFnDeIRpEIp/9V5KT8io3ivbIQ+QQujnkdcYG44LChZc/Vl4b7Yo8V8n7mX2ybXuCaHY0oW72CB3BGyYW+TKzURrEjEAoKwQqnmUqnGGoZzX76RD4+pnn4gGjw/IaE265quKEWB8axPDbgxYZS/K/cWILtYkhs3jLiRQKZBd+ty0hH5xReZW8H6zyvxEsdijCHbxgA7yF3yYOzN0zKqxSX34XD2GeviHbwP/1CVhpmO3LCkjtfLY4ma/J1IAhrw6L6nmsKl3b31DlKZocX60AUSsxE2JCAfcSc3lGXmHFtMekB/A59bs/FzBdZ56Cn1fqa6Z3lKBy8w2INVLcJFCzf4TJKF3R
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:51:54.9590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6aacfc7-5581-4ef2-ec32-08deed5705e7
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8500

Currently, hardware VLAN stripping is broken for 802.1ad tags. vlan_rx_hw()
hardcodes ETH_P_8021Q when putting the hardware tag into the skb, rather
than using the actual protocol from the packet. Because of this, packets
that contain a 802.1ad outer tag are incorrectly passed up the stack as
having an 802.1Q tag. This causes QinQ ping between two hosts to fail.

vlan_rx_hw() is shared by dwxgmac2 and dwmac4: on dwxgmac2 the tag type
is available in the RDES3 write-back descriptor (the ET_LT field), so the
outer tag type can be determined based on that info. However, dwmac4
doesn't seem to provide the tag type. The Length/Type field in RDES3 only
indicates whether the packet is single or double-tagged, not which tag
type was stripped.

Since dwmac4 cannot report the stripped tag type, it cannot support
hardware double VLAN stripping correctly. Disable it by dropping
update_dvlan_state from dwmac_vlan_ops. With this, 802.1ad tags are
left in place and handled by the software VLAN path.

Fixes: 750011e239a5 ("net: stmmac: Add support for HW-accelerated VLAN stripping")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
index 1e47ae62093e..9b5b3f11f699 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -273,7 +273,6 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash)
 
 const struct stmmac_vlan_ops dwmac_vlan_ops = {
 	.update_vlan_hash = vlan_update_hash,
-	.update_dvlan_state = vlan_update_dvlan_state,
 	.enable_vlan = vlan_enable,
 	.add_hw_vlan_rx_fltr = vlan_add_hw_rx_fltr,
 	.del_hw_vlan_rx_fltr = vlan_del_hw_rx_fltr,
-- 
2.34.1

