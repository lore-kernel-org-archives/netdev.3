Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=199.67.87.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816502;
	b=QnwQezsv/omss0lj8LM81qRI7waVwYAEU5zPCEj13NOwvN5tSSvkviBPq4Y+dV6kMRXo
	 qo9JoqjPud8oiPobHrKh1mMk5MXEbKLBxXItM/OCTrnlY5/sts84rm0NV3LqA+Aqo4C/K
	 C0Dk+CNA933IP5tgUf4TInbiC+xLlobO/QE8z5Q2LrZqHFLGqMno5RjYASJm1TS7TVayy
	 4GwUt+zmq6IWZCkosFCWLbtQ2pp9ekCfLK528ZBqE7aRBM4p9gKF/Kbv4wx1F+fpy6MkK
	 KUPuU4YpYJl/MBQfaPw//gds/P+rZ1aA5cJkwhVzD4sdA0aibh0U5V7U7ir0z0zpLVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816502;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=u2s9WdNLrHGY48DAX6a2FVuI8rhMLrzkalNfdtncyi0=;
	b=eAakC8SLdUux47BYLCNGMgl9olrgU1L6kYU+abclz+ejYrZfO/Xl5hJ9z8bq/wsNkR56
	 DWzc1ssrwP16O+3hnrPwvfMyRdYloiBluxbuLerxcxRogVgYPZi0zDoqsamVc+xMj6Wgk
	 Kbxu3cYeIiukETPPLNUyeQMxJtbgQma0KZqqzrK+LSR9SjFeiHGm62JqEg+j/ti3eAoCW
	 E3eTIRvER2uU1osMZFoFRGcgQJkRPgnYGvn8Z4cAx28rLB2/gePxr3FkOM6w4MgMFVK7J
	 LgX0wFBwGYerfRlbc3U1rH+dLdw1MdQ5uO4np/S2kVSzXqNp2dHgRwDmoLhf7UI1gSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=chasehil.tz;
	spf=pass smtp.mailfrom=chasehil.tz;
	dkim=pass header.d=chasehil.tz header.i=@chasehil.tz header.a=rsa-sha256 header.s=zmail header.b=h99wbuKW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=199.67.87.7
Received: from sender-op-o7.zohocloud.ca (sender-op-o7.zohocloud.ca [199.67.87.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC61606D837;
	Wed,  4 Nov 2026 18:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEC61606D837
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chasehil.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chasehil.tz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chasehil.tz header.i=@chasehil.tz header.a=rsa-sha256 header.s=zmail header.b=h99wbuKW
ARC-Seal: i=1; a=rsa-sha256; t=1793816464; cv=none; 
	d=zohomailcloud.ca; s=zohoarc; 
	b=QbFKNmdn8bUhioMjn6OK65PM/Z4DiUfBEbr9zHsGUcBeStb3zyPs907jPoCUWi30dwpaQHx7SI8ONtkObv5+2+0tz6Kxm8v/3Aolh9bIg6JY8IrGiYSY8nPGYJw5n/BZQJw5q9V/avHNrzSmqt9ynPxXvcnJHQeRUDdXSmPKmdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomailcloud.ca; s=zohoarc; 
	t=1793816464; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u2s9WdNLrHGY48DAX6a2FVuI8rhMLrzkalNfdtncyi0=; 
	b=HfBuwLD2g2sf6ASpxJexeDoWuEueMDyx8uEOjeifPcGYwwxzeVWiKWsEcyE6JDbp8mPGvq/vhkNU/6yyAKJIyG0He+46yXDXmeDLM4SGhuIijK0xY/wAZ+ESDSoJPVlGQ9dSjRoL2ZKoeeoCls1irtB+/r7FZ3VuKU8qDAeK4gc=
ARC-Authentication-Results: i=1; mx.zohomailcloud.ca;
	dkim=pass  header.i=chasehil.tz;
	spf=pass  smtp.mailfrom=me@chasehil.tz;
	dmarc=pass header.from=<me@chasehil.tz>
DKIM-Signature: a=rsa-sha256; b=h99wbuKWGgIqPTmSDvjy18WZl85812z0aRVztLCHVmFDosJgjN4n11OTRqSxY4IIdySYkpvZqqxqkXK0TnTv9nP0jxU0uK/pbsE0tVSg6fnOuwsPgGQjgtrvXiznbG6/K95SUruvKdZaIm91g7rdzDJOzlEiUnMdWGLDm8mpplg=; c=relaxed/relaxed; s=zmail; d=chasehil.tz; v=1; bh=u2s9WdNLrHGY48DAX6a2FVuI8rhMLrzkalNfdtncyi0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohocloud.ca with SMTPS id 1793816462556489.1415147616399;
	Wed, 4 Nov 2026 13:21:02 -0500 (EST)
From: Chase Hiltz <me@chasehil.tz>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	weiwan@google.com,
	linux-kernel@vger.kernel.org,
	Chase Hiltz <me@chasehil.tz>
Subject: [PATCH net] ipv4: route: don't blackhole in-use routes when retiring fnhe routes
Date: Wed,  4 Nov 2026 14:20:58 -0400
Message-ID: <20261104182058.2673882-1-me@chasehil.tz>
X-Mailer: git-send-email 2.56.0
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
X-ZohoMailClient: External

When a route cached in a nexthop exception (fnhe) is replaced or
flushed, rt_bind_exception() and fnhe_flush_routes() call
dst_dev_put() on it. That sets dst->dev to blackhole_netdev and
dst->input/output to dst_discard*(), but other CPUs can still be
using the route, e.g. as a noref dst taken from the fnhe under RCU.
Packets that reach dst_input() or dst_output() after that are dropped.

If dst_dev_put() runs after a forwarded packet has entered ip_output(),
ip_skb_dst_mtu() in __ip_finish_output() can return the MTU of
blackhole_netdev (68), and ip_fragment() can then drop a DF packet and
send ICMP_FRAG_NEEDED with mtu 68 to its source.

This was hit on a 6.12 router that sent ICMP_FRAG_NEEDED with mtu 68
for packets it forwarded. A kprobe on __icmp_send() showed that the
skb's dst had dev == blackhole_netdev and still had the PMTU from its
fnhe.

Commit 5018c59607a5 ("ipv4: fix race condition between route lookup and
invalidation") fixed the same race in rt_cache_route() by putting the
old route on the uncached list instead of calling dst_dev_put(). Do the
same for routes retired from an fnhe. rt_flush_dev() still moves them
to blackhole_netdev when their device is unregistered.

fnhe routes are also retired on fnhe expiry (ip_del_fnhe()) and
eviction (fnhe_remove_oldest()). Those paths don't bump rt_genid, so
without the obsolete marking ipv4_dst_check() could still accept the
route. Keep marking retired routes DST_OBSOLETE_DEAD, as dst_dev_put()
did, so that users that cached them, such as sockets, look up again.

Tested on v7.4-rc1 with network namespaces: a router forwards IPv4 TCP
(iperf3 -P 8) over an ip6tnl device whose PMTU update creates an fnhe
for the destination, while a loop adds and deletes an IPv4 route. The
sender drops incoming ICMP_FRAG_NEEDED, so it keeps setting DF.

Over 60s without this patch, the sender received 505,291
ICMP_FRAG_NEEDED with mtu 68, and the router dropped 67,024 packets in
dst_discard_out() and 599 in dst_discard(). With this patch there were
none. Neither kernel sent any without the route churn, or without an
fnhe (ip6tnl with encaplimit none).

When the sender accepted the ICMPs, its route to the destination ended
up with "mtu lock 552" without this patch. With it, the route had no
PMTU.

Deleting the tunnel, its underlay or the peer netns under the same load
(12 runs) completed without unregister hangs or warnings, with and
without this patch.

The same tests on a kernel with PROVE_LOCKING, KASAN, DEBUG_LIST,
DEBUG_ATOMIC_SLEEP and the netdev/netns refcount trackers produced no
reports. Lockdep recorded the new fnhe_lock -> uncached list lock
dependency, and in a separate 20s run 109,305 routes were retired
from an fnhe through the new path.

Fixes: 95c47f9cf5e0 ("ipv4: call dst_dev_put() properly")
Signed-off-by: Chase Hiltz <me@chasehil.tz>
Co-authored-by: Claude Opus 5.5 <noreply@anthropic.com>
---
 net/ipv4/route.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3a90c8d..cd69242 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -573,6 +573,17 @@ static void ip_rt_build_flow_key(struct flowi4 *fl4, const struct sock *sk,
 
 static DEFINE_SPINLOCK(fnhe_lock);
 
+/* Other CPUs may still be using @rt, so don't dst_dev_put() it.
+ * rt_flush_dev() handles it if its device is unregistered.
+ * Marking it dead makes ipv4_dst_check() fail for users that cached it.
+ */
+static void fnhe_retire_route(struct rtable *rt)
+{
+	WRITE_ONCE(rt->dst.obsolete, DST_OBSOLETE_DEAD);
+	rt_add_uncached_list(rt);
+	dst_release(&rt->dst);
+}
+
 static void fnhe_flush_routes(struct fib_nh_exception *fnhe)
 {
 	struct rtable *rt;
@@ -580,14 +591,12 @@ static void fnhe_flush_routes(struct fib_nh_exception *fnhe)
 	rt = rcu_dereference(fnhe->fnhe_rth_input);
 	if (rt) {
 		RCU_INIT_POINTER(fnhe->fnhe_rth_input, NULL);
-		dst_dev_put(&rt->dst);
-		dst_release(&rt->dst);
+		fnhe_retire_route(rt);
 	}
 	rt = rcu_dereference(fnhe->fnhe_rth_output);
 	if (rt) {
 		RCU_INIT_POINTER(fnhe->fnhe_rth_output, NULL);
-		dst_dev_put(&rt->dst);
-		dst_release(&rt->dst);
+		fnhe_retire_route(rt);
 	}
 }
 
@@ -1505,10 +1514,8 @@ static bool rt_bind_exception(struct rtable *rt, struct fib_nh_exception *fnhe,
 		if (do_cache) {
 			dst_hold(&rt->dst);
 			rcu_assign_pointer(*porig, rt);
-			if (orig) {
-				dst_dev_put(&orig->dst);
-				dst_release(&orig->dst);
-			}
+			if (orig)
+				fnhe_retire_route(orig);
 			ret = true;
 		}
 
-- 
2.56.0

