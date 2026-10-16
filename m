Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EF3A1686;
	Fri, 16 Oct 2026 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179671; cv=none; b=nZQRGogIMYQPFQPo3v1zt3x4dWW3aeRAMKW0FGlxhOeQxeDA+Bj9RYeK3iMj67W7GCL4u03ziPIg3RzHOjRko45pDvU+X04sYhItqdroc99M9PWzn5rH9bIfvpLlfgiHgrSGhM5IRvcaJNdG7rsZMMhdnc3gfJckOxyaugl9A/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179671; c=relaxed/simple;
	bh=d+OTnrc88PzEEzO/MJrVSNR+emog6i7NC0B66fW0sLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I+mX+xLq84eFYytc/QvvmtfheZDwcSg6s9GOUt3j739AxRvoLW2eo4M5W4DT38JRKm9+u+8Ohef34h3NjFSxHgUIY1EAeN9N5f12gKYjU35dkghSa6MyzexFVun5M6y+fd1+MQKxQQWODUmS1MX5d3vDblbtwO3YjYAzx/XIKv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiO3GSwp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiO3GSwp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4239DC2BCF4;
	Fri, 16 Oct 2026 19:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792179671;
	bh=d+OTnrc88PzEEzO/MJrVSNR+emog6i7NC0B66fW0sLY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=LiO3GSwpv0QtC6I1JrN0wVK+pc6AXfaHicJi26n61QePE2DVXfyJiuv+RMsBx2H6Q
	 SpMUWkI9t6OvnpWYtGaDWxhSTNyHghKqrvfbMVnCKadTOraBKPbYZ9QXaWwerdMyn4
	 sorMGhRQSx3b1AScYbNKd/gNpI/MVXyx5Jr/DoIBFUcKjAY01E5YmPzAsLzVG+QuGR
	 5dHRI9cur5UGHHmjdPceRPT/VrjvrmYqY8iLGMKJ61IOOuYa+WFmcA4gLbzO9/BNeb
	 +XEqxQ/m6u14RNVMtW8CB5rcW+gKu6A9tIgZhDe+S4D1KB5JoVn5Z7kbDQkhOCSDDC
	 legwS7W398PPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAECCCF2C2;
	Fri, 16 Oct 2026 19:41:11 +0000 (UTC)
From: alex todadze via B4 Relay <devnull+todadzealexi19.proton.me@kernel.org>
Date: Fri, 16 Oct 2026 19:40:28 +0000
Subject: [PATCH net] net: stmmac: fix rx checksum offload with extended
 descriptors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-stmmac-rx-csum-v1-1-986342ec40df@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6W8cxeaBqP4K9JDjFtdIalk01Io/
 XdTPc7AzAblLKy4NhsyL6IypQqmbRBePj2Z5FEZfdc70xlHWmL0gfJKQedIzjpv7Xg5ndmjRp/
 Mo6y/4Q2JC4a/1Pn+5lCOFfb9C3s5FfR3AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792179669; l=6604;
 i=todadzealexi19@proton.me; s=20261016; h=from:subject:message-id;
 bh=14jA977WtCT5IUsuAjwlQ5pv0h0Z3gG4xUUw3unqDZs=;
 b=eCaOR4JAjZ4DQofNJSQF0/MPYnV6II0DsWU2qs66Huum1f5zQ264OMo409LaOYvUnCIxthZix
 odHHUE2SqDPDE5qyjHrujQCpOEGphVbFIXt3d+FouUA1peEjZENwcps
X-Developer-Key: i=todadzealexi19@proton.me; a=ed25519;
 pk=j+Ld51xwndyrS6RE9s1B4vZjwvTeSSbcKp/mOdWy9PE=
X-Endpoint-Received: by B4 Relay for todadzealexi19@proton.me/20261016 with
 auth_id=1216
X-Original-From: alex todadze <todadzealexi19@proton.me>
Reply-To: todadzealexi19@proton.me

From: alex todadze <todadzealexi19@proton.me>

With extended descriptors, bit 0 of RDES0 is the Extended Status
Available flag. enh_desc_get_rx_status() still reads it as the payload
checksum error bit of the checksum offload table, so every IP frame that
has extended status is reported as csum_none and its checksum is
verified again in software.

When extended status is available, take the result from RDES4 instead.
A TCP, UDP or ICMP payload with no IP header error, no payload error and
no checksum bypass is a good frame. Everything else keeps the status
from RDES0. While at it, fix the IP payload type mask, which covered
bits 6:2 instead of 2:0 and had no users.

Tested on a Siflower SF19A2890 (GMAC 3.70) with the board as the iperf3
endpoint. TCP receive goes from 326 to 378 Mbit/s with one stream and
from 259 to 329 Mbit/s with four, and CPU use while receiving 200 Mbit/s
drops from 26.6% to 21.5%. Frames with a bad TCP, UDP or ICMP checksum,
over IPv4 and IPv6 and including fragmented UDP, are still dropped.

Fixes: c24602ef8664 ("stmmac: support extend descriptors")
Signed-off-by: alex todadze <todadzealexi19@proton.me>
---
 drivers/net/ethernet/stmicro/stmmac/descs.h       |  6 +++++-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    | 26 +++++++++++++++++++++--
 drivers/net/ethernet/stmicro/stmmac/hwif.h        |  6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  9 +++++---
 4 files changed, 38 insertions(+), 9 deletions(-)

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
index 051253601..7620246f6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -109,8 +109,26 @@ static int enh_desc_coe_rdes0(int ipc_err, int type, int payload_err)
 	return ret;
 }
 
-static void enh_desc_get_ext_status(struct stmmac_extra_stats *x,
-				    struct dma_extended_desc *p)
+static int enh_desc_ext_rx_csum(u32 rdes0, u32 rdes4, int status)
+{
+	u32 type = FIELD_GET(ERDES4_IP_PAYLOAD_TYPE_MASK, rdes4);
+
+	if (status != csum_none || !(rdes0 & RDES0_FRAME_TYPE) ||
+	    (rdes0 & RDES0_IPC_CSUM_ERROR))
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
@@ -170,7 +188,11 @@ static void enh_desc_get_ext_status(struct stmmac_extra_stats *x,
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
index b837e8e27..efedd0504 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5605,8 +5605,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 			break;
 
 		if (priv->extend_desc)
-			stmmac_rx_extended_status(priv, &priv->xstats,
-						  rx_q->dma_erx + entry);
+			status = stmmac_rx_extended_status(priv, &priv->xstats,
+							   rx_q->dma_erx + entry,
+							   status);
 		if (unlikely(status == discard_frame)) {
 			xsk_buff_free(buf->xdp);
 			buf->xdp = NULL;
@@ -5788,7 +5789,9 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		prefetch(np);
 
 		if (priv->extend_desc)
-			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
+			status = stmmac_rx_extended_status(priv, &priv->xstats,
+							   rx_q->dma_erx + entry,
+							   status);
 		if (unlikely(status == discard_frame)) {
 			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
 			buf->page = NULL;

---
base-commit: 191aa41548b2d2b6af534a6d5cf84a552435c74c
change-id: 20261016-stmmac-rx-csum-636a33f857ea

Best regards,
--  
alex todadze <todadzealexi19@proton.me>


