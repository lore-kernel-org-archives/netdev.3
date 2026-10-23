Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768166;
	b=YctkEqjAdB2n4hVL8sUGRFVHV2SsGtlaOUXXAK47UBkUuVGIu7FVWgEqOzZGVz7MXY7p
	 rgdicZf97HEugJtaxMeayf1lwNAbCmZxRmAIen+hCx6eZVONxZ2Q2odUWrZCbwpUwhp8k
	 9uYi4+p03DMhVx1FCWzw0AuwDfVnCUwPAZURDiMqG1aE04veAwhM7hZKwE0BiIKR9OrQW
	 CimDtSXyzSfGaJFr1AYHUk6utUbk+8oxqASrjljOmVcjv3AADRjMVZnitCAUsJ2c4BVlP
	 E13EXBmZcwqONI44ww48RVKDGTb7Q5hUoDUVwfYnKasSjjwHvbNGCCjkPaom3YcaNWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768166;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=xzwl+TE+jVjHahwjhJURjHz4fs3eOlke9/GN3ATk3AI=;
	b=3KHQAuUJx5A13UOMJ9smEDOlfRxF6ZQPZ+95JspNWWFN4uRgh2lVh1en4/W13wwgIK7n
	 5ZhwerwW4oqvDi97Qb5y3YDWaewoh7cRVU4yqKojKEcEE0MjC6GzbCR5Qb32t8QKb3kZ/
	 dZDcFvTu0svghoHlFLLAsGg+Z6e1OEya43G3cqpRSaojIbT5Ae6cFBrkEx+smB8UdXN6Z
	 vJCV80y2Vr15MwEfHBeTL5mvp0LiMZcDpO1fHoNwBclOETnrp+rZiGsPfUzAaOgr8zd9X
	 DGH2MpWnlUWJw/sTu0nLikQt81eqd+tuSQrOdrXH0qpULw9xI9XVbP5501JyMORBoLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z0dyu1bA;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RfZhnwr5;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D4606A322
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C4D4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z0dyu1bA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RfZhnwr5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792768165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xzwl+TE+jVjHahwjhJURjHz4fs3eOlke9/GN3ATk3AI=;
	b=Z0dyu1bAx1t+PWJ1XWXu/GMaUOpYXyTSjgpeLUmhKT/E1gVN/slVJ+h0QjBwCzZXRi5Bxp
	MOwmR6hGqv0Q+nIca57PJtC4mQdpuLjAJP4fTkBuQ26oGApeTf4r3RhavOuZJZ4pLM2kJI
	4bMSsNqpsLoT67FPsw/ErnTQfbgqFiM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-JG2yDLakPiiNFGY3ioh5cQ-1; Fri, 23 Oct 2026 11:09:24 -0400
X-MC-Unique: JG2yDLakPiiNFGY3ioh5cQ-1
X-Mimecast-MFC-AGG-ID: JG2yDLakPiiNFGY3ioh5cQ_1792768163
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1895ffc83so7315855e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792768163; x=1793372963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xzwl+TE+jVjHahwjhJURjHz4fs3eOlke9/GN3ATk3AI=;
        b=RfZhnwr5nesxguWcR4CCJWkbbbhmj7XGQAAvWBMdd1EMd4SFH3qAV9Q/+hB45nTaEC
         i59B+39uf9v0MS6fJI6OTqDaRXpFHVmve0kzmfV+awUVIQjD5qTMuhofAjivFpXfVUiy
         jrQebMvM0osbtnQIl/kTXp9wmKSbgk+6ZQTak3sfJ+N/mGUMikse8GMzNGpcpyYL15uy
         durH6VAoU3/6ZREg/lBmXdCz+Fc2tesJ4800+LSUrS5bcTq6DXjFWBv1pnpLQI3cWQdz
         sV6gEGrUwXeaUBZY7042MVatDG7+QE/4oC9+wJ36YLFO8dA5sGiTvdyKdB8b7cPDE60/
         qsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768163; x=1793372963;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xzwl+TE+jVjHahwjhJURjHz4fs3eOlke9/GN3ATk3AI=;
        b=I3s5knQ8qVcbEK3X63hZULP8oxwlJBB6w5Nobxj/wg0HbbxV5JoPKGWSl2WtS9LL60
         INpn5LwDDZuQ+iX3BUtB4HPAzH31cqBXHrd6pterlpsM8JA4X7aGYuC098wF6BGSc1V/
         5Rb8UY7R1ULSETsPqlhXM3a8Kuyi30iVGJl7mPelqLIpyqhSDYeISakPd3/14eIRf4au
         FrvGn+pRHfY6SGY+XZ56r2Zkls6IVUUezpsbVMK0Sh3ZWvZJ+t9FJMMA1aG4DyyZXL5F
         WviZjg2JN8lyLSLez5Jti72HbmhkgW00ZgSlU4QVXST9QyuSJHdkEviy477ePI3u77pw
         bqwg==
X-Forwarded-Encrypted: i=1; AKwUvBz7mWGG1H//CURouz+QnR8KwZDt9oAa7MNI0SU+TMey2+cDx2j42Yd8xwleYVMidAu6kHlYkpw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcUF3A4Eee+86Dn3SYaBYMWNo+APjSq8CbF3jr1Mcll/A7ibfk
	DxInN2m7o3zdxyaA5ciYhSZl/ocA97ZUKEfTlJqXbDoLk7UBKFhkznEZppit0JOLdcaZZxtabq0
	nu0N8zdgiEt2gji5H9X9yWuVinfHb1uacgHqEflrEfZIr3TUmhSBTz/i7+g==
X-Gm-Gg: AYBFou3LbOM+gVe5gjnfXvRNqYAzw5cswTZec5fddozGuwo+POKBBpCIUUYeViuz2ml
	qFYIhJur+X0TnCfRbX59GHBMheDBmRp4YuBwgWH638GMsqg02P+XMX+m0QQhjavUyivtyBhDUbo
	ThJGIAodg4lwRxvFVKVD9rhNLHoGV+E4vs/py9Tmvwmfj8c6SA6rV12+ppFH7l3Du03xFebqOiY
	rLWUwR8AxRfrmQezlJPXRyuUdFK38jH9Ckr+/WnNdnPsSdB7rN+h7uIwJx8GEeV/Ddyor7vpIcW
	ftDUlTmwpuR1aQvf+LoJWf3EyzUfsrEf6ZWZNG/BAolLze2qAqIBoWFZTlkfyOgR8mnE+c8=
X-Received: by 2002:a05:600c:1390:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a211ee53d8mr43757215e9.33.1792768162504;
        Fri, 23 Oct 2026 08:09:22 -0700 (PDT)
X-Received: by 2002:a05:600c:1390:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a211ee53d8mr43756545e9.33.1792768161906;
        Fri, 23 Oct 2026 08:09:21 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d417e6dsm294582f8f.44.2026.10.23.08.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:19 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:09:17 -0400
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
	Willem de Bruijn <willemb@google.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Simon Horman <horms@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH net v6 1/5] net: account for ingress-resolved virtio net hdr
 state
Message-ID: <726145690d46fdfc8dbe590ec4dd42d42ab175db.1792768096.git.mst@redhat.com>
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

The following patch will add ingress resolution of uncommon virtio net
hdr checksum metadata (software checksum completion at ingress) which
adds performance overhead to the packet processing.

We should make it visible, so a hypothetical workload relying on
uncommon metadata can be distinguished from none at all. This way issues
in the parsing will be reported and not quietly pay the host-CPU
checksum overhead instead of offload.

Flip every call to virtio_net_hdr_to_skb to test for negative errno
only.  The um vector raw transport even ignored the return value
altogether: rejected packets went on into the stack with their
metadata unvalidated, so check it there as well.

Have tun count these events per device as rx_csum_sw, exposed via
ethtool -S.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    v4->v5:
        count on tun only: dropped the tap, macvtap, ipvtap and
        virtio_net counters (Willem de Bruijn)

 arch/um/drivers/vector_transports.c |  4 ++-
 drivers/net/tap.c                   |  4 +--
 drivers/net/tun.c                   | 41 +++++++++++++++++++++++++++--
 drivers/net/virtio_net.c            |  2 +-
 net/packet/af_packet.c              |  4 +--
 5 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index e1fb2a76fdff..8b7548458663 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -210,7 +210,9 @@ static int raw_verify_header(
 		return 1;
 
 	skb_set_network_header(skb, ETH_HLEN);
-	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
+	if (virtio_net_hdr_to_skb(skb, vheader,
+			virtio_legacy_is_little_endian()) < 0)
+		return -1;
 	return 0;
 }
 
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index ff67d99deb39..73e883394446 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -649,7 +649,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			drop_reason = SKB_DROP_REASON_DEV_HDR;
 			goto err_kfree;
@@ -1084,7 +1084,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			goto err_kfree;
 		}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 242899f7fd07..197fb8726f8d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -210,6 +210,7 @@ struct tun_struct {
 	u32 flow_count;
 	u32 rx_batched;
 	atomic_long_t rx_frame_errors;
+	atomic64_t rx_csum_sw;
 	struct bpf_prog __rcu *xdp_prog;
 	struct tun_prog __rcu *steering_prog;
 	struct tun_prog __rcu *filter_prog;
@@ -1935,10 +1936,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
+	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
+	if (err < 0) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
+	} else if (err > 0) {
+		atomic64_inc(&tun->rx_csum_sw);
+		err = 0;
 	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
@@ -2605,11 +2610,15 @@ static int tun_xdp_one(struct tun_struct *tun,
 	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
 	skb->dev = tun->dev;
 	skb_set_network_header(skb, ETH_HLEN);
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
+	ret = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr);
+	if (ret < 0) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
 		goto out;
+	} else if (ret > 0) {
+		atomic64_inc(&tun->rx_csum_sw);
+		ret = 0;
 	}
 
 	skb->protocol = eth_type_trans(skb, tun->dev);
@@ -3739,7 +3748,35 @@ static void tun_get_channels(struct net_device *dev,
 	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
 }
 
+#define TUN_STATS_LEN	1
+static const char tun_ethtool_strings[TUN_STATS_LEN][ETH_GSTRING_LEN] = {
+	"rx_csum_sw",
+};
+
+static int tun_get_sset_count(struct net_device *dev, int sset)
+{
+	return sset == ETH_SS_STATS ? TUN_STATS_LEN : -EOPNOTSUPP;
+}
+
+static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	if (stringset == ETH_SS_STATS)
+		memcpy(data, tun_ethtool_strings,
+		       sizeof(tun_ethtool_strings));
+}
+
+static void tun_get_ethtool_stats(struct net_device *dev,
+				  struct ethtool_stats *stats, u64 *data)
+{
+	struct tun_struct *tun = netdev_priv(dev);
+
+	data[0] = atomic64_read(&tun->rx_csum_sw);
+}
+
 static const struct ethtool_ops tun_ethtool_ops = {
+	.get_sset_count		= tun_get_sset_count,
+	.get_strings		= tun_get_strings,
+	.get_ethtool_stats	= tun_get_ethtool_stats,
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
 	.get_drvinfo	= tun_get_drvinfo,
 	.get_msglevel	= tun_get_msglevel,
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index daab43ac92ce..2e6fd81df9c4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2519,7 +2519,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 	skb_set_network_header(skb, ETH_HLEN);
 	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
 				      vi->rx_tnl_csum,
-				      virtio_is_little_endian(vi->vdev))) {
+				      virtio_is_little_endian(vi->vdev)) < 0) {
 		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
 				     dev->name, hdr->hdr.gso_type,
 				     hdr->hdr.gso_size, hdr->hdr.flags,
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 52ae3d875e97..e6aec9ecfa99 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2913,7 +2913,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 
 		if (has_vnet_hdr) {
-			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
+			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
@@ -3136,7 +3136,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 
 	if (vnet_hdr_sz) {
 		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
-		if (err)
+		if (err < 0)
 			goto out_free;
 		len += vnet_hdr_sz;
 	}
-- 
MST

