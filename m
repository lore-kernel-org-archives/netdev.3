Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DA93043DB
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388782; cv=none; b=InRNFlGfIp1+R0e5CZwnQyFsBoj1mMDjdfliESRuHn6JAJbHpvfTmAE1osb3oY6Bc1yqv8ohCEBTAq+VW3GjgSz5O1nlCwqF4FBNmasDYu2ukJbm78MaFtIEnNj6jFZoCVg9SUnSazdaJHBHL6okFEKv8LdYsuZCXKxWjTLvz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388782; c=relaxed/simple;
	bh=t5Cj9Hjao+ATei27nDWwiyDKCHRpoeswz0HbhQvSCjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PYByZpzZxIKQml3kVN1hrUa/L8lnADnGp4wBK7Wq5QOqcbF26xeQTvLdH7VzDLt++fsvXuPJ/nONMRyUbHyX3oymn45UF4Zs4vs5lM+KBPa6Hf+KcIZuggFYaEMghtpQbKkSrwAWbT59iHNEgEZ8itpmUiFl3Ybj0UENMBbgkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gEEaslMZ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gEEaslMZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773388773; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eTaVkesOnz00TagXXUlebaD5E34dJ6Qyn5C7uPARsVA=;
	b=gEEaslMZKSiRD2n1tOPnS346OzC+BjTMkOo0GGrxsVocvIdFiyZo3yZqiLzgp9+7JhKG3AKqMRe69GPrWsRfAdV/8X//SlXo0YWuOzzegR8tHW+df1e7TolKyYt1OQQsBInVUZdbCBUcJ9HRtqtVinqaXmVQCfoHOJb8aeh43so=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X-rcU5j_1773388770;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-rcU5j_1773388770 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Mar 2026 15:59:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Fri, 13 Mar 2026 15:59:29 +0800
Message-Id: <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: ad5d7fbc23b6
Content-Transfer-Encoding: 8bit

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This commit fixes that issue.

Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/tun_vnet.h     |  2 +-
 drivers/net/virtio_net.c   |  6 +++++-
 include/linux/virtio_net.h | 33 +++++++++++++++++++++++++++++----
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index a5f93b6c4482..fa5cab9d3e55 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
 
 	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
 					tun_vnet_is_little_endian(flags),
-					vlan_hlen, true)) {
+					vlan_hlen, true, false)) {
 		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d6a9c6a5a2..7106333ef904 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	struct virtio_net_hdr_v1_hash_tunnel *hdr;
 	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
+	bool feature_hdrlen;
 	bool can_push;
 
+	feature_hdrlen = virtio_has_feature(vi->vdev,
+					    VIRTIO_NET_F_GUEST_HDRLEN);
+
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
 
 	/* Make sure it's safe to cast between formats */
@@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
 					virtio_is_little_endian(vi->vdev), 0,
-					false))
+					false, feature_hdrlen))
 		return -EPROTO;
 
 	if (vi->mergeable_rx_bufs)
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 75dabb763c65..48de4a16a96a 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
 }
 
+static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
+					 struct virtio_net_hdr *hdr,
+					 bool little_endian)
+{
+	u16 hdr_len;
+
+	hdr_len = skb_transport_offset(skb);
+
+	if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+		hdr_len += sizeof(struct udphdr);
+	else
+		hdr_len += tcp_hdrlen(skb);
+
+	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
+}
+
 static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 					  struct virtio_net_hdr *hdr,
 					  bool little_endian,
@@ -385,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 			    bool tnl_hdr_negotiated,
 			    bool little_endian,
 			    int vlan_hlen,
-			    bool has_data_valid)
+			    bool has_data_valid,
+			    bool feature_hdrlen)
 {
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
 	unsigned int inner_nh, outer_th;
@@ -394,9 +411,17 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
 						    SKB_GSO_UDP_TUNNEL_CSUM);
-	if (!tnl_gso_type)
-		return virtio_net_hdr_from_skb(skb, hdr, little_endian,
-					       has_data_valid, vlan_hlen);
+	if (!tnl_gso_type) {
+		ret = virtio_net_hdr_from_skb(skb, hdr, little_endian,
+					      has_data_valid, vlan_hlen);
+		if (ret)
+			return ret;
+
+		if (feature_hdrlen && hdr->hdr_len)
+			virtio_net_set_hdrlen(skb, hdr, little_endian);
+
+		return ret;
+	}
 
 	/* Tunnel support not negotiated but skb ask for it. */
 	if (!tnl_hdr_negotiated)
-- 
2.32.0.3.g01195cf9f

