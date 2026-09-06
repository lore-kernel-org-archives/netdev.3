Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D25217704
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 03:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666656; cv=none; b=dBWAIjVwGcSjtTcwwdfZzllyhyFDweJCful/hVkX7aH9ENneukqnlwvVtPU/JXcX8FqSiYfUC61qlFXuWgnZx7QP4+HMgalpB2V+RzO3A3hBhuTQvNrELogor2pVS6H6RW/6XmZrytZ1bQLVbcJ9a4JSbJjgwubuvvEU8VPJ1tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666656; c=relaxed/simple;
	bh=hyapCilL5pWZnnG8x/9q9+l1rNqaeGLgUVdHkrndFms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dSn6H6/0ythIXZEuSMMGq46JQ4/Nb1UMEkYG6QF69hMzPzKZAwLK5nYf0B3M9O/v8wZ1ESwREOILZcdLWMb2KtTm4zpyX5VV777rd/Eb7EVvj/RYQgZSEmeGJWtx8bWR79ypTKKuVTraZAPyQ5yA3S7axP1NGmlfgWRkFc2SHak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeTal1p0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeTal1p0"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so2407703a12.2
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 20:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788666654; x=1789271454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fW6yt9nbpXpIAMyGGr3gNcQLhcmRLKyTBThr7JzkuBQ=;
        b=oeTal1p0PCN54WsKAC/snSb9idD5QlHJy/FNGyDrd04kJ6JXkjDQ8phul7TSvuf/H6
         hAUHEmjq2u3pl1u4uxY/7FldI9kL6kzR+lR2fjqqW33UgPsN0TDPQbnL4wWT38tyyqms
         zw4kTdlActoVAkF23uBPk/Mo+xbIl9KKYQG9ou4Annt4fSS3CzQ7X7PQ+I6jXPHIFGNv
         s4T0SmYK6Bo+f69bfD9Kq/57QG266O/6zkGmFRmVVbQ+tehZNWlIRvBtfFxLYiIsVTxM
         HhhEfF1xrUSC/XL9SZBKy01TiU6CF/xJfOiqrPQ5oHgH5AoXKeo6Kia0UCYit9i12vaa
         AdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788666654; x=1789271454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fW6yt9nbpXpIAMyGGr3gNcQLhcmRLKyTBThr7JzkuBQ=;
        b=N2HBnF9mx+6HOsPAUOkRKvJFH/KucXmQ5kRmpKu6CZrCCW4CMQH/fJooG8t/wLaHyu
         gLJdjyyd8CAKDo3SXEPnIgBzbzj/XwC2ZN9dxW3Glq0pbWXEctKmLPCY2kql5VsI719z
         5wxCUNMBbteGdLI0aZftSW48XasDMboy6AovOXanj/zqZmvffqEZLVT5Hy++vjys1fPR
         04gufp0qs8bLz4V7Zwx181SGAsrOtmpVf+p0Xi3WDsfZ/ipdUZjJhBwBsGDHKeCK6M1Z
         GYBtEWlv283Tan88rStRnUZdNCIpVs58O+16j+CCxdqSFPRt7QfWT1xs7/wylIk9B6Zk
         V6oA==
X-Forwarded-Encrypted: i=1; AKwUvBxLFZTHhpmu87SMcBl46+gbxVE9TGqedJnCvP1uXosazwL2CKHHZH1OMDhWtx5vQV7kwNZkagM=@vger.kernel.org
X-Gm-Message-State: AFuF++kUvciMZwkr5fPVkTmrkUlHfFgpvWNCzA5ICM2RCkIbX9hP/wd7
	X5VN3oU1XvWQ5vhtatIfvxWmJfkSTGC/kqoAuCUvS2Bq1YElfrePX5yZ
X-Gm-Gg: AYBFou0vf/D+dnMb/sogJ5bGMcgCCfAG2ydjO3V7TY73JShVDyFPU/NMNh8AfdwJtZE
	+AHV8MAL0DLVnRo5noynjDXporAqVXaKIehW74L/R881hblmSIeUA4EKwtd08eBur4C92mVbJPg
	uoHQ+xDdNtk7J1CwQ9vAPnVq3Srcd21AcEiJvWsNDaXHo+EMo0ebdh4DIZN+6Ak8AB11qfAtm5V
	nwCPk2JtSGYZL6L3Qyyrana5ZejNDFxau10XndDBuLl0UFgM1pfKs6h6PZzTDQXS/GQoqKhU6Ks
	tI0ubBVXX676ftahOrYID53FOgaX1fK+iOOfv1ZFD2hSWcj4iym1RdqZoSVaqRQKErXYDgdGi8q
	YsZqXXKuZoDb6dN4edhfdoEF3TUFYNqAc9rRHwWNDDttopbZfUBHuF+Z5BAMxTT/ofmq6RHn4FX
	+mI7VAmpMTD62BzwrxehaZvlViwKE1ezOMShgrznzNqTx7wgeyKlebBEzuVQX/naPnrQTOfqZ1n
	iQk4iVoCy+7MrDWnOkq
X-Received: by 2002:a05:6a20:7288:b0:3bf:5b7a:fc8b with SMTP id adf61e73a8af0-3da397c5713mr22545348637.0.1788666654238;
        Sat, 05 Sep 2026 20:50:54 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.115.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc455485c25sm2550916a12.26.2026.09.05.20.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:50:53 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+459f67f4d8af8ce6@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH nf] netfilter: ip6t_rpfilter: handle routes without inet6_dev
Date: Sun,  6 Sep 2026 11:49:38 +0800
Message-ID: <20260906034939.3746540-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6_route_lookup() can return an error-free route whose rt6i_idev is
NULL.  For example, lowering an external nexthop device's MTU below
IPV6_MIN_MTU tears down its inet6_dev while fib6_ifdown() leaves routes
using nexthop objects in the FIB.

rpfilter_lookup_reverse6() dereferences rt6i_idev before evaluating its
loose-mode condition.  This lets an unprivileged user with a private user
and network namespace trigger a NULL pointer dereference:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000000
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: rpfilter_mt
  ip6t_do_table
  nf_hook_slow
  ipv6_rcv
  process_backlog
  net_rx_action
  handle_softirqs

Evaluate loose mode first because route existence is sufficient there.
In strict mode, compare devices only when the route has an inet6_dev.

Fixes: e26f9a480fb6 ("netfilter: add ipv6 reverse path filter match")
Reported-by: co+459f67f4d8af8ce6@bugs.sh
Closes: https://lore.kernel.org/all/VtWUkE8QzJt5CroTj2V2v3ZQ0gwbXZ7nq7I3@bugs.sh/
Assisted-by: Claude:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/ipv6/netfilter/ip6t_rpfilter.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/netfilter/ip6t_rpfilter.c b/net/ipv6/netfilter/ip6t_rpfilter.c
index 67c87a88cde4f..2bcc96f9385cb 100644
--- a/net/ipv6/netfilter/ip6t_rpfilter.c
+++ b/net/ipv6/netfilter/ip6t_rpfilter.c
@@ -72,9 +72,11 @@ static bool rpfilter_lookup_reverse6(struct net *net, const struct sk_buff *skb,
 		goto out;
 	}
 
-	if (rt->rt6i_idev->dev == dev ||
-	    l3mdev_master_ifindex_rcu(rt->rt6i_idev->dev) == dev->ifindex ||
-	    (flags & XT_RPFILTER_LOOSE))
+	if (flags & XT_RPFILTER_LOOSE)
+		ret = true;
+	else if (rt->rt6i_idev &&
+		 (rt->rt6i_idev->dev == dev ||
+		  l3mdev_master_ifindex_rcu(rt->rt6i_idev->dev) == dev->ifindex))
 		ret = true;
  out:
 	ip6_rt_put(rt);
-- 
2.55.0
