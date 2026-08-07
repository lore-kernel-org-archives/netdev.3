Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DBF3AAF54
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122958; cv=none; b=hQnaLAGWopGlFlQ/oySkoHik55/Pnme1WhZ8YCjdJ1lhdI/nD9Yk5vrxuTVSO0oo/P++RkxGjUN6PNPWRQM1nDUK/WdLmekVHafskk78clVkFlTVzMC8/gkggcV0J97nUF4ianN0lESUxJwPhDmerfvOSqFKOZyGl+i2UhD8CMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122958; c=relaxed/simple;
	bh=Tbb25sGeZrNe8qfMPaAkIA3bkftbTcqapPEA5L4Nj5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LT4HU0VEWrqCBeSvwWqWcgr3aBCBoA5jfLKTrM0i0W4Nj/NYJGjmNo06qnTqC64JLoy6OxC5do3xI7Dkss12u+dbyajnncl/hFJwlEU+q/g/3P8vSz7MX1J0uG4pRVgRfoI0MHRlGzBC43jZHNe3u2X5GF34urm0ZoMHDR4O+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YofaiE+j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YofaiE+j"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954aff6088so36540555e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122954; x=1786727754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEXE5xEEQpc13Rsa6o31+ciZXy4TocWR50mP3ni+aMQ=;
        b=YofaiE+j5vHnviJXoNx/VMAxHIfR7wjURLazqF6hM7sjgk0N5gap3HRM0Rqq3geJoz
         ng0fpgVDe6azDIV93cJmtXc8CET1y2jdlMeZVRKdJtimBnHdNfvUvsHVVzOtgkC1SiEO
         WLgHMNXuMq5e1639FeaNftQDje+qB4RUUC9S2wcDDISogWVhpyAVY3sUB26h+LHIZ1Aw
         3rjcoE/PA13+Ny24IdttUenThEx+0UgYsvVOSWMK2rFufQ0hwyHK9J14lVPxh8FBwV3W
         QXv2g2+CsXo8RkJ93IpcQsJ1mZzEojJ7vH0hYZflHmz7Bq7iau+eGu2a8rBdAZiGI+6h
         encg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122954; x=1786727754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eEXE5xEEQpc13Rsa6o31+ciZXy4TocWR50mP3ni+aMQ=;
        b=hfDe+CMKdWHAMxRmE830Q0ICAwQmYxvK8v0flIYgS1EfAPmwIhoBsea1Ybu/ObTPyM
         f1nHwEDBwbPcjssuIRg8SGbXxeKibaFdqHarATYIHc25jYJ0t4EwBodjA4PSKPDm2QNz
         ytWtnQ53WVYrHceYk7+Qhk+SpwTSrVYslOvhFcb8gCeRZY6D8vfYdUgnhQGcPkQZNDpu
         NmfPbtJKcaPigWFfBCVF7VZpjuHPeGfoFOuXOGrQgPsJXSQKYguembCVvCtgS3xBNL4C
         acAul94Q/2MLoAoOnoCvQNXMaiZVypcZ9739Mzln8n5jctJqUaI2Fx9bw9bFhhFa10K5
         /rdA==
X-Forwarded-Encrypted: i=1; AHgh+Rqct/TkMFokwpzWNY/8LohAXYkBdJqs6ZDgVAMg2bUJ0c0RzyFIvHEuLbaE/udF0tNIZ6/aIzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS5c4KvGaJuuku/D+S8OnlzkjM+souTk2VTRuKUB6lSlUk9iCy
	Dvxg5u9ZzjcUBSFjgCC0bEV+8+5EmkpN7cwUNpbL3KigZGD1qB2+nEtT
X-Gm-Gg: AR+sD13rnVkiv1f7PxEMa3Xc/5pV38+Q1zDafNH0C2iaqvTH/gEv6l31F8Ikk5tm5ac
	HupV7DIkBGb7mQPlnngY2+sX54uahrv9k8Udtknz6exadJ3meqX4Sz5bCyHWm3yVMYavYvb82wp
	B9xDF2PyttLgsRokjr5r4PRGacpE7UDfReZLbyWQUqRPBKNf9DAqRV6CjMHJvkQw/HHEGyT4d/Z
	V/b8qbhrsP6LrhqqoFcHY05IBeAF4OdIVcl/QMnAg89twzyL0zXdR1LjBxl4S1rpJZQfWKK1JhQ
	vcBFFjN7dNmcCiSGFwA7eIsZyNX5GARshhcmSXRSYYVkBkpmAMwB3ICGXCol/ECXTjQbeQ8T1bZ
	sBksPHQeL8KLFM1ymzv3tG8oavc1EzDEZMGuvPZS+64C5hhKRL8pXOMxoj6F8We0GVZEzagFCGL
	T8ZiEo6Ib44mVZlcJLG7dA5jRhCTBvPPUWDFsx3XzXEoRNzYD5vpLqcDV79HGkFoe8dHsrR80um
	4DuNX59VGmBbyWNJOwq5KTWr9fD6HDp0g==
X-Received: by 2002:a05:600c:4f4d:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-4994e7cb0e8mr322414875e9.14.1786122954140;
        Fri, 07 Aug 2026 10:15:54 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995d85b96csm27737425e9.2.2026.08.07.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:15:52 -0700 (PDT)
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
	jiayuan.chen@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v5 5/5] selftests/bpf: Add ksock test for async callback guard
Date: Fri,  7 Aug 2026 17:15:32 +0000
Message-Id: <20260807171532.125149-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807171532.125149-1-mahe.tardy@gmail.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
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

