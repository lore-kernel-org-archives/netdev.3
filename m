Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396747DD59
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862056; cv=none; b=ewWapPmOo2/ynwbaTatRTBwXoG0vdjIQMjxEARdoUsfIjuNdzYX5sWnUhjdwn7ZAnGmOyxhm/YGFr3c5vrcyDl9mLKvN/vSzF2vQSCjN9GHUnAv955mqVpaBqx3FEtu2czcbnjQRGY6/QqPNUmSFg4hxutT8LXyvEVZox1fN7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862056; c=relaxed/simple;
	bh=ojY6Dh7yMl9GCMp2bZnbWPy2aSUPq0NSJIxL3y9bqZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=byUuRfQThDaaAoDsApO4OaxxckTosB3a8x3Vc4YVfom8vg03SWEBhH6chkS87DfwJZu/LzhMR004CARgIU1nQ1myAAWS/4bwUBr6r+A0UJJ1YpYIFkzi5NejEops+w6RacxFH2YGG7ms/wHY05vtshbtecqMYkni/0AI+yArocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A55P6NS8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A55P6NS8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4957eefd361so175835e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862028; x=1786466828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YhA+OOHPkGBSEYFG6bn6igO7JPukJH9I40t3scHtbE4=;
        b=A55P6NS8vHwN2xWiXnU+drBjTICS/hcNS007OMSLLUziuS0QTm72bT27vlx9mh0LFL
         GPSBfP1cwJHuGUjYS27NrpJhRKnRvKylCuyYUkLxQOQ1ekNuIYd72HO068QZemv0zHUZ
         HBMx389Cm26VrpO3B7t4xYM80tz5H3/rpW+XdrBV+3DqeOjnFLcIDe1E2N6pEJo1poQF
         nXanVX55y690g5fB+nT63aU+gTKFRC67VoH2fXMipHNH55rusE1DjC8M7PoycXfknWYJ
         P1bfKMG3scBz6ndXuNwMrJQ7T3EUc52ENBCuirjtp+jpsOFoG5Y6rg/RdBI+TdEfTE0g
         ve1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862028; x=1786466828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YhA+OOHPkGBSEYFG6bn6igO7JPukJH9I40t3scHtbE4=;
        b=IRLS/VCTaGKAXnogyQp/kUlFotklehauf2ZWhmlde1gKOz8RGlgqeMoNQQIgZlWHfY
         O+6F/nvCxvsSBZ2KdpkSGakYyoXkNfGQD2XsuKfqQfGPeIXQ/TJobkeHLdAjA/Qmm3Xf
         H0wbDFCQz7n0o7cefaEis9Rh2UfGzm2Xpk36sQZHN5ThPfQ5q7DNuJPboBjAw7zrAhKt
         UKNJka2Xqq+kHfox++33uO8XLyJwkcFOqxNMMKC0ahiiPnEv9ummhCAkmQk88wy8J/uS
         xFFVwINxZPAb8Lqp+ExPnX6M2PlikUrvlWpLxxxJ/cyoTuzgN1IeLqJKuS0XoPMMuFAO
         QCuw==
X-Forwarded-Encrypted: i=1; AHgh+Rr6eKcMGFhqNBre9dI7aLIgw/STDr91eupvBOpMay10/1SyDSJ185+ap02aJVMzWfw3AZpvvmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUhymjvKdbp6jFOIMDbELbFtoZuW26r5ZOnrrBcIX0kJJYLo0
	npYdwcgBjSdDo280yrxnA1UtvvOebZHdFmtgxat3w7H1NsRC8Ri/VRcl
X-Gm-Gg: AR+sD12uIP8gFOKGqPkpmcz/V380cl1JfGkO+pjj1P05NMkI/L41vTHD1jbq5K+LvFy
	XNwpK97tcBelUtFMUzOz5iDwS/EYuJL+vsDR6EaG+ey4UpNP3ahBUrwA1yx4U27YXTYWNz5M2Ba
	gcmqDNFvW/sJlRG+NUSWwtU88YjXw3SGRpZX8w0/aVdtwv8mtSGoIjKOdU4FLCZ7KI+8WKC4ROO
	RuVN5FQh+XhF6iivA/PXj4RsrzirNvP37ixT79wVg1CWa+HZttCi3M/nMoqbJxMt45LU3COsTZ3
	7phPHQNz2KCozZyhbFWqGQexwclgkEZPZJFiVMq0Dis6pxy312TLz9nFY3crZ27M4KCwvmxVp0r
	73wII2ExdBh3a3zKChJxU2XYBYy2qZhJL6eBztSM9QBHfTy84KPmx+ZaNSnjSyAtLTrhcH40w6d
	RfUhrPp6/zyzK2PiyBvPznIzsV6wjjceHTo51h8MaTYRsi0mA00PcLJeCySRs/pzpFO3qzRt0Fb
	3pVDjGO4vewb3pwSb4yNlRYARAteJHRdrgOt07ApUjLVw==
X-Received: by 2002:a05:600d:8492:b0:496:c2fd:1731 with SMTP id 5b1f17b1804b1-4980c64b96dmr272525725e9.1.1785862027655;
        Tue, 04 Aug 2026 09:47:07 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm14229485e9.15.2026.08.04.09.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:47:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/5] selftests/bpf: Add ksock LSM recursion test
Date: Tue,  4 Aug 2026 16:46:51 +0000
Message-Id: <20260804164652.296919-5-mahe.tardy@gmail.com>
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

The bpf_ksock_send() kfunc triggers the security_socket_sendmsg() LSM
hook via kernel_sendmsg(), thus attaching an LSM program triggering that
kfunc on the same hook would provoke recursion. This test exercises that
path and make sure that recursion is guarded and prevented.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  | 82 +++++++++++++++++--
 .../testing/selftests/bpf/progs/ksock_basic.c | 33 +-------
 .../selftests/bpf/progs/ksock_common.h        | 38 +++++++++
 .../selftests/bpf/progs/ksock_recursion.c     | 69 ++++++++++++++++
 4 files changed, 185 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_recursion.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
index fb88eac9eeba..2db89e9c0186 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -6,8 +6,10 @@
 #include "test_progs.h"
 #include "network_helpers.h"
 #include "ksock_basic.skel.h"
+#include "ksock_recursion.skel.h"

 #define NS_TEST "ksock_basic_ns"
+#define NS_LSM_RECURSION_TEST "ksock_lsm_recursion_ns"
 #define LOOPBACK_IP "127.0.0.1"
 #define RECV_PORT 7777
 #define RECV_TIMEOUT_SEC 5
@@ -98,15 +100,16 @@ static void ksock_assert_recv(struct ksock_test_env *env, const char *data,
 	ASSERT_MEMEQ(env->buf, data, data_sz, "payload match");
 }

-static bool ksock_setup_ctx(struct ksock_basic *skel)
+static bool ksock_setup_ctx(struct bpf_program *prog, __be32 *ipv4_remote,
+			    __u16 *remote_port)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	int err, pfd;

-	skel->bss->ipv4_remote = inet_addr(LOOPBACK_IP);
-	skel->bss->remote_port = RECV_PORT;
+	*ipv4_remote = inet_addr(LOOPBACK_IP);
+	*remote_port = RECV_PORT;

-	pfd = bpf_program__fd(skel->progs.ksock_setup);
+	pfd = bpf_program__fd(prog);
 	err = bpf_prog_test_run_opts(pfd, &opts);
 	if (!ASSERT_OK(err, "ksock_setup run"))
 		return false;
@@ -137,7 +140,8 @@ void test_ksock_basic(void)
 		goto fail;

 	/* Step 1: Run the setup SYSCALL prog to create ksock */
-	if (!ksock_setup_ctx(skel))
+	if (!ksock_setup_ctx(skel->progs.ksock_setup, &skel->bss->ipv4_remote,
+			     &skel->bss->remote_port))
 		goto fail;

 	/* Step 2: Run the send SYSCALL prog */
@@ -157,3 +161,71 @@ void test_ksock_basic(void)
 	ksock_test_env_cleanup(&env);
 	ksock_basic__destroy(skel);
 }
+
+void test_ksock_lsm_recursion(void)
+{
+	struct ksock_test_env env;
+	struct ksock_recursion *skel;
+	char trigger = 'x';
+	int tfd = -1;
+	int err;
+	ssize_t n;
+
+	skel = ksock_recursion__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return;
+
+	err = ksock_recursion__load(skel);
+	if (!ASSERT_OK(err, "skel load")) {
+		ksock_recursion__destroy(skel);
+		return;
+	}
+
+	if (!ksock_test_env_setup(&env, NS_LSM_RECURSION_TEST))
+		goto fail;
+
+	/* Step 1: Run the setup SYSCALL prog to create the ksock */
+	if (!ksock_setup_ctx(skel->progs.ksock_setup, &skel->bss->ipv4_remote,
+			     &skel->bss->remote_port))
+		goto fail;
+
+	/* Step 2: Attach LSM prog and trigger socket_sendmsg from userspace */
+	skel->links.ksock_socket_sendmsg =
+		bpf_program__attach_lsm(skel->progs.ksock_socket_sendmsg);
+	if (!ASSERT_OK_PTR(skel->links.ksock_socket_sendmsg,
+			   "attach socket_sendmsg lsm"))
+		goto fail;
+
+	tfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (!ASSERT_OK_FD(tfd, "trigger socket"))
+		goto fail;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->trigger_send = 1;
+	n = sendto(tfd, &trigger, sizeof(trigger), 0,
+		   (struct sockaddr *)&env.addr, sizeof(env.addr));
+	skel->bss->target_pid = 0;
+	skel->bss->trigger_send = 0;
+	if (!ASSERT_EQ(n, sizeof(trigger), "trigger sendto"))
+		goto fail;
+
+	/* Step 3: The nested bpf_ksock_send() must hit the recursion guard */
+	if (!ASSERT_EQ(skel->bss->rec_count, 2,
+		       "socket_sendmsg recursion count"))
+		goto fail;
+	if (!ASSERT_EQ(skel->data->rec_kfunc_rets[0], -EBUSY,
+		       "recursive send status"))
+		goto fail;
+	if (!ASSERT_EQ(skel->data->rec_kfunc_rets[1],
+		       sizeof(skel->data->send_data), "outer send bytes"))
+		goto fail;
+
+	ksock_assert_recv(&env, skel->data->send_data,
+			  sizeof(skel->data->send_data));
+
+fail:
+	if (tfd >= 0)
+		close(tfd);
+	ksock_test_env_cleanup(&env);
+	ksock_recursion__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_basic.c b/tools/testing/selftests/bpf/progs/ksock_basic.c
index c18dcc2ea37b..189b0fc15770 100644
--- a/tools/testing/selftests/bpf/progs/ksock_basic.c
+++ b/tools/testing/selftests/bpf/progs/ksock_basic.c
@@ -8,41 +8,10 @@
 #include "bpf_tracing_net.h"
 #include "ksock_common.h"

-__be32 ipv4_remote;
-__u16 remote_port;
-
-char send_data[32] = "hello from bpf ksock";
-
 SEC("syscall")
 int ksock_setup(void *ctx)
 {
-	struct bpf_ksock_create_opts create_opts = {};
-	union bpf_ksock_addr addr = {};
-	struct bpf_ksock *ks;
-	int err = 0;
-
-	create_opts.family = AF_INET;
-	create_opts.type = SOCK_DGRAM;
-	create_opts.protocol = IPPROTO_UDP;
-
-	ks = bpf_ksock_create(&create_opts, sizeof(create_opts), &err);
-	if (!ks)
-		return err;
-
-	addr.sin.sin_family = AF_INET;
-	addr.sin.sin_port = bpf_htons(remote_port);
-	addr.sin.sin_addr.s_addr = ipv4_remote;
-
-	err = bpf_ksock_connect(ks, &addr, sizeof(addr));
-	if (err) {
-		bpf_ksock_release(ks);
-		return err;
-	}
-
-	err = ksock_ctx_insert(ks);
-	if (err && err != -EEXIST)
-		return err;
-	return 0;
+	return do_ksock_setup();
 }

 SEC("syscall")
diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/testing/selftests/bpf/progs/ksock_common.h
index 6e5b5b089124..c3203220a2d0 100644
--- a/tools/testing/selftests/bpf/progs/ksock_common.h
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -5,6 +5,7 @@
 #define _KSOCK_COMMON_H

 #include "errno.h"
+#include <bpf/bpf_endian.h>
 #include <stdbool.h>

 #define SOCK_STREAM	1
@@ -58,4 +59,41 @@ static inline int ksock_ctx_insert(struct bpf_ksock *ctx)
 	return 0;
 }

+/* Globals for passing config from userspace */
+__be32 ipv4_remote;
+__u16 remote_port;
+
+char send_data[32] = "hello from bpf ksock";
+
+static inline int do_ksock_setup(void)
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
 #endif /* _KSOCK_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/ksock_recursion.c b/tools/testing/selftests/bpf/progs/ksock_recursion.c
new file mode 100644
index 000000000000..52f5200943e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_recursion.c
@@ -0,0 +1,69 @@
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
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+int target_pid;
+int trigger_send;
+
+unsigned int rec_count;
+int rec_kfunc_rets[] = { -1, -1 };
+
+SEC("syscall")
+int ksock_setup(void *ctx)
+{
+	return do_ksock_setup();
+}
+
+SEC("lsm.s/socket_sendmsg")
+int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
+	     int size, int ret)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *ks, *tmp;
+	u32 pid = bpf_get_current_pid_tgid() >> 32;
+	int kfunc_ret;
+
+	if (ret || !trigger_send || pid != target_pid)
+		return ret;
+
+	v = ksock_ctx_value_lookup();
+	if (!v) {
+		kfunc_ret = -ENOENT;
+		goto out;
+	}
+
+	ks = NULL;
+	bpf_rcu_read_lock();
+	tmp = v->ctx;
+	if (tmp)
+		ks = bpf_ksock_acquire(tmp);
+	bpf_rcu_read_unlock();
+
+	if (!ks) {
+		kfunc_ret = -ENOENT;
+		goto out;
+	}
+
+	kfunc_ret = bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+
+out:
+	rec_kfunc_rets[rec_count & 1] = kfunc_ret;
+	__sync_fetch_and_add(&rec_count, 1);
+
+	if (kfunc_ret != -EBUSY)
+		trigger_send = 0;
+
+	return ret;
+}
+
+char __license[] SEC("license") = "GPL";
--
2.34.1

