Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279101;
	b=NLRFt35hUlnuyiPSRUmJJrLKhgn+i4ZG3SjEJ11B2TCdQALUexQwkoEye9OwOAfIdpyb
	 JIN9GNkg5h++Ux5hipyZgRWG0AgZxa6Cm0lmbHDuISKNBEowxhyro39zywc273HwHtqR1
	 hQS8RKfgsDsoiZeASvbfoYXEYpiHgK8mzpbGTHomWhoXL+e3gN5B14AdgHHdcPZkRdRSF
	 q7JzGvDU5sVtvfTmRvSDIf8s939yow5ZqTEPY2e8xtJnfLRy7bvpNe7yPudwy7WzFrp8R
	 K27Da6KrdUo2BbPFjhkhwdsyj/rk8rYybhzOh/ypuI96ZMSAcEZYofKzv+8m5Mw1OGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279101;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qGjIyYvqmOXuaLsYeaNO64qZ2nR91HUnsf+WtkJEZ90=;
	b=1pqfnrCF8lC8V2HMn1DUiJSZd/BRs6LOr8lFMgtgh/MxPapnb+boQ2RV4sGYtYsFt9E8
	 ha7xVpZh9sEEvRexX8Y6Or+SxBXBH3jGszz30OavgPQug4cE+D/5lacRSYBWFiaqZGtKL
	 KWMjAxIDrEOOe7fqMZddUCimU+S6AR+NqttlWuuhmeOmPrwRAkHOk/t8Wjz17XDlp/zdc
	 MzWcOmWSIgfnCd9FmZIF07Nb4CU8I6IdcpNEvelx8JS35ELzAku1o9hYra0dzwGZ4/Z5b
	 T8biMwHNYfqyhP+w20wpUP2Skvsy5nB832Hk6CixUCjGYJDvSwmG8GuhjwqP+gAqxlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=nn17Kgjh;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15350606A32A;
	Tue, 10 Nov 2026 02:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15350606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=nn17Kgjh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794279090; bh=qGjIyYvqmOXuaLsYeaNO64qZ2nR91HUnsf+WtkJEZ90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nn17Kgjh4qShwo/G5UXeBbB5IFCT+kgbaUwh5oplz71FWxY3vqutQzS+q0zrqNG8q
	 EkVJRvahDbsSCs41NRXxR6JU7+zhJyLbOeiAXhq8coIyVFLOw4jKIvx+oPklrRCCBj
	 84rZgeBOAxEew9TvdnxrdxkrqfWzIxcmCglm5ZAzqdAiRNduSpK7EFKlb3+ChdlPdi
	 qg6kAVSo+nId9hbyZpCa90UBPUhckrSMccZQIoNIbx68ahV4/qIJWJUZo41jbCdA1b
	 5PKcrKf/bwM9BfECzPYDQvyNA1YPtPl+tK6ovxwxdSSNKM4Yqt0CiohIC/138Ipo3v
	 QoYuUHCEL+wAA==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 4B2C727A37D0;
	Tue, 10 Nov 2026 04:51:30 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Mason Chang <mason-cw.chang@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/3] net: ethernet: mtk_eth_soc: skip page_pool
Date: Tue, 10 Nov 2026 01:46:33 +0200
Message-Id: <patch-26bcfbd477a24c2d21f0549fb34219b6@loljews.com>
In-Reply-To: <patch-fc08a7ef40667bf3017366e452e6d3c0@loljews.com>
References: <patch-fc08a7ef40667bf3017366e452e6d3c0@loljews.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The page_pool is created with order-0 pages and MTK_PP_MAX_BUF_SIZE as
the maximum DMA length, so it can only back a ring whose descriptor
length fits in that.

Gate the pool on ring->buf_size <= MTK_PP_MAX_BUF_SIZE and let larger
rings use the netdev_alloc_frag()/mtk_max_buf_alloc() path that already
exists.  ring->frag_size cannot serve as the limit: it follows the
netdev_alloc_frag() layout, whose headroom and skb_shared_info footprint
differ from the pool's, so a ring can have frag_size <= PAGE_SIZE while
its descriptor length is already larger than the pool can map.

With the current MTU limits every ring fits and the gate always passes;
it becomes active with the 9K jumbo support that follows, when the
shared rings grow past the limit.

Link: https://github.com/mediatek/mtk-openwrt-feeds
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index a46cf5441..6768ab8eb 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2825,7 +2825,13 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (!ring->data)
 		return -ENOMEM;
 
-	if (mtk_page_pool_enabled(eth)) {
+	/* A page_pool hands out order-0 pages and is created with
+	 * MTK_PP_MAX_BUF_SIZE, so it can only back a ring whose descriptor
+	 * length fits.  Larger rings use the netdev_alloc_frag()/
+	 * mtk_max_buf_alloc() path below instead.
+	 */
+	if (mtk_page_pool_enabled(eth) &&
+	    ring->buf_size <= MTK_PP_MAX_BUF_SIZE) {
 		struct page_pool *pp;
 
 		pp = mtk_create_page_pool(eth, &ring->xdp_q, ring_no,
-- 
2.53.0

