Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2744CDA12
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552939; cv=none; b=NOu52tWOriQdA0khduYXg5Dla4ja6eXRvn53LzyGyQWCF83YtqZEIt8571jznzRlSH3Dn6d0r40maFLFdAX18oKaYLmR8WqAI7dPxmEv/jRDaD45KbuPqaXPNOLt8yyiXPZuy/Ihn+21RpKb8yfTEJXGla1Eea6aIcrfED00q1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552939; c=relaxed/simple;
	bh=cL02XNhA0Qpv1RQiCddi0WtgtVLX6jx8XwbLJe84qOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aoo3q8wh+QbHXYclOancJpRs2FovB69q2nfth5CQNJen9bPqu4ifahm68PsoDH85CEbPZpGc6NsrLt6XHc2jmQFQOm2vkQcHy+OC6a1NfiSPjCZ5Fs2EJVtHO5jekIFKtA97O4sIcGRvz3RUsovmJ8wbsVvws9JfJm6wQvnetKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tuy2YPIE; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tuy2YPIE"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939a6937513so841521685a.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789552920; x=1790157720; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tIZwlsRXDD4C2O8AXHBN8LkhFvT/X2waCRAxyzi8zfM=;
        b=Tuy2YPIESKuRpT7gVimHZUzblq36L6aymT/3jMawAlJ0V10vwxhbW42ZelDC6EbtSD
         M4xdp1mpwrFPzQLUHP0aoDCr3WqqyJL8li03dcjQxFxD3Bf7Kfos3pZqXt7Kh9gNONoQ
         ynsT3rHRsXgcjsJlhpjgb/fnzVszApgbl/Hc/SOe1sZagJLxsNwJYUeERJdHHLoUkdCR
         Tp7YOneBKv1yo+/lYM72Ay3KQ6ZQJeE+BKRuY5PlMJPG8vsl4U+0Iy9J7Pmqm8ONgWUC
         BVQRYrqzBGrWS6BOpC8dcWIcmeCu7lpuNtIJOSa+DYjpKnoQNBZQA4u1dVS0qqt/5vmc
         ZEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552920; x=1790157720;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tIZwlsRXDD4C2O8AXHBN8LkhFvT/X2waCRAxyzi8zfM=;
        b=UNycE4DJb/D4rwdOyAzl0+HGaYtf/zJy1a8pBslKRZo3f1RIr5H8diFdL1OJ8n8Rdg
         W383l0uidLYNsGZKiSQpEqsKJrU2HQZIcarXxn3m1+1rnUHLGudPV7sQPc46nLle6u3K
         MGJjh9NNIpwRXBEe3MphbjezwHICASN46SEFDlz9xFVfeaf/JwWtYT9IgqYhAz07/F/7
         DaYVqpE2ZuXXzatrkjHNoHWbT1dj1Hijh5MsXqJE15gxc16thxNI8dXmy7dOiyvSizca
         iygftIwb88jWQbuwysaXMVuD57wVQ4wInM/hcUuro+Wk7slMoiJzZMUfWvoUfgXDz+oB
         donA==
X-Forwarded-Encrypted: i=1; AKwUvBzy41GzV0uK2RUy3roj2bqutbJZRHC6Z0RzWBP992itzauzbH5dSTkOBEdFtHt6hvtRFBtTPNE=@vger.kernel.org
X-Gm-Message-State: AFuF++no9M28tnhX8Xq10kNiLkeTHIFosCKC0k5kn9uY8PrAlJXzOSHq
	fEL5w5Z/iA7HMBWAhzSxvDT+YWH4mABWfgIHq1KsAsqxEjXL+YvNN+rMTi4qlXlCPV0iG6kHXsS
	RoRoFl6Idn8/14w==
X-Received: from qknua5.prod.google.com ([2002:a05:620a:6985:b0:93a:1ae5:1616])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:44c4:b0:939:4b31:4669 with SMTP id af79cd13be357-93bb78819fdmr279981185a.29.1789552919725;
 Wed, 16 Sep 2026 03:01:59 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:01:54 +0000
In-Reply-To: <20260916100155.1398403-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912150944.3470971-1-edumazet@google.com> <20260916100155.1398403-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916100155.1398403-5-edumazet@google.com>
Subject: [PATCH net v2 4/5] ip_gre: recompute erspan header lengths after a change
From: Eric Dumazet <edumazet@google.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

erspan_tunnel_init() is the only place computing tunnel->tun_hlen and
tunnel->hlen, but erspan_changelink() can change both: tunnel->erspan_ver
selects a 4 or 8 byte GRE header and feeds erspan_hdr_len(), while
ip_tunnel_encap_setup() recomputes tunnel->hlen without the ERSPAN part.

dev->needed_headroom is not refreshed either, since ip_tunnel_update()
only rebinds when the link or the fwmark changes.

erspan_xmit() then pushes an ERSPAN header sized from the new
tunnel->erspan_ver, while __gre_xmit() lays the GRE header out from the
stale tunnel->tun_hlen. After a version 0 -> 2 change, tun_hlen is still
4 and gre_build_header() writes the sequence number at
greh + tun_hlen - 4, that is over greh->flags and greh->protocol. The
MTU keeps the value derived from the old header length.

There is no memory safety issue: dev->needed_headroom is at least
tunnel->hlen + sizeof(struct iphdr), and erspan_xmit() pushes at most
12 + 8 bytes before ip_tunnel_xmit() takes over and cows again.

Move the computation into erspan_set_hlen() and add
erspan_link_update(), refreshing the lengths as the previous patch does
for plain GRE. Call erspan_set_hlen() before ip_tunnel_changelink() so
that ip_tunnel_update() sees the updated tunnel->hlen and erspan_xmit()
sees a matching tun_hlen, and run erspan_link_update() at the end of
erspan_changelink(), including on error paths, as ipgre_changelink()
does.

Fixes: f551c91de262 ("net: erspan: introduce erspan v2 for ip_gre")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_gre.c | 57 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index ced57cbeaad4991487e9ddb29fa18ae6a1f134fb..696884f53cdcc65fe87cf04f357f1cc45a7e0736 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1379,18 +1379,43 @@ static const struct net_device_ops gre_tap_netdev_ops = {
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
@@ -1529,6 +1554,7 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
+	int old_hlen = t->hlen;
 	int err;
 
 	if (!rtnl_dev_link_net_capable(dev, t->net))
@@ -1540,16 +1566,29 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
-		return err;
+		goto link_update;
+
+	erspan_set_hlen(t);
 
 	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
 	if (err < 0)
-		return err;
+		goto link_update;
 
 	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
 	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);
 
-	return 0;
+link_update:
+	/* ipgre_newlink_encap_setup() has published a new encapsulation, and
+	 * erspan_netlink_parms() a new ERSPAN version, both of which change
+	 * the header length. Refresh the lengths on the error paths as well,
+	 * since both leave the new encapsulation or version behind.
+	 *
+	 * As in ipgre_changelink(), IFLA_MTU must not hold the MTU back if we
+	 * return an error, because do_setlink() will not apply it then.
+	 */
+	erspan_link_update(dev, err || !tb[IFLA_MTU], old_hlen);
+
+	return err;
 }
 
 static size_t ipgre_get_size(const struct net_device *dev)
-- 
2.55.0.1032.g73a4cd73de-goog

