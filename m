Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089587;
	b=G4yc7rHmVVAgIFiZFYFzQkZkbX11opT3zOKo+9McKwT2CwivFLgEDI471TgDJ092eDpz
	 P4rZUDM4VoDnU/JXSmzNNAuojEUKfKk/fWeMeuDG13wRfYsNgOregSX5XyhLFUH4Km0gZ
	 L3R/cVoqCQ96mlHxKFfCP5b+Lh/36ZQkZzxwXq1B6h1VD66XTvUH+lwb+SORlEg6OUs6c
	 fSLPIA673gQEaDmsqKAYfKnlmHLs6JxGgQlv6sOfqEUVRkLINK6kvfqrWO0D+CX4U1b36
	 6PXT/PTbaqtNJv8yk/f/p3VX0BZBiX8RzHShUqeIyHsjAiRVnKlUYVEoR8u38FQqHFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089587;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oBdIxhoBqeVADlismHhWbqj1ZPcyaQv3xKqNln+xxfM=;
	b=4/EYW2jsjYGHVhuBlqTv3eaIIdelS/HvIuoExQUOeenk6CVMEarVvt0T4UddoJ2jBpVf
	 a7GVEMNCnAp0qkGMp57e6dXY/Lz0Ynedr1IIMgXWSh/zUVunfY2J4BcigD/14tTEJN6nf
	 FxztxU8Y8AwbJPiv6S6mvkIs0Y1pZlVr9DaTtFDw+u1WqfCTTeTtvinImLYjVy+fUzWUa
	 1zncjV/3GLkZCCFtJeLbf820NfxDsGmaY/HU0lOaUVbyGHweEi7/yrTDxFY35Wkcugh0U
	 gwEAvdUB0tgtK+KGtYSQUsdSY7Xx0OzrBy7LBzKvlSx8jURciN8Qa62zJC+EaXfHIHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqNj1JDj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6781B606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqNj1JDj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C25A1F01828;
	Tue, 27 Oct 2026 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089587;
	bh=oBdIxhoBqeVADlismHhWbqj1ZPcyaQv3xKqNln+xxfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WqNj1JDjGMTFX21RAKQMHHCHfilXB5NmJybt6Vzv4zbc0gwRFGnX+ZXVwQ18nQim9
	 6yFwny2xm+SnJWYgy5wPmBA5zNKJsbA5iC9JMgCXp2OCj0qTx6kqR9RIYMgTNMVG/8
	 37a70gYnCx+jC0aioZdLY7o//VvmV7WYlEtNf0T0l0HYW7hp+ohW66sm/+PmOYCEB6
	 pYZSTG7KKdq5kxHGJ/w8DDzpwwaGcnvZ0wufgP+XbWwKXS6+mNUUpek/Nubu9LwYZJ
	 NKQIrsme3hCus0oNhXy/ADSL7LJs1NGBtALwp8SzzXVKuWX45mDLOg9MTlEaU65bBr
	 OONBsePEWJPog==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	dev@openvswitch.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Ren Wei <weir@nebusec.ai>
Subject: [PATCH net 1/5] net: add eth_type_trans_careful()
Date: Tue, 27 Oct 2026 09:26:00 +0100
Message-ID: <20261027082604.1485903-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027082604.1485903-1-edumazet@kernel.org>
References: <20261027082604.1485903-1-edumazet@kernel.org>
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

eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
NIC drivers always provide this, and they should keep using the fast
version.

Devices looping skbs from their transmit path back to their receive
path get skbs built by the stack instead. Their link-layer header
might have been popped by tc actions (act_vlan pop_eth, act_ife decode)
or OVS actions (pop_eth + pop_mpls / pop_nsh), leaving fewer than
ETH_HLEN bytes in the linear part. eth_type_trans() then hits
the BUG() in __skb_pull().

Add eth_type_trans_careful(), which first pulls the Ethernet header,
and returns a drop reason on failure, so that the few devices exposed
to this can drop such packets.

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/linux/etherdevice.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index df8f88f63a7063fbd1df5248d2fc02c859a7bc74..1f833ebd71ed917d138ec1e64c29689ae7dd0dd5 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -38,6 +38,34 @@ int fwnode_get_mac_address(struct fwnode_handle *fwnode, char *addr);
 
 u32 eth_get_headlen(const struct net_device *dev, const void *data, u32 len);
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
+
+/**
+ * eth_type_trans_careful - eth_type_trans() for skbs coming from the stack
+ * @skb: buffer, possibly with less than ETH_HLEN bytes in its linear area
+ * @dev: receiving network device
+ *
+ * eth_type_trans() expects ETH_HLEN bytes in skb->head, which NIC drivers
+ * provide. Devices looping skbs from their transmit path back to the
+ * receive path (loopback, OVS internal ports) get skbs built by the stack,
+ * whose link-layer header might have been popped by tc or OVS actions.
+ *
+ * Sets skb->protocol on success.
+ *
+ * Return: SKB_NOT_DROPPED_YET on success, or a drop reason. In the latter
+ * case, the caller must free @skb.
+ */
+static inline enum skb_drop_reason
+eth_type_trans_careful(struct sk_buff *skb, struct net_device *dev)
+{
+	enum skb_drop_reason reason = pskb_may_pull_reason(skb, ETH_HLEN);
+
+	if (unlikely(reason))
+		return reason;
+
+	skb->protocol = eth_type_trans(skb, dev);
+	return SKB_NOT_DROPPED_YET;
+}
+
 extern const struct header_ops eth_header_ops;
 
 int eth_header(struct sk_buff *skb, struct net_device *dev, unsigned short type,
-- 
2.53.0

