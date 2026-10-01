Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079747DF80
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881914; cv=none; b=JYGpLGeTFA/iUxixMs9eWzIh7Y7Df/mdQ07m87B4DWz3lbMFmXAsGr1VPmj2fDETq+fZtgTfHbN8H/VBpzrhw2R7FmAO+4NrRGc+Afj38XyIoLgribx6aohlpPNSDHUuT000M3YCLh08qkbHwPnSa7ukHpExOzB7KviBIO3tYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881914; c=relaxed/simple;
	bh=dnN3ShcPh0qVWr2B2QyS5vunjORPSA1J+F3HUIhEnT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aD3iwB126PtDLr2q9vwy921GmHC674xs3p+4F3hPYFJotuYKxPZcH4FrS6Lid7Vm5v/kqySPrS1BnNxlkPYTA+YTcVdk6PpyMQ4jvbH5ymESYeewgfmpxZPfzEUqnNccIJ8gqGjV5b9LUNzUXTXQhYay970lzDViklw8B0mPfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2zt8P2M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2zt8P2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCA61F00898;
	Thu,  1 Oct 2026 19:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790881910;
	bh=4W+W+OPO2QbwX4GSzrHYywutWAoqL25wWR0QbG2PIfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c2zt8P2Mqxm5/fh7TLfMZN5IvXiNK09h8J5wuzfTCe2kmR/imIL6wzjP0jWkvafvu
	 w7GLDfQt8ll20aMn0+CRM9OTbBUiOT4n1NxQ0fcn9jkLHAM480tC0Bw+msJUwbcZTo
	 n3bKTzaPTu0BWj2xmiBSOXyjVyo52SoLgbTUq8c5VAPS7Ot18qU+B0NI6mSjBxRWYC
	 6EJi+GwvCJ41Y5qfqSL20KnJ4mXMRxExwNzTTBdwNC4tNc73sgSJ7/NC2EPrrWIbrs
	 tHd3gBfjpOycZN0OQxsXW56s0HyAJtNvhX4tUCAAMS7bEbV8zDeul0MMSOYMoTZUts
	 IMWKg2GC7Afzg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v3 net 2/3] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
Date: Thu,  1 Oct 2026 19:11:39 +0000
Message-ID: <20261001191140.2818991-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261001191140.2818991-1-edumazet@kernel.org>
References: <20261001191140.2818991-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9e8db5913264 ("net: avoid false positives in untrusted gso
validation") added a '&& skb->network_header' check before flow-dissecting
GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM in
__virtio_net_hdr_to_skb(), because some callers (such as tun_get_user(),
tun_xdp_one(), virtnet_receive_done(), and raw_verify_header()) called
virtio_net_hdr_*_to_skb() before initializing skb->network_header and
skb->dev.

Because __alloc_skb() and __build_skb_around() zero-initialize
skb->network_header to 0 (unlike mac_header and transport_header which
are initialized to ~0U), those four callers always had
skb->network_header == 0 and bypassed flow dissection in
__virtio_net_hdr_to_skb(). More generally, skb->network_header is an
offset from skb->head (where 0 is also a valid offset whenever
skb_headroom(skb) is 0), not a boolean flag.

Whenever the 'if (gso_type && skb->network_header)' branch was skipped,
the fallback 'else if (gso_type)' only pulled nh_min_len + thlen (40 bytes
for TCPv4) without dissecting the packet, without validating ip_proto or
n_proto, and without setting skb->transport_header.

If the packet has a malformed network header, it is not rejected and a
subsequent skb_probe_transport_header() also fails, leaving
skb->transport_header at ~0U (0xffff). Similarly, if an IPv4 packet
carries IP options (ihl > 5) or an IPv6 packet carries extension headers,
pulling only nh_min_len + thlen can leave the TCP header outside
skb->head. In both cases, tcp_hdrlen(skb) in skb_gso_transport_seglen()
reads out-of-bounds:

  BUG: KASAN: slab-out-of-bounds in skb_gso_transport_seglen
  Read of size 2 by task poc/133
  skb_gso_transport_seglen (net/core/gso.c:155)
  skb_gso_validate_mac_len (net/core/gso.c:270)
  tbf_enqueue (net/sched/sch_tbf.c:260)
  dev_qdisc_enqueue (net/core/dev.c:4227)
  __dev_queue_xmit (net/core/dev.c:4884)

In addition, checking virtio_net_hdr_match_proto() only inside
'if (!skb->protocol)' before flow dissection both skipped validation when
skb->protocol was pre-set by the caller and rejected VLAN-tagged frames
whose outer L2 protocol is ETH_P_8021Q or ETH_P_8021AD.

Fix this by:
1. Initializing skb->dev and skb->network_header (plus skb->protocol for
   IFF_TUN) before virtio_net_hdr_*_to_skb() in tun_get_user(),
   tun_xdp_one(), virtnet_receive_done(), and raw_verify_header(). In
   tun_get_user(), drop the redundant skb_reset_mac_header(skb) in the
   IFF_TUN case since __virtio_net_hdr_to_skb() unconditionally resets
   mac_header.
2. Removing '&& skb->network_header' and the unvalidated
   'else if (gso_type)' fallback in __virtio_net_hdr_to_skb() so all GSO
   packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are flow-dissected, have
   their transport header pulled into linear data, and have
   skb->transport_header set.
3. Moving the virtio_net_hdr_match_proto() check to after
   skb_flow_dissect_flow_keys_basic(), validating keys.basic.n_proto
   against hdr_gso_type.

Fixes: 9e8db5913264 ("net: avoid false positives in untrusted gso validation")
Fixes: d5be7f632bad ("net: validate untrusted gso packets without csum offload")
Fixes: 924a9bc362a5 ("net: check if protocol extracted by virtio_net_hdr_set_proto is correct")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Closes: https://lore.kernel.org/netdev/20260927163117.746432-2-bestswngs@gmail.com/
Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_transports.c |  1 +
 drivers/net/tun.c                   | 23 ++++++-----
 drivers/net/virtio_net.c            |  2 +
 include/linux/virtio_net.h          | 60 ++++++++++++-----------------
 4 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index ddd127ee96785daa4c485b2a06f078686efd2046..e1fb2a76fdff59ef3032d091be06a06fa58046cc 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -209,6 +209,7 @@ static int raw_verify_header(
 	if ((vheader->flags & VIRTIO_NET_HDR_F_DATA_VALID) > 0)
 		return 1;
 
+	skb_set_network_header(skb, ETH_HLEN);
 	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
 	return 0;
 }
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68aa3308b0c850b4a2957df3260b352..242899f7fd0711c5c59ff85accbf5bd1be9c6f39 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1897,12 +1897,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		}
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
-		atomic_long_inc(&tun->rx_frame_errors);
-		err = -EINVAL;
-		goto free_skb;
-	}
-
+	skb->dev = tun->dev;
 	switch (tun->flags & TUN_TYPE_MASK) {
 	case IFF_TUN:
 		if (tun->flags & IFF_NO_PI) {
@@ -1927,9 +1922,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			}
 		}
 
-		skb_reset_mac_header(skb);
+		skb_reset_network_header(skb);
 		skb->protocol = pi.proto;
-		skb->dev = tun->dev;
 		break;
 	case IFF_TAP:
 		if (!pskb_may_pull(skb, ETH_HLEN)) {
@@ -1937,10 +1931,19 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			drop_reason = SKB_DROP_REASON_HDR_TRUNC;
 			goto drop;
 		}
-		skb->protocol = eth_type_trans(skb, tun->dev);
+		skb_set_network_header(skb, ETH_HLEN);
 		break;
 	}
 
+	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
+		atomic_long_inc(&tun->rx_frame_errors);
+		err = -EINVAL;
+		goto free_skb;
+	}
+
+	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
+		skb->protocol = eth_type_trans(skb, tun->dev);
+
 	/* copy skb_ubuf_info for callback when skb has no error */
 	if (zerocopy) {
 		skb_zcopy_init(skb, msg_control);
@@ -2600,6 +2603,8 @@ static int tun_xdp_one(struct tun_struct *tun,
 
 	features = tun_vnet_hdr_guest_features(READ_ONCE(tun->vnet_hdr_sz));
 	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
+	skb->dev = tun->dev;
+	skb_set_network_header(skb, ETH_HLEN);
 	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bf82ef9874abb4094931496fb6064a12ee75b789..daab43ac92ce4276b0f8f88684991e3993022ce6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2515,6 +2515,8 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 		goto frame_err;
 	}
 
+	skb->dev = dev;
+	skb_set_network_header(skb, ETH_HLEN);
 	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
 				      vi->rx_tnl_csum,
 				      virtio_is_little_endian(vi->vdev))) {
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index c381b916c1b54afacba5473888af589a24fe087c..d6466f96cdd00cdf059d4fa8842ba1672780e556 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -111,48 +111,38 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 		p_off = nh_min_len + thlen;
 		if (!pskb_may_pull(skb, p_off))
 			return -EINVAL;
-	} else {
+	} else if (gso_type) {
 		/* gso packets without NEEDS_CSUM do not set transport_offset.
 		 * probe and drop if does not match one of the above types.
 		 */
-		if (gso_type && skb->network_header) {
-			struct flow_keys_basic keys;
-
-			if (!skb->protocol) {
-				__be16 protocol = dev_parse_header_protocol(skb);
-
-				if (!protocol)
-					virtio_net_hdr_set_proto(skb, hdr);
-				else if (!virtio_net_hdr_match_proto(protocol,
-								 hdr_gso_type))
-					return -EINVAL;
-				else
-					skb->protocol = protocol;
-			}
+		struct flow_keys_basic keys;
+
+		if (!skb->protocol) {
+			skb->protocol = dev_parse_header_protocol(skb);
+			if (!skb->protocol)
+				virtio_net_hdr_set_proto(skb, hdr);
+		}
 retry:
-			if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
-							      NULL, 0, 0, 0,
-							      0)) {
-				/* UFO does not specify ipv4 or 6: try both */
-				if (gso_type & SKB_GSO_UDP &&
-				    skb->protocol == htons(ETH_P_IP)) {
-					skb->protocol = htons(ETH_P_IPV6);
-					goto retry;
-				}
-				return -EINVAL;
+		if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
+						      NULL, 0, 0, 0,
+						      0)) {
+			/* UFO does not specify ipv4 or 6: try both */
+			if (gso_type & SKB_GSO_UDP &&
+			    skb->protocol == htons(ETH_P_IP)) {
+				skb->protocol = htons(ETH_P_IPV6);
+				goto retry;
 			}
+			return -EINVAL;
+		}
 
-			p_off = keys.control.thoff + thlen;
-			if (!pskb_may_pull(skb, p_off) ||
-			    keys.basic.ip_proto != ip_proto)
-				return -EINVAL;
+		p_off = keys.control.thoff + thlen;
+		if (!pskb_may_pull(skb, p_off) ||
+		    keys.basic.ip_proto != ip_proto ||
+		    !virtio_net_hdr_match_proto(keys.basic.n_proto,
+						hdr_gso_type))
+			return -EINVAL;
 
-			skb_set_transport_header(skb, keys.control.thoff);
-		} else if (gso_type) {
-			p_off = nh_min_len + thlen;
-			if (!pskb_may_pull(skb, p_off))
-				return -EINVAL;
-		}
+		skb_set_transport_header(skb, keys.control.thoff);
 	}
 
 	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

