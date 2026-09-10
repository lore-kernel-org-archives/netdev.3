Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FD49BD7F
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048978; cv=none; b=HwPqQ2H2X5FfpCnJBROBegKVwitt5nYAPTDdw0g/SL8mo4ECtlcew1uHIKZQKjSiBlPn7Ds8ZvaWQfv8kL5zBGuWcixkUYj5OWLg+0WLWOwxCyL6PZ7+yKNQTGqbPvf+qPSdr5y7K+zhzt91kui2dIlQGgZoLqMC+maK57fdpPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048978; c=relaxed/simple;
	bh=QGhb07qkSktQRER419fugbHNSnqcS++NXjxtwnrvM3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DgVsv+1/OtYq+9rJm0+om0MIRVriWRZlc6wToP4xHmuHSLQtnFE9al76oMjKQ/z0HjRKLMEjz2HpQdcH0Y5mKIj9O71FQ6yUn491Hpljgc+judRfGZPOs5awH9Atlv5zeG2U3JhJtWVuP1LZkmscNdBeoWCTVr0FdXWlVDKObho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TlXxD3gf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TlXxD3gf"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a9983162dcso2678357a12.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048974; x=1789653774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D95LKMHN20mJo39+JmHRF4KebZe0Vu58hYQ9hgHIzbI=;
        b=TlXxD3gfEa30VFp4TGJHcjF4Noo+KsuDIojfSpVoDA75nCwgZ9lakDQau7OmvvE0ZN
         WNn8CnB1cgo8UFezEBmTbDsbzEzRiKhiiEWR9Klnu9uBSKlQVz2pIIir/ZvUO4O0LsPw
         wJmq5HbhjO/yBHN1idKW5o+oDgz90fMcEtYVvY1HzN0fV1LnSjOnqQygGot2CO7ounHa
         YDzvhyTN3ihYYoThSSzKXGqqr7dOPKAYiHwejuW+jW/Qj/cNNy99V7ZkEEQOUenFPBlD
         WbLhoS2AZuy9rCdMAzG7lBOkaxQj+7/AnuE2RsB31d++5LrRIlbA/WL3sHf3v42tpB2p
         PT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048974; x=1789653774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D95LKMHN20mJo39+JmHRF4KebZe0Vu58hYQ9hgHIzbI=;
        b=r2eoxi8/Nn4fdRzt6tZflTpog534EnBfJ753++cSS7kOjfujR4MUR4e15XBhAngPZz
         d7kupoUtlcfMxid4p5DeUFUrafRHoH2bpDfuSE04fT/62XJHNrI7sP2z0KtvnAiMnHGG
         s5xpFNtvdWuG4vC5kbkxQ+9KF1F+P8scRSgzzBzK+SCIslbWQRiWgcAKoMhE1eGhMPnH
         DvhOMR4jxm1rXGKHKHhUkGCsLpbm5RUpFgPyOGIBt2GXsYi0p0X567oHYndjbuTp8904
         6Eb7MHX0PUR5DbVPuhFIGtftyZOhu3hybONU0kQ9BqsWUO9aE03zCQWk8VyVG0yUsjUi
         GVPA==
X-Gm-Message-State: AFuF++lxucxFIfYn0YB+i95Bujh1El/CXJWFaJp2ZufhH4MWVUiopu08
	lJ6ALz4EG0pQgGAH7fX2PlRLlnz//kH4OLKMyEk6t8BAmckImwTwRvFaZ2mYmx2z0zY=
X-Gm-Gg: AYBFou3j5yudKKUUstYgB04CBoH+benPO++OCFPQmdwI9my9gqKUO70KlyViyoWlXHB
	gr8xQO362h9LKkjCcoARUGKXsjwhyYa+6luXyixrYP7glYovbiS4FMuA6gEh7UPunuasyc4cMc0
	QSsNCJrXFdJuvhjOC+/z3aMwlMh8JVjJ7TgQITjwjw/ZQVCzUgKkO67gNLKXTwnH0iGighsEcef
	tOzzwNBgIUuL25G+qkJcj95N6/njbMCBqP2DgX8u4hQbArDpQY+m4LsF8B3juFGgB3JqVO/l9jL
	5vGvRUY65JjPupQX6TrY128M/xAvTLee4q8b48iSQXTxGyasBqPCG03NUs7iGCAABIy+5Y6j24f
	4zQLKxuhfuh8t5G+/lTebfbZ5JlrZZ39oAlFKSDRO27Rzjw5paXDM6GNdhPb2kSjJGn9Hh1HSxg
	DX53TErOoZJGxCC6V7htM+oTQKscrg9qpCwPcUuD80EfkK/AUGg1JykF2j6JFJek02T67S3v2Px
	dL/GhuaMqaWws8+O9K4f/hwudMVGOkPclLpRjbSNvhvMD5I2DcEmSdUN+8=
X-Received: by 2002:a05:6402:23c8:b0:6a9:b204:e746 with SMTP id 4fb4d7f45d1cf-6a9b204eb99mr362221a12.15.1789048974399;
        Thu, 10 Sep 2026 07:02:54 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6bf5072sm8139232a12.28.2026.09.10.07.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:42 +0200
Subject: [PATCH net-next v2 07/14] selftests/bpf: Test skb_ext read from
 cgroup_skb and sk_filter hooks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-7-0b21e42180b0@cloudflare.com>
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

Extend skb_ext cross-hook coverage to UDP readers: attach a TC
ingress program on loopback that writes the extension, send a UDP
datagram over loopback, and read the extension back from a
cgroup_skb/ingress program and from a socket filter attached with
SO_ATTACH_BPF.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 121 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |  37 +++++++
 2 files changed, 158 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index d7e81cddb55b..dcbbd55381b0 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -1100,3 +1100,124 @@ void test_skb_ext_basic(void)
 
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
+/* Test skb_ext survival across TC ingress -> UDP reader hook */
+static void test_skb_ext_udp(struct test_xdp_meta *skel, const char *name,
+			     enum udp_reader_type reader)
+{
+	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+		    .ifindex = 1 /* IFINDEX_LO */,
+		    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
+	struct bpf_link *reader_link = NULL;
+	struct netns_obj *ns = NULL;
+	int server_fd = -1;
+	int cgroup_fd = -1;
+	int filter_fd;
+	int ret;
+
+	ns = netns_new(name, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		return;
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
+
+	ret = bpf_tc_hook_create(&tc_hook);
+	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
+		goto cleanup;
+
+	tc_opts.prog_fd = bpf_program__fd(skel->progs.tc_skb_ext_write);
+	ret = bpf_tc_attach(&tc_hook, &tc_opts);
+	if (!ASSERT_OK(ret, "bpf_tc_attach"))
+		goto cleanup;
+
+	switch (reader) {
+	case READER_CGRP_SKB:
+		reader_link = bpf_program__attach_cgroup(skel->progs.cgrp_skb_ext_read,
+							 cgroup_fd);
+		if (!ASSERT_OK_PTR(reader_link, "attach_cgroup"))
+			goto cleanup;
+		break;
+	case READER_SK_FILTER:
+		filter_fd = bpf_program__fd(skel->progs.sk_filter_skb_ext_read);
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
+	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
+
+cleanup:
+	bpf_link__destroy(reader_link);
+	bpf_tc_hook_destroy(&tc_hook);
+	if (server_fd >= 0)
+		close(server_fd);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	netns_free(ns);
+}
+
+void test_skb_ext_cross_hook(void)
+{
+	struct test_xdp_meta *skel = NULL;
+
+	skel = test_xdp_meta__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		return;
+
+	if (test__start_subtest("tc_to_cgrp_ingress"))
+		test_skb_ext_udp(skel, "tc_to_cgrp_ingress", READER_CGRP_SKB);
+	if (test__start_subtest("tc_to_sk_filter"))
+		test_skb_ext_udp(skel, "tc_to_sk_filter", READER_SK_FILTER);
+
+	test_xdp_meta__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index ff134204a33e..d401bd0bd684 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1000,4 +1000,41 @@ int tc_skb_ext_slice_write_after_clone_redir(struct __sk_buff *ctx)
 	return TC_ACT_UNSPEC;
 }
 
+/* Read skb_ext from cgroup/skb ingress -- tests cross-hook survival */
+SEC("cgroup_skb/ingress")
+int cgrp_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
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
+/* Read skb_ext from socket filter -- tests TC -> sk_filter path */
+SEC("socket")
+int sk_filter_skb_ext_read(struct __sk_buff *ctx)
+{
+	__u8 meta_have[META_SIZE];
+	struct bpf_dynptr meta;
+
+	if (bpf_dynptr_from_skb_ext(ctx, 0, 0, &meta))
+		goto out;
+	if (bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0))
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

