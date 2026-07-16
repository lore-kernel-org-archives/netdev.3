Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245E33C1AD;
	Thu, 16 Jul 2026 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168436; cv=fail; b=dP0sQ78ysgwjWwPFuhAMQ6aX939pdTAL8TgqUcCqXZ4bLLCC9xtbtkos9hQx2lW69vCWEum0Rm60qsNEUJ9Jv9d06VdPvVbduHjeMdyW620MI3UlQpcyH9QtXoGhQuIJuRdHBkgC34w7XC1rjiiNMUi+q9k6nqqJxkjz8ni9PLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168436; c=relaxed/simple;
	bh=IHxCiE6+DB0e0RQxFD1h6y21pHXbb23/vuSOhcgW1qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ovE2Nd0hfxYxJu9kz+SyNsFRj8QXTsLFzxF2Pso0Go6zxPt/x0a5Z1Qai/MBUrBWxHjHsC3l6XZVT+HoR3eSkXoZLhS9lo22XQ86oQaxtLHo8gQjwcIaZ4L+7B0EeDz7d8qp5l4ittZ311fstOAHobuTodq7YPkWGII8Q9caY6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=O9IHB25l; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="O9IHB25l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlqKmwEtaBJBq0/JhCuvycpniaRv1laMSwDmi5Aj57g6xkesES4G7XVtSBUa3JwFLjLZ5MzPdowPNQ4TYGmd9XyQKniz61lzeWT/qb+HRnbod+bweRk/6NoIDU0MKPDzYOXfjAkfOza3PlEF4KeZoWWBStKwXMZr5udpJqDhNAqThAMQsAfQ7CWB1HtTXkhHK0rITFlmXNSxYtVeBfLlcS/iyNh75LBPZ/b1flD5h+sLVXVXzMXi8jInH+PMIBnkd29WFWDSNQHzuVViNwM4HoDoZB8/9j28PNovvqfyLi0dN9egKSKHqSgYcmBIo0T14sJZfi+CTwmg3gVHOaKqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3P2RxbkiQwYiaSgWtfNJMss1lpY7j59bScW8cLjeNw=;
 b=ED9Lm+VXcZXcjpJpteK3aQt56nayk4HXX58WqyK0Pnid+HbO7Sx5RYxqQbTHE/PUFE0YnJQuulL+NtO4ouXOdFtnZ4ARF0QiIjqzOxlHWhvIFKUAMP3mHDNSGlkITwR6hotT+OkpmzlzEO91kLI4hjvTCpRb7fJNn9IWLs5gmSIz5YvBdX7BTqJFCxbN6BoCdBz1GRAifo5cEawTB7Lr7hnzLQpKFbrPpVC/UIEVuN10oquj/dNaJoPyqlWgsfr+TiTL7RRTIbYVYVmJdWxy+f+kX+vZ/uX1tlLAPlWGgWgOehJ5V/cBQ32incHmCpbgitPz3r4g5MG4dhXlu+M/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3P2RxbkiQwYiaSgWtfNJMss1lpY7j59bScW8cLjeNw=;
 b=O9IHB25lwtBOEHF6N7sfoK0hgGrBpRLTELxnbQ7CH/LLw2HWqJ0qJnKdV+MtN+OtlJ3e642jqA3pIQ6VRG3/jR9NwbDmrm9bOe6jP8NW3p8gyQ8UDOKDni1iBQyILIBnVzvVrFSCtJkUuCQIq4s+OL183sDZJ3bvTkZuNpRTv0+dydOPZGmGfoxdXirNqnhGZh7oAAhb2M6sTFgBRyimQbViuYS+0hlzTFAS17tPcFYTwkLuiRn0U1k2lUF3AKBV4qc1SuAgHWRQ/zS9mbflNnTKJk206ZyVKrDVNMgrcwUAsGf9MKbY6dXTSnh7ZuA5OukeptyuakCMSxZRn6uzEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CH7PR03MB7884.namprd03.prod.outlook.com (2603:10b6:610:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 02:20:31 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 02:20:31 +0000
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
Subject: [PATCH v4 1/4] dt-bindings: arm: altera: Add Agilex5 SoCDK TSN Config2 board
Date: Wed, 15 Jul 2026 19:19:29 -0700
Message-ID: <20260716021932.20037-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260716021932.20037-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|CH7PR03MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: fedd84be-701a-4476-dbb7-08dee2e0ce97
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|56012099006|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	CFKpw4GrBitnvE9jNDJxnFN46MCT/S2RAQfZ+gfRKAjsZxFo2blX9/iiMP5BMieLo2jdeMYtHa4Gpt3mD+dcc2QrgckI8U2l8+r9om6fS/nfUoZ5hR9l6rxCa1dDoR+xBf+o+S05Xaa0sThg6RXudnGLzkWTiyTmlC0t/WSD55bB2ICL6x49zj7Ymz5NKMQhp0u5OSUdizIRWygVqBKybj5xK/uoByh6rm4wXAVkr+3D4zeQInhC0HlpMHhEL0EfIh9vGVVAfmwr6y24w1DixpwdZvkcYId4PLD4gkJryib3gkeF4sVtMgsno07KQ8YtsQGQqZaiAuv+6mRoSFiRWX262UPBKpfMtzi+0DODVjysCqDbpf+VxaM2YHaC5OHEMpPQysN5Gjv8REZBJmPKUlBneDX8HezB8NnOEXgKt606F3v4m7AIj3G/vttkMwTQzrMzYhgFK1mj1vRtHlHWrCYoGJEn8EyySxgbCUUCkoaAOA/4On1/oXSF4wbW98zFkL+caFUcXBnOW7DcGnfNWzPsAQH3BZEHslTI732jiGPvWSF6cu5hN+thW5mXKfIDAnj6T/U/j0WuBBW8ymgxMkZSqqCDbcEs0mfGu3+hwasqM6T9TAFAngRLsXgb2SLK3SpPgSkBrqfIOf3b+pT1LDAP0t3VNS1t/srKV7hsJMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+BZxbSf74TceFvN2ZJzNDYdS+Y43V8iW8gDdVpURqv3lJyoSGtwNY4LJkvLB?=
 =?us-ascii?Q?1koDIahj1Ai4+fGtkC+kzw9HIf7N9p6QiYLiHEhKS0eecvt+Ci3x3QNUAAgl?=
 =?us-ascii?Q?8FjDmhV4MHq+LWY6SV/vAzGsLwv1GqGsTNUp/9Rh96WJ533LmfrmDyNjbnJf?=
 =?us-ascii?Q?zDRUEEgoLnoO+bUceSGGU/cZBkMHbWKA+D7RozPgTdABeCt2Ue/cCRQjjS5Q?=
 =?us-ascii?Q?0P9/kNTrHnrdJdqlDEeMrq3kt6sldMcjAwJY5RcSg8XEOX6mDekgT3/kJ7KP?=
 =?us-ascii?Q?chLlcaZOLj3exFN4aKMRU6SaSieJDsOcIvXIZ48D+9efzQSKWcK8N7RAj2vu?=
 =?us-ascii?Q?CoK0dpafOTmfnbRsPEQtps1TVXLrMZffKRinaqOdAaQIkcrCl1U7aQ6y0O2R?=
 =?us-ascii?Q?qivVTWnZawbkn6ZjtQ0HI44Mbnl+j7IqpiZORvndWFS77foRJYtvTeDNabX/?=
 =?us-ascii?Q?9xpfjwmqRol2ekxr2mXI6uiO7ahSnZ7thNhJSb42euO2OJkxSAJNss3p2Cy2?=
 =?us-ascii?Q?7UKa42CBITQrkCuVgQ97CSBSt2APdGDMY2O7uEkR1Vlgh2d6DzMJJRfF+cTD?=
 =?us-ascii?Q?ulhaZ9zV3bbRjnh3gjKpBtLjyGcneEYW5bJy/OnCu+1VPrNMoIonCOz+oZT0?=
 =?us-ascii?Q?T4czF6z/EM0E+lUSsw7rgseON4DjDjqNOFDvVQ3COJynilAmNiZFTDaDIZ/K?=
 =?us-ascii?Q?3SFWeECgTkewB4H7PI9kKBvBTSmfUGWHh6NYrS/kwQwCcBUVHOS81AwAM/pM?=
 =?us-ascii?Q?orOdnObcuouIDPRFOjswBKdivrFfMZySmZA5gTZ+wqy88+ToH5ARhokS/fVt?=
 =?us-ascii?Q?DcTwqjBLR2TORandhyX5zz7udzgv5NyhcsC255fVUYn2DRgEgwgMLPCXyfD2?=
 =?us-ascii?Q?Q3cl61MPq8bcT6/iR9QgDrfNuMsBTluSz8rV0UDI2+KwGTgn5CO4OGMyGHDU?=
 =?us-ascii?Q?QroxvdqToZobRfpSlUDJnTN/I6I/TBVmk46OdGrLZCckMO0McDAQ53/BIH01?=
 =?us-ascii?Q?JV5ydpY7OVigIAYjSQKeUgz1QUFdHfrzr2garagECfpzcLOCVkpjOUGsAbK5?=
 =?us-ascii?Q?eBBO+z7372inojjd5nMSd0+4xPUJyUWKbjA69acmT7iNueQBYANazVH8zigT?=
 =?us-ascii?Q?tQkMi64B+FfkgIVPXT5zNDQn1Ml8Ooaoxs87xLjam5R63Q95Ij6VnSvLAk1G?=
 =?us-ascii?Q?fi9Q4rRJpwAFutflpuYOCQ90jsiF41BS9b+pEIivURYhskDu6A6LKoPektYo?=
 =?us-ascii?Q?2sDDsaELzm4sJz5Vcn7cFx7NcJJ0t5aSkSjw1m67dJufaKvkEydViSPXogVy?=
 =?us-ascii?Q?bMznzyHOcB3rsP93oExAH8zKpsTDLxrH0i6hTxBoF9NAp5S+TkiV7/iKvx6H?=
 =?us-ascii?Q?aWh83nRFcZ5uRfzyK4BahNTSkAl9TsYRAGtA95Y7ugMdsn/qfuC3V0LDZpg/?=
 =?us-ascii?Q?K1mjFvEgtl/c6v0ZMwATSoljxlWnYVcBK4MfxH5s1r3eJA6NtLaCC60pd1Ts?=
 =?us-ascii?Q?gqiUVMs3VcWbzXVJhByEjnj3IX4bChZLaVX5zEf2FL1xIDPTi9QLbv7rMB0t?=
 =?us-ascii?Q?C2rKTh+ilK07ggnrtPgDtedzjdZnIM/vIsbQGidk6IgMqj+skb/Wj0vBGWfq?=
 =?us-ascii?Q?N8njugTtPWks4cQ87XYgpDCmG9yTNyW89CfqUj+0LM6xZ5PlYn6L9LH/e7K3?=
 =?us-ascii?Q?zH0dkSXYTD9GiZTPK641OyJ0BZ+lPZNa6rObHo3gvS9LCUqFPI0rqNDCrwXM?=
 =?us-ascii?Q?2nxoLvadiF9U+qthuxPB6MZT5HvR309FS1EHbzpOBmW6ArVxwXKMNbRbEWTK?=
X-MS-Exchange-AntiSpam-MessageData-1: +eRK6TRqvi/jDw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedd84be-701a-4476-dbb7-08dee2e0ce97
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 02:20:30.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD1mZJfwzVX0rUW9wFOsBkzc4z9+5a8bjcuOZh5gtMcj4crlews+aRZVbbUrn4xnT4yfEyTd5dwOktZrRk9QEoimT6tCoWsrPB9UuJMxbfqLO5dxbxp0qM5ks+FZORsQiFfbT8XHsFXw0DgjzV3BPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7884

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Add compatible string for the Intel SoCFPGA Agilex5 SoCDK TSN Config2
board variant. This board enables gmac1 as a TSN port with an FPGA
GMII-to-RGMII converter providing the RGMII clock delays.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v4: Fix wrong email address in Acked-by tag from Krzysztof Kozlowski.
v3: Add missing Acked-by from Krzysztof Kozlowski inadvertently dropped in v2.
v2: Replace mac-mode DT property with compatible string detection.
    Use phy-mode = "rgmii-id" to reflect MAC-side delay handling.
    Fix Makefile indentation.

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

