Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442730E821
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914933; cv=none; b=f3NPoagkvvPc9y/FaxD7YfJ/X+MxrKIEtAQTy1T+6a/Txt3DbGs5Nkh0awNYCiIMAgzX/N1ANm0n2Sd0rvywd6ggwRGuZF5u4zlzMfzNv/mxua4CAC2ra4ocvq8YiQiueTAgWDYkGG6mYk9e+WD/w8Lhn252ngD7cVNo8RQv5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914933; c=relaxed/simple;
	bh=cCGtKzRan8BWBEBX1JfJ3AgQYo8AGQ9XZRDmtPnG1yY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bKfL3AEwSqMMvswdab1XUdca9sUtgLHP5I86lQRD83xI00ZbKwqZVG8CIkEVAlm/ajsJUmnlEtgg3c9JOTKeo2PJCQLTx+THzGbWrA11/oiOxV7vHffYAkKiK83itDOLUxP2Du41YQVoBbdLCWztXmow0iVzmKceAefqN/Uo2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNMiMFIL; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNMiMFIL"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664c2da6so6148853eec.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 21:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790914931; x=1791519731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xq7JBmYQfpiyGGj6KWk3jb5GoLIoazeQmys5Q46VZRg=;
        b=eNMiMFILS9TRLeBm94BHfOP2/9/SyW0OJPDkYOtazkMtdYGufwgE6/O0VSWD0vBApq
         bh7jv4TTRYkEsQNuvtMDg/Vjuyngw5sW4nR3LtJmIXYuviBvkM9GGBdE/AV8VyPyZMrJ
         rGelIaGIoXka+wVa2mJr6J/iH2qkOGs4yY6cHzIKsf1NRfDP8cZd6cQwsF/zeD6dJxSk
         rCiX0zvkeMy2HpNq6dBGRZ+Lf3fRw+5DSh7emeTNC49Wux86NDocQwBzaxquevPpp8P2
         RvR8CymX+rt+M024v5lLa2z3OFHE2oucZxUmgVRXAHKsXG4jGQCfdTNB2F48JCumqkvR
         FhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790914931; x=1791519731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xq7JBmYQfpiyGGj6KWk3jb5GoLIoazeQmys5Q46VZRg=;
        b=y2DjpjnbbzlhfMBpHJiR0z6hgQrRYLDxAQXeHits+RDRt0tCMDiRV9mwgXtTwHI21p
         dCHxL+EXVVN/RFvh/7fCdBuyl2WTE73kWh+3GzSI6LlfM+PXkzArnvM0jHZLAovS1/+K
         VYNnL9Wnrr9h67/oYFnDf18O3RYD4u3koLIn3v1++komuSuvzLCEgycHkblkd7XAbovk
         8TxiZqzalaFOMOpcBsml+rYa08KX53QIr+RusoCK8T+3KJdIA2uJLIALlLe3UfSOz+Lp
         G28dmEBno/SfBTxBqG1shVD+Up4pW8mJabz7gWVW+XArEwGBr1j8NK6he9dR5ZNe/myp
         tKDg==
X-Forwarded-Encrypted: i=1; AKwUvBw4bdfPH/DQDB7VcqBF294rUwyjT2Ev3Yycpj7mY1uw8LZYVUAFWpU+EswsNXrXrk960gNQZZs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1sJeLUJl3iOQBplbn0VE0chxE6u3uzBMDgiWxF0phghM1OVlk
	yeIIj6XQbMztCo+C0Pn9DEfPO1GmAxPl/GP9sEAehRx/4IYCZreIyNVV
X-Gm-Gg: AYBFou0CGA1FDYI6CPW7iBUM2rtjr7t6xl7IsAMBUxxTGJae3rY8xTNLloVjRq9giik
	9p75OPFYt3Vot0h7Nh08iMPmapbGKK3mhpn34W27tEmT1MCOfMyw5byh4O1+kEVAHqqzaAz0R4I
	6ZM+7qu39UDC/VJE9LXlLbdJteuL0fsGkIM7D/K26gTLxlSzCa5YmPGMs45aWiNkqnOIx02OilO
	AUtIAu+86uMCHTE9L4HdVfgDhmBYuo4f/25xQc7lZSq6AZOlPmXcaT68tgIq5LA1AsF5QBy1r45
	8HtmgAOuOCasNoPfJZe2YjRH8PrA0djJpQY3gl+g7/2FIdhCcvYWt412oRGyWkGkAzjyYii2y6d
	omfgH0uDZeBeVIXbB1DL5psCKkRF/nDQ0x56jQfxP/QfkotqzkeI0wedlFDvqSFH2REFDF3oWPO
	0WE3fby0X/RXVYzyae3rueHCWwL8wqlvR6//czHOiqj0krwX2z6JG4LqUr79L836rb04ROLcWk/
	pnKeAjXr3BZ4yvNNf+5yW73qyOZHvayro/BPpuu2uU4oGhaxerXSXfr3ODFCR8qK5GdJaeu98Kb
	o6AzU+DDLQEIPaN4feXZe1rXIWL/19YgYGVDrZrZx/Y=
X-Received: by 2002:a05:7300:7fa8:b0:34e:f967:8cfa with SMTP id 5a478bee46e88-34f21990e24mr2294841eec.32.1790914930420;
        Thu, 01 Oct 2026 21:22:10 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f15019999sm2526734eec.29.2026.10.01.21.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:22:09 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org
Cc: sdf@fomichev.me,
	ihor.solodrai@linux.dev,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: add XDP test for per-flow LRU_HASH window updates
Date: Fri,  2 Oct 2026 04:22:01 +0000
Message-Id: <20261002042201.3483076-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LRU_HASH selftests (test_lru_map) exercise BPF_MAP_TYPE_LRU_HASH
only from the syscall side. There is no coverage of an XDP program
updating an LRU_HASH map on the data path: inserting an entry with
BPF_NOEXIST on first sight of a flow, then updating a bounded array
inside the map value using a runtime (modulo) index.

That pattern is common in XDP flow-tracking programs and stresses two
things worth testing together: the verifier's bounds checking of a
value-internal array indexed by a runtime value, and per-flow key
isolation in an LRU map driven from XDP.

Add an XDP program that keys an LRU_HASH by the TCP/IPv4 5-tuple and
records packet lengths into value->pkt_len[seq % AGGREGATION_WINDOW],
plus a test_progs case driven by bpf_prog_test_run that checks:

 - wrap:    seq advances and the bounded array wraps, with the runtime
            index accepted by the verifier;
 - trunc:   a short (parse-failing) packet neither inserts a new entry
            nor mutates an existing one;
 - isolate: two distinct 5-tuples get independent entries.

Selftest only; no kernel change.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
v2:
 - CC the XDP / BPF-selftests maintainers and reviewers; v1 was sent to
   the lists only and received no review.
 - Rewrite the commit message to explain the coverage gap and intent.
 - No change to the test code.

v1: https://lore.kernel.org/netdev/20260917135433.2260048-1-anilkaushikwireless@gmail.com/

 .../selftests/bpf/prog_tests/xdp_lru_window.c | 168 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_lru_window.c      |  81 +++++++++
 tools/testing/selftests/bpf/xdp_lru_window.h  |  28 +++
 3 files changed, 277 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_lru_window.c
 create mode 100644 tools/testing/selftests/bpf/xdp_lru_window.h

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
new file mode 100644
index 000000000..55175c216
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "xdp_lru_window.h"
+#include "xdp_lru_window.skel.h"
+
+#define SRC_IP		0x0a000001
+#define DST_IP		0x0a000002
+#define SRC_PORT	12345
+#define DST_PORT	80
+#define ALT_DST_PORT	81
+
+static struct xdp_lru_window *skel;
+static int prog_fd, map_fd;
+
+static void fill_pkt(struct ipv4_packet *pkt, __u16 dport)
+{
+	*pkt = pkt_v4;
+	pkt->iph.saddr = htonl(SRC_IP);
+	pkt->iph.daddr = htonl(DST_IP);
+	pkt->tcp.source = htons(SRC_PORT);
+	pkt->tcp.dest = htons(dport);
+}
+
+static void fill_key(struct xdp_lru_window_key *key, __u16 dport)
+{
+	memset(key, 0, sizeof(*key));
+	key->saddr = htonl(SRC_IP);
+	key->daddr = htonl(DST_IP);
+	key->sport = htons(SRC_PORT);
+	key->dport = htons(dport);
+	key->proto = IPPROTO_TCP;
+}
+
+static int run_pkt(const void *data, __u32 len, int *retval)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = data,
+		    .data_size_in = len,
+		    .repeat = 1,
+	);
+	int err;
+
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	if (!ASSERT_OK(err, "test_run"))
+		return err;
+	if (retval)
+		*retval = opts.retval;
+	return 0;
+}
+
+static int inject(int n, __u16 dport)
+{
+	struct ipv4_packet pkt;
+	int i, retval;
+
+	fill_pkt(&pkt, dport);
+	for (i = 0; i < n; i++) {
+		if (run_pkt(&pkt, sizeof(pkt), &retval))
+			return -1;
+		if (!ASSERT_EQ(retval, XDP_PASS, "retval"))
+			return -1;
+	}
+	return 0;
+}
+
+static void reset_map(void)
+{
+	struct xdp_lru_window_key key, next;
+	int err;
+
+	err = bpf_map_get_next_key(map_fd, NULL, &next);
+	while (!err) {
+		key = next;
+		err = bpf_map_get_next_key(map_fd, &key, &next);
+		bpf_map_delete_elem(map_fd, &key);
+	}
+}
+
+static void test_one_and_wrap(void)
+{
+	struct xdp_lru_window_state st;
+	struct xdp_lru_window_key key;
+	int i, n;
+
+	reset_map();
+	if (inject(1, DST_PORT))
+		return;
+	fill_key(&key, DST_PORT);
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &st), "lookup"))
+		return;
+	ASSERT_EQ(st.seq, 1, "seq");
+	ASSERT_EQ(st.pkt_len[0], sizeof(struct ipv4_packet), "len0");
+
+	n = AGGREGATION_WINDOW + 5;
+	if (inject(n - 1, DST_PORT))
+		return;
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &st), "lookup wrap"))
+		return;
+	ASSERT_EQ(st.seq, n, "seq wrap");
+	for (i = 0; i < AGGREGATION_WINDOW; i++)
+		ASSERT_EQ(st.pkt_len[i], sizeof(struct ipv4_packet), "slot");
+}
+
+static void test_trunc(void)
+{
+	struct xdp_lru_window_state before, after;
+	struct xdp_lru_window_key key, next;
+	unsigned char short_pkt[sizeof(struct ethhdr)] = {};
+	int err, retval;
+
+	reset_map();
+	err = run_pkt(short_pkt, sizeof(short_pkt), &retval);
+	if (err)
+		return;
+	ASSERT_EQ(retval, XDP_PASS, "trunc retval");
+	err = bpf_map_get_next_key(map_fd, NULL, &next);
+	ASSERT_EQ(err, -ENOENT, "trunc no insert");
+
+	if (inject(1, DST_PORT))
+		return;
+	fill_key(&key, DST_PORT);
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &before), "setup"))
+		return;
+	if (run_pkt(short_pkt, sizeof(short_pkt), &retval))
+		return;
+	ASSERT_EQ(retval, XDP_PASS, "trunc2 retval");
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &after), "after"))
+		return;
+	ASSERT_EQ(after.seq, before.seq, "trunc no mutate");
+}
+
+static void test_isolate(void)
+{
+	struct xdp_lru_window_state a, b;
+	struct xdp_lru_window_key key;
+
+	reset_map();
+	if (inject(2, DST_PORT) || inject(1, ALT_DST_PORT))
+		return;
+	fill_key(&key, DST_PORT);
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &a), "flow a"))
+		return;
+	fill_key(&key, ALT_DST_PORT);
+	if (!ASSERT_OK(bpf_map_lookup_elem(map_fd, &key, &b), "flow b"))
+		return;
+	ASSERT_EQ(a.seq, 2, "seq a");
+	ASSERT_EQ(b.seq, 1, "seq b");
+}
+
+void test_xdp_lru_window(void)
+{
+	skel = xdp_lru_window__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.xdp_lru_window);
+	map_fd = bpf_map__fd(skel->maps.flow_table);
+
+	if (test__start_subtest("wrap"))
+		test_one_and_wrap();
+	if (test__start_subtest("trunc"))
+		test_trunc();
+	if (test__start_subtest("isolate"))
+		test_isolate();
+
+	xdp_lru_window__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_lru_window.c b/tools/testing/selftests/bpf/progs/xdp_lru_window.c
new file mode 100644
index 000000000..27aa1509e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_lru_window.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "xdp_lru_window.h"
+
+#ifndef ETH_P_IP
+#define ETH_P_IP	0x0800
+#endif
+
+#ifndef EEXIST
+#define EEXIST		17
+#endif
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, XDP_LRU_WINDOW_FLOWS);
+	__type(key, struct xdp_lru_window_key);
+	__type(value, struct xdp_lru_window_state);
+} flow_table SEC(".maps");
+
+SEC("xdp")
+int xdp_lru_window(struct xdp_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct xdp_lru_window_state init, *st;
+	struct xdp_lru_window_key key;
+	struct ethhdr *eth;
+	struct iphdr *iph;
+	struct tcphdr *th;
+	__u32 idx, pkt_len;
+	int err;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return XDP_PASS;
+	if (eth->h_proto != bpf_htons(ETH_P_IP))
+		return XDP_PASS;
+
+	iph = (void *)(eth + 1);
+	if ((void *)(iph + 1) > data_end)
+		return XDP_PASS;
+	if (iph->protocol != IPPROTO_TCP)
+		return XDP_PASS;
+
+	th = (void *)(iph + 1);
+	if ((void *)(th + 1) > data_end)
+		return XDP_PASS;
+
+	__builtin_memset(&key, 0, sizeof(key));
+	key.saddr = iph->saddr;
+	key.daddr = iph->daddr;
+	key.sport = th->source;
+	key.dport = th->dest;
+	key.proto = iph->protocol;
+	pkt_len = data_end - data;
+
+	st = bpf_map_lookup_elem(&flow_table, &key);
+	if (!st) {
+		__builtin_memset(&init, 0, sizeof(init));
+		err = bpf_map_update_elem(&flow_table, &key, &init,
+					  BPF_NOEXIST);
+		if (err && err != -EEXIST)
+			return XDP_PASS;
+		st = bpf_map_lookup_elem(&flow_table, &key);
+		if (!st)
+			return XDP_PASS;
+	}
+
+	idx = st->seq % AGGREGATION_WINDOW;
+	barrier_var(idx);
+	if (idx >= AGGREGATION_WINDOW)
+		return XDP_PASS;
+
+	st->pkt_len[idx] = pkt_len;
+	st->seq++;
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/xdp_lru_window.h b/tools/testing/selftests/bpf/xdp_lru_window.h
new file mode 100644
index 000000000..78434045c
--- /dev/null
+++ b/tools/testing/selftests/bpf/xdp_lru_window.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __XDP_LRU_WINDOW_H
+#define __XDP_LRU_WINDOW_H
+
+/*
+ * ABI for the XDP LRU rolling-window selftest. Existing test_lru_map
+ * coverage never enters XDP; XDP parse tests do not store a modulo
+ * index into an LRU map value.
+ */
+
+#define AGGREGATION_WINDOW	50
+#define XDP_LRU_WINDOW_FLOWS	64
+
+struct xdp_lru_window_key {
+	__be32	saddr;
+	__be32	daddr;
+	__be16	sport;
+	__be16	dport;
+	__u8	proto;
+	__u8	pad[3];
+};
+
+struct xdp_lru_window_state {
+	__u32	seq;
+	__u32	pkt_len[AGGREGATION_WINDOW];
+};
+
+#endif /* __XDP_LRU_WINDOW_H */
-- 
2.25.1

