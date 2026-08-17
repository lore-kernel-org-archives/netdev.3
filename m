Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701403B9617;
	Mon, 17 Aug 2026 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952556; cv=fail; b=nuEhZcpGMGeefdMCxYOw9HXAaD23i+nHbRoS73IbpLdnKQADRy0mDJ+UtIaIDDtMUz1eKFTAem1FQZvOqJonhO+UY2KCQiafTk/5XEOFBzBRqD3OK4FP+fYRhitLLTjIdA78fetEy1tCQqqFHbG/CV3uz8ItcEERLPUBPjq6jtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952556; c=relaxed/simple;
	bh=K27fRAzAFd8g4skdtEh0jSnu1ewS/OeU2wb+NpjVx/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGso0FgY62X+F8U2hquyV+XVW3q1GpZsM/dq6+13dfuIo+4Tzoge4BeQeQ97OUzfkHQiDNGwpNP8aAwzvdWlYAOzhVLSaSAaXmblzwf+C6OYdmIZaGM3rRZl39F6VYxnWEMveZBi0PDZZY6L/Xl6ZSXFC5/KmtiNztf0hdnoASQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LPkax5M7; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="LPkax5M7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoDbY0ZEQ/W/TIgsFhUePKaT9LAfK9ixGg8qZmueJ66BOvWOrbQ+9vUQbotMDcVhIWBXxuiaePXufMd+JzzQ2rLOqgeSIaBDy47iPF2Z8U+zukbMoB/eqqYBkk6+S0moaqJo2NVToIjaiTh2qxAEiW4fiXhbmacpc5W6CgdTJtZqAsN8WaS3bwma48/rU9aFniT+dDTLby+M5w7LVV2CEELMtfP6UJuqQvJfEUfOOYFvThwWgRIqScHvGUHeDQ1fqrH+CzzllQhVWhjovkN1YiiSGN72DQU51yqKAThuSd0U/Hcyke1vbSO5As0pdUTTOvPug9zooLvMKUoKWJuoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bm7ErM3OvgIg7xytrfP6XbDiJ8mepGNbhtLK5plYGSg=;
 b=F8j28hGXROfDkN4c1X0gMkx3PdQEHGjwpbfwH4lj7BwKfMiYDejMtecZw9mO6SwggPoIrDHfLLjCJUt7S9M1Dk4zUaevIx5/CzwyebSIcQ2kzhIy/poJuhBUcVvv88Mreoop9K/Ga3HZhBtgj+HIonk4FceOyrL4xzj7Bt1FFmjuKrzYvMVOF2x06iAHtVNqAXUMRLNoUytYFT/Qjy1bNLZpRVEIqd+XQHXC2su1tdoSC0YOaoPh+Ll83JDpiEc+CxyYF6c6YuNWn51Ai4DyzsxKmefitYOTwTRCAJwU49IuCGla0pxnPiLqTghfznnWA2DNflwrEvAo+090YMNaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm7ErM3OvgIg7xytrfP6XbDiJ8mepGNbhtLK5plYGSg=;
 b=LPkax5M74v86DjC68x1l0GoM9PCxH1SARl0YsJswrutENmPvj3d3u7uOVi3V94N6v2h4/yUlNEGPA/rbxCt6UfzkZ0Hk00MscyDwW/d5UbIjxBVWuOHRygeCdsshgqQph6Gzra17tgqvsftRDgGHj01BHx9KUOq8kpn/LwSm5Z30yqOk8HgMq7wBl/XAOaSSIiML0AESPrW+04g4GwNUQ+LoI+gmyklG84/Cl++OzNCnX3M+loQmDmGbfsW2/9RL74Pz+XE73weWml6vmHeydExWyVEPfTerIQlKXCN5gaiRejMWFamCwOBE8vXE6eK5ii1AIHYVO/D9Hmxrkehlow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB5502.namprd03.prod.outlook.com (2603:10b6:a03:279::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 07:42:25 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:42:25 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org,
	dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: intel: agilex5: Add per-queue GMAC interrupts
Date: Mon, 17 Aug 2026 00:42:21 -0700
Message-ID: <20260817074221.27459-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260817074221.27459-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260817074221.27459-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SJ0PR03MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: 32983cea-5028-4d14-5304-08defc33145b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Ig7tWocpfpwSk2OiNSi7eRt7NbSUKD7N0TOoB79Wz+sjzIfY+G5eT5PvgLn0Xw/eCeeJkgrsFpYvYAu/yncRpZOunz3nGyykubV+EtS+vOX/9Te3HG/vPaqC2RZPBbS9Hf8se0GmC50YM5DNhZP21s/MbRxIMif3RdiAQO+CBTnBNRlKlCQH7eYsb3TwGhY7iuaVXseOR8Y4upT6k96DMxbnChRZxKPf0hAwbSdvQpWo+TuaPT3ZZSnzaEbYcf36PmsfwDx7soZGY3lqGX3ssFYlUE9P8G/s6qNI16rQN4MIovQ1PdnmdZ7a1ZQq4rREUBr6uboP5IYhcqn1h/IKYZ/bRSjATHwWHq0Jxz5/65BZislZjBIW8zBPMTduybaIjk08X38/mo/lorF9r+0IgqNIS80mG0EY9BduZUbaTQEUBWVSDpH6oNn8y4pr01xvT1IgPH9/vSRyLzdKZzM6eG2gI7eWWV7SlCch/+GH3jm26VlphXlUlBRsLuofKzugKE2FYj+6OrVF1ETRiqVIkzQGX0TiDx91GJ/NFdvzdqy2pV0AKmIoFdNHUePbvUuev079RCyO1sw7Bg9UK/HrST140vvNOfi3PshONxS5b4kq8q8/Ps52GIcxCWaGU33n8Bg4hskEB6qpCqi56PL2H6qeaOckLQPs8n1eRF/RXvg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EBcMw0w23F9weM0qAnBgu1WyU2X5wi9OjgvgjBNHXZlOwvlfTnGu1uhA71RX?=
 =?us-ascii?Q?VugKNFP4QhS3kMtiIPfZubyjIEP95gNMAtcRtRiY4hydQ7z3SDazHRX1ZP20?=
 =?us-ascii?Q?x91he1Ro7IsaSxuiccFpESqBk7CpT0gav1ddAEpmfsfqOmFz3qiJJQbgAmEd?=
 =?us-ascii?Q?dnG/sBvqJg7IZaIWyGC2xoeAEScP9p0VRGkd3tCqiD1h9MCqqlIR9CT6Y9pR?=
 =?us-ascii?Q?fC49ASdXalI62hEf2PfGpgWIjdZh5AUSRdi7x2AfUF9hBLnYk8vXOoj76uq1?=
 =?us-ascii?Q?ZR7+WwF0nCOeLncljZhlUD4aeDRaYXDPIcm00fF/a0nWTovAYndqXRVwT2Z/?=
 =?us-ascii?Q?yyuKV+31+3Dh/uxnxX9yBSNj3sOA9zncTOWrPqE7IqfC8L4fOIq5hqjitozM?=
 =?us-ascii?Q?xQmIUKnLbZitF9nRFnRXxmDkDtoung6mX41o9l3Bqre1fgaDy81y5liX+vwQ?=
 =?us-ascii?Q?cvIPfX7ucJhIp85UKgWeIa3Ht1aEzozS0zG9irk6GMq8A5DafJkp2xCfJMZS?=
 =?us-ascii?Q?Z1lCNPexIptJEF3sV9cmpiahxWF0BKs21lPp+yUz4jA8yVBHSblbyQofK2oQ?=
 =?us-ascii?Q?2QKmcj/bqf/qi1OLeGV0xojtKhc7e8T23095uPtMZRsGRtDUhV/Jx/Qf441H?=
 =?us-ascii?Q?n997GTRetAJYqgArHz3/er1a3njRaa1fgDAagYj/Ckufo9OXJ+2PxNm66C6R?=
 =?us-ascii?Q?UemsKKu+LoXPE7jnvH+N04s9K4jG5N17q7UUFRAecnE5OVbrrdxGY/2BzLYE?=
 =?us-ascii?Q?9IaQaH2KoKUPjjdgtgG1crhjqvvLmjNV8VDcc2pXXjvrvZ2OYcVrcNoRxgym?=
 =?us-ascii?Q?5iwM9NjcLXOAzY8d8G2FnZknwySAeylJeIILocPuYJSfIEp3DIW+cZ4VOO7p?=
 =?us-ascii?Q?IVZuTEn9HlmcI7yKXZURqskG3M9WheTAzfbGRYRAnK1WtkOjRSuHz9qXVLHs?=
 =?us-ascii?Q?A1WXTOb/aM9CxzDh1rAG+3cDG7ncZF5uJTT1jppw5Eg4RMRjfvibQhorDueP?=
 =?us-ascii?Q?W6GBIuRLEWvwgkPrhz1M+l0rxxT97ijqMeGBR0LI9UIBUmdyEQa2gQvU/ZKH?=
 =?us-ascii?Q?2F7JeRFiELIBcJY41vJPVNuK0jxWkkLgAcPleZ5XlxKBQeVxaKjQszB5VXdV?=
 =?us-ascii?Q?kPTUDY+Co6trDlTwYA5d8uAHZkFAWlTpfAAPLPO9fgGcQnsqHOI3+4uGCA70?=
 =?us-ascii?Q?Af8mbQ/hv4l5ewj+qyvWjJ/hj+qidT2mZ8899jEunCv2MAbFcsuhhGfGrHMe?=
 =?us-ascii?Q?hJgPVkB/WIXoSc1IsN/wL04m8RzzSlslg6EFSjAH9K1ENrknZupQdccXERve?=
 =?us-ascii?Q?/XU7Ld/GBzggwL0ulOjrzq/lE6mAu5CdPCLsTyEQnnlNi3/LRakqLOJqBAxk?=
 =?us-ascii?Q?yvVdRnNOlflJ5Sk4kle7jikvI63q37LOfqjfyis5WKmOEHYP1hNPBuIJE4ab?=
 =?us-ascii?Q?UW7geYWPdF8OtxFS0ufWzWfgPj5DWO1E76ds1zMiXjJFDm0CjzKp5PQ+FnWF?=
 =?us-ascii?Q?1oE1yTg4nJ7HBezSxZQlPLsF5ir0Lh3djgYTsh8MnRaLEZnsVHjAyIqaNWlj?=
 =?us-ascii?Q?OkMt39HGeyYCaJsWYmlIKRHJiE6Ot/IUV0fyls0QbjOXkos025/vOXBuEfna?=
 =?us-ascii?Q?ZcilsdNpkOzkh+x8ExolYzYKta+8p6Zc5ayhKrY3vZzklvoT4Lx0/acRTXq9?=
 =?us-ascii?Q?Y7RlO8sd4Ul/zJmHDVa8756ITEULm4Txg25YZa8MUfwhAAtQT9xJuAORjmVS?=
 =?us-ascii?Q?6M0xuvgZT5afI6oDmKsxsnk0IWP5QjTzdGsgpGd4U7mXjg8Ug05D/rxG76LT?=
X-MS-Exchange-AntiSpam-MessageData-1: vddXOvt+vZbtCw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32983cea-5028-4d14-5304-08defc33145b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:42:25.0378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hIg9Q6IzIlMT106jXE8LhVfOEeIpFHrmLLDKAqlPc56bDiPWN+HcD7RIXzaBycmFE4Mkah5w6vGol+t0EC6lWgd1GIJB4XexBWc4C39hzJs1/uIG86n/7oHokYal++5RzCfZSe7VUUwmIo5Aa6Dew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5502

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Describe the per-DMA-channel TX/RX completion SPIs for gmac0/1/2 using
the upstream interrupt-names "tx-queue-N" and "rx-queue-N", alongside
macirq. This matches snps,dwmac.yaml and stmmac_get_platform_resources().

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 108 +++++++++++++++++-
 1 file changed, 102 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index b06c6d5d60ee..213e4aa4e962 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -557,8 +557,40 @@ gmac0: ethernet@10810000 {
 			compatible = "altr,socfpga-stmmac-agilex5",
 				     "snps,dwxgmac-2.10";
 			reg = <0x10810000 0x3500>;
-			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq";
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq",
+					  "tx-queue-0",
+					  "tx-queue-1",
+					  "tx-queue-2",
+					  "tx-queue-3",
+					  "tx-queue-4",
+					  "tx-queue-5",
+					  "tx-queue-6",
+					  "tx-queue-7",
+					  "rx-queue-0",
+					  "rx-queue-1",
+					  "rx-queue-2",
+					  "rx-queue-3",
+					  "rx-queue-4",
+					  "rx-queue-5",
+					  "rx-queue-6",
+					  "rx-queue-7";
 			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
 			reset-names = "stmmaceth", "ahb";
 			clocks = <&clkmgr AGILEX5_EMAC0_CLK>,
@@ -670,8 +702,40 @@ gmac1: ethernet@10820000 {
 			compatible = "altr,socfpga-stmmac-agilex5",
 				     "snps,dwxgmac-2.10";
 			reg = <0x10820000 0x3500>;
-			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq";
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq",
+					  "tx-queue-0",
+					  "tx-queue-1",
+					  "tx-queue-2",
+					  "tx-queue-3",
+					  "tx-queue-4",
+					  "tx-queue-5",
+					  "tx-queue-6",
+					  "tx-queue-7",
+					  "rx-queue-0",
+					  "rx-queue-1",
+					  "rx-queue-2",
+					  "rx-queue-3",
+					  "rx-queue-4",
+					  "rx-queue-5",
+					  "rx-queue-6",
+					  "rx-queue-7";
 			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
 			reset-names = "stmmaceth", "ahb";
 			clocks = <&clkmgr AGILEX5_EMAC1_CLK>,
@@ -783,8 +847,40 @@ gmac2: ethernet@10830000 {
 			compatible = "altr,socfpga-stmmac-agilex5",
 				     "snps,dwxgmac-2.10";
 			reg = <0x10830000 0x3500>;
-			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq";
+			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq",
+					  "tx-queue-0",
+					  "tx-queue-1",
+					  "tx-queue-2",
+					  "tx-queue-3",
+					  "tx-queue-4",
+					  "tx-queue-5",
+					  "tx-queue-6",
+					  "tx-queue-7",
+					  "rx-queue-0",
+					  "rx-queue-1",
+					  "rx-queue-2",
+					  "rx-queue-3",
+					  "rx-queue-4",
+					  "rx-queue-5",
+					  "rx-queue-6",
+					  "rx-queue-7";
 			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
 			reset-names = "stmmaceth", "ahb";
 			clocks = <&clkmgr AGILEX5_EMAC2_CLK>,
-- 
2.43.7

