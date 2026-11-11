Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367323;
	b=cAiAK8KdZBIbW3U4p85o5AP4FliRqkef0BPAyFisRTASqfKKzHfyMLMUedPMaAicprs/
	 zUXX/f/86lkUS++IO+LgJoZbUKf5cRTsgEo6O6eVgg6vRK2m3n3sQvZBQ4gveomoKWvWE
	 h55zC1rt4x0prysgqz1uLs5rCW/VNMgF8BCO1xuiSHcrvpa8G58b8wTLIgETyUkaxUowM
	 i7NkZE1aq1cvRDVqP+XieUUADGngYIlGtr6fYtMytBeoRtmvtUeA3bDvyH0JwCvDEA7CI
	 epQgFqbzoOHoVHm/K+YfAauOqAe0gCeT3vGh1tzKZDSEqdswe7EZFbArieye+RNp6bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9hzrCM8HwPB0OkgvQi+cINu2lRLobW5+FEDHZL10osw=;
	b=l76SLE9HdigSPaVv2Td5KJlW6ieXiuGIHn3wilU0tzNqKZ+pYm7wEXgg2x/l+gX3jZtE
	 zcclogTHchmQlvBjD5dmSGqpyq9rRFYXWBa9GS+5ACn4ZaxGiZms4075vpXn4rUL3zr+8
	 Ug5w9LQAiovAgqWHuwQcuLMv9fMVHKkt6SNZaT1B4E8UJSZTCT8/KATUC2s0LhK471oYS
	 zfB4uo3q8wLpYThgYWne1WzuBJtrJpp+0Psn/yIxlrKnWbaYbmTW9XfKtpKZ3MApnoWv8
	 kDWSqCXCTFJ4swOxOPo07v2OJFbsF4EWFMj2oj09j73uOx5y2tpXAfOkoe7eEX+yi3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNMrj5MD;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174B606A33F
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 03:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C174B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNMrj5MD
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3712b6d9843so2604682eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 19:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794367322; x=1794972122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9hzrCM8HwPB0OkgvQi+cINu2lRLobW5+FEDHZL10osw=;
        b=nNMrj5MDLexqC8NKUunFtZwR13VzIkOV0WMei5pxF+d6+/hy39gejtLBJckqjCbBnr
         vsQyvYbTD+naFdWLim3qiQoTDRkSxdlPa1uqgdl/O7Coq3by4vjFvihy54GUuJU7TP6m
         VLuO0BI+6t1xe4ObQQ+OYzYugtuuh8b3O81Zc+x8ZufCWNDT+5jes4xLID6AzEcWmxm9
         1NYhO83xJlV2TmPVUHQRVavTFC67oks0OBxKt3YiSEMnl9Lmu8vo22Uhwia5LnjLvL/m
         SaNI5JGC87ShrlO4Vi7V/oizmJ3djE+vPl4LTZGWmFWIdfUf6o2gMpgV0xjHzdkQvIU7
         BU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367322; x=1794972122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9hzrCM8HwPB0OkgvQi+cINu2lRLobW5+FEDHZL10osw=;
        b=zFlxK3Uaa4zVxLZNFXgPdJk4Cm0yaUed/b9pFKvVj9U9X3mJMc0yFH0B77y4+31ind
         MMiDeI04lhu/TySWFL0kAGKvaGb66VuS+yGh+Y0+BD20F2X4Ezlq0MlHmS0rcZ9G4f0w
         Mhoe78bEyYq0nt9oKfD60d1l/RJNTgEiebWne6IETdgXqGvzgrDxZGQFkfy99U/hbb48
         +FPWCvt/rE/96VSWRGzUKCmn1xK0IYsOZPjA7T8W0DNBef3kYfYilghfocLj2BHFzubY
         Qash7UpBBkpgtnWRu4yM4FNAiXHxDpHFL/PVZRl5WpFeIsO0rfe1IX+K3NeH6WMtX1sq
         8zlg==
X-Forwarded-Encrypted: i=1; AL+hErHuB3T9L8ib4ofS2xK+63WvKRI4YiC+nunfW8DUqL/Eq+93kiVa+tguBSlp9BUpCa2xmQWT+bU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NNKKGG8lSHAWIHPjghOYdYeRxeHjT9n/jzo3Zjy+zLp7zWlb5
	mwW7txOl9vHwr1TOt9VMdep3KSgkHYDI9X9dzYxlcOEWmTJJRlmbLdNO
X-Gm-Gg: AYBFou1/v1smYYMkF271fto3I1eYZieGFIIMMa56QgLP7tUhVgC/eHWEgcnhpn3SpX7
	1DwYNVP/D0YNFJhgNBg3PD8etQrFlHuHS4Hsu263N5G4eI6VrH05A+JL51e/0V4s0ucIrNuy/DA
	whjP69qCaLiJsMtjh+bmqHBaDR9ib+ZAYUCBEIqdrcm9AEviQA00WYQPg6aWGmRGus0Ka+EmYT6
	pq+a2O3LfiN3xL4qJTTfl/H9URR7ofBXuY9OItRWmHdV/C3jZ6CCoUsOW/KsaInN34ak0DYJvoJ
	2VzK1AYzo7Xmkye4SZwye3Uuw0vQ+rv/XGJ468K8Wob1oJT+4aaWa5xkkEZUOJffn+k5QtUh0Sb
	UP2VNLkNS6C3ETR6mlTLqUaiioPRZIhQPL/o7278t2aDeU0CKoX8+BhY7FNMduJFzXd9a97aTIT
	7TlL9kYruSEQ7uY0Z4GBjc/96FEp1MOPRLEHlAsh9Ny70hcDDniwdj+4r43crvK50zCuPf/L8xz
	ZVtI4y5h0+3Xzo2oPyIX1926hBESBhJM9c82M4gaT3cXiYb+1QRqti0PA2foZRdtJbLBWCAwaAp
	LVATElu4ZlOe1MejIXOMwR5miOhZq896QX69Mp4zpMRdE2gOGW+9tN0hQduB0QQ=
X-Received: by 2002:a05:7300:2d2b:b0:35b:cb8a:8d0e with SMTP id 5a478bee46e88-37686073d42mr2409727eec.16.1794367321780;
        Tue, 10 Nov 2026 19:22:01 -0800 (PST)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm9801896eec.0.2026.11.10.19.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:22:01 -0800 (PST)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [RFC bpf-next v3 3/3] selftests/bpf: Add a test for the PPPoE encap/decap kfuncs
Date: Tue, 10 Nov 2026 22:21:41 -0500
Message-ID: <20261111032141.525444-4-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111032141.525444-1-thisseanzhang@gmail.com>
References: <20261111032141.525444-1-thisseanzhang@gmail.com>
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

Add a tc test that exercises the bpf_skb_pppoe_encap() and
bpf_skb_pppoe_decap() kfuncs.

The encap program is run over plain Ethernet/IPv4 and Ethernet/IPv6
packets. The test checks that the kernel writes a correct PPPoE
session header between the Ethernet and network headers (version,
type, code, session id, length and PPP protocol), that skb->protocol
becomes ETH_P_PPP_SES, and that the payload is preserved. It then
runs the decap program and checks that the original packet and
protocol metadata are restored.

The rejection paths are driven by the packet input: encapsulation of
a non-IP packet (ARP), decapsulation of a packet whose protocol is
not ETH_P_PPP_SES (plain IPv4, and an IPv4 packet whose bytes at the
PPP protocol offset decode as PPP_IP), decapsulation of a PPPoE
packet with an unsupported PPP protocol (IPCP), and decapsulation of
a packet too short to still hold an IP header.

A separate program that holds a packet pointer across a call to
bpf_skb_pppoe_encap() must fail verification, covering the
KF_CHANGES_PKT invalidation from the first patch.

Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>
---
 .../selftests/bpf/prog_tests/tc_pppoe.c       | 269 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/tc_pppoe.c  |  77 +++++
 .../selftests/bpf/progs/tc_pppoe_fail.c       |  36 +++
 3 files changed, 382 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_pppoe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_pppoe_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c b/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
new file mode 100644
index 000000000..5420d3bf3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 ThisSeanZhang */
+
+#include <arpa/inet.h>
+#include <test_progs.h>
+#include "tc_pppoe.skel.h"
+#include "tc_pppoe_fail.skel.h"
+
+/* Ethernet + IPv4 + TCP, 54 bytes in total. */
+static const __u8 ip4_pkt[] = {
+	/* Ethernet header. */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+	0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+	0x08, 0x00,
+	/* IPv4 header. */
+	0x45, 0x00, 0x00, 0x28,
+	0x12, 0x34, 0x40, 0x00,
+	0x40, 0x06, 0x00, 0x00,
+	0xc0, 0xa8, 0x01, 0x01,
+	0xc0, 0xa8, 0x01, 0x02,
+	/* TCP header. */
+	0x00, 0x50, 0x1f, 0x90,
+	0x00, 0x00, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00,
+	0x50, 0x02, 0x10, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+/* Ethernet + IPv6 + TCP, 74 bytes in total. */
+static const __u8 ip6_pkt[] = {
+	/* Ethernet header. */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+	0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+	0x86, 0xdd,
+	/* IPv6 header. */
+	0x60, 0x00, 0x00, 0x00,
+	0x00, 0x14, 0x06, 0x40,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02,
+	/* TCP header. */
+	0x00, 0x50, 0x1f, 0x90,
+	0x00, 0x00, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00,
+	0x50, 0x02, 0x10, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+/* Ethernet + ARP request, 42 bytes in total. */
+static const __u8 arp_pkt[] = {
+	/* Ethernet header. */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+	0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+	0x08, 0x06,
+	/* ARP payload. */
+	0x00, 0x01,
+	0x08, 0x00,
+	0x06, 0x04, 0x00, 0x01,
+	0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+	0xc0, 0xa8, 0x01, 0x01,
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+	0xc0, 0xa8, 0x01, 0x02,
+};
+
+#define PPPOE_SES_HLEN	8
+#define TC_ACT_SHOT	2
+
+static int run_prog(int prog_fd, const void *data_in, __u32 size_in,
+		    void *data_out, __u32 size_out, __u32 *retval,
+		    __u32 *size_out_actual)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = (void *)data_in,
+		    .data_size_in = size_in,
+		    .data_out = data_out,
+		    .data_size_out = size_out,
+	);
+	int ret;
+
+	ret = bpf_prog_test_run_opts(prog_fd, &opts);
+	if (!ret && retval)
+		*retval = opts.retval;
+	if (!ret && size_out_actual)
+		*size_out_actual = opts.data_size_out;
+
+	return ret;
+}
+
+static void test_encap_decap(struct tc_pppoe *skel, const char *subtest,
+			     const __u8 *pkt, __u32 pkt_len, int ethertype,
+			     __u8 ppp_proto)
+{
+	__u8 encap_pkt[128];
+	__u8 decap_pkt[128];
+	__u32 retval, out_len;
+	int ret;
+
+	if (!test__start_subtest(subtest))
+		return;
+
+	skel->bss->encap_proto = 0;
+	ret = run_prog(bpf_program__fd(skel->progs.tc_pppoe_encap),
+		       pkt, pkt_len, encap_pkt, sizeof(encap_pkt),
+		       &retval, &out_len);
+	ASSERT_OK(ret, "encap test_run");
+	ASSERT_OK(retval, "encap retval");
+	ASSERT_EQ(out_len, pkt_len + PPPOE_SES_HLEN, "encap pkt len");
+	ASSERT_EQ(skel->bss->encap_proto, htons(0x8864),
+		  "encap skb protocol");
+
+	/* Ethernet header, with the ethertype changed to PPPoE session. */
+	ASSERT_EQ(encap_pkt[12], 0x88, "encap eth h_proto");
+	ASSERT_EQ(encap_pkt[13], 0x64, "encap eth h_proto");
+	/* PPPoE session header written by the kernel. */
+	ASSERT_EQ(encap_pkt[14], 0x11, "encap pppoe ver/type");
+	ASSERT_EQ(encap_pkt[15], 0x00, "encap pppoe code");
+	ASSERT_EQ(encap_pkt[16], 0xde, "encap pppoe sid");
+	ASSERT_EQ(encap_pkt[17], 0xad, "encap pppoe sid");
+	ASSERT_EQ(encap_pkt[18], 0x00, "encap pppoe length");
+	ASSERT_EQ(encap_pkt[19], pkt_len - 14 + 2, "encap pppoe length");
+	ASSERT_EQ(encap_pkt[20], 0x00, "encap ppp proto");
+	ASSERT_EQ(encap_pkt[21], ppp_proto, "encap ppp proto");
+	/* The original packet moves behind the new header unchanged. */
+	ASSERT_MEMEQ(encap_pkt + 14 + PPPOE_SES_HLEN, pkt + 14,
+		     pkt_len - 14, "encap payload");
+
+	skel->bss->decap_proto = 0;
+	ret = run_prog(bpf_program__fd(skel->progs.tc_pppoe_decap),
+		       encap_pkt, pkt_len + PPPOE_SES_HLEN, decap_pkt,
+		       sizeof(decap_pkt), &retval, &out_len);
+	ASSERT_OK(ret, "decap test_run");
+	ASSERT_OK(retval, "decap retval");
+	ASSERT_EQ(out_len, pkt_len, "decap pkt len");
+	ASSERT_EQ(skel->bss->decap_proto, ethertype, "decap skb protocol");
+	ASSERT_MEMEQ(decap_pkt, pkt, pkt_len, "decap packet");
+}
+
+static void test_reject_input(struct tc_pppoe *skel, const char *prog_name,
+			      const __u8 *pkt, __u32 pkt_len,
+			      const char *subtest)
+{
+	struct bpf_program *prog;
+	__u8 out[128];
+	__u32 retval = 0;
+	int ret;
+
+	if (!test__start_subtest(subtest))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "find program"))
+		return;
+
+	skel->bss->encap_proto = 0;
+	skel->bss->decap_proto = 0;
+	ret = run_prog(bpf_program__fd(prog), pkt, pkt_len, out,
+		       sizeof(out), &retval, NULL);
+	ASSERT_OK(ret, "reject test_run");
+	ASSERT_EQ(retval, TC_ACT_SHOT, "kfunc rejected the call");
+	ASSERT_EQ(skel->bss->encap_proto, 0, "skb protocol unchanged");
+	ASSERT_EQ(skel->bss->decap_proto, 0, "skb protocol unchanged");
+}
+
+static void test_kfunc_flags(struct tc_pppoe *skel, const char *prog_name,
+			     int expected, const char *subtest)
+{
+	struct bpf_program *prog;
+	__u8 out[128];
+	__u32 retval = 0;
+	int ret;
+
+	if (!test__start_subtest(subtest))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "find program"))
+		return;
+
+	ret = run_prog(bpf_program__fd(prog), ip4_pkt, sizeof(ip4_pkt), out,
+		       sizeof(out), &retval, NULL);
+	ASSERT_OK(ret, "flags test_run");
+	ASSERT_EQ((int)retval, expected, "kfunc retval");
+}
+
+void test_tc_pppoe(void)
+{
+	/* PPPoE packet with PPP protocol 0x8021 (IPCP), neither IPv4 nor IPv6. */
+	static const __u8 bad_ppp_pkt[] = {
+		0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+		0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+		0x88, 0x64,
+		0x11, 0x00, 0x00, 0x00, 0x00, 0x28, 0x80, 0x21,
+		0x45, 0x00, 0x00, 0x28,
+		0x12, 0x34, 0x40, 0x00,
+		0x40, 0x06, 0x00, 0x00,
+		0xc0, 0xa8, 0x01, 0x01,
+		0xc0, 0xa8, 0x01, 0x02,
+		0x00, 0x50, 0x1f, 0x90,
+		0x00, 0x00, 0x00, 0x01,
+		0x00, 0x00, 0x00, 0x00,
+		0x50, 0x02, 0x10, 0x00,
+		0x00, 0x00, 0x00, 0x00,
+	};
+	/* PPPoE packet too short for a full inner IP header. */
+	static const __u8 truncated_pkt[] = {
+		0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+		0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+		0x88, 0x64,
+		0x11, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x21,
+		0x45, 0x00,
+	};
+	/* Non-PPPoE IPv4 packet whose bytes 20/21 decode as PPP_IP. */
+	static const __u8 fake_ppp_pkt[] = {
+		0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+		0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+		0x08, 0x00,
+		0x45, 0x00, 0x00, 0x28,
+		0x12, 0x34, 0x00, 0x21,
+		0x40, 0x06, 0x00, 0x00,
+		0xc0, 0xa8, 0x01, 0x01,
+		0xc0, 0xa8, 0x01, 0x02,
+		0x00, 0x50, 0x1f, 0x90,
+		0x00, 0x00, 0x00, 0x01,
+		0x00, 0x00, 0x00, 0x00,
+		0x50, 0x02, 0x10, 0x00,
+		0x00, 0x00, 0x00, 0x00,
+	};
+	struct tc_pppoe_fail *fail_skel;
+	struct tc_pppoe *skel;
+
+	skel = tc_pppoe__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		return;
+
+	test_encap_decap(skel, "encap-decap-v4", ip4_pkt, sizeof(ip4_pkt),
+			 htons(0x0800), 0x21);
+	test_encap_decap(skel, "encap-decap-v6", ip6_pkt, sizeof(ip6_pkt),
+			 htons(0x86dd), 0x57);
+
+	/* BPF_F_ADJ_ROOM_FIXED_GSO is accepted, unknown flags are not. */
+	test_kfunc_flags(skel, "tc_pppoe_encap_fixed_gso", 0,
+			 "encap-fixed-gso");
+	test_kfunc_flags(skel, "tc_pppoe_encap_bad_flags", -EINVAL,
+			 "encap-bad-flags");
+
+	/* Encapsulation of a non-IP packet must be rejected. */
+	test_reject_input(skel, "tc_pppoe_encap", arp_pkt, sizeof(arp_pkt),
+			  "encap-arp-reject");
+	/* Decapsulation of a packet whose protocol is not PPPoE. */
+	test_reject_input(skel, "tc_pppoe_decap", ip4_pkt, sizeof(ip4_pkt),
+			  "decap-non-pppoe");
+	test_reject_input(skel, "tc_pppoe_decap", bad_ppp_pkt,
+			  sizeof(bad_ppp_pkt), "decap-bad-ppp-proto");
+	test_reject_input(skel, "tc_pppoe_decap", truncated_pkt,
+			  sizeof(truncated_pkt), "decap-truncated");
+	test_reject_input(skel, "tc_pppoe_decap", fake_ppp_pkt,
+			  sizeof(fake_ppp_pkt), "decap-non-pppoe-fake-proto");
+
+	tc_pppoe__destroy(skel);
+
+	/*
+	 * KF_CHANGES_PKT must make the verifier reject a program that
+	 * keeps a packet pointer across the call.
+	 */
+	fail_skel = tc_pppoe_fail__open_and_load();
+	if (!ASSERT_ERR_PTR(fail_skel, "stale packet pointer rejected"))
+		tc_pppoe_fail__destroy(fail_skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/tc_pppoe.c b/tools/testing/selftests/bpf/progs/tc_pppoe.c
new file mode 100644
index 000000000..880abfbd5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tc_pppoe.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 ThisSeanZhang */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define ETH_P_PPP_SES_TEST	0x8864
+
+#define TC_ACT_OK_TEST		0
+#define TC_ACT_SHOT_TEST	2
+
+extern int bpf_skb_pppoe_encap(struct __sk_buff *skb,
+			       __be16 sid, u64 flags) __ksym;
+extern int bpf_skb_pppoe_decap(struct __sk_buff *skb, u64 flags) __ksym;
+
+/* skb->protocol as observed after the kfunc call. */
+int encap_proto;
+int decap_proto;
+
+SEC("tc")
+int tc_pppoe_encap(struct __sk_buff *skb)
+{
+	struct ethhdr eth;
+
+	if (bpf_skb_pppoe_encap(skb, bpf_htons(0xdead), 0))
+		return TC_ACT_SHOT_TEST;
+
+	encap_proto = skb->protocol;
+
+	if (bpf_skb_load_bytes(skb, 0, &eth, sizeof(eth)))
+		return TC_ACT_SHOT_TEST;
+	eth.h_proto = bpf_htons(ETH_P_PPP_SES_TEST);
+	if (bpf_skb_store_bytes(skb, 0, &eth, sizeof(eth), 0))
+		return TC_ACT_SHOT_TEST;
+
+	return TC_ACT_OK_TEST;
+}
+
+SEC("tc")
+int tc_pppoe_decap(struct __sk_buff *skb)
+{
+	struct ethhdr eth;
+
+	if (bpf_skb_pppoe_decap(skb, 0))
+		return TC_ACT_SHOT_TEST;
+
+	decap_proto = skb->protocol;
+
+	/*
+	 * Restore the ethertype to the protocol of the decapsulated
+	 * payload, as picked by the kernel from the PPP protocol field.
+	 */
+	if (bpf_skb_load_bytes(skb, 0, &eth, sizeof(eth)))
+		return TC_ACT_SHOT_TEST;
+	eth.h_proto = (__be16)skb->protocol;
+	if (bpf_skb_store_bytes(skb, 0, &eth, sizeof(eth), 0))
+		return TC_ACT_SHOT_TEST;
+
+	return TC_ACT_OK_TEST;
+}
+
+/* BPF_F_ADJ_ROOM_FIXED_GSO is accepted; any other flag is rejected. */
+SEC("tc")
+int tc_pppoe_encap_fixed_gso(struct __sk_buff *skb)
+{
+	return bpf_skb_pppoe_encap(skb, bpf_htons(0xdead),
+				   BPF_F_ADJ_ROOM_FIXED_GSO);
+}
+
+SEC("tc")
+int tc_pppoe_encap_bad_flags(struct __sk_buff *skb)
+{
+	return bpf_skb_pppoe_encap(skb, bpf_htons(0xdead), 1ULL << 32);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tc_pppoe_fail.c b/tools/testing/selftests/bpf/progs/tc_pppoe_fail.c
new file mode 100644
index 000000000..f816c7169
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tc_pppoe_fail.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 ThisSeanZhang */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define TC_ACT_SHOT_TEST	2
+
+extern int bpf_skb_pppoe_encap(struct __sk_buff *skb,
+			       __be16 sid, u64 flags) __ksym;
+
+/*
+ * bpf_skb_pppoe_encap() may reallocate the skb head, so the packet
+ * pointer checked before the call is stale afterwards: this program
+ * has to fail verification.
+ */
+SEC("tc")
+int tc_pppoe_stale_ptr(struct __sk_buff *skb)
+{
+	char *data = (char *)(long)skb->data;
+	char *data_end = (char *)(long)skb->data_end;
+	__u8 b = 0;
+
+	if (data + 1 > data_end)
+		return TC_ACT_SHOT_TEST;
+
+	if (bpf_skb_pppoe_encap(skb, bpf_htons(0xdead), 0))
+		return TC_ACT_SHOT_TEST;
+
+	b = *data;
+
+	return b;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3

