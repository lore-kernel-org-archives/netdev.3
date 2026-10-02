Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD44432F8
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927196; cv=none; b=dtRTsZttKqiD63sCZUCGBDvcASbTZJcpbqo89PrYL+kLnpahKJmeXIyL+mtiYchs4Xf4wn4mcymuxXomV7Ebwg7XlIvL4C+zfkTffGZRiVONOz+qZdglhXo5Glfz8EGyzPdkIsANEvSCbTgnStIcPAesj7qO8gm17XoSmuQQuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927196; c=relaxed/simple;
	bh=FBRQii2NI78yMqUBxIsy2G3T/ohQ+oFPHl3SWWRfwV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edXn23aeW8kRKnV2vks+XeZxuayFcDVTyl5CvTPfwoRc8zjHji2qkCHJdO8Q+9/T8K/NcUd8QZXCVtaHO7mBlXgxx2SoT1PfPbvoI7I6fbO9q5J2VZGGgDp8BqkGQv6X8k/M+KH9muUpJ5jYNBPaL/CJTHf7Bib6A/eEDxv2tjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbRmfB2S; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbRmfB2S"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so9347911eec.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 00:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790927192; x=1791531992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/4b3V1d0NnoqdO8NQN0A2YcUSAKEdgt9dIV6PIOtskE=;
        b=CbRmfB2SO0JlT+vWYd/BvlVgho3WhBkjbfGuR7yvprWgPlEEoU9Bmqf5tr68vAL/FS
         lItuy3rqPMvZNyBMxaOG2MDxjCjZAicGAiQ2aVRDa+7BWjvX3RZtshuTDbn5DJdHvvEy
         xHeGowDZWbi5Eg5fX3FQkbCLL7Qge9X+KKQoGaJq69IWGrcTIvlpjznvmI9BT+usJJV7
         ECQQj6cBGWAjP5KDqXELwhg2MaTDkU4ZP53qoDV501F4UCyYtcPlRlWYUqiMoRwlMRSb
         3Vo0Gb4PDP/LmwffqRuSuYEAJ47l2OYh230pNag5SZjeugegPqT9Ov0mQjw+TaasUJKL
         1/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927192; x=1791531992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4b3V1d0NnoqdO8NQN0A2YcUSAKEdgt9dIV6PIOtskE=;
        b=A5OKlp4CfU3m7FgX1wcjePgMPSIs288ivDFTJGfesEKZX1k4TjD2dXVi1k1eQZfRxr
         q/m4wTyTnhXQgwCg6RoxLYvK9eoSURjKt+QeSPRDToWw/C8MF5Jj8lxFtG1oXVgA/bUq
         TjneD2OU7eyXW3zG3glxqr+ge/0Dr6lZ5+t+o2brc5pW+8gQqe4w97czVfDabQ86Act+
         +RM/tsn1MpdIrG0lB1LH2kywarKCmfnV6eJRdihinoH8fhx3SB54ei9V9ETLSv8/2pTF
         pTTuDipTr5ypq5tz1/XLdVS9ATxjFQOqsA7xmNg68dP+IEnWsyCk3vxnQL1neMxfiF7Q
         nmDA==
X-Forwarded-Encrypted: i=1; AKwUvBxViV5StagVIIlm14G6dQFeAv+NA97aZ81+B0RpJgghiBUCM5pM5wtyy5Ph4vmhRtAsx/ODrJ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4xjeYK1ZKHdPva4ffBQpCBkwCl8K7UQ7nVURW0fHit2f/0E4x
	lYHDhSnODo4RuKbhUCchgT94YjY8w7EVACM7ets4uVIZ9xs4gmS6yPOD
X-Gm-Gg: AYBFou03sDg57plZhe5lwtbwCLv4195/yKrz9xwrrJCgUwwFpZiQXrxRKspiLIpogH0
	y5Z7OJOrWXEvn7MJvs5edl1SJaA82iSNixForTaD7EvpJs3NClJSPeQ28pO6D3177olu+X5+oZq
	kryLuJGzoS59ADfaRunbRCl2rZVlnYToeFD949oUCGTtxBs1ka6LGYWDpctmOVL6W5DJWSGHn14
	nW8UxpQ1RqUhkQik19asGp0oLV6qiSZYGhFeGQLlJC+ysvx7ZOqDQ69d+olPv0I5KfJt5r9wmDB
	wJ5AoQ+CiIvegLWLYY7RRgtKDjxbvaOeLAiI3goz4XS58dPGryC+5E53NyPSTocx4ysDHZrN8Q9
	BKaK02S0E/MKyfFSwstt1cNDihl1Ctm49dDo5Grosz9THj5RxL5klOMkHzRlu5uCIzqYk0vEjm2
	tEAfWAhpuIh3GzqYL4y9U1bzprodgNv3j1Hv7jBtEx6YklN1AyHI3GysGrUg2vHaMGaGqfVA==
X-Received: by 2002:a05:693c:83c3:20b0:33b:f5b7:f494 with SMTP id 5a478bee46e88-34f1509e567mr2318820eec.13.1790927191793;
        Fri, 02 Oct 2026 00:46:31 -0700 (PDT)
Received: from dbg-srv ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm5871618eec.4.2026.10.02.00.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:46:31 -0700 (PDT)
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
Subject: [PATCH 1/5] vsock: split socket lookup from locked RX processing
Date: Fri,  2 Oct 2026 07:45:47 +0000
Message-ID: <20261002074551.318789-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

Split virtio_transport_recv_pkt() so socket lookup is separate from the
receive state machine that runs under the socket lock.

Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
Pass the source and destination addresses used for lookup to the locked
receive path so they are decoded only once.

Pass the network namespace and decoded address tuple to the locked receive
path through a packet context so later extensions remain cleanly
encapsulated.

Preserve source validation and failure handling. Keep the lookup reference
separate from the skb owner reference so a later patch can retain it while
processing a bounded run of packets under one socket lock.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 140 ++++++++++++++++--------
 1 file changed, 95 insertions(+), 45 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed..acddb268f 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1774,81 +1774,94 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
-/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
- * lock.
- */
-void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct sk_buff *skb, struct net *net)
+static void
+virtio_transport_recv_pkt_init_addrs(struct sk_buff *skb,
+				     struct sockaddr_vm *src,
+				     struct sockaddr_vm *dst)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
-	struct sockaddr_vm src, dst;
-	struct vsock_sock *vsk;
-	struct sock *sk;
-	bool space_available;
 
-	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+	vsock_addr_init(src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
-	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
+	vsock_addr_init(dst, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
+}
+
+static void
+virtio_transport_trace_recv_pkt(struct sk_buff *skb,
+				const struct sockaddr_vm *src,
+				const struct sockaddr_vm *dst)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 
-	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
-					dst.svm_cid, dst.svm_port,
+	trace_virtio_transport_recv_pkt(src->svm_cid, src->svm_port,
+					dst->svm_cid, dst->svm_port,
 					le32_to_cpu(hdr->len),
 					le16_to_cpu(hdr->type),
 					le16_to_cpu(hdr->op),
 					le32_to_cpu(hdr->flags),
 					le32_to_cpu(hdr->buf_alloc),
 					le32_to_cpu(hdr->fwd_cnt));
+}
 
-	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		goto free_pkt;
-	}
+static struct sock *
+virtio_transport_recv_pkt_find_socket(struct sk_buff *skb,
+				      struct sockaddr_vm *src,
+				      struct sockaddr_vm *dst,
+				      struct net *net)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct sock *sk;
 
-	/* The socket must be in connected or bound table
-	 * otherwise send reset back
-	 */
-	sk = vsock_find_connected_socket_net(&src, &dst, net);
-	if (!sk) {
-		sk = vsock_find_bound_socket_net(&dst, net);
-		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb, net);
-			goto free_pkt;
-		}
-	}
+	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
+		return NULL;
+
+	sk = vsock_find_connected_socket_net(src, dst, net);
+	if (!sk)
+		sk = vsock_find_bound_socket_net(dst, net);
+	if (!sk)
+		return NULL;
 
 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
 		sock_put(sk);
-		goto free_pkt;
+		return NULL;
 	}
 
-	if (!skb_set_owner_sk_safe(skb, sk)) {
-		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
-		goto free_pkt;
-	}
+	return sk;
+}
 
-	vsk = vsock_sk(sk);
+struct virtio_transport_rx_pkt_ctx {
+	struct net *net;
+	const struct sockaddr_vm *src;
+	const struct sockaddr_vm *dst;
+};
 
-	lock_sock(sk);
+/*
+ * The caller holds sk's socket lock and must free skb if this returns true.
+ */
+static bool
+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
+				 struct sk_buff *skb, struct sock *sk,
+				 const struct virtio_transport_rx_pkt_ctx *ctx)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	bool space_available;
 
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
+	/* Check after acquiring the socket lock. Listener sockets accept packets
+	 * from any source and are not assigned to a transport.
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
 	    (sk->sk_state != TCP_LISTEN &&
-	     !vsock_check_source(vsk, &t->transport, &src))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		release_sock(sk);
-		sock_put(sk);
-		goto free_pkt;
+	     !vsock_check_source(vsk, &t->transport, ctx->src))) {
+		(void)virtio_transport_reset_no_sock(t, skb, ctx->net);
+		return true;
 	}
 
 	space_available = virtio_transport_space_update(sk, skb);
 
 	/* Update CID in case it has changed after a transport reset event */
 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
-		vsk->local_addr.svm_cid = dst.svm_cid;
+		vsk->local_addr.svm_cid = ctx->dst->svm_cid;
 
 	if (space_available)
 		sk->sk_write_space(sk);
@@ -1870,17 +1883,54 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	default:
-		(void)virtio_transport_reset_no_sock(t, skb, net);
+		(void)virtio_transport_reset_no_sock(t, skb, ctx->net);
 		kfree_skb(skb);
 		break;
 	}
 
+	return false;
+}
+
+/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
+ * lock.
+ */
+void virtio_transport_recv_pkt(struct virtio_transport *t,
+			       struct sk_buff *skb, struct net *net)
+{
+	struct sockaddr_vm src, dst;
+	struct sock *sk;
+	struct virtio_transport_rx_pkt_ctx ctx;
+	bool free_pkt;
+
+	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
+	virtio_transport_trace_recv_pkt(skb, &src, &dst);
+
+	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
+	if (!sk) {
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		goto free_pkt;
+	}
+
+	if (!skb_set_owner_sk_safe(skb, sk)) {
+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+		goto free_pkt;
+	}
+
+	lock_sock(sk);
+	ctx = (struct virtio_transport_rx_pkt_ctx) {
+		.net = net,
+		.src = &src,
+		.dst = &dst,
+	};
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
 	 * bound or connected list.
 	 */
 	sock_put(sk);
+	if (free_pkt)
+		kfree_skb(skb);
 	return;
 
 free_pkt:
-- 
2.53.0
