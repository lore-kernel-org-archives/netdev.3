Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25909371877
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619167; cv=none; b=pNzgauX+W/q21Yo5pBw9r2Zvak3CtrqDc/wMV+PYNvBx9lF0tAB8ItF3lBXQ2gX9AMLqstHZRZzDG0Ks3MxobcbWwE9WaxUodxQZDnEdngO5vP6h/mgoZ2vj/dk9w2fWaxoUIzJcGMU92RVSzDS4MTFM8l6QwF+C+yqVWFXuuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619167; c=relaxed/simple;
	bh=/yYGJkeLFvj6Y/LJGIkrIrRkkps5bX6o9nrpAAlAySc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VU2GsKlILnCZ61IRQkpxIqVFyY9XFhBvbzQoW9XTLFWvAhnug00UN06gMB0RcDIjAn+lRU+xGfseazecO2mLoGtumryAs8PjVk6n7ZaDDGDrnDf0QFxxUGhYNmy4U+sC1eZHTRK0LxPzNQ1cK3B/xK5IxZdyOYl9Nsunz5OH0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZzunGJa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZzunGJa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495590dde14so24079515e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786619157; x=1787223957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0qkGJ5VeeBBVHFBA4qv8+apvvRtJwiCLF/FlNU51i34=;
        b=JZzunGJav6eDfwvMzG7CP1bp/ZbjIIgObe49lf3IRc4SxfPR04OwyjsucEx7J8UoHp
         bYjpxzM5sKjHR7QpAirBZX430WG/U6jKW1fp/0JLcrPZWyAC6d7BzaKU+Z3i7oxKorjY
         +n3/1tq3ulbFupEofPifbJJCR1Vd2X9PkslIwdLO5XZgrEg58xCcmbaUvlvMX2aSA2fy
         LMJaBO+fTAdckgbXk4zn6xcLgNXigHaumcKb398DC7fgyVK18UZn3htDelM1gSjgUE02
         4r/Dnm20qa8Jfrgz57m+5Hg7dCtk9rKWk7jo/xmEFzPcUJtqYNtXk5nlBOimPNcWf4hg
         QSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619157; x=1787223957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0qkGJ5VeeBBVHFBA4qv8+apvvRtJwiCLF/FlNU51i34=;
        b=YsxH435N31YPxTjPr6qp0aaIHnut10mT0CszzD2lzlqwvKpK0hRYg7L4yQ+Fx/Yv+z
         dW9obQMH5J0oXJE3/a9yacI7kERTPrdNnU7g9hrnlC1zrhTYryonmz04crDpFhADmmPJ
         Mac+L4HjSN9Bv7OWX7a+VlbpJaFlt2p5QMN48GW8lXI9ZRAiHTM2L6V8nhgMnQvZtaD7
         Rk+/r4TmX5/tQUR0WDAKr0YlNhuB0gTUiSMD448FltHtA/TrsX4zSucqaCkJowySK1bM
         AxiJES3A7t6kSlxjVmQG1Fv6rgwia7OqSiG/bxjvze0lnYqbrwfOAJgbz7V6oo2Qx6wm
         WQ2A==
X-Forwarded-Encrypted: i=1; AHgh+RqqI83P/tSuoZZPnoV3kdp0zRdHyk0Yw4xRE6yChQmS3Ueb6EcIcUmJnf1bPv2+5Wfv4BUdyYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8D4+PVDg5N5OX3UfZabyx/f2xm9skYF6RWu0OngJcEadooPUW
	sFsvUFOfzl9HIIC66scxflymHqOy13HHy1FNHFq37ojtYrLPL+wUqp8f
X-Gm-Gg: AR+sD10Gvdub8rTuYQtHiTa9+X3uC+czNdEkZq6TCr+HzD7f0VbLXblSpp9WKT7zI8f
	a+Cn5wEMXT4TK9LZ6ac0i6tT1KdVPGdEQF5POgmE4gRxN0KJJt765yxLup1tCvpDmxmrgpROqyZ
	5Zi//kBoR5W9vKD+2TN0Q2vvBFKAwZJDCGEh7yswncAhaaQA04dFxmeH+IS0740/HzFtxntBIuH
	TBAeO4UuMT3iU0XlU9V9j1BDkod9PHWT/uJa6Tczx31AuRSsr7Dn+jvjyCR64K5gwPaeUviZnE/
	u60uax1KBEShWArLYC+cvaXDOjWVKQ7jeJ7wU+IN8VapAQzItMtHCu6njTbJdcRqe/XGoGtSWxQ
	Amh6GSOfL7T9ZMZC58LdRtJQTYivY8EFvtpF9DSXJb2Gr0Yq7Pz3PAbnBEMODKRtovlKzedO5mx
	bigZkU9zf6hLHtx97uFG7V+ChUqTmRNf3Lk2cZR70Tv7gLQGB/foKMFFthEsBjQ5csA5HUFnR3P
	j4/NnX0BOPl/zX3JBH762Bcq/tN3EZlFA==
X-Received: by 2002:a05:600c:820a:b0:495:6b55:f938 with SMTP id 5b1f17b1804b1-499821acb31mr62643955e9.10.1786619156704;
        Thu, 13 Aug 2026 04:05:56 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49982131261sm93841285e9.8.2026.08.13.04.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:05:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 1/5] net: Add connect_socket() helper
Date: Thu, 13 Aug 2026 11:05:36 +0000
Message-Id: <20260813110540.103550-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813110540.103550-1-mahe.tardy@gmail.com>
References: <20260813110540.103550-1-mahe.tardy@gmail.com>
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
missing. This will be used in the next commit for a new BPF kfunc that
needs to connect a socket and trigger the LSM hook.

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

