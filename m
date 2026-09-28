Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18BB4C10E3;
	Mon, 28 Sep 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597128; cv=fail; b=qQ7w6m4+VLZq8YgCP2JETfcvjWPxX1Y3GOvmuTDXVUtwIdLM7XsREPRKDKWKM04q1CLdSC2k3MpUDrjA3CxISA58TA/5zu3HYUG4THRXJRWgUEmL3NPNZhhqvebEI3jDU67VMFL7XAeQXV8I2uQxhZKXa9k61JBoRFNB1Bd0Feo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597128; c=relaxed/simple;
	bh=HT/+s12xJbZij5Gm+EHE2r6Y9T1wHvagoYC+1G+etcI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=A9Paj+hxdGjIZIm11rVqxDWGZeI7r+LwEIf7rEi8XncoDFBSHKvDgrP0vCveJ4IMnLpzHaSDqyO+cLTlcjbZ8Szmr1cIFJKNuXVVdK79Kv7QS1h29JTxu1e6qy63oPkpslaViBTiWjXU941CO04g2lY0lig3G+Msv6bwneCKxGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=I6hvx/sm; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="I6hvx/sm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9zmN1i7GUWrwnjBwWr65DsnU5gshKOfOJ3IxiiK6r2Ll8PYgiJ8PkHJdR3UNAPCMQYLUNqZQFaEzJfRF5FRe3k275syV86Hj0FFtq3wTvkBwu0MxrWWd1/SRJtb6wfMqX+ueM/uwCiR+pu534Fauhwbfi69WgUptBb3wgvm+urczwkJW1jKAaYNM1dTlLGAPYqKJAa/V5qGIfP/yY7e2szfzNHpbB3cNdzYpiHn+LyWfkjOC5/uRDpi2od1fxpK0aWW016Bw8IFuMmgM9ypWIjFC/g74wZumsVw6sRqewTtdWPbsYW6xuo6ZVQsZp485XR5q4pxrhTOT/Z1/qJvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7K4jomwF4n+ugbv0s0PxJxXqsS8kobd1idcsCnLhOY=;
 b=Ll0gcDsdaLkavbxMAEsbHnNNt/kqiPIrz3Z4IhZQeII9FcVorViR2+DYeYmaK6NcWnGx5bog5u+qRfHHCIXrWevt1fRGxqzuHhciN8S27WyTOYjqmBZU3OuyZKEE7KowUUasi8wExg0/pn3oGMvBydBlYAqZh51+YK5Yh3A4I0w2opVErujCu21IP7/Ri0yQCgmzgNDak2gfr4iA6OWoUBtIqSBV6FFog0rEycfTt4oOOOMAGhTKJjw4nmi/5YnlcRvk8utOGyrTcR1QhYUYOEGrLsivL4b3n84tlD48G6b1mdDK5A/rn462wW5omULxojDEwjeKgSZ8TnFBlBf4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7K4jomwF4n+ugbv0s0PxJxXqsS8kobd1idcsCnLhOY=;
 b=I6hvx/smB147ewJmvDUB1pwyYzJTJ8+jDRXILvPKrh9mPUbrglXxLbMpdZgbM9J0Pj4dOlMX3nGlxKfY3FD/E+30h8GG0xCETayMP69eEhzu+4FdglnL/CW8QxAoN5XDzZ+4iakFBQiVHiV5weIjjAY4N4xO2DT1opzK+ctKsNA=
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
 12:05:18 +0000
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Mon, 28 Sep 2026 14:04:49 +0200
Subject: [PATCH 3/7] ARM: dts: axis: artpec6: use multiple tuples in regs
 and ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-artpec6-cleanup-v1-3-e3b75e10acc6@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=HT/+s12xJbZij5Gm+EHE2r6Y9T1wHvagoYC+1G+etcI=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqulfsEbw3voUM4IA1hZwD0taFi1xr09o87f6og
 V9Y5uhviVGJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCarpX7AAKCRCwB25JC3Fh
 a8hzB/9OoPO51br1zChdv2gGj8l1gwXNdCIIQ4WgpQXdbqR/eFcjCrPfwe3GRbtRESH/K+51pIi
 ViMZ+bMnhTPY1L0+thzQTScES6P4hwCHufl5XJZiFGJMp/OS7BKdT+jXdCpfRXPx03mZVKlpqGs
 i7Jb/MwJYFglt2G4j/lxfDTIeVJ+ECfAdxi9KpzgYV3z9kr+604aKW8RjOw2v5otPRFyNDxd+Mh
 3SAIFFJhwvdM/XZgfO0wcDQaviRgxIL8wAQYXSpEQ4YRBvS32PaX+bQXUes50TejdLgGI91CzDu
 oaDC6hMUH5/U+iyhSuJ5rZyU69oOCgQ0Lz5Af6A6wprKUkjm
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-ClientProxiedBy: GVYP280CA0037.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::19) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|VI0PR02MB10536:EE_
X-MS-Office365-Filtering-Correlation-Id: aec5f661-867b-443f-ef56-08df1d58c37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aKDnqgCsSMsC0GirOYnuGLkyJYBKSkZXc4dxGFtaZb7WAZKFeQkjc8eE59LRE8RprIpEFsXwex5k8jpv5gJm2H/hXiBcGIu7lsDDAN8juqWaxFQ5U5Zs9MZP/je1X4AgIrgqzYw8Mz671GLmY/sCoFxzTAy98VggiTtnUznTMJMw8oAec2DLHd1U7jtAi5jPj9SIff2htoDPj7VSBgHl2ePZWtmkqgQsJUlTBkpH0fpf1C8EhaRj4waD3PtJYHSbcvtn6NNSieUn6OMnTTsPCfUB3x75E4oyr04AP0qr17zZsbvt+ku7aBJZFZN+TnbK23/+ABneStbM9SNMxRJ8iM5nMQQwoFXlby6subpHFMH/EuGYTAnP16wQ/wahRIk0LsAJCXzgkpH3jnA0x8fbws5lTg2ZRH2YQMUgc0cd6ebwrlAUYUrSc2YFw2UEhcquHp7CbeQ43NPE59POtUdr34hV0eBhWiBOJzuZNLzZaPzyz8vEGqFI52iDynP2pS8PXQ136bbICMqBOn22JpF0fGriLEIrsm00LEdfT3fySKUgicyW1u40dA7heAOCRO+qT2UTSb3qkYivXZyXkLQyqKrFLKwspY0SeTPdN/y76Q2IoponHaBk6L5ZQvBYa7YqBunIA19DNcZ+QcWT6D+7BuWCxirc4zu1Yw0t4ddlCT8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlVDUE9Fbm95L1hCdzFENlRodXArSCtOMlphdXRWOU4yc1ZkaHNNQ2dUQTE2?=
 =?utf-8?B?d2NQdXBWQkkxUVlGbGt2a0NCQzZ5WUJXMHFVaXFTU3BnY1h5YmdLY25XeStB?=
 =?utf-8?B?OU95Y1ZyeHAxVk5LaERuWHBWYXFnK2hPNmFUS1pyWHZuQ2g3Q1B6MFhWTDN6?=
 =?utf-8?B?V0U1OURHVkt1MHNLVy9qejlqOTdDTVQzY0xCNERXQmVaQW4vZmFIQy96dnhS?=
 =?utf-8?B?cElwMVQxbURCYVl4TEZ1VnBQUC9KNTJnbjRHT0plTzNWb1JJY21TOTRCcTlq?=
 =?utf-8?B?Sjl0eVQrK3ZhZy9tYkhjeXRlUW1kSm9tdTh1U29odUtUMDBDeitCVitaNTRM?=
 =?utf-8?B?czQwTGZ4Y0NMaFUyWmlRRWVGZllITS9YZVlKTkFtd1F6RjBzVnBPbHkyaFZB?=
 =?utf-8?B?M2hqcUphdU1DS1ZlS1NjV1lneExzTWNaMlRPQnlmL1dPYUlTaEtudGJ1NjZl?=
 =?utf-8?B?dXFpRVp4cXF5TGg2bDNaUmdKWFNuZjltQ1ZUd21kUm9nMUpHblpTT0d6ZFMr?=
 =?utf-8?B?Q0tETU90dUNLS0hzY2dIQzAwV2oySlNsUmtiUHpWbXI0SE8vM0RjVU1HSlI4?=
 =?utf-8?B?NHZkcFhDTFBmMUVJT0hRTVR4VlJJMzBJcVZnT2EzeFFieXNxWkZqNm9lVjJB?=
 =?utf-8?B?S3VZZ2tKbnd6SUJ5VUdVNmpINFlJZnVXTWxCSzJLdDdkUEg4ZThxZEExVkoy?=
 =?utf-8?B?eTRQYjhVdEd6UzFVWG9LYmhSR2U5QlFoU1JGSFFRa3VLNklSR2gvNFNqekZ6?=
 =?utf-8?B?ZElPSHF3SjFBUFBBdWtjWEFKS0c5VytWdWEzTkhwLytLN2g0NWFRS2FkOXdp?=
 =?utf-8?B?R3RBQzRHZEptaDkyNUNTNGxPQ2hEcWM2RzZJNE8zVXpQQVowSnFVaTBvTks5?=
 =?utf-8?B?S3IrQVNzTUtyb2dBZ21EZWUyRWhLUkdCM29lRmJTOWtoZkNsOTBzL0hRdTQ3?=
 =?utf-8?B?eEZYQ1JmS0E1VC9mTkwxak1yUThPWlJaZWJQZ3RKTTR0LzkxODVWRStIUEZS?=
 =?utf-8?B?OVJrZ0t5VzY3QU1vUHlWWFk1QU12Z3dMSUdWVkF1S3VXZkYwQW9aK3RXY3d5?=
 =?utf-8?B?MlVzdWtISUdkbnNZV0xSb2lHeWVFelhTaXdrd0tqTTJyRGFqenJkZnZxdEtr?=
 =?utf-8?B?Tjlsb3BLZFZ5dFZDc05uUlk1ZXE1RldQR1FLKzhJd0wxaW45VVNxWTg0Znk1?=
 =?utf-8?B?T1JXeFh0c2pKNEMyb0V6YXZMR1dXUk1RVEJBL1p6aGpHKzZ2UlBwQXVva05r?=
 =?utf-8?B?Q3FoaUk3dlEyMENVYVdEMjVGbGdmYWhINTg0dDVSTzZ3WGJDZEMxMWhGOHJN?=
 =?utf-8?B?bUFLdWlpNmlBKzVqSFcwOEM5Q0lGTlI3a2plMVpNelBOcEZYZ1ZKZlBuTjdB?=
 =?utf-8?B?NGdHZURYblR2N3N0b3dEa1pnVDFsaWNGY0tHVjJEUVlSK3Fwcm42RjBGa21z?=
 =?utf-8?B?RWZFK25TUFc1b2lqdlg1R0lVcFF5eXdDNDU4ZGFNUnd5a1VWK3E2RE5nZFJX?=
 =?utf-8?B?N2ZjVVo0M1dWcUk5MnJSbjBoeTJTRnpDZ1N2Z3FQUmF1NmdmdkNGQ2JwUk1l?=
 =?utf-8?B?dU1WemtZMzJZWFB3amMzMGJpM05Xem95dXhEenRNYmpVakpPT2NpSVREb2dG?=
 =?utf-8?B?NmFVWTZRNVl6cm1QYVhJc0tmbmpTVWFSVjFXTDkwQi9ZOHhURzEvUmRqRS9m?=
 =?utf-8?B?eHFrREVyZnhpcDd3VkhQY0RqR1I4Qzh1WUxTcHBGVFlKOGxZWjVKU1hlR3Yx?=
 =?utf-8?B?QlhFMEMzZ2JCRlR0TXVqY1FLVVBsZkRHYzFmY2lFd0dES1lRelZFWitSbWI0?=
 =?utf-8?B?cnlMY1VhQnhUd3ZHL2ZLckpaekFXWXFoYUNTOXJMTHp5L2dFdDlCMFRIc3cv?=
 =?utf-8?B?aWxJTzdOYlpGWm5VNG0xYzF4cGk1WlRzdnZSNWo2NCtXRzVUa0ZJbjh0QldT?=
 =?utf-8?B?dDZqTGRtdlo2QVh6YjFnaXNlSVNhdzRyRlgveDlmNlNTa3N1TVRuRHBuZlR4?=
 =?utf-8?B?WGdmR0dTcS9mWSs0ZUZNcE1JcUl4ZzFxb3k1eGE4Q1BCQVBCNFFPWi9VazB1?=
 =?utf-8?B?UUhrK1VTeDRJaWswM0J6Z0NkQU9JcTRud3kwN2lTTEtwQXcvSVJmZlZhdjFa?=
 =?utf-8?B?ZUUwZ0FrTFI1ZlN3eGp6L05WWlExRDhhQnd6bWxiRndvTmk4a1YyMFRsZDhG?=
 =?utf-8?B?ZUNtTFI0MFpHakk4NTRuaW5tQUdGS0ZSVEVzTTZBemlzelVndnBTa05mTjR6?=
 =?utf-8?B?R2dXUGdkWVJibG5Va3lwT1lwSnUreTdrMm4xOEsxQkxEb2gxYzlFQSt3ZWdB?=
 =?utf-8?B?cS9oSjFKL3ZvdVY0ZHdoUDE4OWY3bTdPNllWSU9HZGhCdnBUWnBvdz09?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec5f661-867b-443f-ef56-08df1d58c37f
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:05:18.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ANMsqoFeDpyR3nYSp6ZZByJdr1u0LqDybSFIA1J8noJAEiV7P/Yuiyq9/ooKhNFHjrSJrnNBSWMYyVrjX2wiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10536

When #size-cells > 1 it is preferred to have each entry as its own
tuple, to make it easier to identify addresses and sizes. Update
artpec6.dtsi to use preferred style to increase readability.

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index d6610f62ca25..49439058854d 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -161,17 +161,17 @@ pmu {
 	 */
 	pcie: pcie@f8050000 {
 		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
-		reg = <0xf8050000 0x2000
-		       0xf8040000 0x1000
-		       0xc0000000 0x2000>;
+		reg = <0xf8050000 0x2000>,
+		      <0xf8040000 0x1000>,
+		      <0xc0000000 0x2000>;
 		reg-names = "dbi", "phy", "config";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
 			  /* downstream I/O */
-		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000
+		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000>,
 			  /* non-prefetchable memory */
-			  0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>;
+			 <0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>;
 		num-lanes = <2>;
 		bus-range = <0x00 0xff>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
@@ -188,10 +188,10 @@ pcie: pcie@f8050000 {
 
 	pcie_ep: pcie-ep@f8050000 {
 		compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
-		reg = <0xf8050000 0x2000
-		       0xf8051000 0x2000
-		       0xf8040000 0x1000
-		       0xc0000000 0x20000000>;
+		reg = <0xf8050000 0x2000>,
+		      <0xf8051000 0x2000>,
+		      <0xf8040000 0x1000>,
+		      <0xc0000000 0x20000000>;
 		reg-names = "dbi", "dbi2", "phy", "addr_space";
 		num-ib-windows = <6>;
 		num-ob-windows = <2>;

-- 
2.43.0

