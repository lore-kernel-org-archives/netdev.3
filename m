Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8223B6BF4
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237765; cv=fail; b=nt1kvzmImn06fQ+GEJkCPAB5ees4k3yOrvyRUNKnuHY68fCWAEwFWM3Hce/nGqDcWEBnHGgIdwUxIVJSjZ7Hn9AC/a9QyBMJs6O0YbkJ0gpCqlOvLlCeh9/BCcjvs9fJ20om2Vv+q2BWANY4AIjPQV9/GtNTtD3iluZviVvzVA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237765; c=relaxed/simple;
	bh=Wk/GQv9ogODoC5QSoPxjvg6DemWr+RgzHN9JN1SOGw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMhwKoSXhYi1+vCpJlC9s1bvjpYYsmjCqPCjxYrFZ6qT+EhvOiBESwPHMw33UpMWaX+6zlqc8zcMXF+t6m06ZFUmZihbr5YLQ1MKEhAXwnEdAgxLKGY9orhr8+Kg89/XroEkra+VEE9qoaaJeks2UVcFVK6bV9SMcEiLK44boTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aLeUZW4a; arc=fail smtp.client-ip=52.101.62.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aLeUZW4a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FS1MiCKlIDQKVlg5Abw9C0gazqiCJkiOb1ChhWzPgwdo8PIK6MSLg0cGTCA4MndlIaauvgZK0mEPJhpcG0PlXyAvV89qL28Ry9fUOSYqnfzXnla51yPXN74QYDrtf4YL2ade2ABFvaHpZ8OHAc+giQr1Hyl8lHk1KRp9A3zJC39JC/HZq+LqQDnvk6I8LH/U7yC/DHGdgNqeO8m4VkX3Et4wAe1oAH4GMZCPupln0iGybOEc6U6tRN9hYjoKoqSy+6alSY5vwCk2ZrBSTOTe4P75qaNFxgg/M6mKnEmo0uh9nJcQPNR0mwcjuOS+xo7Mv0WuekWbH9t6yEDh/ygZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRTIA2MZiOKMHEEoMfHdBYX6o17siQgIHZt9R+a7JEI=;
 b=Ik4vi/X14i1uUqC6+C0UV07FPA7neBJoNuvIz4kHqpjckAFWSLVcYnoGPFV5kFD0n4VPhGUBZMkv88g3RGv7ogS1K8O9zcPyXR2hAd++P0FbUbRHbmg+Of0onPv7fYCmET1csCsb7NICmc7WEZ3qi4J0B1/UMTjF1JEJHSPMhVo9LT+VA7LCTygBPfgQn8+zB2EEBCRovxfIqS/ec667w0j55rtf8KdV0XxZVQ8vPThlbZnYZjJf9pouvh0b/8YzTsC1Bo8RxVAcQ+3/ZrMUnXGGQyI8ozsFsfvPpV3KaaPsSXHbBDXeGkQu9Cj4dDIAkXM7K8jM1O44g8QXlPbF2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRTIA2MZiOKMHEEoMfHdBYX6o17siQgIHZt9R+a7JEI=;
 b=aLeUZW4aMOsc6vCxEd2c8gCtRNiy3yrs/A6L+FZDuCKqGp+Q8+pq1ELEH41CJKFwJxiqUtuuLaj/voj/OoatT6/vhi7dh6ysCPCiRpV8qOdVk3a7FGKMHPxW6T5ZeHf5ptXcMm0ymB69UdDFbma0foVGvFdGsF2yLdc866mbIYw=
Received: from SJ0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:2c0::33)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 04:42:40 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::47) by SJ0PR13CA0028.outlook.office365.com
 (2603:10b6:a03:2c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 04:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 04:42:39 +0000
Received: from lab223.rund-run.pensando.io (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 23:42:33 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <brett.creeley@amd.com>,
	<eric.joyner@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v3 2/3] pds_core: don't release PCI regions for VFs on reset
Date: Tue, 1 Sep 2026 04:42:18 +0000
Message-ID: <20260901044219.1361466-3-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901044219.1361466-1-nikhil.rao@amd.com>
References: <20260901044219.1361466-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c45357-2dcf-44d9-0ffb-08df07e37428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	beSJEVZwj3ExlsPcYln0CrA5A7BkF8veeRP13rUzrvYXhNAVaL9gnoo0y2m8H7nb30gkNrz7Htppvb4TNEpjpg7kFJpmMfw599F+he7o989J1LgYaXZHYSrmEeCFXKliLGFRU59U8MmwN96AgzDJENIT7cFK5xGfVLNpW4VO/929Nnl6Edl8LpCe/zwvvk9LMTSBlpMlfCBzqzPxzOdcTP/1j/zGW2tcLHERBBIaCDXFTCFZjb/E6vteVQp7Q1v1JhNOGnq9zOPyQVvrltnJSBj0ToiilrXaFjWwG8Oc70CCNHzOHyNzOHtgCgcSx/UaafPQHlaogdin2wuXfdYNI19ZHnPrGhlT2eLxfrXX499iFzQ2DR4q1e316msimNxiN7yZ0CxM+z51Syr/L/WYeUVcsqc83Ql2xQ5VF/AkL9OIOMjVIgjBxlUxaqZrIJ4RsGpc8Kz8ySIpjPpVjQcBdNmA3m7ca8L+tMgqVrwHyH8SJZ/jftmHY7oIahdoE4mM8hhr6K3fFOZVRiUXr2X1DgU25jsx/DqDMuYf6/S92k34SoAiPqfvvR6fPH97/Qck4Is3GeiT/592wO6XcGnYkpYrK98HxeR/wYuWyWHu3erz3/pv3kjtpUf789sD7YK0pAlMSYJgfj5mtC5Om+CK/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vj3KIVKxuUkakcL29BnZIduUO7WAxZlJpxCjTwsiQD3xhMjVHVosl+91i3hKf0DF0eW7WmIOU3LhBZBZKdBBRpmEXyqFiUHM/V6qQ/LbSFdt6NUYZ3H+4v3wj9jyc5NI3nSldISHHK7+WM9Cor8Sa2kt3Z1GGVkexvM5xGS+kX760F77bvoCXuEjm290r8/dOtiBGdl2HOA7w7ggjlkUuotMCEIXJ+hxQG4JkSLGb6CWCDiufTAjiUvRbWW657wc1HdRpPXpy34/L1TOB24F3mMFzXD9vXn25W4Ehn2FCZgDEAVi4CHNq6vmvxlBZF/BVIdfTTymiHaPGXzjnaa3QF7le6njbOsL6FX8UAGUOp+s/ljw3cX67cPJcs+o9ReccALVAfb6W3BtBzw4g3MvgXYYUPaXX2Q+T8sQWCyJn8P+qclyceCIq6BBHntD9Tns
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 04:42:39.6310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c45357-2dcf-44d9-0ffb-08df07e37428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481

pdsc_reset_prepare() called pci_release_regions() unconditionally, but
only PFs call pci_request_regions() (pdsc_init_pf). On a VF FLR this
makes the kernel warn "Trying to free nonexistent resource".

Fixes: ffa55858330f ("pds_core: implement pci reset handlers")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804235946.177762-1-nikhil.rao%40amd.com
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 6e1079f9ba0f..a971c66d36f9 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -517,8 +517,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
 		mutex_lock(&pdsc->devcmd_lock);
 		pdsc_unmap_bars(pdsc);
 		mutex_unlock(&pdsc->devcmd_lock);
+		pci_release_regions(pdev);
 	}
-	pci_release_regions(pdev);
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
 	pdsc_deferred_dma_free(pdsc);
-- 
2.43.0

