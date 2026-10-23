Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741914;
	b=ifwEPFenQ6d+3Rc316IRWrl+S9szwvVc25lpYmu0rREL+XTQVD57/h07Mwd7031963PB
	 9iWCstd9GTXDIqOg6cQAFTXqQqRQV/EUykhXRB/AoABAkBdynYrbZ3DULxMLgxq/xLSBq
	 eEkc7Zv8BFUFfP4VFJOZqFVJbk89ej++mbbz6vUskiOdIi1js5H2Lv3FmPmy5tlH/8OfU
	 2rQ4j7Iy80w8tgbtg3gr3OtV5ok9RKv7NKOkanSx91Oy0yNaNDZaMguIwYa5ncoYqvLrk
	 HK85hCykhfPNITK27N3z5Pab0N3IoPdsM+y7c8V0b9ZQ64JihFzZz1QgQMO6x4mvyEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
	b=X6/2yWtEs18n1hD1uFJWqf2TTkbik6kQDdUfAAoAKKvcpKKWNUx8ZK2+vO3V7hqZF7qA
	 ESC5N5zi3sAduMqMA2wN0a4AK1NlK/SdKD1yP6CP7vCPMDuB9TUDybIomL3XH8o/LciYu
	 RNvvSoW79Zv9ojCFQcoNeZ6fYbXjVHLx/C07lhaLKIcLtEQyBAaGMd0HilSeMEUPn0Vew
	 M4ZLlymaMmfoAnzIZ8v1Zb6Gi+dbjEtsFM7c29ip7E/goU7VD6JnYA8s2NefHVDPK34Tk
	 W3Z/gvzHXC31zKj85fNtlcMnFs4HZB3x1QvLVjCVO0iFNsFVmbcksG65B9mZnJGc8NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oSZWyNkd;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E5606A322
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 409E5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oSZWyNkd
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e946155442so4391125ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741913; x=1793346713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
        b=oSZWyNkd9tx0LydPfzyYjS/fMAlcBOgtM9UhRvjsW5u8xmv+y1Q3UTVfPiDl0VTyZa
         5cNKc1wDTG/jKS7SCyqAOGKo46llz8o7GuD7gifpoDafi33HLN7cq+nftOOWCUzfyH0F
         xl330z//hkf0zISYEJM2HnQ+Oh4oNkktA7qG32l6j+1VRDZJuRjipbJx8MGw5qHk5C8I
         zTA8/ulsz5ERDvSvMTKTPdhEJQLKC5y6wIj/5r7Ix1qfZrg4gkCMEupTJzU/hA6/3EWX
         SA9KnGIrNfizL8hqk/pOoiPpnQ7haxwUzmCAPcws8XDAU42KxNMosaLfk6erY4MgwkSb
         BdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741913; x=1793346713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=muNE5kIzhzmSy9zy/DQorm6Ec+5hmWxUkOFZe0Ib8VE=;
        b=TnlfGutHjMEQedyNtLdeEZwnLHCwUfLLrP3saK4WBBh+NPORNEAakih5OZv35Nzsmz
         I16Ci02DaboOR8knDzNY4N4BGnMehA82LSlPyJitzJSTX+iLJ5YWyUz3eM3XBA0SfotT
         dHIxK7V0csi8Q1Af9rPbHUwoHXDROUBuqDuqJor8qbvR4Q4Y85eO65JRcC4YqKXQv1eG
         3HJQ6WvrIvkv9eqEc5Np0rcjnwa48kWir0yDHxJF8AmESUMXzSEFwpXo/nrKr5KJlC7s
         eQs2ky9gZNX5PtUXO14cmPR4Er8q3t5DPFwI1SUmDq7wcXajKuwSawoVpNE8tqTF7HSy
         XEgw==
X-Gm-Message-State: AFq9FYJ8XlcW+1sSXrb/d10r6dww47CKhPKhcQtJXAjaV69ObP9wr54J
	jkI5YWhb8/ik51YUeIxgNUQzngkLXSLtnS1+73GZYxAezIvleC9z6uC1jW7+OJhgDTc=
X-Gm-Gg: AYBFou0055bP3QurAtLl0IJuevOFvhUSP++s+k3NzoQMKHh/lYGeSMGWbmVmJvO5y/n
	PrFv05D48U2dJMdcReVfXOyMgb+/e1D4XSVhiDohsfiDHyt9vNfeaxixm0bHvtQhtrvJbd/bAC7
	WUJGqJXk3jJA8SpSTAB38VjMcIuUJOP9IiyPQ9VM9UErs60tH/AoxTkcfGE/S62VZQCsHST72Ia
	W1IFqY70ikDBdkWAczj/0ItSLhXnKsQkRVqdnvTv8lIzQPrbL8PTZSLMMajRITiNXuXINba4yKN
	rS1N8UsHtnK1e6olRzHr2KJn4Rz36O/EN2MpEA28nu1QIxwa+s5kv6v6ur9zUXYpJnrcSM86PSE
	Pt2TNGbxSnrIeKNakOo5TIYdJ3Ql3dpbylLTVutQSjzMaNke//Xo3ww8b4l9gIQVJl3/zjefirV
	GBgeuKodjhtuDJ3+87/TIJr1sMQOfWjFw25/1tc3MO/TsMc7XDsljbg7ZDlOoHq2eEl+H+boFU5
	ZVK5oQGXEFbSWs3mKnNEGhxISvitH2JLJJ2vuWAPplAIGj/Im3H+FeZDw==
X-Received: by 2002:a17:903:2f44:b0:2df:aed3:2ac0 with SMTP id d9443c01a7336-2ea7d09c285mr14383685ad.10.1792741913096;
        Fri, 23 Oct 2026 00:51:53 -0700 (PDT)
Received: from gmail.com ([185.220.236.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b368c90sm7208265ad.29.2026.10.23.00.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:51:52 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@meta.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 1/5] vsock/virtio: split socket lookup from locked RX processing
Date: Fri, 23 Oct 2026 15:51:36 +0800
Message-Id: <20261023075140.9613-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023075140.9613-1-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
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

