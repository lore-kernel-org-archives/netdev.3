Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF449C4DA
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048982; cv=none; b=HJpJL5Mj2C1TmuwAdEgknn7ttbOl7kc6RpuI6kTOZsFbZSEAyt4kuQwkOtFaC2yZp11EAGJp15k8vRZZ/4G8SL/v8ctV5cjZDVIIPYOpr0YoQmsLiaWVBK6dO+vMVUsXEksg7uZMnZ+F3F2mzN7akXg8A4vocAMN9XACUw1ennE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048982; c=relaxed/simple;
	bh=55iQuYMPYHmWNhGI9iYAjdYuMLjOK8wA7LUdMnEO4dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eL1Kiq+EQPQXVjUu7qqJa5FehoF1bxaTydYCaEoL+2fpRV7/1CLA0ylxivpBVUrjyPstAJrJqq/WqAy5scXkgBImYLUdlxdCgs2VpkcIbMFz7zkj08uj16//wtkVfYgiJWxQ2FClS/MYhFy01TEvR8Cg0IPs3FQQk0yEEMEhbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HI/wsO2T; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HI/wsO2T"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c28fde3bbd2so736843466b.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048978; x=1789653778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T2CmDtjdtupO0LJlQjxNeM4nlgByzN3AEY0E2hlHzrs=;
        b=HI/wsO2TRwP1n8HtefhV+5sEPx2gJSJ8buzln21eU4wZg0Tm0BtZM4CBxRsqjemkZC
         oAhxAIzo7uUkM9Z4GhUl4TiOmEJo01ggQij+zZEmBPk73YcW354O08ZpDbtM60uIhqTn
         O3s+lcXzqcZpyZUl+dvc1JylEsPrI7jsiDVWKWYD2uPqMaFQ+piS0SCrPwZLVav/+BCw
         4gRwsIhJ4v7c29zW/qvT3LxlYp000BT+laMaG//Np4MRUgD9NQSgy0l2oC4D7pGC5ucz
         7f9dldJtCEnaKdQrvH2neAkCfZl29ssleueoh1aw9Sqmgs2MAL3tu13iKE3VUCOd0N1u
         3aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048978; x=1789653778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2CmDtjdtupO0LJlQjxNeM4nlgByzN3AEY0E2hlHzrs=;
        b=fbGLjQD/DV/FSbZG5AkDz7hfNTVkOuxxcXB/YAqmJGKC61rqJ7I+i90gU1sAm8HoAg
         IwB/+DFqR1x48eS+bwDOJwclYkkDJwArCK9FB3U51NgNEv16F55hjitRaRf6EkaZ9EBT
         5UR8DmQyFMTWQ0N4Q4+NQdWqDI7Vld2iMWcF/1vWXvfdDdCsUmKJKGwRHdqROOUV4T1E
         pAqDYREWpOnmzj71h06GhU1814zY2cJwERSK2czkUMigT83z4MPlMiPqRB6mV0UJ30zC
         DrjY9ivxlDjIvDA9LEQCl7enx1OujYWPmwgG8VSpEVTAwCMA248famwELtt6UXS/Wv62
         HBcA==
X-Gm-Message-State: AFuF++k3fF1fzNUwCBmSdQ1DpdJGTH4mRzD8rjdSw7TCQxXaVByv8JWY
	mrnWOTfBYjQwSmAP8OC9NR+NGj0rIO7iqpwy9hHk8l7bSXz35JqnitBM+d6nfw6p644=
X-Gm-Gg: AYBFou0T+6QA/nY8mrlxWb9DQCDzzqzlVQ1BL14EmWKP/eceOBiHjeFpvJu97kf+xG2
	ll6XRCy67GtpB7GWS8zLZYwrpb3nJUkjGOmN1wxHSRBH640kI+GbDTvprQ24vNJkdUQfICnsRKu
	qhGSg9pLICOriGiGI5vp+LLJ1QBcB0D5kdI2GDd8XGDWGemRT9gaQj60ENngJFomJVWDL231TmK
	6EdhCUiwjNPleUb1QUp/dfAmVi36JpGFkMst0QaAOkSqAxJkyI+xoQw52hfBb86b5PGyL+ljWwk
	+6bmLPr1q9RJJZqqXh1rb1tYdZoklRa/pXrnt0qFyJSTc4qHUVkwk6uiFgMpcY1ewWJLxk6l47F
	cn2XNuaJbFao7iKPwkOMQRc4dDTTVwsI+t7O3aPXfSdhNk8Rhbz7rAjQ7mFOOuoyFktzmZntyhF
	8ackfHNtWI+sxJNGQ/Q2h9Ka9QynFKh3IO3rGnUnKrOoT/irE8jP7zsP0xkqL+1/0LKQG4d3wmm
	KY7EiP749QynMquFEKesCnxhqYgzo7URFMnlQspQHWv3qTj
X-Received: by 2002:a17:907:db17:b0:c29:45ce:85ad with SMTP id a640c23a62f3a-c2945ce8794mr226072366b.1.1789048977490;
        Thu, 10 Sep 2026 07:02:57 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c28e9aec296sm636743766b.28.2026.09.10.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:57 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:44 +0200
Subject: [PATCH net-next v2 09/14] selftests/bpf: Test skb_ext read from
 kfree_skb tracepoint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-9-0b21e42180b0@cloudflare.com>
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

Write skb_ext at cgroup/skb egress, send UDP to a closed loopback port so
the packet is dropped, and read the extension back from a tp_btf/kfree_skb
program.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 70 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 34 +++++++++++
 2 files changed, 104 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index b702531eb7e2..632b2ae6935c 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1294,6 +1294,74 @@ static void test_skb_ext_tcp(struct test_xdp_meta *skel, const char *name,
 	netns_free(ns);
 }
 
+/*
+ * Test skb_ext survival until skb free: cgroup/skb egress -> kfree_skb.
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
+	ret = send(fd, test_payload, TEST_PAYLOAD_LEN, 0);
+	if (!ASSERT_EQ(ret, TEST_PAYLOAD_LEN, "send"))
+		goto cleanup;
+
+	/* Wait for ICMP error -- confirms the packet was freed */
+	ret = recv(fd, buf, sizeof(buf), 0);
+	if (!ASSERT_EQ(ret, -1, "recv"))
+		goto cleanup;
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
@@ -1310,6 +1378,8 @@ void test_skb_ext_cross_hook(void)
 		test_skb_ext_tcp(skel, "tc_to_lsm", READER_LSM);
 	if (test__start_subtest("tc_to_skops"))
 		test_skb_ext_tcp(skel, "tc_to_skops", READER_SKOPS);
+	if (test__start_subtest("cgrp_egress_to_kfree_skb"))
+		test_cgrp_egress_to_kfree_skb(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 6bdd64b9f3f2..e162683a6534 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1112,4 +1112,38 @@ int sk_filter_skb_ext_read(struct __sk_buff *ctx)
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

