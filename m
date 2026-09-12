Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A034E75D
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789225804; cv=none; b=G0E8i8FyRJDpinobNLi0iVhcEDo72+bmOSym6EYYqGe8i2lWnwKiiGpidyDe0brWMoSecSRIlu3r6yZTctTFvVIOTjcvuoUlfL9ePTfyQZ+0OLjqVB57R4UrQzN6RkcyYlPh7YpJpSP/QhZZYSJO3XhGYBiAnri4V5/XCMVlA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789225804; c=relaxed/simple;
	bh=eBxf0jN/BofyAEUPu/ShIi4CzGy5kB74x6e6cK2wVdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZWWelHiqTroeC6o9I+dudxhEqnR7zwM7xf4/ge7GINDA54EIIQ+2PQuXtLoD3ulQnN4qe9gasqTGVxMHRw9dYRkhXw+qa4OV1mqWK96dbYxJzyr334sNzPkVzhzzqu7FdF+sOEyvD96mZhyMisVJnBC6xnbbdISaGUeBBj7m2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oo5d0cRL; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oo5d0cRL"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52fc0097865so49873421cf.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 08:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789225792; x=1789830592; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ycfWUguf/XxIY7p7CtJJINpUIqVgWVn4z/VyRPXg9g=;
        b=Oo5d0cRLlP9WVgnn+rW+ymk6kQED94c1/x53YdH7dOpychUiaRzyA1iBV3VvzvvMX2
         8JolTLyrVitY3/pRPvlhssSetPu3nIj5N2FogGo6Tj/154z9YmY9M4v1jENwobzwh8KQ
         Y+Q4Yif04jVyya9uN7kos/PJMXf9nBc2dmftMEaqVyeOcBjXHM+gKY6tpEpLT6R8pXWn
         j+gClRX1CTe3nSgTmB9htQPyJR16aCRbmNJd3CUt/9L7TepO6TrSy1xuMz7hJReUPyPj
         PYONGipF0WwhNUYnsHoqHrlyDjVz48/LO2f3orVKWenr8eXwgYjgVw/v/gKMXeJxiOEB
         Sr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789225792; x=1789830592;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ycfWUguf/XxIY7p7CtJJINpUIqVgWVn4z/VyRPXg9g=;
        b=mEfI7a3wgq0NQorncwcTL6gZe22SSXkw9EmWl78/6TsqtZGi7mOma/aPJ8nUgwVxVD
         uRS2q8sP36Ael7+pfh/rq5HWJNjxuPBzUcB367AFnWz/vUrpTi0dVuuMvQO9+AzJp7rX
         1BFRDuiqP4o8X5MUw84s7Wqj+0GiNowO37QsH1TY5DsaQgZuGI2CpuA4hYy/8U3uPYy4
         H2ii9s5qKUvbSMR7AYwu94gYCZTKALSElBrMPdJ33NMS1dWGFaJKs4AcQSgYIKpTvVz4
         Z96xxejcvL9pkLxxkjrmBxi/IVwaMBMkONdKlYiZ+2GWnGc5IF8v9SPTu+AQSAdJqY2n
         8PCw==
X-Forwarded-Encrypted: i=1; AKwUvByEFiHo2tnOmUXQBIQ+lt6inBlVDuRudo1cM8aQ00Y4fbwjybcMAkO9Cc75oCO3sM6AghJbMmM=@vger.kernel.org
X-Gm-Message-State: AFuF++kZvIRyUWr5Yy9UFKSb0f/XFxsPyURFAqwqQYQCA6QEVvUBk1K+
	dGHu6Fdhw72mhYEfAowMNPsTbem/PNq2sha924VUWTgh/FOul4tVn9zO5HTJG+9iswWrNTZ+hlg
	SJ8awAadqEtPd7Q==
X-Received: from qtbma3.prod.google.com ([2002:a05:622a:8603:b0:51b:fc9e:edef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1ba1:b0:530:b2e1:2f3b with SMTP id d75a77b69052e-530e81f8c8cmr42362721cf.50.1789225792354;
 Sat, 12 Sep 2026 08:09:52 -0700 (PDT)
Date: Sat, 12 Sep 2026 15:09:43 +0000
In-Reply-To: <20260912150944.3470971-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912150944.3470971-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912150944.3470971-3-edumazet@google.com>
Subject: [PATCH net 2/3] ip_gre: compute tunnel lengths absolutely instead of
 by delta
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
ip_tunnel_bind_dev() is the only writer of the device lengths.
ipgre_changelink() must then refresh on its error paths too, since the
new encapsulation is published by then.

The dev->header_ops branch is removed rather than converted:
ip_tunnel_bind_dev() does not add to dev->hard_header_len, it subtracts
it from the MTU as the inner Ethernet header.

@old_hlen survives only as a predicate telling whether the MTU became
stale, never as a difference, so it can not make the lengths drift. When
the header length does change, the MTU is now recomputed rather than
shifted, as ip_tunnel_update() already does for a link or fwmark change.

There is no memory safety issue: ip_tunnel_xmit() computes its own
headroom from ip_encap_hlen(&tunnel->encap) and calls skb_cow_head()
before pushing the encapsulation.

Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_tunnels.h |  1 +
 net/ipv4/ip_gre.c        | 46 +++++++++++++++++++++++++---------------
 net/ipv4/ip_tunnel.c     | 16 ++++++++++++++
 3 files changed, 46 insertions(+), 17 deletions(-)

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
index 40b922362a7ca4e8ee0c3ee6c0af8d4a9fdc42d3..556ebf2c5bd0d110290f2ed82ca1221dcc19c5f2 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -789,23 +789,28 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
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
-
-	if (dev->header_ops)
-		dev->hard_header_len += len;
-	else
-		dev->needed_headroom += len;
+	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen;
 
-	if (set_mtu)
-		WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - len, 68));
+	/* Only reset a MTU that the header length just invalidated, so that
+	 * a MTU configured by the user survives an unrelated change.
+	 */
+	ip_tunnel_refresh_lengths(dev, set_mtu && tunnel->hlen != old_hlen);
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags) ||
 	    (test_bit(IP_TUNNEL_CSUM_BIT, tunnel->parms.o_flags) &&
@@ -853,7 +858,7 @@ static int ipgre_tunnel_ctl(struct net_device *dev,
 		ip_tunnel_flags_copy(t->parms.o_flags, p->o_flags);
 
 		if (strcmp(dev->rtnl_link_ops->kind, "erspan"))
-			ipgre_link_update(dev, true);
+			ipgre_link_update(dev, true, t->hlen);
 	}
 
 	i_flags = gre_tnl_flags_to_gre_flags(p->i_flags);
@@ -1471,6 +1476,7 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
+	int old_hlen = t->hlen;
 	int err;
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
@@ -1482,18 +1488,24 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 
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
+	 */
+	ipgre_link_update(dev, !tb[IFLA_MTU], old_hlen);
 
-	return 0;
+	return err;
 }
 
 static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index e6bcf01411d0bcd12cc9a88e449d9283c4a83c64..6b93c1fda4948d320ec00532ebb16c700590373d 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -326,6 +326,22 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 	return mtu;
 }
 
+/* Recompute dev->needed_headroom and dev->mtu after tunnel->hlen changed.
+ *
+ * Both are derived from tunnel->hlen, so they must be recomputed from it
+ * rather than adjusted by the difference: ip_tunnel_bind_dev() is also
+ * called from ndo_init() and from ip_tunnel_update(), and a driver adding
+ * its own delta on top would double count it.
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
2.55.0.1007.g17ff1f9808-goog

