Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102AB49E5ED
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048987; cv=none; b=KekYRJq9FjBrt9cmuV8Nd2/xbuybkBBBRFD7S3p44Z8DlM9uS7qPP/LaXZa/2me5RhdUAk3J0kp7T1CJY8qeIr1RGm2qSRfsEsXNY7J85+O5s9D40snyMhgLbFeeOReBHj+klMlMvaQbSJFDAHqNsuyhOUqhcRLJbcC5zCg6LRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048987; c=relaxed/simple;
	bh=3DbHv+iTX4L3PJMeVnUlH/TtcwZtYZl3I9H/zJtf8Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYqXNoSToCWG7An5VVD5OoaT4+D8HeQmcwc5WPOrP13WrKAzvG4o5QE3NnRV0faKoRQFHoGcE/WliKfOWfRgMhSyvgHBGEA5HFvw2q518sFvfqQb/5puM/iZ3QWMhqlbJvfVB/tcwyPEyRVBSI/yNmsQ5/nAWT9GnV2mv5C+Rb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VxB7uYvN; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VxB7uYvN"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so300742466b.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048984; x=1789653784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=42dvhu2SyGXAENM7Q7aMtAhVbORcgby5xBEV1XxO6q4=;
        b=VxB7uYvNW/FwheeetctfEkdA979TnowHU3yIdvXCE43yibtTR9GU2ll7byjp4YmH97
         eWHY9G+w1tB72ml3sJ9B8SbpUywABDrZLxK71/CGucpAxFj7tXnMrjHn3zNZe+pkKIiM
         qIEbya9dQpsgh377jPR7+V1Bx9ZZFJxoyH6BiXuEMF9M/G46DLqIE4GT7YlGpFlpNVOH
         hAIMW3QgDD1qEeHzj2ParLY8ktsjDem0Mj4efROjC+qcfzkRazdoKLlAQN2G1h6WqkLM
         GKA9ZNU8gcD9ZXj+KPZFzRupi8hTCO+t0AThLVhKTw+YqiX4uS/y8ZibAga6PmUblRr5
         xRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048984; x=1789653784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=42dvhu2SyGXAENM7Q7aMtAhVbORcgby5xBEV1XxO6q4=;
        b=hYiC4yDnmFUMUjDi8Jxe2Q7y1I/pLgBimUZevgQq3RaxdqNXFYh7r8kfNRRV1ji5AR
         zitna0BRRRQq4DzzH9GRmiY+6kqG6KYCvjJFeCnz7MbLx0Qf1/Ct4vGlVqB+hh6v3u8P
         2bzSj1FAyrzHQAZ+jCnJfVh9LX+KMI2rrtzb6fB3nXzzBte19DNQobZ/Z4qlBls6oOoS
         5z8LK6uZUp9Wo/Nve10WnCbKECjYxhKk4o51Jsn2loFr1BS33ar5+9JW1CKmEXICn5ep
         rNhZ4gyqMhwwu3V9VMjH2fTHu5SzXjGIJCkysbRfZl6e7ngiGH+KmKjXCuk8P5kdB05X
         AN7A==
X-Gm-Message-State: AFuF++k/neqBXQkLZbLa2y8KcZICgrLk2M0NOQMnYMW50xOMRkH6VwwL
	AnvM0bIneGfyBEnophWCFR4IMeJOPcqBZZGraRPaIHFmfja0qUW/cNb2GX+Kgs6Cq1Q=
X-Gm-Gg: AYBFou3RTNbQxKDQcDyBj/KB0caTtVzrf34FsjTiwoAsE7F/iP5XdzT7Qwg6UcsPJsW
	VLaZc0sfpnLqhhDT3T46opVB32G/wrsoCIpS3SQY6HULYdD7Mq0RCPg8nV+OfDy+UhvNO1yFlxW
	jmDKOFio3MeDmV3ghvy/QW01EiegJYT7x81V/FfVfki/x+yyu04Xl/6AHmmrbA2djHmGcFab/hF
	ENJtvzEoOSwevc3G7BPFxMRfYkKRfXP1tz/uIRxvMzmXNAG00F4EQyN/2CNSqQUDJZrUrGWRcZa
	HQSF93+qf4Dn/rzSYOhYAaJlWu7fP3GTrlJkb3CLSG1AespQmr9OuwtHC9P46+mKmnrm4zJ9dh2
	3LED6oxUY6/hBNpWHKF60ptC+AsYLfHcfdPKPmOyZZwAcyeatnRld+5/3/h2IiFw0yMib2h8cEq
	IEg6oiY+qmmbloUMgvECZF2Pk6yf/xtXdKGPeIRlcOWazNnJNCPgraUbo3pMyg308Q4o2HubmE1
	EXJotGg49mmZqorE+EI9vnpffSlPbLRDFp9Ha6Gbttr8+h2
X-Received: by 2002:a17:906:ba85:b0:c26:1648:a066 with SMTP id a640c23a62f3a-c2941b3a8bdmr347406966b.33.1789048983836;
        Thu, 10 Sep 2026 07:03:03 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d036440sm928281666b.5.2026.09.10.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:03:03 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:48 +0200
Subject: [PATCH net-next v2 13/14] selftests/bpf: Test skb_ext read from
 sk_skb stream verdict hook
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-13-0b21e42180b0@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Jack Wang <163wangjack@gmail.com>
X-Mailer: b4 0.16.0

Test bpf_dynptr_from_skb_ext() from sk_skb context. Write to skb_ext from
TC on loopback; read from skb_ext from the sockmap verdict program.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/prog_tests/socket_helpers.h      |  1 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 80 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 18 +++++
 3 files changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index 0d59503a0c73..eb114a6ea6f9 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -3,6 +3,7 @@
 #ifndef __SOCKET_HELPERS__
 #define __SOCKET_HELPERS__
 
+#include <error.h>
 #include <sys/un.h>
 #include <linux/vm_sockets.h>
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 2814bfa0d6b5..01241276c4d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -4,6 +4,7 @@
 #include <linux/ipv6.h>
 #include <linux/netfilter.h>
 #include <arpa/inet.h>
+#include "socket_helpers.h"
 #include "test_xdp_context_test_run.skel.h"
 #include "test_xdp_meta.skel.h"
 
@@ -1678,6 +1679,83 @@ static void test_skb_ext_seg6local(struct test_xdp_meta *skel)
 		unlink(SEG6_PIN_PATH);
 }
 
+/*
+ * Test skb_ext survival across TC ingress -> sk_skb verdict hook.  TC ingress
+ * writes skb_ext on loopback; the verdict program reads it on skb delivery to a
+ * socket in the sockmap.
+ */
+static void test_skb_ext_sk_skb(struct test_xdp_meta *skel)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *verdict_link = NULL;
+	struct sockaddr_in addr;
+	socklen_t addr_len = sizeof(addr);
+	struct netns_obj *ns = NULL;
+	char buf[TEST_PAYLOAD_LEN];
+	int c1 = -1, p1 = -1;
+	int map = -1, zero = 0;
+	ssize_t n;
+	int ret;
+
+	ns = netns_new("tc_to_sk_skb", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	skel->bss->test_pass = false;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write_port);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
+			     sizeof(int), 1, NULL);
+	if (!ASSERT_GE(map, 0, "bpf_map_create"))
+		goto cleanup;
+
+	verdict_link = bpf_program__attach_sockmap(skel->progs.sk_skb_skb_ext_read,
+						   map);
+	if (!ASSERT_OK_PTR(verdict_link, "attach_sockmap"))
+		goto cleanup;
+
+	if (!ASSERT_OK(create_pair(AF_INET, SOCK_STREAM, &c1, &p1), "create_pair"))
+		goto cleanup;
+
+	if (!ASSERT_OK(bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST), "map_update"))
+		goto cleanup;
+
+	if (!ASSERT_OK(getsockname(c1, (struct sockaddr *)&addr, &addr_len),
+		       "getsockname"))
+		goto cleanup;
+	skel->bss->target_port = addr.sin_port;
+
+	n = send(p1, test_payload, TEST_PAYLOAD_LEN, 0);
+	if (!ASSERT_EQ(n, TEST_PAYLOAD_LEN, "send"))
+		goto cleanup;
+
+	n = recv_timeout(c1, buf, sizeof(buf), MSG_DONTWAIT, IO_TIMEOUT_SEC);
+	ASSERT_EQ(n, TEST_PAYLOAD_LEN, "recv");
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	if (c1 >= 0)
+		close(c1);
+	if (p1 >= 0)
+		close(p1);
+	bpf_link__destroy(verdict_link);
+	if (map >= 0)
+		close(map);
+	bpf_tc_hook_destroy(&tc_hook);
+	netns_free(ns);
+}
+
 void test_skb_ext_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1709,6 +1787,8 @@ void test_skb_ext_cross_hook(void)
 				 skel->progs.lwt_xmit_skb_ext_write, "xmit", true);
 	if (test__start_subtest("tc_to_seg6local"))
 		test_skb_ext_seg6local(skel);
+	if (test__start_subtest("tc_to_sk_skb"))
+		test_skb_ext_sk_skb(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 00312a549ea9..5b1a5b9b610e 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1232,4 +1232,22 @@ int seg6local_skb_ext_read(struct __sk_buff *ctx)
 	return BPF_OK;
 }
 
+/* Read skb_ext from sk_skb stream verdict hook */
+SEC("sk_skb/stream_verdict")
+int sk_skb_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return SK_PASS;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return SK_PASS;
+	if (!check_metadata(meta_have))
+		return SK_PASS;
+
+	test_pass = true;
+	return SK_PASS;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

