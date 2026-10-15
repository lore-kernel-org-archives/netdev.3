Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0893859E2
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105436; cv=fail; b=eqKaE13QsbnPqg6ZHOgeY38ebZboqbyW82HuHFWTY6yb4itGaM+DdRcpKczYk8Z5F9AI46zfA6UjweorJND7t1i7YuaWJUT1Ncxiy2W2OI3aT41wtXTxNrtIhy4tqyxkuAPtb0BJVV+Kpz3PCN5TwDj5NftNTUP84o+EJsUvWsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105436; c=relaxed/simple;
	bh=Vg43ar6eZtsfeZKKYIVDLMmgXgYJnaUsW9vfLrSL464=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oTRqZuUDWVBfJF0Wm3JQlqxNuKh/CKv3O4Q6149Gtz79oP10PcT79rZofInMnYPMo1b6xyZlreWQ/utdDN3/vXtQivwJhGyIsyz6rzUqEtoOChTUGQ2Oaa158tXdyWpnN9vZXgqBhZEvAPXf48utU4mVDBG6eiDW6G5w/nf6dnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jc0bOhnb; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jc0bOhnb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wfr9TmmtYwFuY31hIKG7lMbaQEGD9jPzsvKOpBxvWiVRadJB581v8BoYuDYHtNV0ZrJb5X7ngKPriGvZXyPBImfXFeHWG17Hvogf1SqHNIby206Oumr5iKXlf8DRBcFCE5AMBKwe63nR3+u9DOomDRkW+lOzrWerBuTmXdijcA5F5Wi7+4RWxa6fTuEfmpX5LKXZALv6mfTYqdNNyt+aCImrX8Em7kwcr4DNPoTpLof/nPIEUexHxkMo03HwtnXpV+aTBTQOaer0wIkEdXB/Pmd5Hd3x3tp8LcfdXb59sKM5oTA7qyplKd5zVQSLjzSsggkziP/H/lAVUNFWkH+8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiRB1AVXtTyJUPvnmT7hrScGBaXo/YwBt+R/XWNbavg=;
 b=tQYd39RD8hgNEzNoC/6oFehFuIXp0jPlHeuRM755Ua+aIcdrOln/UuaU4vEusUKPYs+jLp7+6LQ8pwXEDSfeBrwyKdjy5oGkQAabmz2bvKAlEOnFqkKGH9I+PoEjhVPgXDLEWGkCj0rtAGOoboMS72Q5Uwyn8V0EqUqp2kxzbPx93TJ+S2nKRP64zpnbqMqkoo75Bccy2Mdbs8F/LPq1Dno64j3w6ERJ3EvEh6OtnuO9PwsI0R7YwAKthMVeaRBbdTW3nFxF97SYu07hOC4/ivmDEt6GjkdO4F+fiRRtrw8+VCtyojy+3E21ylNSvCGdOeHOQEziDBmBV5Hh7RpHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiRB1AVXtTyJUPvnmT7hrScGBaXo/YwBt+R/XWNbavg=;
 b=jc0bOhnbx7iQnkBqxdpleGBb474kHHYqhbBhMPZ7qGcFrMbvIsxh02yaJ/0mGy1GAPV38JCPkFCvy4m7jsm5dNT3IV2dLobWmt2+wRZGqHBGJUCrZyBBq+rGmDLUfKjrCEH9xZim1GL02HL+dAQWrOurqspUzvP0ur74hhfwUmg=
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 15 Oct
 2026 23:03:51 +0000
Received: from BN2PEPF0000A991.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::65) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 23:03:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A991.mail.protection.outlook.com (10.167.248.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 23:03:51 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 18:03:43 -0500
From: Eric Joyner <eric.joyner@amd.com>
Date: Thu, 15 Oct 2026 16:03:31 -0700
Subject: [PATCH net v2 2/2] ionic: free port_info when probe fails after
 the port is set up
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261015-ionic-port-info-lifetime-v2-2-57232013fd79@amd.com>
References: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
In-Reply-To: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Eric Joyner <eric.joyner@amd.com>, Eric Dumazet
	<edumazet@kernel.org>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A991:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 957bd26d-e0ea-472a-e384-08df2b109428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|261009223027099003|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+oStzvyz+zO8IvOuOUVUB2MpXgBApXJn0T9orGZZANEGq2vPEY6wBD1LQlePJ5H1Dl5vstRWa8eZfGNoTVgkB5ucFoWKg3XPYVzfIIntHutD+5QSQekjbFHSYetos7wrzm5X7GH2TSgxo0Sx5l5ptj7VwydRXlb5522pgYNsntVYinwGOOqcLueUPImO2Y4N65YY4Z/gq2ErxgMDJ5ie1Lyp4mESsVi5YJ494liiVCc+MlV6B4V8x/3ki3UCrbb6HCXOHbfrfw1RHXcDzQWonVGS9KujpWJsjfsjVp1O6I+zXER8yL/COasjGg3bz8+pSVNZ5VEcBuxRG284kr27rqdzzvu09HwHy17yM6qFOBMQUr5vFa9WajIElU+CpIT8JUmYOX0JHviVrx/AW313zQQ9/3+O00BBGxzdBu/TQVD1ZEch7Nt83wiGvPVZRGlTZ3En8mIdCueb+bC3yvk7diY7Xegus1tXBODgoT/5ReuThJYVKSNhJqnBM3RMk6usV3sjmf8PRGCQZWl87lhHydkxSW2SEh2+AgabYbJc5uHormBKk1U374+FlfPWcdsMSQtVeNUrle/MPYPBijLNea+Cafh6u6Lpolggu/k+N1ZUdn3/PEmqdhkEU4BGBGlWOGNw5g1MgMTsO0uhPS1U+Tb3LesyQuKG8Ff0rr/jSXnAVzgy5QZl4pHCgMI9dAhxLj81Zw5HYblTYbfe1f9gaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GUExULE8W4uEfci/6Nl26LPe7Ejpvz/KezMRgsDoMWOXd/kGxLNAlguYMwi7prtRmfgPyIfDrZpDXDwuKIguQTNvH/wnCFNbCf+xE81EZby6tYVB9v0Ym6MynRXHeb14qHc4BqHIQoSvk5axRxqb8IU80LWBAUR4JIPM4J54DL3UiEzSExdJxUjL3XI0ryds7MNy6URFtpOlljtkiqk3h7nFbTp+IBk6R/SKl/6YAhEorjmZKpzMQjr6ms2WJic+qtrLbSaW7ksdRNWJyJ4+zJ1HOMF3F6GZlr5M8zQfhbkHEgVNcisxRWNmZMh2zeceR8nTE1mUCd/SDuiJCXxwuhjD0nu6lPHHOpzGLRYqNPSWk5rrugtIWVcHDa8gKhV3hodlQ7Pi+JeqCdFu+utLvSOIY1h6531GkCZOgIXL2hFCF7ujkGjS7v1Db40Je/70
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:03:51.4686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 957bd26d-e0ea-472a-e384-08df2b109428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A991.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336

ionic_probe() allocates the port_info DMA buffer via ionic_setup_one()
-> ionic_port_init(). If probe then fails anywhere after that, it
unwinds through err_out_pci, which never calls ionic_port_reset();
ionic_dev_teardown() and ionic_clear_pci() do not touch port_info, and
so the buffer is leaked. The call was lost when the setup code was
moved into ionic_setup_one().

Since ionic_remove() already frees the port_info DMA buffer with
ionic_port_reset(), call that on the probe error path too. Every path
to err_out_pci runs after ionic_setup_one() succeeded, so the BARs are
still mapped and the firmware gets a PORT_RESET before the buffer is
freed, the same order as in ionic_remove().

Fixes: 0de38d9f1dba ("ionic: extract common bits from ionic_probe")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 05f19489ec5c..68b3bceedd99 100644
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
2.53.0

