Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729BE1DFDA1;
	Wed,  7 Oct 2026 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352141; cv=fail; b=pMW4SCJ/eJifNL5oG7XOcIVQUKTzD14JXU8f5kRkYG0+sovfsJ293CwOLuo6RcNqjaTjwTBSg8/Rav6aRCCLkluhFAbY1yVd8YEVhegxsLgK2o1DNpY57eX6BBg50XaQQ8wJjtVELsUnu5l9UQSljfwA0Ba7Lvdl9rrIqEKTLik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352141; c=relaxed/simple;
	bh=Gj23Hx0vB6JwuZ/NQkY4i5AojyhEQguMuf8KDd8fjbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LbATn4c+aM/GaLX2EoHXVyEdacM0sl3n8KbtT8C3jvMnoJjK/5MpRIHv+vENKaStnt77lXVaHN+NfnIaIwOPbvClPOCQ9fMqJYDzeh5DUqlsW5TvpvFl2OEdlnHA0sgw9pNHm/GiRkI2mXjE3OYQIK3wLdnSeGIEjhvzXR/2kJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=npMmpVgI; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="npMmpVgI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSm0xMiLMQ6tQlllwzQYd6QdeKx9ILu7rAjl2S0iEbLaebrktV+0/XOOQKeXpyY8zAIjBBpnkmEf2q3OifrYFD2fNNxKQcWYAGLtDaMJmN3l13Qm1wuyvdjC7gBEB3O9yV2Sf//JGmUCfydZnPyzX56tCf9PDVmwEpTuggvA0d+HGAD93P6uAoPhMtUK8g81pWbU6b9ZtGqA6RmDqWzFMUk5uUkWm8bJeKPLS8bMvO6zXOGmndkmQyyNG5zuqtbGaiRNg9nELf9mZY5eheL1XteFLLuh+DDn0oDpdlDlfYWh86O0R4b2dbQHV82UI/4OhUoY0wANyq/0Rqjo0exo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+y6WpFaqquTAyp4n/98ZdRYvChT3qqeDCQJSzzxC4U=;
 b=WYutH78lhFEDQx+MfbGPiGGC59Z2fmnrhLoc+JNprEbPSMuewXYuqYcjnur7zMhCe5vzXY8V1tD/IL0yf4VzU3emOioGRTTnpzGp+XoG4aM5Sws7dG0/ZdrhwrLzpoCN9wgbqwyBoenklTAm+6hGFMa/WpcFZHG8tBXY+HtD54YkKLOlSzacegPipJhSO7LgZe/Cs+QtKvISs4J0MOMASSQPx30egfZWglKoB3FeAYcRvRkHeBb0ejtIgYzQ0vmDLYR3Y/RRHhm0p311RHKyeneFJA4QeNmhpQnerugbVbRopbIHg3IRcWEN0WBRr4kX/36nwFfM5fbEPUbgMVw18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+y6WpFaqquTAyp4n/98ZdRYvChT3qqeDCQJSzzxC4U=;
 b=npMmpVgInfZ+hljhZYfIdNlj777MqUTOm3FBqEOiK9gdu7jjTjqZepaVIT+s36l6SP8X7vexaSP/wgfpbqrtTCV/dUH2WxaICcs/YnTXC3PZZRWoefAG5hrOKm4sgmvTTJkr7BkzoFDkgtFp8GCWdEPuIwI/r7xVYS9k3PziueY=
Received: from DS1P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:44b::7) by
 CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.23; Wed, 7 Oct 2026 05:48:56 +0000
Received: from CY7PEPF000000EA.namprd04.prod.outlook.com
 (2603:10b6:8:44b:cafe::16) by DS1P222CA0019.outlook.office365.com
 (2603:10b6:8:44b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 05:48:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY7PEPF000000EA.mail.protection.outlook.com (10.167.247.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 05:48:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 00:48:53 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 00:48:49 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek
	<michal.simek@amd.com>, Harini Katakam <harini.katakam@xilinx.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>, Kedareswara rao Appana <appanad@xilinx.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <vineeth.karumanchi@amd.com>, <git@amd.com>
Subject: [PATCH net v2 0/2] net: phy: xilinx-gmii2rgmii: Fix PHY data ownership and removal
Date: Wed, 7 Oct 2026 11:18:42 +0530
Message-ID: <20261007054844.529363-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000EA:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 5120395a-826a-431f-d95f-08df2436accb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|23010399003|82310400026|1800799024|921020|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Gd2Z3LIRtQ2oP0IEL2McFEY04XEWZ5rt0H+G64iWIh2iOA5K+vcKB0OaMSChIjQj+1PKiw+W8T8Xtp4T4nRYSeJ4U8u/bBInruf7gME4iaFvxuylS7JvpZ1zdUUl/tyY0ujXw7OnMPbmnfQvJ9o+nOQNjCVcvMu3aKZ0qss3DFXVIPGXbBiOkpEHzki1Br1l2E8VwTR1+kDhmGQSiF3V5jetixIW+oDZzZ89Hmj28TKyFF9TCOGOoXhtSABSwKpIdBLhgIYbCyX9fBMkQPCT0k9g0jmEBuFudwvdXE59WaJAnqjVxfV0WB4Am2KX3kuEYw94SftjODiZazUl07GFzYe4pPYjSLPLJWR8XzE5KXW1dgw3ykYNKOpvjd3cq74JsiAqhoB6kCjhMiS+4ujgP5AhYphwkoe1FylR4/G6n0YzSUgxsCSA0IH96X1KZ48fV+IG+ma+EkgPrVKSRud7tDKtU31QKaVRznSjz5vdLT8JIxXmUxEKzUwqxTwJe+Qqa5zAWap43gOe+qnjVWqPEaXK7fZSNHSmB+O38Oqjmb0wK+cAN6pC2UCFmmVWOfc1H3AOrE9xTtyim3dXbSSQ0OgNPgSKh4UG6PQ2tJx1J5AfHsfJMAp9Skt+/t0ykBG1fc9fahKdAQtuhtJU4MgM3nZJ6OW6vQAELj0/dHWJ6QEpCDOMtHPBG2WREReACtX5ElknLRE1+lrkaPAfRBjOK7twyhOTkbrOKuRsk/MZBuKCY4Gisyt2ZQaOlO6ghpFA
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(23010399003)(82310400026)(1800799024)(921020)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JpxAPN7zKATCBIVG8n5MQlAPy7LtqDtriOcFkFb9Dahxr7yqo6oizGir2qBj90xSCKBV1hzXuaHN5NQVR7Mm3/YH+MNg40XpYZjl0omkeKnhgX2sbIM1AaxyQHAi6By0DwsCJ+xdU+rgFMsXOGo+c+ucoGZtp4Tri4ZilADoRB327e8H1wnRDV8KjloKxOlX2krA3MPmfIAea0fgM18L16D+W3BjiR9S+x9HzsSIIoNAl5ODUFV9vQbeDTfUtSEc0Sj0f8lIgvj23GNZW7M/LlZhsrEFVhehpuiJeZN0aofCm/X0PuRGHkSA97pETp8ymfX59SHbekblrH9EVZjNF4McohiDndbbYY4MlRgFz/F5RWIgGCaVZf47LQg0TsBl8ocWupMdGb7W2aOkVp91xZEFIcsC51/feUzuVxw1BTtG5cMMEnNwPUIBvk13k+e5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 05:48:55.4878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5120395a-826a-431f-d95f-08df2436accb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000EA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623

The Xilinx GMII-to-RGMII converter copies the attached PHY driver and
replaces its read_status and set_loopback callbacks. This series addresses
two problems in that arrangement: overwriting driver data belonging to
the external PHY, and leaving phydev->drv pointing at freed converter
memory after converter removal.

Patch 1 retrieves the converter private data from its embedded phy_driver
using container_of_const(), preserving the external PHY's MDIO driver-data
field. It fixes the overwrite introduced by commit 168f7a161608 ("net: phy:
gmii2rgmii: Dont use priv field in phy device").

Patch 2 stores private data on the converter's own MDIO device and adds a
remove callback. It restores the original PHY driver under phydev->lock
only if the converter's copy is still installed, and releases the reference
acquired by of_phy_find_device(). This addresses the stale pointer observed
during PHY state-machine polling after converter-only unbind. The missing
removal cleanup dates back to commit f411a6160bd4 ("net: phy: Add
gmiitorgmii converter support"). Apply the patches in order.

Changes in v2:
- Patch 1: unchanged.
- Patch 2: restore the original PHY driver only if phydev->drv still
  points to the converter's copy.
- Patch 2: update the comment and commit message to describe serialization
  against PHY callbacks that hold phydev->lock.

Link to v1: https://lore.kernel.org/netdev/20261001074718.3944521-1-vineeth.karumanchi@amd.com/

Vineeth Karumanchi (2):
  net: phy: xilinx-gmii2rgmii: Avoid overwriting PHY drvdata
  net: phy: xilinx-gmii2rgmii: Restore PHY driver on remove

 drivers/net/phy/xilinx_gmii2rgmii.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)


base-commit: 23609bce9e1de525d1d0e73fc68c6e7971d0b49e
-- 
2.43.0

