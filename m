Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656353F6C48
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380686; cv=none; b=PZTkdivRmafLFLUOnVi4ZYQuhRuVY7OqW2GNKNounGS+sl/RkdrxjKb4feNJgJu3lrGh+EKU7Iu+Il9hqAVRXGP9SKB4MFlPlNhkaoVyhdY9FxvP196NZtx60qbhd1TXHbr+SFmAzWJX1G+5Rev2ZhKzd8UVlbVOl9lYY8WiqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380686; c=relaxed/simple;
	bh=TVdmZXrN5qGZRgwvzVqAbGdkD2aWiSb0ef/bpOK79pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kE73evJwsppRDWBVL7jUxCzQJxbJzBPwe1pyHYGkkxLcFvKRZwZmKwXmDOdPYBp3iE7UewbZaxa9vWYhiKv+qeUeJU99EiJ/+wgnrZBVB3TZQTMceuqv92AcKvA8KTVfTYNESBWk++J/QwY7zH0PtdG3A26C5+io4aMHialBkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq2WHeoi; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq2WHeoi"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15354aa70e8so2080347c88.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380684; x=1792985484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/riTvgAHoH4uCg5GcnEDKRJxDAQc6gVI7OwugnT85eM=;
        b=Xq2WHeoiRdxRoa137XOxY+ngk+FuAYxD2NIhtaA2zKIT/pKFkIrNUqImV0szj/3afY
         WneluH0i88Fo+M1M18scbuZ4GPG9C4fGMdbGKpLcjQeyVbIDwkFhgcs289dnJ1h+7FdY
         u2MnoQtfOD82iPDO2qrEPUJTmmcTq/Z7ffK7Dm9i/mx7HRan2Wtnulp1YFGonKxtGrsd
         eP6hbxIQSmdnKMhr5wq6ORWoELGoYBIOfPvolGrYd3P/MbEwbkzhoz5EVqeJI4JK7eWw
         +j5Q4T/4EJ3VWlS4C1OPiytIfOdZvE3Jy0joWM6sWO6nVFhMdC9ME36fcBSk+Z39xEPZ
         ibxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380684; x=1792985484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/riTvgAHoH4uCg5GcnEDKRJxDAQc6gVI7OwugnT85eM=;
        b=P6l9Qx5sTclUTMrpAdfchkiiCkMpO3kmYmiDJMPmwHMT0Ao2tg3PaEWkd6fputvjvS
         S9pRG2zkzO+e8U2Dn2+Xt0u9RU7E84Jk0UDFwAbuwCWueuxGWnzYcPDq/srddB+8+cmu
         Qhzzz83lRjiF3HOKzHpYaw2L3oAW7xb5AJCu7596PFTpeYR0tgai74ipnoxqwI76AEkH
         psDCLvGO1dOvSSDxMyCQVeLcrV82wE6IBzroJV8TReLHAbeflZ6QDBAv1KcpefiQ1TXv
         GYie30AEjkbdG1wPsljyw0p8YWMuZ8guBaosyxevbMmINQMj2bQGAR/Io9wvT2aJY//d
         hwrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEqjHvr2UaLbOrBNnntY0N+WdMijnsq+iAKbug68Gh5Fscsz4LXFZUcRkNa/hG0WTSDwGZ9oE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFdEXt4R8Ms0/6guKyP8Bq5e8zCgD679jEFRHD1Y4cvHihNm4F
	yn/Zuha+Ww5ySyoWg5hnKU+OxWyf5iH0FV2q5IGV4/61TLozs4DXGGvi
X-Gm-Gg: AYBFou31kl1s7RX6es8PhS6zGiEVbIpBGYg/8mTfbji90YXwDhbhkjbQwZjVKH21bd9
	jDu6D6G9wo0bHOyJT1OdsCkFVSNKnOubhbetemQCQJYtDvCki2CxvCXCo/M9shujDbowQRR8y0B
	ojTJ3k06DjCUhA7jpWAexvAs32JmrYk7/87mlTH6D+W5MJN7she2xcTiF7fGLaDipWqZzn2g8yQ
	SDabYdC9ntDNsiZTvfXGTmyzIhYs4rnLW/UQhMtdNz373f6xd+weEijPyAiZISxQh3d2uU3USTO
	oiD4GXAwB1uWcz0iMxESAhDNYxfO6bPaNWPSl5r+rtpRQ/edlsKm+cAHhmahfZ3Lp5O2y0dSqoM
	WyEeHVu383WStdn+AuJj1nuxeUoV3F079v9xMZ7n8aXOFgk22spm0sbag6alOY19qHVbjiLEZ+m
	gGf08Y9glBNbc3wkO0s/FsXh4dCV8YLlZ1ZHyEYokx4+LWPuuPHwR4hlTdPD/FRYVPGbHXCOxXL
	/Dr
X-Received: by 2002:a05:7022:ea42:b0:14d:c7ae:85e1 with SMTP id a92af1059eb24-18512f1b9bcmr9626649c88.21.1792380684311;
        Sun, 18 Oct 2026 20:31:24 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm24066888c88.5.2026.10.18.20.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:31:23 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 11:31:15 +0800
Subject: [PATCH net-next v2 1/3] ipv4: draw rt_genid from a sequence shared
 by all netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-bug-net-netns-move-rcu-barrier-v2-1-b6eb7780c492@gmail.com>
References: <20261019-bug-net-netns-move-rcu-barrier-v2-0-b6eb7780c492@gmail.com>
In-Reply-To: <20261019-bug-net-netns-move-rcu-barrier-v2-0-b6eb7780c492@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

An IPv4 route records the rt_genid of the netns it was created in, and
rt_is_expired() compares it with the rt_genid of the netns its device
belongs to when the route is checked. Every netns starts its rt_genid
at 0 and increments it on each cache flush, so different netns often
hold the same value.

When a device moves to another netns, routes cached through it remain
usable until dst_dev_put() points them to blackhole_netdev. For a route
using a nexthop object this happens in nexthop_free_rcu(), which
free_fib_info_rcu() queues from inside an RCU callback, so the
rcu_barrier() in __dev_change_net_namespace() does not wait for it. If
the rt_genid of the new netns matches the cached one in that window,
ipv4_dst_check() accepts the route and a socket in the old netns keeps
sending through a device that now belongs to another netns.

Take every rt_genid bump from one sequence shared by all netns, which
never hands out 0, the value every netns starts with. A netns bumps its
rt_genid on NETDEV_UP before its devices can carry traffic, so a cached
route never matches the rt_genid of the netns its device moves to.
Concurrent bumps of one netns can leave the older of two values, so
rt_genid is no longer monotonic per netns. It is only compared for
equality, so this costs at most an extra route lookup.

A connected UDP socket in netns A caches a route through a nexthop
object on a veth. The veth is moved to netns B and brought up with one
RTM_NEWLINK, then the socket sends 200000 datagrams. B's rt_genid is
bumped 0 to 20 times before the move, 63 trials:

                                before     after
  trials sending after move          2         0
  datagrams sent after move       2616         0

Fixes: 4c7e8084fd46 ("ipv4: Plumb support for nexthop object in a fib_info")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/net/net_namespace.h |  5 +----
 net/ipv4/route.c            | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 46b4c67e2966f..9c78f1d90fb62 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -556,10 +556,7 @@ static inline int rt_genid_ipv6(const struct net *net)
 }
 #endif
 
-static inline void rt_genid_bump_ipv4(struct net *net)
-{
-	atomic_inc(&net->ipv4.rt_genid);
-}
+void rt_genid_bump_ipv4(struct net *net);
 
 extern void (*__fib6_flush_trees)(struct net *net);
 static inline void rt_genid_bump_ipv6(struct net *net)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 595a3b7f17830..25bebbb30bf3c 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -393,6 +393,26 @@ static inline int ip_rt_proc_init(void)
 }
 #endif /* CONFIG_PROC_FS */
 
+/*
+ * Draw rt_genid bumps from one sequence shared by all netns. A route keeps
+ * the genid of the netns it was created in, and is checked against the netns
+ * its device is in now, so distinct values make that check fail once the
+ * device has moved. Every netns starts at 0, which the sequence never hands
+ * out, and bumps on NETDEV_UP before any of its devices can carry traffic.
+ */
+static atomic_t rt_genid_seq;
+
+void rt_genid_bump_ipv4(struct net *net)
+{
+	int genid;
+
+	do {
+		genid = atomic_inc_return(&rt_genid_seq);
+	} while (!genid);
+	atomic_set(&net->ipv4.rt_genid, genid);
+}
+EXPORT_SYMBOL_GPL(rt_genid_bump_ipv4);
+
 static inline bool rt_is_expired(const struct rtable *rth)
 {
 	bool res;

-- 
2.43.0

