Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212336;
	b=h6XJFVDNrBd5JIh/cCUuogf21CTxPuZxu3EXSxjVv8hZGOWBPaCBkSZ6WSe6BdW4VaLH
	 6VzlZ6+kuPTS+nZHHQUoKuJE5c1NG34q+RMvSg1htO2oH++9dOyWX40Wjw67B/gsb9BrE
	 ZUp6mCMhekQHdOB57FU3f/vGU9Dcmts5PPRZont9XquI5A0/gJwZm7iIfXJZa9D3zN+4+
	 5dQi4uKdIlxj0Ylbddk0jkqG4gb8Qsu2g156V/L6AWIlz+unsrEZ+ftjY+SbfY1YFvZvp
	 yQ7GbOXF+63eAmW+ls6VU1XK2OrdvOsSlu7nh/8Yxvn9ANCcm8IMd+rIRoCAKtHvV4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212336;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=BGQtkhiTQEncvaXShKyiOU61Jc8kJGe+kX2TaLjyCwM=;
	b=4wPkrgMMj3WSmVJ8XY8csiH0d9JD3QswsN+zK1ztEF98TVHMlUP+Ifi0Auqs3x48wB/S
	 Yx05LhjJt7kxiOQq3rdjQ/c2Zrwtr0PHWR8dqoa+zkCHbzjhNbWWerxuSwKyE66QohJj1
	 FLez3dlY9l7k267YTzBodKX6YcgyWKQFUbRUxzc3buXxi56fdEE3NhFcKgYqEL/AD+VIe
	 B6hTpwX3zN1vZwMaxql5GtJZ50yVXMD3/5I8iqKjWIbzJezZ3/jarID9UZaTM7h1gFjeO
	 xrK8360y+px2XaigtSUFPv4vIUmtPLHa2QBx2CzPnio/ZSRlw0do0i7bf6+sVmOkiyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UWzFwCf0;
	arc=none smtp.remote-ip=91.218.175.167
Received: from mta0.migadu.com (out-167.mta0.migadu.com [91.218.175.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527C606A323
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4527C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UWzFwCf0
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KYu9z+Ws9MnPlTPEBe2QxNPdQ6+TgoscUdEZlYypBYI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794212334; v=1; x=1794817134;
 b=UWzFwCf0VIaSctmV61XsClBPdF9TgiGT/RnzRJTRKfcvJnf5q1CA+4GnEKgsNeHqyZ8vOkz9
 Cw6JXZmA4o6rFCecon4PnQr3a6cWLrI1srOCGj7P7Fl0/VD/AbMD1cW8FXxGPRNVyJ1Yvuf9g9K
 8kG03uO4MUQRiYWSbRi65UMA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4f068457210c7401;
	Mon, 09 Nov 2026 08:18:54 +0000
X-Mizu-Trace-ID: 4f068457210c7401
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Mon, 09 Nov 2026 03:18:15 -0500
Subject: [PATCH net-next v3 4/4] net: remove rcu_barrier() from
 __dev_change_net_namespace()
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
Message-Id: <20261109-bug-net-netns-move-rcu-barrier-v3-4-6084b02610b3@linux.dev>
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

Commit 6549dd43c043 ("net: dev: fix the incorrect hold of net
namespace's lo device") added rcu_barrier() before
NETDEV_UNREGISTER_FINAL in dev_change_net_namespace(), so that dst
entries released by RCU callbacks were on the dst garbage list before
dst_ifdown() moved them to the loopback device of the old netns.
Commit 070f2d7e264a ("net: Drop NETDEV_UNREGISTER_FINAL") removed the
event but kept the barrier, and dead dst entries now point to
blackhole_netdev instead of a loopback device.

The barrier waits for the RCU callbacks pending on every CPU while RTNL
is held, which takes a full grace period on each netns move. Container
and sandbox managers move one end of a veth pair for every new network
namespace, so this limits how fast such namespaces can be created on the
whole system, regardless of how many threads create them.

Remove the barrier. The RCU callbacks queued by NETDEV_UNREGISTER
handlers free memory and drop device references, which the move does not
wait for. Routes cached through the moved device are rejected once its
netns changes: IPv4 and per-cpu IPv6 routes no longer match the rt_genid
or fib6_sernum of another netns, and the IPv6 exceptions of a nexthop
that leaves a group were already flushed when it left. Creating 400
netns, each with a veth pair whose host end is moved back to the initial
netns, a tap device, addresses and routes, in a 4 vCPU guest, median of
5 runs:

                   before      after
  1 thread        46 /s       56 /s
  4 threads       58 /s       84 /s
  16 threads      75 /s      146 /s

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3b60b15e2175e..de1fd77440543 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -13044,7 +13044,6 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	 * the device is just moving and can keep their slaves up.
 	 */
 	call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
-	rcu_barrier();
 
 	new_nsid = peernet2id_alloc(dev_net(dev), net, GFP_KERNEL);
 

-- 
2.43.0

