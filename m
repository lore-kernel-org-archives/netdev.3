Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E851CF75;
	Thu, 15 Oct 2026 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064504; cv=fail; b=pqX1KSLvh3r1S/AYJkNDAKmGA7O/bBiPZT399s9K28veFfVKs3qWd8n45HPibk1zmyaNfcFY+hEZMx1lUdDbasHoSWU2oYPUWYo9+YfWoaAcczkT0WSIeOGM4tYp7zJNmFCRbOMleJof0paCCfKWXU8O4Gp6pukwi9jYrMFL/T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064504; c=relaxed/simple;
	bh=u/3nJKXcom8nZhwuxyXtMHGWvHFGwXp41k6yccIXbNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgevjX55hT3wm+lQYzFOspmzN0tbWdB5jCXRbDYId+ZPRgKYUUtQo42lQYj0E/bh9MVW8fxNkpHFPP9BRF4CRXWSI4CzEAk9sP8wBzLeaOY1Ypzrn9T93MThMPLvcBKuIJg1vtKPrxhkboPJ2WRT+yTC+hojVNU3Mrbkvtwirac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B+qZlbpI; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B+qZlbpI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTLRrkP/yvd6dRxWZ2KId3s5VpmL0siF/YDbA6auahlN9txeJJQjm9EjS8O18NNfyO1pv+lXD8iazKm+uvgPcGdV1+gXvZIeeNwGIk6wv01W1Tl2bnjpbXXBQ618+S13tWqOaxQhqZrjXaG+70S9Br/W7PgUQa/c+jSTXiD7EsxKsM1eCr/R/SmHQ1KZURFoIx6dZ3HZfRvzrP0mGzcMf95g1o0Y9nkKQ/Ptn1dNgsA9QSY3hhNodfQCg0kv1yHN3XhnMrhg2/+bZmRFRSCM0Jb26EvDrqX2Q7jn/pKMpZX3Mguhqbe2/QvDKnDhIg2T06a3p1N+wT+cEYJGYsQCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfAMMYpvtw+TpMFvoCDy499NU3N2QF9HhepO7hlgw/c=;
 b=kdcxxX2vaPg/Drav+3XJ5WlCcxZxq5kRUuPmOgKAdOfUH9iPMVprwRj+04uAXk00zz54BnPHagdq8+a9NXe6POmy5tLe8DvYKw56rbQrj1+FSSsVzBE3oREfG9D+CFjtwHHcEjDXNNW2Fpfk+pNVTfk5C/niYmoR7tm+mb91Kq5JoRmS4K3sWwNRQyzgo+66DdC/h0svoNpGLhq2P36oCtoy4HA4Qc9aXLwNBb22cczoA7NXPYB1SgSbQlXyF459XAGtiNw9QrpcW78W8XPTeUY8l2bc2+AjcMZowGKgaGXtkKyFPdJYHi2REek7fLmW8yYcm7OEh4o/Fts3ndp4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfAMMYpvtw+TpMFvoCDy499NU3N2QF9HhepO7hlgw/c=;
 b=B+qZlbpIdZaug0eN2Dz0E/wx8uvcKSNwYHBBOdTB/+e4AUtLpNpFvEzaeJbF9SiTafhCcnwnuv2Pn0+3tPwBZJQ3eBl3yEnWpeQ+4iWL4UKgV3lRVdTqGmJIlistSfRaUpwB6iDmXJ4fx8jn7DlnSxvpiFfNsdGz8JuiEJH26Ks=
Received: from SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::13)
 by CHBPR12MB443627.namprd12.prod.outlook.com (2603:10b6:610:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:41:37 +0000
Received: from PH4PEPF0000B611.namprd21.prod.outlook.com
 (2603:10b6:a03:41b:cafe::2a) by SJ0P220CA0029.outlook.office365.com
 (2603:10b6:a03:41b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 11:41:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH4PEPF0000B611.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Thu, 15 Oct 2026 11:41:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 06:41:29 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Thu, 15 Oct 2026 06:41:28 -0500
From: Alex Austin <alex.austin@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, Alejandro Lucero
	<alucerop@amd.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alex Austin <alex.austin@amd.com>
Subject: [PATCH net v2 2/2] sfc: ptp: avoid racing PPS timestamp updates
Date: Thu, 15 Oct 2026 12:41:04 +0100
Message-ID: <20261015114104.2531624-3-alex.austin@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B611:EE_|CHBPR12MB443627:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef421cf-406f-4246-0f01-08df2ab1452a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EcdW41KPEfYERxftBOrj6Ck4ILBi5lp8pmVJX9vbGd83xujUvnMOTqw8BQCV+rZHgY0EI7pR/rXniVIRgrjCVNXagjflPFWa8VgsRQqNtVlXI/JKeyYFVcbAXY96t/DPZ4Br5K51qqmqY5V/i9/fSouKXMOwJH4DIv2GAVdEGdpEMoFPuIvrHV+GYEJCxfr8oytlAm9WukFTh8/AB+WvXVeVfBAhGEh5+njSgfShCd8PaZXK+n/WE3nPb62muvkIU53n/MW3Mm3vNMyv26fGvo6SV9xzp7bBoZMDS5VEkN14HA/xcMPnt1pF1yjminxK8nkWGcU6fHajzKCb+s3/9WSrnHonD5l2KFY3mXDz5TbfNIsejEhN6PB0D6qppmgY8CzHT6PPXG0QFrTgMA3F7hUfFcr2usk+wOSdh07L+r9rPfiYZFu2pxtfgLGFQPiYFjbn7PWct5PsyNP4NHsHANwCDs0HDRBEq3kY71Sfz/OwCgMkYbmsMCWjbn8sbt42Jf0ikb0OEragZYwPrMjcRx29r8mhQg11/2ck+rEVD6JtprOx26mrXFoUAY7TKuinrArIpiHgFrYnY1ExGbkCxoFyyjg3ZFJO36bViSgF47xED+6C/2UMyq3Ojj7ThZtawnlhHXAPDT8uZ5DrZ7xatTktfPmJ/g1guJYs2rY/9RS6sib6xdxUbBl/anG5C+aqqphT3VNkNVmK1fv2uPQS7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HtKIBySxeD/KhdoxwKhTfRImIrfh58tbvQekgXSj1AEzz1TLlv/lR1Wiq4f5HhhOHMGt5RYHbLSw0DSuRo9m/2FLTKGbKfZhKxLGZeC2cBfX/NDPl7w+63BxIy04396cICGFGZd5pNUDNRyn/QkFKzDzymx0aR6Dk3km8K3Bqy2N1Rp4l1L97aBzpJmyxi7gEpbYurX/oQHYVxgTOMyng/z0spN4GG36/T71amzR5L+Xn7ei1dSOo0V+FrcQK7VbZW+EkDV+diPguk63DpHRDIwQAPqWq79RkNqT8hulSkdYiXgE22zOmwW4fYztOdWamPK20pmDDXZTOlvo4ifJTYphX6ek+wB61W47nKGEXWpO+/S4e/qDrBvkXGYvXDiJfzU5pRYwo4izd7kyr/5cVeX16njjpN7/I+68A/QddOM9u8YzB6AcwpLf73JeEtCC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:41:36.6735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef421cf-406f-4246-0f01-08df2ab1452a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B611.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB443627

efx_ptp_pps_worker() can race with SIOCHWTSTAMP via
efx_ptp_change_mode(). After the worker completes synchronization, the
ioctl can start another synchronization and update host_time_pps while
the worker copies it into the PPS event. This can report a partially
updated timestamp. Serializing synchronization transactions alone does
not protect this copy, which happens after phc_lock is released.

Return the timestamp through the caller's own pps_event_time rather
than the shared field in efx_ptp_data, so the worker reads storage no
one else can write.

Fixes: 7c236c43b838 ("sfc: Add support for IEEE-1588 PTP")
Signed-off-by: Alex Austin <alex.austin@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/ptp.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index c2f8b94..116b380 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -268,7 +268,6 @@ struct efx_ptp_rxfilter {
  * @evt_frag_idx: Current fragment number
  * @evt_code: Last event code
  * @start: Address at which MC indicates ready for synchronisation
- * @host_time_pps: Host time at last PPS
  * @adjfreq_ppb_shift: Shift required to convert scaled parts-per-billion
  * frequency adjustment into a fixed point fractional nanosecond format.
  * @current_adjfreq: Current ppb adjustment.
@@ -330,7 +329,6 @@ struct efx_ptp_data {
 	int evt_frag_idx;
 	int evt_code;
 	struct efx_buffer start;
-	struct pps_event_time host_time_pps;
 	unsigned int adjfreq_ppb_shift;
 	s64 current_adjfreq;
 	struct ptp_clock *phc_clock;
@@ -912,7 +910,8 @@ static void efx_ptp_read_timeset(MCDI_DECLARE_STRUCT_PTR(data),
 static int
 efx_ptp_process_times(struct efx_nic *efx, MCDI_DECLARE_STRUCT_PTR(synch_buf),
 		      size_t response_length,
-		      const struct pps_event_time *last_time)
+		      const struct pps_event_time *last_time,
+		      struct pps_event_time *host_time_pps)
 {
 	unsigned number_readings =
 		MCDI_VAR_ARRAY_LEN(response_length,
@@ -990,6 +989,10 @@ efx_ptp_process_times(struct efx_nic *efx, MCDI_DECLARE_STRUCT_PTR(synch_buf),
 			   "PTP bad synchronisation seconds\n");
 		return -EAGAIN;
 	}
+
+	if (!host_time_pps)
+		return 0;
+
 	delta.tv_sec = (last_sec - start_sec) & 1;
 	delta.tv_nsec =
 		last_time->ts_real.tv_nsec -
@@ -1006,8 +1009,8 @@ efx_ptp_process_times(struct efx_nic *efx, MCDI_DECLARE_STRUCT_PTR(synch_buf),
 	delta.tv_nsec += ktime_to_timespec64(mc_time).tv_nsec;
 
 	/* Set PPS timestamp to match NIC top of second */
-	ptp->host_time_pps = *last_time;
-	pps_sub_ts(&ptp->host_time_pps, delta);
+	*host_time_pps = *last_time;
+	pps_sub_ts(host_time_pps, delta);
 
 	return 0;
 }
@@ -1020,7 +1023,8 @@ efx_ptp_process_times(struct efx_nic *efx, MCDI_DECLARE_STRUCT_PTR(synch_buf),
  * the function that registered it, so a secondary function can capture here
  * without serializing against the primary.
  */
-static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
+static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings,
+			       struct pps_event_time *host_time_pps)
 {
 	struct efx_ptp_data *ptp = efx->ptp_data;
 	MCDI_DECLARE_BUF(synch_buf, MC_CMD_PTP_OUT_SYNCHRONIZE_LENMAX);
@@ -1069,7 +1073,7 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
 				 &response_length);
 	if (rc == 0) {
 		rc = efx_ptp_process_times(efx, synch_buf, response_length,
-					   &last_time);
+					   &last_time, host_time_pps);
 		if (rc == 0)
 			++ptp->good_syncs;
 		else
@@ -1504,14 +1508,15 @@ static void efx_ptp_pps_worker(struct work_struct *work)
 {
 	struct efx_ptp_data *ptp =
 		container_of(work, struct efx_ptp_data, pps_work);
+	struct pps_event_time host_time_pps = {};
 	struct efx_nic *efx = ptp->efx;
 	struct ptp_clock_event ptp_evt;
 
-	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS))
+	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS, &host_time_pps))
 		return;
 
 	ptp_evt.type = PTP_CLOCK_PPSUSR;
-	ptp_evt.pps_times = ptp->host_time_pps;
+	ptp_evt.pps_times = host_time_pps;
 	ptp_clock_event(ptp->phc_clock, &ptp_evt);
 }
 
@@ -1847,7 +1852,8 @@ int efx_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
 				rc = efx_ptp_start(efx);
 			if (rc == 0) {
 				rc = efx_ptp_synchronize(efx,
-							 PTP_SYNC_ATTEMPTS * 2);
+							 PTP_SYNC_ATTEMPTS * 2,
+							 NULL);
 				if (rc != 0)
 					efx_ptp_stop(efx);
 			}
-- 
2.34.1

