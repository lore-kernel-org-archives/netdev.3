Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D235275A4
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068106; cv=none; b=H6XJ2ljqEo0oRxm+pcMBs2QKXbxzZae0wLk1JJigEdePNeSxNC2JkEyZa4gNwHxisXVV/PdbxkZQNokN5Kv0XbFgOjf2KVBqgKFe98VhiI4WB7nmxl44/zNMA/fI1MQZJoUowWqPoaxz7i6E/8hQqwmkVNZ/8IzFjUp6XB9DNWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068106; c=relaxed/simple;
	bh=Rl5K6qFYr1oz9s3luxB+F/6lIQe8nEjyrP/2SuMzpLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emfiUBqwcAWnI8RKSYmOd5Jdvdd2tn2pbTBrG6lia8p3d1dhp5h+MwJJf88JQaZ6L+T/N+38lR1klbDhMG7TpIVB5DGSor55O5n4MnwIG3mwQND3Au5j3GlZ9nbP2TK3/j6zT1ecyFZAR3cPDAk8qd316bK7azfoRaPA0c4+DFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jd/7wPpN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJYdtz+D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jd/7wPpN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJYdtz+D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TyxHHWSvKWWNVzFcy2Pxr+76QrIfMwrq1ET2Rt01QEA=;
	b=Jd/7wPpNIqDnQSBBqEcb9IXOBHNE8aks7GdYvixzuDpRhP3pqyUiyYV6m+0SJOLG5jQTvx
	JICGxoiabMEUEdBoc/sydxsO6aI/RJuhAAhliLbxoG8MQygV+lcZanv8ZWHJWunJ0TcgzE
	+C33aeFtsWLi+4QHmmRnAoM6Bi24/CA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-ClA6ahvOOKWq8IeWtSsRAA-1; Thu, 15 Oct 2026 12:41:42 +0000
X-MC-Unique: ClA6ahvOOKWq8IeWtSsRAA-1
X-Mimecast-MFC-AGG-ID: ClA6ahvOOKWq8IeWtSsRAA_1792068101
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c415561aaso3333356f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792068101; x=1792672901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TyxHHWSvKWWNVzFcy2Pxr+76QrIfMwrq1ET2Rt01QEA=;
        b=BJYdtz+DPQMakYWFzo7q6KORmMwqmRQ3OkmOQKlJdB3LwqM8kW9jn9GItfbxYOCEty
         LeWsnqEPF3YVCnVpy4Z8eSspVMhlhg35Xzl44hnpkaCBmdZ2jQrlmUDGP0sIV/P32SJw
         g6oxMIlBArKLfN6UgECjK7nSVYbmeTuEUBfc70SU6hfa7GPsJabedFWC3CxsGQsCWGaY
         nwtvwYMBNLX6cUxRksi6EqChwQxdzvpz2/3aKS6PazThbEmyusq0IedTWYrCYb8Lt1gi
         logJofYiy9FdZRiZfFy+fM0k2QGhTLLmh6xLoKETBVOmtVcev/FyMa8qTZO2v3D5QfUi
         koAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068101; x=1792672901;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyxHHWSvKWWNVzFcy2Pxr+76QrIfMwrq1ET2Rt01QEA=;
        b=XNQd93U0mMrwSun9/kssd74zaVCt4oCoMWoIxdCA4LwPpfUEu0KOae1ZKU6Z2sxRCT
         U1i2E77IUiBQHkySTRcKOwQGaZUNks0+oKn8PUEBv21Z/k+RNkovP1InaUP5vV28pXz1
         3qsgB5F5/OJiicdc6IrDKq333GfCOIoGSvaTiHTvUsQXuJf9sxQE96IvHrDMha1+6E1Q
         DtT3xOVNCNCvTB7qi4xbEgHO4OLouGyRKs+bztDdi7rBdSND6FXya6rSLiiaFGGnnPpx
         YKC1quaffDK6+en6Cg+lruw0SLBMbmFq9t18nkP4i9sex2onaxbYx0kAC3vS7/Bl79hR
         AE+A==
X-Forwarded-Encrypted: i=1; AKwUvBwQxQQe9DueiM1FPEoe4Vu8n1w9fXlgFDd81pQ44j+IEnNRjE9W/lClhgApJfWRk4u7erFUvOM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIMBc8IbxhoRI+Xfnc7O0tPmENXL6L3q+6hDaBB4gwMv+W9Ln7
	x/3IFTLmw+fWM+s9hM2XbQZRMCkQHIeKZY+QgmLHqHIjgA7OyUJ5nKfLMSiMf/TVin6kAYHjL1J
	LISz5hJ4T+pz8d8KXUrJs2PreP6YAVagPGj+KDtMBd5pzcnimpbnSnfvi+w==
X-Gm-Gg: AYBFou3ZogijNop+MtAKBKn19RsWCqSEYaOEduk3KgDSpVopReHbzBNIKF82rKSHX5r
	0I1ewsuJLF+w2v+1FSTHQXLtEUcFJzrYuMGfdefFpoKRrIWV+kfutyefrEgEqxC7kvSUICj7oON
	789x7Bhrfm6zYSX1KNOeXawGTgwrFswfz9KKGxf1XYUggbNVOfjDDflM+n5JDZtS8E8OjsbaYo0
	jepGcc+MSn6ldRlAX9uY48WFqKK3JdKCcbnU1rExevHaSb6KylNeZIZID6nFGvNusY3zv9OLn0d
	XxZgidcbAO+KKvCSHOifWqB17m4TAf6Hh9i1Sn/Q6ZblPAAL6mbytqowr4cDephiXe+L9w==
X-Received: by 2002:a05:6000:2209:b0:487:1575:ebef with SMTP id ffacd0b85a97d-48dbacf70c3mr35894018f8f.47.1792068100559;
        Thu, 15 Oct 2026 05:41:40 -0700 (PDT)
X-Received: by 2002:a05:6000:2209:b0:487:1575:ebef with SMTP id ffacd0b85a97d-48dbacf70c3mr35893947f8f.47.1792068099775;
        Thu, 15 Oct 2026 05:41:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df0f99f0bsm6536691f8f.21.2026.10.15.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:37 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	Chris Arges <carges@cloudflare.com>
Subject: [PATCH net-next v2 4/7] net: resolve uncommon partial checksums at
 ingress
Message-ID: <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792067836.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
others, credited below, found more ways the bug can affect users) a
virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
If that state is retained, later checksum completion can modify the
packet after protocol processing has made decisions from it.

Let's fix that: let's validate csum_start and csum_offset and only keep
CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
headers.  Complete other non-GSO checksums immediately, before any
protocol processing runs.

We can't easily "complete the checksum" for GSO we don't recognize - GSO
assumes knowledge of the protocol. We could segment ignoring the
checksum then do whatever csum_start and csum_offset say, but that
seems like an overkill for something that shouldn't happen.

There's some risk here:
- non-gso packets which can't be parsed get checksum calculated in
  software, adding performance overhead
- gso packets which can't be parsed get dropped

To mitigate the risks, the following patch will add a sysctl knob to
bypass the resolution. This is reasonable if the setup is such that
there is no protocol processing at all.

UDP tunnel headers get the same handling on the inner header.

Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.

Assisted-by: LLM
Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Reported-by: Chris Arges <carges@cloudflare.com>
Tested-by: Chris Arges <carges@cloudflare.com>
Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_net.h | 251 +++++++++++++++++++++++++++++++++++--
 1 file changed, 241 insertions(+), 10 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..357115ff0ec2 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -5,7 +5,11 @@
 #include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/netdevice.h>
 #include <linux/udp.h>
+#include <net/gso.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
 #include <net/tcp.h>
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
@@ -48,6 +52,171 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
+/* TODO: nothing virtio specific here, move to ip.h */
+
+/*
+ * Pull and minimally validate the IPv4 header at @nhoff.
+ * Returns the header and stores the transport header offset in
+ * @thoff, or NULL if truncated or malformed.  Only the fixed header
+ * is guaranteed linear; callers that need the options or the
+ * transport header must pull further.
+ */
+static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
+						  unsigned int nhoff,
+						  unsigned int *thoff)
+{
+	struct iphdr *iph;
+
+	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
+		return NULL;
+
+	iph = (struct iphdr *)(skb->data + nhoff);
+	if (iph->version != 4 ||
+	    iph->ihl < sizeof(struct iphdr) / sizeof(u32))
+		return NULL;
+
+	*thoff = nhoff + iph->ihl * sizeof(u32);
+	return iph;
+}
+
+/* Where does the L3 header start, and what protocol is it?
+ * Handles Ethernet and VLAN headers; other devices use the
+ * network header offset the caller set up.
+ */
+static inline bool
+virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
+{
+	if (skb->dev->type == ARPHRD_ETHER) {
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return false;
+		*nhoff = ETH_HLEN;
+		*proto = eth_hdr(skb)->h_proto;
+		if (eth_type_vlan(*proto)) {
+			*proto = __vlan_get_protocol(skb, *proto, nhoff);
+			if (!*proto)
+				return false;
+		}
+	} else {
+		*nhoff = skb_network_offset(skb);
+		*proto = skb->protocol;
+	}
+	return true;
+}
+
+/* Walk the L3 header at @nhoff: where does its transport header
+ * start, and which protocol is it?  Returns false if the header
+ * is truncated, malformed or fragmented.
+ */
+static inline bool
+virtio_net_l4_start(struct sk_buff *skb, unsigned int nhoff, __be16 proto,
+		    unsigned int *thoff, int *ip_proto)
+{
+	if (proto == htons(ETH_P_IP)) {
+		const struct iphdr *iph = virtio_net_ip4_parse(skb, nhoff, thoff);
+
+		if (!iph || ip_is_fragment(iph))
+			return false;
+		*ip_proto = iph->protocol;
+		return true;
+	}
+
+	if (proto == htons(ETH_P_IPV6)) {
+		const struct ipv6hdr *iph;
+		int flags = 0;
+
+		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
+			return false;
+		iph = (const void *)(skb->data + nhoff);
+		if (iph->version != 6)
+			return false;
+		*thoff = nhoff + sizeof(*iph);
+		*ip_proto = iph->nexthdr;
+		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
+			*thoff = nhoff;
+			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
+						  &flags);
+			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
+				return false;
+		}
+		return true;
+	}
+
+	return false;
+}
+
+/* Does checksum metadata match a known TCP or UDP header? */
+static inline bool
+virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
+				     unsigned int nhoff, __be16 proto)
+{
+	unsigned int thoff;
+	int ip_proto;
+
+	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
+		return false;
+
+	if (skb_checksum_start_offset(skb) != thoff)
+		return false;
+
+	switch (ip_proto) {
+	case IPPROTO_TCP:
+		if (skb->csum_offset != offsetof(struct tcphdr, check) ||
+		    !pskb_may_pull(skb, thoff + sizeof(struct tcphdr)))
+			return false;
+		break;
+	case IPPROTO_UDP:
+		if (skb->csum_offset != offsetof(struct udphdr, check) ||
+		    !pskb_may_pull(skb, thoff + sizeof(struct udphdr)))
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	case VIRTIO_NET_HDR_GSO_NONE:
+		return true;
+	case VIRTIO_NET_HDR_GSO_TCPV4:
+		return proto == htons(ETH_P_IP) && ip_proto == IPPROTO_TCP;
+	case VIRTIO_NET_HDR_GSO_TCPV6:
+		return proto == htons(ETH_P_IPV6) && ip_proto == IPPROTO_TCP;
+	case VIRTIO_NET_HDR_GSO_UDP:
+	case VIRTIO_NET_HDR_GSO_UDP_L4:
+		return ip_proto == IPPROTO_UDP;
+	default:
+		return false;
+	}
+}
+
+static inline bool
+virtio_net_csum_partial_ok(struct sk_buff *skb, u8 hdr_gso_type)
+{
+	int nhoff;
+	__be16 proto;
+
+	if (!virtio_net_l3_start(skb, &nhoff, &proto))
+		return false;
+
+	return virtio_net_csum_partial_ok_at_offset(skb, hdr_gso_type, nhoff,
+						   proto);
+}
+
+/*
+ * Handle a packet whose checksum metadata does not match the packet:
+ * GSO packets are dropped, as segmentation needs one checksum per
+ * segment; others are completed in software.
+ *
+ * Return 1 if the checksum was completed in software, else a negative
+ * errno.
+ */
+static inline int virtio_net_resolve_csum_partial_mismatch(struct sk_buff *skb)
+{
+	if (skb_is_gso(skb))
+		return -EINVAL;
+
+	return skb_checksum_help(skb) ?: 1;
+}
+
 static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 					  const struct virtio_net_hdr *hdr,
 					  bool little_endian, u8 hdr_gso_type)
@@ -158,8 +327,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 		case SKB_GSO_UDP_L4:
 			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
 				return -EINVAL;
-			if (skb->csum_offset != offsetof(struct udphdr, check))
-				return -EINVAL;
 			if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
 				return -EINVAL;
 			if (gso_type != SKB_GSO_UDP_L4)
@@ -167,10 +334,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 			break;
 		case SKB_GSO_TCPV4:
 		case SKB_GSO_TCPV6:
-			if (skb->ip_summed == CHECKSUM_PARTIAL &&
-			    skb->csum_offset != offsetof(struct tcphdr, check))
-				return -EINVAL;
-
 			BUILD_BUG_ON(TCP_MIN_GSO_SIZE * GSO_MAX_SEGS < GSO_MAX_SIZE);
 			gso_size = max(gso_size, TCP_MIN_GSO_SIZE);
 			break;
@@ -194,11 +357,36 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return 0;
 }
 
+/*
+ * Return value:
+ * 0 - success
+ * >0 - checksum was completed in software (slow path)
+ * <0 - failure
+ */
 static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 					const struct virtio_net_hdr *hdr,
 					bool little_endian)
 {
-	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
+	typeof(skb->transport_header) old_transport = skb->transport_header;
+	int ret = __virtio_net_hdr_to_skb(skb, hdr, little_endian,
+					  hdr->gso_type);
+
+	if (ret < 0)
+		return ret;
+
+	if (skb->ip_summed != CHECKSUM_PARTIAL ||
+	    virtio_net_csum_partial_ok(skb, hdr->gso_type))
+		return 0;
+
+	/*
+	 * Here we do not trust the checksum metadata.
+	 * __virtio_net_hdr_to_skb set the transport header to csum_start
+	 * from virtio hdr, restore it to a known good value.
+	 */
+	skb->transport_header = old_transport;
+	ret = virtio_net_resolve_csum_partial_mismatch(skb);
+
+	return ret;
 }
 
 /* This function must be called after virtio_net_hdr_from_skb(). */
@@ -282,6 +470,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
 	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
 }
 
+/* Do the tunnel offsets match the outer headers in the frame?
+ * The L3 header the tunnel claims must be the one the frame
+ * carries, with UDP following it at @outer_th.
+ */
+static inline bool
+virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
+			  unsigned int outer_th)
+{
+	int nhoff;
+	__be16 proto;
+	unsigned int thoff;
+	int ip_proto;
+
+	if (!virtio_net_l3_start(skb, &nhoff, &proto))
+		return false;
+	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
+		return false;
+	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
+		return false;
+
+	return ip_proto == IPPROTO_UDP && outer_th == thoff;
+}
+
+/*
+ * Return value:
+ * 0 - success
+ * >0 - checksum was completed in software (slow path)
+ * <0 - failure
+ */
 static inline int
 virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
@@ -293,6 +510,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	unsigned int inner_nh, outer_th, inner_th;
 	unsigned int inner_l3min, outer_l3min;
 	u8 gso_inner_type, gso_tunnel_type;
+	__be16 inner_proto;
 	bool outer_isv6, inner_isv6;
 	int ret;
 
@@ -332,10 +550,13 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	    inner_th < inner_nh + inner_l3min)
 		return -EINVAL;
 
+	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
+		return -EINVAL;
+
 	/* Let the basic parsing deal with plain GSO features. */
 	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
 				      hdr->gso_type & ~gso_tunnel_type);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* In case of USO, the inner protocol is still unknown and
@@ -353,7 +574,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	}
 
 	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-						 htons(ETH_P_IP));
+			    htons(ETH_P_IP));
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -368,7 +589,17 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	skb->inner_mac_header = inner_nh + skb_headroom(skb);
 	skb->transport_header = outer_th + skb_headroom(skb);
 	skb->encapsulation = 1;
-	return 0;
+
+	/*
+	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
+	 * set CHECKSUM_PARTIAL.
+	 */
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
+						 inner_proto))
+		return 0;
+
+	return virtio_net_resolve_csum_partial_mismatch(skb);
 }
 
 /* Checksum-related fields validation for the driver */
-- 
MST

