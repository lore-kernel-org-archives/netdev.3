Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8804CDA2E
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766972; cv=none; b=i2vZPS8+ikz5NsBhGdwmSdB8B4pzPwJ1MdRPjqTI7uY/eMKeoPZMOe6cgMgxZNhjfK3CCyy3hrkd/hcy2zF/zYFqIxcfDT11ESbKzOuDfn7lE88M6kF9kYasPgMfVK0NND5GGTuEvDZ8N4bMTJFG1PBMH5GKAvTMjC+05nzM+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766972; c=relaxed/simple;
	bh=03vJUToSjcWnuAmHQBdVqMhsuaA9Q1lY9fG7yuUhumU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMv87GiC2PA0fwgilpRfvbo47YScAKUO576RkVt2KmuU870cJos94raie5R3vkD+5zvy5QGVRPUIvwWwAQEnAZae+k0aTXpGIrDMNnzF+dck3Wb8v+vs2+CRrtSS8Br4AAYp/sn9b6VsgWy9DClHbQzxWd8XuFBA86SP7YoeUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=wQJQKviL; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="wQJQKviL"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34cde269e1bso321209eec.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790766970; x=1791371770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ihc3rDciqBJTTsa4OlV3U6BPyTwhLMYi+S06H8B/dVk=;
        b=wQJQKviLCuRrBBNdeI5mNwk2+GBhRk+w6YOTKxBwCqtc+D/llH8UF6G6zJ4sVh4Yia
         94JQ6Vpc85hL9w0IEleQSeaq9WhlDrbIdJQEnpAiFnl8Cqb1ap6kbUJ/qfFWbF7VHEYd
         WYWQDgRfP6bnhBV6N2TUW5ciEZYCEW2VZ6+c9AehpAzFcT/qJmkc9rgiU7FvQJ9p0H4X
         MIqPzbYnrMajy6BcWubfjDZmCUHkzQXZ/AEYUOYxw91+I4hKVngtvlKcPVwjNt6AtBJ3
         lheJR5bQGUFDkpj6xz1m6+yvsilabDVj/ybkIN/W7i+pBjZ+JBH1Lea43Rzy7Iu282Qt
         o2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766970; x=1791371770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ihc3rDciqBJTTsa4OlV3U6BPyTwhLMYi+S06H8B/dVk=;
        b=t8Itnt6QjqqDbIjst19RTDI+iHKF7fVXMRiSrR1sr7raTLV+NIM/0XwoSs6iJF5phZ
         GuuwAXWzuSdFV7jRgHG0b+/v7zR2fGB2iCpWlLmU4SuJp4C+I13N/m8hcps+3sMMZ3jb
         SSdYDeYZAX+0Lexto81Tm0ejqKYy5h5BJLTpFKVIRqv5t6YUezhO9aGUfleEhc9Cq8CB
         Sy2JbdO4nfqbbYg8DU3WlsJOGC1zK6Az1MAaDkGvI6dDbpApR1DTLPvZO0ez3dUJ7Kdv
         pR4RmyLKKPieAohOOJ6fSflbkZffbmM8vMbfYsSuRCnYmMqYqKFqsuJby/rklXz8P4ua
         jyhg==
X-Gm-Message-State: AFq9FYK6qDo5+uGPqVoo4wk2/hP1eg1+LoO/R7UdMsX9UmBaHr75UVv/
	8W/2OpQpFk+6EJR+CR3ldyQbBOWqQi38oD+0H7lYjhDMTblJEwG+cEIMNydGA+lmk1/I7r9dXya
	rOC7z85ckXNBslNTggc7V/W9L3JYbdzm2sn2+hIyBdSZpxphad0nnMVL022x8yrYlTxKPeBW2
X-Gm-Gg: AYBFou1ZTeBNxznM1J1muY5CuLCiDvTo80mYVXIMVRCDVCGWuv1KAx9i5P2bjqZWEEW
	UX4My8OVKf7Cd+2CsThNAwtzkD4nTDap7TRS3F4Ydvo2Q4A+srOsWygRiNjVdyln0JXQUHXZ6dv
	xzGpfevZ6zFatYrCphqoPdHBbNcd1xGachig02cB142mkc/fvsvnJVYd433dlb6pL9NhAxEmfNl
	blSsU/orvZ+0onh0pqYADKzdItVcs9cLb/7yfSQgakJM6CXa0SbPjWtWbbRm2vbaFuYvWtvbZqC
	AF3cMH2zOVtG6y0lLYHzYemtW8njaJnJmfm6qN4DN9FxCn+X8SzTA9KuWiY5vuEYTA2H5uQPd8k
	BJtiOhYbNEyLY05raoQZMNrMEnybY9/kJLYwdAuQqHBVyxiQDqYx5NNAc+BW3ZiKEMxxhHIVaG3
	Fq60Fg5mZ9CfcrVmBnZ51Kjp9SxV6dGl5W6M2bX31GM1H6A/XvvePdfbRskov64/Rlp6wU9g98g
	VvE9o83kvk=
X-Received: by 2002:a05:7300:d211:b0:34b:5ab2:e200 with SMTP id 5a478bee46e88-34cdc0cd8c7mr1477552eec.14.1790766968556;
        Wed, 30 Sep 2026 04:16:08 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5a2c6f9sm3520320eec.21.2026.09.30.04.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:16:08 -0700 (PDT)
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
Subject: [PATCH net-next v4 5/5] net: net_test: add tests for TCP re-segmentation
Date: Wed, 30 Sep 2026 19:15:26 +0800
Message-ID: <20260930111526.2183107-6-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930111526.2183107-1-wang.zhan@smartx.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GSO engine can now be asked to group several MSS segments into one
output skb, which is what re-segmentation needs.  Add KUnit coverage for
the max_segs parameter.

The parameterized GSO test gains a max_segs input and three cases: two
limits which cut the input into two and three output skbs, and a max_segs
of one MSS, which must leave the output unchanged.  It drives
skb_segment() directly, because the synthetic protocol it uses has no
gso_segment callback, and stores max_segs in the GSO control block itself.

The TCP test drives __skb_gso_segment() with a max_segs of two MSS and
checks that every output skb stays GSO, keeps its gso_size, and stays
within the limit.  The length test runs a 200 KiB TCP skb through
validate_xmit_skb_list(), the caller which sets max_segs, and checks that
the length declared by every output matches the L3 length of that output.
The limit test checks that the GSO size limit which netif_skb_features()
applies follows the packet's L3 protocol, for an IPv4 and an IPv6 skb,
also with the tag inside the frame.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v4:
- name the cases and the descriptions after re-segmentation
- reserve the headroom the VLAN step needs in both builders
- check the exact gso_segs of each output
- free the segments when a bounded case does not match
v3: https://lore.kernel.org/20260928044102.1004310-6-wang.zhan@smartx.com/
v2: https://lore.kernel.org/20260918084651.3022878-5-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-5-wang.zhan@smartx.com/
---
 net/core/net_test.c | 351 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 351 insertions(+)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 9c3a590865d269..6a91db83e53017 100644
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
+	GSO_TEST_RESEGMENT,
+	GSO_TEST_RESEGMENT_MULTI,
+	GSO_TEST_RESEGMENT_ONE_MSS,
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
@@ -135,6 +147,51 @@ static struct gso_test_case cases[] = {
 		.nr_segs = 4,
 		.segs = (const unsigned int[]) { 100, 200, 300, 400 },
 	},
+	{
+		.id = GSO_TEST_RESEGMENT,
+		.name = "resegment",
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
+		.id = GSO_TEST_RESEGMENT_MULTI,
+		.name = "resegment_multi",
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
+		/* A max_segs of one leaves one MSS per skb, like no limit. */
+		.id = GSO_TEST_RESEGMENT_ONE_MSS,
+		.name = "resegment_one_mss",
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
@@ -226,6 +283,7 @@ static void gso_test_func(struct kunit *test)
 	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
 		features &= ~NETIF_F_SG;
 
+	SKB_GSO_CB(skb)->max_segs = tcase->max_segs;
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
 		KUNIT_FAIL(test, "segs error %pe", segs);
@@ -239,6 +297,7 @@ static void gso_test_func(struct kunit *test)
 	for (cur = segs, i = 0; cur; cur = next, i++) {
 		next = cur->next;
 
+		KUNIT_ASSERT_LT(test, i, tcase->nr_segs);
 		KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + tcase->segs[i]);
 
 		/* segs have skb->data pointing to the mac header */
@@ -247,6 +306,18 @@ static void gso_test_func(struct kunit *test)
 
 		/* header was copied to all segs */
 		KUNIT_ASSERT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
+		if (tcase->segs_are_gso) {
+			KUNIT_EXPECT_TRUE(test, skb_is_gso(cur));
+			KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_size,
+					GSO_TEST_SIZE);
+			KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_segs,
+					DIV_ROUND_UP(tcase->segs[i],
+						     GSO_TEST_SIZE));
+			KUNIT_EXPECT_FALSE(test, skb_shinfo(cur)->gso_type &
+					 SKB_GSO_PARTIAL);
+		} else if (tcase->max_segs) {
+			KUNIT_EXPECT_FALSE(test, skb_is_gso(cur));
+		}
 
 		/* last seg can be found through segs->prev pointer */
 		if (!next)
@@ -261,6 +332,283 @@ static void gso_test_func(struct kunit *test)
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
+	skb = alloc_skb(NET_SKB_PAD + GSO_TCP_HDR_LEN + payload_len,
+			GFP_KERNEL);
+	if (!skb)
+		return NULL;
+	skb_reserve(skb, NET_SKB_PAD);
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
+static void gso_test_tcp_resegment(struct kunit *test)
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
+		if (i < ARRAY_SIZE(expected)) {
+			KUNIT_EXPECT_EQ(test, cur->len,
+					GSO_TCP_HDR_LEN + expected[i]);
+			KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_segs,
+					DIV_ROUND_UP(expected[i],
+						     GSO_TEST_SIZE));
+		}
+		KUNIT_EXPECT_TRUE(test, skb_is_gso(cur));
+		KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_size,
+				GSO_TEST_SIZE);
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
+	skb = alloc_skb(NET_SKB_PAD + GSO_TCP6_HDR_LEN + payload_len,
+			GFP_KERNEL);
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
+ * A re-segmented output is a plain GSO skb, so the whole length lands in the
+ * 16-bit L3 length field.  A device which accepts GSO skbs above 64 KiB would
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
@@ -372,6 +720,9 @@ static void ip_tunnel_flags_test_run(struct kunit *test)
 
 static struct kunit_case net_test_cases[] = {
 	KUNIT_CASE_PARAM(gso_test_func, gso_test_gen_params),
+	KUNIT_CASE(gso_test_tcp_resegment),
+	KUNIT_CASE(gso_test_tcp_limit_l3_proto),
+	KUNIT_CASE(gso_test_tcp_resegment_l3_len),
 	KUNIT_CASE_PARAM(ip_tunnel_flags_test_run,
 			 ip_tunnel_flags_test_gen_params),
 	{ },
-- 
2.47.3

