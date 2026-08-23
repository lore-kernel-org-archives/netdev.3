Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE3381B15
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507991; cv=none; b=Trwa4jhOilKdfWZO2apk6/D6JLNVnZiF/MIJ90bgenCyU9w420BsZp1T9iMyA/692vYOLXIxVnuW6FZdAtm6uy8Z6R+Arqnmj3/oawGV0omy4hWPcl48nIq+pTrm34lcMX3tuOHv+QoekmU1MjHfZLNE1+2IkotyI3UW3vrPweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507991; c=relaxed/simple;
	bh=FAhg6Y+Gf2hFXGS3OvtnnmqFkb5b9j/RA3QH1+XyYfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2beaiKSGvHzpZra74UuhFLHpgyOQpI28zmGptWDLPiLrmB4MLdcV9109VtLiHImYAuoCt7l+4HghdtkntKrfcnRqJhxn4klDTJ7v+FxWjfBpht4WEZ5ByI2IlgOgnOVmy96TSW44GqFlVeMlOZ4fK3liPYk7LCuntmpZsfPAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od6O3a6O; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od6O3a6O"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1930269a91.0
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787507982; x=1788112782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aM0XuwG9Af69RwHZUicdMbCmsYfcoS0svbHZa6lYfL0=;
        b=Od6O3a6O35YsujqMNT33cRxr7+i/Mc3cq4GKPkMBddo0a6vTa1fy8PMZFCHIV68wg3
         8O2Kwf/9QH+mmM4OKjNlmYtKVzU4hvLY8ZEaUa2znWiiXXHQX77xJq4Ste/18ysb63/3
         AHli4mlccj4pKi6abzUVNbzbPtd5nmCRctzshpzFLssHmouh1HUK8y7F1e6/HBRmNSjT
         DESwtLdRvIFnPK0WzaH8Pdcj1ILJkWrEbiFZmj0gs63+sciCEoWlkNLkD+R6fwy+cQ51
         t/JhB5fxPHH+zcvUGhl1QafV+HV/jEQXIOWfGebEwrTuA7kihiXS5YEkCmRuJVmZb/bz
         etug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507982; x=1788112782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aM0XuwG9Af69RwHZUicdMbCmsYfcoS0svbHZa6lYfL0=;
        b=puhiYVAAZIi1xP6Gu0OmSDwRbxhZb7SKMBYyigiklogYrR2u1R8nGgGJhXdgAVzVux
         CCgBjxS18hgvvZ2BO2nLDB1T0FSxkYRvA0ZPx4WQGw7FVUxLpaSM5obXLaK9IclRIqWL
         FH8/XVtt4QzK8eGwmRZ3YAbcelAFnT49ZvTnMKvS7uuoEmh2cqhPSw/tKqgFHrPaZpxB
         418zWBQKIpsX83gNDQuCt7ktdcNbP/uw7RLlgSNrCSwfe3NHRAiSfHbV++SN1mzlMtnp
         HvTsm8dDmu2pCU6Cx6RKDHK6455HQPjrr1X1rJcXGBoHpIBssM/mfgFr0qU+Vqxycvnf
         CcgQ==
X-Gm-Message-State: AFuF++mIWreuo+pg6Gy4Q7GvY3nbh9Vy0cTjfQ7Uhof72SSpfBp77DSO
	Cy+8RtLwOodmRtLIr03GyxS0lGhXUDWD2fLc18usz2n13wKZ1MHeFfpkeLSYQ9IQ
X-Gm-Gg: AR+sD11iP7SInFYXrEBBk8JYZvvyRFMUkbpUOVvshEN40MVsFq/yx90Bh8oRicohjwc
	ZhegbAf1RZgxz+rq5Zsknyy2stk1HwTnc5f6LTbxOiLt/42TgV5zSv/0AewnkGv6gWJZoibT6PI
	HEB8rlT3mSRClBWlpqEoypjSmPfL4CkIsG9OZ8xUUTNyEzd7PYwZ/MbwhAaQcoXnfz7D7VSJsFf
	5B5546Wn8AL1GI5wiJ+PgzIBt6Y0+d7LT32C9jkg5jKtu5rUo18JWK1/AWNCaWwAhZu5XsQD5Pe
	qeQn+JkYuaXmcmulfi2rKAGe3RLy9/16KR8jgsG+NVLygh/Fm1xWGLKBx9ZC7MVsAhmV2Fy68pd
	yUXt5r10B1pkYoCQOkE+kRkB0KZFTc0zUPZTocXCJfSJokB+Ri6gQEynBe4Niwr06QnO/e98xRr
	G/NGii00DqTIhZD2Wt5r2ilaqMChXkj9DJoKKAlEA9BVETpB22x3ASn6uJdL3DAe+PI8WNdWjr
X-Received: by 2002:a17:90b:1dd2:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-395c4c98f17mr20491383a91.4.1787507982541;
        Sun, 23 Aug 2026 10:59:42 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm3722818a91.1.2026.08.23.10.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:59:42 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	stefanha@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] vsock/virtio: validate packet source for connected sockets
Date: Mon, 24 Aug 2026 02:58:57 +0900
Message-ID: <20260823175858.351431-2-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823175858.351431-1-4ncienth@gmail.com>
References: <20260823175858.351431-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_transport_recv_pkt() looks up sockets first by the full source and
destination tuple, then by destination only in the bound table. The
fallback is needed for listening and connecting sockets, but sockets remain
in the bound table after connect(), so it can also return a non-listening
socket.

The fallback does not validate the source address. In TCP_SYN_SENT, a
RESPONSE from an unrelated source can transition the victim socket to
TCP_ESTABLISHED while its stored remote address remains unchanged.
Subsequent RW packets from that source are delivered through the same
destination-only fallback.

This was reproduced with capability-empty processes under different UIDs.
The attacker discovered the target tuple through unprivileged AF_VSOCK
sock_diag and caused the victim socket to read 16 attacker-chosen bytes;
the intended peer-side socket read 0 of those 16 bytes.

Add vsock_check_source() to validate the transport, source port and source
CID against the peer stored in a non-listening socket. The local transport
is the CID exception because its packets are generated internally with
VMADDR_CID_LOCAL as their source, including connections using CID aliases.

Use the helper after lock_sock() in the virtio receive path.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Closes: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  3 ++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 3357ee62d..5549298c1 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -229,6 +229,9 @@ struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
 struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
 					     struct sockaddr_vm *dst,
 					     struct net *net);
+bool vsock_check_source(const struct vsock_sock *vsk,
+			const struct vsock_transport *transport,
+			const struct sockaddr_vm *src);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a33b2a2d3..f840498b5 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -438,6 +438,38 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 }
 EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
+/**
+ * vsock_check_source - validate a packet source against a socket peer
+ * @vsk: socket receiving the packet
+ * @transport: transport receiving the packet
+ * @src: source address from the packet
+ *
+ * Return: true if the packet arrived on the socket's assigned transport and
+ * its source matches the stored peer. Loopback packets are generated
+ * internally and always use the local CID as their source, including
+ * connections using a valid CID alias.
+ *
+ * The caller must hold the socket lock and must not call this for listening
+ * sockets, which accept packets from any source and have no assigned
+ * transport.
+ */
+bool vsock_check_source(const struct vsock_sock *vsk,
+			const struct vsock_transport *transport,
+			const struct sockaddr_vm *src)
+{
+	if (vsk->transport != transport)
+		return false;
+
+	if (src->svm_port != vsk->remote_addr.svm_port)
+		return false;
+
+	if (src->svm_cid == vsk->remote_addr.svm_cid)
+		return true;
+
+	return transport->get_local_cid() == VMADDR_CID_LOCAL;
+}
+EXPORT_SYMBOL_GPL(vsock_check_source);
+
 void vsock_remove_sock(struct vsock_sock *vsk)
 {
 	/* Transport reassignment must not remove the binding. */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e4ebaa70f..6301c108a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1823,7 +1823,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 * lock_sock (note: listener sockets are not assigned to any transport)
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
 		release_sock(sk);
 		sock_put(sk);
-- 
2.54.0

