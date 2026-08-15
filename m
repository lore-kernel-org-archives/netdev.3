Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69223BD05
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786752056; cv=fail; b=GVZHJtGIurP7E3NzLBqN+t21yShp/EaAjxFbHRu7p3SyeJnW7qiDMshyPyQf6PCYyqxg0H0CLqn+W5JSQoNimmJXAHGesjUGbgQ16NtO1qlDWHqpgr2ekHMQpEQgJI0M9D6OvkaEqNaVJ109OdyQz7zjEJrF+Tif3pPBe+JKro0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786752056; c=relaxed/simple;
	bh=PlCErsVsd90vQI2RkPDS2KhW3sagpqBziDU/v3ZoLAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HA0DQ8vxLP5yVmt/mvXTupJQlJcTvOBrEnZ/6wAi2R2ZK4RCYnx4i1NvE9QHNVIJoCwmGotWrJCLDU3k4XuY7S8TF9DaCL8WE9xwT3IwsMyR4fsgAWATmCO9Mk46IYX2XWrLFwuhPKK6c6n5D28jP7Ap5zafGG3Buujc8rMU98I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X8nfwwHC; arc=fail smtp.client-ip=52.101.62.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X8nfwwHC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcQSgA8OVBMGJoCDtqSkxG59L16lH4Ji9dgghlE4sT8eoW+SUemgmwj6ium4vt8tRNJbSx3QuzsDY/2gApi1Xxqgae0H/ccuN4+llycqIPGjxbg8ayGp70vWXw40q9YqMFK09b92w4UV+dw67ljfNdmy+Zs+YdEQihAMHiZDjTZUryBrdEVWMnqyN/NV9DkuQFmdwiqu3dm4stIYZxsCIn2Pc9Fd0yxsu/VvRiJvLKz2xSan3IgWCWPVmdDzN4zmo+tQbhQ++dazdTTkWP1UCfa7gtxLG9UjBo7ocOlfywGuDuZ6SCX0PxDGgTfIPnbMoWsDsL8D5RUz+nzJeDbATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gccDFyDZyvqgvGM1nDW3/wWSNVuLlyzAQxcR4J0qtQ=;
 b=wQlOmtctldmujYH9TSClKAv3AADAz+jWvy826cNsbNmD5pfW9p7k6TqAAt1c4fjpg1oxTtKeD0GwZGgqrdobovTctMSxdS3Zls43Y0IArVZIqnXPD/HuFtJ2GTfUtHXfzljGE0JNQ7NceOLw9hgCS7QX/whh9kd6Ted95kA9k2EUt9uyCzVz76ZeDsgn8Fw6tBrUD/y0BBmpJ+2VdzY9vzegwnI7+ZhYWjHLZf+VGKt1W0mektZ3+r/JihWZ+lILZpotu6xJbPFzAPXduTfZDeaLRiZLmSAI0KkGYPZhw5poOPA8OygoHaufcUhsAnBipZ0iFCrmtdb0lV1ZDDn/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gccDFyDZyvqgvGM1nDW3/wWSNVuLlyzAQxcR4J0qtQ=;
 b=X8nfwwHCdgh5pBc8kROnC2Ij1GRJ/Cfjo5L8BOnlJKaw0kiPlUjtj1v3BGDHi/fnnHcuiiNK0y/j593DFGQ1JvTS6685pu0ll6+bONDBXVi8kPvXpeBihh+/ZtmzAhMrLTOmDFO53N6P8kefAsQgQESaUc7FkSebWgaq9bQuLeU=
Received: from BL1PR13CA0104.namprd13.prod.outlook.com (2603:10b6:208:2b9::19)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Sat, 15 Aug
 2026 00:00:46 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:2b9:cafe::96) by BL1PR13CA0104.outlook.office365.com
 (2603:10b6:208:2b9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Sat, 15
 Aug 2026 00:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Sat, 15 Aug 2026 00:00:46 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 19:00:44 -0500
From: Eric Joyner <eric.joyner@amd.com>
Date: Fri, 14 Aug 2026 17:00:21 -0700
Subject: [PATCH net 2/3] ionic: detach the netdev in the PCI reset handler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260814-ionic-port-info-lifetime-v1-2-f73b1a06c5f6@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afb5e96-38b1-4952-3e52-08defa6041e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	J6IeKm7sdkAoCKrPrmgFdvYAsaxNYK0kwI/tHgZ6Dk5KSDhtTgO5KsqfLRpm0V9NRxxuq0XhF/sljl3oFlbCHJWzMrLOwUHfVuoZhgMDPPv0e44F1CLEBe9/T7zY384iuhYT/5VsrVym/UnOYoNORdPdEssFXRs7GKgn9/hzwsckRLUHe8jC0doBRI7ZmWudlzun8gC45WcR8dH7GZoICTJpJKteFJ/8ycm23dca/nH5HFQodn5TifNqrM+5nU9SLG66DJ/WxwbqZ0sQzEANfge6xlRBDqzVialrqEVbYBfO0fpxUE2PIY6XviPT34pXvVraze6s/+IS7KEweSXQfMTYWOYoK5GUuSgDjRuDw4RTq1SXdMrCYA3NiWczUK9S0xWFpjaLrwu08Et+JVBb7BX8wZI5+TUO8OkJ4heY9vWpBHdECrj9gS5RdRMJbpiGOhuByHAe6BZ3dwWpEYZiIC2cgZ05PrJ8W70zSMG3OYf6zHM0eSAaLDtuFNMjFao3QDg/HVF3ENtaqg07kOt6QvW1gc3fUhoEZkEY/TG5eF80z1XsGUox2qHG4qW+AVVDc+MG8hFQa3+fU8+xswPP7ME7iy6m9NIu8SCkzpcvrArDv6O+cpKuqrJumhRXEHhMJW/ydqT6ApfI4CCZ6P95Y1pZYyeDXLDTjB/+PUJngd8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F3baMHL5vtBdbFq/YGAb6n2+5y8d5JcZtbLs+uV62A86CBLCh9rmMNhaON7bsX0aWkdSLb3Dcevkj7JZl8HAOIEq6ACDSzIKniZr4c0m8/oW6QoIVzbX2w0LTiDWPzECzQcogcVqy1HD5kNUkkZOhskhQsCHLawFhDPsPXgP1yCDGfHdWPGkuW5fwhsSLwWCt+b9wFh3wJgWl3kh7nsQG5CeJ2sX7s10xR15g+AiEAU0OBGvD44wQG7SqtVUi9cYRBsP/E37Kgy+GRnPuBGaiPKFG+gbafmzoZHx7PJg0rarkfDfH49qeJYQMHF8pe5+GBDG9U1g1QpIXVmfkUI7c84rr/YU+/dODfvtYPhRJ42xWQ6wkv/grGv+crGJk2gY03kP6QrvPQiXBOpsuXQRsQYmVpKvAlvyCdFXKqP40UzczwxytfML2O0sqh8WASlC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 00:00:46.1810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afb5e96-38b1-4952-3e52-08defa6041e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998

ionic_reset_prepare() tears down the queues, unmaps the BARs and calls
ionic_dev_teardown(), but leaves the netdev attached and registered for
the whole reset window. The ethtool core only refuses to call into a
driver when netif_device_present() is false, so ethtool ops keep running
against a device that is being dismantled underneath them, and
ionic_reset_done() can free idev->port_info out from under one of them
via ionic_setup_one() -> ionic_port_init().

The firmware recovery path already handles this properly:
ionic_lif_handle_fw_down() detaches before tearing anything down; so do
the same here.

No matching netif_device_attach() is needed on the way back up, since
ionic_reset_done() completes through ionic_restart_lif(), which already
re-attaches once the queues are alive again.

Fixes: a79b559e99be ("ionic: add FLR recovery support")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 05f19489ec5c..c15c4c705155 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -447,6 +447,7 @@ static void ionic_reset_prepare(struct pci_dev *pdev)
 	dev_dbg(ionic->dev, "%s: device stopping\n", __func__);
 
 	set_bit(IONIC_LIF_F_FW_RESET, lif->state);
+	netif_device_detach(lif->netdev);
 
 	timer_delete_sync(&ionic->watchdog_timer);
 	cancel_work_sync(&lif->deferred.work);

-- 
2.43.0

