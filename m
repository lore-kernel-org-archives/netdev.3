Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D7247D466
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326890; cv=none; b=s3S4cgXMKfjYMoTiXlpYD3jiIxxv2RhIaqiLNIX4nM9wlPYoKexXSwB/lVtzvynonhnnvKmICHqHplDOgHT9nbV62/oc8099QkysCjjhc4Ckp7biqfVRhW0xZZWf8/VNV5SzaHJ9ukGWUiq/PRTqVTdvNpphItdVoK3mwur+HPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326890; c=relaxed/simple;
	bh=N8Xmy4/vDXYjA5NH8qTfr6UDnpzFJtO6faLphAOWcS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6qbIFQ70Z7jDv1RBjgA4gJKa2XYads2ayX7GwzkuCp7xUGM30tDbiixmupQYfF2AJqdZwfH2AEblQBjOTcizlVovVwOte7Ci93aY3wZ8OoLUn9TnJ5nfhbPi/ezpC1AsjdepTJSq+oc33G2DfRDWCbZRGI40Z9txuRTFSJK/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ1rV67z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ1rV67z"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e04df8c46so977814b3a.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785326889; x=1785931689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cP9XpBSahU8H90VUbCsH4OW4P7gb1bvekS7IuobkoHU=;
        b=aQ1rV67zNPVdGiKtdUeTuI+ov8me8sUpjkcPziJdFz61VVBcrYVJ+j7FfqfuhnLt7U
         Nd3Gtubm5VESfQWmRgOVomKXKEtcbKW6tCGehn4yBv23fHL/ZqNtWMt94BNgP5kI6l2j
         7xXwXzm/WdDfecrVAFNAsZodLp1XFpEtpV9WnsFO02DEr8iVuCcv2J3GTDydD+LHMssP
         18+m1YjKSvVm/A5igH8/CL6F5TkO6v8clxg/roLi28wynKQEDj6Gg5Uop1ayxAJstkSl
         +GX+TmKDSt0LCSQlghomqCwKd+HN0HofPFBrX4TelN+SiyypAocLHzTrEyo2CMrDr/ll
         b71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785326889; x=1785931689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cP9XpBSahU8H90VUbCsH4OW4P7gb1bvekS7IuobkoHU=;
        b=i1gqyb4+qvSEoJmZ5XV9FtCsazzbjY+07bskfWg9lnamoEIa3jEHsglgd0fl1HB2Qz
         Us4NITZcx3K1OPbIPIXdF2ihrVEvolDJosF8z/vBz7afmVom5XHVZBr0cfq/BY0ur9CR
         f2loxU1mAn69u9V3FFsBhF2GobANzqehfUMqdc2NHlRXviqJFqocH3zcfv0cWwf7hriQ
         zenirVNFrOl6EkSnWbg/OIsNbS621yUbB39pR94ho3xSHJXGDvYs3tjcdI0Pv8hS4LgZ
         jw0aWKm7VBoQ/l0c4tJeN5qsRCclztOaCdM+cYSvONjjnqLrBemEO990C1XfSPxzw3ZJ
         tZkw==
X-Forwarded-Encrypted: i=1; AHgh+RqBPa0eHv+SpvNl7SqrUqresrebi4S+y3oOv2UhAa1+8b0bkQ7Y6UxDWSTgHWT2XqyJe1SjHfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/24C0yFC5PLpXtQKjBykTWM5SLFgIANyYkirBttao8Pbp7py
	AJOYC07doiz+g2EVp4ptkEspSzcdtpZ47z8PIarA53bv0NUdqIYUCM4R
X-Gm-Gg: AR+sD13Od4BnEXe7bmbokKEJQ6T/Sx2YBNwnVWKkfRa5aExTAIrtO5uACxoB6MnnWZr
	U9I7Q4vvy6PpDqdPO4hA1hZEHKpT22svMYoalfw5Wec2l1N4GRkZOnho11H7H3gzyJhHN50w/J7
	+kUYcvd8wrodYh2doGSHxFbzMz+An7kiFe/8E/Jz0ESmznS0hoYBX5Zhn3xlRI2yy7ipP+DcqIp
	q0omisgAWXw0yrgzQk/RTjcZ57a+mtIaWg+a5KuIH2i5IPMEQpSfMOPM/9XtnZJZ0fQhvHA8EFa
	KqaQlKSB8AjvSIrkyxuer4TJOJt2433W8pfy3K2wroO5ZY3MCv7tRJKcWexOxb/XVIJGYbfR75i
	U04OuTXiO0qbPIbZTHujYh91Y/ewG+ntTXn6E3sHS8fLRiPtFbB0o3pG6XW+ngZrmaTpHA4fxWH
	W+WQdekbfw2HY8t6hJAUnCRTHOv6cVmZ9fpXbUP9Zy9KW5sTDjPeLi3zeDJAFuVmQYX/IG4fqbj
	dd33lf6jZ7/h9MJucKqX4KmwjcT+U76wYl+7Q==
X-Received: by 2002:a05:6a00:3922:b0:84a:29a7:f64c with SMTP id d2e1a72fcca58-84e92ff010emr6884888b3a.0.1785326888768;
        Wed, 29 Jul 2026 05:08:08 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:c705:d3b3:a6d9:8512])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0300ac2sm1263482b3a.35.2026.07.29.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:08:06 -0700 (PDT)
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
Subject: [PATCH net-next v4 04/10] ipv6: add a deletion reason argument to rt6_fill_node()
Date: Wed, 29 Jul 2026 21:07:33 +0900
Message-ID: <20260729120739.47880-5-sigefriedhyy@gmail.com>
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

Add the deletion reason to rt6_fill_node() so that it can report it to
user space. All callers pass RTA_DEL_REASON_UNSPEC for now.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 net/ipv6/route.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d2b9f9a899cf..b30becf3f56b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -111,7 +111,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 			 struct fib6_info *rt, struct dst_entry *dst,
 			 struct in6_addr *dest, struct in6_addr *src,
 			 int iif, int type, u32 portid, u32 seq,
-			 unsigned int flags);
+			 unsigned int flags, enum rta_del_reason del_reason);
 static struct rt6_info *rt6_find_cached_rt(const struct fib6_result *res,
 					   const struct in6_addr *daddr,
 					   const struct in6_addr *saddr);
@@ -4035,7 +4035,8 @@ static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
 
 			if (rt6_fill_node(net, skb, rt, NULL,
 					  NULL, NULL, 0, RTM_DELROUTE,
-					  info->portid, seq, 0) < 0) {
+					  info->portid, seq, 0,
+					  RTA_DEL_REASON_UNSPEC) < 0) {
 				kfree_skb(skb);
 				skb = NULL;
 			} else
@@ -5784,7 +5785,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 			 struct fib6_info *rt, struct dst_entry *dst,
 			 struct in6_addr *dest, struct in6_addr *src,
 			 int iif, int type, u32 portid, u32 seq,
-			 unsigned int flags)
+			 unsigned int flags, enum rta_del_reason del_reason)
 {
 	struct rt6_info *rt6 = dst_rt6_info(dst);
 	struct rt6key *rt6_dst, *rt6_src;
@@ -6064,7 +6065,8 @@ static int rt6_nh_dump_exceptions(struct fib6_nh *nh, void *arg)
 					    &rt6_ex->rt6i->dst, NULL, NULL, 0,
 					    RTM_NEWROUTE,
 					    NETLINK_CB(dump->cb->skb).portid,
-					    dump->cb->nlh->nlmsg_seq, w->flags);
+					    dump->cb->nlh->nlmsg_seq, w->flags,
+					    RTA_DEL_REASON_UNSPEC);
 			if (err)
 				return err;
 
@@ -6112,7 +6114,8 @@ int rt6_dump_route(struct fib6_info *rt, void *p_arg, unsigned int skip)
 			if (rt6_fill_node(net, arg->skb, rt, NULL, NULL, NULL,
 					  0, RTM_NEWROUTE,
 					  NETLINK_CB(arg->cb->skb).portid,
-					  arg->cb->nlh->nlmsg_seq, flags)) {
+					  arg->cb->nlh->nlmsg_seq, flags,
+					  RTA_DEL_REASON_UNSPEC)) {
 				return 0;
 			}
 			count++;
@@ -6345,12 +6348,14 @@ static int inet6_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			err = rt6_fill_node(net, skb, from, NULL, NULL, NULL,
 					    iif, RTM_NEWROUTE,
 					    NETLINK_CB(in_skb).portid,
-					    nlh->nlmsg_seq, 0);
+					    nlh->nlmsg_seq, 0,
+					    RTA_DEL_REASON_UNSPEC);
 		else
 			err = rt6_fill_node(net, skb, from, dst, &fl6.daddr,
 					    &fl6.saddr, iif, RTM_NEWROUTE,
 					    NETLINK_CB(in_skb).portid,
-					    nlh->nlmsg_seq, 0);
+					    nlh->nlmsg_seq, 0,
+					    RTA_DEL_REASON_UNSPEC);
 	} else {
 		err = -ENETUNREACH;
 	}
@@ -6386,7 +6391,8 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		goto errout;
 
 	err = rt6_fill_node(net, skb, rt, NULL, NULL, NULL, 0,
-			    event, info->portid, seq, nlm_flags);
+			    event, info->portid, seq, nlm_flags,
+			    RTA_DEL_REASON_UNSPEC);
 	if (err < 0) {
 		kfree_skb(skb);
 		/* -EMSGSIZE implies needed space grew under us. */
@@ -6419,7 +6425,8 @@ void fib6_rt_update(struct net *net, struct fib6_info *rt,
 		goto errout;
 
 	err = rt6_fill_node(net, skb, rt, NULL, NULL, NULL, 0,
-			    RTM_NEWROUTE, info->portid, seq, NLM_F_REPLACE);
+			    RTM_NEWROUTE, info->portid, seq, NLM_F_REPLACE,
+			    RTA_DEL_REASON_UNSPEC);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in rt6_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -6472,7 +6479,7 @@ void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 	}
 
 	err = rt6_fill_node(net, skb, f6i, NULL, NULL, NULL, 0, RTM_NEWROUTE, 0,
-			    0, 0);
+			    0, 0, RTA_DEL_REASON_UNSPEC);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in rt6_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
-- 
2.43.0

