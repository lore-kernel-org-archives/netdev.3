Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793017841;
	b=jVTMPQgwqvBva1tQlrnQqBvAm/bCzILp2CgvdZT5SPGLay0Qi2ny0HUOMclPDx9Yk37f
	 jjvMu5n0G3gBESZqhVkJJXgaUClBpher2RWKYW6MQ6jkzNTLhZi1mYP2HOvIHnaDezjC8
	 Qi3X/6jZsT5CucJ7fwYkB9UMGk/0+k/YUaecHh2TnnmFm6uroTeo8tbhao+6RJjcLsd7v
	 Uykm4DNk+sqTVXkfG4QARTH+W2gTHU/m/GorKAjUiSjACUkoAV6pVtEAOYnd+YwBOmNdU
	 HJOYkrmTDrY1Vzp06awzbOQ7uOg4hRCL8q8Qf8c4/AS0+12kRoE5fiZrIjI23bd92jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017841;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=PuK8Ok/x5IXkQO7V8xOA5DltinVHqZ//0/l8obEWmR8=;
	b=LMKJMGoiM/zU7Wgvfcb+Xu/4nbw4rsj5llY+8pwOSkt4kfFVR3prf6vyL53ELnfHQCWK
	 ojNaAJqceiBBX4iH5qdxBm4o1GCIVvQVpI5lh+jnxJ8F4SjuWuZSmArKGOqV0H2Y8jNh0
	 MZ71oAzU+SNluTVJOZFQb4TcmZpX4qyfLm+B1pO0y5qyAtTjt40VmjoIOmbuy7sBhCehd
	 Kd77U+eYLFUrDZawFFjUkhdAL+KIrOb0sYhP/j4KebtngiVJtewRspuyNVIGjkC6EaNc/
	 9bR+/p8k9OtiUekYMDuixiACxLAsq0I/S7UgopJnpQNbgdsywtiG8WnYTzLX5j/4XcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XsABzCMY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.6
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20926606A31D;
	Mon, 26 Oct 2026 12:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20926606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XsABzCMY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzX/QUYTTg/GKb1Q7Z9h5LawblTjlymlYb0l8U2wGYYsvqKhI6T9GBhlqm4M5vtOLsQAxyqcx3aCTS3rvtLIUt0K1JwRv9BtlOvDGdV+H9gyEqC6CuxIAeitOMwNZXplSsz6bX4cp5ME7Y4a2G54WOfO8EZBwX+nux2E/6Mghsg26CzWFWRoUo9WQWMUs06y4c+pBaZoHH8cNmnuAMG16MkK/fx5vRhVSr66lVUsb3nqromcDpNVAxxVnPg8WqSrG/oN+S8YA7d3wyDdH/gfkGyTdZhKb8My9Mc0m7mkDgNIdzsY5C2zu259c8xTF5F5tpIOUhMfUdbzKfj7wECMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuK8Ok/x5IXkQO7V8xOA5DltinVHqZ//0/l8obEWmR8=;
 b=x+V5mBFP+d5Vqcl/ijBEtWhgD1DpfYtRPlNG1t0TYmXI8Sm5xi8JYF9smjtQkYsVaIavg7B6y72Fqr27jYKxVVJOXo0bk4zXMXQdwXLll/UVQgRMH+7MwCkKrMmUR6NnbQBUslrkH/aGkaZWXXN4jIJomjQAzTZIG/ivLD+E1rntwphvaAas2GfLgXLNGK3VnF7OB/px5FFap9PKYuRRgGMUy0rgGJ9CPV3s1M/ebm70QP/NFOxgeBk8HOAYVQzGkQ/SOIYdcNG6s/+8UleW0bIX4wq59YsYvH75fh7wv5hYtVqp1yTnf6vVhHl5b5d3XRm7HBT7lfV1j0LEYfjJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuK8Ok/x5IXkQO7V8xOA5DltinVHqZ//0/l8obEWmR8=;
 b=XsABzCMY/DNdeywdk7tfrwoOt7nIdK+9mVTYBuK3F0S1i29sN197me8Etc5Z11+hpjB73NJHBXjze+sUsdAS5w0VwSCKFIXqFcBDfr7UTihhyfl4xwU99mY2EkFoD6vIaC1MKVWsfQ1rngj04hbeW2l+ne2sgLmnH5P35Tmx6FI=
Received: from MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:30:35 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::28) by MW3PR05CA0022.outlook.office365.com
 (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Mon, 26
 Oct 2026 12:30:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 12:30:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 07:30:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 07:30:33 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Mon, 26 Oct 2026 07:30:32 -0500
From: Alex Austin <alex.austin@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, Alejandro Lucero
	<alucerop@amd.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, <netdev@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>, Alex Austin
	<alex.austin@amd.com>
Subject: [PATCH net v4 0/3] sfc: fix PTP synchronization races
Date: Mon, 26 Oct 2026 12:30:20 +0000
Message-ID: <20261026123023.3566549-1-alex.austin@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: eac0f995-3f2c-456c-caf5-08df335cef2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|6133799003|56012099006|11063799006|261021121427099003|261021123027099003|10067099003|261009223027099003|261022105027099003|261022075727099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	LbhoBhIWBYqF/3bQ832V1o8tc5S9NqFRshjAzYSUz2lwoQXOiFwVoWmsMK5lVqPa2b9KPRSoX8WKRyXNNCrpAaL3bbvnuTSzkuXEdFrdlKlJvvJw12q+UeGE4xtkCd/RWyZV5gY1zrW5J/+8KygoY50nizeaZMEriC+3R70NVH5l/3QBsdR75ZwHrUCa6OQIxOowWCqwgVs4osc3ca5V7TPFsDieoavPHo+WBK2Xh+a6aanEM4Jx/wSlSCPumcI1vcrgMfpqW4w2ual1b+6lYBnpj85K8ZD5y2pmCtIaiiCX7vQQyZFPn22co6c7Jmmik2/sEMd05FEqjy1xCdAuIpBauSGrqOOCT5Ka2g9+Z9BrA8ure/npsMtErrWCLVn6yGwc2urlcA+dc1YnQbitiM+tYGhok1PS2Eu3ERYrRSJUElU8UYEqVhtxNihKx1uJnofm8Ga+2QPsNeGzaT0WcWf/slKq6L7NUzZM3SkYabqUVARgRBGJEVglpKn3y+HxsneRslswpC91umuzcjTGig1XNI1RTl5ywj0ETU5O4mQMkk4urKidzUI3dfZADbqw4b6fA8byXPmgaVKYNDQdqDJWER9I9GKKyri30qgZGlQfODLe45vhdMkkEyISJqGm8aNat1XlLfrNbXX00SumRtjsVGcYs12TTaMoJbqB47ohOmWl0BKglDmhq3P9APRfa49IVZVazZgCfMtpDdBzeg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(6133799003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(10067099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7unhfR4v8C1hnGXmGHIyq6LM51sm/jd+mf9wEDQ6HrQaKhPdfqQeBAyPh0F13KBfCAsM0FlxqyGCmBwlvDmvUVLbuY4fbsjmahOEbVkWLS0MU40ngXzXcrBbeqBMAHCBvt+m+pKnmQdVzg0e24tAm/6CF7ydAqfA8ltNGoGk1IKRKcX2ZGRh3vuYb8a/nx/55w0dmie2IvI4l9NDv/6E2UK+e0PVW4DUe5OQueIPZmCve7Jo6WuQf7pgXNXxo9tDUvYR/c1yGaJpAp1SHo53Pr9jtJWZJ3/lmyHAOhEMO2pQX0PEUwEQLS9S+pp4U+oVyK+MPEKL4gDu+Gx9u7RAKzJkFR9kzhSH1xhvexoMm0qtv4dC5+LTrgUFKgKs0yJEa87laQBL0Z/pANMwFbRriEMpeUQJIGscHcs6O6DxleD0HONOt5mr4nOt02+RBBYo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:30:35.1443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac0f995-3f2c-456c-caf5-08df335cef2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094

This series fixes PTP synchronization races found by code inspection, and
a related frequency-adjustment bug found while reviewing the locking.

efx_ptp_start() resets the driver's cached current_adjfreq as though
MC_CMD_PTP_OP_ENABLE also resets the NIC's frequency adjustment on the
MC. It does not, so the next time-only adjustment reprograms the clock
from a stale cache. Patch 1 removes this reset.

efx_ptp_pps_worker() and the SIOCSHWTSTAMP path through
efx_ptp_change_mode() both call efx_ptp_synchronize(). Concurrent calls
can interfere with the shared DMA handshake and the shared timeset
results, because the MCDI interface is released inside
efx_mcdi_rpc_finish() and acquired after the handshake flag is cleared.
Patch 2 serializes a function's synchronization transactions and clock
operations under a new mutex. Patch 3 returns the PPS timestamp in
caller-owned storage to prevent concurrent synchronization from
overwriting it while the PPS worker reads it.

Tested on two hosts with X2522-25G NICs cabled back to back at 25G.
Both PCI functions share one clock.

Clock operations on the function that registers the clock were run
against repeated efx_ptp_change_mode() -> efx_ptp_synchronize() on the
other function:

  hwstamp_ctl -i ens41f0np0 -r 1 -t 1
  hwstamp_ctl -i ens41f1np1 -r 1 -t 1

  for i in $(seq 150); do
          phc_ctl /dev/ptp1 freq 1000
          phc_ctl /dev/ptp1 adj 0.0001
          phc_ctl /dev/ptp1 get
  done &
  for i in $(seq 40); do
          hwstamp_ctl -i ens41f1np1 -r 0 -t 0
          hwstamp_ctl -i ens41f1np1 -r 1 -t 1
  done &
  wait

  ethtool -S ens41f1np1 | grep ptp_

                                without    with
  ptp_good_syncs                     400     400
  ptp_bad_syncs                        0       0
  ptp_sync_timeouts                    0       0
  ptp_no_time_syncs                    0       0
  ptp_invalid_sync_windows             0       0
  ptp_undersize_sync_windows           0       8
  ptp_oversize_sync_windows            0       0

The undersize counter rejects readings as implausibly fast rather than
inaccurate. FW reports a 40ns minimum sync window; without the series
the fastest readings sit exactly on that limit, and with it they sit a
few nanoseconds below. The shift tracks the barrier in the mutex
acquisition rather than the serialization it provides: an smp_mb() alone
where the mutex is taken reproduces the counter on an otherwise
unmodified driver, while a plain memory access there does not. No
synchronization failed: each takes eight readings and needs one to
succeed.

End-to-end PTP sync quality is unchanged (tested with ptp4l and
phc2sys).

Changes since v3:
 - fix the Fixes: tag in patch 1 to 7c236c43b838, matching patches 2
   and 3 (it previously pointed at a non-existent hash, ffe9554c17bf)
 - expand patch 1's commit message to describe the user-visible effect
Changes since v2:
 - add patch 1, dropping the stale current_adjfreq reset in
   efx_ptp_start() found while re-reviewing the locking this series
   adds.
Changes since v1:
 - document in efx_ptp_synchronize() why a secondary function needs no
   cross-function locking.
 - take phc_lock in efx_ptp_start() around the current_adjfreq reset
 - do not take phc_lock in efx_phc_gettime(): it reads no shared state
   and MCDI already serializes the command, so _efx_phc_gettime() is
   gone and efx_phc_settime() calls efx_phc_gettime() under the lock
 - keep the comment above efx_phc_settime() (Edward Cree)
 - add the test results above
 - return the PPS timestamp through the caller's own pps_event_time
   rather than adding a struct.

Alex Austin (3):
  sfc: ptp: drop the stale frequency reset in efx_ptp_start()
  sfc: ptp: serialize host and MC synchronization transactions
  sfc: ptp: avoid racing PPS timestamp updates

 drivers/net/ethernet/sfc/ptp.c | 108 ++++++++++++++++++++++-----------
 1 file changed, 71 insertions(+), 37 deletions(-)

-- 
2.34.1
