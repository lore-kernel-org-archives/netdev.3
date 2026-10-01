Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA0345EDD;
	Thu,  1 Oct 2026 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840868; cv=fail; b=Rr6BKRr7rylZMH/WsQPwGEfm5qhBWn6chDNtNPTaaknm1qgcoPrERn5FIKoFHfw0YqjFzV3G98UgBXNXf111gXm63gs2vCHUfCnTrP6IEI1Spf+Yi2gg8919pJ6jkoCV7cicCwC9uC2RGUgWGGtZNQIskze8UYCymGCyqeNFwok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840868; c=relaxed/simple;
	bh=GE7KEPwrdJrebA9K+ZffY72nqsxXJYH7ghHNM1OD7Ro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d/3JzNlJ/uPXcUggsUF2+YopekZxDt2iIQv+Vxe7Bhe8hpuGxsnLihBy2Ed19QjFcgk2Z939mLawYTLVf3N04Ll58T8LDo1hufggo1IoAS5IVaX8dZcWwAVK4cY1NmxKhGuUcAa3yyJg8tV+L/acOke8e926/FSo1h5g3bpQcac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ej3Rjb9L; arc=fail smtp.client-ip=52.101.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ej3Rjb9L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7FOOhmoeUCoYUjFhiLfvR2vIo6pxBfRGXHn335XbSLJhxnxl9UHUopgP8Ndu5918K9MZ7JUKq2z7iosAyp/crE90fi3QyTShuzqazU+WZ9FSU6BQMLLARF7KPnyD3JhHRfd5VzSTPS3fHMTPVJE6loytLGyQvBmM7ntP4ZWrOMUsoQXHB4lVnN8r1DDFzAOmmyRE9XMZKHPG+JekNVNNyd4+btaULSqvBA2EUul0A1bDSGd9OpKmY5FqC854izJWCA+11bJ1PI9+sVn5ebiy/A4ssaUXjXBPCxmk1iT42e6xNIwWYahUbvqV1qbv8yWVtCfwFV9kbkj/Xl8RRgppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxDo3HHzTovQhz6OrzPJHW7C4ZDzap2ESG/3oGegh3s=;
 b=HUrHjDKUFY6Y7fIq8RITWfVMhfacizKdaxJ29QtmaInw8ChtEw/22amGMCpoWBXWYEls9sAYaDHk9k7UMEqz5Rmua6yWUUrTY9z/NUZwMAO6YCdWNF+9Q32FPOiuZ37pD6ZoDIPpYBPPAI4U0Gfj9yyH51nkgqoK+S5VWs2/MLKeskym+z04n/tLOGkootM+I5LT3fAeTcu/uzwvTHu31iPWN0cEe0BEsSW85/+8ANdgDKoqAleCL7YN8CQBdxBt/CeEme1Y89OOskE5I21d45SHrDYvdqt4jBdnYjziTV9J3y7yM78zMbhhrmUCE6CqJJuNGOqJVqSdwnUZZH3QFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxDo3HHzTovQhz6OrzPJHW7C4ZDzap2ESG/3oGegh3s=;
 b=ej3Rjb9LgnKGM8rFC2b7AQ/UetGrmVqG8OMwDnwOhfdTwOIYTKd8sLHwpFBPrI2O3pvL8Xv5VNYShX4hgStFnppzSNCi96LbkKKoo2aPxPxCjIPnamZMVlKgDkuDtDkXbj9xyjaJ9RHFWw724kNi3VRkWu9bEIoVQd0YtAToqc8=
Received: from BN0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:e8::34)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 07:47:43 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::58) by BN0PR04CA0059.outlook.office365.com
 (2603:10b6:408:e8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 07:47:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Thu, 1 Oct 2026 07:47:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 02:47:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 02:47:41 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 02:47:37 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <netdev@vger.kernel.org>
CC: <vineeth.karumanchi@amd.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michal
 Simek" <michal.simek@amd.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Harini Katakam <harini.katakam@amd.com>, Kedareswara rao Appana
	<appanad@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/2] net: phy: xilinx-gmii2rgmii: Fix PHY data ownership and removal
Date: Thu, 1 Oct 2026 13:17:16 +0530
Message-ID: <20261001074718.3944521-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af96b1a-7cbb-4efa-bf80-08df1f9046eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	hJn8Kdq1Qa9WXwMuvKqdGIsrvTcmKzD4ARyGx4noQs9SN/jMguS3DhCWIOgrkapZYpaOhZkkiT9HSpPBVWy+Hm+qRwNW1RlbX57nXKLwgo2EHvpDzcXmS/CBgNMXu/XtU793zqRIisUUOU37AgPcfzUg1zb4KCDqdHQ3XRZN086Qy/YcQIxHovOLQyOFTapRKtiOhZFXEhpLLKm9et7TmZOY+hig/R13d65nTPXkQ0VHKOczkXIAxmatIaW6jslOoZE1qDPISp+GQ1pcNghDBQXnLm8f2Qrf+m50khPmUVn/EXjPPicYY6eKcGC1u5ViDpT/YBJtIxnv+R39f1OfLYj+XHLACyqwn0jE35N1G/d6Ah4BDLjk3aZwDpj5zfbFW04GSMvKD6euMmwvZ91kf8+EWU8M3dkpG/gu74nUR5TAp/uYDagdCCOsm9gANNUQEPXp87I1T479FBMiBHX6M6Yc4M7NGLzagt/j71l5Qmifq2em5kjgn1M1AArBN4Z+mHrTM9+cRDxLEZNu3KbLfdC5hVj83GuXvZwDX7uCoIxuPfRMpcYue7qaAWklFp2tYY239a4ZEcTfzTqczDnRq4mcxqII4QqWMxEZM7ydn23Q6bc/Uxb0lFtCw6jhX+LzQ+idECTlyJga813I62Zu0rHRtdVoHjIlpeHwBh+rhu2l8LEy2Wvmf3MKDXRH+0oYcCHyYrT1KVexJKi6z5glBQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yUQ3r92BukRBaY+FQRC1PLyvlhcu1kf4nMAhq4lEhnatrhkXsUR8PCtj9WNTPFtS1rv17DDSli0s6xUWtrXg/M/N4tXGbufDomnhEZ5hD8Wu+YQe43GP8A47Cjs5kYuEgFDjkK/uiwBP4fVNe7uBNH2bmy3lc39u/qyKcMTNbLj52DkEs1Z1ks8eCJOOrwt43AzUcMKaENikhF6WcVIKJPrqAfII2pf/Vu82GSjORzbEjttoO+U3qAGjybee0+qGmU5u+O/j4AmeS1evN0zzoQTyIr0enmkqt1YSO6bRcwgQ0qOWaUa/FyKBrOpTmRGFBuP7SmFO/dc6ShHBvFyDat6oM3WEojwYbGetPyc55uA6aOTVroc/Yt94h5HOXK26RgKGUJGP5KRWvBGQ5US4c8giFpnRZ8JaTtNM8vovyOFFv2uwnrw6NLkjnwa2loRB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:47:43.5074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af96b1a-7cbb-4efa-bf80-08df1f9046eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

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
and releases the reference acquired by of_phy_find_device(). This addresses
the stale pointer observed during PHY state-machine polling after
converter-only unbind. The missing removal cleanup dates back to commit
f411a6160bd4 ("net: phy: Add gmiitorgmii converter support"). Apply the
patches in order.

Vineeth Karumanchi (2):
  net: phy: xilinx-gmii2rgmii: Avoid overwriting PHY drvdata
  net: phy: xilinx-gmii2rgmii: Restore PHY driver on remove

 drivers/net/phy/xilinx_gmii2rgmii.c | 31 +++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)


base-commit: 7375d38364a9aa66fb31716bcefef38aecad75d8
-- 
2.43.0

