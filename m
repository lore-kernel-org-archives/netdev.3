Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40032346ADA
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122956; cv=none; b=rc6OKiLp4QW65KMpDfjbqAgucp3xayf0x6yXJlul+mOFpmVuXhOnSAMB3Lyz9yfnmSqEBymGIA/SdNWAM9XIDo9gtK9uF7G1eCWjtvslDijP0hJywc6YnRphX3fctSN6+DqK6BbDgxYPTJ/HmMhmNwJNaAhZHsVF+4thDr7adts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122956; c=relaxed/simple;
	bh=E9kvkrJDs0vUUYphvZhgFVMqXCcr8fID40Y0sH/hkoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOzhbYD31RiQm7Imyltd/dcx3Zg2SB7JLDP85P9bFuBGsVlnX4Rjlg6e86rNsA0t7CLBYkIeSO0jXQQrRGehi5EoJPWh3Bx3+6BwkWoUCtW8V7F3MMSjGTEY8zQeGeDBNhIycHsv3GanrhOY8AesxiILAxjpA6A4VLjxkT2fk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJK+EfCF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJK+EfCF"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so38580825e9.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122951; x=1786727751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4a5tyJ8YEVwsB7RSmOWXC10B8IXeB7AlAmeqdvYGqA=;
        b=LJK+EfCFj9RvVsSwthU8f3uW3i4FYAoIggEO9n5PIIDekQvsFSXdadlVuPPuuo1Nx9
         sx+bWSqzVirUgi+XHhLqwd1vrZaj4+vsJBWPcEy91cLlBFOQjmH3nzJm1YvURlrWWybv
         sMnF7xTI+nNXTXcXfRq/c9isa1U80CEdN8zcLYSLY/ljB+QFr96II+6tq6mLpgODyX9E
         o8QBqSbpHZaNEpf5TMmxxPrKz7rj7kmHSLYypEUQZ1500I/8IE9IMUwwBO6vbzVr4hjl
         mFCC8XxYxuVDNgVCp35Hn8IHbWI1u8blEgCA0w45rB8+6hq5A734bBRIjo8GOQN1Ji2A
         K1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122951; x=1786727751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b4a5tyJ8YEVwsB7RSmOWXC10B8IXeB7AlAmeqdvYGqA=;
        b=O66krcR9BG/z9Otzo2s0B0sVtFp8l1j11aCXQ27thrEINAIBNNaSM06r5uu2nME3ie
         uCyohHaqG/A0U5cNFMzZgcE/gclulMivn25203AwgWZIWapCHJixlPY7sYxzhnKuw67N
         O+gd3MBNf3Gl4Oeuw5hzxhuO9lpfVEOYsoPpUzjm7E7aheHreb5l05t1LtIk09qqTx8t
         Ct43k2dtcm8awa/vh9viTMCfQQ/tRXEmanwIu9BL7HNE8/xo8SZMblTezR+4TRJbMJxA
         UMYJnWrsYlQ861UcjH7muAk9ktTaxrnnNWrPsiikF7aAT2FP4q0yAh/ZVvEBUZReNk3/
         PVrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKScD/Wii5E7rFcyhaLuVSoS6OjFmRP8/4jiK8it2aB3efggFFleBt8U22evpwrRYC7pTmhZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxceazmSE9nHfWBUtfLw3Auy7n6j4dKbBL7IKbdInXz9BTQnoLX
	dsEqyQkVkiD7fHdzjAc5Kfy4VrQqp6Y62S0swgzg5TjXjz2H8wygosCH
X-Gm-Gg: AR+sD12dYPSGa/8GA7djUAeLPmh1s8K8TPvSnJkGn0tXkOF0V+BSUuCgrtpssJ0QtKk
	uKI3Q29fyMusQpRrEw/rWz3Lna+KBjdGyTIpwcxiCg2u5WOV0taSdGvCpUdAwXUqUH62ElrZ765
	0Wjxk0+Je4mfIcDkSsUYnLkaLC2e8MFUtq09NdokICwShm0kw1uRwxrp/AecTqXoiuzEgkDZ+6p
	ygLAc55aDjJXpk3wzJfJ5kZM2IN8596ghcCwpHoVnVf7mQsEo4Aa68urAbGRoJA+iLOL/V7zfGj
	rOZC2b3CQCLiyPAV1a0YXw7nDVbz5siNPpthGTl8wBKaiG6Dj9+aJCeqqRswBRqowUy8mkkGfgG
	11u4/E+M8z9e6lQwIVt9j86tU+g+zCxD4i3h0OZoJlUpsUZJah2VNhIskHPLFEiaUJ3wpk9s7mR
	YnPn1FzJy/Mij7pb6WQLD3Ch6n7pouf+ooJXEP9hxRUpA/CZ9cEsbsLhaqkeAYlgeeacntbjSnY
	FnpbrYiCPXAo3iKoAR/Cbc5Rocyc5tZzerCOo0k7RRFTg==
X-Received: by 2002:a05:600c:22ca:b0:498:ee7:e40a with SMTP id 5b1f17b1804b1-4994e7d2c19mr267195035e9.16.1786122951196;
        Fri, 07 Aug 2026 10:15:51 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995d85b96csm27737425e9.2.2026.08.07.10.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:15:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 4/5] selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
Date: Fri,  7 Aug 2026 17:15:31 +0000
Message-Id: <20260807171532.125149-5-mahe.tardy@gmail.com>
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

The bpf_ksock_send() kfunc eventually calls security_socket_sendmsg(),
thus creating a possible recursion if a program calling the kfunc is
attached on that specific hook. A filter is added on the kfunc
registration to prevent that at load time from the verifier. This test
exercises that the verifier will reject such program on that attach
point.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  |  6 ++++
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 36 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
index 30e89d34d388..fb1a332eb3da 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -6,6 +6,7 @@
 #include "test_progs.h"
 #include "network_helpers.h"
 #include "ksock_lsm.skel.h"
+#include "ksock_lsm_verifier.skel.h"

 #define NS_TEST "ksock_lsm_ns"
 #define RECV_PORT 7777
@@ -125,3 +126,8 @@ void test_ksock_lsm(void)
 		SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", NS_TEST);
 	ksock_lsm__destroy(skel);
 }
+
+void test_ksock_lsm_verifier(void)
+{
+	RUN_TESTS(ksock_lsm_verifier);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
new file mode 100644
index 000000000000..5b969e03b6d6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_tracing_net.h"
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

