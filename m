Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E688933CE80
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111682; cv=none; b=WuSDs0VOyQqisEInqqAJt+xgDbChJGcnhDcS2W63W/fSZamjXBmq6DhUrATjzdjLrG3N/ZF1SW+FmunYugokHk+r10Jlhqwxmlsl9CllBYlFsFDiHf+1tbarDkI0fHGK6NhjwAM3PCyupiudTpO8v5nt9LWhiNBIoTH2zmMzru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111682; c=relaxed/simple;
	bh=6ck7GW7JTZkGApm0lDedydnZ+9IMBNxhLrjVRuo1dq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+phgk/fPma/bzSnGw5ecIYY1eX2ZB4Eux74yIOWwYVvZyCAYz54+vvjASlUG3Imn62IwPgREnTE7gwlHVswehKs2oncYCK0kQEgstO95ydWaeM0COmCZKHbTl5OfkiElPT0XC09OwktjzeGlNco0e3+7FKAe2rUL0ieJqkyWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBtWHMqi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBtWHMqi"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f502ff678so413925f8f.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786111678; x=1786716478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oE7F4Cq3TaG660Axwa91NtG4j0CcMsIY14xd/BazRYE=;
        b=XBtWHMqiTUSwLEC0zn94yBwoAb1Gr+xZCg9+43CiaRKXAuTBvRYcp7eMSQ4qA6Xx2P
         Hc986h43/hiyhP7PLM9u+n836zIi9D3ehZK07Qxx3NLldEwcUGFXXcg6S2DIsu1Qt3n9
         au3oqWvEazQFu613CnLTlDmtYs2owoDVXJo2U1VVfeZXifXuUxuOERZo0vDeMkD/jhea
         8EaG4a1scjW2yMK5xpLi+N7qwDl/1mLZMW059FkBCtRCOGoXFz50rcZox9ch0U8fIA5h
         NS18xbK02Bh+wjRRW2ZpL0S5eCIZkU8yAT16hz1CAsCrM6iFGWGCJaDUgQD4l7ehAJET
         GpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111678; x=1786716478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oE7F4Cq3TaG660Axwa91NtG4j0CcMsIY14xd/BazRYE=;
        b=PnATVw4pNHTmqvj7oaKLDCY9W93VtTYVjRbaDUQudG6m7Xib5xBF9/Fj4rdgfvp508
         SplE8p8cilpsPLgcsP3tj0iTU8wIy0xH3Sidnp0hMhk1haOZUNUTrwFZ0S6EzlKKW78r
         /p17S7JaR5YW6jev3Zp7AB+PZBRFc92EhuvvDssUbOgNOioAasn6+Wab/mvrPFTFieQf
         yMopl20L0hz2YyIfDquutQ4y3Fd6MkHkcrXJ6JN/Eq3h4Y2y/uoTvbREkteMU8W30H9F
         I9gT7mRA3QyEdyKlB4XiLKsIE8OQEKcN3gmvU/XL9F6TtmmxEYjmS79Ct53VgrKvKJrD
         BXmw==
X-Gm-Message-State: AOJu0YycvpcUMES17qCg1oEznL5jXbBl59gWbMBtZ/yOXQtVjgbHu/RU
	ZZ+gk5QrWI+aio0MSJR8JyErfy0XiQErTQN+Pe7Las7mB6pk+unpht5RyLLXuW2y3Oo=
X-Gm-Gg: AR+sD12ZYT3nl3O9XiiHjUlyDRU0VtSCM6JywAVZoIt3BT60TfTDcl908eEjqSh2t8f
	c9CssLQR8UDDhLYO+e6I6OXY69QQ1bgKKqFBq9c5BZBLPUCsXuI6+uFjLQLSOhVyVkiqufOZ2RF
	fJldJ3miN9V7e4SjtlBUw9b4VuUJNpxcZFgQKszgOQoH7R9D15rcCRpcT/hPh2PmFyRiuBlur55
	z7Vfj1sR69K/dCGuvXEjAA++Xe+yxQBTmDY5Y3pNAtVrnKD4xgcTpc0JAbN5JDhAfwjTgiTO2kV
	8tCFBPHjnj0dVf/5lNCWe1m2mtd8LVZc66yPF2YIiE0qAnWlVMZsdU6HKlDvCOe++A82tzIJFlN
	1ds849gR15ToZepLzzmT+tf0Rghjzs3UEhOYRMwvC/UPsIgqDxz+lw2LZrH5z08Voyn9KyEOSWQ
	9j7r/2jOK7WR686CJ27MMteSqiJLKU6iEg1Fiwuwl4ex2By3u1BzZLiuy2DlzElS+mg2Ls1fm1j
	P8Z3uoxWyL1iZ8qkz3Z/gLye80EaueCe04s2CxVCKbmJ3t74w+t3maV1iWcrS8F99qlaJ2aBe72
	mu9wslsm3g70SzT8xlfal9Y=
X-Received: by 2002:a05:6000:401f:b0:47f:7e91:3d55 with SMTP id ffacd0b85a97d-47fec520b24mr18027535f8f.2.1786111677830;
        Fri, 07 Aug 2026 07:07:57 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-179-201-133.77.179.pool.telefonica.de. [77.179.201.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506c0sm5980064f8f.11.2026.08.07.07.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:07:57 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	stable@vger.kernel.org,
	sdf.kernel@gmail.com,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v5 3/4] net: hsr: unfold GSO super-packets at the forward entry
Date: Fri,  7 Aug 2026 16:07:49 +0200
Message-ID: <20260807140751.1351-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260807140751.1351-1-xiexinet@gmail.com>
References: <20260807140751.1351-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HSR/PRP require per-wire-frame tags and sequence numbers. Treating a GSO
skb as one frame breaks those semantics.

Classify GSO skbs at the forward entry by effective protocol rather than
ingress port. Segment plain aggregates and process every segment normally,
preserving local delivery and forwarding. Drop ETH_P_HSR, ETH_P_PRP and
unreadable aggregates because their per-frame metadata cannot be rebuilt.
HSR supports one 802.1Q C-tag, so unsupported stacked or S-tag GSO
input is rejected before segmentation.

In-tree software GRO does not merge PRP RCT frames because its IPv4 and
IPv6 length checks reject trailing bytes. This guarantee does not cover
device-specific fixed-on GRO_HW output.

Also remove GSO features from the HSR master's hw_features when possible.
This patch depends on patch 2 and the sparse-bitmap duplicate discard in
7.0 and newer; older trees require an adapted backport.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_device.c  |   2 +-
 net/hsr/hsr_forward.c | 102 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 3fd1762d8916..248cbb142e21 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -652,7 +652,7 @@ void hsr_dev_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 
 	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
-			   NETIF_F_GSO_MASK | NETIF_F_HW_CSUM |
+			   NETIF_F_HW_CSUM |
 			   NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER;
 
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 87cd72a1dc65..f42694cf4309 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <net/gso.h>
 #include "hsr_main.h"
 #include "hsr_framereg.h"
 
@@ -732,7 +733,7 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 }
 
 /* Must be called holding rcu read lock (because of the port parameter) */
-void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
+static void hsr_forward_skb_one(struct sk_buff *skb, struct hsr_port *port)
 {
 	struct hsr_frame_info frame;
 
@@ -761,3 +762,102 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	DEV_STATS_INC(port->dev, tx_dropped);
 	kfree_skb(skb);
 }
+
+/* GSO fan-out funnel: unfold super-packets before per-frame processing so
+ * each wire frame gets its own HSR/PRP tag and sequence number.
+ */
+/* Effective frame protocol of a (possibly VLAN-tagged) skb, or 0 when
+ * it cannot be determined or the tagging exceeds what HSR supports.
+ * HSR supports one 802.1Q C-tag only, matching fill_frame_info(): an
+ * accelerated tag must be a C-tag with a non-VLAN inner protocol; an
+ * in-band tag is unwrapped exactly once and a residual VLAN EtherType
+ * is rejected. Read-only; no state is kept beyond the immediate
+ * protocol value.
+ */
+static __be16 hsr_gso_effective_proto(const struct sk_buff *skb)
+{
+	struct ethhdr eh;
+	struct vlan_hdr vh;
+	const struct ethhdr *eth;
+	const struct vlan_hdr *vhdr;
+	__be16 proto;
+
+	if (skb_vlan_tag_present(skb)) {
+		/* HSR supports one 802.1Q C-tag only. */
+		if (skb->vlan_proto != htons(ETH_P_8021Q))
+			return 0;
+		if (eth_type_vlan(skb->protocol))
+			return 0;
+		return skb->protocol;
+	}
+
+	eth = skb_header_pointer(skb, 0, sizeof(eh), &eh);
+	if (!eth)
+		return 0;
+
+	proto = eth->h_proto;
+	if (!eth_type_vlan(proto))
+		return proto;
+	if (proto != htons(ETH_P_8021Q))
+		return 0;
+
+	vhdr = skb_header_pointer(skb, ETH_HLEN, sizeof(vh), &vh);
+	if (!vhdr)
+		return 0;
+
+	proto = vhdr->h_vlan_encapsulated_proto;
+	if (eth_type_vlan(proto))
+		return 0;
+
+	return proto;
+}
+
+void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
+{
+	struct sk_buff *segs, *next;
+	__be16 proto;
+
+	if (likely(!skb_is_gso(skb))) {
+		hsr_forward_skb_one(skb, port);
+		return;
+	}
+
+	/* Conforming plain-protocol GSO super-packets carry trailer-free
+	 * sender payload and are segmented here: each segment is delivered
+	 * or forwarded as its own wire frame, on any ingress role.
+	 *
+	 * The gate is content-based, not port-based. An aggregate whose
+	 * effective protocol is ETH_P_HSR or ETH_P_PRP cannot be safely
+	 * segmented and is dropped, as is any skb whose header cannot be
+	 * read or whose tagging exceeds the single 802.1Q C-tag HSR
+	 * supports. With NETIF_F_HW_HSR_TAG_RM the lower has already
+	 * stripped the tag, so such aggregates arrive plain and are
+	 * segmented.
+	 */
+	proto = hsr_gso_effective_proto(skb);
+	if (!proto)
+		goto drop_gso; /* classification failure, fail-safe */
+	if (proto == htons(ETH_P_HSR) || proto == htons(ETH_P_PRP))
+		goto drop_gso;
+
+	/* features = 0: request full software segmentation. tx_path is true
+	 * only for locally generated traffic on the master; ingress from
+	 * the interlink follows RX checksum semantics.
+	 */
+	segs = __skb_gso_segment(skb, 0, port->type == HSR_PT_MASTER);
+	if (IS_ERR(segs) || unlikely(!segs))
+		goto drop_gso;
+
+	consume_skb(skb);
+	while (segs) {
+		next = segs->next;
+		segs->next = NULL;
+		hsr_forward_skb_one(segs, port);
+		segs = next;
+	}
+	return;
+
+drop_gso:
+	DEV_STATS_INC(port->dev, tx_dropped);
+	kfree_skb(skb);
+}
-- 
2.43.0

