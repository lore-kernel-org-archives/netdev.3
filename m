Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347B4C6516
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391107; cv=none; b=TWy+O4fAPmWS3+zaR9v6cXLiuJy0KDytapd8b0ErITVJOxGZ1+Sl5pCW2vCB1X0Whqq2ZhHnumjc55uSX5x2u7c/13afuwAsxrysmcJnltcTRr/yeWUHENqS8sHPUvry9r2PGtTSyFMgh9/7nXS4dH1OkP6j/UX4ptNNXinWewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391107; c=relaxed/simple;
	bh=DcdBY7755Rd5gd8U7NHQN4y20vW61aEMrNttD8iRhKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uovXjyPO+h1PoRyGLPq7YvAiBtzTTV9Z6GkbFi7s8WgPzzs+a4wazvb3PGHNOgCEytJr8uw8G05koCmeg/MgutNV2MOT4V3yLRSvMBRZmfZdm4pqMyqxpUVFWeEW4io2rWt6kUjLFSHorlr0o39Bfon8lQ2vH1QpQehrIyoJXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjAge1dD; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjAge1dD"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-677d35fd1d2so3655563d50.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791391105; x=1791995905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PVlFK3AS1FLINdj696y1yUeai/6mvMjKMqfoTZW+i9A=;
        b=mjAge1dDai7d/W3xCJHwGlPw+qomhAwWiugzTKL+l8W8sHDmWnpkSR4tU8RAIEL0Sj
         JpI8iF7R6djaVQg2uFQosxZAj/S2CcAUZfttRaNzq42KJPK7ZV/g+VdMQ3LKAPpLzIoi
         kILl3hzRFaLEL9TUyXv42BitzZv0KAIRSTggNCtnWKY2SgVVPdf9AvZXrh0fL1qJF0l+
         ltAcnClgEicM+vBJO4Jf+GYyjWMsfBY6wfQ7tCizE/l6C/Lub/Uccocmq2P5tdBCknYM
         bqaXmTKGcaYSB6ANroOBOUTVZIaHJ6AlZdDwjd2ujBbp9V2ullz/Qz6QgHgletPOe6ll
         ouBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791391105; x=1791995905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVlFK3AS1FLINdj696y1yUeai/6mvMjKMqfoTZW+i9A=;
        b=X6cQor+YOtnmUWYdGt3NnAnN5gxTcldKtiHkgB6I9qVsv/7tp6PgWsXH0X7bjihXZr
         GmjXU3nheVm8nB09hPUtq5G7XSec6f4u84BxSz8d3D1smmacKRej8H9FD28jXiB2VJBY
         AyMcYSMrt3pmyBsd/jzh6COUWHVMwCUnz21BHXw2MNOr6kuy8VDpXWJ3akrcxwlxRBaQ
         KATvHKTfHz0p3jte8L9xaFPcR8IiC8zsUIBHA2+87NiyXs5lTmC7viVrCDk1UtX80b2z
         A5QedzNu+Rp8rP4uxVeUDbx43E+yjrXKaR885O+nQNhfBw5u+ExYTA3305H8PuL/CLLB
         M9Eg==
X-Gm-Message-State: AFq9FYL2UUZoF8FycmXfcMpPzO1nqTesR7EJHsXNtvpsrSZO41ayHGyI
	z4XHSv8JeKl4hTw2NTIkCBpwbMvtxSjn3qCPzPsa1fTpbYtSSFi0z4mHB22uRw==
X-Gm-Gg: AYBFou2MIJfBFnpcZ1adphgU3IfaIlDjbKiTkBCKmunT7JODTiHDBHP4vabPqDtAA6Y
	dC4XsQnybIi+14aX2+WAXQIOoljFpjPZd8qs4muaZCw9owaBR5Mhw3/0HW/K9EA6wbTVVrJl4Tf
	b1EUb7L6MoTCeltFRyjGUC4WTjBA8ZEFI6w8uhEgkvvhqlMWjIVcBK/jGfs74SEa1T5ogqdVicZ
	KExbQPEuIXzTUlXsKFR4YaWOMlZP3hXt4SNDwE2HbOeiUgvV8WWiGVsp0AWXOpKvxyh6Ok2PCQX
	x0Im/G4esgoIq9UUyG7EZT1/nHMvJPu2fxuTAiG8ZUmGSTBc3ZplQCghFXljfhJ809QuZ/AMWcw
	OA8WHgkS5TCmE+A19R0g8pOnKbN5D/RRHMmP4Ubw32rgRYcQzkB+GbELEfGuMRjD8dRuJ/j8eXZ
	WKcMWq7pHAxCizjN9Bfq7elKqcbjNchVEs2qv8E58HuF5i2SiA30pZs9eVjdSIFhqLpOI9hv18d
	dGufaSBxluyFwa8U5kQJC5riGvTtKr0zvHroRTUJun0FREaFq+TngVUC1vMQ/PjtlS1Git2Eo1r
	sBgfW/MGoM8qblGT/xDh9gELxWBFg+6psQBFzbkasv5stKek+qKZYM4MCGSxKu7nVF717ak=
X-Received: by 2002:a05:690e:d89:b0:675:3ec2:25e3 with SMTP id 956f58d0204a3-6790a3e22b5mr1461246d50.50.1791391104388;
        Wed, 07 Oct 2026 09:38:24 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6791b22d090sm254163d50.22.2026.10.07.09.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:38:23 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	mst@redhat.com,
	jasowangio@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: [PATCH net] net: extend virtio_net_hdr csum_start checks to VLAN, IPv6 and IP options
Date: Wed,  7 Oct 2026 12:36:59 -0400
Message-ID: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

__virtio_net_hdr_to_skb() validates hdr->csum_start against nh_min_len:

    if (skb_transport_offset(skb) < nh_min_len)
        return -EINVAL;

Extend the check to account for the link layer header including VLAN
tags, IPv4 options, and IPv6 other than VIRTIO_NET_HDR_GSO_TCPV6.

Payload, gso_type and skb->protocol can come from userspace, so cannot
be trusted to be consistent, or correct.

Therefore:
- For Ethernet packets (ARPHRD_ETHER), parse from ETH_HLEN and
  eth_hdr(skb)->h_proto, advancing past any VLAN tags with
  __vlan_get_protocol().
- For non-Ethernet packets, use skb_network_offset(skb) as nhoff and
  infer the L3 protocol from iph->version at skb->data + nhoff.
- If skb->protocol is set and disagrees with the protocol parsed from
  the packet, enforce the minimum header length of both.
- For non-IP protocols, require only nhoff + nh_min_len. No in-tree
  non-IP protocol generates CHECKSUM_PARTIAL itself. They only carry it
  when encapsulating IP (e.g., MPLS), in which case csum_start lies
  beyond an inner IP header.

Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Link: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yibelo@gmail.com/
Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_net_hdr_to_skb()")
Co-developed-by: Paulos Yibelo <habte.yibelo@gmail.com>
Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/virtio_net.h | 48 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd0..6a30f58d9d65 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -48,6 +48,52 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
+static inline bool virtio_net_hdr_thoff_valid(const struct sk_buff *skb,
+					      unsigned int nh_min_len)
+{
+	int thoff = skb_transport_offset(skb);
+	const struct iphdr *iph;
+	__be16 proto = 0;
+	int nhoff;
+
+	DEBUG_NET_WARN_ON_ONCE(skb->mac_len);
+
+	if (skb->dev->type == ARPHRD_ETHER) {
+		if (unlikely(thoff < ETH_HLEN))
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
+	}
+
+	if (unlikely(thoff < nhoff + nh_min_len))
+		return false;
+
+	iph = (const void *)(skb->data + nhoff);
+	if (!proto) {
+		if (iph->version == 4)
+			proto = htons(ETH_P_IP);
+		else if (iph->version == 6)
+			proto = htons(ETH_P_IPV6);
+	}
+
+	if (proto == htons(ETH_P_IP) || skb->protocol == htons(ETH_P_IP)) {
+		if (unlikely(iph->ihl < 5))
+			return false;
+		nh_min_len = max_t(u32, iph->ihl * 4, nh_min_len);
+	}
+	if (proto == htons(ETH_P_IPV6) || skb->protocol == htons(ETH_P_IPV6))
+		nh_min_len = max_t(u32, sizeof(struct ipv6hdr), nh_min_len);
+
+	return thoff >= nhoff + nh_min_len;
+}
+
 static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 					  const struct virtio_net_hdr *hdr,
 					  bool little_endian, u8 hdr_gso_type)
@@ -104,7 +150,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
-		if (skb_transport_offset(skb) < nh_min_len)
+		if (!virtio_net_hdr_thoff_valid(skb, nh_min_len))
 			return -EINVAL;
 
 		nh_min_len = skb_transport_offset(skb);
-- 
2.56.0.360.g66cac248cb-goog

