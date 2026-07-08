Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBFD383313
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 06:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490801; cv=none; b=TgJzW3zeq7AxHL0su+AKrd6wJUmNsHTy4OLAK920J5I850FULQtJLi8qZzJQvqkoZTXKD2iyHVpmq8cWiz1EernH4EzKgwqiaCwkWle+TSjtpwSBx3W78r5Nyu4eeRYjEszwY+xFspE2jZ/nwBmUQCtp37fMIOynBFO8NXbZYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490801; c=relaxed/simple;
	bh=DrODIwvyYn9L/GKPzhvUTnULjebDwilC94nEuArScPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RU1pQ8i4Ass2OSNleTpY77zPepvqBhMK4IFyBUFt+818nmeVekBl6yH7E3UiFxkEFUc6JNpuJQmwiWIix695FM2pg2D1naj7HrlC5AbM3nqNcVdnyUxUMUCdoGRqvg5/5TvPim1/pMETq7dYxzKi9HH9RMhpnxoVWowU2zz8xs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=arP/d2S5; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="arP/d2S5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783490798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fVpIZ6ugNKREnQtdLTXjerq4ghmARfupm+QFoiSfkU=;
	b=arP/d2S5lNGCB+VL2UegdIkjEQhuQ7TbQ31FjeBxKjhRIMBFvjS8nY4MDNLQpXssJmzMou
	sGFuys1Ux0NF+1PIhnvzRbw2sCUFfOTK56qqUC4nkYAIMRT0JN8FIOzz7CGI1ResH8Xcwy
	NcmhXqLiSq67ELxRiy/In49ZQruBR9Q=
From: xuanqiang.luo@linux.dev
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v3 1/2] ipv4: use rcu_assign_pointer() in rt_flush_dev()
Date: Wed,  8 Jul 2026 14:05:36 +0800
Message-ID: <20260708060537.17188-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260708060537.17188-1-xuanqiang.luo@linux.dev>
References: <20260708060537.17188-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

rt_flush_dev() replaces rt->dst.dev with blackhole_netdev on uncached
routes.  The field is also exposed as dst.dev_rcu, and existing readers
use dst_dev_rcu().

Use rcu_assign_pointer() for the replacement, as dst_dev_put() already
does for the same field.

Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3f3de5164d6e5..b668375df71e2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1565,7 +1565,7 @@ void rt_flush_dev(struct net_device *dev)
 		list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_uncached) {
 			if (rt->dst.dev != dev)
 				continue;
-			rt->dst.dev = blackhole_netdev;
+			rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
 			netdev_ref_replace(dev, blackhole_netdev,
 					   &rt->dst.dev_tracker, GFP_ATOMIC);
 			list_del_init(&rt->dst.rt_uncached);
-- 
2.43.0

