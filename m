Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735191;
	b=QgLQNUimBqwpk0lhe75uvVZCj/KCux7JJpVkDyuB4geyzFXsEIoDN7zoHv1RxILnRqkG
	 oCla6cCV+5buXyiFHV1y7Yr5yumY32pespgb3EgHp8QzQjFgEXMvbwkuk3jTioqIa91FQ
	 6W6tmg2wtAfUF225yhWi6RvTGAtRHYNOIA9gZ1kIb2NZOreUKvGuOIXUHzKTlViZR5IqJ
	 TO02TkNJRQ9WTet5Hkec1kANS0B1y16ZjvRBtxechm+cRty1/jeAJTsph/G2bugx/Ekgd
	 xsnOv46OSeRZyoCmzd0Fd0gSUnKtQQQUt8oIYDphlAAjaxPWBKBj8W4T8mBy4Sng1tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=m5KNnufLayOc033TTzK3HbAnBHy31BwDE7It1VguZvU=;
	b=w13KPzZHvw78v1hD9IxXz1YiWdJpxDP9/AfjPF7T7xKlfw0/MspS4cUnEXjHDSJgngE8
	 hE3oMPLhRLq0MA9g+3JS0VZVJkexziux0MIUS9qsGJVdznABI2qnxg/UijfwJfy9vN38M
	 5aWo8L0zoTy+oMyxbR4AsVTntXYs+lWj6DX+TsFXFEBRwI8szyYZEEAuHr7QBvXRjPqTX
	 c5l1J24LWe0stJ01xkQr/dAXrSV4+FQZ1fgvr8JcVyqddIkUB+Wsdv4CZnEtmUqKZrUmt
	 BmbS9W5KT9cf9mJyCy8ckGa7ALNXsMtmE3ZnGDTkdbB9ORqazEB/+ucdzdHu6D8k/XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2UNharF;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D7606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B79D7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2UNharF
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7cc53938a8fso2644229137.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793735189; x=1794339989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m5KNnufLayOc033TTzK3HbAnBHy31BwDE7It1VguZvU=;
        b=d2UNharF5o5NCMoH+tqtlE4wR9i/bS0pYXnPGrwDrJeRWDBf/10j0I7FDR6vLeczvd
         6W9RYlF/oFXn9MUx7SDN1cydNFw5Xt/Fq0NYOAazBJPNw9WA2tOczu25886Eh+Qw5X6v
         fEIwdS4MwDNrKbF3qBSJwgBQCUHnZRpfWHGOcJOw8fosV+HfPLkDyFWvnrHTcv7SmK4B
         msH1jnpJGEgWKEsTEidjFlP4WLQYodoHs6H3gvF8xa2l34CmU3dGbK29Nxv5v1Vr1NwT
         0Chv4DmKHZq6ydvsWLVlQ3mfWm7J9r5YAFnsevqHt1U2r3M9RHm+dy7uxdDt9Rc6nkbT
         xBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735189; x=1794339989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m5KNnufLayOc033TTzK3HbAnBHy31BwDE7It1VguZvU=;
        b=wRDvVWEctUfQZOQ+GT4gXGBgiwAyUoNOPXj8087jCc+5xsLs3p4mseuWP3LwQP6mxZ
         0q/JnNn5mGFznUW6iUVPtawZqprVvZvy2CBBNmHaGDQcd6DpFSlcZzcvFLpEu5+rWrMb
         yaXhxg6TIvXfiRLYdUpwK3n8sFHmwGZVpgNujHvM2h+cfyFlZmo42AfD1TPL6T5QWaNU
         UFB0KxecUAY+NxtfLmwQRIwvAsAaMizWlX6NLK9/nO750f8Y7ywZK/KR3YQTXzz4EFsE
         fbmhuCWOqxdymMlY3Vx7iVipfjREJvE63/K0fUZl71DDI4jmUM6jqocLyxIctaMhexMJ
         DnuA==
X-Gm-Message-State: APuU4Z+1SRhs21rXsTndmncxHH3Z4SMAS7keq3DJxnat7ZUKtPvMKJDb
	ndjw2M2W4Q8Oouxci0Lx7+5Dv3OhC1WU6w4l4nbX80uPDNY5pySg4exvht/NEg==
X-Gm-Gg: AYBFou0cRnPJCOw06Ib4bPuC5t4HntK4kvo+QrhTV67WwsTOnn5TCVKVj/4Lo/kcaDL
	5T381gLnWtV0r3vkPQzp1BKRIz7LKgkEoQv/wyXXiGJl66HoNBp35RZwucXdVwZqJx3Ljwd2MBY
	ewPUGrpH9wDWcfnqDVf94f6OV+xoKo1AbEJhXJQMpxUsqtxKqVIV0zX5WR1wtg7QFf/2zCjdKJ2
	W5LrA83UY+AlOLcFp1DZkNXEHk9IE9txOEWTJ3HnOUvRSX6GltfdY/k4rg3T3MpYU3bgA44jt4G
	2xbhcn6JNbrE7IDaOwlE92gT33S96E/bG8mswbukcSSCEmckTXjkubHkN9esPtiBx+Z2kH2IpP6
	WFdkmOAhgZPYNzZE1DgAhbpMXbIcwqwaV1CZ5qypwCONeb84x2OdGX566LMv1syaTXgavepXFUY
	8/iqBVsU1u/o8Ny1/pjfbiPLQX7ARkTv7LqJP5jbGoqWrMnFID7B2jj5xUx8QxahFVuSdZPkihS
	qPYg0yK4LWnbiRmOcRsGnfW89vAP1tM1R63MqYIMlxXonhz5E4oxEmG8IbGTNOdQQOAnhEt7bQY
	EKVdho/cTFBRxLsfyqOOm2u1ZJKU3l+WieZTsI9Y4xB1isTcH49DsXngrEzDrb8RJqfWC1XAqno
	fO2DooSIpE4dxQayXuDRVwH6SCkhmivba2gPcn+eOYOG7RV57WSpdpC0QsjPRg2Xe1PUjoGfMsN
	mjVaB7dW7irsyoAQJdrV0=
X-Received: by 2002:a67:e109:0:b0:7d0:6cf3:d8f6 with SMTP id ada2fe7eead31-7d072ce1bbemr4818581137.28.1793735189040;
        Tue, 03 Nov 2026 11:46:29 -0800 (PST)
Received: from willemb.c.googlers.com.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26feb4c57sm53253137.10.2026.11.03.11.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:46:28 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	paul@xen.org,
	wei.liu@kernel.org,
	mst@redhat.com,
	axboe@kernel.dk,
	josef@toxicpanda.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] net: skbuff: replace ubuf_info ops ptr with type id
Date: Tue,  3 Nov 2026 14:46:20 -0500
Message-ID: <20261103194625.1628600-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Avoid an easily corruptible callback pointer on skb linear
out-of-bounds write bugs.

skb_shinfo(skb)->destructor_arg points to a struct ubuf_info, whose
first member is a ubuf_info_ops vtable pointer. Corrupting
skb_shared_info gives a trivial one-hop indirect call primitive via
uarg->ops->complete.

Replace ubuf_info_ops with a u8 type ID and dispatch to the known
completion callbacks in net_zcopy_complete(). Aside from removing the
vtable pointer, this shrinks struct ubuf_info from 16 to 8 bytes and
avoids an indirect call in the hot path.

A few callback implementations can reside in modules, so require
dynamic registration. Add a concise registration helper and use
static_call to avoid indirect calls where supported.

The .link_skb callback is only used by io_uring. Convert that into a
direct call.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

This patch touches tun, tap, xen, vhost-net, io_uring. If preferred,
I can split it into a series.

msg_zerocopy_complete is so simple that it can conceivably be inlined,
along with part of net_zcopy_complete, but chose simplicity over that
additional optimization.
---
 drivers/net/tap.c                   |  8 ++-
 drivers/net/tun.c                   |  8 ++-
 drivers/net/xen-netback/common.h    |  3 --
 drivers/net/xen-netback/interface.c |  2 +-
 drivers/net/xen-netback/netback.c   | 10 ++--
 drivers/vhost/net.c                 | 18 ++++---
 include/linux/io_uring/net.h        | 20 ++++++++
 include/linux/skbuff.h              | 27 ++++++----
 io_uring/notif.c                    | 13 ++---
 io_uring/notif.h                    |  3 +-
 net/core/skbuff.c                   | 80 ++++++++++++++++++++++++++---
 net/packet/af_packet.c              | 10 ++--
 12 files changed, 142 insertions(+), 60 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 2f19fb07bb2d..0f3ad8fd6ab6 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -665,12 +665,10 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 		skb_set_network_header(skb, depth);
 
 	/* copy skb_ubuf_info for callback when skb has no error */
-	if (zerocopy) {
+	if (zerocopy)
 		skb_zcopy_init(skb, msg_control);
-	} else if (msg_control) {
-		struct ubuf_info *uarg = msg_control;
-		uarg->ops->complete(NULL, uarg, false);
-	}
+	else if (msg_control)
+		net_zcopy_complete(NULL, msg_control, false);
 
 	dev_queue_xmit(skb);
 	rcu_read_unlock();
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dcec7311e601..8920c797acfd 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1954,12 +1954,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		skb->protocol = eth_type_trans(skb, tun->dev);
 
 	/* copy skb_ubuf_info for callback when skb has no error */
-	if (zerocopy) {
+	if (zerocopy)
 		skb_zcopy_init(skb, msg_control);
-	} else if (msg_control) {
-		struct ubuf_info *uarg = msg_control;
-		uarg->ops->complete(NULL, uarg, false);
-	}
+	else if (msg_control)
+		net_zcopy_complete(NULL, msg_control, false);
 
 	skb_reset_network_header(skb);
 	skb_probe_transport_header(skb);
diff --git a/drivers/net/xen-netback/common.h b/drivers/net/xen-netback/common.h
index 17421da139f2..78cc4365dd13 100644
--- a/drivers/net/xen-netback/common.h
+++ b/drivers/net/xen-netback/common.h
@@ -390,9 +390,6 @@ bool xenvif_rx_queue_tail(struct xenvif_queue *queue, struct sk_buff *skb);
 
 void xenvif_carrier_on(struct xenvif *vif);
 
-/* Callbacks from stack when TX packet can be released */
-extern const struct ubuf_info_ops xenvif_ubuf_ops;
-
 static inline pending_ring_idx_t nr_pending_reqs(struct xenvif_queue *queue)
 {
 	return MAX_PENDING_REQS -
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index a0a438881388..068ff15282e0 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -593,7 +593,7 @@ int xenvif_init_queue(struct xenvif_queue *queue)
 
 	for (i = 0; i < MAX_PENDING_REQS; i++) {
 		queue->pending_tx_info[i].callback_struct = (struct ubuf_info_msgzc)
-			{ { .ops = &xenvif_ubuf_ops },
+			{ { .type = UBUF_TYPE_XENVIF },
 			  { { .ctx = NULL,
 			      .desc = i } } };
 		queue->grant_tx_handle[i] = NETBACK_INVALID_HANDLE;
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 3cdb7fd659db..176642363153 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1158,7 +1158,7 @@ static int xenvif_handle_frag_list(struct xenvif_queue *queue, struct sk_buff *s
 	uarg = skb_shinfo(skb)->destructor_arg;
 	/* increase inflight counter to offset decrement in callback */
 	atomic_inc(&queue->inflight_packets);
-	uarg->ops->complete(NULL, uarg, true);
+	net_zcopy_complete(NULL, uarg, true);
 	skb_shinfo(skb)->destructor_arg = NULL;
 
 	/* Fill the skb with the new (local) frags. */
@@ -1315,10 +1315,6 @@ static void xenvif_zerocopy_callback(struct sk_buff *skb,
 	xenvif_skb_zerocopy_complete(queue);
 }
 
-const struct ubuf_info_ops xenvif_ubuf_ops = {
-	.complete = xenvif_zerocopy_callback,
-};
-
 static inline void xenvif_tx_dealloc_action(struct xenvif_queue *queue)
 {
 	struct gnttab_unmap_grant_ref *gop;
@@ -1760,6 +1756,8 @@ static int __init netback_init(void)
 		fatal_skb_slots = XEN_NETBK_LEGACY_SLOTS_MAX;
 	}
 
+	net_zcopy_register(UBUF_TYPE_XENVIF, xenvif_zerocopy_callback);
+
 	rc = xenvif_xenbus_init();
 	if (rc)
 		goto failed_init;
@@ -1771,6 +1769,7 @@ static int __init netback_init(void)
 	return 0;
 
 failed_init:
+	net_zcopy_register(UBUF_TYPE_XENVIF, NULL);
 	return rc;
 }
 
@@ -1782,6 +1781,7 @@ static void __exit netback_fini(void)
 	debugfs_remove_recursive(xen_netback_dbg_root);
 #endif /* CONFIG_DEBUG_FS */
 	xenvif_xenbus_fini();
+	net_zcopy_register(UBUF_TYPE_XENVIF, NULL);
 }
 module_exit(netback_fini);
 
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4570a4ffbab2..435d8ed3851f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -431,10 +431,6 @@ static void vhost_zerocopy_complete(struct sk_buff *skb,
 	rcu_read_unlock_bh();
 }
 
-static const struct ubuf_info_ops vhost_ubuf_ops = {
-	.complete = vhost_zerocopy_complete,
-};
-
 static inline unsigned long busy_clock(void)
 {
 	return local_clock() >> 10;
@@ -926,7 +922,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 			vq->heads[nvq->upend_idx].len = VHOST_DMA_IN_PROGRESS;
 			ubuf->ctx = nvq->ubufs;
 			ubuf->desc = nvq->upend_idx;
-			ubuf->ubuf.ops = &vhost_ubuf_ops;
+			ubuf->ubuf.type = UBUF_TYPE_VHOST;
 			ubuf->ubuf.flags = SKBFL_ZEROCOPY_FRAG;
 			refcount_set(&ubuf->ubuf.refcnt, 1);
 			msg.msg_control = &ctl;
@@ -1895,15 +1891,25 @@ static struct miscdevice vhost_net_misc = {
 
 static int __init vhost_net_init(void)
 {
+	int rc;
+
 	if (experimental_zcopytx)
 		vhost_net_enable_zcopy(VHOST_NET_VQ_TX);
-	return misc_register(&vhost_net_misc);
+
+	net_zcopy_register(UBUF_TYPE_VHOST, vhost_zerocopy_complete);
+
+	rc = misc_register(&vhost_net_misc);
+	if (rc)
+		net_zcopy_register(UBUF_TYPE_VHOST, NULL);
+
+	return rc;
 }
 module_init(vhost_net_init);
 
 static void __exit vhost_net_exit(void)
 {
 	misc_deregister(&vhost_net_misc);
+	net_zcopy_register(UBUF_TYPE_VHOST, NULL);
 }
 module_exit(vhost_net_exit);
 
diff --git a/include/linux/io_uring/net.h b/include/linux/io_uring/net.h
index b58f39fed4d5..1759b1c22597 100644
--- a/include/linux/io_uring/net.h
+++ b/include/linux/io_uring/net.h
@@ -2,10 +2,19 @@
 #ifndef _LINUX_IO_URING_NET_H
 #define _LINUX_IO_URING_NET_H
 
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <net/net_debug.h>
+
 struct io_uring_cmd;
+struct sk_buff;
+struct ubuf_info;
 
 #if defined(CONFIG_IO_URING)
 int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags);
+void io_tx_ubuf_complete(struct sk_buff *skb, struct ubuf_info *uarg,
+			 bool success);
+int io_link_skb(struct sk_buff *skb, struct ubuf_info *uarg);
 
 #else
 static inline int io_uring_cmd_sock(struct io_uring_cmd *cmd,
@@ -13,6 +22,17 @@ static inline int io_uring_cmd_sock(struct io_uring_cmd *cmd,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void io_tx_ubuf_complete(struct sk_buff *skb,
+				       struct ubuf_info *uarg, bool success)
+{
+	DEBUG_NET_WARN_ON_ONCE(1);
+}
+
+static inline int io_link_skb(struct sk_buff *skb, struct ubuf_info *uarg)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #endif
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6787fcf6ac3e..73365c5de6f9 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -534,13 +534,18 @@ enum {
 #define SKBFL_ALL_ZEROCOPY	(SKBFL_ZEROCOPY_FRAG | SKBFL_PURE_ZEROCOPY | \
 				 SKBFL_DONT_ORPHAN | SKBFL_MANAGED_FRAG_REFS)
 
-struct ubuf_info_ops {
-	void (*complete)(struct sk_buff *, struct ubuf_info *,
-			 bool zerocopy_success);
-	/* has to be compatible with skb_zcopy_set() */
-	int (*link_skb)(struct sk_buff *skb, struct ubuf_info *uarg);
+enum ubuf_info_type {
+	UBUF_TYPE_NONE = 0,
+	UBUF_TYPE_MSG_ZEROCOPY,
+	UBUF_TYPE_IO_URING,
+	UBUF_TYPE_TPACKET,
+	UBUF_TYPE_VHOST,
+	UBUF_TYPE_XENVIF,
 };
 
+typedef void (*ubuf_complete_fn)(struct sk_buff *skb, struct ubuf_info *uarg,
+				 bool zerocopy_success);
+
 /*
  * The callback notifies userspace to release buffers when skb DMA is done in
  * lower device, the skb last reference should be 0 when calling this.
@@ -550,8 +555,8 @@ struct ubuf_info_ops {
  * The desc field is used to track userspace buffer index.
  */
 struct ubuf_info {
-	const struct ubuf_info_ops *ops;
 	refcount_t refcnt;
+	u8 type;
 	u8 flags;
 };
 
@@ -1757,7 +1762,9 @@ static inline void skb_set_end_offset(struct sk_buff *skb, unsigned int offset)
 }
 #endif
 
-extern const struct ubuf_info_ops msg_zerocopy_ubuf_ops;
+void net_zcopy_register(enum ubuf_info_type type, ubuf_complete_fn fn);
+void net_zcopy_complete(struct sk_buff *skb, struct ubuf_info *uarg,
+			bool zerocopy_success);
 
 struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
 				       struct ubuf_info *uarg, bool devmem);
@@ -1843,13 +1850,13 @@ static inline void skb_zcopy_set(struct sk_buff *skb, struct ubuf_info *uarg,
 static inline void net_zcopy_put(struct ubuf_info *uarg)
 {
 	if (uarg)
-		uarg->ops->complete(NULL, uarg, true);
+		net_zcopy_complete(NULL, uarg, true);
 }
 
 static inline void net_zcopy_put_abort(struct ubuf_info *uarg, bool have_uref)
 {
 	if (uarg) {
-		if (uarg->ops == &msg_zerocopy_ubuf_ops)
+		if (uarg->type == UBUF_TYPE_MSG_ZEROCOPY)
 			msg_zerocopy_put_abort(uarg, have_uref);
 		else if (have_uref)
 			net_zcopy_put(uarg);
@@ -1862,7 +1869,7 @@ static inline void skb_zcopy_clear(struct sk_buff *skb, bool zerocopy_success)
 	struct ubuf_info *uarg = skb_zcopy(skb);
 
 	if (uarg) {
-		uarg->ops->complete(skb, uarg, zerocopy_success);
+		net_zcopy_complete(skb, uarg, zerocopy_success);
 
 		skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
 	}
diff --git a/io_uring/notif.c b/io_uring/notif.c
index 6c49aff515df..cb2b8afd400c 100644
--- a/io_uring/notif.c
+++ b/io_uring/notif.c
@@ -10,8 +10,6 @@
 #include "notif.h"
 #include "rsrc.h"
 
-static const struct ubuf_info_ops io_ubuf_ops;
-
 static void io_notif_tw_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
 	struct io_kiocb *notif = tw_req.req;
@@ -68,7 +66,7 @@ void io_tx_ubuf_complete(struct sk_buff *skb, struct ubuf_info *uarg,
 	__io_req_task_work_add(notif, tw_flags);
 }
 
-static int io_link_skb(struct sk_buff *skb, struct ubuf_info *uarg)
+int io_link_skb(struct sk_buff *skb, struct ubuf_info *uarg)
 {
 	struct io_notif_data *nd, *prev_nd;
 	struct io_kiocb *prev_notif, *notif;
@@ -89,7 +87,7 @@ static int io_link_skb(struct sk_buff *skb, struct ubuf_info *uarg)
 	if (unlikely(nd->head != nd || nd->next))
 		return -EEXIST;
 	/* don't mix zc providers */
-	if (unlikely(prev_uarg->ops != &io_ubuf_ops))
+	if (unlikely(prev_uarg->type != UBUF_TYPE_IO_URING))
 		return -EEXIST;
 
 	prev_nd = container_of(prev_uarg, struct io_notif_data, uarg);
@@ -107,11 +105,6 @@ static int io_link_skb(struct sk_buff *skb, struct ubuf_info *uarg)
 	return 0;
 }
 
-static const struct ubuf_info_ops io_ubuf_ops = {
-	.complete = io_tx_ubuf_complete,
-	.link_skb = io_link_skb,
-};
-
 struct io_kiocb *io_alloc_notif(struct io_ring_ctx *ctx)
 	__must_hold(&ctx->uring_lock)
 {
@@ -137,7 +130,7 @@ struct io_kiocb *io_alloc_notif(struct io_ring_ctx *ctx)
 	nd->head = nd;
 
 	nd->uarg.flags = IO_NOTIF_UBUF_FLAGS;
-	nd->uarg.ops = &io_ubuf_ops;
+	nd->uarg.type = UBUF_TYPE_IO_URING;
 	refcount_set(&nd->uarg.refcnt, 1);
 	return notif;
 }
diff --git a/io_uring/notif.h b/io_uring/notif.h
index f3589cfef4a9..b0e0e179a80f 100644
--- a/io_uring/notif.h
+++ b/io_uring/notif.h
@@ -4,6 +4,7 @@
 #include <linux/uio.h>
 #include <net/sock.h>
 #include <linux/nospec.h>
+#include <linux/io_uring/net.h>
 
 #include "rsrc.h"
 
@@ -24,8 +25,6 @@ struct io_notif_data {
 };
 
 struct io_kiocb *io_alloc_notif(struct io_ring_ctx *ctx);
-void io_tx_ubuf_complete(struct sk_buff *skb, struct ubuf_info *uarg,
-			 bool success);
 
 static inline struct io_notif_data *io_notif_to_data(struct io_kiocb *notif)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f676411724..3ec9851d0a10 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -92,6 +92,8 @@
 #include <linux/capability.h>
 #include <linux/user_namespace.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/io_uring/net.h>
+#include <linux/static_call.h>
 #include <linux/textsearch.h>
 
 #include "dev.h"
@@ -1737,7 +1739,7 @@ static struct ubuf_info *msg_zerocopy_alloc(struct sock *sk, size_t size,
 		return NULL;
 	}
 
-	uarg->ubuf.ops = &msg_zerocopy_ubuf_ops;
+	uarg->ubuf.type = UBUF_TYPE_MSG_ZEROCOPY;
 	uarg->id = ((u32)atomic_inc_return(&sk->sk_zckey)) - 1;
 	uarg->len = 1;
 	uarg->bytelen = size;
@@ -1763,7 +1765,7 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
 		u32 bytelen, next;
 
 		/* there might be non MSG_ZEROCOPY users */
-		if (uarg->ops != &msg_zerocopy_ubuf_ops)
+		if (uarg->type != UBUF_TYPE_MSG_ZEROCOPY)
 			return NULL;
 
 		/* realloc only when socket is locked (TCP, UDP cork),
@@ -1898,10 +1900,72 @@ void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)
 }
 EXPORT_SYMBOL_GPL(msg_zerocopy_put_abort);
 
-const struct ubuf_info_ops msg_zerocopy_ubuf_ops = {
-	.complete = msg_zerocopy_complete,
-};
-EXPORT_SYMBOL_GPL(msg_zerocopy_ubuf_ops);
+static void net_zcopy_unregistered(struct sk_buff *skb, struct ubuf_info *uarg,
+				   bool zerocopy_success)
+{
+	DEBUG_NET_WARN_ON_ONCE(1);
+}
+
+DEFINE_STATIC_CALL(ubuf_complete_tpacket, net_zcopy_unregistered);
+DEFINE_STATIC_CALL(ubuf_complete_vhost, net_zcopy_unregistered);
+DEFINE_STATIC_CALL(ubuf_complete_xenvif, net_zcopy_unregistered);
+
+void net_zcopy_register(enum ubuf_info_type type, ubuf_complete_fn fn)
+{
+	ubuf_complete_fn cur;
+	bool reg = fn;
+
+	if (!fn)
+		fn = net_zcopy_unregistered;
+
+	switch (type) {
+	case UBUF_TYPE_TPACKET:
+		cur = static_call_query(ubuf_complete_tpacket);
+		static_call_update(ubuf_complete_tpacket, fn);
+		break;
+	case UBUF_TYPE_VHOST:
+		cur = static_call_query(ubuf_complete_vhost);
+		static_call_update(ubuf_complete_vhost, fn);
+		break;
+	case UBUF_TYPE_XENVIF:
+		cur = static_call_query(ubuf_complete_xenvif);
+		static_call_update(ubuf_complete_xenvif, fn);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	WARN_ON_ONCE(reg ? cur != net_zcopy_unregistered :
+			   cur == net_zcopy_unregistered);
+}
+EXPORT_SYMBOL_GPL(net_zcopy_register);
+
+void net_zcopy_complete(struct sk_buff *skb, struct ubuf_info *uarg,
+			bool zerocopy_success)
+{
+	switch (uarg->type) {
+	case UBUF_TYPE_MSG_ZEROCOPY:
+		msg_zerocopy_complete(skb, uarg, zerocopy_success);
+		break;
+	case UBUF_TYPE_IO_URING:
+		io_tx_ubuf_complete(skb, uarg, zerocopy_success);
+		break;
+	case UBUF_TYPE_TPACKET:
+		static_call(ubuf_complete_tpacket)(skb, uarg, zerocopy_success);
+		break;
+	case UBUF_TYPE_VHOST:
+		static_call(ubuf_complete_vhost)(skb, uarg, zerocopy_success);
+		break;
+	case UBUF_TYPE_XENVIF:
+		static_call(ubuf_complete_xenvif)(skb, uarg, zerocopy_success);
+		break;
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(net_zcopy_complete);
 
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			     struct msghdr *msg, int len,
@@ -1910,8 +1974,8 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 {
 	int err, orig_len = skb->len;
 
-	if (uarg->ops->link_skb) {
-		err = uarg->ops->link_skb(skb, uarg);
+	if (uarg->type == UBUF_TYPE_IO_URING) {
+		err = io_link_skb(skb, uarg);
 		if (err)
 			return err;
 	} else {
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index cf6429f09477..e08d5e315b65 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2606,10 +2606,6 @@ static void tpacket_ubuf_complete(struct sk_buff *skb, struct ubuf_info *uarg,
 	sk_free(&po->sk);
 }
 
-static const struct ubuf_info_ops tpacket_ubuf_ops = {
-	.complete = tpacket_ubuf_complete,
-};
-
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
@@ -2942,7 +2938,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 		uarg->po = po;
 		uarg->ph = ph;
-		uarg->ubuf.ops = &tpacket_ubuf_ops;
+		uarg->ubuf.type = UBUF_TYPE_TPACKET;
 		uarg->ubuf.flags = SKBFL_ZEROCOPY_FRAG;
 		refcount_set(&uarg->ubuf.refcnt, 1);
 
@@ -4931,6 +4927,7 @@ static void __exit packet_exit(void)
 	proto_unregister(&packet_proto);
 	unregister_netdevice_notifier(&packet_netdev_notifier);
 	unregister_pernet_subsys(&packet_net_ops);
+	net_zcopy_register(UBUF_TYPE_TPACKET, NULL);
 }
 
 static int __init packet_init(void)
@@ -4946,6 +4943,8 @@ static int __init packet_init(void)
 	rc = proto_register(&packet_proto, 0);
 	if (rc)
 		goto out_notifier;
+
+	net_zcopy_register(UBUF_TYPE_TPACKET, tpacket_ubuf_complete);
 	rc = sock_register(&packet_family_ops);
 	if (rc)
 		goto out_proto;
@@ -4953,6 +4952,7 @@ static int __init packet_init(void)
 	return 0;
 
 out_proto:
+	net_zcopy_register(UBUF_TYPE_TPACKET, NULL);
 	proto_unregister(&packet_proto);
 out_notifier:
 	unregister_netdevice_notifier(&packet_netdev_notifier);
-- 
2.56.0.385.gac671c819a-goog

