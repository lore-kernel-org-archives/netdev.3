Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673916;
	b=lhVef0G0bPwSDMfRP/3NvkxrON5bJM+Xrju9U2IQPA96GJUN6oPCsVV3C2zimOHb/krS
	 XtS4rI3yiye5X30Kc87OJtGb90AHR7WwFBgCDdFk5tXiHBbgfDEp2onCJvC4CAjfkfdqo
	 QKgAKdE08w2iZig3r6aPHozwMsu9KVXHU+xeoO1M2pIRBAYPXVWwOUCfXp5xhkjhN9G5P
	 789MiVSY9OWO12lQWFZuSHDNUx+GJtaDThnULLSaU8BXyKd2oOwzqiXFTzN/+GulgMamk
	 qP3G5i4YWn+qr0IntnmaVxFEv+Dbsr3/pc3iI6kOvts7P6umjMUSkoGXtiC0eBS/74g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673916;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=kotNI+NV8koDhHE4Okh6cXBlCdjWFXScAsrnexeAUHw=;
	b=tTUbBW4vKUBHniW8EeAiDynieiAeLxeymNElfz2VG1NIQyQYgv7ZVSjmBf1e7nBj+vKf
	 GaMUhp055wCP0JKcGGdYYpT85z8rsYN3Avgak+Q4PjBpOQOAUbB0b3kRKmg1uqqhrIxCy
	 /CnzXSEgWdvKg2Dkdl3517UW1zgboVsoeagtilbS0wpSlAtcOy8YY5a9YxaUFoWWNjwXh
	 zJ/L/8QcmsBJndUrpYczhUmiXPUKnDYqGSBhwYXtkJ2SM/a33ZB7SDYqI7u75O1vMWjSj
	 xstshehxOq7om2ZO/DXiEGGrxcSoGnDin1BRP+AIPTeNoDPloI99/uBq2kiO3Ewe0AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BVhAC2n9;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QMG4QEV4;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91660A2620
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B91660A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BVhAC2n9;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QMG4QEV4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kotNI+NV8koDhHE4Okh6cXBlCdjWFXScAsrnexeAUHw=;
	b=BVhAC2n9JHxM49DObKbM/nuVFdvR++IGzarXFA41LE4K3BhErEFn/oOrysfvi8p62IOowd
	TzJxsMR3jtMyY9C9wgiFm48bR97IY1l5EJjZfp6oQbyjykN/cxl0U+WlLx4QoxJF5Gf19o
	Xrey7lwtaJ0eOnVKNTqhehZX6BCIpeo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-7muvhXGON4aA1Dy9FscdTw-1; Thu, 22 Oct 2026 12:58:27 +0000
X-MC-Unique: 7muvhXGON4aA1Dy9FscdTw-1
X-Mimecast-MFC-AGG-ID: 7muvhXGON4aA1Dy9FscdTw_1792673906
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so1051700f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792673906; x=1793278706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kotNI+NV8koDhHE4Okh6cXBlCdjWFXScAsrnexeAUHw=;
        b=QMG4QEV49fZe5ws1VbdM/x5dcWdh0Ve//Fsm8F8xqXVGUxxte0UD5HXhJSrDzxZjkM
         FNxMPsPVBcPFYggBYvMxaUoouadikrargATm4CYDLE5wQsuj35kxXxQAuzR4+pg/Wap0
         F/YKWRmHulkBym/Ct/N37epnpSrINSnRBnSIWAv06ekei6+U7sJas3xonCxNbVJUb/tF
         o9uX7+Dyk2cRFWu6QhDI0xrgdYxjGOE2PH6R2htPa2A18DLXaBqwoudI9K71vvEO8SWx
         YfLB1Nerj51GJ5gLqMrAy7doAqiN3B8A4WW+VtjNmwR1boaMSFc2HcuF1RkzShvYTQCz
         RcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673906; x=1793278706;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kotNI+NV8koDhHE4Okh6cXBlCdjWFXScAsrnexeAUHw=;
        b=PUya2VuTVapQxmBUMWOXgppq/GMAKf8O1Sw78UrQXcmSg8mIjJQhZ7/CRXkZZOCPzh
         rkvJc/mrX4uQp9Mrn1qjJvdBRW4VggVLTwPJqareQPJBjC/fmajLr2cGTErJlBmOuLJz
         EOAN8QVsa2LN2eoXvUt1wPMIOUhONDiejFKC/FnJVdvUeSvYAovRigRag76/rosOwLBi
         /9VMh2wf3UagnSOPua68kbZ02MLDvSkEYk4kFQ60nCZ7vHUmIOBmKyKA+q7InyA+0xya
         bMDJexJGckNTG/f49y3gHiBFJNMjgeTkUaY0nqU8/pqvSMPDeL54acUXVEnXdepm8QTA
         DMMw==
X-Forwarded-Encrypted: i=1; AKwUvBxCQe7Q58W9KlVeL+CncvF24heM1xVWHneXu0pkw4Be61OOcFQr4gGY35+3ZI9m7sH49Tt0H/k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnVIaUn3H0e2juzeGQPF9dSEJoKXRHIXQ31XRmoj2jkB77vi9W
	77AVgfT3ZjxARb8UeAQ/rTKXUmuTxjhtIQigY09R9FBCdlOwmAjGdoXsbtKeG7Y5Xzxoy5RiPwC
	z7lJbCWD6lC+Ue94PXvc4W/1pfbwQjDdU8s/rkWCjGKBo37z9u7rai1tVXg==
X-Gm-Gg: AYBFou16ypAQwTw1PQbJLKE1VUbNNKTjjEcuLl8LEj/3Pu3fbPwF0oI80yeEEW9jDgz
	fs79wyLxU/Jfa9pxi2S95vbkQstiwfkhOdseC0epQLsk66TqVnKPAqX3aMiMbtV4NGq55h2u2yL
	J8pfPf41iKUvVff44EejODLJCavo2OCv8Jl1dWs11GLAwCIbkdx5z3im1ZA7yBLNRBxV/1Dfazs
	b4ei4cSShs1202156LOkDvS2gsw5YLp2HzBqv8udWBJ0uhIEQIO7KBo0AMiXhQXb+rWU7LBKnGI
	G+QUYTE+9ILyj/oowHDb++3JQNe7+hrH24jdtucWumCSlZHM/2BU7PRtQBd5s6GQp1Q=
X-Received: by 2002:a05:6000:186b:b0:48d:fdc0:8bf2 with SMTP id ffacd0b85a97d-48e264d6ac5mr10492454f8f.41.1792673905630;
        Thu, 22 Oct 2026 05:58:25 -0700 (PDT)
X-Received: by 2002:a05:6000:186b:b0:48d:fdc0:8bf2 with SMTP id ffacd0b85a97d-48e264d6ac5mr10492388f8f.41.1792673904824;
        Thu, 22 Oct 2026 05:58:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f093asm12758884f8f.4.2026.10.22.05.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:58:21 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:58:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: [PATCH net v5 4/7] net: resolve uncommon partial checksums at ingress
Message-ID: <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.v5.git.mst@redhat.com>
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

Note that for zero copy, userspace can change the data after the
checksum has been calculated.  This is fundamental to zero copy by
design, and the only outcome is a bad checksum and a packet drop.

To mitigate the risks, the following patch will add a sysctl knob to
bypass the resolution. This is reasonable if the setup is such that
there is no protocol processing at all.

UDP tunnel headers get the same handling on the inner header.

Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.

Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Reported-by: Chris Arges <carges@cloudflare.com>
Tested-by: Chris Arges <carges@cloudflare.com>
Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    v4->v5:
        caller changes moved to "account for ingress-resolved
        virtio net hdr state" (Willem de Bruijn)
        a packet too small to be GSO: ignore the tunnel GSO request,
        complete wild metadata in place (sashiko)
        document the zero copy interaction (sashiko)
        honor a preset skb->protocol on ethernet: the stack uses it,
        except on loopback which re-parses the frame (sashiko)

 include/linux/virtio_net.h | 283 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 279 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 013c6c7e2dea..52852a33a2db 100644
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
@@ -48,6 +52,205 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
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
+	/* skb->dev is only guaranteed to be set since 44378d02c5aa
+	 * ("net: always dissect GSO packets in
+	 * __virtio_net_hdr_to_skb()"), do not crash when it is not.
+	 */
+	if (WARN_ON_ONCE(!skb->dev))
+		return false;
+
+	/* A preset protocol is what the stack will use, except on
+	 * loopback which re-parses the frame: loopback_xmit() calls
+	 * eth_type_trans() on it.
+	 */
+	if (skb->dev->type == ARPHRD_ETHER ||
+	    skb->dev->type == ARPHRD_LOOPBACK) {
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return false;
+		*nhoff = ETH_HLEN;
+		*proto = skb->protocol;
+		if (!*proto || skb->dev->type == ARPHRD_LOOPBACK)
+			*proto = eth_hdr(skb)->h_proto;
+		if (eth_type_vlan(*proto)) {
+			*proto = __vlan_get_protocol(skb, *proto, nhoff);
+			if (!*proto)
+				return false;
+		}
+	} else {
+		*nhoff = skb_network_offset(skb);
+		/* An unset network header shows up as an offset
+		 * outside of the packet.
+		 */
+		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
+			return false;
+		*proto = skb->protocol;
+		if (!*proto) {
+			const struct iphdr *iph;
+
+			/* A packet socket bound to ETH_P_ALL leaves the
+			 * protocol unset: infer it from the IP version
+			 * at the network header.
+			 */
+			if (!pskb_may_pull(skb, *nhoff + 1))
+				return false;
+			iph = (const struct iphdr *)(skb->data + *nhoff);
+			if (iph->version == 4)
+				*proto = htons(ETH_P_IP);
+			else if (iph->version == 6)
+				*proto = htons(ETH_P_IPV6);
+		}
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
+			/* Find the transport header behind any
+			 * extension headers, AH included.
+			 */
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
+ */
+static inline int __virtio_net_resolve_csum_partial_mismatch(struct sk_buff *skb)
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
@@ -194,11 +397,35 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
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
+
+	return __virtio_net_resolve_csum_partial_mismatch(skb);
 }
 
 /* This function must be called after virtio_net_hdr_from_skb(). */
@@ -282,6 +509,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
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
@@ -293,6 +549,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	unsigned int inner_nh, outer_th, inner_th;
 	unsigned int inner_l3min, outer_l3min;
 	u8 gso_inner_type, gso_tunnel_type;
+	__be16 inner_proto;
 	bool outer_isv6, inner_isv6;
 	int ret;
 
@@ -335,9 +592,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	/* Let the basic parsing deal with plain GSO features. */
 	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
 				      hdr->gso_type & ~gso_tunnel_type);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
+	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
+		return -EINVAL;
+
 	/* In case of USO, the inner protocol is still unknown and
 	 * `inner_isv6` is just a guess, additional parsing is needed.
 	 * The previous validation ensures that accessing an ipv4 inner
@@ -353,7 +613,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	}
 
 	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-						 htons(ETH_P_IP));
+			    htons(ETH_P_IP));
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -368,7 +628,22 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	skb->inner_mac_header = inner_nh + skb_headroom(skb);
 	skb->transport_header = outer_th + skb_headroom(skb);
 	skb->encapsulation = 1;
-	return 0;
+
+	if (!skb_is_gso(skb))
+		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
+					       SKB_GSO_UDP_TUNNEL);
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
+	/* A tunnel header implies GSO, so drop. */
+	return __virtio_net_resolve_csum_partial_mismatch(skb);
 }
 
 /* Checksum-related fields validation for the driver */
-- 
MST

