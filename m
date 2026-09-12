Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078273328FC
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789225803; cv=none; b=ev4ruJZl4NNYzKfaJe6yZPFHbuYAxcfuIfJ3hNh/oNzLXLr8pa8F7sZzg3MbQv3LdnXrtR2kp44ohIObuLMLreuLYhgfQkQMRDf9d+KM+s/v65iKc7OYJ3AcPiJ4Sbe2AGqsNVZv/HxcFz0XxPQLkjRoUTrroods9EzUlCjzRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789225803; c=relaxed/simple;
	bh=tbrl60uVVIb38iWU4/g4721SHquWhWkkOC0sYtGW6NA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QJTKEiNz5sisZGuntxHyEqB5prQNy3/nIyVo/EgCFv3C6rwoJoRazZYjtxcNC1xgLuFOotiZfV0FjLkiOQxWTMB0h9L1IK277A45jsZiHEYwek5FG8LsrFgzQP4sexBHJQ7N2fGEd9JW+Iu7MdrBgj0KuQxgiVNpxFgLyJ+b12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBnkXk9K; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBnkXk9K"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52fc0097865so49873711cf.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789225794; x=1789830594; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g98rJEZGXFnLqAYmu7xZefyz0ccbDNajQ7WMQNRACFU=;
        b=qBnkXk9KWa5TYo4rc3i9MeAfHpbMlv27Abs0LPL1a4A9GhzxyNy4M4rDBknERNb8TU
         cUU+NIpDwCf3enLAPkSWlISLvoiD63N1PpxERLfZU6q1H1tiyx3bfxP7uLUsBT7CGeln
         ddAm5M78M0CvMs7xTHbsaELYuXchyDVYinEdclDAJE7PsIIY5KqvALAAC4J4ou1u4gJ6
         3EEnsvBYl8fELAlpIaLQ+nwug5m+g1CPH+ettGbogD7DamkSAFg0b1Hjlvo/tUdieDqt
         H7+7yO+Y4To0idHpBdl4Smq2Kt2qEWBWow4a8tR4CdQyLzMuqQEd8029ffmmgTGlhDrG
         NGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789225794; x=1789830594;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g98rJEZGXFnLqAYmu7xZefyz0ccbDNajQ7WMQNRACFU=;
        b=JbM1NDPkdLUejvpfodUFSlXgBZDDsyDCYO4/Sc6p9GjEAJi/D1cj6f3BZkkYKt04xr
         AGSjhWmVZTxa5TXhqNH8KHq920DwupB9Lz2vyjmuWQZNe3A+Tap9lHR0EBaPoDV69k2R
         C37OD59hoXBCgcIJxSMAm8SAGVaypVdeUh6mOUhVk6aeqwMp/Vk3T0DOKLmwa6wG3ql0
         3D26HaKsv1gjfFKK1DjGl5jORGr/Ps1zQUkxsqXJe5udMNMvW0vi6fqKp6JwLBYCgSNi
         TnGC4LGWrtqsDEFdGRbKntNTw31eawQZDm3PwdGYmIXCoK6K3svGPTtVCprXlqzZg7nv
         dkMA==
X-Forwarded-Encrypted: i=1; AKwUvByoY0QgPZRhn34NXD+HurKe+iSdvUB2jH8Y1mlny4s09Prrr03U22sUZfyCEpzJ7L5voW42d+Y=@vger.kernel.org
X-Gm-Message-State: AFuF++klYM0SXrs+wtleKPgschI5dqKjPwqjd7C03/t/v5ApOots13bo
	KlQQYWCMlOv5Ou7mTIKbVES2fIcMYbdQcTux7qHy3R++K3b8qPruw+Y3+1jQCuInS1PbHUZMII5
	izVHE+DeuDh/WOw==
X-Received: from qtvl15.prod.google.com ([2002:ac8:4ccf:0:b0:530:67b6:cba8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:15c4:b0:52f:b6a8:9e56 with SMTP id d75a77b69052e-530e7dd98bdmr45362301cf.19.1789225793769;
 Sat, 12 Sep 2026 08:09:53 -0700 (PDT)
Date: Sat, 12 Sep 2026 15:09:44 +0000
In-Reply-To: <20260912150944.3470971-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912150944.3470971-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912150944.3470971-4-edumazet@google.com>
Subject: [PATCH net 3/3] ip_gre: recompute erspan header lengths after a change
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

erspan_tunnel_init() is the only place computing tunnel->tun_hlen and
tunnel->hlen, but erspan_changelink() can change both: tunnel->erspan_ver
selects a 4 or 8 byte GRE header and feeds erspan_hdr_len(), while
ip_tunnel_encap_setup() recomputes tunnel->hlen without the ERSPAN part.

dev->needed_headroom is not refreshed either, since ip_tunnel_update()
only rebinds when the link or the fwmark changes.

erspan_xmit() calls skb_cow_head(skb, dev->needed_headroom) before
erspan_build_header[_v2]() pushes the header. Going from version 0 to
version 2 adds 20 bytes, so a packet with little headroom can hit
skb_under_panic().

Move the computation into erspan_set_hlen() and add
erspan_link_update(), refreshing the lengths as the previous patch does
for plain GRE. It runs before the erspan_netlink_parms() error check and
before ip_tunnel_changelink(), because the new version is committed by
then and erspan_xmit() sizes its push from it.

Fixes: f551c91de262 ("net: erspan: introduce erspan v2 for ip_gre")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_gre.c | 48 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 556ebf2c5bd0d110290f2ed82ca1221dcc19c5f2..4807fc6d2fd886621480dcff20f8691ec32c67bc 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1368,18 +1368,43 @@ static const struct net_device_ops gre_tap_netdev_ops = {
 	.ndo_fill_metadata_dst	= gre_fill_metadata_dst,
 };
 
+static void erspan_set_hlen(struct ip_tunnel *tunnel)
+{
+	/* Version 0 uses a 4-byte GRE header, other versions use 8 bytes. */
+	tunnel->tun_hlen = tunnel->erspan_ver == 0 ? 4 : 8;
+
+	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
+		       erspan_hdr_len(tunnel->erspan_ver);
+}
+
+/* Both tunnel->erspan_ver and tunnel->encap_hlen can be changed from
+ * erspan_changelink(), and both feed tunnel->hlen. Recompute it, then let
+ * ip_tunnel_bind_dev() derive the device lengths from it.
+ *
+ * As in ipgre_link_update(), @old_hlen only tells whether the MTU became
+ * stale and must be sampled before ip_tunnel_encap_setup(), which
+ * recomputes tunnel->hlen without the ERSPAN part.
+ */
+static void erspan_link_update(struct net_device *dev, bool set_mtu,
+			       int old_hlen)
+{
+	struct ip_tunnel *tunnel = netdev_priv(dev);
+
+	erspan_set_hlen(tunnel);
+
+	/* Only reset a MTU that the header length just invalidated, so that
+	 * a MTU configured by the user survives an unrelated change.
+	 */
+	ip_tunnel_refresh_lengths(dev, set_mtu && tunnel->hlen != old_hlen);
+}
+
 static int erspan_tunnel_init(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 
-	if (tunnel->erspan_ver == 0)
-		tunnel->tun_hlen = 4; /* 4-byte GRE hdr. */
-	else
-		tunnel->tun_hlen = 8; /* 8-byte GRE hdr. */
+	erspan_set_hlen(tunnel);
 
 	tunnel->parms.iph.protocol = IPPROTO_GRE;
-	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
-		       erspan_hdr_len(tunnel->erspan_ver);
 
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
@@ -1515,6 +1540,7 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
+	int old_hlen = t->hlen;
 	int err;
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
@@ -1525,6 +1551,16 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 		return err;
 
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
+
+	/* ipgre_newlink_encap_setup() has published a new encapsulation, and
+	 * erspan_netlink_parms() a new ERSPAN version, both of which change
+	 * the header length. Refresh the lengths before looking at @err:
+	 * erspan_xmit() sizes its push from tunnel->erspan_ver, and both this
+	 * error path and ip_tunnel_changelink() below leave the new
+	 * encapsulation behind.
+	 */
+	erspan_link_update(dev, !tb[IFLA_MTU], old_hlen);
+
 	if (err < 0)
 		return err;
 
-- 
2.55.0.1007.g17ff1f9808-goog

