Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA833C343E;
	Tue,  1 Sep 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272771; cv=fail; b=L5yUIeFbqTPlRx2erNWxlj0e+2vNJdeEN1LiO9j/TVGuagtE/wvkSAoAbT7E1tylOv5kfdltEIzstMnAK7yiTlH3ygR84U9LCsnZBZYkY4yqKRkrWS3XTnpS+5v9CnhC72ou4bTmVhtunVjQgIrWoPQg7PANGSJ8EIbRAvnqrvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272771; c=relaxed/simple;
	bh=MMzqAbGjPmXUXw7vSm87nmL8Aa+8MA5YCvfP3YtjAkM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lmar1OGJSCvoji2VwJ3+9R38z1ZRzLXHcCL10E/5vrV7EPkYLXWUCAHbHuIiHwcPDDt6Yhy8A4uf0onRjNgOLbi9i+u85YwGWu3t9jrXKBvy+CcajbExWvdzvp/Kv2dY2O/piGXA4zcNmgN41s3deBjkhykj0DNN3B++mfXmrZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vjCnW+TL; arc=fail smtp.client-ip=52.101.57.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vjCnW+TL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnXeNmjqAkKml5jZQc9nXLvzWsiKiYYBptvO1uN77pNG8gP4Z7YyXba0TaO8KQa9cWyTwNFgnXNnciH6NvQ71d2P4cGhTdfaNiN29IQ2yXGD3TWluKTX5z3y+/+FYmjX/JA+2UNmJiJpzTQDx2/W+Fqp4oTpxNuJOGiP2RqNG6istlrms+1OuYmmsRcsxs5QrSlGUjvaVQ1eRXwSnex4CacOqjSJWhz4GN4BeH1FdkgeqCWtd4wf+mG/3+Fd+ebEdBpY5KM62HSGZDE48JAmr2/loEKTDfER+/1moKMyVQh0Zy+nyuQIspv1GUU5xY9e488nfRY0lFtn6jBvFr3S2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jefetif/5G5EpvGfvF6o6vYkYfZBbSmhc8F3jRmtTqU=;
 b=heeuypu5rgwp3sATCdr/le2wdRY+myLe3baiEo0Dhw2/aeitJqQ8aWlrAKmeepNGODViukX6THK2Pol+RuQC5KYTLtpTcLYhWeFeOwnHKbrmGGBbQXwAPlUvlC7Q5C6+mFqTHh3cFSNljnIqdoguvFk+7maomXtET/BfLOYil4BnAdXK6r9tYBfFTFA+VF9myLV5j6eAkdrIy0LxnqXRfXw7oydwMlvjwqdG0DRMYsrloHM3UGv4UKha3DanjQN5pjx+u/pyw/pUoO3OMSij0zFBC7QDJuelk8GmhQf7YruX6SdBcWLt/6+i5rTyUPmuNIl9CCvx/uOgiYVBdNPfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jefetif/5G5EpvGfvF6o6vYkYfZBbSmhc8F3jRmtTqU=;
 b=vjCnW+TLhhF+eps++3ofahS2UMsTJWBnEtaopyYeFt7N4s5CQ1WasuY7KrBOIjecDHQrP2A6A5PZRsmKuxyL+jLYP1gR/WjtAHtPJl9bu3ScWPYRWpn8qKfxps2Fz0bTm8uagBANIJSbIewftqnfbP3I6ylbY6lQGey3sPP0MdM=
Received: from DS7PR06CA0034.namprd06.prod.outlook.com (2603:10b6:8:54::18) by
 CY0PR12MB226969.namprd12.prod.outlook.com (2603:10b6:930:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:25:48 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:8:54:cafe::8c) by DS7PR06CA0034.outlook.office365.com
 (2603:10b6:8:54::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 14:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 14:25:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 09:25:44 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 09:25:42 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: macb: detach netdev before closing on shutdown
Date: Tue, 1 Sep 2026 19:55:40 +0530
Message-ID: <20260901142541.1469544-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CY0PR12MB226969:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8ce20e-36d6-4113-70ee-08df0834ea61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	spA5ufr+h56IYgx8U0dHCWJd/DFzbM2CP8AYI7OcZrpiYRwFHzZ+lplu3xI4m6XqFrsSu1lCw3u67YXjFofn2uKOEPzRwvBjHHVpoCsjQnm7r99ot93tQXgr5g+A8eriMx2fT59k+1sHG1qMyRhrcgkDKL0cV01Fs00GwV3ses4IKdhgLwfv3n4sKPQoAk1yuZbqJQPsV1CVdFSKUljlJv8+yQzIhvshDhMh+1cu4V11wlNeLxD0Jy6PkHlVOzAoRXXUy3FZ1ngC4EjHbvu9plR5pWk6DjolnMVAYxSZdkkRr6dRzINs222oq+yDMAkvflSDUXOhY8QLawZgPBxsKPsOxysWt0x1DnmaWg9o2uMWBR1F8h3IP4m9B53E8YN8eYdA5QCktpYFmTPsxM6xTB6OA5MXs/JvQwnwwDY1+Swv4NkIQUVWpiI199mKNXZliHHspjXxHTH7KK53U1NCquRB8pUVtxuhe8osuvsLqhkAWlKJGndDtqVMDAdu7ysTuHjRk/3JZLr0KAwr4W1G/mp5CjyjLm+z7oNmM/CrdYFyf/y+aonJz1Uha0BmTDfCmG29hcKlyRL7BzVMlvHTqZm4viNTIexxqIye1RSAhfZGaYPPAwb+Zi/ePiDR7yibAKPfglWTKT58fH4YfnWOdLyhJm0ftDe5rF50k4jVXC195C0Gk/jL8xJqTqDwBlCvkThcg4iIdWt8K4xSpWbtCw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vdw54Sty11LfAGRN0jHRkXv9h4YIZkf7mO+QD08PYH8CcYaSj21z6qBUMPUwC7hJCtNt9BhSzh74ZaYJ3KXqg0zVUjCNc+2IP0HS2czMkLXmLA4XbIBUEII9MPo29ueW7bFL/qZczbkiZw7A2iqeq/fZSP5B+aRfOnG257rCYJ7h78kkkj2iNY8OEn5psz40TRvDwqSu4acfkI00Bicv07CMvtVLFK1i80kml931SPskMNfxeFTo4SEfuX0Pj8nzB4wUX5P2/46hZCggtqt1dT6yYA/te/cAUpLQp4BADG0Q+op6xVPC8rWcXsarvauP7OiIgGH/JmtTu6hFZgFdLGXKTHgF7z1hdK4veaGdN60m88T1hcWRz+/cge+Pf7bAgul3dqALZanjQuRj5ghJIsr2g8WL2NOVmznmopDILkhJF+GnP5pvogvS1KtQc1xQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:25:47.2890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8ce20e-36d6-4113-70ee-08df0834ea61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB226969

macb_shutdown() calls netif_device_detach() after dev_close().
netif_device_detach() only stops the TX queues when the device is
still running:

	if (test_and_clear_bit(__LINK_STATE_PRESENT, &dev->state) &&
	    netif_running(dev))
		netif_tx_stop_all_queues(dev);

By that point dev_close() has already cleared the running state, so the
detach only clears __LINK_STATE_PRESENT and the netif_tx_stop_all_queues()
step is skipped.

Reorder so the device is detached while still running, letting
netif_device_detach() mark it absent and stop the TX queues as intended,
before dev_close() tears the interface down.

This is a cleanup with no functional change: dev_close() stops the queues
and quiesces the DMA/HW via macb_close() regardless of ordering, so the
reboot/kexec safety path is unaffected.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 76ee4f506033..21ebaee00f9e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -6246,12 +6246,11 @@ static void macb_shutdown(struct platform_device *pdev)
 	struct net_device *netdev = platform_get_drvdata(pdev);
 
 	rtnl_lock();
+	netif_device_detach(netdev);
 
 	if (netif_running(netdev))
 		dev_close(netdev);
 
-	netif_device_detach(netdev);
-
 	rtnl_unlock();
 }
 
-- 
2.43.0

