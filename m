Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99104EF145
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675584; cv=none; b=JpULGFjhDi4RZ6PzYDST9TaJdFXzGwhFU6/G6T4k6kOCi1UdRjAPtpHcEqUoAK139qKysigXYMRn2RG/3mQspRcUSWHzYZg0aAxm6+5IogIDTlFe7K9oU2fcMzjt46bgwEKZ3m036cX388YNK8LpugnuG+YvGNQvmFknyJZwF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675584; c=relaxed/simple;
	bh=76lTc6/1AUcd00JGKfRFCOnzlD9sA9NjhrMzYbrVqEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8RXmBNOT2Yo7hYil/U/uC14DfXsqGxvdpBvMgtEllQyDKVe+9LJatJHLrbD7b5kbUIZrw7m3JZ90/R2O3ZtPhcwvYPjggQywxjaRw6arF+y08/k6+ZMNoOkNCW333+/LckEYiJZ76cLD/8ekmkki3KQJHRcVEplAYE3HaddRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTAgWCcn; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTAgWCcn"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-804e42309a5so501082a34.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675575; x=1790280375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KpNpdEfA7UsrMGBIwqXLxqF0cGG5Hs5AkYJwtGhjYEo=;
        b=LTAgWCcnOa152RC79+cvt9NOK5BLqPROWrK9Y2sJz0TjPAGCpIB1i1M81TG3uA1Hs+
         C6A338ETuvdg1MC7VZ+1eW9lEnpXU6DRlSwN+lXMjr4oJSo617ZF9arcvUBQQWhF3etZ
         5BKuNjeR0l7g9AzM46kzf0WnZHjb+qxMpqOY/RTjQtdYAREXD5lUV4DzUZqJUmntcE2c
         qI83H+R4Ax47EBERHm6oqkyvDNXBiR3S6XPesSgQ0DGR7UMd/PkYPAaUXskLO6x8pjBd
         ygeSkJwIRMRYKzYNZ2/czsXjQqNC9sSRhfCzItRPa2mhujshZmM8VH6I8NgmWuyaiQ/a
         +noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675575; x=1790280375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KpNpdEfA7UsrMGBIwqXLxqF0cGG5Hs5AkYJwtGhjYEo=;
        b=Dq8HhgfMqgl3guBGA4VYyZ3NRwh7TVuAPkfTbv+7njxFlroa4J/yCKZAwlfnxe6pAr
         FKjHXUVMR7kprUp6XW3+iVu/44Zd7YkbjYF6uhuJ1lOnZ9PfjgZ2oieLJTriRKDrBMyY
         7IegXOY2Ph5Hhfbgr3wdlhzzj+NtQWveWN8TvT/GhV/LrxYRUOF+5eAJoPQuFvwm53/G
         ilYcVImpnvNFK6oul1CzJFkvZfw1lJIVGDFNd4g7SdjFcD7BVpJtLIxurY0KqB/92EpG
         UB3o9xS/67fPwKwuAzL3II2CYHX3my7GyBWa3iUz6E5y5eRhBr2I72JKEkRxKLrhHf/W
         p7gQ==
X-Gm-Message-State: AFuF++lxSBpbt9HAEyFcx4huvfzG9F3GKccXbQh9It2kWyq1Zvl5sSLW
	nbgu8cEMKPF37q+MZTGTIOKz49Hsf464jz0kWaScKiHO32hhJf2JSLxq
X-Gm-Gg: AYBFou1HM+LzYFY4LdhwVa5RMSW7fwJ0Z6BO5SM4l8N2LCluA2sr5e3j7X8nMYH3r+4
	yjNXeknwyJ2zFjshTTWH+AJFhxXzB1QBUtcCwMy5XYaqf1A5EMaqcQ68tSX1BUEGA+xSmIwVTt+
	eW/02g6wYBM+7qiUHegLELC4hspLPfxv+eIw8LedyPsKqvDUhKkAJUIX6BXdd7CkWr+P6L8Q1mv
	CWHkriOZpbWkIRWyZm181+xS5P3AdWlDXfujys8pVpUc0gaJdyuaw+bjXwW+BEKCUPw2GdXeFCL
	wt7jqomd9QSLFojZ/o/yvmKe/kvNZ8t51wBUlnQ66RBTD7jUuprA+ONaOPfuOCw42IRlah5p/r0
	odNWVYEuS61+lr0LO7uwbUo437wwggcyEpa7Ycj+VPkjih3ZNdaW9RRJp5hY99rrW2f/R2//BUQ
	jvv8bAGatVi3SGz+hQ8N/9uarKQP6jqCx7+ctb2smPhExUM2hOgYdo4lTBLaOj/KyPfM2lnAxo
X-Received: by 2002:a05:6830:3110:b0:809:5916:fcc3 with SMTP id 46e09a7af769-80de21c84c3mr299559a34.17.1789675575099;
        Thu, 17 Sep 2026 13:06:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c476c1f61sm3753838a34.25.2026.09.17.13.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:06:14 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 15/15] selftests/bpf: Add test for bpf_tcp_ops header option hooks
Date: Thu, 17 Sep 2026 13:05:41 -0700
Message-ID: <20260917200542.3689605-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test exercising the bpf_tcp_ops parse_hdr, hdr_opt_len and
write_hdr_opt members together with the header option helpers.

The struct_ops program (progs/bpf_tcp_ops_hdr.c) reserves space in
hdr_opt_len via bpf_reserve_hdr_opt(), writes an experimental option in
write_hdr_opt via bpf_store_hdr_opt(), and recovers it in parse_hdr via
bpf_load_hdr_opt() on the incoming skb. Each hook bumps a counter and the
parse hook records the option payload, so the three callbacks and all
three overloaded helpers are covered.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/bpf_tcp_ops_hdr.c          | 77 +++++++++++++++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     | 86 +++++++++++++++++++
 2 files changed, 163 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
new file mode 100644
index 000000000000..244605e69e40
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "cgroup_helpers.h"
+#include "bpf_tcp_ops_hdr.skel.h"
+
+#define CGROUP_PATH	"/bpf_tcp_ops_hdr"
+#define TEST_NETNS	"bpf_tcp_ops_hdr"
+
+#define TEST_OPT_D0	0xAB
+#define TEST_OPT_D1	0xCD
+
+static void run_hdr_opt(void)
+{
+	struct bpf_tcp_ops_hdr *skel = NULL;
+	struct bpf_link *link = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd, lfd = -1, fd = -1;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops_hdr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	link = bpf_map__attach_cgroup_opts(skel->maps.test_hdr_ops, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup"))
+		goto done;
+
+	/*
+	 * One direction of data is enough to exercise all hooks: both peers
+	 * share the cgroup struct_ops, so the sender runs hdr_opt_len/write
+	 * and the receiver runs parse.
+	 */
+	lfd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	if (!ASSERT_GE(lfd, 0, "start_server"))
+		goto done;
+
+	fd = connect_to_fd(lfd, 0);
+	if (!ASSERT_OK_FD(fd, "connect_to_fd"))
+		goto done;
+
+	if (!ASSERT_OK(send_recv_data(lfd, fd, 64), "send_recv_data"))
+		goto done;
+
+	/* Reserve + write hooks ran while sending. */
+	ASSERT_GT(skel->bss->hdr_opt_len_cnt, 0, "hdr_opt_len_cnt");
+	ASSERT_GT(skel->bss->write_cnt, 0, "write_cnt");
+	/* Parse hook ran and recovered our option on the receive side. */
+	ASSERT_GT(skel->bss->parse_cnt, 0, "parse_cnt");
+	ASSERT_GT(skel->bss->found_cnt, 0, "found_cnt");
+	ASSERT_EQ(skel->bss->found_d0, TEST_OPT_D0, "found_d0");
+	ASSERT_EQ(skel->bss->found_d1, TEST_OPT_D1, "found_d1");
+
+done:
+	if (fd >= 0)
+		close(fd);
+	if (lfd >= 0)
+		close(lfd);
+	bpf_link__destroy(link);
+	bpf_tcp_ops_hdr__destroy(skel);
+	netns_free(ns);
+	close(cgroup_fd);
+}
+
+void test_bpf_tcp_ops_hdr(void)
+{
+	run_hdr_opt();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
new file mode 100644
index 000000000000..f3e3dff13784
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* Experimental option kind and payload written/parsed by this test. */
+#define TEST_OPT_KIND	0xFD
+#define TEST_OPT_LEN	4
+#define TEST_OPT_D0	0xAB
+#define TEST_OPT_D1	0xCD
+
+int hdr_opt_len_cnt;
+int write_cnt;
+int parse_cnt;
+int found_cnt;
+__u8 found_d0;
+__u8 found_d1;
+
+SEC("struct_ops")
+void BPF_PROG(test_hdr_opt_len, struct sock *sk, struct sk_buff *skb,
+	      struct request_sock *req, struct sk_buff *syn_skb,
+	      enum tcp_synack_type synack_type, unsigned int *remaining)
+{
+	hdr_opt_len_cnt++;
+
+	/*
+	 * Reserve TEST_OPT_LEN bytes; the helper decrements *remaining. Stacks
+	 * with other progs in the cgroup hierarchy.
+	 */
+	bpf_reserve_hdr_opt(ctx, TEST_OPT_LEN, 0);
+}
+
+SEC("struct_ops")
+void BPF_PROG(test_write_hdr_opt, struct sock *sk, struct sk_buff *skb,
+	      struct request_sock *req, struct sk_buff *syn_skb,
+	      enum tcp_synack_type synack_type, __u32 opt_off)
+{
+	__u8 opt[TEST_OPT_LEN] = {
+		TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
+	};
+
+	/*
+	 * bpf_store_hdr_opt() takes the program ctx (the kernel reads the
+	 * outgoing skb from it); it appends after any options already written
+	 * in the reserved window, rejects duplicates, and confines the write to
+	 * the header option scratch. Stacks across progs in the cgroup hierarchy.
+	 */
+	if (bpf_store_hdr_opt(ctx, opt, sizeof(opt), 0))
+		return;
+
+	write_cnt++;
+}
+
+SEC("struct_ops")
+void BPF_PROG(test_parse_hdr, struct sock *sk, struct sk_buff *skb)
+{
+	__u8 opt[TEST_OPT_LEN] = {
+		TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
+	};
+
+	parse_cnt++;
+
+	/*
+	 * Look up the experimental option written by test_write_hdr_opt() in
+	 * the incoming skb. For an experimental kind the search matches on the
+	 * 2-byte magic in opt[2..3]; on a match the found option is copied back
+	 * into opt[].
+	 */
+	if (bpf_load_hdr_opt(ctx, opt, sizeof(opt), 0) < 0)
+		return;
+
+	found_d0 = opt[2];
+	found_d1 = opt[3];
+	found_cnt++;
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops test_hdr_ops = {
+	.hdr_opt_len	= (void *)test_hdr_opt_len,
+	.write_hdr_opt	= (void *)test_write_hdr_opt,
+	.parse_hdr	= (void *)test_parse_hdr,
+};
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

