Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912E4399CE
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695283; cv=none; b=pTWQP6b4ixoaPVOKMiFOyrpXxoEAEw2HJxzrHqn5CRdNqC6xzt6z8Wu3z0PNm4VDJgTMqto+LXL5imn2nAanEE6S+jsS+1EckaGurw98ZuFia4lVmeNwEdk09n9qz4I2nEejDLpu6vkE0+cDrrQnAiRZl7hXpOK/KFI2hwHZIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695283; c=relaxed/simple;
	bh=SVvPMc29WAN+NIidfSYlQv5iUQ8R5mroi+KpeLX4JZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oplskb3Rzqjc4x8w1aLui7O0wPSMs5ynOLvUn8e/rHBzx/Xx0FljLBSyZxUiMjz3BoM0vHNpFObp+gGdYZXXZ1X7ndjf8vk5BtNg3T7q5r4+Qalkdxp4rvYpxosyqDPdPPl2qTuVaaRY6FFMj3yvtWbsUxuJ3bP3QEHI7dTq5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EPz4Es9n; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EPz4Es9n"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c20363107f4so82054566b.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695276; x=1787300076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=11EqZsuxCQDeLazE4TEyA8aDK/6ifCmJ+0XW6+YCD3I=;
        b=EPz4Es9nYK/Spy5yQGIlYhqkxfdsEanSoz4F4UCG0aeicMbnR0RbajXPWF11oeWVCu
         u+CvmY774YHMujgI6A6wR1XOaqVaDcFCQTtWeOGVHzUfqjry3mRJkahOY9xUxlAro+9d
         DCZ7MzK46x3SaKbBlwDNwxLbujB6v2XCxGrnme5vgCcobY4MIpQW6B/4YT/m5cfJBztA
         aalQ9oXK2SNdEMButXVEFEaQzm2g+Y4CmhKQOQRzD6cR8ublptiR2uQZkdVjTm98D8tA
         4t49ZpHl2WB+pXe2F7tDafdQndNhbhf8JpKIJ59YkoaY4rIWxP8C4YLlL+v4PiaIub8U
         EfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695276; x=1787300076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=11EqZsuxCQDeLazE4TEyA8aDK/6ifCmJ+0XW6+YCD3I=;
        b=MwpXKupbi1BLvPvNlQb9fKY4aJARnuT+muGOOnJUz8YZCn64d+RH5uGaMtpimLXjmz
         /rKHUXU46zT2yXfY7sHbnMTfwMbXi8mybUqVkBOKC4EPLf2edqreLXOnx6ZYG+kQIz+9
         ynMlAbqf9S4+IVhUM1IYU9xHNQY6hySrb5g1wKLpUjtSTxTpaqswtUP9GLe3OINvQIPq
         2/+z2EaCPuV2H2jIc4ORCcaEVWiUknLrl6jiFoO/6dF+UqOFIF06VFFPRtwz2iplJ11N
         BkUK15VOOWlZfUWN7EI2aXipzzrbndR9cpFtlV77bCJ98HT2rOqFpIYdcYdnS5DmHZyM
         aYVA==
X-Gm-Message-State: AOJu0YzES7D9rOQtlkuIxUBiOqgIkhpsZwuEb8wOgqKMUVHlVnp8+KUx
	V67oMwFlcQC29r+FmPx+HsaFWrxxm0FqVLMTp8he0ITbZoxoi53Q9BxnlBJLnBILLTw=
X-Gm-Gg: AR+sD11yjAT+kylZk8VRerE02kW8RwXtm2ZG4kfzphKJCglJ+MCF35HKeCRMYq5c4J/
	o0PAqm+b8oMa3XaN+kw/6bqNQUFqdJ4ZcKG8IrvYX9DAsrqjy51BRtbdj8yJXtyryZSpw07bzBO
	Bf9tJwaSwvXJh+enSGf3zUQ/mprP2P7o+T9QHxkK7i1mGt5nW7vJqZZmTk30DjhAp1bU+xGWIxk
	Clb7CIt8U/nrB8q5FQYU63bTFY1+nk4jFFCdvusF0Vuo5NUHVbUqFAfQmhJftCLA+HWTIezdyTt
	/gzHsyMtpuNOogDrHgSf8ZWFJ1VcNNpIYKVj1oEyIpApWILN7Y4IpFoB3l3TOMSTEg5K3nuDdFi
	zfLT8+2LMT/ArD8oYi/cX9aU7t85T7gVc2di/gBLAGrRt9JZE6opmKR9oDLtStYChfEtl0al7sA
	iEsGu0KaoeW2H0DJE/Zg4i911Pd8U7ND/u+S5RpV5CTrPYlmqdzwHfNt62FUaCThg4ii1fnXqCj
	SxNisUJcJZlCrMWqHS/XRvsixDYT7I+cdAWKfZ3BYuDEjf2
X-Received: by 2002:a17:907:7b93:b0:c20:ff26:336e with SMTP id a640c23a62f3a-c212a25389bmr178444166b.14.1786695276148;
        Fri, 14 Aug 2026 01:14:36 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c212378da3esm78633366b.37.2026.08.14.01.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:10 +0200
Subject: [PATCH net-next 09/14] selftests/bpf: Test skb_ext read from
 kfree_skb tracepoint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-9-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
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
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: b4 0.16.0

Write skb_ext at cgroup/skb egress, send UDP to a closed loopback port so
the packet is dropped, and read the extension back from a tp_btf/kfree_skb
program.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 65 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 34 +++++++++++
 2 files changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index e0ab0fccf9d7..1e4e12d2b041 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1186,6 +1186,69 @@ static void test_skb_ext_tcp(struct test_xdp_meta *skel, const char *name,
 	netns_free(ns);
 }
 
+/* Test skb_ext survival until skb free: cgroup/skb egress -> kfree_skb.
+ * Send UDP to a closed port. The packet is dropped, triggering kfree_skb.
+ */
+static void test_cgrp_egress_to_kfree_skb(struct test_xdp_meta *skel)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_port = htons(4321),
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	struct bpf_link *cg_link = NULL;
+	struct bpf_link *tp_link = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd = -1;
+	char buf[1];
+	int fd = -1;
+	int ret;
+
+	cgroup_fd = test__join_cgroup("/cgrp_to_kfree");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new("cgrp_to_kfree", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup;
+
+	skel->bss->test_pass = false;
+
+	cg_link = bpf_program__attach_cgroup(skel->progs.cgrp_skb_ext_write,
+					     cgroup_fd);
+	if (!ASSERT_OK_PTR(cg_link, "attach_cgroup"))
+		goto cleanup;
+
+	tp_link = bpf_program__attach_trace(skel->progs.tp_kfree_skb_ext_read);
+	if (!ASSERT_OK_PTR(tp_link, "attach_tp"))
+		goto cleanup;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		goto cleanup;
+
+	ret = connect(fd, (void *)&addr, sizeof(addr));
+	if (!ASSERT_OK(ret, "connect"))
+		goto cleanup;
+
+	send(fd, test_payload, TEST_PAYLOAD_LEN, 0);
+
+	/* Wait for ICMP error -- confirms the packet was freed */
+	ret = recv(fd, buf, sizeof(buf), 0);
+	ASSERT_EQ(errno, ECONNREFUSED, "recv_econnrefused");
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	bpf_link__destroy(tp_link);
+	bpf_link__destroy(cg_link);
+	netns_free(ns);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+}
+
 void test_skb_ext_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1202,6 +1265,8 @@ void test_skb_ext_cross_hook(void)
 		test_skb_ext_tcp(skel, "tc_to_lsm", READER_LSM);
 	if (test__start_subtest("tc_to_skops"))
 		test_skb_ext_tcp(skel, "tc_to_skops", READER_SKOPS);
+	if (test__start_subtest("cgrp_egress_to_kfree_skb"))
+		test_cgrp_egress_to_kfree_skb(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 8f0a0fea5d84..415b33b32ef5 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1032,4 +1032,38 @@ int sk_filter_skb_ext_read(struct __sk_buff *ctx)
 	return ctx->len;
 }
 
+/* Write skb_ext from cgroup/skb egress */
+SEC("cgroup_skb/egress")
+int cgrp_skb_ext_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return 1;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return 1;
+	bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0);
+
+	return 1;
+}
+
+/* Read skb_ext from tp_btf/kfree_skb -- tests survival until skb free */
+SEC("tp_btf/kfree_skb")
+int BPF_PROG(tp_kfree_skb_ext_read, struct sk_buff *skb)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, 0, &meta))
+		return 0;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return 0;
+	if (!check_metadata(meta_have))
+		return 0;
+
+	test_pass = true;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

