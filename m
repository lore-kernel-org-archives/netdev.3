Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491930;
	b=LKIJj8zRzZGhSqLK0R+/dpzCYpqPAU1+DoxzwFg3BJbSbXRZ+e1xkAY/Eh8pjJ1z14rA
	 qmfMdt0Wd0vXzOeocJvNmnWtn2t3HFYY/eEFfOZ1MzD3WMfyxV57CVX6XPQ4oFuKk5AiX
	 SLP0dBScuXOcgJiZMuJH9CqeaH7f6u4O0Pv02epDrwcpRJ/SmiI7jsppS3afsCIY+LwL0
	 Bxd5j6X8HScR0HVExQSFunv8g3ePw/is85MMRODT3Ph2qsJEtr4cuabcMdaVfdLaVYN12
	 8vucNHXOfRnvilxB2pUoavRHJFJiCodGbK9+fomhVcuineX1IW7cBc7Rur8E8yQkvFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=56XU7hrsbm+r4VV0OyPWn2c5IYfi16ADafQPzRlPoU4=;
	b=zx5yIOCN3MIsn3Qw5eCb7JblIOcS8VtT63oobZhtzBM/+Kcr8XINpmLyBjrZzgFQg5bU
	 Yima1gFt2EymUlyoR6yWFogKn4K8tdj+d7oGOcUHeK9hxKTg+TVYHcA/Pvo/64GY7BffV
	 W8vkoRPHokaH9F6Z7BInN4ePFrMMdgY4SHFXO+6DbyGw6e+ipH7iYErXrdOTI+/DfLFl6
	 dsvz/nAkoONZ+LRgEwygIvNDRLoCYY8sCr36Wx5MKMGXByynuGXGTT77bGrqmTA97JiF0
	 ajT2SXyqsOWoUXNBQkGY8jnX8B0qLEvvBkG0KSMO7SzUi/7itollUpLRYmhCV6NeuJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k0p1AR0e;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14960A380C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B14960A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k0p1AR0e
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso3861145e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491928; x=1793096728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56XU7hrsbm+r4VV0OyPWn2c5IYfi16ADafQPzRlPoU4=;
        b=k0p1AR0enVTbjpRbMalpSdtLebrH8Xx1s0TQEgoxHoAELi2LlZuVJKOY8RJQJ9o1O4
         Ix+2ToBRowrEgZ4NeWthTg2oBScWpxnRRpJC1tQSM8aKuQYrCwyyKXRZkGNC6L9vcRec
         GVtAPOKdT63DY/mkXF9EZK0oAS57X2LV2XOUM1dvmvwbMOUwmIVifw8735tSAsbD+ppT
         om5vgeo9inGrSoxuqMf7vGO+KqX2Uu6jX9e+aCL4cEtFedB97Hsg8Z9orBMySB117AWN
         E33SSgdRoGGapIBJXEexMxnepKznG5M7pFpe8UmBv3xx9qCMZm1HNy/NqcwpyAHNX4xV
         wjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491928; x=1793096728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=56XU7hrsbm+r4VV0OyPWn2c5IYfi16ADafQPzRlPoU4=;
        b=hHUNvD3R4yvsvgRJc45p4T8v8brLU9tQ7nqU02X4yeqOxnVAo4mbysnx8XI5VX8675
         /haXmdwyn9y5gdxZf6CuNTkDmW8oIhHGPvc5M0tiTkT1N8q4rUNfmJo03YaUJ21Q/W+7
         2LjDbywm6qeHKZ0NhI8dVscpcZn6yD1lLiQFrB0a5KvrK2EppPk0dsK7LZj8PckmVj4T
         b1k0Y7V63rqIZOvHq2NOr6Evqwy/qSQeOXPwYKLdsx5LlByk905+I+KbaU8+w/TKow0k
         NQhpkBaX5kNLBEm0YkECsXj9U8RWu0dGP8sZG7exwXtfucWjKeXqOxZoPHsdfkdxRa/Z
         c+uw==
X-Forwarded-Encrypted: i=1; AKwUvBxhhkDaZq1UyDKrkYRztXpRi0eRQ4Un1Pajwe4FPmBzNFjNRxXg2bf+cLB3orNuAuDkI1TyVEk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzfflwu04DUCHW53U/HOyeWWJ+VbiOCJnWN8rK4A7v0LkNQI87
	fK7JGmrfkOSeJl7ba9yeXzlO/PHtBdsGva+E+XvZxr//Qnrbw8MdM901
X-Gm-Gg: AYBFou0ug2uLeEeKMeBgjmX+oApDHKHWVOvjlCCEk9885zK96geNrJCzfRPBB7NTJ8N
	yCEEF6pyOTt+Mb4GoKuOz+PX+mAavHHln2Mi9e5QdlASrJqloLw3IP5jYad9GJkmsBdnnx5NEGN
	T+tMtA5oSsvIPVYCKHYwNm+dkjBDOUXGFfUvsm81Zvh6gvonEgjq2P9KumqLriXMhmSQjUmAK05
	bt0s2Y6hply7w4phUxmEoJuytfTeKAMhged657op50r4pLhvnEAnvKY5r0nNyB9sAd6DUYXZlyZ
	COIgkdUTDpM9ybAh4J/nAhXZkoSs1eqYGf2is7+SeoCVHVxQh5/B7QG7h2/pMQ/Y08aE+HepdGv
	Sbgv59MpKoSXu1BATLUQBQy1MhL/qJVeEx/YQA0uWpYYCfOK4SOh3CBVaXaJ62sqjV6LygLC9BP
	zNrV2NUNe/86+WJ5M6RuOLX/CRs0U/SMpMo94sqkHS0Tum2iGu76U4XXqZqXnx/a6hSin/BV45R
	vUqI3hFY8yr0w+yCZVple6c2Q7gJ0QJ31qJAGZjs4zdlg==
X-Received: by 2002:a05:600c:5250:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a1f4f7fcd3mr31653675e9.13.1792491927715;
        Tue, 20 Oct 2026 03:25:27 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:27 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 8/8] selftests/bpf: Test ksock sendto()
Date: Tue, 20 Oct 2026 10:25:12 +0000
Message-ID: <20261020102512.518479-9-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020102512.518479-1-mahe.tardy@gmail.com>
References: <20261020102512.518479-1-mahe.tardy@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests are covering that:
1. sendto() on a unconnected UDP socket works (and that the socket stays
   unconnected, i.e. send() on it fails with -EDESTADDRREQ).
2. sendto() on a connected UDP socket with a NULL address is equivalent
   to send().
3. sendto() on a connected socket with an explicit address doesn't
   change the peer of the socket (send() after sendto() still sends to
   the original connected address).

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/ksock_sendto.c   | 108 ++++++++++++++++++
 .../selftests/bpf/progs/ksock_common.h        |   2 +
 .../selftests/bpf/progs/ksock_sendto.c        |  59 ++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_sendto.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_sendto.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_sendto.c b/tools/testing/selftests/bpf/prog_tests/ksock_sendto.c
new file mode 100644
index 000000000000..498f0e1be6ee
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock_sendto.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "ksock_sendto.skel.h"
+
+struct sendto_test_case {
+	const char *name;
+	bool connected;
+	bool use_sendto_addr;
+};
+
+static bool recv_payload(int fd, const void *expected, size_t len)
+{
+	char buf[64];
+	ssize_t n;
+
+	n = recv(fd, buf, sizeof(buf), MSG_TRUNC);
+	if (!ASSERT_EQ(n, len, "recv length"))
+		return false;
+	return ASSERT_MEMEQ(buf, expected, len, "recv payload");
+}
+
+static void test_sendto_case(const struct sendto_test_case *test)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ksock_sendto *skel;
+	int receivers[2] = { -1, -1 };
+	int err, i, port, sendto_fd;
+	char buf[64];
+	ssize_t n;
+
+	skel = ksock_sendto__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "ksock_sendto open and load"))
+		return;
+
+	/* Use separate receivers for the default peer and explicit destination. */
+	for (i = 0; i < ARRAY_SIZE(receivers); i++) {
+		receivers[i] = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 1000);
+		if (!ASSERT_OK_FD(receivers[i], "receiver socket"))
+			goto out;
+	}
+
+	port = get_socket_local_port(receivers[0]);
+	if (!ASSERT_GE(port, 0, "connected port"))
+		goto out;
+	skel->bss->connected_port = port;
+	port = get_socket_local_port(receivers[1]);
+	if (!ASSERT_GE(port, 0, "sendto port"))
+		goto out;
+	skel->bss->sendto_port = port;
+	skel->bss->connected = test->connected;
+	skel->bss->use_sendto_addr = test->use_sendto_addr;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_sendto), &opts);
+	if (!ASSERT_OK(err, "run test_sendto") || !ASSERT_OK(opts.retval, "test_sendto retval"))
+		goto out;
+
+	/* Check sendto() outcome */
+	if (!ASSERT_EQ(skel->data->sendto_ret, sizeof(skel->data->sendto_data), "sendto bytes"))
+		goto out;
+	sendto_fd = receivers[test->use_sendto_addr ? 1 : 0];
+	if (!recv_payload(sendto_fd, skel->data->sendto_data, sizeof(skel->data->sendto_data)))
+		goto out;
+
+	/* Check send() outcome */
+	if (test->connected) {
+		if (!ASSERT_EQ(skel->data->send_ret, sizeof(skel->data->send_data), "send bytes"))
+			goto out;
+		if (!recv_payload(receivers[0], skel->data->send_data,
+				  sizeof(skel->data->send_data)))
+			goto out;
+	} else if (!ASSERT_EQ(skel->data->send_ret, -EDESTADDRREQ,
+			      "send after sendto remains unconnected")) {
+		goto out;
+	}
+
+	/* Catch unexpected deliveries to either destination. */
+	for (i = 0; i < ARRAY_SIZE(receivers); i++) {
+		n = recv(receivers[i], buf, sizeof(buf), MSG_DONTWAIT);
+		if (!ASSERT_EQ(n, -1, "no extra datagram") ||
+		    !ASSERT_EQ(errno, EAGAIN, "recv errno"))
+			goto out;
+	}
+
+out:
+	for (i = 0; i < ARRAY_SIZE(receivers); i++) {
+		if (receivers[i] >= 0)
+			close(receivers[i]);
+	}
+	ksock_sendto__destroy(skel);
+}
+
+void test_ksock_sendto(void)
+{
+	static const struct sendto_test_case tests[] = {
+		{ .name = "unconnected", .use_sendto_addr = true },
+		{ .name = "connected_null_addr", .connected = true },
+		{ .name = "connected_explicit_addr", .connected = true, .use_sendto_addr = true },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (test__start_subtest(tests[i].name))
+			test_sendto_case(&tests[i]);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/testing/selftests/bpf/progs/ksock_common.h
index 01edaeb9fdd4..2a32cff2fbe9 100644
--- a/tools/testing/selftests/bpf/progs/ksock_common.h
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -16,6 +16,8 @@ int bpf_ksock_connect(struct bpf_ksock *ks, const union bpf_ksock_addr *addr,
 struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks) __ksym;
 void bpf_ksock_release(struct bpf_ksock *ks) __ksym;
 int bpf_ksock_send(struct bpf_ksock *ks, const void *data, u32 data__sz) __ksym;
+int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data__sz,
+		     const union bpf_ksock_addr *addr__nullable, u32 addr__sz) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;

diff --git a/tools/testing/selftests/bpf/progs/ksock_sendto.c b/tools/testing/selftests/bpf/progs/ksock_sendto.c
new file mode 100644
index 000000000000..b6eacf277fcb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_sendto.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"
+#include "ksock_common.h"
+
+char sendto_data[] = "hello from bpf sendto";
+char send_data[] = "hello from bpf send";
+
+__be16 connected_port;
+__be16 sendto_port;
+bool connected;
+bool use_sendto_addr;
+int sendto_ret = -1;
+int send_ret = -1;
+
+SEC("syscall")
+int test_sendto(void *ctx)
+{
+	struct bpf_ksock_create_opts opts = {
+		.family = AF_INET,
+		.type = SOCK_DGRAM,
+		.protocol = IPPROTO_UDP,
+	};
+	union bpf_ksock_addr addr = {};
+	struct bpf_ksock *ks;
+	int err = 0;
+
+	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
+	if (!ks)
+		return err;
+
+	addr.sin.sin_family = AF_INET;
+	addr.sin.sin_addr.s_addr = bpf_htonl(0x7f000001);
+	if (connected) {
+		addr.sin.sin_port = connected_port;
+		err = bpf_ksock_connect(ks, &addr, sizeof(addr));
+		if (err)
+			goto out;
+	}
+
+	addr.sin.sin_port = sendto_port;
+	if (use_sendto_addr)
+		sendto_ret = bpf_ksock_sendto(ks, sendto_data, sizeof(sendto_data),
+					      &addr, sizeof(addr));
+	else
+		sendto_ret = bpf_ksock_sendto(ks, sendto_data, sizeof(sendto_data), NULL, 0);
+
+	/* sendto() must neither connect the socket nor change its default peer. */
+	send_ret = bpf_ksock_send(ks, send_data, sizeof(send_data));
+out:
+	bpf_ksock_release(ks);
+	return err;
+}
+
+char __license[] SEC("license") = "GPL";
--
2.43.0

