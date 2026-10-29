Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300004;
	b=1Sof7DQdN2wcLV+2udhexndtYPccw6i6DIl48Gcv92Xev7+GcBa9e9jKldbhJaqpawjO
	 cclZ89xUd+oOHjEYVFenJaljWtQ576bmMYMbcBa7Q9E4XoXhg2/zILrIkNMDM7/WWMBKa
	 xRAuOS5PcjqguokJ0Oad6wvzD1l/oO7OF/6sAJNdkUQ9a+0teuqNIw07XCpK/o7ydZ+uF
	 +VTCQRlchAEcjgQd6ohCsrXpbSnO0cQL2SLKYhnNuNNaRJ52f7Q/9okEabOotxUlia3Rx
	 NzrkloJbUVFvovHJz8Iut3OnuFX3oBceLDNjzN6KEzeHLWkHgW9/P5nhMY5m/4Lvodg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300004;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-Mailer:
	 X-Mutt-Fcc;
	bh=Kl5aqa/5huOMBjE/HMjqhWjp8eowVgL7maZxpKhEQks=;
	b=QnF/BZrsIs1qKKOfIi2rq1mdPw/hkbZnaZ0QpwYKG07wOz2UlwzQ4gIZk3y2MRbMYP0T
	 +7ckTxG1jBuHIyo2uN2tH7PK8pojQ8Dawrx+2fgEvRjLwCAj8yWQ1JoufMg82/zqCuG/J
	 nVTg3kItuYM84SAGrbYcUxcyS5GZAbv6klS1S4IbdM6/YBLGNY9FUGuKCAn2kunyS0Ser
	 PWdwb8SDhaYV3oaQ2KQuKWHAFdWnkX4q2VhlUga78P8TJfPUt230F1pgGSLnNYeMO0+3L
	 VleC5G1WaYW9LXPuVKGOd3Yqfxppm8DlvgxNnALDOQpkSGapBihvN+YneT6NcqbVD3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVtuQAMi;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QkvjLFKA;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A7606A33C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 18:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC9A7606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVtuQAMi;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QkvjLFKA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793300002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kl5aqa/5huOMBjE/HMjqhWjp8eowVgL7maZxpKhEQks=;
	b=VVtuQAMiAv65Fe3XELvJjdXkKosmJPa0vP1v1zvwe39B3SDIUo9cHK8YV3+qNJgWF/n1dK
	E8szOXFWU4a1Es9L0lpiHyPSF1uhTYp5cmzORtGwqf5ECuicU27phZLuzldS5r8HbClRjq
	8KoN7b2/qEIwM9fdZ/2iPEuaUSv9DeQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-UyYl5RiONMePcuhAje2Swg-1; Thu, 29 Oct 2026 14:53:21 -0400
X-MC-Unique: UyYl5RiONMePcuhAje2Swg-1
X-Mimecast-MFC-AGG-ID: UyYl5RiONMePcuhAje2Swg_1793300000
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so22152065e9.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793300000; x=1793904800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kl5aqa/5huOMBjE/HMjqhWjp8eowVgL7maZxpKhEQks=;
        b=QkvjLFKAJ21o+Kfz5fyVkBTJurdpBUVDy5cRc+5uewTMggJZPomJ09kxvhZd7m8Ot1
         X1rxlz+4f8xSeN2j1UpxPexqELsoLDr9h/ow5K2qZ9RrZHzri+6bIVt6dUFPXUD0A7GR
         SoMY2t5MkQ9I90tg2YzG5uAkPsLYT1SCc0Kidtki3VB0zAhZQBQ66m/9gTK7y1bk1a7c
         WQJEl2Z0Kmi/zDSIdXlBu3ZA4SUEGrL1Fz09Xb+Ggm8Y0RZRITNyzWYdv8lnz3dwbzHt
         9Oxnf8y1whBIRrVh6ROlQa6pMuzzTrAjCj2U6Ol7dAfmERIR90MT/hfwOUvhzIb7iHRq
         9YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300000; x=1793904800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kl5aqa/5huOMBjE/HMjqhWjp8eowVgL7maZxpKhEQks=;
        b=P6AO75g3QakkP2LK9o7pyzrAgEh8nrVkqg7Vtif+/ey4QfO6sz4Yda0+r70+LOYuhy
         qmgoYTi/J7c42SKYwTi2oTjsVvlITFrac0HXk8fs7pqU7WHIbX+ZpkTmFCPyQMtpeHgb
         N/EsfUHeZtgUFqkjPiYwOOw3I+GUdfzqaep1pz+BROAlRWoBFxaNBvi4jjx7IcvB7ji3
         ZnCy0FF0faHlD4MbJzb15eSF/herTbRksGwkbeFmMPLt+Xe2JOzo6X3aVJ/q09Y2do13
         iHbLD+GldHDmgc2MtRb5iayvqrrJ1GrjKM/C9j7ovQMsh6mw9NTKiX7fU9f0gZgroR2l
         ievA==
X-Forwarded-Encrypted: i=1; AKwUvBwlyQgu0Qnhu8P0BVBuzBa8Ms9pYfDIrxACvHDjFUK8X4CUzM/ogoB4+bahRmiTBV1mv37TJYM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4RgBtUM5V2ZWfp4laewMzq3olmnNQ0E78peNUA0GN+zvptQvH
	M0vlw2YKCBwVBALfSegOejDCajRW/tCLqsyCcaGc/NuCtLTBUEspdfKIpz5IzFnIZZ/O+a7YkTr
	JwNEOfK534xrDgbkdOxDd730Y9sdreP9RtHlx8hNmbq3cG4ay3QDsp7nuTw==
X-Gm-Gg: AYBFou13g36PC9L4FFFTqmiu08OgPLcp+A+BqKaaqjL/HgB9YvjdlkdGR9CxbB2vYLQ
	913SovkwvCdehT7lY+xTUdowVxUTgF5j6/enFZcmw6BNPXhi9ZAFi6Y1XOx1FJ87Eu7pi6S5ROH
	H+J4QY6/qNmt7jeYq0WWJ5NkFYylS1ZB/a134wuuTzlmyaM8y755Asd7em2atoCZVgB+hwsVZke
	5xoN3m2Jp1frRlp1jMddfJ72FhM346DIKBWCFdB4kw6QO37WOt57bm/6ms9SIV1Ll3GE8wAm0z/
	ZSoRmCPEmtCx38EhWnaOHlBfd9nNmPw1X6U6ZZdZ2kfiM4GAd6kLvVI3D/RwuJHzTvEUX8O0o6B
	z4XXjiRwxLVdawiNyg1eHF7oAz/fY8oUFGZZjpaa1yLlQ
X-Received: by 2002:a05:600c:8183:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4a96710c712mr125672675e9.25.1793299999810;
        Thu, 29 Oct 2026 11:53:19 -0700 (PDT)
X-Received: by 2002:a05:600c:8183:b0:4a4:fc8c:cfd9 with SMTP id 5b1f17b1804b1-4a96710c712mr125672195e9.25.1793299999308;
        Thu, 29 Oct 2026 11:53:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b286a0sm3822575e9.4.2026.10.29.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:53:18 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:53:15 -0400
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
Subject: [PATCH RFC v7 1/5] net: account for ingress-resolved virtio net hdr
 state
Message-ID: <305bcadb19f4a539a318c6b87c829fbe43d0ffdb.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
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
In-Reply-To: <cover.1793276116.git.mst@redhat.com>
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
index 2f19fb07bb2d..101994870bac 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -650,7 +650,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			drop_reason = SKB_DROP_REASON_DEV_HDR;
 			goto err_kfree;
@@ -1090,7 +1090,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	if (vnet_hdr_len) {
 		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
-		if (err) {
+		if (err < 0) {
 			rcu_read_unlock();
 			goto err_kfree;
 		}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 770b8fe085c3..82ea59594eba 100644
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
@@ -1944,10 +1945,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
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
@@ -2615,11 +2620,15 @@ static int tun_xdp_one(struct tun_struct *tun,
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
@@ -3749,7 +3758,35 @@ static void tun_get_channels(struct net_device *dev,
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
index dd2c41ef6fbe..dd3f39516f90 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2535,7 +2535,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
 	skb_set_network_header(skb, ETH_HLEN);
 	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
 				      vi->rx_tnl_csum,
-				      virtio_is_little_endian(vi->vdev))) {
+				      virtio_is_little_endian(vi->vdev)) < 0) {
 		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
 				     dev->name, hdr->hdr.gso_type,
 				     hdr->hdr.gso_size, hdr->hdr.flags,
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c910..c0cd36be53d6 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2921,7 +2921,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 
 		if (has_vnet_hdr) {
-			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
+			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
@@ -3144,7 +3144,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 
 	if (vnet_hdr_sz) {
 		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
-		if (err)
+		if (err < 0)
 			goto out_free;
 		len += vnet_hdr_sz;
 	}
-- 
MST

