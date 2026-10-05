Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE74CA79E
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213005; cv=none; b=UNsCfRCfo5sRTVwBqgYQwmJFFs5vQ/Wie+sxpPulW7876ETrei54KWIPfsg1uPdmOspqNyQBiyLRtX6+bG/zJx4RPWTYSYxNrsMPLkQsZYrDuKCy0mDusDq70JWdPl2kY728XUGbv1nkiZy4rQ3/K5f7631ni3HcmhPdkZYT4jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213005; c=relaxed/simple;
	bh=sj6IvvpiH4G5HeXtQ/w8rgZEYm6Vebo2GQ/VGeptjoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ioCNLj27J4FS3CjCxeiGUQhfvm2/36YgOIKnxqCH4AiNMVK8e1icy2KTU3bDFT8UDjMyUvT1vjU346qkhp9R20BwyXNOj9r7C1ownjyaSbfh1DyobbOfKGJcnibqbsLJtiY/4wJ4KmcVkNYWIme4WybNf/xqHRIcN8QtzfGwEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=00kxn9kE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="00kxn9kE"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8abd68b3937so16924337b3.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791212999; x=1791817799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OiZ06e1bwcFWfpqrqmzoNBYBcxZ/+ZVmZd6FQIzN/qM=;
        b=00kxn9kE3vGTHtl3bKE8JrlY8b1mc/tt6MK3NzlWUmXSjEwgMtwbmTrv8kmJf3fzEb
         U7wuDL1ptAf6j3Ea+P/peJnhnXRzK/IbPIFNVvRJEd/7PlEg/A5C1rddBp3t6UCIUKtu
         X5BFR5C8lkP2VjvAg38calf5QJD70Cb2/0mDa9xyhgRfB38NZRqbKjXVQG7ViVE+Vr8l
         62psLmdkXu1b8miz5uNvIBGibmsi+ul6v5uU6nQAwGXU5xjCLLFiWAheUkYCp/ti1wCv
         zBqd8opwdrJuDrvOUODIPx4zc+R6+VhM0qj0MV2seu/Q+wAVXyZwfYDIcTtUzcBjx+zm
         KGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212999; x=1791817799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OiZ06e1bwcFWfpqrqmzoNBYBcxZ/+ZVmZd6FQIzN/qM=;
        b=hGGjLrh25kUhUKGFkK+9sNx90+qLsqd7TfovzwxoBLgoBj8GzDZnMfjMJQ6T+kSFk2
         Q+GHZwsXU/ZStKKboUuUWWTQt12J2UHm3KSRBTD+qAuwSmqW/TvmvAXQhz7CjKnnv0s5
         gQYiDsv8oQtgGlqAZF9GmFDqKyp0VQByfOizQzcZqdXc6dXkWreSOpxBT0qa9SaonzIm
         48y9VV0fxeIo8agK8/cGoivl/SOjZ7YcA/e1d5BP+LIx2Mz+A2gU3+FjEXvDBzBp4n0h
         clkM4Wb92izTs9FXrZKPw4Icd9+H5IF2SjhE2fEcwfblPh1qdCvTJBCAHbG3eoandbEM
         AV1Q==
X-Forwarded-Encrypted: i=1; AKwUvBynSeFDkTBRh5hFRN3onUhO3lbQlxxYQznVeroiA0h4kgWCeRPKYVoP7kPbFjY7QDBWwYGhpsk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJk9iHNTTLucYHLydu+8cVeK/Qo9CnHUuQlvJDCUNSQ5kfnit2A
	IBnn/w41+sx5yLUTmzaGYDP0UnZCJjva9c0S+BF1bf5dMNZTdcMkt8kJIkbuj8axey98
X-Gm-Gg: AYBFou1dw0R+kluI7WFPNUWZh/V9HC0p+mze4nEgf9IEr8pDBedgKkI/3aX6P+09XK0
	MHoPrtmGsGF0I2EgCdUmnQsW2HaSgfmtQ92fMzbQMA6+waLKUc0MEDVfI7NSbw//SueHjPa5it2
	tq+H63CD8WsdeD1/OyFs5l++uFA90vTN3J2mZNOhnOIupqiAWHMa75FxEjeisAisN2nn+httoQQ
	tec15s5ABVvnDSyFSqJhZiQtcq8ymyN1TjgFZ5Z97GdVsGasup6o5g5espiBOdR2x8PXojz25Iv
	ucvKudL/Q8/iC+34iPccORiKFxoJviR+8OdFAQK3qDNrt5BD4pdfHn17fwZiNQXw+mevqn1UNkz
	PbuJJQMfN8JyJvMB49jkalWugDr5b+uFHYiIFcMwjBWpYnzBlpykHcogq9Q4xQp2+6ororZbO9N
	Vb+5inpBkUr28Axq2HtwMRB+PnDTRQqXsk/WKwTrhzIJJyKOi8L524MTzp0LFf5Y/78h/4VftNU
	xr4spMl/T928uW3s9aG7ZQuysJh7/zRAjGtsmBwq752Y2cTdQNkpWaq
X-Received: by 2002:a05:690c:4d49:b0:8ac:46ff:d3a5 with SMTP id 00721157ae682-8ae959d6dc1mr29681427b3.64.1791212998716;
        Mon, 05 Oct 2026 08:09:58 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:58 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 05 Oct 2026 10:09:38 -0500
Subject: [PATCH v4 08/10] selftests/net: SO_PEERPIDFD_THREAD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-work-unix-passpidfd-v4-8-350183b6e02a@amutable.com>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Eric Dumazet <edumazet@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

Add tests for SO_PEERPIDFD_THREAD.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 97 +++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index d73ae9d27a48..cbe53fab44fc 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -36,6 +36,10 @@
 #define SO_PASSPIDFD_THREAD 86
 #endif
 
+#ifndef SO_PEERPIDFD_THREAD
+#define SO_PEERPIDFD_THREAD 87
+#endif
+
 #define CHILD_EXIT_CODE_OK 123
 
 static void child_die()
@@ -1058,4 +1062,97 @@ TEST(scm_pidfd_thread_creds)
 	EXPECT_EQ(msg.ids.pid, msg.thread_info.tgid);
 }
 
+static void *peer_connect_thread(void *arg)
+{
+	struct sock_addr *sa = arg;
+	struct thread_ids ids = {
+		.pid = getpid(),
+		.tid = gettid(),
+	};
+	int fd;
+	char sync;
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		return (void *)1;
+
+	if (connect(fd, (struct sockaddr *)&sa->listen_addr, sa->addrlen))
+		return (void *)1;
+
+	if (send(fd, &ids, sizeof(ids), 0) != sizeof(ids))
+		return (void *)1;
+
+	/* stay alive until the server has looked at our pidfd */
+	if (read(fd, &sync, 1) != 1)
+		return (void *)1;
+
+	close(fd);
+	return NULL;
+}
+
+static int peer_pidfd_info(int fd, int optname, struct pidfd_info *info)
+{
+	int pidfd;
+	socklen_t len = sizeof(pidfd);
+
+	if (getsockopt(fd, SOL_SOCKET, optname, &pidfd, &len)) {
+		log_err("getsockopt(SO_PEERPIDFD*)");
+		return -1;
+	}
+
+	info->mask = PIDFD_INFO_PID;
+	if (ioctl(pidfd, PIDFD_GET_INFO, info)) {
+		log_err("ioctl(PIDFD_GET_INFO)");
+		close(pidfd);
+		return -1;
+	}
+
+	close(pidfd);
+	return 0;
+}
+
+/* SO_PEERPIDFD_THREAD returns a pidfd for the peer's connecting thread. */
+TEST(so_peerpidfd_thread)
+{
+	struct sock_addr sa;
+	struct thread_ids ids;
+	struct pidfd_info info;
+	pthread_t thread;
+	void *tret;
+	int server, cfd;
+
+	server = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, server);
+
+	fill_sockaddr(&sa, true);
+	ASSERT_EQ(0, bind(server, (struct sockaddr *)&sa.listen_addr, sa.addrlen));
+	ASSERT_EQ(0, listen(server, 1));
+
+	ASSERT_EQ(0, pthread_create(&thread, NULL, peer_connect_thread, &sa));
+
+	cfd = accept(server, NULL, NULL);
+	ASSERT_LE(0, cfd);
+
+	ASSERT_EQ(sizeof(ids), recv(cfd, &ids, sizeof(ids), MSG_WAITALL));
+	ASSERT_NE(ids.pid, ids.tid);
+
+	/* SO_PEERPIDFD refers to the peer's thread-group. */
+	ASSERT_EQ(0, peer_pidfd_info(cfd, SO_PEERPIDFD, &info));
+	EXPECT_EQ(ids.pid, info.pid);
+	EXPECT_EQ(ids.pid, info.tgid);
+
+	/* SO_PEERPIDFD_THREAD refers to the connecting thread. */
+	ASSERT_EQ(0, peer_pidfd_info(cfd, SO_PEERPIDFD_THREAD, &info));
+	EXPECT_EQ(ids.tid, info.pid);
+	EXPECT_EQ(ids.pid, info.tgid);
+
+	/* release the connecting thread */
+	ASSERT_EQ(1, write(cfd, "x", 1));
+	ASSERT_EQ(0, pthread_join(thread, &tret));
+	ASSERT_EQ(NULL, tret);
+
+	close(cfd);
+	close(server);
+}
+
 TEST_HARNESS_MAIN

-- 
2.55.0

