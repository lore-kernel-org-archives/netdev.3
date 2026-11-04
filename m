Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793755959;
	b=bmbtGovjDSLZfm9vaNBjPYCpZRd/8ylPgVTQ9iR6qt1AqTmvraLrxnCClL+K9Akx1cm6
	 m4H+peJ0krmcZUBkylUkF1A5zNP4TFRBxlxyCuP1/92eEvWQwvN8RC7w/kTs78u+ur9cL
	 Sa6p8x8QM0dNiLmp53OWI6yOB20qSbe7hQbKlYhVxWAjwY6fgb1OytxBpfB/ccU2zURh7
	 DlVzODE2t/3RU2DWg9xLAfWzjLcms/tf61uvk8Cbbkd1bGU+Mw710AqWDlcXtgBy2LKEK
	 fYMzCW5RaBPrbLu67xPyK5L4UFs5r7nLM7mGEsk2133OvqBbyL4v2klQtASV3uyimGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755959;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ESZOYinYnRXo9lpsj5rolSEFEdee5qBikhWfjsCw4k8=;
	b=NZIjr6p957a7OrKs8EhXOxJTiu0fXQaRByO7w4xqtZNlHyIk4+iinQRnyQj5cCtTnPv7
	 zTXCinIv1WpwNOXDHIMqY9AyoTodQD3dleC18AGAAgFxB0bPn/+d1W3zUaex3A5zpKej3
	 jI1KCrso4X63GFD1wo09Tm9DkQoPEvp0X3vjdiGfSJc9vPkzJ0pbBngWHzoEPiNATUofy
	 Jaoa8TUyA1y8VGoHK/qpIOwKI3V6W8CvLBKAdEHL30soczZLuGSlCZh5J2+uIZtGjxEW4
	 zoOfP5HVu/ijbnNbGLlHvbYKjR+tcoFCglJogDWf119hcq/K+J9tXYTQtDB3tFGmr9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aMam1xBy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.29
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D18606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 01:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13D18606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aMam1xBy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRhAzzWXa0c7zDrWrNekrFOFLO/FfgFeZyYNuSiDkZi2IT/GJbHZS72qTKveDUv21DIib9f9lH854biD/a3cOMBNle5TXOlG6gBWeRgaomBUF3DaHRCJhzZkNa4I4D6XGySoXljGfH9b6Lr3aZYtw0jUtnpFDB6883U+KZa4dYWkDRYej5lKYfuZZs+J10S816YBver3Qkv12RE0k2uh1qKZjf0ovy493pgQN4xrRXlCJofuTBkgyrhOvM5kH1TwF8ewEAeygLYaLsnaUePFJB3scd8XnIe9OxcYY4VCTUVToj87727vbxtcOWKEizMwgl2WoWlHn0r0NUEjMdGNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESZOYinYnRXo9lpsj5rolSEFEdee5qBikhWfjsCw4k8=;
 b=vkxsTQ38B/E4dQATYKV/hVIhdjpdfd6rhG1buVgsrl8NdRQ/kKcvO02bX37bHU6MwEcZIdQ67INtKid65O5gcjvnFrOI0xOsmfPG0II8i+BZR9HBw8txnpoBborWDC8yB89J7zgnQsQXfUtBBq/hmvEM1hRkz+leXOBmX+JvHaUcwnVuEkF+JMdmjqyM7Sw6jPGO4dWDQWtdCHT8v/iEg7ed0SwHbMCjZaAqjcPSgo9iQfcfydK8V5R0BwxtzxX7lDMiNcvpBbhW85SXL4T756TnqDM+j/6o5W9hofiyuudf9aJXu5b+Yd1D0dCUfUiPchbx2sxzs7Z4NqmqrfEvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESZOYinYnRXo9lpsj5rolSEFEdee5qBikhWfjsCw4k8=;
 b=aMam1xByB/43FT0oF77wop6bPD143TnuxACuZo0iiqcqKyjkTSCu+6HEDHx1KS57cihVfsodmG4Ud38D/oJ1hCxVfR+sX3VpajUPf/gTCIhptoCetwzit6qKqg4Fk2aLP8/7VV5bjlcMZwkRXtsDrahXFP6dTSuSAgT3yUAHAVI=
Received: from PH8PR20CA0008.namprd20.prod.outlook.com (2603:10b6:510:23c::18)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 01:32:32 +0000
Received: from PH2PEPF00048912.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::7b) by PH8PR20CA0008.outlook.office365.com
 (2603:10b6:510:23c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 01:32:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048912.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 01:32:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 19:32:31 -0600
Received: from xcbecree50x.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 19:32:30 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net] MAINTAINERS: remove and replace myself as sfc maintainer
Date: Wed, 4 Nov 2026 01:31:38 +0000
Message-ID: <20261104013138.4103896-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048912:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: ad336933-1015-498b-950c-08df3a137f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|261021121427099003|261021123027099003|261022105027099003|261028144727099003|261026140227099003|11063799006|18002099003|261102123227099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	aGW6B4FQSbg0U8Ueori08VuAYxebWGHO1kNPkngOmDL4oF5Ve5Yg6IOscyDgyyJJpKdH0SwDK5G2uKT0n89eYJvAYTfR0EAurExhPqjxe3gAhHLU+WIVpFO1bBDqo/BFkkz1G/lamH016Gop4p9IULSjcihOwE0gCuosVCq1LVlwPDK4vWdGk0eDekd6RKz31Qn3+0s0nN5BN3Nlgk4bxKFB1aQ7DXUi4Dl2DEGGJb0FcvhT4f5LhfuweDWCvHWKTvbjQeCafAAGuL1XfzWcneb+uQ4UMi1Tt7o1NfRlwj6QbPurOv/6/VIqW/tunU68FtgeD4bT+yYxuPT++WW7jhgQarhT48jvN/KykFxY9a47KyRO9FzESSk/mYUB2grMlLHKQRKCIScheRMXpN28QJry70CVri6F8qjkcRGC8Mx4RdDGsTkaE4pEg/xK5i79ZUIAxDNMQRk5Y6ec3NV/jMJNshUJToT2SUuXgQfj0bMmsT2Lqru+WAZenot57Km5TgKk4+5+EubY33YdNc+H4djOiE1CddoutStg8sxEwaIbgHDU9dyahlMGpJ5UqDi2cEdzvVVDK7/sh981Fzpv7TwN5/oNrWJzu/Qc59Z5eT3hwKt6SBiyFCSJ6gmDncKHFKutZPrXZHVqhsAIEc5bVR/Y//WqAOJKL3CaWlxzZEmSaeYQ6nXcj/36KPq0+9tTnkGMz9DiHgunNtLnvRFbjw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261028144727099003)(261026140227099003)(11063799006)(18002099003)(261102123227099003)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J0LzUTRaAH2UqCSS8/N78abMmnvdkx2t/JdAjKTeGghuyQhAzMsaK7cSCUcRd3dbZ9Y1CSu4ERc0y9t/68qQjmjC0YWF3JjoZ4tocrOqrKkG70iqJjh5lx6TVMHJN5kcu7WV94D0Ke0m0qz0lxY+3M3M6yjqziaw0wV1ic5VWDmPI2Ifa/VV8YgPM/UIV6KpDm4sTtfOu6cbnMHxpMv390yTrKBYSDWlfUYmkQ+7345s+5TnYYGT5Y/PFQunjzD0XKiViD3Oj04UOTu8h1c683uvwxujYgAse17z8t3IJijV5CAyUYiOKSasDQ7NqT/wcxHKn3o8AqCl8f0GpjJykqQ6xgf0gHLwfQpmeYsTwRLZAY6ZHsHnGGqh918QHa6nE6vtEzDpTveKBGcVuKg08DswbQ6yDvxoTHJWusQn5XjfumSmVDFaEv+u2eiCdWIn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 01:32:32.0622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad336933-1015-498b-950c-08df3a137f1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH2PEPF00048912.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260

From: Edward Cree <ecree.xilinx@gmail.com>

I will be retiring this month, so it is time to hand over the baton
 after a decade maintaining the Solarflare drivers.
Remove my M: line, and add Alex and Andy as the new maintainers.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09713dc4c6a7..4d43d3559960 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25465,7 +25465,8 @@ F:	drivers/slimbus/
 F:	include/linux/slimbus.h
 
 SFC NETWORK DRIVER
-M:	Edward Cree <ecree.xilinx@gmail.com>
+M:	Alex Austin <alex.austin@amd.com>
+M:	Andy Moreton <andy.moreton@amd.com>
 L:	netdev@vger.kernel.org
 L:	linux-net-drivers@amd.com
 S:	Maintained
