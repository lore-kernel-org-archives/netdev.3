Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D312E22B5
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721271; cv=none; b=mmxUPUZ+V/ZxZOOEaPCuZHQlsjPRshbWEewhfsR9PYxZ8zWPAvgxr+KklgErOe1AI9AqI2klPMHvZZ8cwANcyUrgIR0KMCvQEepkYXblTOCjvcgBkqO7y84aMnrdkx4KWYxdhseO+VDV0UT9VwWevHp01MUYOVxTmlr0TKtpbWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721271; c=relaxed/simple;
	bh=0ZPwOWiie73m7+I8w4QoVVAiKL8lctn3+26dkhswGNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSi/T07yVylEwdrw3JPVsrTHIDnf1/1CNFl0KzIA0dRoA+ktWWZlMcdD4dLPWoI2icdZtXWr/BQ1xvoW1NomMYLE2IUo4V6YMufasHWTpV2R2Eo5lsuWmgBQ5NNO8f4LrzdR08/2mkXfj8rzjJcPmIbaDA1qbA7vZx1T0TnucMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=JDTpM4R+; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="JDTpM4R+"
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2db33361b2fso4043905ad.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789721269; x=1790326069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1XvpSKyrmCHT7dMphFLx8PksLDVZGygqrZYq1kDdTU=;
        b=JDTpM4R+dDeQC0zhyVPJHemGAmm2Gk7awWVDPdUP6G82NdqoF2I8qjNe6J4YLF3hiJ
         YR3mt59VMUXeFJbAueWWILuVDgGPovBM/vf4UkZbYel85utnOhzaAxKenC8MZ6spnWPW
         gHxDVoQozI1ZKkHNxpbJ3xf5G9BWeXzMhcxq1bV/Kt5NwxeqJ/3R08yFSn6UKoIwgZC+
         Al0qMyIkPOzCsXhwFZlSCT3oquccUdKcXLwPWAGnUv0HB95t3KLeNseJH2v9sMbjo7zF
         89nn1VlvoowB0tkP/aeKGv8qC2EAXjf2Hsg0lTH10lazWlWe+DcziZZ/hLVaWTM6llzG
         S00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789721269; x=1790326069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1XvpSKyrmCHT7dMphFLx8PksLDVZGygqrZYq1kDdTU=;
        b=H3GMuJjLJuuOnyH4+cSUI6Txp/7nDOz9yVWw8CML4weCNStXu7s5zS9rFB+85TDhIV
         YFBUIG8ARmHCA4YEUjs1YmiZYTmdk4lTLQXsU+yLye9ziD9c0ke98/Ux9QlgAj5ig5sa
         nnQfl77EUZuH5pUKEFvGmcQBimMRxWuwoAa0HVnKw/FIgMY+qeMCjSkCBu2E7kuBugJk
         NvwUco4ZaJQAdVaxz76M7Nt90bxFzPLBkZiEHbZwaypb9GuOLqgw8/NJDcNhmsBl+WBU
         ZVgX1frwHCEQQQJ/s8xQnJaBjWDB+j44IzK0mYsMzPIcNIs0xIMnxRg5FcuTQ4OG6ZXp
         s2gg==
X-Gm-Message-State: AFuF++lli8S84qGcHBdDHes0AQbOjMIMAJI8wB3P7l0IxI9RVHZ/IGPd
	zPdaPaoiTzkhCJ6l73suWUSHcjEiPFxpL0lx+T6hnp3fUTMumChVqEt++/M2rUi+GqKfGi1KnXx
	2Jsrw3CBo7niCZqtS48lWIIGcE8qcZIYscEFw60fjVqJ8lQPROp5znSlmE7Iqq4TgTucl9oyK69
	U4AZxR
X-Gm-Gg: AYBFou0K6gk+HHbKMbcfL89DWrVe4zqKsPUIXIGVxBR8CRXujObjAeSPfzpCOmefLQ7
	LzSpnrvjM/whTVO0ufYZr94xoyHhjeBfosfXNe8ouFjChrgWBs2Aby0Y+NCJczYIDT/Rx1xQfwR
	aFFQylC0Opa/fLfVnl3gHfoixGwhN4oKzJU9hVw5FIyC6UP8D90LpGJ2klTvqW2/tDQnYM0cpfQ
	6K9jcdpkijpO54AxybYKTHvx7feLgu+irSO2CThy6P3efJKsDtkTLDxZcby/3Ins1dL772EocGi
	aGpdBOkMdVnXjl+yQew5GpFZ9yLl4MJxKV2WR8xv7t2M1ce+5ibFaPaWzJEVjuZp9Kd8P9B7khs
	LelNoMqMXQ6Lelyxh2gzkhVkia6z7fEpuvSm+Qa378FNOV05/d+hqdXvsaV10Bt2Tw2dI2YZJdf
	ryVFL3G3MJSJ30dLWFj+T4iKjpknJ9IYW9o81ISbPF/kRS+bfJoAyhegy9HzClFVsaUI4LVPpOi
	AJyMK1RMF4=
X-Received: by 2002:a05:6a21:596:b0:3db:3e1c:8585 with SMTP id adf61e73a8af0-3dd8c493044mr4598891637.27.1789721268808;
        Fri, 18 Sep 2026 01:47:48 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287aab5fsm2578095eec.22.2026.09.18.01.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:47:48 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v2 4/4] net: net_test: add tests for bounded GSO segmentation
Date: Fri, 18 Sep 2026 16:46:51 +0800
Message-ID: <20260918084651.3022878-5-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918084651.3022878-1-wang.zhan@smartx.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GSO engine can now be asked to bound the number of MSS segments which
go into each output skb. Add KUnit coverage for the bound itself and for a
TCP skb segmented with one.

The parameterized GSO test gains a max_segs input and three cases: a bound
which splits the skb into two outputs, one which spans three outputs, and
a bound of a single MSS, which must leave the ungrouped output of the
unbounded path in place. Output skbs which remain GSO skbs carry the
original gso_size and no more than max_segs segments. It drives
skb_segment() directly, because the synthetic protocol it uses has no
gso_segment callback, and stores the bound in the GSO control block
itself.

The TCP test drives __skb_gso_segment() with a bound of two MSS and checks
that every output skb stays GSO, keeps its gso_size, and stays within the
bound.

The limit test checks that the GSO size limit which netif_skb_features()
applies follows the packet's L3 protocol, also after validate_xmit_vlan()
has pushed the VLAN tag inside the skb and skb->protocol is the VLAN
ethertype. It contrasts the two ways the IPv4 and IPv6 limits can be
skewed, and the skb with and without the tag.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v2:
- wrap the .frags/.segs initializers and the two header macros to 80 columns
- use KUNIT_ASSERT_TRUE() for the __be16 check, EQ warns in sparse
v1: https://lore.kernel.org/20260917063854.2011613-5-wang.zhan@smartx.com/
---
 net/core/net_test.c | 243 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 9c3a590865d26..6ca0cbe3a3653 100644
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
@@ -247,6 +308,15 @@ static void gso_test_func(struct kunit *test)
 
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
+		}
 
 		/* last seg can be found through segs->prev pointer */
 		if (!next)
@@ -261,6 +331,177 @@ static void gso_test_func(struct kunit *test)
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
+static void gso_test_tcp_bounded_segment(struct kunit *test)
+{
+	netdev_features_t features = NETIF_F_SG | NETIF_F_HW_CSUM |
+				     NETIF_F_TSO;
+	const unsigned int payload_len = 3 * GSO_TEST_SIZE + 3;
+	struct sk_buff *skb, *segs, *cur, *next;
+	const unsigned int expected[] = {
+		2 * GSO_TEST_SIZE, GSO_TEST_SIZE + 3,
+	};
+	const unsigned int max_segs = 2;
+	int i = 0;
+
+	skb = gso_tcp_skb_new(payload_len);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+
+	segs = __skb_gso_segment(skb, features, true, max_segs);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, segs);
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
+/* The device GSO size limit is per L3 protocol, and it has to survive the
+ * VLAN tag which validate_xmit_vlan() can push inside the skb, because that
+ * tag replaces skb->protocol with the VLAN ethertype.
+ */
+static void gso_test_tcp_limit_l3_proto(struct kunit *test)
+{
+	static const struct net_device_ops dummy_netdev_ops = { };
+	const unsigned int payload_len = 100 * 1024;
+	netdev_features_t features;
+	struct net_device *dev;
+	struct sk_buff *skb;
+
+	dev = alloc_etherdev(0);
+	KUNIT_ASSERT_NOT_NULL(test, dev);
+	dev->netdev_ops = &dummy_netdev_ops;
+	dev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO6;
+	dev->features = dev->hw_features;
+	dev->vlan_features = dev->hw_features;
+
+	skb = gso_tcp6_skb_new(payload_len);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+	skb->dev = dev;
+
+	/* The skb fits the IPv6 limit but not the IPv4 one. */
+	dev->gso_max_size = GSO_MAX_SIZE;
+	dev->gso_ipv4_max_size = GSO_LEGACY_MAX_SIZE;
+	features = netif_skb_features(skb);
+	KUNIT_EXPECT_TRUE(test, features & NETIF_F_GSO_MASK);
+
+	/* ...and the other way around. */
+	dev->gso_max_size = GSO_LEGACY_MAX_SIZE;
+	dev->gso_ipv4_max_size = GSO_MAX_SIZE;
+	features = netif_skb_features(skb);
+	KUNIT_EXPECT_FALSE(test, features & NETIF_F_GSO_MASK);
+
+	/* Pushing the tag inside must not change either answer. */
+	skb = vlan_insert_tag_set_proto(skb, htons(ETH_P_8021Q), 0);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+	KUNIT_ASSERT_TRUE(test, skb->protocol == htons(ETH_P_8021Q));
+
+	dev->gso_max_size = GSO_MAX_SIZE;
+	dev->gso_ipv4_max_size = GSO_LEGACY_MAX_SIZE;
+	features = netif_skb_features(skb);
+	KUNIT_EXPECT_TRUE(test, features & NETIF_F_GSO_MASK);
+
+	dev->gso_max_size = GSO_LEGACY_MAX_SIZE;
+	dev->gso_ipv4_max_size = GSO_MAX_SIZE;
+	features = netif_skb_features(skb);
+	KUNIT_EXPECT_FALSE(test, features & NETIF_F_GSO_MASK);
+
+	consume_skb(skb);
+	free_netdev(dev);
+}
+
 /* IP tunnel flags */
 
 #include <net/ip_tunnels.h>
@@ -372,6 +613,8 @@ static void ip_tunnel_flags_test_run(struct kunit *test)
 
 static struct kunit_case net_test_cases[] = {
 	KUNIT_CASE_PARAM(gso_test_func, gso_test_gen_params),
+	KUNIT_CASE(gso_test_tcp_bounded_segment),
+	KUNIT_CASE(gso_test_tcp_limit_l3_proto),
 	KUNIT_CASE_PARAM(ip_tunnel_flags_test_run,
 			 ip_tunnel_flags_test_gen_params),
 	{ },
-- 
2.47.3

