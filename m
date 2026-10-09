Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D44D598E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548688; cv=none; b=fbzYZdVDf5Lt4qKQmpeTy8W4rC/OOUu+EPp/CCCR36oQPijmqz+iWYSOTnXcQUuglz6PWXa+yPjkXrwbmHCszDS1wlWcSDx+28f/wbO50bmYLyOHcJMY8QayDvnOMPE7SRiSdOsxyyrahWAeSspTQN+dIuplHamLC9/7V5q7I/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548688; c=relaxed/simple;
	bh=TmplD7M3/ZS5S2MqUm5uRoy8Tnhp/HPPz1KHIvm0O+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6RrEdeczXSvMIYt1F2204PcDbPh3hcyhhyvQmS9d2ralnvm/VDjbDgf/OX17P0w2ZKbpkEoW06n4fxBKAW0hAuaKwT1dWVMnGzornZKmZOQDpFRp49XFk5JPVnIaPrQctsNZcz+3ALwl+23RyVKlL/1T4gCCW3bE3DIgjjS20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=qX2nhVKP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="qX2nhVKP"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so3423838a91.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791548677; x=1792153477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nZvhZNf/1EH5SUhLAT8AYkRI8zQOSFEZ0YB2gJwWoYA=;
        b=qX2nhVKPpKITrWjwsp9sMMj4p/vpOcQt2NFvGVYqbYxx5Tzl3g0P4iNi9yXk6X1hoD
         aHHIHDwBStO5teYG3pipRNZebZdBuz3FTPCwSgQAFtXaYxRozJ4wYFItvbcwmbgQyoRS
         9bMAJedb90MINk2akYDwz7TMla5jiG/1dfGmxcZ9GG7v6qQFHjog77NcHPAjJnqydzic
         Gsh0tSh1KdlzlK7wlDT6vPhuARoi4CDQYcz7ZFIin3yXRxUSlmeh6L1a+0tMnpvq5zLn
         pcRauf3QBl7qxGWTX1/cA7XoWadfTGB8aoKKT0Kk+yXqXxfHOxXF5JA69y6amlthzwf4
         H28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791548677; x=1792153477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nZvhZNf/1EH5SUhLAT8AYkRI8zQOSFEZ0YB2gJwWoYA=;
        b=qr6wBCkKYMqAytOyWIXwJCoYbs1z4sbev085dRGdOJppctnHlxO9ZlGXAblibNfBkw
         1qkd3v+glw6aJjuG5bU0P4PSrfWv8htYpm19jvvYA4UsnZ9yWpc+9DO6zvKzcMXyk7qt
         BWasV7KwLwbw4XyuHhjcUykGKKirXAY46K23ipILrQK8YQ/vKYpUn6hPReNC4WEn4tTF
         NWTBeItTlluiAhffryUixHyqlw2rm92PLZnl31dOZ13oncJp7oTGSw+G3rnfpOqiSNlC
         /g9W+vCIBHA9U0VBMHUrTVWJq8Zc9N7mBnUjuWwvA7i85kp/czFL6isoThOT5eA4XEOG
         SWZw==
X-Forwarded-Encrypted: i=1; AKwUvBzIDfXWNme0Ls8LBRuTjKVlz7nA6QlrzLuka9QySM2Vj7ZshqwqdrOFj9RqCTaX4pi1DrXCcGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlPJ0TQGCWH02qNN5ooAwdAzLlAXq49y2VEv1O0a3EzcK8iBfI
	7hgJDm3pjK1uyn8809FTy1gd37naQQvMsaACskaad8eRe2VLx+SaN0Eyzl0moPPInOE=
X-Gm-Gg: AYBFou0olitmo6uGAHpwi7I9fTtoWbZocru5BHO09qrB2Ntb8cLOpS6+ImAoO5GBESe
	4p7sXumPChuebaAbhSQTEfmanWz3KFfsn6NPjG1xZaPtjFYc5aY1X+D5fSbYp8kupKY0HVSyF6p
	dqq8M6L4iRcbE+C1IJDQ5vVX0x6pYk0/+7bzVz9Q9P2JK6UY43xh3W0ktgXxfmhZxwAxVjlUmyc
	BWfxnFkdiAyqnrRz7JKj50YANP6YfuxLWMOoAOlKhWgcQpVQCrHy4owZPZ+5Fw8nLHvI1T6xepe
	r+NZaAnhbaWyjiJzigh06+cgc9wRVzGPXZSuIOlV0SZmNDT4nwvmIxwGDwh+WrI31kLilgcBn3z
	DFaW8GFd1s1yNOqk6Dk9QB6xyyI6za4oLjgoftce/i/mTwBodZXquBLKQ/qRCuDo9qPbL7uEwa8
	82xohHOyHdcz9MU/vYtIfY/BD2k36NWn3Nalz2LHHCPss508nm/Jy7xbMEz4AlRz6NKwLYSb15n
	bOgWmMa2wJIWGlBnLlbguzd0H6q4PGLgxLHAnCm
X-Received: by 2002:a17:90b:4b:b0:3ab:2c2b:1030 with SMTP id 98e67ed59e1d1-3ab3a747cfcmr1496285a91.22.1791548677492;
        Fri, 09 Oct 2026 05:24:37 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab55e41eefsm1660502a91.10.2026.10.09.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:24:37 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/13] amt: send the Membership Query over IPv6
Date: Fri,  9 Oct 2026 12:24:17 +0000
Message-ID: <20261009122426.551178-5-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009122426.551178-1-omar@blockcast.net>
References: <20261009122426.551178-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the Request, a relay answers each gateway with a Membership Query
through amt_send_membership_query(), which routes and transmits only
over IPv4.

Rather than adding an IPv6 twin of the function, move its routing and
transmit step into amt_udp_xmit(). Given an skb that already carries
the AMT message, a union amt_addr destination and the port pair, it
sends over the device's family: ip_route_output_key() and
udp_tunnel_xmit_skb() for IPv4, as before, and amt_route6() and
udp_tunnel6_xmit_skb(), which fills in the mandatory IPv6 UDP checksum,
for IPv6. Both use AMT_TOS, as the IPv4 path and the IPv6 control
messages do. udp_tunnel_xmit_skb() scrubs the skb in iptunnel_xmit(),
but udp_tunnel6_xmit_skb() does not, so the IPv6 path calls
skb_scrub_packet() itself. Otherwise the conntrack entry and extensions
of the inner packet would stay on the outer one, which conntrack would
then pass as an already tracked flow.

amt_send_membership_query() sizes its headroom for the outer family
with amt_ip_hlen(), builds the AMT header and hands the skb to
amt_udp_xmit(). The route lookup now runs after the header push; on a
route failure the caller still frees the skb. The relay's General
Query, which amt_send_igmp_gq() and amt_send_mld_gq() now send directly
through amt_send_membership_query(), takes the IPv6 path with no change
to those functions.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 94 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 26 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index eaa5637..5e8a74c 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -88,6 +88,11 @@ static bool amt_v6(const struct amt_dev *amt)
 	return IS_ENABLED(CONFIG_IPV6) && !ipv6_addr_any(&amt->local_ipv6);
 }
 
+static unsigned int amt_ip_hlen(const struct amt_dev *amt)
+{
+	return amt_v6(amt) ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
+}
+
 /* Copy the outer source address of a received message by value, so that
  * the caller may pull the skb afterwards.
  */
@@ -1098,6 +1103,65 @@ static void amt_req_work(struct work_struct *work)
 				 msecs_to_jiffies(100));
 }
 
+/* Route an AMT-encapsulated skb to @daddr and send it over the device's
+ * outer family. The caller has already pushed the AMT header.
+ */
+static int amt_udp_xmit(struct amt_dev *amt, struct sock *sk,
+			struct sk_buff *skb, const union amt_addr *daddr,
+			__be16 sport, __be16 dport)
+{
+	struct rtable *rt;
+	struct flowi4 fl4;
+
+	if (amt_v6(amt)) {
+		struct dst_entry *dst;
+
+		dst = amt_route6(amt, sk, &amt->local_ipv6, &daddr->ip6,
+				 sport, dport);
+		if (IS_ERR(dst)) {
+			netdev_dbg(amt->dev, "no route to %pI6c\n",
+				   &daddr->ip6);
+			return PTR_ERR(dst);
+		}
+		/* iptunnel_xmit() scrubs the IPv4 tunnel skb, but
+		 * udp_tunnel6_xmit_skb() does not, so drop the inner
+		 * packet's conntrack and extensions here. Links cannot
+		 * cross netns, so this is never xnet.
+		 */
+		skb_scrub_packet(skb, false);
+		udp_tunnel6_xmit_skb(dst, sk, skb, amt->dev, &amt->local_ipv6,
+				     &daddr->ip6, AMT_TOS,
+				     ip6_dst_hoplimit(dst), 0, sport, dport,
+				     false, 0);
+		return 0;
+	}
+
+	memset(&fl4, 0, sizeof(struct flowi4));
+	fl4.flowi4_oif         = amt->stream_dev->ifindex;
+	fl4.daddr              = daddr->ip4;
+	fl4.saddr              = amt->local_ip;
+	fl4.flowi4_dscp        = inet_dsfield_to_dscp(AMT_TOS);
+	fl4.flowi4_proto       = IPPROTO_UDP;
+	rt = ip_route_output_key(amt->net, &fl4);
+	if (IS_ERR(rt)) {
+		netdev_dbg(amt->dev, "no route to %pI4\n", &daddr->ip4);
+		return PTR_ERR(rt);
+	}
+
+	udp_tunnel_xmit_skb(rt, sk, skb,
+			    fl4.saddr,
+			    fl4.daddr,
+			    AMT_TOS,
+			    ip4_dst_hoplimit(&rt->dst),
+			    0,
+			    sport,
+			    dport,
+			    false,
+			    false,
+			    0);
+	return 0;
+}
+
 static bool amt_send_membership_update(struct amt_dev *amt,
 				       struct sk_buff *skb,
 				       bool v6)
@@ -1230,8 +1294,6 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 				      bool v6)
 {
 	struct amt_header_membership_query *amtmq;
-	struct rtable *rt;
-	struct flowi4 fl4;
 	struct sock *sk;
 	int err;
 
@@ -1240,23 +1302,11 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 		return true;
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(amt->dev) + sizeof(*amtmq) +
-			   sizeof(struct iphdr) + sizeof(struct udphdr));
+			   amt_ip_hlen(amt) + sizeof(struct udphdr));
 	if (err)
 		return true;
 
 	skb_reset_inner_headers(skb);
-	memset(&fl4, 0, sizeof(struct flowi4));
-	fl4.flowi4_oif         = amt->stream_dev->ifindex;
-	fl4.daddr              = tunnel->addr.ip4;
-	fl4.saddr              = amt->local_ip;
-	fl4.flowi4_dscp        = inet_dsfield_to_dscp(AMT_TOS);
-	fl4.flowi4_proto       = IPPROTO_UDP;
-	rt = ip_route_output_key(amt->net, &fl4);
-	if (IS_ERR(rt)) {
-		netdev_dbg(amt->dev, "no route to %pI4\n", &tunnel->addr.ip4);
-		return true;
-	}
-
 	amtmq		= skb_push(skb, sizeof(*amtmq));
 	amtmq->version	= 0;
 	amtmq->type	= AMT_MSG_MEMBERSHIP_QUERY;
@@ -1270,17 +1320,9 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
 	else
 		skb_set_inner_protocol(skb, htons(ETH_P_IPV6));
-	udp_tunnel_xmit_skb(rt, sk, skb,
-			    fl4.saddr,
-			    fl4.daddr,
-			    AMT_TOS,
-			    ip4_dst_hoplimit(&rt->dst),
-			    0,
-			    amt->relay_port,
-			    tunnel->source_port,
-			    false,
-			    false,
-			    0);
+	if (amt_udp_xmit(amt, sk, skb, &tunnel->addr, amt->relay_port,
+			 tunnel->source_port))
+		return true;
 	amt_update_relay_status(tunnel, AMT_STATUS_SENT_QUERY, true);
 	return false;
 }
-- 
2.43.0

