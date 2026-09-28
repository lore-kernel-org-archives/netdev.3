Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CB4ABBDA
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595637; cv=none; b=Q5nixi3jtZ6MRjsb5jFD8VsVE6qkMXtGuIfa7X6K9jysff67TyXhxb4ady+OfXPCELnUmo1vMouHPh+P5YQvuQxgm56li3DLzkj5ecxWToe/0uoc415kHwg6prsEkmwhIuc/dTcEZHm9ixo99v/b4VCiMsKOet5oG6ft/DH9l5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595637; c=relaxed/simple;
	bh=iSII4P9Q/wh3M+qIEQ7vbvphPgiwLh3g8AYFwjEK9Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ma0/D1CeE+NdmEcqDwu4/MzVLcIMqNsE02mEe8CIp/+aUEt5/kHNn56bVBJ++pM92Mt+tIC2fjiZMNerjghzs+l+tEpan4jrG1EvqRqE0SlTZdUZvRi46pUd3SyMEfbBqAd3UiSyr4bLj+NaHHDkZQ4t8in/AGzLucdbgVCceow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bqMzJPGA; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bqMzJPGA"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2dca989afcso166471366b.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595633; x=1791200433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zsCn+O9j27CcO0kEARS72JWVZW3t5OI4UKqAnXPVa7M=;
        b=bqMzJPGAbdV9wsQtiN0aFauap7mouSoVyk57IDGVtKElA/0gAY4ZWHhRgJPqJYvg/v
         /9a6qie0thkiNC/Z+zpwf+yuDl880bmMzbxmp94pjaGTDpkE+9xSsHUnfa/lvFhpValP
         NSzWmh1yzHqmN7srWyLNk8toZNSPtFsLohIHUfCYF1sQEG4+ymYKeIqLkJXORQcbRhLh
         +xUWTNY9wy7RMxsFiyT+ls2WGLYltEZUS9A89bTr0JSUVoLwMEXJyGLpjrfbHLEjDD/E
         PhvkBPZOZQQ6lEsT5gWJJATjdL6GzcGPCYjh430NIhR4ZQSwy5gspf0SwRMCE5MeZIoB
         1E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595633; x=1791200433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zsCn+O9j27CcO0kEARS72JWVZW3t5OI4UKqAnXPVa7M=;
        b=gcP41jASuBDpnXEziJZM7AMCjoKEf9Q7lZKvXdGzUyncdiLU+agUWtuG0VOL9IB5CH
         qyHJ4n+8jb9Kn6+VN3ZbE1wf9Ci80kgdE7uthAoKmljLnr+g3LDplTYaBbm6ecjZxe3D
         BYfeV3/oxIgLqZ9s56fuYtJR+5IGucoAZaRuPJ4vOk2mdGyEbk+HhTtjU65QKN/MtBkY
         vQX0piFccNEgOL8mc/WmTMXMUZZLkCD3RspGUIBMMFva+N9+rP99s38QUOx851tQYpo8
         mC4FsBb4cJsoiNbjhTcIc4VE3nrwcCK6BoF5/xy8aaWuXCGlwvZiJJi8+28GMUXF+Obj
         7h2g==
X-Gm-Message-State: AFq9FYJ8SC+VgJ19h8LiWvivvdonEUUImhZHWzgvyYYd4l0gPLxpewJJ
	VgGP7UKHTX8aXOL14LIC361heYJzqW2nqzn1FOP4HVS8JGR9Kit5jFMz+8U4uy1nAkc=
X-Gm-Gg: AYBFou3JVJIz0FfSFMNGRxd/Z/TyGykiDDa8oRjqMpwibz6tZj07YeZLSZcHBFtxzmm
	pBEzzqhTegq6ScoZq6Gcm4/EleCvGImGXt42l87IUIg4rS7AikqOS7nHeMSa99x263+24m9lIsL
	BsVaJ3Mg4WMMICr5a5jTToAhdX+BqWqdZaIm3Q+Dg8aqmJELM2t1fUoYQ0f7jXiA716WZWsgpWM
	EBpf0ZoDddCXWH6tMACoPP8jAk42yKUuaioyHb/9cCcbjlrTxtPcjBQsX9TXzb2YAQ0/2pY4I7h
	oOqy8PI03nIptzkBZS0MeoLSF4N3V+ZfaXREadiuGVg6Csw+mSvYbQ94cSDCfIpSXtaDsyj5Am/
	gHLGaXDVomyLGnyx44A9U5oiSwu9A36/g0vTkNfmubfAQMIu+djyVwRGMY9YyrOB5JI0k+vStuJ
	4Z/KpTTDqsEIPMEkakYjku5hs5p47/BKz7Hiz1Dxz5meaoy9ZEBx+EzDI7jsPibkfosTaj1PfQ4
	X/1RMdDO5y4AQM+oj+VlV3Y051cYX411FDptPt/XxKoqVCCgCiuEivPdsQgh5mqvNGsJMedM24H
	L5v8QsVhwdDQ
X-Received: by 2002:a17:907:c71b:b0:c26:1691:b371 with SMTP id a640c23a62f3a-c2ac2538398mr1128031366b.42.1790595632749;
        Mon, 28 Sep 2026 04:40:32 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2db959aa33sm279979866b.61.2026.09.28.04.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:32 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:24 +0200
Subject: [PATCH net-next 07/15] selftests/bpf: Test metadata passing to
 cgroup_skb and sk_filter hooks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-7-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
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

Extend metadata cross-hook coverage to UDP readers: attach a TC ingress
program on loopback that tags the skb, send a UDP datagram over loopback,
and read the stashed metadata back from a cgroup_skb/ingress program and
from a socket filter attached with SO_ATTACH_BPF.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 139 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  33 +++++
 2 files changed, 172 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 1155e868ffbd..25a16daf5fdf 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1038,3 +1038,142 @@ void test_skb_trace_basic(void)
 
 	test_xdp_meta__destroy(skel);
 }
+
+/* Send test_payload over loopback UDP to recv_fd */
+static int send_loopback_udp(int recv_fd)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	char buf[TEST_PAYLOAD_LEN];
+	int ret = -1;
+	int fd = -1;
+	int port;
+
+	port = get_socket_local_port(recv_fd);
+	if (!ASSERT_GE(port, 0, "get_port"))
+		goto out;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		goto out;
+
+	addr.sin_port = port;
+	sendto(fd, test_payload, TEST_PAYLOAD_LEN, 0,
+	       (void *)&addr, sizeof(addr));
+	recvfrom(recv_fd, buf, sizeof(buf), 0, NULL, NULL);
+	ret = 0;
+out:
+	if (fd >= 0)
+		close(fd);
+	return ret;
+}
+
+enum udp_reader_type {
+	READER_CGRP_SKB,
+	READER_SK_FILTER,
+};
+
+/* Test metadata passing across TC ingress -> UDP reader hook */
+static void test_skb_trace__udp(struct test_xdp_meta *skel, const char *name,
+				enum udp_reader_type reader)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *reader_link = NULL;
+	struct bpf_link *put_link = NULL;
+	struct netns_obj *ns = NULL;
+	int server_fd = -1;
+	int cgroup_fd = -1;
+	int filter_fd;
+	int ret;
+	int i;
+
+	put_link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(put_link, "put_attach"))
+		return;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup;
+
+	cgroup_fd = test__join_cgroup("/skb_ext_udp");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	server_fd = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup;
+
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_meta_write);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	switch (reader) {
+	case READER_CGRP_SKB:
+		reader_link = bpf_program__attach_cgroup(skel->progs.cgrp_meta_read,
+							 cgroup_fd);
+		if (!ASSERT_OK_PTR(reader_link, "attach_cgroup"))
+			goto cleanup;
+		break;
+	case READER_SK_FILTER:
+		filter_fd = bpf_program__fd(skel->progs.sk_filter_meta_read);
+		ret = setsockopt(server_fd, SOL_SOCKET, SO_ATTACH_BPF,
+				 &filter_fd, sizeof(filter_fd));
+		if (!ASSERT_OK(ret, "attach_socket_filter"))
+			goto cleanup;
+		break;
+	}
+
+	if (send_loopback_udp(server_fd))
+		goto cleanup;
+
+	/* Poll every 10 msec up to 1 sec */
+	for (i = 0; i < 100 && !skel->bss->test_pass; i++)
+		usleep(10000);
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+	/* Skb is freed after RX delivery; wait for free tp */
+	for (i = 0; i < 100 && !skel->bss->free_count; i++)
+		usleep(10000);
+	ASSERT_GE(skel->bss->free_count, 1, "free_count");
+
+	assert_meta_stash_empty(skel->maps.meta_map);
+
+cleanup:
+	bpf_link__destroy(reader_link);
+	bpf_link__destroy(put_link);
+	bpf_tc_hook_destroy(&tc_hook);
+	if (server_fd >= 0)
+		close(server_fd);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	netns_free(ns);
+}
+
+void test_skb_trace_cross_hook(void)
+{
+	struct test_xdp_meta *skel = NULL;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("tc_to_cgrp_ingress"))
+		test_skb_trace__udp(skel, "tc_to_cgrp_ingress", READER_CGRP_SKB);
+	if (test__start_subtest("tc_to_sk_filter"))
+		test_skb_trace__udp(skel, "tc_to_sk_filter", READER_SK_FILTER);
+
+	test_xdp_meta__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 35a2c0e6ccb0..32c39c264cd7 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -772,4 +772,37 @@ int BPF_PROG(skb_copy, struct sk_buff *dst, struct sk_buff *src)
 	return 0;
 }
 
+/* Read skb_ext from cgroup/skb ingress -- tests cross-hook survival */
+SEC("cgroup_skb/ingress")
+int cgrp_meta_read(struct __sk_buff *ctx)
+{
+	__u8 *meta_have;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &ctx);
+	if (!meta_have)
+		return 1;
+	if (!check_metadata(meta_have))
+		return 1;
+
+	test_pass = true;
+	return 1;
+}
+
+/* Read skb_ext from socket filter -- tests TC -> sk_filter path */
+SEC("socket")
+int sk_filter_meta_read(struct __sk_buff *ctx)
+{
+	__u8 *meta_have;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &ctx);
+	if (!meta_have)
+		goto out;
+	if (!check_metadata(meta_have))
+		goto out;
+
+	test_pass = true;
+out:
+	return ctx->len;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

