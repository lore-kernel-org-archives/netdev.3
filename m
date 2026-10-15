Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13E3D88E0;
	Thu, 15 Oct 2026 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108610; cv=none; b=M2j2Uvvw+FXmlIiyHQKo5TcYPVcwrgTTj7atuGitZRk3lEyNgH16RLfio413rNMrEXNT3c88fPz3hL8LrZECAyfx5YSJULnT1SKPVnbPhT44qR1kw+m49m48/TkMbziJYaXu4r6ABCb60ap/N8sNJYFyWAlFlmZRdPBO+e8BFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108610; c=relaxed/simple;
	bh=Aw7Uh7QIY/HPESoLBQp6yeoOqo6iAB6HcKSVOV0eK84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Av1lPjxqt3EUbQq9vz0D5bg6gtZonGBT95GBjcY11cBVwkHVMwYnqXxULGL+bPVoJa5HYHRHg/uv3AhtEBsUsQPHYb35D7X55YTa09XC9AQlj27tN/6La4lIblkBJhaxkgufJ9siuu8FnJ5jZXeo87x3ohUeNsf4HpbEWEYx3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IQWjixcz; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IQWjixcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792108607; x=1823644607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iporXgDcLq8Qs5m1AomBCEZH863qUOYM2erUOveq4GQ=;
  b=IQWjixczm2WbmlE4yAvWSp6n7sP7GR/xAjqbjv9Y+XY3dilM72faHXMm
   JjSww59YwFi9pHoBL9kKcVefHCnfbAKXfDTFtdjwZ7dKBIn1E53Qlg41l
   Z9atWq/CRGl36xICwebW4SA4i+ArvFCx4mjqp1IzEKPcERf1eHrzC2H0E
   /QyqENovAV03BdxkF/qwE1afp1E9WiQS+/QCPF7Nkg7tJHXPIzj+lI/Xi
   kmTlmFufzdlCyQNWdUFh134BdqHci0O0FzQOVeBEvUOZhGpvmY1+ucGnY
   yQDUkicdl/UqjP1fqAgeD4G92aU4KVDPYnf8hq6zfRjLVORYZmPAA4uAw
   w==;
X-CSE-ConnectionGUID: T55mjaqtQ/m9ox5hHqnMZQ==
X-CSE-MsgGUID: 4WQ80iPOTpKbUgKwMWk6gw==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31368865"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 23:56:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:9704]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.90:2525] with esmtp (Farcaster)
 id 0df28996-750e-4a56-ac9d-24d89250e3a0; Thu, 15 Oct 2026 23:56:44 +0000 (UTC)
X-Farcaster-Flow-ID: 0df28996-750e-4a56-ac9d-24d89250e3a0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 23:56:43 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 23:56:43 +0000
From: David Keogh <dkeogh@amazon.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	<nh-open-source@amazon.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next 5/6] selftests/bpf: add tx_extra_headroom data-plane programs
Date: Thu, 15 Oct 2026 23:53:34 +0000
Message-ID: <20261015235335.4162993-6-dkeogh@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261015235335.4162993-1-dkeogh@amazon.com>
References: <20261015235335.4162993-1-dkeogh@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Add two BPF programs for a tx_extra_headroom data-plane test:

  * push_outer (SEC "tc") pushes a 20-byte outer header on UDP egress,
    forcing a head reallocation when the skb lacks the headroom.

  * count_realloc (SEC "fentry/pskb_expand_head") counts those reallocs
    for one ifindex, selected via the cfg_ifindex map.

The test that loads them is added to selftests/net in the next patch.

Signed-off-by: David Keogh <dkeogh@amazon.com>
---
 .../bpf/progs/tx_extra_headroom_probe.c       | 68 ++++++++++++++++++
 .../bpf/progs/tx_extra_headroom_tc.bpf.c      | 69 +++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tx_extra_headroom_probe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tx_extra_headroom_tc.bpf.c

diff --git a/tools/testing/selftests/bpf/progs/tx_extra_headroom_probe.c b/tools/testing/selftests/bpf/progs/tx_extra_headroom_probe.c
new file mode 100644
index 000000000..a6ca66ef0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tx_extra_headroom_probe.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fentry realloc counter for the tx_extra_headroom data-plane selftest.
+ *
+ * count_realloc (fentry/pskb_expand_head) increments realloc_cnt[0] each time
+ * pskb_expand_head() runs for an skb whose egress device ifindex matches
+ * cfg_ifindex[0]. The ifindex filter scopes the count to the test interface so
+ * unrelated background reallocs are not counted. fentry is BTF/CO-RE based, so
+ * this attaches by its SEC name via "bpftool prog loadall ... autoattach" with
+ * no raw kprobe name, no bpftrace, and no user-space loader.
+ *
+ * The companion tc program (tx_extra_headroom_tc.bpf.c) is what forces the
+ * reallocation this program observes. Userspace writes cfg_ifindex[0] (the
+ * device under test) and resets realloc_cnt[0] before each run via bpftool,
+ * then reads realloc_cnt[0] after.
+ */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_tracing.h>
+
+/* realloc_cnt[0] = number of pskb_expand_head calls on the test interface. */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} realloc_cnt SEC(".maps");
+
+/* cfg_ifindex[0] = ifindex of the device under test (set by userspace). */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} cfg_ifindex SEC(".maps");
+
+/*
+ * BPF_PROG unpacks the trampoline args, so skb is the first argument of
+ * pskb_expand_head(struct sk_buff *, int, int, gfp_t). Count only reallocs
+ * whose egress device matches the configured ifindex.
+ */
+SEC("fentry/pskb_expand_head")
+int BPF_PROG(count_realloc, struct sk_buff *skb)
+{
+	__u32 key = 0;
+	__u32 *want;
+	__u64 *cnt;
+	__u32 ifi;
+
+	want = bpf_map_lookup_elem(&cfg_ifindex, &key);
+	if (!want || *want == 0)
+		return 0;
+
+	/* CO-RE read: skb->dev may be NULL on some paths. */
+	if (!BPF_CORE_READ(skb, dev))
+		return 0;
+	ifi = BPF_CORE_READ(skb, dev, ifindex);
+	if (ifi != *want)
+		return 0;
+
+	cnt = bpf_map_lookup_elem(&realloc_cnt, &key);
+	if (cnt)
+		__sync_fetch_and_add(cnt, 1);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tx_extra_headroom_tc.bpf.c b/tools/testing/selftests/bpf/progs/tx_extra_headroom_tc.bpf.c
new file mode 100644
index 000000000..43e3bea60
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tx_extra_headroom_tc.bpf.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tc-egress pusher for the tx_extra_headroom data-plane selftest.
+ *
+ * On egress, pushes OUTER_LEN bytes of outer header via
+ * bpf_skb_adjust_room(..., BPF_ADJ_ROOM_MAC, ...). On an skb allocated with only
+ * LL_RESERVED_SPACE() of headroom this forces skb_cow_head() ->
+ * pskb_expand_head() (a realloc-and-copy) on every packet; when the device has
+ * reserved extra headroom via tx_extra_headroom the push finds room already
+ * present and no realloc happens. The reallocation is counted by the companion
+ * fentry program in tx_extra_headroom_probe.bpf.c.
+ *
+ * UDP only, so TCP control traffic and IPv6 NDP are not corrupted. OUTER_LEN
+ * defaults to 20 (one IPv4 header) and can be overridden at build time.
+ */
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/pkt_cls.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#ifndef OUTER_LEN
+#define OUTER_LEN 20
+#endif
+
+SEC("tc")
+int push_outer(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct ethhdr *eth = data;
+	__u8 l4 = 0;
+
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		struct iphdr *ip = (void *)(eth + 1);
+
+		if ((void *)(ip + 1) > data_end)
+			return TC_ACT_OK;
+		l4 = ip->protocol;
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ip6 = (void *)(eth + 1);
+
+		if ((void *)(ip6 + 1) > data_end)
+			return TC_ACT_OK;
+		l4 = ip6->nexthdr;
+	} else {
+		return TC_ACT_OK;
+	}
+
+	/* UDP only: do not corrupt TCP or ICMPv6/NDP control traffic. */
+	if (l4 != IPPROTO_UDP)
+		return TC_ACT_OK;
+
+	/*
+	 * Grow at the MAC layer by OUTER_LEN. The helper's internal
+	 * skb_cow_head() reallocates when headroom is insufficient; that
+	 * realloc is exactly what tx_extra_headroom is meant to avoid.
+	 */
+	bpf_skb_adjust_room(skb, OUTER_LEN, BPF_ADJ_ROOM_MAC, 0);
+	return TC_ACT_OK;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.50.1

