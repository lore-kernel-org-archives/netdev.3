Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854544B7144
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873128; cv=none; b=Rk2pI3scafalKHsqTQTfFOgqFunA0r0Qh9EtP7aTa5J3RgGgR0cLi7gzZier4OJInm+Iqg2j3RrIvtg2878SgrA96tBbm6mp3ar4eeTSzylWTal/U0kjmC6n2opeXxpo0NsWqN3K1vKKPnVmq6WR72Plr+fLwMYyP10Jcu7hqCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873128; c=relaxed/simple;
	bh=L/dNElf7d0/8j9/vCtolWRLlDfu3My0EYUi4Jj3CkKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDbCLQZG197aaXKCp2jok6iDUEEt3RIRyEP4h7jvzTb/PQOYQrvpPsNJegk/vt7VTOXc52Jiuc4CToEiywOjxP8YmmGvj5lNwdwEVCJrDiB0w9HZsveACUfJDUVkTNqELXvRTGoD7SXZCA2l1FDpcHYbRpJfttfWhz18lFNxW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtQImIUa; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtQImIUa"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso1891945a91.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791873127; x=1792477927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cf0DekLkQo44hkrueV4aqPPbi+U5QUyqtXFTYMPqfJc=;
        b=NtQImIUadkL7R5J6uBoER/mkCBKr8zgy56stmMHz4a+pLlH45CUL86btZdkzWCvuw0
         vcvYROfj8lGSBY3ZlAMc/iCzL9tJrZv5f4u0ByKqImKSk5/+6JwHEKR/EIAs+eVBwmt4
         5ZnkGzSIIzW7eJVUeRjswVdJUGnSV8vDa8rOh2ace7piA2VFE+Qc8NDLevesKnrkunDo
         sdsVE1ChMp2LNe9UDDodJavqZLQ1N/1SwFp2QTNlI07PUJ0sDPJs6Z/vWv1bZ+1Emxlc
         wmyQbnSVv671tyvwMPs2kkWd4Pjz4BW8TDywqYKC9ldV0rX8Nt1JIr7vZr2kjUm8Cl/1
         mM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791873127; x=1792477927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cf0DekLkQo44hkrueV4aqPPbi+U5QUyqtXFTYMPqfJc=;
        b=CoI7UYoR8MWgy1ITavUnAW0FpV7+5X83B+xtXpSW/yP8/lpAXEzjV1yj1ZnGx1u0Wl
         CRSgeda7bYi9rvxULuWbgOyuSBFSk4U7Jk3f3PSAt5rRg9SpiLVA6g5M4LX/SV2jpRnP
         Z2GDh+slV1tfMuVcjsie6zbMG+WJQSlhC52X3Xgj70Z9h90W6/R4imMSkwVROl+ouUty
         Ixs7DfwfMGQIEk/JpW476xRRCLX7R7ZrHmJakccmBzuWhE2cYs26BisQPl5N6TYTu4cl
         DgFlWZiGd/JfTESdrkGcM1tzdxIiNbVgCvSdrM0JIfcQQXBBpzlrcQxJlJXCgGFz/3H0
         Xoig==
X-Forwarded-Encrypted: i=1; AKwUvBxXVnQruaE92RNy4sGXqJd89g01MKbrV5Z7U6zJQEIdlRcYjHUMETJvrK2g2hCprNRFn8Tw+z4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsTvsWpvjvvL3YYQrL+o6m4LKHMRx43N8PhpYnLE/uzoNWIsNh
	GE005jydPssQWNKNMzOCEW6kpwLEIACYa8GgWB5Vv10NDXj4t3de7Pbl
X-Gm-Gg: AYBFou2AH1scIt0bZYGfpmc/5RKgKgvPF1J/zCNjIp77o3xCsawZwJo0GWKOa4cClSG
	peyTKwS8feYcPYaA2EduBaYm/TqOsHgrFwbK3YsKqHby3a7TBIERXb2skxNMM6q1qKmBbUV+cjX
	sf5eePmiQ80ByrRpNpDESMvKMJ16kFcTU14OGBjosL2RpMlmGjXvGTwH1O643dTZKGldca91tRz
	M/IBTl5n5tsVD59t7wS/Xm7pE+1NqJCVn/kSXEaKB5Xjr4HMp4+BoHIu3KEULOwzHt74HXtG/7z
	X3H0HHAmlPKGBbK0Qo/H1uKiDKubXGerquivB/zE7loCvqXEqTqoiZHeGa2hWH9BHhpg6wjuPmE
	gBysRJBQCZbD5/UbqVgzeseDijA52MKHFgfoxA43tD7SnYM7I7QyGNJc0nYojzR4mEu3pgb45Gj
	1Kww5D/8bU9URAYdCAKToltQruEf7VRMrTHQ2G7k8lNAvW0HO5FQYNXZcTDHPUgZuGpav+mSs=
X-Received: by 2002:a17:90b:224c:b0:39e:6c68:c77a with SMTP id 98e67ed59e1d1-3ab3ac58a7bmr11413151a91.48.1791873126483;
        Mon, 12 Oct 2026 23:32:06 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3781d581sm20018349a91.1.2026.10.12.23.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:32:06 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/4] vsock/virtio: defer RX readable notifications until batch unlock
Date: Tue, 13 Oct 2026 14:31:12 +0800
Message-Id: <20261013063112.168321-5-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013063112.168321-1-physicalmtea@gmail.com>
References: <20261013063112.168321-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An RX batch can make a socket readable while the worker still owns its
socket lock. Waking a reader at that point can make it immediately wait
for the same lock.

For the callback installed by sock_init_data(), record when the existing
low-watermark condition is met and issue one notification after the batch
releases the lock. Save the initial sock_def_readable() callback when the
AF_VSOCK socket is created because virtio_transport_common can be built as
a module and cannot refer to that unexported symbol directly.

Require the original protocol and both saved callbacks for batching.
Sockets with callbacks installed by sockmap or another user retain their
existing per-packet behavior.

A psock is published before sockmap replaces the callbacks and is excluded
by the batch admission checks. If an attach races an active native batch,
only a packet admitted before that publication can complete on the native
path; the next packet ends the batch. No queued skb handoff is needed.

Keep the socket reference until the deferred callback completes. Control
packets, state transitions, transport changes and non-batched sockets keep
their existing behavior.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  1 +
 include/net/af_vsock.h                  |  3 ++-
 net/vmw_vsock/af_vsock.c                |  1 +
 net/vmw_vsock/virtio_transport_common.c | 22 +++++++++++++++++++---
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index bf077ee0ded88..f1396ca3ad9b5 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -288,6 +288,7 @@ struct virtio_transport_rx_batch {
 	unsigned int pkts;
 	size_t bytes;
 	bool write_space_pending;
+	bool data_ready_pending;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 9d8ae62209eda..a799f08556376 100644
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
index fe7f49da6c4bc..f40659ec29df0 100644
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
index d6ebfde880db6..84822d6bfb958 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1588,7 +1588,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 
 static int
 virtio_transport_recv_connected(struct sock *sk,
-				struct sk_buff *skb)
+				struct sk_buff *skb,
+				bool *data_ready_pending)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
@@ -1607,7 +1608,13 @@ virtio_transport_recv_connected(struct sock *sk,
 			vsock_remove_sock(vsk);
 			break;
 		}
-		vsock_data_ready(sk);
+		if (!data_ready_pending) {
+			vsock_data_ready(sk);
+		} else if (!*data_ready_pending &&
+			   (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
+			    sock_flag(sk, SOCK_DONE))) {
+			*data_ready_pending = true;
+		}
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
 		virtio_transport_send_credit_update(vsk);
@@ -1820,6 +1827,7 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
 	return sk->sk_state == TCP_ESTABLISHED &&
 	       sk->sk_type == SOCK_STREAM &&
 	       READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       READ_ONCE(sk->sk_data_ready) == vsk->default_data_ready &&
 	       READ_ONCE(sk->sk_write_space) == vsk->default_write_space &&
 	       !sock_flag(sk, SOCK_DONE) &&
 	       vsk->transport == &t->transport &&
@@ -1879,7 +1887,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	case TCP_ESTABLISHED:
-		virtio_transport_recv_connected(sk, skb);
+		virtio_transport_recv_connected(sk, skb,
+						batch ?
+						&batch->data_ready_pending : NULL);
 		break;
 	case TCP_CLOSING:
 		virtio_transport_recv_disconnecting(sk, skb);
@@ -1961,12 +1971,14 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 {
 	bool write_space_pending = batch->write_space_pending;
+	bool data_ready_pending = batch->data_ready_pending;
 	struct sock *sk = batch->sk;
 
 	batch->sk = NULL;
 	batch->pkts = 0;
 	batch->bytes = 0;
 	batch->write_space_pending = false;
+	batch->data_ready_pending = false;
 
 	if (!sk)
 		return;
@@ -1975,6 +1987,10 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 		vsock_sk(sk)->default_write_space(sk);
 
 	release_sock(sk);
+
+	if (data_ready_pending)
+		vsock_sk(sk)->default_data_ready(sk);
+
 	sock_put(sk);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
-- 
2.53.0

