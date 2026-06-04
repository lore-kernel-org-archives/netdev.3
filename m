Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E98480970
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582445; cv=none; b=j8wWiUuWZliU1jnX5Z/YEivt3siQQNBMMOKVNpKj1ZB7mJPbFYq9PNZxHp3+RQxR00YMo9bnDNvV4sdQXcNkfwyvtknHBtf27Kv/4Gk6+i4pceF/SSW5L7xjF+1Gjmcvm8F4dxAmAJzaAmo16oAHqsB5ttuPoa1jC+Ufn4JZLvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582445; c=relaxed/simple;
	bh=/Wb4szO7KFT1y+eAsfpfCvhKedpKy9HOFnh5gENLCOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c+RJtPKJYEG7zuF4G6i0ibekfn1JXd8KjOMBG4CNhc8bNTw6o1kpnWg0T02dbu3zHincYM6b5QOwuxQZDre52fz2/yC6hkQcgIkEhP/tBgRY58wkjBpdSH/8t1Pt3IhxETmtLpPXq9CmwBowqarQfNxxqi11Lo9/04iV2j386NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ka3rSjtq; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ka3rSjtq"
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8ce9de04835so25621506d6.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582438; x=1781187238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc/mj9LIZxr4ZUxDfAjSCQwydR9Uuqwp5cjPUbNL/4Q=;
        b=ka3rSjtqdJ+Pm7Thzj+B9pecK2oTyQVCgpqU96KQZafs7x3j1O8A4emdlLelZW2XmR
         ipAKtDXqJJbbuP+N1QE/IfMv4pBrNRNjVya/wMGBO73kxdcFoCZuLxJhA6XZ2uAAS0/M
         sF+VDyAVUYsVOTtdFwNi6HWhzZhZw5GOy+O7kBtXsIOQL8OechBSlXWOo8RMsxNBCVt7
         mJ4MXsvCoJA8CLFiK5XLxTXWj8XTm18Ob5uVCG1Uu/TbCvAyyZkC6HtT7tdyMyYOrq0t
         fwLrfn3tgqB2FUYiEERPQA2zi4QwE5r0p6SrO8N2Eveo8i/GmOFdJSsk7jI2trjF+A5t
         uYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582438; x=1781187238;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc/mj9LIZxr4ZUxDfAjSCQwydR9Uuqwp5cjPUbNL/4Q=;
        b=QkXKyVE+CfBwx1jqwvuj5153e+5vlohWXHYl5yqa+PIiCiWnzbeRCU1Mp1ycUDjgDp
         EDE272Sc7fRWHcCATyTdRs6hqkXeiQLyndwFnLckxLJdNBKEOe7WMbkzEPYwsbWrr54A
         WeJ5WjvGk3IFYgdtAMJRnsWaRZMQ7k1lwFPaazoFhuSQCWowYNJSOQ0aAvAJhvOMxyTu
         HP1r+GSiY8eJdI7s3bTAc/jFUYxaxMba29t+cTVhE7o6hyDZUcPz1hbOO1TnX8z+FluI
         2wAmghIZkLUV8TrxfSVgrR+FOIS1E616Ce8jtKTRqa9MSBJ8+rpm9vln+3IJRjVD7bgk
         q70Q==
X-Forwarded-Encrypted: i=1; AFNElJ9CD5UtR+EfM8gJj14LYCZKmL9CxltFNnjnMQZuoxOGkPawDtS8S0APontuPjvBLyoWq+fL3qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGkbhBoo/qUi+ckSCQNMPn8OS5xFZRpBlhWeF+mb6+Ec1zvOet
	3Uj/sfL4qe8zuON3VJoDye1uTlrwpZLLbori6mpfwADf7KN9xDNT5mi7h0TVPmpKy4SH51zdufM
	BiQ3HxR8oiZ6wqA==
X-Received: from qkba14.prod.google.com ([2002:a05:620a:a38e:b0:915:71c1:ce29])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a0c5:20b0:911:dfb6:d89b with SMTP id af79cd13be357-9158a7b6ec7mr946044885a.39.1780582437393;
 Thu, 04 Jun 2026 07:13:57 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:40 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-9-edumazet@google.com>
Subject: [PATCH v3 net-next 08/11] bridge: provide lockless access to p->priority
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sysfs show_priority() needs this.

Also br_port_fill_attrs() might in the future run without RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_netlink.c  | 2 +-
 net/bridge/br_stp_if.c   | 2 +-
 net/bridge/br_sysfs_if.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index a722db89aef6bbb6ecc77c7e0f173dc79418797f..fc25c6b6cc9713080873976f443da1fbd764aafe 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -239,7 +239,7 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	u64 timerval;
 
 	if (nla_put_u8(skb, IFLA_BRPORT_STATE, p->state) ||
-	    nla_put_u16(skb, IFLA_BRPORT_PRIORITY, p->priority) ||
+	    nla_put_u16(skb, IFLA_BRPORT_PRIORITY, READ_ONCE(p->priority)) ||
 	    nla_put_u32(skb, IFLA_BRPORT_COST, READ_ONCE(p->path_cost)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MODE, mode) ||
 	    nla_put_u8(skb, IFLA_BRPORT_GUARD, !!(p->flags & BR_BPDU_GUARD)) ||
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 7b0d1a334785047905a00694fd65e3212b160e5d..3524bb7e87f0586774a883720be9fa8eb60f0370 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -323,7 +323,7 @@ int br_stp_set_port_priority(struct net_bridge_port *p, unsigned long newprio)
 		WRITE_ONCE(p->designated_port, new_port_id);
 
 	p->port_id = new_port_id;
-	p->priority = newprio;
+	WRITE_ONCE(p->priority, newprio);
 	if (!memcmp(&p->br->bridge_id, &p->designated_bridge, 8) &&
 	    p->port_id < p->designated_port) {
 		br_become_designated_port(p);
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1023f97b1c9a22a1f79c3c734aef9bd41832ea39..3f666d4fef42324a4751779153ecc48bdb44b85a 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -100,7 +100,7 @@ static BRPORT_ATTR(path_cost, 0644, show_path_cost, store_path_cost);
 
 static ssize_t show_priority(struct net_bridge_port *p, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", p->priority);
+	return sysfs_emit(buf, "%d\n", READ_ONCE(p->priority));
 }
 
 static int store_priority(struct net_bridge_port *p, unsigned long v)
-- 
2.54.0.1032.g2f8565e1d1-goog

