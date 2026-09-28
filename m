Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB04BA1F1;
	Mon, 28 Sep 2026 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597126; cv=fail; b=TMaX5/gSXndjZcTe9oR6nfIXd/8GQX9mcaZ19ty4vLbtfnMejYzBDuu1wFUnAbTu+0eWrfwwEY5AQCBzNvGaDvvoORMkg3JgStWu2RsZGAF9ooy4MRuVBqB7btBXUbxvvn82k21eGhDGNX5IBfx6i18gR+5FGqrZK7csxIVBFOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597126; c=relaxed/simple;
	bh=TsaXMdbcjKnhZLCgXBENKITr6BRCJ1FZ7Hu3ni8UQG8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M+2jeNRTbCovfjf+cHuXj6fXXuiQ4BUXitr+oigzjAvmkIU0oL2HbtQcGXlXqSTv5d7YJAOr6Oj5Bq9g7+Ep1pzLYkP6kNHNUdGQHey7ewpRt9d8kQd5CpxQ9mx3rzlVxCtlAA0l53h3eHS1r1oBJYgNcA/JvFZEH01M/bXSc84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ItGIftN+; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ItGIftN+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+1EN/2wiNUgORRCk/qKEWuI1UMJfWR8bzEob13m6rOa3bZ3QlPdsPNwhfXMEeLfy8KHKYNWr8xWt0Q/cr5phrX0+ewgWrGTUpcG/oFODeGudFLi8wfaxRaJ/u69ipZEE4sKbwIkWrJQ8d735WDlGJqxnbxTIGmYa86mJ6rQNMlcYLP6URmgEHPSKdYzfxQ37odrV2DMDzH13Shd3VKvL5kPtMi9qvLVtNjv/YspsnXfnyzNK+nMTn/zGjRQbYm5u9iu1BtevOPAzfZDnKVen08wAJU8zFSzp3GuMwuRDJBD890QxIZjne9gpRovq8wDGb4s25nn7RsP6+e2PJYimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqAlterKQYE8JG95SP+eGi77TEbqrDs01JRO3oEZ5rc=;
 b=DJgHI1rmMyjq37mAjAD0bWDV3yad/+ngRNrH/h6JRrfcc4ClCAqF5+dXixvfqzGuB2NJwb+Rn/rRMwB+6U0C50D8nuoALNkU4/bUNueZtzXVaDYmgwPTlw42EGCXc79eNKMFvy1mpT9BYtYg2sjNn2fzL5TRPnKunxOcbraP9gZ+3tQA2RyfR1x5TvKZ8pCRQ31xiHjhhpQ6dQ/6fk1WRpA2Nuz/ir5Doz78vqaDnPJqjxKQp2n4AcUoO1NHxP7Zo+zzFKwlkUkA8oNkYFE5BzbxkfaLfDiX8XuEGbpRA666z6uqt5CyiUjHh2G1CuJsHjFxOMubDHRahwbuvrCsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqAlterKQYE8JG95SP+eGi77TEbqrDs01JRO3oEZ5rc=;
 b=ItGIftN+JE4QJcnt/UE9o0Mi0oQEUue3BzY+Kpr5kP0R6LOyl9DLJYCLJNezaox8YXlOfxMMteS/ncKWMRK6NuxJPd2VKe/zVDnJNED68zIxkuoQyaEvVCyILFoERYNj0aaMC1eWwvbXAm5f78QhqhVn2FYbku6dmEPhXLplblw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:05:18 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:05:17 +0000
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Mon, 28 Sep 2026 14:04:48 +0200
Subject: [PATCH 2/7] ARM: dts: axis: artpec6: align all continued lines
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-artpec6-cleanup-v1-2-e3b75e10acc6@axis.com>
References: <20260928-b4-artpec6-cleanup-v1-0-e3b75e10acc6@axis.com>
In-Reply-To: <20260928-b4-artpec6-cleanup-v1-0-e3b75e10acc6@axis.com>
To: Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@axis.com, kernel@axis.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Henrik Grimler <henrik@grimler.se>, 
 Henrik Grimler <henrik.grimler@axis.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2861;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=TsaXMdbcjKnhZLCgXBENKITr6BRCJ1FZ7Hu3ni8UQG8=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqulfp/OUzKHW07I8rGXfdVvit8JusZBLnhTrWk
 eoWr4f4QB2JATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCarpX6QAKCRCwB25JC3Fh
 axCHB/sEFOyhYHLFIfsc6eOAFnP9QTAzkUAz79IWQVHalbYH9ABr/C+Cy6ersPbhAEtLfZwY4I4
 uLuZMSrcclNdCmTt/X5XjupVWqQdvgVjR2XrD7skplc4FDkIKhYJC19nxSngAxU7GhdsUBgL8ng
 /1H7t4X012V55WbkXyzmeBExoMIbR251A3i1QpUZaD63pPz3AMG/dRo7MxA31Ekrf3bfeCb9UwV
 YjfAlA/fUp8HoPS/W0P1aOl3sKYgs/HJMxSyliqEPw+BP5wH2FVsEXJppJ5CMgA599PWTUtgSYf
 HtLP4Ede9kcPWq2JSet8duTKP/zUdeDe8y4lzGjXJRdVYkVp
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-ClientProxiedBy: GVZP280CA0089.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::9) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|VI0PR02MB10536:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2a2973-348e-4501-6f0e-08df1d58c2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dU9zGW+4lrzqWnGzmTv49XHZnYot/tzMSpmS6GuJbqHQ2tH9Se3o2ba/ocoQBaSI9OkyK8hgRmQsAeRScb85CSDSsGL8Qizq23MqdfWTi4P6+nXF41vHjclqPRtyElGwpferajhKiu0y3BSU/8+61qqHNG1AY8ijPU9BQuAo0eHutbdUxLixFaFPpnFZM5GeoJ3hVAiIb3IO1lk8Kxqyt7rKPhuME6WgWWDBHlRQnzTMwqa4r9PXJuRvkclLxU1/nojrSOUJW8x9jJSXDX2IsMd0IfZAwI4dBEHtlOCNTM2ZsmejIOT4LAJqjll/E/HztfuMLwoFvCxZqMy0tapRm8rNr2UI0lQb+4tw1oHnbKGTJ5qVXM5r5L3OiQn8Z7JydQio5HQwwJJRNTWwl7/oEVLGAYdw5t6Dc1mSgIsZ4/Lzjkff2wZdR+R8mB2ukdvMky1inYJ7Wt2VDg0BJpau8LVi3Q8pwND+Xb5NDAaitaoHd3VkbIejsiiAnQAeUufGPoDEQPPggudaNu1035MIg7m/UQTwDhnQWM6inNrbC+9/gZQSTj7GMAj6NVaoP72MC1BPSKR09ktz73eXRjSzs2gHKl55Z3a1soNSwKzI4tJ0oUqXA+ZPLVMxm97Vhp1wVWQVxCFsTer4x7x8uA/DF8S4dQLM539NSMr7aibfSYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vnp4dkJ0WUxGdURGanp1Q1lyM0pUdW5OYnFwbWMvYkdHdzRBNTdISmpXa0dY?=
 =?utf-8?B?dmQvYmt4c29XYUpZT2FldkRSVzdKaUs4ck8yK1d3Rmp0NGN0UDNZSmVZN0RE?=
 =?utf-8?B?T0tJK01GN0JtRlZJTGs1bnVsRklvOFErVm1INkdrZ0RhRjNWcmNXVEdNb0lK?=
 =?utf-8?B?cVZpRkY0MFZhRzJhNjg5R3V1K0k2RXVnVE8zSTRacEkvNkhSNElSOEVDWFU5?=
 =?utf-8?B?S2M4eUMxdEljcVJkRS8rQmJQSE81T2dLa3hwdGtFMjNSYjBtOFNicjVYSjJl?=
 =?utf-8?B?YmkxbEJOa2pBcEg4dlVOK25BOS9kU2Vtd3V1M25SVFQvWUNhbHMrM1hJbTZm?=
 =?utf-8?B?QWNBQnl6ZWpIKzBITm43TlpBSUk3TXQ3QXQ3RXplajR3cmVLb01ieXVKbG43?=
 =?utf-8?B?Y1lCSUF5MjYvQkFlWE1xeCtvb2xLK0FKUUtiZEhQMlNYNCtBQzhIOU1pZytw?=
 =?utf-8?B?Vit1YVFNbmkySnZVcElLV2ZUY013UThjNVpzbDg0SzlPRWJiYXA2VW1jb09S?=
 =?utf-8?B?TkttMGo0dXp5Y1N3T3NEN3ZKVFhPSE0vb0ZqNjdhM0dnMFF2SStsSko2aHh5?=
 =?utf-8?B?WmtYNlRrb2RYY1dZYlBhamt2WGpzaklmNnUvZzNJRDRXMFhnbitoT1pZRXFa?=
 =?utf-8?B?L3EyWjRiYkdFT2FvQ3I3a3MyUENEblA0bkJGMFZlV1QrbHkwUDdyVXZuNU9I?=
 =?utf-8?B?eGQrcktBTzdFYnY0a0tXWEJZbS9SR0V6ekNEWGlWemVmdFg1NGhnUU9hc3JM?=
 =?utf-8?B?UStDaWlza3k3bEtLTTRVQjdoT2pleTR3eWJzSnpRQXo0RGhQVW15RURrVWV2?=
 =?utf-8?B?SVdrU09BbUg3bTh6cnNsWU9MRTZzZkNPK2ZYSHh2bkpVZXNGbFZ1OTlqTHdj?=
 =?utf-8?B?ZlpjMDhuc01KWVRHTUthOUQyK0pSeGNVRVN6OTJmRnltSkZqN1FlM09JU0JM?=
 =?utf-8?B?amQ2eGRyeTVCU1V1MlJQVmh6bjYzZy8xRk8ya0lFQ1RaV05vd2NBRVhpNmlV?=
 =?utf-8?B?c081Z2JJMGRKenhqVDFVbzVWTThxUTNRSElGQWhLUUsyeFdsZ1N0d3RoTFhW?=
 =?utf-8?B?eTJOWURHZ3dnRHBDakMwSVZ6UDlHaHhpOWNDWmxXaXhFYSt3a1d4Y3hwSWRq?=
 =?utf-8?B?aTh2b2loQzhZVHdmYUp0VkRXbEpyRFpUU290R3JhamlDOGtCVW1FUElZMjhU?=
 =?utf-8?B?TkNzRnlUOGtYUHZoV2Q1V0tyeHJBbkJETFhUK2QxWlQ1a3hQTXFXZzYvMGF3?=
 =?utf-8?B?NG5pbTk5STdpQU1Ib0hoWERPenRIOWt2WFk4VWdTYnNPSFhYc0o5L1pHNVRD?=
 =?utf-8?B?amlkaFRhVjl2NGRkTFE2a3M4SnltKy9kRHQvVUREdWsvSHBXL0pxMVd0Q3lG?=
 =?utf-8?B?R1J0K2hSbUo3KzJWSDRaQXVyT0pqc2s0NHNNNXVUTis0TG9BamhRT1FTRDl0?=
 =?utf-8?B?aGoyUnlBK25JaHJyUkZLRjQrejBDYjVMdTU0S2NwZ2NjL3B0cENrU2h1UEFy?=
 =?utf-8?B?YkNvM0VLWk1SSGtEZy85RWpsRlRWYkhuY0RzRVVGTWdWbFIrRjk2Vk9oejBB?=
 =?utf-8?B?aks0K1VGUXhRcjRhd0NIQ1doUEpGaGlCRzFURGpsVkQ5YmZmV2pSWSs1ZDZO?=
 =?utf-8?B?UEVSNDBGbGtXd3ZPeFFoVnI0dWZ0YTVDWWs0TVN4bWlBclExR3J0UTVJbnJY?=
 =?utf-8?B?M0xLNVBCanlkVG45bjlJdVdwemhIREUybG9XS2o4dkNyK2ZLQTdRN2NBRTJs?=
 =?utf-8?B?UUUvS2lUVVJNQlh3a09za3ludG1iVXpQanNxQ21YanhIeWRRZk9pd3BaWEc1?=
 =?utf-8?B?WXF1cXdXVUNIMnRPQkMvelV6dFo4VGpZRUZPd3RjeXhiWFREeEh5NjJMY2NO?=
 =?utf-8?B?K1NzbmlmMVpLVnNBck5PUi9DMVdkbWVNVzFzWnZOYitRMU9QVFlJRHdiS3Z6?=
 =?utf-8?B?OUZXaXRaK1l1VjZIMDlOQVIyNHpPYzdjVml1V01XTW9ZMmc2WWpYZ1h0enZP?=
 =?utf-8?B?cnFrVkJIVG5zdE53TmpCZHlub1YvN0VEVlpBb1cvd2J3bTdUUDAydVUxMHBw?=
 =?utf-8?B?b0FnT0xYKzU4RG9wYzY5czR2TUZ0K1V4L0NTOHVEcGJjeGcrUzk0L1ZWbFUy?=
 =?utf-8?B?anBHcG5zM1MxZ3YyUWNSMHdGZGk2Ni9Va3Fld0NycGRpZUtkMmlqa0tXRnFy?=
 =?utf-8?B?djZQYVR3MVNjZFVEVk5oSWU5b0piTTQwOWR3VXA2UFd1QXRocmpBSXNmZmtH?=
 =?utf-8?B?OU14YUxNYTZPaTRadDFBMW1tU3Bnd25KclBWdE9SVjQzTWQrUkJGZEUvNFU4?=
 =?utf-8?B?QWtaa29Xd1UvelpPZ3BzaWsxa0sya0tNRHNBNzNxRGs2RkZKUXRiQT09?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2a2973-348e-4501-6f0e-08df1d58c2de
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:05:17.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6YhVlKjeRYZ6Mt53w2GEiY9osUombmN/7UKeq78BFr4gLrKWsR9ttvaBwSgI6+rG/MUn4OqkElryP5QFo4uCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10536

dt-check-style in strict mode reports that there are a bunch of
multiline properties that are not aligned, fix them to make the dts
easier to follow. Fixes dt-check-style warnings like:

  axis/artpec6.dtsi:290: [continuation-alignment] continuation should align to column 34 (to < or ")

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index ce642dcc754e..d6610f62ca25 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -151,7 +151,7 @@ pl310: cache-controller@faf10000 {
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-			<GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
@@ -287,7 +287,7 @@ dma1: dma@f8019400 {
 		ethernet: ethernet@f8010000 {
 			clock-names = "stmmaceth", "ptp_ref";
 			clocks = <&clkctrl ARTPEC6_CLK_ETH_ACLK>,
-				<&clkctrl ARTPEC6_CLK_PTP_REF>;
+				 <&clkctrl ARTPEC6_CLK_PTP_REF>;
 			compatible = "snps,dwmac-4.10a", "snps,dwmac";
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
@@ -333,7 +333,7 @@ uart0: serial@f8036000 {
 			reg = <0xf8036000 0x1000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
-				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
+				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
@@ -347,7 +347,7 @@ uart1: serial@f8037000 {
 			reg = <0xf8037000 0x1000>;
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
-				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
+				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
@@ -361,7 +361,7 @@ uart2: serial@f8038000 {
 			reg = <0xf8038000 0x1000>;
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
-				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
+				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
@@ -375,7 +375,7 @@ uart3: serial@f8039000 {
 			reg = <0xf8039000 0x1000>;
 			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
-				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
+				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;

-- 
2.43.0

