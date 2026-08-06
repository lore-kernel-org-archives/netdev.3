Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DBB239E60;
	Thu,  6 Aug 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039953; cv=fail; b=DC9Zv+vsmyuAIY6dUB2nZ3mOGkCJ05IivFC9PBPHez/N4+KeaOBVg/b9asJbrVFem/54XL62Pb73A09Ljxrx6lhVr9VZrc8rmiRWFpPF1JZGE2Xc6Bt4C4pXgOY7Aph3fDP702IA7KEB/3+eDs7fD4qVRVXUO+tj/qxxKvHPRps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039953; c=relaxed/simple;
	bh=u8ETwGFYW0RTArdZboEhfho14Mh9blXrrFXdiXdhYWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAvKaLXVzuGOP5TZ67ONcPCLlBeqUKvbhhNDHyuYdnMTz8DAj7ELIUYxLXF4geuuqWXoSWB/p9jkHtpaWOg7LPTqV1kGHS7SYk8b2BnzjjVJWAor6JopCL0jTWADeR7bJprPXn+26y0hr6WqDdunIG9B9u+rAxABQKZ06BJHQ9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EB8GBR6F; arc=fail smtp.client-ip=52.101.57.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EB8GBR6F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZjxWYRfRJlpPmsQ4l40DbXEd1ZjY6YxDOKMxtXXArtyE+JopftDH2rGTz5u++fvHUesB3NOcRSebxTbWzw6JYaNR7Fc/0p4RUP7V23YGhIXULFwOAwcM5GRlCKCL6iFekK3c4e55RBThmtQ5brznqcEH6DBct7OMXcykHDvP2SsDFYaEkVK48EOXwSItvjyulZfVs2mxIpS5+6h70xTvHFLNeUseWuJhNmoMSgrjSwk0fcpSbOKF7grVJWsY4B3D2paQv517N0gXeK6X1lwr9L0+RBlUkWqJDfI59fppKNv5M5vQYmYUkCsYK18a23QiDo2ojtdG/9XSPhYHerOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82TTsPol7pywyMi5IzCCAEOAzelDKwD06oN9jnjHe1U=;
 b=xWF/l2+xrYSw9MLkqdVH5lQ5wTbG90lK4yNoxE0xvGVJN9EVcV+ufNy4Nyn2NzyaD+SAotsTCIZ8ZvaHwWrgXvhpCL3Wh2vXpQm5e/+s/Dg0LaLJQzK8izyWoU3JecRYoNz4etAvyvTl2rGDUPAWX37X6KMxoJLJ7qKHy76vcyNlQJ4KTcGpVXkl+N8Ggo71+ozXWF7v4aXyINIYi+M+pI6P2G12RWyHCWedBAhzl6EgPYPYsfzhTH/7KjtemJtxiiZbj3YD2HHd/DhFvNQBCWmKB7U43lRSA64Hc6KVSvcEO4J+yBaZ+ZZQB7UiO0/Wl17iR34y3RkjIeLrA87gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82TTsPol7pywyMi5IzCCAEOAzelDKwD06oN9jnjHe1U=;
 b=EB8GBR6FHZnJhTmTB1PifRUXCKlT5GGyiiLxqqYEZMFwk9nU4OwoOIGDF9P+fvN4ElDKJFLL6EPsuVNsVHfr7NLY/r4G0gQp5EGQjXflL6W2rSSeldfSkhepn8FtHZ3YoHmOypKHFIzAcTjz0d239H1pDCjNJKPXYdoGVbwTS5s=
Received: from CH5P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::6)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.20; Thu, 6 Aug
 2026 18:12:25 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::57) by CH5P223CA0019.outlook.office365.com
 (2603:10b6:610:1f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 18:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 18:12:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 13:12:12 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 13:12:05 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Brian Masney <bmasney@redhat.com>, Stephen Boyd
	<sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<driver-core@lists.linux.dev>, Danilo Krummrich <dakr@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Russell King <linux@armlinux.org.uk>, Shuah Khan
	<skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v2 1/7] clk: Add devm_clk_bulk_get_enable()
Date: Thu, 6 Aug 2026 23:41:47 +0530
Message-ID: <20260806181153.1213996-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806181153.1213996-1-suraj.gupta2@amd.com>
References: <20260723123838.125145-1-suraj.gupta2@amd.com>
 <20260806181153.1213996-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb63567-1168-4a11-3c99-08def3e644a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	r5qf5uBdLu4WmH19bbTFY7mSFXMzSQaBOjPJQPsgpE3dv3W0WVfQiT137/5UjIu+ZiRlpMNdMDpVIxT3hbG3FU7hUF0da86y3dKfpeSiFjn1YdmxXG+KR4qbYwgGdw0RL3+ufj02LQSmqrMyqp06RSotFykRANd19GaqrjjFrofYwcnqtFd+y06i99QP3KDBw+6BlkeUt1cYnd7H4QMZE3xQfYNTxy6PhKSq+5SQlGVbhSs19WzM4LPvBp76995yZGsOvIlwgYcXVEglTW7GgFvk8DBvA5RojKD5cKAjRY+bYU1fhGaKkIp2bLaQpdEiOrOybycx9ajF1AcR17bPbNSqxOa0xYGshlA2Y+uMPhS8HRFqybnMqnSQmziuaJSLYKMzNblhrJxSYg+T5HaJzXtC+nOEcq4HlMN8EHLvufPDadzeV8RcH1EYQuBGiF2dPPIj8xnEn/HtC9haQQ46grzQL9OtsdYU4JatZT5NDfP/cT9Rhbz8Q+FlH+zgzXFI++SbunvNxwBWiNzTIwRefWRCW27P92r2c6T3z79rhiWonuTd5k3BAEpTogrkUU83HwIAabFQ2DmWNoMLUy8xQ1AQTnmq0uGZAv9BNVHiIBxmxvQc0LYEZPjXsmxr6NbeKjbx9i6Xu0ZFoafjZPhP+lfL2369xwXUDgJavOlU6iM8Xpwjg658BphioBU/NCRUl6Sa+G0muh3SfPoaRUfchjnQTYXjMf6OFVaMyGEgBe8DGjvDJEysI+K3nALPaU8R
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ixiIEXKdjDUnX0BKwix+UW8KpQo5pvjbDzR4yLLSgcjXIuAWRLXhNWK7PRl85kAkdbGjRymo40IuL19PO/ocoLJxUl3EjOL5M84q7Ob3+DQ4jKJn+JnTcH3xghOWcig880Gke75x28CE8ACCdr/eiNyAD41pD9Yn8UGQkHFeVIftb8U7pV8HBinxrZ+HIqyCc368A/bC4G4Jw8ZKiEnSk6E+XyYne+nVBnuoOXLw6xfCUzQjvHHDsn1jSPKuXVTbTEhOq5vr1v8t9XmQY0D7p7pvP7H12d9SJJDGcQHn//Ok4S5PBWWV4MP6PwIJUdP34pKN83D3YgcmeFJftQ0Ko8ZtFTmfrHuCh0nHZlXo0hEAFOJWbKxiNH+SDH2rM5XIg5V4icY8F9jtwSsp8upk+nvCWW3FL1/qrBVy4GprmRzpIWUpNrDUyOu/wZQaIKBC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:12:25.2280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb63567-1168-4a11-3c99-08def3e644a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123

devm_clk_bulk_get_optional_enable() gets, prepares and enables a set of
clocks with device-managed cleanup, but treats every clock as optional:
a missing clock is silently returned as NULL instead of failing.

Consumers that need a fixed set of mandatory clocks enabled for the
lifetime of the device currently have to open-code devm_clk_bulk_get()
followed by clk_bulk_prepare_enable(), which loses the managed disable on
unbind, or fall back to per-clock devm_clk_get_enabled() calls.

Add devm_clk_bulk_get_enable() as the non-optional counterpart. The
underlying __devm_clk_bulk_get_enable() helper already supports the
required (optional = false) path, so only export a thin wrapper for it.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/clk/clk-devres.c                      |  7 ++++++
 include/linux/clk.h                           | 23 +++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 017fb155a5bc..5067500ded5c 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -248,6 +248,7 @@ CLOCK
   devm_clk_put()
   devm_clk_bulk_get()
   devm_clk_bulk_get_all()
+  devm_clk_bulk_get_enable()
   devm_clk_bulk_get_optional()
   devm_get_clk_from_child()
   devm_clk_hw_register()
diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 994d5bc5168b..49d4782991eb 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -222,6 +222,13 @@ static int __devm_clk_bulk_get_enable(struct device *dev, int num_clks,
 	return ret;
 }
 
+int __must_check devm_clk_bulk_get_enable(struct device *dev, int num_clks,
+					  struct clk_bulk_data *clks)
+{
+	return __devm_clk_bulk_get_enable(dev, num_clks, clks, false);
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_enable);
+
 int __must_check devm_clk_bulk_get_optional_enable(struct device *dev, int num_clks,
 						   struct clk_bulk_data *clks)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 998ba3f261da..0289ac4c6e48 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -502,6 +502,22 @@ int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
  */
 int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
 					    struct clk_bulk_data *clks);
+/**
+ * devm_clk_bulk_get_enable - Get and enable bulk clocks (managed)
+ * @dev: device for clock "consumer"
+ * @num_clks: the number of clk_bulk_data
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * Behaves the same as devm_clk_bulk_get() but also prepares and enables the
+ * clocks in one operation with management. The clks will automatically be
+ * disabled, unprepared and freed when the device is unbound.
+ *
+ * Return: 0 if all clocks specified in clk_bulk_data table are obtained and
+ * enabled successfully. Otherwise returns valid IS_ERR() condition containing
+ * errno.
+ */
+int __must_check devm_clk_bulk_get_enable(struct device *dev, int num_clks,
+					  struct clk_bulk_data *clks);
 /**
  * devm_clk_bulk_get_optional_enable - Get and enable optional bulk clocks (managed)
  * @dev: device for clock "consumer"
@@ -1052,6 +1068,13 @@ static inline int __must_check devm_clk_bulk_get_optional(struct device *dev,
 	return 0;
 }
 
+static inline int __must_check devm_clk_bulk_get_enable(struct device *dev,
+							int num_clks,
+							struct clk_bulk_data *clks)
+{
+	return 0;
+}
+
 static inline int __must_check devm_clk_bulk_get_optional_enable(struct device *dev,
 								 int num_clks,
 								 struct clk_bulk_data *clks)
-- 
2.25.1

