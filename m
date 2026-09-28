Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7B4C6F1E;
	Mon, 28 Sep 2026 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597135; cv=fail; b=QF9Pk4qaVYcBfV285UVyRu0AFB1OOrzeDGm4MGUrir20fWj5U62gyXwaz5rm3gpJQ9tvMWurQIMcUiH6CRMuqm3cdDerMtXCJF54XJBaiUiHFuumIp/oG/0wSEcS4bQfY2OIEeqYT+2ZBw3z1HBr0x4pi0wU6+kWY7TKRg8T4jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597135; c=relaxed/simple;
	bh=6ltMxs5ugNW9WsLBqqoW2ka3tuBuTXrxBIAhixuRtlw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ispx+qB8PUpQaQTuuK1HafLYErQfAdJRBuY6VTePu4LEzSqo79u2BmI80x66EI9ntbloBYEuplnv3KJkrJShl4bd75aMsZp2UXGe4K8c4xngTuUkhPPFyNlKJR3tipJ4NbwOGKz37pZyY717QjFNh7sbfM66UbAIKVTjVkk+f+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=F9GPUxnI; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="F9GPUxnI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFpvIC7lpxiCRsmhlOHLV5ljzumX7d0NBOzv23T1VZ0aSIBBSWkT7hoBUIiMQHRW7p3x5ndswJA30i/RfeQOJCN1BRdkPF2eFgpHAIJnpg0Pk9cdUH2fzQko0ig+Zr8RgwTi0VHqsw4KyX3JVGU3bWTjLjNG1n/g+pQBhdHMxuBGc+DyRyBB3OtHF/SGFI5PGAuPPDpA0AjxLZ4kEnYx/eMssAZBxhS0lKvXrww1BCua0gZiLYXA6RTiNAQYTOskw9oVO5eBPmM2OJkEw27hZMoc9KxuNJojtJQ1a46+PIYztDQwMWzqHN8L/Mc/IHYhnToXjeB9QJ3PQ2btdIba/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO9mwHyWTgjrWDFFJX/oZb2iDhMcT3FiaFT0yRxaHfA=;
 b=s/eAy6os+gyUcxJDzrvcAmSX2N3iTGLBzZCyhMAuzvaZ0/4go32eSbx6eAamFb9bAlGEnnLsZxO9+fTNTCEMhJu64BTSqnPtfzuJw/OlkP/kL/c309vs4pZucbgDsh2P4xPmKp+HXGOD2pU9X5+t3pkP16LJEHEd+hO7IU9xRXvQAPvUpGvhEwF+Z0bc0AGjJbNY9XJY7RIElyEGQGRRuoBz4nebOgyu+Q8s0Ob6gTuIUlpXDeHg6wU6aBfPaSY7MnJkG2D0RSyVqEgrlqxiiCGLQ1H2gXYe4hVYb2me82rcBiZyCQZhiCDigG0EaU4WdPOO2ZTeeoxwI1rW9cV4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO9mwHyWTgjrWDFFJX/oZb2iDhMcT3FiaFT0yRxaHfA=;
 b=F9GPUxnI8IDcLdvObBR2CKsRaeeFsaAD1Zgpb55IEx9mWfJrjnsgODfAs+AzDGXazGe1v/QUpiiNW11VExtfw6bfXBwWXPM3j9pqTV1TMBoOxalnXxmHhr+9jIBozqwCnP42wNWCRgtIFehKY3z+KaCQQkCcK0ur1+MEbhBmx3M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df) by DU0PR02MB9537.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:05:25 +0000
Received: from GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6]) by GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 ([fe80::9ac:6f90:5998:69d6%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:05:25 +0000
From: Henrik Grimler <henrik.grimler@axis.com>
Date: Mon, 28 Sep 2026 14:04:53 +0200
Subject: [PATCH 7/7] ARM: dts: axis: artpec6: add empty lines before empty
 queue nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-artpec6-cleanup-v1-7-e3b75e10acc6@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=henrik.grimler@axis.com; h=from:subject:message-id;
 bh=6ltMxs5ugNW9WsLBqqoW2ka3tuBuTXrxBIAhixuRtlw=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqulf3LyD0FrBy9e4uG0kMRhz0B0KDajR+LGayu
 wUgiY+ehvmJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCarpX9wAKCRCwB25JC3Fh
 a57OB/98jx0rwB+AJLTtu2pDxLkMWW1ma/q1BQCrgxin7aTWVv0Rob9+MvEuV6pfK8Zht3EXO29
 fO4TFh48cHwU4Lxz/NvCpjnO2jDbiyn9PCJmS5zVkmDNRU6ZizkJxNQOuRo5hLTwhVGlFLhrVHT
 3r/HO/hV92TGXJr/aR0PevYJbclrI3hP+8seUj9VIrc9OHUATtmhEx/6roVPXI5SbByZz1GzbWU
 kXUVtT10Kwn/jEePdeLqz0LU4t++5hhXgX1gkACG83tFwtseBZWC2G7H2+pOWsnqQheMj3f/Aqe
 uj1NLaf82C7tankL7Deazbji1aEqmuCz3OsAO4Ss391My2R8
X-Developer-Key: i=henrik.grimler@axis.com; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-ClientProxiedBy: GVX0EPF0005F6CB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::65b) To GV2PPFBD14D17F4.eurprd02.prod.outlook.com
 (2603:10a6:158:401::5df)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPFBD14D17F4:EE_|DU0PR02MB9537:EE_
X-MS-Office365-Filtering-Correlation-Id: a975e405-fa81-4769-7a42-08df1d58c767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V4pOJlCnIxW34GiIq/deC5iPFczyHBfH/vAnVlb/MKEDEP5n1+fIfBKJRtKNaFqQvtlg2jCIUd4caElepbK5WTtCAFVXyGf+ZkCNHrWG6HDaIhjp5hCUFn2cxGs5rUzevwsT+ZY3334RKbIgrybshj3L4qcFI2OkibJqIzYMbIWMsNjZlG89h5GSQjEGkRkENn3GJR5KE1mzAGgTguaABbmXiX33pmc9izQW13Z8xML+WYetTKJLM0EZ5f6+caaWwiQMtDGuAjXHZS/V1SSRGVWgRs+RSTz+jVKNN6u8nTmmU6AyTQIzRSOf1mZLXU137ny3AAgq305B1053duD1wX/CCaJCiMVQg6RcryMDf38sMtmYysBykmEt67bCTMGcFoV9JVP9Ty+R2GUxegNGf2lM1n7Xh4elBTot3w+dTvWtYfqWVv6yESLwCEAP1MN46ta2NWQ/9cLrJ0GWY4Q0V8xREfqWwaVGSedpziNPgU/bk6eRxcU0QjUxwn5KH4T9ABjZOorHak1Melnx14KzLDhqL8dRa1bee7GeeHeCX+2171d5mpKjriUuuPvSJvl5ngtnectEvQH7pLC6fuxy6baPDjlt3mUD3nVdfpHpDMVPeBA7YFN2HyaZeGvtW366BD29erLnDJ9PN2NdRre9xirsD+btwr1ITVfitjfN8n4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PPFBD14D17F4.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmFXM295c3NMVEErUTRsZkhtMDhZZkJzVDFMUGdTSGxQendDZUZMMmRTbVFD?=
 =?utf-8?B?d2FUOVNxZXhHQldneHF3YzJ5djhzUUlIYk1ZMlA3Ymo4cnMxa3hRM1FhSFVp?=
 =?utf-8?B?T2Q2c3VVa08vbkd6T2l5Q1VqejFVQUhaVjlkdFN2bGNyOVR1bmNHUkpYYUxk?=
 =?utf-8?B?dlAwVjg0K1V4dVFaMkRySmU2T3pGajFXUHVYSEV1aWhEckhZLzlyV3daMEN5?=
 =?utf-8?B?TDliUVFwMTU2UG0rRzhldm1BTkJDWDZxU0ZuSTVURk5tNGJJV1E2N3BQakNi?=
 =?utf-8?B?OW94S1kxNENvUWZFcDBXTDVWeU9PMDYvRnlidHdaaEJmREV1b0w2Z290Nlhq?=
 =?utf-8?B?bjlqSUtRSGgvYk5wVzJWbWo4KzA2VllLUHFkUWpKYzh2V0dDMDQ2VVN4a0NQ?=
 =?utf-8?B?VWpTZkk1SDJWUmI3WmpYVmlXTUVhNUV1eVJsdzBYOFhTZzZ2RTZxY1dwQSth?=
 =?utf-8?B?c1FDcVBaYzE0Q2dIaFdQRklWU0pLRGZiTjVMYzJRUHkxakdWRVNna083SDRG?=
 =?utf-8?B?ZTQ5eXViUXFGV2JYb053S1c1Zm8vVWsxNnRqNmNLYjhvd0pFZktaenIzT2E5?=
 =?utf-8?B?Zy9HcjMyUkNkZ011bnFSaXBHR1FxU3FJdWRyWnREcTVjb0ZCc3l1VUZUc3BV?=
 =?utf-8?B?SldkUWNFLzUyTldneXFheVBQOGJaV2tsakFaZ1M1S0l0dElLMzVPRWRZNVdR?=
 =?utf-8?B?amZiWHp5UmozdGxwcjFjL25CcGowbGJLUXJUVlhnYjFOdGpReU5sTGdOWkI0?=
 =?utf-8?B?U0FHNzFWQXE3dERBeVdxeUNNNXR4N0liMHVEWHFDMXorR2NTL01UVWtBcXdM?=
 =?utf-8?B?bjZ2ZDlMdGlzcjFTZExtSTlhdzVUR29KSkNkSE9takZIUTBPWXJaYytZbW9t?=
 =?utf-8?B?cXpLRjMvZ2hLTDFraEFSNEhFZ1RGaWVna2ZlNlM4ZXl4UEN2RndvazNJekFV?=
 =?utf-8?B?L2trUVNldEozallaTlJVUnJEUUVqQkZRZmVJWXJqQnhhOGwyWE01eFR1ajF5?=
 =?utf-8?B?N2FTOXdMOXJjTklRK2w4RDVUNDVzYWliV0hXWkgrMU1TN1dQb3dmN3RIZjdW?=
 =?utf-8?B?amY5THJiODg3YktqOGxHekR0TTRhZXg4c2xUSUJhR3VUZmVoaytFUGlRQ0dp?=
 =?utf-8?B?V0wxamU3TDljcUhwdzREVW5KZ1dRdUVGbGZodnBLQmUwdyt6enRTUlBwa2d3?=
 =?utf-8?B?RUY3eENtUjI0VGoxM0ZnVHhWYXNaOTZwL3ZoT29QT2VEc3FIYlNKNzJNeEJM?=
 =?utf-8?B?NTd5VGRRSExiaXFaK2kyZTljS1pVeDRlSm0rWnRnNVluT1U1S2Iwak5VV1Fl?=
 =?utf-8?B?dEdQQnRtb2lnV2l2Mko4WW90VUVxL0lPdDFCejdKdmJTQ25UZDZ4YWpCaDlP?=
 =?utf-8?B?TjF3TXQzOFNJbnlCdFJodEpzQ3U2eCt2VFBhM1lVdVdadnVXbFovVmgyYndp?=
 =?utf-8?B?b1pUWS9uczNWbXRXYUF5dU5wcm0vN0h2VnNwTXZLTmNVSWlSQ3c0M0VKYUho?=
 =?utf-8?B?dVQ4ai9MOWcxYzBGdmpQUnJjZjNwUzlVdVVvVHZ4dUZXVEtENktJM1BsSG1s?=
 =?utf-8?B?Mmp4aUh3akV0eUVYM1NJSUhrdlJRbFUyaHJsMm9MQ3RreFBOeFQ0MXNLaXBB?=
 =?utf-8?B?TEwxMzc3TWwybS9CNTFreklubldCcGlOUi94eHdLdEdvcXkyUXFMSklXM1Fa?=
 =?utf-8?B?MC9lUkI4NXNialRPV0xmS0w2aGpUeTBITjJ3WVU2elRmOGwwaEFhMXR6VFA3?=
 =?utf-8?B?WFBjWVRRRktHQndnUmgweExhS3F6MzNCa2h0a1d2ZmlablhQVXJVWFk0U1Rh?=
 =?utf-8?B?dW9iVDhDUUVIbjVmc0c1VEdxQ29mdVVwOE5ZUGJRb2FxMS9kcTN5elE4UUlX?=
 =?utf-8?B?eFZ3ZXVOay9GQnJnM2FFUHE3cHFXRGZ2OGR5NzZOZXdwWkZtSGpxT25NcVBH?=
 =?utf-8?B?SDRUOWRUVnZXb1R0NlA0RCs4VERqU3B2RU5BYm95SUJZRVVPNzJKU0VYbzhk?=
 =?utf-8?B?M0l3R21mbmMwTnFja3c1TVRkWFpmQ3dLOE9KMkZYK3dWaUFQMkFIVmUvUW1j?=
 =?utf-8?B?L21lbi9UcytRWEpvREE2ZjBCN3NsZTl3Wk1BZEkxdkZuRlJ0MGN4VHpNclBV?=
 =?utf-8?B?SmRLRHVCa3oxem94dXlXMTJxTHJCZVQ3SjRCQ2N4dmNtT1hIOWFNdGE4WWhB?=
 =?utf-8?B?cU94UWhsRUR4KzU4eDFOQWZCR0haNWJJamcvMnhzY3hDL2wvLzBHUTNKOHpu?=
 =?utf-8?B?Rmw4V0JkQkdDdDV3VEtXdFhXak03RTM5cVVhOEM2NW5pUFlnMXNPRzhCSDBY?=
 =?utf-8?B?c004Znl5MFdFampZN1ByTVFCOFlFU1MvakdGYUNiTm93WC8rSmwzUT09?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a975e405-fa81-4769-7a42-08df1d58c767
X-MS-Exchange-CrossTenant-AuthSource: GV2PPFBD14D17F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:05:25.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4/9hWpwPHGl1siWRrPiM+BS4LXJGt7PIRSkNh4tsmWNeUZKKW0cNlYx5CCbpd6vgGw1/6I/yd4mkbEkSRhXuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9537

For better readability child nodes should be preceded by an empty
line, and closing braces should be on their own line. Both issues are
reported by dt-check-style in strict mode, e.g.

  axis/artpec6.dtsi:212: [required-blank-lines] child node must be preceded by a blank line
  axis/artpec6.dtsi:321: [node-close-alone] closing brace must be on its own line

Updated the dts to use preferred style.

Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
---
 arch/arm/boot/dts/axis/artpec6.dtsi | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index c9f671fd685a..6044a378c5b0 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -323,13 +323,19 @@ stmmac_axi_setup: stmmac-axi-config {
 
 			mtl_rx_setup: rx-queues-config {
 				snps,rx-queues-to-use = <1>;
-				queue0 {};
+
+				queue0 {
+				};
 			};
 
 			mtl_tx_setup: tx-queues-config {
 				snps,tx-queues-to-use = <2>;
-				queue0 {};
-				queue1 {};
+
+				queue0 {
+				};
+
+				queue1 {
+				};
 			};
 		};
 

-- 
2.43.0

