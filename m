Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924A039CD03;
	Tue,  8 Sep 2026 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851221; cv=fail; b=k7WrgnzcnWVK4YEep4/zTXJGsfISDvpBUNjolQAdI/LwjMDtAuqBVwxZUGCamo6oR3hPDVLJP4oRzPeLEZxB74VmEI1y+1Ugh/2gWWpCMtqfjrffS7Xcm1Cknb/WVvj00lNkTcNNWzk+mMyaVU2EwvYIHhLuBVtVoane9XnMwoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851221; c=relaxed/simple;
	bh=DpoKgaS1cFUn9lk/LeKMdTfbndbST1JBf07hMwZTYVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWoCby5UtJULWoEUnHCabQoCe3eDU4KX64VrFWOlTW9H7LbD+dxLGwlsHqafjV/cA34VzP+3A8gsqNlX9FL7AKy1w4MSjU2qX916Yb25hu3JdkVBzfFoBTKdUrMhBaLsNDY5DmimolG7CiYGeKD979cYBWNvZzvN4Wh2Qqiho2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ZIofUuJO; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ZIofUuJO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxWmKsBeOd2LRRmYx/aq8nNqfS2qwzD2uUugXQ0yQfpYyQDvUnuC/SQVyc83+rjv38Et67ZpluMaarmVGDjyg54GUR9qprbFUTWEUtqVVJrqT4ae08GxE2CYD+LbMp0ioMLQgdo1Mb/7CGk+RayPDNDZ9RngFtixqF5zQ4LJvYRrM8RbVdiw4xrxIP+qIkoEyoqAROGUfEwVLc/hM9/ilMzG/ff6yQF8eA193iODTqcTZh25VdN62khgB6snNhcR1wXMMYziFXTvMS4hWPMKmztIpysx1dQrJAp09VwoIfy07kEc8SJHROnhcKuDpLl4puAKnp3ViAGMxcZj573V/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE76DRA1bkLjJ0TcM5n2KUDFYOPPcN24e7GdWfo8k10=;
 b=nqfRkn5oEbmNtVei2PESu6xgM4lF5yH+mPMt1ZC25mFN0QFiZxALOs9tDdXEXgjfRnzDI3q3+cIKQIXiu284pHOoBBXdoSVt+LZ/Sf/6MmKuE7OcdvHlfo/Rv6bSLDnuAFnECzyfGHe/KYpIJqqdDTZulG4FjxoyMH+z4N3hfS4h8Fff8h+HQBox3glr9nOGVC/4NnUKANZpey6ihg2HIVrImrn1U0Hfspwj6LMMdpjqMOF6r7w2UOl/y/8pT08wSHPZ+1USPkp3I5vsiwE58R8T3YzggksGeUDZCe64Rs+m4FEYK5ZUkckMUR7RIyuKa6KgmOGlJFVg9PtPVJ/B2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tE76DRA1bkLjJ0TcM5n2KUDFYOPPcN24e7GdWfo8k10=;
 b=ZIofUuJOuKAhO45wGtJDdkjeURr1xsg0i1rs0dx3ymJAP/5ewovfdmLCxZ/eo2I3iMoHptrmVT7YSkCDjFG+eF7G8mFN10TqWZHCu1YoEg2X0LXw8cjyxqILb6pYzFY4Ih6AzwYHhJ4ZQN3D58ToY9+UMP3HgvmQV28qMZBAzZKVx4AzhPNqrt+2Tu/pYpHeZPKQaPnZn8/6+R8JLbM4+Sl4MkjpfyJyezBw6EDEdjQRNobbGyxAnRdrqRUXPZZ3l39QDlvCehN/GmsNygkPaJKFcq+iew83b+stIL/UpOmNzlTxJfaKEk7IkgZNt6uvZIV681OcBON0JwQwYtrB0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CY1PR03MB8123.namprd03.prod.outlook.com (2603:10b6:930:104::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 07:06:54 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 07:06:54 +0000
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
Subject: [PATCH v6 3/4] dt-bindings: net: altr,socfpga-stmmac: Add altr,socfpga-stmmac-agilex5-tsn compatible
Date: Tue,  8 Sep 2026 00:05:56 -0700
Message-ID: <20260908070557.3585-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|CY1PR03MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ecd6a5-2db8-435e-14d8-08df0d77c363
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|22082099003|55112099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	WDoQIXQyovEq8NCT6KLxi0lUty2G7xuFLX+wMF5SavB/fw1WAiJLqQ3Y3MrZGoatDrxhCZtkQlKvcth+jcxoOqL7JQc8zfm0osvnJ1Qp849OEyPbtqjHWccQZeLGj0eJMjhr36oL8bk5nqdFjlCk1XdZhzYrB7vkiOrTnfH0bmcWdrnPCrQtDeHP3+Rj+BsN62rjWFgbGgpcmaIUQMl401hM5AisK1p1z4cB5ba+HRcaGZCstl1Lc3wIqGwuMIouQFtXzQE5LRc/P1wugZDMojqpmPIh/Q8/YgAs0tDjExboxfHJrGB9Ou+dXtsUQ2qN2oXf3NpiDy+ygBTun49S9aAU+8KXH34mnSpwau0D5WvsQObDxo5tk8AvktgU2cAhFNSknYYFJcLgTmJCtis9bzMEiYd9ghqxAte/YNDU1OxjMSeZ+QYWgGnzvguN/GkQnamrwHj6d8qenD/DzQMnTFl+egzWmmSRwsDVpbDZXhAEw0SM9A8SnfNNfmcFBan/39ONu5CakA/4RrFPEM88Qsux2T2ezqXUofXVbi1ywzkQNt/7VzA0F+W2/Vg51tw7IW9d9QxnnCTTWBQJsW4A0oT4L5s1BXBLAAmq0S/3mSE7+tn9qq1nM5P1c7wCnzgLUN1gMKz8Bm86Tbi2mDaGZbcN37ly2Xci/ubLkVQFa0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(22082099003)(55112099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ciHK38jRQnxGDOIQKni17faG5EPwrAx0G//VZB5Hbf0KI0clJ6zjJtlc13Tm?=
 =?us-ascii?Q?2c5ocqz1RJpvqW4SoOyfZQeVLSPPI//L04u/pR+M9m6pD5HM+VxZjNnafbky?=
 =?us-ascii?Q?o/9zAwHjCss/t/dBmtI19Db6czCWkpNoyNChpcMK1VhkcfPv8VgIHR1pq45L?=
 =?us-ascii?Q?N3YrAzHRY2QzoVJ+v4F69Tpu089Ch/X5EfLLmdO4Zgya420Mp5rqN6YhYHp8?=
 =?us-ascii?Q?aILB/+kbmRTw1h5kFzkBf/YO095poEAOQ3z1rZb8AI8cEQmhLO1XOg7H+erQ?=
 =?us-ascii?Q?KS8ne7CciIZb4vOqtHtx3PBJwecLDz7LlC6TsAe6tzKqlikgKjdAWP/MbT40?=
 =?us-ascii?Q?OkZrovnf/09vHHLDnHXMhSxtZg1FbyvYqdbTUSczxFgNL6OCg6zluvQ2O3Ee?=
 =?us-ascii?Q?E4AlxI2cNzrbtvLO1iO25OUk3Sa7DQVO3YTlTfsHTOk983FQzEkcm7h8jtA7?=
 =?us-ascii?Q?kddLFxSxdbh1Mz0cGI/N+tC8D/R4naqWekdoTGmbWk0HR+JMqUJCXzPIDTvR?=
 =?us-ascii?Q?ZnTFWjE31BHDupqfbS7oBj5xL4RdiIRdaHL/fHNPqVcgBEOYeSqrZNXTcCW+?=
 =?us-ascii?Q?536g1iL8Q7HPm8/JPfC2p1TKjmOWt4Rxt1EkGxKXuMw3EMAimQSsW6C3TbMt?=
 =?us-ascii?Q?hRJmgarnbcsXBDuDITvGrvm3FAlE4o+0Z3CKp0BvN1LKFcsOljiKhatBvLrt?=
 =?us-ascii?Q?9N4MBzS/WLrAtv5SKBP7hJ4UGqnJt9yKuxOnV6smGvtr3Qdk4dPY03119Om/?=
 =?us-ascii?Q?ReAusm+6OKwNWIKSMdVQvMFgR60J3B9Z7m41iYrgeQjkODwU7oDFUbWcv2D/?=
 =?us-ascii?Q?EWHjWbX0uNc/jSNPSmwS2/C2NRRWZ+tJXXfm5sfIpqqJP/zb6PgVQ18QxRbg?=
 =?us-ascii?Q?Fz1TfxSq8O406hYK4ZB2u4Y4wAjct19lE7dYlGVIyBwi9rMAdqcR1Umap8D5?=
 =?us-ascii?Q?o+upJkaKtkR3U9mmJ9fijxrBXvFCVpKmCuuHU+Gyq6ySTc+Xrez1DGfLZcit?=
 =?us-ascii?Q?cLCuXkFBaYAK7digQ3uRBBZuGmP6UPhTHBQ+fHsNQYDsCDfJEUDhdBoTS2Q0?=
 =?us-ascii?Q?1lWYMnZ1fhiBM+JqlEaburpNg5JFWajPV1a/y+gsF2pdpgOBWpziN5fTqrar?=
 =?us-ascii?Q?1uGf66pCJGjBz26/5Rn6UJDJdVOGfqPuIXx6OMyQeKpiMDf1k1UcPjqpOoPS?=
 =?us-ascii?Q?HWiw48tk+PRhOlsx56jrr00iJQ+jfIVgGnxXmLIJsWTv5ij4TTpLNzFAStHr?=
 =?us-ascii?Q?mvCYwu0C85iSHpQLONNz/4slYoEicqJ01eb/8KOfJwUbX0329Q6woewdu/h5?=
 =?us-ascii?Q?saqYZyQt+s0kJHaE/v6A78W+y1fSbTJCEuNe71DZfG3sirfA6WV/LLSIlhzO?=
 =?us-ascii?Q?ce+rktk+FDCjvp9v2A4IcBldO7ZljOkSB+WZWorcGo5h1aPWC6sKLUVwDUqa?=
 =?us-ascii?Q?ZHqlFchQ6xhOB+NIhL/Zna7vpq2MbnAYB9/W2WTR9gZw+JPqtLV3xClM7uLs?=
 =?us-ascii?Q?2hKIjAUqz9QvuMwrxpsbx25Kkg7uJ7caKgxiOnHydFYMVM8qfZv4O70QBPfP?=
 =?us-ascii?Q?Jzl3ZKgibL2Ip1roy+8g1WXlL7+MVSB+Y1O64VoqZSmaPHByV8/s/XWahbeG?=
 =?us-ascii?Q?8Kv3i7uURwJV27sWD0k5p8bjaat0nalHOjP14mdfOFyYcXV556EBpq85/s4c?=
 =?us-ascii?Q?04yF1uPuCQtLek/fqfIA9rumARNu+5S5439WrDg1CqP70JHoqYwtf8o5IaVx?=
 =?us-ascii?Q?UFRItw0h8MLgIQk7cLHivI+Ra7PfBrDjhuaFGBkJrN5arItbfhOVXKVYjoKx?=
X-MS-Exchange-AntiSpam-MessageData-1: 1Y1XmpzM2ASr4Q==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ecd6a5-2db8-435e-14d8-08df0d77c363
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:06:54.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRBnkmna5gFmMd6r9i19MUvr2VC83Hnr2qWH6wse0k++YL5SJi4YaSFBueNttWbtbba+Dg0IfdK6UW+FKVrAyM8sVAQ//aQ7YB6SO/Wq2rv6vSnlFjqQaxJt9aS2389/T8rx1rJZ4YRgXeRr715MzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB8123

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Agilex5 SoCDK TSN Config2 gmac1 path includes an FPGA soft-IP
GMII-to-RGMII converter between the DWXGMAC and the PHY. The converter
provides the RGMII TX/RX delays and presents GMII toward the MAC, unlike
a plain altr,socfpga-stmmac-agilex5 port with no such converter.

Add altr,socfpga-stmmac-agilex5-tsn for that integration in the same
compatible items entry as altr,socfpga-stmmac-agilex5 (shared
snps,dwxgmac-2.10). Do not use altr,socfpga-stmmac-agilex5 as a DT
fallback for the TSN port; the converter presents GMII to the MAC and
supplies the RGMII delays, unlike a plain Agilex5 GMAC port.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
v6: Put altr,socfpga-stmmac-agilex5-tsn in the same enum as
    altr,socfpga-stmmac-agilex5, per Krzysztof Kozlowski.
v5: Drop altr,socfpga-stmmac-agilex5 fallback and rewrite commit message
    to explain hardware incompatibility, per Krzysztof Kozlowski.
v4: No changes from v2.

 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml         | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index 63084f762373..2c27bfd5af89 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -24,6 +24,7 @@ select:
           - altr,socfpga-stmmac
           - altr,socfpga-stmmac-a10-s10
           - altr,socfpga-stmmac-agilex5
+          - altr,socfpga-stmmac-agilex5-tsn
 
   required:
     - compatible
@@ -44,7 +45,9 @@ properties:
           - const: snps,dwmac-3.74a
           - const: snps,dwmac
       - items:
-          - const: altr,socfpga-stmmac-agilex5
+          - enum:
+              - altr,socfpga-stmmac-agilex5
+              - altr,socfpga-stmmac-agilex5-tsn
           - const: snps,dwxgmac-2.10
 
   clocks:
-- 
2.43.7

