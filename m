Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FCF4B8DE8
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552939; cv=none; b=Zui27xekjUd6EqbnmLvBO3EDVi1wgehfRV82+eyLe7mLYpa9KZWPA0hNQ1NZJMZ5KclL6APNVMNv7paIWId8qELyDyVgy0malrX6+FBbc1vqyqim3fZh7ODhChHZ22sKmu5XExUUOBAf6NJBSwkMxWvqCY5zOVJOUqKzJPuzDf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552939; c=relaxed/simple;
	bh=lTeAKy2cUMECYz9XAgj6jm8FSzEY92vwbcBe9a5mHxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XuoBpNc4YqeTWtEfjLDMqi7hEkbdFAHZ7kr+m+cz2XzEKb3PoyRC5xgqwjOgox/HndxdkdO+86PdBuOBom/lo7F3fCi5dfo1N8yd1spQIKeiMe3/6swazP2x/xub147mhRXyFS7CWJLIshRIwRDghgBWiLJz26HO/POjq4aL1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhErvUhE; arc=none smtp.client-ip=209.85.128.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhErvUhE"
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8200c815489so64813887b3.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789552919; x=1790157719; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9QagC2ovlqvpy0hNeyHV6M9kvPtIc7PIUyX82cZctBg=;
        b=PhErvUhEQ70LFbqV75KYnmsMG7LQJW0z4MLSQ1FiepuGeTpZyZIbOrtqKM87T809Oc
         8DUUWTbHUl1UqDDl+NuROlxmG1x/vymNCkaANl1cEx7FHnoTdvXQq3mk1LJeT2/8BO2I
         kLRbi3A/rsEw0jIp4IundB7V5L7Tq1CLxx/YgEk8VPNKC8W4vbbqypaKxvZbKG1pdP2j
         zNtpZLd8Y5+Bk9RLmF3hkmeRYzgtEdk9xBHp1ssJ+K2DP6LeTCR7oUr7CIFhL9WXaKbo
         hSiijyefcP0h9WqhqGTAR3zEoC4NzbXPyqTtYnwsOOIfinGbxUnC+irf1S21cVlzYIh/
         G+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552919; x=1790157719;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9QagC2ovlqvpy0hNeyHV6M9kvPtIc7PIUyX82cZctBg=;
        b=Lnec8YWGxjF97vcunVGkhlHGwBhu9R/0zD7hCnkFobRv9LTlsphTYMmd4zFX7mOJ2d
         Ayq8E2/POBuu61SNIfeCLVWfcdUwcVg2qBS+irfkiY2P/CyRwYT/JLD401A/Y6opQ5UF
         Wede9pIbatZVZRC1HG/QpD8FNlIp3VfIvX584LGurXaZbdQ8haMyS+I/P6biEycZc8qB
         cySV8brd17MrUXjxYj4ndMYU/21856zk3JyQ5ThrKVsST6N2bWAMmLwTzFF7YiE8ka3B
         zwlJTqu9va6nwrwkp6OA+o1XsoLeZFcKHn+All2SJjWNjHoeig1oz+wLtaFB6RDCim+/
         KWKg==
X-Forwarded-Encrypted: i=1; AKwUvBwmi3uznRvZwjyFX9b+Mkggc2weTMbovHYE6JDgD2dtjVmC9vab8q7bZG+PY9zCKkwphqee9NA=@vger.kernel.org
X-Gm-Message-State: AFuF++nvadgxwqyemkE1WLueomPIsC/KrjhDBTdG56sneTB1M8bE3lbL
	4YTQ6dgMqCvJujuRSWmn6WaP9omndgAYj1Abx4QHBvxcJAVubbIZ+KehyixPd7Wdp1etF6X+Ee7
	xSGxPf5gd53WAaQ==
X-Received: from qkcbk8-n2.prod.google.com ([2002:a05:620a:72c8:20b0:939:ff54:fa9c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:f14:b0:882:31:3af9 with SMTP id 00721157ae682-8922076277cmr4830857b3.9.1789552918844;
 Wed, 16 Sep 2026 03:01:58 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:01:53 +0000
In-Reply-To: <20260916100155.1398403-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912150944.3470971-1-edumazet@google.com> <20260916100155.1398403-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916100155.1398403-4-edumazet@google.com>
Subject: [PATCH net v2 3/5] ip_gre: compute tunnel lengths absolutely instead
 of by delta
From: Eric Dumazet <edumazet@google.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipgre_link_update() adjusts the device lengths by a difference it
computes from tun_hlen alone:

	len = tunnel->tun_hlen;
	tunnel->tun_hlen = gre_calc_hlen(tunnel->parms.o_flags);
	len = tunnel->tun_hlen - len;
	tunnel->hlen = tunnel->hlen + len;

But tunnel->hlen also contains encap_hlen, which ipgre_changelink() can
change through ipgre_newlink_encap_setup(). Such a request leaves @len
at zero: adding "encap fou" to an existing gre device keeps the MTU of a
bare tunnel, while creating it with "encap fou" from the start gets the
smaller MTU from ip_tunnel_bind_dev().

A difference is the wrong tool anyway: ip_tunnel_bind_dev() already
assigns dev->needed_headroom from tunnel->hlen, so changing the link and
the encapsulation at once is accounted twice, and ip_tunnel_encap_setup()
publishes a new tunnel->hlen before the request is validated, making the
next difference bogus.

Recompute tunnel->hlen from tun_hlen and encap_hlen, as
__gre_tunnel_init() does, and add ip_tunnel_refresh_lengths() so that
ip_tunnel_bind_dev() is the only writer of dev->needed_headroom and
dev->mtu. ipgre_changelink() must then refresh on its error paths too,
since the new encapsulation is published by then.

dev->hard_header_len is recomputed the same way, but it stays in
ipgre_link_update(): for the ARPHRD_IPGRE devices installing
ipgre_header_ops it is the outer IP + GRE header, which
ip_tunnel_bind_dev() does not know about. Check specifically for
ipgre_header_ops: gretap devices also have header_ops (eth_header_ops),
where hard_header_len is the 14-byte inner Ethernet header that
ip_tunnel_bind_dev() subtracts from the MTU, and commit fdafed459998
("ip_gre: set dev->hard_header_len and dev->needed_headroom properly")
wrongly adjusted hard_header_len instead of needed_headroom for them.

@old_hlen survives only as a predicate telling whether the MTU became
stale, never as a difference, so it can not make the lengths drift. When
the header length does change, the MTU is now recomputed rather than
shifted, as ip_tunnel_update() already does for a link or fwmark change.

There is no memory safety issue: ipgre_xmit() cows dev->needed_headroom
at tunnel entry, which always reserves sizeof(struct iphdr) + lower
device headroom (>= 34 bytes after the GRE header), enough for
ip_tunnel_encap() to push the FOU/GUE header before ip_tunnel_xmit()
cows again for the outer IP header.

Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
Fixes: fdafed459998 ("ip_gre: set dev->hard_header_len and dev->needed_headroom properly")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_tunnels.h |  1 +
 net/ipv4/ip_gre.c        | 55 ++++++++++++++++++++++++++++------------
 net/ipv4/ip_tunnel.c     | 17 +++++++++++++
 3 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7c9aadfe8fe396da10a47e93499a97141ac04f4c..fd0396aa5039538a0391a352ace6d15f554df874 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -429,6 +429,7 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
 		      __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
+void ip_tunnel_refresh_lengths(struct net_device *dev, bool set_mtu);
 
 bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
 				   struct ip_tunnel_encap *encap);
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index dad3d054bd15612a3ebe1cf27e6e8c5d9e6896e9..ced57cbeaad4991487e9ddb29fa18ae6a1f134fb 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -789,23 +789,36 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static void ipgre_link_update(struct net_device *dev, bool set_mtu)
+/* tunnel->hlen depends on tunnel->parms.o_flags and on tunnel->encap_hlen,
+ * both of which ipgre_changelink() can change. Recompute it the way
+ * __gre_tunnel_init() does, then let ip_tunnel_bind_dev() derive the device
+ * lengths from it.
+ *
+ * @old_hlen is only used to tell whether the MTU became stale, never as a
+ * difference to apply, so it can not make the lengths drift. It must be
+ * sampled before ip_tunnel_encap_setup(), which already publishes the new
+ * tunnel->hlen for us.
+ */
+static void ipgre_link_update(struct net_device *dev, bool set_mtu,
+			      int old_hlen)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	int len;
 
-	len = tunnel->tun_hlen;
 	tunnel->tun_hlen = gre_calc_hlen(tunnel->parms.o_flags);
-	len = tunnel->tun_hlen - len;
-	tunnel->hlen = tunnel->hlen + len;
+	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen;
 
-	if (dev->header_ops)
-		dev->hard_header_len += len;
-	else
-		dev->needed_headroom += len;
+	/* For the ARPHRD_IPGRE devices installing ipgre_header_ops,
+	 * dev->hard_header_len is the outer IP + GRE header, as set by
+	 * ipgre_tunnel_init(). ip_tunnel_bind_dev() does not maintain it:
+	 * it only subtracts it from the MTU, and only for ARPHRD_ETHER.
+	 */
+	if (dev->header_ops == &ipgre_header_ops)
+		dev->hard_header_len = tunnel->hlen + sizeof(struct iphdr);
 
-	if (set_mtu)
-		WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - len, 68));
+	/* Only reset a MTU that the header length just invalidated, so that
+	 * a MTU configured by the user survives an unrelated change.
+	 */
+	ip_tunnel_refresh_lengths(dev, set_mtu && tunnel->hlen != old_hlen);
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags) ||
 	    (test_bit(IP_TUNNEL_CSUM_BIT, tunnel->parms.o_flags) &&
@@ -853,7 +866,7 @@ static int ipgre_tunnel_ctl(struct net_device *dev,
 		ip_tunnel_flags_copy(t->parms.o_flags, p->o_flags);
 
 		if (strcmp(dev->rtnl_link_ops->kind, "erspan"))
-			ipgre_link_update(dev, true);
+			ipgre_link_update(dev, true, t->hlen);
 	}
 
 	i_flags = gre_tnl_flags_to_gre_flags(p->i_flags);
@@ -1474,6 +1487,7 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
+	int old_hlen = t->hlen;
 	int err;
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
@@ -1485,18 +1499,27 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
-		return err;
+		goto link_update;
 
 	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
 	if (err < 0)
-		return err;
+		goto link_update;
 
 	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
 	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);
 
-	ipgre_link_update(dev, !tb[IFLA_MTU]);
+link_update:
+	/* ipgre_newlink_encap_setup() has published a new encapsulation even
+	 * if the rest of the request failed, so the lengths must be refreshed
+	 * on the error paths as well. This has to come last, because
+	 * ipgre_link_update() needs the flags copied above.
+	 *
+	 * IFLA_MTU only defers the MTU to do_setlink(), which rtnl_changelink()
+	 * does not reach if we return an error, so it must not hold it back.
+	 */
+	ipgre_link_update(dev, err || !tb[IFLA_MTU], old_hlen);
 
-	return 0;
+	return err;
 }
 
 static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 2a313b18134e2f0bafd52d59d8e173fa1a084f03..dd1b2f719f21670b02bfc1cafa62689b4a28a580 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -326,6 +326,23 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 	return mtu;
 }
 
+/* Recompute dev->needed_headroom and dev->mtu after tunnel->hlen changed.
+ *
+ * Both are derived from tunnel->hlen, so they must be recomputed from it
+ * rather than adjusted by the difference: ip_tunnel_bind_dev() is also
+ * called from ip_tunnel_create(), ip_tunnel_newlink(), ip_tunnel_init_net()
+ * and ip_tunnel_update(), and a caller adding its own delta on top would
+ * double count it.
+ */
+void ip_tunnel_refresh_lengths(struct net_device *dev, bool set_mtu)
+{
+	int mtu = ip_tunnel_bind_dev(dev);
+
+	if (set_mtu)
+		WRITE_ONCE(dev->mtu, mtu);
+}
+EXPORT_SYMBOL_GPL(ip_tunnel_refresh_lengths);
+
 static struct ip_tunnel *ip_tunnel_create(struct net *net,
 					  struct ip_tunnel_net *itn,
 					  struct ip_tunnel_parm_kern *parms)
-- 
2.55.0.1032.g73a4cd73de-goog

