Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7974C1500;
	Mon, 28 Sep 2026 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597129; cv=fail; b=gNv1Y7APE+HFTRwgZsn+3YINm/mldq3Fcd0nu/dzLWP8ginFPfAjDAWotqjDgRcnaAGZJFLw+PJdW/5DNkAIUFzWttDR8UgRu1VlkUXQQSEveWUkxe58/q36wVQ93bp8XqmcfNVf74NuybX10KRpQNobptrn+vlYs9mbJU3iniE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597129; c=relaxed/simple;
	bh=2Jc+wLltvfjnaPprq30qTYTnNib+bu9HtJIOTYGJxx4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oo3L1BrXNxzAeQ4yapPHK0JBYxXhCnSOqY25OVxButmnJa5VYf+C/1Xffv6AQQWwE4wqZ2cpOoowhITxa4cgz3Z4v1DqfeIQsztCQqIy17Qh9RzTAUbq9yjjbQZc5kYUm/+leclwP0EVYwunlz+LSCK9jNNS1gHuTicxglBsn2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dE6rlWzp; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dE6rlWzp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2VPtRoVhdxLZUuMESAuZT8A8cXiJ+lVOP4mnlkkAEX2r5QUn3u+IoSU2Vmv8oNOvWUuNahYbNqZzvm0ovKoXVpaC415ereHq5osJBcH1BlWMxTsp54UZ0ArlJdG0BXZiLCqv+Y4bgHM9VVfDe6dQ6IuBKWD258ZShQVl5YFLQZBYpebBorJL8oBoPJTlSouff3eIhXG3F64ZjI1dxrQZDYyhJjYJa7Bgs9rtRT9oYqBVVnJJCcfsRLR9LJnNj2i+8+xvQs/9JkNWhutAbAaw0lS4yyrWG2KyD50yqq7YFFjAmnUcm6vXKCg6We/9z8rOshPYni4Pl1CtIVpfz1QBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5P8tUbIkWlbLeRSBduHcMvJumUFmx0slVygljYhfUo=;
 b=gjbmqPCQnDN7ADcNDlhHBf7ZmKXdc5B0IPF3kbljJQpKoJg468PybaO62F+lcrercw+3Y6pUVzVmUfuQ87iNSyGkOxSpOVvJRn43tlJEj3PbYutEC6J8w4Qor0yoQHqNxp7tFHFrUro9zCecF5jYd78VuY+NC/NNJeoeuSIqddClV1f5Q9oOqUFb28kOY7eIbsaof87G8Savc83rYLpZ7DA/oNJSmI5n2Rq2xipXc5styj+aNK90k4Z+VMNqxKrl9aVZMVh6ZuJvJqjF/854FZLQraa5SagBdsK5LM6MUYr63LCNVUraDwrQPxDdeHMmV/3+nnjtqzU892DAXhSRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5P8tUbIkWlbLeRSBduHcMvJumUFmx0slVygljYhfUo=;
 b=dE6rlWzpO+6PO9DMUCEMqp/zUbRcuedR+0C3P9q6rQof9NNhSGAsrRqHWPPBTBFV8gKNiVlMa9MkSdfVq5KTQN/2QbIP25rQV+jdPnTZMsOfewS3SASYCsUmO2lWBvVHQfB4ckqx+mcLCXENBSIZJS+PYzSfbqWhXyjqIfpdN7I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:05:22 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:05:22 +0000
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Mon, 28 Sep 2026 14:04:50 +0200
Subject: [PATCH 4/7] ARM: dts: axis: artpec6: sort all properties
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-artpec6-cleanup-v1-4-e3b75e10acc6@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6717;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=2Jc+wLltvfjnaPprq30qTYTnNib+bu9HtJIOTYGJxx4=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqulfvHFYWGhATbx8M1w4Eer5ONad2kPfEXlxdw
 iXzr1h5TmeJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCarpX7wAKCRCwB25JC3Fh
 a3SgB/97J9ovXt3PqCJ8hKZNm3E2ria3gTFz+yhWHrdN2QmHgHDEn7eSfh2/7I2Of1eO4qzmbPG
 yiNPt3Uof0Peclu+Cl5Zpte8onUIbYIPsvkDlM5vG2KmgQmwlovttJ0tubViGE0KHBvorKR6yQj
 thMaKQfBmeqlwJXOlmE/a/aZ8SlI3b3ptaifrz1nU2WrbLotcoVnIzTzzucmwXLBRhdTfQSNGWJ
 0QQrQfPWQnkd0cfzyW2ItudTTnmdgBOtPEuuUgjq8d6rMFmezYB2dURpspvzmkC9lnfZMe2H8eJ
 X8540evEVVyH+KcrCI7E1+TigVfrncKqVyBtXbCukyZNb/Ic
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-ClientProxiedBy: GV3PEPF0001DBF3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::310) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|VI0PR02MB10536:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c4429f-cb45-46b3-2e16-08df1d58c55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3fiPSlsCtwI2pZ+TPfgjy8OSUgOws1htBdl1/qBmf6PMP0hjnnMJJSpZbom994s4xYHWMt9hDZ2GmAevLqtexKNE7B0CsXAK3l5Xu7DqCv1NZYlAOlokZfB69VwZZ5yEu6OxzY6CwouUdV6ASxmGwncSsiJ7CyNo/Ea2czx1N02YZxizq0BLf6XNoJ6hMJHXwTQKe6YIL7VkQo97M7RxHJALbDy42vXfOmndtYhG6hJoNym0OmM1fOD1flUWMkpSGWfm5EKwFOYIsXMlyMLr5yTwuvand+32m7EGCHQY1HXBo47Nt2X6t24ze4LHqQoZG6t1AMMZUKIP9I1A0L4drN5Wfsgej2aEH0d95CXpqEgYt5gGWTLqYU2nvYXAhkkcZAourUH2mdJ+ecDMyzl//gBKR++KikgVhHQhLiII5ughJIoyvZECpOsRKMF3ZWaffkZ7ffCJNHTZIrggOYVolsMqR8kbr1VOiT8AtNjWYlGmcXFvlzewTErG82I46EloZa+juRrKrfBKUTtYp3jjnP9OA4MG9KG4a/K1YimKWN5whb53D9GkA5FvjhqANondsuKwT1SjkjQcMThxP3RU36t6OgQ5IrDZ/ghMLCKvMPDi7vHfV1koQS0jOohB02Q1r1/MNxQCp2LxZXT+iMwIcsljbYPHfhJlGKCbMChwJBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGNCS3hSUWpVTUlDUTIvSEhDaHBxL0N3OFhWVkdmTm9OWHh2dFREY2xmSG4r?=
 =?utf-8?B?dFltMnB5OVBCcnk1ZzlsMWxjcmhuWTJ5bFVRdnVHMDB6YnNwODZZYlN5VEds?=
 =?utf-8?B?ZnhaWllpWnJhY3hTYTFaSWxTRGYrRG1PWXA0MDUrZjhSMmNiOCtKUDVjRGdm?=
 =?utf-8?B?ejZNalZBZnlVc0xRbjIwMkgzemMwTW9tY2VBRGh1NU5TT3E5S09VSlNEaERS?=
 =?utf-8?B?aFgzOGpZSWlUc2hxbS9Qc0xabkZCb1lVWDZER21vS2drR3k1ZGVvQWwwT1l3?=
 =?utf-8?B?eHlsZTNrVmVtQkRaczdpVWxPWGpZMlRyeDFlZ3lQQlUwQjlwRjluTEV5SXZw?=
 =?utf-8?B?SGZUQWpSaEhyRktkZzFqUHZnN1U1dXhOU010SUJXNEdtRXdBUEdudEszM3VQ?=
 =?utf-8?B?cEtyZ0s4YzVjT3FxeFFNdnB1MUNxM3lmMVk1cjloNWl0ajN6UHB3VzdDT3NX?=
 =?utf-8?B?RjVBT0VqOTF3cHdicVJPd1ZFQnorNEg4a3UrcnRIanY1a0MxWHd2UkI0S2NH?=
 =?utf-8?B?K2JUV2NsUjBwQ0w3YXFMQ2VISkpvdi9KSWtMSkE0cmlsWE94NFpiRERWeGFu?=
 =?utf-8?B?cHZpWTBIdEJNNEYyRFNLWUkzK2hVOER2RW5EU1Vla2hDT2Y2MlZTOTJxN1Zr?=
 =?utf-8?B?eWNyV1poSCtxTHJqVzRVa2RYcnY5em1OelNQbGxjNnN0M2FUNVQ1bjROdVFX?=
 =?utf-8?B?c2RZZnNVbXRmU2c3cyt4TkFFNlRWS1RodjA3TDNNYkhFV0JiUUZKc2MyQjMr?=
 =?utf-8?B?WldObzNFL3BFK3VDaHdNUFBwbUlXRGtiSmR4cW92THlZdElHQ0lIK1QwNzlV?=
 =?utf-8?B?TWxOb29jOFNBODBLSFQydW1UTEV2U2F1WFBQTXNUYWtaekZiUkNOWko3QkNk?=
 =?utf-8?B?aVRVdUs2WFIzZzJkK3dKNGdnOGo0MU8zTzJkcDJnd0RMSlFqMXloU1N4ekNp?=
 =?utf-8?B?MXpDRzJoY042RjhyanE4K2pFUFE2MjRTTTg1SE02RHozeW93cmdPeG9xT09J?=
 =?utf-8?B?VExsenVHYk9iUWNxU2JhMFZUdUQ3dzNDakRjd2hkSk1CY1RLRHNZRU5oSG5H?=
 =?utf-8?B?RTEvSXdiM2VmeXR3aFk3dWI4WDJaL25Lc2lBUFUrV1ovS1lOT296M2NJVkVS?=
 =?utf-8?B?OEMvYm5RQ2Z3M2dvYUg5US8rZm9FU2ZReHljYlRsQ3pPV093ZjhEbld6SnM0?=
 =?utf-8?B?SmMySnBQRUJRN0FGSXZ4akxPR2h5TW1JaDJxNS9xZzQ4NWJ0aHZzeGo1b3k5?=
 =?utf-8?B?Vk5FOGtCTElMQXIrRWNiYUp0WjlwOUlMVjVmalBqUGZBZEp0Z3NtWERkbUZJ?=
 =?utf-8?B?SlMyZXRVdkp5N0VxWDVVWnNJNnZ1ZHUxdFlJajV0V29ZWXNXb1NKaEk4YUo4?=
 =?utf-8?B?dno5SFQrREw2QWxOSjIxckgvSFE2NGRNZlh6eUxHZGNzb3pFUzR3YzNRdXU4?=
 =?utf-8?B?TEN2N0pGRXVQMGpiaHFub3lRS0dCMThNV2FYUm1GdlVYMDZFR081MWNld1Zp?=
 =?utf-8?B?MlZYSXhwdUR2L1VJbEJFeWZwV3NxQnV2N0hKSFJ6R3NnTGoxQ09KU1VGYm9i?=
 =?utf-8?B?bHdrN2trcmhnMm9BRlZwY1puaTBWcThJOWhtVU5OWnllYlZZV0lXbkU5bjBh?=
 =?utf-8?B?U1AzYnBJWk5QVForc2srdEZ6MnhjRlZQVHFyZ1ZBT0NHaE9RU05YMzhVM2oz?=
 =?utf-8?B?bXhvT3ArZVhSL0hvQVR1bXo5MENDKzZoc000ajA5M0VxdHEwQ1p4aVBtYTZE?=
 =?utf-8?B?TXZVMThJUDJDcHhwVnZLUWxJZ2hNd1M2enh5aU9iaS9tSnFSUHNlNytSTmhk?=
 =?utf-8?B?Qi9ZN21lMEdORG5HSjAxLzhFcWhpRitvM2pjdERqczlpWVAzQVFZYmxPZG5D?=
 =?utf-8?B?K1N5ZTg3c3BjV2pWc0cwZ2FOQjAzSWNONWtKSlA5OGh0SCtxdXJOSzdZL1g0?=
 =?utf-8?B?YjAzYlpsMmt1dkdUVk5PNVFwd2hPL29PSjQ3OWFOUm1kSWFYU1IwRjM4TWN3?=
 =?utf-8?B?TllTVE9SZ3UwaGp5NmF3TjVwZnBLQ1hjVWVoMzIzTUZFZXJCMnZrRmt2Vm1C?=
 =?utf-8?B?NHEzRDZhRTRIakcrdjVGci84U2JQU2JiMm9pdEpPV2R4aDUxZWxuZ04yS0VQ?=
 =?utf-8?B?SmFMNm1odlNrRFlSL1FiUm0vQm1zWUppZTJseEt2SkZ4ZlgxVmIyZ3FkbUwy?=
 =?utf-8?B?YlF4Vkd3eFkwTDY0dVU2RzExY1pOSm1XRDlEazlTekJyVmx5ZXNiM3Z6YWhw?=
 =?utf-8?B?TDNBWTZTa2ExWTZsMldGZitJUlA2RTd4SjB3TUZ6VnNIQW1nYzRXWVJ2Rk0w?=
 =?utf-8?B?bVNFc2VXbDNod0ZGRzFhZW9LY1hRVDVjTDhiM09qbXdiSmQwT20rZz09?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c4429f-cb45-46b3-2e16-08df1d58c55c
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:05:21.9263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mw/RvQ0PM3V2VVYnOJN8FKl9E6zHHrPJ673lir3KIj85px85MZzPDDqY39XvdJqw4ceLZOpzNtRgIlR9ySlS5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10536

To make as easy as possible to read devicetree nodes, the properties
should be alphabetical, with a few exceptions (compatible, reg,
status, ..). Update the artpec-6 dtses to use preferred style. Issues
are detected by dt-check-style when run in strict mode as:

  axis/artpec6.dtsi:93: [property-order] property 'compatible' out of canonical order (should sort before '#clock-cells')

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6-devboard.dts |  8 +++---
 arch/arm/boot/dts/axis/artpec6.dtsi         | 40 ++++++++++++++---------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/axis/artpec6-devboard.dts b/arch/arm/boot/dts/axis/artpec6-devboard.dts
index 042a9cc920c6..9a91f9758442 100644
--- a/arch/arm/boot/dts/axis/artpec6-devboard.dts
+++ b/arch/arm/boot/dts/axis/artpec6-devboard.dts
@@ -46,18 +46,18 @@ &pcie {
 };
 
 &ethernet {
-	status = "okay";
-
 	phy-handle = <&phy1>;
 	phy-mode = "gmii";
 
+	status = "okay";
+
 	mdio {
+		compatible = "snps,dwmac-mdio";
 		#address-cells = <0x1>;
 		#size-cells = <0x0>;
-		compatible = "snps,dwmac-mdio";
 		phy1: phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
 			device_type = "ethernet-phy";
+			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index 49439058854d..d3079badcf21 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -45,9 +45,9 @@
 #include <dt-bindings/clock/axis,artpec6-clkctrl.h>
 
 / {
+	compatible = "axis,artpec6";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	compatible = "axis,artpec6";
 	interrupt-parent = <&intc>;
 
 	cpus {
@@ -89,21 +89,21 @@ scu@faf00000 {
 
 	/* Main external clock driving CPU and peripherals */
 	ext_clk: ext-clk {
-		#clock-cells = <0>;
 		compatible = "fixed-clock";
+		#clock-cells = <0>;
 		clock-frequency = <50000000>;
 	};
 
 	eth_phy_ref_clk: eth-phy-ref-clk {
-		#clock-cells = <0>;
 		compatible = "fixed-clock";
+		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
 
 	clkctrl: clkctrl@f8000000 {
-		#clock-cells = <1>;
 		compatible = "axis,artpec6-clkctrl";
 		reg = <0xf8000000 0x48>;
+		#clock-cells = <1>;
 		clocks = <&ext_clk>;
 		clock-names = "sys_refclk";
 	};
@@ -124,26 +124,26 @@ timer@faf00600 {
 	};
 
 	intc: interrupt-controller@faf01000 {
-		interrupt-controller;
 		compatible = "arm,cortex-a9-gic";
+		reg = <0xfaf01000 0x1000>, <0xfaf00100 0x0100>;
+		interrupt-controller;
 		#interrupt-cells = <3>;
-		reg = < 0xfaf01000 0x1000 >, < 0xfaf00100 0x0100 >;
 	};
 
 	pl310: cache-controller@faf10000 {
 		compatible = "arm,pl310-cache";
+		reg = <0xfaf10000 0x1000>;
 		cache-unified;
 		cache-level = <2>;
-		reg = <0xfaf10000 0x1000>;
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+		prefetch-data = <1>;
+		prefetch-instr = <1>;
 		arm,data-latency = <1 1 1>;
 		arm,tag-latency = <1 1 1>;
 		arm,filter-ranges = <0x0 0x80000000>;
 		arm,double-linefill = <1>;
 		arm,double-linefill-incr = <0>;
 		arm,double-linefill-wrap = <0>;
-		prefetch-data = <1>;
-		prefetch-instr = <1>;
 		arm,prefetch-offset = <0>;
 		arm,prefetch-drop = <1>;
 	};
@@ -160,18 +160,18 @@ pmu {
 	 * leave the unwanted node as disabled.
 	 */
 	pcie: pcie@f8050000 {
+		device_type = "pci";
 		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
 		reg = <0xf8050000 0x2000>,
 		      <0xf8040000 0x1000>,
 		      <0xc0000000 0x2000>;
 		reg-names = "dbi", "phy", "config";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
 			  /* downstream I/O */
 		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000>,
 			  /* non-prefetchable memory */
 			 <0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
 		num-lanes = <2>;
 		bus-range = <0x00 0xff>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
@@ -228,9 +228,9 @@ pinctrl_uart3: uart3grp {
 
 	amba@0 {
 		compatible = "simple-bus";
+		ranges;
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
-		ranges;
 		dma-ranges;
 
 		crypto@f4264000 {
@@ -285,14 +285,14 @@ dma1: dma@f8019400 {
 		};
 
 		ethernet: ethernet@f8010000 {
-			clock-names = "stmmaceth", "ptp_ref";
+			compatible = "snps,dwmac-4.10a", "snps,dwmac";
+			reg = <0xf8010000 0x4000>;
 			clocks = <&clkctrl ARTPEC6_CLK_ETH_ACLK>,
 				 <&clkctrl ARTPEC6_CLK_PTP_REF>;
-			compatible = "snps,dwmac-4.10a", "snps,dwmac";
+			clock-names = "stmmaceth", "ptp_ref";
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq", "eth_lpi";
-			reg = <0xf8010000 0x4000>;
 
 			snps,axi-config = <&stmmac_axi_setup>;
 			snps,mtl-rx-config = <&mtl_rx_setup>;
@@ -335,8 +335,8 @@ uart0: serial@f8036000 {
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
-			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
+			pinctrl-names = "default";
 			dmas = <&dma0 4 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma0 5 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
@@ -349,8 +349,8 @@ uart1: serial@f8037000 {
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
-			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
+			pinctrl-names = "default";
 			dmas = <&dma0 6 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma0 7 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
@@ -363,8 +363,8 @@ uart2: serial@f8038000 {
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
-			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
+			pinctrl-names = "default";
 			dmas = <&dma1 0 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma1 1 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";
@@ -377,8 +377,8 @@ uart3: serial@f8039000 {
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				 <&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
-			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
+			pinctrl-names = "default";
 			dmas = <&dma1 2 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>,
 			       <&dma1 3 (NBPF_SLAVE_RQ_HIGH | NBPF_SLAVE_RQ_LEVEL)>;
 			dma-names = "rx", "tx";

-- 
2.43.0

