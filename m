Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821184E780C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889136; cv=none; b=PbRl7urUr8iZ53oVb+HsNVNEfjH9WvqxFqQMp5FBAnWm5+bWKKgCAopFY9b2agapzj5edtB8claLPFJ4p1zraSEnaL1WLrCLJAclIdsJyhRsUMFOUYdXoqlBVcRTdoaoFChREjemCwEo5966rBnHNSRu5gGxl04OGiXQ21Zavog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889136; c=relaxed/simple;
	bh=H0l0lW7OIR5JEAGWTHP04PSYXRXwPf9bf6J09uxs1gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0OKW66unZRCTJIUR92sgnoMi808Cc2r8khPdt67zRPJf3mMzWzjpHdmL0trl3IXB+j4HXthoNxZJFi5rdcd34Ibc0PrPLhnLuWoTurWG4KXXakxHg8V7T7/bSSY1hkGWLdKpIxSr/pNyr8FtrpIVkIkBy7fcnO7feDWluE1A1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIG8/+Mo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N68kqBMI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIG8/+Mo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N68kqBMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791889127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YX0cMX2Cf26EXqpfUZ4FHg8Am9Idf3c80yUtynKrkSo=;
	b=FIG8/+MowbcvvYSNicE8q9vjDTUVOb/rohE71xDp5cngDaN5pecVXgrf3D2T5M/B03bDPL
	fbzkZY6enzOQO6nSZFiO8IWFYhqanUPdCEZtRSOGI3TXcvSpIRD0yBmVq4cobZ/YRnoX+9
	rNUsAXN/2G4C7WPYpdUbJj5PPaUwd+g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-5bUvKqMgOj-KmoR32j5uSg-1; Tue, 13 Oct 2026 10:58:46 +0000
X-MC-Unique: 5bUvKqMgOj-KmoR32j5uSg-1
X-Mimecast-MFC-AGG-ID: 5bUvKqMgOj-KmoR32j5uSg_1791889125
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1721559b4so30210545e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791889125; x=1792493925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YX0cMX2Cf26EXqpfUZ4FHg8Am9Idf3c80yUtynKrkSo=;
        b=N68kqBMIXYtV2EphfkUgM0c+SndINr17dyJvowmfEUy3bJzTy/9OA3CuLuIbjjIsuh
         N8LxK0oRjzah1/nettIkDFVIzVIXKiOpN1J2FuI7Rgwbr17/NmNom0cdsB01XEaxRGkF
         AwA3CHT9xon62MXlWWs8jrMJ5RBRy9r8e4jhIPcWZ6YtaSr4/iGwburLRKDUh1NzrNX3
         UH99hw94KG9G6cUhsYwx+xO0oRYLSRpIZFP5LomY8cldMVTYihdP24VBlBzTk85pQMwX
         p2+YdE7Ac4f+MZW2hc6QUvIB10fPRXBu/z/YJWBXpztQxm92tX9lAx8PjH7717vy/T74
         G6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889125; x=1792493925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YX0cMX2Cf26EXqpfUZ4FHg8Am9Idf3c80yUtynKrkSo=;
        b=JnuwaLUOkDDDpFl6HhIVwsGdLUJwYTi/UrVbskAAU2uf9I9EI5HO1EpIx2yo5Zj+Dl
         omVLRDJg6oehiwpLdBo4C/z10BAF5CRe6AxbtoQChPdtol4m5MI04UPYVGnTSraymdVR
         tFhTQuxsSG8j3vZ80X4tCho8pYuLrGYjEKQHCcGJnVOxXgJWkhLVtngAMbqkIvy9CbJD
         EikPRdTlV/24422gj3drm9AdPFa209QXrPb/rYVgT9ZAAFhGVkBHa2Et6mdXMJkdGOxj
         hjcB27HdFSNxSiYvWczYhBV6HKo+YRWvMbtImwmq8KlMzmZQCmgZ22gWIv7MnKpgHyeR
         Gb7g==
X-Forwarded-Encrypted: i=1; AKwUvBwcyx3dgs/PGtMtd/1fkuF+ZlhlznSPwHy+Nwm6I3K5sEcoq7tLXZFnG/q04FSa8JmcuHnSVMg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVaMSCLq6XrJxiRnhn6lEdK/mn0sORt7JMO0ryGNbKw1iNvOti
	8Ra4MiJk28Il0M/nJRMYnHQ7OAoIPEGjqpgGr3yJ0TvICe9dwYMkePuc7HpjmqYzVCtI6E+5+d1
	FNleprxVElnmT+AuMKZNfoMSVMzTOte5183LpKy3wBCaAISuZAZ3vw7ynFQ==
X-Gm-Gg: AYBFou3fBO8JHS6tekZctU2WMX/78A6NgcPL2318uOw8KGARtkseExUDV+x4D86hRkQ
	TbUoZmFZGVKr/XcMD24WSkgVZficKIKGlJwCPh5p8Fq1K0yE9D6N3pUbN7peoBZdn2e16GZ7+Ul
	k+cFmSpSYNgPw1cERG4uUyzLN+ewdnmaKsKSr6wS3NT4Rpxiare7Zu5MBTKvGkB8C+u8cw3mfSj
	4RYrHQKBGxcAsjjJZQtXxVmXCUhOmyq1+8LeHfgBb4L05nxxPM1uZwQkj//RWQe6+54T8XWYOEx
	PHRBL7jvI56IvphzNmf2ie0/nNB/UH82cH4Oht1XkWmESRMtAV/cJGA2yZtI0wfE22+6vg==
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a18e4f56bcmr247258515e9.33.1791889124820;
        Tue, 13 Oct 2026 03:58:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a18e4f56bcmr247258035e9.33.1791889124335;
        Tue, 13 Oct 2026 03:58:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc50e0sm5758574f8f.49.2026.10.13.03.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:58:43 -0700 (PDT)
Date: Tue, 13 Oct 2026 06:58:41 -0400
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
	Rusty Russell <rusty@rustcorp.com.au>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 4/4] net: account for ingress-resolved virtio net
 hdr state
Message-ID: <d82518764906d3b552fd3ade65b96ac741197d4e.1791887415.git.mst@redhat.com>
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

Ingress resolution of uncommon virtio net hdr checksum metadata
(software checksum completion at ingress) adds performance overhead but
is currently invisible: no counter tracks it, so a hypothetical workload
relying on uncommon metadata cannot be distinguished from none at all,
and packets quietly pay the host-CPU checksum overhead instead of offload.

Have virtio_net_hdr_to_skb() return 1 when it completes an uncommon
checksum in software, and flip every converter call site to test for
negative errno.  Have tun count these events per device as
rx_csum_sw and expose the counter via ethtool -S.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")

---
 drivers/net/tap.c          |  4 ++--
 drivers/net/tun.c          | 44 ++++++++++++++++++++++++++++++++++++--
 drivers/net/virtio_net.c   |  2 +-
 include/linux/virtio_net.h | 12 +++++++++--
 net/packet/af_packet.c     |  4 ++--
 5 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index ff67d99deb39e..73e8833944463 100644
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
index 242899f7fd071..138ca8987dfc6 100644
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
@@ -1935,11 +1936,19 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
+	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
+	if (err < 0) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
 	}
+	if (err > 0)
+		atomic_long_inc(&tun->rx_csum_sw);
+	/* The status is consumed: keep err clear so later exit paths
+	 * (XDP drop via unlock_frags) do not return it to write() as
+	 * a short count.
+	 */
+	err = 0;
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
 		skb->protocol = eth_type_trans(skb, tun->dev);
@@ -2605,12 +2614,15 @@ static int tun_xdp_one(struct tun_struct *tun,
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
@@ -3739,7 +3751,35 @@ static void tun_get_channels(struct net_device *dev,
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
+	data[0] = atomic_long_read(&tun->rx_csum_sw);
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
index daab43ac92ce4..2e6fd81df9c41 100644
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
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index b181183118b3a..d8447db58ac83 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -14,6 +14,14 @@
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
 
+/*
+ * virtio_net_hdr_to_skb() and virtio_net_hdr_tnl_to_skb() return 0 on
+ * success and a negative errno on failure.  On success they may also
+ * return 1, indicating that an uncommon checksum was completed in
+ * software at ingress rather than deferred to the egress path;
+ * drivers can use this to account for such packets.
+ */
+
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
 	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -292,7 +300,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 		err = skb_checksum_help(skb);
 		skb->transport_header = old_transport;
-		return err;
+		return err ?: 1;
 	}
 
 	return 0;
@@ -441,7 +449,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
 	/* Let the basic parsing deal with plain GSO features. */
 	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
 				      hdr->gso_type & ~gso_tunnel_type, false);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* In case of USO, the inner protocol is still unknown and
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 52ae3d875e971..e6aec9ecfa994 100644
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

