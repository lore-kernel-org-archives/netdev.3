Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D351C07E
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789410; cv=none; b=OSMmz5BAC+h2SbZOCizIx8C2FnnSGOYw/DeU0axvlJvF8jhdwOLnYa0BlqmfzA/bL+qR5/BfEF9mN7se3RUQmqRLHJma1g6j8uRkGBGmk6JKEU+S9X1HOSOleJoxhUpGUQ1u5xI4KMgEs3Az939gNBKcz1gdVa/vl6oXlhrk8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789410; c=relaxed/simple;
	bh=aWQP77YTXcbXpJLSE89qHkQt6wgg27gb3vrqIzm12PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Emx6ALVlM62EaRztRCkhnc9HcSP3x5Ya+xv39L7yxXuJ7QBf26gp9DNCQICh/En8pMVuzFK+8PvIVhiSvK9LQQBweTV/QM5Lp6hdvvEF+zO3mIyJT78KU4D756X2Pdo7bK84r+s9hddMRwCxaJd1yCvDtI4ScOynw652BA7V+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPW/2teF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPW/2teF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3F81F000FF;
	Wed, 30 Sep 2026 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789408;
	bh=rPit0HjogdYyAPZEfWM+7ra0oJFUEkyD7wVJPFFMsMw=;
	h=From:To:Cc:Subject:Date;
	b=HPW/2teF9rnqW9pw4JsnE0c+UYaKqOvaaNghvSdf1FOpS5CWd1qMSXCj7uO/y7Y8C
	 BYVh8wwqSDyDl9vlKbZIQ0T3Jc0mvfhAc/sWUhOVqq44JOOKVSdiyLOoAQpW5nZxK+
	 xYOq59haZESVssCo1Q5RZLkun48iog/TZXCrd3paPj+xtsYKs3wGRPCLy1ghxJs7i0
	 uSeoiwG/9JxX4QU1PLA+a9CYDmpixxjxlD3GUZT+Fswh/6Mk74iSXiGnG1rFokxB6v
	 rOokDNO3C5o5RNfZV4lpJR16YCtk6wgWS8+oX1gzRSHtWm/K+j8fzbO4R7SBy+Ik1K
	 mJzJelUIYAMkw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next] net: inline eth_type_trans() fast path
Date: Wed, 30 Sep 2026 19:29:57 +0200
Message-ID: <20260930172957.897342-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eth_type_trans() is called once per received packet by most
Ethernet drivers, and by core helpers (napi_gro_frags(),
xdp_build_skb_from_*(), veth, tun, tunnels, loopback...).

With CONFIG_MITIGATION_RETHUNK / SRSO, the call and return
are not free anymore.

Add eth_type_trans_inline(), handling the common case inline:
unicast frame sent to dev->dev_addr, with a real ethertype,
on a device which is not a DSA conduit. All other frames
(multicast, broadcast, otherhost, 802.2, runts, DSA)
are handled by the out-of-line eth_type_trans().

eth_type_trans() is now a macro calling eth_type_trans_inline(),
so that all existing callers get the fast path. The out-of-line
version remains exported, and can be called with
(eth_type_trans)(skb, dev). bpf_prog_test_run_skb() uses this
to keep tools/testing/selftests/bpf fentry/fexit tests working.

The inline part is about 25 instructions on x86_64, and the whole
function would be almost twice as big when fully inlined.

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/linux/etherdevice.h | 43 +++++++++++++++++++++++++++++++++++++
 net/bpf/test_run.c          |  3 ++-
 net/ethernet/eth.c          |  8 +++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index df8f88f63a7063fbd1df5248d2fc02c859a7bc74..a45c9bcca7dd61e0d696be5a6f2e7a6203d548d0 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -645,6 +645,49 @@ static inline struct ethhdr *eth_skb_pull_mac(struct sk_buff *skb)
 	return eth;
 }
 
+static inline bool eth_dev_maybe_dsa(const struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_NET_DSA)
+	return !!dev->dsa_ptr;
+#else
+	return false;
+#endif
+}
+
+/**
+ * eth_type_trans_inline - determine the packet's protocol ID.
+ * @skb: received socket data
+ * @dev: receiving network device
+ *
+ * Inline fast path of eth_type_trans(), handling unicast frames
+ * sent to @dev address, with a real ethertype.
+ * Other frames are handled by the out-of-line eth_type_trans().
+ *
+ * Return: the packet protocol ID, in network byte order.
+ */
+static __always_inline __be16 eth_type_trans_inline(struct sk_buff *skb,
+						    struct net_device *dev)
+{
+	const struct ethhdr *eth = (const struct ethhdr *)skb->data;
+
+	if (likely(skb->len >= ETH_HLEN &&
+		   ether_addr_equal_64bits(eth->h_dest, dev->dev_addr) &&
+		   eth_proto_is_802_3(eth->h_proto) &&
+		   !eth_dev_maybe_dsa(dev))) {
+		skb->dev = dev;
+		skb_reset_mac_header(skb);
+		__skb_pull(skb, ETH_HLEN);
+		/* Like eth_skb_pkt_type(), leave skb->pkt_type unchanged. */
+		return eth->h_proto;
+	}
+	return (eth_type_trans)(skb, dev);
+}
+
+/* eth_type_trans() is called for every received packet by most drivers.
+ * Use (eth_type_trans)(skb, dev) to force a call to the out-of-line version.
+ */
+#define eth_type_trans(skb, dev) eth_type_trans_inline(skb, dev)
+
 /**
  * eth_skb_pad - Pad buffer to minimum number of octets for Ethernet frame
  * @skb: Buffer to pad
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 513354e928cb58f837fdc93a77f2e896de1ef916..f3eed8c0a767b7c141117f30c0c2c12dc207d9a9 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1165,7 +1165,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			goto out;
 		}
 	}
-	skb->protocol = eth_type_trans(skb, dev);
+	/* Keep calling the out-of-line version, for fentry/fexit selftests. */
+	skb->protocol = (eth_type_trans)(skb, dev);
 	skb_reset_network_header(skb);
 
 	switch (skb->protocol) {
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index d9faadbe9b6c86a746cace6d7a7cfffdb84e4519..476c39fb6a80f4e913bd3631bf1783473bface34 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -143,6 +143,9 @@ u32 eth_get_headlen(const struct net_device *dev, const void *data, u32 len)
 }
 EXPORT_SYMBOL(eth_get_headlen);
 
+/* Define the out-of-line version, not the eth_type_trans_inline() wrapper. */
+#undef eth_type_trans
+
 /**
  * eth_type_trans - determine the packet's protocol ID.
  * @skb: received socket data
@@ -151,6 +154,11 @@ EXPORT_SYMBOL(eth_get_headlen);
  * The rule here is that we
  * assume 802.3 if the type field is short enough to be a length.
  * This is normal practice and works for any 'now in use' protocol.
+ *
+ * Most callers use the eth_type_trans_inline() fast path,
+ * which calls this function for less common frames.
+ *
+ * Return: the packet protocol ID, in network byte order.
  */
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 {
-- 
2.53.0

