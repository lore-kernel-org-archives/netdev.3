Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC51341D123
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695282; cv=none; b=RlmIU4VhSJ7lwwiLOo9miSPyFmAQd8G11mtsn2sYZKFt/bLLN/yahdv0EacFq8zHR/67Pd+k/A27cW4ajgoUFiWY3xf7TYiDVlNy7RVa5wvWOgNFElAJu0IOM48Q/lfKoqvVYYApW7Rh9mZwtYy48VYZ0Y6sq9Z2bqCLRZD9mgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695282; c=relaxed/simple;
	bh=QiUne7U+fQ23uVts4Nbuw4TPzvCHUGGYYTJAmeh0N3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BEvHs6U1SAuPE3QGYkMCmjLNylPH/DZO+CCEMdtgItDFlqEJTR/F+F5LfXJsgShB5i5eujS3dwfa76Xybc0vCLdfjRPzjFTKVeWrrFvXErIvcr33bgDGSacjgztz5xmDkCtskSdWtP359qw2w390AFjq4ISH5jwVXHkotslYieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FocEtcDc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FocEtcDc"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so1012761a12.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695271; x=1787300071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z28Gv9I4BVJxChINtqK4ree4CvtoXLVC0UM1x8G60iI=;
        b=FocEtcDccn2Mv5qdI+GiwA6remG3CLSnIMsihsAiRrCGi/+duPdqG6lrdOj3KPrlRC
         DDPm12GrYYi2SlTxMb5Wt2vMRQrEq3g83nftR5/xHniBJqrTk5CbTypishJr7SGJYRlS
         gEGp5rXl6Ai/oL++4iq4g8GxtN1CxWoZnXCQN89k+vtZsPufiAEFl5gQeI1zXiKxeaot
         rgt2UMv2nYkr7btvrTlMpre9JMOR4+inNWEIRkTCWNMxY4kBb5MChKaqP/pqoXiiYWXA
         9+lm1gC+IAwHRLaPRj8D7Sw96/lcxOyCqnNYuQDPgaROXuM4DLpWa8mCVAuFxoL6KCaW
         dHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695271; x=1787300071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z28Gv9I4BVJxChINtqK4ree4CvtoXLVC0UM1x8G60iI=;
        b=BMHGkLnYbeMJwGNuU+X9ssCRtJDm90vC4VNkRm3NeUSf4jN6rieJSdxPtfLVNzotE4
         Vbw5qKJTkGlTTTpvz7POl6fc+LfdL8gMhLZrW9O9EdBENNf75+6GGMkHNn+GvzwpKt/M
         ZqhhBJjhNJ0UXzKCnUKklIjmrHVdzorAtLdUVj0i0ZZsSWM+4aB+L/kB/BiEeC7CFmSs
         bbrZb3yWwT21sAFD7Frs62ziqijYRw91W1a9SAlZ/Nd1wGkXLM/abcUFbxVCVfCCMf/f
         nlembuEZOBIMfdD20irFqP6Kz/0IGIJaqyzVlkmsg+vJ2qbvZ19zRdbpx9npeYbywxSQ
         IvKg==
X-Gm-Message-State: AOJu0YzoAnQzcsu9gB2+qtuoT8DI+ce8L3xGo6nvsWf3i5nC2/vb/lQ+
	qhHtKIzQKicLEfDhwx8PX7QBCq26/8hosD39URIo9RCtI9Y6pLKA5I5IaJ3qAQCR6W8=
X-Gm-Gg: AR+sD1009D6G9TNXFxCSfawVKUYr5/rbMsAG+HUfL0DsV7LQkroEf9WwS1b4Fys3+W0
	OreYNxzrME7CTqM2Mk6nK2peg0I5AvhBtMg664H/E7zJSIPG2sIdehRzUMxhHqVFPQmn+XKMPDx
	IGvEPXuWZPpB2n5CJwhrW1G6BCo78MtBfJKXxt4JOqqXtb2ifL904qacwZoW7QEXTcjyuSC0d3A
	jxbSDKq+eG/xcX82PoWu13UJGVk5UFlPTLGfa4KOSDcnZh/+F+HcXUumCFdDII/3a4BLqmA37E0
	0aIfks/WlAZHFvCfLaPLJCks/1nB9/Slh54mTnSi3t98Ygt86DvmSAaZgRgHqkUMN9+bK/LW87y
	4e1wJDKupk6Hw4PQe0NBPaIO2JRDcBDQdubWVxibhB3lt6EjTa04f2FSjK14aUiWJZ/+GDGB5ot
	m3XwGnd1P11DsAsKkPAkYKdGk2os4xpAKRxXPdrb37kcZLn73e1hfjZqTtksUl2PUwdOxEw5CNr
	B12OOG2uKhB1YJZ6fiOBWE6Y9mV3hgUsrc+AQ==
X-Received: by 2002:a05:6402:52c9:b0:6a0:8885:e6f0 with SMTP id 4fb4d7f45d1cf-6a38a912827mr1543723a12.3.1786695270699;
        Fri, 14 Aug 2026 01:14:30 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38c9d5573sm513808a12.1.2026.08.14.01.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:06 +0200
Subject: [PATCH net-next 05/14] selftests/bpf: Test skb_ext on cloned skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-5-767edd862656@cloudflare.com>
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

Cover skb_ext behavior when an skb is cloned by TC mirred
(mirror to a dummy device):

- clone_ext_read: the extension written at tap ingress is readable
  from the mirred clone at dummy ingress -- the clone shares the
  extension with the original
- clone_ext_cow: opening the extension with F_CREATE on the clone
  triggers copy-on-write, so overwriting the clone's data does not
  affect the original -- verified by a tp_btf/kfree_skb probe that
  checks the original skb still carries meta_want

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 93 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 46 +++++++++++
 2 files changed, 139 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index fd340e5538a3..58b793cf14e5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -694,6 +694,95 @@ void test_xdp_context_lwt_encap(void)
 	test_xdp_meta__destroy(skel);
 }
 
+/* Test if skb_ext survives skb clone (via tc mirred).
+ * dummy_prog runs on the clone (dummy ingress).
+ */
+static void test_mirred_clone_ext(struct test_xdp_meta *skel,
+				  struct bpf_program *dummy_prog)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct netns_obj *ns = NULL;
+	int dummy_ifindex;
+	int tap_ifindex;
+	int tap_fd = -1;
+	int ret;
+
+	skel->bss->test_pass = false;
+
+	ns = netns_new("mirred_clone", true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
+
+	/* Dummy dev: attach reader */
+	SYS(close, "ip link add name " DUMMY_NAME " type dummy");
+	SYS(close, "ip link set dev " DUMMY_NAME " up");
+
+	dummy_ifindex = if_nametoindex(DUMMY_NAME);
+	if (!ASSERT_GE(dummy_ifindex, 0, "dummy_ifindex"))
+		goto close;
+
+	tc_hook.ifindex = dummy_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "dummy_hook_create"))
+		goto close;
+
+	tc_opts.prog_fd = bpf_program__fd(dummy_prog);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "dummy_attach"))
+		goto close;
+
+	/* TAP dev: attach writer + mirred to dummy */
+	tap_fd = open_tuntap(TAP_NAME, true);
+	if (!ASSERT_GE(tap_fd, 0, "open_tuntap"))
+		goto close;
+
+	SYS(close, "ip link set dev " TAP_NAME " up");
+
+	tap_ifindex = if_nametoindex(TAP_NAME);
+	if (!ASSERT_GE(tap_ifindex, 0, "tap_ifindex"))
+		goto close;
+
+	tc_hook.ifindex = tap_ifindex;
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "tap_hook_create"))
+		goto close;
+
+	tc_opts.prog_id = 0;
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "tap_attach"))
+		goto close;
+
+	SYS(close, "tc filter add dev " TAP_NAME " ingress "
+		   "protocol all matchall "
+		   "action mirred ingress mirror dev " DUMMY_NAME);
+
+	ret = write_test_packet(tap_fd);
+	if (!ASSERT_OK(ret, "write_test_packet"))
+		goto close;
+
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+close:
+	if (tap_fd >= 0)
+		close(tap_fd);
+	netns_free(ns);
+}
+
+static void test_mirred_clone_ext_cow(struct test_xdp_meta *skel)
+{
+	struct bpf_link *tp_link;
+
+	skel->bss->clone_cow_done = false;
+	tp_link = bpf_program__attach(skel->progs.tp_kfree_skb_cow_check);
+	if (!ASSERT_OK_PTR(tp_link, "attach_tp"))
+		return;
+
+	test_mirred_clone_ext(skel, skel->progs.tc_skb_ext_clone_redir_cow);
+	bpf_link__destroy(tp_link);
+}
+
 void test_skb_ext_basic(void)
 {
 	struct test_xdp_meta *skel = NULL;
@@ -742,6 +831,10 @@ void test_skb_ext_basic(void)
 			    skel->progs.tc_skb_ext_double_alloc,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
+	if (test__start_subtest("clone_ext_read"))
+		test_mirred_clone_ext(skel, skel->progs.tc_skb_ext_read);
+	if (test__start_subtest("clone_ext_cow"))
+		test_mirred_clone_ext_cow(skel);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 43840ee32d35..1b6bb20ee7e8 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -3,6 +3,7 @@
 
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include <errno.h>
 
 #include "bpf_kfuncs.h"
@@ -874,4 +875,49 @@ int tc_skb_ext_double_alloc(struct __sk_buff *ctx)
 	return TC_ACT_UNSPEC;
 }
 
+static const __u8 meta_zero[META_SIZE] = {};
+
+volatile bool clone_cow_done;
+
+/* Overwrite skb_ext on the clone via F_CREATE (COW) -- must not affect original.
+ * Runs on the dummy ingress (clone side), synchronously during tc mirred.
+ */
+SEC("tc")
+int tc_skb_ext_clone_redir_cow(struct __sk_buff *ctx)
+{
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, BPF_SKB_EXT_F_CREATE, &meta))
+		return TC_ACT_SHOT;
+
+	/* Zero out the clone's ext -- must not affect original */
+	bpf_dynptr_write(&meta, 0, (void *)meta_zero, META_SIZE, 0);
+
+	clone_cow_done = true;
+	return TC_ACT_SHOT;
+}
+
+/* Verify COW isolation at kfree_skb time: once clone_cow_done is set,
+ * check that the original skb still has meta_want.
+ */
+SEC("tp_btf/kfree_skb")
+int BPF_PROG(tp_kfree_skb_cow_check, struct sk_buff *skb)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (!clone_cow_done)
+		return 0;
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

