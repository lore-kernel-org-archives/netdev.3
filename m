Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07546D2A9
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157611; cv=none; b=kMJh7rAKKPLPMHZNgpl/O6rmWigc0H5iimlupgEklwgXIKaMdZE6FnwYPJLew7dMRtk0MhXZAFxKGPodqZ1bFDZAfnDTnzyd74wFRgxrBmZmNqxNI5HHhTHlN6oJGnwnlNCnk8QuPsGtC5Tye+VnFoYRIO8Xq84HeXa2hXsox/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157611; c=relaxed/simple;
	bh=3dHREFcLm7gqKgNAjH/wkK7TlEmtSb0IT8JfzGYJXmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2ZYz4nQ359Yvjpc5V2xXdE/ISSeoeU51yJ9VSVz5dpRfk3/9gg7bKHFmikimd29DrpWRi2CHclGopv2sBHGtkd0IiYctITZCo5ALZaKQ90nPG/EEis6HF0T+WSfsFW3bXwtmh7W5FkUc+q7THk1s5705xBvCZIAn4SScDliLxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR5fYCgh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR5fYCgh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso46669635e9.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792157608; x=1792762408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UuGrO2Nw+TigaB2RBhvd97a0VXkhWCtVzbs6ynwIRds=;
        b=RR5fYCghDi7fDayOgFtmRZ7V7pNISEJDP+cZAjggSAggX2/oOIqNBfRq4kR1W2A1dm
         e/zcuRl200ZBBtPr9wUT5VIfjTC4AXJ1vZyxlCGh2stPv6Ba4AfPmsY465QyXt/8O8Tb
         wL1Mp8/YKki7C8R1qj0naHXgbqzm8AHlYZvKmJ4ukfOow/jc5K+3Xbv+HCk3OrSzF6hY
         fPE8n6tDGCERMjmzJK3XdoZyeB9xadnI/IrkS4dYQP34uvqxQy6iZpa5WLw0bmNixufR
         1qpIHzvcPkakNEk0ESAn8r27fLy4wLaekdi6gQwjYBoPLtYnrx6krZ71Euiwf1i19wTT
         iQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157608; x=1792762408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UuGrO2Nw+TigaB2RBhvd97a0VXkhWCtVzbs6ynwIRds=;
        b=t/rWp0YxVQaQsD9G0o8N0hnCJyQg4oVnO/pZdbl3iQf8bMh1r1zqfFz6tRMa9GJKUv
         7Otkcaw1/lSHGvHaMcz9SVN+wRzm5cXeDG3tqhIxE6Q4mFL8xX7u/VGqr3qdFiPB4Pqj
         p1XV2dTO3W09GPFmE29xqpOmNKimB7XPbCOTBG30umKRY2Hg6qVxioGzn7Iqq4raCuIc
         omsDeuZEXhaNNsgIE4yHbE5wiZuy5MZJnJq3eNA5LUUTfdPEq6/xt1d2oRp44s0Ld8N8
         Jhtzub1SafmC0fCJ4HtOL8Vq9c9y6EgtxVwy4Dc23yQRPdsTCDOvsJElEo6/NOLBPyky
         l55g==
X-Forwarded-Encrypted: i=1; AKwUvBzfo85iSZHWTn1DMb27C3rUwgUFE9Jgrxja0TfVvW27tJ68XKpI9jf/9367Te8de3QVy9QbNQ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2tYhoi7TP0z34WdtKKypT0meoenNNLtS9ZBK5wvfXbSnZQ9OS
	7+piRBMTeGHRpWXNAiw3QQM/MT0PXjaCe93yqZH/jueXG4P0I0U6ToEU
X-Gm-Gg: AYBFou1KajTzZoMExtH5hDoxSZjXHlRmaEqAbkRGDJ8CRZUGBB60Z5mhip3kl9GWugp
	/Ai0SAadQQ72f7B9cL8avnO/wZmgp8RUBc6LlsCtCi4Ux6hBHyNh8ZjA0o+4AvVT3tbqAD3Ey5h
	22Zu0TnqdSJb6Q0HLkEuGcOu/eLPYMrVSXEUzScP2XO0i4qI3A1lNs/gzs/RJQhhqEQ9n3/EN2W
	Ux9ApFNoz2AmYrOPx+yLsKefyM+VgZHGR7MvsweijNe1z2kNjx0QMHyj1bXWF4eH4/sDxZ05Veh
	qrpcs3f21YVovw4xai398zCDceQ8YecEPSiV3SsUX+FDyvFN5WL1I7CxVHqyY+9AnDhX1vlbMu9
	qS9VYJQb+Bd+VDO6Vt7thyh5uUedoLkDgJnUbJ1uvaUDHq88iEyCqh1lfiJDelTj/VIoA2I9rt7
	BS/oBVnYBqOtaIn1CcBpjiKPOFBlFC3uvpRq5CzOV6y7SbS8+t1KMB7WWtNMrPpfoqJil724cA6
	tjJucbCF0tfX9MyU7cMXtv9hbja4Kkb758ICtB84p7xig==
X-Received: by 2002:a05:600c:3f0c:b0:4a1:85d9:13be with SMTP id 5b1f17b1804b1-4a18e498471mr477331905e9.20.1792157608065;
        Fri, 16 Oct 2026 06:33:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1cf05009csm42169885e9.10.2026.10.16.06.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:33:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 1/2] bpf: Allow ksock connect/send calls from wq
Date: Fri, 16 Oct 2026 13:33:17 +0000
Message-ID: <20261016133318.33999-1-mahe.tardy@gmail.com>
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
 net/core/bpf_ksock.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

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
--
2.43.0

