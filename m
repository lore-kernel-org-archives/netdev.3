Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2369447CC8A
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862060; cv=none; b=bzlhMNaipaeIvIYjW7mIT75Rd4nh55usTIMbsy1I9lT6WxuSrtxlAqMSasgealm5FS8VUwxYPvHkeOOjexQdIXFVqfGGnVSnynB5IAZy/l/W/kBjgo6WUOoO1UkZmCEGeQZWuUY3q2cOQboErlXjSkdHCmO/1lj2EsZXBKPhziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862060; c=relaxed/simple;
	bh=DZKWqPUe8rp0preIxSd9+SZ2NDa0Nv/CCVQVG3K6GM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVES5kAi3zXlIQDHLaIqIGhKnMcyNj3v4Gp5dD7bfgb8PWnopxgK19rTOJSjNBWHaSBoYr5FlcaWmsQk4TLBjzv3QRtGtidn1PmGelA1vAhdR5dAlKryVMHskNfQK0XIbWCz7ESPdcLGbcppq6v//WCJurTFS69HZLUoR40Kod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=day3UncB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="day3UncB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4957eefd361so175745e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862027; x=1786466827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gn/YPTWqyUKI7vml1SFF967j/xyYu4XxUNdG4z3EXqc=;
        b=day3UncBlr1B3NA5xwL2maSJLGqPs0o6kHzoG/vEhAWhoo+znKppZmNk8exhY6emfc
         ouhC61g+Z8NC0dwcsJefO205hv45uArvUTOmX28OhHCiKAJnLWXajQmwnbyof6ydKCmL
         jag4Eb65jAnmGh3W+crEd+yyx7O4fS9CEOyL2CZJwuHKIS97IzPFXRBaSWhHTykeQfUc
         wXkFVKUMf1nVYPbI9AxQi+Tf/vbmceSicE0oKVY74nARcczellTLYrxTYee6gc5+VXu9
         /izc4h/gBNVam8rSHTKT9tuaG0f9DoSgYOiMHRrd9wDknck/EcUcrsO+VpcillN4jO4m
         VoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862027; x=1786466827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gn/YPTWqyUKI7vml1SFF967j/xyYu4XxUNdG4z3EXqc=;
        b=qM2Hk4GDwmoQtzz3zddhDrSxLrPw+ZiO+aTy1QgwrHA0NbXzb3HU90WLIM+h3ijIcR
         jM4DgQYFkXJp18XyPgp8yXR9XWJQ1kQyp3NnW//coniKiRWZRoh3Lt7bXP6Klw+/0Doe
         Mi/PPHKrQKLLn0eoFFeu67juhXjqh6sXxMIjW4tztDwl+0FGNvuSAd8ayP3rAz3qimKp
         ibeMBRWbJ6Q1BpYLpRA3bCbkUbxQQlh8QaP4MO/kurnMSE6vkkxgvkPsZN9VePFzY6IL
         7u3HOnEyB86H9ZLJJR4553Adq7yMtXb0NbVLO3rpd8QTn/kN2YkwbLza25qEztseMXmJ
         QMoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBivT9QL0/Zh6r/pg+qgSFU1r5rGjdC71beqOfEmvJG58ghMCoK6NiK+xpF97oSavKJcKssfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9aVMRQ/cXrh0PhxeXCs05qL8wazURoFKnqotCUnG9MWtl6Us
	U7kYhDdSf7kd12AGYpdV9A7gC45bFQIQD3MJKDwmjPjbmpENro7L4EJDxYOHnjxaAyhs/A==
X-Gm-Gg: AR+sD12PD4EvoNKSz4FMt0ecf94kW8xbO3QgB2VVTuMv7Yzhctsc2/RGHdTV7jLpQL1
	FRNUSwyk2qd8Eb3Owp5XdaPMSoCq7uxttJ05FlF/k/V46WZ9/Rl/IU9T5KNwiDofdrruNZ+xSzc
	p3Zrm6Z44JxXdnLj9zvdXLLj1GPEJpzDmIqlzSa6Z7aF73V5fHJ/ksa5LUtCp2bYexihyIHQiJ3
	89gj4LgorJs3631ytUbPGYxKjwqXsFhIUx7QawkOTTaIP1zDnQui/SsaJYNm/5dnkopDuCFXAIn
	W/NIe+rnFAzXyBowFaM3MUAwY3d5zjPzCymPNRcfh7eJ2Gpmbwn2oyirn/+G2JY3YHZAwkKFsqj
	v0sqM78GKNNq4w5qPEF/fyLT91jvsHM2bWmJowHDqKD/yTTIJ4hK9XAes7N2H7lmKyMRhc1MrS/
	IiHhgevapS0soVdYSpYdsj7voQSTYzM/9zNkyNr2+iRddFF3BbjTX4DE1YuW/okZzey6PbSFRa/
	jlxb9jw2SQiQC24J+mV16X/w/EDifWVrA==
X-Received: by 2002:a05:600c:46ce:b0:498:ee7:e403 with SMTP id 5b1f17b1804b1-4980ee7e7dfmr289205385e9.19.1785862027104;
        Tue, 04 Aug 2026 09:47:07 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm14229485e9.15.2026.08.04.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:47:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/5] selftests/bpf: Add ksock kfunc test
Date: Tue,  4 Aug 2026 16:46:50 +0000
Message-Id: <20260804164652.296919-4-mahe.tardy@gmail.com>
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

Add a selftest that exercises the ksock kfuncs end-to-end. One syscall
bpf setup program creates a ksock context and connects the socket.
Another syscall bpf program looks up the context and send test data.
The userspace harness creates a network namespace and a new socket on
loopback, run the setup and send syscall bpf progs then check that the
userspace socket received the data from bpf.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  | 159 ++++++++++++++++++
 .../testing/selftests/bpf/progs/ksock_basic.c |  68 ++++++++
 .../selftests/bpf/progs/ksock_common.h        |  61 +++++++
 3 files changed, 288 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
new file mode 100644
index 000000000000..fb88eac9eeba
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include <arpa/inet.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "ksock_basic.skel.h"
+
+#define NS_TEST "ksock_basic_ns"
+#define LOOPBACK_IP "127.0.0.1"
+#define RECV_PORT 7777
+#define RECV_TIMEOUT_SEC 5
+
+struct ksock_test_env {
+	const char *netns;
+	bool netns_created;
+	struct nstoken *nstoken;
+	struct sockaddr_in addr;
+	int rfd;
+	char buf[32];
+};
+
+static bool ksock_test_env_setup(struct ksock_test_env *env, const char *netns)
+{
+	struct timeval tv;
+	int err;
+
+	memset(env, 0, sizeof(*env));
+	env->netns = netns;
+	env->rfd = -1;
+
+	SYS(fail, "ip netns add %s", netns);
+	env->netns_created = true;
+	SYS(fail, "ip -net %s link set lo up", netns);
+
+	env->nstoken = open_netns(netns);
+	if (!ASSERT_OK_PTR(env->nstoken, "open_netns"))
+		goto fail;
+
+	env->rfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (!ASSERT_OK_FD(env->rfd, "receiver socket"))
+		goto fail;
+
+	env->addr.sin_family = AF_INET;
+	env->addr.sin_addr.s_addr = inet_addr(LOOPBACK_IP);
+	env->addr.sin_port = htons(RECV_PORT);
+
+	err = bind(env->rfd, (struct sockaddr *)&env->addr, sizeof(env->addr));
+	if (!ASSERT_OK(err, "bind receiver"))
+		goto fail;
+
+	tv.tv_sec = RECV_TIMEOUT_SEC;
+	tv.tv_usec = 0;
+	err = setsockopt(env->rfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+	if (!ASSERT_OK(err, "set rcvtimeo"))
+		goto fail;
+
+	return true;
+
+fail:
+	if (env->rfd >= 0) {
+		close(env->rfd);
+		env->rfd = -1;
+	}
+	if (env->nstoken) {
+		close_netns(env->nstoken);
+		env->nstoken = NULL;
+	}
+	if (env->netns_created) {
+		SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", netns);
+		env->netns_created = false;
+	}
+	return false;
+}
+
+static void ksock_test_env_cleanup(struct ksock_test_env *env)
+{
+	if (env->rfd >= 0)
+		close(env->rfd);
+	if (env->nstoken)
+		close_netns(env->nstoken);
+	if (env->netns_created) {
+		SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", env->netns);
+		env->netns_created = false;
+	}
+}
+
+static void ksock_assert_recv(struct ksock_test_env *env, const char *data,
+			      size_t data_sz)
+{
+	ssize_t n;
+
+	memset(env->buf, 0, sizeof(env->buf));
+	n = recvfrom(env->rfd, env->buf, sizeof(env->buf), 0, NULL, NULL);
+	if (!ASSERT_EQ(n, data_sz, "recvfrom len"))
+		return;
+	ASSERT_MEMEQ(env->buf, data, data_sz, "payload match");
+}
+
+static bool ksock_setup_ctx(struct ksock_basic *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err, pfd;
+
+	skel->bss->ipv4_remote = inet_addr(LOOPBACK_IP);
+	skel->bss->remote_port = RECV_PORT;
+
+	pfd = bpf_program__fd(skel->progs.ksock_setup);
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "ksock_setup run"))
+		return false;
+	if (!ASSERT_OK(opts.retval, "ksock_setup retval"))
+		return false;
+
+	return true;
+}
+
+void test_ksock_basic(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ksock_test_env env;
+	struct ksock_basic *skel;
+	int err, pfd;
+
+	skel = ksock_basic__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return;
+
+	err = ksock_basic__load(skel);
+	if (!ASSERT_OK(err, "skel load")) {
+		ksock_basic__destroy(skel);
+		return;
+	}
+
+	if (!ksock_test_env_setup(&env, NS_TEST))
+		goto fail;
+
+	/* Step 1: Run the setup SYSCALL prog to create ksock */
+	if (!ksock_setup_ctx(skel))
+		goto fail;
+
+	/* Step 2: Run the send SYSCALL prog */
+	pfd = bpf_program__fd(skel->progs.ksock_send);
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "ksock_send run"))
+		goto fail;
+	if (!ASSERT_EQ(opts.retval, sizeof(skel->data->send_data),
+		       "sendmsg bytes"))
+		goto fail;
+
+	/* Step 3: Receive and verify the data */
+	ksock_assert_recv(&env, skel->data->send_data,
+			  sizeof(skel->data->send_data));
+
+fail:
+	ksock_test_env_cleanup(&env);
+	ksock_basic__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_basic.c b/tools/testing/selftests/bpf/progs/ksock_basic.c
new file mode 100644
index 000000000000..c18dcc2ea37b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_basic.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"
+#include "ksock_common.h"
+
+__be32 ipv4_remote;
+__u16 remote_port;
+
+char send_data[32] = "hello from bpf ksock";
+
+SEC("syscall")
+int ksock_setup(void *ctx)
+{
+	struct bpf_ksock_create_opts create_opts = {};
+	union bpf_ksock_addr addr = {};
+	struct bpf_ksock *ks;
+	int err = 0;
+
+	create_opts.family = AF_INET;
+	create_opts.type = SOCK_DGRAM;
+	create_opts.protocol = IPPROTO_UDP;
+
+	ks = bpf_ksock_create(&create_opts, sizeof(create_opts), &err);
+	if (!ks)
+		return err;
+
+	addr.sin.sin_family = AF_INET;
+	addr.sin.sin_port = bpf_htons(remote_port);
+	addr.sin.sin_addr.s_addr = ipv4_remote;
+
+	err = bpf_ksock_connect(ks, &addr, sizeof(addr));
+	if (err) {
+		bpf_ksock_release(ks);
+		return err;
+	}
+
+	err = ksock_ctx_insert(ks);
+	if (err && err != -EEXIST)
+		return err;
+	return 0;
+}
+
+SEC("syscall")
+int ksock_send(void *ctx)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *ks;
+	int send = -1;
+
+	v = ksock_ctx_value_lookup();
+	if (!v)
+		return -ENOENT;
+
+	ks = bpf_kptr_xchg(&v->ctx, NULL);
+	if (!ks)
+		return -ENOENT;
+
+	send = bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+	return send;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/testing/selftests/bpf/progs/ksock_common.h
new file mode 100644
index 000000000000..6e5b5b089124
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Isovalent */
+
+#ifndef _KSOCK_COMMON_H
+#define _KSOCK_COMMON_H
+
+#include "errno.h"
+#include <stdbool.h>
+
+#define SOCK_STREAM	1
+#define SOCK_DGRAM	2
+#define IPPROTO_TCP	6
+#define IPPROTO_UDP	17
+
+struct bpf_ksock *bpf_ksock_create(const struct bpf_ksock_create_opts *opts,
+				   u32 opts__sz, int *err__uninit) __ksym;
+int bpf_ksock_connect(struct bpf_ksock *ks, const union bpf_ksock_addr *addr,
+		      u32 addr__sz) __ksym;
+struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks) __ksym;
+void bpf_ksock_release(struct bpf_ksock *ks) __ksym;
+int bpf_ksock_send(struct bpf_ksock *ks, const void *data, u32 data__sz) __ksym;
+
+struct __ksock_ctx_value {
+	struct bpf_ksock __kptr * ctx;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct __ksock_ctx_value);
+	__uint(max_entries, 1);
+} __ksock_ctx_map SEC(".maps");
+
+static inline struct __ksock_ctx_value *ksock_ctx_value_lookup(void)
+{
+	u32 key = 0;
+
+	return bpf_map_lookup_elem(&__ksock_ctx_map, &key);
+}
+
+static inline int ksock_ctx_insert(struct bpf_ksock *ctx)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *old;
+
+	v = ksock_ctx_value_lookup();
+	if (!v) {
+		bpf_ksock_release(ctx);
+		return -ENOENT;
+	}
+
+	old = bpf_kptr_xchg(&v->ctx, ctx);
+	if (old) {
+		bpf_ksock_release(old);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+#endif /* _KSOCK_COMMON_H */
--
2.34.1

