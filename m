Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC70E443A88
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927215; cv=none; b=EE8isEFCd/J+8yq4fmSa03yhB+1YT4HAeSb1q9B5R1aieMxX1mew0yEYQORkpGk8BNWKL3s30Xyr9kymbrW14QOs4bWtkJI6e9DE8f5PWQjWjxbZVz0t6FJ/wY2O3EqdEdS1YqEyhywMnPBJXQHOpy3Eml9xehF87IxQJxc6dMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927215; c=relaxed/simple;
	bh=Iph8cQPjQlzJvVdwLAMxAEBkHSEKgnnbrMaq0iNc5dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9I8Eckhhmrty9ZTUBdmqmvK+/BEJ5L16TUkDXfRPZB7XgJw5UtYKOUaGJPEwycXsbdYAegWiMdM13jZ8xfZJl9FzMAijCy+cXeXkgBDTHzPP5gSquroFZF85CPubhK+CAAJ+4t0+NGWwLfo7iZ2aiXYX7MunI/ocMmFd94XqdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm6Z0LbE; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm6Z0LbE"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-346c612c7a8so3835867eec.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 00:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790927212; x=1791532012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjJGZHeSlYSt0da6L8tYDnIpMtDpUH2iAs8gzn1WvfI=;
        b=Hm6Z0LbEMQSgcamMhN/vBIDwiCReIU5C9eVZJDOPMkXvYq5u5otrVCKRvFLbgVKSYJ
         nX63hikum8ie5Q4eHUweRKZAsOzwkgYm4AQvlHM4/CWp3Q7meLD2nYVFbuIeaiCYr7Tf
         CT9ig8NZH0cFqGxGDH7/w+IvpRT+h5cHb6aSekBTFpVYHLgenQc3PRiwnJh9YWJMdlcx
         ik3kTbTCj9zusS1x8Mx/xz8kBlR3IwTo1+fOhnltenzJnJV4HzecVxkGFqfLyu/hwKPx
         AbG5Br0ycitVJi5j9IRz0D4GUBTGb2RJyHViTfFwo5Q1urATiHRoQufxLtHwNXHmQAe9
         txlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927212; x=1791532012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pjJGZHeSlYSt0da6L8tYDnIpMtDpUH2iAs8gzn1WvfI=;
        b=TEb0DNI2k0P1vFupTTeygLf/UGexZTfEP/+BnupL9NMT/qdeomsu5Pqe942hQemltB
         BvjVX3jSdDzXgBSR/wOjORi/rpMjqkcjvDcFTgNXHDIPYHDFqhc48zkbyBGRDSGRrHI/
         OuAjKPbySMJTEwn5TOENlsVemSvxVYFEcOVVpp2zbtEoNXeVKrJMLvuuDnbKVIMrvGyM
         xLF6xiUvxFycsWTKUviYyDEnP3BCNBELkhhkOX6h++EyobdJ4r1F1byBKmzu27dtNKaB
         7cyvLjIrZcUpdIIGoN1NL9+zq93Zs2JD/oWpz/zbbVQec+YpfR2wL7fLk32J/TwZnASO
         E3Xw==
X-Forwarded-Encrypted: i=1; AKwUvBwJmA5ABuMF0Kp7pmuhAwdoy8Dnq18hJ86vZ5L7GJsPPEA62wVVszn4Ob5AE9CybxltMbuKnY8=@vger.kernel.org
X-Gm-Message-State: AFuF++lgBSwlNfSSym87yvL3tLp3Zf5x9UcO3iM5KK6Gun+/bvS9K//W
	huqr7Vqavz5GG6ROI0w2rPEKd7mxl9gJS9FnhVgKY/tiW/hZWEee9waU
X-Gm-Gg: AYBFou1M4480xZDPvDkXqkAZrqmsbVq4bjpKSDdi66eU3bSlshvd4F/3p4cYKQd/0Fp
	iqP/ZuC1XYruzPR4LlEd9eao0NVsdxDhWdDiKAMucRdU107ADa0OHJOBodubKP5ZADOF1WaImXC
	it0s6sYSRaLJAt8aRvEcMnwH3dbIVQhH3F1ZfYEtACgOdV9QkxaK0mJcLKBhe2P+sXIC95sUQk0
	fbnwerz1VSeXziTuO2wYEkZWq9G0OjZnRnoW8Yu24Axn2TX7yyyhl88j1ngPi+LMts/id3dczOl
	CvGH3wgNqkYtyiCVLThc8/km3tDgB3p6o1rQj2l4WWHj3jPzQ1WN0tmANt0IikT79tMDTJReXrn
	DVTf7AW5wqzbKC6pqViNH4cc2A6+uy9Js7jDvuBqZnQ1xhVHKMXqUlJWlsEdTkz1PoZtbNPi2Zv
	dboz5EeO2Oz3DfgLx1riKY/F8L/GX933So7lSDfmv8tFaMoXncA2zdd+zfJeONN6nsfepv
X-Received: by 2002:a05:7301:df43:b0:340:7202:d7fc with SMTP id 5a478bee46e88-34f150d9568mr2038092eec.17.1790927211285;
        Fri, 02 Oct 2026 00:46:51 -0700 (PDT)
Received: from dbg-srv ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm5871618eec.4.2026.10.02.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:46:50 -0700 (PDT)
From: physicalmtea@gmail.com
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] vsock: defer RX readable notifications until batch unlock
Date: Fri,  2 Oct 2026 07:45:51 +0000
Message-ID: <20261002074551.318789-6-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

An RX batch can make a socket readable while the worker still owns its
socket lock. Waking a reader at that point can make it immediately wait
for the same lock.

For the callback installed by sock_init_data(), record when the existing
low-watermark condition is met and issue one notification after the batch
releases the lock. Save the initial sock_def_readable() callback when the
AF_VSOCK socket is created. virtio_transport_common can be built as a
module and cannot refer to that unexported symbol directly.

Custom data-ready callbacks retain per-packet notification behavior. If
the callback changes while a default notification is pending, finish the
batch before returning to the per-packet path.

Keep the socket reference until the deferred callback completes. A sockmap
attachment takes the socket lock, so data queued before the attachment is
reported through the saved default callback.

Control packets, state transitions, transport changes and non-batched
sockets retain their existing behavior.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  1 +
 include/net/af_vsock.h                  |  3 +-
 net/vmw_vsock/af_vsock.c                |  1 +
 net/vmw_vsock/virtio_transport_common.c | 53 ++++++++++++++++++++++++++-----
 4 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f67fa99ec..d69c09d5c 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -289,6 +289,7 @@ struct virtio_transport_rx_batch {
 	struct sockaddr_vm src;
 	struct sockaddr_vm dst;
 	bool write_space_pending;
+	bool data_ready_pending;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 9d8ae6220..a799f0855 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -63,7 +63,8 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
-	/* Initial callback, used to identify replacements. */
+	/* Initial callbacks, used to identify replacements. */
+	void (*default_data_ready)(struct sock *sk);
 	void (*default_write_space)(struct sock *sk);
 
 	/* Protected by lock_sock(sk) */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index e5290a3bb..1a25b5393 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
 		sk->sk_type = type;
 
 	vsk = vsock_sk(sk);
+	vsk->default_data_ready = sk->sk_data_ready;
 	vsk->default_write_space = sk->sk_write_space;
 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 78c4e2f9e..e337a7aaf 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1583,7 +1583,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 
 static int
 virtio_transport_recv_connected(struct sock *sk,
-				struct sk_buff *skb)
+				struct sk_buff *skb,
+				bool *data_ready_pending)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
@@ -1602,7 +1603,14 @@ virtio_transport_recv_connected(struct sock *sk,
 			vsock_remove_sock(vsk);
 			break;
 		}
-		vsock_data_ready(sk);
+		if (!data_ready_pending ||
+		    READ_ONCE(sk->sk_data_ready) != vsk->default_data_ready) {
+			vsock_data_ready(sk);
+		} else if (!*data_ready_pending &&
+			   (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
+			    sock_flag(sk, SOCK_DONE))) {
+			*data_ready_pending = true;
+		}
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
 		virtio_transport_send_credit_update(vsk);
@@ -1836,6 +1844,7 @@ struct virtio_transport_rx_pkt_ctx {
 	const struct sockaddr_vm *dst;
 	bool *batchable;
 	struct virtio_transport_rx_batch *batch;
+	bool defer_data_ready;
 };
 
 static bool
@@ -1852,9 +1861,11 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
 }
 
 /*
- * The caller holds sk's socket lock.  Set @batchable if the socket can remain
- * locked for another ordinary STREAM/RW packet.  Return true if the caller
- * must free @skb.
+ * The caller holds sk's socket lock. The packet context optionally records
+ * callbacks to deliver when the batch finishes. If defer_data_ready is true,
+ * defer the default data-ready callback in the batch. Set batchable if the
+ * socket can remain locked for another ordinary STREAM/RW packet. Return
+ * true if the caller must free skb.
  */
 static bool
 virtio_transport_recv_pkt_locked(struct virtio_transport *t,
@@ -1902,7 +1913,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	case TCP_ESTABLISHED:
-		virtio_transport_recv_connected(sk, skb);
+		virtio_transport_recv_connected(sk, skb,
+						ctx->defer_data_ready && ctx->batch ?
+						&ctx->batch->data_ready_pending : NULL);
 		break;
 	case TCP_CLOSING:
 		virtio_transport_recv_disconnecting(sk, skb);
@@ -1971,10 +1984,12 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 {
 	struct sock *sk = batch->sk;
 	bool write_space_pending = batch->write_space_pending;
+	bool data_ready_pending = batch->data_ready_pending;
 
 	batch->sk = NULL;
 	batch->net = NULL;
 	batch->write_space_pending = false;
+	batch->data_ready_pending = false;
 
 	if (!sk)
 		return;
@@ -1983,6 +1998,16 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 	if (write_space_pending)
 		vsock_sk(sk)->default_write_space(sk);
+
 	release_sock(sk);
+
+	/*
+	 * This event covers data queued while the default callback was installed.
+	 * A sockmap attachment takes the socket lock, so it is ordered after that
+	 * enqueue even if it replaces the callback before this call.
+	 */
+	if (data_ready_pending)
+		vsock_sk(sk)->default_data_ready(sk);
+
 	sock_put(sk);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
@@ -1995,7 +2017,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	struct sockaddr_vm src, dst;
 	struct sock *sk;
 	struct virtio_transport_rx_pkt_ctx ctx;
-	bool batchable, start_batch;
+	bool batchable, defer_data_ready, start_batch;
 	bool free_pkt;
 
 	/* Only STREAM/RW packets can share a socket lock. */
@@ -2015,6 +2037,13 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 		    vsock_addr_equals_addr(&batch->dst, &dst) &&
 		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
 			sk = batch->sk;
+			defer_data_ready = READ_ONCE(sk->sk_data_ready) ==
+					   vsock_sk(sk)->default_data_ready;
+			if (batch->data_ready_pending && !defer_data_ready) {
+				virtio_transport_rx_batch_finish(batch);
+				goto lookup;
+			}
+
 			if (!skb_set_owner_sk_safe(skb, sk)) {
 				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
 				virtio_transport_rx_batch_finish(batch);
@@ -2028,6 +2057,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 				.dst = &dst,
 				.batchable = &batchable,
 				.batch = batch,
+				.defer_data_ready = defer_data_ready,
 			};
 			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 			if (!batchable)
@@ -2040,6 +2070,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 		virtio_transport_rx_batch_finish(batch);
 	}
 
+lookup:
 	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
 	if (!sk) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
@@ -2060,6 +2091,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	 */
 	read_lock_bh(&sk->sk_callback_lock);
 	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
+	defer_data_ready = start_batch &&
+		READ_ONCE(sk->sk_data_ready) == vsock_sk(sk)->default_data_ready;
 	read_unlock_bh(&sk->sk_callback_lock);
 
 	if (start_batch)
@@ -2070,10 +2103,11 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 		.dst = &dst,
 		.batchable = start_batch ? &batchable : NULL,
 		.batch = start_batch ? batch : NULL,
+		.defer_data_ready = defer_data_ready,
 	};
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 	if (start_batch && batchable) {
-		/* Keep the lookup reference until the batch is released. */
+		/* Keep the lookup reference until the batch finishes. */
 		batch->net = net;
 		batch->src = src;
 		batch->dst = dst;
-- 
2.53.0
