Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793468;
	b=IITJTPFdx+QDIFRXUmCSUmx4fgrGPaafaXXnN0efjlJycS4kEeWfUZ4UnliN39iWKkAo
	 XmpB73MJ6cNmmO4KRZiSd3ndRV3pAHSurMmrYr8bR4dqTvPyKACbsOC11BTxi2kybKWOT
	 Abe7XED+Wd9jxkT5HxC8ZH/YK/Ve0GAo49rkSedH+WRvrzZulzYr9D1Cxn3SBiDYVDwF6
	 kgfdD5OM6YiFLG1IaCvr8qxDDtDLvJBCK1bbS0JRv+HGJA5ol57ymn83YK2CtINrqPPDj
	 IrrHwiLFuBgPbED7JBZPwPseBreF6+olnjou6WuHxjVeq53L6aFOHPSZnQUF2drieUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793468;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=STtrZRO2YxEVx3H+ha1sUlpeSWj4yt3rSoZpXoj+5so=;
	b=A7XbAXsP9GcX4+Zv8e+K+1FP18nfuyc3QTzvyXlM/XGW6KOB0YrIybGJ0trsGNybTjdP
	 oCiVl6EiHmHbW/8bcN9jrTS+aVJi/XSJg0igN09usRwLb7ZUDTMeUXmXJK2PHiUynvqfl
	 rLfzZkSZ0DPYyVmRP3dIwthhoOyVmcPNj17M0fXLw60QJRL0iM8LYdnIdUBzqwT9zN82D
	 aEARdWRa7G3quu1ksWXVmQbFnBxMYdkaCuyhcaay+KgLNA8Lg9tKE7gndh5MI2tr71gw/
	 aknwNa7+FxbWfPXmFW/Bi/F2eNeXaY/nQzmo2G1I6zxau4uzxsJ/tsj71XogUAxGR6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NO+1zbRS;
	arc=none smtp.remote-ip=95.215.58.54
Received: from mta1.migadu.com (out-54.mta1.migadu.com [95.215.58.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044D606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 11:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B044D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NO+1zbRS
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9ozzZ0J6mwwASk+DJQ5lOt7LdV8xbNav1SzRVl12KLg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793793465; v=1; x=1794398265;
 b=NO+1zbRSM+V63urpcuwaMWPllejHdbakKNru/UJnunnDdRNDWf8o51B11Rfz3uSE/KHgzEMg
 yQH0pvmOz4ud5jVnLfrrSbGaVUESnsmWt7GoyZF2n1UvtODIZ6hIvsL/V1A7RHN4QOAMMUPJngg
 m9d03mraUzvq51pKW3OfIxNY=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8e7a7c0b85afa322;
	Wed, 04 Nov 2026 11:57:45 +0000
X-Mizu-Trace-ID: 8e7a7c0b85afa322
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Kees Cook <kees@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Breno Leitao <leitao@debian.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Joe Damato <joe@dama.to>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Li RongQing <lirongqing@baidu.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: raw: fix ICMP unreachable sent when receive queue is full
Date: Wed,  4 Nov 2026 19:57:26 +0800
Message-ID: <20261104115732.322151-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
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

It's found in a raw socket application. When the application doesn't
read packets in time, the client receives ICMP Protocol Unreachable,
which makes the client abort the session.

The reason is that the server hits the sk_rcvbuf limit, and
raw_v4_input() skips the socket before setting 'delivered', so it
returns 0. Then ip_protocol_deliver_rcu() sees 'raw' is 0, thinks no one
handles this protocol and calls icmp_send() to send ICMP Protocol
Unreachable.

IPv6 has the same issue, ip6_protocol_deliver_rcu() sends ICMPv6
Parameter Problem instead.

Also, we'd better run icmp_filter() and ip_mc_sf_allow() (icmpv6_filter()
for IPv6) before we check sk_rcvbuf, otherwise packets rejected by
ICMP_FILTER/ICMPV6_FILTER or the multicast filter are counted in
sk_drops. So move the check right before skb_clone().

Fixes: d721812aa875 ("ipv4: raw: check sk->sk_rcvbuf earlier")
Fixes: 026763ece881 ("ipv6: raw: check sk->sk_rcvbuf earlier")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv4/raw.c | 15 ++++++++-------
 net/ipv6/raw.c | 15 ++++++++-------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 9d01006d8189..f33a9dfc5309 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -182,18 +182,19 @@ static int raw_v4_input(struct net *net, struct sk_buff *skb,
 				  iph->saddr, iph->daddr, dif, sdif))
 			continue;
 
-		if (atomic_read(&sk->sk_rmem_alloc) >=
-		    READ_ONCE(sk->sk_rcvbuf)) {
-			sk_drops_inc(sk);
-			continue;
-		}
-
 		delivered = 1;
 		if ((iph->protocol != IPPROTO_ICMP || !icmp_filter(sk, skb)) &&
 		    ip_mc_sf_allow(sk, iph->daddr, iph->saddr,
 				   skb->dev->ifindex, sdif)) {
-			struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
+			struct sk_buff *clone;
+
+			if (atomic_read(&sk->sk_rmem_alloc) >=
+			    READ_ONCE(sk->sk_rcvbuf)) {
+				sk_drops_inc(sk);
+				continue;
+			}
 
+			clone = skb_clone(skb, GFP_ATOMIC);
 			/* Not releasing hash table! */
 			if (clone)
 				raw_rcv(sk, clone);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index b965258cf9e5..eb99f4a906ec 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -160,12 +160,6 @@ static bool ipv6_raw_deliver(struct sk_buff *skb, int nexthdr)
 				  inet6_iif(skb), inet6_sdif(skb)))
 			continue;
 
-		if (atomic_read(&sk->sk_rmem_alloc) >=
-		    READ_ONCE(sk->sk_rcvbuf)) {
-			sk_drops_inc(sk);
-			continue;
-		}
-
 		delivered = true;
 		switch (nexthdr) {
 		case IPPROTO_ICMPV6:
@@ -197,8 +191,15 @@ static bool ipv6_raw_deliver(struct sk_buff *skb, int nexthdr)
 		if (filtered < 0)
 			break;
 		if (filtered == 0) {
-			struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
+			struct sk_buff *clone;
+
+			if (atomic_read(&sk->sk_rmem_alloc) >=
+			    READ_ONCE(sk->sk_rcvbuf)) {
+				sk_drops_inc(sk);
+				continue;
+			}
 
+			clone = skb_clone(skb, GFP_ATOMIC);
 			/* Not releasing hash table! */
 			if (clone)
 				rawv6_rcv(sk, clone);
-- 
2.43.0

