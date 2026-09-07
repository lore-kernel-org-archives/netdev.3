Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2F336884
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821938; cv=none; b=HGVySfppdqXF90WBu9etuDui8qjb34NqxKlOKyFMb6VTPdCl6NqSFrjrHY0aQBE0BLzIHWQLwNRlURqAfAYxB/tpDjbL7MyfoU7z5FnNV34rbnnimUJaXtbm6PStjJ8rSnxr7EcdIdPs0wX8XSoJg7XsDciC3aZZHizd94lm328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821938; c=relaxed/simple;
	bh=ffwWF3/YyY9uDUNl7DIeKOC3iZ0LFwQ8VGX3iR4LyFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W9mAbcCe0UTtvKJWT55iuBsP6dykfKAujNTLLZxQ/3CrXXtOmKeTd10OSFgnoRtFqEjSVO8tAjQ9No5YrDIzLwVachE9oGEHq5rbp1G9SladG2lTGG2/KedFgIx2452KKbqIM7I7PYZaZijsq1ElhkorVSTJQ1KYNN7T8gV8xIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFAhYpZ+; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFAhYpZ+"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-85602449126so875687b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 15:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788821936; x=1789426736; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K4pAIBKSwp3ppogrfD2Ya3loccy55lJwaI8+BS9o4Rw=;
        b=oFAhYpZ+jzQGBJ+J5Qq/36M90ETRjrC33eUxB3mg3ho9ZdkxzcoIYvVQRPNpFBayxb
         bjmsqi2dIzHQXEUO6Lycmy80UyFG2dH6NBBbDi51XqNomy1EzxJG0ozqGXfXL+Mq5oVM
         5KnwZgFi2forTQletwZPmhltFAN9m8ZXh9GVVX7Q35vzHB4SoyuVemfxcgx0GGQtZ7qw
         JXqlLdfQJOxJtJTMWOwqnj8sH4/x1G6y8ztrXkqvRtsno/o16in+D8JRGDE+x/G5E3iT
         1M84mSy1PMllnZeDNJWV6Mgn/KTKFDCOWfarijuGwXSI2I4LgCJMh+NYNIt+BgZfxx2S
         +kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788821936; x=1789426736;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K4pAIBKSwp3ppogrfD2Ya3loccy55lJwaI8+BS9o4Rw=;
        b=VCmPfFqbg4cmEMzwpNenLHm2GYtZTzQ+/3NBZp8u5IdDZeNcFg8uYKeZ7P2Jq9Yyoo
         YZXbsO/WBZezDJq5Z1TrirXodn5lcSD5ZiS5tyAcRNQdc5rJL5D3oZclSz9o70sKYH+D
         wY6TsoK8pDiME+6ilMeiMFwm/Ps+qiquzfc5UOzWNu3YrE7ThjK9+8g/VA3/L8SkCH3i
         U04oyMmLXb+m6ile1G9ygH3Xm3m9Ddopmur01WG3RYHbHlth+/dzMWD0sMsnad1doQcK
         fI8PHkBHptO4NR9guuXRD+xXjYpuSPB0B8eiXbhKlh1XB7y+qQij930xqxuMLWCetYh4
         nqEg==
X-Forwarded-Encrypted: i=1; AKwUvBwdaqViD+yE7EMLuB1apBBPs54f8KNPYSZVPkjV3RTHFCwktfmd5GMqEWbpPOhwRBvVfAg0O88=@vger.kernel.org
X-Gm-Message-State: AFuF++lZEWHa9wsLTYAvJ2eJfb7HGUfymJt5qxE7z6CUkZo9JkBwyCjN
	Ij7Lqbv3EsIcU55ayJEoq3Xc5Ly8zvMuJFTOQLVJgR4jsScV9q7XXaLZqYhnjAsHolk8yOxYQdW
	V3pEoxA==
X-Received: from pgdf10.prod.google.com ([2002:a05:6a02:514a:b0:cc4:4ef9:6a24])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:914d:0:b0:848:8715:c2d9
 with SMTP id d2e1a72fcca58-86169676ac8mr37073921b3a.2.1788821936242; Mon, 07
 Sep 2026 15:58:56 -0700 (PDT)
Date: Mon,  7 Sep 2026 22:56:48 +0000
In-Reply-To: <20260907225846.3787676-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907225846.3787676-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907225846.3787676-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/7] ip_tunnel: Don't pass rtnl_link_ops to ip_tunnel_delete_net().
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
index 7c9aadfe8fe3..b0f9d02a7f18 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -398,7 +398,6 @@ int ip_tunnel_get_iflink(const struct net_device *dev);
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
index d29e2ba7cdd3..1696ba1f3ed9 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1151,7 +1151,6 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
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
2.55.0.1003.g10538fe699-goog

