Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792536146;
	b=BzH0eY9rfbTwBj3BSZNcpMl8zRoCOdISdR6NFK/BrcwF0UFel4qpbN+SuUHDOQD+9OVd
	 ghMCWqBVrhsZRlZ+gOe9ZJ/3rSAsIh6GfY7+zzwKBnQbANmd00xoJCyS8uB1fKZ+06Gqz
	 TwZqfkESQVXqn7ocv0iDD4Wv01ip5C/j8y8wMm7ARZWrnSven+5qRju3NAYFZqcl6x+3H
	 cSihtXkr0Enok2+1wvsZW05tVpGbNxsf3RAI0Hej0aK7ekDyag4/SrL6BbcxMKz6Doc8+
	 977C7RVmpCRWQeUD/XG6pfkNEERgmJ8GM8bM7zpuf5rdXSsE6RI+6YuTh9sUc5Qh8+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536146;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=f9DiGrbhappTB/KOs9+ECctUN+MOwQSxuYwJ3lZY5eM=;
	b=pOTmwXFXwurXShSpJ0M6tBpie8Tz9GwwTvWjYO5wTHA/2GoO/r8aNfzaqt/oTcofzrqi
	 E1PmRWXEJPYQe3DRUx4CeWPBGjeN97Jat8hyegPfSR1kjAaI4+/XJetRA+g4S5YvlD1X2
	 DWFF6LEy+RFQXqbtp/maSkIA93J2IUGRBOuyLNkYrH6fB81FPDATNj0aX7FIYtJmJKlfk
	 DH4ZS9MrxQWp9Xq5SH4yiA8LigDKy79pRmdOKKu8uzOSBcrtwt/16m6O0lm30NtffiQvm
	 V5qfkL8OuRvGTn2QG+ETTg4NIz/8i14wnAk1LnwJ4+L9wCejwlxz3Q8mHSU9QkhYrsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5ibvlQZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D078606A319;
	Tue, 20 Oct 2026 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5ibvlQZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792536146;
	b=Yr+iO6Om4Vv2wUykLjhf1QL0ZPtNYKe81LoYZ6gmd/VkR75McIR55C7D9gLLOWhGKYkr
	 y3oyYbbycLFBiA2/uacxqipF4j0I/c48INuYNCsG4525X5uf/jkdsLf+OfPDM/e/Lfobl
	 JLvYy7i5BMOEZx3TZdx+ngsE8p7TC6SM3Xo21W8rltTMpflllFVXjqdcI1cBVJCGC9oFV
	 BWQPA733z92ySD7I4W/J1L+8rYkJQ4uEoLnZ6U45nGLvVZ4jLvdlcqzw1AXGbX0NoceO3
	 wllNHYjnKb4DY5hQ9AvVIiA5cwplPKm6jgZySVkpJvQBp3FFZ10a4bEOP8lwci/VKPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792536146;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=f9DiGrbhappTB/KOs9+ECctUN+MOwQSxuYwJ3lZY5eM=;
	b=paiLAwkW6FLvTweaCDziRu0O4mn0rsgKe93C0k8xu7QrHz7VCpknMXzbeYIp7CRNTV6r
	 Fj/oowwDGjpQcimKVYAUNPe8Cfxd++7KUShHwT+zOVBbIumPuJvaVszVunsHC88YrZ5dh
	 +miZIW6pMH+0SqFjabJyqcUQyaWaQKrE4MNKnMcKoFmCHAX+4phBuo9XEymYDBlSIhSan
	 8R4ZPB59fuIeY05kou+o81834RPOBgkquRUH/KAAk0PiW5pIpGXgvXhO4h8KUskFhb5GV
	 WxwTsny2Y1lMVgmhId8H+cwcoyV6ee3ED1yBrzvNOx7hXD+3PNc+022XYceAN+VB1SA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 50BAC1F000CA;
	Tue, 20 Oct 2026 22:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792536146;
	bh=f9DiGrbhappTB/KOs9+ECctUN+MOwQSxuYwJ3lZY5eM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=b5ibvlQZ7dSnyfYgS7qi84EnH/q1jvdAg91Dcf3GNKWOipfjwCktTDbkyT3gNhI2T
	 cyfC8tfRJK8Oa4j0MW5dkPPd5+KNhR1zh9ZQ6blEUS0areHDVc0rQ9+AneT0vnp/bc
	 4GZPknigA8xF/vKiY36wN1D15UtmN89Ds5YXn5f9+2GPqffHAEgDM0B5WzzoDWDD3d
	 nP9pgjY+xGtiqoMwnxZMCX3zX9Zp8F62vNykLiyOMGtEBwojjXKuZruUYzOni95Gya
	 ESb1uHWwB9ZKwhfjwauaS1wOPPx5xrlAn7KfP7bsl3yRnFrSOFWankHfVa9a6LOyTw
	 7jmQgQv9+sFFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A39084320B;
	Tue, 20 Oct 2026 22:42:24 +0000 (UTC)
From: alex todadze via B4 Relay <devnull+todadzealexi19.proton.me@kernel.org>
Date: Tue, 20 Oct 2026 22:42:24 +0000
Subject: [PATCH net v2] net: stmmac: fix rx checksum offload with extended
 descriptors
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-stmmac-rx-csum-v2-1-330c8d0951ea@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf8Xs2TW0xYqe/A/DoZZFatKWdAvBE
 P5dwLPHmbx5MwNTcsRwO8yQaHTsYliDPB7Adia8CF2zZpCF1KIQGjl7byymCS0PHrXSRqm2Ol/
 IwDrqE7Vu2oUPCJSh/pU8PN9k86basM5xjumz345ih/89jAIFXiutSkm2LJr23qeYYzh5gnpZl
 i9mn7rYwwAAAA==
X-Change-ID: 20261016-stmmac-rx-csum-636a33f857ea
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 alex todadze <todadzealexi19@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792536143; l=7765;
 i=todadzealexi19@proton.me; s=20261016; h=from:subject:message-id;
 bh=005DGWjRmMY4f+bx+12CFajZHePOk6TxnwqxfHB7YTw=;
 b=UAChc2hEaFVH4vYixoIkNKudow0Ni+zTub9K9cQRAmKFfG6/y/4OsHQZjWws60MA+6uDguXcg
 V2nKMNfQ9cOCYFQfnHDhh9hs9C6rwDp6NWBw3ZsqPt5iFX8NbnfLgZG
X-Developer-Key: i=todadzealexi19@proton.me; a=ed25519;
 pk=j+Ld51xwndyrS6RE9s1B4vZjwvTeSSbcKp/mOdWy9PE=
X-Endpoint-Received: by B4 Relay for todadzealexi19@proton.me/20261016 with
 auth_id=1216
X-Original-From: alex todadze <todadzealexi19@proton.me>
Reply-To: todadzealexi19@proton.me
Content-Transfer-Encoding: 7bit

From: alex todadze <todadzealexi19@proton.me>

With extended descriptors, bit 0 of RDES0 is the Extended Status
Available flag. enh_desc_get_rx_status() still reads it as the payload
checksum error bit of the checksum offload table, so every IP frame that
has extended status is reported as csum_none and its checksum is
verified again in software.

When extended status is available, take the result from RDES4 instead.
A TCP, UDP or ICMP payload with no IP header error, no payload error and
no checksum bypass is a good frame. Everything else keeps the status
from RDES0. Since RDES4 now decides the checksum status, read it after
the own bit with dma_rmb(). While at it, fix the IP payload type mask,
which covered bits 6:2 instead of 2:0 and had no users.

Tested on a Siflower SF19A2890 (GMAC 3.70) with the board as the iperf3
endpoint. TCP receive goes from 326 to 378 Mbit/s with one stream and
from 259 to 329 Mbit/s with four, and CPU use while receiving 200 Mbit/s
drops from 26.6% to 21.5%. In stmmac_rx(), frames with a bad TCP, UDP or
ICMP checksum, over IPv4 and IPv6 and including fragmented UDP, are
still passed up as CHECKSUM_NONE and dropped by the stack.

Fixes: c24602ef8664 ("stmmac: support extend descriptors")
Signed-off-by: alex todadze <todadzealexi19@proton.me>
---
Changes in v2:
- Drop the RDES0 bit 7 check. With advanced timestamping, bit 7 is
  Timestamp Available, and ERDES4_IP_HDR_ERR already reports IP header
  errors.
- Read the extended status after the own bit with dma_rmb().
- Say in the commit message that the bad checksum result applies to
  stmmac_rx(). stmmac_rx_zc() ignoring csum_none predates this patch,
  and I will send a separate fix for it.
- Wrap the lines over 80 columns.
- Not changed: bit 0 still reaches enh_desc_coe_rdes0(), so 802.3
  frames with Extended Status Available set can be discarded. That
  predates this patch and depends on when the GMAC sets the flag, so I
  would rather test it on hardware and fix it separately.
- Link to v1: https://patch.msgid.link/20261016-stmmac-rx-csum-v1-1-986342ec40df@proton.me
---
 drivers/net/ethernet/stmicro/stmmac/descs.h       |  6 +++++-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    | 25 +++++++++++++++++++++--
 drivers/net/ethernet/stmicro/stmmac/hwif.h        |  6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 19 ++++++++++++-----
 4 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/descs.h b/drivers/net/ethernet/stmicro/stmmac/descs.h
index 846007cc2..0af819a98 100644
--- a/drivers/net/ethernet/stmicro/stmmac/descs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/descs.h
@@ -116,7 +116,7 @@
 #define	ETDES1_BUFFER2_SIZE_MASK	GENMASK(28, 16)
 
 /* Extended Receive descriptor definitions */
-#define	ERDES4_IP_PAYLOAD_TYPE_MASK	GENMASK(6, 2)
+#define	ERDES4_IP_PAYLOAD_TYPE_MASK	GENMASK(2, 0)
 #define	ERDES4_IP_HDR_ERR		BIT(3)
 #define	ERDES4_IP_PAYLOAD_ERR		BIT(4)
 #define	ERDES4_IP_CSUM_BYPASSED		BIT(5)
@@ -147,6 +147,10 @@
 #define RDES_PTP_SIGNALING		0xa
 #define RDES_PTP_PKT_RESERVED_TYPE	0xf
 
+#define RDES_EXT_PAYLOAD_UDP		0x1
+#define RDES_EXT_PAYLOAD_TCP		0x2
+#define RDES_EXT_PAYLOAD_ICMP		0x3
+
 /* Basic descriptor structure for normal and alternate descriptors */
 struct dma_desc {
 	__le32 des0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 051253601..023b54b72 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -109,8 +109,25 @@ static int enh_desc_coe_rdes0(int ipc_err, int type, int payload_err)
 	return ret;
 }
 
-static void enh_desc_get_ext_status(struct stmmac_extra_stats *x,
-				    struct dma_extended_desc *p)
+static int enh_desc_ext_rx_csum(u32 rdes0, u32 rdes4, int status)
+{
+	u32 type = FIELD_GET(ERDES4_IP_PAYLOAD_TYPE_MASK, rdes4);
+
+	if (status != csum_none || !(rdes0 & RDES0_FRAME_TYPE))
+		return status;
+	if (!(rdes4 & (ERDES4_IPV4_PKT_RCVD | ERDES4_IPV6_PKT_RCVD)) ||
+	    (rdes4 & (ERDES4_IP_HDR_ERR | ERDES4_IP_PAYLOAD_ERR |
+		      ERDES4_IP_CSUM_BYPASSED)))
+		return status;
+	if (type != RDES_EXT_PAYLOAD_UDP && type != RDES_EXT_PAYLOAD_TCP &&
+	    type != RDES_EXT_PAYLOAD_ICMP)
+		return status;
+
+	return good_frame;
+}
+
+static int enh_desc_get_ext_status(struct stmmac_extra_stats *x,
+				   struct dma_extended_desc *p, int status)
 {
 	u32 rdes0 = le32_to_cpu(p->basic.des0);
 	u32 rdes4 = le32_to_cpu(p->des4);
@@ -170,7 +187,11 @@ static void enh_desc_get_ext_status(struct stmmac_extra_stats *x,
 			x->l4_filter_match++;
 		if (rdes4 & ERDES4_L3_L4_FILT_NO_MATCH_MASK)
 			x->l3_l4_filter_no_match++;
+
+		status = enh_desc_ext_rx_csum(rdes0, rdes4, status);
 	}
+
+	return status;
 }
 
 static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 5e2654c91..9925b789b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -70,8 +70,8 @@ struct stmmac_desc_ops {
 	/* Return the reception status looking at the RDES1 */
 	int (*rx_status)(struct stmmac_extra_stats *x,
 			 struct dma_desc *p);
-	void (*rx_extended_status)(struct stmmac_extra_stats *x,
-				   struct dma_extended_desc *p);
+	int (*rx_extended_status)(struct stmmac_extra_stats *x,
+				  struct dma_extended_desc *p, int status);
 	/* Set tx timestamp enable bit */
 	void (*enable_tx_timestamp) (struct dma_desc *p);
 	/* get tx timestamp status */
@@ -128,7 +128,7 @@ struct stmmac_desc_ops {
 #define stmmac_rx_status(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, rx_status, __args)
 #define stmmac_rx_extended_status(__priv, __args...) \
-	stmmac_do_void_callback(__priv, desc, rx_extended_status, __args)
+	stmmac_do_callback(__priv, desc, rx_extended_status, __args)
 #define stmmac_enable_tx_timestamp(__priv, __args...) \
 	stmmac_do_void_callback(__priv, desc, enable_tx_timestamp, __args)
 #define stmmac_get_tx_timestamp_status(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b837e8e27..e733bfd80 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5604,9 +5604,13 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (!buf->xdp)
 			break;
 
-		if (priv->extend_desc)
-			stmmac_rx_extended_status(priv, &priv->xstats,
-						  rx_q->dma_erx + entry);
+		if (priv->extend_desc) {
+			/* Read the extended status after the own bit */
+			dma_rmb();
+			status = stmmac_rx_extended_status(priv, &priv->xstats,
+							   &rx_q->dma_erx[entry],
+							   status);
+		}
 		if (unlikely(status == discard_frame)) {
 			xsk_buff_free(buf->xdp);
 			buf->xdp = NULL;
@@ -5787,8 +5791,13 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		prefetch(np);
 
-		if (priv->extend_desc)
-			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
+		if (priv->extend_desc) {
+			/* Read the extended status after the own bit */
+			dma_rmb();
+			status = stmmac_rx_extended_status(priv, &priv->xstats,
+							   &rx_q->dma_erx[entry],
+							   status);
+		}
 		if (unlikely(status == discard_frame)) {
 			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
 			buf->page = NULL;

---
base-commit: 191aa41548b2d2b6af534a6d5cf84a552435c74c
change-id: 20261016-stmmac-rx-csum-636a33f857ea

Best regards,
--  
alex todadze <todadzealexi19@proton.me>


