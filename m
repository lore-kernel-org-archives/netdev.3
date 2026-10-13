Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADBF4E7807
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889136; cv=none; b=cAZi5FrXeaJZ8K3MtwMAUZchEMdZEjTh5hIH3dYB9yeswfavaZ2h7jscywOVbICRZxlLQmCwuKr9cSK8mhWif+0vnjVC7kUhBxPf/U90XMA/3cOhitPomK215oy/qaCPm2p78zd2P8lKfvgMAN9d4LOItCkRTOgMYU5gwJIoFn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889136; c=relaxed/simple;
	bh=V6Y2OOfILu8iRugw/J/2pGAy0cZHF3UrQwmkRmjqG+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A85ROgjyt/dKIDqfXCw0vom+ueNJONPVuH20t9Z/FjwKXVyyY3fpk7+HaItxmR9Z9uplbP1DYqC9RRPB3kzSDzGmOZWG+MO8EwbvyvAS/qo8qGyaH7M9dmyNxWqe46xcknAd1O2E1rtUU5QoEOUXT0XcZ+3IVUiTuaah3MFdsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByX1hwzy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayvgWqtH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByX1hwzy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayvgWqtH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791889126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iG/7dIFT0k9x6q+NzOMLKquGeR/nbsX1KREm+Zvlnnc=;
	b=ByX1hwzyjBas6WyrJ+2jDGb8bNgQf2DWhf//XRykB98sX0XPgGmo4i4HfA44+NRUVO0KOM
	VC55zBdcima9ZhhwXOgao3JRNTSpp+2ZcVaKSO3dsAj9hQJwNGY8FvvK5uJawcG/+JZwiX
	CzvUjau5P5Q/dMyqYiAdGfxKvxA8owk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-ztQB-M28OU22YjDVdy2wHA-1; Tue, 13 Oct 2026 10:58:44 +0000
X-MC-Unique: ztQB-M28OU22YjDVdy2wHA-1
X-Mimecast-MFC-AGG-ID: ztQB-M28OU22YjDVdy2wHA_1791889124
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b00febba3so2291203f8f.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791889123; x=1792493923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iG/7dIFT0k9x6q+NzOMLKquGeR/nbsX1KREm+Zvlnnc=;
        b=ayvgWqtH+tImDjAtgAowF4WTjBtUT7HJvLUjKVv+GsmEk5dIPb1aWLBM+RMeuVFaUK
         Rp3XM+DDnTmur5lKJ3zZbBW+0flKY8+lMonV2XPHClNtoqOcROmppSPYCR1LuaG8saSC
         6J+ErfVHkztTkBLb+pC21wBrh62rn1VeGjH2KX4y8sm2yqrul7WZFtq1ZanUjQBkKBLj
         GvW+V2zW28viw1+blXvuv/F/aXgC9BQ8M2JM/iRQ/ko4EY2KRFQjRGq0MA6vWuAuff2c
         pogonCswajJrSXYxLU5R1ZaL1kywokyAr6254FOR+AwAZ63/FQiiRbycVwLSIR3H0Abx
         J4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889123; x=1792493923;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iG/7dIFT0k9x6q+NzOMLKquGeR/nbsX1KREm+Zvlnnc=;
        b=PDtksf9Lsd8QCG5t7BdN54IhtDBtMoZdpX2dxWghHW6zFZimeYG43w3ponvrS6Oe5i
         8l8gLWNgfnV1EpI0WzUyae2HrjVQJifAqpQ+DJHwRX+WX4B+cgQ1XsWapPLTmAZL1Sjc
         RVC6wWztNGyQLcRXoTbFztSR/SxKWLvVIjEK68yD4rxBnbUYCzXFhAC+MgHGvKsAKBzF
         ALm5asJL6FXCvPKJjDwtwcqEIwt18Jm5D5q8nEbr0sIzHcWSxAjnmxHcf/La+B9tkeyI
         TtAuDUgvfUhxURTsTKQ+ehVOKit9Ft/1hR4mx9UZ4LkjPofKuMEv3Dq0VJY0nha/x3h8
         mY5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwdg/i0uwrxQHt5E8i2B7Y8MYXSj76WxLjo4kgHrRfMmwT90A1kRpnA5VgPreISdWpwUk62ZrE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnVf4c7z6p1pHejx2XtBLk0MT3p/tQ3OHTsxOR9bLMkgwWg3Xg
	ggREHeHU3//E7iIDql2YlnfZiKll0LsaE5MpsgSu6/yjgP2C61pcX9clUXcb4Km3At5O8kTqRWi
	6VQx4PnNKV6oxsBPZh5MF3s9GEvEpytGO1xltx9jFwvi99csPT9E2/2KUUTPDlm4epQ==
X-Gm-Gg: AYBFou0ZAGuRzZkcYnQJ3sPQdrLc0+rkaZtlC5jFKCCCYw/rjhihAD0gWBq9XjjZ1oK
	9ZwS0gvmSa9PqtdYbDCDjsWGj7JmHPKYwo9Dz3Gl2rN9fpKpW7vQG39VQ+aKrswIkOG6ECG7fiB
	bYVDJUKVt6RdlRuHWWbfrn7+uxVyTBBactAA+AcJDBp+2ZXwfM9eUfioqTQ/QgEdq0u0xCzZMmY
	ibe80YPQnkLtSFV6Q4Q3dMQ2vUzj2cN+x/PVmfb7Wd8bqrA1wvkT795QS0Tx2FwgiQW5l1F6qbf
	fBknQNULgKWjvqBt0z3pxdUERGgmnRXyHUaSVo8rD1kP/eKf/27sSnKujNxMR7ugBriYoQ==
X-Received: by 2002:adf:e010:0:20b0:48d:e5c9:39a4 with SMTP id ffacd0b85a97d-48de5c93a10mr1026288f8f.33.1791889123151;
        Tue, 13 Oct 2026 03:58:43 -0700 (PDT)
X-Received: by 2002:adf:e010:0:20b0:48d:e5c9:39a4 with SMTP id ffacd0b85a97d-48de5c93a10mr1026165f8f.33.1791889121293;
        Tue, 13 Oct 2026 03:58:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6ddcsm4439578f8f.52.2026.10.13.03.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:58:39 -0700 (PDT)
Date: Tue, 13 Oct 2026 06:58:37 -0400
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
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH net-next 3/4] net: resolve uncommon partial checksums at
 ingress
Message-ID: <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
References: <cover.1791887415.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791887415.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

A virtio net header can place CHECKSUM_PARTIAL at any in-packet
offset.  If that state is retained, later checksum completion can
modify the packet after protocol processing has made decisions from it.

Let's fix that: let's validate csum_start and csum_offset and only keep
CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
headers.  Complete other non-GSO checksums immediately, before any
protocol processing runs.

We can't easily "complete the checksum" for GSO we don't recognize - GSO
assumes knowledge of the protocol. We could segment ignoring the
checksum then do whatever csum_start and csum_offset say, but that
seems like an overkill for something that should happen.

UDP tunnel headers get the same handling on the inner header.

Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.

Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 include/linux/virtio_net.h | 151 ++++++++++++++++++++++++++++++++-----
 1 file changed, 133 insertions(+), 18 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd00..b181183118b3a 100644
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
@@ -48,15 +52,111 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
+/* Does checksum metadata match a known TCP or UDP header? */
+static inline bool
+virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
+				     unsigned int nhoff, __be16 proto)
+{
+	unsigned int thoff;
+	int ip_proto;
+
+	if (proto == htons(ETH_P_IP)) {
+		const struct iphdr *iph = ip4_parse(skb, nhoff, &thoff);
+
+		if (!iph || ip_is_fragment(iph))
+			return false;
+		ip_proto = iph->protocol;
+	} else if (proto == htons(ETH_P_IPV6)) {
+		const struct ipv6hdr *iph;
+		int flags = 0;
+
+		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
+			return false;
+		iph = (const void *)(skb->data + nhoff);
+		if (iph->version != 6)
+			return false;
+		thoff = nhoff + sizeof(*iph);
+		ip_proto = iph->nexthdr;
+		if (ip_proto != IPPROTO_TCP && ip_proto != IPPROTO_UDP) {
+			thoff = nhoff;
+			ip_proto = ipv6_find_hdr(skb, &thoff, -1, NULL,
+						 &flags);
+			if (ip_proto < 0 || flags & IP6_FH_F_FRAG)
+				return false;
+		}
+	} else {
+		return false;
+	}
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
+	unsigned int nhoff;
+	__be16 proto;
+
+	if (skb->dev->type == ARPHRD_ETHER) {
+		if (!pskb_may_pull(skb, ETH_HLEN))
+			return false;
+		nhoff = ETH_HLEN;
+		proto = eth_hdr(skb)->h_proto;
+		if (eth_type_vlan(proto)) {
+			proto = __vlan_get_protocol(skb, proto, &nhoff);
+			if (!proto)
+				return false;
+		}
+	} else {
+		nhoff = skb_network_offset(skb);
+		proto = skb->protocol;
+	}
+
+	return virtio_net_csum_partial_ok_at_offset(skb, hdr_gso_type, nhoff,
+						   proto);
+}
+
 static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 					  const struct virtio_net_hdr *hdr,
-					  bool little_endian, u8 hdr_gso_type)
+					  bool little_endian, u8 hdr_gso_type,
+					  bool need_csum_check)
 {
-	unsigned int nh_min_len = sizeof(struct iphdr);
+	typeof(skb->transport_header) old_transport = skb->transport_header;
 	unsigned int gso_type = 0;
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
 	unsigned int ip_proto;
+	bool csum_partial_ok = true;
 
 	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -69,7 +169,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 			gso_type = SKB_GSO_TCPV6;
 			ip_proto = IPPROTO_TCP;
 			thlen = sizeof(struct tcphdr);
-			nh_min_len = sizeof(struct ipv6hdr);
 			break;
 		case VIRTIO_NET_HDR_GSO_UDP:
 			gso_type = SKB_GSO_UDP;
@@ -104,11 +203,11 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
-		if (skb_transport_offset(skb) < nh_min_len)
-			return -EINVAL;
+		if (need_csum_check)
+			csum_partial_ok =
+				virtio_net_csum_partial_ok(skb, hdr_gso_type);
 
-		nh_min_len = skb_transport_offset(skb);
-		p_off = nh_min_len + thlen;
+		p_off = skb_transport_offset(skb) + thlen;
 		if (!pskb_may_pull(skb, p_off))
 			return -EINVAL;
 	} else if (gso_type) {
@@ -158,8 +257,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 		case SKB_GSO_UDP_L4:
 			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
 				return -EINVAL;
-			if (skb->csum_offset != offsetof(struct udphdr, check))
-				return -EINVAL;
 			if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
 				return -EINVAL;
 			if (gso_type != SKB_GSO_UDP_L4)
@@ -167,10 +264,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
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
@@ -191,6 +284,17 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 		}
 	}
 
+	if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && !csum_partial_ok) {
+		int err;
+
+		if (skb_is_gso(skb))
+			return -EINVAL;
+
+		err = skb_checksum_help(skb);
+		skb->transport_header = old_transport;
+		return err;
+	}
+
 	return 0;
 }
 
@@ -198,7 +302,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 					const struct virtio_net_hdr *hdr,
 					bool little_endian)
 {
-	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
+	return __virtio_net_hdr_to_skb(skb, hdr, little_endian,
+				       hdr->gso_type, true);
 }
 
 /* This function must be called after virtio_net_hdr_from_skb(). */
@@ -293,6 +398,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	unsigned int inner_nh, outer_th, inner_th;
 	unsigned int inner_l3min, outer_l3min;
 	u8 gso_inner_type, gso_tunnel_type;
+	__be16 inner_proto;
 	bool outer_isv6, inner_isv6;
 	int ret;
 
@@ -334,7 +440,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 
 	/* Let the basic parsing deal with plain GSO features. */
 	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
-				      hdr->gso_type & ~gso_tunnel_type);
+				      hdr->gso_type & ~gso_tunnel_type, false);
 	if (ret)
 		return ret;
 
@@ -352,8 +458,8 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 	}
 
-	skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
-						 htons(ETH_P_IP));
+	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
+	skb_set_inner_protocol(skb, inner_proto);
 	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
 		if (!tnl_csum_negotiated)
 			return -EINVAL;
@@ -368,7 +474,16 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	skb->inner_mac_header = inner_nh + skb_headroom(skb);
 	skb->transport_header = outer_th + skb_headroom(skb);
 	skb->encapsulation = 1;
-	return 0;
+
+	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
+					       inner_proto))
+		return 0;
+
+	if (skb_is_gso(skb))
+		return -EINVAL;
+
+	ret = skb_checksum_help(skb);
+	return ret ?: 1;
 }
 
 /* Checksum-related fields validation for the driver */
-- 
MST

