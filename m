Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385374;
	b=hy+TNCJa1EXsxptbIwBNo4x74+vYasaX9Mpgl3CA0hUVd0V1VbxFecJeBWu3ZB2GvJlk
	 qu31ttYqrBWhfHNufdtfHgDs8BuKNUk+mJYdnz74fDEgDsyfYsKNZysNPFAf/sCtYzke+
	 IQ3woEG5+hqiu9HYkX30Aqq/Xtr25hf9gkcaNzKFVSbrA8ObWYupszRNOi4m7uMdSq4cj
	 nUFCflrEl/bnJLuZz4vhA7rtzQJ13cNiSk4hMXcjq1kZHm5Utratc71X+gjan1eZed5xI
	 EJcNEJ3Je8sdL80LRkZ+3R6tlW4bWI5EjXXn9Pmhd0rZXwcP+zrlrQny18JhfJ+nxgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385374;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=ZzaRT9EriuUe3n4+kQFzrBiO072spo9Pbubm9BFqReA=;
	b=mh4ciB46rUoHIZ7iavPT6hrOW5jA4cCNlwTjx8D/T/YzVFhNfyvRbUXx1zBR5cMUpGTS
	 wP4m/73UNGT96QeBzMBdqk2LBbT51gmR4eArmmZa/tgVpG8yAcp5dVbW3GUqsTNEfeggd
	 0V7J6yNxaaxxmvcDKOusl+3JOt2R+fkPrt8hlnfkKDCGHdfY77r8j6TCVkqK/kQTYbmON
	 6TYW9YTL/uhBjyxr7XJt+2+yznuy8DKkp6kZh78+hCWJdQ9bCdZfZq9f+himMvDwS5ozL
	 Ec7LPmIxUJxRjGKSgBBKFJuzaTZ2VPI7V6NL1j7FbK0be8voi1w5oIMpr4f+KAyemAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b="pqS1jv/O";
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E8606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A0E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=pqS1jv/O
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jPc2y4QhYz5x2D;
	Wed, 11 Nov 2026 09:22:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794385370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzaRT9EriuUe3n4+kQFzrBiO072spo9Pbubm9BFqReA=;
	b=pqS1jv/O6zyW+MdiKgLxZgT0K+YMWUdOrDyy3VN9XT/taMZfIXh5STgwMtpXs1LUG9lVDh
	kgps3NKsjvPxVLEIJ6NOVXLXYC9Z9a5tjmfVFZC0UpR0vM+pPLAWKuv4jo05EOCD9Nsmcp
	Mmdco+HcgCyzY8X6ZFzsw3GwZI59c2pIxU9MvI+ySqnSxr56hFVV9SqCrrRLl/UYr2kB6T
	3hWFNtoXiYHd+QFrjaIRusU3W4oG8NY5F022S3CdHNTgoS8H3f+DbOZeW9/D8xwzSVkk/4
	QwhQM3yF4yGaq5Rwl8D01DtwPK49pyXMhqmJcUfwUq4RD7/Kbktj+5hTJbDxZQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
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
Subject: [PATCH net-next v2 1/3] ipv6: stamp the default route node with a fresh serial on link failure
Date: Wed, 11 Nov 2026 09:22:35 +0100
Message-ID: <143461e2c94a20060ff4c7d6e5eb46c47ac46aa0.1794384146.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794384146.git.ralf@mandelbit.com>
References: <cover.1794384146.git.ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jPc2y4QhYz5x2D

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
No changes since v1 https://lore.kernel.org/netdev/5b039a5a24808f2678eedd283c29f8dae514ef5e.1793806941.git.ralf@mandelbit.com/

 net/ipv6/route.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 04098cf32eab..89fddc9df55c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2867,13 +2867,13 @@ static void ip6_link_failure(struct sk_buff *skb)
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

