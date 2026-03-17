Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27737F744
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728540; cv=none; b=Rjyk4NNYI2Kerjq4298P9ZtibOBQcqNo1st0nME77jjImTjZs0NIpqP+sgMf0JVuT+aZU58d3hZmTNXQFVppbL8YGKzPyH3a81B23ASkiPZf3qU4W6k3G+KezISr3WID8cQdYjzGGN7yhHE+IUfalPNFFlY7XXuk/6OXPNH3QRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728540; c=relaxed/simple;
	bh=rBYJQmkgsKaSv613RrkdKVJsLZP+8bywc9OZhFEU9dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DS9+9yj5ltWISwtJYIpt2lUiiKsUwXZL1pJSgqcb0Ra+Eymj5tH2mN6nH14IpfJHDv4P4yyG0oUiIbDaEkbe2pzFX7NshVIgnI6ENPIeblB1ZUAvp2quyiQCkXTm3js+iWDUyd9gp8h0xTh050yx1KjPrL0GMo1bRMgO0pqpn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=naFxhx57; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="naFxhx57"
Received: from ms-a2 (16.4.31.150.dy.iij4u.or.jp [150.31.4.16])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62H6MBPV068957
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 17 Mar 2026 15:22:11 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=FSGEy83Ejkug+FTTykT/GYOYqYSI90bywuoJAtinwXs=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773728532; v=1;
        b=naFxhx571U3+TZ4vOApOb3aP/gHwlhPXLNOiF02sU0376595d9Mnd93qitlYL+QA
         2Zrxmz+FB24w/waeqCRV5EqZY88RhK6AK607jBDe8+wY5kmf33ySX4LDtvKdeBTg
         czheDR4m62aqNPB+kyOo1JS3aLuFXbwpski5HEwx23xZohbEfYiHVt6tgtQSrhYu
         6CO2fTOBe0zgCDHN/D7LmIkB0jjYaClSK97CFfkGB994kMKDbdF3fRkW0uokbkK5
         NkiePoxVCcImcnlQfL9Q/gR/u6ThxqgBww8fyjYhp0ai0w5LgNqK6+UoNoh+/5A1
         CstwXAic7Alo3VcUGftqlg==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, dima.ruinskiy@intel.com,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 1/2] igc: set RX hardware timestamps in igc_build_skb()
Date: Tue, 17 Mar 2026 06:21:45 +0000
Message-ID: <20260317062205.39406-2-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317062205.39406-1-kohei@enjuk.jp>
References: <20260317062205.39406-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

igc_construct_skb() sets RX hardware timestamps, but igc_build_skb()
does not. This has not been observable so far since igc currently does
not enable the build_skb RX path.

Set RX hardware timestamps in igc_build_skb() as well so that both skb
construction paths provide the same behavior.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index cad5a26cc84d..79192b02e6be 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1964,8 +1964,9 @@ static void igc_add_rx_frag(struct igc_ring *rx_ring,
 
 static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
 				     struct igc_rx_buffer *rx_buffer,
-				     struct xdp_buff *xdp)
+				     struct igc_xdp_buff *ctx)
 {
+	struct xdp_buff *xdp = &ctx->xdp;
 	unsigned int size = xdp->data_end - xdp->data;
 	unsigned int truesize = igc_get_rx_frame_truesize(rx_ring, size);
 	unsigned int metasize = xdp->data - xdp->data_meta;
@@ -1979,6 +1980,11 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
 	if (unlikely(!skb))
 		return NULL;
 
+	if (ctx->rx_ts) {
+		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
+		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
+	}
+
 	/* update pointers within the skb to store the data */
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	__skb_put(skb, size);
@@ -2681,7 +2687,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		} else if (skb)
 			igc_add_rx_frag(rx_ring, rx_buffer, skb, size);
 		else if (ring_uses_build_skb(rx_ring))
-			skb = igc_build_skb(rx_ring, rx_buffer, &ctx.xdp);
+			skb = igc_build_skb(rx_ring, rx_buffer, &ctx);
 		else
 			skb = igc_construct_skb(rx_ring, rx_buffer, &ctx);
 
-- 
2.51.0

