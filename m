Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66F469826
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619172; cv=none; b=GKldK6L2+kRnaW4G6BMr/lTcFEtJQv08GhqaNGamckwitHhROUZ3X0/UfD+tBJIVYORHSbvUGUJfVKSjSqSUCK1YmJV+qg3DhRS8MQsIJx3LVzxsaV29yr4rX+WsB6rqlQ00qogIke4dyL7yZwmw5Zg+u8UnDALr+MgQ+2gLRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619172; c=relaxed/simple;
	bh=SYyfPCQihWyjqkP7HqRGM5KXs9K9fTlaqZk5lYk96MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYUEJ29OL81jQbTTLsa/76kqiLfWdRF/kYzGmdPwiCRjgQSSjqXTlC2chB9jID89noGt+yJGWO0SEqgTP5yS99Th0vkJCTpz2uwuS2CDVu4G+A62zWTiFbS9Vgu5MrTwNpXg/hdOxuUudyFrWcA18/94Zs2ORfpdKR0WV/jazkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRu4i0/N; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRu4i0/N"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956242332dso17990255e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786619160; x=1787223960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnabLq/zZlzT6flo8eoDxgMosyAhh+oBIBd+U1nxMSE=;
        b=MRu4i0/Nyrkp4QhjZCMgBkvmhoC+5gH/QzZf8MSC7aM8i+tUxqxhuJimVI2dTCHRPd
         xFk+pz8LKcb1wYqaMSZBQwFfiDRKiFuufvWgT65C4Tuij0ZXiD/ekLxNXiAwmdyBnb0w
         fu9yqKKTxYqbIwfiEgoXb4EBMuPkFW0Z6R96oLKd+xIqB2nOvLmZ/uJVHDfnVF/SUzKb
         QCGe36cy9GKsSC0NCaWTlFMWxjG7YohUIuzWMw+qLhLSpWOmNzY2izmV0+eZw5hiIBXE
         TTpUzNxPptE8rhMkdSxmDc+aGpXMUsEMf3oZ+OeAKfqizH2zItxP5YWQxY/IHKwL7F5R
         lV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619160; x=1787223960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UnabLq/zZlzT6flo8eoDxgMosyAhh+oBIBd+U1nxMSE=;
        b=NU5bNx/He+ChYXLAPda6+KsZHFgo9y8uWN0/3qd7o0zmIS5nfJIxiGqiUgWoxW2W85
         WNketX3Hcyy9bVN/oc63Q7K4MRCY21fx/v1i1JgqwTfXqvjIMiFz4cGFwh5gIvXtNcbv
         mEwKZZEcOThyTJQBM3NE7qfSGzFp4ocSxGBb0q29DZYwWakujSpNwPvCStAMu8o4OZdu
         ushh6XyHVF0yERoC52rZurFTSyd15uYKCpF3Bgc/D1RYIfLStmUB4UzXtxm3I3Nx0G6o
         3F+hsbQ0g8+MO88tO9sczFLusf+tWJ9IzxLOAaQS8zezfsHf1YtMihSHM+KcruUyZSs7
         RCAg==
X-Forwarded-Encrypted: i=1; AHgh+RqfhtoPggkGP1pxf82tiNA33GHOYmMseB8Ek11RTt540AyLx26FJ+zVsw3cLXYRjgvbeNDLDAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwROtHtLBahjfxS8hN0HJzzB4EhH2mVtW1+/0Dc6db9gpusIG9K
	HMvXOKND5iv9/99H++ANTxteiMJum7RoS/6y/bk21JgG4KQyQMAGvo3f
X-Gm-Gg: AR+sD12cWfqPrgOmVQa5nJ5egk9ky0e7wO9OcbHWY76w6Xg0tyGfUGsw3aQ4lv7g3Bp
	ZIeN+MJhV+JLCbTlGnCZnlNeSqCEFE4Q4Xt/tNXLqC0K2bnbYzKsKirzR+mM/TYWqsyKaIpAh73
	owIvs/03XQtX1qwQgY3+VojI5URFjophcQXfbsJmof4d7ndsJUiKuFarb5Qt/NngIvU1J4TKdtL
	Arj3CypTp6Ud7b/qZEOKELmdxkeYT8tms0Os8ZvAFVblZ/rVhsjkoHj/pvJEsUXQ6oa68oWO9Rv
	uPfEXqJ96lzXyfBk6nx6izop5+QsgyWdUt1kwur3O7goP2kE+NloAF8hcDalTfl/Hhhb9bDVndC
	FEE8DdWjSo4nqVibimfXzK/7CczYBuNv0PPkRu4VY8Bog7thFyl8I/esWLN4w11/wfrRKZFLLC4
	SGRpJ25UrmQoAWSouRsOrrRhgiqfalRM98p4ys108zgOkZn9dUdLf1PDrwggcSpFAD5sW2Uvgvh
	xbIDaN2jmuo75Z6EG5OhvadVuJAAVVrIQ==
X-Received: by 2002:a05:600c:5492:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-4998219b773mr55770445e9.3.1786619160050;
        Thu, 13 Aug 2026 04:06:00 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49982131261sm93841285e9.8.2026.08.13.04.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:05:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 4/5] selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
Date: Thu, 13 Aug 2026 11:05:39 +0000
Message-Id: <20260813110540.103550-5-mahe.tardy@gmail.com>
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

The bpf_ksock_send() kfunc eventually calls security_socket_sendmsg(),
thus creating a possible recursion if a program calling the kfunc is
attached on that specific hook. A filter is added on the kfunc
registration to prevent that at load time from the verifier. This test
exercises that the verifier will reject such program on that attach
point.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  |  6 ++++
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 35 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
index 05d7b7424aee..dd6b167623d9 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -6,6 +6,7 @@
 #include "test_progs.h"
 #include "network_helpers.h"
 #include "ksock_lsm.skel.h"
+#include "ksock_lsm_verifier.skel.h"

 #define NS_TEST "ksock_lsm_ns"
 #define RECV_PORT 7777
@@ -122,3 +123,8 @@ void test_ksock_lsm(void)
 	remove_netns(NS_TEST);
 	ksock_lsm__destroy(skel);
 }
+
+void test_ksock_lsm_verifier(void)
+{
+	RUN_TESTS(ksock_lsm_verifier);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
new file mode 100644
index 000000000000..fd2ccfdb5802
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "ksock_common.h"
+
+char send_data[11] = "dummy data";
+
+SEC("lsm.s/socket_sendmsg")
+__description("bpf_ksock_send is rejected from socket_sendmsg LSM hook")
+__failure __msg("calling kernel function bpf_ksock_send is not allowed")
+int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
+	     int size, int ret)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *ks;
+
+	v = ksock_ctx_value_lookup();
+	if (!v)
+		return ret;
+
+	ks = bpf_kptr_xchg(&v->ctx, NULL);
+	if (!ks)
+		return ret;
+
+	bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+
+	return ret;
+}
+
+char __license[] SEC("license") = "GPL";
--
2.34.1

