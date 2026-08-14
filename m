Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269F446857
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695289; cv=none; b=oRX/DVVp6lktq7ZyHc0KmhV5RUjvCEFF7l5/VRBJ19Va8dY8fs9nokC9vMCQWLaDZtVaQwsX+GpM4PKKgoFArScOc04L6bO99XWuHm7OONvBME5gE1kt0RnJu30ZKgTjdGAuCikskPiaJ60TIbqBEibsRshnT0HP9J42oLNVDSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695289; c=relaxed/simple;
	bh=XYJaaV6RZ2aCIdSZZp3UOKwoSCacrsxDSSu5mwKR1/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jl7Uar9TTeZCfiAhXkjPYZ4r6JD7LTbJx0BeyAPPE07afvlNX4DJHKgZZA/TEYBtIBsrUl6mjzZGEQRap3DqElJmhBXhtOAHiBnCxGIIg9qOB71WBENjjGS59shOD/7CBbbRXUGejDymTqigdWXuNhAKcTCHpcm4+ixr/UoziIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KcD4ZaQA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KcD4ZaQA"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15c42a45adso268412066b.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695281; x=1787300081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eVWgO9L7od1ZdDLD/qLThejWQzHxo+90HVB2YhHUZDE=;
        b=KcD4ZaQAMwr3MDs/7MsxjwQI3WRHrYwXCcozcFdLipJTIHvZF3g3PyTtxEb/A95JX6
         fyb9K6B039+p+Wr91o8mW7k1QdMCB/JSmsoPne30lNrkHeCa3cnPKsqizSg27djQNhb7
         H55JKVU+K7xthrbRRZYJaRGE79yjluz0dCYNLv+P3mcPxvZfet0LBVYB1LcfKmOeP9N6
         xQa3kp5SlfwDTM0uDdhEWdQt4QXi7tmcrCED26/6jGdfUUv/b6asf2SGQFMxcj1xWE/Z
         wk3Kb/hyTihLh2AkanaFFY36VA7T8zPRQPvRAovu8zyoU7VSEabd5w9S71dHAPoTD4Qh
         xVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695281; x=1787300081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVWgO9L7od1ZdDLD/qLThejWQzHxo+90HVB2YhHUZDE=;
        b=PYbF6yT7d8SvyISNXLBhVeJ8f/WGQpq324bvO2XFbOpibQQxUpiEVfLoGU/0lqPSA3
         OGlqJKhkspEIGWOFJvMEBYdBtKjD77jh7710mcCddXxwG/lASF3USP+fcu28KorRLZEd
         ZjC5Zfga95q6vbnFAKImrzwPD33lnO6i5zt3N49iw8dw2WbddvacT+FbQspbmFHfHGfl
         miw6NKDleImyD804LWRozxOE+ovjRVdIeCdGz2OjNcBQ9kHVwXTqwTNjAUd7JnTB+Lm0
         a18s7vsi1mQ9iB8sCkX1GmV8UUVUqveD+hAyXjtT3Fxa/3MB7HPW4yPzyOW44HTJROod
         Bw3w==
X-Gm-Message-State: AOJu0YwdXClbWtPihXE1pOvhBcLRxDGvZwcLBzNeGtOWdyX7A3OlxsV8
	fGjhJ100eKlz3EAtDm9BgH0Zsloedsc9qni4iCfNMdQkrla5SQ4majv81tp2Lc9xBtk=
X-Gm-Gg: AR+sD11Pn+3PmRkKzvNb9tPIEmDOaQ0HVTrZ2mDbPCC5evTwELVkZGnUIUgSPgpxl0+
	FdlZlKECDv8Ci6Yz53qBxx+h/Ob15u4zLa5lcu72kH02xssZMHfgkyb28J1TDOsICjuhYlmaQcS
	zTxOz4Q8dox/vxC9OV7ZR1Rgel0wzLKvjKHHRgMG9Fy+9tqEfNKQTGKBrcnCMvBU6gb3l7HKyai
	o8NAUVql2LnmcEk+kPDvBKAszWfjTIV/QU+QBB/FPa4GAVvSbgprJU9rn/UuLA/NeIr8sRVByOd
	N0qSY8psgO839jYZ61v54fPfJ8tZ9Bsan5soYMzbwBzWOssi8Mjb6+lqO187Fj6DdRRoFGjZL6n
	LhLBZqAvExsJdJJUdzZh41kHu8/2oDtUn1phqvpoOT8u2wgaBc99M757jYpXGN3p64VOpoEBXdL
	PgCSWg+sby+K3/bxLOsDsyrYlhC/KFrCu+V4SPPH8z8k/t35Is5lhZqVu0rByQfpR7IvLjXfAsg
	bzW0d0C63DHSP2PvdGyUXU00Bj7ujJZQNiiPA==
X-Received: by 2002:a17:907:1c88:b0:c12:3cbf:9f6d with SMTP id a640c23a62f3a-c212a22e0e4mr192756366b.1.1786695281460;
        Fri, 14 Aug 2026 01:14:41 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c212378fffasm77941666b.36.2026.08.14.01.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:14 +0200
Subject: [PATCH net-next 13/14] selftests/bpf: Test skb_ext read from
 sk_skb stream verdict hook
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-13-767edd862656@cloudflare.com>
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

Test bpf_dynptr_from_skb_ext() from sk_skb context. Write to skb_ext from
TC on loopback; read from skb_ext from the sockmap verdict program.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/prog_tests/socket_helpers.h      |  1 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 79 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 18 +++++
 3 files changed, 98 insertions(+)

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
index 5f9247941aa0..f5fbc19757e3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -4,6 +4,7 @@
 #include <linux/ipv6.h>
 #include <linux/netfilter.h>
 #include <arpa/inet.h>
+#include "socket_helpers.h"
 #include "test_xdp_context_test_run.skel.h"
 #include "test_xdp_meta.skel.h"
 
@@ -1560,6 +1561,82 @@ static void test_skb_ext_seg6local(struct test_xdp_meta *skel)
 		unlink(SEG6_PIN_PATH);
 }
 
+/* Test skb_ext survival across TC ingress -> sk_skb verdict hook.
+ * TC ingress writes skb_ext on loopback; the verdict program reads it
+ * on skb delivery to a socket in the sockmap.
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
+	n = recv(c1, buf, sizeof(buf), 0);
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
@@ -1591,6 +1668,8 @@ void test_skb_ext_cross_hook(void)
 				 skel->progs.lwt_xmit_skb_ext_write, "xmit", true);
 	if (test__start_subtest("tc_to_seg6local"))
 		test_skb_ext_seg6local(skel);
+	if (test__start_subtest("tc_to_sk_skb"))
+		test_skb_ext_sk_skb(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index c4ea38d79533..4c224d5fe1b2 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1152,4 +1152,22 @@ int seg6local_skb_ext_read(struct __sk_buff *ctx)
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

