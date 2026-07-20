Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB93876D6
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567750; cv=none; b=Of3x6N8NKUv36ZSPM0hF+OrOxewUcNcv1U9uUjCKBAAjmB0tHMfRJUwGPQz+rlcWGEgLhKJRUM4eAguL61tPKIXHmaIGm1r9D9sRjDphGxrEAtT+BXOa3kyvF2Enh7L+fAUWDfsq42W+9SIrlE+5f8X4thgqCQiOR86znqjKTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567750; c=relaxed/simple;
	bh=64a4DlTYawvxG91ejYkDajPG8YP3qyD1+Oc+1khMMCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkDMqJClKwPfNRjcumavFprHWMG9idFN++CwG9mkYS3zY3zcZGnl0+A2mgLA1SBJU993+sqijtQkeannweWdAP/KVxTBVkkYTvwhKTwd+MVlcKX6/9PyC8Prs4LiGh0Hglsa9ojETAF6QCEEw5vYYp2g4goelckxrzoIjRBkV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T321IJkY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T321IJkY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso20352675e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784567741; x=1785172541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k1cSOK1WPe3ELJQklD1aQ2qR0lnoMm7ijOjPxD/9WX8=;
        b=T321IJkYnjYfJdKRDPhSc0HSxCUtPLaUIC6qrIzGdefGBkiGzyfG35bm1kJH1JTKTz
         FM8HqJU6meDvEGi7KVyxugv3Ov2TOXxkQWxaCYwwrVXa7EpZay4fzDM0IW1rRxOxlJnj
         Cezx7kE1U0oy1F1K9JOQoIXC8AqqmYQbl9ATN0nItwy9YhHtaA9XzL7YMkq6LaoogzRw
         FXOo5IfgN8qSnBdeLxdjM+h5RyUJutPRjuI6iSa4odZwKP625Pq8QD28J5JeFvlYLUUk
         lsDCn2BzkzC7tUUz79Y8v0UNdR9OPL7PJuUgC1F611i3dOWN84Rv2advkvWZZ7LgFt4X
         aVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567741; x=1785172541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k1cSOK1WPe3ELJQklD1aQ2qR0lnoMm7ijOjPxD/9WX8=;
        b=cdjKP3nNTtPhMpxXDxq/7hUIVave85/YBNPYznACR+G8j/xAtWC0jn2JKn1ifxfRqv
         VfAchleRA8iCfrD2VtMOYd4yYuwzJI1t/9LEO02d0BuNrnNVsn3B51jIZW1lmRKJSTap
         4A2LAq2hStH45FnB055YaHGKb3TY85k+vauyk2DNb5yXsKPxWV5Vr85FV0ehUUpkBcUf
         w03nF+3Vyctb+3YU55NEaCRM16JQfeJoQMNkGCaPRpTsmflqZX8QJhqctf4Az5hp9oU7
         S8ZMSoIejvyttSZGvc9uFa6yDlfqrW8XqzSVnoZXaie7omsT/zQKCsqd0XgHrgmxwFtx
         g8RQ==
X-Forwarded-Encrypted: i=1; AHgh+RrB1OX59rjd1IP68gCZ+ZeSIturc+rpcFrmizrEMIrd8uUWZiXbHOvSUrfH95DKVFdbTt1Y+rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytY0i7H2OXLanrjdVpgSYFtNbU9zARltjvA1KNF1XUUYIz12E0
	YqaZjBLlPC/Cl1WCeCLHC4uwACYDR8WefQYi0CMTzlNagasTaCdsiZnv
X-Gm-Gg: AfdE7cnDkeIAX0XlxvIRXwMUBWBQ3zaG2lWpFy086JHKn3kvv+t1yFK14dKF6ZIdp8a
	u6l6G7WEpcywS/y/DgujqoE8Y0suSgPytg4Cio6aGx3nqcLtSqHff/G/baF1hecJhc0XpAIzvxq
	OkSUs6togWQcNH5L/Rzy5jxng/GF6+xwCxUWZTSUbxB3LiWV4MZRWDu62Bk/tllw/S7j1bP6q6M
	lNKIZWOc2lCFOlCvPO4yC/wNSaklewIB63Rnzssr9wcsMQL7Fx/q4y0du/tvMPc4dvpNy1ZB1Jc
	rcce7t/T4UHFtvqpzWyEGPPm/Vl7iJp+DpLtWhmpPwG1Yny+0N/GeNoncZCnG/tNKvSsZbVrusZ
	Ii+hAj0yEizPssRghbmXfRQnOyqMJ4uJIFU3NR1OtJsruqMnJ+B0vXUdsj7h1LI49wMJNGNVLJC
	OPuWreLEegyhSU0Z24A4Yf5IGx0zAHwZ2yjvo8uSkxaJ++pdnIXWXLsuUm8ER0bJQEpg==
X-Received: by 2002:a05:600c:524a:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-495641abe94mr24542225e9.13.1784567741407;
        Mon, 20 Jul 2026 10:15:41 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547af7esm2304865e9.8.2026.07.20.10.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:15:40 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: nnamdio@gmail.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashiko-reviews@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] selftests/bpf: add sockmap recvfrom EAGAIN selftest
Date: Mon, 20 Jul 2026 18:15:35 +0100
Message-ID: <20260720171535.67867-3-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720171535.67867-1-nnamdio@gmail.com>
References: <20260720171535.67867-1-nnamdio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These selftests exercise the tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser()
functions, to ensure that they are properly handling spurious wakeups in
tcp_msg_wait_data().

The expected behaviour is that recvfrom() does not return an EAGAIN
error.  If the spurious wakeups are incorrectly handled, this assertion
will fail.

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711f93..d18faf46fac0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -1373,6 +1373,126 @@ static void test_sockmap_multi_channels(int sotype)
 	test_sockmap_pass_prog__destroy(skel);
 }
 
+static void *test_sockmap_recvfrom_eagain_thread(void *arg)
+{
+	int fd = *(int *)arg;
+	char buf[1024];
+	void *result = NULL;
+
+	while (true) {
+		ssize_t len = recvfrom(fd, buf, sizeof(buf), 0, NULL, NULL);
+
+		if (len == -1) {
+			if (errno == EINTR)
+				continue;
+			result = (void *)1;
+			break;
+		}
+
+		if (!len || buf[len - 1] == 'e')
+			break;
+	}
+
+	send(fd, "test", 4, MSG_NOSIGNAL);
+
+	close(fd);
+
+	return result;
+}
+
+static void test_sockmap_recvfrom_eagain(bool with_verdict)
+{
+	struct test_sockmap_pass_prog *skel = NULL;
+	struct bpf_program *prog = NULL;
+	size_t buflen = 1024 * 1024 * 25;
+	char *buf = NULL;
+	int map, err;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	map = bpf_map__fd(skel->maps.sock_map_msg);
+
+	if (with_verdict) {
+		prog = skel->progs.prog_skb_verdict;
+		err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT, 0);
+		if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
+			goto cleanup;
+	}
+
+	buf = malloc(buflen);
+	if (!ASSERT_OK_PTR(buf, "malloc buf"))
+		goto cleanup;
+	memset(buf, 0, buflen);
+	buf[buflen - 1] = 'e';
+
+	for (int i = 0; i < 200; ++i) {
+		ssize_t sent;
+		char ignored[128];
+		pthread_t thread;
+		bool thread_created = false;
+		size_t rem = buflen;
+		int c = -1, p = -1, zero = 0;
+		bool success = false;
+
+		err = create_pair(AF_INET, SOCK_STREAM, &c, &p);
+		if (!ASSERT_OK(err, "create_pair"))
+			goto end_attempt;
+
+		err = pthread_create(&thread, NULL, &test_sockmap_recvfrom_eagain_thread, &p);
+		if (!ASSERT_OK(err, "pthread_create"))
+			goto end_attempt;
+		thread_created = true;
+
+		err = bpf_map_update_elem(map, &zero, &c, BPF_ANY);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto end_attempt;
+
+		while (rem) {
+			sent = xsend(c, buf + (buflen - rem), rem, 0);
+			if (sent == -1)
+				goto end_attempt;
+			rem -= sent;
+		}
+
+		/* we cannot use recv_timeout(), otherwise EAGAIN would be an expected errno. */
+		err = recvfrom(c, ignored, sizeof(ignored), 0, NULL, NULL);
+
+		/*
+		 * we are checking for the invalid return of EAGAIN, any other return is considered
+		 * successful for the purposes of this test.
+		 */
+		if (err < 0 && !ASSERT_NEQ(errno, EAGAIN, "recvfrom eagain"))
+			goto end_attempt;
+
+		success = true;
+
+end_attempt:
+		if (c >= 0)
+			close(c);
+
+		if (thread_created) {
+			void *retval = NULL;
+
+			pthread_join(thread, &retval);
+			if (!ASSERT_NULL(retval, "retval"))
+				success = false;
+		}
+
+		if (!thread_created && p >= 0)
+			close(p);
+		if (!success)
+			break;
+	}
+
+cleanup:
+	if (buf)
+		free(buf);
+
+	test_sockmap_pass_prog__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -1451,4 +1571,8 @@ void test_sockmap_basic(void)
 		test_sockmap_multi_channels(SOCK_STREAM);
 	if (test__start_subtest("sockmap udp multi channels"))
 		test_sockmap_multi_channels(SOCK_DGRAM);
+	if (test__start_subtest("sockmap recvfrom eagain"))
+		test_sockmap_recvfrom_eagain(false);
+	if (test__start_subtest("sockmap recvfrom eagain with verdict"))
+		test_sockmap_recvfrom_eagain(true);
 }
-- 
2.52.0

