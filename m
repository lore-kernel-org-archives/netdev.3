Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926AB48C8AA
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040570; cv=none; b=tLnTSYorV1VffeY8xm3S7xT7YzFd6/urkkB4/JW1s08odsk4oaAFSmgFN5haaoo9vbk3AZ1MDnpnUZvtcUs+PccT1qYlgyUHfYAMJC7pdyxrxywRcDkuX1piJ2Fl5I9hdEF43fHdpTnDgc53IJ8T3eYP24unPkWG8LUZoNJLgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040570; c=relaxed/simple;
	bh=Tbb25sGeZrNe8qfMPaAkIA3bkftbTcqapPEA5L4Nj5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NCdFlWm3G4hp9cs1/XK26wDIzVP7Omoz6lFRmhwoqeBcqld9kfU0P/TB6fqvtjlJlQ+N007udZGNYPSlwQGTNlETFauN5tMje/3kwe3xhBF+mZJ0c+J+C7ai2IpAdvnYA+s10+ksHaip62QeRwu43vEMLCC4YW/T3rBEYdlQUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSDCYDiL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSDCYDiL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso18827195e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786040567; x=1786645367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEXE5xEEQpc13Rsa6o31+ciZXy4TocWR50mP3ni+aMQ=;
        b=BSDCYDiLF8bgEmX8yBmLem71D4k4eJSjefO/H1wWsr9VzVvkCCN13mxCadrz7dm9rx
         FpvTQ4VMp7HVS6nCY2oEO7BXYkMV49o5t6pFF08b0tGcPYmq0Ke+QvECS50wuMeKQr4I
         DA+qTXCyR3Mthr8198e48novJr2QIGqCVj7hva/vvuq3jrtfbrC10NCOfnHBpEYTA41Y
         fEH+e7eEY/0/jC7Hao0d/9YjdQV+4rdfj7Jin4PSRCQARHJI+NI9bha7Zln4kE1+/5UL
         fSHrhLkENqGXWzprFhUOXTPxhYC3qWEIGtXPMFrNegWRGpCyoFb1xputjl64dYtzdZHr
         xaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786040567; x=1786645367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eEXE5xEEQpc13Rsa6o31+ciZXy4TocWR50mP3ni+aMQ=;
        b=csXhGnZO9sZmhFgi5mIDmZube4fARXYwR/bbUjwBs5hzrHhD9NbcU3wrJAGFpglgtW
         yhJL4AdrKZ9ldtbbkqrWxPVF7MuFEJqrOmT04Hf/1S6harF5u1skORNq0yA7/f4tBVfQ
         4PC9jiOVu4jrsq6y9N2iOehveJARSB68o4bCY6owAak6pe9UeG+LExB3CzWl99fFBLWF
         YF6wWNoYZUWet6SKc+me0vvxo6bAlPYYSmJaML+laA+ZEqsCJHQXI03AVU/opjjm3/kB
         kZEEHRdEq0PEuzADX8Rz4Po40iXo+LITCoPROSuG+4QXDbAvutyu5Elhijk0hT+fR7oF
         rdVg==
X-Forwarded-Encrypted: i=1; AHgh+RpPc4EXaLE0uMYWn3fPGkNOA1jH5dBHGGw1dcMBXfdEzaTCniS2WaAPJjVA6facga4awK9+4l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmqLJTOj+2fY9xVnIe3lmxqpJC4DdXAq+GfF5Z6lmdO5zHnq2E
	dBDur2UNfJ/eS+GopXqGsP6ncRl/S5wgeyqlesSdA5dAyDxtCHv4g993
X-Gm-Gg: AR+sD13xDA1/yUrNauPdQKoU6o/0yVP5OdZAsZtZIUSa/ToOqNU8VMOLf41hmgAZ59u
	GiMsaQjmbGJMLbqIDd+T27orwDSjrb5jLiN3dXa+YCw0dbyd3iCRmHWOcvG9lUrHpshNX88fL+X
	D7iYIBc9zmCJcIF2wWNa7sZl48yv5IzqqUOYeyqZhrXDzUZGRvXXMwFMJzTDzfVswe/PitsISRs
	EVP6Us806+K1/c5xAiRTNmlORcaPLdm0zSZd0IMVFEd1H0srG9SqZDC1kzNhuCnuCigIU64iJPW
	HwzyqVTxW2ixsslah6b4XtZ9CDuCnerPYxg2ctRHUKHQGVJUqrjQWs0VpWsI3LMpr+TWJtfVEVB
	bDIu1bWVjAZIStCMpesfDjO2zjku7R9Uo9QaE2bW64wrbBIt7iRzB5HYwO16oFyhrV1HBF0is4d
	SDmGrhG0B/3hAiuPkPAhrWHRE+NR+0zAL0tOL55R4Timhow5eE17cl3ZjvGHCaa7WHr/GmCedL1
	2Db8ArcweQxeDEWfGPeVNz+6zWoGgVtfQ==
X-Received: by 2002:a05:600c:354a:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4994e7b72dcmr230219655e9.9.1786040566829;
        Thu, 06 Aug 2026 11:22:46 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995420bd1csm82214425e9.3.2026.08.06.11.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 11:22:46 -0700 (PDT)
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
	memxor@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v4 5/5] selftests/bpf: Add ksock test for async callback guard
Date: Thu,  6 Aug 2026 18:22:34 +0000
Message-Id: <20260806182234.380833-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806182234.380833-1-mahe.tardy@gmail.com>
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because the kfuncs are going through LSM hooks, allowing their use via
workqueue callbacks would expose the wrong credentials. This test
ensures the kfunc are preventing any use from these contexts.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/ksock_wq.c       | 34 ++++++++++
 tools/testing/selftests/bpf/progs/ksock_wq.c  | 62 +++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_wq.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
new file mode 100644
index 000000000000..5b9c6cc30392
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include <unistd.h>
+
+#include "test_progs.h"
+#include "ksock_wq.skel.h"
+
+void test_ksock_wq(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ksock_wq *skel;
+	int err;
+
+	skel = ksock_wq__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
+		return;
+
+	err = bpf_prog_test_run_opts(
+		bpf_program__fd(skel->progs.ksock_wq_start), &opts);
+	if (!ASSERT_OK(err, "run ksock_wq_start"))
+		goto out;
+	if (!ASSERT_OK(opts.retval, "ksock_wq_start retval"))
+		goto out;
+
+	while (!__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
+		usleep(1000);
+
+	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
+		  "workqueue create rejected");
+
+out:
+	ksock_wq__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing/selftests/bpf/progs/ksock_wq.c
new file mode 100644
index 000000000000..16a1873d132e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_tracing_net.h"
+#include "errno.h"
+#include "ksock_common.h"
+
+struct ksock_wq_value {
+	struct bpf_wq work;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct ksock_wq_value);
+} work_map SEC(".maps");
+
+int create_err;
+u32 callback_done;
+
+static int ksock_wq_callback(void *map, int *key, void *value)
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
+	if (ks)
+		bpf_ksock_release(ks);
+	create_err = err;
+	__sync_fetch_and_add(&callback_done, 1);
+	return 0;
+}
+
+SEC("syscall")
+int ksock_wq_start(void *ctx)
+{
+	struct ksock_wq_value *value;
+	u32 key = 0;
+	int err;
+
+	value = bpf_map_lookup_elem(&work_map, &key);
+	if (!value)
+		return -ENOENT;
+	err = bpf_wq_init(&value->work, &work_map, 0);
+	if (err)
+		return err;
+	err = bpf_wq_set_callback(&value->work, ksock_wq_callback, 0);
+	if (err)
+		return err;
+	return bpf_wq_start(&value->work, 0);
+}
+
+char __license[] SEC("license") = "GPL";
--
2.34.1

