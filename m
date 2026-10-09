Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D56511213;
	Fri,  9 Oct 2026 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570778; cv=fail; b=NoqDtJX9CyJr3G1oIvdexuZjshy+bhDned/EoKmefbBVlCyDgKGYER4UfiX75qHbO73UH0ul04FWL9tAJ302VUG8LVsrcn5qqYBbSzUMSe8gVhmHq+JgpVk9FWuBZkG7mqJ5j3zoO0kva7RadFzgWKsfpS86XzdgK190MpI1THM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570778; c=relaxed/simple;
	bh=4W6GWdKOzKR8o/cc6tTPFxIhO71pCRQ2+OP7C6xcVZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZCm1kGb2k8zSJOmFb0FL7V5BU4E0sYJ7Iiq721SToIwmgSOpfc4/8rXi+sxjgD7obGa84Frhf25zV+i+coME+VHq2srN6Cpr+MlnWpuajV97v1s7Ruh9GXcgqOPfnt3fXtawndtQUP6ftTKCsxnHhygqyQM+HvF5Ed3Lb8lvELo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lsu4NaV1; arc=fail smtp.client-ip=52.101.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lsu4NaV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfKgoGBP8tOTQJODIazmmvWvxIEljcxd05gYqVjp9AshXxOBPspmqU9Q9abx0jWxsQPJgM1mtYBKIgXt+DQhi+QymqkohQDm+NrTERavJDO6Ht6Lfgme3ZV88j04Bptw1eVHfaUPQOtfOA/+FpfuRpjgZyoXUMi8NFDcwew1hSEFgbMHjM1eDkM0O0RC3DTY3EQ5hpA0JIZPNy2WU4wd0PCrAEfg76MySwiYGBFXttdfq7nPVijnViE4vcBZdsYqJq0PW6xjK1pEqz1wqYitLfYEkyYvwuDnl8KeWEr1COFGuuSBpOmsbVaNUDbus+PqtJCroK5ELQSwKNr39l67fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSlwe8gzGKHnoGKJcOBPGUgpqmsjquzh2Sq5tTuVTvw=;
 b=f8RUCqB/IBM/lHTaZlHy8gkYGysi8hv9VWYMYexfOJoMAPHCS7N5aDVtYAwVZGSEAlvwh2XBHDyzM0bSVVIeMp+vu+OtAAeEB0HjFqueZkwCjS3RLqYCXibISNg7Sn6v9ZjE7q2w6a0q3EmQWww5CxqUpaectzwuctMf52eBIAlf6n1vSA9v4y7C714FtHq4m5cwxdZkwQh/eaTZ/nlBXo4vl5Uhe02AHizd4U1OeRzTFK0A7RoXur1BMDvpfCR9PtAIqoQ8+856e+cRqL1BI4L32+NszCHpnD8x7eXWBkvU6FHFW0PJdi4J6xP2tytgqmaAHIyTuBNQOH8OClhsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSlwe8gzGKHnoGKJcOBPGUgpqmsjquzh2Sq5tTuVTvw=;
 b=Lsu4NaV11MCQcNdBunLRGXHQxaGrI/urSof3ttfS+QgD/z9v73WCI06Vj7CeyQDo27X6PzWTp6VDBl1FhtZ00s6I6JLqsyYeBqwGPzSd5fssCdzBrSMQ3oxXxbAB6O6rflJDcDN/kwIJc16jCa4b4pSckAn6KUJtnb17GlOKTQs=
Received: from MN2PR20CA0042.namprd20.prod.outlook.com (2603:10b6:208:235::11)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 18:32:50 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::87) by MN2PR20CA0042.outlook.office365.com
 (2603:10b6:208:235::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 18:32:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 18:32:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 13:32:45 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 13:32:43 -0500
From: Alex Austin <alex.austin@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <bhutchings@solarflare.com>,
	<davem@davemloft.net>, <ecree.xilinx@gmail.com>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<smhodgson@solarflare.com>, <alucero@amd.com>,
	<pieter.jansen-van-vuuren@amd.com>, Alex Austin <alex.austin@amd.com>
Subject: [PATCH net 0/2] sfc: fix PTP synchronization races
Date: Fri, 9 Oct 2026 19:32:38 +0100
Message-ID: <20261009183240.1898762-1-alex.austin@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 62767190-926b-46b7-70a8-08df2633b943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	GQCJulGQ+t2oAxjM+HN9i+JtlUnNYjP77kH8DUFkPmKaOxLCgOX6K+GZMWkn3eAidR9wpxkIRG2MUTsBRsq6qTSsej/CbtFeWmODu+02E8jI/qfu2bb6Wvx0qdhPLfsFBU9Cjvn9XeB6XiiCtn29M4btokZ3fEhvaw16I6aY23yQblz15D1zA6Yq6ZA0yRYQf4oJerxHxiY3DD4Fgl8beVQheAeIg0GRTohjFcSErTs9I6iI1bJyYctlOISPCB4mkEAkdJm3UbPieo7gUstV1qzNFudn9WeW1awuOZqxXbzslZLksOPwjkEyqbDqJHd1jH0T8AP0bl4ZaLIx/uNV9FfDhFMCjbGq0JBqbJXH050dlpf5CFA07LH076YJmNUlpbkWn5lZw/qo1dr/45cDASEmpPpE+iteXIBvy1OdjJ0CXSM17nZ1MW7IXEjGk88yT6i9ps75SOeQXxhArCu8Z69g85Jg/dABA5o2k/8r9nzK0FXgXWSxoviVtiPzPRkpV/HJYwHtTTFyoWD6731ez7CbaDXku70f9TNlAohErsG/GPPrljpdXAmboiBfg5h2qq+LrMH+SZh9j0zCy6HPYilaWExCGNkO8SJVqjDkxhZOqpZmIQUHdxrYBNVVzvAswaqNyH3oouvB8OAXK3RZe98KfIi/1YZK4El8wiXPqNY23vA9hJOlih+80edFuargpG/7g75ArEd+0gfMOyNfRw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zlCJXIVvFrj6iG0v0Wdh+w5tsXsIqI0M5aLNqaU69a9rrQof0H3df7LTFPDskp9GX9iTxWfXzHnvh/CtWCDY6r1gyzPSTCFXPzac/RoDwUG27bQ4hqUPFx5FmW76wRrYC1un3KWR9Xovc0DlAeS9yA5YtNa/RTgWseWrGVF6zlXQ8RgyH9Zrv5t0NUQiHQEWyNI/kiCAiILEhiDt29r9JIGC90Vh6teZhEx3dO9VJNyUJldQaDo8xQOB/qYYkN14XqJSDqfpuz0/jZxYwgJWHp71nLeHA7iPYR/T0jNZ2nx4qyNisJmas951nscE8Jiy50CVTVi2/lZxU3sjS2a0421+ZlFo4zsE9nf7t4jRbaDSxG7BaCixyJkTKAxtjBVekJlxlRlSG4Jfl4CF0kGy3oDGLgH0UdfRYD+dJz9cb0zpcIbzIQpEsR1RBNRfmKPC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 18:32:50.2846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62767190-926b-46b7-70a8-08df2633b943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

This series fixes PTP synchronization races found by code inspection.

efx_ptp_pps_worker() and the SIOCSHWTSTAMP path through
efx_ptp_change_mode() both call efx_ptp_synchronize(). Concurrent calls
can interfere with the shared DMA handshake and synchronization state.
PHC adjustments can also change the clock during a capture. Patch 1
serializes synchronization transactions and PHC operations. Patch 2
returns the PPS timestamp in caller-owned storage to prevent concurrent
synchronization from overwriting it while the PPS worker reads it.

Alex Austin (2):
  sfc: ptp: serialize host and MC synchronization transactions
  sfc: ptp: avoid racing PPS timestamp updates

 drivers/net/ethernet/sfc/ptp.c | 136 ++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 46 deletions(-)

-- 
2.34.1

