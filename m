Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67F30674C
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538940; cv=none; b=UwAPwcPBDhqL56j9CcfSumz00Xp94oHe2VhO6Mf1wbMp7j3gU4D7aa0Kqmv811EqH+OJjDi8C6TQ4nQJ6mDwTIhrTMQeMHmVCyDA9mKKCj65mukV7jaJS9qPUqIeO3dsGrEiVzjzhKzx5KY6paqHh95F/zvRhjm6AXQUKa3xvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538940; c=relaxed/simple;
	bh=ZAzoG8zmik8KEA9onEC3pLAwRNvSvuc0PAtC5RWFWLs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gecsU4XfrU2wk6SGeBpiWLKCXUp0g/nLfGb+0orcVRNHGuLawiZ5RDuvEJhfBV3PwDnBwlq8E12AbsxWc+ddOahoYZyOOhX6VKS3eva0PREomREiScPWw1QnigGKw8vo3BtNj1/fhZ9jFObdHatq26qlkU+UTq1zNp/lvMswSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UCEbDs0g; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCEbDs0g"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9308eafb465so674546385a.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790538937; x=1791143737; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fk3pmqFtywPX4oRTyO/KpeSiBG5bVaQSy2Q6rk906AY=;
        b=UCEbDs0g+RoTMLtjPWcpXVM01cWMlMWh/tnl1+wDlVInG9nWXXWcJnCEWs7dutE5jB
         RrAGjk0j12stFCdDjkEAmKIDLq3WU2MitGercAR6jXB7wUpZWTATrM6eFr8Fa4w9SHbf
         e/inScxw5yR0tr5hegkixt15d/ckH9C+9Z7knZAdh00DttJ3+YniklQFNxiFV4QZdJdu
         qgwQL3lET303fW59VakHhbrj4kQ7RcMXI62Nr7Iy+67ItHNtqYBJml2FsiN1O6gfKJkj
         HrGPpVhgqVq6MiR+jJ2XkZmggh7KqoxiLnjkhRskL7y7rbXVfkxkVVrUGk/5xLKF6x9c
         Ne0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790538937; x=1791143737;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fk3pmqFtywPX4oRTyO/KpeSiBG5bVaQSy2Q6rk906AY=;
        b=z8GNxGtJV9rR+T7EhDSFmPmTEHcc4AwcfAteG6nMpdTayTpze3J1WZiVmLDP/QGkuw
         jPaCVUTZwl824bRpQ1MN1ZAAVhy71hfaAs6X/GEOim1zTZw4zzCGS7hglV47JVoX4pR4
         iG3lvqkwdSBQ/fexM44YQqaiWiRvfbQOBiydL4+xI/DMG/4JX/hPvyVpfMaahXunKqIR
         6kLGr/EyNPY99mH7GGOhBgFcwBEBsd3h0LmMFzhU3u5KztT5vdHv0TULTyJEw1eDaNnZ
         fHcqYo/3QKwDjC3gbdZQexVCMm82xuazG1vPbtMvO/zwmAWlUItmSFKYGvfg/zW2BHs9
         kAcA==
X-Forwarded-Encrypted: i=1; AKwUvBz2Wk01FepOfT/ss7GdnAIu66t3lUWNka/6DO5xNCdvEgP14BcUO8YJJYc/VlQeYYrqr2RsVuM=@vger.kernel.org
X-Gm-Message-State: AFuF++kOL5hNzG/KVq0IY/JrAKeUjs6jrUonNUTLx5yC2Bx6TPUQs9U3
	jlZNCGX+FV9ARdjIph2BLua+AZ335cx97WlZFI6I/V3zGrop5xhx1FCeu6Oj7KYWyZ1PYhY2AYz
	4zJoCgyo74m5Awg==
X-Received: from qkmt27.prod.google.com ([2002:a05:620a:35b:b0:93a:14af:9e8e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6602:b0:939:f89:3688 with SMTP id af79cd13be357-93c47498f78mr1521397185a.42.1790538937325;
 Sun, 27 Sep 2026 12:55:37 -0700 (PDT)
Date: Sun, 27 Sep 2026 19:55:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260927195536.2489079-1-edumazet@google.com>
Subject: [PATCH net] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Weiming Shi <bestswngs@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Commit 9e8db5913264 ("net: avoid false positives in untrusted gso
validation") added a '&& skb->network_header' check before flow-dissecting
GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM in
__virtio_net_hdr_to_skb(), because some callers (such as tun_get_user(),
tun_xdp_one(), virtnet_receive_done(), and raw_verify_header()) called
virtio_net_hdr_*_to_skb() before initializing skb->network_header and
skb->dev.

However, skb->network_header is an offset from skb->head, not a boolean
flag. When skb_headroom(skb) is 0 on a device without L2 headers (for
instance packet_snd() or tpacket_snd() on a tunnel/pure-L3 device where
LL_RESERVED_SPACE_EX(dev, 0) == 0), skb_reset_network_header(skb)
legitimately sets skb->network_header to 0.

Whenever the 'if (gso_type && skb->network_header)' branch was skipped,
the fallback 'else if (gso_type)' only pulled nh_min_len + thlen (40 bytes
for TCPv4) without dissecting the packet, without validating ip_proto or
n_proto, and without setting skb->transport_header. If an IPv4 packet
carries IP options (ihl > 5, up to 60 bytes) or an IPv6 packet carries
extension headers, pulling only nh_min_len + thlen leaves the TCP header
outside skb->head, causing tcp_hdrlen(skb) in skb_gso_transport_seglen()
to read out-of-bounds:

  BUG: KASAN: slab-out-of-bounds in skb_gso_transport_seglen+0x173/0x200 net/core/skbuff.c:5503
  Read of size 1 at addr ffff888103c7ec4d by task repro/5718
  Call Trace:
   <TASK>
   skb_gso_transport_seglen+0x173/0x200 net/core/skbuff.c:5503
   skb_gso_network_seglen include/linux/skbuff.h:4718 [inline]
   skb_gso_validate_network_len+0x92/0x1a0 net/core/skbuff.c:5566
   ip_finish_output_gso net/ipv4/ip_output.c:285 [inline]
   __ip_finish_output+0x28b/0x4a0 net/ipv4/ip_output.c:316

In addition, when skb->protocol is pre-set by a caller before
__virtio_net_hdr_to_skb(), 'if (!skb->protocol)' is skipped and
virtio_net_hdr_match_proto() was not checked.

Fix this by:
1. Initializing skb->dev and skb->network_header (plus skb->protocol for
   IFF_TUN) before virtio_net_hdr_*_to_skb() in tun_get_user(),
   tun_xdp_one(), virtnet_receive_done(), and raw_verify_header().
2. Removing '&& skb->network_header' and the unvalidated
   'else if (gso_type)' fallback in __virtio_net_hdr_to_skb() so all GSO
   packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are flow-dissected, have
   their transport header pulled into linear data, and have
   skb->transport_header set.
3. Validating virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type)
   after skb_flow_dissect_flow_keys_basic().

Fixes: 9e8db5913264 ("net: avoid false positives in untrusted gso validation")
Fixes: d5be7f632bad ("net: validate untrusted gso packets without csum offload")
Fixes: 924a9bc362a5 ("net: check if protocol extracted by virtio_net_hdr_set_proto is correct")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Closes: https://lore.kernel.org/netdev/20260927163117.746432-2-bestswngs@gmail.com/
Assisted-by: LLM
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_transports.c |  1 +
 drivers/net/tun.c                   | 23 ++++++----
 drivers/net/virtio_net.c            |  2 +
 include/linux/virtio_net.h          | 66 ++++++++++++++---------------
 4 files changed, 48 insertions(+), 44 deletions(-)

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
index c381b916c1b54afacba5473888af589a24fe087c..8902d5a5c418c46af0a6e7b26ae89948c20b0b54 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -111,48 +111,44 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
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
-retry:
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
-			}
+		struct flow_keys_basic keys;
 
-			p_off = keys.control.thoff + thlen;
-			if (!pskb_may_pull(skb, p_off) ||
-			    keys.basic.ip_proto != ip_proto)
-				return -EINVAL;
+		if (!skb->protocol) {
+			__be16 protocol = dev_parse_header_protocol(skb);
 
-			skb_set_transport_header(skb, keys.control.thoff);
-		} else if (gso_type) {
-			p_off = nh_min_len + thlen;
-			if (!pskb_may_pull(skb, p_off))
+			if (!protocol)
+				virtio_net_hdr_set_proto(skb, hdr);
+			else if (!virtio_net_hdr_match_proto(protocol,
+							     hdr_gso_type))
 				return -EINVAL;
+			else
+				skb->protocol = protocol;
 		}
+retry:
+		if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
+						      NULL, 0, 0, 0,
+						      0)) {
+			/* UFO does not specify ipv4 or 6: try both */
+			if (gso_type & SKB_GSO_UDP &&
+			    skb->protocol == htons(ETH_P_IP)) {
+				skb->protocol = htons(ETH_P_IPV6);
+				goto retry;
+			}
+			return -EINVAL;
+		}
+
+		p_off = keys.control.thoff + thlen;
+		if (!pskb_may_pull(skb, p_off) ||
+		    keys.basic.ip_proto != ip_proto ||
+		    !virtio_net_hdr_match_proto(keys.basic.n_proto,
+						hdr_gso_type))
+			return -EINVAL;
+
+		skb_set_transport_header(skb, keys.control.thoff);
 	}
 
 	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

