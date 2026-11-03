Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679148;
	b=rtxQNcaMfZ4HzTSIX7f/DycQ8ewcq3zG2H1+kx7cRxXRR67+BaLyY3gzesQ61BCP8EfC
	 UrM/x6OUPREVfBlgDyAwRCf9und6a0+f78l00ze7TuV2TQG8kNuYiSvLDFBymlNp2ojtC
	 WaNrkouJWqKQs/Z95e/r+n8xjy1sWOmtlMN0DbtMae/gWXzdQjKnZ98k7A0RZuq3f9u8D
	 r9hvgJs5GiVUggiqgYrokLWKGUtH8LU23SiKCRD77WA1Qs3ZnHkOjJU9tAo9bAtJ3gmZT
	 HGX36NTTdnIWvRUWEClV0MnZAqxGp2/zVniO4vmswXpPWEMzg5SF/+CqkXQSSpVSC6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
	b=w5DgnAQd2sytKhtde8k6N/89Jq2v16iP8b+5XWRh/qDUcV5phJWd3kLqCyBocEQoEF4i
	 DR2+juLAOlZKM5Z7prp03vIkjhyiZguVBCrhch5hh0RhOjGyQCbtvMA0AOmnIVHixGtbZ
	 yxDRYx5Bxajz5NJ8B6bvppwrUt+6XmSS9fG+m0tzNKjUM9dw9Nze+ZlZVLoXqQegDRxue
	 ccCIuzxXfNmiBdnFaaHQQjx76W6QV7pPDylEbbm2kQELYqqX40TsR/zsw47phnrW5Kqmg
	 9RDidih0XT5phsYXpYo3Ml3vl2v7eCMFn7Zz8qyYQ+IIOZyApS25W2bqZ8Qu9H4NUyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNEHX1JC;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F76606A32F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 04:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F76606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNEHX1JC
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1915634a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 20:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793679147; x=1794283947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
        b=gNEHX1JCiFF60qj4wmZeZFrogcP2KBfERRy81C+qP7fhO00AyS/P3H87XfjjaAnY3a
         NsHu7zMQ7UxrnyGJ/SAn/JfPZ2O4G3ftckyAeyEJX9odi/VCKHtX53Sor/JakK8TiK3w
         3A/fFmiWRjXW8cfZmPXsQ6aNrOC3/cg+begWzi8N2mwf7iatkoGXdJ113hYCltF/0H2U
         DZ4WaNQWGo09VwLw/5uKAthmDr0U6JOhkws2rf5/p9+XaWJOyw40fA2THL3qrt0vprJu
         OovvJ54WlZR3PWLhztGREEys9gC7z2MzzX0DQClX764qO5a0dt47JuAAEoatLE9QPrlG
         yLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793679147; x=1794283947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
        b=JUhmnd2uML0yaOVOdAQWhsips6iAN2wVD56JKs1LRJKIw4VR42eJQHHA3Zrn5wLMWd
         HHFEKt5gtZ9GjwupDCPxJ30uaLvSJcoU3nbHbsAUmNA3DbTYSqL8lSd+GlqloVR7FBlH
         S1gAWSekZF1zBHtVgXsaDQTojAaTII/l7f2rritqQW6lmCuIirYOv50bSGnp0puTDsgU
         9lght0nqPbYxtX5X+VUJpZU3AGtj9tdVvCmD8B4i0NdF/HtBH8oL7qZjDqtWFpYMJQCf
         XCN5M562atJW41dT7/wd00YVGusxo4rag3xw8Bc+h5TvoEDl5MBoFK0+/BVoJVSDy7Cj
         u/mQ==
X-Gm-Message-State: APuU4Z+bXgLqLHdIIQzOgJ0WiOEnbNGDKaj5MIfCLZxJRo/wAIGbMJx0
	YMQNu4e+vJoqwU/tEyt2fQEuintVhwUNFKBdr4DkKBwC9W2cfWHciTaMvwWVLvjC
X-Gm-Gg: AYBFou2RE4X5DdgWODLBVBhgUa83lSgeDhPLhdyjZMExMPXtKMf4QlTMzmmtQVelxlG
	cP/ismAQfr7HJxn9tZGe97flxMXrAzIW9/o5CKCZlvxbh6tOfOVrbgZjPEzanfKSu5TaBR7u33r
	QRZJ388qnJqQqzxD1QOWgP7LAuGfgWMuS9uytwHl4p4Bd9eLgCiBsLFxnjekE1saJRYw8I4XRdp
	U82ErDCOkj4TWfEC7DWzhL0T8bp7jJ//BZ40wSQt310AA5qxzJTqugWSFXawgr8L4FaC8tVGxg3
	GdXrpPR1pZhcAHszTzfjNNLz9V/NKddo3jhqRdYQsxwTlGOgM5wrNEMGMjIdJC1q8iNdQ2l5KoB
	q4llWtPhdRy0Z+lt3H1DEnujOTCKng4vQ4qBoGj23wqI6jEYL5vINBEaCiXovrgoaZ8vIwJEEhk
	5CxyW5nJrT/ytxTDAMfpPKcDDhW4IQhB6R2bmyFbOwWMH1VrZda5HjiPHF+PVL4pw8+r3LMNfQu
	FZ7eLf5PjXgJx30DVIo09w7oAg0r0pMjcBk1MTVP0Tdik8WIvvGHqrRASRn/1l2Nn5cIOy65jvJ
	HMLtGb8=
X-Received: by 2002:a17:90b:2888:b0:3aa:fc22:8aa7 with SMTP id 98e67ed59e1d1-3ae89853f54mr10262747a91.53.1793679146575;
        Mon, 02 Nov 2026 20:12:26 -0800 (PST)
Received: from gmail.com ([2407:cdc0:f00f::117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6f010asm1941708a91.15.2026.11.02.20.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:12:26 -0800 (PST)
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
Subject: [PATCH net-next v5 1/5] vsock/virtio: split socket lookup from locked RX processing
Date: Tue,  3 Nov 2026 12:11:30 +0800
Message-Id: <20261103041134.33310-2-physicalmtea@gmail.com>
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

Split virtio_transport_recv_pkt() so socket lookup is separate from
processing that occurs while holding the socket lock. This prepares the
receive path to retain a looked-up socket across multiple packets in a
later change.

Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
Pass the caller-provided network namespace to the locked helper so reset
handling retains its existing semantics. Preserve source validation and
failure handling.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 131 ++++++++++++++----------
 1 file changed, 78 insertions(+), 53 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..43325d7aebbb1 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1774,6 +1774,80 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
+static struct sock *
+virtio_transport_find_socket(struct sockaddr_vm *src,
+			     struct sockaddr_vm *dst, struct net *net)
+{
+	struct sock *sk;
+
+	sk = vsock_find_connected_socket_net(src, dst, net);
+	if (!sk)
+		sk = vsock_find_bound_socket_net(dst, net);
+
+	return sk;
+}
+
+/*
+ * The caller holds sk's socket lock.
+ */
+static void
+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
+				 struct sk_buff *skb, struct sock *sk,
+				 struct net *net)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct vsock_sock *vsk = vsock_sk(sk);
+	struct sockaddr_vm src;
+	bool space_available;
+
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
+
+	/*
+	 * The socket may have been closed or reassigned after lookup but before
+	 * its socket lock was acquired. Listener sockets have no assigned
+	 * transport.
+	 */
+	if (sock_flag(sk, SOCK_DONE) ||
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		kfree_skb(skb);
+		return;
+	}
+
+	space_available = virtio_transport_space_update(sk, skb);
+
+	/* Update CID in case it has changed after a transport reset event */
+	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
+		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
+
+	if (space_available)
+		sk->sk_write_space(sk);
+
+	switch (sk->sk_state) {
+	case TCP_LISTEN:
+		virtio_transport_recv_listen(sk, skb, t);
+		kfree_skb(skb);
+		break;
+	case TCP_SYN_SENT:
+		virtio_transport_recv_connecting(sk, skb);
+		kfree_skb(skb);
+		break;
+	case TCP_ESTABLISHED:
+		virtio_transport_recv_connected(sk, skb);
+		break;
+	case TCP_CLOSING:
+		virtio_transport_recv_disconnecting(sk, skb);
+		kfree_skb(skb);
+		break;
+	default:
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		kfree_skb(skb);
+		break;
+	}
+}
+
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
  * lock.
  */
@@ -1782,9 +1856,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct sockaddr_vm src, dst;
-	struct vsock_sock *vsk;
 	struct sock *sk;
-	bool space_available;
 
 	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
@@ -1808,13 +1880,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket_net(&src, &dst, net);
+	sk = virtio_transport_find_socket(&src, &dst, net);
 	if (!sk) {
-		sk = vsock_find_bound_socket_net(&dst, net);
-		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb, net);
-			goto free_pkt;
-		}
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		goto free_pkt;
 	}
 
 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
@@ -1828,52 +1897,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		goto free_pkt;
 	}
 
-	vsk = vsock_sk(sk);
-
 	lock_sock(sk);
-
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
-	 */
-	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN &&
-	     !vsock_check_source(vsk, &t->transport, &src))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		release_sock(sk);
-		sock_put(sk);
-		goto free_pkt;
-	}
-
-	space_available = virtio_transport_space_update(sk, skb);
-
-	/* Update CID in case it has changed after a transport reset event */
-	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
-		vsk->local_addr.svm_cid = dst.svm_cid;
-
-	if (space_available)
-		sk->sk_write_space(sk);
-
-	switch (sk->sk_state) {
-	case TCP_LISTEN:
-		virtio_transport_recv_listen(sk, skb, t);
-		kfree_skb(skb);
-		break;
-	case TCP_SYN_SENT:
-		virtio_transport_recv_connecting(sk, skb);
-		kfree_skb(skb);
-		break;
-	case TCP_ESTABLISHED:
-		virtio_transport_recv_connected(sk, skb);
-		break;
-	case TCP_CLOSING:
-		virtio_transport_recv_disconnecting(sk, skb);
-		kfree_skb(skb);
-		break;
-	default:
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		kfree_skb(skb);
-		break;
-	}
+	virtio_transport_recv_pkt_locked(t, skb, sk, net);
 
 	release_sock(sk);
 
-- 
2.53.0

