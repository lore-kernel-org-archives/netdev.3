Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE89C48C400
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040570; cv=none; b=QZlH0mdab6TmaYmdBIxMxH+PJ0x0KUzKa8ju/GK19b0rbxLH9nUprq4iwn/a/jr+qEetvdEygYphzpsjcP4o0eJJ790aNiMjDKcpTdLJIKlTEUUehs0uysg6FATuC+DOXzSKmPWLzvJFPYaNUwRPvTb7lzmmjlO7nvy7wjBuXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040570; c=relaxed/simple;
	bh=E9kvkrJDs0vUUYphvZhgFVMqXCcr8fID40Y0sH/hkoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gsn13gkvb0RjmOUTxQDhpjO7Qr8DnkqGjawKXQr5nvCj/TjgkAzTJbWt1xSu1ro5dU9sfoH7h01+FgIO8ISpYbay8bFufRzFwttSBuozEPp6+kBDpSnNxnQhoXlu2reF8qdhiCQ0Qyx2M6aGXj3nXK+nGz3xzeaNcDBeJUXWl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCrGsItG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCrGsItG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso9818285e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786040566; x=1786645366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4a5tyJ8YEVwsB7RSmOWXC10B8IXeB7AlAmeqdvYGqA=;
        b=VCrGsItGbwwc1FzJdBf7HLuHJvRU+BjL5hXJ7G/VECAJWnbntfJWWS/svTNo3V9uS2
         wgj+XwePGU/sxcUivirJk3uHK0BC4ZksSH1r1yXD6NsAffBZScVEKEu8GPQDkO8zIp95
         /aA1kXy3ks2pp6eAgTWM4kOMvFtaxmAmplZmVeHNh65tqQRTccfrT6sbl8k6jOTvGE5Z
         Fij9cRtHr9qzxS4lLKXZMV/Vhkv8Zblg7CiybmIEWpqpqPmR6ucnQWklteO50YTFRcXa
         zrDGqAVd52mtD5AG+3drSeO8tOK8bC1ZWK+buZTFToIh0PzTnrP+i5PB7IMzrGQ7bytd
         mo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786040566; x=1786645366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b4a5tyJ8YEVwsB7RSmOWXC10B8IXeB7AlAmeqdvYGqA=;
        b=UtSheCiYIjyzBj+4HoUbbfk0jiAIxUJDriKAeEGEaoyIhBGr9TS/6jGfQ7Vzslez9n
         ePsCwjguMHE+fcw9ThYkHdrf17dqklPOgkiw9FfniFnCtvm6o+4a0sm7HJY8jNOjFzL1
         Ct87q65bI+FcKu9RSL6cfi9o2XBvYkGj0uy9X/XDvwdvpmv25Y58t/I6J0/5phQxZvaZ
         0T9/cJLe9VDGQcD/vwUv84NJlrjwd87a/Cv9V80ewlDFfFQQ6//NQBwQOuz+y7UUMiqS
         qjyfdKpDHesDHOZKjEYxoNShns43GKp0Jvvea2uSlOthGv9WjNXQ6gYg8rTnt+MuUTWt
         eCKg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/TFQR5lCufPrc6VvcDGDj2WkfKl4sUqoJ0kOY2kpO8HRIrIXzPxxnCudaAEX/ce/33DrJnVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2I8Uu71w87+CV6s73WRhTkib62BDvbozxknTY0J3RBWRQ5aqH
	ntu+kouyD4MPyJ22apfFjdi0yZkaErf97rpPY5rsuwbeN1lRdSkGSq59
X-Gm-Gg: AR+sD13Eyu1PEJvcJ0H4/D5XS8uKbeSyDa1lkUuTgEng2vL2zHbqOnCoTWx4RbWMYUn
	5wHmSkJgYBz0HdAuF29C/oP3ciokXkXPwzqLxcwHl12n43P6fbZJm1NDAlmOFSImXEhoGvH5RQo
	dvTxZRp6HeR0Hn3AwUJbU2g48slFNL2KqeXZTE5PFduckWvXydINUfDfzAI+BukCtxj0KSiRN0q
	OFXw+Jd/MhbmabOrN4qbBvx4dj5uym0h/NIuc+zMShvgZxMMycfKE0KsRSuM+SNx7GF1HqE9Dr7
	l85DJDzIP06H0BrJYvu+SV8/2RcdOvzh0POGIfKInuqrgqYiU4vRxZuWO5N2s/8eG3yVsJp6TOv
	SIMgtHUKHDpWKxf8MqvQlKXZavwwAXvXRhlee388Ouw/AU4FTC07i4lRGUqzrGfQUEwF+OExtc6
	oPlR4Lyd1hLKEZ4gBK7ypnouPADfJQyXNWCjewxGcannViPVpVNPmU7P2QMHlSGf073ykwKj5yC
	MANZqI6XzKwpqn3wZZi+FB8z/Ta2P5XFg==
X-Received: by 2002:a05:600c:c173:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499553e1c83mr98177835e9.6.1786040566221;
        Thu, 06 Aug 2026 11:22:46 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995420bd1csm82214425e9.3.2026.08.06.11.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 11:22:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/5] selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
Date: Thu,  6 Aug 2026 18:22:33 +0000
Message-Id: <20260806182234.380833-5-mahe.tardy@gmail.com>
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

