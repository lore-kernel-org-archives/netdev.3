Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6D437F8D7
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789254050; cv=none; b=Z8KsneT5dj9vvAtCpzjbi3BxtDiwgi+VaP84hSuqLhygYyihzK0wC8LMfeO0pvF2JK8x/oCp2tC2ZvcErD6/3M3wHUbiKc03ZZHjQM1dq9JtNLcSD18jAYFA6YLxjJJCLuJY3w9JarPJE10EQQ/UAfkTSrOE3xENhx+mpYlMq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789254050; c=relaxed/simple;
	bh=fAfeJLoXmLR7P8s9DMIF0Km2jydAPfxlZiF3lM06MmY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bGjPt1tOCcLNLp4YSYL8CtG55DRLgPwJLegdeZqeptz9iFX3gWqAuap2WE5yvcyfEoid2GWJ9r/pSXRXA/7/K7GJdxKBGuprDgpYQYlz4xk11Eejvkzde+b3cio6V1Z47JrgE/LIzyWFHLj7gEbj1tQzTcloiESgbuNcJ7USMVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwkTW+dT; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwkTW+dT"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39af92138f9so3709631a91.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 16:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789254048; x=1789858848; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hT7lXcg6p/xgiN/2CBnuaKb6PyHDiPvivVNh4BJjij0=;
        b=mwkTW+dT18uHgIBhL7bol096OfMuXQbXzzTyde5razUMnDhVq7za/0UGwVvvNxdYLF
         nofNo67+iH1J9B9FK3c9pll6SmKAF8fa3fwDKp8Wk6LbEHwkecp62pp8XUHVCLHTHczz
         SvmNlgQI5zqDUFmLV3a00/XKZ0RxSbcfep4Pd4Tqbfdg1xdkWIF2eJL7V/RxwXKFasth
         apVOAvSW45KVaZbU+M5Gq/tTzusjUlWv7dXDR09IZKhyr6suuvRtHAvsmLRhlukPdAeM
         MJRHDn5lVcX2kZIjJwCdPXf+KsKlMcP4GNbquHha8rkt0D4O0QDwVj2uGqVcCgyR5NUM
         QiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789254048; x=1789858848;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hT7lXcg6p/xgiN/2CBnuaKb6PyHDiPvivVNh4BJjij0=;
        b=mpcGFKeAk+lkGsP4X/rF5yLfQS8SedKh40tytKKbkp73xXIxo1KIP+qOaintRKnDe8
         0z/2frMyeBPRXKuAt4B26EGfUdEGWO5PRA97EJY63BAnfLsVgPmW2JTVIexOdfldEm9S
         tdUgFpEheXMkMHkqb22lhwRPyzB4YfZ1U+2TQ6skU51k1Mi+M6501H89mM05pXkNOMPO
         7k5cuV14IthCi/HuWlxT87cj0sL/zatHgqN3JhSJcueaBmzpgYXmT8HG7qtVskwyc2Wn
         KNCouBZPTHZm65jtX03HWslb6k0Y1OLhHQoh3wTc+SMM4FcMfID6rAXLofHxUTOnbW93
         qL5w==
X-Forwarded-Encrypted: i=1; AKwUvBzYWVb8cpkzuisEzb4U+JiTXtbg7rIRpEMNnrf5uKHF+8Pj3sgUuClatbjOa1j9SvQ64WFV8jE=@vger.kernel.org
X-Gm-Message-State: AFuF++lxv1VTfjK/4+xLc36KIKK1VwDo0StaEg6jv85gYfkeUjKd8OI/
	crCNihbdtamwQ4vMHxFoTnzBrHnjNSjDWicXV/cXtvA+KtxRaz5IXWOynKp6B0c6InlMhX4uTOX
	Yv2eIvg==
X-Received: from pjtz9.prod.google.com ([2002:a17:90a:cb09:b0:39d:9ae6:6e56])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5387:b0:398:baa7:4c2f
 with SMTP id 98e67ed59e1d1-39dd555a7f0mr137684a91.5.1789254048127; Sat, 12
 Sep 2026 16:00:48 -0700 (PDT)
Date: Sat, 12 Sep 2026 23:00:29 +0000
In-Reply-To: <20260912230043.2586313-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912230043.2586313-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912230043.2586313-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 3/7] ip_tunnel: Don't pass rtnl_link_ops to ip_tunnel_delete_net().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip_tunnel_delete_net() no longer uses the 3rd argument,
struct rtnl_link_ops *ops.

Let's remove it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip_tunnels.h | 1 -
 net/ipv4/ip_gre.c        | 6 +++---
 net/ipv4/ip_tunnel.c     | 1 -
 net/ipv4/ip_vti.c        | 2 +-
 net/ipv4/ipip.c          | 2 +-
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index be4cc10f88ed..a78dfbb98044 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -401,7 +401,6 @@ int ip_tunnel_get_iflink(const struct net_device *dev);
 int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 		       struct rtnl_link_ops *ops, char *devname);
 void ip_tunnel_delete_net(struct net *net, unsigned int id,
-			  struct rtnl_link_ops *ops,
 			  struct list_head *dev_to_kill);
 
 void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 82309efd417e..5e877018e006 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1084,7 +1084,7 @@ static int __net_init ipgre_init_net(struct net *net)
 static void __net_exit ipgre_exit_rtnl(struct net *net,
 				       struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_net(net, ipgre_net_id, &ipgre_link_ops, dev_to_kill);
+	ip_tunnel_delete_net(net, ipgre_net_id, dev_to_kill);
 }
 
 static struct pernet_operations ipgre_net_ops = {
@@ -1728,7 +1728,7 @@ static int __net_init ipgre_tap_init_net(struct net *net)
 static void __net_exit ipgre_tap_exit_rtnl(struct net *net,
 					   struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_net(net, gre_tap_net_id, &ipgre_tap_ops, dev_to_kill);
+	ip_tunnel_delete_net(net, gre_tap_net_id, dev_to_kill);
 }
 
 static struct pernet_operations ipgre_tap_net_ops = {
@@ -1747,7 +1747,7 @@ static int __net_init erspan_init_net(struct net *net)
 static void __net_exit erspan_exit_rtnl(struct net *net,
 					struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_net(net, erspan_net_id, &erspan_link_ops, dev_to_kill);
+	ip_tunnel_delete_net(net, erspan_net_id, dev_to_kill);
 }
 
 static struct pernet_operations erspan_net_ops = {
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index d74200ab5762..e6bbc5e4c357 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1149,7 +1149,6 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 EXPORT_SYMBOL_GPL(ip_tunnel_init_net);
 
 void ip_tunnel_delete_net(struct net *net, unsigned int id,
-			  struct rtnl_link_ops *ops,
 			  struct list_head *head)
 {
 	struct ip_tunnel_net *itn = net_generic(net, id);
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 3b80929994a0..c4f14d42df24 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -526,7 +526,7 @@ static int __net_init vti_init_net(struct net *net)
 static void __net_exit vti_exit_rtnl(struct net *net,
 				     struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_net(net, vti_net_id, &vti_link_ops, dev_to_kill);
+	ip_tunnel_delete_net(net, vti_net_id, dev_to_kill);
 }
 
 static struct pernet_operations vti_net_ops = {
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index f684baf8e58f..2ffe64e736e0 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -645,7 +645,7 @@ static int __net_init ipip_init_net(struct net *net)
 static void __net_exit ipip_exit_rtnl(struct net *net,
 				      struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_net(net, ipip_net_id, &ipip_link_ops, dev_to_kill);
+	ip_tunnel_delete_net(net, ipip_net_id, dev_to_kill);
 }
 
 static struct pernet_operations ipip_net_ops = {
-- 
2.55.0.1007.g17ff1f9808-goog

