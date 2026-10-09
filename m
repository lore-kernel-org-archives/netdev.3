Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33276511E9A;
	Fri,  9 Oct 2026 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570790; cv=fail; b=pfSFTg2iyUGUJF9RPw1hSdWfqdinKSrisjYbud6bs945fLSRShFq9+AcRhMMdp2Bs+xIZGEe5Q3qGQfNGXTwq1uHoHHo/zQ2LlEajLZKXquUfe9DsXQhsQLNqT0/uqtASd7NLBPSNm9VaN3QNDOUAhMjIzljoBfFVTvU3KGg0kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570790; c=relaxed/simple;
	bh=NBnbVzN5R0xWbh9tdDp+UYu2OtlQlK534+W7NgX3aAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpKewD0J+wfhGDCB6zh8e7rbnWDovf7WtJRBiNbDBl2MpwpXX+lcjjUGH56e3fvw1tOCK3DihFfGa0j/HaUjtt8mkuq6pyCKiFuLmTf8ZfjzR8thPG3xhQEqEBYDRbw8QmziiQquRTo9CGT7xlK3jnCaDHW4pRX5PaePooFXgzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iXhSgpE1; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iXhSgpE1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDdhAT+fkkS66z5gMQbqYEZuAW7mazLzy/p1QmUmWsN7yMz2xCOLZhqvhZQ9tqjZz6JKpyFHrmzFFKWKG1R1lNhOab7U2YfaNL/mX/8Vt/rmhAEEbs3lpqqm+J5iHGLQn2D+Tz5SYVz8eG5JmKXoXamXuQjgEjT6YQFwhvPhc0E+8g8s51KBgaIevtbPsdZX4yUSN6cfIOsSmbNvWu8vSXunkerT10RUOrqkol+SSjAO/En/qVL2zV0LKtd3NsKT7oWWrmgLFOM8vr9ttuwgfQHVAfUg2rAHsyVQmD4WXDeaW/IOSMFX53a8i9QQe7M21XEtxso/ylrOwS3aPQtTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afIkeO0p63UlUZJlqZUoKc9E3H370phODrMazVeg0E0=;
 b=PjaCnY6PlP2fFbXd+4f7SZob+qW4ZnbnwjQUkPrtLHPCKEiL6pYIm1v8HfZLePd4/OHHG1xLuLeBqONYPAFbVo02eH8w4gk8Dm03PhMngAd2KXWo8u6hGV0moFmdjin79RQmRi498SZYx4GnhABSl5kXDDyPmhn49Yq4DacD6BalsU/DrlezkrGqRZsitC/+NqW/baGXRTdqvg1isH6/tCo/GkwOqf5TSxIuIB62msgHfGAKuvCYCJ67hl0FE2UCTtKsjDkM3waTmhd6I2yz832+jtE7WP7Fu0Xui3ImKSEcn2nWSQx6Y0E4ClzQXM2k5eUQ08+OgUH9T4TSVWCf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afIkeO0p63UlUZJlqZUoKc9E3H370phODrMazVeg0E0=;
 b=iXhSgpE1rKPiwp6YeBQRQQS/8AriZLrfvRkjJiarO8siuJA0hcrvJrxhkorc4ShNNmDiTumlwGsH/nd2hvdclPoznRzcTyC2LQDT+1Z//gTe7zxqIVoSNduR+jn5QNMPU7bZra69aDpwmMgqe6A2TnK/hZzxNVPp+DBiBryrI1A=
Received: from BN9PR03CA0889.namprd03.prod.outlook.com (2603:10b6:408:13c::24)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:32:57 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::5a) by BN9PR03CA0889.outlook.office365.com
 (2603:10b6:408:13c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 18:32:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 18:32:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 13:32:50 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 13:32:48 -0500
From: Alex Austin <alex.austin@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <bhutchings@solarflare.com>,
	<davem@davemloft.net>, <ecree.xilinx@gmail.com>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<smhodgson@solarflare.com>, <alucero@amd.com>,
	<pieter.jansen-van-vuuren@amd.com>, Alex Austin <alex.austin@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH net 1/2] sfc: ptp: serialize host and MC synchronization transactions
Date: Fri, 9 Oct 2026 19:32:39 +0100
Message-ID: <20261009183240.1898762-2-alex.austin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009183240.1898762-1-alex.austin@amd.com>
References: <20261009183240.1898762-1-alex.austin@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a4bd55-17a7-446b-962a-08df2633bd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|11063799006|56012099006|22082099003|18002099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4ANjkmF0in6+G6GtVWrGV/2MqpuPCKm4/NfM96oJV/Bzlh0Rd6TsfPYR7cnGQFJx/BCSsByP31a2Wo6wlEq5nC18+su9iS27RU2FpsMJltJnTuOsdCdkCZYvZpeoOdbSP7t8Ru0O/Nr2Mf1+c4qSSMq5azfdyfvHy/jnyYVOO0s1yZiCe1APL98AglIsLtB8HkLIoFYBxE+E0cvakHguoRMbVKYv0zwdwD1TodV02Phd6fKhJx7pePqyFnDKslClR8eGsG6f3aXT2+iFp8UVZumg4244SvaQyV5fQUeQUXfZ2aJWgv5TDFsA4yPZpVXmAn5SGOC+8Tin5ITU2mLpWtTMbba78Oe2AE206NBn0KEGWxXuuCL+DmBwIR3LwQYuFGdwNkX6uBaQTTwAxduDQGIFQQfQL11LhcfBHApB9QwB+prRxYsSz3DS87g8ccGFQfREM3Svg23MJApe50xHkYztaEeIjaJ3mdj+ChbbqzO7iSZHjjUIMoHi6FqmCdEXrr6lz8Fsw6/iSHKn8lwRmskPuZGhuLoR9IIk9A1LD72UuU5ReRSe5CG0b8fjBdY9qvVkAEHUVvHGAyripAOb1Hteov4SGJUBBFZyxxYtU1euaWq15dfCCxncQ5Jf3/b2q/L8JnJvlXrhgvHipBgvvcUj3n7gygGmWjISY6c+R1iR8ftaE56YG0wUUq6wO4pD01zy0qL5zCXwGbLzjdSxFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q8BI5zZ2L+HDLUM4R7XKzCne1ZTGaeNOTIXDSgPG5tPPqrMjLNSjVAeVGSGVcQRV4eXqYH7iC4zWI/9VBR9NOVsPohCkyYzptW1UyybZdn+vzJ36mCWrlWthPq3Mullz9GcdogenPhblbuCcfRLDyuEW2fm2z/rhxCfVK2CDXc+1WHUlE2o+G/eVT72wSMY3LFzzAUdHHJfUvoTjqL+XeVTiL3/ghsBrPuZIMAC0sDyqwbGdZftvljNeA+zKRlmMj6aqQjl190+z6IU51k2oUGVgvMVDlAkNg/xUu7XOt4ytT4rxyq/wGTX5It5PbPyDZmZmsO5/YaX2CoW3qpr34VVB8OxpH0558GOYz0GoHCc4w4UV51n5h6fOnHsS0ycRnpElqD+URH0Vn/goa+pTrOdSdg13VlyYGceDRr6ut8hfyxd4Jtbo56fnh7LaCihO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 18:32:57.4440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a4bd55-17a7-446b-962a-08df2633bd88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315

Protect the DMA handshake and result processing against concurrent
synchronization callers. Serialize clock adjustments with the same mutex
so they cannot change the PHC during a capture.

Fixes: 7c236c43b838 ("sfc: Add support for IEEE-1588 PTP")
Signed-off-by: Alex Austin <alex.austin@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/ptp.c | 102 +++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 6ca9a75..ac9951f 100644
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
@@ -272,6 +273,7 @@ struct efx_ptp_rxfilter {
  * frequency adjustment into a fixed point fractional nanosecond format.
  * @current_adjfreq: Current ppb adjustment.
  * @phc_clock: Pointer to registered phc device (if primary function)
+ * @phc_lock: Serializes PHC commands and synchronization
  * @phc_clock_info: Registration structure for phc device
  * @pps_work: pps work task for handling pps events
  * @pps_workwq: pps work queue
@@ -331,6 +333,7 @@ struct efx_ptp_data {
 	unsigned int adjfreq_ppb_shift;
 	s64 current_adjfreq;
 	struct ptp_clock *phc_clock;
+	struct mutex phc_lock;
 	struct ptp_clock_info phc_clock_info;
 	struct work_struct pps_work;
 	struct workqueue_struct *pps_workwq;
@@ -1027,11 +1030,14 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
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
@@ -1062,11 +1068,13 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
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
@@ -1570,6 +1578,7 @@ int efx_ptp_probe(struct efx_nic *efx, struct efx_channel *channel)
 	if (!efx->ptp_data)
 		return -ENOMEM;
 
+	mutex_init(&ptp->phc_lock);
 	ptp->efx = efx;
 	ptp->channel = channel;
 
@@ -1641,6 +1650,7 @@ fail2:
 	efx_nic_free_buffer(efx, &ptp->start);
 
 fail1:
+	mutex_destroy(&ptp->phc_lock);
 	kfree(efx->ptp_data);
 	efx->ptp_data = NULL;
 
@@ -1695,6 +1705,7 @@ void efx_ptp_remove(struct efx_nic *efx)
 	destroy_workqueue(efx->ptp_data->workwq);
 
 	efx_nic_free_buffer(efx, &efx->ptp_data->start);
+	mutex_destroy(&efx->ptp_data->phc_lock);
 	kfree(efx->ptp_data);
 	efx->ptp_data = NULL;
 }
@@ -2106,23 +2117,23 @@ static int efx_phc_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
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
 
@@ -2135,16 +2146,29 @@ static int efx_phc_adjtime(struct ptp_clock_info *ptp, s64 delta)
 			    NULL, 0, NULL);
 }
 
-static int efx_phc_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
+static int efx_phc_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
-	struct efx_ptp_data *ptp_data = container_of(ptp,
-						     struct efx_ptp_data,
-						     phc_clock_info);
-	struct efx_nic *efx = ptp_data->efx;
-	MCDI_DECLARE_BUF(inbuf, MC_CMD_PTP_IN_READ_NIC_TIME_LEN);
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_PTP_OUT_READ_NIC_TIME_LEN);
+	struct efx_ptp_data *ptp_data = container_of(ptp, struct efx_ptp_data,
+						  phc_clock_info);
 	int rc;
+
+	mutex_lock(&ptp_data->phc_lock);
+	rc = _efx_phc_adjtime(ptp_data, delta);
+	mutex_unlock(&ptp_data->phc_lock);
+	return rc;
+}
+
+static int _efx_phc_gettime(struct efx_ptp_data *ptp_data,
+			    struct timespec64 *ts)
+	__must_hold(&ptp_data->phc_lock)
+{
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_PTP_OUT_READ_NIC_TIME_LEN);
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_PTP_IN_READ_NIC_TIME_LEN);
+	struct efx_nic *efx = ptp_data->efx;
 	ktime_t kt;
+	int rc;
+
+	lockdep_assert_held(&ptp_data->phc_lock);
 
 	MCDI_SET_DWORD(inbuf, PTP_IN_OP, MC_CMD_PTP_OP_READ_NIC_TIME);
 	MCDI_SET_DWORD(inbuf, PTP_IN_PERIPH_ID, 0);
@@ -2161,28 +2185,34 @@ static int efx_phc_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	return 0;
 }
 
+static int efx_phc_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
+{
+	struct efx_ptp_data *ptp_data = container_of(ptp, struct efx_ptp_data,
+						  phc_clock_info);
+	int rc;
+
+	mutex_lock(&ptp_data->phc_lock);
+	rc = _efx_phc_gettime(ptp_data, ts);
+	mutex_unlock(&ptp_data->phc_lock);
+	return rc;
+}
+
 static int efx_phc_settime(struct ptp_clock_info *ptp,
 			   const struct timespec64 *e_ts)
 {
-	/* Get the current NIC time, efx_phc_gettime.
-	 * Subtract from the desired time to get the offset
-	 * call efx_phc_adjtime with the offset
-	 */
+	struct efx_ptp_data *ptp_data = container_of(ptp, struct efx_ptp_data,
+						  phc_clock_info);
+	struct timespec64 time_now, delta;
 	int rc;
-	struct timespec64 time_now;
-	struct timespec64 delta;
 
-	rc = efx_phc_gettime(ptp, &time_now);
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
+	mutex_lock(&ptp_data->phc_lock);
+	rc = _efx_phc_gettime(ptp_data, &time_now);
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

