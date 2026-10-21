Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792574157;
	b=lFvrwpXw8irvEYXb4/jbG3aH1o9Y9qk5m7Lv22oQc17+XmuPihWkcMIBtsNR/If45OvV
	 CHfz56WiedFc5Dcn3zN+d5ViMoW8SgLxR0FTxnUfkOP1qwEoxnZYW3PgJ6Jg7F296rWEp
	 fsPUU8Nsy67MDs9xG6biwygGcHLOGYIdZ7p43ldaAjaZEeRFeS8hBAQyvIEW6wOPpc90T
	 8skIKM8TQ/Mn54hS0v115cxTcFM+OXB7SO9SSySfDSJj91CVHRJbE7bJCou6UinDRWOBr
	 hb74tFK7qJpsXOR4+yHb9OkllclHdqN4/5hDaxZB2PLsllTUVWBU33s14jHv0w0Vg2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574157;
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
	bh=jTarPnb8o9O0DvON7HF/AXl9Y7rdk+6oyXx8e2bni6o=;
	b=l5YVL2eU/447r+UvY6gBaNG9rRygrlAJ3WINvUK4shvStkhi1SyaYEPt1PYwJZqiXECA
	 ej6Ot9E2gYskT4rScdTL2y71N5Qf8EeCmmXkmqSGVNgg6kUstAbsO+g8jE19ysyWOfXgn
	 2RlSQ86xmxCcqTSL7btpPf/pkcVwdr+BRjmmKxXDygelhnAFIU5L3ODopVRB0n5SopInF
	 qQ+m+Thuq6GqowRiA0bWXp8mf/amfLqNF+zw7IPYWsSM+N0uVeu2MaN8Oe6YgT54aBHcs
	 L9GBwwTPVFh9DIYc9JcbkXzMOalNDH69j4HIIDcK6BvzCLyFVQaw2IkaEEBv/krxx6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RJi46IJ2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.20
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5A606A31D;
	Wed, 21 Oct 2026 09:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0F5A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RJi46IJ2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYqPSrQsEvt58A8+FQFgLTH1RAbMG1rN9my4zyQkJLPiFKVvp0OrZ8R9VVnrYpREPP03OR1BqhtVoN/qp15FLdOub1VuDgY/SNJkY7OfQ+fd6Ls5HVzwMRqWMtfkyLfkrYTMHhCjw9VztSM1DFVo9ocHPi/yvg5l9RNfAt8YD84rpjvfqJe0j4ch74lB3fSB7gVDoAmrrVvxyKGRGYK+EanZJCCy5/eDBsh1mMdkezRFj9PUIKFhBzOrGI4m41liG+u5pmBcpwk6DH03FBrcSFuT0rsv7f6UxyKgyqbIhFuNnC5JX34fcsTwOQco1eTCw8usK0iTLwqGYvOccgnm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTarPnb8o9O0DvON7HF/AXl9Y7rdk+6oyXx8e2bni6o=;
 b=Bs/SzY2FBrpYxPNrszbk+atnP6AzR4Gqc7Y3OXiiJ8uCPK62LnTNt18YiCdsEet/RqOJZ/Q0ywNGjo8ythpgtmXPc/RJ6EhT6tqcJrg4YDjQgkq+sgsd5QV197AlENNIYUEk3EfLbeM20EaF/wFhTX/e786xy4ypZAMJzJHoU/lqC7d8ol+dcAIMZFFsDAEDoWPl2g12+o3GG+loMdu8qeaKfKmWRfwrGGkYg4AL2abEGMPGI37XOoE/aQUQ8/OYbPyCYcrx5mZF4PgCw+iC62U7UXBP/3qy8L99/zxnpemuVdAA8HvD1XJNySRqiAS+XHHlmU+4uBYLY8yhSvPtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTarPnb8o9O0DvON7HF/AXl9Y7rdk+6oyXx8e2bni6o=;
 b=RJi46IJ2S92stEh+bgYDHdQcAk4T7ysATCaEL5mKFMck4V9vsmBjppWKcLQfXjsRmnti4ytl16YEYxmJb1bfuH7mEY3cVTWbKedkowg4yvdHMaGbgSVaphOUGIfsqhpP0FvkxI3uUkD/TmfRd1j1n7SzyAyGhKbfmSZKywariw0=
Received: from CH0PR03CA0425.namprd03.prod.outlook.com (2603:10b6:610:10e::27)
 by IA3PR12MB524589.namprd12.prod.outlook.com (2603:10b6:208:705::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:15:53 +0000
Received: from DS8PEPF000000DF.namprd05.prod.outlook.com
 (2603:10b6:610:10e:cafe::48) by CH0PR03CA0425.outlook.office365.com
 (2603:10b6:610:10e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 09:15:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000DF.mail.protection.outlook.com (10.167.23.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 09:15:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 04:15:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 04:15:52 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 21 Oct 2026 04:15:50 -0500
From: Alex Austin <alex.austin@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>, Alex Austin
	<alex.austin@amd.com>
Subject: [PATCH net v3 0/3] sfc: fix PTP synchronization races
Date: Wed, 21 Oct 2026 10:15:31 +0100
Message-ID: <20261021091534.3164258-1-alex.austin@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000DF:EE_|IA3PR12MB524589:EE_
X-MS-Office365-Filtering-Correlation-Id: d3971af6-213d-48ae-2ca6-08df2f53e7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	gp0sIaZKio8b1Cljn3iso3ZBCirZqy/Fj+Qe3ae9vIGg4qlPqno97/CrL8zO3FKyHyfZUqQAS6W/YK/hMhs5R3hNpBYjqc5wrOrFmOCESUsBp4DrMN55sGyf3+yBRVvwdf1EwwUGFy8b5ynot3FxpN3y5Mrtw/6eWwWT7ygd3/huzBP3g1/O2PsvIpz0yXWD7oeE7RZt5oNhTwF3G00fBmB0grpSlIRv6jIV2l8i9pBWjHvCrHINvkLQse6Nrj0dhHLXmFIOOZkNPi8G0yEkBOARKd8yzUzKaGnpf8/xpnfQhwoLc3HuQ/M/Con5UWb++Z/L329EkGlgVXUOUoBSuciGr8jLr8EqkkStafof6uAsR2T0+XwU8mLr106rzS8PHokB/eg2gV7kAjl35YDQQ0x69mEF69ds5dB+UqbHqPZNXuIQI9oDU0jAkNOmMZ6DYWA1p0/EzhOslEpeNv7hD4OyHwUYeRDnA7zJun7ko0ZnJs8bvakNnjiOe63Ev29zuo3f84msPBVMML1/6a7ObcULAfMboS7kFmk1jy6k70JlI/AW8fMWwH/mDOSLyjnF1H0/pRiu/juLB0j10Mu8bugvpHrxm9cnd2mG8KwbS/i2lHhTogXVM/tzDtLIJVdwawJ5W5xS+knfMZJU6d30Kw7wf481ftzVOA8c1hvDeeUpL/wt3ZsQE4WVXGzJtpIyCoDP9TkgLx6ig/dzhFk2Lg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wk7PVNeCpFuGDpdhG+KwXPNqZtkOXxCQXgFHwhxW5vlNy1OaDvEBMF5uRTqtIKOxbYq2jiSzsCubvrUtiz/sNYYugcbPxBFgIJ52atqMQvB7g0jFzEUciNl/6ecSe4C9b3tCBNvZGXQ74SDpXErVH+VUa8whqfokD5YBfjOkWFqbbKcynUVMxYtI63xiakZ5A0uEyMge5xhYKd7IFzRwXJWeGqyAbvhR+Su/ZjpeGiTOnfyjnNz8OjqWNEKLcaaiwYB+qehDAfk4D7d5LhieCwlM8H/Zhz6WIWxIQjfdn0zkq0MtpDIg8+lHjNeBHYx+AWyEWSaVe8SiW5YIWZms9cpTrQ/PzcgIgmX37Bcwc7mypkdfwESoljLj4IgpEnTkVSGtPOEiVDtVHGL4Vlr89SoPqZvavqzdrMv3lgFQpXkMrd77/ZDkDogJOZBMY32z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:15:52.8253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3971af6-213d-48ae-2ca6-08df2f53e7e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000DF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB524589

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
