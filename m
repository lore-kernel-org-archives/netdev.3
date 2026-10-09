Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7704D4897
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548704; cv=none; b=TnrbxZA58CcN/1tPdiUFZkZQVrE6hj62edty5F8aC7oQ4ZAcW/zCsa6Nh5HH7nqrsPiDY9vsFOTWnFY0fXq7LWV2yIxXcHpMIU108S0/4VfnfugCAasngit1PayqliLjI+SlEJO5uL7QLpi7tsXk5Yo10nweUfux2eVLXJEB73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548704; c=relaxed/simple;
	bh=2KNbFL2OKP7D3som//HIEy6TdZx60UeBfrW7UC0etKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbT/2Epf+3WA1yztOIspatsNRgymfQAndVRtlaTwl5nlrzriYwGt0cN5Z1vZYtDJcAmLmby8D2FdZQINYPiJn3mCNnmPulF6IlQeYEcxfi4qScgYrBe6n5pXZDviF34O4AKZtkbxq6qGF9vKIx7gNsbx81CYx9sXIpIYsKnaHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=OiQvr46q; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="OiQvr46q"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3a7026b3123so1068562a91.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791548689; x=1792153489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9b7Uo0a4NDP5ORGxTjsMEwyaVH53rDfhowBUmdjYwKI=;
        b=OiQvr46qJ8xr/b+/mwNs6aXr2+hYnPnJkiMyV7s3tQ3rGugHcFP8VkoXBtX7PwOI34
         v+4CCcycN0vNXjH5PmgL2i8eyFXETXzMPho5O8iGyrbCXtXIJDAqOwu+jd92PsmpyC8d
         klIb7OWLhXNXH29gWFoFIfo/pDISj+XIfB0p23/SBWgYLwOMKvGVCEOpIyQZvmcmTOsg
         LG+bd7kEzTyNQR6NsuEvpUxra/rOEHAoLPpZgK7t7PTl1QshXqFitkzpgSSPYDAOhIzI
         cFOUgfv7B7q+Sm2+QijopumhuwsSp1Ur3yqNJcJZA3+kKTAH+auziSriHpTroltM0meB
         bxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791548689; x=1792153489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9b7Uo0a4NDP5ORGxTjsMEwyaVH53rDfhowBUmdjYwKI=;
        b=eU+WBqhWza1D4AVlJG/5y+HQhcFaT+v4nY9lsQwrS8Kv9F/ElEGakAeQ10DvpxDym0
         MQVmWfbbR2r5lsekmLJzJ0qk2VxPsAOeqxlMQMFhkrJdxeMvYeM4ZXG5HWIluABEf9Mf
         X/lbpIhWKYLORDdDavio7HK5DhAzxkEMv9AVh55e+DL4Nd+gagAGzKhmI4e5iqRS91ho
         UJkvGEp3JAEl2LWBE61gKW/zIoB9ShqQ2KryeasVDc68u6bJve4DNicFKYXkM7TYh696
         fk5LqgaJW1SL9Goiu7Bq/oaDXHTRfSKDxvnlUWW5hoc+8LLCfomM98gJHEnEHwid5Xyc
         xzMA==
X-Forwarded-Encrypted: i=1; AKwUvBxpJlxti/5o1R92q7ZsUMq+Tlyv4yG/EELAvdzjYRtnfzmy7IZmRQ3LKoUYeeEAZ0qf4LxFlwQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/uotmAR3myFkz6OcNl5TbB0ccLs0YQKtIuCNEs8GhRB/MWViE
	FT2ZBE19mvxfAK6+OiAyQxYTdErmb2AYykY9ahiEVqM2Edk5Z4gcOGtBe1SkqDTnNWE=
X-Gm-Gg: AYBFou0vImejod81+QS3gOukzRgY1PrIa1HcR+Peh3k2OEirzfa3A27j8oiPGxGwL5e
	17r6CbVbXnG+gXu31UEAkJcYQ2oHfJLgufHn9Liw0eH4DSKsOqgf2rIpTjz+1xF4bPiwcbPF0jd
	GSmMRrgyWx7YbDq6PWgiRuOhu0QYsRP2QNAdLbhXMpVyS3CYSWrgJNi1zLp2cKA42UwfNRfhRik
	W1z2UE+p5GMECLWoRTUjMvnZmuh1g+iTj4KsBmJ6hf+FRcwltUrDcyo0/tGr+ziR97LpOv6WqAG
	Xp2Bv+Dunge235+xG63IsmjJr6a5LjQZf5ma6R+LAZAfy5rbboco8UgU4upcbXGj7aeD+X0nGc5
	51GAmdxIfBFSam1xP9vREDZ/adXDACf3ahD8ZjJwjTbhTDZJII/xum3PcnmHP1/vfUAi2sFZ0Ve
	DVn5Jwmciy54KGqNcdsvB00NKIBdml/fxqqletox43xst1K0A9BfvTY8ONbNDCV2qvnRcWyqcYv
	ZZdfZzM6Uo61PRmBI/Ah4fLTtiviu87gBR/JJJi
X-Received: by 2002:a17:90b:2ec3:b0:3a8:240e:b493 with SMTP id 98e67ed59e1d1-3ab3acf5c6amr1692804a91.45.1791548689236;
        Fri, 09 Oct 2026 05:24:49 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab55e41eefsm1660502a91.10.2026.10.09.05.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:24:47 -0700 (PDT)
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
Subject: [PATCH net-next 09/13] amt: receive the AMT gateway control plane over IPv6
Date: Fri,  9 Oct 2026 12:24:22 +0000
Message-ID: <20261009122426.551178-10-omar@blockcast.net>
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

An IPv6 gateway now sends its Discovery, Request and Updates over IPv6,
but it cannot take the replies. amt_rcv() checks the outer source of an
Advertisement against the discovery address, and that of Multicast Data
and a Membership Query against the learned relay address, by reading
ip_hdr(skb)->saddr, which on an IPv6 outer header is bytes 4-7 of the
source address, so only 32 bits of it are compared.
amt_advertisement_handler() parses only the IPv4 form, so the gateway
never learns an IPv6 relay address.

amt_rcv() now takes the outer source with amt_outer_saddr() before
amt_parse_type() pulls, and checks it in the device's family through
amt_from_relay(). On an IPv6 gateway amt_advertisement_handler() pulls
the 24-byte IPv6 form, whose header and nonce are laid out as in the
IPv4 one, and refuses an unspecified, loopback, multicast or
IPv4-mapped relay address, the IPv6 counterparts of the checks on the
IPv4 address; the V6ONLY socket could not reach an IPv4-mapped relay.

amt_set_remote_ipv6() publishes the learned address under
remote_ipv6_lock. amt_clear_remote() forgets the relay in both families
and replaces the IPv4-only reset in amt_event_send_request(),
amt_dev_open() and amt_dev_stop(), so a gateway taken down and up again
neither accepts traffic from its previous relay's IPv6 address nor
keeps reporting it.

IPv6 input delivers a packet from ::. On a gateway that has lost its
relay it would match the cleared relay address and, with a zero nonce,
could inject a Membership Query, and a relay would create a tunnel for
it. amt_rcv() drops a :: source, and amt_from_relay() matches nothing
against a relay address that is not known, in either family: IPv4
input delivers a 0.0.0.0 source too, when the packet is sent to
255.255.255.255.

RFC 7450 s5.2.3.3 says a gateway that processes Multicast Data itself,
as amt_rcv() does, must not discard it for a zero UDP checksum, which
s5.1.6 lets a relay send, the RFC 6936 exception to RFC 8200 s8.1. An
IPv6 gateway's socket therefore accepts a zero checksum and still
verifies a non-zero one. amt_rcv() drops a zero checksum on every other
message a gateway receives, as RFC 6936 s5 asks, and a relay's socket
keeps requiring the checksum.

The Membership Query and Multicast Data handlers work on the payload
behind the outer header and need no change.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 116 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 94 insertions(+), 22 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 148d1fb..86f168c 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -116,6 +116,16 @@ static void amt_outer_saddr(const struct amt_dev *amt,
 		addr->ip4 = ip_hdr(skb)->saddr;
 }
 
+/* An IPv6 address no relay or gateway can use: the counterparts of the
+ * IPv4 zeronet, loopback and multicast checks, and IPv4-mapped, which the
+ * V6ONLY socket cannot reach.
+ */
+static bool amt_ip6_unusable(const struct in6_addr *addr)
+{
+	return ipv6_addr_any(addr) || ipv6_addr_loopback(addr) ||
+	       ipv6_addr_is_multicast(addr) || ipv6_addr_v4mapped(addr);
+}
+
 static void __amt_source_gc_work(void)
 {
 	struct amt_source_node *snode;
@@ -731,6 +741,21 @@ static struct in6_addr amt_get_remote_ipv6(const struct amt_dev *amt)
 	return addr;
 }
 
+static void amt_set_remote_ipv6(struct amt_dev *amt,
+				const struct in6_addr *addr)
+{
+	write_seqlock_bh(&amt->remote_ipv6_lock);
+	amt->remote_ipv6 = *addr;
+	write_sequnlock_bh(&amt->remote_ipv6_lock);
+}
+
+/* Forget the relay a gateway learned, in both outer families. */
+static void amt_clear_remote(struct amt_dev *amt)
+{
+	WRITE_ONCE(amt->remote_ip, 0);
+	amt_set_remote_ipv6(amt, &in6addr_any);
+}
+
 /* IPv6-outer variant of amt_send_discovery(). */
 static void amt_send_discovery_v6(struct amt_dev *amt)
 {
@@ -1134,7 +1159,7 @@ static void amt_event_send_request(struct amt_dev *amt)
 		amt->qi = AMT_INIT_REQ_TIMEOUT;
 		WRITE_ONCE(amt->ready4, false);
 		WRITE_ONCE(amt->ready6, false);
-		WRITE_ONCE(amt->remote_ip, 0);
+		amt_clear_remote(amt);
 		amt_update_gw_status(amt, AMT_STATUS_INIT, false);
 		amt->req_cnt = 0;
 		amt->nonce = 0;
@@ -2476,27 +2501,39 @@ static bool amt_advertisement_handler(struct amt_dev *amt, struct sk_buff *skb)
 	struct amt_header_advertisement *amta;
 	int hdr_size;
 
-	hdr_size = sizeof(*amta) + sizeof(struct udphdr);
+	/* Both forms start with the same header and nonce. */
+	hdr_size = sizeof(struct udphdr) +
+		   (amt_v6(amt) ? sizeof(struct amt_header_advertisement_v6) :
+				  sizeof(*amta));
 	if (!pskb_may_pull(skb, hdr_size))
 		return true;
 
 	amta = (struct amt_header_advertisement *)(udp_hdr(skb) + 1);
-	if (!amta->ip4)
-		return true;
-
 	if (amta->reserved || amta->version)
 		return true;
 
-	if (ipv4_is_loopback(amta->ip4) || ipv4_is_multicast(amta->ip4) ||
-	    ipv4_is_zeronet(amta->ip4))
-		return true;
-
 	if (amt->status != AMT_STATUS_SENT_DISCOVERY ||
 	    amt->nonce != amta->nonce)
 		return true;
 
-	WRITE_ONCE(amt->remote_ip, amta->ip4);
-	netdev_dbg(amt->dev, "advertised remote ip = %pI4\n", &amta->ip4);
+	if (amt_v6(amt)) {
+		const struct in6_addr *ip6;
+
+		ip6 = &((struct amt_header_advertisement_v6 *)amta)->ip6;
+		if (amt_ip6_unusable(ip6))
+			return true;
+
+		amt_set_remote_ipv6(amt, ip6);
+		netdev_dbg(amt->dev, "advertised remote ipv6 = %pI6c\n", ip6);
+	} else {
+		if (!amta->ip4 || ipv4_is_loopback(amta->ip4) ||
+		    ipv4_is_multicast(amta->ip4) || ipv4_is_zeronet(amta->ip4))
+			return true;
+
+		WRITE_ONCE(amt->remote_ip, amta->ip4);
+		netdev_dbg(amt->dev, "advertised remote ip = %pI4\n",
+			   &amta->ip4);
+	}
 	mod_delayed_work(amt_wq, &amt->req_wq, 0);
 
 	amt_update_gw_status(amt, AMT_STATUS_RECEIVED_ADVERTISEMENT, true);
@@ -3075,11 +3112,32 @@ drop:
 	}
 }
 
+/* Whether a message a gateway received came from its relay: the discovery
+ * address for an Advertisement, the learned relay address otherwise. A
+ * relay address that is not known matches nothing, not even a 0.0.0.0
+ * source, which IPv4 input delivers in a packet sent to 255.255.255.255.
+ */
+static bool amt_from_relay(const struct amt_dev *amt,
+			   const union amt_addr *saddr, bool discovery)
+{
+	__be32 relay4;
+
+	if (amt_v6(amt)) {
+		struct in6_addr relay;
+
+		relay = discovery ? amt->discovery_ipv6 :
+				    amt_get_remote_ipv6(amt);
+		return !ipv6_addr_any(&relay) &&
+		       ipv6_addr_equal(&saddr->ip6, &relay);
+	}
+	relay4 = discovery ? amt->discovery_ip : READ_ONCE(amt->remote_ip);
+	return relay4 && saddr->ip4 == relay4;
+}
+
 static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 {
+	union amt_addr saddr;
 	struct amt_dev *amt;
-	__be32 remote_ip;
-	__be32 saddr;
 	int type;
 	bool err;
 
@@ -3090,10 +3148,14 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 		kfree_skb(skb);
 		goto out;
 	}
-	remote_ip = READ_ONCE(amt->remote_ip);
 
 	skb->dev = amt->dev;
-	saddr = ip_hdr(skb)->saddr;
+	amt_outer_saddr(amt, skb, &saddr);
+	/* No relay or gateway sends from ::, but IPv6 input delivers it. */
+	if (amt_v6(amt) && ipv6_addr_any(&saddr.ip6)) {
+		err = true;
+		goto drop;
+	}
 	type = amt_parse_type(skb);
 	if (type == -1) {
 		err = true;
@@ -3101,9 +3163,17 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (amt->mode == AMT_MODE_GATEWAY) {
+		/* RFC 6936 s5: accept the zero checksum only on the message
+		 * that needs it.
+		 */
+		if (amt_v6(amt) && !udp_hdr(skb)->check &&
+		    type != AMT_MSG_MULTICAST_DATA) {
+			err = true;
+			goto drop;
+		}
 		switch (type) {
 		case AMT_MSG_ADVERTISEMENT:
-			if (saddr != amt->discovery_ip) {
+			if (!amt_from_relay(amt, &saddr, true)) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -3115,7 +3185,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			}
 			goto out;
 		case AMT_MSG_MULTICAST_DATA:
-			if (saddr != remote_ip) {
+			if (!amt_from_relay(amt, &saddr, false)) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -3126,7 +3196,7 @@ static int amt_rcv(struct sock *sk, struct sk_buff *skb)
 			else
 				goto out;
 		case AMT_MSG_MEMBERSHIP_QUERY:
-			if (saddr != remote_ip) {
+			if (!amt_from_relay(amt, &saddr, false)) {
 				netdev_dbg(amt->dev, "Invalid Relay IP\n");
 				err = true;
 				goto drop;
@@ -3264,12 +3334,14 @@ static struct sock *amt_create_sock(const struct amt_dev *amt)
 		 * that IPv6 route lookups are strict about the output
 		 * interface, as IPv4 ones are, and a link-local peer is
 		 * unique. V6ONLY leaves the IPv4 wildcard port to an IPv4
-		 * amt device.
+		 * amt device. A gateway accepts a zero UDP checksum, which
+		 * RFC 7450 s5.2.3.3 requires for Multicast Data; amt_rcv()
+		 * drops it on the other messages.
 		 */
 		udp_conf.family = AF_INET6;
 		udp_conf.bind_ifindex = amt->stream_dev->ifindex;
 		udp_conf.use_udp6_tx_checksums = true;
-		udp_conf.use_udp6_rx_checksums = true;
+		udp_conf.use_udp6_rx_checksums = amt->mode == AMT_MODE_RELAY;
 		udp_conf.ipv6_v6only = true;
 	} else {
 		udp_conf.family = AF_INET;
@@ -3328,7 +3400,7 @@ static int amt_dev_open(struct net_device *dev)
 	}
 
 	amt->req_cnt = 0;
-	WRITE_ONCE(amt->remote_ip, 0);
+	amt_clear_remote(amt);
 	amt->nonce = 0;
 	get_random_bytes(&amt->key, sizeof(siphash_key_t));
 
@@ -3373,7 +3445,7 @@ static int amt_dev_stop(struct net_device *dev)
 	amt->ready4 = false;
 	amt->ready6 = false;
 	amt->req_cnt = 0;
-	WRITE_ONCE(amt->remote_ip, 0);
+	amt_clear_remote(amt);
 
 	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
 		list_del_rcu(&tunnel->list);
-- 
2.43.0

