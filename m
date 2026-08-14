Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0E35E1AE
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689370; cv=none; b=SrLO3pV55LfCqWFCJ+nT02o8v7kGCCvLt5cAW7WEX2sbxETWYUrjmHt+1myrYcCzMc5PFidiQMrPEUl0wL1bbVdzmnJfICuz5bPAm/HWSa7YezZ87xT9uxLcqHANxp9Q0Jcuxne+8Hj0/HIoPYIKhgifZbeu+QLPPPdk5JAnknE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689370; c=relaxed/simple;
	bh=YWfBLkfminW2fEFyfEKhAu+hPo/HrLPBOYLF83LLvHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PM6epjdKWpMi9rOO+VB6TJmen9fJTnrXI7Ird4SJL8UhVWnCpxYXWAdKBF8Bsu04a0ocVjD94TsS1gh0M4ldvidw4LH5gzPWzVL2xL11yNXDmFTxBVDsJml2LFFTjNwdRI2iAN9YOflSPwF+7SiyRWvwpk8fGuEK9uHGh2QSG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AaEdyIwm; arc=none smtp.client-ip=91.218.175.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AaEdyIwm"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YWfBLkfminW2fEFyfEKhAu+hPo/HrLPBOYLF83LLvHA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786689366; v=1; x=1787294166;
 b=AaEdyIwmdd6AN0f5QKpaq8LkbvrnU7Y0IFg5QfqiBxFDsq0anoLqL0R7afQ2xJozV6vk/mVK
 XC0FQv1lYcrbkVKqQ7V3KO8ZaOB5ZF44V8UhtNxUjjQ559Vw0PIOPHoPang8Wm584VQ/JUSPJ78
 5I4R7C2p1XeDEPfg7SqN4rUY=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (147.136.157.3)
	by smtp.migadu.com with ESMTPS id d3e0458ca6c5652b;
	Fri, 14 Aug 2026 06:36:05 +0000
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: advertise TCP MSS from the configured MTU, not the learned PMTU
Date: Fri, 14 Aug 2026 14:35:43 +0800
Message-ID: <20260814063545.225896-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MSS a host puts in its SYN tells the peer how big a segment it may
send us. Right now we can shrink it with a PMTU we learned on our own
send path, which is the wrong direction entirely.

On asymmetric paths this bites - think DSR load balancers, where the
request side goes through a smaller-MTU overlay. We learn a small PMTU
going out, then advertise a small MSS, and the peer stays capped for the
whole connection even though its path back to us is wide. MSS only shows
up in the SYN and never grows back.

On symmetric paths we lose nothing by dropping it either: the peer runs
its own PMTU discovery and usually already knows the real path MTU.

So work out the advertised MSS from the configured route or device MTU
and ignore the learned PMTU. Our send side is unchanged, still clamped by
tcp_current_mss(). Add ip_dst_mtu_configured()/ip6_dst_mtu_configured()
and use them from the two default_advmss() paths.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/net/ip.h        | 25 +++++++++++++++++++++++++
 include/net/ip6_route.h | 37 +++++++++++++++++++++++++++++++++++++
 net/ipv4/route.c        |  4 ++--
 net/ipv6/route.c        |  2 +-
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 7f2fe1a8401b..a8f57b4f4aa2 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -506,6 +506,31 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 	return res;
 }
 
+/* Configured/administrative MTU of a route, for advertising the TCP MSS.
+ *
+ * Unlike ip_dst_mtu_maybe_forward(), this deliberately ignores the
+ * ICMP-learned path MTU (rt->rt_pmtu).  The advertised MSS bounds what the
+ * peer may send to us and must reflect our receive capability (the device or
+ * route-configured MTU), not a path MTU learned on the reverse (send)
+ * direction, which may not apply to the peer->us path and outlives the fnhe
+ * for the whole connection.  See RFC 2923 section 2.3 and the comment above
+ * tcp_advertise_mss().
+ */
+static inline unsigned int ip_dst_mtu_configured(const struct dst_entry *dst)
+{
+	unsigned int mtu, res;
+
+	rcu_read_lock();
+	mtu = dst_metric_raw(dst, RTAX_MTU);
+	if (!mtu)
+		mtu = READ_ONCE(dst_dev_rcu(dst)->mtu);
+	mtu = min_t(unsigned int, mtu, IP_MAX_MTU);
+	res = mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+	rcu_read_unlock();
+
+	return res;
+}
+
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
 					  const struct sk_buff *skb)
 {
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 09ffe0f13ce7..ac1acc0b7436 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -385,6 +385,43 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
 
+/* Configured/administrative MTU of a route, for advertising the TCP MSS.
+ *
+ * Unlike ip6_dst_mtu_maybe_forward(), this ignores any ICMPv6-learned path
+ * MTU (which is kept on the RTF_CACHE exception route) and returns the MTU of
+ * the underlying route (fib6_pmtu) or the egress device.  The advertised MSS
+ * bounds what the peer may send to us and must reflect our receive
+ * capability, not a path MTU learned on the reverse (send) direction.  See
+ * RFC 2923 section 2.3 and the comment above tcp_advertise_mss().
+ */
+static inline unsigned int ip6_dst_mtu_configured(const struct dst_entry *dst)
+{
+	const struct rt6_info *rt = dst_rt6_info(dst);
+	const struct fib6_info *from;
+	struct inet6_dev *idev;
+	unsigned int mtu = 0;
+
+	rcu_read_lock();
+	/* IPv6 keeps the learned PMTU and the configured MTU in the same
+	 * RTAX_MTU slot: the learned value sits on this (possibly RTF_CACHE)
+	 * dst, the configured one on the underlying route.  Reach the latter
+	 * via ->from (fib6_pmtu), populated by ip6_route_info_create().
+	 */
+	from = rcu_dereference(rt->from);
+	if (from)
+		mtu = from->fib6_pmtu;
+	if (!mtu) {
+		mtu = IPV6_MIN_MTU;
+		idev = __in6_dev_get(dst_dev_rcu(dst));
+		if (idev)
+			mtu = max_t(unsigned int, mtu, READ_ONCE(idev->cnf.mtu6));
+	}
+	rcu_read_unlock();
+
+	mtu = min_t(unsigned int, mtu, IP6_MAX_MTU);
+	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+}
+
 u32 ip6_mtu_from_fib6(const struct fib6_result *res,
 		      const struct in6_addr *daddr,
 		      const struct in6_addr *saddr);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fd688e1f879f..46aa98c92183 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1334,8 +1334,8 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 
 	rcu_read_lock();
 	net = dst_dev_net_rcu(dst);
-	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
-				   net->ipv4.ip_rt_min_advmss);
+	advmss = max_t(unsigned int, ip_dst_mtu_configured(dst) - header_size,
+		       net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 5968ce5ad150..e2056bd0df3c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3261,7 +3261,7 @@ void ip6_sk_redirect(struct sk_buff *skb, struct sock *sk)
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	unsigned int mtu = dst6_mtu(dst);
+	unsigned int mtu = ip6_dst_mtu_configured(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
-- 
2.43.0

