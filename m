Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021447A0C4
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862052; cv=none; b=W9iLZTz1h4c4ztYMTvmm+A238L/ycttUWZm1hpMSr0TZ0RGuUscJTBFX8QE13YWbWnHrILoN/BM1iYSXSoBHNkWq9rpc7cDJ1Gq+QgHF31GzaS3Jgwmv1S7Rfe180iGfjAn62+dTGaEeuUHAEajY9WfmYIbtLvffn8c1PzlhML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862052; c=relaxed/simple;
	bh=XV0B/JhCsG40H9ag/PHxTNYCI0x+JONwkI59bxqGKMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W16/kYJGwJwkqSKe3i1lJH8npJ1wn9dKxECVlWxCo3cSLuLX4oTb/dllDFtK8Y5i4AXye8ExVWgCmfoPHD460Qe+tLIK/dyXtdvt8IwV7cXBEUHwDT15kUXJW9LeMa/iuFEjweP+vJqBpBIbFZe6mX2ifLzrePtRYLsHBHsBb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAT5shlp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAT5shlp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4980dc26022so236815e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862026; x=1786466826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rwrdJxGLamDKuaEmMI5UrE7st//n0E96F1Xn4wpyT0=;
        b=FAT5shlpzlKMdMyn68N0l2a8Xtqxu1ZS0eYBJ4NyrLfkd6PFvObcpXzHZepI4YudT3
         K0G39a3nFqrhnrq8KHttO9o18HOXHzYY9Ep0qguYZ091J9R2Z/ozbXASlvYLp1TIV1is
         9pq9SgGs6cdjyigWagzFNW/YjoRrbl3fTo21bARl/PSRVNPEpH89Nqfoq3yLpHl6O1rY
         6B9MDc98xc3QBHvwMfgDHPvlL/8B8Agt+TekLEBCWHbLQRad8SxKoN9dHhmgLyAOYsEe
         rPkczLw43Ltm3EFORizcwn/L+ZIR4a0r9w16V0XFxj9LoQXmQ/RK7WRqsET5WCjGijWQ
         1zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862026; x=1786466826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1rwrdJxGLamDKuaEmMI5UrE7st//n0E96F1Xn4wpyT0=;
        b=BHgEZztZSo9a08a8AF5ywfDFov0+aUgPvalZNWau4zEFnx03vTGEIdUjtqY4DrmMUO
         9T1UOEX6ppxrM1CiyxQTrSpvnK//4Ls437E98YuTJAdCj3i+mAcQjLErG0s3fsT1uB3q
         y5gfa7Xi6tAScQokw7x0tzmxmlDy9uB2Lg1HMwxiEvJ0mWnjdiCXCOjpM9Ow+8yDS8pe
         XkI28rmIPafGLrNPKNjRXH2UwZa0w6bHslDCDWjNRaL8xcxxWbAj6NQ4GHPDjN5DZjLx
         GnYMhCdzvEelWUIALTdm/ZA/iusA4VpYq+jNB/4SFSsrZX6GLYX9uiOoLNMDWdBwMMXL
         Ab3g==
X-Forwarded-Encrypted: i=1; AHgh+RqiLvj4XkT5Y5i25lYOCo9mP6FmUjNaQjxazx8nGjHaDb+2cNOhqchAEfqsYiAy8JQpAHTSWyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQghua13WzBnZHwUS3AP5narUAz7ZU4gTy3EZwVeedgi0ifEn
	NIMlehyiy+lJk53x60XzU61eXmqGDQDwPqAiYGI7yhT06S625cVN8r7D
X-Gm-Gg: AR+sD128hdUXBkIEFsTNRlzQN2AeUR87j2XPO7/oHoMHKIHjpatAADXy1iVKLwUQpmt
	S2PNOs/gAyDwhJekFRTxLgnDYVoqqQy2nqRFYh+1mc5IC5uAfYcw+JxVrj8XxTR34QKQ3FIEPsx
	oLtXX0sI8e3kQpxmELAiELDmuMqUkFEVSeduykVbIxAiqodFISlUVumPN6H69jtRo1p8GaKhZ9S
	RbW2iJOlAXHkRzXAOMNd1/xT2m7pSDEEBrcPFBTSpaPyaGEuOrq2PAJcVWodrbr+nSHF6qYUFaI
	Wid22qFAz7HfNdvqtuUGigDHBNWA9RP5sHSfXG1NhJr8B/b66lcMGQUwe8kPcPV/kqa2G6xFjnk
	UHgQWcdk6xMsxjQp3kTf9U1pXMIMe+k5Qj1CiDCYYqYn5v97NBqf1Hm9jrQOdkeo38RY5Ka5pu/
	wTG2wzYYFCitjjmlJkpGc/UAfb3RTijUYNlUendlOKIbCQM11WeNGoNPJlQvAMUzZJdaMv4g2Ry
	q5Xt9wwoQcLOlo8RF5RWrRokkLUbo3YFA==
X-Received: by 2002:a05:600c:840f:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4980c64520fmr314174835e9.2.1785862025962;
        Tue, 04 Aug 2026 09:47:05 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm14229485e9.15.2026.08.04.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:47:05 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v3 1/5] net: Add __sys_connect_socket() helper
Date: Tue,  4 Aug 2026 16:46:48 +0000
Message-Id: <20260804164652.296919-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804164652.296919-1-mahe.tardy@gmail.com>
References: <20260804164652.296919-1-mahe.tardy@gmail.com>
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

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/linux/socket.h |  2 ++
 net/socket.c           | 32 ++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 2a8d7b14f1d1..48f1eb8193de 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
 			     int addrlen);
+extern int __sys_connect_socket(struct socket *sock, struct sockaddr_storage *addr,
+				int addrlen, int flags);
 extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
 			      int addrlen, int file_flags);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
diff --git a/net/socket.c b/net/socket.c
index 63c69a0fa74e..c7427dd4dd52 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2115,27 +2115,31 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
  *	include the -EINPROGRESS status for such sockets.
  */

+int __sys_connect_socket(struct socket *sock, struct sockaddr_storage *address,
+			 int addrlen, int flags)
+{
+	int err;
+
+	err = security_socket_connect(sock, (struct sockaddr *)address, addrlen);
+	if (err)
+		return err;
+
+	return READ_ONCE(sock->ops)->connect(sock,
+				    (struct sockaddr_unsized *)address,
+				    addrlen, flags);
+}
+
 int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
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
+	return __sys_connect_socket(sock, address, addrlen,
+				    sock->file->f_flags | file_flags);
 }

 int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
--
2.34.1

