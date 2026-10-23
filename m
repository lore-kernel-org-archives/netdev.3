Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768186;
	b=vMmOrhTjG1ikW25+X2W54nl5mz47iSzXJliH7Eh+wEbL4TWU8QjWNDqczOMgDo7nBIzn
	 JHVt2xHbWcvcBeKbTnhS1k/8gjpuEkCqkHdbq8EeHP8qfxZeeXUwbCYXYJ2o+2JtZRLoH
	 ljCcsFYw1GRfVReP2Cu2xBCBCYdKCIOzIheDOfMbz0akxiKXQ7W4AUvoROeOHQtYWMPvS
	 mHL/wojRA3otZizlDpG7vbVQVHln+eunxSuiO+Yy+gwsyy5MdLK6alCDs5MNAcamX0jge
	 07qhIAqJeQIn32ZnjHBC+qyyIdTJvU5sV25WZqXz+Gu5Dd0OnBaZFYA25OkWj2YbDMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768186;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=ytuTyx5zqUg3e3n0tGXrxKR+0ExrfaUne6WVkZTy85c=;
	b=xmV4TfaPijt3Tuu+fpxBm9+jJsNH7NCRi5j5t98rXcB84UTz3DdlJkBla7Cqe0QERN1n
	 zdUTAFJstLY36WHgq08IUOl5wqSm0TXhdINpNW0T+OAys/n4Wvj8UpSJqqFk1oTXwG4jS
	 PBHvbI4NAJZUcdHD0IvQP4p/5OOJUcJ6N8eAlICrre8pkA2Xh612yYkEK/lwR5Ydv1iA2
	 WeTK+vTWxcEh4idqLGFsKQHKBRtUjueWHMm7q+MsrjK7M881mcxAKMyxOOCF+izACOasY
	 baF8YDheK3BkqDwXVEpQX0cpza+Al906GnUDHla/Cbu32S7P0Bywy2GHqWlmvkFTzBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V+vnOUtZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MOVhJtJ2;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189260A380A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9189260A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V+vnOUtZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MOVhJtJ2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ytuTyx5zqUg3e3n0tGXrxKR+0ExrfaUne6WVkZTy85c=;
	b=V+vnOUtZvKjbalG1BTafk46/5jOxMutUNHdJRotVjGbrZkVGeZLjGwXVnHXT9974mLtQlz
	QbLzsTkRfIGort6xn+UMuXRd87tfOyCln4sC5uLrGgCgvT9QUU1qgbcJ8UNPA56TPceG1I
	HS6qurcPFlG7/Rx5xOPG2jBJ8Dkhxjo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-FsvZoJGTMGaIZ--hfzODjQ-1; Fri, 23 Oct 2026 11:09:43 -0400
X-MC-Unique: FsvZoJGTMGaIZ--hfzODjQ-1
X-Mimecast-MFC-AGG-ID: FsvZoJGTMGaIZ--hfzODjQ_1792768182
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2000d5ebeso7745695e9.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792768182; x=1793372982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ytuTyx5zqUg3e3n0tGXrxKR+0ExrfaUne6WVkZTy85c=;
        b=MOVhJtJ2peX1EYhbngaBSYoAofWAKiTWZ11fj3OwdnFrOa+IO8/74tcAYQzbOI8SGr
         LtjHI4fUqcPWNyjdvRuLd2Fr0Pzmr1cDPniCVeq3CrG386mEntEdGmht8Xi5s8V1s4Y/
         4JsDjRbpBedLZn5oa8v7HWyFZpGAgPRwQAWyJowiJHG7wo54nmiiecSQVf2S9IJsf0ZY
         ObaWyW7eRDYNHKeUyrM+NrnztlkfKlMpHcubIh/9bNf+MkKTp1Zjh8bfptTv6p36OJYU
         cDuMbgefS4AW0hIBzqascKieMqSm77+s91nlKaLkCtsshi+cGHAzbqDlWGwK2dfnJ+on
         klIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768182; x=1793372982;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ytuTyx5zqUg3e3n0tGXrxKR+0ExrfaUne6WVkZTy85c=;
        b=sz+Ntv5B1bVvmLqqxhM2fw2I2LozHYd4EDVysAFMIKMoyS1JcRSsljJP83jxtfu6Vi
         jrR02mB35JHpCp55gyQ8ZlbfoLxKvX0z4poBJgqu74pPcv8xWyQHiIx/b/xhBQrLKOoU
         rEv1q0gyO2BCQLzSCYHJztqL5PnT238c3UTN1JJgx5No1kSeO3DOhR9XSRFeFttMyTjH
         BQ+pojTFtilGhaexjP8PuA+tEoGmCadzBb0ZvGi9z8e15HLy5Epp31C52PBQySSt0aXx
         7QvpINBCbH2fPj+UWTAFkSZvdqlMXhKTtAT6HSNJOllTpE6mRTC/NI7KwSfy5yI9JOUr
         4tPA==
X-Forwarded-Encrypted: i=1; AKwUvBzpT+7VuyiBvFwut4GVn5sM/NwfsVc7L0FxuNC9MnAbfpxgfjvun42wTOsBzC4JbQUHTCyn2/k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiPcmpZZbfTbE7UP3UAiq8c+QzI6+tcjp+VURW26TmcrsSVizH
	h5yT1rbYpIyZlyObkovoDhODBT7dPD7VBhIBhsyKOdebGhd1qDlcgCS/xp+5Z7O/5VWEhz35z3D
	ZsCYDHHT7UdJK05nCdOXF8PvLMQcUUuG58kjthGgW7+txsSUVuLorthy5Pg==
X-Gm-Gg: AYBFou2wl6J9VSqmYejBFpXAQ2DwAfLc27jQLj9YbbCx1bk0FnflpGOJfUdfzex064q
	M+Q0HOpL8JbkisVnCKa/sVX8ndj3ZAmY+AWZX4aI7BQhlGje2gyJ62H6DrMjUOTMz70jY2hv7iI
	ydUoeWJR3jL6LWUExNuz0vO+ySaF2fFgDAuQ31HcgoI+AQdXK+pva3MypqRQbAjPEKKLQqn8Ohq
	0r3nLltGD9fetY/HwPIeeeDgjlU5Doo/UgLIjvMrNKFFZX/5rxuiZDJxz7UFUBX2N7hR0kpcHvT
	n7RWb6pxabfTk6Wbnt3kN2jGyGWlJeWMpiV8d7wBgoqEY/297T+FNm4S6sdR1MbKSIUoXac=
X-Received: by 2002:a05:600c:3511:b0:4a2:d99:3171 with SMTP id 5b1f17b1804b1-4a211f0411cmr44905345e9.23.1792768181471;
        Fri, 23 Oct 2026 08:09:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3511:b0:4a2:d99:3171 with SMTP id 5b1f17b1804b1-4a211f0411cmr44904655e9.23.1792768180848;
        Fri, 23 Oct 2026 08:09:40 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d3f9d0dsm444711f8f.22.2026.10.23.08.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:39 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:09:37 -0400
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
Subject: [PATCH net v6 4/5] net: resolve uncommon partial checksums at ingress
Message-ID: <bd468c7ea5468d6e3827a3c678eee15243615580.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
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
In-Reply-To: <cover.1792768096.git.mst@redhat.com>
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
    v5->v6:
        read both skb->protocol and the frame ethertype: do not
        validate when they disagree, instead of preferring the
        preset protocol; same check after the IP version inference
        where there is no L2 header (Willem de Bruijn)
        pull the IPv4 options in the helper as introduced, with the
        transport header offset computed before the pull
        (Willem de Bruijn)
        fold the trivial protocol calculation cleanup, formerly a
        separate patch, in (Willem de Bruijn)

 include/linux/virtio_net.h | 292 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 287 insertions(+), 5 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 013c6c7e2dea..14120710d075 100644
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
@@ -48,6 +52,214 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
+/* TODO: nothing virtio specific here, move to ip.h */
+
+/*
+ * Pull and minimally validate the IPv4 header at @nhoff.
+ * Returns the header and stores the transport header offset in
+ * @thoff, or NULL if truncated or malformed.  The whole header,
+ * options included, is guaranteed linear on return.
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
+	/* Pull the options as well: the transport header offset
+	 * returned above must be within the linear data.  iph goes
+	 * stale across the pull.
+	 */
+	if (!pskb_may_pull(skb, *thoff))
+		return NULL;
+
+	return (struct iphdr *)(skb->data + nhoff);
+}
+
+/* Where does the L3 header start, and what protocol is it?
+ * Handles Ethernet and VLAN headers; other devices use the
+ * network header offset the caller set up.
+ */
+static inline bool
+virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
+{
+	/* skb->dev should always be set here already,
+	 * but let's not crash when it is not.
+	 */
+	if (WARN_ON_ONCE(!skb->dev))
+		return false;
+
+	if (skb->dev->type == ARPHRD_ETHER ||
+	    skb->dev->type == ARPHRD_LOOPBACK) {
+		__be16 h_proto;
+
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return false;
+		h_proto = eth_hdr(skb)->h_proto;
+		/* skb->protocol is a sender claim, and parts of the
+		 * stack parse the packet per it: when it disagrees with
+		 * the frame we do not know which view the packet will
+		 * be parsed as, so do not validate.
+		 */
+		if (skb->protocol && skb->protocol != h_proto)
+			return false;
+		*nhoff = ETH_HLEN;
+		*proto = h_proto;
+		if (eth_type_vlan(*proto)) {
+			*proto = __vlan_get_protocol(skb, *proto, nhoff);
+			if (!*proto)
+				return false;
+		}
+	} else {
+		const struct iphdr *iph;
+
+		*nhoff = skb_network_offset(skb);
+		/* An unset network header shows up as an offset
+		 * outside of the packet.
+		 */
+		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
+			return false;
+		/* No L2 header to cross-check with: take the protocol
+		 * from the IP version at the network header.
+		 */
+		if (!pskb_may_pull(skb, *nhoff + 1))
+			return false;
+		iph = (const struct iphdr *)(skb->data + *nhoff);
+		if (iph->version == 4)
+			*proto = htons(ETH_P_IP);
+		else if (iph->version == 6)
+			*proto = htons(ETH_P_IPV6);
+		else
+			return false;
+		if (skb->protocol && skb->protocol != *proto)
+			return false;
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
@@ -194,11 +406,35 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
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
@@ -282,6 +518,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
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
@@ -293,6 +558,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	unsigned int inner_nh, outer_th, inner_th;
 	unsigned int inner_l3min, outer_l3min;
 	u8 gso_inner_type, gso_tunnel_type;
+	__be16 inner_proto;
 	bool outer_isv6, inner_isv6;
 	int ret;
 
@@ -335,9 +601,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
@@ -352,8 +621,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-						 htons(ETH_P_IP));
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -368,7 +637,20 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
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
+	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
+						 inner_proto))
+		return 0;
+
+	return __virtio_net_resolve_csum_partial_mismatch(skb);
 }
 
 /* Checksum-related fields validation for the driver */
-- 
MST

