Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E123515CE
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050366; cv=none; b=UC01QHP+SzL6+4C8hhdyhj4dcX1mlqSq22W+cLPjhiVQh4h6zIoSi9dHwq3TNhKuwNikPDSLxiUXp2Z9MuCz0DsqHXiEQaK2rM4WXz3CxPsrO2XzEhqERtpMkBVZjkbE8BiZ8B9sqtoEadsDtB8wEnWpnti8Em+qYQQNVcGQdgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050366; c=relaxed/simple;
	bh=v41t6DF0ekEaT1U0pL8kouPJmgXfGZQNl45p9mcEWys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fqfEduATIx5rJRhjcZjUKduOnlf55S+N0n6yrYxuznfYNXBPtQxPDPZ/B/QbZ6B3YHm7SmyvRJuLxh1XJV83ptpGS7Jpdbsg1lw2q9e4ZK86SOkMmBxYXJ5NgD+Z40Fhnv6jD6D/6ZBliJvUsr+niZefj1Mf9sAzz9Tz6Laq3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XHQYS2Th; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XHQYS2Th"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6249b76a8so2474868a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789050362; x=1789655162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHjcy2tEeeYxVaNirsJovhAOnE2TiMy7/YEG9O5S2Mg=;
        b=XHQYS2ThSYZKSvhR6589aCQUH3wWpzSMpD7N8mdd6s6//AVTNP87NaDNBX0Est8opE
         Wq/VwHgL0tPe8oONm73uMAQfRD+CkdKplSF9vnzsdLwUtdwfi404AgISQL6o7fkVnZDi
         8kuWa/xTOZFWdX//jyp3yW6eOksXz6uafC2FBu1nDiB+3OL77rDnBIar1iCDEhFk2cNM
         hAH335eY+BWmdqf1Z7fGE7FD4OGiMtG/sACUd5gmZU1HExbm7AEfTssU3a1gahHNkQXs
         F7ZHHdjJhZN+HHqevDZSmJvk+pKSRv/69oXLtmqxGy9QXg8dTO5fqeNa0M4q6aRO/dl7
         vqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050362; x=1789655162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PHjcy2tEeeYxVaNirsJovhAOnE2TiMy7/YEG9O5S2Mg=;
        b=frJgowvTNsOWCSqndWqaxpKugQwNkZGirXHU5tBrgkN8bI37GQG+013znhgDjNScAB
         aARscKzGSqTEh+aJFpJXX5pOqgfBFvsZGz2lY7AxRtU2HvUTXjumQIZT7ias9xkBEv+f
         QYI3Eivyzif2ZqnFaWfMRlWCzXQWBlaUKNI5TS6vOs5YnTcIETlqCHsy+juedDmLqBhN
         IQIzVYUFdpxsMkt3PEN97CLUGLPho752j/DoED5DIp/YrxWkMgA7qczVau+HjtN0wzCj
         eXLPZasKF3nkIdw2O5/FoMM01iOu4GB+0IHZ5z4WMo262HdUg7vpPcgaAzT6G64Sz1Sx
         5ccA==
X-Gm-Message-State: AFuF++k5vuHnJtV40WhYsCqFhIT5z21RadrjFFhbOIboQExybQmb6xtS
	dSwb3g0OiIk0bgzBxKcqO/Lprw9SYvpYoTFBbovOcamJrN+ZYZkfSnc8svaQgK6MJtZOKfVjZep
	yEEP7lTg=
X-Gm-Gg: AYBFou3m52QHfAHUN994SD6q3HJi9Sl3Vi6PHccuDGXxk6hbEqg0uO0vLWL2ovJV7Zv
	myBJjxtgQUEDYAelrvwfIVn/9ntNumz03Gq1uljiVbjqL33HqIrRbo9dgyYUn1zLQ88OK36dil8
	Y0gK8xNNhD1rsE+1OEvoViFqbHf4ogZ8xTf7SEkmvAe53u1OIcTFyuTaM0X05GWShdpqpb85LZN
	YlHjWgOA86h6KDm/5vlVAITjT61rnevAhuQv6ph/47h1kkk0kMXdMPqsEZ+bzrtMidwNVDAdYAg
	yY/2OyCVUgDeI9/vS0d8EDOGgX2vDme9jk69++yEw66d/pIDTduhVCjrCXcT4VVkqmFPNJGm9+o
	VTKxuPHEvXWExaYvg82uR8yxSmomvjmYsQWgYLoNc4aS6W7S34N/Sev1wGIUl7Twa0jTtu6yaCs
	l+YRq8zFbDa8JRaCDyiJKIsyf9v1BNULbGEKheeGxYz2aIpCKmFJrckQmnWFoWDEYloLstr8HRs
	ny3JD+3eaGdGU5WEe+Xutiilo8dKtOrVags1zZ8JrcOOwMt
X-Received: by 2002:a17:907:d20:b0:c28:599b:7782 with SMTP id a640c23a62f3a-c29419f8fe4mr330837266b.21.1789048980243;
        Thu, 10 Sep 2026 07:03:00 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2939592a2bsm223829666b.62.2026.09.10.07.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:59 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:46 +0200
Subject: [PATCH net-next v2 11/14] selftests/bpf: Test skb_ext from LWT in,
 out, and xmit hooks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-11-0b21e42180b0@cloudflare.com>
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

Add cross-hook tests for bpf_dynptr_from_skb_ext() covering all
generic LWT program types. For lwt_in, a TC ingress program writes
skb_ext on loopback and the LWT program reads it back. For lwt_out
and lwt_xmit, the LWT programs write skb_ext on the output path and a
TC ingress program reads it back after loopback.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 103 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  45 +++++++++
 2 files changed, 148 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index b42e74aaca88..cb38a221a278 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1416,6 +1416,100 @@ static void test_skb_ext_nf(struct test_xdp_meta *skel, const char *name)
 	netns_free(ns);
 }
 
+#define LWT_EXT_PIN_PATH "/sys/fs/bpf/skb_ext_lwt"
+
+/*
+ * Test skb_ext across LWT hooks on loopback.
+ *
+ * @lwt_prog:  BPF program to pin and attach via ip route encap
+ * @encap_dir: "in", "out", or "xmit"
+ * @writer:    true if lwt_prog writes skb_ext (reader on TC ingress),
+ *             false if lwt_prog reads skb_ext (writer on TC ingress)
+ */
+static void test_skb_ext_lwt(struct test_xdp_meta *skel, const char *name,
+			     struct bpf_program *lwt_prog,
+			     const char *encap_dir, bool writer)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+	};
+	struct bpf_program *tc_prog;
+	char buf[TEST_PAYLOAD_LEN];
+	struct netns_obj *ns = NULL;
+	bool pinned = false;
+	int server_fd = -1;
+	int fd = -1;
+	int port;
+	int ret;
+
+	unlink(LWT_EXT_PIN_PATH);
+	ret = bpf_program__pin(lwt_prog, LWT_EXT_PIN_PATH);
+	if (!ASSERT_OK(ret, "pin lwt"))
+		return;
+	pinned = true;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup_prehook;
+
+	SYS(cleanup, "ip addr add 10.0.0.1/32 dev lo");
+	SYS(cleanup, "ip route replace table local local 10.0.0.1 "
+		     "encap bpf %s pinned " LWT_EXT_PIN_PATH " dev lo",
+		     encap_dir);
+
+	server_fd = start_server(AF_INET, SOCK_DGRAM, "10.0.0.1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto cleanup_prehook;
+
+	skel->bss->test_pass = false;
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup_prehook;
+
+	/* When LWT writes, TC ingress reads; when LWT reads, TC ingress writes */
+	tc_prog = writer ? skel->progs.tc_skb_ext_read
+			 : skel->progs.tc_skb_ext_write;
+	tc_opts.prog_fd = bpf_program__fd(tc_prog);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	port = get_socket_local_port(server_fd);
+	if (!ASSERT_GE(port, 0, "get_port"))
+		goto cleanup;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		goto cleanup;
+
+	inet_pton(AF_INET, "10.0.0.1", &addr.sin_addr);
+	addr.sin_port = port;
+	ret = sendto(fd, test_payload, TEST_PAYLOAD_LEN, 0,
+		     (void *)&addr, sizeof(addr));
+	if (!ASSERT_EQ(ret, TEST_PAYLOAD_LEN, "sendto"))
+		goto cleanup;
+	ret = recvfrom(server_fd, buf, sizeof(buf), 0, NULL, NULL);
+	ASSERT_EQ(ret, TEST_PAYLOAD_LEN, "recvfrom");
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	bpf_tc_hook_destroy(&tc_hook);
+cleanup_prehook:
+	if (server_fd >= 0)
+		close(server_fd);
+	netns_free(ns);
+	if (pinned)
+		unlink(LWT_EXT_PIN_PATH);
+}
+
 void test_skb_ext_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1436,6 +1530,15 @@ void test_skb_ext_cross_hook(void)
 		test_cgrp_egress_to_kfree_skb(skel);
 	if (test__start_subtest("tc_to_nf"))
 		test_skb_ext_nf(skel, "tc_to_nf");
+	if (test__start_subtest("tc_to_lwt_in"))
+		test_skb_ext_lwt(skel, "tc_to_lwt_in",
+				 skel->progs.lwt_in_skb_ext_read, "in", false);
+	if (test__start_subtest("lwt_out_to_tc"))
+		test_skb_ext_lwt(skel, "lwt_out_to_tc",
+				 skel->progs.lwt_out_skb_ext_write, "out", true);
+	if (test__start_subtest("lwt_xmit_to_tc"))
+		test_skb_ext_lwt(skel, "lwt_xmit_to_tc",
+				 skel->progs.lwt_xmit_skb_ext_write, "xmit", true);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 98d06ab340bf..8ec0ffd98da3 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1169,4 +1169,49 @@ int nf_skb_ext_read(struct bpf_nf_ctx *ctx)
 	return NF_ACCEPT;
 }
 
+SEC("lwt_in")
+int lwt_in_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return BPF_OK;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return BPF_OK;
+	if (!check_metadata(meta_have))
+		return BPF_OK;
+
+	test_pass = true;
+	return BPF_OK;
+}
+
+SEC("lwt_out")
+int lwt_out_skb_ext_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return BPF_OK;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return BPF_OK;
+	bpf_dynptr_write(&meta, 0, (void *)meta_want, ARRAY_SIZE(meta_want), 0);
+
+	return BPF_OK;
+}
+
+SEC("lwt_xmit")
+int lwt_xmit_skb_ext_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return BPF_OK;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return BPF_OK;
+	bpf_dynptr_write(&meta, 0, (void *)meta_want, ARRAY_SIZE(meta_want), 0);
+
+	return BPF_OK;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

