Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11428686;
	Fri, 24 Jul 2026 04:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784867596; cv=fail; b=Z4yQtLMucXncYs3fICB8grUmZyvI03YZS0T5gmOA1/F7xmSKxMbP5Pc/KOZFFbOff5CiNibHAnXBHIK+AoWdUaOz5Ya+EkjNLL3MwAr06ChBTpoCeYrpsT1Y7DGshVzXIO+hf3udBGLUmdv9VCL8iAMtAIlRzxpKfcr4aVS4WP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784867596; c=relaxed/simple;
	bh=AzfomZOeEtbNRxEuaMcWHp9Z/VVhexxiUWgxzt6C7Do=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fEcABSOHTQKLE+o9L1NYH1vFhGHX/Cg8H2Ya48uljjltcsEA40qO2nCme9/KWXduJUB5Bwr5aotl9exyTMnEYeeVWj2aAtmGIpIuCRxo0qB6oaqBE42FY0qag7PD1FPljmN6EfGDAKO+QLlGYOopaKhgrnc70fwW0+LfW2HklVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a0KErEhg; arc=fail smtp.client-ip=52.101.46.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a0KErEhg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tril95kspwlRV7+pZKaVq/1bKh5K8MiwsAccnVBq239NYpN7rQGbM40fxW6zJpKYv3uUl7glCIYQhN4gWJn8qYzlcIjY7ldYCgXRPP5bf32GEMUr4t2luI5CP+7Yv1aSevsZ0hbSwaPZzsSvQGc4invciIKleOE1RUJNiTbBFc5LgLmzdLEZxAssVxFkr76mRpXbP61gWjd1Wt8StzUcDvrfO9kkQwJx0qy93h4IxoszUAFGvHNqRYQUL+l30AFw6/0rjRXAbptXsoEnnYpgBgL/WBXwLzw8OYChvLo0XNd9gkE6FneTOtI9L9pSQ/xjDxUNKfBj1UNxxRu2SQ8YTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02kj7zXFkiG4wEQfyuppn7t2c5AncRc9N7W95hM7k5o=;
 b=G/MaL0QOhfzVEC1nFd11lTFnIpq2U6x44s4nYIKP7IRhtZzwK5yy62BnT/J56TuPhCVOHXbNfBbTBf2bf8OaMZsyIpWlihwRr19BDolA9qg+YCxPV5/BMN03x8AnPK/2FpkyMYAKCf372B04bO0MNz+SErg9XTcxagfOFQ/LUQtucuNleJkxLWUrrYKnfTOb7JRWKc71nSCjkpbg3ryca8tbwoKHO2y0EMg8fA+L4Umkjg7skLMYprUspt6ZFBOCHxvPk31TttZAkoTpvlierTD54PMPRgVXPVfZqzoLv/YLGW1GbWWGiSr/WJ/Fdr9eJMRI9tdfR9BTTit9O7Zwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02kj7zXFkiG4wEQfyuppn7t2c5AncRc9N7W95hM7k5o=;
 b=a0KErEhg9Jsn4+SCc3TinJuymRCzfr2Hb18x1f5cX2B1s+dCAOUEl35OMim5YYnoAtFGIC6voWR5YKolwqUS4d4pU2LWinrhGdtMDg/4qabBu98oBgmlS+H861zzpYkx2lEf7yMXLgAKBd5yp1fdj2CHE7Py3milS+ARingR6gw=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 04:33:12 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::18) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 04:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 04:33:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 23:33:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 23:33:06 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 23:33:03 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/2] net: macb: fix ENST configuration for all queues
Date: Fri, 24 Jul 2026 10:02:55 +0530
Message-ID: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfa2ed6-077e-4a27-1d98-08dee93caaf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|11063799006|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	CDXZLnB5aIIDa4pp+V+l8rAIuES5piFqSBIfO9sRKpDYMG3N0ujnHtg/4Guo27gbInb6K5+EB21v/1JyLjdQHTFEBLHi4C7nMiJIfLPoBjGpbcsLiUeNVi8xC56a0nlRkIecUxyWQ1F+rOrgHuOg5Fj1Uk4YsBLJ67O8BSBue6ZFH6hlH7KFs53rG1mJ+cMup7hWNIAcD2KLpbKTzrKZklcFZwsIGHLg0d3w11RyCEj9r+e/23jeiiJO4uFrVuJQPYON/QyPwE7oIV7YDVnb0OV3YnHZSuDhgRS7nAecv6A0sKTovZKfyG7KAhvlMAD2sXHrwP7L02IvCzswZINQoPwE8CP2yHRW5C7lTXmoiuhAvJI4+JobiIC+nh/QSmeCgfX4TgNW1mH1Yz1UnxQ5X7Z6EwHEKhsmmTzAZ9XDG+mXNVIzmUwc6s7UVpf2gr26Dc2zeWpmDoGlLtPGx2zt0f7qoErDXi9x2nEhLD5SHlTpZ2Gjm52kB+u8tBEYutdrw6hkDtT+uxa+kT5V4X9EX6/IOJ2778EfqITBMoyPTvXFB6EcVGkQFzZWeEZOJOFA/GVspS5js4ooQkehKudHelssoD9nDBLtoIjJ8jT0Mu4FhffjNKqEwFS2uRaBhDF7evfU7Jkx/mSxwZpY29doV4vm5c7EZMbkxUlu5t+kOLluRcKhkrN/sPZbr8ORpSRM2++bAS35foQTMK8N/wu1DA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(11063799006)(18002099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	grXfPX39ojJZHwUHGkHKPVKcFbqhYCEH+k32b4CmTgkXPuGiFLvVIUKUe/qMMq8fmWQRYkxW0gXVXzdtuiz+bWQbEEYuIo5wqNfbldGj40Zp2u2l/w29PdpUDknkoqEvCTYI28zrT66aAGK/ramLPPRVSIG8AuK0o8gAt4noDYA8uWIkG5Wm0UGIpwd5iVGZo3Wumk6QMCkLJ3KMDBREXo1Saas9j3Pfos65v73PTPs7PKo386UhiKwyQ/gHTnd0FCbTxWe1uw/59DuRmVodkDdbVoLTLutpQ7+3O2ySExq7n4zj8jxukcyCnVgWiUWQFAQ6HT2PI5zUJMTQXOYwxkQU2TTSRF5kFQkUqUsL37uU2eC93s5GI6QzFq+kOql5VemhJxim8HCMH05k07f62XW071hZJGorjtD8Wc16dJcw9Qr67EoAfGqaEASSKuch
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 04:33:10.7669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfa2ed6-077e-4a27-1d98-08dee93caaf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

This series fixes the ENST (Enhanced Scheduled Traffic) queue
configuration in the macb driver and removes leftover dead defines.

When a TAPRIO schedule configured only a subset of queues, the driver
left the ENST timing registers of the unconfigured queues at their
reset values, resulting in an invalid setup. Patch 2 configures all
queues unconditionally, zero-initializing the unconfigured ones, and
derives the queue index directly from the gate mask instead of storing
a redundant queue_id.

Patch 1 removes the fixed per-queue ENST time register defines that are
no longer referenced, since the driver computes these addresses from the
ENST base offset and the queue index.

Vineeth Karumanchi (2):
  net: macb: remove unused ENST Q0/Q1 time register defines
  net: macb: configure ENST registers for all queues

 drivers/net/ethernet/cadence/macb.h      |  8 --------
 drivers/net/ethernet/cadence/macb_main.c | 20 +++++++++-----------
 2 files changed, 9 insertions(+), 19 deletions(-)

-- 
2.44.4

