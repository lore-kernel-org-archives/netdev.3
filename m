Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212151B16E;
	Thu, 15 Oct 2026 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064508; cv=fail; b=krfI0wnCvcbSqFziGdrbn7MXYTNYBwlQvNzVhYe/D8t4OFIFM6dHZ2HauTfyFp/kveiy9/x9dFiIFugo7p5u+QlOkzlmGot3otNYgBYLQ1uvAa2AZjGh76j85RRIgXT/Y20CHhT4l/sN2UCPo3hpDQFv2iKHjHPCdNkGMyZy5QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064508; c=relaxed/simple;
	bh=ME3u6VMj9jtirZ5X0ZLjqCCjOSfovJe0I5AR+VvJld0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoQq4uWTxEyxwpBrue7pW11UEIvqrQUFcqNhzl35ggkH29udNrEp1kxNMdS6BDP0dvsrW0qsie6idTdxXtEl7HaDWfR1FLypw29OJL8fWxY5DfcLfAHUp8BPBYMgRdqhExmTlycA72f46lqaOVEb9cxpnbVZo4twwk114O29fHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WZG3j+U2; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WZG3j+U2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJXwiINss2D8u0NEnq1sWK0tQIwFFfe7PHZ1AzKpqhj/9JSmixa6Ws04/Fcc+Zxs6lEl+k0BXkCzd5i0i3OnLJrLP0BZAV5UMrG7W8jdwW5RxuoWPI9uY6DhNi4Xjabt1m999lg0Svdyc33mTPcI/RFpZdOzZzxEACR8Hr8acsbc5i0ERPThm3/ZGbbs0bE6DIQ/r+xN8falITlfGQ7j2k7Si3z7O6xzMFWGXoD9kPnAAE5xePHqePPRyL74VpUkOgk5alO+poidWUE04SWXzuNW9E2Kussy3xPAWzjwBmgbx1vZykBhDdLhV3nlXqMBncpZBOF4YgeCLxpweWovDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWKvB42VUb9Kgiuanju4vRCMifdk3B7mYs2/86lcq4A=;
 b=gTOk6BBM4iBezVX+xX3SCupninjlXbtoejpEts0VGduxIPWDQbTR7KmGkv7fE5Lahl1dAZcX/yb2dSmWBhnNeOg+WjVlKoeIee+3+tQsLd3MEvl7cOCYalIsRzgTPdq9Y+UmApalAMMz9YiCede6CtqcziynqrYBvrJoGMYgknxNVSRx9gHOp7soozziSJZDiDbPjgHSXkH1pnAihtiOidXXhcP6oPM6jXIKiIgh7/Di3JuwZMXSbWcOmYJ3L537EvFhTlJco6X71BLtwpGLqgKp6SSAUc8lSctQWXX2eWcBeZisVKHg6eJCWhcXCiQ9v38jr8K1L2aO5w/49NMviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWKvB42VUb9Kgiuanju4vRCMifdk3B7mYs2/86lcq4A=;
 b=WZG3j+U21n9c5Id5zPLdRFPM7i1omTlWlWvzKxaQ0PumJpgoxC27CsE88Cggqdq15WC6t1EPzjKwR/dO7nlrTGkbzj6Bfg0Bd39F5fb7p7R8gPqTxQPHT8ngvScyubvox3x1MsiyP8y+4KpyQjIVXbzXvZ6H4I7vnkycYiD1/6I=
Received: from SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::9)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:41:34 +0000
Received: from PH4PEPF0000B611.namprd21.prod.outlook.com
 (2603:10b6:a03:41b:cafe::3b) by SJ0P220CA0004.outlook.office365.com
 (2603:10b6:a03:41b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 11:41:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH4PEPF0000B611.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Thu, 15 Oct 2026 11:41:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 06:41:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 06:41:25 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Thu, 15 Oct 2026 06:41:24 -0500
From: Alex Austin <alex.austin@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, Alejandro Lucero
	<alucerop@amd.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alex Austin <alex.austin@amd.com>
Subject: [PATCH net v2 1/2] sfc: ptp: serialize host and MC synchronization transactions
Date: Thu, 15 Oct 2026 12:41:03 +0100
Message-ID: <20261015114104.2531624-2-alex.austin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015114104.2531624-1-alex.austin@amd.com>
References: <20261015114104.2531624-1-alex.austin@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B611:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf5a56f-b7aa-496a-7c01-08df2ab1435e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HUD+Y0Oj2Kg1PZpAsNSYiIbufrACB7P659fzEQ+E4zNsbxEoVBOOjNfgP32b2LSGPhcopf0tFCuvKR/EN7NQnanf0RmxB/wY1rd4IS5pH7q0wFcSVanDcGWS3vCXXzu+Bxa9uPCfymlx4plk1Bm+rFKeQ2QGQP0yTOJ6B6bwAq+IfXfFlr2z7nvynpGcHaUNc9J/IBdBQgYBzCjB1n1kHoEOjORUfKVWwyclfIUSWRR7YDyMT6bZQeiBNuLQVclNn/pSBEEIoP8PIVT64rJ0I+6Hg06fgFRxXfIud+YWfjI047qgTR27jGZBsxU5sM4VLAOPcGhaXfVw9aFc5064kGeXDxde5d7dTTSZ9IwE9Rhi6GaWcPOzecuxxTSEvxvDs1Q3a+iqH9CubO2+JsbRNErieaihg99CYLPf6/oAwCMI4Zw5u74SZFMh97bfS9XKWLWCfyiQjBsxBJb1LW1/y/q4+WEDp7/HdhJla9lsIMs/qwEdRWA5EEItSJSUzGAK1Wk8GIhjdLIotEhTHk78K82IXNNPj1stAY4ujt1JkZSP/dDRamvrEhE2CTiH2GGjmkf+WMW52i+7XH3z7isQsxdH3NQxgu+24WlGeuOA4LuZrL9F86gD39WbqrYmgpZM0+xc2414ad7fAV2d3rsxE9mQ9TNLE5B+Ee3Szm+AVgc80QHHqzj3XSvYIpY9Ambf5QixlrT7ZnGcgdmNd4M7ZA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mlc+J4nk+XZFKNjqhV+Pc3ifv7he7ZHD4TYN6gMrZuJxe04EhtkbmiaKG6Qv3XkKpD1TYe78uaErfAKgYBMhQxWbsP+4d3fkFat2vXN5sAg0yVEhltNgTOTI6g/yKVIfqlRlziIhJUmvETKL8Ioyp2BQoMxkJc89ev2+D8s8UqHdo4kPxVJgxEbTpATMi3yoQ39/WUeJOWP4+frxoPbxj5EnLbkS/1VoO8OXpMdqcqa/RHEdJl/JkM/kjEwBJ0bq/6EVnKRIq6buXLZf9UvLIUtkPiCq+bGjFpS4ZkhgsDAjnjXpQU/bCNSevpRQjeHezo06vTSBhhr5Ax1ezjRZMSXM02qTmiJRNHC7KbIZPZWQaHzGrbhp3Q+DCpguK31EUpm3ZoHUmJtujdqmtG7QZ/rQseER/llR8T3GSe/JDDcn/gUMWLWOSYaK1DSoqMQ0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:41:33.6626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf5a56f-b7aa-496a-7c01-08df2ab1435e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B611.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742

efx_ptp_synchronize() clears the MC-ready DMA flag before
efx_mcdi_rpc_start() acquires the MCDI interface, and processes results
into ptp->timeset[] after efx_mcdi_rpc_finish() has released it. The PPS
worker and the hwtstamp enable path can therefore clobber each other's
handshake flag and timesets.

Hold a PHC mutex across the whole transaction and over the clock
operations, so efx_phc_settime() reads and adjusts atomically and
current_adjfreq cannot be torn by the reset in efx_ptp_start(). Also
bail out when efx_mcdi_rpc_start() fails rather than finishing an RPC
that was never acquired.

Fixes: 7c236c43b838 ("sfc: Add support for IEEE-1588 PTP")
Signed-off-by: Alex Austin <alex.austin@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ptp.c | 83 +++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 6ca9a75..c2f8b94 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -36,6 +36,7 @@
 #include <linux/errno.h>
 #include <linux/ktime.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pps_kernel.h>
 #include <linux/ptp_clock_kernel.h>
 #include "net_driver.h"
@@ -272,6 +273,8 @@ struct efx_ptp_rxfilter {
  * frequency adjustment into a fixed point fractional nanosecond format.
  * @current_adjfreq: Current ppb adjustment.
  * @phc_clock: Pointer to registered phc device (if primary function)
+ * @phc_lock: Serializes PHC commands and synchronization, and protects
+ *	      @current_adjfreq
  * @phc_clock_info: Registration structure for phc device
  * @pps_work: pps work task for handling pps events
  * @pps_workwq: pps work queue
@@ -331,6 +334,7 @@ struct efx_ptp_data {
 	unsigned int adjfreq_ppb_shift;
 	s64 current_adjfreq;
 	struct ptp_clock *phc_clock;
+	struct mutex phc_lock;
 	struct ptp_clock_info phc_clock_info;
 	struct work_struct pps_work;
 	struct workqueue_struct *pps_workwq;
@@ -1008,7 +1012,14 @@ efx_ptp_process_times(struct efx_nic *efx, MCDI_DECLARE_STRUCT_PTR(synch_buf),
 	return 0;
 }
 
-/* Synchronize times between the host and the MC */
+/* Synchronize times between the host and the MC.
+ *
+ * The MC serializes PTP requests, so MC_CMD_PTP_OP_ADJUST cannot be applied
+ * while MC_CMD_PTP_OP_SYNCHRONIZE is collecting timesets. This holds across
+ * functions of a controller, which share the clock but adjust it only through
+ * the function that registered it, so a secondary function can capture here
+ * without serializing against the primary.
+ */
 static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
 {
 	struct efx_ptp_data *ptp = efx->ptp_data;
@@ -1027,11 +1038,14 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
 	MCDI_SET_QWORD(synch_buf, PTP_IN_SYNCHRONIZE_START_ADDR,
 		       ptp->start.dma_addr);
 
+	mutex_lock(&ptp->phc_lock);
+
 	/* Clear flag that signals MC ready */
 	WRITE_ONCE(*start, 0);
 	rc = efx_mcdi_rpc_start(efx, MC_CMD_PTP, synch_buf,
 				MC_CMD_PTP_IN_SYNCHRONIZE_LEN);
-	EFX_WARN_ON_ONCE_PARANOID(rc);
+	if (rc)
+		goto out;
 
 	/* Wait for start from MCDI (or timeout) */
 	timeout = jiffies + msecs_to_jiffies(MAX_SYNCHRONISE_WAIT_MS);
@@ -1062,11 +1076,13 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
 			++ptp->no_time_syncs;
 	}
 
+out:
 	/* Increment the bad syncs counter if the synchronize fails, whatever
 	 * the reason.
 	 */
 	if (rc != 0)
 		++ptp->bad_syncs;
+	mutex_unlock(&ptp->phc_lock);
 
 	return rc;
 }
@@ -1446,7 +1462,9 @@ static int efx_ptp_start(struct efx_nic *efx)
 		goto fail;
 
 	ptp->evt_frag_idx = 0;
+	mutex_lock(&ptp->phc_lock);
 	ptp->current_adjfreq = 0;
+	mutex_unlock(&ptp->phc_lock);
 
 	return 0;
 
@@ -1570,6 +1588,7 @@ int efx_ptp_probe(struct efx_nic *efx, struct efx_channel *channel)
 	if (!efx->ptp_data)
 		return -ENOMEM;
 
+	mutex_init(&ptp->phc_lock);
 	ptp->efx = efx;
 	ptp->channel = channel;
 
@@ -1641,6 +1660,7 @@ fail2:
 	efx_nic_free_buffer(efx, &ptp->start);
 
 fail1:
+	mutex_destroy(&ptp->phc_lock);
 	kfree(efx->ptp_data);
 	efx->ptp_data = NULL;
 
@@ -1695,6 +1715,7 @@ void efx_ptp_remove(struct efx_nic *efx)
 	destroy_workqueue(efx->ptp_data->workwq);
 
 	efx_nic_free_buffer(efx, &efx->ptp_data->start);
+	mutex_destroy(&efx->ptp_data->phc_lock);
 	kfree(efx->ptp_data);
 	efx->ptp_data = NULL;
 }
@@ -2106,23 +2127,23 @@ static int efx_phc_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	MCDI_SET_QWORD(inadj, PTP_IN_ADJUST_FREQ, adjustment_ns);
 	MCDI_SET_DWORD(inadj, PTP_IN_ADJUST_SECONDS, 0);
 	MCDI_SET_DWORD(inadj, PTP_IN_ADJUST_NANOSECONDS, 0);
+	mutex_lock(&ptp_data->phc_lock);
 	rc = efx_mcdi_rpc(efx, MC_CMD_PTP, inadj, sizeof(inadj),
 			  NULL, 0, NULL);
-	if (rc != 0)
-		return rc;
-
-	ptp_data->current_adjfreq = adjustment_ns;
-	return 0;
+	if (!rc)
+		ptp_data->current_adjfreq = adjustment_ns;
+	mutex_unlock(&ptp_data->phc_lock);
+	return rc;
 }
 
-static int efx_phc_adjtime(struct ptp_clock_info *ptp, s64 delta)
+static int _efx_phc_adjtime(struct efx_ptp_data *ptp_data, s64 delta)
+	__must_hold(&ptp_data->phc_lock)
 {
-	u32 nic_major, nic_minor;
-	struct efx_ptp_data *ptp_data = container_of(ptp,
-						     struct efx_ptp_data,
-						     phc_clock_info);
-	struct efx_nic *efx = ptp_data->efx;
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_PTP_IN_ADJUST_LEN);
+	struct efx_nic *efx = ptp_data->efx;
+	u32 nic_major, nic_minor;
+
+	lockdep_assert_held(&ptp_data->phc_lock);
 
 	efx->ptp_data->ns_to_nic_time(delta, &nic_major, &nic_minor);
 
@@ -2135,6 +2156,18 @@ static int efx_phc_adjtime(struct ptp_clock_info *ptp, s64 delta)
 			    NULL, 0, NULL);
 }
 
+static int efx_phc_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct efx_ptp_data *ptp_data = container_of(ptp, struct efx_ptp_data,
+						  phc_clock_info);
+	int rc;
+
+	mutex_lock(&ptp_data->phc_lock);
+	rc = _efx_phc_adjtime(ptp_data, delta);
+	mutex_unlock(&ptp_data->phc_lock);
+	return rc;
+}
+
 static int efx_phc_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
 	struct efx_ptp_data *ptp_data = container_of(ptp,
@@ -2166,23 +2199,21 @@ static int efx_phc_settime(struct ptp_clock_info *ptp,
 {
 	/* Get the current NIC time, efx_phc_gettime.
 	 * Subtract from the desired time to get the offset
-	 * call efx_phc_adjtime with the offset
+	 * call _efx_phc_adjtime with the offset
 	 */
+	struct efx_ptp_data *ptp_data = container_of(ptp, struct efx_ptp_data,
+						  phc_clock_info);
+	struct timespec64 time_now, delta;
 	int rc;
-	struct timespec64 time_now;
-	struct timespec64 delta;
 
+	mutex_lock(&ptp_data->phc_lock);
 	rc = efx_phc_gettime(ptp, &time_now);
-	if (rc != 0)
-		return rc;
-
-	delta = timespec64_sub(*e_ts, time_now);
-
-	rc = efx_phc_adjtime(ptp, timespec64_to_ns(&delta));
-	if (rc != 0)
-		return rc;
-
-	return 0;
+	if (!rc) {
+		delta = timespec64_sub(*e_ts, time_now);
+		rc = _efx_phc_adjtime(ptp_data, timespec64_to_ns(&delta));
+	}
+	mutex_unlock(&ptp_data->phc_lock);
+	return rc;
 }
 
 static int efx_phc_enable(struct ptp_clock_info *ptp,
-- 
2.34.1

