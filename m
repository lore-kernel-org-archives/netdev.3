Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C53E51FF
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849334; cv=none; b=b+UzS+oZwHPSBlz+0hlCCHvzrfvWF8j9nKpavXpViHhtAB5o0BjfbpF+ClrmmcAWs6LUMs72Boq/Z7DJ03ipN6x8UG4kw722lOf1poFx0BdElaCwTGHFZ4T1xf9m5CXJKbuHVSx8ynVXDTmOb3kk8fK82nHb3O2VEOYmj3i6RqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849334; c=relaxed/simple;
	bh=7Jppg6yM4EgF1LiDYJeOE79I8PpMZq9yJUvSKhHYuQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMJfwdKCiwyel6Z8VjdwJtMchmheU9BmvvnqyxGwEP6KYS7ctOFHaaUBAP77Zn9BvxEzf0SqLACV/yDm1t3eQwk0zVXhV0cNDBzTthC4BUpeXBMplPzUenFece4DcMyvLoVAr9MNyZWaqcIarn5Wl97FU2zW9bJouNXslRi2TyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTIiAExt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTIiAExt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48afe0081a6so1600417f8f.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791849331; x=1792454131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBDjfcYpOnFL2AwGB62aVDEEQFBwxjTJIGQXAUNz3X8=;
        b=mTIiAExtp+vzTD3O9gYjellUybDuRPWQLdJbEwn+wHzhpp0Gk8Ye0d5sDxArWvlTgf
         xoP6QekHy5aJOwW+GzV0/ZVHx7Yuv1RqMBBzThto0HrpwYYuqCThyujVdS/cJYgcWhhh
         8CLn677wd1KYS5Ta0l+yU8P/hNJ2MS+Tw+kOeP1q+at5//2bWRlFadA4n0M3W5MXM37A
         wXZPwWT8g4Mouk3nEdujwolsqiXts6Eldp+8k5tAObRHee/iFFGlpVukHhrkt2QeopP8
         Tk4ul8sz+6gD5UXRYTXw4hc9COctb5QInfJRR0F5LeYHOr3gMOJI8ENeJqh84Pvnr7EQ
         YHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791849331; x=1792454131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gBDjfcYpOnFL2AwGB62aVDEEQFBwxjTJIGQXAUNz3X8=;
        b=ha2/JezGO4IDtcpEb3NsjFXTtFyPBq19RQaKKOnyekz43pnwFWAPS8kGrVjrliKroS
         QVgY9AxrSuySU8qsNWp4xKSKfFqITOxEE5k3ZbTez3ffINW0oUc8CDOLrkVcEv2xRmr4
         gh2lcKDWNgyeC0fQ1wfTb8ln/QuoSrxtlVPzByih4bdrd5yd18CpQv6P0/YLsRWAjVtf
         2wkzYL8Bqd5T2McEfv0i50CNnCH5qcYoqAZsOFodlbFnzhh0YZLcIXQ1wFj06Fw25SiQ
         9vNVMxKMrzEIm0rYj5PW0kuIkMDIitLyxvDul6qvcR5pv9LkBMH1BWf0S45pwJkm19Pq
         Ysxg==
X-Gm-Message-State: AFq9FYKNHiaMKz2M6S2TyZ7bhQa2oAQnTDYEjw7ze3usoNKR39HEQg/l
	r74tdKyNRVQdt2IgknDuVTfUBiCtD7UlgFv/FM53Nb2bT3eTnGw7WoJVmXIO/Q==
X-Gm-Gg: AYBFou28HlxQmXJdR/e6h6HVgfBg6E4csdaX9vaMkTL+xvpSPCu2TpvyeNSvz13HwUm
	6h3scu3oewkDTMQrm9DclRCS4Gp1bDEl5QYWcxT7zq86FYMzsHGl4Ms9o2sJNCjs2A6KoTTpS41
	0wY4Rtj3fIIt4K/K3ulmpPK2svCtBBollp4A23VklC3HZmA2QxbZPkddtyHC8PfgE0Reju6hZ2i
	UuxZsP+VHhmXuOur7EbvBpJwajkQGQxFYnfxjgv8k8o0SXoWQF9Fxf7wckGiTtxNG5M43fNoYMT
	sx/etxRRK3m2g5ScRdOXJwRjU2iXjJSM94xI2ZBLF4LvzJ4Ib9ZnzhJCeBoIKisp5phvFQ4P2UB
	LdPy65duzomfScyl6R/JPtcfqAXnezIRyK334K3Q/VJ5YoWmrDJHrsee+Mi8sJnbH0SzwIC9jpg
	X1mVyUCeLZyILOUcNWFA1PiVkV62pjaQXqd8ecsxTyPx/BfwgowQm1ZDwd0uLkgYz6ekazrO0Dt
	g/uNuFFA3cKKu+cYDizaQs6KFTupAyH7TrXKb+aw3gbRgqaVw/iWPztJa8r
X-Received: by 2002:a05:6000:290b:b0:487:2805:6834 with SMTP id ffacd0b85a97d-48dbace156emr19400809f8f.42.1791849331313;
        Mon, 12 Oct 2026 16:55:31 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967a0dsm1933762f8f.3.2026.10.12.16.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 16:55:30 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next 1/2] vsock: support SO_INQ on stream sockets
Date: Tue, 13 Oct 2026 00:55:23 +0100
Message-ID: <20261012235524.41468-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012235524.41468-1-devnexen@gmail.com>
References: <20261012235524.41468-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SO_INQ makes recvmsg() return the bytes left in the receive queue in an
SCM_INQ cmsg, saving a SIOCINQ call per receive. AF_UNIX stream sockets
support it, AF_VSOCK fails with ENOPROTOOPT.

Add it for SOCK_STREAM, reusing the hint already computed for io_uring.
As with TCP_INQ, 1 is reported once the stream is finished so the caller
reads again and sees EOF. No cmsg is sent when the transport cannot
report the queue length.

SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
messages, not bytes.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/net/af_vsock.h   |  1 +
 net/vmw_vsock/af_vsock.c | 41 +++++++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1ec6..e8481f12312e 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -68,6 +68,7 @@ struct vsock_sock {
 	u64 buffer_size;
 	u64 buffer_min_size;
 	u64 buffer_max_size;
+	bool recvmsg_inq;
 
 	/* Private to transport. */
 	void *trans;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 1c2d1cea67f4..874dc1545a35 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2050,29 +2050,38 @@ static int vsock_connectible_setsockopt(struct socket *sock,
 	transport = vsk->transport;
 
 	if (level == SOL_SOCKET) {
-		int zerocopy;
+		int v;
 
-		if (optname != SO_ZEROCOPY) {
+		if (optname != SO_ZEROCOPY && optname != SO_INQ) {
 			release_sock(sk);
 			return sock_setsockopt(sock, level, optname, optval, optlen);
 		}
 
 		/* Use 'int' type here, because variable to
-		 * set this option usually has this type.
+		 * set these options usually has this type.
 		 */
-		COPY_IN(zerocopy);
+		COPY_IN(v);
 
-		if (zerocopy < 0 || zerocopy > 1) {
+		if (v < 0 || v > 1) {
 			err = -EINVAL;
 			goto exit;
 		}
 
+		if (optname == SO_INQ) {
+			if (sk->sk_type != SOCK_STREAM) {
+				err = -ENOPROTOOPT;
+				goto exit;
+			}
+			vsk->recvmsg_inq = v;
+			goto exit;
+		}
+
 		if (transport && !vsock_msgzerocopy_allow(transport)) {
 			err = -EOPNOTSUPP;
 			goto exit;
 		}
 
-		sock_valbool_flag(sk, SOCK_ZEROCOPY, zerocopy);
+		sock_valbool_flag(sk, SOCK_ZEROCOPY, v);
 		goto exit;
 	}
 
@@ -2581,6 +2590,7 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	struct sock *sk;
 	struct vsock_sock *vsk;
 	const struct vsock_transport *transport;
+	bool do_cmsg = false;
 	int err;
 
 	sk = sock->sk;
@@ -2637,13 +2647,26 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
 
 out:
-	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as
-	 * a byte length when sizing retries, so only streams report a hint.
+	/* Seqpacket has_data counts messages, while SCM_INQ reports bytes and
+	 * io_uring treats msg_inq as a byte length when sizing retries, so
+	 * only streams report it.
 	 */
-	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
+	if ((vsk->recvmsg_inq | msg->msg_get_inq) && err >= 0 &&
+	    sk->sk_type == SOCK_STREAM) {
 		msg->msg_inq = vsock_stream_inq_hint(sk);
 
+		/* A negative hint means the transport could not tell. SCM_INQ
+		 * has no encoding for that, so report nothing.
+		 */
+		do_cmsg = vsk->recvmsg_inq && msg->msg_inq >= 0;
+	}
+
 	release_sock(sk);
+
+	if (do_cmsg)
+		put_cmsg(msg, SOL_SOCKET, SCM_INQ, sizeof(msg->msg_inq),
+			 &msg->msg_inq);
+
 	return err;
 }
 
-- 
2.55.0

