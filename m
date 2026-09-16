Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010016.outbound.protection.outlook.com [52.103.23.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB444F4758;
	Wed, 16 Sep 2026 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555311; cv=fail; b=cWNskdi6G2RAsCC5JMx/FhyGryNhDvYFD0z1mOMdyos3G9RTnzV0YR54LKwJJn9jriTTJ0aluUa9YqW8mrQTeLu54hLy+MtpQQDm+Jxans3wJsS035jRpP+x2Gv+aj90IB8VUtCcl+iVGhOmHudzvnPBwO294ze0w4T6VKLTe2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555311; c=relaxed/simple;
	bh=jympCvUpn85cEui+DzMoTbtoq7p75ilaqnSWhUmHIcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E21o3WhSGWOGhW8EGb7ULLdoxw7rj10sqI7CKFc9ukcSabSWbK4N/uvW5h9AEoG2bWixzFrTW/4sLOjcQY9+MsO9BuTAS0hrWIKjHVTn476FP/KG9bjFmt/wqha7yDXnF5X1J8zWh6L8cIbnuoxzwQS3np6HwZmnwjzQYsEEbuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Hr6HvXz+; arc=fail smtp.client-ip=52.103.23.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Hr6HvXz+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=su8HarmpSWy3flOFRdN9ZkiMMU4uOkHlm9nbEZPQQ8yDwAQQzzODKmz0UKx/Td8MfZiKIs9HHx+V9CXL6NqijUHioVFD+5Y1ZghrX5G2Diu4qvvb5191zgCGJuG1BzQFEsyxTiJRcAk8zLGttJoohLMtWlVhHdIjjlnbuvjOkDB5V6np58pzPjXTsGB2cq2a3MMLi8T4fGIthbZQ5q+l5KL3BgRj+EomAISaPsqi46d0uF7egSrO+khpXk2okV6xgiiNpfgyPca5qWpcs+rrqsi234JgIroym5Vj0cDr6GUsIkGYwNab3LwhL3GFsqd77j/GwUcGZ4v7YO+TaNozow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZnYBaJw0xmP9Ir385yWRE1vP1XpTl5npLYizfD3pvU=;
 b=AdEAnDFpZhj4Uxwk+Y4stVPKDGkVJYCUHxa6I6zXXKIzx6GLkh3p+du3vZd95GyJZKvT2+uHaAI24xQ7m+7bm4tIMyKXwkt2CmkLyHk03HEVVONsz2klfq9QXDSqxyw5idLQIqNVi6dKvdCSlLdfNsS1tOWik+Oz0YJQlGfz4YztBpSeR8WTaWS0Bk4CJX0ej+czeFVLdwhl52zXmfuMdv3zd+Dt+eKYl8SUP7X1NOfS9xm3xmje2togJ3nPGL0oE82LVIXzwgDnferNbO6AExRtQ4SZnC0jOnbyBEfjFeXOxMW0HzNuvYG1mqNdWsSU6TvdwDqC9IgPvPWS7KNjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZnYBaJw0xmP9Ir385yWRE1vP1XpTl5npLYizfD3pvU=;
 b=Hr6HvXz+DT4+k9eZh6rIrhFdL1/U8WYuf+8mvnyAr1ZJTI463DCdq3rTmZRKgMmnZJ4mLJ92hb7UE/h8BhnDV98gaMmIumTP07B07VzcUkYmDJC6WAP0JnT0dfS69LjoERpri2rrLUdNWggPYJHRzC1D7E7b3Zl9t7F6n02bVJpznhvQgBsQjgeCyRTRvvF3QvI7GuOAlAQ4ggHTQhVpOVO6ta8CmQxQJXm1Yq+4Tx9brz+6pStvjhaz2ERUp4i5j5pXEl80ud5sJz8L4Gdb123cSjbBQsT35HD+Ep3nQVbk6wmRRRIFPPiXk0KDXneElRbbtbHd8V3f4OBJ/h3ogA==
Received: from CH3PR11MB8413.namprd11.prod.outlook.com (2603:10b6:610:170::8)
 by SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 16 Sep
 2026 10:41:25 +0000
Received: from CH3PR11MB8413.namprd11.prod.outlook.com
 ([fe80::5cba:cff:2a19:7d1d]) by CH3PR11MB8413.namprd11.prod.outlook.com
 ([fe80::5cba:cff:2a19:7d1d%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:41:24 +0000
From: Thomas Karpiniec <tom.karpiniec@outlook.com>
To: netdev@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: stmmac: propagate platform mac_finish errors
Date: Wed, 16 Sep 2026 20:39:49 +1000
Message-ID:
 <CH3PR11MB8413069BD77B03793D1A9B42E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
References: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MEWPR01CA0033.ausprd01.prod.outlook.com
 (2603:10c6:220:1e5::10) To CH3PR11MB8413.namprd11.prod.outlook.com
 (2603:10b6:610:170::8)
X-Microsoft-Original-Message-ID:
 <20260916103950.41510-2-tom.karpiniec@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8413:EE_|SJ1PR11MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4159e3-2e6c-4e2b-6c67-08df13df0e19
X-MS-Exchange-SLBlob-MailProps:
	7qh87CJt6y1mqZO6407WRLxlypE3k+ej2YpIfKi8HR6YKlr3sp/pHw1FGW5zSfhIuM0S1ESNUxXFEwKkpDTWK2ymjPWu3lXFip+IkrG9MWZGSW+kSdZG9zKNPlcNEk45YCsYbwrcq0suyE/cyssvNflj1Dg09GSKIqv9TDkaiNttxiXxBPlMogMt9RV20XOUDb9VAaRMP8j5MLHEgFfEr07C2xTf7RO9+5nY0VISXooQPgMnSVb7QPT9qr4EkTgyAwYh/7FYS5wzBTJKGU7a+6EMtrhNEFOArNBLhHaIFZdxJl/1zHuQDKNcgR33gZhCx0Qmhfl6k0efDVIhZG745hlk2UtFkEnPkukwpEVvvWsI/TXB1XW0YBB6oWLhamniVKE1qSEdr0odcLLs1xWDnvSa0rFKXJgyBIzoPWDBuORmsVBRJ25mLk+lCB+Z25/YJSIIw4oQpzox3+egZqSHMve2TsblVc1U8i8VDQJGjQHuRMPeJMZWq1Yld6H84/dSTph37VkoCDH+twNL8XdeZuXyaCaDPOoU02T3QYa2zWaFN2OJDTVqubZvsEBuJMCFGqayMbuHS7vSTfVd8rG6HVZ/1BFDJWk73SmeTMxz1xDebTSGpGbvUtpWb3OTEV1yqnb6OJ+XfzdANES9Ke+JL14NmP4QyDMS1alPj96EKNY0QEZzX6l5WuHts1p5nC7nGAfz2gfqnGDULvQ4y6CboM0G6hFiWokUChOVh+/asgMooFiCGca5/dr7Q5r6Po7l
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|25010399006|41001999006|19110799012|8060799015|15080799012|51005399006|37011999003|24021099003|23021999003|440099028|3412199025|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e3mLhfJY0BVoR3vhIQ/jo+vnjkJkGrpy8aMq+8SOXZiSkTobk6JQVXaM3oTQ?=
 =?us-ascii?Q?m3OYZsWLy/wDWwG0hCK/mR1DHww+ItzmW2LA1q5A95aBYTo7+ami9Pb2SH6m?=
 =?us-ascii?Q?yi4Sfbv/47gdzlGSyyD2mLAA2H2oGK4fbt+EFpUPriuf+mzQfNrIMIbp8I24?=
 =?us-ascii?Q?wEDOqhGEkjGN/40DC0CkBNhEHWeLwcmrh9zW342cNfXMF8oup8wGlR3FFXev?=
 =?us-ascii?Q?YicTa/w88dtafVI6QG0E217u8TJievWVlyOkI2S44EaMO9cJabBytdTaJedN?=
 =?us-ascii?Q?YI7N8kj3YTgegpXX4jJrGDbGbrKnt6lAt7rTVk2wRm63snBSksekB9t1lgrR?=
 =?us-ascii?Q?TAK+Qsp6RxTjkdrDmBpyg6oUyuIk6iYQCIYwRqdvyNsmgkb2CQKRnqXY+yx9?=
 =?us-ascii?Q?GRsj3ks4N9IiNDM/zHI6D8/kITHY2RISSFZmLdbOQoFFRGFmBLCbXqJAfKvr?=
 =?us-ascii?Q?Hsh10KVVPE+jK/QV6mpBHl3sMxnWStaw1K70NOk75KqDr1PnhI71QDDVQQh3?=
 =?us-ascii?Q?BBcTBX9Gik6ATHzM7UwAjtMI1/Tcc2vjioXi7xHcNKlGYPvBt1GZW58nW10Q?=
 =?us-ascii?Q?Em8u7BKWn+l7PWYF8qShPZ/eq7xzPBfa6G0UTbID61dpqb4WFIJripsZHIZ0?=
 =?us-ascii?Q?1upAC2xmBqlGcE8vVFyGVL/j9jjTc/I1KgVLMmMPjC8+CSz0vfleu8TUwbAJ?=
 =?us-ascii?Q?4xaewEvo8HTHIja6rxQEozNFWf6mbZBaaEPTo9bYWc4UxrufiPSPHkxGnjBA?=
 =?us-ascii?Q?X8/0+rwWcvIolIRf7OQzQFrmokMxxBYhJwjuS53goT/2FCTTes2DDehHDxm+?=
 =?us-ascii?Q?8MNljzW2wTsBqCXYCA6QG1NsvnWSeY32D7ITw+JWL3kuktF+NX4CBJWUe8rx?=
 =?us-ascii?Q?XS8pQmPr4Ve8qzOvQ6gaXH3AoaXvOjcCzf+3LGIAYF/z5GUyL3fcPPNZW2Yb?=
 =?us-ascii?Q?hvHGzQ1fLNwokWypFl+fiCB4Q0QLoYDN6/e04hktrDNR5Hrsj6GZ7NzSiHrq?=
 =?us-ascii?Q?PecW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sflDwqwu9Sfkm+ZOpznWBtCQEwzMtcKrkSl3Sm4gNDQCfV0t90wBYQwHShil?=
 =?us-ascii?Q?aJn2fpplSLZ3tKZWKr1E9PZji3VdWgdd6bogRH9PTScdSSGxD1oZ0zn6grEN?=
 =?us-ascii?Q?iFq2kd8KhWIV8l0jekPaRjode3FhtQwEhCtvUOcn0eRhP2KcsTA/JvdDt4yB?=
 =?us-ascii?Q?s/84v9nbrTOemfPm3GptXeevHTbb0CDN8j139ZaxwelTl4NPwg34CYsL8RoV?=
 =?us-ascii?Q?L4dF3g1qbL0COPx2w1EguIvCUjwTyOHxs6wgsJt3LFFVyU81aczhfLGZz+98?=
 =?us-ascii?Q?VtVbX4BsKBjQpU7lU89mQuX8yXjvtaTRQUhqycaZIV2Kgx5NAP/tglLcb9sn?=
 =?us-ascii?Q?tDmIESt1u4rTdXMmQXU+NZ3hh72MfLF4iAFwbq6lT3hYTwGRt8qHZIz1aqbK?=
 =?us-ascii?Q?UPHz43RzmcpAEf3bsYuCEBNj2C6BAi5eedon62ARllJGi8pxj3QDU57GN9OE?=
 =?us-ascii?Q?ZNuGLuY2egJCwfh3SAe7zkn06XM4wPiLcau9aC2DwqucQd5mIttlfGpoleC3?=
 =?us-ascii?Q?kNX2xdXEQb9yKcZ8tVNk2atF2BUIsEO14X349qAq7NQtUIQZbSv0inFMmEbm?=
 =?us-ascii?Q?iKhoP+5SBDs+GD68ox+FJo1CT9slPb2oKk/vkWLCEkcN/2+p6xM/WUCehMPb?=
 =?us-ascii?Q?XR+Zq6xnwzkWm+H2Eu+B0+IA2K18UE4qZSYsDrCckNz9zpVzzDTPBEhc+n5N?=
 =?us-ascii?Q?bwF9+hKGKUayv7sF4mQ6cd2vlSP7PKNrC9U2E/gH5JA2ZZKHC8t779zfAcwE?=
 =?us-ascii?Q?OwxSCN5gVN1L6FeT02cT2WQXAZvWYx1C3PYzDO8kRJhVOJFZIBZdGOdxWKxA?=
 =?us-ascii?Q?W7Pq27QYyq/CvoUMQHClVC3jDCYb1viujj7xVL+1QW7BOYrBgAyn117jq1CY?=
 =?us-ascii?Q?W1ZuZfIqfZdcwKvgKs9mJU6Vd/uGKwtHlj/q9ZEAVgGwE5Oj7TdNsEWqAvBq?=
 =?us-ascii?Q?nY5JpWe7puy8PaYDjFpqTtZiyvUfLnXbLQQP34pyYhcuZpyJGUbdO0RHfp85?=
 =?us-ascii?Q?1KKfDy94qmBSFsszyFPWR65RPqLtJGApEmY1pMJ07DK3SckOCEkM7YsAuxrV?=
 =?us-ascii?Q?/GmvAVReICm6TYweaiVNBXPWO1AUws01mvv7x0AeSb1pt+T0sv3Eap/7YG6N?=
 =?us-ascii?Q?E9d/Zr8uoYVEjbUV26kbpJ/K+t2sykGLDs4sdAhDcc6FAx5j3qVQWgUKhj5D?=
 =?us-ascii?Q?8W5pooDrR0ybTwYiEzaTpS6GcF2FqKDZpGGnFiwWad4TGGplPuI0Vf66XinA?=
 =?us-ascii?Q?1RX1dWzKJRhc6SAg23Toi4AFEcJenUC6O0BaeecbAfOfsY2vJroU3rfods1R?=
 =?us-ascii?Q?Ngr2L37mlpPJ47zM10KHcg3XnICbTfbYQH6kOwDkGVr8/35XspZC1/vu8vXB?=
 =?us-ascii?Q?ymPKFLsJkhVFeqUtZxA1JNTQt2x5YEdbe5iA94FZjPDPdUf8T/9M0HhBZrdR?=
 =?us-ascii?Q?kXeZZOhd/jZxXdHG4poJrjV0hoqoK2b9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4159e3-2e6c-4e2b-6c67-08df13df0e19
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8413.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:41:24.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129

From: Thomas Karpiniec <tom@wendy.sh>

stmmac_mac_finish() discards the platform callback's return value and
always reports success to phylink. For example, the Qualcomm ETHQOS
callback can return an error from phy_set_mode_ext() if SerDes
configuration fails. Phylink then treats the interface as successfully
configured and can report carrier even though the SerDes is not ready.

Return the platform callback's result so that phylink can report the
failure and keep the link down until a subsequent configuration succeeds.
Keep returning zero when no platform callback is installed.

Fixes: e654cfc718d4 ("net: stmmac: configure SerDes on mac_finish")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse
Signed-off-by: Thomas Karpiniec <tom@wendy.sh>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1fb5f804ea23..1350e92943ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1048,8 +1048,8 @@ static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
 	if (priv->plat->mac_finish)
-		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
-				       interface);
+		return priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
+					     interface);
 
 	return 0;
 }
-- 
2.50.1 (Apple Git-155)

