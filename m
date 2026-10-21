Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792574170;
	b=Y2zL02z9jiyXXtIxKiVHqOANsvM8qP+fyaJg364XeVllLonoNf46QztK2B4GgXv9obAV
	 Y0MNLeKRjEDW4kBcPjc/vZvMP6+GautgcIZJuj6zif2KnKlSKmzK8/YhKkQvBX/YQ7S22
	 QgBA8SYu6QW70UPSdX9j0JM48RL21k/41oV7owFbor/LEzfmZTahYrrvDyrew4xzVBb4z
	 CJXCO14jXwUwST4aWXj27/oeOObN9fHxAZtEmtPMypOrOTeEQxMantDbIvaoI9NG+haYC
	 T19Sbdb9MdWR6D74k8ZtpPFZ/Y1mS5jH5XQSt17QPpP6q2NmB5r4AZ5CftuB75HkIxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574170;
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
	b=XDHOaL2AmSnU9iQFSeSUQEsIuieEzt/dU9ev9NSq7AB0RJOCUwHQp00HC8VF7tt1LWsR
	 d94SKEcRQH86T7QKnQ1AlXT10gMAlEPjcJGtvH8WxN4scwU74no+KuRH/8Xtzu2DhBrAh
	 dFiAO5JYXXfqYlq5WeVtIM7U3zHUP7y+3q0TqSqu15GnF/zqcU9OXL1xXdt1PUUyo4RMC
	 nw5Tnt6sA6u6vrk3/3TYKdHzGuTIMVOSOTeyT1k2E7IKH8X7R89HVY/v+bfcmYybGEB3/
	 6R4H+G/srOCOdmrOaqqkoqI+8WIavRuZKHcu+W6tHrpwTUNV5Gt1Ghq2Vlka8XzwG6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=THCYIcbe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.33
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90753606A32A;
	Wed, 21 Oct 2026 09:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90753606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=THCYIcbe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4rCD5N4ANcNMFBJMFu3dnSYDWXCqTyhXmNPKRaNaF15HDgnkKRh0GLDEhyQjnpGYsLbb8Hc1jgQTvmckfSH17XTjjHrjHwYqNyDJpCl2ckfSslre5sBR0bOJgxIf38D49YWw/4IouoJLug8WDv5a5TST5b1a0WzJfG8rdaDeHMdeYHOvCX5q1PrBH/MBtZkgViOAfbaVP8yfjo745+30oSIA/PZarOuZ2M0mwOGL3KwIySu5gFaOYkvsd0U1w6HQTbw+dPc8zRIj7GqKegmOfsr2V8Ckxquy5v0tByqgz0eNzTt7c6MQm9L1IEAFETKRZZ18R7Bkxmj88Ct+MKHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmHZPjfmIc4enEGR6naj+q1z5ghYzD/WaoQyJfH0jN8=;
 b=pHopb3j3zsfMUAB/NEgOVkfENvEsVPS1uxvGWJlKNoDSHy0EG5+kdRJZ+E67EcGBJp+TY+wjI1FZDerIye7biyRJEtSQl70z1DdgsHnVGzYk0Rm4awt/IjFVA2bX3Jf9T7OQpIgCWbDTXkU6ah34S4V/8A2d/i2Y+Fs/+KB32zBqsxJRJuRgAtLm1NhqMkx09apGemFz9XgLHv/w32dFu/BQi8GskcTHG3hMmaQXQWeJNz7piuYi6NA1Nu/BNVHi3BtAPFvKYrWzLKITmLRgPZP8tQJJXCLf9qA84e7dRJy/LdflUh1RfNjaGUB0tKe3C4EvCCgiQBLIbRZaFz17ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmHZPjfmIc4enEGR6naj+q1z5ghYzD/WaoQyJfH0jN8=;
 b=THCYIcbeVSUQLyLHXCR9X6/jgdMBF97L0VXghnzTaZowQHzbiS/42k1tbR0oQctOEMZzbqqj1xnddt6itmdqKlxRDKeB33jf/CJHUuUCnIYHmYCKwmZ/jHlKht09M3utCXulX9rq8AFsHv0h4Jga4uKp6Ai/TySngqjEzfF0yYg=
Received: from DS7PR05CA0067.namprd05.prod.outlook.com (2603:10b6:8:57::12) by
 BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 09:16:04 +0000
Received: from CY5PEPF00000E7B.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::8c) by DS7PR05CA0067.outlook.office365.com
 (2603:10b6:8:57::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 09:16:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY5PEPF00000E7B.mail.protection.outlook.com (10.167.247.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 09:16:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 04:16:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 04:16:01 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 21 Oct 2026 04:15:59 -0500
From: Alex Austin <alex.austin@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>, Alex Austin
	<alex.austin@amd.com>, Alejandro Lucero <alucerop@amd.com>, "Pieter Jansen
 van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net v3 3/3] sfc: ptp: avoid racing PPS timestamp updates
Date: Wed, 21 Oct 2026 10:15:34 +0100
Message-ID: <20261021091534.3164258-4-alex.austin@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E7B:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: df9e3a57-bdf5-4793-2796-08df2f53ed76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rRlOLUopbFLjEscO4Evctm3gZKpMDIMaI9p0SDAxhsxS23OlNjQadaaWg5SomICmvUPbKAL6jlyfztRkfDHiCTHL0B7y643h3Andm4sDstFKwzx1JbKp9k9TNVs1zJYtH78FrKBcfcG34+/d2pmjURJ23+Qo+qVOaiccwy6sm3z5Pwjhs5WfIWWMwTHT7EJaNN2sppdp147RQa5P2kIq7k0dfEiLKSG6gKOnQjxcI1rorKgUTH5n1uxw/wAF6x88jacVVJ3pMFae4FZMQFDf8xDPBN282kxfpgnGndcId4EVgtDM+7r9j6JPd6GnhpnLrRWxmfG9I98sk1cCcUKINDTWg0sx/YzbC1qkHgvW1DCejsCXEKNY3BAQPPhUH0V6UBWj5DSdnDmX3SvZzO785W82retpkARIWsBpGBAvLG/6Elb1LsYfdjT7n/GuPW0SnivMdQ4EIFQtBz40t+OQV0S4GrtgoSInLaNPPZ5Romh8auYmp8fvonos5M3mkpe8kGZOfww8Q54qgCkBUEiXDaxFm+1x7yt4L1dYOctnvY1Vt+YW4APmJcXkfKyCKSce05uMcA8jG+h0cPLOagp/eWnQJDpbBOQ8eOVt6pTo2mN9ucEByaD0zAaSXT+VEq/BJXuuldSmS3wzc2Po+iLwScg1QTBwrjqY0w7x9ia5+s+FMKK2/qGGMH54OCI3hr6oYwZsBgef3ucncWg1CVHI2g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QoZUIQTTGqpPNH4TOeRPeXmtneIy6GRKW9MjF4eqYiLr8lXgASnosOQZS64TlT3f7+dbWlmViB0Dh0lKX/WflizSn88qlWYZdkXgUDU72E9kZP9H1htaaozGpyj27990FiZZyoxnznv+asy/BDCwI1qavGSZHSsw951gvbLWlGHMJVwdSApPebJ3E6oje4Q9WnZcAYHR8kkxylkIXKMUiDyZhu8zlbZbcm4Y+3v3/N0VPEzTe2SjopQw/VTwCCAxtVb7MNBGibb76RD6UKsZBHIrIM7bEVn6WY/L0wsOfTv8q5YcrvD57Md/KT6Kxn3CpqFHw1OQh3OQoMBPZaMarFtXlznNBYsPW3oDEU5nwMvNe+OvWWS4++J7u3UIx9J2C8M9a3qNi6nPUSGkyGlR57pjDzoYVEJJEitZYysMoBY1r2ySsIjAEmcy+P4wTlJx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:16:02.1751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9e3a57-bdf5-4793-2796-08df2f53ed76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E7B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994

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

