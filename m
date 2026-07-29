Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9947CC9C
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326880; cv=none; b=MoxT+w79uXHC7NwtAzO7kYfbQARojsJ8LPY+bPQRbckzt3oxkC7M+DVpBe2ltRW9vaqenJ+e6LbX/s+R7Cxt0iHfQxCPRoSn3Ege+itU4VAj5fQjsV2vlNxXg1BdnT5FamAcUAZwP4/rlAzYOjkA6ef/xm7XyOGxiXNk4vdhiW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326880; c=relaxed/simple;
	bh=kNIUfvSyMi6L9e1071hg3k2veREijumtXkxFG/0UalU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esBotOHZZn7jrTKw1uF+FiRptnBTTd0TpEG+jNxccDV1QpcOzyY4T6gRIlheFxaQbfLEqP7peRkIiW/5d2sI71VtklqhTPxepv8YWCq95NGC3AK+e8tMK35OyR/UjOMTedZq4GHPtR9y9RNz9X0TPl0LWNmxpjIs3RLZgdJ3kWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkTe/tri; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkTe/tri"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8487214ad2bso1270798b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 05:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326877; x=1785931677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AkT+xjK4yh7g3MZJUEw3DTMTSG3CVFnmRonGIiu8WvY=;
        b=JkTe/triXVbNynclZ8+2Sjdd1ACEvp5LspxQlyPIAAY+yUOu5+SKmSyC2PSRN+9U8u
         MFz+yTUbyXcHQLUD+HCMqgs6hh/jhxh8EMwQL6Mbe5MI1gsPglMBHwxR83pwJ/xCKRc1
         OWPYhh7ScShZeVChdEJIk9Gh2MjfFW60huWBrOVIWRhaVfN20CffN/o8fqw9Bj1ddh4f
         1QQ/2rNXl7oOywGvwrfiRsDQ9zK80Lu8k79qUcelm8/G/uTYtqvmit45MHRUpVgivd29
         drRKk0MpOXK1aPiaArHTCyRFBdPQb7Bcv7FGneytADBnh34N4TxmAoKh9WecqyS5p6M7
         xaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326877; x=1785931677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkT+xjK4yh7g3MZJUEw3DTMTSG3CVFnmRonGIiu8WvY=;
        b=DwGoAI8aH+ZfHYuI+6xUMdvNMxrJD2F7DMiCETKx6+01MNTqRaF12EWZJgggRrOhtJ
         sZ1Hx3kNqZBMJ0l9yl1c6IDImJ3YaSycXyWjkapO9xLuFcSkPmIRTH9+y1eP+4zhOiPa
         6N4JfoP5ebzJZbls1ygI1T3zZ4NdFyo1Fr1ev5FohpZrktnHytqoFLkMgotB/wW8Y95D
         VcBdzfCJW1/HzZK+UGJzIKryCeS/YfOA73CvCgpC3AYJ4ydO9Irg71wzfPKnQ/rdBQ8X
         uUbtrUspKH6bXyvtcyGaQj4tbTmXytqRpW/kXSxNO3QBGNceFyBVy0/W62Kmy14aU0xT
         /JCw==
X-Forwarded-Encrypted: i=1; AHgh+RqyCr2/AS3MPPDUzarghhkHgHaTJoEhS8xh65JD6hPaBYE2l4sXGpHU+8G8w/fXR+4JJvRajT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCVtlGEwk1yXabCuE4HTlrGsz6OIQJjGtbDVjdTYVJ0gNRZqFB
	baZGWGGs4qMU+zXxLwZsR6qRLY1/CwMuN8CzKDOJsTBb0dZnhIZnfqRF
X-Gm-Gg: AR+sD13lY+ZtVTWBv4lHrSmXbE8w5Y4rJpIAeZ7olE7Q6Id6vgx9n+8KsGDcuuJ1jva
	agmqj63XQ2giIrzbxj8zJgL+ANH1PfH2rPx6IzXTFukcohesHO3O13VEZ2AjvoSbNkf6TJ8OJZx
	3/LuB/dW0Foo2Leb4Wt9EAXeM9V85mWyROIL0ZvesgMybyKdlX4uQsZK6MVMVaGVOFdLmE8NonA
	0duJ8SNX+IfzqntoiE1qaxdb1dZLJMPOQ13aitWKPCUzrQk6h21a/MtPec+T8a7Ih7oevfoKBVt
	ZzY8Pghfup6ik6CcvAM9yyQNTz2un32ufR+DcFx0y5pSjVAuBs3eBxWU/WeeqdHEOCSn3qVnri+
	vlwqdIXLb2dluDwuDnECMBWMjiDYVcqbLWIxtCW6ldz20oJTAFB3FZyw6qdoitK014b3C4uCS36
	1uu5HpUokDpORs1ox3hiWuSHD09Bj63LnY/Pb9xXUXksExaEGDt/z6A/QlHZnxy+47mBu4+I+4D
	/xwZ63kOTqsNSgZQhlifGGS4Bnflwz9rMVM7ywwv4DGL0m7rw==
X-Received: by 2002:a05:6a00:12da:b0:848:2c2e:c7a3 with SMTP id d2e1a72fcca58-84e931b5439mr6653550b3a.16.1785326877510;
        Wed, 29 Jul 2026 05:07:57 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:c705:d3b3:a6d9:8512])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0300ac2sm1263482b3a.35.2026.07.29.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:07:56 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Chris J Arges <carges@cloudflare.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 02/10] ipv6: propagate the route deletion reason to fib6_del_route()
Date: Wed, 29 Jul 2026 21:07:31 +0900
Message-ID: <20260729120739.47880-3-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729120739.47880-1-sigefriedhyy@gmail.com>
References: <20260729120739.47880-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the deletion reason from ip6_del_rt_reason() down through
__ip6_del_rt(), fib6_del() and into fib6_del_route(). All existing
callers pass RTA_DEL_REASON_UNSPEC.

fib6_del_route() ignores the reason until the notification path learns
to report it.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 include/net/ip6_fib.h |  3 ++-
 net/ipv6/ip6_fib.c    | 12 +++++++-----
 net/ipv6/route.c      | 17 ++++++++++-------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 9cd27e1b9b69..c57980671f28 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -468,7 +468,8 @@ void fib6_clean_all_skip_notify(struct net *net,
 
 int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 	     struct nl_info *info, struct netlink_ext_ack *extack);
-int fib6_del(struct fib6_info *rt, struct nl_info *info);
+int fib6_del(struct fib6_info *rt, struct nl_info *info,
+	     enum rta_del_reason del_reason);
 
 static inline
 void rt6_get_prefsrc(const struct rt6_info *rt, struct in6_addr *addr)
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index a130cdfaebfb..b6e3bdd20cd0 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1966,7 +1966,8 @@ static struct fib6_node *fib6_repair_tree(struct net *net,
 }
 
 static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
-			   struct fib6_info __rcu **rtp, struct nl_info *info)
+			   struct fib6_info __rcu **rtp, struct nl_info *info,
+			   enum rta_del_reason del_reason)
 {
 	struct fib6_info *leaf, *replace_rt = NULL;
 	struct fib6_walker *w;
@@ -2061,7 +2062,8 @@ static void fib6_del_route(struct fib6_table *table, struct fib6_node *fn,
 }
 
 /* Need to own table->tb6_lock */
-int fib6_del(struct fib6_info *rt, struct nl_info *info)
+int fib6_del(struct fib6_info *rt, struct nl_info *info,
+	     enum rta_del_reason del_reason)
 {
 	struct net *net = info->nl_net;
 	struct fib6_info __rcu **rtp;
@@ -2090,7 +2092,7 @@ int fib6_del(struct fib6_info *rt, struct nl_info *info)
 		if (rt == cur) {
 			if (fib6_requires_src(cur))
 				fib6_routes_require_src_dec(info->nl_net);
-			fib6_del_route(table, fn, rtp, info);
+			fib6_del_route(table, fn, rtp, info, del_reason);
 			return 0;
 		}
 		rtp_next = &cur->fib6_next;
@@ -2252,7 +2254,7 @@ static int fib6_clean_node(struct fib6_walker *w)
 		res = c->func(rt, c->arg);
 		if (res == -1) {
 			w->leaf = rt;
-			res = fib6_del(rt, &info);
+			res = fib6_del(rt, &info, RTA_DEL_REASON_UNSPEC);
 			if (res) {
 #if RT6_DEBUG >= 2
 				pr_debug("%s: del failed: rt=%p@%p err=%d\n",
@@ -2400,7 +2402,7 @@ static void fib6_gc_table(struct net *net,
 
 	hlist_for_each_entry_safe(rt, n, &tb6->tb6_gc_hlist, gc_link)
 		if (fib6_age(rt, gc_args) == -1)
-			fib6_del(rt, &info);
+			fib6_del(rt, &info, RTA_DEL_REASON_UNSPEC);
 }
 
 static void fib6_gc_all(struct net *net, struct fib6_gc_args *gc_args)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 9f82829923ab..7574c385105f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3973,7 +3973,8 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 	return err;
 }
 
-static int __ip6_del_rt(struct fib6_info *rt, struct nl_info *info)
+static int __ip6_del_rt(struct fib6_info *rt, struct nl_info *info,
+			enum rta_del_reason del_reason)
 {
 	struct net *net = info->nl_net;
 	struct fib6_table *table;
@@ -3986,7 +3987,7 @@ static int __ip6_del_rt(struct fib6_info *rt, struct nl_info *info)
 
 	table = rt->fib6_table;
 	spin_lock_bh(&table->tb6_lock);
-	err = fib6_del(rt, info);
+	err = fib6_del(rt, info, del_reason);
 	spin_unlock_bh(&table->tb6_lock);
 
 out:
@@ -4002,7 +4003,7 @@ int ip6_del_rt_reason(struct net *net, struct fib6_info *rt, bool skip_notify,
 		.skip_notify = skip_notify
 	};
 
-	return __ip6_del_rt(rt, &info);
+	return __ip6_del_rt(rt, &info, del_reason);
 }
 
 int ip6_del_rt(struct net *net, struct fib6_info *rt, bool skip_notify)
@@ -4070,13 +4071,13 @@ static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
 		list_for_each_entry_safe(sibling, next_sibling,
 					 &rt->fib6_siblings,
 					 fib6_siblings) {
-			err = fib6_del(sibling, info);
+			err = fib6_del(sibling, info, RTA_DEL_REASON_UNSPEC);
 			if (err)
 				goto out_unlock;
 		}
 	}
 
-	err = fib6_del(rt, info);
+	err = fib6_del(rt, info, RTA_DEL_REASON_UNSPEC);
 out_unlock:
 	spin_unlock_bh(&table->tb6_lock);
 out_put:
@@ -4202,7 +4203,8 @@ static int ip6_route_del(struct fib6_config *cfg,
 				if (!fib6_info_hold_safe(rt))
 					continue;
 
-				err =  __ip6_del_rt(rt, &cfg->fc_nlinfo);
+				err = __ip6_del_rt(rt, &cfg->fc_nlinfo,
+						   RTA_DEL_REASON_UNSPEC);
 				break;
 			}
 			if (cfg->fc_nh_id)
@@ -4221,7 +4223,8 @@ static int ip6_route_del(struct fib6_config *cfg,
 
 			/* if gateway was specified only delete the one hop */
 			if (cfg->fc_flags & RTF_GATEWAY)
-				err = __ip6_del_rt(rt, &cfg->fc_nlinfo);
+				err = __ip6_del_rt(rt, &cfg->fc_nlinfo,
+						   RTA_DEL_REASON_UNSPEC);
 			else
 				err = __ip6_del_rt_siblings(rt, cfg);
 			break;
-- 
2.43.0

