Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B154C2273;
	Mon, 28 Sep 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597131; cv=fail; b=gK/ECUyuAx1MRXu6rDjOOjds6g7bHSRkxLO4HlVmTiPUycHeqEwY3x8K8q13rdkhemftiOthYrMNO9Gf1K7ZyZQ68SytK5bTlywmdDYJFhXALG7JZu6GgPRjuoqODqC8i2fc6kdBLOfsiLOmrKKjOAHhr4drSgfM2yNPzGcZgpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597131; c=relaxed/simple;
	bh=ocZTuykwTIw53JFIM7yemCEb1gGxa+T4opJC968BiY8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Xhb1YBT2iV3VnFn5shS+uXMa5IjpTGkjXFKQHz3/QHUdOfDwzsv6OjBvrAufaQ0Wx6GcALe0jQ43ZWpOXtlWdL635UMMbWBs82KMmlHdxnoaDGmJlAGvx0COclpwL/TZLxY63VLszlZxp5o7EWBdqDPH0LqiF3tkACPXLPhtvrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=atnkI+XM; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="atnkI+XM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p74sKrmJttEPTlyThF3RcoRlQX3znMBWYnhpqaKIJAzK36nW9bv4+UMcusN1/TCoWISfsdJIEenhl2aMni9CGDrIq/IX+2f6M5X4oA1CKvoHEfOAG58ce0i6KW/ob0DEO8CDYPd9JBduDzdbhIifbqTukC/XS0sJ1aMNGWUR50alKpOrc2hD2jtkJwU4iKLykFbBLUsVF36193aB8S9P+p0tFVuj51nibLEvdAGpbPEFG54ULnn+lUrNVbiQBo8w91HD2o8kGLml9U55LWlvY0n5GqnevutBIXODnFNtKEU48ImSxWCTkRRnuZNDnso7/OeiUzdWdzxO+wLSXpsSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLrwIP1JE9K3pWhsWsZF7y52cpjg49GM7L2nrKqeysc=;
 b=hvLH1dgjs+S4xsXylOIMCtPcKFOy2QEjhlHwtXwfwV3mYOGRN9eF91aVIVsxp035nGYa7Hz8C/Y2ZJGhIqC3blvawZv4bZrPDeScIUlHQh3Ym+6PYR9iHgdbsKw772NeRh+71V5U9zypA3quZwR7tOb7IuZASCKJ10VuT2yUZ0ue5b5FrfDCGjYizsMP2l7lSaICjJqq5Xtrz7XIdYmjmSM+XLvLt0vdqU2Wvbx7xF0qUVOBpRT/wVfO8sYr6dlTkx8YdDAKYhqS4lRtPfOQR8Y+J08v+QPrKQPgbP3BPfyckQZZlx5B8D5J+lFHesBanZWRI2xnhGL/ut/RqNUn4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLrwIP1JE9K3pWhsWsZF7y52cpjg49GM7L2nrKqeysc=;
 b=atnkI+XMrO14gjEcdGBDIHEHInfLzvnq148F2ld8n7V8wbZFzh/SRBzJr5qzhrSxvf0MKUJJQCnafU0TAKlVw9JQvNvp+KvmlaN7KdyvQ2h6J7jg/ag5aq2elqZU6XpNEZ+gb4uQyKsvba2sVE91GQL6ySQOggPOACpflszfoYo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by DU0PR02MB9537.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:05:24 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:05:24 +0000
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Mon, 28 Sep 2026 14:04:52 +0200
Subject: [PATCH 6/7] ARM: dts: axis: artpec6: put inline comments on same
 line as entries
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-artpec6-cleanup-v1-6-e3b75e10acc6@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=ocZTuykwTIw53JFIM7yemCEb1gGxa+T4opJC968BiY8=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqulf1gYkpOGFppvV+H4TDUiaTLY8mvTFuNPXWu
 ssC4BTu56KJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCarpX9QAKCRCwB25JC3Fh
 a29PB/9+3Ox8Ymw4L0DJ3jB0vkgpVKbar0wVA5r6LVyiSN5ktLLYHSFGujS4eU244qerkDgWYor
 ARPdJPAClSgxtb822OYlK9FYRBPxr7v0ID04e99r6hKx7sV19dktrjD+cyhvLKBoTgw68NwhjwZ
 v5lWs9RV2nPrECyF+ACSR6GnEO4c4hRzgBpJSeM7KeqlfuJRGsZmvqhcysBVDQGzAMF6cJ6lnG0
 pD6yklNA/gVhexjbALzniTM87u6UXlrUkbrwtxlGAVgc7fizFHPkQmWocWfQ0pUxEpT6c7BBpQ0
 i+XNzi/lirQrqacdxP73eiV9awvjYFh4NeKyKxv2N6vpWf7V
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-ClientProxiedBy: OL1P279CA0005.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:12::10) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|DU0PR02MB9537:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b30be39-95cf-474e-f18f-08df1d58c6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	foBJgbokF6abzvACDdWesAz5Fjlu1wMl2y4J4lfiW5/CVezPO9nQs3rxs2PWiDy85kupad9m6NLa13Tnm+6ZMhoynPPR34hOFGMpIslsyWh20j9gACokAhOKrNMCI8Y1SQ9MZj9q64epKlytZIM6hmsX48cE5Jr4FPxbSiHHU6XUs+t3JN17l2YeAy/kk25OFZoIJXUA6XJMklrlIVc+Y/6VhyyM3KeHT0ZZta/XKFkH8TSTiyb7RPiE1d2d3n3P1rm8bI++xDql6BDYSjvfyIohB208u1bpHRKl0MyAwz2P2KpEXWc13TTL0HsgcnkGdbdv4LFqcsJ3VD3KyIKdKZ02vLc1xL3PR58CmdCHxOI1F/gX6yZYY8R0I2QN8drRjpPuVAUV1PRTiJN63s/SRGeftXIkvr8Ki9oDJsg3D/RdhLMnAy8CVn5qk9giH5k9lEe0d5+FMNZWfY+nc7qYUK4QlkCimJpFErYYWmGJptSenJFaRz1wXVClP/u6HsjlSRilESPZUWrFiCjb6gJ5PiexoT86kHsJL3ppUJW5Pa05lnqzVedgtOKmqg0Re3D0EIYvNigQAuvo4LYSL5k9fe/REJ5HrlB9M4UTcWiSpEiCUFYl61BozxHzh/2BXwmwV94I2iMvH2WUuR9lJq0jNrAzUK2bvWSucEXsl7zq7o8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXRPcHh2aWVtbWlwTHYvWk01SnY0dFJmR095Rkh6L3ZxWXk3VXNXWjBYdDE5?=
 =?utf-8?B?QW9YaXdqUUhNTGJRUU1JMVJoemlUVnFGOVVpS1VGU1A5QTcwTm1RY1JSK3JH?=
 =?utf-8?B?QlpHQW10cmMvNGs4SmVTaEhIbG1UWjhHOVJxa08rY1Z4YWdEZFNDYkhxVGov?=
 =?utf-8?B?OFAzZGRXaThybjRFRU9NZWtqeEpxbjROVVczQW5SUzhOVGRndFNCalU0Ky9D?=
 =?utf-8?B?cHVCaDlBZWkxeGZjSmNFMUR4bktSWFZabUVoY0VvUkZKc3dIam4vaXhrbzhu?=
 =?utf-8?B?NktKSXkzVXIxbkNmVzBaRFk1L0pQcWZmYWFUdjFzNWJGbkJnUUlZMlVydThu?=
 =?utf-8?B?Qzl1RnRRbUQxd1NMdGtHa3JGbEpid3ozZmJ4cUZnVDJtZkE2S0l1TWI2aDhl?=
 =?utf-8?B?OWNESWdEeVhXcjJ5WG5raGNwSVBHV1Y1WUVpRlhIRngwUTQ5Snp3VnVCUXpo?=
 =?utf-8?B?bmR0eGV3WXlNSjdydUQwRGZhV1NJbXlqQTA3bzI4dERUakkvak55YWxkNnNJ?=
 =?utf-8?B?RytPcUc3dDJJZTJZUkJLbTNZbUd6VkdYRDRKVkZ2MnY2c1k4eUVMSWtiUWZo?=
 =?utf-8?B?T043ZmZEQmtxQzdIYkNoUGVJNnlMWEVGK0wzbHFvMzYrb3dCUkltc3lZQUtG?=
 =?utf-8?B?ZG05VkV3V29ENnRFeExUcUh5bThINWZMZEFueUVUZDVFbWJmcGdjOWhkbUpE?=
 =?utf-8?B?dzdROGVIMG5pcTNGdUtXb1h5OGdQRTdwWjM0S0ZvQXhkRGJtaEVETW9rdmNW?=
 =?utf-8?B?WjZrYmxYc1oxMTFVUVRPWC9Ha1dXaEZ2RDM3MHVsNFI0VHdiWjlGU0lyUTlq?=
 =?utf-8?B?VXpHZDRLU1F3clpmS1F2QXkzenhhYzA5NTRjdWIveUp2cUREdS9aN2x4V2hS?=
 =?utf-8?B?WGdGRkU1SnhiS0tGd1E0M0tBM3dyZDZsSnRWcUlaZXhzQUZ6L3NUQ1Eybmlo?=
 =?utf-8?B?SDBrTUdSYlc5bFVsWkRRVTdweTFhaVd5NE94NmtOZmJOZTNrSW5TbTQ2RmI1?=
 =?utf-8?B?djBZdS9OYlBNNmt3RDV0S2pjeGt6cFk2bjlEZEt1eUFPbzJPY1QxK0ZwTFk2?=
 =?utf-8?B?Zm51QkZhaVQrOWFCaEZKY3lNK3Y1d00wM1ZRTlFsN0xmT1FBRmxqUkJ1b09C?=
 =?utf-8?B?NStZL25JeWRDZE1vNnpBWk50M3RDWFRPSTBkS0hUZ0dQdlo1WnFKdGdPYzh0?=
 =?utf-8?B?ZjFOL0swOS9zYlV6dnhjYkt4K1pwb2RYYmExa1Bmbjl4T2lHZTIxa1Z6OEZG?=
 =?utf-8?B?WVAydXlXQnplZ1Jsc0xjek5QWFZUVjZZN1dOMXdLd1pXd3UrWk5hWC9rZ1dZ?=
 =?utf-8?B?RktuWFU1TDd3SFVGLzNiOFNCMmV0ejdnSjZKV1B0Yjh6Q2lDQThGNFhTaFRl?=
 =?utf-8?B?Qm51T3JtMllQcWJTdStKOGtkNXFuUnJZZDY3blliMUs1SWtoMXpVbHJOR3Jy?=
 =?utf-8?B?azBUb0FvM0xwdUJ1U3llbC9FdFZONDBaU0ZTRURncm1JMEdGU3JOY0wzMzc3?=
 =?utf-8?B?T1AydGkyNURTdHRUZmtjK3BnQlFpcjNHM1N4dG8yeTE1bU5mOTMzVGh0N3F6?=
 =?utf-8?B?aEJ5akhuamh1V1Y5a2hFZzdsRFFGamRLV1dvM0JWK1g1Mmh4eSsyV3VDdDZW?=
 =?utf-8?B?SUdJYld4N2lYUVA0Q002TUk1dXhJQlZXY2xhdDlVcWhBT1U5VmFJN2pjQjE5?=
 =?utf-8?B?YzBRc2pwbzR1VlkwTFNvVkhUUmJISjBhb0x2MnRYUUdqZDU5U3ZzdWJOZXhN?=
 =?utf-8?B?TDJiQ0tUZ1J4WnRjVHV4ZGdXaitNMTR1UmQ0RjdTdC9aV3c2TTBVWlZRVTFw?=
 =?utf-8?B?eDJBQVgvZEM3Y2RXN3RVWWE1K1ZyNytWUEw2Nlh2TDViUXFFNllmWlllZ1RY?=
 =?utf-8?B?eCtmU3FNd1c5cmdMUXpQendoYUh1ZDlaYTlrSW8xRGswNU1jdEt6Wk5BU21O?=
 =?utf-8?B?THlHOG1JSi9XMXoxZUVDL3pFdTRySzRtK3VPWDcxYjAwNXFTUDNmVk9OSGZk?=
 =?utf-8?B?TFZ3eEZ5ck52dXdXRlpQUE05TVBLU3dmOVlIQTBNWGhlUUY3U2U5SW1zUlFJ?=
 =?utf-8?B?WXdmVWFrVHhzV0w5cFNxY0dzZGNqLzAxR0Z1SHM4MVZhcDhsdm1YRWxGS1JQ?=
 =?utf-8?B?Z2o0ekMveTQ0TUkza2JEUnVlVzFZYXFHcFJScnBPVEN2a2IxS3lJRDZFb3h3?=
 =?utf-8?B?RHB4RlczZlNoRzRCZnNtM1hJSmZQQWZlUGdIdkdPWnErQ2xHK3hFZzFNYjJp?=
 =?utf-8?B?WUxBb2Uxak8wY1hjMWZwQURSVWRrYlFyRFpRdFFRc01hWU02WEZFMHRFNnhp?=
 =?utf-8?B?L1Vhdkp5dVpNSjI2ZjZBVkhEanhxd3h2QUpTZnl6RmptajFwRXQ3UT09?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b30be39-95cf-474e-f18f-08df1d58c6e3
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:05:24.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwcmTQKCewaI/0sgSD3YMEEdWQt1owbdk0GdDFYVzgNFBKeIB/JNWmcVV4uwl7IPZyrU6sRE7oQoro6Ib4cjEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9537

By having the comments next to the data they describe it is easier to
read the property. This fixes indent-consistent and
continuation-alignment warnings from dt-check-style in strict mode,
e.g. warnings like:

  axis/artpec6.dtsi:170: [indent-consistent] indent mismatch (expected depth 2 * '\t')
  axis/artpec6.dtsi:172: [continuation-alignment] continuation should align to column 26 (to < or ")

Also shorten one of the comments a bit so that the entire line fits
under 100 chars.

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index 146a5fd98528..c9f671fd685a 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -167,10 +167,8 @@ pcie: pcie@f8050000 {
 		      <0xf8040000 0x1000>,
 		      <0xc0000000 0x2000>;
 		reg-names = "dbi", "phy", "config";
-			  /* downstream I/O */
-		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000>,
-			  /* non-prefetchable memory */
-			 <0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>;
+		ranges = <0x81000000 0 0 0xc0002000 0 0x00010000>,          /* downstream I/O */
+			 <0x82000000 0 0xc0012000 0xc0012000 0 0x1ffee000>; /* non-prefetchable */
 		#address-cells = <3>;
 		#size-cells = <2>;
 		num-lanes = <2>;

-- 
2.43.0

