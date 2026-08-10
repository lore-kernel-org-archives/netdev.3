Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB243C7A9;
	Mon, 10 Aug 2026 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395549; cv=fail; b=Zx1fTbidSjiLM9D/m2S7K3XfmY6QczcFq+wa+1X16D8Mb4uxrK9TlGDqSJ6gu/gu0du0vux6h8zULrfi+OAOnyvRLY3vTS5ALrtgtFDfYjQrME3aDkSwle+MS6Fhs1WElYw5rMt/4BSza3MwWnuu5C8KP1rFprf8AdAp+blJWhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395549; c=relaxed/simple;
	bh=r4QW32XKrE02xCyVLsokxcWAjuZW7mvmGCxwcRUE2P0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a9wt5Nx627uuwUqugSAJFP7Wqkyq5AYReukdIp6zrKzkSUwwaP0bgOkMIWrrru4XqLxjjvv2Y6MrA4+MCfkGH+RLzncOpN0O7yKFmw7FhrfaavpiGLNhiKYTvkSLAVk+q16fk8n6KyaF0EgtrLyXJ5nqc2iWqnzAoX2t+C8BGDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LpDe+HcH; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LpDe+HcH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi57/t8+6VnQ/6ZRGU9ERSIrV0AuimeaoBM2bUGj98mr6zaZ7qXN5t2dMGeRW/X9zI+WfgvNVsP1IyO3HlJDC7eUWh2bjw4YA8ypA4Er3C/oCTipV0mHXPeqxgkqdPThsElar43lrLRhwuwWUgJAjkZg4MPxbh2oM4FRZyR7h5fh4fHaU3hOcYnUHYvmDCCqZFCeQ0W3EBPVje3GSaVehFNBacZJM17E9/tOVTAQOL6r4+lN60DlFooild/RxmwlKtTWTiY7nrxh/uP4gDevw1/rexiQKQMK3B/KvHXTsZeMIjcTkmsa/G/H4c5akXrEVzc2IiFcY3TSywseU3Htww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V90bPVCoAbn6YH5NwPfYGNZ6WyUmliYPxZ9O1cTjcLA=;
 b=HS3VdJjs0CHt9+HPhcQ0PJVlG9C6FjrgHlRKbQoXgOArT0xq0NXMCwyS5lrM6SLQypebuowPUl0vvPh+aZ15infYAH9MW9PqDBtG5KzCg3DCnuXveLqugiFcKJbKAqBFJOsHQAPnxygJVmHoZLFayyIBx7dOHF0LJCu6hLNH5wOKZDj0Iz9ZZJ1vYKhoQOBYNnjZFXuWepdQeiI5+pnP/QEmItqsljyMsfmSzSfaeuhZAiy48CcGLbxPFbWNDeAxAUH6xXHwAt+rhyYNegqxIkpGGftum7VXkhmsMW1k3rOsbedAX6QzrE8oGdCc7G4x19TL6+Q8D719m7heiPg/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V90bPVCoAbn6YH5NwPfYGNZ6WyUmliYPxZ9O1cTjcLA=;
 b=LpDe+HcHZq0m8s5DyIa8O5J3lLBisO50X3mND5guyEwirb+xobMRMpR/OXFAdsh9hQxfsSzjGMZjvGtJdUuSQXOO6ReTvo7dXGB4M7A/m6GlT2nDAmeCg2qLjw3lg6/LRaKIujwcrE/G0QaoQSEj7kUS6LnSchTWbKZC5jR/idMQo07kbvLRj+ZDMeelRDTQVE4jeW3OoxA7I8ozDoWZF2rSRTfrYRHpSo3deIRBcw+sQ6n+6HRGiU9Zp2crFXi4sJP63mDDv9kg9ix9HvPGAdBH7Ruemr2sSvLkk35p8Eis08HBIMjkrn7rize/keLrnQUf5x1PPfSAhOB6PoviKw==
Received: from PH1PEPF000132F2.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::35)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 20:59:01 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::2) by PH1PEPF000132F2.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 20:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 20:59:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 13:58:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Aug
 2026 13:58:42 -0700
Received: from f43.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 10 Aug
 2026 13:58:40 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: devmem: add netdev_has_dmabuf_binding() helper
Date: Mon, 10 Aug 2026 20:54:45 +0300
Message-ID: <20260810175446.3945358-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d129701-479d-45f8-728d-08def72233b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ucKPYPHqlx2KbhPoVU0nfIaZe9qvydnLIU3dzkxGtbl2zcRGA1pDDZnT8SIBbPGa7DmvVxw4tFh4csOzbUsKqP0cyeUAcfAaKAsWchEBiOuQnbq8H6mMw5JZWiJsLNoqzmpCoWQt155CY7rqSJtcHIt8PdyCrubSPXm2EcKw2ZvCVobH1m76oi2qqYmtfELUTOKecXlmzfIAqHOAiIdm1z0y4K3Y5Sd1U8qV9XUuleqK0lRjPwk/8m8dIiHot/JU0WPBSVpgPGV1TbcTKYH1Urd3cM0zsq5e/LH2/QAfLuuwcJW0U1hA0U7kI3lsWeN6mPr408apRZPrgfRusjjKc9ILF66fwdEZ+cYHTF4DGWaMxyW7RHxyQ68AnzEDegMMokNsXf8nByM+7LXJZUjJENzvJiJOXbwvu/UmdV1Wldkg04fxOv7Y8OTZCxvYlG9+bWLx/3gS9ts1pZpE4clZENQ772QBHqQsLL3b+k+SBUoYVfwze5EvvL7kA/RcPb4LMVDmdlftB4+hbHSwVCRG1snb23uWKe3ky6dkYZcjbSsKad5ul2xxp9xD8g9/ZfS33BCoM+UN+4UdTkDMcYhXIUiGgEqwGWaDZctnyFD38ygEmj8u0pbgdYwiQXta2sTJ39ZnNlS+UilMWzY79WSj5r6jphDc/gCiDnXNzeUMcKkTe+SxatrwSgRDpL4saXSXyAzmvzQ+qe7BnaZyo0ba8A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AxOR5W7QZzMBd5seWSkEU/3m5KTBxIEI86oYt8RqMMyZUiCt5zfrLEJ7sFMoytksY1l2bsSNN4pvVjAUmXcbxtT5Rj/8/OK+B2jcnxdeFunj1bF+GEGgu6StBaoTshz3nLwSOnIIsUA9s0h2I69EqTH9N9T0P6aoqSVk/aEsKINIRdRDo3F29VuoYudGPrK1/4o5HapZSdmfU2ZoXYWq4v5IiKTDAjRDzgLwt92Uq4VkHs78ewf6zBxcb60RdjJGXK6RoqmN0mUwln4OAKjRNCfTfCkuLOHVQHcdnY2mW63Ig41lmwvxEmj57Wb8x+uW+gR6gsVw5bm/jhMCz9nhCUisskpLm2kMPjmEyf3eo+clIyoBJ88/lDv/S34SVXIT6OluJO9BZQQUOVqUj4Y2g11RRwy3QHlqIv6Kjwp1wT1aaXSzziRwY5M94mNoC2u5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 20:59:00.0179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d129701-479d-45f8-728d-08def72233b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485

Currently there is no way to check if there is a dmabuf bound on a TX
queue. RX side has netif_rxq_has_unreadable_mp() which gives a hint of
it.

To help with that, this patch add a helper to check whether a devmem
dmabuf binding is active on a given netdev, optionally filtered by the
DMA device the dmabuf was mapped against.

This API is necessary for the upcoming support of data direct in mlx5e
to allow blocking accidental swapping of DMA devices while devmem is active.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 include/net/netmem.h | 19 +++++++++++++++++++
 net/core/devmem.c    | 20 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index bccacd21b6c3..0e332e04ea16 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -363,16 +363,35 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 	return netmem_to_nmdesc(netmem)->dma_addr;
 }
 
+struct net_device;
+
 #if defined(CONFIG_NET_DEVMEM)
 static inline bool net_is_devmem_iov(const struct net_iov *niov)
 {
 	return niov->type == NET_IOV_DMABUF;
 }
+
+/**
+ * netdev_has_dmabuf_binding - is there a dmabuf binding for a
+ * given @dev and @dma_dev
+ *
+ * @dev: netdev to check bindings
+ * @dma_dev: dma device to check, when NULL it will not be checked
+ *
+ * Return: true if a binding is found under @dev and possibily @dma_dev
+ */
+bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dma_dev);
 #else
 static inline bool net_is_devmem_iov(const struct net_iov *niov)
 {
 	return false;
 }
+
+static inline bool netdev_has_dmabuf_binding(struct net_device *dev,
+					     struct device *dma_dev)
+{
+	return false;
+}
 #endif
 
 void __get_netmem(netmem_ref netmem);
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 957d6b96216b..f13a0e343684 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -364,6 +364,26 @@ struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
 	return binding;
 }
 
+bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dma_dev)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	unsigned long id;
+	bool found = false;
+
+	rcu_read_lock();
+	xa_for_each(&net_devmem_dmabuf_bindings, id, binding) {
+		if (READ_ONCE(binding->dev) == dev &&
+		    (!dma_dev || binding->attachment->dev == dma_dev)) {
+			found = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return found;
+}
+EXPORT_SYMBOL_GPL(netdev_has_dmabuf_binding);
+
 void net_devmem_get_net_iov(struct net_iov *niov)
 {
 	net_devmem_dmabuf_binding_get(net_devmem_iov_binding(niov));
-- 
2.54.0

