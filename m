Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011059.outbound.protection.outlook.com [40.107.74.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B04F0533;
	Tue, 13 Oct 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891924; cv=fail; b=CDg37WN0KqIA4JB4ITKDnXeGc8gDRzqBODLMprKHiP2dTfkhkfqt5U8zxBh15Z95Y8MvHC8g1CWNOyn6yzbdueVKxYqcRTyzrumRjBcr8Zs+EIUs+ClepEtGzEqaedCxzrrJ7XKh3zEhxuORCmmM6vwDRR7TisVhqFFzC3io36A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891924; c=relaxed/simple;
	bh=aW2NyW/YszKZm7If82RgiNEauTaTL61FghDyPaFZy24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CHJleK2UeCzReFepwlv7F5UCCiJgADDcLtjjbwzIWjBA0Qj8ztMPhHRkD7xfB8gvwm59ZgB9BaG7bY1F+y1y9nEJ508LGbu0KaLChakrZWwZ6pW5dS9fYj6kkAxem7rl3DZi6RxYhmd5enPi4NdKyHTQvpttePbfSzjymmcOAz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=QO3rFX05; arc=fail smtp.client-ip=40.107.74.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="QO3rFX05"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQR88AzEcN89rG1tZmN8rM22kQ17xpp9Wlsp5G6alvYGt6/N9MIE+S7v/Mta+aiPy5aCYSZOnijUhdJMLOm0MPe5YqUx8BDdzCeYJ55oW+djJp5X0dYTiimF9TIbUTpY9w9Xw2WWOkWUDrrA4OXsA4pHFkiB2LYKJ2g1cet936VBvzR6gaos5chi0ffsAao1vbV+iaK8pzxYdEqgmu/xmeWvOkiY4H0cFhgXhycatJwdi46ZIyOjSa2eU49810FGVQQDbVYOEneJlPn9tIKIkJphnKtmzc04BOGVOZMSpgQN/1vAUgEtgkMg0VbIZVu+2sf+yMU+E7acxqQljuTqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly4XvGD5pppTZDPDOEqP6AmyaK2yGR/pnwe91PJ+Sq0=;
 b=ozIFAl13nR65nmF4peBBX0fPqcYA1a4eWajyk44/g4ANmzHM/OAst0DXSlpxyxQJnAot5qv1qdWZJbq0/3ph7w8aaHhGN71Qe4FZ4wsURAK2Ub5HuuETyvArgBcB1xzvhl8VCSZk3UR/6/kf26waoJ1rGHNyCU5SbbslDLo4+V1cVdx7r39OZTJ21gAHHQ5KV8gK9EqKvcTW2s8hOkvEwX+nx/x/lDQzGLVZGAlw5/qvyFqCLzfCfaETKlNCY63KoJhJJiv0CCM1ivlHnFjAd6MWKvjr3ayVonYbd2FeBaDbliGcY6OP6cj9NBxPikFHoMnthHfqeiTGKBHgNWmVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly4XvGD5pppTZDPDOEqP6AmyaK2yGR/pnwe91PJ+Sq0=;
 b=QO3rFX059AE5z/VjXJWkUHooWVNKeEEBetXZmi/SdSoYs48O5Z/D5CoNsuZNbdnXOkAg3NbB7CXpuwEK386Lho7LatOvKDKurocVxjc14p5oLQCjswYnL0Ik9AkPMJ9+kqIID1ha6kXOiCYsWzPP/WRaSuQ4DyF5IJpJSDpegF8=
Received: from OS7PR01CA0099.jpnprd01.prod.outlook.com (2603:1096:604:256::17)
 by TYVPR01MB11215.jpnprd01.prod.outlook.com (2603:1096:400:367::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:45:14 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:256:cafe::54) by OS7PR01CA0099.outlook.office365.com
 (2603:1096:604:256::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 11:45:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 11:45:13 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.5])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id BF9A23000270;
	Tue, 13 Oct 2026 20:45:08 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	xiaoliang.yang_1@nxp.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH net 0/2] net: stmmac: Track and report the TX DMA threshold per queue
Date: Tue, 13 Oct 2026 11:45:01 +0000
Message-ID: <20261013114503.57487-1-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|TYVPR01MB11215:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 023652a3-8aaf-4a21-8d2b-08df291f714a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	s++4ebF6MuWM19CXGVOMtWtd4FiNhWc+f6NEFp0OCDSJ9qLTrJgRXmpWRC5Q16yEMry57Bwq9VhyczOfHklgUP0p0Xq4I7o4ILCvbDbAwipbK1+yuUWfEU86eE2aBj87+v7a9rmua2yho5/HoDXpWrviCOq0h8urWfLnWxAAQD6VOt3+5EunLHB67tJ4SRznVyMHQ8Hl8/CH/hAVuN8iDeKY0wxZfVdDICrsd+eieByBdKzEb7EZSII26dLTo2KHJ2DXv/ICMI4+aawXYJ3U9qWuR4yo0Rsv+tzuuRVsj8i/EAiif2eKLeWmklfk9e04HtYMSNWyGc6F7HfBL9/cUuRUvUd1QsrDXBYCcIxXhlnE5qGvaKuzK229iBk0RFs5qmP8taD58QMFzRZJLsZfp/c2xc+nkej35zuafEkJheTO5m0gRI39vnRLBzppDJipZ7xVqKGfYind+qVFuEdEoShaYAlXCZpoDj6xWP1t+e6FmKvR6Fa86JaTr938NOKH5GrmDMzzVPPxG/vV/5eeh3vobbkvr/dFMk54UKRc9WfnqgbP/XW3KUS4Zix2M7jf2Gl8IvLIyoDBtTH0R+tyM7GQSsgBjkNEBV69JSvXTDlN3D5zuGKwbGcTLy+6x4ge/xobVUMoezfZcTl+NMLbZ71xAr/jRrwKJNN74x1HNDL+tWO/oZtb0RAkO3lZzorwpe0H35K6dEjYIBhfz0k2vw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TvFIZhWhZ6YCC25mMC1FzNOSfbyw9/yRXL0ZFGQgNsNI1srONUO3bB/7j9D/TjgeJXlfZ+udwraT093HHrVzefjjQ4BS1KzntavR1KPr03VzSEW6X0wYu9RgPwE/PhoMSy+HlW0/o09No2rnNEjeuRhuYNjN7gWXCBChnmKLq/whh442eFGMPdYVLVqH63RNJByV4G7FsSyMw4WPzQJvXjsdZ5GH+WPbewfaBlf+gC3O06qypIUmRWGYiWWFAgfGDSY61BPZ33pP4aigRJu4KsX0WgHDUbJRhTYgjXyAFDO8F/BudOIEJHrnQHJ4tqcHpqRCCH1oL9da8JGgHm8u5dfPp0USQ7nNv72P2JWGIyswgEs/5itXeDZNM41D4PV8bQpDo/rsvn+txBSS0eSfsL5jb6SNR+SKcGVVrQGSlHxQ2LiOFrqtt8EUWyquJHXj
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:45:13.0713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 023652a3-8aaf-4a21-8d2b-08df291f714a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11215

On the Renesas RZ/V2H platform, which has two dwmac4 controllers, we
observed sporadic iperf3 TCP TX failures on one of the controllers, with
throughput dropping from >900Mbit/s to ~1Mbit/s due to TX underflows and
the resulting retransmissions.

Commit 3a6c12a0c6c3 ("net: stmmac: bump tc when get underflow error from
DMA descriptor") made dwmac4 raise the DMA threshold of the queues that
report TX underflows, by increasing a global module parameter 'tc'.
However, this logic does not work correctly across multiple queues and
controllers, and can leave the TX DMA threshold stuck at 64 bytes.

This series fixes that logic to track and report the TX DMA threshold per
queue for each controller.

Ovidiu Panait (2):
  net: stmmac: Track the TX DMA threshold per queue
  net: stmmac: Report the TX DMA threshold per queue

 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 33 ++++++++++---------
 4 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.34.1

