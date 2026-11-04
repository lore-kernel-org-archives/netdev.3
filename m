Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793827214;
	b=hWkOLwgq54pnotsCdXfVgdbSFY9NId/f+RG3/vOi/18tcODZ7MRJuB8/CavYRCKuRT0u
	 4lg2pze3mnZwzLDjsrrDeH+JA9vkCNFnjMHqBJjcHrwYATG1UX1GyerQTudNh37zOxEwI
	 m2eKP2vSxqCB0HC59NqVAx2IKxhBySRZkWJ2iIfbfvwWYYxuWGVstsqyYKN5f8/mo14Qx
	 E1d/6AoOAicYv4eCdSn1DZJ0zTzWi+jQdMvBUSv0RIdZhnGF+njmZ7+Fw9WMomzJ4PMEC
	 e2fNbaZxHKlm8w2eN/yGVvataZqaKCFgCeeshWi1RHsTSM3NYxmw+qFqxhIdLFePEHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827214;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=rBo+nt0mo6zbRPx4RfBs7z4Mt5gi/enPiYSxuGH5yQ4=;
	b=G2b4hQ3tmLM4RvMJBKyj8Rz5Y0uL8kg+PtlYm82YiZ8adFBep4XxWP8jGrB9Y3vri9vG
	 XQw20HagWKsyUifEgAyF9dV4+93xVh6w2ruvVJdTemr808eKFrXVeVf4iSm4HFkArkD1T
	 76/IR9kS7AElTwkezPgszuIwDaXXXXs5JHgh+nWFFoIy7uYe8goOxYFP3GaEq+ZkBvw2N
	 n+d7gvXaFOzpUkOxom0TZQ66ZOqIral6uUIiwO8fu9eOHfuc+gG9fNKC4Iwwpium2aXJ9
	 fKyYgGC5iNWvO8Yv92oiF5q6LLVEhQY5fILL06eKvjNxGER8fa+PfW9QWAzpQI7EN8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1F5u1HTH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.58
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2E606B3AE
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E2E606B3AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1F5u1HTH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvUR1gNb5L90T7Q1f8e5pDCVcAEzEhTWQQqioshs6rKipf5Br3qhagcR/lGwr5MIB9P0ePRtswE4r9NqawX1H/v+FNu/MiXCifPkI2mV+ivoDegDtdKI4f2hbc0KIKqmWB/uaLQJmKk1zQVMCuUJeLoYWrCkw9FbLavX2ERghRS0ZrVhsaDPX+41F3dQl93V1k4a63gwFyQbwjL6orYLYVstw9xUQkPPfKOYE4kowNaalMH4lbVlZDdgXegS1YK5Qatr1/4aVRz16HzIjcJXtxsVt2zUtUkiwjry35cxEp86KrCyiM5n+mXRkuPkHz+0RG3GSnqAQcx6KNTPTQZ95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBo+nt0mo6zbRPx4RfBs7z4Mt5gi/enPiYSxuGH5yQ4=;
 b=Nzp50lEaDrSjYrj/lEbP3GR6MA/cn/bBnm9OnwNL0nicERDAJJWLMMVZe8a+lhFFPMiKlesNt6I8us4iJH0LUqKEKXpwasAHp/4UOVBi4+lmKSSH7e6RZ+bJXGotzT4ZlN2WfM6A+CWaUe3+W6THOdiofzASkelqGUIY2fytra4GEhZVX8e7PTZmwW/3hs6wu4qGVmWYZpuesrfE3RpJDmecItoG8hOhGV9ljRC4UGchy/7MBImJ+iAggLU+79AD/cgE+mVRswQ/s1Y8qghI/tNAC/L07JgoDH7bmOQYfBW3RCJ0hE1OWsox8STowoXd3YniwKL4qRRXeeYdC/kWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBo+nt0mo6zbRPx4RfBs7z4Mt5gi/enPiYSxuGH5yQ4=;
 b=1F5u1HTHXUnpi9wf2LdJC3fPQzT/C6m0ZSOm4vd72KRlbxtvYGK3lhA7579yMT0c/KsALpAPcqXkpWaAL6rUyX8locBGizZAW0f8X4OcFqzVCyW6gMTq1Z2GDONLhV4pIdZ4c8PDGf2E8e7BhlV/pv9IEMB1O+VNGyzTBcRIaWY=
Received: from CH0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:b0::9)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 21:20:05 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::92) by CH0PR03CA0004.outlook.office365.com
 (2603:10b6:610:b0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 21:20:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 21:20:04 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 15:20:03 -0600
From: Eric Joyner <eric.joyner@amd.com>
Date: Wed, 4 Nov 2026 13:19:45 -0800
Subject: [PATCH net-next v3 4/5] ionic: report the operational FEC mode
 from ethtool --show-fec
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-ionic-get-fec-stats-v3-4-b261fd53d0a7@amd.com>
References: <20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7@amd.com>
In-Reply-To: <20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, "Nikhil P.
 Rao" <nikhil.rao@amd.com>, Eric Joyner <eric.joyner@amd.com>, Eric Dumazet
	<edumazet@kernel.org>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ae726c-219a-4f4d-c443-08df3ab9651c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|11063799006|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021121427099003|56012099006|261021135927099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	y4xdDRCUQJy4BRUpK+j4na9FCNBY9gdhRB0zzA3gDkiQUDhBlO9JUIdSzU9JLwUWrLE/H9xPb1sfLzn/wVnDqmVrAxncqNFLzH9UQ6r5aL23jJ7zjf8O19YTvotCmZtKQO3yO4CEdIwNu71wmBLevCgr2WJfcv1QljfNPkAiWK1Vtc2aIhHvLQ87xlvhYLgwqxAM4H/40mtWMjhi+DQ5t9qZz4tyeGyLnQ5dSKCL+jARGMZDBKFO+uNbqIwLxZWUby2hQ9mjGaiHcjn1l3rafm84j+Ju5k1g0UOBueD3yDsrInEwEjr/FEuKlL1ODKSBZmwD0ktcQ8CO5cqkLoDhFqd3uDzUBbYplRY2mgRoA2zR0mhwsA7Qk51G4bPjEkO5CZH2ew78vzGYaXcKsUUawj036IqQwLR09A3kamZAun+JHzksxXYDSD5G8a3Ltmu3zmo6dVr2KP8r6ENmWb9oO402INB5vbeedX5W3+M5QtGSje456ktMToUSH/Cd4di8WsZTUuFUxx8yz8seKATrmJlsxz9s0WOUNucmY373mOVE/k63nN5JSYGDAbASrNR6qsNvGapKFulIkIkHzyxJJPNwxO3wi05Z17yLk2X5ORd/uusjP5WMCsvxeH2Jnbi36CXoda4AshVzJ2IuWH8Rz7YgYeYEY3cBkgGeqHiEIdCI9CkBZ3sbf+wyOGFsUv8gG/oVBS/LGa1PR/ScyB+p5Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021121427099003)(56012099006)(261021135927099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tYNkEP9vqHGDza4U1cGsokmJmeCttxZUR3f/P1jL12V4v3cwwpF8ymEdCIVtaoJCZtD+UgFQ+7Zi2TuTfhfGv5jfOV1zhVZChLgL/p4gdFGhvHSMETFd+8ep/7sfJUrTrUW5HqmKYHsqQ8wiOPSZ3lv/qV917ld5LdaqlszRXbAeOi66DVOeyHBMDs3A96sUl7KcFQtJ5udgrut8de3NrlbYy37MkSEJNMsuREf+4k5VKQA+jMuwdbkP+WaDmK+UCOPU+YP6ZuikrNODRE8RtTcGrKlui+Rw4daTe01Di0OWurE5I2TgQoBJtn41BP2faWY/S7wUpUr4EM+wkuD+dzV417IfwDcnR5QWmgSy5Wq/8xzfitaAvpIWXxBlkmif6clS3a1Darf9y8xDugRUCNxaDeLmwFHorHKE9fSeblYjWMJijXvKh+/kNof/5F5V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:20:04.9103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ae726c-219a-4f4d-c443-08df3ab9651c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744

From: "Nikhil P. Rao" <nikhil.rao@amd.com>

ionic_get_fecparam() fills fec->active_fec from config.fec_type, the mode
the host requested, which on an autoneg link is whatever was last
programmed while the link negotiates something else.  Read it from
status.fec_type, where firmware reports the operational mode.

status.fec_type was carved out of the reserved area by commit
c4e7a75a096c ("ionic: updates to ionic FW api description"), and
firmware older than that leaves the byte reserved, where zero reads as
IONIC_PORT_FEC_TYPE_NONE, so --show-fec reports FEC off on a link that
may be running it.

Poisoning the byte before PORT_INIT, the way the driver marks unwritten
extra_stats counters with IONIC_STAT_INVALID, does not work here:
firmware builds the whole port status block and writes it over the DMA
region, so the marker is gone whether or not that firmware knows the
field.  Accept the wrong answer on firmware that old.

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index bf7c70438a8c..2e067481bb15 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -442,8 +442,10 @@ static int ionic_get_fecparam(struct net_device *netdev,
 	lif = netdev_priv(netdev);
 	port_info = lif->ionic->idev.port_info;
 
-	fec->active_fec = ionic_fec_type_to_ethtool(port_info->config.fec_type);
-	fec->fec = ionic_fec_type_to_ethtool(port_info->config.fec_type);
+	fec->active_fec =
+		ionic_fec_type_to_ethtool(READ_ONCE(port_info->status.fec_type));
+	fec->fec =
+		ionic_fec_type_to_ethtool(READ_ONCE(port_info->config.fec_type));
 
 	return 0;
 }

-- 
2.53.0

