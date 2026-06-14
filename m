Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25793290B9
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470413; cv=fail; b=QMmWl0h+s1OLixlLKLG56bsaSmkn+BaoNCSfU9FEfQPxCQLuQ5dQmOpOJ0pF6zEChWfOIIVkVowWHPUUcVtsPyWPT17+E0d1pcOXNNN8BLrrf0xMjCf8nQCuXN1EGK5vxYcZ6ql0qVAX0PWYRFraOYUC+nDJzV2t6p4wfrKIXBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470413; c=relaxed/simple;
	bh=mOS8GFA14QwEiGLMigULKDpYgpIrJuSKnWN1PVv8kKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0ALX3Tur1DC7Ef1KQj7bgGndNQ5sdgh8BHfv+VYxbsf00PxAh+CqDdZrKIwNXL76PmVIQ15zVGKoj36sZX5KN8YuZWrWXKmHGSNcKTv8ekCtVwxaD9nyet5U/WYyz1zxp77zzpbkU20B40c4x6dR2olszMOcG4gKX2zoX443Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=irxGWl3S; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="irxGWl3S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRVtwdFgnI5Qc61VqkIx+imY9mF3F7S2/nIbKQlC0QALZsJ54MeU68hd1+FX6VreAADRA1nYgamHleBgtBo7TtvT+90njBPaZsXUS/d87A+M6Z5yxcvXe/hQGICcnHBKp2ybuxmd2oZq/7LfPVMmA9TSVFjIEJX6l371RuN1K0/fGQ6wFZqSG9z+bPcRVxSXc5i4Uq+Yz7w03ILOyhnII+3Py5rH5QyFhbG/VDKHBDh/r5viOZbHpa4Hj9UwuIcHoVpDJM0wciqB5NWAc4uMmfTpaqVmlN/eDvdRkSMsmr+WhZa8qSQwi9e9GqfP0axk/TvwNvZ0v3oXwcsa+wgR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUCa9W0XNLsrhJ1+LD+jgaMiMg2sVf/E7pulBbsznHE=;
 b=yuRVIA1CH0cPXk74UyI+nLw+6WJA+Na99+dC3QUQEsioJn+2HZWPoxye1tKKYRMBuQWXMcWSUEQun6QfUbbbuHxNdcXP4PtzIT0K67sTLZdBqMwhp6OGwWzaDRKAm/RpNftEl8KPk738d9sFubDSVx66PxzOFgYe1psg2M1D2liHOpoupL9vYBslXIRc0oL6xrZcrkc0L+ffciORSZXLMweV0ZlRBLudeJUY7mfs/L9y83qVbMxyfqZF5kQhOSNuQ+9/xWyN2Ja3YrOKYQEjrFoAHT/n3w1lGkpGg7DNKH+0svaK6xuHIR/rbqfuvk1UmJIuhk7Zt0ux6plOd7y2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUCa9W0XNLsrhJ1+LD+jgaMiMg2sVf/E7pulBbsznHE=;
 b=irxGWl3S/K0iTMRG53/NuwnFFVS86+z44c5u+abkpxAdc4ikCf87dcl1I8AW2zuxI9iCnkOa+6C9Te0AU6h01K86ykcB4kqcH9PaOKn6/XcIwjYltmZ3IFpzpdlxbzooDLLzsABqfjZexFi9Y4oHipjBz0Kc1ndIkSwXCbtcbr4=
Received: from SJ0PR05CA0068.namprd05.prod.outlook.com (2603:10b6:a03:332::13)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Sun, 14 Jun
 2026 20:53:26 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::a8) by SJ0PR05CA0068.outlook.office365.com
 (2603:10b6:a03:332::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Sun,
 14 Jun 2026 20:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 20:53:25 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 15:53:24 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>, "Nikhil P . Rao"
	<nikhil.rao@amd.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 2/5] ionic: Update ionic_if.h with new extra port stats
Date: Sun, 14 Jun 2026 13:53:00 -0700
Message-ID: <20260614205303.48088-3-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260614205303.48088-1-eric.joyner@amd.com>
References: <20260614205303.48088-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9e8306-e81c-4380-55f2-08deca56faf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	T5ke50g+gbfilo7Jz8kDt4BKLOJW1KPAQscrsOwBGLYnU+9VgwabUymwo/u0vr/HmFUNeCMdfA9/mWMMneexDWBLbDSd2jjEgkDAeoV4X8hDmDjcsFiaLUS3lyueC+6z82hlVvoCznYsYe8YDXjPosH9vfV1W7TbIk+tmqDWHmvZgXIqL8TyU2IJKVD3N5iDpiCiLaGRA5jKdj7P/WVih7ilZAeAT8AyMRQRt7YsDIGNLWnLSfTatJIZu8BMQX3x2nNofcxWUG1P5x8bv/e7+XWDivfA0rLSGGDPGYeqOLjq+ZUsLbs4XpjDXHGp5Cqr3taJUHxc0s2rsmKa7zLfhvFV2NnAomux7MoG5tCXUE6XtKtJAgEbuyHZANqU8fgfh6Zl1vJulJtRzAq+8lD8FFDBeFhu11foIlhqpseqVh/ESjq3+WoYV+0sW266xyjsRCjOIT+KpOxf8lZTxRmctAk/Na2tXhxoCLZHujEQN0rem0eSh9Owmcg9Gv8ioAr6autNGtdDT3bISQUQi8AwVZBK/Z2/van6g0MqHrumoSklH01LkI+pLZnP+itCGOZltujSM67kpFw86cl+Rp+J+32itcncHN1J9FArnkN57nI8UPtDxbMz31YSvNs0BCJXuAtSZgmNKH+62r/vUqvy57irjvu4MEhHD5/QBa7CVpo0/lkZZ6veYWfxamy0eQRWjVL0aowsrsC8eYg/0nMG2EZa7a24soAwK8/q9jkRB6Q=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Uc+4FwCcRiVUKHJVWH4Ixewi+uj2bxL0mDsQEiqw3MEOJzokGWHPUovUqWcOp35GE5LaBNINHxzf+h6rQH3g7FCaLY9jmiUHL6yHF9yD7rFGk/YsiZbfm9atNQhJnvfmJJP30vEOm00i1v3qg2JhtSDrcUOArurccXsyb1k/2MGWWyim7BqM9IpqpySK8fCA3s+W9Zjxbpd0OGDnjzgpvu1suy5aKuHJAHtQkLyQ26ZQgTzdB4+qCLb1ctIJAg2QkJEkKIXxo77e8ivZBwfATdvBicGkCkZczR8TUvCKKZcR1bfQ8OQb1hwJkl63Plof3c78KCizQOokkkwzz7HL2USpzlpFgAIqhaxdP61QRmncVoMsW34yOnRmiACGlbYgFy0UyziAk+/y9bIDhMOBfPSAuzY0I4GRzUnxfhPgAZv40A98WkbwYH3dbKCpCKK9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 20:53:25.8282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9e8306-e81c-4380-55f2-08deca56faf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644

Add a new structure to report additional statistics from the firmware to
struct ionic_port_info. This new struct currently only contains FEC
related statistics, but any new port-level statistics collected by the
firmware would go into it.

The new structure is located in the same area as the unused
ionic_port_pb_stats structure, so this patch also removes that and its
supporting enumerations since they was never used in this driver.

Finally, to indicate firmware support for the new structure, introduce a
new device capability that the driver can use to see if the attached
device supports reporting these extra stats.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_if.h    | 64 ++++---------------
 1 file changed, 11 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 23d6e2b4791e..0a201422d0c5 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -273,10 +273,12 @@ union ionic_drv_identity {
  * enum ionic_dev_capability - Device capabilities
  * @IONIC_DEV_CAP_VF_CTRL:     Device supports VF ctrl operations
  * @IONIC_DEV_CAP_DISC_CMB:    Device supports CMB discovery operations
+ * @IONIC_DEV_CAP_EXTRA_STATS: Device supports extra stats schema
  */
 enum ionic_dev_capability {
 	IONIC_DEV_CAP_VF_CTRL        = BIT(0),
 	IONIC_DEV_CAP_DISC_CMB       = BIT(1),
+	IONIC_DEV_CAP_EXTRA_STATS    = BIT(4),
 };
 
 /**
@@ -2329,7 +2331,7 @@ struct ionic_qos_identify_comp {
 /* Capri max supported, should be renamed. */
 #define IONIC_QOS_CLASS_MAX		7
 #define IONIC_QOS_PCP_MAX		8
-#define IONIC_QOS_CLASS_NAME_SZ	32
+#define IONIC_QOS_CLASS_NAME_SZ		32
 #define IONIC_QOS_DSCP_MAX		64
 #define IONIC_QOS_ALL_PCP		0xFF
 #define IONIC_DSCP_BLOCK_SIZE		8
@@ -2855,54 +2857,12 @@ struct ionic_mgmt_port_stats {
 	__le64 frames_tx_pause;
 };
 
-enum ionic_pb_buffer_drop_stats {
-	IONIC_BUFFER_INTRINSIC_DROP = 0,
-	IONIC_BUFFER_DISCARDED,
-	IONIC_BUFFER_ADMITTED,
-	IONIC_BUFFER_OUT_OF_CELLS_DROP,
-	IONIC_BUFFER_OUT_OF_CELLS_DROP_2,
-	IONIC_BUFFER_OUT_OF_CREDIT_DROP,
-	IONIC_BUFFER_TRUNCATION_DROP,
-	IONIC_BUFFER_PORT_DISABLED_DROP,
-	IONIC_BUFFER_COPY_TO_CPU_TAIL_DROP,
-	IONIC_BUFFER_SPAN_TAIL_DROP,
-	IONIC_BUFFER_MIN_SIZE_VIOLATION_DROP,
-	IONIC_BUFFER_ENQUEUE_ERROR_DROP,
-	IONIC_BUFFER_INVALID_PORT_DROP,
-	IONIC_BUFFER_INVALID_OUTPUT_QUEUE_DROP,
-	IONIC_BUFFER_DROP_MAX,
-};
-
-enum ionic_oflow_drop_stats {
-	IONIC_OFLOW_OCCUPANCY_DROP,
-	IONIC_OFLOW_EMERGENCY_STOP_DROP,
-	IONIC_OFLOW_WRITE_BUFFER_ACK_FILL_UP_DROP,
-	IONIC_OFLOW_WRITE_BUFFER_ACK_FULL_DROP,
-	IONIC_OFLOW_WRITE_BUFFER_FULL_DROP,
-	IONIC_OFLOW_CONTROL_FIFO_FULL_DROP,
-	IONIC_OFLOW_DROP_MAX,
-};
-
-/* struct ionic_port_pb_stats - packet buffers system stats
- * uses ionic_pb_buffer_drop_stats for drop_counts[]
- */
-struct ionic_port_pb_stats {
-	__le64 sop_count_in;
-	__le64 eop_count_in;
-	__le64 sop_count_out;
-	__le64 eop_count_out;
-	__le64 drop_counts[IONIC_BUFFER_DROP_MAX];
-	__le64 input_queue_buffer_occupancy[IONIC_QOS_TC_MAX];
-	__le64 input_queue_port_monitor[IONIC_QOS_TC_MAX];
-	__le64 output_queue_port_monitor[IONIC_QOS_TC_MAX];
-	__le64 oflow_drop_counts[IONIC_OFLOW_DROP_MAX];
-	__le64 input_queue_good_pkts_in[IONIC_QOS_TC_MAX];
-	__le64 input_queue_good_pkts_out[IONIC_QOS_TC_MAX];
-	__le64 input_queue_err_pkts_in[IONIC_QOS_TC_MAX];
-	__le64 input_queue_fifo_depth[IONIC_QOS_TC_MAX];
-	__le64 input_queue_max_fifo_depth[IONIC_QOS_TC_MAX];
-	__le64 input_queue_peak_occupancy[IONIC_QOS_TC_MAX];
-	__le64 output_queue_buffer_occupancy[IONIC_QOS_TC_MAX];
+struct ionic_port_extra_stats {
+	__le64 rsfec_correctable_blocks;
+	__le64 rsfec_uncorrectable_blocks;
+	__le64 fec_corrected_bits_total;
+	__le64 rx_bits_phy;
+	__le64 fec_codeword_error_bin[16];
 };
 
 /**
@@ -2950,7 +2910,7 @@ union ionic_port_identity {
  * @sprom_page2:     Extended Transceiver sprom, page 2
  * @sprom_page17:    Extended Transceiver sprom, page 17
  * @rsvd:            reserved byte(s)
- * @pb_stats:        uplink pb drop stats
+ * @extra_stats:     Extra port statistics data
  */
 struct ionic_port_info {
 	union ionic_port_config config;
@@ -2968,9 +2928,7 @@ struct ionic_port_info {
 		};
 	};
 	u8     rsvd[376];
-
-	/* pb_stats must start at 2k offset */
-	struct ionic_port_pb_stats  pb_stats;
+	struct ionic_port_extra_stats extra_stats;
 };
 
 /*
-- 
2.17.1

