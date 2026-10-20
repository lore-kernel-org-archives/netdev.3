Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523005;
	b=h8jop9T3QlOobAQXUuN6bRIFapzs2GTmwX+7drLtt/oaa1JkE67rBIl5QJDYrnn6DKis
	 nHUumJlVjEhOl88HsVxdZptlDAyXGvdB6xKKFekbDca/yQGDXtAG7M3PymW/cpRa5fETE
	 a7oQPWfTaF8wBgRozYHJrRtVcXGvdJPPVsk5sD/x63788uHVvQikykOk/BEcvRS0RmC0x
	 3ndNOA96X/dhVO0HmibSgZ2TG/6gFZlSRl/juPuEkZexWizfIVXIySTXBIlrecJCGWU9a
	 Wj/Bwna1HrHdpWNttXBUdoxYt/S37nM59/LNCtt5aqJpyw0ovwiGSiz1nBM1bX0TE0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523005;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XW2XawDSDFkTSk897IfBcZxxEG8qyMFEO8Acjxpagfo=;
	b=i9fC39nC8P0lAuRJjljLhzEqeEy8dhQ8CyHuSltzvOFxnkktNyY1z8x2gFdu0Zhgv4P5
	 XLm2Plfpjf74fMXwOBb8sYR1NiWjEuCi7NiLP7Ua1qCwl9v4R8U1kaXiBmKGLdl3vVUIe
	 qC/tWiV+56D16L0BfY63hBtdmvI624B8jjbyPsTQMlytOJbIqwcRoJpykIi1RABmwbdDn
	 hvLtdrUZfLBFD41l4f/1eS7xKMns2fzWbOQZtGI1kAR3nvg69nI8M+x+gXmUB96LQIPRD
	 Hfh13gvYwXbJ3ZYeTSz57ZPETUM8p20VrwYBjV3b7yp8w7Ys5Jbls+uxdsy2WBRUCzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD59606A329
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBD59606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1921704f8f.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523003; x=1793127803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XW2XawDSDFkTSk897IfBcZxxEG8qyMFEO8Acjxpagfo=;
        b=2E4nVZmCTAwfNC3tLGYS9B22NiVFDh8QpbXV9VGmTD7MzQYUnFI9rDPGjg0/m8Oz0Y
         A4RXTGg07J2OQ+nX7Awd1TG1yGUuzqgalGwFMF9QKKC846udLgT/FygEMeWofF15sK93
         eNyke4G7q+YlQj41daVe1yEEh9+JxWPCZY3DJh85t+XfTMgqjBmgB7m/AaZWXA+f4jAO
         KqZpCkyKc3fAoZop9j8yrU6NbHRNOU/Og76or0DMWnSBNfuuAfVNjPRC7v/rOe7akBBY
         Bws/a50RkOdWAYKZBzzJScuJp1pscNsEdH8UwR/dz2G4pG6JI4s1CxtQV/l+E99UepJm
         VN2g==
X-Gm-Message-State: AFq9FYLDRlBm2Uz0i0+HConDcttFuFKiHW6MWtFDIMKoDDsnOE4M4lf5
	khINciNLN1suV13sMEdELj9Z6yYG5teSQ9gDYNrlWcCG51vC+zpX4Au23eOu2OQ3sgE0q7HnWeH
	ZmO/M5WOD0Q==
X-Gm-Gg: AYBFou1nNrEiyna7Mr3hWZE+YpvQlQc7mniMuZfzsbynfJbdu9bkxK6Oz9FFNBdgsiH
	YSk4OCOO2MFzbctRxkbRAWbYbRkDa4M52vhXhyBtEngUO4xsQmcArzhZjk8FEpJWMsRx1gpv/oq
	eIATXB+HlULlOCCf72iXGc8BIwdWvH0uxnUc3dZBvgLGRMBhGt2uhQZWreahoQ/EcUiYp6bf9cz
	yTWM7aulzWDRGFfyzmQAeQiH9idtIgbmOx15xcQWv30gOvzDAXtnx6y1/ulCr5F8OS4HPt4k0ra
	O0Ec8Ub5dnCZhcOqeB6GPYSEh+hk4ipR5xYw6pz6tlBJS84ECHaWHkJ7xgg9WpRDwfDZ7pKoCeT
	RY3NUV4ABNqPNUt0OdkDxjFpv4YznPezyqCPE+UgytH3Ds2F6DLostiFqD9JXxMSGgaaIBhth4E
	TtPoTUzbOZf9c6XIeQx5sjQjRoPAtipjkqBQPKc3cNX8gglwiBDoyIyMZquCO3A8PhDRLe
X-Received: by 2002:a05:6000:1ac9:b0:488:8bc1:a2eb with SMTP id ffacd0b85a97d-48e07f99197mr25786391f8f.39.1792523003036;
        Tue, 20 Oct 2026 12:03:23 -0700 (PDT)
Received: from lake ([2a02:810d:d09:1b65:a3ee:29e0:454d:c31e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cbfsm279157f8f.23.2026.10.20.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:03:22 -0700 (PDT)
From: Grische <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Grische <opensource@grische.xyz>,
	stable@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 1/3] net: stmmac: honour Rx checksum errors in the AF_XDP zero-copy path
Date: Tue, 20 Oct 2026 21:03:16 +0200
Message-ID: <20261020190319.884375-2-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020190319.884375-1-opensource@grische.xyz>
References: <20261020190319.884375-1-opensource@grische.xyz>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ee0aace5f844 ("net: stmmac: Correctly handle Rx checksum offload
errors") taught stmmac_rx() to honour the csum_none status, but
stmmac_dispatch_skb_zc() still ignores it and sets CHECKSUM_UNNECESSARY
for every IP frame whenever the checksum offload engine (CoE) is
enabled.

Since commit fe4042797651 ("net: stmmac: dwmac4: stop hardware from
dropping checksum-error packets") dwmac4 delivers such frames instead of
dropping them, so this path receives them.

Mark the skb CHECKSUM_NONE when csum_none is set, as stmmac_rx() does.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Cc: <stable@vger.kernel.org>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Grische <opensource@grische.xyz>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9741f97fa37a..32810f949245 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5463,7 +5463,7 @@ static struct sk_buff *stmmac_construct_skb_zc(struct stmmac_channel *ch,
 
 static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 				   struct dma_desc *p, struct dma_desc *np,
-				   struct xdp_buff *xdp)
+				   struct xdp_buff *xdp, int status)
 {
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
@@ -5488,7 +5488,8 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 		stmmac_rx_vlan(priv->dev, skb);
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
-	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
+	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
+	    (status & csum_none))
 		skb_checksum_none_assert(skb);
 	else
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -5698,7 +5699,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 		switch (res) {
 		case STMMAC_XDP_PASS:
-			stmmac_dispatch_skb_zc(priv, queue, p, np, buf->xdp);
+			stmmac_dispatch_skb_zc(priv, queue, p, np, buf->xdp,
+					       status);
 			xsk_buff_free(buf->xdp);
 			break;
 		case STMMAC_XDP_CONSUMED:
-- 
2.54.0

