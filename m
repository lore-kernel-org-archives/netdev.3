Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283092;
	b=S0Jy4asi5JJyHDdEyRHELP1OtaoMd5k2EyISdrdW+NMCeIBo0epVn6ngitMXt8SC3+oS
	 9apwzdshXK3Si5tKtNVGaLx2CtRIysNbEyAZ1ikPTPexVFZQ8qz4uX1VqXi/FNn1UeAYc
	 QX9X2gT6Y9g1ADHVgDQ/cccfJQu7v3+BEqkV6Lp9Gtx/ptWrs1tubrhbr9I3X973K+Qiz
	 e3oAH5RYhsYkgllzE0Z1hnjzvk+c/gU00NElml3knkA/MpLroUIEUiffOQRe4hALrQDXG
	 1FNdW9A11pIjCVes7kFiCJ7CVSamUE6l5PHiCxy/tcwJKw8lMz8ELRWJqOJFQJis/BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MSk1Tsr4MwxHYw7iRh7y9cNVx4+IdLtKhJgZHhSE8Jo=;
	b=zoGWL5UuoNjapfhXdQewxdlvrYv8K8iql+U1HSTfWxgD6QTlfdqBIE8BgZLHGooBWi/0
	 v0NuNha+QR9iO0mbSnCP1gwhPzrE6tcF83KnZcXqOxS/Qbjdw98bF5Sv/3+GyyXWHkCFK
	 INJGE8zNQx/d569BLdrgZMeb4uuFOT5yJkAlvzLu+B9X+mJ7mAEUzdzCWh8vuJo86E0ye
	 gfLwVkpRaNXsfK5yuwo+3lP3LjC+d3aq5Ug628E7PX3HWh6/4VUhfvK8At3hNaI0RvZYF
	 B64lCM5bWHC6/yw+MbTkIUsS8AI92pr+/yrpfqf8kD85C0Fyy1k+8sNpWnVO3gc5y0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=UQp73qAG;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0960A5BE0
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C0960A5BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=UQp73qAG
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so1742946a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 19:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283090; x=1794887890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MSk1Tsr4MwxHYw7iRh7y9cNVx4+IdLtKhJgZHhSE8Jo=;
        b=UQp73qAGGfIXkMkoZdae4O4MEuyXs9A8yF9DoGxrfX96OQSLEPSt04bP7TR1S3SLAz
         PV0jhQwOGM0N7/GPg1saqkQ1IubsOC5rH1nfnrzQQB9sTcd+a89qSxOTPNj5o9v+3pI8
         QbG4bnaC2W9wZFtsAIZJKG17XlEJQfDOIHPRgbdgWKVoDjUX/1es0DbX7bEKMK0ETE5G
         HaJIe6N4oXBFDQQbJnkUmBGhdrNsoLcALj0Q7a+oDNScA2v4lufrqEV4xUcyBwwTtdDw
         TYfz7GaxzLZ/sW9tyI4ovZAFvscq3eS96Y6l0o+mYu4Rd/cSwGm48ogEpv+yCZLTxH4d
         65qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283090; x=1794887890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MSk1Tsr4MwxHYw7iRh7y9cNVx4+IdLtKhJgZHhSE8Jo=;
        b=XjgkGHYmt5Rm26q56g0yMOYcaxAEOklGRS0HKNAUCjd0IB+Q55LHpW3OWehZ3orML7
         XtpmmhyOf+Izvv0QeYm1SJSWmQ3G9CI/s6fg+/es811r305AQPFrQRCnMZf5EVjbrG2P
         JJbzGFi8SJ6l0Nb578FWcYnJaVeyHv17xh9SsCqQzShbof8ghoSgaa7Ck8LzRo2dj2lk
         QPLw0jCGzQKyQfLSIYzw+zon+Lv/cJlMV2rrRQItlByyN3SApPgW0/KHeMWJm4IV4jGs
         zn0upzEd126NrM6C2bMmrmgBGRnNeNF3kt1O3Pyjc+r5wZZsRI1kCBCSiXEEoqLBO3yT
         3q7Q==
X-Forwarded-Encrypted: i=1; AL+hErGbP5wU8qW9js0ZYTtFyPxnNGowgmWZ3H4uFqu9ENIJ4frYraLWwKpnyDdiQTsk+IwZHYCOvHo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jgwxaMONdNpE0T0y+R1aMV8kDToQ74mCGHyDtMcecR5kmpwf7
	nMPV9arhhi1kfu2OC7q9MYPwvtek/et7AGzXv1WKbmLvUznhb53OHJXuzWR5J+QYyX0=
X-Gm-Gg: AYBFou2rHaiYj6LF3g4LLdzYMwjtcQD6WzPiAXYgIvOCE3oYExKGL4F0YwtKAZHxz63
	dB1ofOa0/d16TW5yqbrGodPYb1nxH/KKRIVRNh06wl3zTfFaA/IBc+Dgx+Q/v/gQMzlkVNnEnVo
	pPuumbVJBEPM9g5ccP16gYwixZPpaHhGVOzbH3GIn8KVjevYXm+kh6OkKNfQvqZgwKHXAYRRNnb
	l61UJPoHHLnTZVQKjiqj/i7ksH/Sg6SvzKA15VsNAdn3WGUWDzikQvC0V3/S+cBkDQ3z2zt0NVO
	VbGNkWMCMJFZJFWwZz32ygL7ANo9iwa2uon/GWl1XKgzK9BES2mvQr5QFyMFPPSh9N6O/DVB+sb
	kzG1VhI3ACdZ9Cp5ySiuR3QM1uYpVyqS1z3XpwHvPXCqz86svNPCR2b6nVr9jmZlCnh76RIA76J
	gwY6QdbtlOQuT3YFWIJct7AqXhmflLfnK1lTm9QYHNALDIUrseM/M3A43gPcV06ieFnzKuOxOwD
	u6JyQCLKJSWvKgbmuiCeKKdngiBvvqeI1Zz20chCLix/lnu1aa7coeKeMewyZrRmE2/8b3TwtGn
	yC+5a5DFoNA+x7Hlh/9pdfzP4EjLdYu4+HYtZ+EpMVN798wYy4dpv6KBSC7mLNjX
X-Received: by 2002:a05:6402:5626:b0:6b6:efc4:9eb2 with SMTP id 4fb4d7f45d1cf-6b7556282afmr914079a12.0.1794283089889;
        Mon, 09 Nov 2026 19:58:09 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.58.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:58:08 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	llvm@lists.linux.dev,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH bpf-next 14/15] selftests/bpf: Test the load kfuncs on cpumap and veth
Date: Tue, 10 Nov 2026 03:57:12 +0000
Message-ID: <87e20fe4ae289764205f33920e90f3283a478e8a.1794281983.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for the load kfuncs on each path of the xdp_skb_ext_to_skb
test. On XDP_PASS, the program that stores the values reads them back.
On cpumap and veth, the program after the redirect reads them. Each
test case compares them with the stored values. A load that finds no
entry, also after bpf_xdp_skb_ext_del(), must return -ENODATA.

With BPF_F_TEST_XDP_LIVE_FRAMES, a recycled page still holds the entries
of the previous packet. The live_frames test checks that a load returns
-ENODATA there.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 .../selftests/bpf/prog_tests/xdp_skb_ext.c    | 47 +++++++++++------
 .../selftests/bpf/progs/test_xdp_skb_ext.c    | 50 ++++++++++++++++++-
 tools/testing/selftests/bpf/xdp_skb_ext.h     |  2 +-
 3 files changed, 81 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c b/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
index 64c6f0268d60..0811c09b7747 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
@@ -7,7 +7,6 @@
 #include "test_xdp_skb_ext.skel.h"
 #include "xdp_skb_ext_success.skel.h"
 #include "xdp_skb_ext_failure.skel.h"
-#include "xdp_dummy.skel.h"
 
 #define XDP_RSS_TYPE_L3_IPV4 BIT(0)
 #define XDP_RSS_TYPE_L4 BIT(3)
@@ -167,7 +166,9 @@ static void set_case(struct test_xdp_skb_ext *skel,
 	skel->bss->want = c->want;
 	skel->bss->del_hash = c->del_hash;
 	memset(&skel->bss->have, 0, sizeof(skel->bss->have));
+	memset(&skel->bss->loaded, 0, sizeof(skel->bss->loaded));
 	skel->bss->store_err = 0;
+	skel->bss->load_err = 0;
 	skel->bss->pkts_seen_tc = 0;
 }
 
@@ -191,8 +192,6 @@ static void check_have(struct test_xdp_skb_ext *skel)
 	bool unnecessary = (want->fields & SKB_EXT_FIELD_CSUM) &&
 			   want->ip_summed == XDP_CHECKSUM_UNNECESSARY;
 
-	if (!wait_pkt(skel))
-		return;
 	ASSERT_EQ(skel->bss->store_err, 0, "store_err");
 	ASSERT_EQ(have->hash, want->rx_hash, "hash");
 	ASSERT_EQ(have->l4_hash, !!(want->rx_hash_type & XDP_RSS_TYPE_L4),
@@ -208,6 +207,24 @@ static void check_have(struct test_xdp_skb_ext *skel)
 		  "csum_level");
 }
 
+static void check_loaded(struct test_xdp_skb_ext *skel)
+{
+	const struct xdp_skb_ext_vals *want = &skel->bss->want;
+	const struct xdp_skb_ext_vals *loaded = &skel->bss->loaded;
+
+	ASSERT_EQ(skel->bss->load_err, 0, "load_err");
+	ASSERT_EQ(loaded->fields, want->fields, "loaded_fields");
+	ASSERT_EQ(loaded->rx_hash, want->rx_hash, "loaded_rx_hash");
+	ASSERT_EQ(loaded->rx_hash_type, want->rx_hash_type,
+		  "loaded_rx_hash_type");
+	ASSERT_EQ(loaded->rx_vlan_proto, want->rx_vlan_proto,
+		  "loaded_rx_vlan_proto");
+	ASSERT_EQ(loaded->rx_vlan_tci, want->rx_vlan_tci,
+		  "loaded_rx_vlan_tci");
+	ASSERT_EQ(loaded->ip_summed, want->ip_summed, "loaded_ip_summed");
+	ASSERT_EQ(loaded->csum_level, want->csum_level, "loaded_csum_level");
+}
+
 static void test_frames(struct test_xdp_skb_ext *skel, const char *path,
 			enum xdp_skb_ext_deliver deliver, int ifindex)
 {
@@ -232,9 +249,12 @@ static void test_frames(struct test_xdp_skb_ext *skel, const char *path,
 		if (!test__start_subtest(name))
 			continue;
 		set_case(skel, &skb_ext_cases[i]);
-		if (ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &opts),
-			      "test_run"))
-			check_have(skel);
+		if (!ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &opts),
+			       "test_run") ||
+		    !wait_pkt(skel))
+			continue;
+		check_have(skel);
+		check_loaded(skel);
 	}
 }
 
@@ -266,6 +286,7 @@ static void test_veth_skb(struct test_xdp_skb_ext *skel, struct bpf_link *link,
 		goto out;
 	if (deliver == DELIVER_CPUMAP) {
 		check_have(skel);
+		check_loaded(skel);
 		goto out;
 	}
 	ASSERT_EQ(skel->bss->store_err, 0, "store_err");
@@ -275,6 +296,7 @@ static void test_veth_skb(struct test_xdp_skb_ext *skel, struct bpf_link *link,
 	ASSERT_EQ(have->vlan_tci, 0, "vlan_tci");
 	ASSERT_EQ(have->ip_summed, CHECKSUM_NONE, "ip_summed");
 	ASSERT_EQ(have->csum_level, 0, "csum_level");
+	check_loaded(skel);
 out:
 	close(sock);
 }
@@ -292,7 +314,6 @@ void test_xdp_skb_ext_to_skb(void)
 {
 	struct bpf_cpumap_val val = { .qsize = 192 };
 	int ifindex_src, ifindex_dst, tc_prog_fd;
-	struct xdp_dummy *skel_dummy = NULL;
 	struct test_xdp_skb_ext *skel = NULL;
 	struct bpf_link *link = NULL;
 	struct netns_obj *ns = NULL;
@@ -330,18 +351,13 @@ void test_xdp_skb_ext_to_skb(void)
 	    tc_prog_attach("veth_dst", tc_prog_fd, -1))
 		goto out;
 
+	val.bpf_prog.fd = bpf_program__fd(skel->progs.cpumap_load);
 	if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.cpu_map),
 					   &key, &val, 0), "add cpumap entry"))
 		goto out;
 
-	skel_dummy = xdp_dummy__open_and_load();
-	if (!ASSERT_OK_PTR(skel_dummy, "xdp_dummy__open_and_load"))
-		goto out;
-
-	/* veth_dst takes xdp_frames only with an XDP program */
-	link = bpf_program__attach_xdp(skel_dummy->progs.xdp_dummy_prog,
-				       ifindex_dst);
-	if (!ASSERT_OK_PTR(link, "attach xdp_dummy"))
+	link = bpf_program__attach_xdp(skel->progs.veth_load, ifindex_dst);
+	if (!ASSERT_OK_PTR(link, "attach veth_load"))
 		goto out;
 
 	test_frames(skel, "pass", DELIVER_PASS, ifindex_src);
@@ -354,7 +370,6 @@ void test_xdp_skb_ext_to_skb(void)
 
 out:
 	bpf_link__destroy(link);
-	xdp_dummy__destroy(skel_dummy);
 	test_xdp_skb_ext__destroy(skel);
 	netns_free(ns);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c b/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
index a63206ff993d..34db1a986f3b 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <vmlinux.h>
+#include <errno.h>
 #include "xdp_skb_ext.h"
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
@@ -14,6 +15,8 @@ SEC("xdp")
 int live_frames(struct xdp_md *ctx)
 {
 	__u8 *mark = (void *)(long)ctx->data;
+	enum xdp_rss_hash_type rss_type;
+	__u32 hash;
 
 	if (mark + 1 > (__u8 *)(long)ctx->data_end)
 		return XDP_DROP;
@@ -25,6 +28,9 @@ int live_frames(struct xdp_md *ctx)
 			reused_ok++;
 			bpf_xdp_adjust_meta(ctx, MAX_META_LEN);
 		}
+		if (bpf_xdp_skb_ext_load_rx_hash(ctx, &hash, &rss_type) !=
+		    -ENODATA)
+			reused_bad++;
 	}
 	if (bpf_xdp_skb_ext_store_rx_hash(ctx, 1, XDP_RSS_TYPE_L4_IPV4_TCP) ||
 	    bpf_xdp_skb_ext_store_rx_vlan(ctx, bpf_htons(ETH_P_8021Q), 1) ||
@@ -51,7 +57,34 @@ enum xdp_skb_ext_deliver deliver;
 struct xdp_skb_ext_vals want;
 bool del_hash;
 struct xdp_skb_ext_have have;
-int pkts_seen_tc;
+struct xdp_skb_ext_vals loaded;
+int pkts_seen_tc, load_err;
+
+static void load_all(struct xdp_md *ctx)
+{
+	int err;
+
+	err = bpf_xdp_skb_ext_load_rx_hash(ctx, &loaded.rx_hash,
+					   &loaded.rx_hash_type);
+	if (!err)
+		loaded.fields |= SKB_EXT_FIELD_HASH;
+	else if (err != -ENODATA)
+		load_err++;
+
+	err = bpf_xdp_skb_ext_load_rx_vlan(ctx, &loaded.rx_vlan_proto,
+					   &loaded.rx_vlan_tci);
+	if (!err)
+		loaded.fields |= SKB_EXT_FIELD_VLAN;
+	else if (err != -ENODATA)
+		load_err++;
+
+	err = bpf_xdp_skb_ext_load_rx_csum(ctx, &loaded.ip_summed,
+					   &loaded.csum_level);
+	if (!err)
+		loaded.fields |= SKB_EXT_FIELD_CSUM;
+	else if (err != -ENODATA)
+		load_err++;
+}
 
 SEC("xdp")
 int xdp_store(struct xdp_md *ctx)
@@ -99,6 +132,21 @@ int xdp_store(struct xdp_md *ctx)
 		return bpf_redirect_map(&cpu_map, 0, 0);
 	if (deliver == DELIVER_VETH)
 		return bpf_redirect(ifindex_out, 0);
+	load_all(ctx);
+	return XDP_PASS;
+}
+
+SEC("xdp/cpumap")
+int cpumap_load(struct xdp_md *ctx)
+{
+	load_all(ctx);
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int veth_load(struct xdp_md *ctx)
+{
+	load_all(ctx);
 	return XDP_PASS;
 }
 
diff --git a/tools/testing/selftests/bpf/xdp_skb_ext.h b/tools/testing/selftests/bpf/xdp_skb_ext.h
index 11feee2fa31c..64d4a0511d0a 100644
--- a/tools/testing/selftests/bpf/xdp_skb_ext.h
+++ b/tools/testing/selftests/bpf/xdp_skb_ext.h
@@ -30,7 +30,7 @@ enum xdp_skb_ext_deliver {
 	DELIVER_VETH,
 };
 
-/* The entries that the XDP program stores */
+/* The entries that the XDP programs store or load */
 struct xdp_skb_ext_vals {
 	__u32 rx_hash;
 	__u32 rx_hash_type;
-- 
2.56.0

