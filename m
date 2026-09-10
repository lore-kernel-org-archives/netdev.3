Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BBD49BD7A
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048980; cv=none; b=qAJ9TsNeT5IsSvXYvGXqY23D9eOg+ThQY9LFNrVA2M4cLgW6zBYi1iSEpl3kxVUlL7Wt5posR9IR471vxiI1LEqUHR79aPegorEPxy/qwkm2vopEGhPtZdzWVEKvSN1ePW8TOoOtubFi8h/zbk38SnbCULWgR+OfiLDM5vkN7ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048980; c=relaxed/simple;
	bh=p/4kdzmqdqZ49Rg66XNui8varG+BQh50Yv+uxiIRcbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QN4pZUEJFGbPh4GRZUgO9Hc/BikwCGXB7D9J/Jk0rbTyduSuJAud4YwI/SoXOno2mYzGQeE4GoVcbKgghZnLPJ1Ntd3lUAyiTsfwj2Eb+bWGm0SVMplH7Pir8ez7b8Yh1XRG2E0l/y049fscr2fIRYNle2F+Zh3LZE+4g40l8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cVDXcmlh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cVDXcmlh"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c28fde3bbd2so736832666b.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048976; x=1789653776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0QnKhgV4aQoJzv1b7776+Y1AHmiDgzz5VQL6hTPT0rE=;
        b=cVDXcmlhmVJ51XiQ07rU8sghIevDzp+8wwjPcBsOK6mkBY99ElkUozzY/pWWKI9F1Y
         2tPT0MiL6yeR71Z5s//GiR5ERcBrQTTvcZUQPUI4LXS0g/S7Cy1luKvuoYi38GKN+II2
         KZK/izkmYBTdYWC288IcuDTUoFTNkIZyf9uaA/fL4JRAEK5EF7izzyliMfohi7Qxn29n
         EfvVLfYsr6tnDFH8R/rWVbJ+pNRZPvg9inxQctjKODYTQ+TZpCEP8lROc+rqTZ3UUJQX
         ztIjGcM7uGY/5zujw8ZA+bOSy+fHpHrXbqm/81UPXeJ3GmrKQYSNXZJGyD7IVGVsU+g2
         IgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048976; x=1789653776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QnKhgV4aQoJzv1b7776+Y1AHmiDgzz5VQL6hTPT0rE=;
        b=Q9tDDas1qKF+g/RtkdC71Qub7YrV5z9WfazRMmL5zlcul7gD7S4KP4SrEWh1feQaJh
         E/EnoJwyQ4+sWotHcPZTS/94CwU2LizOhYyxXIpnUVF20ZD/3pROMpQUylaS9wQz1UDR
         XSqClARFfbC8xxebVDwltPg1iakNn6GhdJ9Sea+Gb61/kW1lNLvYb1CZMkIyp/E5Yor2
         L3CmIDw2PMHO5WXUb3rfo7HFbr1neYdydMG0cjRE0vCz9Th77q8O6s4mi6cqRHuAEv0/
         QTXy6kJiZWWJE/7WKu+SfpQ5PhfUyEnmFxKIiaea+IGqrl69dm+x6WaPT6sYgc3JtKsR
         7h2g==
X-Gm-Message-State: AFuF++mJouWr2WpM0xQNq5mMBSf14wAR8XRYKoY3jL4LUjTmGxHOBPuQ
	SiOvEExqFzdC+MkklRZ2FIVtwRscYiqDezTKuczqlwkFRHVZPpQ9pGIn0ktJQBSz5rU=
X-Gm-Gg: AYBFou32dIwfh2Drd54/MIdAIs2FPM9fadVPDOhtfONisoz/q7yJsjOAyuRu1dNYx3c
	fQ2CSdbBMqOBXlzh3J1qxG0RAy9otNgrs1kv22XoLGumBJjc5pmgQQP4nhY6CaEC3clwg81G55Q
	GybkPuR2Dbv2S1HV7joQMErxBoH48g4ztXe6I2em/PhcLKtgBrEV8KP83u/NgI0g+6/d3EaKbYC
	sDUQRQ5WYeJepkbKgqiPQYHP9KWXbLaPwQ8RBSz1HvuzTIFDodlFkLVDBnJd5mkCphBZkuEZubm
	EjXU32BTLZOKUGalTYSSjrrwplB12xc/0k9GeoGOuPwNDL1lGqY/6nMdg81Zkxts5vxvJXwXzP7
	prcP+Xz0rcQRkl8N+th7A2vmo37Haybixl8xuMGZnAT5U8ciHJ0iwgKBxOzGrA9UHOy4R+OrdbH
	gIQpVkFpq/VK62GlHfXJh93eekbxP/Ib45yrYoiSVyk32+o5hkoHxHfGv6euhg5uokXRPqpBgWH
	Z0lKe7LrpdLhZwxsPVHVPVLS1agkJDM1r0EB8Jk0ZFAgW6F
X-Received: by 2002:a17:906:4789:b0:c24:e0dc:8b66 with SMTP id a640c23a62f3a-c260c8dc700mr1872735666b.6.1789048976137;
        Thu, 10 Sep 2026 07:02:56 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c262ccca940sm764121166b.18.2026.09.10.07.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:55 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:43 +0200
Subject: [PATCH net-next v2 08/14] selftests/bpf: Test skb_ext read from
 sock_ops and LSM hooks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-8-0b21e42180b0@cloudflare.com>
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

Extend skb_ext test coverage to hook on TCP ingress path: attach a TC
ingress program on loopback that writes the metadata to packets, and read
it back from a sock_ops program (BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB,
reaching the skb via bpf_sock_ops_kern->skb) and from the LSM
inet_conn_established hook.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 92 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 75 ++++++++++++++++++
 2 files changed, 167 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index dcbbd55381b0..b702531eb7e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1206,6 +1206,94 @@ static void test_skb_ext_udp(struct test_xdp_meta *skel, const char *name,
 	netns_free(ns);
 }
 
+enum tcp_reader_type {
+	READER_SKOPS,
+	READER_LSM,
+};
+
+/* Test skb_ext survival across TC ingress -> TCP reader hook */
+static void test_skb_ext_tcp(struct test_xdp_meta *skel, const char *name,
+			     enum tcp_reader_type reader)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *reader_link = NULL;
+	struct netns_obj *ns = NULL;
+	int server_fd = -1;
+	int cgroup_fd = -1;
+	int client_fd = -1;
+	int conn_fd = -1;
+	int port;
+	int ret;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	cgroup_fd = test__join_cgroup("/skb_ext_tcp");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	server_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	port = get_socket_local_port(server_fd);
+	if (!ASSERT_GE(port, 0, "get_port"))
+		goto cleanup;
+
+	skel->bss->target_port = port;
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
+	switch (reader) {
+	case READER_SKOPS:
+		reader_link = bpf_program__attach_cgroup(skel->progs.skops_skb_ext_read,
+							 cgroup_fd);
+		if (!ASSERT_OK_PTR(reader_link, "attach_skops"))
+			goto cleanup;
+		break;
+	case READER_LSM:
+		reader_link = bpf_program__attach_lsm(skel->progs.lsm_skb_ext_read);
+		if (!ASSERT_OK_PTR(reader_link, "attach_lsm"))
+			goto cleanup;
+		break;
+	}
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect"))
+		goto cleanup;
+
+	conn_fd = accept(server_fd, NULL, NULL);
+	if (!ASSERT_GE(conn_fd, 0, "accept"))
+		goto cleanup;
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	if (conn_fd >= 0)
+		close(conn_fd);
+	if (client_fd >= 0)
+		close(client_fd);
+	bpf_link__destroy(reader_link);
+	bpf_tc_hook_destroy(&tc_hook);
+	if (server_fd >= 0)
+		close(server_fd);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	netns_free(ns);
+}
+
 void test_skb_ext_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1218,6 +1306,10 @@ void test_skb_ext_cross_hook(void)
 		test_skb_ext_udp(skel, "tc_to_cgrp_ingress", READER_CGRP_SKB);
 	if (test__start_subtest("tc_to_sk_filter"))
 		test_skb_ext_udp(skel, "tc_to_sk_filter", READER_SK_FILTER);
+	if (test__start_subtest("tc_to_lsm"))
+		test_skb_ext_tcp(skel, "tc_to_lsm", READER_LSM);
+	if (test__start_subtest("tc_to_skops"))
+		test_skb_ext_tcp(skel, "tc_to_skops", READER_SKOPS);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index d401bd0bd684..6bdd64b9f3f2 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1018,6 +1018,81 @@ int cgrp_skb_ext_read(struct __sk_buff *ctx)
 	return 1;
 }
 
+__be16 target_port;
+
+#define TCPV4_HDR_OFF	(sizeof(struct ethhdr) + sizeof(struct iphdr))
+#define TCPV4_SPORT_OFF	(TCPV4_HDR_OFF + offsetof(struct tcphdr, source))
+#define TCPV4_DPORT_OFF	(TCPV4_HDR_OFF + offsetof(struct tcphdr, dest))
+
+/* Write skb_ext on TCP packets to/from target_port */
+SEC("tc")
+int tc_skb_ext_write_port(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	__be16 sport, dport;
+
+	if (ctx->protocol != __bpf_constant_htons(ETH_P_IP))
+		return TC_ACT_UNSPEC;
+	if (bpf_skb_load_bytes(ctx, TCPV4_SPORT_OFF, &sport, sizeof(sport)))
+		return TC_ACT_UNSPEC;
+	if (bpf_skb_load_bytes(ctx, TCPV4_DPORT_OFF, &dport, sizeof(dport)))
+		return TC_ACT_UNSPEC;
+	if (sport != target_port && dport != target_port)
+		return TC_ACT_UNSPEC;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_UNSPEC;
+	bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0);
+
+	return TC_ACT_UNSPEC;
+}
+
+/* Read skb_ext from sock_ops passive established -- tests TC -> sock_ops path */
+SEC("sockops")
+int skops_skb_ext_read(struct bpf_sock_ops *ctx)
+{
+	struct bpf_sock_ops_kern *kctx;
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+	struct sk_buff *skb;
+
+	if (ctx->op != BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
+		return 1;
+
+	kctx = bpf_cast_to_kern_ctx(ctx);
+	skb = kctx->skb;
+	if (!skb)
+		return 1;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, 0, &meta))
+		return 1;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return 1;
+	if (!check_metadata(meta_have))
+		return 1;
+
+	test_pass = true;
+	return 1;
+}
+
+/* Read skb_ext from LSM inet_conn_established -- tests TC -> LSM path */
+SEC("lsm/inet_conn_established")
+int BPF_PROG(lsm_skb_ext_read, struct sock *sk, struct sk_buff *skb)
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
 /* Read skb_ext from socket filter -- tests TC -> sk_filter path */
 SEC("socket")
 int sk_filter_skb_ext_read(struct __sk_buff *ctx)

-- 
2.43.0

