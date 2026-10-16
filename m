Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6343E4B0
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142164; cv=none; b=Zlph/Ph6gPFpK4wqaxS1bEu/apd2T+tdIOVmsQNakFCIktJzyBymIuhMVmUhxtIwTTm2c5cc5yum2v64EQIpveOicDwe21jKe7bCR7u87Ro/w9DXTo9xMC8/YUh8NQrVle0DFk6sHjUds1O7aYfk6p3oAJe0zaFcgOXTLXzAfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142164; c=relaxed/simple;
	bh=E7mpl7I6DsC5uzkfguWQD3b8PgcKno8oTjK9o+TFPMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKvwIkL6PvconVYH66nK/mVFnBbiKg4Lz37JmhOb1PD+0MUroswj4Zs3lL8UcVY2OvK/up83UbwE5qa9PU1YN/J1SyS7ikj9jXCY47ZzVR90B6Qzzp8oTtwBojKD/Fte/qG2FhBpj4s437G0ByDTeFIMGkXgnDtrEtV+7k6RA+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THlqrEoB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THlqrEoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE37D1F000C4;
	Fri, 16 Oct 2026 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142161;
	bh=o3ggBl62aSnr9Win5mFK5uRuud6rGb/7McQZk51Xkl8=;
	h=From:To:Cc:Subject:Date;
	b=THlqrEoBfQp0t3mRElX2xqmn+ZaK86XxOKOMbijf/ORZXS82fPFSjtKLQJ3kpyJFs
	 AVfy3fTHNBx4eJa+DUF+JnOLu/dG04AUAdyt1diMXeBWwwZOU1QvsP7oPoumwRDTTe
	 i0/fT6uQ8hrOswfxQOgVyXghZ6ZgT8YuCOBuuh5N+yT8HcqhLWEbfONz9tjzwb0fb2
	 lB5sQWF+AmlCZmpDXUdftw6wjg4Wn/gSS/A+/pREIDRJQ74jBEPk29uq/30qHHIcHO
	 lEYc8xF2hV2gnsBHKZ0Xki0hncLWctqTRb4QNqZ2E6Vangx4OD/s6zlLwWAy5JtkEv
	 vqJhSwrMSTz3g==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Qiliang Yuan <odys.yuan@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] ipv6: account route exceptions to the netns of their dst
Date: Fri, 16 Oct 2026 11:15:56 +0200
Message-ID: <20261016091556.2750902-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt6_insert_exception() and rt6_remove_exception() update
rt6_stats->fib_rt_cache of dev_net(rt6i->dst.dev), but the device of an
exception dst can move to another netns while the exception is still in
its bucket.

This happens when the bucket is flushed from an RCU callback, for
instance from nexthop_free_rcu() for the nh_info of a replaced nexthop,
whose exceptions still point to live routes. If the device moves to
another netns before that callback runs, the decrement hits the other
netns, whose u32 counter underflows in /proc/net/rt6_stats, while the
counter of the original netns never goes back down.

Account exceptions to the netns their dst was allocated in, derived from
dst->ops as ip6_dst_gc() already does, which does not depend on the
device. The dst already relies on that netns' ip6_dst_ops being alive
when it is destroyed, which happens after the exception is removed.

Fixes: 81eb8447daae ("ipv6: take care of rt6_stats")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Discovered while reviewing https://lore.kernel.org/netdev/20261016-bug-net-netns-move-rcu-barrier-v1-1-4157d798658f@gmail.com/T/#m7f6763afc4dc72233969ae22567af09cfdb3923a

 net/ipv6/route.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 34ab7f330540c89291773e4fdc8dd1f348c9de8e..6d39fdd14d1b7dc5bd50a4fc8db0466b51db6bea 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1511,6 +1511,15 @@ static struct rt6_info *rt6_make_pcpu_route(struct net *net,
  */
 static DEFINE_SPINLOCK(rt6_exception_lock);
 
+/* Exceptions are accounted to the netns their dst was allocated in.
+ * Unlike dev_net(dst->dev), it does not change when the device moves to
+ * another netns or when dst_dev_put() points the dst to blackhole_netdev.
+ */
+static struct net *rt6_exception_net(const struct rt6_info *rt)
+{
+	return container_of(rt->dst.ops, struct net, ipv6.ip6_dst_ops);
+}
+
 /* Remove rt6_ex from hash table and free the memory
  * Caller must hold rt6_exception_lock
  */
@@ -1522,7 +1531,7 @@ static void rt6_remove_exception(struct rt6_exception_bucket *bucket,
 	if (!bucket || !rt6_ex)
 		return;
 
-	net = dev_net(rt6_ex->rt6i->dst.dev);
+	net = rt6_exception_net(rt6_ex->rt6i);
 	net->ipv6.rt6_stats->fib_rt_cache--;
 
 	/* purge completely the exception to allow releasing the held resources:
@@ -1750,7 +1759,7 @@ static int rt6_insert_exception(struct rt6_info *nrt,
 	rt6_ex->stamp = jiffies;
 	hlist_add_head_rcu(&rt6_ex->hlist, &bucket->chain);
 	bucket->depth++;
-	net->ipv6.rt6_stats->fib_rt_cache++;
+	rt6_exception_net(nrt)->ipv6.rt6_stats->fib_rt_cache++;
 
 	/* Randomize max depth to avoid some side channels attacks. */
 	max_depth = FIB6_MAX_DEPTH + get_random_u32_below(FIB6_MAX_DEPTH);
-- 
2.53.0

