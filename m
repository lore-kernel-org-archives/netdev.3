Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4C43161A1
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157244; cv=none; b=KXS8gNPNQWuB9amnflDn4mCPMK2zkOLlH6nX1Fl0zW6g2foDYj5fp4VFjbQ5blOC4jtmeCF/OcqzW9eTWnQDX+YwwZKZAmFvDc8BxDEJji0bFmzhHCk38dZWBE4D8/nQqMihyVK3DgSIjYLGa2ebl5IoiPL8Kb30XiUrakRYtr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157244; c=relaxed/simple;
	bh=7lJhbyjirH5zCJmTumSnG3oHiNd4/m1148HN9wMGhoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Knja7S23zQD79dEu8tUQYgOBwNP/zegosYVX+f6fiMfzsTFF6ppPY70WWUulMMbizgNMIVKR6VNsbG/DYuUAEEz0X0etX8nxYZg2Fig1toVQLIXB9EUCbnIUPe9WdpJ55ks9mukJlCQ3FzZxFCyp0XmdbVlVq4O4PR5BfNPD4jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQRilWui; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQRilWui"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a02753c04fso35032145e9.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792157241; x=1792762041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MIGsi8yoMefpYRASR5cNSIMFZDXgY+eEY8Ausj37ByM=;
        b=kQRilWuiAn8tICLJUeOY3AAv29cxLQwuRgfsTvX/wPX5TQD7xVoZlr64wNK8Dy0xHP
         27Cqrj2iL4lro2KEGHRkdixM/9hbqfyQtW75865l7yFti57Q00cLub58zNyh5gkhaROl
         WeuLhJ2aZTX/P1N84tBXCP7DToZeekNGDXGXISemMuqeJvWqBWn4+nkDJ1nmUdvQ6du6
         tgMuXLxFpbIFUQwOE3QLZD2J+AQbjtKFl8qB9B7DG+QeiDJE1G+D2r0V+vrllIRT6GoN
         esYt5nA4thMexChiZECyCayUu4pfVNA0uqoRP3xowuxiDIFYTsWIOkBk6TxmjWM4Gr+W
         MdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157241; x=1792762041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MIGsi8yoMefpYRASR5cNSIMFZDXgY+eEY8Ausj37ByM=;
        b=ZyvxW32ckjYYkb7dNAFAxMrFr9rZQ7DvhLCnUctZfzm3djTXICzbhhvkKH3LBEJXFd
         9ibiSqK8s7SQn9bEsIWJM/2mitWpr3puKeBZH+0+8FJ9q9TcL0EIiQfbnj5p96bgU2be
         rd/vq6iXJ1EDk1xYuthaANn/Q0C4Cpg3PfLg2/s0zCbnGv3lNTVE9WyMVT0mTfoz9f9j
         YTeW+VZOgLiFIH+cgvwMnDMTbQThjzduDixdwvllBXy2wV6k31VC29ni8ONLxOC7ID8b
         DiBClAXwZxF3uUpUp1UZhnH/YOFImTIZrPQus+HTVkzUMtQhXAtDmec70Ga/HWMHY2jd
         Asfw==
X-Gm-Message-State: AFq9FYLO7BltbleBBagPXkLgbC6r4rvj1FLIyE9KAUx8oaNCSwt00uT6
	6kS5Abzi4AiG7ezQAKjSh9XSMUU1DuluHRCErlkuzLv55S4+lvLcK2DPiJXvUA==
X-Gm-Gg: AYBFou2SGz9W/9xINJYUN03cbMAMDaPhhXwZ+ibSLdkmibiQ1sEdA2tGs52qEtPa+TG
	2/dlPBWOvknoI9dfvb7Lli+wfssEmz55Zt8I/KPktMAMJISw9neERaikUDX4rcY7inHTHgmNGrQ
	oAdjSEa64SnnWknBA8mE4xh4N68J2G+NVZegKA4N7TJ1LoPnXPf0qHDiDfkKH5rqI80JpzGy1T7
	8E/8aka1VdKp6SI+xcYUm30OHoN1MUwp4NuH//ubZON55LUkTRU0j/bCE3BNJi8yxVWMvRS/MwA
	SpwSAGFriUKC506nhtD1OI4rtaRId9Um6QNdLoGy+1/3KjX180mpHSNsPuMMUu1wdxFJL6nXgLN
	+OeFPJKIKGibqNn/++U4tbAXDUlWwhieh3XJxdDWWKZMF4FtJxYg7VF6KmFp/ONB14YpJqJxUSw
	udHzLtUK2+2zQ6TOBKQ2TUu8lxsSPnO7cX8X2HYWcLE+o+LVgBvgI1AwTbiJnAytRdIl0pkBI3L
	IhSjORTtgjH4UO4VI9plX7tSF3s+nLF9zDw8TLoS10v4L2IBgFfeY+4WVE=
X-Received: by 2002:a05:600c:3e0f:b0:4a0:1b21:2628 with SMTP id 5b1f17b1804b1-4a18e4b60d8mr444663565e9.23.1792157241254;
        Fri, 16 Oct 2026 06:27:21 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8de7230sm58114275e9.14.2026.10.16.06.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:27:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/3] vsock: move SOL_SOCKET options to vsock_sol_socket_setsockopt()
Date: Fri, 16 Oct 2026 14:27:14 +0100
Message-ID: <20261016132716.272018-2-devnexen@gmail.com>
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

SO_ZEROCOPY is handled inline in vsock_connectible_setsockopt(). Move it
to a helper with a switch on optname, so other SOL_SOCKET options can be
added as new cases. The value parsing goes to its own helper too, so each
option can do its own checks before it.

No functional change.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 90 +++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 25 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 1c2d1cea67f4..ac2faac97462 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2014,6 +2014,66 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
 	vsk->buffer_size = val;
 }
 
+static bool vsock_sol_socket_custom(int optname)
+{
+	switch (optname) {
+	case SO_ZEROCOPY:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int vsock_sol_socket_get_bool(sockptr_t optval, unsigned int optlen,
+				     int *val)
+{
+	/* Use 'int' type here, because variable to set these options usually
+	 * has this type.
+	 */
+	if (optlen < sizeof(*val))
+		return -EINVAL;
+
+	if (copy_from_sockptr(val, optval, sizeof(*val)))
+		return -EFAULT;
+
+	if (*val < 0 || *val > 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vsock_sol_socket_setsockopt(struct sock *sk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	int err;
+	int val;
+
+	lock_sock(sk);
+
+	switch (optname) {
+	case SO_ZEROCOPY:
+		err = vsock_sol_socket_get_bool(optval, optlen, &val);
+		if (err)
+			break;
+
+		if (vsk->transport && !vsock_msgzerocopy_allow(vsk->transport)) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+	return err;
+}
+
 static int vsock_connectible_setsockopt(struct socket *sock,
 					int level,
 					int optname,
@@ -2045,36 +2105,16 @@ static int vsock_connectible_setsockopt(struct socket *sock,
 	sk = sock->sk;
 	vsk = vsock_sk(sk);
 
-	lock_sock(sk);
-
-	transport = vsk->transport;
-
 	if (level == SOL_SOCKET) {
-		int zerocopy;
-
-		if (optname != SO_ZEROCOPY) {
-			release_sock(sk);
+		if (!vsock_sol_socket_custom(optname))
 			return sock_setsockopt(sock, level, optname, optval, optlen);
-		}
-
-		/* Use 'int' type here, because variable to
-		 * set this option usually has this type.
-		 */
-		COPY_IN(zerocopy);
 
-		if (zerocopy < 0 || zerocopy > 1) {
-			err = -EINVAL;
-			goto exit;
-		}
+		return vsock_sol_socket_setsockopt(sk, optname, optval, optlen);
+	}
 
-		if (transport && !vsock_msgzerocopy_allow(transport)) {
-			err = -EOPNOTSUPP;
-			goto exit;
-		}
+	lock_sock(sk);
 
-		sock_valbool_flag(sk, SOCK_ZEROCOPY, zerocopy);
-		goto exit;
-	}
+	transport = vsk->transport;
 
 	switch (optname) {
 	case SO_VM_SOCKETS_BUFFER_SIZE:
-- 
2.55.0

