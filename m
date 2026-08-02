Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E55318EDA
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696647; cv=none; b=NXavUxPMtPf6a6Y/1LJhDbCk2wQ1Rajp3VHNf9LkvXo0oPNsmZrF7IM/RjL8ZPWW7Sm+11g9ZaeWcED0SftomhPEA4D7PrBmDm/8ayRK0XF9sbsKq7oMPbD88FQroZFT6sw1EvrpxhjGnoG9XLdvLk0uU3SJZAx75Z+Ky982t3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696647; c=relaxed/simple;
	bh=LmLCWT4/4uUD3zcPsTniG0TUvi5ybnkkWdM+sBagQP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2il9t0L3iEL4VUieEdRfIFA5DAX0nafYwYyK4ka+JX3bvOxJCICN55LFUqg2+UbAcbCoPAWQaj4QFssKErmqvpeB0aDvxLEstM0a+0teECoKrpP0k/17DYe5VJ887UFsxTTteYLA+sXbJ38H04SLeAjZ+oDZq2XePmYqqHNA8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Qz988Y7t; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Qz988Y7t"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dcbade417so2466013a91.1
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785696645; x=1786301445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UtpeFkg4AA98jetm2vO6q263mNBUF8xD1A66L1T1z0k=;
        b=Qz988Y7t6Q4wFWkXhHTaSY4mAAq3oQOCMhz0mUotKG5+iHdjoi949HDBfLW1vRW84F
         ocyzlSLHbpIraFAzBPtb82RQ17v//jeQF49k2Cf/QFGIL+TUjQcOXVt0fLQETPH05nLQ
         IW4l5DLY7jLiVXrW/Lz/vr0aBHf08eSdpzkgasU7IovZzWtV0+ZoxCoGR2vQPGMYdeYi
         6/dgTLFjdZSshRvXQ0Xxw7LR6jPcI2JXqYrq6vGNl18fd6Y/IrinejvXZw0NSZ+FLOmy
         QC3Zg39GcXAXkIAy/Y+4GVe1YVBErp9l01cyXoaNFaxneVpElpcLv2megC0VTGwAQDeX
         QjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785696645; x=1786301445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UtpeFkg4AA98jetm2vO6q263mNBUF8xD1A66L1T1z0k=;
        b=ALnOI/vJaQPqvbAxK1e60e3F8lPLc+nzvpq8d9kw2S9hV+cSutE1kC9QaBKTm/8Sv8
         NH7suTlWI7+lh9L/QofuMGWMXRH3bMrYFnWBAxhi/t7qIauDQCuzKKOcNUy4eEHK1tTO
         pG9yu8wfWHdkBHn6bbynVrQPHkokNeTnkSvfNgN1hdEtrkdX9RPK6zn+cfTiJL6elp1D
         amM/9AZp0gVArleS8F4sNY1ca5V/0un9BxOQrTZ/qlS3FGhUyRtGlFy9LIQYMLbYntFp
         go68ZOEIJIkFXEEWcvql+OzAnTOlLClkddDnAD1eO/LAo3Xn0wDvshfQXMMk9i/Fd2Bf
         oBpw==
X-Gm-Message-State: AOJu0Yx0E9UHgOueFmUos5+EzDteyHEsdx6zbd4rgrIDrTEqXZBvamTh
	5CCUFtlnaqUIljQWpfc3lkepMdGd2HHrMTfFuHpUGEje3NGg9r8PuTQrJrhZD5Q2QGDUi7cHZds
	iLzD/g+c6
X-Gm-Gg: AR+sD10NkjJ598+ybqr5/etfVBgIKaATAGUErXFz8St3001u6nsgpGqc1HhJdCCsRIw
	BMjbAGhybKvDzbwDPfz4uMu4TqiuUjYzMtKsnSKkwxkeclfr/FHxL1ayFKgF4jPgRdUCYMzqXfu
	lM3ZpAHQc+zz+qTsjay+JJNfeHm6xx6I0iSc4GiFgnkVGkyXAlMGN+dkXvAEvqPwa5L8RIZI6jZ
	Km3UMsDqcTMSnuzl8uDYbEBWSSmAAiueRM53wCKDdGkzK5qY4jqxSWkBWBCl8nu34qxWRot72HW
	5QEhQqF75uNfJl7UbrNRj/JnS9s4N8TGbKs95R8qbVsMXXCo91QriHlN4OoNzbgoJhdFoIgT4Gd
	ZQh/5nZWO1gffZ+cTIGhIA5D54FYg3So9mnylZdyq6JUipFGL0iR3KKII4O25eF1uVFRO9XfjNn
	8aA+bNWfrKJlMZm5vYQkpcwVlRvyJz57u/5CCGp121pWVtl0obHFhYDxXdH1tmn54QHoxFoA==
X-Received: by 2002:a17:90b:4c42:b0:37f:9cdf:f0ac with SMTP id 98e67ed59e1d1-38fbc4cf1b2mr7353194a91.27.1785696644698;
        Sun, 02 Aug 2026 11:50:44 -0700 (PDT)
Received: from localhost.localdomain ([115.192.251.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb29cbac9sm2961867a91.7.2026.08.02.11.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 11:50:42 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	kuniyu@google.com,
	gustavoars@kernel.org,
	runyu.xiao@seu.edu.cn,
	jlayton@kernel.org,
	michael.bommarito@gmail.com,
	kees@kernel.org,
	willemb@google.com,
	lirongqing@baidu.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v3 1/1] net: ip_tunnel: reject excessive tunnel stacking headroom
Date: Sun,  2 Aug 2026 18:49:17 +0000
Message-ID: <a25901403c69929d6f72ba802b3ab912f2adbe63.1785691607.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785691607.git.zihanx@nebusec.ai>
References: <cover.1785691607.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

raw_send_hdrinc() and rawv6_send_hdrinc() reserve LL headroom before
storing skb header offsets in 16-bit fields. If an egress device has a
very large LL_RESERVED_SPACE(), skb_reset_network_header() stores a
truncated network_header offset and the hdrincl path can later copy the
user header to the wrong location.

The reproducer creates a very deep gretap stack. Each new tunnel derives
its needed_headroom from the lower device, so the stack can grow the
resulting LL headroom beyond what skb header offsets can represent.

Reject IPv4 tunnel configurations when the computed headroom would make
LL_RESERVED_SPACE() exceed the skb header offset range needed by raw
IPv4 hdrincl. This rejects the bad tunnel stack at configuration time
instead of checking every packet in later hot paths. Keep small raw IPv4
and IPv6 hdrincl guards as a final bound check for devices that are not
created through the IPv4 tunnel control path.

Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v3:
  - Rework the fix to reject excessive IPv4 tunnel headroom at
    configuration time, following Willem de Bruijn's feedback.
  - Drop the broad skb/XFRM/GSO/ESP/IPTFS runtime checked-helper changes
    from v2.
  - Keep only small raw hdrincl guards as a final bound check.
  - v2 Link: https://lore.kernel.org/all/cover.1785529351.git.zihanx@nebusec.ai/
changes in v2:
  - Keep skb_segment() default error code after successful checked skb offset
    updates to avoid returning ERR_PTR(0), as reported by the kernel test
    robot.
  - Extend the checked update coverage to XFRM, ESP offload, and IPTFS
    transport-header recomputation paths instead of relying on raw hdrincl
    entry guards alone.
  - v1 Link: https://lore.kernel.org/all/cover.1785346409.git.zihanx@nebusec.ai/
---
 include/net/ip_tunnels.h |   5 +-
 net/ipv4/ip_gre.c        |   8 +--
 net/ipv4/ip_tunnel.c     | 138 ++++++++++++++++++++++++++-------------
 net/ipv4/ip_vti.c        |   4 +-
 net/ipv4/ipip.c          |   4 +-
 net/ipv4/raw.c           |   3 +
 net/ipv6/raw.c           |   4 ++
 7 files changed, 111 insertions(+), 55 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index d708b66e5..0102fe387 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -425,10 +425,11 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  const struct tnl_ptk_info *tpi, struct metadata_dst *tun_dst,
 		  bool log_ecn_error);
 int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
-			 struct ip_tunnel_parm_kern *p, __u32 fwmark);
+			 struct ip_tunnel_parm_kern *p, __u32 fwmark,
+			 struct netlink_ext_ack *extack);
 int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
-		      __u32 fwmark);
+		      __u32 fwmark, struct netlink_ext_ack *extack);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
 
 bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 0ba1e94e9..6907688d0 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1424,7 +1424,7 @@ static int ipgre_newlink(struct net_device *dev,
 	if (err < 0)
 		return err;
 	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
-				 fwmark);
+				 fwmark, extack);
 }
 
 static int erspan_newlink(struct net_device *dev,
@@ -1445,7 +1445,7 @@ static int erspan_newlink(struct net_device *dev,
 	if (err)
 		return err;
 	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
-				 fwmark);
+				 fwmark, extack);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1468,7 +1468,7 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err < 0)
 		return err;
 
-	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
+	err = ip_tunnel_changelink(dev, tb, &p, fwmark, extack);
 	if (err < 0)
 		return err;
 
@@ -1500,7 +1500,7 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err < 0)
 		return err;
 
-	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
+	err = ip_tunnel_changelink(dev, tb, &p, fwmark, extack);
 	if (err < 0)
 		return err;
 
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9d114bd57..5e4f56c0e 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/skbuff.h>
@@ -277,16 +278,31 @@ static struct net_device *__ip_tunnel_create(struct net *net,
 	return ERR_PTR(err);
 }
 
-static int ip_tunnel_bind_dev(struct net_device *dev)
+static bool ip_tunnel_headroom_too_large(const struct net_device *dev,
+					 unsigned int needed_headroom)
+{
+	unsigned int hlen;
+
+	hlen = ((dev->hard_header_len + needed_headroom) &
+		~(HH_DATA_MOD - 1)) + HH_DATA_MOD;
+
+	return hlen >= U16_MAX - (sizeof(struct iphdr) + MAX_IPOPTLEN);
+}
+
+static int ip_tunnel_calc_dev_config(struct net_device *dev,
+				     const struct ip_tunnel_parm_kern *parms,
+				     __u32 fwmark,
+				     unsigned int *needed_headroom,
+				     int *mtu,
+				     struct netlink_ext_ack *extack)
 {
 	struct net_device *tdev = NULL;
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	const struct iphdr *iph;
+	const struct iphdr *iph = &parms->iph;
 	int hlen = LL_MAX_HEADER;
-	int mtu = ETH_DATA_LEN;
 	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 
-	iph = &tunnel->parms.iph;
+	*mtu = ETH_DATA_LEN;
 
 	/* Guess output device to choose reasonable mtu and needed_headroom */
 	if (iph->daddr) {
@@ -294,36 +310,58 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 		struct rtable *rt;
 
 		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
-				    iph->saddr, tunnel->parms.o_key,
+				    iph->saddr, parms->o_key,
 				    iph->tos & INET_DSCP_MASK, tunnel->net,
-				    tunnel->parms.link, tunnel->fwmark, 0, 0);
+				    parms->link, fwmark, 0, 0);
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
 		if (!IS_ERR(rt)) {
 			tdev = rt->dst.dev;
 			ip_rt_put(rt);
 		}
-		if (dev->type != ARPHRD_ETHER)
-			dev->flags |= IFF_POINTOPOINT;
-
-		dst_cache_reset(&tunnel->dst_cache);
 	}
 
-	if (!tdev && tunnel->parms.link)
-		tdev = __dev_get_by_index(tunnel->net, tunnel->parms.link);
+	if (!tdev && parms->link)
+		tdev = __dev_get_by_index(tunnel->net, parms->link);
 
 	if (tdev) {
 		hlen = tdev->hard_header_len + tdev->needed_headroom;
-		mtu = min(tdev->mtu, IP_MAX_MTU);
+		*mtu = min(tdev->mtu, IP_MAX_MTU);
+	}
+
+	*needed_headroom = t_hlen + hlen;
+	if (ip_tunnel_headroom_too_large(dev, *needed_headroom)) {
+		NL_SET_ERR_MSG(extack, "tunnel headroom exceeds skb header offset limit");
+		return -E2BIG;
 	}
 
-	dev->needed_headroom = t_hlen + hlen;
-	mtu -= t_hlen + (dev->type == ARPHRD_ETHER ? dev->hard_header_len : 0);
+	*mtu -= t_hlen + (dev->type == ARPHRD_ETHER ? dev->hard_header_len : 0);
+	if (*mtu < IPV4_MIN_MTU)
+		*mtu = IPV4_MIN_MTU;
 
-	if (mtu < IPV4_MIN_MTU)
-		mtu = IPV4_MIN_MTU;
+	return 0;
+}
+
+static int ip_tunnel_bind_dev(struct net_device *dev, int *mtu,
+			      struct netlink_ext_ack *extack)
+{
+	struct ip_tunnel *tunnel = netdev_priv(dev);
+	unsigned int needed_headroom;
+	int err;
+
+	err = ip_tunnel_calc_dev_config(dev, &tunnel->parms, tunnel->fwmark,
+					&needed_headroom, mtu, extack);
+	if (err)
+		return err;
+
+	if (tunnel->parms.iph.daddr) {
+		if (dev->type != ARPHRD_ETHER)
+			dev->flags |= IFF_POINTOPOINT;
+		dst_cache_reset(&tunnel->dst_cache);
+	}
+	dev->needed_headroom = needed_headroom;
 
-	return mtu;
+	return 0;
 }
 
 static struct ip_tunnel *ip_tunnel_create(struct net *net,
@@ -340,7 +378,9 @@ static struct ip_tunnel *ip_tunnel_create(struct net *net,
 	if (IS_ERR(dev))
 		return ERR_CAST(dev);
 
-	mtu = ip_tunnel_bind_dev(dev);
+	err = ip_tunnel_bind_dev(dev, &mtu, NULL);
+	if (err)
+		goto err_dev_set_mtu;
 	err = dev_set_mtu(dev, mtu);
 	if (err)
 		goto err_dev_set_mtu;
@@ -859,13 +899,20 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_xmit);
 
-static void ip_tunnel_update(struct ip_tunnel_net *itn,
-			     struct ip_tunnel *t,
-			     struct net_device *dev,
-			     struct ip_tunnel_parm_kern *p,
-			     bool set_mtu,
-			     __u32 fwmark)
+static int ip_tunnel_update(struct ip_tunnel_net *itn,
+			    struct ip_tunnel *t, struct net_device *dev,
+			    struct ip_tunnel_parm_kern *p, bool set_mtu,
+			    __u32 fwmark, struct netlink_ext_ack *extack)
 {
+	unsigned int needed_headroom;
+	int mtu;
+	int err;
+
+	err = ip_tunnel_calc_dev_config(dev, p, fwmark, &needed_headroom,
+					&mtu, extack);
+	if (err)
+		return err;
+
 	ip_tunnel_del(itn, t);
 	t->parms.iph.saddr = p->iph.saddr;
 	t->parms.iph.daddr = p->iph.daddr;
@@ -880,18 +927,15 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
 	t->parms.iph.ttl = p->iph.ttl;
 	t->parms.iph.tos = p->iph.tos;
 	t->parms.iph.frag_off = p->iph.frag_off;
-
-	if (t->parms.link != p->link || t->fwmark != fwmark) {
-		int mtu;
-
-		WRITE_ONCE(t->parms.link, p->link);
-		t->fwmark = fwmark;
-		mtu = ip_tunnel_bind_dev(dev);
-		if (set_mtu)
-			WRITE_ONCE(dev->mtu, mtu);
-	}
+	WRITE_ONCE(t->parms.link, p->link);
+	t->fwmark = fwmark;
+	dev->needed_headroom = needed_headroom;
+	if (set_mtu)
+		WRITE_ONCE(dev->mtu, mtu);
 	dst_cache_reset(&t->dst_cache);
 	netdev_state_change(dev);
+
+	return 0;
 }
 
 int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
@@ -962,8 +1006,7 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 		}
 
 		if (t) {
-			err = 0;
-			ip_tunnel_update(itn, t, dev, p, true, 0);
+			err = ip_tunnel_update(itn, t, dev, p, true, 0, NULL);
 		} else {
 			err = -ENOENT;
 		}
@@ -1128,6 +1171,7 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 	struct ip_tunnel_net *itn = net_generic(net, ip_tnl_net_id);
 	struct ip_tunnel_parm_kern parms;
 	unsigned int i;
+	int mtu;
 
 	itn->rtnl_link_ops = ops;
 	for (i = 0; i < IP_TNL_HASH_SIZE; i++)
@@ -1153,9 +1197,11 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 	 */
 	if (!IS_ERR(itn->fb_tunnel_dev)) {
 		itn->fb_tunnel_dev->netns_immutable = true;
-		itn->fb_tunnel_dev->mtu = ip_tunnel_bind_dev(itn->fb_tunnel_dev);
-		ip_tunnel_add(itn, netdev_priv(itn->fb_tunnel_dev));
-		itn->type = itn->fb_tunnel_dev->type;
+		if (!ip_tunnel_bind_dev(itn->fb_tunnel_dev, &mtu, NULL)) {
+			itn->fb_tunnel_dev->mtu = mtu;
+			ip_tunnel_add(itn, netdev_priv(itn->fb_tunnel_dev));
+			itn->type = itn->fb_tunnel_dev->type;
+		}
 	}
 	rtnl_unlock();
 
@@ -1194,7 +1240,7 @@ EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);
 
 int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
-		      __u32 fwmark)
+		      __u32 fwmark, struct netlink_ext_ack *extack)
 {
 	struct ip_tunnel *nt;
 	struct ip_tunnel_net *itn;
@@ -1222,7 +1268,9 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 	if (dev->type == ARPHRD_ETHER && !tb[IFLA_ADDRESS])
 		eth_hw_addr_random(dev);
 
-	mtu = ip_tunnel_bind_dev(dev);
+	err = ip_tunnel_bind_dev(dev, &mtu, extack);
+	if (err)
+		goto err_dev_set_mtu;
 	if (tb[IFLA_MTU]) {
 		unsigned int max = IP_MAX_MTU - (nt->hlen + sizeof(struct iphdr));
 
@@ -1247,7 +1295,8 @@ int ip_tunnel_newlink(struct net *net, struct net_device *dev,
 EXPORT_SYMBOL_GPL(ip_tunnel_newlink);
 
 int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
-			 struct ip_tunnel_parm_kern *p, __u32 fwmark)
+			 struct ip_tunnel_parm_kern *p, __u32 fwmark,
+			 struct netlink_ext_ack *extack)
 {
 	struct ip_tunnel *t;
 	struct ip_tunnel *tunnel = netdev_priv(dev);
@@ -1279,8 +1328,7 @@ int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 		}
 	}
 
-	ip_tunnel_update(itn, t, dev, p, !tb[IFLA_MTU], fwmark);
-	return 0;
+	return ip_tunnel_update(itn, t, dev, p, !tb[IFLA_MTU], fwmark, extack);
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_changelink);
 
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 3b8092999..18b6382b4 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -585,7 +585,7 @@ static int vti_newlink(struct net_device *dev,
 
 	vti_netlink_parms(data, &parms, &fwmark);
 	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb,
-				 &parms, fwmark);
+				 &parms, fwmark, extack);
 }
 
 static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -600,7 +600,7 @@ static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
 		return -EPERM;
 
 	vti_netlink_parms(data, &p, &fwmark);
-	return ip_tunnel_changelink(dev, tb, &p, fwmark);
+	return ip_tunnel_changelink(dev, tb, &p, fwmark, extack);
 }
 
 static size_t vti_get_size(const struct net_device *dev)
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index b643194f5..1684a81a9 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -481,7 +481,7 @@ static int ipip_newlink(struct net_device *dev,
 
 	ipip_netlink_parms(data, &p, &t->collect_md, &fwmark);
 	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
-				 fwmark);
+				 fwmark, extack);
 }
 
 static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -512,7 +512,7 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	    (!(dev->flags & IFF_POINTOPOINT) && p.iph.daddr))
 		return -EINVAL;
 
-	return ip_tunnel_changelink(dev, tb, &p, fwmark);
+	return ip_tunnel_changelink(dev, tb, &p, fwmark, extack);
 }
 
 static size_t ipip_get_size(const struct net_device *dev)
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 7f74d8b95..8e6e8c684 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -43,6 +43,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/sockios.h>
@@ -356,6 +357,8 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 		goto out;
 
 	hlen = LL_RESERVED_SPACE(rt->dst.dev);
+	if (hlen >= U16_MAX - (sizeof(struct iphdr) + MAX_IPOPTLEN))
+		return -EINVAL;
 	tlen = rt->dst.dev->needed_tailroom;
 	skb = sock_alloc_send_skb(sk,
 				  length + hlen + tlen + 15,
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index b88d364e7..fa223ec02 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/socket.h>
 #include <linux/slab.h>
@@ -613,6 +614,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	if (flags&MSG_PROBE)
 		goto out;
 
+	if (hlen >= U16_MAX)
+		return -EINVAL;
+
 	skb = sock_alloc_send_skb(sk,
 				  length + hlen + tlen + 15,
 				  flags & MSG_DONTWAIT, &err);
-- 
2.43.0

