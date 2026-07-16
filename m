Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F6541C2FC
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219876; cv=none; b=cLteFqP0yfnRErxAVNSQhSKe17onz6uSM5N6XXXGKZLXRsrwTX3ncxq33y9Yror1HTKcqS2WsmedqnkC7I7J37lSPEn2TWrPci2d1v4JxHCB5QdEtzpFUQ7RBfEkSJpQ+QX5VmeYx4DoQFvMOSOxPaaQP6p9rlSORQMcq+/H9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219876; c=relaxed/simple;
	bh=o/HwCVgYgQFkz0/ODb7pKMxQLGAduLjD199HG59bSMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuVpSumQZv+89Ve/ncWcAcDsGqJ+DaCIu9l+VnSn57AQmeIOU3xfFD9dvrCvqiEgtCSyiKY6HHReA1Ys+ivwjsR+IFmqs8DKhzON2tHQMkF5pNcPRop5CW7LoKIVyC8yOjHGH8fMlM0+u/rJnb1M1In8w6ZAY0a1LYdVXd0tULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7f48cp4; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7f48cp4"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c923b8c2aso65235381fa.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784219862; x=1784824662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7CwBdf7YTl0lNtDo3SBe9j9ZzLE2uAoBiUh1WwfPJrk=;
        b=M7f48cp4I0hteFI5/USpDZwKw8qvmCAzFC8n/QB7fNdDX95CxoWBuu80JmXBzvpQL5
         +A1XWjIq+J8JdgUGBDIYvWTLthSNeQx2fvuvkr6bI8TBslhO/rjk0G1yoad7VM2OWv3n
         gh4J5gDfSLKeLCtuF/nj8zd/lT6mdhwwSr03sdkm3y4HTZD/kLDqVhYgvZdpZeEkV+iO
         4TrnEaKTvbopKIB7Ph8OZLM3r4ncsqPoVGkTa9GtHgp5RBl5o4coht+cD6eZDA0Z3uY5
         37RTWcQ/eqj15gEomEcIA+lVZP8yL8W4zf2auHajOx4rfbeViVscHWAZRLldN/TgWUSL
         wEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784219862; x=1784824662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7CwBdf7YTl0lNtDo3SBe9j9ZzLE2uAoBiUh1WwfPJrk=;
        b=JrHpvEugpHjADfpiZXTdnkyvezjH6hGSWjEGVgdtd2ylfKc1JnuryGoX+ztH4Kxbv0
         1vcfURO0VUnWssAlzVlUflpe51DpGuPoJNvfOpEiUoXuoU+yrXEitW8kXVkBmRTZjlqy
         AHAf8jkL/U0oSf1P856/O5pyHm4vuPQ+e6toGbuNaKzPVDhdcOYa8R0Vxa5Z4w4Rb2Vp
         Q0QPpah/nC0Bsyr+sCbRgr5dixYrldfEDJg6+c5tSFz9Rgo8J3goBnV7ExVCFJLHIT8K
         60QrxK85Aunw0ion/GQgfT+n2bBwkieBrYaVDwr84LH+vA2hpmQbU7/I1aQu7Bgmnkp9
         /cfA==
X-Forwarded-Encrypted: i=1; AHgh+RrYWtVOLLBy6qy1SahwMw3FXYwnx1kq45Z2wT0rrlij5yv052kd55e+H3iEpFIAhwWNucjmgYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsTF7fcPd6DSr1nrycjTC2nqfZxN4dLDyuJNCR1fRHGvdb11uW
	XEV7a4+v6DLNzUgdiFTzWkqXBctPmxey7rvD1ztUi909+mfZlKj7OeSP
X-Gm-Gg: AfdE7cnFpo1PTdu0Xt3RrCGNULvSBXja/bSkugnLwG3vNf3uPU925YtXB+qjNy+/eOB
	L4Hs+Bh2DHLujsYOc1YzXInioPUlFPzRnVw0SIZT+kBHRXxn50d2gIXDfbI87w2MLOpIa3WVMDb
	vHDy/O2fUIoQ72e4b1vVI5e8CydERoQm+N/fvFAT4vK+UIzi8Jgub9tJ6UXfZCmub5ATji/HlWU
	uY03CZZCIeC9AyzRUTI7HzBt3+sj1ApLHk4utIn+Dm6JUI+z5FSomAXLMvyz+wpeSEeoL37QJu1
	bOdXeXrNepeeIY4CHz8AtdN0RbKOXy0b2LIlM0w6LUHZo9HZ0H8wEy0eEIczLpIXDclruQcGXio
	TNry8+wobfLavO1YjdrlmsoPEmTw2u83n1A6VDL6rr7lbN61MwgmByOInRaCsWZzHwEm3cz/R5+
	dkBXIinNsJ
X-Received: by 2002:a05:6512:3b20:b0:5b0:21e3:672a with SMTP id 2adb3069b0e04-5b159b8b887mr2052865e87.56.1784219862231;
        Thu, 16 Jul 2026 09:37:42 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01caaf468sm5164318e87.68.2026.07.16.09.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:37:40 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: [PATCH 6.12] vsock/virtio: fix zerocopy completion for multi-skb sends
Date: Thu, 16 Jul 2026 19:35:59 +0300
Message-ID: <20260716163600.115458-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

commit ae38d9179190a956e2a87a69ef1dd6f451b51c4d upstream.

When a large message is fragmented into multiple skbs, the zerocopy
uarg is only allocated and attached to the last skb in the loop.
Non-final skbs carry pinned user pages with no completion tracking,
so the kernel has no way to notify userspace when those pages are safe
to reuse. If the loop breaks early the uarg is never allocated at all,
leaking pinned pages with no completion notification.

Fix this by following the approach used by TCP: allocate the zerocopy
uarg (if not provided by the caller) before the send loop and attach
it to every skb via skb_zcopy_set(), which takes a reference per skb.
Each skb's completion properly decrements the refcount, and the
notification only fires after the last skb is freed.
On failure, if no data was sent, the uarg is cleanly aborted via
net_zcopy_put_abort().

This issue was initially discovered by sashiko while reviewing commit
1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
but was pre-existing.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
Reported-by: Maher Azzouzi <maherazz04@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Link: https://patch.msgid.link/20260514092948.268720-1-sgarzare@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-53365
 net/vmw_vsock/virtio_transport_common.c | 78 +++++++++++--------------
 1 file changed, 34 insertions(+), 44 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 95170c7be758..aeb205e84bd3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -72,35 +72,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 	return true;
 }
 
-static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
-					   struct sk_buff *skb,
-					   struct msghdr *msg,
-					   bool zerocopy)
-{
-	struct ubuf_info *uarg;
-
-	if (msg->msg_ubuf) {
-		uarg = msg->msg_ubuf;
-		net_zcopy_get(uarg);
-	} else {
-		struct iov_iter *iter = &msg->msg_iter;
-		struct ubuf_info_msgzc *uarg_zc;
-
-		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
-					    iter->count,
-					    NULL);
-		if (!uarg)
-			return -1;
-
-		uarg_zc = uarg_to_msgzc(uarg);
-		uarg_zc->zerocopy = zerocopy ? 1 : 0;
-	}
-
-	skb_zcopy_init(skb, uarg);
-
-	return 0;
-}
-
 static int virtio_transport_fill_skb(struct sk_buff *skb,
 				     struct virtio_vsock_pkt_info *info,
 				     size_t len,
@@ -321,8 +292,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 src_cid, src_port, dst_cid, dst_port;
 	const struct virtio_transport *t_ops;
 	struct virtio_vsock_sock *vvs;
+	struct ubuf_info *uarg = NULL;
 	u32 pkt_len = info->pkt_len;
 	bool can_zcopy = false;
+	bool have_uref = false;
 	u32 rest_len;
 	int ret;
 
@@ -364,6 +337,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		if (can_zcopy)
 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
 					    (MAX_SKB_FRAGS * PAGE_SIZE));
+
+		if (info->msg->msg_flags & MSG_ZEROCOPY &&
+		    info->op == VIRTIO_VSOCK_OP_RW) {
+			uarg = info->msg->msg_ubuf;
+
+			if (!uarg) {
+				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
+							    pkt_len, NULL);
+				if (!uarg) {
+					virtio_transport_put_credit(vvs, pkt_len);
+					return -ENOMEM;
+				}
+
+				if (!can_zcopy)
+					uarg_to_msgzc(uarg)->zerocopy = 0;
+
+				have_uref = true;
+			}
+		}
 	}
 
 	rest_len = pkt_len;
@@ -382,21 +374,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 		}
 
-		/* We process buffer part by part, allocating skb on
-		 * each iteration. If this is last skb for this buffer
-		 * and MSG_ZEROCOPY mode is in use - we must allocate
-		 * completion for the current syscall.
-		 */
-		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
-		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
-			if (virtio_transport_init_zcopy_skb(vsk, skb,
-							    info->msg,
-							    can_zcopy)) {
-				kfree_skb(skb);
-				ret = -ENOMEM;
-				break;
-			}
-		}
+		skb_zcopy_set(skb, uarg, NULL);
 
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
@@ -420,6 +398,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 
 	virtio_transport_put_credit(vvs, rest_len);
 
+	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
+	 * skb_zcopy_set() increases it for each skb, so we can drop that
+	 * initial reference to keep it balanced.
+	 */
+	if (have_uref) {
+		if (rest_len == pkt_len)
+			/* No data sent, abort the notification. */
+			net_zcopy_put_abort(uarg, true);
+		else
+			net_zcopy_put(uarg);
+	}
+
 	/* Return number of bytes, if any data has been sent. */
 	if (rest_len != pkt_len)
 		ret = pkt_len - rest_len;
-- 
2.43.0

