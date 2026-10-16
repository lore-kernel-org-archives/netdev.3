Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6373E4112
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140845; cv=none; b=qFzUpvWJr9yX+WkPryqiVT9OLWCSHqMsJZbD9lmDRiRfMeKTdUteAJ5s8Xv0XnMfmfeEA4RfI+Ydd/3dB9cjMLfs+INFVJVarXCgLrFTujI+hOyLBPuvYBSP9QW5WcJwzjkMVPCc7cT26cnqQO4ljk8mZkxVijOtRQyCdLqszII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140845; c=relaxed/simple;
	bh=EVgnD5pqk/2+Ds+lMnDAozwkD4fmr1vMXcslwpWpKgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJU6Vr/BNU3KwITgusCeg9BWolbfiR2oEVtHmM215CvLlUvV4OMAPkH8lfpxqBBHxi8bTH2j2wMqE0LP34JrLXcox9JB958Hay/+5o7IUj8xP3dqwYiWZnV8QqVD2JkgTAWhvPft9hX8wqcQGqfKsA3/fdG3U3TxBmNM18LeKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLfa9YBp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLfa9YBp"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1420843f8f.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792140842; x=1792745642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Cad5VRQZezTW2uJ2xgaD8dGgKtN1zqLOsmVB5ElnDU=;
        b=GLfa9YBpSgD9Qse11TiPqRSc8zafmjd2QAEGP0okworVb8aPeaZqHq8ktdzPGnmVGx
         6UfC7qK9+p+fUelPukbL7T1cbDypgcXHKRiT43VZqHM0UoMEBAm4jVNWZBli687Fo3Zd
         wrZrfbJYjBTUZtejuJ2U2AWUbZp9osgC7Lz41bSRTQJWQSJLlsjOU1vE41/UhBKgxN2h
         84Fv6dhMf9Xd4m75Kv2bzhDBvT5/XZ7ZmAmXgDhKv0L+gEWz0vJyDMLfl5z+Qmbtbene
         JAoygnwSxZOA/n77aEDZzx+usKEpu1P8Dgg/j6X+Dk3Yg3bvRnxi/eiUMuUP26I0bUFk
         BhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140842; x=1792745642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Cad5VRQZezTW2uJ2xgaD8dGgKtN1zqLOsmVB5ElnDU=;
        b=cay3y7d0uQgYjaO46jsM8ax8AZ4dLgSq7l3j7sJ3f2CFCAyqdVD7LY9DATi13GtjOk
         ECr0ic0jogjkaycirGZ+y2sbrOzEQWs4WONdhRANQoyfTTE0pL8GmCOQhRVLHgJBjGYc
         plrU3dxqKJdgqp2e1S5kRGrMqGgAXg2M7hGhgJaKUy3HqWp4IASb7ErwGlQB8kayZv+5
         bv5Z2lU9nIZjhn9jeovnyayo8zZq7rQUhs5+HhvZ7lMabl/dgs2Fe2p3f9Am0zQbADtc
         MPE7e/7thN7RACTviGh9FRBP4NrxYZ9REiRKqGd4Wtt64mSEurIVKcVj2PTc8RQlT4eD
         vwsg==
X-Forwarded-Encrypted: i=1; AKwUvBzIFQ0ZyappaLVVvjMtD2w/UUKYmi7v4zavOa1iU4giXkZOT2oobIefA+nrsgWb31Q2Ec9wtII=@vger.kernel.org
X-Gm-Message-State: AFq9FYKztivYdE3Mc529QcJt7yZTaWrTebhmUoxUSo6z7jSRiPtzqoZN
	KGIdaOmZ4gPqFsldemtJ9pqwx4ai6IikKzKCkkWzdg7bHf78NTJ+flSj
X-Gm-Gg: AYBFou2t0hIFgdfRZ08zH+hrSNjEhxfjW1msHhDmNqRxluusC+THDOxhcHTpbG5/Hi8
	09Q19KtDcbboJg+bet+h+pV4TcPMv0vKfw5nBDhJfut2QTsT/GmA/+I1ziTawUEFHl6hdI5df+P
	NfChR1w72C5pi8pX55sH21RJGPg4zzR8x57nSPLzAlJUp79e48heS29Uiw+rawKFpHFBvYqwloM
	/F3FHcmGVyAqTPai2KmKtybbixBESdlDQ+5OsK3GF5bcbPFdJXtVlktvZOtKXKfxLUi5ny6WYE6
	3+0xJNm7iTzF344/8k8BnSEH0IxAg/ywBPVugzpbkeXQlzmsIsNj1fJc18GEyy00pVqPYp+cxqW
	ivci5OU0WE8k8xi3ZF2h+Uy7CHSDPmkzrM3IoBw9z6dvV0+IGeIE3gTurAS6tBNx0JqYkzsU7ie
	7V14A2KeJjUy0DhXq+AJbFCh0JZHW/WLM5HKlded3I9PG6HFx/ygQKC49wQMd56y3aY67+f+B2i
	Lsmux5usKp406VlE/udxKh5SFQFz3g1f72eL8q1PwboPaFo9i+4W/Jp
X-Received: by 2002:a05:6000:4810:b0:488:7bdc:f7f8 with SMTP id ffacd0b85a97d-48dba9d2c0bmr41576790f8f.29.1792140842108;
        Fri, 16 Oct 2026 01:54:02 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48dfd4e7889sm3565929f8f.24.2026.10.16.01.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:54:01 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
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
	memxor@gmail.com,
	jiayuan.chen@linux.dev,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v6] bpf: allow ksock connect/send calls from wq
Date: Fri, 16 Oct 2026 08:53:53 +0000
Message-ID: <20261016085353.9512-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial ksock implementation, commit 7ae4eb14c5f9 ("bpf: Add ksock
kfuncs"), kept LSM checks from the kfunc calls and disallowed
asynchronous workqueues because worker credentials differ from those of
the triggering task. However, discussions at Plumbers 2026[^1] revealed
that bypassing LSM checks for BPF-created sockets could be acceptable.

This patch allows workqueue use while retaining LSM checks for now,
paving the way to call bpf_ksock_connect() and bpf_ksock_send() from
non-sleepable programs, such as tracing programs, in future patches.

Also adapt test_ksock_wq() added in 'c93cbdb13f99 ("selftests/bpf: Add
ksock test for async callback guard")' to test that the connect() and
send() kfuncs are now allowed and work when called from workqueues.

Note that bpf_ksock_create() still checks:
* for current to not be a kernel thread (thus excluding bpf workqueue
  callbacks) because the socket is created within a userspace task
  network namespace. It should, most of the time, be the process that
  triggered the SYSCALL program, but could be another task when called
  from bpf_task_work callbacks.
* for current->nsproxy to be non-NULL since when called from a
  bpf_task_work callback and the task is in the do_exit() phase, nsproxy
  is torn down just before the remaining task work is executed.

[^1]: https://lpc.events/event/20/contributions/2430/

Tested-by: Alan Maguire (Oracle) <almagui@kernel.org>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c                          | 24 +-----
 .../selftests/bpf/prog_tests/ksock_wq.c       | 29 +++++--
 tools/testing/selftests/bpf/progs/ksock_wq.c  | 84 ++++++++++++++++---
 3 files changed, 102 insertions(+), 35 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index e9943aeeadd3..7bf796193ab6 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -37,15 +37,6 @@ static void ksock_release_work_fn(struct work_struct *work)
 	kfree(ks);
 }

-static bool bpf_ksock_has_user_task_context(void)
-{
-	/*
-	 * Task work can run from do_exit() after exit_nsproxy_namespaces()
-	 * cleared current->nsproxy, while current is still not a kthread.
-	 */
-	return !(current->flags & PF_KTHREAD) && current->nsproxy;
-}
-
 __bpf_kfunc_start_defs();

 /**
@@ -59,7 +50,7 @@ __bpf_kfunc_start_defs();
  * This function may sleep (sock_create), so it can only be used
  * in sleepable BPF programs (SYSCALL).
  * It cannot be called from a BPF workqueue callback because that callback
- * does not retain the invoking task's namespace or security context.
+ * does not retain the invoking task's namespace.
  *
  * @opts:	Pointer to struct bpf_ksock_create_opts with socket parameters.
  * @opts__sz:	Size of the opts struct.
@@ -74,11 +65,10 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
 	int err;

 	/*
-	 * sock_create() derives the network namespace, credentials, and cgroup
-	 * from current. Kernel threads, including BPF workqueue callbacks, do
-	 * not carry the context of the task that invoked the BPF program.
+	 * sock_create() derives the network namespace from current and task
+	 * work can run from do_exit() after exit_nsproxy_namespaces()
 	 */
-	if (!bpf_ksock_has_user_task_context()) {
+	if ((current->flags & PF_KTHREAD) || !current->nsproxy) {
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
@@ -165,9 +155,6 @@ __bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
 	struct sockaddr_storage sa;
 	int addrlen;

-	if (!bpf_ksock_has_user_task_context())
-		return -EOPNOTSUPP;
-
 	if (!addr || addr__sz != sizeof(*addr))
 		return -EINVAL;

@@ -247,9 +234,6 @@ __bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
 	};
 	int ret;

-	if (!bpf_ksock_has_user_task_context())
-		return -EOPNOTSUPP;
-
 	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);

 	return ret;
diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
index d6dc20b8f95b..12c2275e8177 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
@@ -4,6 +4,7 @@
 #include <unistd.h>

 #include "test_progs.h"
+#include "network_helpers.h"
 #include "ksock_wq.skel.h"

 #define CALLBACK_WAIT_RETRIES 1000
@@ -13,13 +14,22 @@ void test_ksock_wq(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	struct ksock_wq *skel;
+	char recv_data[sizeof(skel->data->send_data)];
 	u32 callback_done;
-	int err, i;
+	int err, i, port, rfd;

 	skel = ksock_wq__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
 		return;

+	rfd = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 1000);
+	if (!ASSERT_OK_FD(rfd, "receiver socket"))
+		goto out;
+	port = get_socket_local_port(rfd);
+	if (!ASSERT_GE(port, 0, "receiver port"))
+		goto out;
+	skel->bss->remote_port = port;
+
 	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_wq_start),
 				     &opts);
 	if (!ASSERT_OK(err, "run ksock_wq_start"))
@@ -28,18 +38,27 @@ void test_ksock_wq(void)
 		goto out;

 	for (i = 0; i < CALLBACK_WAIT_RETRIES; i++) {
-		if (__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
+		if (__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE) == 2)
 			break;
 		usleep(CALLBACK_WAIT_US);
 	}
 	callback_done = __atomic_load_n(&skel->bss->callback_done,
 					__ATOMIC_ACQUIRE);
-	if (!ASSERT_EQ(callback_done, 1, "workqueue callback completed"))
+	if (!ASSERT_EQ(callback_done, 2, "workqueue callbacks completed"))
 		goto out;

-	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
-		  "workqueue create rejected");
+	ASSERT_EQ(skel->bss->create_ret, -EOPNOTSUPP, "workqueue create rejected");
+
+	if (!ASSERT_EQ(skel->bss->connect_send_ret, sizeof(recv_data),
+		       "workqueue send bytes"))
+		goto out;
+	err = recv(rfd, recv_data, sizeof(recv_data), 0);
+	if (ASSERT_EQ(err, sizeof(recv_data), "recv len"))
+		ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
+			     "payload match");

 out:
+	if (rfd >= 0)
+		close(rfd);
 	ksock_wq__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing/selftests/bpf/progs/ksock_wq.c
index 16a1873d132e..24246bf2c748 100644
--- a/tools/testing/selftests/bpf/progs/ksock_wq.c
+++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
@@ -2,9 +2,11 @@
 /* Copyright (c) 2026 Isovalent */

 #include "vmlinux.h"
+#include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_experimental.h"
 #include "bpf_tracing_net.h"
+#include "bpf_misc.h"
 #include "errno.h"
 #include "ksock_common.h"

@@ -14,15 +16,19 @@ struct ksock_wq_value {

 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
+	__uint(max_entries, 2);
 	__type(key, u32);
 	__type(value, struct ksock_wq_value);
 } work_map SEC(".maps");

-int create_err;
+char send_data[] = "hello from bpf workqueue";
+
+__be16 remote_port;
+int connect_send_ret;
+int create_ret;
 u32 callback_done;

-static int ksock_wq_callback(void *map, int *key, void *value)
+static int ksock_wq_create_cb(void *map, int *key, void *value)
 {
 	struct bpf_ksock_create_opts opts = {
 		.family = AF_INET,
@@ -35,28 +41,86 @@ static int ksock_wq_callback(void *map, int *key, void *value)
 	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
 	if (ks)
 		bpf_ksock_release(ks);
-	create_err = err;
+	create_ret = err;
 	__sync_fetch_and_add(&callback_done, 1);
 	return 0;
 }

-SEC("syscall")
-int ksock_wq_start(void *ctx)
+static int ksock_wq_connect_send_cb(void *map, int *key, void *value)
+{
+	union bpf_ksock_addr addr = {
+		.sin = {
+			.sin_family = AF_INET,
+			.sin_port = remote_port,
+			.sin_addr.s_addr = bpf_htonl(0x7f000001),
+		},
+	};
+	struct bpf_ksock *ks;
+	int err = -ENOENT;
+
+	ks = ksock_ctx_get();
+	if (!ks)
+		goto out;
+	err = bpf_ksock_connect(ks, &addr, sizeof(addr));
+	if (!err)
+		err = bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+out:
+	connect_send_ret = err;
+	__sync_fetch_and_add(&callback_done, 1);
+	return 0;
+}
+
+static int wq_set_callback_start(int (*callback_fn)(void *, int *, void *), u32 key)
 {
 	struct ksock_wq_value *value;
-	u32 key = 0;
-	int err;
+	int err = 0;

 	value = bpf_map_lookup_elem(&work_map, &key);
 	if (!value)
 		return -ENOENT;
+
 	err = bpf_wq_init(&value->work, &work_map, 0);
 	if (err)
 		return err;
-	err = bpf_wq_set_callback(&value->work, ksock_wq_callback, 0);
+	err = bpf_wq_set_callback(&value->work, callback_fn, 0);
+	if (err)
+		return err;
+	err = bpf_wq_start(&value->work, 0);
 	if (err)
 		return err;
-	return bpf_wq_start(&value->work, 0);
+
+	return 0;
+}
+
+
+SEC("syscall")
+int ksock_wq_start(void *ctx)
+{
+	struct bpf_ksock_create_opts opts = {
+		.family = AF_INET,
+		.type = SOCK_DGRAM,
+		.protocol = IPPROTO_UDP,
+	};
+	struct bpf_ksock *ks;
+	int err = 0;
+
+	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
+	if (!ks)
+		return err;
+	err = ksock_ctx_insert(ks);
+	if (err)
+		return err;
+
+	err = wq_set_callback_start(ksock_wq_connect_send_cb, 0);
+	if (err)
+		return err;
+
+	err = wq_set_callback_start(ksock_wq_create_cb, 1);
+	if (err)
+		return err;
+
+	return 0;
 }

 char __license[] SEC("license") = "GPL";
--
2.43.0

