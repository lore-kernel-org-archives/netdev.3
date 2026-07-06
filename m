Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320943B6DD
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330548; cv=none; b=eV8d5Zsica7UPWtI0kV1nGmMvvg4DjoUOZmsaRIy/VQ0oSv8oiNdovDtTYfoiPwTLHn0fPlEHN+izqOaXVt5fHucqPk4LtV8eVJvB5TDYWX7ejszjEnCDT/U2BenwnRBytEDZrG8egQZucQkkDhXwGmjspD7Fv+GFeeWWVFJ3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330548; c=relaxed/simple;
	bh=XV0B/JhCsG40H9ag/PHxTNYCI0x+JONwkI59bxqGKMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQud+FQq+IzH53XQ8nZ67M3W/vzkdTrtDIYKfz46bO6j+NQpbJL5Hy3N4JVao9dOmUZNib4sjNe9c44srxTvYOiMn2tyCOlXWofxIuoFgNC6arkSyeViAWStFz1DAuJaZjhFQ+2Ei4709ZWd0CnJEj1LC4eCBmKCLEGPwZZtWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTaTruKE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTaTruKE"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47db714766aso452284f8f.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783330543; x=1783935343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rwrdJxGLamDKuaEmMI5UrE7st//n0E96F1Xn4wpyT0=;
        b=sTaTruKEJCmc/yieB3J5KXszHr3NlaKPczIdQ3XtA87Gnq+dhI3YfE7ba7upJNq8OU
         a7phPZkn7EHWyumOEQ20yu8bUefnhaDxTgFVYM78Pc5r+0zecbrtV2GJjBRlXdqe9Ydu
         aAR4gxt/huSgOHcyiEIzm1Wt9fuR2eB6f1GgY8W28kSXzPwqSZDpqPI0Bt5UuM9ZfzFi
         0tqd8l2n+tt6U0DHW+0rhlVNl+jDwfjR6wrVlB+gGUc39BgV6jswYfL6sgWlgsJeD1cO
         AghKyqR1SmYhwJqJIamahREuEXKgFxPuoywlUhRB1dmnlJs5ETIuHGhDYI4CDJhW8xNj
         KzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330543; x=1783935343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1rwrdJxGLamDKuaEmMI5UrE7st//n0E96F1Xn4wpyT0=;
        b=WcryETIxdy7HAXgV9Rs/4m5mL+NKxxWmejo3eFMDSm9RyqOsso3yvvV1RHw0V1D2JD
         6ItQSTWgZOhTIMLFUtb68ryF15m/rWUY5+4/10fJeqcFV+WFLMGRtkvn3SS5xR1TPnD0
         TycW+KylIL0AEFaDFuMGKl392lH8ZPW0w+7i0S7tTA4m8hK4YT3oEytDd8Xemc4OxLYj
         BIcGxcuH2l23ipNPMYaNvVRL6vDCl+bj43f7lH4ErartaStWP71sJSKRVHFhBTaKtKzf
         6tUzoxnFPlxIcNp6shGjRbDUt4jstIPeerwqfsh41ywfs3/BL/byKp2V9xGX+5MuR610
         2s9w==
X-Forwarded-Encrypted: i=1; AHgh+RoeelPj/xJ/P0WYWfIhUoiU3cAcfi3WL0FfeuYcyxH+++5qalvtBOuzQ1Rqb2uOH/+gakG9RGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOAmEATZUkFSY9F6elgqf2AxSFpJ68mt2u6yQbOsewk2XsEAu
	XcVMt3ncUAVjogzZv4iYBs1lEpf4sSARPFC04gmiU/7hkDddx5rwBLoy
X-Gm-Gg: AfdE7ckgiLu6ilxMueu3nk8R2TeVThem1hHuH44zU4/Ecn7su9+ZwGYbVMNzIAkzTfH
	fngrkm1FiiT5LpUd7AM6rKzTIxFWBX8rL0BurSYFZ1UAGR//q+fHcz1WbDf766lyaZxRUMPg9yE
	+/W4dbINANdjXwkL7e8ZAzaXM8tCjPiHZ0BxXd+8bwCtG4uiNBzRVZaGyNwJhIbuuuj40nprwEQ
	h+Zk73vH+X0NIMYgMofdkQzRFs7AMmo+woBcCsZxE05vrBIcwPzu7AGTgMhReopmXPltFnEFffO
	JW/aDQlHcBXO3PsBjmKCH7pUkHMhYBZGpjk45fFCW3rb7SQ2/Szszog630lm540i9AdZKYssrSk
	i4ks4TcAPoyvJf5bm2bRGWBcPpSrPC068+xaZYOSlEFv8M/CVI20HqJf3/txHqVcmqEwwkfPUqf
	opPuMy8DFzxr3mAD57Xd8pEnNOAZ8=
X-Received: by 2002:a5d:5f90:0:b0:475:f0c2:75af with SMTP id ffacd0b85a97d-47abce83ebcmr10976609f8f.26.1783330542738;
        Mon, 06 Jul 2026 02:35:42 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm24282530f8f.25.2026.07.06.02.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:42 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 1/6] net: Add __sys_connect_socket() helper
Date: Mon,  6 Jul 2026 09:35:20 +0000
Message-Id: <20260706093525.13030-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706093525.13030-1-mahe.tardy@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
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

