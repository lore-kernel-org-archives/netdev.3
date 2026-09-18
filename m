Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012008.outbound.protection.outlook.com [52.103.23.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129443498F;
	Fri, 18 Sep 2026 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707102; cv=fail; b=P7lYs9LvdwQS8sT+4mauaCWAFehg05jM1gK9X51/9Zllp7us2orHOtzD/uxvaCZmKdi1gpSIFf1huh0CSJrD56jr5xWzvo0mBXaclI37zBuJCaMvcla885yk2hCUZySe1Xki2cf2jA8ERQHXU0ZAoitWFfrrREPSqqjaZgPDWRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707102; c=relaxed/simple;
	bh=YnRWi8893fMkEiYYw9ZbOV0GSJciiAUkMvboO0vGd1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ql9gwUHg4mtzbIXCNKv/c2uIiaKk/3+2xdlrhzM4VJCpvOpaSbHZj/P6mhk5G46Kogi9vfqu2Vn0+hM1GmOPIPuXamrrrzVgyNX4q8uUetG1ZxEhiTEwQufScYc/Z05uTnOBzAryY6o01PpiqKk+77kZfbgEDxaNzmTqWt7ZAWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BxsTnD6J; arc=fail smtp.client-ip=52.103.23.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BxsTnD6J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxi+J8x0fFvglxw0JmG8C8eGFZTRryt1AtOR7oxG250gp+YmxQgT+27iS4HRZp1lbxClvkFJB2hhPjdf4FvYE70IBWZLf3xKKlNHzjBaTmCPZ2uzr8glVEBw/rfCWudv9lxdfZh6uoaU9sG9vmcYDKF3+ZudC+L6Jd4AnGIbyX/f9LvoGg9G4H/yjnRqz+Z/VBTC45qj+ENUCbkSmHR5KY7jvCmTqWZSvYOOKKT58xl81w73GVi977OXli21oqWBzokrfwL+ccSMeC+32f70d4VAg4Kfz/kbF5qmV/JoXUj3FcNRe67izYnl3CsCMYHW7q+IE9GVDInZLk2sEcIAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybZ3sPWA8J+vJwvsCr60f7Mstcrqgfg/D6UA9IcigTE=;
 b=NfJ1aRhwn0ycL6bz5Kzj/hte8DcnUkG0wPB0ie0c3MeUKtvjIdaiEc2tZUFSrhCnS/PqkGoUXXPB8O/NFhr7K+Ymnf2+FkDr46hAOZV90D1rjTWY2khPOV5jv2iXLUsn7uynk6zT1pcSFkRQWdLrxcIB3Oh8+ZKso1ykme7m/nYap6g9Be+xS3X2A4VqFRPTACpbT2FlG94ZZGdp/k/TOTyua8VtZaeqv4w1ct5qsqxu6hUKg3js5nGQIVeJIaQM9HimEwNws0T15BV50lDRaraxD3qPMRYWh0si3Ps+TKB3nTeUjSVcFHCHQrHS6o4rtPedfzyTwTt8Bot916QQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybZ3sPWA8J+vJwvsCr60f7Mstcrqgfg/D6UA9IcigTE=;
 b=BxsTnD6JBmakgblzqUDa7YmuC/4q5/vMRhzvt2C45xVffx+2OYO6uPGy7GDC6qCIecUYiw2xNhdD223Lz7nv76RG+6qOIKu5H7Mj1OUqIaPw8BXOogEsRnKqCTdFnf8iqbAAvbThZYFTLDfIF7n/gdBNax5uBCXdWZozIY8emJfuIuvp3J1mxlmS6rMP00ihGJDhq6yGR8xrGzT2tJpdyHd71oUpmjAJfkP1yI4AEjdj/Jd7SXdsQJy34S0m9V8RPo0+BnQPi7ZEx1md5+qw9/nf2jrsoz8sO6M3EBSVhdOlT7fogx3m0eq3G8O1tf5xCTAfjbq41ZMrrVqW1qLfkw==
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 04:51:38 +0000
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65]) by SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65%5]) with mapi id 15.21.0406.014; Fri, 18 Sep 2026
 04:51:38 +0000
From: Thomas Karpiniec <tom.karpiniec@outlook.com>
To: netdev@vger.kernel.org
Cc: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Coia Prant <coiaprant@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/3] net: stmmac: qcom-ethqos: enable 2500BASE-X in integrated PCS
Date: Fri, 18 Sep 2026 14:50:56 +1000
Message-ID:
 <SJ2PR11MB84018DBB1F18F07D79DBC5E3E4872@SJ2PR11MB8401.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SJ2PR11MB8401F5C3A075DE2A0013E063E4872@SJ2PR11MB8401.namprd11.prod.outlook.com>
References: <SJ2PR11MB8401F5C3A075DE2A0013E063E4872@SJ2PR11MB8401.namprd11.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MEWP282CA0188.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d6::16) To SJ2PR11MB8401.namprd11.prod.outlook.com
 (2603:10b6:a03:539::19)
X-Microsoft-Original-Message-ID:
 <20260918045056.4294-4-tom.karpiniec@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8401:EE_|PH7PR11MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cfe103-90be-40a1-5f35-08df154085ac
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|15080799012|16051099003|25010399006|51005399006|8060799015|19110799012|24021099003|37011999003|440099028|3412199025|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Az/V1coEwPoBOcj38rgEteMBUnPszltvEnUdoJZeq35GdNr31Zuu1p4CajoE?=
 =?us-ascii?Q?Pv4cCqrmAT5vpNofThs5N0EwHbV3AcQpGZB7j34huLDGnk4/HF83Sb3zwpIH?=
 =?us-ascii?Q?+miinNavKBo40DsgLd2TuZxUXT/vypSh5dCLegMTVr3IPQiZn2K3Wo8nYRiU?=
 =?us-ascii?Q?OSO/Ft7DyYBMjTIW8DRDo0AFLBSe8c4hjWwTUsQ5D1Wfwf4w2CVUhRHiFSnZ?=
 =?us-ascii?Q?4XwBeRSW+sYHPHaiH720hWdosDfO9rzi3jICgjhhRKhcon5i+/7YIirnW8TL?=
 =?us-ascii?Q?qRvXyTz8zrXB9oTwWugwY8A5NBAhse45B8ewomtKv1cGVBvjBZikF5Hj1OR5?=
 =?us-ascii?Q?+/oFL0DbcXOQVhg4AMQPutNpF61R7iQHjvjGvvJK/TYaTVAPwARBgBdZlEi9?=
 =?us-ascii?Q?CRWfCDHg4jwcX9sIUm6orPFtlTrMRt4iPOmX/0j5wQTlCIqVQvMiYQaSJvoX?=
 =?us-ascii?Q?KOiaj6UKtEsLi0GhoLd5M66zOgriS//PozR1KZiUb2VvQbQ6F4f24X+CxFeM?=
 =?us-ascii?Q?VqarItVkl1LpQ3IaPAb6tj5OLxrXQriQ3WYapdt/nC8jSNUGLvn1PgzvYH1X?=
 =?us-ascii?Q?PJsRY14W3IVV2nqEREaytbalDvFRfQalUVBhJYfLI/ayYHjlcKFNyv2TxSoF?=
 =?us-ascii?Q?Xkf/JfI+yKcEFusDv7w6Af9kdFh0rQwB5+hSzoMJwxBEBx4MoHXT3WhAyqfA?=
 =?us-ascii?Q?0TAN3FS1RMDu4b3KD8UDd0hrBoQwhZsgkj4YWRLKOOWdcjHMGz3M+BlKWDtG?=
 =?us-ascii?Q?z3CgJqQDlchr1ngg0++OyTEgXwpkLqTQnnvZ75YEhtLhzKgp/ZP3pmzWkL5T?=
 =?us-ascii?Q?vibQ6iI2bG8TxSgFRT6LsZSFdjwNwTAYGCoXfWAvy36JPqEJvAQYPXSj4EE/?=
 =?us-ascii?Q?/zbQhBjNfIsUKb3k82U7nmdEZRqE5AZJeJaT2OzM10Z5iQfX/z0LN+qsIz2U?=
 =?us-ascii?Q?TzV9M6Rz7FGbrXiYcylUWq/B+KqKo1Zg1IiAhysJDTy7G53z1GEtDcQCvjrJ?=
 =?us-ascii?Q?BGhy?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uMYk0AfzRwAaqckG8AVyN2ifY1V92Fuz6JIX8ZQqGDtjkhErERsHR2I22gQ?=
 =?us-ascii?Q?+l68ZSCaBGMzkSbCbp9368fl1m24FZQMQNr++qYUw9o0yBKcqkaiWr8Ye/Kv?=
 =?us-ascii?Q?vp6IM56X5Ki0eivuiKEVvRY7H6UqUObDkm2BXcFsi0gUY8IWisM/Wm/tWRqJ?=
 =?us-ascii?Q?awgcpfuPKG55829iheaTqcnTdFVqHJd947G1UMPWf3hUMDEU/64X/A6zB4lg?=
 =?us-ascii?Q?w5x4p1OMs3dmtCMhZYbVdxoDA+MwF3vGYUEOeMEaRqxxShFbB4kHPbD78LnC?=
 =?us-ascii?Q?TXUUHJd2c8ZUi+fq1SSzGK/Uh+WTzKFv3PrBe1g0TMq+kIauusducG2eDh5f?=
 =?us-ascii?Q?60WZfqBmRJlWUfDdk2+3ifOPKX8WqMJRGukkw/k6zfCr9gJkksxEuTMLJ+Eq?=
 =?us-ascii?Q?Tc2de797nzyGvPva0ypVuUrZHI8rIWAGvFpHD+EszVe+165LKNOeFoLVoFCn?=
 =?us-ascii?Q?fDbc9Mu2K13a3Jn3Jbyn/OBLacWfQMH9V7eY9LxdZMQdOoTzEt3hcs3C9FC7?=
 =?us-ascii?Q?9byd5h0uiFF3qF0WOf8a+U91RkguO4Gfwx++niRQfsP8A3D131IeEpU6hD/d?=
 =?us-ascii?Q?DC9EEbOlJWMiFRoj24e6yiIaMAiZu9Q/YE26NfkUPPn8aXNaMBrraln5syGo?=
 =?us-ascii?Q?o8WJoo+TYSCuoF1rxfa2xER7bUFcLLy17Ila5RY+nvpIE6vKFovYHQrp6TZz?=
 =?us-ascii?Q?b9kNyucQ8OUnoVDPo4CiBAFDxwUJfRIadRgnrxa0CSeXOfF0ALVw+W6vSjsD?=
 =?us-ascii?Q?4GnGb8jXRV8RnTpukPJggIoiGPLsP304Vy4d5PKZqcD03MNvPfk0Y6AEJLKN?=
 =?us-ascii?Q?Q3lxGMog+SrUFNtrCzziRt1mPMXorNE67MmcMywIBiV3wga6EyBjOWZMkBB6?=
 =?us-ascii?Q?GtewphqJn8XTItRsO5FMbPHRLTn78y4yMgaL96U3XSg1+kFS8WmMxOkzxQID?=
 =?us-ascii?Q?AqmIB49VyYvVPZHuy5FZhDQ+0pj01CSV+zQbDd4pC54dusZRN+4JYm0KoIWC?=
 =?us-ascii?Q?xB8zK23EcSBvbgUbRxXEf1pedQUTr5zwKYvwdQk+Dl32ryqX983mnhNZgJvs?=
 =?us-ascii?Q?MeF9ENptEQ+4JAeGej02OolhKm/SxgLtakG9Zm+ju4icRY2jGEWfHQ04JlNU?=
 =?us-ascii?Q?xvydHu/nrSyOa70ZTbEBGy3TzQLbZ0YOC2n0zzaHuRKI0X1Py+JIDD/udGdJ?=
 =?us-ascii?Q?vMpcvV5Xj+f5dTDHC+8j5n7H16nr6Sqt98AZfUI7rpU/0+5iN6bfl2j7qo4N?=
 =?us-ascii?Q?mjlkVe6g6UJkq6aF+o6BZP559TUo3nCrCgIwOCATG31/L7Q9k8sOPCwslqMk?=
 =?us-ascii?Q?F2/l4TCtgChDLoRqlIKHN1pc3qJrVRzzS4nAWMeNidXMkEye7TNry3T2KgYh?=
 =?us-ascii?Q?ZXZMag6WKaKV3l4sq6YfFkeUo1j4oOUDFM9QF+7JUcSZvDIKSwsrmQMQQBl3?=
 =?us-ascii?Q?90tMq6Lfmv9vmH9dmbV2iJfjk6M3W33I?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cfe103-90be-40a1-5f35-08df154085ac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8401.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:51:38.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145

From: Thomas Karpiniec <tom@wendy.sh>

The Qualcomm ETHQOS SerDes supports SGMII, 1000BASE-X and
2500BASE-X. However, the integrated PCS only includes 2500BASE-X in its
supported interface bitmap when the platform sets
STMMAC_FLAG_SERDES_SUPPORTS_2500M.

Set the flag when the optional SerDes is present. This allows stmmac to
select and configure the integrated PCS for 2500BASE-X and, once its
interface bitmap is propagated to phylink, preserves both the
lower-speed SGMII modes and 2500BASE-T.

Fixes: 61e9be0efbe8 ("net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode")
Cc: stable@vger.kernel.org # 7.0+
Assisted-by: LLM sparse
Signed-off-by: Thomas Karpiniec <tom@wendy.sh>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index ac7d6d3e205a..0e07225a70ca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -786,6 +786,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		plat_dat->host_dma_width = data->dma_addr_width;
 
 	if (ethqos->serdes_phy) {
+		plat_dat->flags |= STMMAC_FLAG_SERDES_SUPPORTS_2500M;
 		plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
 	}
-- 
2.54.0 (Apple Git-157)

