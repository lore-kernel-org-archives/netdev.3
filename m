Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491927;
	b=bM7jmnc4pq64E3XdoQRXVlSOPkQIZruZq1ektz7tJ6rqJvgwGHYY9naawyISPU+p1GgL
	 IcwHM/xzrL08oJguYX8aLPUz/pP4bd7ElvEWA8MO7oIfjQWRU9yl6kqV9AznlKlwIe+VM
	 +3N5AS+jOR79WMMYijiqxbNOXIOe2GpBst4Ljq+Qfx28EKFxhHr/Qakx+BnrZ7hCWOXw/
	 zcdCInNY3pNUldytBkiDiAGD6UbuYUYlKC6P3ynQFNH9ngBRznUGc52vSFc2Mcg5wE+6k
	 CUpXL369Zh8xyYntoHz/euncIOdJOqnpWTI5rRGSb5YC5y2IL9zgqHpUv6hhT7vF66w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GH4/sMbIVb/PRKafLnvsKSsgd0EUcesJyPmYbXgeZ0w=;
	b=UMm8eIy2nnHkJWQQTcOdv4rW/iPT+R8sWBaN8n3lJQvF8GLYeA8dhRma4RROcY2UZRAn
	 o9g5/FB/+A5Hvy87tWQYv+WChtOve6NOhLBqR5vch5cBaYPdBnF/1qOC3WHZJUmUWxJzh
	 1AHD6IzefyLj2FdkWMUXeo79pYYk/VbL8ilLKTjOMlvg3VusNgOMf3xTHnd6g/l7BY6WS
	 VykuGzv6Y7byPhbuVh/l8een/omdbHhMCZL4BiGOMZJmbD5/Rzz0dyafxPdxiGyUbt2b0
	 nRyTA9QTb70L9NqwilmA8wztYpwYRRnPTkisuNXsDBzxXNs/p7Xm0qEqk4rG+D44jOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RUTiVOaT;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC460A261F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86CC460A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RUTiVOaT
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so15818775e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491926; x=1793096726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GH4/sMbIVb/PRKafLnvsKSsgd0EUcesJyPmYbXgeZ0w=;
        b=RUTiVOaTa0qH1gt7f0s6XkSF1KLaWGEkwnlsTqojm+9HIK+WCSDU5Fzo7yzfc6/W5M
         L3rvFfMlzWZueI80lHlnEZ0vuIsxBPlBcCUh1gg2Uk14X3GQKx5Au+MCUeecL4V90KqN
         zG5uQNtYvmllOVErd8yNMJ5nPdmsnjEVioGa3wQLGhDEmnlbFA6xedXY2dQixr7gFt/i
         h4aKjMm8ryHDNRJaanBMxSQ85i68rQ5xzz92kDnRnTJXYRk/WnUbOmQcFIGszRorzkwc
         /CibxoZMDW2nq4uN0LEGFCNzXuSeOopRYHKbyHMNlC3dJqQUW/HnNlEfdImf8YbgCqtC
         6wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491926; x=1793096726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GH4/sMbIVb/PRKafLnvsKSsgd0EUcesJyPmYbXgeZ0w=;
        b=SABymr2K7VqYbnLHVQrLpJg+aHmSbpW5jsZTzrllk+EAH/0Unhxel8M1RLpJNFPsxv
         YNO8uTl7LgUQVHfVW6gx6gMg7AHJQhf/uTlclGWlYoJipHHXD0BQFtMTnBV0Ss1Rm/Wb
         tfBlWWCRtHaeHcOmXlymi3YIAAsiNB/DRuLVNi5DmF0mNv0vFtWCoiNJB0gLPOHRqb27
         AZSNc/RbKYq1DU8A/6pmHPMsv0okWpfDJ6/BsZk6pWqAvpzXrgEQ2nUZ1Z0aJ3nhE2AL
         8KOXUCchcy74jCpaw8pwK8+I87H1rHwW0/O8bdq/4P5SdKnXVtpQcq0Gsbu3O3K1TzWx
         BtHA==
X-Forwarded-Encrypted: i=1; AKwUvBzNAfQKVwh/FVsWV8AUN693ZufsGULrjJLj3lxslQHcfqCLaX+5pTihPJYotA5tIXLyxjXiSoU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9Rprl85SbDXxxmQYWQZ498oj4e5v38WYOnRGZNU85VdyrcZzr
	vLOCjL1xzwH85+ywBE5Ttsr2EazrfscNpEUAKvrZXSNfOtgVwDbBsP4N
X-Gm-Gg: AYBFou3NX4SxoPfexCMYArPZUykagEoQshdLbF66GSGLVNRqfl4ijEnHYhoAJF+lehi
	RJOazdxn6+4iVZenkKIYjvg1dA54yLx2KrChfpefOWaB7souf6xS8kIKl0tpy2WpRRaVaomgVR9
	abOccUwCBxHwPUJJGaZQBovzUEsNJhs6wM2+0ht0oy6JMxqcwDr9S+0Igzn0IFG1S8P44SpQtps
	nsQcp8IjprRxb7XLqVbWi741S9pNImwTQH2dqxJkn2MP8E4Fo5YVg1yUiKIHiPhjwzLMiwC7Vy6
	91YS7Po5nwcBs1jx6EJZKjQY2OoXvhsTBn7tNVYWkfwIBF5/zAIE4pAPmARButhTcSIuw+OGcMl
	Y92wHFsbrksOeL2GUCn653BlczuWcjWc7jnJ40SUvOiS0p8kmrwsYZ+YVpN/BEVLBDgrU2Wgqcr
	+N7jzVSpiqLPYpKI3uqSDhIhHoHEYdv5m8QyU4vXhxuQYxV6WyjX+xY2F6VA2yacK/eXaBVL182
	nWBYONZvTqhTaUWDxZqTauRWr3k/7gaBFwUOnoyqI5Afg==
X-Received: by 2002:a05:600c:3513:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a1d760e58fmr220948485e9.27.1792491925762;
        Tue, 20 Oct 2026 03:25:25 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:25 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 5/8] selftests/bpf: Test ksock connect/send combinations
Date: Tue, 20 Oct 2026 10:25:09 +0000
Message-ID: <20261020102512.518479-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020102512.518479-1-mahe.tardy@gmail.com>
References: <20261020102512.518479-1-mahe.tardy@gmail.com>
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

Tests more consistently that calling bpf_ksock_send() from unconnected
ksock socket fails and that bpf_ksock_connect() can be called from the
SYSCALL program creating the socket or from the LSM program also calling
bpf_ksock_send().

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  | 53 +++++++++++++++----
 tools/testing/selftests/bpf/progs/ksock_lsm.c | 32 ++++++++---
 2 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
index dd6b167623d9..78677bfffdf3 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -17,6 +17,12 @@ struct ksock_test_env {
 	int rfd;
 };

+struct ksock_test_case {
+	const char *name;
+	bool connect_in_syscall;
+	bool connect_in_lsm;
+};
+
 static bool ksock_test_env_setup(struct ksock_test_env *env)
 {
 	struct sockaddr_in addr = {
@@ -55,16 +61,18 @@ static bool ksock_test_env_setup(struct ksock_test_env *env)
 	return false;
 }

-void test_ksock_lsm(void)
+static void test_ksock_lsm_case(const struct ksock_test_case *test)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
-	struct ksock_test_env env;
 	struct sockaddr_in trigger_addr = {
 		.sin_family = AF_INET,
 		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
 	};
+	struct ksock_test_env env;
 	struct ksock_lsm *skel;
 	char recv_data[sizeof(skel->data->send_data)] = {};
+	bool connected = test->connect_in_syscall || test->connect_in_lsm;
+	int expected_send_ret = connected ? (int)sizeof(skel->data->send_data) : -EDESTADDRREQ;
 	ssize_t n;
 	int tfd = -1;
 	int err;
@@ -79,6 +87,8 @@ void test_ksock_lsm(void)
 	/* Step 1: Run the setup SYSCALL prog to create the ksock */
 	skel->bss->ipv4_remote = htonl(INADDR_LOOPBACK);
 	skel->bss->remote_port = RECV_PORT;
+	skel->bss->connect_in_syscall = test->connect_in_syscall;
+	skel->bss->connect_in_lsm = test->connect_in_lsm;
 	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_setup),
 				     &opts);
 	if (!ASSERT_OK(err, "ksock_setup run"))
@@ -103,15 +113,25 @@ void test_ksock_lsm(void)
 	if (!ASSERT_OK(err, "trigger bind"))
 		goto fail;

-	/* Step 3: Verify the LSM hook sent the notification */
-	if (!ASSERT_EQ(skel->data->send_ret, sizeof(skel->data->send_data),
-		       "LSM send bytes"))
+	/* Step 3: Verify the operations and received notification, if any. */
+	if (!ASSERT_EQ(skel->data->connect_ret, connected ? 0 : -1, "connect retval"))
+		goto fail;
+
+	if (!ASSERT_EQ(skel->data->send_ret, expected_send_ret, "LSM send retval"))
+		goto fail;
+
+	n = recvfrom(env.rfd, recv_data, sizeof(recv_data),
+		     connected ? 0 : MSG_DONTWAIT, NULL, NULL);
+	if (!connected) {
+		if (ASSERT_EQ(n, -1, "no datagram"))
+			ASSERT_EQ(errno, EAGAIN, "recvfrom errno");
 		goto fail;
+	}

-	n = recvfrom(env.rfd, recv_data, sizeof(recv_data), 0, NULL, NULL);
-	if (ASSERT_EQ(n, sizeof(recv_data), "recvfrom len"))
-		ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
-			     "payload match");
+	if (!ASSERT_EQ(n, sizeof(recv_data), "recvfrom len") ||
+	    !ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
+			  "payload match"))
+		goto fail;

 fail:
 	if (tfd >= 0)
@@ -124,6 +144,21 @@ void test_ksock_lsm(void)
 	ksock_lsm__destroy(skel);
 }

+void test_ksock_lsm(void)
+{
+	static const struct ksock_test_case tests[] = {
+		{ .name = "unconnected_send" },
+		{ .name = "syscall_connect_send", .connect_in_syscall = true },
+		{ .name = "lsm_connect_send", .connect_in_lsm = true },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (test__start_subtest(tests[i].name))
+			test_ksock_lsm_case(&tests[i]);
+	}
+}
+
 void test_ksock_lsm_verifier(void)
 {
 	RUN_TESTS(ksock_lsm_verifier);
diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm.c b/tools/testing/selftests/bpf/progs/ksock_lsm.c
index 9808451098ef..944398ce2852 100644
--- a/tools/testing/selftests/bpf/progs/ksock_lsm.c
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm.c
@@ -13,6 +13,9 @@ char send_data[32] = "hello from bpf ksock";
 __be32 ipv4_remote;
 __u16 remote_port;
 int target_pid;
+bool connect_in_syscall;
+bool connect_in_lsm;
+int connect_ret = -1;
 int send_ret = -1;

 SEC("syscall")
@@ -31,14 +34,15 @@ int ksock_setup(void *ctx)
 	if (!ks)
 		return err;

-	addr.sin.sin_family = AF_INET;
-	addr.sin.sin_port = bpf_htons(remote_port);
-	addr.sin.sin_addr.s_addr = ipv4_remote;
-
-	err = bpf_ksock_connect(ks, &addr, sizeof(addr));
-	if (err) {
-		bpf_ksock_release(ks);
-		return err;
+	if (connect_in_syscall) {
+		addr.sin.sin_family = AF_INET;
+		addr.sin.sin_port = bpf_htons(remote_port);
+		addr.sin.sin_addr.s_addr = ipv4_remote;
+		connect_ret = bpf_ksock_connect(ks, &addr, sizeof(addr));
+		if (connect_ret) {
+			bpf_ksock_release(ks);
+			return connect_ret;
+		}
 	}

 	err = ksock_ctx_insert(ks);
@@ -51,6 +55,7 @@ SEC("lsm.s/socket_bind")
 int BPF_PROG(ksock_socket_bind, struct socket *sock, struct sockaddr *address,
 	     int addrlen, int ret)
 {
+	union bpf_ksock_addr addr = {};
 	struct bpf_ksock *ks;
 	u32 pid = bpf_get_current_pid_tgid() >> 32;

@@ -63,7 +68,18 @@ int BPF_PROG(ksock_socket_bind, struct socket *sock, struct sockaddr *address,
 		return ret;
 	}

+	addr.sin.sin_family = AF_INET;
+	addr.sin.sin_port = bpf_htons(remote_port);
+	addr.sin.sin_addr.s_addr = ipv4_remote;
+
+	if (connect_in_lsm) {
+		connect_ret = bpf_ksock_connect(ks, &addr, sizeof(addr));
+		if (connect_ret)
+			goto out;
+	}
+
 	send_ret = bpf_ksock_send(ks, send_data, sizeof(send_data));
+out:
 	bpf_ksock_release(ks);

 	return ret;
--
2.43.0

