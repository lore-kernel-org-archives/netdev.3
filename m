Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7734397E92;
	Mon,  3 Aug 2026 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738527; cv=fail; b=inCNRaxTpGqKjHfFLmMu+vG+sZ4vneXJeS2yoe1iu6+wUVRXMnj+5P0d8waaviV8LtHWR8ZSvJW8WzkzqRBYBGjZGL0PASB1lROk/rwcY2LMdH7+y5ihc97p3kVexZ3/NWiH2bBKI7jmxsg1JOc0Mw7RE/sEd146uGcENZEqucw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738527; c=relaxed/simple;
	bh=rw5PYLZMhj0i4b5mAOvHWlrNjuwrYmMsIXsdGacR0hc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CCDUGQah5loMWOz1H/Z/4MMl58TczJh93ysatL1h2l3uEf0PsFGLLGUX+57FpzUP3vEoP/x8UJmyuTUsCI95k6UCQbuImXhJEiCl9ysQJUpeZV88MRe8+DvqJzT4kjcSW/fuyy7Xj5fi5rYXd6GWnG/2pFNaEipOt/HYd+YtNKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CADRkWsk; arc=fail smtp.client-ip=52.101.48.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CADRkWsk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOTtyM9W7H/5axfsR5UbeBrX5KR5sl6zTQUc2sx6FhjAdU3OikRGz2J47c8pmsU6/8Y+x6paZOjWsblWIZBLs5iQiz91Mye27KLO1LTRZzoYxKZ+SDBsEouaYiXd8oBaIzhDbRIGXfaUF24YGGX8uD3c7NmGzwyQKxyUFbvq+6Mvaiwr03HnNeSsDtPoQJocv70S0ENjiiByls8Ms156hMmIFcxe9OPSZTY0nXmQjFqv6M86OoPuJ8435N0bdbrwbgh49dsQxCZjiYHPlUr7X3sWNyMYc15ovjLxZSmhYUvqFeS0liHdJXpQlsvyCNfEW5F3t8h1JAkUMkkJk6ZWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrqXku1fvNa6WSQmk9wRr2lmr2FJ+moa+DVjWToUKi4=;
 b=TZtswhWfowkTCi/QVxDE3wZ0LZnPUCp4GxWVbvOlqvQNubE6DcVn3xaHCvaAOHMQ0pIeyjlTnZ98SXlOjvIH5eiDcSItuZvUDBOfPtU8/sG4Hd1lde1cIovkPp+gIlI2PMGUtYrXXaGijsRWy2wropa1J3TeHyV7Vy2PVU3vAxnW+KIvZN985TYn7fBM+kVwzVjw7ZDxRZNejLo1jm5ssXtJnoms3fY0DtiVQrNEoSKbTNXLMpZsM51SdmpjQVq43W+ABFb8dxu+S/3LqKfNc7wrqW0ek4KYLv84+w48/tvAYB5RIIYPi1rj/Bl8e97IevDlp2vxSeBdSpZA0AFUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrqXku1fvNa6WSQmk9wRr2lmr2FJ+moa+DVjWToUKi4=;
 b=CADRkWskVAPBnDUpap2yblgC0iXpoY7GVKyLiU1otu/z5RGajDQYTXITQOyOxTALCt01TvxuyiJJxT+DMf1mx7qHxnAxSKQcO4jLeKLoZ10fGBA8fqtCD/0yeQNUcT6CCm7GNeLqTT3u16itiS+gTS0CtGo2n6YpFgNXYRZ+1F4=
Received: from BY5PR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:1d0::23)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 06:28:42 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::ac) by BY5PR04CA0013.outlook.office365.com
 (2603:10b6:a03:1d0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 06:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 06:28:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 01:28:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 01:28:37 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 3 Aug 2026 01:28:34 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] net: macb: remove unused ENST Q0/Q1 time register defines
Date: Mon, 3 Aug 2026 11:58:34 +0530
Message-ID: <20260803062834.3865755-1-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.44.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: fb201970-9b58-4253-1f54-08def128757e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	30BtDpsE5SWMg2z3n9NABCXoxc8UDO/knF1yl6fqxlefRLju6MkfutenEx9MdTyX5KUU8k5l1kx1EfXSfncTslGaAAsNrs0fEURcFA9T8whpx4bk9UBX7sRZLD6mTbttguziWRElfZF4DGSQHkwihrCcuOH4XvQWMJ2XN0lEYgE4jRdys4PDVT0ydg03Z4mYdVWenDWTm4+VGoizRvEOrAZsamqiU5Mtw0qIyNvv43NIeCCNgvBW8d9r5Z+OO4kvPM7i89M2+adnwpw0vLklUFV7TUtJ4iY/MK9AJYAbHTm6IYVzfHU1wGhNiL6AB9NmRV7dj272L6umGLstnfQBgGd6whCIYYnCVsqL3VHXV0k+PMznJsOJq75vVXxjxraWtvuVLJJe1mpWXlWcfxLEEGKZXaHv+eninmBoqaq/rTtNeALMjacALG95MegbRWhlJjo/ej+xBkqFzpKMMjcGn5regg8mNSGNIMQ66scuFv4bPl4xepqskvH5dwbMISB/5y9Sbetd4a8c4YmQ3gplzROy3eVyv4NgSA+L9kq+DVtQIIL5kTrXODDKe/K8BsUMtRYAdopvw9QrFi6QP8pik42nWRK9yTSrgtOICwnDty9hGYGeKl8ak+fsVHVZBE8dY28bPpxWlrL4x+w1qyCNy0UFRYpQW899n8kcu+twjhiNU3MxEFAoWZzfa7O1NAapFypQi83w+U3dvgP5H1Fetw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	75JHs/DNf7D7vXuX6QYteg1DYHpQo4Wine/xwEzIrwn3jyZ9zAihJwZd4yYFA5fa7qtOpnvahy69uRHebd69o9XblGIP/sQ3Eismo9v3fF4zwhdvopf92MmiyCchW/x/b5oPgsGlcI894iV+n/L9VVIoXXkR934QMuXGxB447UDI8XE/n/1N5DhO3CeHebbVbEcy9wOBLxYgWUsnJ4vHQWYQ6o/anOaMgp91bIPwy1hVd5WH32OrbDR9lnKudDRMQb7u1pUfKgFQDjysF0+VDIK7CMvAPyeT6iOl+qnCDvKxen28gGvw04n7Vnb3zV9RvwlFug3Rfg3CviVEWX/kjbJVT1KYn7pQIeHc1xbMdE+8LHEI3QXyBsVIr7TDtSEqAhNlUK/FQrOnYKwlXUwLXuqiWMpYAFNbrQjSvOyVMX0stxQK9dUrg5E9kQG1NDSi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 06:28:40.4682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb201970-9b58-4253-1f54-08def128757e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

The ENST start/on/off time register definitions for Q0 and Q1 are not
referenced anywhere in the driver. The driver calculates these register
addresses from the ENST base offset and the queue index instead of using
fixed defines, removing the unused macros.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Changes in v2:
- Split the patches for net and net-next.
- Link to v1 : https://lore.kernel.org/netdev/20260724043257.2221030-1-vineeth.karumanchi@amd.com/
---
 drivers/net/ethernet/cadence/macb.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2de56017ee0d..a11052565436 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -184,12 +184,6 @@
 #define GEM_DCFG8		0x029C /* Design Config 8 */
 #define GEM_DCFG10		0x02A4 /* Design Config 10 */
 #define GEM_DCFG12		0x02AC /* Design Config 12 */
-#define GEM_ENST_START_TIME_Q0	0x0800 /* ENST Q0 start time */
-#define GEM_ENST_START_TIME_Q1	0x0804 /* ENST Q1 start time */
-#define GEM_ENST_ON_TIME_Q0	0x0820 /* ENST Q0 on time */
-#define GEM_ENST_ON_TIME_Q1	0x0824 /* ENST Q1 on time */
-#define GEM_ENST_OFF_TIME_Q0	0x0840 /* ENST Q0 off time */
-#define GEM_ENST_OFF_TIME_Q1	0x0844 /* ENST Q1 off time */
 #define GEM_ENST_CONTROL	0x0880 /* ENST control register */
 #define GEM_USX_CONTROL		0x0A80 /* High speed PCS control register */
 #define GEM_USX_STATUS		0x0A88 /* High speed PCS status register */
-- 
2.44.4

