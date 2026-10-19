Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A294EBAF6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411393; cv=none; b=EGzZSbueY2chONkTjxOrcsAPleFMZhgP+b4Nval2A86TF+e7mswrpjh2PQlp9UvJTvxJkFIdTqr0ooWdRNTKyiCRGL/LvLd0zO9tgSZe19YrK4RDHkyANaKNLPwWC1uS7ieyXCtRU7QTptJc9AtNwRUCiJ4wXlH7b7YF4fVnE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411393; c=relaxed/simple;
	bh=UOTdqyK/Bh3jmg5tq5waFLxklAdVZaf+YzmxhBON62A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOqz4YhpT5drnPSqEqcL3p4lCrxYv4TKMezlxVegoSw7AxZAMi/LJE10oMeeexbA/+Vn7rVUgduTicqtNN1KCZLopFZr8I00s+PTwr0GPDoaDrzEsO6ABGVUj4lqNUrcuf88d+8wrwYeaCGF7PE86bDrPoadLWlk4HsG+1dCo+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxQ5jmjo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HW6X3dwE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxQ5jmjo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HW6X3dwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OPjtCegbC2jn7HsffHh9I/GufwNUoioiRsioSDiFk6s=;
	b=CxQ5jmjoVhR7hucsFbQEG6b8oFmiUWzQSvqdUSR4NTakTqLIDZHldA6fW+K0qH2p+MXyxe
	G9IIk+2Kgg6qfZ5QPIo4zC7VP9KbQscIm4/vmvidtEG1i0bfcUKZZDYpM9L9Hpvcnf0ZPK
	/tJkf1RKyqLQVJiR/+LdSBxrGcDYGWM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-ss8Xin44OAmcdw_YkWkLHA-1; Mon, 19 Oct 2026 12:03:08 +0000
X-MC-Unique: ss8Xin44OAmcdw_YkWkLHA-1
X-Mimecast-MFC-AGG-ID: ss8Xin44OAmcdw_YkWkLHA_1792411388
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df02e6b40so1238319f8f.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792411387; x=1793016187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OPjtCegbC2jn7HsffHh9I/GufwNUoioiRsioSDiFk6s=;
        b=HW6X3dwE8diXel6AuG3PduzV4wCSDreXKWjlPcqPnv/SVI83U6PHBS+teZz7ZJqPjD
         NLA70A67zQOPlJIvyAORwpo9TRYvlgIEDfP1mIPrKtMrOPqXPg43hKHAOVsZdSdniPKG
         0nVMAXMSgbJaO6GsDzwL4Ir2M5gzWp/sNRtJRrlT6b07kTarylj1aRcX/lAv1ODhsJ/L
         BHqfy8AKLD0wqlVbZ2/eWmjFaomOQXtTZJbCa+as+Dp00fI6kapabt+rL1q3b2e1a5AZ
         75aMags2e3wnaKOXq1kxz9XC6QCmuYmOhaOH1buJj7cfjOFTOnkf9PVS8sTgqcDjBblP
         a3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411387; x=1793016187;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OPjtCegbC2jn7HsffHh9I/GufwNUoioiRsioSDiFk6s=;
        b=muYZAwP84q81wxAhQ3LjBuj15XtbdFMoiTulqsIb90MiFlhCtE0siPV1w8ERSQZREa
         EObTA5CzRNVf5TNDUpF+EUjJD1LyjieYMEe0hQZsir0gezeg7FTGZCNiS7f+BrVFrik1
         gakICSjkKmNNTHrvlj0pBSOH43ges0w9hvEMwVayCbXn7a7gH3a1KGuJ+5sgypzPHmrm
         7+E3Km6rRAanYyj421ORgCQNyfpxnmcvUns0R7e+1HJtUEJTgy53me2e2x0sJ+1ushvo
         DpBW94LXxRwLwV84Jts3yAiaFP2wO+6Z5JUIUeZ2pCpMroVPubhK7Fin8w9ukxPgpjgp
         6vOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZN8bjLFY64tmSJUbW3pvKrina+hCBB11TRFESz3jcXoUST30ritTm0Oqbs7mTQfc89dIQCSY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXKqdpIgds13ZiKL7JKIyFoN8Nxnpa4BAqvzRQAk56k0H0qLh6
	ZOmnVlrnK7cmChj6IBbpVMe4BFkijSTZ+rRcALFNS2c4+kXXbaGPZ6LVaFhlBZHchTs9E4lm5Ic
	8N4Att0aZI8InPshS5vKz1UKBhaq4VwPUpi2g38uPlmtNEA+MkfYFdKWqhA==
X-Gm-Gg: AYBFou1f4CjzaZ/zX5Ztu6ra0vT4as7Cd0WndV1pXG1H4SQnt9suF4otkr7SwjSEphC
	vjL7xwsTGKyCdyssL8iLGecAtZ4dSW4hm5JtoZS9YsX9s2C+9ePx5FR3KcUyAEAxlaXwzhc2Txf
	HFDI9iAKHJVC9jXD7AFtavMaPhCLke4NOOKXliLKIVJHiWh+IOH1IjPQJCrmF/OklCnhsuAQSfm
	K5HhztrL3z2pZb4wvZdRrBn7RZxhOQkIAHAt8jkT8kdewsAfaQWrjspAgkqAhAObbAEGXtyo35z
	Qcq44dI/U5gysYQ38CYar2UeeFtX4oPAG2POHqOHt+7LsbBSbWjGKS6phgk7EVMY8+xujA==
X-Received: by 2002:a05:600c:3ba7:b0:4a1:e6cb:25bb with SMTP id 5b1f17b1804b1-4a1e6cb2ad6mr73790775e9.2.1792411387267;
        Mon, 19 Oct 2026 05:03:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba7:b0:4a1:e6cb:25bb with SMTP id 5b1f17b1804b1-4a1e6cb2ad6mr73789795e9.2.1792411386598;
        Mon, 19 Oct 2026 05:03:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c10fe9d3sm328226975e9.13.2026.10.19.05.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:05 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:03 -0400
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v3 1/8] net: account for ingress-resolved virtio net hdr
 state
Message-ID: <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
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
only, and have tun count these events per device as rx_csum_sw, exposed
via ethtool -S.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/tap.c        |  4 ++--
 drivers/net/tun.c        | 41 ++++++++++++++++++++++++++++++++++++++--
 drivers/net/virtio_net.c |  2 +-
 net/packet/af_packet.c   |  4 ++--
 4 files changed, 44 insertions(+), 7 deletions(-)

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
index 242899f7fd07..19cb443c89b0 100644
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
@@ -1935,11 +1936,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
+	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
+	if (err < 0) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
 	}
+	if (err > 0) {
+		atomic64_inc(&tun->rx_csum_sw);
+		err = 0;
+	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
 		skb->protocol = eth_type_trans(skb, tun->dev);
@@ -2605,12 +2611,15 @@ static int tun_xdp_one(struct tun_struct *tun,
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
 	}
+	if (ret > 0)
+		atomic64_inc(&tun->rx_csum_sw);
 
 	skb->protocol = eth_type_trans(skb, tun->dev);
 	skb_reset_network_header(skb);
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

