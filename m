Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011050.outbound.protection.outlook.com [40.107.130.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0D2ED16D;
	Mon, 27 Jul 2026 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161078; cv=fail; b=LAcyEhZdwFyyRmN5jWPVObxzxpNC6tmWWOl/XYDTKMjJ7ib+fZDaHVbibyxflrVZ1GFWYKFOlnDnoITTrH+AJ4+hTJrhlWbjlJvczN6qqeBMQE1tRnenH6erJqiK9ddlfI1l2xA4s75W+OD98yzheSIF+htCOisImjRm9H82OJQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161078; c=relaxed/simple;
	bh=Jud9JKJBjRXXRx+qrKRrqxr288xSd/UORMGfP2pdl2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LuQp2IJRu0JpVQmIIkK+fdToktElLXddHCRLqc3zCt0jLauUh82Y3KMA+xho/InRteGfHW9hX1jLF4p7O6TTNFQwlmOPmprCZcAkJDpdkBZ/pVZLbvgmrGW5lV0py8cY2IMqEDuEw5TAzoQAF5AB+hxgXbiFRinEKn2cRsfdgAw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MnKIeM1M; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MnKIeM1M; arc=fail smtp.client-ip=40.107.130.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MnKIeM1M";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MnKIeM1M"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xQF2Uh8qe5EqkaEjuu5+gc4a6YrMmpAumk0RFQgYNys+5rCB/NqhRDVki9E9PqfHqalaSU7hpFZsR/W9EX4FnMDA/D3SCA3pdnzuRPWfjMDUE/HbGHcJYWiWezpELamkNtXL/PCM0Pj2qHjLgeVl4DjUpaOS0xrBFDIUaqYdxZJ8+rAHuhfdJOCyLrNtYJb4nJ6sQ+sbwxSMBH9gs+xjcl4EPsD4FM+7ZjvzSWTMwtcHiIoAhpH2XE1HxNJx/Z0q4ZcRr/m3PUQBBCg6i2C1+EhDg86++OsQHKxp6KvMdpNd3lTsYrG7+Oy1eIotQfEiaJ7hgcEb9l7sJgIIlonoPw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFkcjfk9pICqjbm0xBsv6mv6Be8dONd19CF+99Hz9Ss=;
 b=MugKv4EbmkV3kyA5QdZxTyn+vo7NRP1wzz7AkgdDGLHU+cganQfEI7bp5gIGhMGi9dk0cGLGGPscBDgctSL2fbpdF6Vh1YTsCTbgafG/fA5Y7j1N8M4ABUyc2OqE8Q8TuU61UOgWTY8Epg/DPCtb5w7xfVjQbf6ruuXh+VGg5YwDOKL7VJJxoj+mbUusu2VLiL29a29pTLVgJmGuy+xTEi6jwzxD/7oAqf6k7hF2VEv1mmmQbNkgYeIIC3KiQNB4Zq0USdJ+KSfhl76EICIVOzrWqocmZzhAs9KdyUVKcnXZELGTBI6Ot5X3t6ENi45+B3sCMD6/PwRQKnkiot2S2Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=pm.waw.pl smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFkcjfk9pICqjbm0xBsv6mv6Be8dONd19CF+99Hz9Ss=;
 b=MnKIeM1Mlnps1POo6UbEVLYuRp381k05S9YrBakroq9RPzM4FvZaoH3RRC7fyfoURPKZJlIWMI0SWrPEdnijlapHRgwHkRMJQM6z718fzV5iMhYkKmcmVgg8WdT0Xu5pNdPPyqdXDd5pBY5vYMLGvmZj2e2VSapqqrQ79cDA0Ks=
Received: from AM0PR10CA0050.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::30)
 by AS8PR08MB9837.eurprd08.prod.outlook.com (2603:10a6:20b:616::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:04:27 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:20b:150:cafe::17) by AM0PR10CA0050.outlook.office365.com
 (2603:10a6:20b:150::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 14:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Mon, 27 Jul 2026 14:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m27OO0MFaRUmRP1n6tkZ//CRlBehAMaDr+5QNFxm7+BG/gQlfDQ4FINldxaC8kxooEbiNDY5vhmdOD0Pn9UoGolg/IYqEJcm3cXk6fI12R2gk8BquDrY/7TqfTLpyAyXvUMvqiJZIcBrwO+eFZ9TGMuPfPFFT6B6z/qlxYCGnCUHrngj32UiKRTzBNG5qMgZfQ/c4DDYoZeOFpZbxakV+jj2ZouFdpXtFNSRWd7ASpkE+/uHl8iR8onAt+qVaPh5We3QAtKMPVYhcWV+h1S4QOWK8fL8jOHyi2Liim9KGAUS5P87PZiccR46S7aS70WF1m8D5buc7ri/tplJzjD8Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFkcjfk9pICqjbm0xBsv6mv6Be8dONd19CF+99Hz9Ss=;
 b=T9iJVA0jPnDdInKvMtFFhynKX+ljKoIKHsyFLENL3vdwQGYpoBus2O//LN6+qLGnzloJ1REh7MYY25SQ/Aus5/FJrrEoOeiXDrsROckvDaJEHVy+zsmtYMBb5C3QPQ4PvvUhCTWK5UANh24GVF2J7wWSOk52mYjsdFWu6kV9ZPcYELztUMzxDJp9LoWKHpyCGSIliOqQAfNEyfc/xGIOSFRWQn6lGG91V0ocBaSb6o438rYOPSPqv8tUwSbJv48fWFrX38/twVNAHqrWNpxqNdoaPrxM9WSqF2WrEkswBM1CmPDosUCmhYh4EDORHijkcGBb2LuSJODRcBBwnvGKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFkcjfk9pICqjbm0xBsv6mv6Be8dONd19CF+99Hz9Ss=;
 b=MnKIeM1Mlnps1POo6UbEVLYuRp381k05S9YrBakroq9RPzM4FvZaoH3RRC7fyfoURPKZJlIWMI0SWrPEdnijlapHRgwHkRMJQM6z718fzV5iMhYkKmcmVgg8WdT0Xu5pNdPPyqdXDd5pBY5vYMLGvmZj2e2VSapqqrQ79cDA0Ks=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by GV1PR08MB8377.eurprd08.prod.outlook.com
 (2603:10a6:150:a6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:03:22 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:03:21 +0000
From: Bence Csokas <bence.csokas@arm.com>
To: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bence Csokas <bence.csokas@arm.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2] wanxl: Remove pci_map_single_debug()
Date: Mon, 27 Jul 2026 16:02:07 +0200
Message-ID: <20260727-wanxl-cleanup-v2-1-3826430829c9@arm.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260427-wanxl-cleanup-7e59607dc4f9
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0006.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::12) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10455:EE_|GV1PR08MB8377:EE_|DB3PEPF00008860:EE_|AS8PR08MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 7213c708-0d33-42f1-f72f-08deebe7f74c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 rQfo3LJM9pOgHDFDTb5rV039oO+ve/e26VcHjw/r6h3u04/pMCqnXqpDio1oj+TKxPV0WBSZBqx5VpBdOmmfG7z1hyqp733xFnW4h7mv8mc/LlhWhdmu7fNZeb3cGnP9+8DOnKLJ/mX6ygVLjOEOXyqyGrdKialqcucri+Oke3WSa+vkQo23YoDebGSGARNlRSSPnsoFxguJsFeFPjSd6f7VrM8oy//E5arLtxbp5jdmcriYRozPDvpzkl1cSDm871FTOC9qaZsaCwUqjG/Y5rkRek/0WGUssJM0sRdbVf8/+MdeRyz3s6YK1J6UxCe56eLbetF2//dliN/xfjoe/gq6H5WDBTkcjVD55E+mgwtXpmcrwrMAlUYue+3iXgXwcHMxAnOuDcLj8l1CgcG1aGW4IVUD85pkauWLBw2VWnePB20EeKIbaYIXUvBdsxBk8kn7H0RtNvQbmpohX17A69ySny6SZ6a0BnqpPQ9XVqzrA2BO/bTC4VFDDNCZI6Wd9J8Oj3rzPnGZmAlXhNd63w9YnQLhKapdS87tp9EJ292p52fZO/vboCbhq/Zwk/ACv5+87dcIe3Z8YMfZjTPNvYRwjlmlDk/K0BKhv1zlqkU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10455.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 fGDHwOEIJ835ik73durtxdAmR8OUEuivoCaNII+pFnHEqLUwf3x9FT+gmu9vX/wzGnh/5eTdSXFlr9HhElPC+s5iiGeePS0fASteq2aYsXqyFEN4NN00nVC+sPPEDdYGA8cYSACx5Qo4SoynC5m5ZshjamTcJsS0PfLEcDcSAtSWmJqV9hER/vRvE5yLvXvbpWtiKn2X+4z1sHvIZ1hQsZUGLroRCQ1aQV+Ev5+WlGjoOSY/EDxNNelQhxigwQP5exaFC6T4eXdM8e8ISTE9i4uOgDBNJRqxN/R2SSdWQ3Yujph7aeaBrdmPoAcyuLASxlGl+SedOLiRu8CCJlWg+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8377
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fcbc585a-ea93-4933-daca-08deebe7d16a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|35042699022|14060799003|13003099007|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fuetfwgrmrVqnm52s2xuHGmoqnhk9BnTuoNvonmPGWD+1ZR06rZ6Zw8ckEMQ8FNgjbcvX2rUsRnLJImHZsLdyXeXMhOlj6O2w0rayosbblm46kgsKL0pOssHt70QtR2mETrxq/lxxd7rEUXgsWCgX9InsxxGGFY1f6rOzYrR0wEghT31dKnfqcmFM0dcIR9dvLyM1BWJm5n32TFcdXHsHdDkCaTzgRWary4H0NdAtC9o2JZc5hDZ2/F+mADekfnyIpG6PUnOCYkuX8+lbuIhinganaOaLWNpNkOGd9hjNLa9IsOMIGbMvV0oV3nMwbm6Kj4oqrWsIO6oPutWkFS1M+8j3a/1uXYYaYeQAhKv8rDRMtpjzZFxJXAhYTuuzLu517QY14KGvWgdw/Fp+G8992VmBBx6BhRTye6X7dK5jn3cwd5OtU/InqHlUEfKcLZ7l5qU6r4VTqc6TMugo9W5wHLBfqMGRHxeJwHXPS6z4xJTWUmb9GqSrmkBBnxi/ClghRynwk44m1CldjvEgymG7eFdeojO1j+vDKn5AgPh6Q7EbmEWTSZShwDTUW0uD8g7Cb7fazOwR29e5GeHrbYci1/pQYDdxGlS4o7OhrLackq5JeW15ZxoKl3soeoBlVSdVxpVxb3w0gXC1l//Mxyw9A==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(35042699022)(14060799003)(13003099007)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JhElmXktDs5eEfVcdOM8+Km9pHvc0RgGqjcXNjUyJVut5AQek6LzhbitpBKArqyA4gB9n9UfarHJg7l2+0vBUmNBQFmLY3WfDxQZiLzKvi3rwyI35Jc52Q0JVsldcN2hXt0I4/ews6g3U6OLQDs8q5iy+chwFS2YzkvziYlZQGosy+WCO62MAN4TU8g/D31x9h0h2fKL4/KzJ1FEGN9V0IOCeMv7oAClafzZZqCyY6uFRy3v1+nCkXG7AlleNw0EytztxlbSKcwUrhlgJZOTv2cN2aTfuzouuUee2v87jzHIeSDPyhxjcyS9XuO2XpZb+XFeW5GdUylbVNs1PKAUlf2ZP3OUqUk5v23OlRroCvBwI3FK6hF7fjG0B1jUCSwW7WE9EXOTHNFB0/q80ZKeTxmace7Mfp14/WLS7c/PpFyfbMpUPsB8Ms7UeCA5zTm9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:04:25.1201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7213c708-0d33-42f1-f72f-08deebe7f74c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9837

Since commit 24dd377a76b0 ("wan: wanxl: switch from 'pci_' to 'dma_' API")
this has been dead code anyways. The pci_map_single() function it attempts
to redefine has been removed in commit 7968778914e5 ("PCI: Remove the
deprecated "pci-dma-compat.h" API").

Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20260709151401.GO1364329@horms.kernel.org
Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
Changes in v2:
- Remove now-unused DEBUG_PCI macro
- Collect Simon's tag
- Link to v1: https://patch.msgid.link/20260703-wanxl-cleanup-v1-1-d5deb23fa941@arm.com
---
 drivers/net/wan/wanxl.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
index 065c00c12cc1..c9873f07e06c 100644
--- a/drivers/net/wan/wanxl.c
+++ b/drivers/net/wan/wanxl.c
@@ -37,7 +37,6 @@ static const char *version = "wanXL serial card driver version: 0.48";
 #define PLX_CTL_RESET   0x40000000 /* adapter reset */
 
 #undef DEBUG_PKT
-#undef DEBUG_PCI
 
 /* MAILBOX #1 - PUTS COMMANDS */
 #define MBX1_CMD_ABORTJ 0x85000000 /* Abort and Jump */
@@ -88,22 +87,6 @@ static inline port_status_t *get_status(struct port *port)
 	return &port->card->status->port_status[port->node];
 }
 
-#ifdef DEBUG_PCI
-static inline dma_addr_t pci_map_single_debug(struct pci_dev *pdev, void *ptr,
-					      size_t size, int direction)
-{
-	dma_addr_t addr = dma_map_single(&pdev->dev, ptr, size, direction);
-
-	if (addr + size > 0x100000000LL)
-		pr_crit("%s: pci_map_single() returned memory at 0x%llx!\n",
-			pci_name(pdev), (unsigned long long)addr);
-	return addr;
-}
-
-#undef pci_map_single
-#define pci_map_single pci_map_single_debug
-#endif
-
 /* Cable and/or personality module change interrupt service */
 static inline void wanxl_cable_intr(struct port *port)
 {

---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260427-wanxl-cleanup-7e59607dc4f9

Best regards,
--  
Bence Csokas <bence.csokas@arm.com>

