Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCE436BC9
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627188; cv=none; b=KQdZpP7N0V+nHSVdsSnqlY3AHC5PoYiWEAq5c+L+pcHtrIsfDlbeZPy86XJdGHyLm0Ep7+GsHrkfztGQMKYKtZ1q6WudTJVpXsdWRPeMEv+bNPwHcVeJVscwfStJJq18sEzXXqjcXO5MKPAW1VDqQ1nBYyviLBcZCmxaPapTcFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627188; c=relaxed/simple;
	bh=Iswn09eRp7twT5abEcH3wUMIQJ71tRI22vNNxkgvmsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa2LaSA6kV3wtVfsjcalCQcbDP6LZ9rNr0hVg2rnSL3VQVQN0/Zl1yRZjHOt2BZOAbA9D663U+JCnewomLUYf0XQBx2qcaivuhEA8qHOrTsvBik96mFpfBeX7fKZuFFUszniXRz7JUd9S8qp7qwQL/dpl2eL16e5ipjZeMR9bhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=uFO8fb1R; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="uFO8fb1R"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc02279so399167a91.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789627186; x=1790231986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UKpEOVICiwAWGcHfJwa+bgsPceu3uXkg++SCve4IU4w=;
        b=uFO8fb1RcvnKhWSy3Iq6rYxx5/Ys4aCyARe2174nrbHA6Y2K6Qw9l2i/FuCb66ysMD
         a79HWEfRyOPlfpGWjJEE1sQvhGLnyFeDvour/EVcz5gERov+Fv5td747wOKdn2OBMTh3
         OXTK4Pjsdb4Jc9c7jU/5Xt9+Gu8s3xjA6zy5oDroyrlZ3RNyINUVRGKWuF+YOKd8Odmh
         6C9ZLxelxxAzTuTN5PxwD3dZU94rTLxRZ8Jrf6PayTC5+f1WZYEylE+3KPwo7IqHjNem
         NyDiB00OsOwJUnYx6tZtXDwMW0nufb0XTWrVc76MBzTrbBfvwm1kOwyxsYB81n+WziiK
         oDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627186; x=1790231986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UKpEOVICiwAWGcHfJwa+bgsPceu3uXkg++SCve4IU4w=;
        b=F9eKBhiX2L2/28yzamF80Ic6zTD6Xmz6oB62TdLA/nEAp9oxM5kb9iFiHFlanjP42b
         uyzqiChJ+NC1XIKJqOFvTwRPH2MHOzBi4VeveYYODMk7whYYTnu0AMRdbD6ozhM9IPts
         cP6EXtbGPSORRRuqQkmxu6H4cVVnA4oypIt4c1OoKli1xFwrINUnm5b7l13B+L2w5syV
         Kh/Ewz5JK0II6AwI1yRnGAW+4XQkEAw8NzX6PHk2vs6VrSJegjF3lXuSVt8/UOfZ81Z+
         fhfKF3bFCKR1uXJcA4xDfE1S2l3wt/HXhTP6ffcLIvwJL6RN+eB7c/hBxHvL33xDPo4B
         gFxQ==
X-Gm-Message-State: AFuF++mO/7rb5TyWLHs6Z7jg0OPt0ieZJXNdC/6sug9bcTaxicIqFrJb
	anWXDB0gtiaYvNilDvd5L3P6AZP5LnWgT/OqFE3c/RmUSPWqRRxwZe8LgfUSKpSDlKM8auttgBM
	Ajwy68yuHQqQ6j4FD7eY2V66mGI/7vW+z+LN1VArY9ciChVw0eqOTIWwbK+ZG8xX+pz6omWFjQL
	WbNA==
X-Gm-Gg: AYBFou3w9H09U1exl2utTEw4hZZbpZ8M6V7aLSxegTm9caUOSFHaUfcgSkn7t1Y3+4N
	yua9tJUG0dvJUFaAfFdpkW5EdY9K/df7gh+6SOUNxvxtfHxRkslYZ9XHpMpdhMDmF1F7yvfDWp/
	NIjGeJO9wQGDFmG09BE33vhbAzyaTC30L2IS06Xt3hl8qTyv5TTHjJq+puaNoj9qign1qb97ESu
	8nBRX94vIKn/TLWpXkudpMPX5Zzj0ac7gpy2kfU1cwb9RJcl1vGz+ASupsRnyXKaail8Nw1kIRi
	/LX3jMr13i7gtIRTqkaUQhYQjBtPBw9Q6NP5K/Mtxmzd9xSZiaz4p5rNVpjY/SshBUDeCsai5Yo
	Aartanj/jONr5pPgOn2/GqBuS4cCDIpDgsSvqGVS3yb5fAGdSoWXvBdUdB1+qR6USc7AGgyhG90
	/mkCYLLSWihrIH+pKQcGGNSoquJTUwQwpx3DlKuVphxn/6NcsRDFARWkgZeJiopyFneGCf7r+Zt
	qzdnpKJzSxR
X-Received: by 2002:a17:90b:39af:b0:39d:f247:bb3 with SMTP id 98e67ed59e1d1-39e1e4b0168mr12136416a91.21.1789627185198;
        Wed, 16 Sep 2026 23:39:45 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d76834sm10904606c88.14.2026.09.16.23.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:39:44 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next 4/4] net: net_test: add tests for bounded GSO segmentation
Date: Thu, 17 Sep 2026 14:38:54 +0800
Message-ID: <20260917063854.2011613-5-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917063854.2011613-1-wang.zhan@smartx.com>
References: <20260917063854.2011613-1-wang.zhan@smartx.com>
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
 net/core/net_test.c | 231 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 9c3a590865d26..8cf478bfbda1b 100644
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
@@ -135,6 +147,44 @@ static struct gso_test_case cases[] = {
 		.nr_segs = 4,
 		.segs = (const unsigned int[]) { 100, 200, 300, 400 },
 	},
+	{
+		.id = GSO_TEST_BOUNDED,
+		.name = "bounded",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frags = 3,
+		.frags = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 3 },
+		.max_segs = 2,
+		.nr_segs = 2,
+		.segs = (const unsigned int[]) { 2 * GSO_TEST_SIZE, GSO_TEST_SIZE + 3 },
+		.segs_are_gso = true,
+	},
+	{
+		.id = GSO_TEST_BOUNDED_MULTI,
+		.name = "bounded_multi",
+		.linear_len = 2 * GSO_TEST_SIZE,
+		.nr_frags = 4,
+		.frags = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3 },
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
+		.frags = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 3 },
+		.max_segs = 1,
+		.nr_segs = 4,
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3 },
+	},
 };
 
 static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
@@ -226,6 +276,7 @@ static void gso_test_func(struct kunit *test)
 	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
 		features &= ~NETIF_F_SG;
 
+	SKB_GSO_CB(skb)->max_segs = tcase->max_segs;
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
 		KUNIT_FAIL(test, "segs error %pe", segs);
@@ -247,6 +298,15 @@ static void gso_test_func(struct kunit *test)
 
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
@@ -261,6 +321,175 @@ static void gso_test_func(struct kunit *test)
 	consume_skb(skb);
 }
 
+#define GSO_TCP_HDR_LEN (ETH_HLEN + sizeof(struct iphdr) + sizeof(struct tcphdr))
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
+#define GSO_TCP6_HDR_LEN (ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
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
+	KUNIT_ASSERT_EQ(test, skb->protocol, htons(ETH_P_8021Q));
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
@@ -372,6 +601,8 @@ static void ip_tunnel_flags_test_run(struct kunit *test)
 
 static struct kunit_case net_test_cases[] = {
 	KUNIT_CASE_PARAM(gso_test_func, gso_test_gen_params),
+	KUNIT_CASE(gso_test_tcp_bounded_segment),
+	KUNIT_CASE(gso_test_tcp_limit_l3_proto),
 	KUNIT_CASE_PARAM(ip_tunnel_flags_test_run,
 			 ip_tunnel_flags_test_gen_params),
 	{ },
-- 
2.47.3

