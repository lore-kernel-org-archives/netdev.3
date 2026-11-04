Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807649;
	b=CyYeEldVhaIQPoY4R/MtWcQtrGBIYIY4IC4MpUn2hU+LN0MQtrzQ6yjyfQVVXJWBrCmk
	 YW6il+wJuqWuPx5pMRBlgrh4oUTWnxxF2Ewe8QvwJrvsm/znDg7Il1g2lAIlT8EL8p0Zf
	 EI3Gz4/SriDxXSSC6dBcYtzvxT9RMaI4RAOd06MOfTmKSxpWvIn/mJzLP9QisBGi0APww
	 L7jA/RvxAVMy66IXt4/qc9cfescR/oUUY2uz9xv1tM6nHCoYzXOaJj7v6EQ7au9GJ/rxl
	 q1vC89jGLMiOJAywvjlcTVajP83nWMYUkY8ZnuBy+fwiuSm0djAJZDFXETF6Ezhn7LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807649;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=GFaRpb5xInao4DidM06nxZha1Kt9gH95kDHrKh0m23s=;
	b=eXC2qqGIUJnUNVVd2Dbcf2S6pIzOzmcDdLib31UKCckOcT7EATje+chyAShCnaiF65vY
	 lP+Z8bNDHxLnjtB84TrN8iEpvRkh43sLyn1unne12TCjtwTFLelDBM37Oeki8XMcYZVSt
	 W2fjeiPAzyuNPw/pYD0ILmzOUrIfh70uYgbaWX89OVRKXjpJOxFHPA0HuX7G6ScEw7XAj
	 huk4wfxTu5hBPvY2Q1OqQJKOegrVKATtdjrb+t87Rzn13xXC1BFlDdFa5tzOn8zF4p1kd
	 ozKFE890INx6Lk/jM8XVgjlWNBhwAf2qSUe7sXnIn3oxnmcfAFxxDsi0v8i2RmujVWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b="MonnN//x";
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B16606A32F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91B16606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=MonnN//x
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jKVNl0F4rz5vSs;
	Wed, 04 Nov 2026 16:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793807639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFaRpb5xInao4DidM06nxZha1Kt9gH95kDHrKh0m23s=;
	b=MonnN//xEv5JtNF41YBxjZV48XZfJ11IqJrvwCmm2GhPq3dCBAJU6XctkdAO4it9tvjJj8
	PqnTwnVOUqcGmFPCGUU4XfR2wD8pqnBQqboyRmG+HzALkjV4LeSk9VBAeeqlNowV0ZnaAy
	WcWxslpK1kplToJB4cOFzaFzHXXJwCwk1FDGsKfHLneHS0gkNe/bWyJv8yzjbYkcx63cfA
	AkGgXF/4OrJhLKqv5N8yPxQULa3bhQvGnDHbG54L8clm6ruLwAixkCsm+afuL4wbSWss1f
	a+75w/QfS8nP56jNrgzHAPPjp6p6BcTPD1E7Fn3dqNJrp+A1muSWyhsmkA7dQA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 1/3] ipv6: stamp the default route node with a fresh serial on link failure
Date: Wed,  4 Nov 2026 16:53:29 +0100
Message-ID: <5b039a5a24808f2678eedd283c29f8dae514ef5e.1793806941.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793806941.git.ralf@mandelbit.com>
References: <cover.1793806941.git.ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jKVNl0F4rz5vSs

ip6_link_failure invalidates the cached dsts of an RTF_DEFAULT route by
writing -1 into the node's fn_sernum. Unlike every other fn_sernum
update, this does not allocate from net->ipv6.fib6_sernum, so the change
is invisible to anyone watching the generation, and a cookie sampled
from the node after the write simply reads -1 and matches it.

The write is also a no-op when the node already holds -1, so dsts cached
after one link failure survive the next one. dsts of nexthop objects are
validated against the generation and ignore fn_sernum, so a link failure
never invalidated them.

Allocate a fresh serial under tb6_lock instead, as for any other FIB
change. A link failure now invalidates the nexthop-object dsts of the
namespace too, as a route insertion does.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 net/ipv6/route.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 616b86f89f63..fa2b9033be6a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2853,13 +2853,13 @@ static void ip6_link_failure(struct sk_buff *skb)
 			rt6_remove_exception_rt(rt);
 		} else {
 			struct fib6_info *from;
-			struct fib6_node *fn;
 
 			from = rcu_dereference(rt->from);
-			if (from) {
-				fn = rcu_dereference(from->fib6_node);
-				if (fn && (rt->rt6i_flags & RTF_DEFAULT))
-					WRITE_ONCE(fn->fn_sernum, -1);
+			if (from && from->fib6_table &&
+			    (rt->rt6i_flags & RTF_DEFAULT)) {
+				spin_lock_bh(&from->fib6_table->tb6_lock);
+				fib6_update_sernum(rt6_exception_net(rt), from);
+				spin_unlock_bh(&from->fib6_table->tb6_lock);
 			}
 		}
 		rcu_read_unlock();
-- 
2.56.0

