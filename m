Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD94C9E1A
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157246; cv=none; b=otuVJII3aceSZFEGP8ul5KYEEBhexClnOVYcMjl1Nc2BUfSB/PLaThfFor5jpyboOFnwgKsUIjcz0pvdYUvQAC+9dJSwbFuDUoZKUluq9glmJ75VW4U3D1wD8Ki+FiSuBByqUJMtze53+P+rbc4i72iTT2YsdzsdAmWcv4jMXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157246; c=relaxed/simple;
	bh=ISWeu8QEzSrFqiBXeb7EFy71sqAccupUyBleU+xH4Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3HmInbmbuvbQQ/wvyL/5GZMuy3r8ttWB+ifrQ9DJA3jpVXXFjYLYrjvXVgXHthhGWIKZdU/+brbQ1+FG4+iKQYZ7KYKdLpbKwFXPeoqeI3Wgb215iQAYKCLUGtXlToQZHTVntckcFfm7Ye8+bHjbP/llLl3PVP5LDWxWq5oHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG5h5/JJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG5h5/JJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso26133535e9.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792157243; x=1792762043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4YjOyRguzbQ9PKrv92k4FnDoKt53mMLhByiAMojhitA=;
        b=WG5h5/JJbmwsFmMPsBjmviIYBhCdOPPBRYKcYpNCW6ZV8W6XUgABurQJibcep0nav3
         eZqF2qxdOeOBomRfLo+0sbJZK20uIaNKhzy3yurarahQhS/KklXbNLOQsRUt4ndsdeY+
         pPndUUa9JWf2rAsqDgafX6aFrCBpg8RjhlPEJ+Mw92pgXlpiLJsQIWDmifOxaTKMgmYW
         ItJbqDEpI4TK0qAuXhgijkEHDywWghWiYUCRri3Jq2XffrsN2Jl6xYyv9rBSHGRkYlDm
         D1WhBy5v9WiMuZVUFqx+Qaxmg8WhnsMmfcuH2FrqRvm0oUfQh51ff1NHmNHLb6s7EDl4
         iwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157243; x=1792762043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4YjOyRguzbQ9PKrv92k4FnDoKt53mMLhByiAMojhitA=;
        b=ZFGb7w0XyHr4dARIaI5AXDnHCurmgDfA/HTSf3un4197nxZv9Ajmfiphjckv+eldAr
         zG5E8JvZOGR06aKq4WOBAQvQ4cGamQO0qjO8VXGCinOiCJ+JKFdsiNibu9WntUIYuaqp
         3v9VWANQcHa7zPiIPYS/eLUpAc+vKYqgXIYkaBJSht6mBpU7wIKDfJtKdml4zG2PT0/u
         uKJlY87LRpTBaA+SxNd5SCGf5u+YoN38efsVAgN5qFncDKa/1xxBvd+feHqBpuEqo5Lx
         WBWnHHSJcWuflQ3DLN0LkdeaM7kvK6NpToN371bMKhQbhRk8TuCxAom+4NBFQLnYmQyO
         363w==
X-Gm-Message-State: AFq9FYJYdamxHcpKpREGmofxH9l9NWOsP6E3wVOvjB+gbESclo13lQ+f
	y4Lce7MP2u/qHjoY2WFcQAlniE35vpYWvQwV+qnDn8PfOe5giUy2W26M0BLGiA==
X-Gm-Gg: AYBFou34j8s+d+94MuYBSt6xtSx4MLH9tIDCSRo5ckXRTZYleL/XItw8AVt0q++7+T9
	Sik9KQ3yvdo2c87eqwXkKFC8w6hFVcalFG+GOk/fNtstoelOoHtLjBG6eo1JurhkcCdjIdkHCA6
	YmH9ZEDoxXT84+T2uOI/2nTZud1STNLbxDWFqJyPqTP13km/fY6583sBlLxanVKlaM+kud38gA5
	K61KEb1MaXFg8lBjKh9ocu8BD57L3r1C8gdhBqN2w6fzH4ic6u3q48YGZhHQkfpuxI4p5jd6DAL
	GY/CWAA6Yr7wLAtVHgYcz4B+lwCKhCvO4dxg2ezQB/J9lwLryZprITfVr5z/3Ggb6mz1kZj1pfC
	QIylz5A0QMmc6zzPDnGiuX/SCcpBAiObuUpR2qTRj1ym+9MaOLwvAw12ylo+Wp0LXyKiRENE1l+
	OrkThM4pPlI4+NW/s3J8fKHqFiariefl6b7uNoRFHWLVfkg6NYZZYaS0oCRywnu+Czw7obzzlrm
	AXZGs5A1xOI+SMVORtQ4D5Cbqm7PpeaQrYrtwUa8fPvi0NEdGe6WyL5eho=
X-Received: by 2002:a05:600c:3e87:b0:4a0:a34:6e7d with SMTP id 5b1f17b1804b1-4a18e4bacbfmr418899375e9.18.1792157242302;
        Fri, 16 Oct 2026 06:27:22 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de7230sm58114275e9.14.2026.10.16.06.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:27:21 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/3] vsock: support SO_INQ on stream sockets
Date: Fri, 16 Oct 2026 14:27:15 +0100
Message-ID: <20261016132716.272018-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016132716.272018-1-devnexen@gmail.com>
References: <20261016132716.272018-1-devnexen@gmail.com>
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
reads again and sees EOF, and accepted sockets inherit the setting from
the listener. No cmsg is sent when the transport cannot report the queue
length.

SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
messages, not bytes.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/net/af_vsock.h   |  1 +
 net/vmw_vsock/af_vsock.c | 35 ++++++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

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
index ac2faac97462..6d77e6344840 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -984,6 +984,7 @@ static struct sock *__vsock_create(struct net *net,
 		vsk->buffer_size = psk->buffer_size;
 		vsk->buffer_min_size = psk->buffer_min_size;
 		vsk->buffer_max_size = psk->buffer_max_size;
+		vsk->recvmsg_inq = psk->recvmsg_inq;
 		security_sk_clone(parent, sk);
 	} else {
 		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
@@ -2018,6 +2019,7 @@ static bool vsock_sol_socket_custom(int optname)
 {
 	switch (optname) {
 	case SO_ZEROCOPY:
+	case SO_INQ:
 		return true;
 	default:
 		return false;
@@ -2065,6 +2067,19 @@ static int vsock_sol_socket_setsockopt(struct sock *sk, int optname,
 		sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
 		break;
 
+	case SO_INQ:
+		if (sk->sk_type != SOCK_STREAM) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
+		err = vsock_sol_socket_get_bool(optval, optlen, &val);
+		if (err)
+			break;
+
+		vsk->recvmsg_inq = val;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -2621,6 +2636,7 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	struct sock *sk;
 	struct vsock_sock *vsk;
 	const struct vsock_transport *transport;
+	bool do_cmsg = false;
 	int err;
 
 	sk = sock->sk;
@@ -2677,13 +2693,26 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
 
 out:
-	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as
-	 * a byte length when sizing retries, so only streams report a hint.
+	/* Seqpacket has_data counts messages, while SCM_INQ reports bytes and
+	 * io_uring treats msg_inq as a byte length when sizing retries, so
+	 * only streams report it.
 	 */
-	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
+	if ((vsk->recvmsg_inq || msg->msg_get_inq) && err >= 0 &&
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

