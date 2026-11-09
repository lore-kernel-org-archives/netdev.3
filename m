Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261194;
	b=LJ7kFpQrUwd5NRPoseP/FLys5ta5BqP7s8LAmLWgAlbk4JRne6E7KxAZ73akOmXY94Fh
	 4GzqWmhCDOAgZnI+oS19Lo0R/keZBCLzHjaOLqt25qt68SMkUco42lPujwTdRkxCrnaMc
	 s7S+rRAKGMVN735WH+FyebQlQZr/XmBR1+9SzGWInpGYyBvkok4eTQs7nydsS0uTrwYH+
	 ujDbfekER53+Z+uy07xhlU3i5ZfClKfTgNF/obivTp0uYrSvOU81RlQKCsynlT+4DhUm5
	 MwG6S8Nbb+U2MTxpB8gpEoeZLHzR80Bnx61dU9H8zDGtLrB5mjYq9SYGdwQLPEaSyaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261194;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=0Ke7eQAZpCZdUlSdEyb4HjoREhDwF5L3xJDmT+ObenI=;
	b=CwVRFzx10Wp3nmNS8F6LCcl91825erCyRfvrkH9M6YwAJNjPnTcQfhzKmFb2bxfErvz4
	 GMjVo6shkPVGe+QKrCSiKEjxFYJytv+E64iDKFfx8Sy2eQ8SjYJSQC1MhB4A5HcKL+ibA
	 79Od6xNE/Ikpv3ovwGkZeJSTm2wFSwwsWI3wdON6MqDhOelNHHUwGNqVoKLSAvpsLjNYw
	 1K5oLKlabvv3R/GMEaxAOibO4Dqgj11eBqy5Vsi6dCuXpuX1eLPmoL/Dl5W2DJP1XEX0n
	 e0EUpwNmhCSF3q8kKTfBfmYPNr/8Njh8+aarTvCX/50luzWx3HJtMnhtLIypzPcKQsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=lmJAwbTU;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB0606A326;
	Mon,  9 Nov 2026 21:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74DB0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=lmJAwbTU
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58E63A160B;
	Mon, 09 Nov 2026 22:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794261191; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0Ke7eQAZpCZdUlSdEyb4HjoREhDwF5L3xJDmT+ObenI=;
	b=lmJAwbTUPa39OyTW+/JxZL7ICCV6c+9LFj6VZTwXaBknf+N7laGJn49T9bbkJReO89pB87
	DvoZ9bBUu1DzWw/F5DHXBSzw3jUX1WHMiKnma3pqn8m3BPGQb5LJesqERkBKyoAm+fGA2s
	0Gr5atnQ6wgKA/8VmZbVh/3TP4PLxDBWix1OcQLoMJmx684CNrpx87K1qOHWyxzt9Gt7mI
	YKOhMjAvdxUIfJVoJTy1sxJvARGfOxEFpT4GyncH/ZtPk/MBRCf4yGZGeZRZ0s998u+LZ1
	FceTIquVwq3H9tE48H3EawkVAJPvGmSHZDe/ihCYcRITvlHtQ4rUO7a6bVtEtQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 09 Nov 2026 22:53:02 +0100
Subject: [PATCH net v2 2/2] net: bcmgenet: flatten frames that cannot fit
 the ring
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-nb-genet-txq-thld-net-v2-2-efd8f4be96f2@tipi-net.de>
References: <20261109-nb-genet-txq-thld-net-v2-0-efd8f4be96f2@tipi-net.de>
In-Reply-To: <20261109-nb-genet-txq-thld-net-v2-0-efd8f4be96f2@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

bcmgenet_xmit() wants one descriptor more than the frame needs. A 31
fragment frame needs 32 descriptors, so it is refused on a 32 descriptor
ring, even if the ring is empty.

As a result nothing is in flight which could wake the queue again. The
watchdog can only hand the same frame back, therefore the queue stays
stopped.

This needs CONFIG_MAX_SKB_FRAGS >= 31 and a sender which fragments that
finely, for example MSG_ZEROCOPY.

Linearize those frames instead.

Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 9049822012d13..61f5a4c2f0cd9 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2143,6 +2143,22 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	nr_frags = skb_shinfo(skb)->nr_frags;
 
+	/* The check below would always refuse this frame */
+	if (unlikely(nr_frags + 1 >= ring->size)) {
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (skb && skb_linearize(skb)) {
+			dev_kfree_skb_any(skb);
+			skb = NULL;
+		}
+		if (!skb) {
+			spin_lock(&ring->lock);
+			BCMGENET_STATS64_INC((&ring->stats64), dropped);
+			ret = NETDEV_TX_OK;
+			goto out;
+		}
+		nr_frags = 0;
+	}
+
 	spin_lock(&ring->lock);
 	if (ring->free_bds <= (nr_frags + 1)) {
 		if (!netif_tx_queue_stopped(txq))

-- 
2.53.0

