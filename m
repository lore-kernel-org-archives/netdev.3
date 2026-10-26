Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793017860;
	b=0+Z51zj5vl72XLgyhlK8XDKlCw/bjfk5KHuO4oRiVTA/FJMBF5trCRpC9237Yvjp0YU/
	 ZuC+hQpI9diOaH4ti6Dc//Yo3R1dr+6yIShnN+/+TKTLlWWZ+Kqf2/7d782QLFk0DmJZ3
	 t6gdMXdE88okCDfNs8srX+NQuWiSQz70b2QJe+wn1f6uhxdvCbVTm4+/LvGDJdzIhrnAn
	 3GRqQf5l5GWNEYDhE7CEhmnDwZPh/hCCfrPGw5sVyMgPrM5w5vBAw/eIQHafWUXdQDIgI
	 m5kncHvflA6KJLbKks+/vHICXRUHd+2IEMwtAhDKoLV1yxAPYAlDKcLrxwzbEo/L+QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017860;
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
	bh=bmHZPjfmIc4enEGR6naj+q1z5ghYzD/WaoQyJfH0jN8=;
	b=Oapb+qJ95JPsz+w/AMBNRql9mxMiDFpRmXyBpccKqgtb+ZtvgjTj10RmeTYHlsXm4gQv
	 nloUkwfStqv5NNvH595MeUc3TrhonrJMeQAy0sINrV3slpY0fx/GSSFrfHD3eT5PJJgr8
	 RWlW9oHf4Gy0G9+Ly7+B+UuChE8yqFvOdrjZuIccB84M+ra+h2HoyTZyLp3smnOPFE468
	 UevqAGs8xCy0IDaBWdJzoh/MtpLq1kxVRzYdgR1f8AXjn8m8SZ+7rKe8qDsK6AaLFMDlh
	 C9bCMQHQChGs+Io1lWszG8iWMs71g7+GMaeIAA6oyi9BApOkMBXxQ8A19QeYquBJJlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X1fGiw72;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.41
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3D5606A31F;
	Mon, 26 Oct 2026 12:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3D5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X1fGiw72
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhKRIooOo0Q6sLoMhi+s0/ew6NpK5x+DZWhXnYMl0Nz6PYksiyOV3l8AN/c+FACjmK8ayTWFeNHMp6w+G9Z9eEWzqR8AOUduLj0YPM/LKFU3z73ShxipH2iotyJ1ZpCNtwmL5mBEiuRQ5Mf/hhtO9r/rXM9aiTqPiXAR1hocQw/8npF/xvt3NALcU6hfr5oWPTL7a+FFcO8jWwxyf5O4nfXxy8ntrJJzungxUxl23v0yC/RX5/6W5ypmHY5WK6JHGzF6kFGoM1JDH2qsuLmrhnX6Y0TaTSUYhomEv53YzZC7x4066c017i0et6GK/gKJeDM9rnb70DXeoRp2EtEh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmHZPjfmIc4enEGR6naj+q1z5ghYzD/WaoQyJfH0jN8=;
 b=EA5qEcPQx19Kn0VunBF8gwRrsfExxGOR1nwbdC9E8M4mEVL2Kx4aeenjy5bV1DnHQOml7Cc6xZczuT+AykswyJHjAzmx0y0jBmPevjIUHDIolLfzdEXEHAY+miybsh5nEPPehrktrdQSd6L9x+V0WgyntVAuctW8+IN0KdmosD/etsf8berc0ChvwbQQfWIkx5qih6qziz+YJ35yqKu2fNFn46TlsYMuUGX2Xsjiy7fog6JRBGWnB9FjITqqWLMtzKcAjQBQJWzbXgIzMLsANn9Xvnek96dLlYQws/NPnXMHLDdmz+Y9kuiw5yGfTqi8D9XHSDQB86v1klYF0Joypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmHZPjfmIc4enEGR6naj+q1z5ghYzD/WaoQyJfH0jN8=;
 b=X1fGiw72ML9GP//wIW6gtHR1deSP4QP+730xCvaaqa8aySLyiVuZ+PF9+FHXczAA4MaXvdkv//gtcbVhL6nf2q9GUdnS9vNmQe/M4cqgXk1Aw7YjXLEjvr3EQx/hO4ThHX31itZUJcK+hw10gEblGgCUAUDScR7+XBokty/QBb0=
Received: from CH0PR04CA0069.namprd04.prod.outlook.com (2603:10b6:610:74::14)
 by SA5PPFD8C5D7E64.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:30:53 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::4a) by CH0PR04CA0069.outlook.office365.com
 (2603:10b6:610:74::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 12:30:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 12:30:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 07:30:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 07:30:41 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Mon, 26 Oct 2026 07:30:40 -0500
From: Alex Austin <alex.austin@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, Alejandro Lucero
	<alucerop@amd.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, <netdev@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>, Alex Austin
	<alex.austin@amd.com>
Subject: [PATCH net v4 3/3] sfc: ptp: avoid racing PPS timestamp updates
Date: Mon, 26 Oct 2026 12:30:23 +0000
Message-ID: <20261026123023.3566549-4-alex.austin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026123023.3566549-1-alex.austin@amd.com>
References: <20261026123023.3566549-1-alex.austin@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: febe6a64-581e-4d1c-5de9-08df335cfa41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099006|11063799006|261021123027099003|10067099003|261009223027099003|261021135927099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	anNMXMv582xsLbdUm2+vZq+cWaDdbaviO3yRPsmRHMSGrvI/RnFG15IbVTdOQ+ZlbBmGTYW9vtABYZMEk5GPTeBBOWGzGG1oEu72gqSBdjcn2Jr5Q2V5ZmkqlsZzt9SMd1dIs/NAWTk+ZzYLdu1RRXI8UQF/beOJQJXAWlotJsgFMgLZ1aQDLj/hpsue0mDh+uMTKV5ZQk3Zib3TJerUr19NPvCTBYsttzGJ3m++81CG4dxeUM/XLZe8Yj+TNeNEcwNWh2zMr51aOTIzlPSzL8gwT0TktU6QAzVCRfw2gHNVcyKy/lMrzGCVzQXYXe1PDcTiTrnU0rLrb2v4GB7O4DtB8FDpz1pRNV+Qvhpv7IBreyJehlVecCm8D2aQ0SRsJSf0v6ts3JugzTN81lkAQJDqX9KgmXXqJCXXK7cji629f1WkQN2WJshycAMPt6oYIBtmh2VvTqMdzejOJmifrTOQfaJgmUlIuVs4Ea6hE2szfCSDnDFpqRhn+pNrVa3rY3CSGw+boVF8YdCezS7xjd45wxN2LeaZqQNCBvIYutGlwFAMMW8rI4u3aUsU7HjZa1NwJ0UUoZyj/tZwzdFTHkBYeTGJMcCKJA/doJtvrCVGHb7kFfBXNWhcO8z0qfurPsUpj4OP91mp/sOV2rbPHxHueibOJJsl6iPPQYam9w7t2cJdjaBb8mQStKNVOUpyEqUIrykvqarrrs+Qg5Avmw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261009223027099003)(261021135927099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T3p7RQ9LGS5mkljZ6GNoMiJPLK2POpX/uaJ8u13HAQQLRvzKMqA5OPsMDJnpfcgCdGj8pC6oHKlEaKpltWDr+iWyrulISW5qpn6MD0WsG30yb33v7NWKZajqeLOKd9GUyUz8GxoQqNIyWlvB128ShgB7WElwBbPzIoAEUS27Litaapg3QhK2qo1c1X/4BQ/ILl+EUyia8afKHK1YuGY4g770nAGYjoZTmCJX9F1VIPvIVaZjSNdW8vikrF/jfq/QbgwvI3IytF3MBmYbQUiLgL8GgM0tRblF0WuTDff2g/1wq42ZqUf+zsGoewXz4YsNjiHtMPku+fhTCzvsbB59wbBSozx2Cn9N3pFkyAIq9BVrkAHzATjXZCADKMEtVpAPVkp7jO1qCl6zRH3+xASv+Xxu2RGoNnNVkoMceH6yZ6InznaKutHeQZ52/5ABANRN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:30:53.7915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: febe6a64-581e-4d1c-5de9-08df335cfa41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64

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
index eedab53..3c6a85b 100644
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
@@ -1501,14 +1505,15 @@ static void efx_ptp_pps_worker(struct work_struct *work)
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
 
@@ -1844,7 +1849,8 @@ int efx_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
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

