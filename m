Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010006.outbound.protection.outlook.com [52.103.33.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492412F260C;
	Sat, 12 Sep 2026 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237073; cv=fail; b=Xn7lLO+9enEGQIMJaxHCtKZDVHYvuthkujLEuKau6P4jTUfaQcWt35ueF4XQlqVluBEgH515k9ye7bR1cCuVADJuitW5CdaswIkLluIvSAZJQLVYa7fFzfBDH6d9bn1XNaUbnHi+o8OVk1NnBgFB4XLKjpXrxxL6nc46vhFGdpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237073; c=relaxed/simple;
	bh=8/MBjP6qV/tipUlX6kZRWJFwUIE0LkSEJ1Lmf1x6qVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOBGZsfpHSeHI/X9G3eN3oXUk3U8KBa5DtD3+KuJbUJVtsewyZ8MMz//vVqNbPMYRBNfqyY5OcXjS5B/op8E9e5UjlAlyYFHdpvzwMgVg6cEb1+iw66lNEoaLuhUzc3paJy5htHAotN1A5gFlhH6b92ctHyJM+md5ycpeDVNlEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=tPXOZRay; arc=fail smtp.client-ip=52.103.33.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="tPXOZRay"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E686ZP7ZOPOZHN/HXXrlsWR1ZSUj/vCRZS8M/OSeo7aa78JJ84EV+4w+Aue94Tq5pBCS5e99Ec/6BQ0RXUSiP9okW9fZTZX/aOWNzsBOsKcruBKl1DusPiJL50+iFfMkwbMzMIOc2km0ZZqXZKk96mCZMkncpnQm/+hw6uhBon3z+Cpzg1bEfDvjLXDBNjb3u5MigDSM4snp5KQ9GUB50xMZmdekl7ed+5p+KnRxykIRZp/wWC6NLeowKJndPGFDHvFUjQLsWatcbv98/zU46UVxsJZj9Uj0rUkzItlPBDckDWt9/O60chTerOz2sBMoy9bf2lrjBERTZ21a42AnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZkgW9lw9LhtweAQNVpvhJxcLTiKUd/TmTxYcmNwGno=;
 b=BEv5Dp4lEkra+Jo27sREnyYTx3am+BD0P49pxFsJQjc+b5WydUAlIy/XOQ2GFqyrCmkqI9eFIaAsWXW58c7Jamapl7B1bqHTo6ZjdNC5oaXAt4Rm4QV9ERjqVENMvHRR4vCA78L5/jYrZ2n4vUTHmodxU1c5AvtLz5n7WVFplLTAyxhEkBHTUbuQZbrn6r0alVJuMpeUcvEBygJiTGWYNWJLJ+Wme+pZLxBVruXzCOchYtFvk2TAO4WCNNQBNJx6//Bq4VYJ+NsNXuHV+2/Eej2c5nDPW8+5gRXHswxNHJdNjkHr01VeF0d0IUvbg3qq9vZVB7M5BdvDLa377xJI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZkgW9lw9LhtweAQNVpvhJxcLTiKUd/TmTxYcmNwGno=;
 b=tPXOZRayPuXbXwYKYipnzS5/orz1Dh6YZh0oqbmviZIGR3PbrLP7sZds8U55TDtzXbV2zU7ntLPWCthobRuzqbzHbugIBiF8T8L3x3LyIbtPE+mR8VcOA88rD1dNra2h/X+pVutnid4TCG67SpdxVVOImdy78CTmC2OzFRmMCd6M9xub7V6L9qPS3Q/bE1zMMtqdZHmKnEQru5C3NZ1+QdZYhjTZoLFztF172RrJ7G0Nw/Dd3zVIXP9QzKMPstUgPfn9IL/fRi9cON92qB+wioYJLt1hd1nvrlmuSzDFqmoJ0vauUgAMjVemLChiKplTNOHGca85c2q9/pVnpH9P0g==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0494.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:28d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 18:17:47 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 18:17:47 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] net: ncsi: validate MAC and VLAN counts in Get Parameters response
Date: Sat, 12 Sep 2026 19:17:45 +0100
Message-ID:
 <AS8P251MB0001747FE185395C4303F511C8BD2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912180937.60250-1-elb12345@hotmail.co.uk>
References: <20260912180937.60250-1-elb12345@hotmail.co.uk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::9) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260912181745.61283-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0494:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5478d0-20c0-4929-f717-08df10fa25a3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|37011999003|23021999003|12121999013|25031999004|25010399006|55001999006|24021099003|41001999006|5072599009|51005399006|19110799012|8060799015|40105399003|2607281247196008|1602099012|10035399007|3412199025|4302099013|440099028|26104999009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wlTMQt/QacRI0d/pEGkfTP/xxpdTDRIonCl8kTaitW4HoCATASNiqbMEj/qb?=
 =?us-ascii?Q?mxVYqSuJjjX0eaJ7DCf6QeNTuxqCmT31GAqR0TIh9kWyLc7msKMJFgFSGTQY?=
 =?us-ascii?Q?oHAbLYn4nKehn3CwgIlEEUGaFulWDp5AGcwj9gDYwEzCkY2ZFFQfzf4mMrwk?=
 =?us-ascii?Q?P2ys4X4pGQnerMIwjJz6bKYQgJQJ7A3oMmYHqzeqGYKhgKi4AUuVoR7EJvUC?=
 =?us-ascii?Q?0Qyevxi8V4Z3eux2BU2ApM0Fm0qLHJdQmBWqLS6IJ4QIWo8ZRrxDvpV1gmUD?=
 =?us-ascii?Q?XMsddV9TTFjGVGg0+3G/V9iJ/ABUQHmR4IpGGJmGjD51VMPwMYatRk/quVHI?=
 =?us-ascii?Q?3O68cnr1h09zA4LVwHLsmHniLbeL+y1W6CxttTQQkCwhwrO425m9gtiVSK/f?=
 =?us-ascii?Q?/yqjA+iMqH4aHEeDAoSYWg26UyOat0M6Qb42dxpttPN7miokiJGZMmyX//kp?=
 =?us-ascii?Q?inFD12m/hStTAN2vxp7tur5uBs13eyEuDTmxIvuPpe2iEaZAQCq8+enb0xaV?=
 =?us-ascii?Q?+mwtpFsITls2SxrL9ur4qksr9kUAVKOlf2Ln6I4rjalWm5KMS8RHrEWSHCnO?=
 =?us-ascii?Q?9KpmFUr7s76SecgUbAlJ20+pMELyI2DMj+ExeWNVQLa6mdA1vbuPCIyKJSM7?=
 =?us-ascii?Q?qZ0TO896Ng6iDIu559WpusXmoSHx0L4ywY5eWC9+FssR3n2HVz7puh+qFGR3?=
 =?us-ascii?Q?2D09jOgIjtanW+R+nEy0maFgKoLr/muTIDxAwUNtwRCPsj4lwtKVtncSe3bq?=
 =?us-ascii?Q?E3rNnoxOtQ42h4Fj9KKgOmmkgKl6m13nXlrSEriBYxDmTdG1N0Q7KCHU4f53?=
 =?us-ascii?Q?4KknItDeUW/Y4qUR4NZ0ubNAsbF/9TzFHdydDMj1bbmRg2JCdxFoDHZK3bTr?=
 =?us-ascii?Q?Weh8N+uxo8BXFfoohMcZ7S+QbDpwo2opq9T5RGspQmSwxrihjlIlMD97WMto?=
 =?us-ascii?Q?/OcNUESJuNGMq1EPwqRF16k7YW0f8XyyL0euIT7VeCmeZJJPf5E6ghej9JnR?=
 =?us-ascii?Q?NpoOozt4W8HFaqHIcqIv+FWqOyHsvhbQIdVPVjGHwcSOY16VHP6Ni0BDiBe2?=
 =?us-ascii?Q?BMY6OY0Ud5xb7h3LDhP3RKMUzB9/TZxmVJnh81WWT9eOyhk9vPky7WZy0VDO?=
 =?us-ascii?Q?hC0+12A0NlJakc43lPYt1SUMmGhwvISjF53ZQU72nb6B40jcYFBEnWuWs+U5?=
 =?us-ascii?Q?xbfsBHfEQaaIIWaT?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LGkXd4BVSwfCO9wYoWwfma5yGK1UStTKGM6O8xOATfuAlECWz8puyTQnuiip?=
 =?us-ascii?Q?cgVXqSttqU36TH9aSZFJwKJ3jZlwa3Z5BEvSDTCrT5BJuwfiGcv6z44a/cov?=
 =?us-ascii?Q?EMaJpbSv5abLZswSdSYyuZy00U/RAAFFQyCmAvn+fhi3CcR2C2saT+pYtuvl?=
 =?us-ascii?Q?lIbDLkICYlmN2MCIPdzYcLc5vd55H3OkvtTbeoUy+cZ/vwTAXJ8EqVlGEi0o?=
 =?us-ascii?Q?7wr+gysu6oJslCoptpJa0ycEXV4CXliT5RgNSanSXm9+/vDXFC1v60rOWpzR?=
 =?us-ascii?Q?dr7a9cXddsQkyjVg2m21UucBxx3yOZxChYI0LFArYUF5IYDmW7Xp5Dv1Bc0m?=
 =?us-ascii?Q?EBrVA0eryMSxoznlqb9heR2+1aaNrnlP/tF2k+Rd5fDpfcmfljEoq/ZpE0Fn?=
 =?us-ascii?Q?B024knRVY9ZUPxIytT7yqrDgZHkZtE0UapuWEwgFTFivjkfvK/NgVwwlOSQp?=
 =?us-ascii?Q?oWJpHKw1Q3XrPbyuHuiOjc5FK5FM8O6BTHzCxFkB1LhxH//pAEAAVcIvwZyI?=
 =?us-ascii?Q?AAMe1w9MoyZYu8tEAbJc4wvUs4OTNvrWz8w0nSalm9HgBSnTCGtzWoYMPaby?=
 =?us-ascii?Q?UrokxN3cI1XGacfmhDizycJEWDGGSQWgewylv5elyS6aDgq1GZuCfX1CI7GF?=
 =?us-ascii?Q?eccR9NF/WRnOrJ2GVnVbtMM+2A6nOWo8xTeFA0d5Js9PItLqYvYobUGI5DNq?=
 =?us-ascii?Q?ASrxaHZjqZDheeavDSv3wVe94t8nI9NvQIw0FLIHJKV0PnDO9pqV9gtpl4yV?=
 =?us-ascii?Q?aoe/E0fADthCWrTqj/cPatgWHJI92s3Vo4uekQufYFbfVzBZgIJsJKC8n3NU?=
 =?us-ascii?Q?sp5HMFSokpwSLeNK6lDlURMPOqfBFOe+46leBJ04dnk3aMuk9Ig3SYnxD64z?=
 =?us-ascii?Q?oxuMMS6gclP7WZYcaHjE+2QqlSStyNSVlNxBvZNCYT/HhGNgqPWMCOiJtHsQ?=
 =?us-ascii?Q?EknKdqdv1cmP0pXW+vyWGTFvTCky9/87EORMkCy8SCmI8JXZmQULdLKq1nrs?=
 =?us-ascii?Q?K/iS5BWBpHCsFLNjeoSMplAcma4bdieNTOij7MC9f4nY6DjAIbVizUxUUT0b?=
 =?us-ascii?Q?DoAb9gJ3vshHEtEHgcp2qfnKVSPUiKiz/xefelb88fZgnm1GwBbbldDYentc?=
 =?us-ascii?Q?WAYb5+QM726RErzDdlrNDX9W7ZDxJVSrLonrGGV3Ghp9kERYvNXqvKAYVGY4?=
 =?us-ascii?Q?pViR7H42hVvoCVYg1HVTI3v95jV2xObpvINL+wRnaaS8GFp0S1dxHIto2OnR?=
 =?us-ascii?Q?xAzz1SgeBoQkvYJhN5s6SOAs4ISqUFBf0NB4hBH5pucifHDLplfS7FXmLueE?=
 =?us-ascii?Q?WrJe8QOv+GnBH/1+KAr5ouBfDLNOUbpKwVUupAOLv3Gmls5oId/dBz74ri67?=
 =?us-ascii?Q?/giI9/6pnIGhczafoVYR+cI5RqK68hWuwANKtpHArzcCb0oTJ8BKL4rC78GW?=
 =?us-ascii?Q?NfAb/s2FNL0VaxVLpwfXdYaK+1pp+zzn?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5478d0-20c0-4929-f717-08df10fa25a3
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 18:17:47.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0494

ncsi_rsp_handler_gp() walks the MAC address and VLAN filter tables using
counts taken straight from the response, without checking them against
the data the packet carries or against the filter arrays the earlier Get
Capabilities response sized.

A malformed response can therefore read past the packet, write past
mac_filter.addrs[] when mac_cnt exceeds n_uc + n_mc + n_mixed, write
past vlan_filter.vids[] when vlan_cnt exceeds n_vids, and set bits past
the u64 bitmaps that track the enabled entries - which for both filters
overwrites the array pointer stored just after the bitmap, so the same
loop iteration then writes through it.

The response is not guaranteed to be linear, so make the fixed part
available with pskb_may_pull() before the counts are read, then the
tables they claim, and take the pointer again afterwards because
pskb_may_pull() may have moved the data. Reject the response if either
count exceeds the array it indexes, the bitmap it sets bits in, or if
Get Capabilities has not run and the arrays are absent.

Fixes: 062b3e1b6d4f ("net/ncsi: Refactor MAC, VLAN filters")
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
v2:
  - use pskb_may_pull() instead of testing skb->len, in two stages: the
    fixed part before the counts are read, then the tables they claim,
    taking the pointer again afterwards (Simon)
  - also bound both counts by the width of the bitmaps they index; the
    v1 check covered only the arrays, so set_bit()/clear_bit() past the
    u64 could still overwrite the array pointer stored after it
  - correct the Fixes: tag; v1 quoted a hash that does not resolve, and
    the filter arrays came in with the refactor
  - use offsetof() for the start of the tables rather than the literal 48
  - read the counts into locals so the loops do not re-read device data
    across the pull
  - add the Assisted-by: LLM tag (Simon, Greg)
  - name the target tree in the subject
v1: https://lore.kernel.org/netdev/AS8P251MB0001E99A1865DFEC3C3A16E7C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

Compile-tested only; I have no NC-SI hardware. The OEM and GMCMA
handlers read past the header at their own device-supplied offsets and
counts and are not covered by either patch; those are separate changes.

 net/ncsi/ncsi-rsp.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index e4264a028acb..b155b2105b89 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -849,12 +849,20 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct ncsi_rsp_gp_pkt *rsp;
 	struct ncsi_channel *nc;
+	unsigned char vlan_cnt;
+	unsigned char mac_cnt;
 	unsigned short enable;
 	unsigned char *pdata;
 	unsigned long flags;
 	void *bitmap;
 	int i;
 
+	/* The fixed part of the response has to be present before any of
+	 * its fields, the table counts included, can be read.
+	 */
+	if (!pskb_may_pull(nr->rsp, offsetof(struct ncsi_rsp_gp_pkt, mac)))
+		return -EINVAL;
+
 	/* Find the channel */
 	rsp = (struct ncsi_rsp_gp_pkt *)skb_network_header(nr->rsp);
 	ncsi_find_package_and_channel(ndp, rsp->rsp.common.channel,
@@ -884,13 +892,40 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	nc->modes[NCSI_MODE_AEN].enable = 1;
 	nc->modes[NCSI_MODE_AEN].data[0] = ntohl(rsp->aen_mode);
 
+	/* Make the tables the response claims available, then take the
+	 * pointer again: pskb_may_pull() may have moved the data.
+	 */
+	mac_cnt = rsp->mac_cnt;
+	vlan_cnt = rsp->vlan_cnt;
+	if (!pskb_may_pull(nr->rsp, offsetof(struct ncsi_rsp_gp_pkt, mac) +
+				    mac_cnt * ETH_ALEN +
+				    vlan_cnt * sizeof(__be16)))
+		return -EINVAL;
+
+	rsp = (struct ncsi_rsp_gp_pkt *)skb_network_header(nr->rsp);
+
+	/* The filter tables were sized by the Get Capabilities response,
+	 * whose counts are themselves device supplied, so a larger count
+	 * here would write past them. The counts also index the bitmaps
+	 * that track which entries are enabled, so bound them by those
+	 * as well.
+	 */
+	ncmf = &nc->mac_filter;
+	ncvf = &nc->vlan_filter;
+	if (!ncmf->addrs ||
+	    mac_cnt > ncmf->n_uc + ncmf->n_mc + ncmf->n_mixed ||
+	    mac_cnt > BITS_PER_TYPE(ncmf->bitmap))
+		return -EINVAL;
+	if (!ncvf->vids || vlan_cnt > ncvf->n_vids ||
+	    vlan_cnt > BITS_PER_TYPE(ncvf->bitmap))
+		return -EINVAL;
+
 	/* MAC addresses filter table */
-	pdata = (unsigned char *)rsp + 48;
+	pdata = (unsigned char *)rsp + offsetof(struct ncsi_rsp_gp_pkt, mac);
 	enable = rsp->mac_enable;
-	ncmf = &nc->mac_filter;
 	spin_lock_irqsave(&nc->lock, flags);
 	bitmap = &ncmf->bitmap;
-	for (i = 0; i < rsp->mac_cnt; i++, pdata += 6) {
+	for (i = 0; i < mac_cnt; i++, pdata += 6) {
 		if (!(enable & (0x1 << i)))
 			clear_bit(i, bitmap);
 		else
@@ -902,10 +937,9 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 
 	/* VLAN filter table */
 	enable = ntohs(rsp->vlan_enable);
-	ncvf = &nc->vlan_filter;
 	bitmap = &ncvf->bitmap;
 	spin_lock_irqsave(&nc->lock, flags);
-	for (i = 0; i < rsp->vlan_cnt; i++, pdata += 2) {
+	for (i = 0; i < vlan_cnt; i++, pdata += 2) {
 		if (!(enable & (0x1 << i)))
 			clear_bit(i, bitmap);
 		else
-- 
2.55.0

