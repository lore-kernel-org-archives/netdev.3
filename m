Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334F476CE4;
	Thu, 23 Jul 2026 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810348; cv=fail; b=i1eVoc+jU+1z5quzZXhlIJab1RmgCz/1qf1e91S4npuT9WFlGI+xyn7KpdlfqeG/JcspyoBm+7dCVnaYcnnWzYD1rC3wHt2RkrTiZClfK00cX7/KHLoEty5Q8Til7WeEBH908N+BH7NqXcIDIcsBM05H69iQhIUNbgJs0/FCfto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810348; c=relaxed/simple;
	bh=g8A01fZiMJ2FEVyrImx5TUU2wc3UfDutfJdaDibnSyw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qG+6LhMA17af4VZOCoFC/7omTGCbP33Icr0jkzXyN+O0bGG7F5ZS7d/9Iif294uKhTWuKBfGT7j3qKRXSN7QM57q2O/ef13ZwJXmsoBVKf4866g+PRt1mUbFSAL+dJQNq8FCkMC1Lgkji1V73ZakSVtm5sPQhlWnmhzSoT/vTY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M2TL6Gq9; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M2TL6Gq9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xY3lPbGCvALFvKg8QMxoVPL/V1q8ULCBlVZbAidUqZPI8bpO+Jcxv2PFyE3dOEooDeXVI2Cm33CFFqkXdznWdvU6LGTWzcK6PK9R6dNjpsR6iBpWnnhdb790QajCFqAp/+vS+rD+Ms7HjXdQdltOxU86enu2AcJmZG6PgmrbsErVAqp2UX7i/9HbB9VO9b6PkknG2WezbQqbWr09HBCb5wjRcy+eY9qs0G0b2m5hI0Ap7OHNHa8d5R0tmoSCTxM4jCkAOrZkxx5QhjLUSVUdrPk7L+rpNLD7cFh2/EJHdF1mvfNuW/5gXUsii+F+CcQz+nIZ9KKEEeIsko3AD05msA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guVufXUP0mAGwNZ8QdSuhHDcIZ3iMYwl9L8E2aaBn0E=;
 b=rvoHxfk2iTR2Wq+61mn9vvznEnXTJVg6dNWSuLPAMhjznWsNLnG+FWvWRxIL/L88E3JkhvXum4NyuBSDZez2nnbcwsOOkbLFSIdsTqnbRRZQCvOHvS2PXD7Ap/lTfmhadx+sWSWXsqFFVWauPIjalgLPoGDQvOgIJdnrDtJofsrN7FZqSKR+mBE4I2Za51UaDePmJ25MRnH8BWkqA6q79NRLqidDihwLN9QRtZkkhDPztd9SUFErNeemKUaI1idz86HExLc72pPoBBEJzjQdVMIYZIIQN9QSUe7YQuk/phyu1wlNV208WCLpXywAphzOhSxACLWRZH+PWmTAPYwtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guVufXUP0mAGwNZ8QdSuhHDcIZ3iMYwl9L8E2aaBn0E=;
 b=M2TL6Gq9/S0IJoY/ttx62ygP/Vz15xOoqtjVI8r7FVNSDupm0NlySGuDPZfqXSNUhOmNemhPNuC1SsTbrPb+9uy5qLPPL0LQkWhbhC+18XZBdq+K6fNONZnFbaXMMeRauSG8y/sAjNvpS7cDFpi4IOjNs4ImA3B1MtZtafOrLAE=
Received: from MW4PR02CA0015.namprd02.prod.outlook.com (2603:10b6:303:16d::6)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 12:39:00 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::3) by MW4PR02CA0015.outlook.office365.com
 (2603:10b6:303:16d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 12:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 12:38:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 07:38:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 07:38:58 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 07:38:51 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>, Russell King <linux@armlinux.org.uk>
CC: Shyam Pandey <radhey.shyam.pandey@xilinx.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<harini.katakam@amd.com>
Subject: [PATCH net-next 1/7] clk: Add devm_clk_bulk_get_enable()
Date: Thu, 23 Jul 2026 18:08:32 +0530
Message-ID: <20260723123838.125145-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260723123838.125145-1-suraj.gupta2@amd.com>
References: <20260723123838.125145-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c2cb04-dad0-4717-8b8c-08dee8b75eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|921020|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eaACfIfySPOob0GjLEkb8h5iZefD15hPRo3N4lA7qPN9puXiOzJzMpJT/anQuUreQP2AXvYCjDHOOcapDOwlI565Rsq0g+tqux/C7vbuOmOmZNysP+v981USVebbam7vZLEhtFT5vSRj5jDmNw5G0+Zr/LjCsB9ao+8x6YHb7PY7t/Z5nrhEJEh3EDrNUoZApw6u8yhJknHk7rChGbSFeWAFkr/ZFALttk8NtUrh39jkM0af4lGuLQrkxstqp0Bn7kbKK6+kHIBUeuRCTCA1mG8UC8oPyrHcFydST3wtFsUnjMzuIPwwCba5rDTFHWGXBFXuUTLfJyP245RdmFDXUTQo9XxEHoWZac7mjSIr+vFlXr7uSS9519F5NvKxESLKLoMHZizoMt+QhBUnu3SLLz44a0OfruVREcet0KTm+sj5BgI5LIjy/v/lpcqdWm5/AZUV6L8VeIlzj3hlPyzhnjZZk6YwhnNbAS2a6734XNxI3PYZ1athOx3PFXOjX1rgAR2MpQSF6O7ErChcO6duQoEKKJlhz7raIV2h4PZGwiHrDTex02OwI0jKL1VgFU96ok7bnUMzW4KQWXRhepuDrUoqXeOiqXHZRiV2izwOUCWDJAH/dQ2ckXpnaMDizufAHy/xd3GivaQwSVtRbt31RXU+Lz8c4ZfyklSLS5kU5t/pRKgxXVx75IbTwG+YxBm1ShmDqlVs3DNjLyiPEXdodCGq58WYQFVShmrPNcW7elJud9gVHX77AjHe8bat5YFE
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(921020)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	csaboYG2Z6cFa2MKCftkH/FhFuzuoIU4LzLIKRJGRwKPXQG4P/lL7BrBalXJAHWlRjkWu9JVCugFIrHUdSGlV25cO7Q5JvjCYpDamc4g9P72U0t/F5g4SNPD0KCCql0fP83fvZWcDrgc3vfpgdKUURSRGbuy/HnDAsgQCjqEoUxjVC1sZGZBX2bs3fP5GQttK+36/ZnPJFRFB7jaOuJhS0V5cgHz07Ubm51StA6MJrdlvCqmCxbHT+u5m2nBlkWQHTdWLUd+C0M76oTEINpqgyaZ5EkuTQE9efbvo2MTQhwluPaYVs2rEdyilH7kgSBRq9sNomNLWr1vH0s7rKQJXUZwP7+UBuNzBVItGb1xqAs1AfJOEbQz5cXIClX/F9rVt43DmJYl/2y5Ve5XyuVpsyHmtdEWF8M6wgFTODiExoLncZHjwrp7E0aNAu/7zzMw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 12:38:59.7430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c2cb04-dad0-4717-8b8c-08dee8b75eb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474

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

