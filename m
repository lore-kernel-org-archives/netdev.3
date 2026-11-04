Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793827206;
	b=oBreD0NHCSpMPBUPG09DaU9QRo7R+bMUWwpvocYmV+NyxMBX0SrrYhzeurPE+/fx7hws
	 cM1eeDStoXrgwfButFCAGej52UerKZwpjEN68IUzEAI5NvVrILRFl6aV1y5FrMQQ0HlJn
	 1aE1UxLjewR5ZmDC6aTXzAIsboR968GMXCUyesWuW0fix6KhxeK7Em5qynvTn8jyNH8eS
	 UFiwf1UjBFUM3XW5FoJZj8YRklrkOF63invx4caJPc+O68pmsdYqYvlTiHQZG3c9n4CrL
	 TbtFfCQuOEourFXsuG8k0He2WgXZLsxp8RQcRz8iGeAjBePi/U7pSQQFeBIbY2Qso5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827206;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eOxMHXkQ7P1VZT9E3exgWWiZJEC6dXZ4SGBJ1mLWO5s=;
	b=hpLgx0zNcZvWZ2C3GIZcZsr85T0YqhJQ9/xGp4g7Kx0FTxYeOa9ErVmktKvlInY0DVii
	 Yc3F5rCVQvNvcQbl4m9iAE0mlreGCboIuFmi+Gwn/cu/UmNho2x+eWI3+NtEGCGt2/N4/
	 gwMpS/JSdRcRPzaxTP+/l7XDg37KaEp5QQmCDIU1iHUYfvhkW63cr87zYAMi21hkP3hvj
	 zfmiXjxtirWYeIqqCBZ++ORV+WrI03an+2Sd+zp2vvpldtbsqudQJ0vmv8lLqSzsFwnbc
	 93Cp4fq6oZu3tkkMCflzoap7eGDZ4YebVH5K8nWPi3naT3vcso6l93k6AvBeQ5yS1Ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OwuN7L9y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.5
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988F606B2C4
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B988F606B2C4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OwuN7L9y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APQD8NVbdsRTFT0anLgm048ilc2Oc7bNUJ0TuzBvdGnWBRST3A4HlyrpGM7ax5o8gCczmMAILObjZEy6Hgj+0if+gOET71QMfMRBiQ9AY8fa1qBWtlwji5f6ELV44MkBpRZMMxdJnU3Oy4vnM7KPBw6+eqEOsLC57MOut1yWac+G78ui147VjExgdOGpZmgxH/Lz8M4FBtNpAe8YuIfkcaM4mq3qXNkhIlLFnCauEdGbi9dVTDeHWH/L/qa5Gkxfi4NcYHCmNnyT/yyaUHrFPUr/3UljLKV7ILBb2k8oIDNrWLA5YSQgLVXo0hRC+IZPKTrsp/vtVU3V7MBA5SiaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOxMHXkQ7P1VZT9E3exgWWiZJEC6dXZ4SGBJ1mLWO5s=;
 b=xdPR8aBcUqGCh2OYRRgmq+6I/1odELYg47yxX3DWekJPIJnqT09Z8kqXhRZgtBfGXjQiuhLalPaRBmspxYHaokcE9u014vIUaYI/dC9sr0SGgg7e6HUZJtevKyF5iQ0c0oRKFReHP0wFB/UvmhXnZx8mdF53xx4umrReqTM1CSnG//lwszXDH8rJYOqrhxVSbHGTeaSRNV4fxdlR3wuCzHeyMelHY/isqkpNbgN+8IsYU+FKh9gMPRXaYdIR8MiEOBISA8QZPkDof5Q5wgdLZ9cteJa5svaPa3cd9El06m7zqT2YVFZBAkzJhjSPNTIHeQHJG9R5EVUXhifWAkVo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOxMHXkQ7P1VZT9E3exgWWiZJEC6dXZ4SGBJ1mLWO5s=;
 b=OwuN7L9yoH9WNSNT7b+PrZfGbJxe8j1jb3+dR5KcR+PQpsVu9AyMS4H40+kD4OKUHsFjn2DzF7aKMQuiTBsvdLONTuPrnS1U3uRIvn3UwLSslqY3DpT0eY6lgsEgxZ0uc7HNzSOt93RvTNuCnX8BPtY13w21vkoi16uWnD3rA4k=
Received: from CH0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:610:b0::32)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 21:20:02 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::16) by CH0PR03CA0027.outlook.office365.com
 (2603:10b6:610:b0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 21:20:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 21:20:01 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 15:20:00 -0600
From: Eric Joyner <eric.joyner@amd.com>
Date: Wed, 4 Nov 2026 13:19:42 -0800
Subject: [PATCH net-next v3 1/5] ionic: write the extra_stats invalid
 markers one counter at a time
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-ionic-get-fec-stats-v3-1-b261fd53d0a7@amd.com>
References: <20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7@amd.com>
In-Reply-To: <20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, "Nikhil P.
 Rao" <nikhil.rao@amd.com>, Eric Joyner <eric.joyner@amd.com>, Eric Dumazet
	<edumazet@kernel.org>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7a6f71-68ff-431b-2de5-08df3ab9635a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|22082099003|261102123227099003|18002099003|261022105027099003|56012099006|11063799006|261021121427099003|261026121527099003|261021135927099003|261009223027099003|261028144727099003|261026140227099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	XdJKtqbymzyzTi85DIkwr5VLA7T2Ul8CTDL2zJjSe2JKRVs8Uyw79598vcO3Tmc7xMAho7/3Jxjksiq31Hljr2VcUDijiRmew1pNjGBrRDBYiZO9gDgcrscroIWTPX8f//ye5/Y18isKjay2cDnshiG6uen6kiP0iDfrACyLahBWOeDm1MQAChERb193kLZT80tosee0DO8HHGvCjoLIJUJVd1e+q0lgK2aU6z0QWe1j1e9cACwHbN3vP8T126AQOSubq/WXne6u00WXoMYQJwCgAIFlxb/xfySC7e8WrxvzGb/9YkQvtxmttDANNHXz1vLA9po2r9ndHeqQmFbSiJwuh/u6/kamQSA8uPjab9c7t+6zJ1fNUcd8rj4J8C0rXZG6n8HGcE+0L+150j3eRVCHQ1EhMW2w4lQcSTOpm5+scnmSygvmuT8WZT4t3sZd3XAYJ3tuJJbJgtt1q3p11CHIcQUyqRB9hDDjtrewwYQ4lcDeQ9+E0xz0K947wQcPQuzhsutNw6PuDFo9nKLg9gA7NwiQXcIvOGMPvy26pJQaY6XV9Q8HlfhV87b46w3mtaMvcgeP2/nVNwiB12G2UBN759RRafMFBQ00svj8Ng3nrySCZH/eZrIJ2HAD+WU+K/Fnqn6HOWbrMSna3wNOiZIS+OQS3iAm+BIY8vHIXIWd9SWB1NPmRXQH1PjZNvz3Oh9I/Jj8TIj/Nec7no89mg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(22082099003)(261102123227099003)(18002099003)(261022105027099003)(56012099006)(11063799006)(261021121427099003)(261026121527099003)(261021135927099003)(261009223027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MTwunBbmOTGZ4cKDvhW8yM3E7StH2vH/rpLU0+Rwaxvp1X1+2wXI2vkGBJDCRH4r/xq/Ky1BE9t8E4oQhHFT2pYMWyG+ySbel/MMk60NH6q7oAB3UGCiYM1AAc7VFh6QKnYpupUtOFsAwcfF9zi2Cnsypuv2Su5hvVyv7uG8UYxZRTD0jAoX0CQ3EDV+3TpieUa7uJcwAjrghhDgXAZpAcHezv2rhUw3/VzX275izcmy834Ci6MTZjR9OjNJfn6XsRPd3DQSxpZ1ZgBqpHJGmU4enXK25dey7kpEXAqzLvKG27za90QNyTfu+smXg1xzs1o8cmrxZiyME1KEpdhksXOnmnZgufmiOT1xyw5r6oiW12sv2K5en0aFdq7QdKsvMbcMIAldhF2oUThZ7eL6AOalMuWh2qZju/IkxnyIA1YPeJ5TDpfl9u6HCEfEIWBt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:20:01.9831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7a6f71-68ff-431b-2de5-08df3ab9635a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

From: "Nikhil P. Rao" <nikhil.rao@amd.com>

ionic_port_init() marks every counter in the device-written extra_stats
block invalid before asking firmware to refresh it, so that a statistic
this driver knows about but the firmware does not is reported as absent
rather than as zero.  It does that with a memset() of the whole block.

The .get_fec_stats handler added later in this series reads those
counters one at a time and tests each against IONIC_STAT_INVALID to
decide whether to report it.  memset() gives no guarantee about the
width of its stores, so such a reader can observe a counter that is
neither its old value nor the marker.

The block is entirely __le64, each member naturally aligned, so walk it
as an array and write the markers one counter at a time instead.  A
counter read on its own is then either a complete value or the marker.

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_main.c  | 8 ++++++--
 drivers/net/ethernet/pensando/ionic/ionic_stats.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 38b47b959a11..8197df5532f5 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -12,6 +12,7 @@
 #include "ionic.h"
 #include "ionic_bus.h"
 #include "ionic_lif.h"
+#include "ionic_stats.h"
 #include "ionic_debugfs.h"
 
 MODULE_DESCRIPTION(IONIC_DRV_DESCRIPTION);
@@ -723,7 +724,9 @@ int ionic_port_init(struct ionic *ionic)
 	struct ionic_identity *ident = &ionic->ident;
 	struct ionic_dev *idev = &ionic->idev;
 	bool allocated = false;
+	__le64 *stat;
 	size_t sz;
+	size_t i;
 	int err;
 
 	if (!idev->port_info) {
@@ -741,8 +744,9 @@ int ionic_port_init(struct ionic *ionic)
 	/* If the driver knows about more "extra stats" than the firmware,
 	 * make sure these stats are marked as invalid.
 	 */
-	memset(&idev->port_info->extra_stats, 0xff,
-	       sizeof(idev->port_info->extra_stats));
+	stat = (__le64 *)&idev->port_info->extra_stats;
+	for (i = 0; i < sizeof(idev->port_info->extra_stats) / sizeof(*stat); i++)
+		WRITE_ONCE(stat[i], IONIC_STAT_INVALID);
 
 	WRITE_ONCE(idev->link_down_count_init, false);
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.h b/drivers/net/ethernet/pensando/ionic/ionic_stats.h
index 7ed935868e84..8a0edcc86fb8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.h
@@ -4,6 +4,8 @@
 #ifndef _IONIC_STATS_H_
 #define _IONIC_STATS_H_
 
+#include <linux/ethtool.h>
+
 #define IONIC_STAT_INVALID	(cpu_to_le64(~0ULL))
 
 #define IONIC_STAT_TO_OFFSET(type, stat_name) (offsetof(type, stat_name))

-- 
2.53.0

