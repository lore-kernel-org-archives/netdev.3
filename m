Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazhn15011021.outbound.protection.outlook.com [52.102.171.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4B4570E3;
	Wed, 29 Jul 2026 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.171.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318688; cv=fail; b=T+sA5o22cmjNwY0r4UAUtZrv6yyjb7L6RC6ixXzKDZ9lGeb/sqUMNuvQdMTC8+M5jAFdmqEOe/880JuvVS/nKZEBOoKC6xMw30uDIGW3pRUeJKAe7gTS2+MwNKlz6K+1mk1/HV5d6yRPoEqPx1YMNb94rJecyqIFe9eYwe4Bo9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318688; c=relaxed/simple;
	bh=oNZqLk7wUB+dxhi7XSyD1Gvp7wlO1XZ5lABw4ZUufB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GXwCrjVkasxgrdT4W2ZtfkhfIrXKbnediop+II6ODzl1Mch1Om24tyNJmlLvBFhps/OCrlO5jJto1eq8e4Zw8fODWOsj1lSU7dyTS0eCUmZT2TaLVLA5QkI/np9CpyF8ezpz7aOnXop/OnpQ1/OUxlD5xSyMCEcNKQuJ8Qw3ljk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=PVZMt4W4; arc=fail smtp.client-ip=52.102.171.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="PVZMt4W4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4wREjNs/LtyG+0Eq/HEbMhTNXfN1GanXiNsl/5a48EZTGFHWMqnENL6ffn2CeUvnVgYICGkx6NxOao6FAwk8T+tPPDVXvkhFds5/eNxhyt+RVr5FGiQV4p7qSwSQmh5N0b3gzK1L9/TaK2Dypo1Pj2BbB0Ev4Vd6FkOmMw6SNF7O6ypDiw+dDvvcH81EX18BXsNRdJH0MObhNbxl9oIdscbYew2UWHGRaAmMS/xXVCxHzopO+JSD9Cee/NF2xNSwaDf7IKVpp3vBhchSk4hkeJmWZs1Iz77IqOGNe2VksyPa6TEdseHC+QZgcVM8qnrdBEsbe0BSX+rToxTTPNDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNbJzJE74xw8nIYZhPcwkTRS8Zv/qFDUaJQKzOkj/hE=;
 b=cDDhD+Tw+CaCRpajbJheY+DSUoGUCkD3fww6oWjgKspRKN/suKoiluqcgsOUU3ehHDM+A3ilJvr84J+QEsNLYtYDVQOZWfKh3srDRUP6xcispxZcpOHwajG1v36g1Aj9FIYk3fE7dZ+vzNPIZ70yL1eEEXCp8BV14rYPHQFdoCnex9UlJbWjS7m0fPEbx7VvoWqFvnnq6/RwJZDPr767IUeKb5bL+GjcJDEcdtLc8w5vKBhJ/sDl3YWAIhdJ0yr2AjiijhCDiU7VzDB++KBu10SNl2VEa905D1+sf4M60kZLzmbCIMf+ocFw/czTXYQhpjldweFgzSZGvPaCB5ut8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=altera.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNbJzJE74xw8nIYZhPcwkTRS8Zv/qFDUaJQKzOkj/hE=;
 b=PVZMt4W4Fz+nD7mj77BNTpXDgowqhWuAYCCQr1++d8OlBU/twAfq3ZeuXf74mvhg/rjI4bcfk/k9X9+8UX9zUFGN56MfjIs67wTL1twfeumRqb6CxRQnUm+FzW4iXWwTx02+lZ7/vOiuweHKhIgZq7vlAHAa1ds5wRzbvZfVVbU=
Received: from OSTP286CA0099.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:219::16)
 by TYCPR01MB10888.jpnprd01.prod.outlook.com (2603:1096:400:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:51:21 +0000
Received: from OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219:cafe::a9) by OSTP286CA0099.outlook.office365.com
 (2603:1096:604:219::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 09:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D215.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 09:51:21 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.40])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id E8447300027F;
	Wed, 29 Jul 2026 18:51:13 +0900 (JST)
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
Subject: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag handling
Date: Wed, 29 Jul 2026 09:51:04 +0000
Message-ID: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D215:EE_|TYCPR01MB10888:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: df090fcd-73f3-4378-1d82-08deed56f20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|34020700016|1800799024|23010399003|921020|6133799003|3023799007|56012099006|11063799006|18002099003|10067099003|12100799066;
X-Microsoft-Antispam-Message-Info:
	+OQSGC9n3cwLJLEy34K8IeedGqWHId+C58msij3ug4GvQz0P/PKcy70JANbOm/XnqhT401tl0UZ0EtacLX4Px0OHuGZBMsmR6slNG4lPCzrdOdoHnjvg9GQx1zgq4XuRas8ZjQ0HmIxeZCTzfXxHQVfxHDcfkTl+e/hxOYylrHsgzvynpSgZO7LvIGp/aSvRyeAUXIXFT1CNA1b9rsd1/vQJ8F42AUtRjy17fzo4uIz33LrgoHtO7JKVZ9qjbeZ6SlF2nSGeDFbY+UB5t3FnA5sqCf+O4bjsi2Qonf4aKr27/5JKy6ngKLvX3489hkv/qd802UJ3Ytbcdr7xaugZb3pO2FBzG26lxtRil+2zQ30upoVBnNWzA47dSLyq9GJ7g6JuUAt1tilZwdaC8OKueIFqZhEWJ+63Bl876gQQmuhTER8kxs72OQj+NPTD/4Q/ScaGUjfOyIlWNe70UykDlZrAGSGCffmWd1WgUyV88+BBjJ4oMSsZLbNUnTm7HYvKfKpHcX+Bfm1UjvzsfJr8Cz7koCX3uH17yCmDzEXD2BFEc67ErPsIHgBV/AZBYz3S6LX1s6P//c3TbOENo6qVoQ5unODSiT/vaaVqN2ycD+4ejiJl4Zz6CLzmwS65ag9PI632dxdBRFjWLJ22RXnJdytbcvLCKxOVXMqF7tmKydFcsLITlGJy16CbD3UZhbVqHLOVK+MH3XCvV/gvxvT77OttFQzRrJgoN7tbxBgk0bcMm7RwvFiV/sHhUN+Vg3Gs
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(34020700016)(1800799024)(23010399003)(921020)(6133799003)(3023799007)(56012099006)(11063799006)(18002099003)(10067099003)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dVh1VEKdJXqh/bWLpBXvCddUFAzODY1W3/IE9zznjJ7xLDUKOB5Wkjab2eE+A2Id1kMbTnR5ODr8n58fU7I1ihe4Nhi6db359RfUV/PCdvYDZHa/XpuwrGhol100dpWBsKu5B9vHhKLnjJNIYtienAKLJAV3BOdUGgEpXX2xxogzHr6w51hvkUsUfujJ4wWPZ+jQvfq2Lu9O6oWIs+AEQ28XrsIUwpBmVfQivGIsRWDcx5HZuFz2PM/msLBpbqQX9wxKHf5Eq2xbs+V+9YlUfmmsOiCl95JP6dvnx+YK33TAN0sDNoJUlisHOf3uhiF6U0sQfww7EXh3j3AIrWTPv8Qam89SGp5NajxpbwnLS3yQmDrbhIPLUVvMEsrFXGosOw7NsDAXHwz7eNb3ux5CnbyMR3ulNzUc4OJH3XqBQI7R/V/ZZShwsC9YQ77ri+wy
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:51:21.6403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df090fcd-73f3-4378-1d82-08deed56f20c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10888

Currently, hardware VLAN stripping is broken for 802.1ad tags. vlan_rx_hw()
hardcodes ETH_P_8021Q when putting the hardware tag into the skb, rather
than using the actual protocol from the packet. Because of this, packets
that contain an 802.1ad outer tag are incorrectly passed up the stack as
having an 802.1Q tag.

This issue was observed on the Renesas RZ/V2H platform (which has a dwmac4
IP), when testing QinQ ping:

  # DUT
  ip link add link end0 name end0.100 type vlan proto 802.1ad id 100
  ip link add link end0.100 name end0.100.200 type vlan proto 802.1q id 200
  ip addr add 172.16.3.2/24 dev end0.100.200
  ip link set end0 up
  ip link set end0.100 up
  ip link set end0.100.200 up

  # Peer
  ip link add link eth0 name eth0.100 type vlan proto 802.1ad id 100
  ip link add link eth0.100 name eth0.100.200 type vlan proto 802.1q id 200
  ip addr add 172.16.3.1/24 dev eth0.100.200
  ip link set eth0 up
  ip link set eth0.100 up
  ip link set eth0.100.200 up
  ping 172.16.3.2
    -- FAIL --

This series addresses the issue for both dwmac4 and dwxgmac2:
- dwmac4: since dwmac4 does not expose the tag type in the RDES3
  descriptor, it cannot support hardware double VLAN stripping correctly.
  This series disables double VLAN stripping for it, so the 802.1ad tags
  are left in place and are handled by the software VLAN path.

- dwxgmac2: the RDES3 descriptor does report the type, so the code was
  updated to read it instead of hardcoding ETH_P_8021Q.

Note: patch 5/5 was compile tested only, as I do not have the hardware.
However, it uses the same codepath as dwmac4, so it has the same issue.

Ovidiu Panait (5):
  net: stmmac: Remove VLAN perfect matching dead code
  net: stmmac: Enable double VLAN processing only when supported
  net: stmmac: Move double VLAN handling to a dedicated op
  net: stmmac: Disable double VLAN stripping on dwmac4
  net: stmmac: Fix double VLAN stripping on dwxgmac2

 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 15 ++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  8 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 16 +---
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 87 +++++--------------
 4 files changed, 47 insertions(+), 79 deletions(-)

-- 
2.34.1

