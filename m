Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0343CE47
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695287; cv=none; b=fhUYih+5K/ENm6OPT1Ku+cZpzlrMjKjyjZYDigGkFKhURav0vsbEDCVAo34RDaNRlydfmydM+0EvlqBUxE3pPtQA1PuBma9ziApK5mqki1zG6sIF1loARfZaFqsgPtHrymXcEWcC8R2U9zHyf+cyYZkgJheyfiy5V+VoqCfqpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695287; c=relaxed/simple;
	bh=G0uczJX0OnZghJYHJZd/OPl6+oxUOdEJJa4tBIyFUgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCDW20EtbKJXXLiTC5/iEcfQiSGVmZ+Suk6Ptp8gG5vo/BXBl4QlqDYoOeGiPvKt7Yv5NsoHCFfyfqfKNzB+c2PHIZqs/+yHOQ1Q7x+6W9EdyCRgQwEWcuIIN4hsG+B9noI4sWlI+vPaK9KcvcE6PcRxw6+ajpJPI3tJmJf/XrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IYX9455S; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IYX9455S"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so3094168a12.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695275; x=1787300075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W4Sji205UuRGZDGOehgFL1kH8xgJd0ZEEQg/iWEHPRM=;
        b=IYX9455SYAlTX1ND3ZHsEWwF3hD4CqR3jripv4msczDZdpEx4E4MPPjwwe/qmsinNw
         bGASmgUcNcnbe3f4jZ1Ert0L6klPu5319LG/sVbQ7naqUE5dNBt2d3f+9he5MmLqhKBz
         g8Jig9BtgBAPECnz193CZmPXP/OS+bieXl5t5t1S29RfGycDHAMI5+CBL8p1LKMTbwkP
         ugbqdrPCpz3cxIxAyrYA/hP8jJEOiikPxuEKtkOmu7PzVzd2qiC8213H4BfbvyZ5eG5L
         mM0uzwP0423q32sGJT3AcjUNei2wZLFweEjcxLdg7pggKgAgZRAYRLR8fgkR1TU83ktl
         eQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695275; x=1787300075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W4Sji205UuRGZDGOehgFL1kH8xgJd0ZEEQg/iWEHPRM=;
        b=Y0B7Un5+H/BiFG7KBtyPKsLoO5heNZPG42Z7BrNRsX92dVu9EwPfzBgJZVFK5S9Yzk
         wa0WvbdzVKkMpsTy4ouQaK2fWjMAZh+0c2fP+n8LO+NOpe9YWNGFm+z091mt8mVbwN5T
         zlpKbWwq+Ftb90ZDBGYDodXPTwlenEygovbSL/U5pvwspgKbiOVa1SD0dUPfjB6M3Q7j
         TepMFYL3+VNGQ4ztOzSYUbFD1iQCNa67nlvU/nBcoDaBIDnZoscENxYaAWrWcIwKMhgZ
         uns1E28GX7nt7TqiWzISPH0W0N6wLWOdo5GRCGSGPSovIxbajV3RAQ2+D0dhvi70NVut
         CXZw==
X-Gm-Message-State: AOJu0YzAGrDPMIyPFJY8BDGRp1sQKSFR2czfoFFKEGDX+hPxlYF8zkF2
	+bX62CKBingdxFbDqb36YtrURgZ+XG4i6lKjIQaFIxGanGxE++db6NrgCzsDs5Z/trI=
X-Gm-Gg: AR+sD11MLqALy2mhx31eqB3y02+3bP3leHUHdDlg+x3RDQtqmSCsBIWQUOleDJ1PoLP
	AQdbD5rO9jj+M/pVi4sIniWUbBbShal4nzHVux270Z5iP3VidzzKxyRQkCXKBS0prJvTjEmpHuA
	8q0daArV8ykw/JpOZjDjhnuWdQPwHwzIllmLJOqYErvMz9/P/AVTMki3YVJnVAf1GGRjy5isDVE
	YYzcfx3ncXLAXY90snUcFGVCq8nDTBxK83KdO5VLUH6/u/cltN0LME8IoZUy2K4Qy86RP19h26d
	dOctTxmcc9/UmBmnY970dYAhUY8oQgIX+X/IQhv/aLCOS0HHIv2Nbl6N5kmtmpGFtCL6uTq/ZoH
	Y5w4XCXz1rDmd9sftH2aFeE5CvgoyMoaDE6NjWTKmn4WSwdr7W+qhY2Qh11HE+8InAGQQbmQTbd
	KwLS/OuseZvP615EDAqo+9t2p0pzc/cQdmDqevvBw8G+TXq5M7Eyp5ucEuTllfDwGtrlbXZhqKu
	l+Tf5TDxlfRpvQYCOy5+I9r9vLVsXUQb7zt8A==
X-Received: by 2002:a05:6402:1cc7:b0:698:4501:3a8e with SMTP id 4fb4d7f45d1cf-6a38af1daacmr1802007a12.9.1786695274833;
        Fri, 14 Aug 2026 01:14:34 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38c9d7f0dsm520813a12.3.2026.08.14.01.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:34 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:09 +0200
Subject: [PATCH net-next 08/14] selftests/bpf: Test skb_ext read from
 sock_ops and LSM hooks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-8-767edd862656@cloudflare.com>
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
index 808eb158fe0f..e0ab0fccf9d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1098,6 +1098,94 @@ static void test_skb_ext_udp(struct test_xdp_meta *skel, const char *name,
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
+	__be16 port;
+	int ret;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	cgroup_fd = test__join_cgroup(name);
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
@@ -1110,6 +1198,10 @@ void test_skb_ext_cross_hook(void)
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
index 0a3afb5c3461..8f0a0fea5d84 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -938,6 +938,81 @@ int cgrp_skb_ext_read(struct __sk_buff *ctx)
 	return 1;
 }
 
+volatile __be16 target_port;
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

