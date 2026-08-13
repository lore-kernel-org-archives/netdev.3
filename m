Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94CA468C02
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619175; cv=none; b=FKPSH6WgSYo2GH3EB+Mepy4aQXcfcZQYzIhBzHwE3g8fuR583MlXA5GShOMnC/oomGFX1D9L/KZzd7Cj4H5/kl5m6kwH4SgjcxAp8yL2Sxtdc3LimJIUZKnT5v1Jjs2xtHSoIDcaHFIfzuJ/eX09618+olkZFgq2Byccbtd/l5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619175; c=relaxed/simple;
	bh=9jLm869/rxxzZ8IEC4SSPHCqtwuz9NiQgajzHAyv7bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvUy9SsjAOv3pXnW86oBwtu8H2zsWinGL3H8kr4rxWihetAk1NzMgyJb/X8lBhZDzBXFLy1sDv746VRBdXA61rdtLei3JtaOYa015+1QcyxZaTqVFcQf50+8+4O+x8A0zJwmMqjMOgG6TWruROzCoUi1WF7wCJRUS4IPHMWUWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca9H+CEA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca9H+CEA"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954dff6536so14379935e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786619162; x=1787223962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zxYBBjt7hoBjiujwsMip09wemFO4/Am0KMtbsL2Lxhg=;
        b=Ca9H+CEATaTdmF8pvUK/Z0sGCyykw3U70QDGl1j03aAq0f+1e5hGYX4dNlHGWUbNW6
         +G3FWshUMCaDdlSKWDtXGSwSMH2FigkdUUqFyTCmaCqrP6WsfrW5BTVBKs4WYuso61H6
         UQngh1eztP5pmUt7tGIUs4Msz5BNUxjuJbo94DpilseY04aukOE/e57yu3V5ESB2ADN0
         QuBDrXS4HxcpU6LQCBQYBtMBpwgOHS0P4T9vxzrkj9v6dvyJG2OXwQhvQkEsnLTKs7cA
         6ydTtaC921CQeZ6zJoFxKHxDJ3miD3XFpfeC4TmP/yRDHA/7A6jlwlLinfPJqgeiVnMS
         AM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619162; x=1787223962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zxYBBjt7hoBjiujwsMip09wemFO4/Am0KMtbsL2Lxhg=;
        b=M2HWTnnnKt35tSMY5RtPx2eTMOszon0zeBQ4cxKPhhKGprvpBW0OhT9zQbLnbP+fGh
         bBfmJ3vm8d8Q8ukkSaWI4BEF5sMeyeZdFrgDkNO8tO4sdU2rxvR8fnfS1u5kOXPzENZ9
         FBxcD1S4J1WG+K76RbGb8bsScJUMM+aov40+bGBdN3y2KKv4RVFSjzzyfXKcf5/rw0hb
         5PbrKLiKoT3wrLIV4rMrhzQvmoohl3pPeHwOTRINHJDU3z6WlEOInA55dss+5zDJEa1Q
         rweDjZb69XIEqoavL78wVCWNe/uTh0dL1mSf0/5E7Zly9sipetMLquk4lpox/6j9DoUa
         8UjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpsqe3K63lDq29/5hDme8vXBKq6L07gN3ajcH/ytJE2bI9X+sJIDT0g3ltSxCN/BC0j51OVcWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbMEuoOAWOVTNfCAkB36tnusMgwK6wWkz1Bt+JKszVIaToqDB
	BmPc11iDCrleI9piw/3HhmoZe+3MtQPU0SSjOsikawHECWYo+0X5Ew/R
X-Gm-Gg: AR+sD12Xu1hzsNBRU4l+9gDaqFIR7ESFINdQPGx1+QfRSrjD9y7Qy40Pq8+nko2EGLj
	cyGoj9gB6G0tE8ksMXqm+AYHNKeBj/3remXV2bA/3ILYyFhrMXVQyfdM+9n1ktogT+k66iAGnUS
	gwnlmKtrurgYxreg63LCs2+qHuy2ajETA+anxcRV8qiGYP8+I3s1AHdBsrhd0sdPCSMuFvRDebE
	rTZKlce+3+6qhnI3kxBNyLoa8Ge7aZBpaVmfGavWzPUXTzTejwgVcgFotJjXHbcgKgSJ8TaFeZC
	sulczmsSL3S1OFogYt6IEs9wYhgtK3Lty7pboMa0K/BjoRdAhlcvrG022w2XEVLyl9tlQKIPAQZ
	VIBgwnHw0r+9TVGweud5IbeDKYxoLCFnL40ZKSxSVLjYWxsPm3t1in1H3VW7hzFVjYMDD5eJyEF
	IJ9U6ewQ9+V211wM8Fc/P3sK++Z2/ENoOIf5FlgnTz4u5nuoB3Yq7HEsch2AkJDd0sqvetDYjaw
	oWxqwMA/Lv0IE8S55xDkWj0axkBJ0AvYw==
X-Received: by 2002:a05:600c:c8d:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-499821ba25amr52207435e9.9.1786619161588;
        Thu, 13 Aug 2026 04:06:01 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49982131261sm93841285e9.8.2026.08.13.04.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:06:00 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH bpf-next v7 5/5] selftests/bpf: Add ksock test for async callback guard
Date: Thu, 13 Aug 2026 11:05:40 +0000
Message-Id: <20260813110540.103550-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813110540.103550-1-mahe.tardy@gmail.com>
References: <20260813110540.103550-1-mahe.tardy@gmail.com>
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/ksock_wq.c       | 45 ++++++++++++++
 tools/testing/selftests/bpf/progs/ksock_wq.c  | 62 +++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_wq.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
new file mode 100644
index 000000000000..d6dc20b8f95b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include <unistd.h>
+
+#include "test_progs.h"
+#include "ksock_wq.skel.h"
+
+#define CALLBACK_WAIT_RETRIES 1000
+#define CALLBACK_WAIT_US 1000
+
+void test_ksock_wq(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ksock_wq *skel;
+	u32 callback_done;
+	int err, i;
+
+	skel = ksock_wq__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
+		return;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_wq_start),
+				     &opts);
+	if (!ASSERT_OK(err, "run ksock_wq_start"))
+		goto out;
+	if (!ASSERT_OK(opts.retval, "ksock_wq_start retval"))
+		goto out;
+
+	for (i = 0; i < CALLBACK_WAIT_RETRIES; i++) {
+		if (__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
+			break;
+		usleep(CALLBACK_WAIT_US);
+	}
+	callback_done = __atomic_load_n(&skel->bss->callback_done,
+					__ATOMIC_ACQUIRE);
+	if (!ASSERT_EQ(callback_done, 1, "workqueue callback completed"))
+		goto out;
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

