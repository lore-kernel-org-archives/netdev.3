Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792574163;
	b=MfkCC6U+atkRG72L5KErbL+xgBbOWHPuNevHvthYs/5NxtSjubuuyP94rMDCLpE5lXBP
	 SoDbWmLD9fnJ3tH3NS2TJ68QzUo56kivhex0AKiim2/gSHPh1KWqqRxgyEhLgRKIzpf9H
	 pfTfxkcKMRsPkPdVeNZXOJ2FYGu7LdM4YskrebhhDH5t2Pl4kaPn4gZKB9O1PGW0fqs8+
	 1Gt6VZ2k7skOgpV2q5GZ7OAnyNfCT7MMkQEik9rpLMYrI1szMCGeOTxaRvvSyAExZqDmY
	 l9kMfS1Pimc9KbwmIYeenLdGZu4N6W3MW/PRrEINEw1XUo7MrrVU6UfnfTX7mlH6TzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574163;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=ugS5CN4Xt+YQeMzTs5ZJXAMTrXk/dyw3Y4INmBZA8Ws=;
	b=XiEwGqvqXcgCTsA/TdCloW1YAtHGcgEsYrHqAmYM/fNPMXQeaIUJbYGKSLILICoNbpMe
	 87l1XgMw3dQZ6hQh72VyUPZ7kOGbJoZQ79M69F3GuV4w7dV48GVOmp6Io+ZGms2GtrgDP
	 jL/JuTFydzEy5tbrW+g6JaY6VFWYjll97F3CmgJF1dc3u4/vSkDOZVFR+ITeS1xtG3WEn
	 LWMyuMXN8q7OSoTBCs+XC+7i+6N3ObQ7QfxRqADgMtj0Ssq9CvWPElccjAGd9cqeMwmDB
	 eSRMRwJIIhXTwD5YXt0T/3xBbguZzuuicAf+vFtz2h7jIxTR98gp7uwS9UM6GGRiVSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iAGKo6N+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.54
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545B6606A325;
	Wed, 21 Oct 2026 09:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 545B6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iAGKo6N+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktQBIuzjJAA+nsI3/hCd6z9N/lpBI3wA74B/jMKwHHASbhf8u59b0wTbXSZcm+VHFXh6mxCsULOpX52gNGuFDANxRXYrahSfYNdKi9s/9S+4bSbmPjyHnDbr//Rj8kKj9elwAqjzryxLtrJt1dj2ybln/75pvIo+9YEZm/sQFaNP4e3Gez3H+4DedneBDIG7TzSr48WHaWr1bhXkQBG5FMjOe/hCnHAWgYTmJiU6oskJzeHq8dMdtcwR4sNr1cwD94lL8WPG7Fkg7133aaXNND8huBodrVo2mXtTZV4d9y/buK7RpnV4oBR3c1DTrjO6UOB2pN1KDrenXnTIzNeFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugS5CN4Xt+YQeMzTs5ZJXAMTrXk/dyw3Y4INmBZA8Ws=;
 b=h0q2JE8Ud3F8svC5ag4CWuuCjwnK2VG9aCCHyEhRMQhjDSuk/B998QkQv/EzGhprQqUZB693QW/Lpw0nyp0gYNuVIw59pGQu4C37Fdv7OIo+LLgOoc+z5y3GFpImtjme2UAsili7gxZJidKOL3RLf5cB6cWOJsro1zJFa38daAFgJBs2Di/dKangdFZ3tZdHWLeA8HFAbWFyC6U8Zvumy+sSBXyxva670MDZOrpX9U6OEsMhDQ0JzwHmiCVT7HLFPJr/2yMEHeBkngADReljgcYtM3iWZPKEqw3pj+Jt/RuPzNXbZIOcQmBc3hL6xMZ3sN72jMjmcXz376fK/pQt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugS5CN4Xt+YQeMzTs5ZJXAMTrXk/dyw3Y4INmBZA8Ws=;
 b=iAGKo6N+/+nufg6Hh/rrX0M11E0Qx3+aBZOgp7yKsGBroigyEAlXymnNMURlDLo8XlvfyKCHDzxz8QD1gYSMZSFlXwSRv32SARbtP7Siv/33yTX212Jj7PF7vbXrU+O5INMA4r1LYfAfd9bNw+VgDclMECMzANqrs97qHul36PQ=
Received: from CH0P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::16)
 by IA4PR12MB590810.namprd12.prod.outlook.com (2603:10b6:207:10f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:15:59 +0000
Received: from DS8PEPF000000DD.namprd05.prod.outlook.com
 (2603:10b6:610:11c:cafe::9a) by CH0P221CA0012.outlook.office365.com
 (2603:10b6:610:11c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 09:15:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000DD.mail.protection.outlook.com (10.167.23.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 09:15:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 04:15:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 04:15:58 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 21 Oct 2026 04:15:57 -0500
From: Alex Austin <alex.austin@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>, Alex Austin
	<alex.austin@amd.com>, Alejandro Lucero <alucerop@amd.com>, "Pieter Jansen
 van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net v3 2/3] sfc: ptp: serialize host and MC synchronization transactions
Date: Wed, 21 Oct 2026 10:15:33 +0100
Message-ID: <20261021091534.3164258-3-alex.austin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021091534.3164258-1-alex.austin@amd.com>
References: <20261021091534.3164258-1-alex.austin@amd.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000DD:EE_|IA4PR12MB590810:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c338bfa-67a5-4b74-39e2-08df2f53eb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	x3P0nhWAY4Z0FogYqWz8/SA+ViPgaIbmrVKH3CsxF8vPo6HZOu0rxFiSCaXP9YL8uNYQtbN8+2hNv1abdzYXD2C2fNtzCVKuN/PKKEGDb68QHwDhZjHodwQMUsrqymHPvv+3iCEjDb5WoNNY+ShujIfgwFDBoBaYv+q5jFqBDPTIfikexfAEtM7qjx+X1hDK3kSymdruNX3XfHPy9twVTMSi9BM26S1MLVX3ew8pOv+c9Wz951g4XWaH8r4PwOYrBrIdwFofSbirJ3H8mt8uL5mfZlzvVBEFy74jYKvdK6fb9lKYklAhEEWtIczkR2GaRyx81T1gazxhh+ujgq7D7TtV9Vz1pMxcaTbdVRAS/DfcEF8kBQlsnKYTv/vdAviVcqdEaP6tCnhTeOm/7yIaJ4oRy/8Kin8DkkhAhVrvztRRIq0aRaJKZJntJXUA2Fg9c+OSdIv0VYHKEshl9tdq8NAKym6BFABPYy7rPFVecf133qmiGKersgf7xN1sTnPw0e5g0qymeR0vqiYe/rpesp3TvcVOpd3E3owfLDZXkN9pjnJiXlnAhGa8u4+ymJtgKGM5iMHIQp8iiXfKlGZ7P2hNOaeN9jG78GvY4iCuT2PKcZrwaSNLvp4VwSVv0AlVbL40q7jiDNyxQ0XgPXggr8m8mhrMT3S1mi5fj1rOWemrIoitW8hwjjNQ8VG9RHsoRm+HvvWy3hhU+7btebbmzA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BcMB0hL6d9baaQbuj8hsYhdl05cV97a26j4FUKAce1br5B1UhrZ0dWpxOzyq53k/6/Wbg/Q4DR1eQv3XsBznIZLLZ1jO1QkMIpXEhTfyr2wHHGAcDEwMkeyfHZGnv72pHhztTZUO37TU96MqJfwOq0J7u5Mz94Fsw2YP99jwPJwvms/ttqilnU8UgMkzxokxnyS4fMCYZ+Y8/yK4UMLkh0WBpNwAddWQjhnPkebW9i8Qwp6+fz0DsPDu6YtZ9+m5JcgrlOp6wNDfDSbPtAJncrPOgZHOuHzEYJSWibaX+qwOcUDtlsWP0C1GqYiFQIJQKMKk0o1mc3kz8I2gCYScqkszSMBOQS5MhTdbg+jHHmK5eEoX7RQAVAXoyn8V+TpN+jtmonDS01FEMc5NIdUXexbrhBS5hhWDR3rZP3UZtWY4TWM2aI9ORGuUXBVqTu8R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:15:59.0569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c338bfa-67a5-4b74-39e2-08df2f53eb99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000DD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB590810

efx_ptp_synchronize() clears the MC-ready DMA flag before
efx_mcdi_rpc_start() acquires the MCDI interface, and processes results
into ptp->timeset[] after efx_mcdi_rpc_finish() has released it. The PPS
worker and the hwtstamp enable path can therefore clobber each other's
handshake flag and timesets.

Hold a PHC mutex across the whole transaction and over the clock
operations, so efx_phc_settime() reads and adjusts atomically and
current_adjfreq is consistently read and written under one lock. Also
bail out when efx_mcdi_rpc_start() fails rather than finishing an RPC
that was never acquired.

Fixes: 7c236c43b838 ("sfc: Add support for IEEE-1588 PTP")
Signed-off-by: Alex Austin <alex.austin@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ptp.c | 81 +++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 2247e5e..eedab53 100644
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
@@ -1569,6 +1585,7 @@ int efx_ptp_probe(struct efx_nic *efx, struct efx_channel *channel)
 	if (!efx->ptp_data)
 		return -ENOMEM;
 
+	mutex_init(&ptp->phc_lock);
 	ptp->efx = efx;
 	ptp->channel = channel;
 
@@ -1640,6 +1657,7 @@ fail2:
 	efx_nic_free_buffer(efx, &ptp->start);
 
 fail1:
+	mutex_destroy(&ptp->phc_lock);
 	kfree(efx->ptp_data);
 	efx->ptp_data = NULL;
 
@@ -1694,6 +1712,7 @@ void efx_ptp_remove(struct efx_nic *efx)
 	destroy_workqueue(efx->ptp_data->workwq);
 
 	efx_nic_free_buffer(efx, &efx->ptp_data->start);
+	mutex_destroy(&efx->ptp_data->phc_lock);
 	kfree(efx->ptp_data);
 	efx->ptp_data = NULL;
 }
@@ -2105,23 +2124,23 @@ static int efx_phc_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
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
 
@@ -2134,6 +2153,18 @@ static int efx_phc_adjtime(struct ptp_clock_info *ptp, s64 delta)
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
@@ -2165,23 +2196,21 @@ static int efx_phc_settime(struct ptp_clock_info *ptp,
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

