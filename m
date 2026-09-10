Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63818489FB4
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050394; cv=none; b=U6HPD1CJZl7AF66EfB45rWB9Iyf1OJWy7o9IViawbCARkhEk8dnYnvpjdOcZDlOK8cZvaQHYn5bDaTyidc8W+IUz0WNtvzYxOu5b65Em/JPzG+Z19MXN4554FnYsQYpZqTaXf4mekA/yjWwFt7urj75bPTJsM8/ZhT50mNzP2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050394; c=relaxed/simple;
	bh=idjd0XpKluSxLFQX+2XIDYxpVVBUBIHh3Ossfmv7ifY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbT+8go0bCcIiXGSG1YX+u9t3QxkRbjNJLJbxD4l08jafN1sG0hC20phx+nvrNdPqce9c7dRV07AO5BkKyb32LcR7bIdDSeOGlXET/XAfjDdm+NCNEATu/oTt0XcDgheexaJw3quqrBauFCSLBSFUMLQvJhzf/aUBprqUYhFJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FKIt39No; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FKIt39No"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d7eso21748521fa.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789050389; x=1789655189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSbzilpslCe/i/7LXye4xmbe80qorkEa/HcRS29f1+4=;
        b=FKIt39NoDSE7fZ1o+UrvV9G23psV90z7Wn/9tmUyrjh39+rFQwUSnb3JvUmoA1ULGb
         bvuv3bbvvvUYkpjZ2q0DWm3OLzl+ZNMvVjRys2SrzzQyBuY6/Z657/zg1gL/4a0RrRg5
         HwplQR4SE7g2SN2XX+lMnrnb9VrhmSjYT3uXuThgcsEQub3i5AHdnV0STF0Osj76Wkmi
         eTJaLsTiYivDdBGU3HKtdKaVX5JL1PbE4tJyMsXFp9deViEHYY2xMbmo9Cr0Kv+GZsyA
         FexHPlelLgMaBjwKITI9XR+2b13E0pGRoJ2mQ97QUhsti06y8vtkXyIBj2cAMh5xa4Ig
         k5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050389; x=1789655189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSbzilpslCe/i/7LXye4xmbe80qorkEa/HcRS29f1+4=;
        b=M33LaZvT1l9dLMLCeTXEc00ZMdJgb4GwVIeyBggQ96iS5q8UdWBxjPgdAxZEqcI7Cp
         sUxzIcIPS1wNUqg3k/1QwKaVT2BZkWhg3bUoUXG+JmE4VlXAI845die+bnX919TjsHkR
         MYH9aAkkYwVvFd36aj7bcnUDfdScokYNk/e5+L6p0afwOjD02Qse4AhKTHMsPVGIhOOS
         E2VMvIZO+1i9iPzwKcx49zS4FP+hxDmfdxpa5hmokZ92Zwg/wbTOIDKqoefgrRXtccXY
         btQrR2rdPdVlimXfqGpfObGt07I/7MduiWXwl9d+k7hu1CQ+z/b820thOMSmgsdBLy6F
         tSwg==
X-Gm-Message-State: AFuF++nrChHtB7f8Oy9tAW2HzNP0dz2j0EdBSPF2EG4Rbfv/bGS7nESS
	EyoAwtRizXgA8qyPpnWmafDlLQfAQAGRUWKkv3a71hjRrs1bGImifAOTQ5puu/7QohlaoSO81EE
	qn77wBRQ=
X-Gm-Gg: AYBFou0AksDWsZMQj5KSrQN0wd9sYahxBR0V2hzdv2QOKto/cf/cx6W8omYzG5ed/xc
	vdHtMACcbRDm64vsMiPeIDqLP0fqm4AecEwwDjnLWguE/M2bd2+5PUI+2fM1GceYsCxkmRIZdJR
	oV6BHBeZNuUdRbEZiXkJlIdYIuoRrtTXwsvhkHXgOLyVGrzpZfGvP0fyZdTGg9dgSuMZ2TonU9q
	LZpWblL51RBkWvwvXlACEksl4sDiKg5LCXVZM0Dm0xTYHVAgYO1XPib8edlQwN/j8SbDa2SrCIs
	4qpcERV3O8pxLSfJ3EBtUExcoW6vpqPbLG8pUl1PoVu0SaBZ7IMOBiOunTLNfyXZ7x5yxzsjgz+
	5/4hw3yli+CmhvwZn0sNgvVd4aS7UF6XlvuK51fJdY6wAlVsg8ZAGybE/bcYEbnOHFtXeDDYqyG
	VTG5XJRcXCKGqVQ+qjgiXXo6FTgsVXJou1BxV57A9rEAmKzpuzTkLiFz3ixacgndZeHF28WZ6EG
	psHqV3yB4uckWHr8H6KOKmY5qVgf7eSQG7IaZyFHDZ1auAO
X-Received: by 2002:a17:907:1c21:b0:c26:3107:71bb with SMTP id a640c23a62f3a-c292b1f3691mr1092866666b.24.1789048969258;
        Thu, 10 Sep 2026 07:02:49 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2622a7c677sm820412066b.9.2026.09.10.07.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:39 +0200
Subject: [PATCH net-next v2 04/14] selftests/bpf: Add tests for
 bpf_dynptr_from_skb_ext
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-4-0b21e42180b0@cloudflare.com>
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

Cover the bpf_dynptr_from_skb_ext() kfunc and the dynptr interface
to skb_ext with TC-to-TC tests on a tuntap device:

- write/read via bpf_dynptr_read and bpf_dynptr_write
- write/read via bpf_dynptr_slice and bpf_dynptr_slice_rdwr
- clone read via bpf_dynptr_clone
- error paths: no allocation without F_CREATE, invalid flags, read-only
  enforcement without F_CREATE
- double allocation: data from first alloc survives second skb_ext_add

Plus, exercise the verifier check for tracing and LSM programs that rejects
bpf_dynptr_from_skb_ext(BPF_SKB_EXT_F_CREATE) in these contexts.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../bpf/prog_tests/xdp_context_test_run.c          |  73 +++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 185 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/verifier_skb_ext.c |  77 +++++++++
 5 files changed, 333 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index ea7044f30adc..502f4504bdba 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -7,6 +7,7 @@ CONFIG_BPF_JIT=y
 CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_BPF_LIRC_MODE2=y
 CONFIG_BPF_LSM=y
+CONFIG_BPF_SKB_EXT=y
 CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 64ac49ad67e6..7724e82fce66 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -94,6 +94,7 @@
 #include "verifier_scalar_ids.skel.h"
 #include "verifier_sdiv.skel.h"
 #include "verifier_search_pruning.skel.h"
+#include "verifier_skb_ext.skel.h"
 #include "verifier_sock.skel.h"
 #include "verifier_sock_addr.skel.h"
 #include "verifier_sockmap_mutate.skel.h"
@@ -256,6 +257,7 @@ void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit); }
 void test_verifier_scalar_ids(void)           { RUN(verifier_scalar_ids); }
 void test_verifier_sdiv(void)                 { RUN(verifier_sdiv); }
 void test_verifier_search_pruning(void)       { RUN(verifier_search_pruning); }
+void test_verifier_skb_ext(void)              { RUN(verifier_skb_ext); }
 void test_verifier_sock(void)                 { RUN(verifier_sock); }
 void test_verifier_sock_addr(void)            { RUN(verifier_sock_addr); }
 void test_verifier_sockmap_mutate(void)       { RUN(verifier_sockmap_mutate); }
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 448807676176..252ac02de81b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -16,6 +16,7 @@
 #define DUMMY_NAME "dum0"
 #define TAP_NETNS "xdp_context_tuntap"
 #define LWT_NETNS "xdp_context_lwt"
+#define SKB_EXT_NETNS "skb_ext_tuntap"
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
@@ -331,10 +332,11 @@ void test_xdp_context_veth(void)
 	netns_free(tx_ns);
 }
 
-static void test_tuntap(struct bpf_program *xdp_prog,
-			struct bpf_program *tc_prio_1_prog,
-			struct bpf_program *tc_prio_2_prog,
-			bool *test_pass)
+static void __test_tuntap(const char *nsname,
+			  struct bpf_program *xdp_prog,
+			  struct bpf_program *tc_prio_1_prog,
+			  struct bpf_program *tc_prio_2_prog,
+			  bool *test_pass)
 {
 	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
 	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
@@ -345,7 +347,7 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 
 	*test_pass = false;
 
-	ns = netns_new(TAP_NETNS, true);
+	ns = netns_new(nsname, true);
 	if (!ASSERT_OK_PTR(ns, "create and open ns"))
 		return;
 
@@ -396,6 +398,15 @@ static void test_tuntap(struct bpf_program *xdp_prog,
 	netns_free(ns);
 }
 
+static void test_tuntap(struct bpf_program *xdp_prog,
+			struct bpf_program *tc_prio_1_prog,
+			struct bpf_program *tc_prio_2_prog,
+			bool *test_pass)
+{
+	__test_tuntap(TAP_NETNS, xdp_prog, tc_prio_1_prog, tc_prio_2_prog,
+		      test_pass);
+}
+
 /* Write a packet to a tap dev and copy it to ingress of a dummy dev */
 static void test_tuntap_mirred(struct bpf_program *xdp_prog,
 			       struct bpf_program *tc_prog,
@@ -693,3 +704,55 @@ void test_xdp_context_lwt_encap(void)
 
 	test_xdp_meta__destroy(skel);
 }
+
+static void test_skb_ext_tuntap(struct bpf_program *tc_prio_1_prog,
+				struct bpf_program *tc_prio_2_prog,
+				bool *test_pass)
+{
+	__test_tuntap(SKB_EXT_NETNS, NULL /* xdp */, tc_prio_1_prog,
+		      tc_prio_2_prog, test_pass);
+}
+
+void test_skb_ext_basic(void)
+{
+	struct test_xdp_meta *skel = NULL;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("tc_write_read"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_write,
+				    skel->progs.tc_skb_ext_read,
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_write_clone_read"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_write,
+				    skel->progs.tc_skb_ext_clone_read,
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_write_slice_read"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_write,
+				    skel->progs.tc_skb_ext_slice_read,
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_slice_write_read"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_slice_write,
+				    skel->progs.tc_skb_ext_read,
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_no_alloc"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_no_alloc,
+				    NULL, /* tc prio 2 */
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_invalid_flags"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_invalid_flags,
+				    NULL, /* tc prio 2 */
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_rdonly"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_rdonly,
+				    NULL, /* tc prio 2 */
+				    &skel->bss->test_pass);
+	if (test__start_subtest("tc_double_alloc"))
+		test_skb_ext_tuntap(skel->progs.tc_skb_ext_double_alloc,
+				    NULL, /* tc prio 2 */
+				    &skel->bss->test_pass);
+
+	test_xdp_meta__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 08b03be0b891..43840ee32d35 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 
 #include "bpf_kfuncs.h"
+#include "bpf_misc.h"
 #include "bpf_tracing_net.h"
 
 #define META_SIZE 32
@@ -689,4 +690,188 @@ int helper_skb_change_proto(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+/* Write to skb_ext using bpf_dynptr_write helper */
+SEC("tc")
+int tc_skb_ext_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, ARRAY_SIZE(meta_want), 0))
+		return TC_ACT_SHOT;
+
+	return TC_ACT_UNSPEC;
+}
+
+/* Read from skb-ext metadata using bpf_dynptr_read helper */
+SEC("tc")
+int tc_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, ARRAY_SIZE(meta_have), &meta, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Read from a cloned skb_ext dynptr */
+SEC("tc")
+int tc_skb_ext_clone_read(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta, clone;
+	__u8 meta_have[META_SIZE];
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_clone(&meta, &clone))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, ARRAY_SIZE(meta_have), &clone, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Read from skb_ext using bpf_dynptr_slice */
+SEC("tc")
+int tc_skb_ext_slice_read(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	__u8 *meta_have;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+	meta_have = bpf_dynptr_slice(&meta, 0, NULL, META_SIZE);
+	if (!meta_have)
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Write to skb_ext using bpf_dynptr_slice_rdwr */
+SEC("tc")
+int tc_skb_ext_slice_write(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+	__u8 *dst;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	dst = bpf_dynptr_slice_rdwr(&meta, 0, NULL, META_SIZE);
+	if (!dst)
+		return TC_ACT_SHOT;
+	__builtin_memcpy(dst, meta_want, META_SIZE);
+
+	return TC_ACT_UNSPEC;
+}
+
+/* Opening skb_ext without F_CREATE on a fresh skb should fail */
+SEC("tc")
+int tc_skb_ext_no_alloc(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta) != -ENOENT)
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Invalid flags are rejected */
+SEC("tc")
+int tc_skb_ext_invalid_flags(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_from_skb_ext(ctx, 0, ~0ULL, &meta) != -EINVAL)
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Without F_CREATE the dynptr is read-only */
+SEC("tc")
+int tc_skb_ext_rdonly(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+
+	/* Create and populate the ext */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0))
+		return TC_ACT_SHOT;
+
+	/* Reopen without F_CREATE -- should be read-only */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		return TC_ACT_SHOT;
+
+	/* Verify read-only: writes must fail, reads must work */
+	if (!bpf_dynptr_is_rdonly(&meta))
+		return TC_ACT_SHOT;
+	if (!bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
+/* Double alloc: data from first alloc survives second skb_ext_add */
+SEC("tc")
+int tc_skb_ext_double_alloc(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (!is_test_packet_tc(ctx))
+		return TC_ACT_SHOT;
+
+	/* First alloc + write */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_write(&meta, 0, (void *)meta_want, META_SIZE, 0))
+		return TC_ACT_SHOT;
+
+	/* Second alloc -- skb_ext_add returns existing ext */
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
+		return TC_ACT_SHOT;
+	if (!check_metadata(meta_have))
+		return TC_ACT_SHOT;
+
+	test_pass = true;
+	return TC_ACT_UNSPEC;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_skb_ext.c b/tools/testing/selftests/bpf/progs/verifier_skb_ext.c
new file mode 100644
index 000000000000..db43f1051400
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_skb_ext.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+__u64 flags;
+
+SEC("tp_btf/kfree_skb")
+__description("F_CREATE is rejected in tracing programs")
+__failure __msg("is not allowed in lsm/tracing programs")
+int BPF_PROG(tp_skb_ext_create, struct sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0,
+				    BPF_SKB_EXT_F_CREATE, &meta))
+		return 0;
+
+	return 0;
+}
+
+SEC("tp_btf/kfree_skb")
+__description("non-constant flags are rejected in tracing programs")
+__failure __msg("must be a known constant")
+int BPF_PROG(tp_skb_ext_var_flags, struct sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, flags, &meta))
+		return 0;
+
+	return 0;
+}
+
+SEC("tc")
+__description("non-constant flags are rejected")
+__failure __msg("must be a known constant")
+int skb_ext_var_flags(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, flags, &meta))
+		return 0;
+
+	return 0;
+}
+
+SEC("lsm/inet_conn_established")
+__description("F_CREATE is rejected in LSM programs")
+__failure __msg("is not allowed in lsm/tracing programs")
+int BPF_PROG(lsm_skb_ext_create, struct sock *sk, struct sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0,
+				    BPF_SKB_EXT_F_CREATE, &meta))
+		return 0;
+
+	return 0;
+}
+
+SEC("lsm/inet_conn_established")
+__description("non-constant flags are rejected in LSM programs")
+__failure __msg("must be a known constant")
+int BPF_PROG(lsm_skb_ext_var_flags, struct sock *sk, struct sk_buff *skb)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext((struct __sk_buff *)skb, 0, flags, &meta))
+		return 0;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.43.0

