Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1C48E0D8
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587670; cv=none; b=k0kurGLlapU3n/GkR3OFRpJqdFm33wMsy4/IotI6BIX1mdijJflvuWEmuLt0ZloXUZCMtiUIm2hRXqmMjEyGUM5yulVVb8Xmerukf0DGycIfzDIL4KWMvuUhVig4Om6Z6llZq+Y7yJ8WVREly1QiG+sOKA9LRepXsbmLf3W59+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587670; c=relaxed/simple;
	bh=c1qhLL0thzNwLIlM1QYszVXFAVtnDo+nY3WMBxk8jRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=regJc0y0DOS4AXlUkKLzMHMQNvg6q2KAfvs53xBFUa8JQRktWn40qa7GQvGR2HKAfgotccV8dQ9pknjq9nsmyY7r23vBlMAycG+i84CG1Lo4FQMfTekszENl6B8QFfFVJXaHHG2Bf0jKK+iSPemdQ4JRuSbDk0OKJzOBciCDh1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=zaCzK2fr; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="zaCzK2fr"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaf688ebb0so2872702a12.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790587663; x=1791192463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C1t18H5a7fnu/1Aac6tNpx9pwjEGhHPfRk234flruY8=;
        b=zaCzK2frgoD8gXPylRA1NVkeXlcGny/7NdgdJvl8KJC//CFzPuDBzf4nG6EYUttNc6
         6lphYiUWXmuvthgEfwLHXaAhdeI8lTdL9OF9Zfjv54hvtTk7xbS364cmtkJ6yoIoXjlN
         Lj7XIPYOlvrVOR+swb3kLdeu72e0FuvvyO3WQ7ehwJiQ9M/0Js35+DYPzN9FwQzd0gIS
         XYed6iFjw81CmU6mYUnV4bVM8ZYz1QI4IsFlT8A5eNXbYroDO+voSzo6mx8G2rvVa16L
         ZU7ZEven+ydINacwqcQ6cSSDxTetvQOxP+hwGu2yJZqtg07KgE6dql/8D8zp0zng8icf
         hUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587663; x=1791192463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1t18H5a7fnu/1Aac6tNpx9pwjEGhHPfRk234flruY8=;
        b=ZsbwArS/gK2/yTqqI5/P9Fs3Q7NrvBtMtXLxoxbsPIIMNjokO0wyFWcNW8wulXl53U
         FLYkABUh/iOXPp/XsBmT8A7ViF4WdE0Df8NfjyoknNV/E0nluuvF9xTz7Zgo3G1fA7Mn
         M/YE+vkSDsYsP32EaY1Y3pqGDjeLlhqgcoG5+4MaWYOw7Bo4BU88rZK2jktcApLHi+at
         w3z9XTR1JipAohdTfSxHrgjVixlQPqkvIBTWFh1Rty+meBMCqUduKjWwjZTmmUV8R91z
         zsBkeqKMY5w8dCUD80+Jbw64w8wD63w7W0lVgp/AvoeqfCWDfcxMhHboC05ZnNLwAeXg
         9ong==
X-Forwarded-Encrypted: i=1; AKwUvBxerQR/cCo90aCqARdHlvQaECWAvHjbrzv65DjnS2Ysp2YcVubEVa+b2/jNMXqCKDaZsWhGaX4=@vger.kernel.org
X-Gm-Message-State: AFuF++nINN+ra1Qi4v0JR6pruh2h3Wohu8QZzrBWvwD6Ssk9opWZ5eMZ
	YfNs1o1R2xHkzf1u7cNKzeNYlzrjvMy7Kd9lwc8dTd7rlLNiauk4fLBtWgI0dien2VJW
X-Gm-Gg: AYBFou0nPYOYUYomqpp3oc+JA/cqLkalfUhgst9oWDxJdYm8CC1XHgG6RXL1ez4EInU
	iogAUVUF8YISvnMUZkIbi4s8WVwjFFHIRKgn6vnwDkXnRZiqf27Ucrao8OSc2eU3mjLplSxmVOM
	c/FRetJsVcu5tph+tLA9Gsw2LA6xaJvdroJOXRYZm0utRmsdxmERNGef0aIpW5RuHQ+9q7by4z2
	sWCPEDHm/ZQlcCjwYImCfPPgMEP54WQ0QONx8YuoZRlkF7b/a+nmLvOZLBv0X/aPA2eVniwdqtm
	I8/H9NK6PRpYgbu6EjBKyK4mdSIf2aHrO/hUzctpt1gFO+EZAWq/3X23ErjhFesqa9yhii+UoBg
	q0RYTpbDu8K8R5nySme77JtwWplq+FDGp4i9o/5l8yAMPsQ4MPalJSg+crIXnwjC0IzgomC7Lsm
	Xf/AvZdIFtPDe6bDrgkzCLqH1um86xFEUP0ZGfBGef2t9Yjq62ZvJm7ZwAOV8VpQ9Dxc+udLWux
	h1jseIgd0/+2pJwZsHQT1uujHclUiFvdh3TaLrI/w==
X-Received: by 2002:a17:907:1c9e:b0:c29:53eb:9919 with SMTP id a640c23a62f3a-c2ac256d4f5mr1002327466b.40.1790587662789;
        Mon, 28 Sep 2026 02:27:42 -0700 (PDT)
Received: from [169.254.24.37] (tmo-085-169.customers.d1-online.com. [80.187.85.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm205609466b.1.2026.09.28.02.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:42 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 28 Sep 2026 11:27:14 +0200
Subject: [PATCH v3 07/10] net: add SO_PEERPIDFD_THREAD to get a
 thread-specific pidfd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-work-unix-passpidfd-v3-7-532018a91b21@amutable.com>
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

SO_PEERPIDFD hands out a pidfd for the thread-group that called
connect() or socketpair(). Enable workloads such as the coredump server
or a broker to get a pidfd of the specific thread that connected to the
socket.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 +
 arch/mips/include/uapi/asm/socket.h   |  2 +
 arch/parisc/include/uapi/asm/socket.h |  2 +
 arch/sparc/include/uapi/asm/socket.h  |  2 +
 include/uapi/asm-generic/socket.h     |  2 +
 net/core/sock.c                       | 87 ++++++++++++++++++++---------------
 net/unix/af_unix.c                    |  1 +
 7 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index bb3d534826bb..5d3524c26b2b 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -159,6 +159,8 @@
 
 #define SO_PASSPIDFD_THREAD    86
 
+#define SO_PEERPIDFD_THREAD    87
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 269badcaa086..245a43f52fb1 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -170,6 +170,8 @@
 
 #define SO_PASSPIDFD_THREAD    86
 
+#define SO_PEERPIDFD_THREAD    87
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 313aee10a52c..f23710e1c671 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -151,6 +151,8 @@
 
 #define SO_PASSPIDFD_THREAD	0x4054
 
+#define SO_PEERPIDFD_THREAD	0x4055
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index bd3e69bcce7a..b35b25bdefc2 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -152,6 +152,8 @@
 
 #define SO_PASSPIDFD_THREAD      0x005f
 
+#define SO_PEERPIDFD_THREAD      0x0060
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index d1e5c6de146d..56fed7ab27ab 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -154,6 +154,8 @@
 
 #define SO_PASSPIDFD_THREAD	86
 
+#define SO_PEERPIDFD_THREAD	87
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index dfe98463ad0e..c970f8beae3b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1736,6 +1736,50 @@ static int groups_to_user(sockptr_t dst, const struct group_info *src)
 	return 0;
 }
 
+/* Hand out a pidfd for @type of the socket's peer via SO_PEERPIDFD*. */
+static int sk_getsockopt_peerpidfd(struct sock *sk, enum pid_type type,
+				   sockptr_t optval, sockptr_t optlen, int len)
+{
+	struct file *pidfd_file = NULL;
+	unsigned int flags = 0;
+	struct pid *peer_pid;
+	int pidfd;
+
+	if (len > sizeof(pidfd))
+		len = sizeof(pidfd);
+
+	spin_lock(&sk->sk_peer_lock);
+	peer_pid = get_pid(sk->sk_peer_pid[type]);
+	spin_unlock(&sk->sk_peer_lock);
+
+	if (!peer_pid)
+		return -ENODATA;
+
+	/* The use of PIDFD_STALE requires stashing of struct pid on pidfs
+	 * with pidfs_register_pid() and only AF_UNIX is prepared for this.
+	 */
+	if (sk_is_unix(sk))
+		flags |= PIDFD_STALE;
+	if (type == PIDTYPE_PID)
+		flags |= PIDFD_THREAD;
+
+	pidfd = pidfd_prepare(peer_pid, flags, &pidfd_file);
+	put_pid(peer_pid);
+	if (pidfd < 0)
+		return pidfd;
+
+	if (copy_to_sockptr(optval, &pidfd, len) ||
+	    copy_to_sockptr(optlen, &len, sizeof(int))) {
+		put_unused_fd(pidfd);
+		fput(pidfd_file);
+
+		return -EFAULT;
+	}
+
+	fd_install(pidfd, pidfd_file);
+	return 0;
+}
+
 int sk_getsockopt(struct sock *sk, int level, int optname,
 		  sockptr_t optval, sockptr_t optlen)
 {
@@ -1931,45 +1975,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 	}
 
 	case SO_PEERPIDFD:
-	{
-		struct pid *peer_pid;
-		struct file *pidfd_file = NULL;
-		unsigned int flags = 0;
-		int pidfd;
+		return sk_getsockopt_peerpidfd(sk, PIDTYPE_TGID, optval, optlen, len);
 
-		if (len > sizeof(pidfd))
-			len = sizeof(pidfd);
+	case SO_PEERPIDFD_THREAD:
+		/* Only AF_UNIX records the peer's connecting thread. */
+		if (!sk_is_unix(sk))
+			return -EOPNOTSUPP;
 
-		spin_lock(&sk->sk_peer_lock);
-		peer_pid = get_pid(sk->sk_peer_pid[PIDTYPE_TGID]);
-		spin_unlock(&sk->sk_peer_lock);
-
-		if (!peer_pid)
-			return -ENODATA;
-
-		/* The use of PIDFD_STALE requires stashing of struct pid
-		 * on pidfs with pidfs_register_pid() and only AF_UNIX
-		 * were prepared for this.
-		 */
-		if (sk->sk_family == AF_UNIX)
-			flags = PIDFD_STALE;
-
-		pidfd = pidfd_prepare(peer_pid, flags, &pidfd_file);
-		put_pid(peer_pid);
-		if (pidfd < 0)
-			return pidfd;
-
-		if (copy_to_sockptr(optval, &pidfd, len) ||
-		    copy_to_sockptr(optlen, &len, sizeof(int))) {
-			put_unused_fd(pidfd);
-			fput(pidfd_file);
-
-			return -EFAULT;
-		}
-
-		fd_install(pidfd, pidfd_file);
-		return 0;
-	}
+		return sk_getsockopt_peerpidfd(sk, PIDTYPE_PID, optval, optlen, len);
 
 	case SO_PEERGROUPS:
 	{
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 634db1b40ecb..54f122952979 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1057,6 +1057,7 @@ static bool unix_bpf_bypass_getsockopt(int level, int optname)
 	if (level == SOL_SOCKET) {
 		switch (optname) {
 		case SO_PEERPIDFD:
+		case SO_PEERPIDFD_THREAD:
 			return true;
 		default:
 			return false;

-- 
2.55.0

