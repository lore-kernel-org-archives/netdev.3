Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BDC3DD518;
	Fri,  7 Aug 2026 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096237; cv=fail; b=tnh6SVRZdu3xtxCf6/RHBevTpML2WGKqOmm/VOPeL+k8caBODKxfht+c5snr5qSGUTEDTAO0VaZJJzay4NNbdgmLt8SY2xZSdSFst1egQoORDfzW9PCc3xSpbUzAIR1PxLzANzCTSOvcJM320Rfx2CYn+Ic0jaCvCiLlxIPPVac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096237; c=relaxed/simple;
	bh=3KXoBd4kGEn9SrfJzyhV2WfQV9LWmW8vq4IaFGdNE3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QIhP3M5/BdT69T5ahUhI6m2si2Mu+PFm+IcLWbGkoYh+HnPpiNPdWsgdI/fAEPpL0f/5Ub3ylxoKNbPsTrmJQt0izyqnIeFZpY3kuMsFV07qi4UWOH6qelkLfIw+I2ROiY6pWhuRSnn3fNP7TAWiXkLKc1SvFtL+Uig+NHg+UMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2J6qst6V; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2J6qst6V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ax0Z3Z+1djBPKhJ+KsJ/zy+fbr/PKwJIntRQDnn406Wke2lPkHBtFx3Pt7FCoSm6V9qVoanThJrpxJKSobM4FdDMY+mBhRVG6cbPuGX8Ew/MltXkH3365qwterrkvY8wwJ9ngMXzCh6pK5E5sz4HseW0jpOpkdX/aHsJ/g/mAeW0UYn5yEeCG6DWpTUZM/stiHtXjL/n9rrahD0QZ1w0JJImGoQRMxHlTu7I9zm3HX5whd/mG1b4N8U5/xyukua6zrfnK0CL55t3v3t1gOaavPV5g0vwj1cESCgWuLMZamjxQxJ2dEG/rbAAjTPTYoCdemF3BWYkJPW1cNt+J3MZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IHU6Ys4rWlsSKRWlCgEDWlF2ikexkh/Nh4oGrEjX8Q=;
 b=N6IRRPM65Vp0SGHe9A8fCB5n59Sr/RAHo23rV9q2V14xcGCWfq4Hg8r18zaDxnwrYoW6kp0sP8dnRDHS3w4/Ok/4U5cnlpXbg/3r5/O7KxnaTDZ1tYuyJm1PQYYpZ7uc8RtYwU2pS5EdWON+67kFLr+saBxP7Qtg++vvMGFmd1wG6vhjkFtL38bqWj08VpFRgvr8Kow5hE52O3V1OSxsTJchoShcYxcscmDTY7ykSfhp+RqPDfAf94cqiIgaNNd6jZTrw4gFhDM/5a809CR4gjMTajbmqE2uNKad0xeI8Wp6Lq0TOsaFFYiWWRTcnuXXk/MkTw8mGvNyzziZaCbDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IHU6Ys4rWlsSKRWlCgEDWlF2ikexkh/Nh4oGrEjX8Q=;
 b=2J6qst6VsoNUSjPBT9XPU3aaAnRcxKY7XxuCggKzi4xvEG6Rke1GCdylL6zYohV9SJSuUVJUAvmowxnnJDJzFhxVzKQUVulSV5p10tMTsXWrI8oWxLGWXhDvhr01XTv+Z2Ez5JpRYpH33ZNBjlw9//+0Z/GlxjK4aEQCHErGeFk=
Received: from BL1PR13CA0391.namprd13.prod.outlook.com (2603:10b6:208:2c2::6)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Fri, 7 Aug
 2026 09:50:30 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::31) by BL1PR13CA0391.outlook.office365.com
 (2603:10b6:208:2c2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.4 via Frontend Transport; Fri, 7
 Aug 2026 09:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 09:50:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 04:50:15 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 04:50:13 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/4] net: macb: Add TSN MQPRIO and CBS traffic-class offload
Date: Fri, 7 Aug 2026 15:20:08 +0530
Message-ID: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.44.4
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: e1869518-cad3-4467-6737-08def4694fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Hyp11WyqyBSxbPJeSSd8U1LubpCfIQZwvOQ/AYrHW1GSQcy8P0oOhWVyRZQiZO/8/RBMT1GdnVEwODbVMF203HXS9kBgGXP8pIngrbFXXEMX5CuXIIki3U9Ml7m0Om7UKFKjIwdBT50tNZ1q6vNI2t633ZPEfuevfedh2lHUTFWWUs42g/I6j8dKflVjLTG6MnSJlVXv9yez0Jdqd4qts62ReIoS6MdTHkL39Yw+3ZL9+nmCfDkZPg/Q7xDt1tzovLbyM/HVbC+kU66O5w3EHGVKKy4FxU5RL89o1L9dstNZNU2xdrN4ovOQm8fEFu3Nis61+8Qdt0ZlOPdRd3rm+jD/VaXdRnzhaV45qythmZiXg5lcEhjV5ky+MKtcn5NaejeipqCAGZ7vFsJudShC/3iho59LPcxmo+hr92EuAQcsgsV8p9QsdSGWyPdSYMvIsNG9Fp8Q/mHtPP9LDaWtv8jx38MC6f0pNI8hDt1mb+aHNMMzVJcdnq8tTL1MwIEJIrByaYTQtuwXYQq5BUNvto7pWZDhXtPuNBli60CLxy9fml9pBNkL0582QL1tPhHJowpeyd+ByxtOVgJV9OazdlpCbvEfxQ37zjPHfKGoheoWXGGkHF2nTrW2ztLw7EilpqHpwzdtRtwLjbi0RGNDZP8O97wrwaupt7zzf21QXiTgyzapidMYfzMpTvi8nrHH34fkTGokQAkEi+XzoYMmBQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gkVJ2d2sNsHs713/BWWaviO6BRf56xtdhO9LhMP7LQix6AjoDZoBvdsR8OwAhuuEksWF1qysQA8jyxTecQHBGPAReNaxew+AUHSPBo7tGPejlfIN4rJ5HYy1ZLCnZz9cK9YawhZp5XowvFMrvoWiOnOhn2/5ywhYssQreI0con2A2EWBo2tssIUt3j+YOE9mQA56SEZDLJTV1OexyiW1VfIRIUqQZ/r7BtV2hpdcDrfs2C+WchIGoI1b1pOMrW7KAsv/bAMvMpSNs3Tx5JYUfAXvHRK0zPgG2de/bIZeEkRTB9m0szeebJYkXY3PW6/+ClO0GNB8MfGds6CkVkqEXLcmQNRFZBr82tMX+uRaBmeZkuo0Davh+Wbl3iL1c6VZJRhiTy8x+EyBz48+KGjWfRvuwDe2x57qsptH6j/84uXtrO9r6b92jovFeF6YCXYd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 09:50:27.8678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1869518-cad3-4467-6737-08def4694fb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255

This series adds TSN traffic-class hardware offload support to the
Cadence macb/GEM driver, building on the existing TAPRIO/Qbv
infrastructure.

GEM IP versions that implement Qbv (e.g. Versal GEM) also support
additional TSN clauses. The series first generalises the existing Qbv
capability flag into a traffic-class offload flag and centralises the
common ndo_setup_tc() preconditions, then adds two new offloads:

 - MQPRIO: traffic-class to hardware-queue mapping, delegating queue
   count and overlap validation to the mqprio core.

 - CBS (Credit-Based Shaper, IEEE 802.1Qav): per-queue idleslope
   programming on the two highest-priority queues, with the idleslope
   register value derived from the current link speed (full 32-bit
   range for high-speed GEM, port-rate factor for standard GEM).

Patches 1 and 2 are preparatory refactors with no functional change.
Patches 3 and 4 add the MQPRIO and CBS offloads respectively.

Vineeth Karumanchi (4):
  net: macb: Rename MACB_CAPS_QBV to MACB_CAPS_TC
  net: macb: Move TC capability and PM checks to macb_setup_tc()
  net: macb: Add MQPRIO qdisc hardware offload support
  net: macb: Add TSN CBS TC offload support

 drivers/net/ethernet/cadence/macb.h      |  11 +-
 drivers/net/ethernet/cadence/macb_main.c | 209 +++++++++++++++++++++--
 2 files changed, 206 insertions(+), 14 deletions(-)


-- 
2.44.4

