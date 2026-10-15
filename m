Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19874FD799;
	Thu, 15 Oct 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064498; cv=fail; b=WvdBAx4CsQJULWZjz9Rbgqp77EImesyHwDRQMnsdozukffwYPILAICs3LS+9LKfSqCjjzQboxtRu31MxL5u59CXOAaxpHDByl6NVNpZOaPdl4fyiGWdqfDMnlHE0IbVyHXZI2xgsHtQOfXS4PrWgm3H9555uCeWIXl49N9Mn4pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064498; c=relaxed/simple;
	bh=h48y52L0BDrr65uLN0l8dlUzL4u2d2V034ueU9LjmbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XJI/PsFY8YblB7J+AlzC2sp6C71xJSrjOtUlCdYvXh7ZbHcPSA46uKy/t+i9Weg+vcB/0x0DxJ/JPEUKg2Pzlfse72RpKGLuC8rvK0eSm72BUeT1x6iTUqsULB1wzKFtDiW8HWoEOuFCPETWFnLAOMhiyBITgMLcCEpeihLIyng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jvcuuug7; arc=fail smtp.client-ip=52.101.193.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jvcuuug7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGncNi2vP/FUV/066iHIAx39xi0Q5J0/+6KM4JFV+S7ciLAqSqn+8iUcSkbeyKsEMSHdJVhhe67qnQ7GukiqNGvPAOgDrJB658dBAtmegpnGPeKkVSL6dzGBnFJowNmxuqP8D0620FE+6OCzdRCvw1Cy8OAW8s2G9+o9qAeA2J5tF+MhCwi4fE4H9Zm0Rth0JDZKNwfc0NpHH0U1AgNFBHGcXq1u8FOB/wTiLBxToXQOYtVXhuh59MaY3hvhq9129kGkM2X2UFote4NQ4IRS1tVl1s2JmKTG4crLDqPB1vgrIxTmuxmkt4gWexRSbzJGCnfjS86yLeNUikLQdFfqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FmSd8e9TUZQ6iJRg2osFpmF5ljEleLUBH3N4GUsc6U=;
 b=nZjM4D7OMV85aTu1Z58n0UELI9L+KMWRtfyEAgh0+J9jbXi43cswuziUgYNrrZ8PH4pHayA18mR2x7OMzeFfSJUn0ck+HmJH11zh+fGF3JfbwqZuSFIsjVaCfy1JTTrZLQU/tIt44wWplQADC7P74vjjwcBxlAZ6E+HjlFwYks2QeuxWZcZNOSln5tGT+UjmFPC9CvgrIYAWpNWoWdDi3oiGIAqnu5pPhf5EZex3Lkw5wH9HW+R67mOPa9vVMsosrqAxQHoQh8iDVXGzlUquo6y8+GjGI/VU+JgaEzI/O9t1rM9JLzReYYcUhWJ2eQiwboG6lUTmcwq1FjLjHIpmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FmSd8e9TUZQ6iJRg2osFpmF5ljEleLUBH3N4GUsc6U=;
 b=jvcuuug7vjWXIZDKXyz8tKPiTHvCaWl58r9vN4iqmWuc0qVDnqy+5ayreanS3sanYDH0nK26umj1WrEpLXbUoG5C/40WBEV6382gw2MrB6eg8Bd3i7gnhsDmrSRZ+dc8aaMLQ/kICkKUOTJKK22DBwOOfdoYKp1m3paI+ZTtcis=
Received: from MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::15)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Thu, 15 Oct
 2026 11:41:29 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::5) by MW4P222CA0010.outlook.office365.com
 (2603:10b6:303:114::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 11:41:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 11:41:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 06:41:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 06:41:21 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Thu, 15 Oct 2026 06:41:20 -0500
From: Alex Austin <alex.austin@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, Alejandro Lucero
	<alucerop@amd.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alex Austin <alex.austin@amd.com>
Subject: [PATCH net v2 0/2] sfc: fix PTP synchronization races
Date: Thu, 15 Oct 2026 12:41:02 +0100
Message-ID: <20261015114104.2531624-1-alex.austin@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 655ef2ef-4926-4ddb-23ee-08df2ab1407c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|18002099003|56012099006|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	orMDvf/dDZ0QSyhToy8kc4LTTiYgLc7KgRpik5MkHPDOuueozOavaZ3QGvQBZo45cNiUxeWaZLMemNvW8auCvzrUz72L4ef0vfUFCugKMbfFh1zALPPBiiucPrj6STzC9hCSzGapIYloU8k+xB0MYuLhljHlPx2bBEWOcIUb1RIRT6ZHQxPuL9qUhz08QdCS+/FLmg+o9bF06RTYN6CuOLhTtTAcQ/2oyRKHeadHmj4J/X2whdgfusZIzoY/re8lxQpksiw1JvwhBQSVw6zheu35NMXDuAuv+2uP094vVOl3R5Erd3/PCw55t6uo2L3WMBGDxuW5qOmVpY1Uc+u/9zChpcF1Sv7FB6f10qsvHDltPpYJVkQLFiGEb9Z3ckJWrkmV7c/7s3ah6WRPLGgPmnkjeUFQFmx2hfx52wJsN0sDtZHr6YQEdv5MarNHpPgN4BuUEompcYJr+XXkqljFF6tNSKkgcPKWl6nFBX8Sx++Az88HsBM8msHjz6/U6C3pJ5JnceVH4mKzj1w4sHi+6HkfFtrJOqA2ifKMSfUhRTljdoRv6fKRJIqUVOpXY1mAHeAkHMn9pHJjRFkr/SJU8Q4fKzW5WwHqYfPa9cQl4VqULkh6zFkirAzKKF3qwO1wEPH82ddDbAUYS/7L9uR9L16W24wTJmccTp3lxo4VpnWYu8M6VFV+mcztWmrlJSBYNwqhysGF4oKlDN4OY8wiVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(18002099003)(56012099006)(6133799003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fx8UiTqmqo0oqHATyUyN1jfMAlEZDjinXfz/4XPj7FdVXhaD7LYWp+rvsEboaWugIBGb74gdQGNi5npGJhYQhWe5wnPJA4KsPM6SZYmd6yQwhEbP3qzGJRKNBtibycUG+oiqOiUysGLc3LBhgDBkoohVD1M/RSVZGzaPaRpMHWeAGsJ64Nv9X2Y0mjFNhWa43dVbQU4JjbLjjI1F4XxzNasvrUKKI3IvKAKKUBPROXyh8jLTYG7uCVvfTwiqc9AY3uzUk15k9lI1UnL6dK1YOHNPxqVO/DIY8M3uymOc2ZIV8kbcrYdduNbJoWkbG0QQlEStD3n7sTk5KZ6GyJ8ENAF44z1Y56JLg2EzRdJtOwVOi8WtQBHxlE4bb2QiOox0sztxM8+OZovZ0Ml9CBDkvmTYgChrCT3hdocCo1Ias4BpGTS6r76XzI4ZY/muNZNW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:41:28.7998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 655ef2ef-4926-4ddb-23ee-08df2ab1407c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155

This series fixes PTP synchronization races found by code inspection.

efx_ptp_pps_worker() and the SIOCSHWTSTAMP path through
efx_ptp_change_mode() both call efx_ptp_synchronize(). Concurrent calls
can interfere with the shared DMA handshake and the shared timeset
results, because the MCDI interface is released inside
efx_mcdi_rpc_finish() and acquired after the handshake flag is cleared.
Patch 1 serializes a function's synchronization transactions and clock
operations under a new mutex. Patch 2 returns the PPS timestamp in
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
acquisition rather than the serialization it provides: an smp_mb()
alone where the mutex is taken reproduces the counter on an otherwise
unmodified driver, while a plain memory access there does not. No
synchronization failed: each takes eight readings and needs one to
succeed.

End-to-end PTP sync quality is unchanged (tested with ptp4l and
phc2sys).

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

Alex Austin (2):
  sfc: ptp: serialize host and MC synchronization transactions
  sfc: ptp: avoid racing PPS timestamp updates

 drivers/net/ethernet/sfc/ptp.c | 109 ++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 36 deletions(-)

-- 
2.34.1

