Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2337E5F2;
	Wed, 23 Sep 2026 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129915; cv=fail; b=nA3i5SXVFzoYKeEES2Fygk2H2LAtjpmJZhp/Rnwpi0k8IbjJhpVs8Fm+0gzw+kevlr7V6D7jYuQhRYwtTFn1559VOtTUQMNBr2cSEVmvTzkl2J1fmVXtfsKbe+FtzoY0qr9Bw7A/CPJeqUKsBHEGJ0CMZsNq6dtJi+mgUT3Ou2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129915; c=relaxed/simple;
	bh=vRz++NSZ2rOo8ZwRTMzGNO1ai6enhkYUsGJcVr9MGw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9NH90ZS/glF9iGGA0kdzFbGg1p9wwX0xKjjh6/ZT2dcUv05dkgay/E4lIATGFYECUm4n2Qzu57sOLPL4/NpV9ISlKeaiiMgogrW/miM0upocVmBi8SOB+1kf92yZmY6pOD/Ch6pnLR26+xGg4D+Pw7V/zPMcyXiWqQq4VOkugc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Tj1tTqPX; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Tj1tTqPX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdDcRw9bI8omwAgswA7inP2mRnT5gP2J5ePPFRmhvhgehhRMnSKRIb82gB08jrC9NTHTIuU0TOfGK5/6tbGVUfTblWMYTDyPYiwcXNMU5Am7f6gJ5QlFb9aPN4UjoJfUbXYcxDTPA5iBb6P3DXL+Z/QmvXI6h5MJXet6tgxF4HHU1280PXpsX7k9b1JXAwbNwavvqBKw/FqJEFphTzOSQhQzELDNyH0chAzEQrGHBaF4YqRo8H34idqh8ajhZmM3Htlh5u4twIyoVNvrSS7klBHCazD0A7WBIKXkeZf1c1/wOjqWq/2iC4xLFFx5UCUeohv5aPPjxCpwnaSys1HSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8MNVvVhCJRyajri+L3WamaWoM/RHEu0pqGR7dsgzcM=;
 b=HXpOIO4ZQpOdxCxf9bLJ8LaIWkyK/JW2px7mxYKIz9p5cmoBX9VZaOLLb5ayIxB3RW7B3n2penMyLctrCC5Dkf1k/t4Tvr/GcylwAXYSbfq8mfCs9vKpcMBWUGt8rJ6PdTCTOACpAVZngF9G7hSpLsha5TjqhB5LyNO8OqUpmaDd6Kv3V+GcVXeqHu0q39SeGDdh+hgzAt177N7IoFG7akfLoxGFpg6RRXiTZjKgjBs8b5VXvi9QxwJzQvtY2kCZFMzio7c4+e0BqN00h0zccMCxFfWHE1M/EcGTkCNclv6Y37+ElBUXmM7MOXgi1z2siIV2wIXBjVlDVNStNtyhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8MNVvVhCJRyajri+L3WamaWoM/RHEu0pqGR7dsgzcM=;
 b=Tj1tTqPX9fJhE28tWuYOKUaEdTQkEh2I+SqM27Jqu4dVJaRHaHkc0lg9XGDm4o8qydGd/999dnPA5DH0jI204VSla1+rNbsUvEZi15UXQuHAcD64L5V0CjKR4ms237vu2aysS0c9zHuc+MrjtVZoU6Mt2uTYjd/A2GJktjONF1ugUUlH8KOKUNmHGzOAArR22uQSVseXpReEriDuOI7g7bNrBK5Z6/MlxU27aIr4oTUkZltJ8VI/xYFqJNRihlSNtTpOZaRiD82lVWoHTBeVVFI8PNL1mAQjW3LAvR44R0Sb1oaiTDOyaRY2ZiNUv4KuZ8byosc6RmvvmeY8Xlk+sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by IA3PR03MB8024.namprd03.prod.outlook.com (2603:10b6:208:50c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 02:18:28 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 02:18:28 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] dt-bindings: net: altr,socfpga-stmmac: Add altr,socfpga-stmmac-agilex5-tsn compatible
Date: Tue, 22 Sep 2026 19:18:22 -0700
Message-ID: <20260923021823.46649-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260923021823.46649-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260923021823.46649-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|IA3PR03MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 9762db06-73e8-48fa-b1d9-08df1918f3d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	lBXk2cAYKFWL1HY/pyu0Yz+6j+qSSoMnT55EsefvlEjVkxfkhaQyFHMbdRKyYl3kQ463PAGZzX2bQV8/Jo2knzGvUnjdypK/ZAVCbsFsI7EbeUZwqS/p4/q80oQSNbzThHdyZJBouVWnJLtzaSRNfTUL7E/b2Kd/shQ3MrnQKDPbqJyWNvsiN1llPClNqddyqkzyKiWpAbNWjdlaAAJ05bkq0aujoo16uGb4UbXoCdheOgbl+ApAhqiUSHN41VnVyKMNsFaEz7CJ4SY6wq3xtD5zlkIdDrlIMb/DboaZS8z4JzgYJS+FoopJa3QFTXc47iU9AOjsVMVhQwL7ySnm2zzfBhDcPQQrZsyMJotza7axtiLq4Ia+vC+Pde+F+6ma66mGVRvEiq7jZvuQfs6SwiNm+ntYOOrwWM5F0dsXyh8F9+jc9iYwRbM/8jGGoOZFs4YpccMYLPulVk3Ud4E3bd4x83E2UXLqLZqXt/dPZJ3sYKbq2GKX05HSosTwjhxBwhfzRGYzwK/JoHXrGMjfjddVU4jGVFPzvCiXxi4bG+XqGb766nb7qBt0AEXn4GDX0TtvKHCzE9X+hXc9xC8TtKU8iSaqxBk5b8kQDv6KUDsgCAmaNiRUUoXsw4Y1nDpjBrpySbMelgmAeRrElUOmkCtPmKydwY520S5GEyofKqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sSIn4RKFIoVz5J3xPWlGbM28ZdIn8YOC4ByJzctIFVjpER2AbxS15nxlkZlq?=
 =?us-ascii?Q?vN1z/Ot/wqUGIU61rALU2BQeu2ghiYEbTmjqETN1pi/vvA8YnHh2+bS71YZt?=
 =?us-ascii?Q?3rDozMD6tlPDJpJCY8NgcNk2P5f+6DYGoM9ibZjq4a83t1CWrSrlY3xjyz6o?=
 =?us-ascii?Q?KDPIogi2daAT9Byd2zQYcEq3KCPWySwVWDceZko6i3g71vL+UScytHCxBGrP?=
 =?us-ascii?Q?t/L1Wu+LshxmAPh47Q8UvNeir6H5ad3omZEJOv7HVNAGWTntVKuWOO7XLsmO?=
 =?us-ascii?Q?MPQaZrVEA10dUVYXIuUImSBXuiY1AaPk/6k+lIA8+L7hvhvNyoop455kaAj8?=
 =?us-ascii?Q?7LeSScBJsM4QIqsCn+AgV4Ld/ThkVYAcNVSJJVLlTxtc608s75+q308ehNi6?=
 =?us-ascii?Q?VkK0Qlbd3LK9v/JMDVrFJekkAyOIeaeM/SxIkjBj+D7jpLLBVOVJqJjIw8Q8?=
 =?us-ascii?Q?Uha4+iiYQdXsbuZRYWzc+OpYQ8fCDY0i6X/+UmzMbFhsFdnQVPPPqA8g6llL?=
 =?us-ascii?Q?TVoS4czf0wAs9/8x7/eNt1p33LQmVaYEDdBr81NWgLvQ7P8cgRkweT4x8Etg?=
 =?us-ascii?Q?S+iz72g0Va6KUPubCCMmYJ20vBDP1c0sFmun2V5tPUvdMH4jZtXglczt5gR9?=
 =?us-ascii?Q?bR+dsj+qAxFROskbTsbPJw8sLdhhJKLJidL6O3FC1JYSvU6ihRtQdKmlbkDf?=
 =?us-ascii?Q?7AIAsGEOt9pAwKbOlmwkobTE92iYprituuTAM0ZOfWnfoywt9/3Rby8lReSf?=
 =?us-ascii?Q?t9ByTpOfAKVk4qDebAanLa/YM+HBTCAWohti89VURRMCKSSe4kAosXn1oZdC?=
 =?us-ascii?Q?/G7KnmcvYRsZBnBdcioFLsr47Se3XZz24Y42Bau1rqGQd61fs1lfBIbbt1LV?=
 =?us-ascii?Q?gACTkpCbgqz5dqI6M1R18s0CHQ/AR3a/xFcafsxicfscnzFWQFaMLzbGPE3j?=
 =?us-ascii?Q?ULPGe/A7AL0JuPYe5g5hw5tsxo74ARTrgGQy4tjgQ3Ql5ag7NganPm7rcX0R?=
 =?us-ascii?Q?ZdYu52grXQ8z248GIDZWAN+vjglpSvYDvPfGdS7SksYo0EtL+PLzx90fih/l?=
 =?us-ascii?Q?Wb0tlzqOW8p4WRiTKEz5FkVV8h5HTzpTxoeT2Aw7cD3sQH5oadKk1ZJl8ws4?=
 =?us-ascii?Q?Ac+w5pj6DrwuIWRYxCACESqJt9/xDBJDU3wr302WbIbcXsPZ0l1sY5fT82b8?=
 =?us-ascii?Q?psMG5I5uAbW3Ow2AX3USEUggrh3INBAJwhar0Pd8az/4utyYkj4LflQL9CRX?=
 =?us-ascii?Q?8G8FjaxKI/H5Z+gBXWMppH7nfzt3YyMt+LLnNaPKHUS47+fH5kwSChdSIQn+?=
 =?us-ascii?Q?8edLavk9SSBjksAYq+oSm/ZklXbczhi8IStYwhgGewSrdf9+Xw9tSAZSbLHw?=
 =?us-ascii?Q?UzMqDRJiJbFva7GZONwZg17C0EVrQ2aH8OsqpIbBj0y6TzCursrXo7Rf3rCM?=
 =?us-ascii?Q?Mno24Ot3U08xRF70MNIX3s8aFUEMMRN4wwNR41ztsu+3KDVfxKqDtO0Yhwzh?=
 =?us-ascii?Q?VpbeHHUAGmoy2RD4ozY5OXaO6Rcwg/iL5/4jypw7S/KpQyxk38eklnyF29OG?=
 =?us-ascii?Q?5evKQw2QT6H3cSsRr8AQ++p0VGZ2CUpmB5erCXjnwKjO2t4YvuYZqNY4y13E?=
 =?us-ascii?Q?wYSiXRnKSWsHQTxOSZFvq0Zrystl6rIV1ZQgOLtxtKn35G8BVCbLOCdb1QTF?=
 =?us-ascii?Q?j5wJoIH04GAlloZHUWTfIXnTKKuYFwx/2rvKx8Vg36R7LqzHqMHxqp2vnWQp?=
 =?us-ascii?Q?wC5bPD/RFsV8HyC3rLWG1EVSIagiaMnweJLpHx8v8MONndW+AR5G+aTENRyN?=
X-MS-Exchange-AntiSpam-MessageData-1: pM6aKTlRMBDA5Q==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9762db06-73e8-48fa-b1d9-08df1918f3d2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 02:18:27.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvOXk3fhCgjRi4Jmsda3BECSXNrMhUnHnWnscr4vIpAZAYCqw+hoZQgXI0COJGZDuOYqhEqPJqwEoOsjTGHODshwPJRi3HM8aQkoBcsRQ7KV/MVJgrnfFaqCT31z0gbc3OFjmSneiXFMgt7AZXdAoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB8024

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Agilex5 SoCDK TSN Config2 gmac1 path includes an FPGA soft-IP
GMII-to-RGMII converter between the DWXGMAC and the PHY. The converter
provides the RGMII TX/RX delays and presents GMII toward the MAC, unlike
a plain altr,socfpga-stmmac-agilex5 port with no such converter.

Add altr,socfpga-stmmac-agilex5-tsn for that integration in the same
compatible items entry as altr,socfpga-stmmac-agilex5 (shared
snps,dwxgmac-2.10). Do not use altr,socfpga-stmmac-agilex5 as a DT
fallback for the TSN port; the converter presents GMII to the MAC and
supplies the RGMII delays, unlike a plain Agilex5 GMAC port.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Previously patch 3 of the v6 board series; split out for net-next.
Rebase only.

v6: Put altr,socfpga-stmmac-agilex5-tsn in the same enum as
    altr,socfpga-stmmac-agilex5, per Krzysztof Kozlowski.
v5: Drop altr,socfpga-stmmac-agilex5 fallback and rewrite commit message
    to explain hardware incompatibility, per Krzysztof Kozlowski.

 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml         | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index d8f90d36d246..ca768937d890 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -22,6 +22,7 @@ select:
           - altr,socfpga-stmmac
           - altr,socfpga-stmmac-a10-s10
           - altr,socfpga-stmmac-agilex5
+          - altr,socfpga-stmmac-agilex5-tsn
 
   required:
     - compatible
@@ -42,7 +43,9 @@ properties:
           - const: snps,dwmac-3.74a
           - const: snps,dwmac
       - items:
-          - const: altr,socfpga-stmmac-agilex5
+          - enum:
+              - altr,socfpga-stmmac-agilex5
+              - altr,socfpga-stmmac-agilex5-tsn
           - const: snps,dwxgmac-2.10
 
   clocks:
-- 
2.43.7

