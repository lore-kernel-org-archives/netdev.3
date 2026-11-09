Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212321;
	b=tIbnUQW1KnYHJGbgX4Rmr3zc1W2ypDhFqCDbuN0o1nB/av7S6q+NzroOw3VE4+gESWGL
	 Vr8yGZQ9VCHzgbU9D+CQfas5a3hwLfUggctURfiD2ah+d+YldXZFNlJA979AA9mcUYEvk
	 ipPXHVf/pH3RRO3WolbRkMa5W4Yy23xxOLlIcI7hrzMQO7bDnwjqtFhMe5An4d+RrCHz8
	 AwHnkq8lkN+Bv03PsbiVI/3hlBEob80WIjc13NJaWiwdmOTdw2sRISF9fXxjoC5VZfnOQ
	 Rh2zydfGBkX8JiDmqgl/mZwr5fQqqWe6XrhnVZ8c79iu0M/byrPgesZCXl0GH+RJBcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212321;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=x9XVD/0ohs7oMGMaz9ZkzBw5Vyvf8w/OSrxiwXVJ68Y=;
	b=gQY+PjLMoXXQhJ9xOTU8kehbKsUPmtEvsRaE3OKmqwTLErjW2XqOtO+D7mD3WLmvkXqQ
	 N34Pecm/UE8J0COuouEulLgkYjICNbRo5hDfTzklOz1fYzoa1mzYhOKg6hLirXMj4+ac9
	 1TdlcPeHoGOroS14ZBb04p6G6ejrI8QkOXCXNAYHeRRwXVQPF+xFeySevo/GQJjsZI1sE
	 dx6ZVwXAiV44H2JENxSfwqBM9z77X6SYhEWqmiFUep4NYbdzn2gChAyoteNUZPl5oYsfH
	 opBtViV3FjtMk1TeMHKbZIJb7eMy2TeKTS+X9k2Y7KzrEADt3wgWIX6N1sYY6TEKIjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XpROUVdL;
	arc=none smtp.remote-ip=91.218.175.155
Received: from mta0.migadu.com (out-155.mta0.migadu.com [91.218.175.155])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4A606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51C4A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XpROUVdL
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FerX5k66pAHBzte7mokkF2Oe+4SJ4Lb5zMrSGV3QcDA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794212318; v=1; x=1794817118;
 b=XpROUVdL9JYmch1q4FyY8+U5SI72+G848AHyj5OJ/r3y+NROC9/DQjaSBm2zr2ECFsdsuubG
 Zb6owJnFXFIcsy90KVCE/ooDH/Aj/qn0J2yTaJrcL4FLBK+CoQgBXzm2eOHoe5nHjdZGfiAogCe
 /nEWdx6EEsOCksrXl8Wrffvw=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2c5c3cba312d07a0;
	Mon, 09 Nov 2026 08:18:38 +0000
X-Mizu-Trace-ID: 2c5c3cba312d07a0
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Mon, 09 Nov 2026 03:18:13 -0500
Subject: [PATCH net-next v3 2/4] ipv6: take fib6_sernum from a sequence
 shared by all netns
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-bug-net-netns-move-rcu-barrier-v3-2-6084b02610b3@linux.dev>
References: <20261109-bug-net-netns-move-rcu-barrier-v3-0-6084b02610b3@linux.dev>
In-Reply-To: <20261109-bug-net-netns-move-rcu-barrier-v3-0-6084b02610b3@linux.dev>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

A per-cpu IPv6 route of a nexthop object records fib6_sernum of the
netns it was created in, and rt6_is_valid() compares it with fib6_sernum
of the netns its device belongs to when the route is checked. Every netns
starts its fib6_sernum at 1 and increments it on each tree change, so
different netns often hold the same value.

When a device moves to another netns, such a route remains usable until
nexthop_free_rcu() releases it, and fib6_info_destroy_rcu() queues that
callback from inside an RCU callback, after the device has moved. If the
fib6_sernum of the new netns matches the cached one in that window,
ip6_dst_check() accepts the route and a socket in the old netns keeps
sending through a device that now belongs to another netns.

Take every fib6_sernum bump from one sequence shared by all netns, which
only hands out values from 2 up: every netns still starts at 1, and 0
means there is no sernum to check. Inserting a route bumps fib6_sernum,
so the routes a netns caches carry values drawn from the sequence, which
no other netns holds until it wraps after 2^31 bumps. fib6_new_sernum()
callers only hold their own table's tb6_lock, so two tables of one netns
can store their values in either order, and fib6_sernum is no longer
monotonic per netns. It is only compared for equality, so this costs at
most an extra invalidation. A connected UDP socket in netns A caches a
route through an IPv6 nexthop object on a veth. The veth is moved to
netns B and brought up with one RTM_NEWLINK, then the socket sends
200000 datagrams. A route is added to and removed from B 0 to 20 times
before the move, 63 trials:

                                before     after
  trials sending after move          1         0
  datagrams sent after move       3429         0

Fixes: 8f34e53b60b3 ("ipv6: Use global sernum for dst validation with nexthop objects")
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_fib.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index e1d49897d6ab0..827051cbf7482 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -123,13 +123,23 @@ static void fib6_walkers_skip_rt(struct net *net, struct fib6_info *rt)
 	fib6_walkers_replace_leaf(net, rt, next);
 }
 
+/*
+ * Draw fib6_sernum bumps from one sequence shared by all netns, so that a
+ * route cached against one netns does not match the sernum of another one,
+ * e.g. after its device moved, until the sequence wraps. Every netns starts
+ * at 1 and the sequence only hands out values from 2 up: 0 means no sernum
+ * to check.
+ */
+static atomic_t fib6_sernum_seq = ATOMIC_INIT(1);
+
 static int fib6_new_sernum(struct net *net)
 {
-	int new, old = atomic_read(&net->ipv6.fib6_sernum);
+	int new, old = atomic_read(&fib6_sernum_seq);
 
 	do {
-		new = old < INT_MAX ? old + 1 : 1;
-	} while (!atomic_try_cmpxchg(&net->ipv6.fib6_sernum, &old, new));
+		new = old < INT_MAX ? old + 1 : 2;
+	} while (!atomic_try_cmpxchg(&fib6_sernum_seq, &old, new));
+	atomic_set(&net->ipv6.fib6_sernum, new);
 
 	return new;
 }

-- 
2.43.0

