Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2994C4F62;
	Mon, 28 Sep 2026 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597133; cv=fail; b=dQLiVde4xLwPWAmaSGH3UxtoLuxPNQPSUpOsPD+xu/RvLokhhmN9CYyc00PJQiNw/6//uSctimnVQ9RkT74cIUzeoGbFkn1OTjXNW2u26qVAQQ/beUeH/hHAbVk+aDSFFrF4jkpL/fPaVh1D3DfWERBrHkp086HedOOCiTbxRRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597133; c=relaxed/simple;
	bh=wovCHd4YyCNpa2tf88ca7sMwerZoak3RP2C5KaPZdmM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=d4tDRaPMt9FKwoLrc0YXSEMtS6XHz0g+VeuMfW82oqMn/A+tI7wTskr0rQ8ogMxBZE7B5x9sxRLtSeACEXiWTKRv9n+O1OKky0+b1ulHsB8LMhNj44BBKeu4HC9UGaWXunLM2JA21aoq5Ok81CNPrE3TVONKQD69aKaPSntdp38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Ck75nkNa; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Ck75nkNa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMeGiuzPYz2Pby0OYi51TyEsg2mYLOmFIQ24AiOgWobzN4FAL2xYHathXIhnPIZBRf4jSAltyxSz38tsTddSGrQPsWQyBPGQ/B6R5KqjliDDT/HEEkdS9sSYlrVp06PBmR04KQy9CrzLEACukuAqKX/S6RrqEY2jMbO7KHa7Hw9SZle5ostC6X1y2JJrC3BI8RpOQl+xHLek1eFtJ6X6QvuglT4+1ZcdM97/XHvc8XtRAVsuUcAuxp3TxMpivr2ETYxQlJ/3aZoUi3P0GcvPq7E+pjszEvHn636iKbkevEDFDx15uTJ/aIpI16rQ9w1tj4sDcI7yx4VSaYAND4Tb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k53Onqd+sA/PGeF5w8A9wt4JY5MpC8B4oOg+6983/p8=;
 b=XGEGlA/CCzkr50Yv6cwRGCdyjS7jqMKMQZZ7EuzbjQ+NBzcpgwUzZtxyQBtw8Ll1PS58L+Tpe5gaHN0VUtVYtEtipqNl23/L5rlf9Pbyve6MyllKyGL5dQ1KBpKrvcVGKLZE+n6qT99MaBBq6QZjVBWMXLWQNiPk1ImiJF3LTVNLjzoKXVEQ5bbBdMcrxL9yP8Ar0ZatFZ+TrqCbYkZKARLZPeN2GC+s/L5u4XpCAMR2qT8mt1vqbtpSfNJaY8Hpu05KgWOiCKt/o/V/FmMbEpiOCN44426HqzKoDg2Sl326WMxueMbt0eaoFh3yIxGVbgvB/zHZEkrK8gi4KerI6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k53Onqd+sA/PGeF5w8A9wt4JY5MpC8B4oOg+6983/p8=;
 b=Ck75nkNauo5Zd6XZW6S03xdAu68/6N9IpHpO0/IJEpuLV1xl9nZY5diLomHgi02SEyO/38Xwv2gXrgsY4RzmmeEYvrWynpjenv3THtK+OpcLKQPOhSoYxDDM/x0QM6m65IxT3EQJrzkeC9WES6x5sZ+BQ6DpvQkRTwVSw3J//QE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by DU0PR02MB9537.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:05:23 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:05:23 +0000
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Mon, 28 Sep 2026 14:04:51 +0200
Subject: [PATCH 5/7] ARM: dts: axis: artpec6: add more blank lines
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-artpec6-cleanup-v1-5-e3b75e10acc6@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3722;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=wovCHd4YyCNpa2tf88ca7sMwerZoak3RP2C5KaPZdmM=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqulfye61oqVMKjYrBCXU05HCXF7Fi6ATJTMOEv
 JKLQjLBpNeJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCarpX8gAKCRCwB25JC3Fh
 a5CBCADFbL0m+A2cAypoSZUsVakLEXXr9oPN/sXWQmr6w8p+YFQb3Rkj6588VZKXibU3eG1BGiW
 zHcOAwDrZA13POzbf9LviAaH9qtsNx17QyptBoGTK9GLR8pcrQODkfsR9YR5pCiZ+UIWxl4Hdvz
 rqZN3bRxYXBT9zzdHSAb7UbscyoNZ+DcOH/fQPtDyf6iGBR4VUO+4TQLT5BKMPlH5eAOMvGNf85
 tS/EaiAhzgX6bq6x+2G2dHCS3KWPuGhSAjJ8mWZHt9FG+yWGNlGW4AnfL6iQW793222dt4Thff8
 y2+z6xRL3kwOjcxe66sK1Rj0hCIubI/lmsZNbYic3Jw4OxiE
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-ClientProxiedBy: GV3P280CA0025.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::21) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|DU0PR02MB9537:EE_
X-MS-Office365-Filtering-Correlation-Id: 659f496a-e6d3-41e4-9b78-08df1d58c5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EdWsyHtXSQ1PCUa6IAT/qHUap052ZPgbyQf9yaGRcVdRVYjgTwodoGt0q63ySGws93Q49f+juMwK6mmnxmXcBDvKp39IcPKUDhWenvjZbLIQnEirCMP3ZT36T3IA3is03ak+xARje3hBRHSI0/kdPW2cpztyeHU0a0WDXhlBGN7g8LaD6Y84SNkGhwfsynYTAnF0aAQCQ6A0p1SlP60UycB/mb/VcGgVYgMjJKiDREunsZhRC58Zb+Wb9y+7e4XAoTvVev2e+oeCcAcilZnei1mWpqXdvWudydG+PS5oXijcrP30W1Jpgw+VK+w4CQ6z2RG7izTWoUI5JwKLUvgN719E7horHqVCVpguQcvZqVIkVvS0suELQbXZHXW3mvMb2jSmPh2MLZdV2xmkWLPYtA3PWAduUMXlmuTX+OZHFxYJAJXfcrEOH2h3/StbOlmlKZY1lG9dpTXxZobNLkUL6RyMoqeeW/4Bx7UiFZ5bHCrCJlPpWNWMDylcA8EY1Mbl/XRlZuwrbZ7UM07eJamc3Z5h9MTQa6oRNVdh/ykyK+9l3QgqYcbAe8zYiPjh9Ebn6LdqVrf/ioShqHHdVZe2MwzHX0C1qkduys2u+9wi1Jf7sSIw5f8g1neA3VMhCDhTT5pN/ooMsGI3CgrnYrsCw6MalAqIyvI/yPwXBEI61Eg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVIzTHFDQWtrZm5WVlRRYWpVWmRMOXAyUW10TkRDWWsxUUN0aWpxQjdOS1dU?=
 =?utf-8?B?QzVJK3hqV0pyRUV3VnBoUFdHZnN2L2ExUkZqaVVIbkhBWUdPK3lySHhZQU5Z?=
 =?utf-8?B?UDJQU0RmY0I3S0trZXBSci84d1QvTWZiSjVBYkRIZ2d5eE5NWnI2dFhJTFFn?=
 =?utf-8?B?NFN0czRhRGZiSTNyNkZjMmZETndrZEhIRlRwTzdhdG5tK0VDTFZYZFU4M2p3?=
 =?utf-8?B?eE5QeVBNWlp2eVg1WGd5dStZNVdKd1dGNDk0d2xPVWVNTFlMeERVZGloTGNJ?=
 =?utf-8?B?Nlgxc09ueXBHQ1k5dzcwK1NxZHFDMTFlTVdpSlBqdjBoczcyRGc5TkhWVVhU?=
 =?utf-8?B?ME00czROWXBGTTY0L253dmtEM3ZERmpoZVNGU2w1V0UvQlNDT1YyRnBnemtr?=
 =?utf-8?B?ckVrWlBjWFlqdTRHaE1MaEc1MVVPM0VsMGJlOVB2Rk5GRHE2M3hZZUFmSjZJ?=
 =?utf-8?B?dzVFeVpJRHlqK2lmejNMVXQvb2o1MnFuT2w2UFRlMUxJU1JOeGx2bFN6dDNT?=
 =?utf-8?B?UWpxbTVWbXhjTjdGRUVZMG10SHVuZnNkY1FrSnlKLzNXL00xeUVySmpFUitC?=
 =?utf-8?B?eThRdU1iTVJBdmt6OFV0a2JHVk5ISGVwcFNkNjVTNXQ1VjJqSldzanNwcmVi?=
 =?utf-8?B?S1BzK2NnaTdiWFFYR3NwME9VSzZ0dGgzaHhYQ0FHUXZEVlIrTy8yODFJN1lZ?=
 =?utf-8?B?M3ZhRkRZV3BuLzk2djBWaEFaU0pEQit3ZXJON3BxNjVHWGlITGRoeFFCV1Bi?=
 =?utf-8?B?Rkk0Y0ZZZUg1VEFHZ3RxY0VLWUVHdGd2eHJLWkcrQVh6WWM1V0Eyek00c2Vv?=
 =?utf-8?B?QTI1VHFQa09YaE9sM3RPR29zTGhDMVZyWFVjdnhWSlJaWVVuK3dpVHVrNU1U?=
 =?utf-8?B?MEFnekZTd1JnMkh1SFhVbWFYQW1RU0xlWTZOTWQwT215aWJvWEhIalBURUJH?=
 =?utf-8?B?QnpoKzdmNG1GNVZSUGRQWGxkUGZ4aFNoTTcwcU4zb2o2cFB0R1hYeXRzRCtX?=
 =?utf-8?B?b0pFRngxTStCVFNEV20rNktHdGozSlZ5cm54NGFpNmJPYVB3RVhwU2lwemJX?=
 =?utf-8?B?KzJWOXgvUkNWbWlYTW94ejlEekM0aklXbXlVcmxhV3NiSWpDcjR0dVorMFdt?=
 =?utf-8?B?WjZ1VjdTcFVKQkZKcTd2em9MQ1JRTUd3TVB6SmQyTitvK0dDdTdudkR6KzBH?=
 =?utf-8?B?UVhZYkYyS3hLR3BML0RrRUVFNnRmSXRhalhmbFJTMk5BdHdEMmkwNUl4djJa?=
 =?utf-8?B?QlI2Q0VFMWVyc3c0VnpTNnRBVmE0dGhES0VXblFnWnZrTDhoZXF4Y0V5UlJH?=
 =?utf-8?B?dUErTG5ESnI1WlJTMjRjNVVITjVuUGtjMmdEZU5DWUFKSmplT0p3dTQwNmU1?=
 =?utf-8?B?LzJNdTJKbWdUSG5qVGE4c0Y5YkxoZWgzTUdpS1o2SFJzYkltQVlGM2pVVTJ1?=
 =?utf-8?B?LzQwcEgwZTdvakR5dTRSdDk5cjRUOEl0ZDE1VjQrcFZBZWtwNlhUeWd3bUJS?=
 =?utf-8?B?VUVXVmFIakdRVE5GN0xyTDNXVGZxV1ZxRll5NXRNN2F6U1E1b2ZackVxRHNa?=
 =?utf-8?B?b0FHd3NTNFBlenNIMnd2djA3T0doUGtWQmlzS0Y1bUc5YWJqYnVOQzhmd2Q0?=
 =?utf-8?B?ZGdyMGtsVWYvUDFvUlYxYmFFdUpoS1pKZ1d3ZlJHSThyUStQSmpKb2x5QkZO?=
 =?utf-8?B?UWM2Nk9uUTlkWVFJOUlMV3kwQmwzaDBMTDU2d2JZY0JPRmJiRmIySDdEZ012?=
 =?utf-8?B?cmRnQllhbWxjQlFrSlJvdnZubDh6U2l6eE4rMDFDR0YySmdEbXhZTDA2MXVh?=
 =?utf-8?B?bFR3ZENNNjI4NEQvQzdyYVE0dUluTlBiWXdyOXVqRlp1VzRSZklGYlkzd1Uy?=
 =?utf-8?B?dzN3YndUWU10NWtPdEptVWRQc2ptbG9pNGtqZjJCcFFpZzduNkNZdnlNNlRL?=
 =?utf-8?B?T3R5eEFlSjZWOU5mczZhUEZhQkpkRkgxcTNYZDJBVG4rbGZRQjY0UysxZGdq?=
 =?utf-8?B?N1lZK0RGRnQ5SEVXaHp5NllJZUUwQVN1SzU5Q1M1K3RZb3hPL0pUWVA4MXF5?=
 =?utf-8?B?RlZteTN1QkhrZ0lqWVVDTm54UUM5RW51Vm1HQit6QkJjVDVmcUN5SkxYSndz?=
 =?utf-8?B?S1M5M3lWYUNNdjZnbGRTbkdBZEFwc0g0bmhya29XTnAvaTVweU90S1JhM2FK?=
 =?utf-8?B?QlNGNFU0QndVeTNoYnhHNXhCbzE5UDh4V3FCakNiS3k1dGtucEl0R05aekZy?=
 =?utf-8?B?TmtKekxnQnlDbENCUlYxYVJvUmtVNkF2VWQza1dqaEU0bnZab085bERqaGtp?=
 =?utf-8?B?Y0NQSHYyVStka1VLSDdjQzdkNDVxK2g0TEtwUGpyOUFodFZORWpkdz09?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659f496a-e6d3-41e4-9b78-08df1d58c5ff
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:05:23.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spcHQSKFpHUNdjlZEF5Otf6cms3f49Rv2bUWmCvce1H8UJUEFXShQvO4eHEy+tl7wVd13t7Aqnozt20VY+DgoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9537

The status property, and each child node, should preferably have empty
lines before them to increase readability. dt-check-style in strict
mode reports this type of issue as:

  axis/artpec6.dtsi:186: [required-blank-lines] "status" must be preceded by a blank line

Fix all occurences.

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6-devboard.dts |  1 +
 arch/arm/boot/dts/axis/artpec6.dtsi         | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/axis/artpec6-devboard.dts b/arch/arm/boot/dts/axis/artpec6-devboard.dts
index 9a91f9758442..55fdd610d3ed 100644
--- a/arch/arm/boot/dts/axis/artpec6-devboard.dts
+++ b/arch/arm/boot/dts/axis/artpec6-devboard.dts
@@ -55,6 +55,7 @@ mdio {
 		compatible = "snps,dwmac-mdio";
 		#address-cells = <0x1>;
 		#size-cells = <0x0>;
+
 		phy1: phy@0 {
 			device_type = "ethernet-phy";
 			compatible = "ethernet-phy-ieee802.3-c22";
diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index d3079badcf21..146a5fd98528 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -120,6 +120,7 @@ timer@faf00600 {
 		reg = <0xfaf00600 0x20>;
 		interrupts = <GIC_PPI 13 0xf04>;
 		clocks = <&clkctrl ARTPEC6_CLK_CPU_PERIPH>;
+
 		status = "disabled";
 	};
 
@@ -183,6 +184,7 @@ pcie: pcie@f8050000 {
 				<0 0 0 3 &intc GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				<0 0 0 4 &intc GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 		axis,syscon-pcie = <&syscon>;
+
 		status = "disabled";
 	};
 
@@ -197,6 +199,7 @@ pcie_ep: pcie-ep@f8050000 {
 		num-ob-windows = <2>;
 		num-lanes = <2>;
 		axis,syscon-pcie = <&syscon>;
+
 		status = "disabled";
 	};
 
@@ -209,16 +212,19 @@ pinctrl_uart0: uart0grp {
 			groups = "uart0grp2";
 			bias-pull-up;
 		};
+
 		pinctrl_uart1: uart1grp {
 			function = "uart1";
 			groups = "uart1grp0";
 			bias-pull-up;
 		};
+
 		pinctrl_uart2: uart2grp {
 			function = "uart2";
 			groups = "uart2grp1";
 			bias-pull-up;
 		};
+
 		pinctrl_uart3: uart3grp {
 			function = "uart3";
 			groups = "uart3grp0";
@@ -261,6 +267,7 @@ dma0: dma@f8019000 {
 			dma-channels = <8>;
 			dma-requests = <8>;
 		};
+
 		dma1: dma@f8019400 {
 			compatible = "renesas,nbpfaxi64dmac8b16";
 			reg = <0xf8019400 0x400>;
@@ -340,8 +347,10 @@ uart0: serial@f8036000 {
 			dmas = <&dma0 4 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma0 5 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
+
 		uart1: serial@f8037000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8037000 0x1000>;
@@ -354,8 +363,10 @@ uart1: serial@f8037000 {
 			dmas = <&dma0 6 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma0 7 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
+
 		uart2: serial@f8038000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8038000 0x1000>;
@@ -368,8 +379,10 @@ uart2: serial@f8038000 {
 			dmas = <&dma1 0 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma1 1 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
+
 		uart3: serial@f8039000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0xf8039000 0x1000>;
@@ -382,6 +395,7 @@ uart3: serial@f8039000 {
 			dmas = <&dma1 2 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma1 3 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
+
 			status = "disabled";
 		};
 	};

-- 
2.43.0

