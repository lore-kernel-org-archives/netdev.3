Received: from mail-pz2-f30.google.com (mail-pz2-f30.google.com [74.125.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953374C9E06
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012403; cv=none; b=lXRcSCqnFeVQJXrVSeKWz4bsezZdXLENW3eVklYiAcxb4xAZ48M4tPTQiTHuc6wYRVVbZszwP5bmwsGjr5L7iFfuiOCXb02y+YWG6M9jBMi7oAyxiCIJtU1GKcmJxvvLpnnJJ/DedjXOdfl44nEdR3a4dSnje708hVO77fHAYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012403; c=relaxed/simple;
	bh=G6MYpOzFS9oaQMkxPkHjP9bTWZdWzUL4Wm5DCp+oCjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ujmq0gQqD9yOq6TBl92LxbdqdhKJAHrrZH+vqrHH9Y2ZaA8TaEOp58rtHo+FpPVkoHC0IjxNt2ouPt6mL/edEE6LzfVOxqWaG/XH/QAzcZdzcy06sZGetOodFfB5sFfFEYPGUIxIiZWIFrjIAAYqib3JKk36JENrDZUnWOMT9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZaRz6wc; arc=none smtp.client-ip=74.125.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZaRz6wc"
Received: by mail-pz2-f30.google.com with SMTP id 41be03b00d2f7-cc1cea50dc0so1401347a12.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790012400; x=1790617200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9eJ58EFzv+KbS2BjBvEgqqhI69SkKi+v+DcklYWB+/8=;
        b=kZaRz6wcdpyS4w1YAvdChMzOmhQ6BOMMlkGfeeFkipwbEuEhKnVR2aEPoYIrYzlx0g
         mzkqgWiZXKVpvSl6eUw0EW7g6dDx6yIWonhhmC6Vk1YmQiHh2my84aIFh4D1MifC4Xcs
         W3nppw7NJdFhSXQNN/LrLFXC8k1D3KLBUg+ktJHlUr9eXRJ8hFaXTfXEM/KYNXquFR4J
         bcngKiI8NURVLWoQbZpRl8dgxP2yxbkp77tJT1n263lRZZ4wlwhgxc5ziz0BZuSXnuyV
         C0JaeCc9m7Yxc88r+u5UJlriKGO6qDk+YR24LWCq37h64z4aq3KzT69jRxvqKh1A015O
         1vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012400; x=1790617200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9eJ58EFzv+KbS2BjBvEgqqhI69SkKi+v+DcklYWB+/8=;
        b=txSE9r8FkFwQMqzlV9Ig/FHcp2JMh1vjnA7zcGPjjWznu+P2B1HOOaZlwWxJ6Uikor
         1KaEqnSDLhbxFNQeripD1TesGd9tl+R2kql+vXEOzQApXXH2d4ylSN2FWlazrKoanZnV
         2PFYAUYb6f01A8zxnEdBnDrEQTSVFYmqEHCNAkEEbF+4RKhJY7uML4VNvAGbK06l5S8R
         REY94RaTDOz7eRtlhuzsQQMTO8nDwA13Ht57woSS2xePvrbiYzG1Xui8wzV89MaPDLXT
         Y8jiYWcRPwicH4NTqUjia/RMmc4kq84+d+V30ZOyNVrMvKkXdOEpGkdxf1p+s/XC7nZ1
         vgAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCja6I/KGeO4XlYbktUSBdqyYPcuqbrds22+ygY2rkdSKHNMDKXidQZZuKU8/g711rWTUaBPw=@vger.kernel.org
X-Gm-Message-State: AFuF++k2AXzHEkmVmGxThnH1DtPO5ttAQIBFM57FYFMkd7nOlFbmPyhe
	C/Ub1lfyXTzAQ+aemwXgVneR0SmbpBO20qxxhTwlXRnDlNmSInKEaFE5
X-Gm-Gg: AYBFou16Uw/c/fur78QCD/IMMe7wBg/+LKc/S7hJ4J18/LlB7KMSi8n5GhGMzdGkMMk
	5IXC2lLRt+Itk0yVKHFA65gkuVJemtiqk46gH95CbCOhaNeROe/s+H3vH5tSsjnQ0ZLkbzLlHso
	/fIR+7D609YusEzgpGXQcYNu6CifutYF6Ucql/JDyfqA7rAxLc6pDGAKeSR79rQ06PyH4RpK10N
	I1eEvoBHuTEuUzRkJk41hWEVhPxSd8edmv+rLB8tZFyqM5WgdSPCy2VMKO36CTr9yC3Egvcfk4E
	bGfkJ7J0vwAcgvbgpFYYxS/rswhAN5xfqLvvQmEVElvy++SbfN5KCgOtgC6JhxTwg8lhqVD613/
	0G/2ejq1y0XpQrLb/+KkWvrON8BHZgOssGzUqCR4AO4W1JX8ltmiMBZeAPFQtbIjwDPFR7w4mDM
	D+bHDChdM/Gbzxnoly143U9cRz2yvOPmWVL3HhnxApdRYsAlIhTkBSO4YBnIiyd7EE36tOZ18OU
	37VkOOKuWLm2SSIT5DGu+ZzsHWUdDT3
X-Received: by 2002:a05:6a20:439f:b0:3d1:af47:5f80 with SMTP id adf61e73a8af0-3dd8c405d09mr19804538637.11.1790012399706;
        Mon, 21 Sep 2026 10:39:59 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72af0955esm3986985a12.32.2026.09.21.10.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 10:39:59 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v4 2/2] selftests/bpf: cover stale CB after LWT IP encapsulation
Date: Tue, 22 Sep 2026 01:39:10 +0800
Message-ID: <20260921173910.90847-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921173910.90847-1-bestswngs@gmail.com>
References: <20260921173910.90847-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compact regression coverage to the existing LWT IP encapsulation
test. Send an IPv4 ping with a Record Route option through an ingress LWT
program which prepends a TTL-one IPv4 header, then observe __icmp_send()
with fentry and verify that the restored protocol control block no longer
contains the inner header's cached option offsets.

Read ctx->cb[0] in the LWT program so the test exercises
bpf_prog_run_save_cb()'s save/restore path before the post-run check.

Link: https://lore.kernel.org/bpf/DLKB3UXOH0IS.1UL8NV9HSJFXG@gmail.com/
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 45 ++++++++++++++++++
 .../selftests/bpf/progs/test_lwt_ip_encap.c   | 47 +++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
index 39e8a3b8b6af..14ba33eaeb96 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
@@ -686,3 +686,48 @@ void test_lwt_ip_encap_vxlan_ipv6(void)
 {
 	lwt_ip_encap_vxlan(IPV6_ENCAP);
 }
+
+void test_lwt_ip_encap_stale_cb(void)
+{
+	char ns1[NETNS_NAME_SIZE] = NETNS_BASE "-1-";
+	char ns2[NETNS_NAME_SIZE] = NETNS_BASE "-2-";
+	char ns3[NETNS_NAME_SIZE] = NETNS_BASE "-3-";
+	struct test_lwt_ip_encap *skel = NULL;
+
+	if (!ASSERT_OK(create_ns(ns1, NETNS_NAME_SIZE), "create ns1"))
+		goto out;
+	if (!ASSERT_OK(create_ns(ns2, NETNS_NAME_SIZE), "create ns2"))
+		goto out;
+	if (!ASSERT_OK(create_ns(ns3, NETNS_NAME_SIZE), "create ns3"))
+		goto out;
+	if (!ASSERT_OK(setup_network(ns1, ns2, ns3, ""), "setup network"))
+		goto out;
+
+	skel = test_lwt_ip_encap__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		goto out;
+	bpf_program__set_autoload(skel->progs.bpf_lwt_encap_gre, false);
+	bpf_program__set_autoload(skel->progs.bpf_lwt_encap_gre6, false);
+	bpf_program__set_autoload(skel->progs.bpf_lwt_encap_vxlan, false);
+	bpf_program__set_autoload(skel->progs.bpf_lwt_encap_vxlan6, false);
+	bpf_program__set_autoload(skel->progs.bpf_lwt_encap_stale, false);
+	if (!ASSERT_OK(test_lwt_ip_encap__load(skel), "load"))
+		goto out;
+	if (!ASSERT_OK(test_lwt_ip_encap__attach(skel), "attach"))
+		goto out;
+
+	SYS(out, "ip -n %s route replace %s/32 encap bpf in obj %s sec encap_stale dev veth3",
+	    ns2, IP4_ADDR_DST, BPF_FILE);
+	skel->bss->stale_cb_seen = false;
+	skel->bss->stale_cb_cleared = false;
+	SYS_NOFAIL("ip netns exec %s ping -q -R -c 1 -W 1 -I veth1 %s >/dev/null 2>&1",
+		   ns1, IP4_ADDR_DST);
+	ASSERT_TRUE(skel->bss->stale_cb_seen, "stale_cb_seen");
+	ASSERT_TRUE(skel->bss->stale_cb_cleared, "stale_cb_cleared");
+
+out:
+	test_lwt_ip_encap__destroy(skel);
+	SYS_NOFAIL("ip netns del %s", ns1);
+	SYS_NOFAIL("ip netns del %s", ns2);
+	SYS_NOFAIL("ip netns del %s", ns3);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
index 4a934fccf8f5..8b57c7fb7fa8 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "vmlinux.h"
 #include <string.h>
+#include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_tracing.h>
@@ -10,6 +11,8 @@ struct grehdr {
 	__be16 protocol;
 };
 
+#define ICMP_TIME_EXCEEDED 11
+
 SEC("encap_gre")
 int bpf_lwt_encap_gre(struct __sk_buff *skb)
 {
@@ -80,6 +83,29 @@ int bpf_lwt_encap_gre6(struct __sk_buff *skb)
 	return BPF_LWT_REROUTE;
 }
 
+SEC("encap_stale")
+int bpf_lwt_encap_stale(struct __sk_buff *skb)
+{
+	struct iphdr iph = {};
+
+	/* Exercise CB restore before post-run invalidation. */
+	if (skb->cb[0])
+		return BPF_DROP;
+
+	iph.version = 4;
+	iph.ihl = 5;
+	iph.ttl = 1;
+	iph.protocol = IPPROTO_IPIP;
+	iph.tot_len = bpf_htons(skb->len + sizeof(iph));
+	iph.saddr = bpf_htonl(0xac100264); /* 172.16.2.100 */
+	iph.daddr = bpf_htonl(0xac100464); /* 172.16.4.100 */
+
+	if (bpf_lwt_push_encap(skb, BPF_LWT_ENCAP_IP, &iph, sizeof(iph)))
+		return BPF_DROP;
+
+	return BPF_OK;
+}
+
 #define VXLAN_PORT  4789
 #define VXLAN_FLAGS 0x08000000
 #define VXLAN_VNI   1
@@ -194,6 +220,27 @@ volatile const int tgt_ip_version;
 __u16 transport_hdr = 0;
 __u16 network_hdr = 0;
 bool fexit_triggered = false;
+bool stale_cb_cleared = false;
+bool stale_cb_seen = false;
+
+SEC("fentry/__icmp_send")
+int BPF_PROG(fentry_icmp_send, struct sk_buff *skb, int type, int code,
+	     __be32 info, const struct inet_skb_parm *parm)
+{
+	struct iphdr *iph;
+
+	if (type != ICMP_TIME_EXCEEDED)
+		return 0;
+
+	iph = (void *)BPF_CORE_READ(skb, head) + BPF_CORE_READ(skb, network_header);
+	if (BPF_CORE_READ(iph, daddr) != bpf_htonl(0xac100464))
+		return 0;
+
+	stale_cb_seen = true;
+	stale_cb_cleared = !BPF_CORE_READ(parm, opt.optlen) &&
+			   !BPF_CORE_READ(parm, opt.rr);
+	return 0;
+}
 
 SEC("?fexit/bpf_lwt_push_ip_encap")
 int BPF_PROG(fexit_lwt_push_ip_encap, struct sk_buff *skb, void *hdr, u32 len, bool ingress,
-- 
2.55.0

