Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5705218A9
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068086; cv=none; b=Bl0NA35qFaVVQx1DqOsBYU+GT4FsYZ/lNygaVrJck1Vl7g9VM4M/cP3AiYgDzfYpoaYC4QIVaEG+lnOvxZA+gW2h2zvqVd6I7jtPyfkf7of0oKZblGwaEwNJnz5Qql1L6uCLrbJ591jVjmGXKGKditmEQbLyddknMlPsxI2g6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068086; c=relaxed/simple;
	bh=Yq8ewY/bypfk6WYMo5O6jE96KUzAFsHbBJPrqOn2/CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1UxZ5tenIkfqccljNz2OJ5RFzK+L1TGWpVrzRy5iLRpB00O3BxkkOPLHin8kGJQdXjOPHFZMnFC0P7MW/O8LmvKKqiiTtauEw8tjIGXun8AXc+9sF1iAS5ULclVkL+cFAJRUMfqh1OUJ+DjRywCxHqir5ETockY31umNYqnarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwBaeIiO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j1MfkxqS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwBaeIiO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j1MfkxqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NfjAXgzIJDVH07KDf3KR4Ni0NTeFXvYShemAw+4OhqQ=;
	b=bwBaeIiOxWy+UtTVddvDfhhYdOGixMTBeR11fYF397WrKo1dt9QhB0Cs/X1k4iAR+QUEhK
	0lIlbCH/Dc0kxI5LX5q0uHMFzWqD6VrDmRQRjhwhnFq23kyE1uf/qJQWX/6WRlhwXCwUcL
	dhATN9x0pcOdY79ZY4NpiJJsghf+IeM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-ojACp6tVOQGsU1TU_NvQRg-1; Thu, 15 Oct 2026 12:41:22 +0000
X-MC-Unique: ojACp6tVOQGsU1TU_NvQRg-1
X-Mimecast-MFC-AGG-ID: ojACp6tVOQGsU1TU_NvQRg_1792068081
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b0a199b20so4330687f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792068081; x=1792672881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NfjAXgzIJDVH07KDf3KR4Ni0NTeFXvYShemAw+4OhqQ=;
        b=j1MfkxqSUQ4RWCr+48BD9chXELMZ94fCC9Jykm+Wd7bo/Qs8CwVts08oe0pBPv1N/y
         yxZu8Mg5p+B26UJuhXSm6AsiiCrchNY2oC3UiX41Asu24LsjwInopl5eoQVHIs/Eav1T
         /YEAXDXAaDFryZX0qdJ9Os3TdxU5uVL8IRwkjIGOKD2gx65DnFloBPgdQU45zPvwPhOw
         nt4wEogmBgK2usbNbHeWpxE/sEukka7k9MvrM4FoIEpZXoeXTyU+ZMMRS5vsbopb3/w1
         C9Y/KZua7A2W0rv2sOeyCvBRmq9NE39UyWQwoq6+tys1E16ASsgyBI9lDZ4JlGwnjUcX
         ABww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068081; x=1792672881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfjAXgzIJDVH07KDf3KR4Ni0NTeFXvYShemAw+4OhqQ=;
        b=IOAvZOsFZbebW4RgLXo56aPRMqORwEBZxxB+1Lapm7YafMZWqRBseMHfqupCQIshZh
         7AZNR90dTXQ9lQ7JHoYrxABQRsUh2fpAuwsguGr7P6AsTp8sPIHy1mQylXJoH6bfT2Hg
         kzjasEEExK+dT007jPYT9V4ixVKVAf66yx/tMWtStxlUs1Cj6l4yBdMYxf9Z2Egj3vy2
         zJn2FkIf5/hWmmTpkBQcAh+b7dP2G/mGQHfXS0F3faQ5J+W2MliKXTy2ZP9WRaIeZnv8
         oJ4OuxCQumNzrFD7T3kiARSH/qbL8PxAgmR+Wr3uT28XOuKVO8u7IJbOxd2/4MNE4fni
         0GMA==
X-Forwarded-Encrypted: i=1; AKwUvByxwJvZhVJJOphC4SPcORxAEe5VBjqJ9tYVBnIZsHMMLZRWIkX2wua+0UuoyNK7bfzulGmlCzs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMBE3JPrKRZYGK0rg6i/VyEdY34Wlpp0vt23wb0E+xyRdWWGy+
	DZi2jQyjX3VXvyu+qvQDsnFD3/HoLlrFNSRgqPxwkFtEPTKjn+AnhoqvhKYqrFZcwCB7xW2d0DF
	UaYrvaodzPHgCqXfypKVkF/7lNmPzfI4TcAIwp2FG0dxidaBXpuYX6wf6sQ==
X-Gm-Gg: AYBFou0YdecmAgRmdXCpA3S7DxtD6MWNzSAAUnS+B65yIkoowmv7gLnIyNu+cWXACYn
	L9Z/ymJH4neXgTMHyWdZT5amVtcCcLwcrWLTV9zXEsYInjwT55pmmhjecJ0iiw7tLdg3fOq0STl
	DlO/An4fFCJ3MGLxMWkU8piVMG94vVhAZQxCYtc+fn0E68z8rsFPmmqww+lUT/pAeYXeQ342ko/
	Y3HKARYgcGD1OUhdAffFz1t1eP3EyxJpThl9AqS49wWsXx6bkkkKzt3cQDv4vpNk7r9m+S+Jq5k
	IWgW2gqfVw7a9vGEzwS1IpA/ZlSSWuhj793UOGJN82Qm4r5nSf78yPcre+xeR3L+uGc1lw==
X-Received: by 2002:a05:6000:4816:b0:48a:f3c6:7bfa with SMTP id ffacd0b85a97d-48dbace50d8mr38390915f8f.52.1792068080851;
        Thu, 15 Oct 2026 05:41:20 -0700 (PDT)
X-Received: by 2002:a05:6000:4816:b0:48a:f3c6:7bfa with SMTP id ffacd0b85a97d-48dbace50d8mr38390842f8f.52.1792068080125;
        Thu, 15 Oct 2026 05:41:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7773d02sm12897491f8f.13.2026.10.15.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:18 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:16 -0400
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 1/7] net: account for ingress-resolved virtio net
 hdr state
Message-ID: <885c413aa895291c0b404e639aa85d1e33353e81.1792067836.git.mst@redhat.com>
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
index 242899f7fd07..44d95a8c75a8 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -210,6 +210,7 @@ struct tun_struct {
 	u32 flow_count;
 	u32 rx_batched;
 	atomic_long_t rx_frame_errors;
+	atomic_long_t rx_csum_sw;
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
+		atomic_long_inc(&tun->rx_csum_sw);
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
+		atomic_long_inc(&tun->rx_csum_sw);
 
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
+	data[0] = (unsigned long)atomic_long_read(&tun->rx_csum_sw);
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

