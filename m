Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A536606D820
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 05:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A536606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e3Isvyj2
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so147025a91.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 21:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793942399; x=1794547199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6AmEohuqIdfwDgu3Ty8WU1x3cRaQS/VCTm4XZLnhyw=;
        b=e3Isvyj2iNfcI/gjc89pfMfA3BSuHRJcNhLCNdhxsWza5gY2VzVaENk76+lg2aVfT0
         uv919mtesNeQKFgpozO9cVKUXi5j0dBW0Eyf4s89sfavgX1d6Olclb664Le3brAzZKcV
         vpCTCj1vtl1CNJF8Girkap2DNanxglS/OrfqoGaXMwltDg4JMEi+Kjt3/2dItWULMmfQ
         H5YhsCboP3CXWLrG1sZwo24SB8PBC4xDoFBBhey5OdNjFDLbDczPwqxhqE5d0+u/8z1G
         KTAkCDYXyX6OOr+b1UYkm8KAXRL50WKcSfe5IkK8KwD89ZjfNuJZFwwzCOouCAURmCpL
         8DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793942399; x=1794547199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s6AmEohuqIdfwDgu3Ty8WU1x3cRaQS/VCTm4XZLnhyw=;
        b=05QuwPTpnqTEoWo5r4S+cwLu8w1YJ5oDUTunVupWNSvzqtu/+wUm60Q6vGK9TVrlDG
         KkueJd0k4yPfRGpo80KkszJUjEDSL1k/2KxV20S6dTuD5gsgnmCEMCMD7CX0cZmJjDrJ
         xNbhUEa8/nzo960OvWquxavIjsFkHOae0wuJUOJ55JA6LF/q8chGKvxY17oo4MuAjPlI
         mioAF+v8wnJubW+VbK+FY4vruTBSbWBWV12LNEvgbbs1nVD5O8yrldtRB+KRFZ0dtUNZ
         Yxc/cdtC03Q/ULznqN1GibDIUgWCDiPMOnhMBgC4VnOlY2GCnbsoEbZhAjNCoCyHEE4f
         GenQ==
X-Forwarded-Encrypted: i=1; AL+hErG57tfsbYUfn1P8DvRqdUs0vcMQ//kuB18bfqAutNj8kkcm8AgAwKnPMKJbbGHimQDvMaGvkLc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+p2Qk/xe0vja5CtNKNfnWbxlT7AI3FWeYlzHQFhmuF2mSFKlHh
	r4Zd0kR/vB83y2RKcieRlrUN12qZkvX2nl4XBNWUmYSOEOfaKMcq9mO1
X-Gm-Gg: AYBFou3zOHejb9dWSwC9VM29gioTSQnRzamJ5PR+xwg0pYHo8ezwIxA9Pjl8gBBP7OF
	z+/etBIqYryfB233we8FUbGTNpN0bO9xqIABRl2394TkouZ4NnQYJ3oYWJ25j60x6Z+ViwMa3+2
	G2E4odsjl7W2F2BJjTDGw1vpW0cSkk2Nh1T1tz83IibysNQElYBLZKgWZ++PPQokGR+3D7Sp8Ow
	SVpcGMPvHcj8w87xTVbi/MXHulMRs1/mw4xTPmqQqSLhY6hmh6sOUtAnO0ID1crVVTnki/TSGoL
	A2L+B3DSQBuPN2IVGb7wXVseGodGbds+7UQrDbsli4cYVZ5dqdzYwqDSMO47f7kY5rQlFiecmYZ
	064ZbwKiuXNTQzf99ZVLdUD1tbelXofz4t5+LpBYggxhQUekLfK2XNRwbyLEBEcGIdQuRYRKeyZ
	nbUqsh3glvc3FPHtWMp1RQM4ZAulOiTi0tEmRWRBp24VU98s8H+gRpIY/Asrn/wNr4bV+wMgWMo
	kka+mLRz0SLUtkYee3iz9QAVTUYYh6cwqJwosEHqUCezgwnM3qpgYG42seZKQp6mgtd3eKEefKX
	ayUFWAnK97Ujg/OiQAM/son4MlmDNbFjxavoJPzzeTfzGqAVaQ6/Ju9F0L2KOgg0zSGiw78tyuC
	s4VOtnc1fnyWsmAaW0X3C8WOH38jbWeV67CelZeAWBSTDK/czVXzosGVlKpwrQINKCFPjUKBF2n
	VLrZaVBpBgmswBoHUbQfgNXqkN15we03lRhbIDJATUPF2lQuaWssoVf/MsHJd29g==
X-Received: by 2002:a17:90b:3889:b0:3ac:aa8d:19f2 with SMTP id 98e67ed59e1d1-3b0db7232edmr1311891a91.62.1793942398683;
        Thu, 05 Nov 2026 21:19:58 -0800 (PST)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d7bd2esm1594465ad.56.2026.11.05.21.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 21:19:58 -0800 (PST)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jann Horn <jannh@google.com>,
	Kirill Tkhai <tkhai@ya.ru>,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH net 4/4] selftest: af_unix: Test SIOCINQ and scm_fds with OOB and dgram disconnect.
Date: Fri,  6 Nov 2026 05:19:05 +0000
Message-ID: <20261106051905.218638-5-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106051905.218638-1-sidchintamaneni@gmail.com>
References: <20261106051905.218638-1-sidchintamaneni@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify in msg_oob's __resetpair() that ioctl(SIOCINQ) reports 0 unread
bytes after draining the stream receive queue, and add oob_fdinfo and
dgram_disconnect_fdinfo tests in scm_rights.c verifying that
/proc/self/fdinfo/<fd> (scm_fds) returns to 0 when OOB skbs carrying
SCM_RIGHTS are skipped or freed and when a dgram socket disconnects with
queued SCM_RIGHTS skbs.

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c |  12 +-
 .../selftests/net/af_unix/scm_rights.c        | 108 ++++++++++++++++++
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index f051d79f7a8e..7d5a25485048 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <unistd.h>
 
+#include <linux/sockios.h>
 #include <netinet/in.h>
 #include <sys/epoll.h>
 #include <sys/ioctl.h>
@@ -336,8 +337,17 @@ static void __resetpair(struct __test_metadata *_metadata,
 {
 	int i;
 
-	for (i = 0; i < 2; i++)
+	for (i = 0; i < 2; i++) {
+		if (!reset) {
+			int inq, ret;
+
+			ret = ioctl(self->fd[i * 2 + 1], SIOCINQ, &inq);
+			ASSERT_EQ(ret, 0);
+			ASSERT_EQ(inq, 0);
+		}
+
 		close(self->fd[i * 2 + 1]);
+	}
 
 	__recvpair(_metadata, self, "", reset ? -ECONNRESET : 0, 1,
 		   variant->peek ? MSG_PEEK : 0, true);
diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index c165f250220a..38a125d9f6e4 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -378,6 +378,36 @@ TEST_F(scm_rights, backtrack_from_scc)
 	close_sockets(10);
 }
 
+static int count_scm_fds(struct __test_metadata *_metadata, int fd)
+{
+	char path[64], *line = NULL;
+	int scm_fds = -1, ret;
+	size_t unused;
+	FILE *f;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", fd);
+
+	f = fopen(path, "r");
+	ASSERT_NE(NULL, f);
+
+	while (getline(&line, &unused, f) != -1) {
+		if (strncmp(line, "scm_fds:", 8))
+			continue;
+
+		ret = sscanf(line + 8, "%d", &scm_fds);
+		ASSERT_EQ(1, ret);
+
+		break;
+	}
+
+	free(line);
+
+	ret = fclose(f);
+	ASSERT_EQ(0, ret);
+
+	return scm_fds;
+}
+
 TEST_F(scm_rights, mixed_lowpoint)
 {
 	create_sockets(6);
@@ -395,4 +425,82 @@ TEST_F(scm_rights, mixed_lowpoint)
 	close_sockets(6);
 }
 
+TEST_F(scm_rights, oob_fdinfo)
+{
+	int recv_fd, ret;
+	char buf[2];
+
+	if (!(variant->flags & MSG_OOB) || variant->disabled)
+		return;
+
+	create_sockets(2);
+
+	if (variant->test_listener) {
+		recv_fd = accept(self->fd[0], NULL, NULL);
+		ASSERT_LE(0, recv_fd);
+	} else {
+		recv_fd = self->fd[0];
+	}
+
+	/* 1. Unconsumed OOB skb skipped by normal recv() in manage_oob() */
+	send_fd(0, 0);
+	ASSERT_EQ(2, count_scm_fds(_metadata, recv_fd));
+	ret = send(self->fd[1], "a", 1, 0);
+	ASSERT_EQ(1, ret);
+	ret = recv(recv_fd, buf, 1, 0);
+	ASSERT_EQ(1, ret);
+	ASSERT_EQ(0, count_scm_fds(_metadata, recv_fd));
+
+	/* 2. Consumed OOB skb freed by normal recv() in manage_oob() */
+	send_fd(0, 0);
+	ASSERT_EQ(2, count_scm_fds(_metadata, recv_fd));
+	ret = recv(recv_fd, buf, 1, MSG_OOB);
+	ASSERT_EQ(1, ret);
+	ret = send(self->fd[1], "a", 1, 0);
+	ASSERT_EQ(1, ret);
+	ret = recv(recv_fd, buf, 1, 0);
+	ASSERT_EQ(1, ret);
+	ASSERT_EQ(0, count_scm_fds(_metadata, recv_fd));
+
+	/* 3. Consumed OOB skb freed by consecutive recv(MSG_OOB) */
+	send_fd(0, 0);
+	ASSERT_EQ(2, count_scm_fds(_metadata, recv_fd));
+	ret = recv(recv_fd, buf, 1, MSG_OOB);
+	ASSERT_EQ(1, ret);
+	ret = send(self->fd[1], "y", 1, MSG_OOB);
+	ASSERT_EQ(1, ret);
+	ret = recv(recv_fd, buf, 1, MSG_OOB);
+	ASSERT_EQ(1, ret);
+	ASSERT_EQ(0, count_scm_fds(_metadata, recv_fd));
+
+	if (variant->test_listener) {
+		ret = close(recv_fd);
+		ASSERT_EQ(0, ret);
+	}
+
+	close_sockets(2);
+}
+
+TEST_F(scm_rights, dgram_disconnect_fdinfo)
+{
+	struct sockaddr addr = {
+		.sa_family = AF_UNSPEC,
+	};
+	int ret;
+
+	if (variant->type != SOCK_DGRAM || variant->disabled)
+		return;
+
+	create_sockets(2);
+
+	send_fd(0, 0);
+	ASSERT_EQ(2, count_scm_fds(_metadata, self->fd[0]));
+
+	ret = connect(self->fd[0], &addr, sizeof(addr.sa_family));
+	ASSERT_EQ(0, ret);
+	ASSERT_EQ(0, count_scm_fds(_metadata, self->fd[0]));
+
+	close_sockets(2);
+}
+
 TEST_HARNESS_MAIN
-- 
2.43.0

