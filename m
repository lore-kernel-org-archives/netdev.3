Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1D51120C;
	Fri,  9 Oct 2026 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570793; cv=fail; b=OhMsGw7HAIE1zgM8JiiRXEaA3xf5iHeKrjY31IzMRVZylrtdYVaBfrXGiDxWrgxpdWz+q3xH6CXZFtNLCHA41VOYL3X3YOOnq8Piat3/NtswgSfBZ1kgazcP6BQbmWcW6UVFprlA1bUmXHo2dKza/dIqgWxJ2Eh3OmTnnsS7xcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570793; c=relaxed/simple;
	bh=p5TIG1brKjFVIu0tdxYkPjGS2ntQvCv7+6NA8x91g+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCig+Fq0hum1EJmrHHnaD2aJ5SXy9CMKpUO2QhvnEEkpLigHjlRQajhladNE4Z6OlAb6B/Uf1XROiQIRtOxuJWyr5jrTxTW8RkcZ+MkLKcBLm1BiZlNx1+T6ysZ0LIokizmbNtQyD1YOpFZUf3Xq8GZ5HcWZqvAVnrjZLSkn0wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=duzC05NK; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="duzC05NK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMeDtv6DJ7tQyGbgYIakOdcmQqWm/OetvdbHp83SRc0RVCFr9iucGgNHRVHDn5oTbWF38LPm3tj8SdF9EQCtQ91VKsjCyeoNsQRIYfWpwtBBC1zcK8XnfNlNi2KY/NIc96DRpaSFMH9dOYVj8VUxHggnloQMWTIi7XkC0nd+j5cBdqvfqD+TptuUl8KZbrh7iW6KtPyCXiBMlXX663rDzaii457a/GHKvLwSV0MG1sDPe4MhnUTRqP8iunfD3lULmQ59fvviHQ6L85wTvC+eAupaPAN/60XPV38iAt/RekyPxOeCwEE1k/5IV/iqGCV27+15B2ugSaiyH7a681b+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jseAmJWv5dSRGVSTuEHmoBpNf9VA0eP+LTv4oG7xhGE=;
 b=LTw1/VL/OhlwcXF8cc7pN2bsT3NU4E++NjGce7k8pc0LKifOFDk69bI+ou4iRQ42awyA/knHkb+ylTGTApt/pFYmfEuwdefK2rTFp4QEtnLzK2UAlBN/OWDQubsFm0baOq+PgUQmDTvMIwEvULC4zJSr73MFo70sdGxlpk1BHiFzPI2dFB9SEx/NtuafvvHUqsPXoucj9NiFnbUuLydEvRDpmCJbUdn8jrW8evPSIUFERDMCpqcxHGCIUTToapnWjlJWrzL5m7GWA2PNMTqlYEQeRXhPTmZy2za5h/VLRSembjUWQmVC/LunEzndjw4i76uCUdBYa8vZaLs0clEk4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jseAmJWv5dSRGVSTuEHmoBpNf9VA0eP+LTv4oG7xhGE=;
 b=duzC05NKYL/BfJmhSXMvhw0OmTdf1a345hRCOFw05LXGHJAi0+J+BhcmDpctnOoPQ4T5iwr7OBMFtgniwr8r89sINMi17dM7muHZvZjmfVOUPsX4aYTKH7DCbLOmSSTHS5Yvpyx98Hx6gM1E96oxMLT3MHj89L31F0kQo8bow0A=
Received: from BN0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:408:142::15)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 18:33:05 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::97) by BN0PR08CA0029.outlook.office365.com
 (2603:10b6:408:142::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 18:33:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 18:33:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 13:32:58 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 13:32:56 -0500
From: Alex Austin <alex.austin@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <bhutchings@solarflare.com>,
	<davem@davemloft.net>, <ecree.xilinx@gmail.com>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<smhodgson@solarflare.com>, <alucero@amd.com>,
	<pieter.jansen-van-vuuren@amd.com>, Alex Austin <alex.austin@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH net 2/2] sfc: ptp: avoid racing PPS timestamp updates
Date: Fri, 9 Oct 2026 19:32:40 +0100
Message-ID: <20261009183240.1898762-3-alex.austin@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: e578fbc4-c6fd-4049-0016-08df2633c252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SndnZb8ntQGww5j7PT1iIa6zyUAlYq56Dj4lY5zAEMA8fwhWUEBieqdUqQisAIGLFYL770iaa2oM15nB2hx64vLkyqZS+EP0vxWOleXDPUkvnkvz3GEZQI4KaeHxS3aWVgSqGkf96SP+DyEz66f9FvszdTZSPUtIepVxZxqM1nLBStfPpHVCu3eqQJgxL9T1aOlroNqdT0XZO9rvHtVtzTBCKCP9psu/xKBO6QKIwnZ8Ceb+ZP5N7qay0Bci7TRQsLD/+b+Motlz1B9YNYTSWSY7CLHTHqsaJmtycRKZIUZLvBXhUSqUM1Er2aSL6MsqzI8MHuDZ7Mt4BQ13OOIvFOKCrhpw6l4F72MYkuNBP4KMf1wuk6rz7s1UaoXn/1sYaTSkZ59/F18FtQU6FfR7r9+nDCM5MGFm1hADAR6fypaEQ+uxYzRo9JxkJ4ayF6rsbGtOtY4pAdh4W1d2jS0X3MSdAbvFGKtkmm+QNovogVVZbdGl0jx63AfLcjnYEA9+VmPFxHEocM5hnaXMaimB+v5ynh8kQ6FGfTVkYeo+XlDK5/o8XkoUg5Wpqqtg1vI7BHdreSSKBAXmKRTbwQKFWTBohoDFkceTIqaD0VOw3ElGeFwqJdFssMa9fXhQA/gm4qzkR6dIW5ORPowNUif7ulhkQwyvt046RGzyHqVvi2klwWwAqCemiRx4AOBcWMOn8CiQHHLhpPOEO/sOmyaAfA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rYhZPiydEtCyVvSyElvmo8M6g3CGhYksavo5nx0LSPgGF0EUowIpPTfsh3MGExQ1eu+nfZ8zVnmA256Fe+1cCrQzjUnIa2M+yAojwn/LsRSFNWdau7Rl3DR2nkbcZO7VRQUBFBSc1xip06AguUl1yf+ygr6Y2fMe+iY0pxIIT47zqdgjpOAy+CHqJakNF4mPMmLEXm4v3p/6tdsmmYRX8N+PaSFOynIkR30o+Wwra1yPwBHVbqlGdyk/5HFh+EBTlwNatWyIt63XUK4YX2OnwkgCiZYpJdqHRAxtdJ91jeHF/jszqTS1Wv52X9HCVfyaNbzLi/6nd75PwsHg3h9GwX3KHDDysj/Thextu/ZnwwY28DtktKCMH+4KMsAbOYUnD52mopy4/Y5u9HgIkFdPdY7fmOqfVelas/DlHaC8LZ1n0zsua5TTBsDY7mGAN55J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 18:33:05.4793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e578fbc4-c6fd-4049-0016-08df2633c252
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576

efx_ptp_pps_worker() can race with SIOCHWTSTAMP via
efx_ptp_change_mode(). After the worker completes synchronization, the
ioctl can start another synchronization and update host_time_pps while
the worker copies it into the PPS event. This can report a partially
updated timestamp. Serializing synchronization transactions alone does
not protect this copy, which happens after phc_lock is released.

Fixes: 7c236c43b838 ("sfc: Add support for IEEE-1588 PTP")
Signed-off-by: Alex Austin <alex.austin@amd.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/ptp.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index ac9951f..103df1f 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -205,6 +205,14 @@ struct efx_ptp_timeset {
 	u32 window;	/* Derived: end - start, allowing for wrap */
 };
 
+/**
+ * struct efx_ptp_sync_result - Result of host and MC synchronisation
+ * @host_time_pps: Host time at the NIC top of second
+ */
+struct efx_ptp_sync_result {
+	struct pps_event_time host_time_pps;
+};
+
 /**
  * struct efx_ptp_rxfilter - Filter for PTP packets
  * @list: Node of the list where the filter is added
@@ -268,7 +276,6 @@ struct efx_ptp_rxfilter {
  * @evt_frag_idx: Current fragment number
  * @evt_code: Last event code
  * @start: Address at which MC indicates ready for synchronisation
- * @host_time_pps: Host time at last PPS
  * @adjfreq_ppb_shift: Shift required to convert scaled parts-per-billion
  * frequency adjustment into a fixed point fractional nanosecond format.
  * @current_adjfreq: Current ppb adjustment.
@@ -329,7 +336,6 @@ struct efx_ptp_data {
 	int evt_frag_idx;
 	int evt_code;
 	struct efx_buffer start;
-	struct pps_event_time host_time_pps;
 	unsigned int adjfreq_ppb_shift;
 	s64 current_adjfreq;
 	struct ptp_clock *phc_clock;
@@ -911,7 +917,8 @@ static void efx_ptp_read_timeset(MCDI_DECLARE_STRUCT_PTR(data),
 static int
 efx_ptp_process_times(struct efx_nic *efx, MCDI_DECLARE_STRUCT_PTR(synch_buf),
 		      size_t response_length,
-		      const struct pps_event_time *last_time)
+		      const struct pps_event_time *last_time,
+		      struct efx_ptp_sync_result *result)
 {
 	unsigned number_readings =
 		MCDI_VAR_ARRAY_LEN(response_length,
@@ -989,6 +996,10 @@ efx_ptp_process_times(struct efx_nic *efx, MCDI_DECLARE_STRUCT_PTR(synch_buf),
 			   "PTP bad synchronisation seconds\n");
 		return -EAGAIN;
 	}
+
+	if (!result)
+		return 0;
+
 	delta.tv_sec = (last_sec - start_sec) & 1;
 	delta.tv_nsec =
 		last_time->ts_real.tv_nsec -
@@ -1005,14 +1016,15 @@ efx_ptp_process_times(struct efx_nic *efx, MCDI_DECLARE_STRUCT_PTR(synch_buf),
 	delta.tv_nsec += ktime_to_timespec64(mc_time).tv_nsec;
 
 	/* Set PPS timestamp to match NIC top of second */
-	ptp->host_time_pps = *last_time;
-	pps_sub_ts(&ptp->host_time_pps, delta);
+	result->host_time_pps = *last_time;
+	pps_sub_ts(&result->host_time_pps, delta);
 
 	return 0;
 }
 
 /* Synchronize times between the host and the MC */
-static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
+static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings,
+			       struct efx_ptp_sync_result *result)
 {
 	struct efx_ptp_data *ptp = efx->ptp_data;
 	MCDI_DECLARE_BUF(synch_buf, MC_CMD_PTP_OUT_SYNCHRONIZE_LENMAX);
@@ -1061,7 +1073,7 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
 				 &response_length);
 	if (rc == 0) {
 		rc = efx_ptp_process_times(efx, synch_buf, response_length,
-					   &last_time);
+					   &last_time, result);
 		if (rc == 0)
 			++ptp->good_syncs;
 		else
@@ -1494,14 +1506,15 @@ static void efx_ptp_pps_worker(struct work_struct *work)
 {
 	struct efx_ptp_data *ptp =
 		container_of(work, struct efx_ptp_data, pps_work);
+	struct efx_ptp_sync_result result = {};
 	struct efx_nic *efx = ptp->efx;
 	struct ptp_clock_event ptp_evt;
 
-	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS))
+	if (efx_ptp_synchronize(efx, PTP_SYNC_ATTEMPTS, &result))
 		return;
 
 	ptp_evt.type = PTP_CLOCK_PPSUSR;
-	ptp_evt.pps_times = ptp->host_time_pps;
+	ptp_evt.pps_times = result.host_time_pps;
 	ptp_clock_event(ptp->phc_clock, &ptp_evt);
 }
 
@@ -1837,7 +1850,8 @@ int efx_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
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

