Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793017857;
	b=P81CADoHQ6YIoS1wHDXhldghW+N9GMunUSRXBhb7wUUAXOoOSEHML0ra9vkxi9E3Ll8R
	 +0pbMXcHDuh4svDtYbSEYu9SqsWHi0gSHG8+IpsBrtRFbKfMx9l2OI+D8gw/qDE3uLPc2
	 ybSVq8UvCTMJBKN/xJR3aaN950mvBG81MKePNHkTqlJX7diK5ZiONhJoJrLEi6zMJxlOu
	 NjRmMSBs9136p5vI4+aIE5mb1JtqoQ4uFfHcjSf8grnv+GG/g+Q/lF6AN6Z9TFEHHcTY0
	 Y5qbpu5D8kP3xK48Q8nGqNjg3SMPqDS4BXRSV6LlZTI/9Zc+rZ52nCRoL8ra0x8X/bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017857;
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
	b=EVS55/E06gNeeas7o2fgDzLFmbwkLwlnCWDSy2GWiKNWinGQx1MZWZFZjOYTb7MR3aCt
	 YGx+1tPcwV1aW4y/N8S667JG8GBB7zcMw0JMqtYpQy05Cq9ypZ1sL2aum3QSK2Uxql7GD
	 Kpp1MrkGrfzq1aXHRIEOV2xkJ3u06B4wH1XVkCFE+qT7YynBx6T5lrhEF9NhVEPf5vxnU
	 gDeEBhxD7GkYjSZqcLSUzHnj4lPCKLY/8e0K3Q1wuEYZuJiandpsvVaKx2ssVqLU6SYF/
	 yh0cbgwTuUKV9L1A20V40GAD6RKy6N1Y/PQ0/QL2Hapgx/AsOxcAK5Go3+ltxhg/i3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1lsbg5DF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.49
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A991606A31A;
	Mon, 26 Oct 2026 12:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A991606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1lsbg5DF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKMYUa9zb+dG/vUskVUQklfaekm7fQCJfjmL+ya4IfhbO7l4hYgSTDx+iCEhaSm+ozX16I834FG+C17YlOSTiT+NxmutamBcKLTu1JafS1magiDweA8ReA5Hh1IvJyWju5ki8kuWpwCJHKCjuFYJXGLI3mepYGvM5YGegmttkb0TBDF4vEjoj3WJTTSO/Zk4DXlnRwa8jzpOkKi7I8xnyJwHFvsS26Uw2mAy7asmPDGLOMOCcUdD2bq4kCHPJrN2hXyYVGba5ilmci1Ufss/zUgITyRleGYEWLADUJ9ERWjYcKl5hNCUzV0F4HVd3nb4y3xwdE8MOmrmR1K0IOfFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugS5CN4Xt+YQeMzTs5ZJXAMTrXk/dyw3Y4INmBZA8Ws=;
 b=HqKehFWkqAtLKTAjiLIg76ogtdcSjAEDRzthXtlS556cgbG3Yp8xZ4XW06sHSaOJbUdYeh4DvBF5niPtuY8tqLaguyJcADlMSOjA/kBGwmV7EpiXVjh0OmaUnUFowRVLJQ8LK2kyAi8hQW2HK+05KUplxWGpNqt+Y3Ytg/rw/LxcPGWq0xNWZ12c3O1eLHLbVRlZjC95uS0WgJ2nAK7DWO6x5nmMefOl1WEvEACGD+r/IQIh/0weaRh+zEC65t1EvbnFZrAtYAl3m5a11smfgPinvGk8CclGwG9Ky40V9z493/t2OfEsaTinJ9hUgUmwZgqknYr4fU94dhguJxIwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugS5CN4Xt+YQeMzTs5ZJXAMTrXk/dyw3Y4INmBZA8Ws=;
 b=1lsbg5DFbfHEeLkUsYAttSZT9y1y+vzpGMfYIRUP+RsWn+lRz8kto81jHHu+N8mxl+lT+B3qnf9vrKZWvAmPIaOMTQ9Mg8QkOJP6gxpBghEF9zTOl/nvfvnuVGP3O6/0TbMcli/VP7YrfgskhPyQKTcQGFnm4fvvaRpQ8evKVbM=
Received: from CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::23)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:30:49 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::8a) by CH0P221CA0007.outlook.office365.com
 (2603:10b6:610:11c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 12:30:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 12:30:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 07:30:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 07:30:38 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Mon, 26 Oct 2026 07:30:37 -0500
From: Alex Austin <alex.austin@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, Alejandro Lucero
	<alucerop@amd.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, <netdev@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>, Alex Austin
	<alex.austin@amd.com>
Subject: [PATCH net v4 2/3] sfc: ptp: serialize host and MC synchronization transactions
Date: Mon, 26 Oct 2026 12:30:22 +0000
Message-ID: <20261026123023.3566549-3-alex.austin@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: a922c1be-05f3-4fd1-c957-08df335cf7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|11063799006|56012099006|261021135927099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	5VABjYvXRm/DYrDFFYV/7k1Ull4b7N7PIL6qiyrS/oosOOso2TdPAL21gunPblucrCEpb2fdvfnOKRLDCYjGMfU02dO8g0to0f/iHgNdVXlNG0sTN8GEFahYukQIbmJ82a3ovXq5kE69Tv2iLHDhBbXM6KgfFzXpJOb6uUiLu8CekAbh0fy+f8rE9PH2itB2M9Bnj6CYzGY/bioF4sySnv0PkVUq68QmcTzodFIKsNQCOsDH0WRbc8Ic+eupzOtt0XYd6WDm3qYMY1/CEOCKbhiawhTIf7hpX9SDFDDr7TkFoJ8TnAJj74Y7CfQsCA2IUQq3YC0DwLy4p+cnOSCQZv7+Hzak4oWaBQI7l20C+MOd41nnUDJODgkcCI3Fjl4CqCd7j3+l3sqZqrQ1shghRTWVBUqjYocrA5WNFl6KY7Wxs5ykm3TU5aRlzqjAdeEXEjTcA3lZzjrUpF1JqIE9wrBf9Rb/tF6MuevyD0cgSZz5GdtKYECBp1DQQz/eZPu2iLpjZMyL1JzVAj8ys+/zFbtAuiINedZaa3DCWAlfgfXZ4q4iHJdwips8we/MR8lfpotkoxdqiR2A7/PPnOYhQMGZSIvdOjYXBhMhg7oGhCa3Dk4FAeEdvpz/pqY8qPViyHZu/DF9ZUBvknRBYpQK5vVoxI0eKnlICLfRX1dW+9e/4oNSS9Sx5yEIa/dLcVTXoIy95z9TuZpkpBIlLe2JRw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(261021135927099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vB/56hScwnB1sSQwrnwJJAujxrNLfuc92yqhR+KKsVmgXKCvsUGSpIpnViYqAobvo9tPHEtqwsZzYj3SThSf0131DRpiR/AA8adBXaQG02oIQuw48oHPyqLz29VSjsb3EYTYMjQ0UX2RQjTRhVKj4DFFmjpY7uASLJSbBEgaQUx5iX29QALmFeU/ykF9jQjC81uNWisTOq4u4n9lGdOLcO1Z+D/fb1AuWZgWzacOQ9jdOo9Iw20UWM1uuxNHguQZZtSX49cxIOibBa73HLGxJ6MoPDWW/dZsjqo3Zur1rLIi+udrpgigGM/b4/PfmMNj4MR0DR0kDFZ5DnQz3FbDvC8eemtkFEVgmnHycN7HVt6fM/DQ0FKPL1uhCEaLygiNdULmEn9XtuMqVOYtvyJj3zQjPNk9IOokZ/fVqc84FICDezuCQFutOxcem7fWNpiC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:30:49.5059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a922c1be-05f3-4fd1-c957-08df335cf7b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147

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

