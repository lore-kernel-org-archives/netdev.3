Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A764B04B2
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595639; cv=none; b=b/hHkVg6u5PdcvyoUmXL0/TfxrNu0wo4kGQf1oTz09FB0UraJgotrVwwzUAsNoJsCzmE+hF5t0OaI7SaBkfuLp0QyIY2hPe6bxEX5IBylrBIPN+kHDonj+9sBtcv+m3exqNXG0saSomm8NQo7Uww4fWC2uiK6t9htwkBdoKOcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595639; c=relaxed/simple;
	bh=oxPb71Pzuv1G+imd0erFNgrQcUK8gklEHglOW1Q4TBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDOfydn3RaJpRXXgaBAChYKYEBulyLg0AduLVY3J7lrai64lvSlQgxX6GTpAoIGDZfp83kk2IP62Fy+2/8zzszjjOb+k07gSxvOcTuvTAh+Eh9E7+xhrh1BhCJwI57IcPRmX3+/MGOxZ8llxlLmHWqqMIxrAl0xb9j6NCedVD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RbdsOFNW; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RbdsOFNW"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2dca989afcso166484466b.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595635; x=1791200435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+OA0GWoa4ixfoYDT5UKqGDyWWsW4lA6Mg1fZuacd8Y=;
        b=RbdsOFNW0M89fvvHF/9dt1jNEqe1KuGdvP5tP67PUWuJme973OYPwO7NF7MJz6n6jD
         sDBfVfVA+Eub5nk+bGZh9NplbyR/5ZQJeIHa5o/hxBHGQeiY0x077yq6EjFTx50jKckU
         ikczC5T8Tjj+ONuddpdg4Ehn08HRGJ1ZLeMClhEl/Ll1w520mP3oZIClNbYAI40fBppo
         89gNgFZU0hKGA0nhzeLiKuiKBH1p3i9ttvYnVLvtaGBu/70hajekMxzE6bOBhMyGG/m6
         3jDJY90V4s4ZASEO/rgxIKVdfCKDNZeYXRtFbt5wBMXl9EicF4KBxWgCDa7ifdOVqZAY
         GG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595635; x=1791200435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+OA0GWoa4ixfoYDT5UKqGDyWWsW4lA6Mg1fZuacd8Y=;
        b=bFXAaB5Ahmd1AThU7Yq+p8q63GOidYBsDCFU6rkUDr7LxEHCNSD3rrqX9b8j75j9ps
         WVsLLOFIyBoPReP3A/xWnN5Goej89rdwgm5iyMOg6z4dGU7i9I3Frblwh4E1XTxwzOxW
         0pH6r7EFBc6wraUlpLCwWKdGTh3jTnhJEHDJ7/VyZZnGO4p6nJepxarr1JYiMWm5TcWM
         Myl9DAVlx0xCE5oHhyctVYOl7Tv4usNa9U1gjJOKbDgT9yHPIPepJJVKiTYOQ3nFgcil
         hlRFYkBiGvcGSpY2CrBjsf3RFblG5rbL0H3UAZS7zx0vrBMLZSH5JRTO+T43VZwr9RHW
         7L+w==
X-Gm-Message-State: AFuF++lwmtGYwsLaS2bWZzZIgugB0g7HIzXvIJeDx2gwlIjG4NvwaeQ6
	STynoSmGOrSGFZuLt7BTuepRXenxPXyu8G8nP3wkjU+S9mxeKt2VoAySEvKg52WF+W/wvomRnvL
	BjJi9pV0=
X-Gm-Gg: AYBFou2qsOdzkLhkDmwuZUx9U7qVRWG0TN2iLkrFGV8MslrNsIB/zQGuwRmvdHvTttJ
	nPsdSkbnzrKX96NubwwTk8RHEMhPDZRtNfAySaKbH4U0lsHBgEiZOXyftn3ATgUWLrcD+KqK80T
	WerGkSp4+nXt0Febvl23yBrAc/CwUHJUvYU4BaUUUHzgdbYmDH+NfQ9gvEKujJRmv/6m0SRTT77
	QBX1gaILEya1Zq2gDstjmLRXJh7sLmkSDfN/KYEmdN2yuouE6cUuSJyayROB0wWc3v9hPc6HFZz
	dbFOdb7hPeNQPJOYjv/UhhAzgIFueCEF9gfKSeEk4VFuigkWVHnAPDVEDfX1NpICdABQvIXE026
	gSdHwkr1jsxrDh3DkYY85d/Sgp07fy5bnz5gwf03VcuX+/uxzVCoZbEjv15vTKe/EiuJOgpzHUz
	TCYxPmA0i8SRTMveLBt+8v5LQ4tgnMr5CcFDvhIDvi3Vqss0zmWJj/HIbHeoECgLlLZfX+0j1H5
	QLbsVMzWADMuAJbC/X5HjIApv3j8ZfxFg4uqzTx5xjiPQPVd8UM9wLfraAc3MGNGctq+QQxisRf
	g1l9k3/VOXwCAA==
X-Received: by 2002:a17:907:c310:b0:c26:1691:b36b with SMTP id a640c23a62f3a-c2ac2509b6bmr1109095866b.36.1790595635454;
        Mon, 28 Sep 2026 04:40:35 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-c0dd-2af4-566b-b23f.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc1f8413dsm239340966b.55.2026.09.28.04.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:26 +0200
Subject: [PATCH net-next 09/15] selftests/bpf: Test passing metadata to
 kfree_skb tracepoint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-9-844dbf3e1edf@cloudflare.com>
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

Tag the skb at cgroup/skb egress, send UDP to a closed loopback port so the
packet is dropped, and read the stashed metadata back from a
tp_btf/kfree_skb program.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 91 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 43 ++++++++++
 2 files changed, 134 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index b90ae0a6156d..890a881a6a1f 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1268,6 +1268,92 @@ static void test_skb_trace__tcp_ingress(struct test_xdp_meta *skel, const char *
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
+	struct bpf_link *put_link = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd = -1;
+	char buf[1];
+	int fd = -1;
+	int ret;
+	int i;
+
+	put_link = bpf_program__attach(skel->progs.skb_free);
+	if (!ASSERT_OK_PTR(put_link, "put_attach"))
+		return;
+
+	cgroup_fd = test__join_cgroup("/cgrp_to_kfree");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	ns = netns_new("cgrp_to_kfree", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto cleanup;
+
+	skel->bss->test_pass = false;
+	skel->bss->free_count = 0;
+
+	cg_link = bpf_program__attach_cgroup(skel->progs.cgrp_meta_write,
+					     cgroup_fd);
+	if (!ASSERT_OK_PTR(cg_link, "attach_cgroup"))
+		goto cleanup;
+
+	tp_link = bpf_program__attach_trace(skel->progs.tp_kfree_meta_read);
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
+	if (fd >= 0)
+		close(fd);
+	bpf_link__destroy(tp_link);
+	bpf_link__destroy(cg_link);
+	bpf_link__destroy(put_link);
+	netns_free(ns);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+}
+
 void test_skb_trace_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1284,3 +1370,8 @@ void test_skb_trace_cross_hook(void)
 		test_skb_trace__tcp_ingress(skel, "tc_to_lsm", READER_LSM);
 	if (test__start_subtest("tc_to_skops"))
 		test_skb_trace__tcp_ingress(skel, "tc_to_skops", READER_SKOPS);
+	if (test__start_subtest("cgrp_egress_to_kfree_skb"))
+		test_cgrp_egress_to_kfree_skb(skel);
+
+	test_xdp_meta__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 4da50c848beb..9ff6ef4b7f3c 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -873,4 +873,47 @@ int sk_filter_meta_read(struct __sk_buff *ctx)
 	return ctx->len;
 }
 
+/* Write skb_ext from cgroup/skb egress */
+SEC("cgroup_skb/egress")
+int cgrp_meta_write(struct __sk_buff *ctx)
+{
+	if (!is_test_packet_tc(ctx))
+		return 1;
+
+	write_meta(ctx, &meta_map);
+
+	return 1;
+}
+
+bool write_once_done;
+
+/* Write skb_ext from cgroup/skb egress -- only the first matching packet */
+SEC("cgroup_skb/egress")
+int cgrp_meta_write_once(struct __sk_buff *ctx)
+{
+	if (write_once_done || !is_test_packet_tc(ctx))
+		return 1;
+
+	write_meta(ctx, &meta_map);
+	write_once_done = true;
+
+	return 1;
+}
+
+/* Read skb_ext from tp_btf/kfree_skb -- tests survival until skb free */
+SEC("tp_btf/kfree_skb")
+int BPF_PROG(tp_kfree_meta_read, struct sk_buff *skb)
+{
+	__u8 *meta_have;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &skb);
+	if (!meta_have)
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

