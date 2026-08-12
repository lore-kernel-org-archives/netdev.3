Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A26470EB6
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549424; cv=none; b=P6Zd6JqwykuXZP/hi6Csoko1rE1AhT/f/ycrjVIAYCq5iHqFyQvIM2+hCHUtuEFvj/ebLvBHHND6p2DsyRMMRm9Z/UK82DoTptKMm/6+JjjUsFigyVizQBR+q+0qnveHuoqND6MaTFXRuUcN34c/QSFnLdZXNzTuL4L0rT/+7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549424; c=relaxed/simple;
	bh=sDfBi1FbLdZKEIjCa1JlIso23rfEnxUE7PG6iWsMglA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5bYpfLlmfhvPQoYoHwaEjHFhm3akJkFNU8xFRlHsqeVo5pXndUGVdPHemukl+N8MMOMJsAAa57N/GIj4Y6MKPrx5wM//cRFUX3xfkF3/79aeljLN908vksUBkXP66l0njqwE9dvo5fWW59M64DGVZs3D8BzBW41r3/R5244fr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8FT1+1y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8FT1+1y"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49802c418b5so10472865e9.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786549421; x=1787154221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i0II730EeqJl5l4RTb/tRpoa4/jb1ggTvoYpR9OsVSc=;
        b=D8FT1+1yR8NwKmWimrBPXQG5fai+4WM/OdxPNtMKXJtcxyInTg5KMZcJS7XAvOps3s
         37ZxxzQdxTyOsZNaHAMNAh81n5teAfV1MBSsQOxvYe0vzaHVZy0DOrK+wDxJCUko09aS
         BemJJuRSG/08enxF9iqVMdmGRr/B8wQ7nBgE6CZvFG5Ul3pdRikrp/o2nlV5hNvj6rpo
         LlHZFOzeSyEA8Qs/K0qENli17l+pqWOTjLf0v+vj78LJd1OMeVguEVHVxczPRKs8K1RW
         TGkr+CEvBZJGOW0NfczwYq95O7mwVmTwOvAxEqvRzHO0+PmzEYDBaaPfrtwLTUudh1OZ
         LyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549421; x=1787154221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i0II730EeqJl5l4RTb/tRpoa4/jb1ggTvoYpR9OsVSc=;
        b=dViuGVo/FvMAANPWwpaWnMyAgyMsJIyy0QOxhHImKm9X9ly77GqJGFCVuK7Ht/jIs9
         Fgm5qXN4lWwmrj6NmRUQZrkN3Ih/3o9Rfj8b21XWNGZfnchPapxoj8wvrFgHi7jITX1M
         Lrfq5PCElOs+/pUhAZvMFwtIOAQDZcd1UDGfDsOENQutznnwwpDkt+uqIsdFpqSCaY9D
         BqbPYrazGO4+H1z/rpgYxfjYxgCLTzB3xJkyLnprYGx3Gj9zJ7avlaMT+cppNH0+CpV7
         leXholba6pBYv4HeZHP157LIMJjtTHbpt3BSwY9QryqKX+y0WcZxyn1swZov62vSz09D
         dQeA==
X-Forwarded-Encrypted: i=1; AHgh+RoCo90D8rtwIuLUL6k6/fLQMNEB5Zu1fdGRTPJMLQvY91r4PchhWslZ6AyabLti+MIpUEKyilE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymD5lhfraHn4uXwRXwnQiyF0kfcbvWpgn5Uzx7I+5GOzXTMP7d
	37JLjlci6CBODrSWnnJ3jzWeG+xr304KT2v4BuEqTKpH/ja3l0oCsqBQi6elgcPLVN8=
X-Gm-Gg: AR+sD11/4b//5YgBBNrXbD7+/FU0t6S6Seb0GQczwN7Q3++QhaeKrfZmhwoQwjXv+HM
	O6NGc+Qje6icxysT5GwpCGjbXnaMMu+8fPquJT4GVdEe5ZQUZERzuSoqWmdt34kc4WMt4LgVN5L
	2NtzzMqESpPZP64t0SxwPM90F0ghfz6edCQy6SrNWihUAn+Rc4NptZ7e0QcdXZp+JaDXSMKDXgQ
	VMx4llzwWhT9pOe0RDKPO/BBQJWoE8d9yAaKsNtljlKfVezSrRnxIBAJushIrpExRPkYbuWGDRY
	CkwzKcN/VrX4RnHSQh30xU6VeIv8NEH7m21Ng/DiuE9dWGwu8+v9tB8BJeuLq1IXKwG8+sfSwGi
	rtcOqFpzBMb2R27zZSKYCIquV2ITHbPpnFG3Vay68eFtOA2/NbmMsVKAgWoMtn6iqDrVsL54XwI
	AeCyrVKM9PsAt753O2+cO464zTpWjfpUB651a8htnzyX1Uz3t9Pkgoeiv5DXoaXo+if3CUS2IKM
	oxjwY+IRkHd6yNaXzQEprGR+RyHtPGGLw==
X-Received: by 2002:a7b:cb8b:0:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-4997c13b097mr62361095e9.14.1786549421232;
        Wed, 12 Aug 2026 08:43:41 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4997c939574sm51584985e9.1.2026.08.12.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:43:40 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	ameryhung@gmail.com,
	kuniyu@google.com,
	memxor@gmail.com,
	jiayuan.chen@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH bpf-next v6 1/5] net: Add connect_socket() helper
Date: Wed, 12 Aug 2026 15:43:24 +0000
Message-Id: <20260812154328.72834-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154328.72834-1-mahe.tardy@gmail.com>
References: <20260812154328.72834-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper that connects an existing socket while invoking the LSM
hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
logic. Other socket operations have equivalent helpers that trigger the
appropriate LSM hooks that can be reused, this one was the only one
missing.

Acked-by: Song Liu <song@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/linux/socket.h |  2 ++
 net/socket.c           | 32 ++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 2a8d7b14f1d1..5a5eb1250103 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
 			     int addrlen);
+int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
+		   int addrlen, int flags);
 extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
 			      int addrlen, int file_flags);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
diff --git a/net/socket.c b/net/socket.c
index 63c69a0fa74e..5b02e6217c68 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2103,6 +2103,20 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
 	return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
 }

+int connect_socket(struct socket *sock, struct sockaddr_storage *address,
+		   int addrlen, int flags)
+{
+	int err;
+
+	err = security_socket_connect(sock, (struct sockaddr *)address,
+				      addrlen);
+	if (err)
+		return err;
+
+	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr_unsized *)address,
+					     addrlen, flags);
+}
+
 /*
  *	Attempt to connect to a socket with the server address.  The address
  *	is in user space so we verify it is OK and move it to kernel space.
@@ -2119,23 +2133,13 @@ int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
 		       int addrlen, int file_flags)
 {
 	struct socket *sock;
-	int err;

 	sock = sock_from_file(file);
-	if (!sock) {
-		err = -ENOTSOCK;
-		goto out;
-	}
-
-	err =
-	    security_socket_connect(sock, (struct sockaddr *)address, addrlen);
-	if (err)
-		goto out;
+	if (!sock)
+		return -ENOTSOCK;

-	err = READ_ONCE(sock->ops)->connect(sock, (struct sockaddr_unsized *)address,
-					    addrlen, sock->file->f_flags | file_flags);
-out:
-	return err;
+	return connect_socket(sock, address, addrlen,
+			      sock->file->f_flags | file_flags);
 }

 int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
--
2.34.1

