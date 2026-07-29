Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39DB3D566F
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366094; cv=none; b=DcE7RHPoEWiE+u6HCqMcXe8SLFoTmwdqKkQZ29vlZlT4MB6pT1CG2NjIkg0iNcQ3ghBK6dLEyyrEtOIxk2GGiS5B2IgbvtCQSXjXY5gVVE3Zr/Stu+XHhNHJ8LydlzT/qOBK1acNv9a7wnkT3oq+fMODHZZcaUVVHbtY6SVW4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366094; c=relaxed/simple;
	bh=3tNPz/BsLCQF78BKqAt0cQ8ZmvH5Y553Akg7cS1y2jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kffrGRvRS/32dFRkMqegPMqYcISCdpxizbwmjT/qWXg2e+IHZCR13SL2OjSmTqhcDH3qy10IGDXaxrIx8dBNnSPjbfdxTAdMVPOF9Ao3kzSl+Yk5ZFFkm/mbatHKFf4dRcOt9D1KmRUgRe6SqzCHbImLwqg1CZ+Goa5TEToSYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=aUGmKD0c; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="aUGmKD0c"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso911723a12.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785366092; x=1785970892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjF0r6TlqwMFAJCr0zMgeq2zR8VFIGVvm8lDzRkRjpU=;
        b=aUGmKD0cBMK83R+Ms6AN3wBHPYxrZyjizz5Xyzlolpo4XC6gHbxDish8kMdD/h/U+G
         IPdbVA8fyCTHiPza66m/7CVBVpxv6PZEkDaswDl/4RwAakaCBYIQsLaO9uzdDt0JwgA6
         NJWpCbtajlKawZ14pVPqcuRb8QIK4B0UHFEfe/dm38RDF1BKZ+T4vZPv9nvZ5kF2YPhi
         3sDHQ8/YYUWGzzWiklkr7p4rK273zD63iWf9SSutvzPpSiePBKgMHrVIl4NM8E0lwrcf
         4th0FkWPh6gBh0xomsXAfNIII0dU/emfcH/mybHHVAOJ9CxePrqn2EYDyde4EjeoVxH0
         DuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785366092; x=1785970892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zjF0r6TlqwMFAJCr0zMgeq2zR8VFIGVvm8lDzRkRjpU=;
        b=k4hIuDbKNov89HV2bW0++jtDckPGhvgVqsesPXJpev2cZYaL5gdaOwL+gibkqsZaZu
         rrWIitR4ptmmOVWE9IAq50T1i06OQstu4xlgpimXRn7WRAs90JFvpyefSJOAFwP/F9hy
         W67wMd1tK952ppq49+6x9EuIuDb/YFeteTKtNm0bR/vvS5VSODAy/FEi3wPUFPsLBpmB
         UenCz8jxNTt/n0nMYgzCgUiBhlXcT0MhmAT3ei8x9eXPMuhd7+6bWLyAm+Vrx5XpeEIe
         /al2fO08uxJ7jKaBEohek9NgusosQKKMsT8jQrFGKS84Mmrmem9lqIy7aiNCz8/wukGv
         +qBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9pYjxb7I+KOl9TSV6A3UpgVV9Rih+IXRjcfKi1zEnCcErFxDiwbTT6bHChZw9uP4mvmjh89s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWyoJGHJ88Bql6DRABeU6xhIu+mL0HiPMj1hkCTe2MqGxHlFn
	yVkxuC0oHPtbqxopI3sKQrz3mTWC281Z1K9eSP71fcwQRAyXwTrL/o9XYPxID9t+HQ==
X-Gm-Gg: AR+sD12yg28UjpTamMY6uNk3xYdUrAzKAyfiYvAMM4sCBLEF/i3t+jzgqeLJnH0ERUr
	GRJenViKVAcCr5q7mUQKpaUfBeYHXfAxGj2agwHKF3T9O2KJV9lf57iG0UgOYHDyjIy04ks03LL
	vAK/s1c7FjviNEStkB020MwJJFoZ+edcgwGksfGVLryfn+M35B5N83e2FNaccL6b0Pnto2LLaM3
	nez/54vO1z9lqKM+rjmAxoY2iWIzWMyzhLVlxPkur7gI8NQd3w8byR2Rf27h6/iQqD7NoP1jp8S
	zwnfcsuSCsiDb52WTZ5eOLUgWzAh2lSMcnAsZmU0wVzWn6Q0TkdJsEGs8YfppkXJB0vqmd8qe/1
	Wcn0irbfOYN0Mx2VGz/7YWeECUHPK+JQOvzTvs+mWONgdSQcI4hpQhYGE5+tv3LMbpSzy2ZyVek
	vE70YPO8DjBkCHh+OhAgWwrC1cKhkisAWSqPCk4DFIA0KLiviX+xUkh7Sz0rtFpjyoJL+1Rl9Rq
	Dn0
X-Received: by 2002:a05:6a21:9185:b0:3c3:928a:b0c1 with SMTP id adf61e73a8af0-3c9007b5059mr34101637.74.1785366091907;
        Wed, 29 Jul 2026 16:01:31 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d373c3sm13777272eec.23.2026.07.29.16.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 16:01:30 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [RFC net-next v2 1/3] ipv6: ndisc: export the route attach as ndisc_attach_dst()
Date: Wed, 29 Jul 2026 23:01:17 +0000
Message-ID: <20260729230119.2717507-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729230119.2717507-1-xmei5@asu.edu>
References: <20260729230119.2717507-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ndisc_send_skb() pushes the IPv6 header and transmits in one go, so a
caller that has to build the link-layer header and transmit the skb
itself cannot use it.  bonding needs that split to insert VLAN tags
into its NS monitor probes.

Such a caller still has to attach a route before handing the packet to
netfilter: ip6t_mangle_out() calls ip6_route_me_harder() whenever a
rule changes the addresses, mark, hop limit or flow label, and that
dereferences skb_dst(skb) unconditionally.  Neither icmp6_dst_alloc()
nor icmpv6_flow_init() is exported, so a module cannot attach one
itself.

Move the route attach into ndisc_attach_dst() and export it.  It is a
no-op when the skb already carries a route, so ndisc_send_skb() is
unchanged for existing callers.

Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
v2: v1 fixed the crash, ignoring the data corruption.
    v2 tries to fix both.

 include/net/ndisc.h |  3 +++
 net/ipv6/ndisc.c    | 53 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 3da1a6f8d3f9..f3e3c3e5c61e 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -411,6 +411,9 @@ void ndisc_send_ns(struct net_device *dev, const struct in6_addr *solicit,
 		   const struct in6_addr *daddr, const struct in6_addr *saddr,
 		   u64 nonce);
 
+int ndisc_attach_dst(struct sk_buff *skb, const struct in6_addr *daddr,
+		     const struct in6_addr *saddr);
+
 void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 		    const struct in6_addr *saddr);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index fe36b3f51285..91ffbfec9e5d 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -465,13 +465,44 @@ static void ip6_nd_hdr(struct sk_buff *skb,
 	hdr->daddr = *daddr;
 }
 
+/* Attach a route to a locally generated ndisc message; @skb is not consumed
+ * on failure.  Split out of ndisc_send_skb() for callers that build the
+ * link-layer header themselves.
+ */
+int ndisc_attach_dst(struct sk_buff *skb, const struct in6_addr *daddr,
+		     const struct in6_addr *saddr)
+{
+	u8 type = icmp6_hdr(skb)->icmp6_type;
+	struct dst_entry *dst;
+	struct flowi6 fl6;
+	struct sock *sk;
+	struct net *net;
+
+	if (skb_dst(skb))
+		return 0;
+
+	rcu_read_lock();
+	net = dev_net_rcu(skb->dev);
+	sk = net->ipv6.ndisc_sk;
+	icmpv6_flow_init(sk, &fl6, type, saddr, daddr, skb->dev->ifindex);
+	dst = icmp6_dst_alloc(skb->dev, &fl6);
+	rcu_read_unlock();
+
+	if (IS_ERR(dst))
+		return PTR_ERR(dst);
+
+	skb_dst_set(skb, dst);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ndisc_attach_dst);
+
 void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 		    const struct in6_addr *saddr)
 {
 	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
-	struct dst_entry *dst = skb_dst(skb);
 	struct net_device *dev;
 	struct inet6_dev *idev;
+	struct dst_entry *dst;
 	struct net *net;
 	struct sock *sk;
 	int err;
@@ -479,24 +510,16 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	type = icmp6h->icmp6_type;
 
+	if (ndisc_attach_dst(skb, daddr, saddr)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	rcu_read_lock();
 
 	net = dev_net_rcu(skb->dev);
 	sk = net->ipv6.ndisc_sk;
-	if (!dst) {
-		struct flowi6 fl6;
-		int oif = skb->dev->ifindex;
-
-		icmpv6_flow_init(sk, &fl6, type, saddr, daddr, oif);
-		dst = icmp6_dst_alloc(skb->dev, &fl6);
-		if (IS_ERR(dst)) {
-			rcu_read_unlock();
-			kfree_skb(skb);
-			return;
-		}
-
-		skb_dst_set(skb, dst);
-	}
+	dst = skb_dst(skb);
 
 	icmp6h->icmp6_cksum = csum_ipv6_magic(saddr, daddr, skb->len,
 					      IPPROTO_ICMPV6,
-- 
2.43.0

