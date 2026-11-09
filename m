Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212327;
	b=WlLYiANdxe223OwM1xcXslIfJXY/0j3Naq2rdvKg3OSa4/Z41c4zJgqAjWeBMCE3/7jC
	 UFCrNxDDIsEbZG48JWitF8jgM3EXTtqR1LDo7iprLku+HGNz0/66+fGGXhKYGKrPv7tZ+
	 Id3O/MQAvEH11q3ngTklO/6TMDtndIB0Pt2HUAAPRhMWnxwZPEPHoqNhNfYd5kL65cg6a
	 6RZF7F7MiWXEIE7JfcoDK56AMfi3LJHwhqb8GGuh14EXkYETZlT9dpTt9bWDA5kVF44kc
	 UEL4854LxwIdJzTjg8ZUw/+Ldjs8150dgqW9zQzLt8e3YucKhdR+hdD8ljzFWJkXW2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212327;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=LbKm7kJZnVDCUFkPTQ8FL3AQnqnNWdJ/bsGB19ACkvg=;
	b=N1JgPiATOa+NQOF35mD2IJyoDj+6dwkDr/I5VS2LnMC7KI72sIQYRVt+OKiCo21YtFcQ
	 ZGrY4dzGeZ5oYI9eLtGvf5NjWwiFaWr7O1skdA8aqSrqQ3TyaM36qQFImdgUTwsSO38oS
	 71tZWfxx+EbAti/QTvWwkai1RrbERbYzcnMoP7pkNxdyq2smS2NCm8dH3W//Ns/jQbEqI
	 0LGHekDbF9SYu+3PNBRQL/pjfMbihoZpmZN1sVjF1qt6EXZltpo08n3sKGDLIXPxgZwUV
	 ViaF5OVlqgQ+BeQOej+Vr46crqvyTH4Cm6j3LAZ2ih6BwcTAG1vqRBPwpq/M/fq+YFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vViUmp6G;
	arc=none smtp.remote-ip=91.218.175.162
Received: from mta0.migadu.com (out-162.mta0.migadu.com [91.218.175.162])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D48606D804
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D48606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vViUmp6G
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=t6DAMmrQ/ek3RuXBK/3/jv3+3PoeJVRD8BaQxUbGh9k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794212324; v=1; x=1794817124;
 b=vViUmp6GQQzxbF06SbqFCg4FN8cnyjtfbKA/qfv4tMVNFZv3Ry/itrecCckfFyD+9u8qbKkZ
 5pcvYu2PrEUgq+KlEIsC18B3JrKLefb0wOgJIZikAnNW362MDZERcRR0saj3SgILAube6Y1vW86
 xzkfsYzhxuhEAif4RPGWu16U=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cfebcddeb0e48edb;
	Mon, 09 Nov 2026 08:18:44 +0000
X-Mizu-Trace-ID: cfebcddeb0e48edb
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Mon, 09 Nov 2026 03:18:14 -0500
Subject: [PATCH net-next v3 3/4] nexthop: flush cached routes when a
 nexthop leaves a group
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261109-bug-net-netns-move-rcu-barrier-v3-3-6084b02610b3@linux.dev>
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

When a nexthop is removed while other members keep its group alive, only
the group array changes: the routes through the group stay in the FIB,
and the dsts they cached through the removed nexthop are released when
that nexthop is freed, from an RCU callback.

Until then those dsts stay valid. IPv6 route exceptions, such as the
ones created on Packet Too Big, are checked against the cookie of their
FIB node, which does not change, so a socket keeps sending through the
removed nexthop. When the nexthop goes away with its device, removing
the device's IPv6 addresses usually flushes the routing tree first, but
not when the device carries no IPv6 address.

Flush the cached routes of each affected group once all readers see its
new array, as replacing a group already does. A connected UDP socket in
netns A sends to a route through group {nh 1, nh 2}, on an IPv6
exception of nh 1 created by Packet Too Big, while nh 1 is deleted.
Datagrams still sent through nh 1 after the new group is published and
before nh 1 is freed, 10 trials, the one or two left after the change
being sent between synchronize_net() returning and the flush:

                          before      after
  datagrams per trial   395-4423        1-2

Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 net/ipv4/nexthop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 42e55b5a755ee..e0089a6450e75 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2109,6 +2109,9 @@ remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 	return false;
 }
 
+static void nh_rt_cache_flush(struct net *net, struct nexthop *nh,
+			      struct nexthop *replaced_nh);
+
 static bool __must_check
 remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 			   struct nl_info *nlinfo)
@@ -2130,6 +2133,13 @@ remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 	/* make sure all see the newly published array before releasing rtnl */
 	synchronize_net();
 
+	/* Routes through the groups can still hold dsts cached through @nh,
+	 * which are only released when @nh is freed. Invalidate them now that
+	 * no reader can pick @nh from the old groups any more.
+	 */
+	list_for_each_entry(nhge, &deferred_free, nh_list)
+		nh_rt_cache_flush(net, nhge->nh_parent, nh);
+
 	/* Now safe to free percpu stats — all RCU readers have finished */
 	list_for_each_entry_safe(nhge, tmp, &deferred_free, nh_list) {
 		list_del(&nhge->nh_list);

-- 
2.43.0

