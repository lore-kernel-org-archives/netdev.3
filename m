Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5A5111B2;
	Thu, 15 Oct 2026 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061798; cv=fail; b=UZesFadToQ8iqeAde/rPLQChFNlyNNb0htFW/S0DYZIBkXVeBK0aGVYgbmeArb2LKTCrGCFXjjRTwHN4AaVwGeZqjfG5A7E2Q5bpx+yWkJ9rAhn3LfOTH9fFmH4cI+h1SFEqyiA0PllUSbpabKsF5btmSD4iayojD5bZscPfzyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061798; c=relaxed/simple;
	bh=Q5opTpsNyjpU7pGzlKnQXviO0CnawBsgOrEtO+nEFKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTQ1Q893FFOgXMAmlUWseDW4ZPQSHr7dYZ/R1Y/SPPRYg+AuCJ2MNu6Xu4bQldCccIdQAer3abLp91pbq1X/6kGTsjxNJPlUr9lJn8qgSJyI60L7pFkzl4ayBSHkFgcN75Nl1fhdEB6um5SozZw3Su1ny1GDZhcLMlOD59rV0as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TLUPo+2c; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TLUPo+2c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yij8XBGYWaPInnwok59Pzj4fykszWAPsGMlnlr9zdA4IhE/UT7my82lUisizo9UvAS50YnyOzJ2LR2mH9BHC6Ykp8K+V9RrC1+2fGX7TxETHLnxcsBX/Yg0K3PQup8s7Z0s9ladwFTnvU3jGbbzbQyoAhNG5gTWNCGQy7y73BfP8zV6aPNSonVuOICpKZlkG5Kb3MY9BTf/WVBVij2f6p33POrWgAi7BmZiFfMQyT2IDeQC75p3eIYwRqRHM4SCIzdgBczbgnhu/Q6RwNkqjHs5izlYKpHRzRgeCB84C4HL/EabDuOoSPxntPok5vXcRWfdPBDxXSQLSi34cF7avdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itvl1O2NczJqk0HP6otk8zE6COA5tpW+3hCtDpMYiZs=;
 b=RZecCt+alnkq9FLjVCSLXJiJnJn/oURvgo+2Yb6ogn1OjFcKbeHLBPpnWn8SpnPVFuRnve5GxJw7fZpGdLWLedtOwfQgg1tPBYZeFrgAnp5jfOxujst0FQ1kF4UMGwYIUr9ko0YVHokCjBZswltuQucise+EBWy/dUAtUHTlU433X42X6Sj7S2bZD+34ZGfR2D3eUhQF0foa6ry1Cphtm46xtQQUzX5B+s/OUFqOtgNqRMO+HBwljKzGCGQueYjEPzHoiCu+XYrO+x3usNQ798NYoZBzgnl2zvkfGBugk4+7erDo+oP6KI6HYlB9T4q2iC9wbua21wmkzME7hb7nnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itvl1O2NczJqk0HP6otk8zE6COA5tpW+3hCtDpMYiZs=;
 b=TLUPo+2cm+A0FhNvnvzbihRy07vtq9e2cpczLPC6vN0maHWaHXxVR1JsDVc/Wcv5TyjkokWoIsihamlSfrSF84wPgvzVYzTnlGS6P8q9PWM6hRCkp2027IpVXw1YUmGPARByOz2oYX67uUCcw94vK4y4jjzuZDPcPKVtwVyQG/wP9Pzo849uF0ySnpbDvHI0Qm3aFZ8EMjcRpr0i+ISAa9+0plJWWyfh0VzQeQch+Wx5It+9pHFbI6OOO7B754dw+Vigz7IInR0AVWjoWkRRAN4eJeqpVrvqlHuCPCGzd8RV+6thzEXfy1hwG1rFrBWsvVKtVFRnmozqr55Nlb13mQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:56:13 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:56:12 +0000
From: vladimir.oltean@nxp.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Zefir Kurtisi <zefir.kurtisi@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net 6/8] net: enetc: pad short XDP frames in software
Date: Thu, 15 Oct 2026 13:55:34 +0300
Message-ID: <20261015105536.1692348-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::34) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f421bb6-0ea6-4efb-6e2f-08df2aaaed83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qtYFNj1EpSN92+IQdnszyaf5AMWIQ7oIJI9JAKlNkR2PvQKzYHb8puKknmWlOPA3i/aiU6ql5X9H956PN/v2wfBsIuHx0V1/PHgfPtyXYR0TR60Yx+DN35fppX/GimMTvXdsB86CaRxoDPD/Ap7lGQkG8hQFcLxRMom4vPW20zn+8D2VzE779jSXOaUpuy+HYGbJYWyuNGg1sOT461O858xMAJHsJsw5ndcYlhu0DzBOnPN3LpQGbbiWgkpU+KnRti8SjaWkr9AagyNsB5nh0P+dGO2i1caT60xa4OHrCqK8DjwDvkgknJrgZmdZl3OBALX5Lw3fk4aIxwbexNFR+TfEHwv2dxtrzVnm5HSR3Sr/WQShnF7t3dnAKcmzLmWAHXJoJjyOfnnA/WT0zPWlu5vcAx+iw+awSrNHh1ITbgTHvAkV2f0KqojjhEKIg454u9/bAspHzaVuiKu6ULpNJCZTMaiK7rVW4RNevLUneHlxF50loL8Ed5K/qqPjYAFzVtRNEHkcI0YJoFdKU1JQmEVE4W4te9XUrkSUtbR94tV5C1T1tnvo58pAabZaLA1dKT/YGwDozSmGYyWZdWFgzYdv6gHX94bOOwbLa3mLigHU4+k2WbXYe+yJ4WbIjgUSo85t2qZRtDqcaB4MCJoVqCfyhzxQSoFOXHdePPyN/Sg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ioGVK8KcXF5WnlwTTeFtApD30fcjk0FoM9CJslbyFQ9GgybSYEXOVoZ6IFv+?=
 =?us-ascii?Q?qQCdJiyoo5h/DAMEwbM/OZf1MtqHGrn6fpTBOKDYh0WJWnrnUfbvRIv2v1PM?=
 =?us-ascii?Q?rAxcyKBuT+sk9CwGa8AsMWk8ssr1pctk3Tn2df7xeX7U1IftRlyT0mekvvUh?=
 =?us-ascii?Q?R2gTXf9fgRV9r+EAQ9DwLf9MLeiiUhpvI8h5TKCppqxI0sO1VSHDsv2uprD8?=
 =?us-ascii?Q?HFYgTQbmUlOQjs4/qIKfum5gVYo7uqD2BdfaaUpXmM5fNGYbLytBatYVWeT5?=
 =?us-ascii?Q?kl5YByxx/UKmehbz3dzvuk/R7OmCElb0NvXWyHlQgtN5PQFtf/CN1annr4uB?=
 =?us-ascii?Q?QvJ9PZxfikzCacDMvy4wPZahkh2UnQ3xeqC057AJZSepKe1PDNvP9QU07s1F?=
 =?us-ascii?Q?r/KzqAgRgYlnRW985REIEC9W3Hbmmysb33vWhTwu+Lh2CxDa+eEChh+lvGVt?=
 =?us-ascii?Q?DqTfWNfndYTG8nxBPvkrsXkOyNQjtxC+KWULOQ1dYBddQs5xfuQ1Fehy5mtV?=
 =?us-ascii?Q?V5JrDq/jm04Zz0BngZbyGWFJM7catPG91IBwdL7k7GqC25rshDVGbGIA5UhX?=
 =?us-ascii?Q?A+z5WJVXXRDlXIQhbh6oGCmsq2Z8iWxhJwIwZZl56y4effP78nECTmQFAFLK?=
 =?us-ascii?Q?1/xAs62i7L0CdPNGwGvagv423RZJgEGMV6TrISFOgJ0QnQx1xRGA5BnSt5xU?=
 =?us-ascii?Q?vwT3aBV0gThe3E509N/1Nw9MaP4Nt0lu1xT2cvquWnAxxvKwwIAGvFF3sCdL?=
 =?us-ascii?Q?GYSSjzaB6ydTfu4nkrbwtG+E9/OxVRjARN5kxkZ4N5myoEHDH+cLCgk025xb?=
 =?us-ascii?Q?QM+PyMM//2BlyiZaY9XkDDYeqHljp/WB03osNkrNQFH3h359FqnfQgHIhomR?=
 =?us-ascii?Q?pPprkMoBEgCoSCgPPnPy4lpcfXeE6leBxILZaEiY5KwXC1y+z+GxLw9S57s6?=
 =?us-ascii?Q?ORWd/hpCer5D9NrphnCU6cTSTviAllBu+9xJdUv0fkZQpOTYIeiRx+M5IoA0?=
 =?us-ascii?Q?/82VZv6Jpnx+z8vAiV+DlQvDjXRzjAlS512LRNKjwrdxDFrv2SoG8ND+6jSW?=
 =?us-ascii?Q?/tNwVNOcSAhH9ihS9cJhQsO5xbhCtdKdcjDKW63QS/P1GTENUQI5o5Cc+ky7?=
 =?us-ascii?Q?b+8/Ba+OomeM27xGtAbgA9pppZzmm9N8y6QjLC8yH5DzMg0/MwpKkX+vrC04?=
 =?us-ascii?Q?sfBHA2/kkvlttEMf9UMuRWfxZLB2p+7mBgWDBIbnj6TwWP86oCX0WyMDwxho?=
 =?us-ascii?Q?zYonFLePPgASIsgEFOUr+OajsVrzvQO3b+ZMoUKvicOPw6kzFQ1TlbEQLF5F?=
 =?us-ascii?Q?eXIlG+Iy80bZkwsqcvRP/38za1PDKRtFTha/4YRAYGdOC9GE+E/f6yDD+bAz?=
 =?us-ascii?Q?nbIeD9fsvaiVIy0pwg0x9C5SCM05C6lAtDVDyS/q5cI1NSiHq7gQT7HJWesV?=
 =?us-ascii?Q?qEeCLVJ4A4ZgtFxDeOOR+WkicS0rRNTPzM6oWUefrqwdOj0A2D1bSAqCDVP4?=
 =?us-ascii?Q?HusXU3zGPVtN6//IcAuSoRwPa9ipxQJdpO3ApV65ZJUSvGg6iZfvNlegGBpv?=
 =?us-ascii?Q?HiWpuLFbSBD7QRsESWgFIHuNP12DGJ7FxHP79z4rPzplXwUcxgqYf3CO/UhS?=
 =?us-ascii?Q?iOLQ04gvSQ9uSYRFkCK4TY9HbpQb77YI3VpGIgBVwXGZipCnsBeL0MGyHqmh?=
 =?us-ascii?Q?nnPnONix7+KW14kLxKoOybaJ8SajXmJeoKAB+f5riomz96DfYpDtkAUX2qNQ?=
 =?us-ascii?Q?viYYcwJacA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f421bb6-0ea6-4efb-6e2f-08df2aaaed83
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:56:12.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynO/fJ23TFTlo/mhq2AWt+oWkxiSqVY0KC7rzWPXQX8/iSV2HSkRsDiPiyCR7ijVOi753uewYW873Uirhd2JlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

Similar to the skb path, the XDP transmit path may put frames shorter
than ETH_ZLEN in the TX ring, and may put frames whose first buffer is
shorter than 16 bytes. The former relies on mEMAC hardware padding,
which we no longer want to rely upon, and the latter is not supported
by ENETC at all.

There are two callers of enetc_xdp_tx():

- ndo_xdp_xmit(), which can transmit short frames for example when
  redirecting from a veth interface pair through a devmap.

- XDP_TX from enetc_clean_rx_ring_xdp(). With RX VLAN extraction
  enabled (the default), a minimum-sized VLAN-tagged frame is 56 bytes
  long when it is sent back. Furthermore, once the driver honours
  bpf_xdp_adjust_tail() and bpf_xdp_adjust_head() for XDP_TX, the BPF
  program can make the frame arbitrarily short.

Handle both in enetc_xdp_tx(). When the frame is shorter than ETH_ZLEN,
append a BD pointing to the shared read-only tx_pad zero buffer, the
same as for short TSO segments, and advertise the padded frame length
in the BDs. The pad BD becomes the frame's last BD, so the F flag, the
is_eof marker and the xdp_frame pointer (for XDP_REDIRECT) move onto
it. The pad BD has no DMA mapping of its own, and it is not an XDP_TX
buffer, so TX completion neither unmaps nor recycles it. It is also not
accounted in xdp_tx_in_flight, which counts RX buffers.

The 16 byte limitation for the first buffer cannot be addressed by the
pad BD, so frames with a head buffer shorter than that are dropped.
Both callers already treat a false return code from enetc_xdp_tx() as
a drop.

Doing this in the driver rather than padding the xdp_frame in place
also covers multi-buffer frames shorter than ETH_ZLEN, and avoids
writing to the tailroom of buffers that, in the XDP_TX case, are
recycled into the RX ring.

Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4:
- patch is new. It replaces "net: enetc: pad short XDP frames coming
  from devmap", which padded the xdp_frame in place using a new generic
  xdp_frame_pad() helper, and only covered ndo_xdp_xmit(). The XDP_TX
  path is now covered too, using the tx_pad buffer instead.
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 36 +++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 08870df613b8..15c48c938a4e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1747,8 +1747,11 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
 {
 	struct enetc_tx_swbd *tmp_tx_swbd = xdp_tx_arr;
 	int i, k, frm_len = tmp_tx_swbd->len;
+	struct enetc_tx_swbd *last_swbd;
+	int pad_len;
 
-	if (unlikely(enetc_bd_unused(tx_ring) < ENETC_TXBDS_NEEDED(num_tx_swbd)))
+	/* Hardware does not support a first buffer size of less than 16 bytes */
+	if (unlikely(xdp_tx_arr[0].len < ENETC_MIN_BUFF_SIZE))
 		return false;
 
 	while (unlikely(!tmp_tx_swbd->is_eof)) {
@@ -1756,15 +1759,24 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
 		frm_len += tmp_tx_swbd->len;
 	}
 
+	/* Pad frames below ETH_ZLEN so the mEMAC does not pad them. */
+	pad_len = max_t(int, ETH_ZLEN - frm_len, 0);
+
+	if (unlikely(enetc_bd_unused(tx_ring) <
+		     ENETC_TXBDS_NEEDED(num_tx_swbd + !!pad_len)))
+		return false;
+
 	i = tx_ring->next_to_use;
 
 	for (k = 0; k < num_tx_swbd; k++) {
 		struct enetc_tx_swbd *xdp_tx_swbd = &xdp_tx_arr[k];
 
-		enetc_xdp_map_tx_buff(tx_ring, i, xdp_tx_swbd, frm_len);
+		enetc_xdp_map_tx_buff(tx_ring, i, xdp_tx_swbd,
+				      frm_len + pad_len);
+		last_swbd = &tx_ring->tx_swbd[i];
 
-		/* last BD needs 'F' bit set */
-		if (xdp_tx_swbd->is_eof) {
+		/* last BD needs 'F' bit set, unless a pad BD follows */
+		if (xdp_tx_swbd->is_eof && !pad_len) {
 			union enetc_tx_bd *txbd = ENETC_TXBD(*tx_ring, i);
 
 			txbd->flags = ENETC_TXBD_FLAGS_F;
@@ -1773,6 +1785,22 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
 		enetc_bdr_idx_inc(tx_ring, &i);
 	}
 
+	/* The pad BD becomes the last one, so it takes over the xdp_frame
+	 * (if any) from the last data BD. The pad BD has no DMA mapping of
+	 * its own, and it is not an XDP_TX buffer to be recycled.
+	 */
+	if (unlikely(pad_len)) {
+		struct enetc_tx_swbd *pad_swbd = &tx_ring->tx_swbd[i];
+
+		enetc_map_tx_pad(tx_ring, i, pad_len);
+		pad_swbd->is_xdp_redirect = last_swbd->is_xdp_redirect;
+		pad_swbd->xdp_frame = last_swbd->xdp_frame;
+		last_swbd->xdp_frame = NULL;
+		last_swbd->is_eof = false;
+
+		enetc_bdr_idx_inc(tx_ring, &i);
+	}
+
 	tx_ring->next_to_use = i;
 
 	return true;
-- 
2.43.0

