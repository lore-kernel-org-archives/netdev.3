Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679162;
	b=K8qlPlKi+hSOqfbtsTy3N9nePabYF0HPRoWht0v24oQ4b7TsrykI5KASuQqcH9GRz4hJ
	 Ma52RsWV95RERX5+lHlNtFGgDoQTK2YwqE6qIh0JmYipm4a5ylJIdau715Y0HGAJrSKdh
	 WbT1L4/zxR9qYMJNeH4QCN6Xm2Fp0yayLIAi/Eu3a5dNUirCqqS2U/HxC5054ICBHlJY2
	 igw8MXT9ehoHYhUllmS16B/gdfZUOP3v7CENxApaFom1RAoLR6n/MRmUYSdsZ6Uvkj7NL
	 ZqWQ5JzvE59IwkP9jSvzpgaYmEX3XBULHKVmEFV7do1bU7vm3rpqlSn3vloWj67sdvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AoK1tSvrGC/yGpo34e5d7pEB1O9R0LQE99Bs7YS2fkw=;
	b=MJRVqq1JTtRp4Gr0bebRa9xVYxNGvGIW0gWKMEbkjJKAVwo+cV6ydRUXwVeoiyN+RsrH
	 3FUBxI1KWiA47n3sWGh9J2mQg7At8xdDnOTIvd9yqK5/T1NjBcpfDkVYWHzwHfxVm4/61
	 +05i9VJhT6jydrwfBMP98eZxkIVFlAuhq/8lHW+9+QcvLaA7VAKilijbZ7EW+AtGGplyQ
	 Bz3DjRCu0J8q+sspXGSrhL3vZDAIYoQbj1xc2m4M9XNam+BKlCg4yXj1RMQOgRBR9OJZa
	 LlqL7leW5wjkjDtmpUwXaDS2qPl/hzT0Ad/jO6xk+MAFmmkLQQlVmu9U8vppo6AKCRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yNb5JtGr;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0EA606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 04:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D0EA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yNb5JtGr
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b07db03f41so211435a91.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 20:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793679162; x=1794283962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AoK1tSvrGC/yGpo34e5d7pEB1O9R0LQE99Bs7YS2fkw=;
        b=yNb5JtGr8cWg5rgW1J6E4bnifWYrSmlFuU4BFB4PrdDiock0WoXQJSnoDQ/L5yHiTC
         LxrnCsVRpGrSizZV6gvhHqJ6thD5TD1LQc8Ayb7CQbdyA/KtE2Sq0Ti6NDl/LvpTd9PW
         6jA7il4MedAFpJDcCBW/Bo3jG2g1JGqf/V89cymLwPJHMqMgYWi2hhFhkC2/i2Pe9KI5
         6Yi7LxTM6A8eAZe1HLf7xYUKKkr9y+jD72q5Ah4F+3V1EVQUTGDhgHEmPeFghvzzzfVB
         KReqJ0ql86WwSd9wmCovyUBASO8+BIMWferu3vt5faIJSUtJzjFUy+4E5B5ysKlWtSao
         wCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793679162; x=1794283962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AoK1tSvrGC/yGpo34e5d7pEB1O9R0LQE99Bs7YS2fkw=;
        b=zvJfK0ZI9wsL6y6GZwNGrFMlU0jHtHhy7P2nCztt9ZBxJqzPZJDeGPuNoMcbGW1zzx
         2UszZFuYllW1/SNDLHu+RFx3Mx5QflSZkCAciE/EupyYfCfjrD1MTQG8Rmtlop42al//
         e2UBQ3sece30qeiagPwTaoCqam1l28EOknH7hHxc640eYv0gZiq5muOV151H9FhETR2k
         sR6tlw0X+IzWsgSZEykllxfHZHD5UGO2Um0VZHIC9zvX4AR4UyHblRbT5jNLE006Ymuy
         ogAxWNrB5ilIFRj+XNfab5f6yTuJCUzJl6r/e9JfT3mRNgQnMYJd0kmgebJFaJ+skRGf
         J8DQ==
X-Gm-Message-State: APuU4Z9OOwb60EE5dnqFtvRalQNNBofDIEEwO48xX4NT+WKdYKteALYu
	6dwYRKn7Ad8E3nzG018Mp2fkPa+Ze/Yk6HTb0sgVVA+I/BStrrXG+/kVMsRu/wHz
X-Gm-Gg: AYBFou3jHdK2az18TnOo8Il52rrOaqWpKX8Dm8GTsUTvxdHCfxATIuNE2JQC2D6lSIM
	2VwObkSkfETxQkv2gM+dEUeuWr1KwMBSDo9O25TapCS9dbrZbl4V7D6HpBRHJ49p9bKLJE1BFuN
	NzQJ5HiZUEfzNo86Tzqj1XYBQlYKbEFtsBCLcdWETYFJ/38QmaEEaYlhz9I0dx3TR5aIxA7XBoV
	tzox926F/JHSDeM5k0oX/D3xRY2yhcpHTqijNed6jmWs1R2128z/HEdr7A4fdwslZkvcp4H+8PM
	Q660/IA8qBJENRyuE48R7b2gJkgfOSAOhx0TlQhkO3CVG1Hmk/BX7qunq1/88nTM+4BuRT6c1D3
	tt9KkUo1F2FDapqkmGII9NFu748lRW4dOEq4Qdj+h72ZWpl1IYr/HqPQvz6E3kcBcA/ZJ5qxvZe
	oVBQijRGTf7Vg8RJuJ+ErpDBBFtvqKSjT9eiwxsCnBX0rVwuWEchstEDQB3sf0WPxLiQ9RgxKI1
	1Ni0vx2qCSNiZt1HllUEt3x8FQTBCOJkF9jGkM65OzKZA0rZAN9EO+2bqT6vF4Kes5juQt68e0V
	XCPELYjr
X-Received: by 2002:a17:90b:4d01:b0:3a7:cffb:8b96 with SMTP id 98e67ed59e1d1-3ae8970ef3fmr9559326a91.18.1793679161371;
        Mon, 02 Nov 2026 20:12:41 -0800 (PST)
Received: from gmail.com ([2407:cdc0:f00f::117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6f010asm1941708a91.15.2026.11.02.20.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:12:41 -0800 (PST)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 4/5] vsock/virtio: coalesce native RX write-space notifications
Date: Tue,  3 Nov 2026 12:11:33 +0800
Message-Id: <20261103041134.33310-5-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103041134.33310-1-physicalmtea@gmail.com>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
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

Each received packet can update peer credit and call sk_write_space(). A
writer cannot consume that credit while the virtio RX worker retains the
socket lock, so repeated native write-space notifications in one RX batch
are unnecessary.

This patch coalesces write-space notifications on the native AF_VSOCK path;
data-ready remains per-packet here.

The batching patch establishes batch ownership before its first packet.
This lets this patch record a pending notification for that packet and
flush it even if the packet immediately ends the batch. Deliver it while
holding the socket lock to preserve the callback context of the existing
receive path. A following patch changes that timing together with
data-ready handling.

Capture the native write-space callback before socket publication and
access it through AF_VSOCK helpers. Sockmap can change the protocol,
write-space callback, and psock marker without the socket lock. Serialize
each batch eligibility check with sk_callback_lock; if a packet boundary
observes a replacement, finish the batch and use the regular per-packet
path.

Packets admitted on the native path use the saved native callback at batch
finish. Reloading a current sockmap callback would not synchronize its
invocation with teardown; a wrapper seen before teardown need not forward
the native wakeup after its psock is gone.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  4 +-
 include/net/af_vsock.h                  |  7 +++
 net/vmw_vsock/af_vsock.c                | 16 +++++
 net/vmw_vsock/virtio_transport_common.c | 78 +++++++++++++++++--------
 4 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 748633aa0cc81..bf28e8e32e280 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -287,12 +287,14 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
  * Initialize a batch to zero before use. A non-empty batch owns @sk's socket
  * lock and the reference returned by vsock_find_connected_socket_net(). The
  * caller retains both until it calls virtio_transport_rx_batch_finish(). An
- * empty batch owns neither.
+ * empty batch owns neither. A pending native write-space notification belongs
+ * to the lock holder and is delivered by virtio_transport_rx_batch_finish().
  */
 struct virtio_transport_rx_batch {
 	struct sock *sk;
 	unsigned int pkts;
 	size_t bytes;
+	bool write_space_pending;
 };
 
 static inline bool
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1ec6b..b76ab565ea58b 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -63,6 +63,11 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
+	/*
+	 * Captured before the socket is published. This identifies AF_VSOCK's
+	 * native write-space callback after a consumer has replaced it.
+	 */
+	void (*native_write_space)(struct sock *sk);
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
@@ -78,6 +83,8 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
 s64 vsock_stream_has_space(struct vsock_sock *vsk);
 struct sock *vsock_create_connected(struct sock *parent);
 void vsock_data_ready(struct sock *sk);
+bool vsock_write_space_is_native(const struct sock *sk);
+void vsock_call_native_write_space(struct sock *sk);
 
 /**** TRANSPORT ****/
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 44cee74519555..e39567990539f 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
 		sk->sk_type = type;
 
 	vsk = vsock_sk(sk);
+	vsk->native_write_space = sk->sk_write_space;
 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 
@@ -1122,6 +1123,21 @@ void vsock_data_ready(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(vsock_data_ready);
 
+bool vsock_write_space_is_native(const struct sock *sk)
+{
+	const struct vsock_sock *vsk = vsock_sk(sk);
+
+	return READ_ONCE(sk->sk_write_space) ==
+	       READ_ONCE(vsk->native_write_space);
+}
+EXPORT_SYMBOL_GPL(vsock_write_space_is_native);
+
+void vsock_call_native_write_space(struct sock *sk)
+{
+	vsock_sk(sk)->native_write_space(sk);
+}
+EXPORT_SYMBOL_GPL(vsock_call_native_write_space);
+
 /* Dummy callback required by sockmap.
  * See unconditional call of saved_close() in sock_map_close().
  */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f83e5b2edce35..af26344678e41 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1865,31 +1865,55 @@ virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
 	       !virtio_transport_rx_buf_full(vvs);
 }
 
-/* The caller holds sk's socket lock. */
+/* The caller holds sk's socket and callback locks. */
 static bool
-virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
-				      struct sock *sk, u32 len)
+__virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
+					struct sock *sk, u32 len)
 {
 	if (!virtio_transport_rx_batch_can_continue(t, sk, len))
 		return false;
 
 	/*
-	 * Sockmap can replace sk_prot and publish a psock without the socket lock.
-	 * Check both at each packet boundary; a boundary that sees a replacement
-	 * returns to the existing per-packet path.
+	 * Sockmap can replace sk_prot or sk_write_space, and publish a psock,
+	 * without the socket lock. Coalescing is safe only for the native
+	 * write-space callback, so a boundary that sees a replacement returns to
+	 * the existing per-packet path.
 	 */
 	return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       vsock_write_space_is_native(sk) &&
 	       !virtio_transport_sock_has_psock(sk);
 }
 
+/*
+ * Sockmap teardown restores the native protocol and write-space callback
+ * under sk_callback_lock. Serialize each packet admission check with those
+ * updates.
+ */
+static bool
+virtio_transport_rx_batch_can_receive(struct virtio_transport *t,
+				      struct sock *sk, u32 len)
+{
+	bool batchable;
+
+	read_lock_bh(&sk->sk_callback_lock);
+	batchable = __virtio_transport_rx_batch_can_receive(t, sk, len);
+	read_unlock_bh(&sk->sk_callback_lock);
+
+	return batchable;
+}
+
 /*
  * The caller holds sk's socket lock. If @batchable is non-NULL, update it
  * after processing @skb to say whether a native STREAM/RW batch can continue.
+ * When @batch is non-NULL, record a native write-space notification for batch
+ * finish. A writer cannot consume the updated credit until this lock is
+ * released.
  */
 static void
 virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 				 struct sk_buff *skb, struct sock *sk,
-				 struct net *net, bool *batchable)
+				 struct net *net, bool *batchable,
+				 struct virtio_transport_rx_batch *batch)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
@@ -1921,8 +1945,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
 		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
 
-	if (space_available)
-		sk->sk_write_space(sk);
+	if (space_available) {
+		if (batch)
+			batch->write_space_pending = true;
+		else
+			sk->sk_write_space(sk);
+	}
 
 	switch (sk->sk_state) {
 	case TCP_LISTEN:
@@ -1947,7 +1975,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	}
 
 	if (batchable)
-		*batchable = virtio_transport_rx_batch_can_receive(t, sk, 0);
+		*batchable = virtio_transport_rx_batch_can_continue(t, sk, 0);
 }
 
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
@@ -1991,7 +2019,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		goto free_pkt;
 
 	lock_sock(sk);
-	virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
+	virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
 
 	release_sock(sk);
 
@@ -2008,20 +2036,31 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 
 /*
  * Release an active RX batch. A non-empty batch holds the socket lock and the
- * reference returned by vsock_find_connected_socket_net(). An empty batch
- * holds neither.
+ * reference returned by vsock_find_connected_socket_net(). Deliver any
+ * deferred native write-space notification while holding the lock, preserving
+ * the callback context of the regular receive path. An empty batch holds
+ * neither.
  */
 void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 {
+	bool write_space_pending = batch->write_space_pending;
 	struct sock *sk = batch->sk;
 
 	batch->sk = NULL;
 	batch->pkts = 0;
 	batch->bytes = 0;
+	batch->write_space_pending = false;
 
 	if (!sk)
 		return;
 
+	/*
+	 * The packet was admitted with the native callback. Do not reload a current
+	 * callback here: sockmap can replace or remove its wrapper independently.
+	 */
+	if (write_space_pending)
+		vsock_call_native_write_space(sk);
+
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2080,7 +2119,8 @@ virtio_transport_rx_batch_process(struct virtio_transport *t,
 		return;
 	}
 
-	virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable);
+	virtio_transport_recv_pkt_locked(t, skb, batch->sk, net, &batchable,
+					 batch);
 	if (!batchable) {
 		virtio_transport_rx_batch_finish(batch);
 		return;
@@ -2158,16 +2198,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	}
 
 	lock_sock(sk);
-	/*
-	 * Serialize initial admission with sockmap's callback updates. Later
-	 * packet boundaries recheck native state and end a batch when they
-	 * observe a replacement.
-	 */
-	read_lock_bh(&sk->sk_callback_lock);
 	batchable = virtio_transport_rx_batch_can_receive(t, sk, len);
-	read_unlock_bh(&sk->sk_callback_lock);
 	if (!batchable) {
-		/* State or receive-buffer failures keep the regular lookup path. */
 		if (!virtio_transport_rx_batch_can_continue(t, sk, len)) {
 			release_sock(sk);
 			sock_put(sk);
@@ -2176,7 +2208,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 
 		virtio_transport_trace_recv_pkt(hdr, &src, &dst);
 		if (virtio_transport_recv_pkt_set_owner(skb, sk))
-			virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL);
+			virtio_transport_recv_pkt_locked(t, skb, sk, net, NULL, NULL);
 		else
 			kfree_skb(skb);
 
-- 
2.53.0
