Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07020233920
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787704806; cv=none; b=lr9x/exy3EVWBKpkTwKa31lT6CzNOclnTVVVcmXwI5FmN+BJq94olh0nKtQS/x2DUMbid/m+ChHhLkvMIQiPyg1iBxavpKtdWQx4kcH8MH8gRD7SlkylgaSUCKcLR9A5qqCEon6F2WB3ddYyMmpVKXLDGuZTqOoYb0iu0H2gSlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787704806; c=relaxed/simple;
	bh=QX/vn9JHBDF1P5ti7air7BXUMt6TE73hYnNrwXMaVVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXY1jQmn9VLTNsUIf6Zo8BX83J+cGJL9IK1iX4gnupGhfD4SfSvVUJJWu7q+Lp55/3E9+4ADB11mzYcT5UN9AwHFZw//P0zpPdo5cGPsctUdMyN2fQS/zMGf4uiCeoxVApmzGESOSqB0dzcj8Coqp6NfsN265z9d1NoJePHvWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+aHCJdU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+aHCJdU"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84eb992a881so386305b3a.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 17:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787704804; x=1788309604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/eP+e7q3408itBdeYjBe53xJJY4zYLdPkL6W0uiwF0=;
        b=i+aHCJdUmTYuaEgvVtcpVA3B9urc/aM0SkRp8X3nRjrcOuGRatHkVV0jEWOFFDThRi
         SHrQTq+ikJkAk4nVsRKOOUBVrgDFQXu3Q9buZsfx2QdpaLed894N5tBoLDUxU8ayvXIq
         WjFqDSdFwIj8pfH+L25wCjn/YGay8SvdtCj228YAfyTi//Nk35XiU9Uhl0xhwSMcVl52
         BFEL+GbyyGlm7sGSZhuthmMUcfcS/BtpjSDM/eZfsUs7hpVCwN5RdTGQJuN5smfF7NDA
         DOQUK87y09FF7axWI8XZbV0/0wmqrL6XenrcmafJQ+NqkU//gbJrww5ua8BW47eznIx9
         yPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787704804; x=1788309604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/eP+e7q3408itBdeYjBe53xJJY4zYLdPkL6W0uiwF0=;
        b=fNMi4CzI4xGuGn5ni9e5FUK4LUGimFEIniJrwn4EawKtAagQ/mJ3T/FMuyjMvZe0C9
         aO+I/P9ctyT6TmeQoSI+UA/hhTCK5SblXHGnoBjUyc1+YTCFrNCVm48m3Vpug0UARAj7
         2XdUPZfBMzlC7HsVStmVej4/Y0V/em5kbGVrphVvQaihDNNWqhlq/fVItK5IQbjqMDJ3
         KazL5oAw+8ZXjmIZ/dFQxKkWFyvzNC68I1Ix07zTIIi4Rx/DcwJFIX5LZuy0qki1V7en
         vGTiPy/92RF4gKmnmTnECgyzZp+5lnjmy8yeZGR/XeWg8JnHbVQ47iBBmc8nb+hc44XE
         Bv/A==
X-Gm-Message-State: AFuF++kLTq8PqTy1/mdSbEvAqXKKnE+6qlNbAohD+mFNXVMEfeue+NSk
	k3FDvCbn5yX1hXmN51O1PTCjomA4SuD0cLarsYs9YdKtpv2+LUqsyffmB3IUtTAP
X-Gm-Gg: AR+sD120QEvqzENTnW7vBnuRtX+BBjLdJB8FtPnnsLE7HmmZY0W7QISSA6zsQPHhs2g
	AOA9P9f+Rxu63G2rOruNslAMB8iG62ZNarzcTlxqAJjC1QbmaV/YVF60BpqGfS2eYu/RrNX2Kd5
	wASQ9LCAzsVjUGi3gYR3VU0mlPr2omNpKnYsmPebmQ9vV1IZzaECZaJVz8YdwIV2JJlgWeN5Nxz
	21730hq+QeLV0BDcjqonQRlkYG1SfSNMrJSwFbuMsMAK0oBssLlDLDYD+yiVQ6aoxPejCherIbX
	SEozOB49rRnwi3rKZBDCzaWQfB1AJmoTfoM8IKEUmiiMZQJV7yDxNF12rM2XSuLiBX6P407MQ8c
	ZLLwFyS5pBYz5ut0ZnrTmyeouJPfBa9sJC8eHalKsUAdPY9uUihfw5AOf2FtDt+2+UYXGTaqP3c
	equv5GQiOnj9fd9cg453aesccgJDG8gdZgGeFQ1OgkQoyco0fF1bzqw1e+Crug+7UNbBKhQbnE
X-Received: by 2002:a05:6a00:4f92:b0:848:2e3c:9955 with SMTP id d2e1a72fcca58-85371fa599amr4496713b3a.4.1787704804199;
        Tue, 25 Aug 2026 17:40:04 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cdc038dsm339377b3a.38.2026.08.25.17.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 17:40:03 -0700 (PDT)
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
Subject: [PATCH net v4 1/2] vsock/virtio: validate packet source for connected sockets
Date: Wed, 26 Aug 2026 09:39:27 +0900
Message-ID: <20260826003929.966160-2-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260826003929.966160-1-4ncienth@gmail.com>
References: <20260826003929.966160-1-4ncienth@gmail.com>
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
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
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

base-commit: dc4b95b8fee95113587e93ca116356032d271371
