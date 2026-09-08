Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C4399340;
	Tue,  8 Sep 2026 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851219; cv=fail; b=jK5Rl/5xHZRohwpmGhhPwBcyE6R+J2Cqmd+BkVxY+nKLQugv5x3D3GpeFV8++aAeuBugL6buzbhfeEbVgMLu3ZVNU8bfbaJBpPNdGeQfQWicnlqRMfm+RZcH86/uuB0TD6bhOZzwdzYPPntThnDwccAX/CqUUakx9fq3Ydqajf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851219; c=relaxed/simple;
	bh=/SujGt4LvIaMebE7gGp1SzRISMwwNanjZHTfgow0u/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iDGquhGanED6Kb0D/kHh3RDTbxWICCCFpLRJWyf4x/kLc2Hhe1w+7nSEFqdrUcvbHTLK+8g6efR3PcpauKV4i4m3fxeX5Zf3rbdoKv1TAD2D/GuQI3T5ynX9PW8aRwlCO+NUVY5HYLdFA1Ln78zkXCf7p3z2Gt+SzTgBPhoEckQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=RAJbc99n; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="RAJbc99n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhrGLTfcVILSk4V8r6NI3UB/7TxgnPOme+NQqTPCtoxZjhl4zsWcvt7s6wjEJ4HQW0wp38TlGzuK92XjhlYj4nqbkW+KQF4nb3BpUU6fGayyYv4+jEOf0C5hEIAyNdxEmC5l6qgrbkFywT2+gWYAYtmvDgyFD2jWjdV2OmAEWSh+RuKR95k2lJdPIaw+CxNZauZ9DINh9mKMkCMFQiNuSob43JpwbVT2qLJYg6se8yUinmFgDDxq3eLNAHP1IQ8JZUEtNBo218/OXQeAYuzqxlz5YL3Ye35uiVqsBfY67SQhlTQjb0K3JokrhJ1sb8WGgDMnJy766s+CzbluCM+Uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C2k2BDbjlxzyu7cMj311KaIkZZXDTy89FtgpihPN9I=;
 b=UVnP2Y1Qw5SwmZjrJ4q1CC+r8dPvUJ3VTj2/v8RI7/3U6pprPmVMF5WfLeBytFFPOghUEVpXHm0f+Tztlr4tFrdJZCq9bQaO9O5/gKBHS4H4jo8OTUsEogynrrkzs9eH7bdYKsQ+sXuY9tumXFA428rVnh1Y8XsWIWVg8/qzqFLEvq6pSA2G5/QdBV8VyCdYDc50UtX2E0rUQq1ZqtCJIUK1PHtsAY3soGc397XvdYxw6lzEk21HIEvhHPIZBNT5UJR4TSz3Ap2aRobvHDPwdju1bhcYLD5fgtOYihOt6t1+bhofMmgae29epYEru3SZ25yqZep1PcMnZQQfX2HUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C2k2BDbjlxzyu7cMj311KaIkZZXDTy89FtgpihPN9I=;
 b=RAJbc99nH+W+t1XLM4i+VvYD0A8KpJ9nUvvd1WH+uCHkx77N1pWEF75E9R5N90TAFRTK/vDRaLQJInCu8L/Uxg+lnj0KVTqEN8k6xed2VieobhPsEbDEyTZmNPUUxQevl9KrE06jqGg/Ar0OEC9U2ldILMmAzBY3CvbwcHpcELWLJlRwhbcr9GPRuH7WYVujb+3xv5hfcbimGSqi3u0Tpx4lXChZrNTchemfPvk2gzyVQx/m3qb22GttBDo2pf3NmiE8C9erVY0bESLslFBMa04Q/kletDb8zuRWx1sXPtwNKgZpVJa1NcsqS+2Jgqq3Q1Jz3OzYJwYTMZROjJLr3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB6397.namprd03.prod.outlook.com (2603:10b6:510:aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 07:06:53 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 07:06:53 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] dt-bindings: arm: altera: Add Agilex5 SoCDK TSN Config2 board
Date: Tue,  8 Sep 2026 00:05:54 -0700
Message-ID: <20260908070557.3585-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260908070557.3585-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260908070557.3585-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::13) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: e1267cc8-6286-4a47-4a81-08df0d77c29f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Op0T08RpHKzGVqD70bqyA4SsF9ewhj00MLMEIsaH7gXLuGc5BW1sf2EJbOb5riI9LyCuB+dp6VD2pkLwio/WARVA9aM/3E2VkHdJwRRa8mQ8dm0SGMDrMQ4d3U0aDsoNwcFjrI45GTjV1lLmSHSuPvJ7NhjU6aYno2qG7RpAqXGJnbnaFpF1ZwC+1PlPdeLqFwgtJ+4ll9aqvmnNEceWwOwK5/p6otiXuTp82jB/pxxHeUnlbG/4xmH946V/cV8Y7p91Sx4m32cRe59iNQRpioYZO9j5l1+KpjIPIO00ANRZ6dlGxGdSNMnb1H+fCCoLvOyhfVpo3v2/L6Fs2cef3HZNRXTHmz88yShase9/h9zb68/vIoiuWSVNW2X33R2mQvFFueDshhcRdKqilYTHkVN1aB3dUEvsYuobI4zTZp1y+owPsl7BWZUy5+xP3AgOPwTn2ELeOSZdhYovbxREdALC38Q1AcCYo/ACzAkXYQ8NjIB6bt/OJXQBhUVDQv3awdv6yM6dZYTyFpc5B+7YYfImXX79rolW4Asn0WRCH9iO1b/j4ffj2l/Cf4OMqziPqFLgA9qNh/gVO5CWuEnZrT4eJIHA2y2dW+Vl/dZO0lACV242WLLFHpzqBQSejY9IF3wZZd9H01EMQpaCdrvjRFA+FW2KdF0ilBmff3Fz+xw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nmfuS+ALxmX0vJlLHqeBfU98TxhEbalzGc4dqimw8Lo14SaNe965JPjItXEB?=
 =?us-ascii?Q?MPUrxYY81COqQA9jvxgVadEF2pFt8nn7OjyzpQcHMgj0IrJ0Rr2NX1Em8sep?=
 =?us-ascii?Q?u2KwPfUcKXj0g0wD7d2hp4cRBzfcUwnHgAdSz+3bt/AXqJDON4ol6+yp23oA?=
 =?us-ascii?Q?fLGH1w7nYBi2sGKqJLLCLT4LGoNepaT0eiz1sH1iKD8thckVEeXdMVT1UGnL?=
 =?us-ascii?Q?WQp7/vyQxx0fMUBDz/ji+bKM58YCURGpnujt9v/JwRlOQKAw1JE3LFzAEFqN?=
 =?us-ascii?Q?nBIHLavSO1ck3KLa0WK1aH1Mj45mQFF11fVwg2LxARp6bsjmhyWLhrgA6g4H?=
 =?us-ascii?Q?zrVtGvP4/fj2c9ETT4iPgc84lvVyIhNsFiI5DKrsIPr6SKvMXsgOeULd0naa?=
 =?us-ascii?Q?MB1E9Gs/5sJUSw634rbk09VbXzQTSuP/8USY+qv/9dvNrQkopMBWt5eUoWJy?=
 =?us-ascii?Q?7bdwukNyZq9WNp2rcA9WMzc6M/DW689xjBXUlxw4ZRKr8Hwjy2IODdRPznjY?=
 =?us-ascii?Q?QyDmO4TEpD+SQU/xluefNj9lbu6/tAgWBg0l1vlmQV8kl1gsi6XiBcHpQ1ED?=
 =?us-ascii?Q?4xe64mbr8cQ7FucZ5BpI6Gii+CkKTRx3Qie1cDHCW7Tv7kHhwnuSARNpPmBZ?=
 =?us-ascii?Q?5sLqf/4WhmG0YsgO6V0WRrjlqkApgPUf4EACUDOr3xaslwfZSuPb/vuX0paB?=
 =?us-ascii?Q?9yEuu7k/WuKwho5ZLExcHSx/IWCrWQx488n/zZyPdpG9EQjuefc5eoPvTCZe?=
 =?us-ascii?Q?eyPpQec/bS9VpgJxXuB1yTjplbczaUWkxpYtSFhXyEFR0EXPVUypVX0yCmlA?=
 =?us-ascii?Q?aDOTpkaUs+h5dVAWtjhSsvQcFHGOjVDsKaA+f+rAnts9JT7a1H+2+sEweF1z?=
 =?us-ascii?Q?jgPEA90be6H0evxf1l4pTY0RXNYhHMBG6nvpLJdJf4IJVtgIoytS71dBNJ6B?=
 =?us-ascii?Q?l3R+MZeDaSRrgsy4V411PhrggOQSmT8NkpGETJ3wqbC3KmHs84oAtdz/DxzA?=
 =?us-ascii?Q?FjP8MrOAYlNmWwciLI03eqRwa+twrTCAbQCI4DSq7DzjbAWVYpAnxNA5w/f8?=
 =?us-ascii?Q?T7wDPqek7O+U3RkiehMG7Jm9VANXb2uEhwkDyRzxG6O0XNi80usfUNqj/2ro?=
 =?us-ascii?Q?18nACqqDagInZVCWJT1LPW1XSdeUOMKygtTeNQZgsOmxT2IQYnhs13JCmRjY?=
 =?us-ascii?Q?G92ipWYynSbDt/J8V4nj5OJUQpFpRu7ynV/qu8FQwwD5cIr9ESDkDUnYKAGL?=
 =?us-ascii?Q?RQxHdLB9IJwnlVEB8HE+lkPviPZG39DdFyMRQwMgnJ2WNWfB6KGMRlM7G8Al?=
 =?us-ascii?Q?waA4ApSybqHjooaWlMVhQ2gS0aZHaP2cJTNiDgo/eGCa8Grj9naFZpoR4zUV?=
 =?us-ascii?Q?2wdDhzvas6yGuisu1k6sqoLaqlsviA25fKfCAYrLPxiMnEobxo2fVn47MD/2?=
 =?us-ascii?Q?cjyqY7Qtt3K+AG9T+PsZsBdaN1UBmREh/C+wALeSMGVVNMCvTBtPEKDZASE+?=
 =?us-ascii?Q?MyIKva+gtC5j4Ae8pqGJJ+w6yK7n1IUVLLY1zdecxxTvPmetpVTuDKXDZNLc?=
 =?us-ascii?Q?EE9tYHbkhLE4pbZmBwzIpc38z0T+/eZ/61DzlUUUYlAI8ZHtbcdNEcI0Dn++?=
 =?us-ascii?Q?/Tv2DnrxnWRUfXbyWphKXDLZjbyxJ8oGqoEWg2qV/fsrbOE3VPcfRqCWXuAd?=
 =?us-ascii?Q?yP23K4+00dGTp1gwi8uQZHbwlQKLCd9rdi5cACBBWeJo4w/E3xJSlVxXLaVP?=
 =?us-ascii?Q?52kDuM0HIvdNbLs6KPNVoJpYO1O+2FZQHRPi0RkKSJKrXu8gIw81/0oGtXLf?=
X-MS-Exchange-AntiSpam-MessageData-1: 3mmd6odjLYHHCQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1267cc8-6286-4a47-4a81-08df0d77c29f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:06:52.8936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dpn9FopzQWG+Pz6GaL9BpMGfjs26WmjgfzVsBbCXOS2HWRea3VxBSg4WaWQDWZp6/0R2qiEnxeFfL0EZdcTQ7vrhfzUbsN7Bgx+d72D+UNc/ykVNuT1kAoBfGrQaXc900d3QfTF6xSG/6vyf8rhAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6397

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Add compatible string for the Intel SoCFPGA Agilex5 SoCDK TSN Config2
board variant. This board enables gmac1 as a TSN port with an FPGA
GMII-to-RGMII converter providing the RGMII clock delays.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v6: No changes from v5.
v4: Fix wrong email address in Acked-by tag from Krzysztof Kozlowski.
v3: Add missing Acked-by from Krzysztof Kozlowski inadvertently dropped in v2.
 Documentation/devicetree/bindings/arm/altera.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 3030cf46fe74..e431469a7175 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -114,6 +114,7 @@ properties:
               - intel,socfpga-agilex5-socdk-debug
               - intel,socfpga-agilex5-socdk-modular
               - intel,socfpga-agilex5-socdk-nand
+              - intel,socfpga-agilex5-socdk-tsn-cfg2
           - const: intel,socfpga-agilex5
 
       - description: Agilex72 boards
-- 
2.43.7

