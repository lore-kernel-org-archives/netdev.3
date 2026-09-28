Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E414BD34C;
	Mon, 28 Sep 2026 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597124; cv=fail; b=IMJcuqZK+xPHGpeRLvOoPV8D2lBLKpyq/Sh/Bm6T/klvZM/CMgIdJ1EL5rNQtn9vN1WuBoLIYP78wpCPDDRd6t6pKheYSi8rkUyyz00bv6qp0cxeHZw/qtQtY0dych39ADFVJ2UeK15S8GmU1RidYmS++IcHOGPiW/RhcvE0P68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597124; c=relaxed/simple;
	bh=/NLhfJ5HW7+33iPkdnREIWifKyYQ37Hu3OjhUdJV5dI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iWaVhG5ef4Mm/mpeS7IbKK/kYyLl0IvQZb3kHW65Nhq3grjk+BZeW2Hi9RRxkDOYAm4qUN150fTGuJnWJFnuNmP5nEcKOWAQzHKzYthyrSwsxazboDgIsbjgVIYdsaCCthJKTTqTpr7iRqZEKQihgxD2IdgwLGG0tNQaE3OEwdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=j2TS3hWw; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="j2TS3hWw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr2148nfofVa5WC2V/i9+kV2l4862rx3/k3X7H/QzTm894wz5G4cbhzEcT+ZAJj9TLO374IhGDGrQTm7mfXwHuhBfDeWFzuu+VntrdJz0W57AIX10f239mDGfpzrUQesVyBX3SpfrQCzBxUYvem2KpZyVrPx5f3qu8IADEkx8bFAWDVyOnLa6fdywCwy0ERbWJJYom1YWvFAXAgSPG85N8QIWM26pjd1mu/hV0D59DTF3zXPrT0J5+F0rqQEuG78eqvTrAc3ezAjjcaSCvm4t7ba3p7yBAsiNJ9vDR/WaoF3MwDYcHaTnPXzkTeS0ZakFHSVFNr9NhIPxglFmpgU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXHV6rPF8nrmw8ErpVGTR7Z+ptgqSLzvK5ueLVV2KD0=;
 b=bVSOxR4jB/lqASWSlurC/V6S5Di3cPHn4vbCZEMEQUvXF3fvo76cs8nJVhLVyPCefAzNfrl3bJwKX5drrziRjlSe75VscO37AouyXvCnhzjdNmmEQAQC1Hh6xtnTyTbdj7ELlAUB4+HuH/3o6okGM+7AF2vFvAbl6+h7d9ddY5jJFqZ3Tq/v8HGlEijLmkHWR4Z24rCU+oDrOj2o8k25EJ4a3sawOQsv4HqackPKAJdTwRL9tMbiWCPC+ej6XgYvIi5PoQs+eeZUbhrk3bIpYsnU4BFn8H9DVgDOhenNGhS7eSwgGQKunIh3mPt2MQwnStLb5h6CFRt8gP0jSQQ58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXHV6rPF8nrmw8ErpVGTR7Z+ptgqSLzvK5ueLVV2KD0=;
 b=j2TS3hWwdni6PI2ROkkdTzMgeJPniQrpJNjOMdtXIcPAWpAb9taJak7PuJAIGmjwf1NXl/MOlULnV1R6LLbrxrKgUSPm/NlixEalELm7HcXK/NT4gg52etuzxdHQlLFGgFJ34dVn9ws9P2+YSl4xFS60h1Ha2O8i8BBpQLC/Rrg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:05:17 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:05:17 +0000
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Mon, 28 Sep 2026 14:04:47 +0200
Subject: [PATCH 1/7] ARM: dts: axis: artpec6: avoid _ in node names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-artpec6-cleanup-v1-1-e3b75e10acc6@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=/NLhfJ5HW7+33iPkdnREIWifKyYQ37Hu3OjhUdJV5dI=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqulfmNRXNFkdMoNRWOO6hYYzlh3Hn6775JKIPy
 T8oL7DGr1WJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCarpX5gAKCRCwB25JC3Fh
 a3sRB/4gReXp++Ba0t822vQ9EHRAbC9TC3uzsjA0Nf+CpJnqnwr7xAy9YXegJf5zklh+quq1nwu
 ke0GqHj0jKjqFICeBycQCXzGlP5SD62w0y2soZNOaZLSJ/Dnih2y6IYne3CwlVX2Pv6YHIV2oWG
 ZE1c3NSzAJU/fTwXLP+67cwW8pGHICB595PfSQSsf7Gti7tJQkl2q6EOooyjgd7DHq0DXEcnUNO
 Jg1KqtBE+tgl91a1NB7IFepIVXCmeCO7UlTpgnq8Tcxra72QnIoRLi/VPZkd5Yu8UPcwieGr/mJ
 LXDR/CBeknHCWDCj+5uA1bRqXioyazARbN3d+qQkFzOUvzI6
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-ClientProxiedBy: GVZP280CA0097.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::11) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|VI0PR02MB10536:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ef1f17-44d2-489c-154a-08df1d58c26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8v6IvfF4NoAhWILzSOeP18eo/KbXaVhpWKJ9JOrcKVAsaDKLgep17FIJC8rItRtCbDyfRWtCrTkdzMsZLkkvNY8YovEr/sIg/xL3x/Al2eYbW7StLQenf8mUdNk8yLkO0E6LarqjVufS1rUJd63qOYhlrYWB1CTWlSgUiiTQLfpEcBOQsVfMKnu/QiQWpQywck9gWOpKC2Qx2FkDbvnXW2riGOnkoS7J+0HdbWMS4Pie0Rsg0btOt1SNjgCuLjGVh3Z0wc+b8mSvU1TNtZhQQr+gLU9mRN6cMlqKT0JDIuncrKjneau57stG8Q2iHee5cw1iu7kZge+OmDo7dhckw5qiVR5f1xkO/p6cNcsIFadz+EUkKdBewLkHzzdJWZAWyMcHGP8/bkrW2UfWblbamHuXNb4Nv3GT+BoNYKrjTHR5tL/CPtRiaJR/hwmGYaOjQ0q8dE21Y5U3VdrzPw785rWuGFTSzP6KQWwKYfGswnRnrAaPmmGYZOCQXMyMFDtCB246rk6A22KqGtNkwlDnhQHGLIbnhAdgxRl1PGHmbyG1HD4oEO8GpOb7OXwe0MoQSXU1DOxCsqgj2ZG6OixOH9TC3AVZpoQSg1i3yVQvQE41KNgCKvNyLctmI9fP4y3ofr9ebwgpnJ+4eUpwIoTC4TPiAXIg5vTOxUvpLmJNzxg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHZQRkF4VHRTa2RsbWt3cHRsRno3WldvczJhSTEvOGRvb3lOcEpKVDhQdVI4?=
 =?utf-8?B?dC8vU1J0L3VxR3k1Rkd5bUZNcTFPQnZrS3dJUkMyRk0xT1NzaU9rQmdSVk5q?=
 =?utf-8?B?WDVUUUkxN2dDTzRMcnp1NCtJYjZqaXNrZldmTkRwREVPWDd4VWZhZW9CeDVl?=
 =?utf-8?B?MzhGL1htdzFhY280MVZ4cnhUUUZKb0ZNSkV3Q3ZZbXNkQW0zdk5zY0lCZ3pl?=
 =?utf-8?B?eWlpUHE2MEpabHlvd3VEeWF6YlM5N0dPNjlxbG8zaml6a2RzZEFmRGlmdXpL?=
 =?utf-8?B?RlBjK1dIcWFyRmhPWW1HRHRkS2l6S29paFBENitPMHJiU0QrUmxyK2VhNFFa?=
 =?utf-8?B?QXp4eUMwRVBFUFMwK1hYWFd2L3RWMUZpTEE1bXgza2xsUE45dG9EWnJScmdz?=
 =?utf-8?B?d0MzY2ZGSlpDY3VaSTZjdGVqajFjVVFpdFpJOEhzTm5kdnE2am5Wdm9mK0ZJ?=
 =?utf-8?B?Y0JHM2pYZkZLTzROa2RRekw4ZmtWK3BDRGxzUmFhbTVoQ083NmpnVnE3cHJJ?=
 =?utf-8?B?d3lZeC9FYkY1UDRKc3NpajJSdkVhSCtNZGVNcjhKZDQ5ZG1kYWhFRldVK25p?=
 =?utf-8?B?S1A0MGpiQ3VYS1NWeHc5NzhMSms1TXU2dlJ0OTFZeFNWbG44NjZjc1I3YVU2?=
 =?utf-8?B?azJZaThvUHJvMnlmVGRCT09nN1hBNVBGZlJiWFlENG5DVW1nT1hweWVIN3Nw?=
 =?utf-8?B?dEdNcnE0cGhydWo2ZHVNOG1PZ2IzTWFodTBpRktyTmxkNVQyU1crNytNRnZp?=
 =?utf-8?B?NmNVUTJTei85dWp6Q2hXdVdsYXlObE1EeTVmOWdnOHExWFMvWEtrT3UzTlUx?=
 =?utf-8?B?WlFDdzFqQlB5eXp5b05WN0xtNzNLa3ZJVGJwNTdjOXRLR2JNZmdERHdPN3Vo?=
 =?utf-8?B?OVFZY0RCSHdBcHNFUElFaWEzRnRNVStFNDJVWXhhMU5EWWZQZ3hIUnZ2dU9R?=
 =?utf-8?B?V3kzeVNVNlo2ZWk4N3hKYkR0VzVvN0h5N2VReXI4V2pWeG9SZkZDYkJDU2ZJ?=
 =?utf-8?B?TnBQTW9vL010bzEyaW11V1I2aU9OOEduYVJla3MwLzdEdUVyTjNlN0hocGsz?=
 =?utf-8?B?UUZnRmhoTlRteUpnSW9JMlV3akFTSHFSSzdTdER5c2ZzS1hyVXpkSEVJMTdi?=
 =?utf-8?B?U0h1ZWFWaXFuWDlyL3ByVzV1WXRtTWFNZFVKckw1MCsxd2w3WDZ2dEFNOXRG?=
 =?utf-8?B?aDV3OWd0QmFLR3E3bTRPWFZtRXhTWXZNMGRhRlhZYW0zRUJHdHNvRTNmSWsv?=
 =?utf-8?B?UzFlMDdmM1AvTXQwdC9NNXV4dkphUjRhb29hSzU2VW4yUTE5RUY2a3RwQTZD?=
 =?utf-8?B?T0ZLWGlhc3VkOXVMQ3lSTjBITWQwRUkwMG4yNnlsZW5NV1c2eG9BamVQN1ND?=
 =?utf-8?B?cEpKSEFqcTRRTGFtM0t6Z0dRV21Cb3lQVTRyQzJvZXgxWi9peFg5MlhmdTFi?=
 =?utf-8?B?UW13bzhvWkdLZmU0UjJOYTZObW11Rk5MbnZzTXVMU0hTdDVULzUwalEvWlNn?=
 =?utf-8?B?TVd5RHM3cldYSktWR2ZKMWFadmk0bmVOY0dyWGVmRlh5SFhwb1hSblcyNE02?=
 =?utf-8?B?QWNaYVJjYXJDdHFTYjFicFVROUtJMm9KZUtGQjFPMzJUcFVvaUJTMjRsVzFF?=
 =?utf-8?B?Q3JSbkh3QmVhdW9JdFBFTUlnaStmRUMzUlY4aHJwR3pHM1RlOVRmcVZVQ3Ux?=
 =?utf-8?B?bjFkRjNoc1JjWGJPSzBYZGw3Qnp6cU5pSnF5cnB1SldBaUFvanJiM1RQc0th?=
 =?utf-8?B?b3FGUnpFY29XQm5RRXpUZW5CWWFFMlp3R1VsZUVNU3dhaDNKdlV0QTlwTUR4?=
 =?utf-8?B?TmppUTNwMVgrejhENlZFNUwzY1BwMHE1ZWl1SFU3RXozU1hYdTZVN1NnRlJa?=
 =?utf-8?B?NUxvUEIrbzJ4QTdza0tDTUxxUEE5NHNoOEhvZmFCMUJNVml3VTBXMGQvQWlM?=
 =?utf-8?B?QjFLcGNZUE5iSkNwOGhRSVF4THVhNE8xSXF4eVI4cEc1OHJaVGhGTmFKZ2hm?=
 =?utf-8?B?bSs5NGZkbWhHenJEZjhpVFlHMXVWL2oyWkRyTUQ2Z0lDK0RLd3NEQTVFUlBR?=
 =?utf-8?B?dzlwWW1HWU9KRUNqSnBjMVVPN0dXQ1hEQ0dzMVErRWxWNzlDZW10VE9SU3g4?=
 =?utf-8?B?emVWb2RRV09aVGlTT3h1aHEvR1RhazNiUTNqaWUzMWlZQjlLTlBjZyt2dWU0?=
 =?utf-8?B?U0lxSEdpN1YzZjRnNFlZWExKaS9JdnB5cVBna2FwRTB1M1Z3SG4rYVBtN1g1?=
 =?utf-8?B?RXhHVTFOWVVYMEpJMVEzQ2JaNjA4V0JGZ2kxaE5KRUFvSm9KVWZseFJGTXRh?=
 =?utf-8?B?R0RxNVZVb1hVMit4YTVyN1hGU2p4bHpsS2x3SlV6R0lDY2EyK2hvQT09?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ef1f17-44d2-489c-154a-08df1d58c26e
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:05:16.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/LYYgLNbNicRU9aokSlMN6N7K2/JU61wlhBbNHve2hIBTvBS1utcbwKH/kNtbXaCCTHLFBxBrhwaoQFFxXDjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10536

Node names should preferably not use _, use - instead. Fixes
dt-check-style strict mode warnings:

  axis/artpec6.dtsi:91: [node-name] node name "ext_clk" is using discouraged style
  axis/artpec6.dtsi:97: [node-name] node name "eth_phy_ref_clk" is using discouraged style
  axis/artpec6.dtsi:189: [node-name] node name "pcie_ep" is using discouraged style

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index 037157e6c5ee..ce642dcc754e 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -88,13 +88,13 @@ scu@faf00000 {
 	};
 
 	/* Main external clock driving CPU and peripherals */
-	ext_clk: ext_clk {
+	ext_clk: ext-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <50000000>;
 	};
 
-	eth_phy_ref_clk: eth_phy_ref_clk {
+	eth_phy_ref_clk: eth-phy-ref-clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <125000000>;
@@ -186,7 +186,7 @@ pcie: pcie@f8050000 {
 		status = "disabled";
 	};
 
-	pcie_ep: pcie_ep@f8050000 {
+	pcie_ep: pcie-ep@f8050000 {
 		compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
 		reg = <0xf8050000 0x2000
 		       0xf8051000 0x2000

-- 
2.43.0

