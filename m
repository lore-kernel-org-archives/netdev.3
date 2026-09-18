Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010023.outbound.protection.outlook.com [52.103.20.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524743B3E3;
	Fri, 18 Sep 2026 04:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707097; cv=fail; b=jkAWyqglFtMt8ximbwNTpYWWLWRI8vP825WWBeNWxRwwQ6gfBQSZFUrW3LEbWGUIKrmGyXV7cXUQ9bQ6q12ey4h1LmgAyjstEfyKCDzEEYiCk6Qwn1QZJe9yK09v1n/FXOcc5icCHkcl9YOgNKc16ZXheqbsVyKDIdMfHDbhedU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707097; c=relaxed/simple;
	bh=FHSr8a4c7Wt5Og+CNCxKNSrVEmZ/mtMNPuX2aIrfpgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KikdGkLY7AMuMQNlxMfGb09G7UnrO3Yr5zMPzVdBAUUqVTHjuJsxsFHw4uKY+xRoub/luVNhjXKuvs6Tsu/0Jq6NP8c4Sh/LsUIFctjWllGZvmVygn9p8VwdwJMuMIdW10Pjrw6+eFT3TSXA/sBHa+6igtGLnBzJTqE1VtZOIlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pnuBrFo0; arc=fail smtp.client-ip=52.103.20.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pnuBrFo0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hanFKj5imq99nwyDULfseJ2SOoHd3EQJV18MqYm0iabLbZhl5WjZbRNzXb9ouJvkeN8ag3w0gHAfT5h54ihQYSS9tc6jD6Feb/LZ7NEhQKZr45g66usV30C80bFqKD5cwUSfGtb+87LbowjFUzzlQRPetjDSm1hacIrzHWwVvvio5hib5VMiuGKqpCTDqQK0K6ghInMr1toGME9ddroYHzK+Yl+xS6gn96ou3RadimtwhH+ATurddKnSY17HLRaU5D3MIeucdhnkenQR/W/P/Lna14nnfqtUb6+SThg6UqGGxrND/uOkDom7XHWsEFwZ4tVyBBeSHQJvsWklqMB4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89Poy2b6FLwtPQFEiT76AGR0/IGnlkhounJx7iktvp8=;
 b=Af2KNTWEYQWc1E71r5VPxeTWUJI5z/acnhBD64zeiurNyHes1PtYu9CBa0uiOloa678fzchMonHTjRPohl6n1tqkWlL5vmiNvyglU+ymyb3p25XbF4jiiJpDhQL7HXMSGeHWPWagkvtLNvrP/wX3AZh6sEraZ0DcexSPtdvsi0B8RU9i4csCc1pT/G7Gtfl/tccvalzYa0HUcv3AoRFSEnFwuf8ldzRGBmSwr10zdPJ48PUXdyuAm8PTRHVgfzveEbtgezpDn6z0lrGg/A6c8YJTE9heoPnS/NaBPZusen5jxPTOtffvx8fKASLE8XmCy4dbmRJft67I1Cx9qVvM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89Poy2b6FLwtPQFEiT76AGR0/IGnlkhounJx7iktvp8=;
 b=pnuBrFo0oR3X2n8BBq4xDknhOu+y7BwZIWkYgZnSj7sv8ZPJa8wffygXmGYMYpUtJ6VJvQeiC6/EMUkAAWueCU1J6leVWl4LskPXZmqa1kaoKCFKHETHVoElMy0zcomuDOxCCvX4i+VNKQVDLyHoGoo4E31wi2ATvnY5bPmv5S9viv8OztYqxqvi5BCJQT7Byhk0N47eXVMm7maR6MJJZHSmcnxMzNGahJjnZPhpqRRW282RdHj8cj3IAzlNmb0Byn8Y87uTBdX+sAdOvncq7LAWD1cWyHM4/ZMimZNVvXLi5bfTHuYEzFcOlny4LBUuPKEwYOx3QrSzTpLBNxWSzA==
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 04:51:33 +0000
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65]) by SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65%5]) with mapi id 15.21.0406.014; Fri, 18 Sep 2026
 04:51:33 +0000
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
Subject: [PATCH net v2 2/3] net: stmmac: advertise integrated PCS interfaces to phylink
Date: Fri, 18 Sep 2026 14:50:55 +1000
Message-ID:
 <SJ2PR11MB8401D53F5519472525156BA9E4872@SJ2PR11MB8401.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SJ2PR11MB8401F5C3A075DE2A0013E063E4872@SJ2PR11MB8401.namprd11.prod.outlook.com>
References: <SJ2PR11MB8401F5C3A075DE2A0013E063E4872@SJ2PR11MB8401.namprd11.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MEWP282CA0188.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d6::16) To SJ2PR11MB8401.namprd11.prod.outlook.com
 (2603:10b6:a03:539::19)
X-Microsoft-Original-Message-ID:
 <20260918045056.4294-3-tom.karpiniec@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8401:EE_|PH7PR11MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f12c347-b375-4c32-d94e-08df154082be
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|15080799012|16051099003|25010399006|51005399006|8060799015|19110799012|24021099003|37011999003|440099028|3412199025|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qQ9VS6NvahxCBI0fKDANANy+jOgH9gJ7FxRB7cbAMui7Ec2bi7to+DrAULJV?=
 =?us-ascii?Q?/lHvp6EbDVbN6/qaMG5mKMLPZbL0U9VpZrX2kmpdmr45CJ6FiymJyceHarJZ?=
 =?us-ascii?Q?zpxwjhRIPLgXO3ppKOWKSLlzshlqHFP9AHpY73FIwsBmu3has3IXiOpCOtf6?=
 =?us-ascii?Q?ApRqQHzcn6z0ryYyndq6mgDmuNBqzkaV+8m9Z+wL2R+NSwlsc482FDJU1DfL?=
 =?us-ascii?Q?CxFCdQZKRaJ65WSUHB2x2w0/p/cTbp8erCcW5qiVxkPl1N6FTbitQ5bsedJx?=
 =?us-ascii?Q?agsrH766604n6vwjwxt5kuGviQM5AqgwBg6ysFl5lun2cVXDP3GFAphO5fHg?=
 =?us-ascii?Q?+rYhi9kusQ6yWY2stqOnP0Cy9FNyspC713ShXVZD+6RaNm6dj90ZqVB+iWyF?=
 =?us-ascii?Q?zeEm6GHt0wiiKyXz+K30PTL+ggLWa1WLUUl0O+N3UJRtPNEVKDDMM95jHfFr?=
 =?us-ascii?Q?oRZMzoBYT3QPAs+GCMEqXWJG8gqrqkCAC49zuPlc1zBsfDUvcrHKUBrFuw79?=
 =?us-ascii?Q?V5KQCbXGUO9iu9t4wg8idbibqey0jQBvP8dwrA4+SNAPRtPrILiqOe6yo73c?=
 =?us-ascii?Q?ptwlMto5GJt0fKe64YCARooLmNz5mKVE5+v0qbLzxl2Klx40KB/VDCvVxPOy?=
 =?us-ascii?Q?MRFpc55z2urGIbCygTuXV4A51jRl5MfznHuhCMSihSiSF+7m4tDKpOCq+pe7?=
 =?us-ascii?Q?ZH7m8klC9hJzF8G0mffToSTQO6waYIXWBP1O/09iTgd6yhZqCrd2Xl0l0t7j?=
 =?us-ascii?Q?SjAhGPc8SJ43i9a1KSwdx75RiY4KiSlRPFMPb5tRpHpJhB1s9rQffTHVX5bu?=
 =?us-ascii?Q?nPXfsj7nuDNvWFuyT4iK94w0ZZxYQHwNs/FjV3ydffQ7BaTWdQblLDwBneWn?=
 =?us-ascii?Q?Its1JJ/wyueQj6TAm9LSeELaUd5XyoLsjYABO6/PHOMiMBY75/kQUUwSCP8s?=
 =?us-ascii?Q?a/9nIKo8z4b8iiQgQO0ztSbPg+1GT8omFvjtKVcxpEaxRwI5sNekrJPVu4JT?=
 =?us-ascii?Q?xuap?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qJ0vJvZ3JRIdhZ0ZZ4BzTR6J/PjdN3gy43pY7nDPgt2QNmWurDXG/AAgKNPv?=
 =?us-ascii?Q?hxqDcWZaSw9urZJ3TiGMoZgFZpsuT3Oaoj6IJq0jDjpNf8zLo22b/dRNtwXx?=
 =?us-ascii?Q?MUCP1d7D56dX0mmlbttwQDhLh6+6j+FCZVGH4gGeAXp7sZP8pP5cIVrlLCVB?=
 =?us-ascii?Q?x2syDitNl4csBH88N9zlL6dO1zYslbeQAoN3NGE9C/Az6l8am/oxk+JJ+Z/z?=
 =?us-ascii?Q?eq4CFR9owqBpRWju1o6XtygyTsiIi4s9wRe0gkesLF1Lt4Xsker04scolpum?=
 =?us-ascii?Q?gZD8jEzNnYdzFDNUTGrfuHaow5ObUG7NolzbzglhggDS6ow+Z3GP7rwytW2j?=
 =?us-ascii?Q?+nPcLWtkTTpc4z8f8C9DqWkrzw82BiDggPhyyj3lIvWcUnuhOgGWFVBHJaIQ?=
 =?us-ascii?Q?oVAJNkRTmXXc+fBzmAoZVVwqN9Godf+R9RxRdK3Z4yOwQ/teEZo6+g29gSmB?=
 =?us-ascii?Q?e0CB7FP7JVmxUxDXO9QEsGyJSgVAMiMIhWpxULMIY8foYsWEp0Txm0LNNTR7?=
 =?us-ascii?Q?WuqT3LIf2MrAaw0aH2/qFaTuvNsCSv3d62BytRVwyX6EMTv5ltF0xgFvN86z?=
 =?us-ascii?Q?sMnR5Dku3PMaSL3ElnS+raeBiCB6c0/EVKWcvRUNMGDWb09pYjhw/4Hb3GjK?=
 =?us-ascii?Q?Y2wEFsQw//ZFN9+Ixe7gtKxwVg3XUOFwGsjgMNdcG5hveDBTrncF7NJ70R5V?=
 =?us-ascii?Q?J9GuODx21ly8VJ/sc+HuWhkEcQXuRNlfga0tixBKlt3XOAMCwLAcVi3sSU1+?=
 =?us-ascii?Q?KSrbCnVLdYAQBVGXuv8sj7Ne6bOxPa/utX9qQ759wBqmql2uTkpT6f2ids/4?=
 =?us-ascii?Q?1SqHDRmcKn+4eZoUBu9fh/9h9+dwLBf6bUDdkcKHyytFAAi+n4t5kOByb9Gt?=
 =?us-ascii?Q?BVOht9d5T2tgafwLQRVaZ+xr/BjzlIrObuWTcwuTijc4fR/4+zuYk8DoC+1z?=
 =?us-ascii?Q?j3eiCPOcCudhb3dimqOg+DNZlJVVHjwTqvdEj4RhLtRtZUZbdSDpdqwtoXw7?=
 =?us-ascii?Q?cvxJ+WzcGb1ZNECdw0+9koRObk2q5VmTkNBe1AWDJyhc8B7ixZlqtXsrwk7v?=
 =?us-ascii?Q?f0suk5m+3NLaR2+0zEQe7I/3i0U3DhzCCNm7zmS/7yqQhwzk4yJYEW2/nZdh?=
 =?us-ascii?Q?WdJjkm5ms60NBTlakxFNgTejLl/fAQfVdQfJyTHgztK2UehU0yxyuUmz9zGr?=
 =?us-ascii?Q?7Kqk84SejMrrb09Z0UlL+d6ncJstUUjOkcPE/yjn9Etp78GDYVJkSbH46ZbR?=
 =?us-ascii?Q?yaFKsxaP0i7k1uDYWnEi1pAdGFB0Jk9OBlf6XDCIr+t+HxZMpj8QItjjS3/c?=
 =?us-ascii?Q?95u0oLxRYRPr444cTD+RDs8Nvrf05dfkOOH4VFDTImSfcmy4/LiDUDM7LSpz?=
 =?us-ascii?Q?5XgNLKFkH4st2K7oNg/DcBfI4XwzLafDiNjsB3dw13NLhfSnFnrUUP/BWf1I?=
 =?us-ascii?Q?9a8N9jsdFOkN0XtfJZfciUFePf2q2cMk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f12c347-b375-4c32-d94e-08df154082be
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8401.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:51:33.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145

From: Thomas Karpiniec <tom@wendy.sh>

stmmac_phylink_setup() adds interfaces reported by platform
get_interfaces() and non-integrated PCS instances to
config->supported_interfaces, but omits the integrated PCS.

On qcom-ethqos with 2500BASE-X selected by firmware, this leaves SGMII
out of the supported interface bitmap, causing phylink to remove the
lower-speed modes of a switching PHY such as QCA8081.

Add the integrated PCS interface bitmap to config->supported_interfaces.

Fixes: 68cff4fff61f ("net: stmmac: add BASE-X support to integrated PCS")
Cc: stable@vger.kernel.org # 7.0+
Assisted-by: LLM sparse
Signed-off-by: Thomas Karpiniec <tom@wendy.sh>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1350e92943ac..f956e0d2ec64 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1414,6 +1414,12 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
 		__set_bit(priv->plat->phy_interface,
 			  config->supported_interfaces);
 
+	/* If we have an integrated PCS, add the interfaces it supports. */
+	if (priv->integrated_pcs)
+		phy_interface_or(config->supported_interfaces,
+				 config->supported_interfaces,
+				 priv->integrated_pcs->pcs.supported_interfaces);
+
 	/* If we have an xpcs, it defines which PHY interfaces are supported. */
 	if (priv->hw->xpcs)
 		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
-- 
2.54.0 (Apple Git-157)

