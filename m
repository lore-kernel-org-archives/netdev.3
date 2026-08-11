Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A7D39A4DF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477863; cv=fail; b=uyeHK+yG0n5i5mrn4YPxCUomMGGoXffXR90Vr2O9LSvvYYHdvTvuLWusSIMmMu+uyfgTyct0/NuwQkx9MU+JlJqsG2+9ywbFZChrkcd0TwPvTN+8SLJCQFVc3YgbtayDaqT6I/KA+UQaq6p4nLdAXZUOGWFxwFP87JA0C12ZkN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477863; c=relaxed/simple;
	bh=qw8HW+JwyBMIQAfE9po31zlpsxt1Esp/uLcP+49FH4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cen+ox3g7IHwtHlUUPtqRxI+q9tzhrJW6WlU4XPxjFDkfTZxwOSl5A+5d3RKXXjNYmWpA7ggyo03hlDXnr29Vvhjnrvlxli/e45eIPVFFdemQrAaYD5y+HL3gKfxGCj/Zic2Rg3QQGJArsm2Gqvhm45EEKKgrGW5kT0FsSx33Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=198eBE+Q; arc=fail smtp.client-ip=40.107.200.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="198eBE+Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIv/i/IL/vbZmQmWqp3n1F3nug7hO07C4n3KBLzI4SEcSoIXvyG6cuI5c8zUTlPDeJEvKmpzcr+iQhAisetwMrQa85VZriEoLcaN8iQYoYEszztGTaF+e+4DrEhG9DJZzQUz+tL6VY7MYftl1mDzFjN2rkrFqNOASnId3/xA5qt5AnatfWw+L88f8ufZBvY68MA0jMAt284Kdi+7lhAW9JlzWzGHfMYa7cOs3gnQkPMvlzW6P5/0/c0e/MI0V+y3YfLceHa38hgaMSlF8LeAzTbDyQNK3AdP390xRWTsmW4luCAR2Uy44dcT4rdoJtErvAtGiPPu+PGcMo11/4FP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsYiWWH0pIZFo+rW6B8VeYDjF9CUvGxswKlZbmtnBuc=;
 b=QVS0dywOGnmO8Ip++wmZ1xi/f0NmcB3WuOM9IVUM74iORFfFNvUleDhVewsLkAVPayXeZkW5BeUEYelHTux/4r1LJIZ64kenxxl2DFzNiwHAXtIepCo8eETIxyGqyQ7I6q1v5IbgqU8LB4Av5w4JJ47v2LgJoI3G1aNaUjTVlGZGaQ0rJJ1pNMHM/IChLNpUiD3eYMR3NqZBZqtmJWL6BJL+iHFzTcSCrTIc+udGIj9hQMMAlvVgce9GqkRTyuXsstnJWMs1wgIUc4+tZbSDnmLCGPnpqVkm+ZoKQBEVrRjeZ3yF3IZQ99nQwy0puZ0+jsHkqkWV2djzqxVggoxWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsYiWWH0pIZFo+rW6B8VeYDjF9CUvGxswKlZbmtnBuc=;
 b=198eBE+QCRTHqb3jwtINzYBxxQHTSvwk/t9rI1WirsW8J7eUKskCZTNLEiHPQJNlGrwWwQBHR6DKfSLq+WkSqZTBH8LC16AUUm3Adg9+bdNma3k2PV4cz7VTEYmeKuFYJviJDVNx5PaDju3vMu1Pu1ryy2ze6+aIxlsN2n66B1w=
Received: from MN0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::9)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 19:50:59 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::aa) by MN0P220CA0029.outlook.office365.com
 (2603:10b6:208:52e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 19:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 19:50:58 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 14:50:57 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Prabu Thayalan <prabu.ponrajthayalan@amd.com>, "Nikhil
 P. Rao" <nikhil.rao@amd.com>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net 0/2] ionic: fix completion descriptor access
Date: Tue, 11 Aug 2026 12:50:37 -0700
Message-ID: <20260811195039.1315045-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e38774-1cc8-496e-b346-08def7e1dd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|11063799006|56012099006|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Vo868pn4TGbyetArXv1lwita0HV8Xq8kzZzRd5IZ5zbG5KV55PM0EnDxiPgNWUYA75KKI6P/aImw2YmljafVK2qcsFhFbrJgQhcDSCkzXm3sZmrKcdVxedEJ4UMz29gQHq8T5XG5xX2ET+cSwQFyk16icZbg79MDkWgBBLIkWPu6U9Ryorl4kfvTR8Ris3XxsViaCoiUNk38HZbO64Uxj29iAMg2XURHJK1hUzsT5LV3MatKo/zizY4PttTb0b0jnE3eoDwalBsAeswPRZcoRJ30BxRlQmXxQ9xfoELIvI90BxQHwqPvNoMJCq9EKkBSClclb8PWZdWlRYlOF711tILhfD7+HD0BNxI6O/CyTnDp8jZYaRP9dA+K9H3YbqhYDwvZFG4NXw7xlBLu5YpNFj/U5WjPooiDn0IXJkWb+N8i+mUsKS3JGIymZTpCn541WfY0MP2dlCVO3492Yydcl5W4bzcqg9B3sFWF0pzF6Gv5qdCyR0HYSMsAUj46A/YRWJRv0Pb60viClgkYq8cCbVodifQm4ms7uc2taNoZnemEtC/rYgbDR1+NhiZJir24zmA56zQluvYofLFEZJClDmL+8uuCgra/buQ/l1IjlpYYc3zEoAiE3+r7d9++TSlhoR5Q3FbdlqIB9QJmxIsSu+o5DMpxoKHUOu8DbI9aAdZi5FEjHBSohbITIr0zz+N8dDed/w2iYaaIs9n+KWApgg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q6jqoR4UHFgLQuxdDzSXMaKZIz/scbyAwn2hWGjEnDQPgNzw2uiuILPt326XyFSpquzwp+tW3HaASj381VtmaEhO60TqsfHu/xX5DcS+jM68tU2kzPMcHkhN6vloTSxCZwXU7fUc5g0rqmgTcZiFQ7GdXSd8J7l3tvM6nH3nvhwVxiAXMRGwj98R7FgOPRRquBlH5S4qpG24pLpEBxpoeiyTodrK0UEhSSTjwLfqZOm3CdCcCZsH+TTFST0PAuuoFOuAf/DqWJpxgeTHFOZm3a34S7dGdYiel8Biy5gPf+ssJ6fuGDJCTyju3uCpf/qoJ02FzK2h2ZtguqqZ6egiLRn/PlEwDGVsRLK9pqeCzUX3rSGQsiLvQ3HbG7t7iu4wn6hp2vGwd6Y2N+6FqkujhqB/LDbETHVtKrNsV7Xz53uS5u7RXp7zd/pU4n+59w26
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 19:50:58.7352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e38774-1cc8-496e-b346-08def7e1dd6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564

The first patch adds the missing dma_rmb() between the completion
publish checks and the reads of the descriptor payloads, suggested by
the Sashiko review from [1] for the second patch.

The second locates the completion within its slot from cq->desc_size
rather than a fixed stride, which is necessary when IONIC_Q_F_2X_CQ_DESC
(double-sized completion descriptors) is used (e.g. for hardware
timestamps).

[1] https://lore.kernel.org/netdev/20260507155928.2537928-1-kuba@kernel.org/

Eric Joyner (1):
  ionic: add missing dma_rmb() after the completion publish check

Prabu Thayalan (1):
  ionic: fix completion descriptor access with 2x desc size

 .../net/ethernet/pensando/ionic/ionic_main.c  |  4 +++
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 31 +++++++++++--------
 2 files changed, 22 insertions(+), 13 deletions(-)


base-commit: 53658c6f3682967a5e76ed4bc7462c4bdcddaec3
-- 
2.43.0

