Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98704B0E34
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595641; cv=none; b=X06X6NwouTclROGVhN2y2R1VKovRZrmAL0JGlmLPbMNOAYKT3o46rpPJ0jVOY/iyWPNRo38aw+gt9Ej53aSEg+5vgtLqF++FxPaLPSJzrv9Hc33T0frQIuWaSf5/rG5zdNDJwpygLTit7BHNA5cc4GBvf2Nv4kSHRjb0eyBqLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595641; c=relaxed/simple;
	bh=B7Bc00WuRfwzQkHbx/wrtPAk7y8Au+RTrsFDT8CH4fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZyxX5rJo+LxrsKDGplo9RFvwWCPuFs2+ToJrYW27FvoqMNcyjbsGgQ+EByHv0vIlpv02dR/q16S8KQeZTLnG2/za3KKDOaERBciro9dPz+EZWpk4WovVlJyWCUt2fhwjAeFKVTwkOHx5C+pBxRdW3wtE6rLNPDFb/QEhM/+LXHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gC19/46f; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gC19/46f"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso4059629a12.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790595638; x=1791200438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVAJ1NgEXnSaT90SAJ2mbWCptUlBge8LdG03UtznJjU=;
        b=gC19/46fGxemi2idqibZ3d183UobUNPfrED7xGxGEbduX9un6IDiBKschkOgROIFri
         al2YCtXIbZxCX9nSd0oAL8mKiIrMS1H0+NEPHdhyeiHvvyDs0S/3IIkS6pNgZyDrQpnp
         waFdCu7olTUaG9MPqJtE5CwpoGeMReEN4T+ydW0zMGSN4lFinj94VqsamCP/9/Oa2+bi
         ARzJdR7gKLXY+d8xU+6+aPbErHTr2UQYT1+EkY/6LIalN3SEiGLdQMHrzXK5BQOwt/w+
         PX/Srjn3KfKegrHGhdo8w7SqQOGl0xyclwmp4hm+3Bai6HmzVCeTWKyoUL5aoazrGVA1
         yBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595638; x=1791200438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVAJ1NgEXnSaT90SAJ2mbWCptUlBge8LdG03UtznJjU=;
        b=QOjY5YXhhjry0eKVbhgrzjn+VsncnTvUuzDwLbTyVeWq/npRyiY8/e+1DcDYiZS7/O
         WA3P8HolcCWaA8Sloo8YAm0Pgib//CniU5UFyk+VHMdOOyxaDIiPR8SC+LcSNWpYiIss
         ESIh+48zuQUauFuXraTfevGGdzCiqI6WAwHS/BOmt81uciMe0sqKKx3IyvGWNN/xctIB
         3x2YHFMr0qjAbdKZes0Pxb7yQ4+fuUSfcI4/G4e6hnK1DW9sCn5H17hAx5z9TK5/PvxN
         R9VpoPgnmtQY7SEo9aP7NoYH/bex5x42gDg46yteHMGBVc/qeJGkT+2brSs8a/72nd+B
         N6Vw==
X-Gm-Message-State: AFq9FYID7FNJ0fF09/zoBqj8SfvPuRiovwhnXyYuL5l/1XkZPdkeVns9
	GDC5ybD4iNsGqkynTKMDE5v4KZBEB0lpZKgptVobh3vWGvptphr4aieSjcVg1xD9Aq8=
X-Gm-Gg: AYBFou26d8cBEr9nWkEJYbJruWZCuvBCv+Wzu0J99SX0tqTLZKBo6kPa+BXlL7VfD4Y
	mDFXmqSsxIPjd+Wy1hfaKlm8/iQhs63l4AUOXrXJpey5n4vLeIHSdv8YdGMJZtDy57qUIIHdLaL
	/c1+hzwPz2v2tUIC5KZGCfmVUzNacWB1X1NQkR7YIDNWLqG7LjswDDITnpsK+Ks1Qxmuher1Uee
	rK1Fi53sXXitT0aaSmfXuDsf8hi0ooVJVd/uS4+xJnh59+CtcYvQeDQxwX3ALb8IPr8tvIa9Wkj
	wgSXGV0BmhVVB6Hy/JdJ8F/9/Yj4yg5cT3/i3wBasWOFEbdTzZEvSFEtfFnVe4B13shuhBUYeEy
	+c/76Xa4mZI4yh1T4QrMIwERndpvuKeL8z5OSdryBFwuuHEcq7pYISlP9xXHMqIYCpes4b3PrKk
	Ymr33aNG67xaDrIGRWD5yx3dT1zPMg64PzOzEtnXCmZFzcdOBcO/qBwJS+2Ta+H39Oe4TlJ8vVZ
	pa1UOo=
X-Received: by 2002:a05:6402:360a:b0:6aa:f1d2:ddbf with SMTP id 4fb4d7f45d1cf-6aaf1d2e1e7mr6600902a12.35.1790595637941;
        Mon, 28 Sep 2026 04:40:37 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:491b:1300:c0dd:2af4:566b:b23f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dc0cddsm4016637a12.14.2026.09.28.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:40:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 28 Sep 2026 13:40:28 +0200
Subject: [PATCH net-next 11/15] selftests/bpf: Test passing metadata to
 netfilter hook
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-bpf-meta-gated-tracepoints-v1-11-844dbf3e1edf@cloudflare.com>
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

Add a TC -> netfilter cross-hook test for the metadata stash. A TC ingress
program tags the skb on loopback, and a netfilter program at
NF_INET_LOCAL_IN reads the stashed metadata.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 74 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 21 ++++++
 2 files changed, 95 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index ac5c0f067b3f..eb0d36e7a45d 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -2,6 +2,7 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include <linux/ipv6.h>
+#include <linux/netfilter.h>
 #include <arpa/inet.h>
 #include "test_xdp_context_test_run.skel.h"
 #include "test_xdp_meta.skel.h"
@@ -1566,6 +1567,77 @@ static void test_cgrp_egress_to_kfree_skb(struct test_xdp_meta *skel)
 		close(cgroup_fd);
 }
 
+/* Test metadata passing across TC ingress -> netfilter hook */
+static void test_skb_trace__nf(struct test_xdp_meta *skel, const char *name)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	LIBBPF_OPTS(bpf_netfilter_opts, nf_opts,
+		    .pf = NFPROTO_IPV4,
+		    .hooknum = NF_INET_LOCAL_IN,
+		    .priority = 1);
+	struct bpf_link *reader_link = NULL;
+	struct bpf_link *put_link = NULL;
+	struct netns_obj *ns = NULL;
+	int server_fd = -1;
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
+	reader_link = bpf_program__attach_netfilter(skel->progs.nf_meta_read,
+						    &nf_opts);
+	if (!ASSERT_OK_PTR(reader_link, "attach_nf"))
+		goto cleanup;
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
+	netns_free(ns);
+}
+
 void test_skb_trace_cross_hook(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -1588,6 +1660,8 @@ void test_skb_trace_cross_hook(void)
 		test_skb_trace__tcp_egress(skel);
 	if (test__start_subtest("cgrp_egress_to_tc_egress_fclone"))
 		test_skb_trace__tcp_retrans(skel);
+	if (test__start_subtest("tc_to_nf"))
+		test_skb_trace__nf(skel, "tc_to_nf");
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 50aa045bcc22..d85b60c24f73 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -988,4 +988,25 @@ int BPF_PROG(tp_kfree_meta_read, struct sk_buff *skb)
 	return 0;
 }
 
+#define NF_ACCEPT 1
+
+SEC("netfilter")
+int nf_meta_read(struct bpf_nf_ctx *ctx)
+{
+	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
+	__u8 *meta_have;
+
+	if (!skb)
+		return NF_ACCEPT;
+
+	meta_have = bpf_map_lookup_elem(&meta_map, &skb);
+	if (!meta_have)
+		return NF_ACCEPT;
+	if (!check_metadata(meta_have))
+		return NF_ACCEPT;
+
+	test_pass = true;
+	return NF_ACCEPT;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

