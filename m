Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F24078E9;
	Sun, 11 Oct 2026 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791708002; cv=fail; b=EsdNLSe95954Z1R3u/NJKRAuuyY4DHeDbc/jrFyZsXVxrKoh6er9EP82SIfADVK1zAL6vuNyJD3qNQdqoOLZpAYeT3NjQ8Oy0hRMOYJmFv43RkJkKdSWNZupachOSiRKWjNzjsqB0NOnRrUAe41b1ORRvgZz+b1aqVFUbgWGHz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791708002; c=relaxed/simple;
	bh=pXb/udyY72tlkXkHG5bT/Pzlwro3XpfXpDb7mUUcUT4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZlGl5trA+kEKd0NhD95yi4+SrGGX9bP0A6rHFUOTcvylNT2o3+6WjEojyuaLS3k2ZwdpqPU28S2UoROBOSjibnS/g7RZ8TJUEeax1bCgGmeSam6aB2/VX5O9k1JKMdNpjg+uOFkZL3JF+fBdDzLSqZcjipQ0ALRPlTmusIm0q08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FN7njEH7; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FN7njEH7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWT98xijiSAPQgIMQCUg4HJ+mCuULHZMDf/c5x4oGw3cRe7aEZxEO4T4qaYsqA7+xmi7tzhD5wSgvfeahy2jiIFRcPuCoXPEHGxcQjI3h08p15ZvAlOVJY7PtvvJRWV7v/Tw/LZ3TOcf8SPeAOCSXIgLed5gCeQpcp/vjiK8inHWvBQXOxYc/QC7BUN5AJ8xExOrJigiTObaKYkffhYraGfh/6ZyZCsbj1gMsBFy1PAKH8WuFPWZ6ONfY4aql4mthzsshwI61OS9ZXnN6Lj3RpC0UOiMKvLUQNw8mIx8M/LGNXynVpXEnXIYi3WmaiiWpx7Ky/NxpCMUQyP42PGfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+M3A6U7TU4M4aiMrOjf/Awi+1GBbK4DCBsFhEb/M/s=;
 b=C002OfBi9Isyem2T4MKaVMWpeasaQzX6j59GWptyXoFEBMil8F3KbXeVS0od+c0OUksjNl/HsUEhsaVBuWZh6ddRSLgzgju9qP10nie9iRtYahjYvQIPtyM+wBcmzO6r57XohEcF1RxoPZJkfyKJNaQuh8vSFS0lD9kboacg8zmulL8GxXa7ZNYzrdTQg4xGntgOfFh5n2Qx1a6SM0scD1g73VkW9VzTzr/qA+4UVXm9zu5zhP9TIfgOW+OwefgF9CMuMpCEgK4/dx8MVJR5r0Y62zLZPxSsZqVEaTRd19pMvi/CbsKTbNk7IzTw2x90JofwgjWLnaU1DTYdZGzGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+M3A6U7TU4M4aiMrOjf/Awi+1GBbK4DCBsFhEb/M/s=;
 b=FN7njEH7XTCjWMXDF5ZDKD6m+3s9mdjqdEsiLR3vnk0NmrcLXRcar7E1iEbYlkRcXrOh3YPz+qp7TvyMfKAmidl/+0fH9FnPHWkiGhJTMW1f6PFqFTwFXF946anPj/kxuMZ4st9FV1RuR6aMGECgoe/5MBZVBu79FI2lGmAmXdxAGmoq5ZkhJZHHHP5AU/IZJdI1OTeMO4u9S/ysGYG88hU5XKgEnc2cLEgloZzOJH0Svlc1ibCAo5gHTeadJdJGtX2vPzdBnl6XEtv1YSCEof8cmAGwP9dy75BW5hMbSPZxV7BbGqO0MPfjea48gmBYM0xoJIlIbyiTx3pLmhOuQw==
Received: from BN0PR04CA0169.namprd04.prod.outlook.com (2603:10b6:408:eb::24)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sun, 11 Oct
 2026 08:39:55 +0000
Received: from BN7PEPF000000AA.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::4f) by BN0PR04CA0169.outlook.office365.com
 (2603:10b6:408:eb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sun, 11
 Oct 2026 08:39:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN7PEPF000000AA.mail.protection.outlook.com (10.167.245.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sun, 11 Oct 2026 08:39:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 11 Oct
 2026 01:39:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 11 Oct
 2026 01:39:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Sun, 11
 Oct 2026 01:39:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Alexei Lazar <alazar@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Kees Cook <kees@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, <oss-drivers@corigine.com>, Simon Horman
	<horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2] net/dcb: Validate bandwidth for non-ETS traffic classes
Date: Sun, 11 Oct 2026 11:39:29 +0300
Message-ID: <20261011083929.739261-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AA:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 772b5598-cbd4-49fb-c49e-08df277339a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|7416014|376014|36860700016|6133799003|18002099003|261009223027099003|13003099007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	V8phrbmX+Jh545IEkIF/lxqJlcNlIQfSnGiQm0/Z2BeQ6jDKcRMr04obzj0Jgzlfw2Red0jJyrdx+Zd2D7U1ge3c5miuB9Phzd4r4o6AJV8rjiQ/BoQ3NvxQUOSRPkM5U8M3eemQKahiIzbyzuo/XktE7gA2CatGvRVwcSYoHAlO6bpWRcS4Fuo12EgDEawOZJjCUcHoxPknh3fl2+KnRzpWvHV0fpCFn8XU7+ipxxGzirWRff+Yt7IQyDQcU7cEqQOUGpSmvWa6zFU4cbheaL1j+8bPv1zyaliz5G59oCiPaReX88AfaelvKnAH2R8QGDZ+bVhgdmVv3+2EaZrADUYXSnHUhbZU2+VSuC8QXj+AaIRPVDKjot4IsNc5mO8IdnPJkrmwx55ojbs9kf3gyCdCzIVUKYYclrtuDfGDANuvN9nbaBRl/Gx0qjIhtH6MZQj1zKRxePL2aStel9HuihluiYjiBfrk7DppEn5qKwTaxjh/8jST4sCEsNzGsmcc5lceERzp3RJiYgYqLCByK0mOKb9h50tGQqwWE3aF0p2mtu0J+nR04+KxiKJIlLbAG+fnxshB4VX9GXxoHmMU25k53xljd2PwsdG+7YLq7n4S1pE338ulKrI6Y+DdQRnRxL68nmaKvudjFnqJBL1UYVOfbkUzYeLzU9j8k4THudNy3LpJjvgNfJlA3j1Sq01VAKt42G3kiytetKaIQSdOXg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(7416014)(376014)(36860700016)(6133799003)(18002099003)(261009223027099003)(13003099007)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5/BYGQTVYLrgPoBchk4K6p42NpqnHikun41mt8qsPha7D47BeJNv0xjpc/s+ko2Zght3Ume7smyQPF5ZY4jkvk7U1FD4tttdYAdBY7IqcFEUkFqrXQwiUVzWCm4Get1pUpHtjSlGAZ3BAs4R85r78g86dNfqSJKhPfxBMhNyENECS3WYGQWvnpZuEjcEPiRvExV85Kga77CcyiA/BWxJnzjW1N209K1lNCq6SDdGKkHZjYNeWhF2BZ30OzWGIxKK9SMAEOC5s2qa9MQhn239RBeh9JBgfSk6TDV+4dn0F2M20H4dajQgKFgKzBIwu7ldutlmZgGD9f2voH7ZqHDRCUPMVtywfUZgQaoKG+D6wt8nM7jZJJsoqlaH4f2+GBvPl4EbentJpxMLCIuTYubexKNwcYzq0Y+hjJW1/z8OL8ZVlGr2bDmwisnHACDRqXBL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 08:39:54.9555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772b5598-cbd4-49fb-c49e-08df277339a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000AA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431

From: Alexei Lazar <alazar@nvidia.com>

The IEEE 802.1Qaz standard defines that bandwidth allocation percentages
only apply to ETS traffic classes. Reject ETS configurations that
specify non-zero bandwidth for non-ETS traffic classes.

Placing this check in dcbnl_ieee_set() enforces the constraint uniformly
for all drivers rather than relying on each driver to validate it
independently.

Drop the equivalent check from NFP's dcb_ets_check(). Keep ETS
bandwidth-sum validation unchanged.

Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/netronome/nfp/nic/dcb.c | 3 ---
 net/dcb/dcbnl.c                              | 9 +++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

V2:
- Generalized per Jakub's suggestion.

V1:
https://lore.kernel.org/all/20260622112925.624795-3-tariqt@nvidia.com/

diff --git a/drivers/net/ethernet/netronome/nfp/nic/dcb.c b/drivers/net/ethernet/netronome/nfp/nic/dcb.c
index bb498ac6bd7d..91fbfa3708fc 100644
--- a/drivers/net/ethernet/netronome/nfp/nic/dcb.c
+++ b/drivers/net/ethernet/netronome/nfp/nic/dcb.c
@@ -218,9 +218,6 @@ static int dcb_ets_check(struct net_device *dev, struct ieee_ets *ets)
 		if (ets->tc_tsa[i] == IEEE_8021QAZ_TSA_ETS) {
 			ets_exists = true;
 			sum += ets->tc_tx_bw[i];
-		} else if (ets->tc_tx_bw[i]) {
-			nfp_warn(app->cpp, "ETS BW for strict/vendor TC must be 0.");
-			return -EINVAL;
 		}
 	}
 
diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index 35164bfa563d..ab71f5312876 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -1578,6 +1578,15 @@ static int dcbnl_ieee_set(struct net_device *netdev, struct nlmsghdr *nlh,
 
 	if (ieee[DCB_ATTR_IEEE_ETS] && ops->ieee_setets) {
 		struct ieee_ets *ets = nla_data(ieee[DCB_ATTR_IEEE_ETS]);
+
+		/* IEEE 802.1Qaz: BW allocation applies only to ETS TCs */
+		for (int i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+			if (ets->tc_tsa[i] != IEEE_8021QAZ_TSA_ETS &&
+			    ets->tc_tx_bw[i]) {
+				err = -EINVAL;
+				goto err;
+			}
+		}
 		err = ops->ieee_setets(netdev, ets);
 		if (err)
 			goto err;

base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
-- 
2.44.0

