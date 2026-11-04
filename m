Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793827208;
	b=PU2uEUGxskJe9KLAslqZwskP7wFXmOadI8y2LIOw2EqaV92QEPZfI46dAn5PQWsyobb8
	 nCIXICpHJawPg39EIMz/FmUk/8O+C5O29XDzmTRe/nOx/xwQ/YBiPQNXsBpic3oGpOidI
	 3XdPlXRiMZ75fcTEPQUvMJMO6spxtoTWZFBADPYOeHP04WIWQpesVejfDlGOxIhaWFA/T
	 SIbf7ZYcngYWyKcHvzTMaO9Tj5RrmtJf8l6h5h6dza3bw7I9qgEnmsJbk5T53YdGwpp7o
	 5YKNLHSBd2ydOJUVsNvQAt6OSuism39MmhBQfXmM/NYW7HfSdbDmYsaRY/c0h4iVLEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827208;
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
	bh=fasNm9yHoLGJA6sYse9zc6fbS5z3+osYQyzf8lyoEOY=;
	b=cMro9km2+QaeP/bIrthrLuZyYQgQ1xe7H1LsUuT3PVvnRJKsnanxAXm9Ua4HQBQEyHYU
	 ViOV6eNPrVJjXl1jjsWJNw9wPHWM6zhCBWH7JuXaO3txwJUjs8K2PZCGOxwPZXyvRZy6X
	 jdQK48d5Lzzw6I7QmOfliTXy4ZOYn7sBpXqRJNwgQVTkttZoUKbn8ITyrlh2UBX6KdEPR
	 LfQESknQCjGXkiNg8HmVE9uObakOIWtrCqmq9Z43fq6IIfgXFxyQ+u/QJP77uMlUNBa34
	 d+0wWfE5YS4Jnmk47ToejKfLilhsaa/xdaLcxXuZ5ASb+jed/eF/8HGQIzHqnwNoQ8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sawnOQRB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.58
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109B6075265
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A109B6075265
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sawnOQRB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlZwlbwFGOOM3Xar4y5sX5Pv6lWJuUGJK23H+EjJsoT/cPdf77SBqa54PpsRo9kegvFh0yLrwXcpm2l6dDBs4/GNqHq+NkWfiYUZptgSY3+purI80GMXWw4z5wjAphR0wCiCUHoa29hVv/p4s08TdVotAW5q7z5RgH6140FbbjZ4ecXjpIjQ/q1JtnQeI9PdlkflNVEBPOhm5I/X+vcUQmg8L8qGSK7ougMTevzA152a4dpmV2QLRRkIZ/W7Yr+u9BFn0xZgo1/VPquQ38QDeYs+Xbd73m1z+RlPHI43Z9UyLM0KJbpX5eIBjDzieI7XFhrkEf0w7sQXpXkzyRj/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fasNm9yHoLGJA6sYse9zc6fbS5z3+osYQyzf8lyoEOY=;
 b=eE9lsJudbmI/BoT1p+fgNfvY/uqS70maq355TAVRKTGM4S5IwFHAuCwLlAr98DeL1ruHDnjW1HTmBET+7nOBdRKdHylk6W7TsPM4vFCkwY34xZ6GmvgFifR2zrQo/kV1e8O3cxXdUdA+f2KpcAxLtNgx37G4zAikw2VrGLDhadebD1q2I8GHG1OfBRY4A8KO0sJKWll7cjhR6TCrqPP9qmhGE5krlaOUz8paqMOBa3ZqW9S1MASu9PnPS5iYmIwIOyDCqnGaLCto9amMbbJG1ZYmtDjRnIoOBojZSCXA9TViLBOhJ1kHXwIegf36uHCw9R277wMnFvLu+RLIz7qwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fasNm9yHoLGJA6sYse9zc6fbS5z3+osYQyzf8lyoEOY=;
 b=sawnOQRB5eGzgNqmyntJxuMyFywgonRneuz7e5/m9j9OqAfEVzfznbw8Ijj5OA47cOz1heyFyZI80gGGdq1wOjdSfqiDAsWHt2uY+K1WE3TZ4153GR89yEr+KLL4sdFewqQlp7MWyvPc4iZVmec31Jy4vPTg2o2/zPDBCKXGINw=
Received: from CH0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:b0::18)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 21:20:03 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::49) by CH0PR03CA0013.outlook.office365.com
 (2603:10b6:610:b0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 21:20:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 21:20:02 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 15:20:01 -0600
From: Eric Joyner <eric.joyner@amd.com>
Date: Wed, 4 Nov 2026 13:19:43 -0800
Subject: [PATCH net-next v3 2/5] ionic: report the configured FEC mode in
 ethtool_fecparam.fec
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
Message-ID: <20261104-ionic-get-fec-stats-v3-2-b261fd53d0a7@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 574df4c3-3674-401e-7907-08df3ab963e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|261102123227099003|261026121527099003|261022105027099003|261026140227099003|261021123027099003|261009223027099003|261021135927099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	2isE6HWjG6aiR9EnlVeO34zqL0aDawrCkdGeKr9Ru4TLffzyjLDlKB1AI9wwIqNAyuBM2XdERs2B4IVyyaW71JeKJHE3xJ26wjyCAbDreLYLS8Gx5EBlP4jXbPhY+0uCDh7o3NswIgm4AjPuhHoEeUbBS6BGvEg6MuWLMUKiC1SmCvdbm3NAK0K0VZp/tHiyig8+Ed31HWRBLM1GkypKKRbfTJsaxh2fAynESk6t8waFp67X1bckHF6YTXKlWBBR4tuxfuzU3HGoTL3KEnT3MpK5zXF54dhfqJgHuAxzTbFZAsEc17gDZxpKtjVsyckHWw4Q8PpqqWZmNZu6sy4vA3yI3dqTrjDfo8oi1FRaxu4m4kRB0nrk3BlDlDaSRnpui+wyrtJXDq8w6Jjt9sNEFbgLol66ab2Rp2qpxneynL5CCmOpdBP/wF1WUz9U3g54+wJAy6T7iBJyQdLRsOrYLnbcvHW9m68b1Ily0EqZjX7nhpDST29kDGeN/vmUxUn7SqEjRijgcPQ8e5mDYDk0PiaGq6yiCbh7LIwEgzjPgOIQ9UUCXuWtbOAeQ/urlHb9f37+SFCN94PpQJB3f9CDXThojY54/NE2f87/I9gUD14flBHKJ5xDJIyrnYEtmwGnzJDQGZy/5FMG9x9hTsGyb56YuyGSlKdqCEoO0zbqLjqZHSx6zK1xzigXUg8YP8c8arjqvwBiadz6o7Ts8DxdLQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261022105027099003)(261026140227099003)(261021123027099003)(261009223027099003)(261021135927099003)(261021121427099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	txdXAwZLRIsMeNVucr3vIIEXqhULgRnyR7/cGTFfipmPBpfsWEpBRQSjoaJ5ghB/lVa/j9mgNv9BEK4DuD3W5MQ+5kDMhpSyk0pPUR6pDGo4vFeSjdwWZvD3aDmgm/r1c7RWwBuSJuxjgCS5iTG/qX3mnSNb8S7B1OVCjFLUdtYeBmfBsQJk4QlmdnWMvvdRI4odj+FZ2H9zR3z2/zZtBpIvmjiK5koU4VIVuGRFP2GK3VV4rr5Y8R6Hd819NaGUdO2v92bE0+Jk3h31ZksqBomJx2WRQ1rqdQusuHmFpxiL0o8no0HWl7/CHuOSyerBd41xpqTma5CMv36e9lvBdI4AEyzhMZfmXqzcUnvH+M73Adh8WOiXVRRJDqoaEjQ4XDgESWCmXgcnu0WSQT1d0+et2ytyaboFQaVIM9Mm4djH+A9a4CL5f8WDt0YMJrhp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:20:02.9146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574df4c3-3674-401e-7907-08df3ab963e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801

From: "Nikhil P. Rao" <nikhil.rao@amd.com>

ionic_get_fecparam() fills fec->fec with the constant
ETHTOOL_FEC_OFF | ETHTOOL_FEC_RS | ETHTOOL_FEC_BASER.  The uAPI defines
fec as the configured FEC modes, so a port configured for RS reports
all three:

  Supported/Configured FEC encodings: Off RS BaseR

where it should report RS alone.  Take fec->fec from config.fec_type.
Supported modes belong in ETHTOOL_GLINKSETTINGS, which
ionic_get_link_ksettings() already fills.

fec->active_fec still reads config.fec_type; reporting the operational
mode is a separate change.

Fixes: e95f922f4c2f ("ionic: implement ethtool set-fec")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 119ac720c078..317dbf96964e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -427,17 +427,18 @@ static int ionic_get_fecparam(struct net_device *netdev,
 	switch (lif->ionic->idev.port_info->config.fec_type) {
 	case IONIC_PORT_FEC_TYPE_NONE:
 		fec->active_fec = ETHTOOL_FEC_OFF;
+		fec->fec = ETHTOOL_FEC_OFF;
 		break;
 	case IONIC_PORT_FEC_TYPE_RS:
 		fec->active_fec = ETHTOOL_FEC_RS;
+		fec->fec = ETHTOOL_FEC_RS;
 		break;
 	case IONIC_PORT_FEC_TYPE_FC:
 		fec->active_fec = ETHTOOL_FEC_BASER;
+		fec->fec = ETHTOOL_FEC_BASER;
 		break;
 	}
 
-	fec->fec = ETHTOOL_FEC_OFF | ETHTOOL_FEC_RS | ETHTOOL_FEC_BASER;
-
 	return 0;
 }
 

-- 
2.53.0

