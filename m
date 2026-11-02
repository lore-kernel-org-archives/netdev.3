Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661175;
	b=CnEvswg3lujfP+wJeA3jY8ccVLjESJaJUET6v2DAq5aD2NDgZ+mJJBMNXx8OO8q+u4jy
	 O7rt9sZqHt7YX7FVEMTrN3K9900AZPAF/RRipyvIBkfbr2anJ/C3BSFTNRBubIqMRriRA
	 S5jVQyH+1bPrK23FCJYV3hNmP/Eegm1pmtZSd/gL6KpXjFQqVPwhKRdDMp1uIfvMferO6
	 6S/irtiH0ToTElg7EOtEhe5eMZvMoMXd9e6kdQ60U35axvvQMszfDWYr7WP1aQkecDjCG
	 KwCEQCC1l2Rqz/uvdqgqvr25Stbs9N6oobkGlOiiGmEiiYdo8bpJNNirE0vHwvjtF6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=OXN/npWsGuscMDKYzwQyqKyh6TSWjmZFiWK4TeHONjs=;
	b=nG7MqdI/zxVHe81ig/0q7u0WdP+T+v+2f5f+/ORRoWNyvFlb/Iq9T2lN/nOzSqVqjbWG
	 CNCiheavtftCHbFw55JvoR6dZc1eOkQ0TD/021Mqp9yZtF3GckmVLEz/5F7ap36c4ZrZA
	 l6JYMtnMGiJlIl60sAKlxF65JeDKHjHYa1tgHjLm5+oPyYGXCuneUjGtJ8txNk4czwnOM
	 bSsrmzY3TwD0Sy1fmhIBL24u7AgTGffdArDn0QglMW7+mXGBONxlv3iypAWiOBrzgjw2j
	 YCcrHQsGBiva2Q2vNPg6ZlmrXPuC6Ig7vImFAFuWTB5o12f7xSafL6bBtF6BkDFBbww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GuCtLrDd;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D141606D82C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D141606D82C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GuCtLrDd
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6798eb0d190so2503844d50.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1793661174; x=1794265974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXN/npWsGuscMDKYzwQyqKyh6TSWjmZFiWK4TeHONjs=;
        b=GuCtLrDdKx7WZqs6WOcKxAJeztLkuF4NCrr7VlX4Jhge7qBvmkIigLqpaIll3VC8Sn
         8Zmr/IJmoKc381jPHIBvLZn/invWMntUi/ZAJ+ao8q2+6gwUAGTHSYuvxT5h78kLv2Pm
         UcSw3SWWKxuplvPna5N06aDFoS+1PdJLxRYplIr2VBI3N7f/gd3dMLe+EVtzolbn1A7B
         w4NLgZ8gaoqBgQ+0wwmZmszEA6lLqvFrb+U9J76fSN7BgrwehR3702+IegtTEd0UFX+d
         6jiO+hvJlPKRrXNw+I78EBpD2hqMKz+2mh8z36VqzqlfXsuHs6ELm0fPoLq1MLEBqI8n
         d50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661174; x=1794265974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OXN/npWsGuscMDKYzwQyqKyh6TSWjmZFiWK4TeHONjs=;
        b=hgSv5WvDuMQqrIpXQqaw7t6sLh1oIqXQP4LH4S2lgRA1FGsw/iofry77uid9TiHqOW
         LhpNfcg3Q8TQty/J3aSprlYbVeh71YsNhf4+4ylbzplMJi/uEmdbIF/0tpdzk7gv7d6/
         Uf7+uGTfcFzLAkt07ODQn3oP+Q4ZI8U7Sj6eQRtjXhVWQPlLyJWOH68ZBFGNeZRv+hqY
         YEVzgBxmSAUvS+wm/L9BdUbPzNpXKzexKyV08zTZK00KsIF+eMkGOnLMVVtYJXd5BT+k
         eDPxAY1qAuUvRd1pwh2Adxi6IPhVEDwBjtq75+6z+7fX6XadjXH0jZ7wCQhSpolpRprI
         oDrQ==
X-Gm-Message-State: APuU4Z8S5iET2nbFcyiizR84De3PWsEbNXnbU1JuXYxx/j0FZ4+Qwo2j
	wCjqxbSlkIa5ugz+4opzj22vOf2SSuvzgN2DDzWVW/V4cG7RZBbQEMxcC5YkRzKLVk7e
X-Gm-Gg: AYBFou0wTfUZZSFW3zuhM1bksiANRhbs5meXDDsR66TTl+J3ydOqmKTkJrlCPR8grHI
	VibzyNxpP6Po/vKpWHNab6g6tI9xbI5lA2aUbybrkgWmoUNduNTD4dc9aQfu64+IPGI2f8jeCjK
	vE/jeqmlTNNiLoE/8JhJR9shcVRr7IXp3dkq6cRTAK8paAJonO8ygwotCR05dXzP5BP/559cQfv
	5ZGMOD5vzA67y7wZ742q+/1kjeCupWB6+bfY8HVGVnxxvzJClEJTjtutv9bSXZZA//NjUABBkdb
	tIT4o/ARKOh1TU9QWGMlXIqjc4iMSAs7zfUMZHofT9WOiP8WOj/QFKY+mpdn7xIfOR6Rvm7PZ0L
	w9ff3OtGP8UA3hioBTed5Ml/6s8bVa3tVgZrULyDrYPG3rrLP5FsrlLC4wUqqJ9QVTFXIpEyQxq
	xYnjfgWf9h+S5a48G+dp9dX0fRnJ7HKXck0DzZ5DmkaMgSEhTu0g6uBY0whRwRJKDSvSl6pTdLb
	aaAYN2oTIep3IR2NnvL97pG8gdQ3wMv4D6+6qFIGBrKYvYRIqaAnxobXOT8bZ0kVSoFVPgdsMHk
	tw7tmErssm6LwIlG0hTVLj8tg2LjcSuPaYq4+MbrgJOGhrZs4CRXGZ/LBiPmM7TFoQPqS1jOcvj
	oopYjTKUyog==
X-Received: by 2002:a53:da06:0:b0:679:b50e:9a with SMTP id 956f58d0204a3-67ba5114fb5mr6079051d50.108.1793661173861;
        Mon, 02 Nov 2026 15:12:53 -0800 (PST)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf3303ebsm5946481d50.18.2026.11.02.15.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:12:53 -0800 (PST)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 02 Nov 2026 17:12:36 -0600
Subject: [PATCH net-next 3/3] selftests/net: Add tests for
 SO_PASSCRED_THREAD
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-halaney-scm-creds-thread-v1-3-0b4d75dbf35f@amutable.com>
References: <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com>
In-Reply-To: <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>, 
 Willem de Bruijn <willemb@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
 Andrew Halaney <andrew@amutable.com>
X-Mailer: b4 0.14.3

Add SO_PASSCRED_THREAD tests to the af_unix scm_pidfd selftests.

Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 160 +++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index 7524f3f6a8aa..75387ede1eeb 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -40,6 +40,14 @@
 #define SO_PEERPIDFD_THREAD 87
 #endif
 
+#ifndef SO_PASSCRED_THREAD
+#define SO_PASSCRED_THREAD 88
+#endif
+
+#ifndef SCM_CREDENTIALS_THREAD
+#define SCM_CREDENTIALS_THREAD 0x06
+#endif
+
 #define CHILD_EXIT_CODE_OK 123
 
 static void child_die()
@@ -689,6 +697,10 @@ struct pidfd_msg {
 	int thread_flags;
 	bool have_tgid;
 	bool have_thread;
+	struct ucred creds;
+	struct ucred thread_creds;
+	bool have_creds;
+	bool have_thread_creds;
 };
 
 static int get_pidfd_info(int pidfd, struct pidfd_info *info)
@@ -703,11 +715,12 @@ static int get_pidfd_info(int pidfd, struct pidfd_info *info)
 }
 
 /* One recvmsg(), reporting how many bytes came back and what the pidfd
- * cmsgs that came with them say.
+ * and credentials cmsgs that came with them say.
  */
 static int read_pidfd_msg(int fd, struct pidfd_msg *out)
 {
-	char control[CMSG_SPACE(sizeof(int)) * 2] = { 0 };
+	char control[CMSG_SPACE(sizeof(int)) * 2 +
+		     CMSG_SPACE(sizeof(struct ucred)) * 2] = { 0 };
 	int tgid_pidfd = -1, thread_pidfd = -1;
 	struct thread_ids buf[2] = { 0 };
 	struct msghdr msg = { 0 };
@@ -739,10 +752,18 @@ static int read_pidfd_msg(int fd, struct pidfd_msg *out)
 		if (cmsg->cmsg_level != SOL_SOCKET)
 			continue;
 
-		if (cmsg->cmsg_type == SCM_PIDFD)
+		if (cmsg->cmsg_type == SCM_PIDFD) {
 			memcpy(&tgid_pidfd, CMSG_DATA(cmsg), sizeof(tgid_pidfd));
-		else if (cmsg->cmsg_type == SCM_PIDFD_THREAD)
+		} else if (cmsg->cmsg_type == SCM_PIDFD_THREAD) {
 			memcpy(&thread_pidfd, CMSG_DATA(cmsg), sizeof(thread_pidfd));
+		} else if (cmsg->cmsg_type == SCM_CREDENTIALS) {
+			memcpy(&out->creds, CMSG_DATA(cmsg), sizeof(out->creds));
+			out->have_creds = true;
+		} else if (cmsg->cmsg_type == SCM_CREDENTIALS_THREAD) {
+			memcpy(&out->thread_creds, CMSG_DATA(cmsg),
+			       sizeof(out->thread_creds));
+			out->have_thread_creds = true;
+		}
 	}
 
 	out->have_tgid = tgid_pidfd >= 0;
@@ -769,6 +790,9 @@ static int read_pidfd_msg(int fd, struct pidfd_msg *out)
 static const int pass_tgid[] = { SO_PASSPIDFD, 0 };
 static const int pass_thread[] = { SO_PASSPIDFD_THREAD, 0 };
 static const int pass_both[] = { SO_PASSPIDFD, SO_PASSPIDFD_THREAD, 0 };
+static const int creds_tgid[] = { SO_PASSCRED, 0 };
+static const int creds_thread[] = { SO_PASSCRED_THREAD, 0 };
+static const int creds_both[] = { SO_PASSCRED, SO_PASSCRED_THREAD, 0 };
 
 static int set_opts(int fd, const int *opts)
 {
@@ -1061,6 +1085,134 @@ TEST(scm_pidfd_thread_creds)
 	EXPECT_EQ(msg.ids.pid, msg.thread_info.tgid);
 }
 
+TEST(scm_creds_thread_setsockopt_values)
+{
+	int sk[2];
+	int inet;
+
+	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM, 0, sk));
+
+	/* Verify that the options are truly set independently */
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSCRED_THREAD, 1));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSCRED_THREAD));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSCRED));
+
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSCRED, 1));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSCRED));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSCRED_THREAD));
+
+	/* Verify that the options are truly cleared independently */
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSCRED, 0));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSCRED));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSCRED_THREAD));
+
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSCRED_THREAD, 0));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSCRED_THREAD));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSCRED));
+
+	close(sk[0]);
+	close(sk[1]);
+
+	/* Only AF_UNIX records the sending thread */
+	inet = socket(AF_INET, SOCK_DGRAM, 0);
+	ASSERT_LE(0, inet);
+	EXPECT_EQ(-1, sockopt_set(inet, SO_PASSCRED_THREAD, 1));
+	EXPECT_EQ(EOPNOTSUPP, errno);
+	close(inet);
+}
+
+/* A receiver that only asked about the process cannot tell the two
+ * threads apart, so their writes are glued into one read.
+ */
+TEST(scm_creds_stream_glues_threads)
+{
+	struct pidfd_msg msg[1] = { 0 };
+
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 2, creds_tgid, msg, 1));
+	EXPECT_EQ(sizeof(struct thread_ids) * 2, msg[0].len);
+
+	EXPECT_TRUE(msg[0].have_creds);
+	EXPECT_FALSE(msg[0].have_thread_creds);
+	EXPECT_EQ(msg[0].ids.pid, msg[0].creds.pid);
+}
+
+/* SO_PASSCRED_THREAD on its own is enough to split a stream per thread */
+TEST(scm_creds_thread_stream_splits_on_threads)
+{
+	struct pidfd_msg msg[2] = { 0 };
+	int i;
+
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 2, creds_thread, msg, 2));
+
+	for (i = 0; i < 2; i++) {
+		EXPECT_EQ(sizeof(struct thread_ids), msg[i].len);
+		EXPECT_FALSE(msg[i].have_creds);
+		EXPECT_TRUE(msg[i].have_thread_creds);
+		EXPECT_NE(msg[i].ids.pid, msg[i].ids.tid);
+		EXPECT_EQ(msg[i].ids.tid, msg[i].thread_creds.pid);
+	}
+
+	/* Make sure we really got unique threads per message */
+	EXPECT_NE(msg[0].thread_creds.pid, msg[1].thread_creds.pid);
+}
+
+TEST(scm_creds_thread_leader_sender)
+{
+	struct pidfd_msg msg = { 0 };
+
+	ASSERT_EQ(getpid(), gettid());
+
+	ASSERT_EQ(0, leader_flow(creds_both, &msg));
+	ASSERT_TRUE(msg.have_creds);
+	ASSERT_TRUE(msg.have_thread_creds);
+
+	EXPECT_EQ(getpid(), msg.creds.pid);
+	EXPECT_EQ(getpid(), msg.thread_creds.pid);
+}
+
+TEST(scm_creds_thread_and_group)
+{
+	struct pidfd_msg msg = { 0 };
+
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 1, creds_both, &msg, 1));
+	ASSERT_NE(msg.ids.pid, msg.ids.tid);
+	ASSERT_TRUE(msg.have_creds);
+	ASSERT_TRUE(msg.have_thread_creds);
+
+	EXPECT_EQ(msg.ids.pid, msg.creds.pid);
+	EXPECT_EQ(msg.ids.tid, msg.thread_creds.pid);
+	EXPECT_EQ(msg.creds.uid, msg.thread_creds.uid);
+	EXPECT_EQ(msg.creds.gid, msg.thread_creds.gid);
+}
+
+TEST(scm_creds_thread)
+{
+	struct pidfd_msg msg = { 0 };
+
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 1, creds_thread, &msg, 1));
+	ASSERT_NE(msg.ids.pid, msg.ids.tid);
+	ASSERT_TRUE(msg.have_thread_creds);
+	EXPECT_FALSE(msg.have_creds);
+
+	EXPECT_EQ(msg.ids.tid, msg.thread_creds.pid);
+	EXPECT_EQ(getuid(), msg.thread_creds.uid);
+	EXPECT_EQ(getgid(), msg.thread_creds.gid);
+}
+
+/* A sender passing its own SCM_CREDENTIALS still reports the sending thread */
+TEST(scm_creds_thread_explicit_creds)
+{
+	struct pidfd_msg msg = { 0 };
+
+	ASSERT_EQ(0, pidfd_flow(send_ids_creds_thread, 1, creds_both, &msg, 1));
+	ASSERT_NE(msg.ids.pid, msg.ids.tid);
+	ASSERT_TRUE(msg.have_creds);
+	ASSERT_TRUE(msg.have_thread_creds);
+
+	EXPECT_EQ(msg.ids.pid, msg.creds.pid);
+	EXPECT_EQ(msg.ids.tid, msg.thread_creds.pid);
+}
+
 static void *peer_connect_thread(void *arg)
 {
 	struct sock_addr *sa = arg;

-- 
2.56.0

