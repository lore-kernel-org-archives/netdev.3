Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2549E35F164
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570514; cv=none; b=Zrcr+dKACk7bjqN7dElh5EYWdBxUsi4dzBjhfNzXf/LYVZ7wNQ/H5VjdZzzUSzuMusPw5nHApXzxSWTdqriRPzHw3c/I+ui38Qq8xMB2bvB13IAbpbgY8m/dPiXAyN8CN9HtkpVP9GqHYrnjKiDUI2a9bkWvCQa4I0a+XsoGGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570514; c=relaxed/simple;
	bh=C9vK1hMwPFI1REHzPs2lJbPRSwpXoDf/Gwm9LmYY360=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FE2WOEYvreI9KqUpWyrNJh8DFF9LqdSdiu2qqS4MyqD33sMUZJgmCEE2TLFeXrqOpuW1j/aV2XxubMYO461Ye/vs9p4tvTrWqJDfxyUF+6wFK8z80Z7jMG/YqJSKXTotW6lAsYdzp5AfVKMrKJSKnZDoy4hSvgJOBns0xL7xRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=lgeeIH5s; arc=none smtp.client-ip=74.125.229.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="lgeeIH5s"
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e6be52a80so366158eec.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790570511; x=1791175311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9wCXSkWYXprmObiSZgE+C1kfdGbVxkipXY9GaDORA/Q=;
        b=lgeeIH5s37u0ImlaibJ8cmbYGpKHP14oQsDlm7H426umBnpvudLW21FAqZts8RFWtH
         9j2WfRp4qFwtcamTJqKNCVSxfhEI0ORgV+skF3hdrvoaF4T6TkkpVwe6orx4ebUQnvkK
         +qzp2dWaQ7PcKM4pwOwfd23DQ1NG9qB2rWFPFBOQPI5DSEZTYZu+AhyomW25KdyPbM21
         3hz4EdXpFH0KuC+c8CoJF+0zyUaLMPkUvJQr7BMDJYjriu8JRWHBSvml0vgeQaC5BNiS
         bt/1CvBeCtO+tpk1EBwD5JusBo8k76sMKT4K9f4CPLcimAjxVePvopJMhURlKPegdoHI
         7IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570511; x=1791175311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9wCXSkWYXprmObiSZgE+C1kfdGbVxkipXY9GaDORA/Q=;
        b=GeN9X5BnqzeZymvE0N9bPp21va5UbGkCAj/6gBhfY9Qou03yF1LesS/0Omjz+Wq2Kh
         4nWpYEartzORY6ASuVTAADaJDrlkU8f4pSptXNYxhFC/u4mM7CsOp/gapS142p1ulnPM
         PYa4Ac/+XLwpqN3WphYrL6GV1KtFyX/Y3qsjfPIRpJtddCG2sEMwuOlFvBcAG1XBrG6b
         UlNSr/asY3vBaemha8OO7cw19Rqz/vamGJqfBmpIHMuf4swnVpzC2uTkXCQsniNUfX26
         8+gDMykCst20snD08xHeKHG0ngdDn4qWjwshi9PjQam0JgaKFYDG/47U9w5BqyaXmlsG
         bi+Q==
X-Gm-Message-State: AFq9FYIuTEBz+KSzdbzTp9d4zkLH6/1ayh8pncJ2DqenRyLtiTRiggtk
	qh/E21/AWutQaf8M2h6DETji6+hfUIEHaASvmAPufxPvd3flzQWl6/LAzwDxsyWs9a1+FraEA00
	O9ngoY26xbtxDTzEDsll++Xr5fp+ePlQyaT9robo1IZsvIXKIMLtkWrvmcpawf2CF8E+sjk6enD
	6V2w==
X-Gm-Gg: AYBFou2yS9mbrnkjcrMjyU9ntE6hmbU2R6FAFuQNPReWzHiLsAteTjztrCcSBSfnTua
	Yexya8GDc+NPXjZ+kf+QCGXx4S/BK9IumRglTPuVpCVQzSE3SK6IzyXyM7VEcqRx1GKDdFAMTU8
	AQwR3UVQsbzO3Z1bqASCLXF5mDfRO9yPabHzgYQeAN7IuRAiY4SLAVii8OnMBVGynzWJjU9QG04
	E0UXYKyVfWBJlIi81WPPiZqBoPuDMSDB0YQtAqtjmIPHxhBsOmF1PA5xYxXjtyjNiOX5vfyuPoZ
	oVBk2qnl0KR2VOIeIiPYaF0x3fEvmPbih7pTBDNGV7pVAB8Fd2awyROVUmqnRZnbeOfNitYAJgL
	6atGBr+oRJ0EKwTTTwxdpiuaOhFs/NhKXuqnLkF+QkpnnKh+MG3wjW8NM2Y4X07sXB4SwVD2P0o
	ZfYnpoAa3qm82LuiXC9qG5O+ywcWvpsj2KM04BYdji6ez5F0pVVuBRUwwNMXKuEC/oJlFcx6sxm
	UJaGg5EeLE=
X-Received: by 2002:a05:693c:39c4:b0:33c:43c:f3dd with SMTP id 5a478bee46e88-34272d5bf0cmr7225654eec.11.1790570510439;
        Sun, 27 Sep 2026 21:41:50 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm22772905eec.28.2026.09.27.21.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:41:50 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v3 5/5] net: net_test: add tests for bounded GSO segmentation
Date: Mon, 28 Sep 2026 12:41:02 +0800
Message-ID: <20260928044102.1004310-6-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928044102.1004310-1-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GSO engine can now be asked to bound the number of MSS segments which
go into each output skb.  Add KUnit coverage for it.

The parameterized GSO test gains a max_segs input and three cases: two
bounds which cut the input into two and three output skbs, and a bound of
one MSS, which must leave the ungrouped output of the unbounded path
alone.  It drives skb_segment() directly, because the synthetic protocol
it uses has no gso_segment callback, and stores the bound in the GSO
control block itself.

The TCP test drives __skb_gso_segment() with a bound of two MSS and checks
that every output skb stays GSO, keeps its gso_size, and stays within the
bound.  The length test runs a 200 KiB TCP skb through
validate_xmit_skb_list(), the caller which sets the bound, and checks that
the length declared by every output matches the L3 length of that output.
The limit test checks that the GSO size limit which netif_skb_features()
applies follows the packet's L3 protocol, for an IPv4 and an IPv6 skb,
also with the tag inside the frame.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v3:
- add cases for the length a bounded output declares and for a bound of one
  MSS, which must leave the output ungrouped
- cover the IPv4 half of the limit test, checking the protocol's own bit
- skip the TCP cases without CONFIG_INET and bound the expected index in
  the parameterized loop
- free the skb and the device on the failure paths
- reserve headroom so the VLAN step needs no atomic allocation
- drop NETIF_F_TSO: the transmit path passes the features without it
v2: https://lore.kernel.org/20260918084651.3022878-5-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-5-wang.zhan@smartx.com/
---
 net/core/net_test.c | 347 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 347 insertions(+)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 9c3a590865d26..a4f61398a90ab 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -4,7 +4,14 @@
 
 /* GSO */
 
+#include <linux/if_ether.h>
+#include <linux/if_vlan.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <linux/tcp.h>
+#include <net/gso.h>
 
 static const char hdr[] = "abcdefgh";
 #define GSO_TEST_SIZE 1000
@@ -34,6 +41,9 @@ enum gso_test_nr {
 	GSO_TEST_FRAG_LIST_PURE,
 	GSO_TEST_FRAG_LIST_NON_UNIFORM,
 	GSO_TEST_GSO_BY_FRAGS,
+	GSO_TEST_BOUNDED,
+	GSO_TEST_BOUNDED_MULTI,
+	GSO_TEST_BOUNDED_ONE_MSS,
 };
 
 struct gso_test_case {
@@ -46,10 +56,12 @@ struct gso_test_case {
 	const unsigned int *frags;
 	unsigned int nr_frag_skbs;
 	const unsigned int *frag_skbs;
+	unsigned int max_segs;
 
 	/* output as expected */
 	unsigned int nr_segs;
 	const unsigned int *segs;
+	bool segs_are_gso;
 };
 
 static struct gso_test_case cases[] = {
@@ -135,6 +147,54 @@ static struct gso_test_case cases[] = {
 		.nr_segs = 4,
 		.segs = (const unsigned int[]) { 100, 200, 300, 400 },
 	},
+	{
+		.id = GSO_TEST_BOUNDED,
+		.name = "bounded",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frags = 3,
+		.frags = (const unsigned int[]) {
+			GSO_TEST_SIZE, GSO_TEST_SIZE, 3,
+		},
+		.max_segs = 2,
+		.nr_segs = 2,
+		.segs = (const unsigned int[]) {
+			2 * GSO_TEST_SIZE, GSO_TEST_SIZE + 3,
+		},
+		.segs_are_gso = true,
+	},
+	{
+		.id = GSO_TEST_BOUNDED_MULTI,
+		.name = "bounded_multi",
+		.linear_len = 2 * GSO_TEST_SIZE,
+		.nr_frags = 4,
+		.frags = (const unsigned int[]) {
+			GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3,
+		},
+		.max_segs = 2,
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) {
+			2 * GSO_TEST_SIZE, 2 * GSO_TEST_SIZE, GSO_TEST_SIZE + 3,
+		},
+		.segs_are_gso = true,
+	},
+	{
+		/*
+		 * One MSS per skb is what the unbounded path produces, so a
+		 * bound of a single segment must not change the output.
+		 */
+		.id = GSO_TEST_BOUNDED_ONE_MSS,
+		.name = "bounded_one_mss",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frags = 3,
+		.frags = (const unsigned int[]) {
+			GSO_TEST_SIZE, GSO_TEST_SIZE, 3,
+		},
+		.max_segs = 1,
+		.nr_segs = 4,
+		.segs = (const unsigned int[]) {
+			GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3,
+		},
+	},
 };
 
 static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
@@ -226,6 +286,7 @@ static void gso_test_func(struct kunit *test)
 	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
 		features &= ~NETIF_F_SG;
 
+	SKB_GSO_CB(skb)->max_segs = tcase->max_segs;
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
 		KUNIT_FAIL(test, "segs error %pe", segs);
@@ -239,6 +300,7 @@ static void gso_test_func(struct kunit *test)
 	for (cur = segs, i = 0; cur; cur = next, i++) {
 		next = cur->next;
 
+		KUNIT_ASSERT_LT(test, i, tcase->nr_segs);
 		KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + tcase->segs[i]);
 
 		/* segs have skb->data pointing to the mac header */
@@ -247,6 +309,17 @@ static void gso_test_func(struct kunit *test)
 
 		/* header was copied to all segs */
 		KUNIT_ASSERT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
+		if (tcase->segs_are_gso) {
+			KUNIT_EXPECT_TRUE(test, skb_is_gso(cur));
+			KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_size,
+					GSO_TEST_SIZE);
+			KUNIT_EXPECT_LE(test, skb_shinfo(cur)->gso_segs,
+					tcase->max_segs);
+			KUNIT_EXPECT_FALSE(test, skb_shinfo(cur)->gso_type &
+					 SKB_GSO_PARTIAL);
+		} else if (tcase->max_segs) {
+			KUNIT_EXPECT_FALSE(test, skb_is_gso(cur));
+		}
 
 		/* last seg can be found through segs->prev pointer */
 		if (!next)
@@ -261,6 +334,277 @@ static void gso_test_func(struct kunit *test)
 	consume_skb(skb);
 }
 
+#define GSO_TCP_HDR_LEN \
+	(ETH_HLEN + sizeof(struct iphdr) + sizeof(struct tcphdr))
+
+static struct sk_buff *gso_tcp_skb_new(unsigned int payload_len)
+{
+	struct sk_buff *skb;
+	struct ethhdr *eth;
+	struct tcphdr *th;
+	struct iphdr *iph;
+
+	skb = alloc_skb(GSO_TCP_HDR_LEN + payload_len, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+	skb_put_zero(skb, GSO_TCP_HDR_LEN + payload_len);
+
+	skb_reset_mac_header(skb);
+	eth = eth_hdr(skb);
+	eth->h_proto = htons(ETH_P_IP);
+	skb->protocol = eth->h_proto;
+
+	skb_set_network_header(skb, ETH_HLEN);
+	iph = ip_hdr(skb);
+	iph->version = 4;
+	iph->ihl = sizeof(*iph) / 4;
+	iph->protocol = IPPROTO_TCP;
+	iph->tot_len = htons(sizeof(*iph) + sizeof(*th) + payload_len);
+
+	skb_set_transport_header(skb, ETH_HLEN + sizeof(*iph));
+	th = tcp_hdr(skb);
+	th->doff = sizeof(*th) / 4;
+
+	skb->ip_summed = CHECKSUM_PARTIAL;
+	skb->csum_start = skb_transport_header(skb) - skb->head;
+	skb->csum_offset = offsetof(struct tcphdr, check);
+	skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
+	skb_shinfo(skb)->gso_size = GSO_TEST_SIZE;
+	skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(payload_len, GSO_TEST_SIZE);
+
+	return skb;
+}
+
+/*
+ * The transmit path passes the features of the device which rejects this
+ * skb, with the GSO bits cleared, so the engine segments it.
+ */
+static void gso_test_tcp_bounded_segment(struct kunit *test)
+{
+	netdev_features_t features = NETIF_F_SG | NETIF_F_HW_CSUM;
+	const unsigned int payload_len = 3 * GSO_TEST_SIZE + 3;
+	struct sk_buff *skb, *segs, *cur, *next;
+	const unsigned int expected[] = {
+		2 * GSO_TEST_SIZE, GSO_TEST_SIZE + 3,
+	};
+	const unsigned int max_segs = 2;
+	int i = 0;
+
+	if (!IS_ENABLED(CONFIG_INET))
+		kunit_skip(test, "requires CONFIG_INET");
+
+	skb = gso_tcp_skb_new(payload_len);
+	if (!skb) {
+		KUNIT_FAIL(test, "no skb");
+		return;
+	}
+
+	segs = __skb_gso_segment(skb, features, true, max_segs);
+	if (IS_ERR_OR_NULL(segs)) {
+		KUNIT_FAIL(test, "segs error %pe", segs);
+		consume_skb(skb);
+		return;
+	}
+
+	for (cur = segs; cur; cur = next, i++) {
+		next = cur->next;
+
+		KUNIT_ASSERT_LT(test, i, ARRAY_SIZE(expected));
+		KUNIT_EXPECT_EQ(test, cur->len,
+				GSO_TCP_HDR_LEN + expected[i]);
+		KUNIT_EXPECT_TRUE(test, skb_is_gso(cur));
+		KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_size,
+				GSO_TEST_SIZE);
+		KUNIT_EXPECT_LE(test, skb_shinfo(cur)->gso_segs, max_segs);
+
+		consume_skb(cur);
+	}
+
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(expected));
+	consume_skb(skb);
+}
+
+#define GSO_TCP6_HDR_LEN \
+	(ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
+
+static struct sk_buff *gso_tcp6_skb_new(unsigned int payload_len)
+{
+	struct ipv6hdr *ip6h;
+	struct sk_buff *skb;
+	struct ethhdr *eth;
+	struct tcphdr *th;
+
+	skb = alloc_skb(GSO_TCP6_HDR_LEN + payload_len, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+	skb_reserve(skb, NET_SKB_PAD);
+	skb_put_zero(skb, GSO_TCP6_HDR_LEN + payload_len);
+
+	skb_reset_mac_header(skb);
+	eth = eth_hdr(skb);
+	eth->h_proto = htons(ETH_P_IPV6);
+	skb->protocol = eth->h_proto;
+
+	skb_set_network_header(skb, ETH_HLEN);
+	ip6h = ipv6_hdr(skb);
+	ip6h->version = 6;
+	ip6h->nexthdr = IPPROTO_TCP;
+	ip6h->payload_len = htons(sizeof(*th) + payload_len);
+
+	skb_set_transport_header(skb, ETH_HLEN + sizeof(*ip6h));
+	th = tcp_hdr(skb);
+	th->doff = sizeof(*th) / 4;
+
+	skb->ip_summed = CHECKSUM_PARTIAL;
+	skb->csum_start = skb_transport_header(skb) - skb->head;
+	skb->csum_offset = offsetof(struct tcphdr, check);
+	skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
+	skb_shinfo(skb)->gso_size = GSO_TEST_SIZE;
+	skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(payload_len, GSO_TEST_SIZE);
+
+	return skb;
+}
+
+/*
+ * The device GSO size limit is per L3 protocol, so only a lowered limit of
+ * the packet's own protocol may cost it the TSO bit, and a tag inside the
+ * frame, which replaces skb->protocol with the ethertype, must not change
+ * which limit applies.  Takes ownership of @skb.
+ */
+static void gso_test_tcp_l3_limit(struct kunit *test, struct net_device *dev,
+				  struct sk_buff *skb, netdev_features_t tso,
+				  bool ipv6)
+{
+	unsigned int other = GSO_LEGACY_MAX_SIZE;
+	unsigned int own = GSO_MAX_SIZE;
+
+	/* The skb fits the limit of its own L3 protocol, not the other's. */
+	dev->gso_max_size = ipv6 ? own : other;
+	dev->gso_ipv4_max_size = ipv6 ? other : own;
+	KUNIT_EXPECT_TRUE(test, netif_skb_features(skb) & tso);
+
+	/* ...and the other way around. */
+	swap(own, other);
+	dev->gso_max_size = ipv6 ? own : other;
+	dev->gso_ipv4_max_size = ipv6 ? other : own;
+	KUNIT_EXPECT_FALSE(test, netif_skb_features(skb) & tso);
+
+	skb = vlan_insert_tag_set_proto(skb, htons(ETH_P_8021Q), 0);
+	if (!skb) {
+		KUNIT_FAIL(test, "no tagged skb");
+		return;
+	}
+	KUNIT_EXPECT_TRUE(test, skb->protocol == htons(ETH_P_8021Q));
+
+	swap(own, other);
+	dev->gso_max_size = ipv6 ? own : other;
+	dev->gso_ipv4_max_size = ipv6 ? other : own;
+	KUNIT_EXPECT_TRUE(test, netif_skb_features(skb) & tso);
+
+	swap(own, other);
+	dev->gso_max_size = ipv6 ? own : other;
+	dev->gso_ipv4_max_size = ipv6 ? other : own;
+	KUNIT_EXPECT_FALSE(test, netif_skb_features(skb) & tso);
+
+	consume_skb(skb);
+}
+
+static void gso_test_tcp_limit_l3_proto(struct kunit *test)
+{
+	static const struct net_device_ops dummy_netdev_ops = { };
+	const unsigned int payload_len = 100 * 1024;
+	struct net_device *dev;
+	struct sk_buff *skb;
+
+	dev = alloc_etherdev(0);
+	if (!dev) {
+		KUNIT_FAIL(test, "no net_device");
+		return;
+	}
+	dev->netdev_ops = &dummy_netdev_ops;
+	dev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO |
+			   NETIF_F_TSO6;
+	dev->features = dev->hw_features;
+	dev->vlan_features = dev->hw_features;
+
+	skb = gso_tcp6_skb_new(payload_len);
+	if (!skb) {
+		KUNIT_FAIL(test, "no IPv6 skb");
+		goto free_dev;
+	}
+	skb->dev = dev;
+	gso_test_tcp_l3_limit(test, dev, skb, NETIF_F_TSO6, true);
+
+	skb = gso_tcp_skb_new(payload_len);
+	if (!skb) {
+		KUNIT_FAIL(test, "no IPv4 skb");
+		goto free_dev;
+	}
+	skb->dev = dev;
+	gso_test_tcp_l3_limit(test, dev, skb, NETIF_F_TSO, false);
+
+free_dev:
+	free_netdev(dev);
+}
+
+/*
+ * A bounded output is a plain GSO skb, so the whole length lands in the 16-bit
+ * L3 length field.  A device which accepts GSO skbs above 64 KiB would
+ * otherwise be handed outputs whose length field truncates.
+ */
+static void gso_test_tcp_resegment_l3_len(struct kunit *test)
+{
+	static const struct net_device_ops dummy_netdev_ops = { };
+	const unsigned int payload_len = 200 * 1024;
+	struct sk_buff *skb, *segs, *cur, *next;
+	unsigned int nr_segs = 0;
+	struct net_device *dev;
+	bool again = false;
+
+	if (!IS_ENABLED(CONFIG_INET))
+		kunit_skip(test, "requires CONFIG_INET");
+
+	dev = alloc_etherdev(0);
+	if (!dev) {
+		KUNIT_FAIL(test, "no net_device");
+		return;
+	}
+	dev->netdev_ops = &dummy_netdev_ops;
+	dev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO;
+	dev->features = dev->hw_features;
+	dev->vlan_features = dev->hw_features;
+	dev->gso_ipv4_max_size = 120 * 1024;
+
+	skb = gso_tcp_skb_new(payload_len);
+	if (!skb) {
+		KUNIT_FAIL(test, "no skb");
+		goto free_dev;
+	}
+	skb->dev = dev;
+
+	segs = validate_xmit_skb_list(skb, dev, &again);
+	if (IS_ERR_OR_NULL(segs)) {
+		KUNIT_FAIL(test, "segs error %pe", segs);
+		goto free_dev;
+	}
+
+	for (cur = segs; cur; cur = next, nr_segs++) {
+		next = cur->next;
+		cur->next = NULL;
+
+		KUNIT_EXPECT_TRUE(test, skb_is_gso(cur));
+		KUNIT_EXPECT_EQ(test, ntohs(ip_hdr(cur)->tot_len),
+				cur->len - (skb_network_header(cur) -
+					    skb_mac_header(cur)));
+		consume_skb(cur);
+	}
+
+	KUNIT_EXPECT_EQ(test, nr_segs, 4);
+
+free_dev:
+	free_netdev(dev);
+}
+
 /* IP tunnel flags */
 
 #include <net/ip_tunnels.h>
@@ -372,6 +716,9 @@ static void ip_tunnel_flags_test_run(struct kunit *test)
 
 static struct kunit_case net_test_cases[] = {
 	KUNIT_CASE_PARAM(gso_test_func, gso_test_gen_params),
+	KUNIT_CASE(gso_test_tcp_bounded_segment),
+	KUNIT_CASE(gso_test_tcp_limit_l3_proto),
+	KUNIT_CASE(gso_test_tcp_resegment_l3_len),
 	KUNIT_CASE_PARAM(ip_tunnel_flags_test_run,
 			 ip_tunnel_flags_test_gen_params),
 	{ },
-- 
2.47.3

