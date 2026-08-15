Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82983B7A8
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786752053; cv=fail; b=UF08s0v7w5AxfSJcjNoIwcFWtnYlQECkwxfq6yfuLh1nk2wjuJDZ+9gXJlEbZBXiR2x22cgkGw3CJIaJzVkQfyza/UsTV9p2FYsGbuhXP2lsIpG9+Id4ih6V5UbZWIvPbPlcKd528hmKJ+bgtsYdCa34zCyjBK7RJ9+UgLIxTx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786752053; c=relaxed/simple;
	bh=LNXogRO0Wh48ge8OTivCw1vhSpx2BaYgtfrsrClHVGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=etZ4EviMDNStUU7mZLxiwEdKLdhFyPf6W6DTzbXed9Kgj5UWVC4gWuYOBR20lvcA9cyUSkVM3+tKuF+w/m4CbTRkQN4bngN7rAIn1sENumFQ2jd4Ui9xwSZtemixDQg5GBCdsXuVL4AehAIerCmW2fslaHARby4EttVPqqTQAfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SIy65shi; arc=fail smtp.client-ip=40.107.208.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SIy65shi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EO+/fvW3mNR5FGUM1zXSt8NKOlAuSykfaB0IMBP5mV2arURR+pUELzdJYsDBAaMKyWz+VdI//ySugrOZlf1nsozaUOdHuG1T0z4wSSNnTAuHcXtaHqsTJXokzidm2QJK2SBDfrSWfhpHWsxanLluq7Fyo6s+XgSK3KWI23Ifv2KKcgEjrg6L6GYZEi2bupTowj6WycQn3D6vUOrh4TEv3h5/elWGBMpzyTv299aIt4IIDam1l2WnAXDT+cbP3Lv/UO20kuu17/Qy+I2Q5J4ilwYraXZRWTW/vN3YQNv8z3q0z16NDkErVh9O1qGbuPMfzKs3XZnJWYtefq4BTXXlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFha9UPS3LzoR3eWAMtRkPnpPJuMSL4Gxh0U6E2Eg1g=;
 b=Wzz4xAcYdNarovBVe/uzHHfI/wHAwAf2OFgA/ICCWIyTCRQe0iV+OGr4UvGEwi5h+Qxe8XrQsixQvcRjpVszuUguFbTrTEqb5Wz2PssiHEnANPaMebGyCmxnA5gqFTuaMDnJFECB9V3PBNAjLpIlk1MdM6pD+amwH711BFaVv5SchJe1WQIyQfDpE0dGWM42XLZtiwD7YjfqFH94MIV6HegoZrq5vnfVMMrLhPservf+GwXblG8en1av6H3Oveuz3CBSYxcKBogL0xRTh3sUIqsxTmhT7EOLJfyGl7r+5uRGKapyfTRsxH/NN0hDsbsPGaYKf6KqIWvWd631px01og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFha9UPS3LzoR3eWAMtRkPnpPJuMSL4Gxh0U6E2Eg1g=;
 b=SIy65shi78zIFC5O6jdYnzbIt3Dp7weS1Tut9OBnj4wGGfVzjrqIIxM1arTgqc3SlnPhlcbiwEWvLS+nluc1iG8QKA4nlOWik+clM006VdbZYORmPL4/jJKH8xI/+SP+2Z52HZCDJp6uKAOV3m2WlvnxWfb++6bJfDp+nGif2fs=
Received: from BL1PR13CA0108.namprd13.prod.outlook.com (2603:10b6:208:2b9::23)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sat, 15 Aug
 2026 00:00:47 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:2b9:cafe::31) by BL1PR13CA0108.outlook.office365.com
 (2603:10b6:208:2b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Sat, 15
 Aug 2026 00:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Sat, 15 Aug 2026 00:00:47 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 19:00:45 -0500
From: Eric Joyner <eric.joyner@amd.com>
Date: Fri, 14 Aug 2026 17:00:22 -0700
Subject: [PATCH net 3/3] ionic: free port_info when probe fails after the
 port is set up
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260814-ionic-port-info-lifetime-v1-3-f73b1a06c5f6@amd.com>
References: <20260814-ionic-port-info-lifetime-v1-0-f73b1a06c5f6@amd.com>
In-Reply-To: <20260814-ionic-port-info-lifetime-v1-0-f73b1a06c5f6@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>, Eric Joyner
	<eric.joyner@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 78da1d01-0b40-4635-d988-08defa604282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	u/k2CUCjB6Yqo0ohjOkRgLwQY1Z7RX/HFUm47UhDzqUOYyfWwRQz8SUOh/S0TfsFF86RURZtn1lhwnGNG0Min2gvQgRvtnGO9w+oCAvXdeRfVLw+saJDrH9s2a1UopW0m1CfMD7fZ8J3A5QFeYqpkuH4QsHVMUkLlITn0lkQjCVd7eOB85RJvaV/FQdPKUv/zrHpYy/lrIcSx50ik6CAr0gYENQjfNqbydn1cs3sDxcK3Qpxoby/UQnaVg104yX7srwt7TAFWU68SDDw8S4WbiK4/iTfbGeTEVqY+NgOCN/qRj9/jUsMWJfpX0vggeIB5b3hoEJG1wnT2ZKC7sFaGiLLr3Qr6JwGc82MdlwC+00kXQpV9KzpZ7o1igzS6l5j38dKA5tKO9UIib8W7L5xGfsYTsqJ6zQN2mZvjgG1JMTqGVoj9c6YBD0yzRzdF4TbzEQSv393gUqiMb6Y1i1zKLfDHl5kc40VWow4aWEnFOqzbkiIkj2GyioCNwNHOYE9jR496lgK0rkvUfHxEV3cZhjiurVbWQigt4HDlIcypMBk49kNRakxH1cuKCeztMCuPTTKgvXESlycy5pT4EbiUAh+J/4IyjT3FeidkMBX1kauJVmE4kJTmVkM66u76xgsrNEdlhletrn1G4tJfGsclzg7DFx6Jp+pwrPlHAnG8sc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0Yj8lIKECy4w2dpImilkbIZIJlG8SVanrM5o6es4Oz2ykHj25Gg4kCmdopTeDckKCtE2dU/rtKkVJWs1+lR8nZrEOA7bOzaXOHlSoep2H9nma/F6unxnW643/7CQyeDkC+q9Tkb6G5FpGZ/iaeIV9+cVCmegd34stfvDuxQIA2Z8IBf7oLFWAr9INVZoagp6V8jrVyDnvvMZYAPuF8Um9oR5fL7xpfhveOEnbgWvW+dptcJ2ws25Ba+UxsNgA+pB9l8KCtDrQjraMtR0PYKABsYevKbkH7oY3WE8QZ7cVCafkRmbg+xe6Qtd9GZc+tDoyy7mv2MlFbK1ladPDl1EbYGFaIg3gnoEFn88LHXti4Zgk1Zdq2CV3VokNzzKMrG2NuEXtnTYHp4QHn0czDA//D6Yni7X/Y4j8/zisUmWFHhTzS84GSkBWyf8PyfgGE/b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 00:00:47.2478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78da1d01-0b40-4635-d988-08defa604282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

ionic_probe() allocates the port_info DMA buffer via ionic_setup_one()
-> ionic_port_init(). If probe then fails anywhere after that, it
unwinds through err_out_pci, which never calls ionic_port_reset();
ionic_dev_teardown() and ionic_clear_pci() do not touch port_info, and
so the buffer is leaked.

Since ionic_remove() already frees the port_info DMA buffer with
ionic_port_reset(), call that on the probe error path too.
ionic_port_reset() returns early when port_info is NULL, so it is safe
for the earlier gotos that land on the same label before the port was
ever set up.

Fixes: 04436595c435 ("ionic: Add port management commands")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index c15c4c705155..2fb8795189b7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -397,6 +397,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_free_irqs:
 	ionic_bus_free_irq_vectors(ionic);
 err_out_pci:
+	ionic_port_reset(ionic);
 	ionic_dev_teardown(ionic);
 	ionic_clear_pci(ionic);
 	ionic_debugfs_del_dev(ionic);

-- 
2.43.0

