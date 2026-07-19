Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8D38642A
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458695; cv=none; b=tvsSxFe9p+TJS6j+SFKhp0JEkzCusCrMYDHVcCNNAZLEUvkWLENWvHU6z8ezUJLAhZHt+4ND4IMoW4yztbDFGOYnzpBjjbbzHvSDG+xxoY2hEcwctCNu9/eZulFKUilPd/2Jbj0RJsUO++74r2eUuz+g5Oy8A2r8MZCYUEZ8hmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458695; c=relaxed/simple;
	bh=kG68kuGxwTUfYF9d6eeoBkKrI492WSL5nm8S3ECKohQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ca2S9cNG1hWd9qesWqs7Sql/D7Qqk1l8+SzItG5Wh51kARkFfmPvwp2K4GQzhYgKI2Wrewsyy/8n2wnRInSffWnmEo25L09VNQmDgDGZl+f9C6TkpeLoALhmTlgo+7ooZOnUBgjrCfIN0mwpO2Qtb34Q2/x2EXsSJC4T/2ZEQOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBr7zHI3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBr7zHI3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954d383e64so9251145e9.1
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784458691; x=1785063491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7HzRtazZ4L1gYUv2iM5Gcb2OTN39V4RyFH9aAlRzqso=;
        b=ZBr7zHI30EFKhzYd2TnU6qFjCU/DOAf6CABgZ1aDlLXBURtAELzLWPymhdiriiduKu
         3VbtB0pWkQTRIZvIz3EaPPw2xcxDbNzIFei9e7BxrLpICwPBAl3l4BnLIWwg23hj+nJ+
         2zFBuIma7qShyfQ9fZeJunbfYwleSchnPT2eQx+4UmJnBzTFkj7k5Z00JARW1SyCLS6B
         mHYDWTb8wGNwbaa+XIJt5vEU4tWtiv7KI/vRTETYj4k3wd+9hkrB+8i+vnxa5RMnCJy7
         09D2NLf/D8JKS7JTVGsvMzF63/UaU7WJJI3/a1tonoB5/Ar/3oGZHSGGfnx6EN73mNOY
         VB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458691; x=1785063491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7HzRtazZ4L1gYUv2iM5Gcb2OTN39V4RyFH9aAlRzqso=;
        b=R3V7mML4Nus9l0mGH0woCq6/iO4fsIh7D6EO7C+3P6pnbGBePXZ02GToOCt8qk4D6k
         vWLSnzRevH7J+jiXO+2QmM08X/iA61tdiK67sjNNEUWJdPEQ0LU3eAkru6WgIy3HBdBd
         0N5uNhmOateT7GDGgUzbicwOG7H5HeCT++CcStJGp/HSv21hCkmLpU92M6VyI3ZcmL+2
         c5utHrVXRx/4uQ1I+hx38CfXKqt3JyEJWipB+MU5EehW/+AOoUNYzhqL45xgy/LCIUO8
         ljf6/af1BANkk/+iHTUlI127CJIiYaXa5mepVKkGoDlVH+A2An+UjcvUmxco+vWVWl1b
         bYCw==
X-Forwarded-Encrypted: i=1; AHgh+RrD8g3OlZHAItiL7zOtU/VOPVKU/uWCcWWZRy71NQuZrCeqgZn9FOvXCj/1vPMKAQM6VIjz9Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBmnLfImEBJyCI5zDR2RKJ+QJT4MEFs43zeerANidldTkkrS0
	YKP4eRDobtgmhUfQf0YMUbRVs/oZwynEOIsFXGXLouBzRHO+24k3jNn6
X-Gm-Gg: AfdE7cmZ3rUWqNuVB2eluH8GZfX8RXVDY0Ew0ffrfKQVW6u0RHgK1JcaCj4s+XQjskZ
	45gw9lHlLom9+FX7z3iICrOy561Jrn2vEdsQiVfhy117a63wN3jzp3wb5Dem/JhoGgfYicRV7YC
	hm/WyQdbfmr60zdKWPI5M2vQARVmVcTd9g38wDBd4AbsiZinaZ2MFohE6/4JDImm3B/YkWsXQY4
	ZuT9/WTVCJTJLapNdb7w1GJu5PTtPOGL3BYkVJ8QsZonB5UDvyq/lFMd/YlcMY4r4H50yuy3JCK
	udRL2wMJ34s8/bXfZUGqTMvJuBFw0f6CXQBAxEIUMYDfPPeIa8zEw6d0wpeYReuaKA6Y737c9E+
	PSmfAtywLXAKed3k3Y5/ZBCkRARB9e38DYhcfMIVnKglX873Cy+Keo0P8gBoo6+yYQ5yFoDumTk
	GN9540lPt/
X-Received: by 2002:a05:600c:4703:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-4954e893f8cmr84812365e9.15.1784458690612;
        Sun, 19 Jul 2026 03:58:10 -0700 (PDT)
Received: from fedora-dev ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm21094119f8f.5.2026.07.19.03.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:58:10 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: kuniyu@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>,
	syzbot+84d4a405ed798b40c96d@syzkaller.appspotmail.com
Subject: [PATCH net] ipv6: Change allocation flags to match rcu_read_lock section requirements
Date: Sun, 19 Jul 2026 13:57:59 +0300
Message-ID: <20260719105759.558050-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the call to __ip6_del_rt_siblings has been converted under
rcu read lock and it only has one call point
we should no longer block or yield.

Our stack trace from the syzbot reproducer looks as follows:

__ip6_del_rt_siblings
  rtnl_notify (Here we pass gfp_any() -> GFP_KERNEL)
    nlmsg_notify
      nlmsg_multicast
        nlmsg_multicast_filtered
          netlink_broadcast_filtered (GFP_KERNEL passed from earlier)

netlink_broadcast_filtered can yield if GFP_KERNEL
is passed, which we do not want to happen.

Fix this by changing the allocation flag of rtnl_notify.

Also change the flag passed to nlmsg_new. Even though it
is not related to the syzbot generated bug it still falls
under the same requirements.

Reported-by: syzbot+84d4a405ed798b40c96d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=84d4a405ed798b40c96d
Fixes: bd11ff421d36 ("ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.")
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 net/ipv6/route.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a1301334da48..fc42d67e5822 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4022,7 +4022,7 @@ static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
 		struct fib6_node *fn;
 
 		/* prefer to send a single notification with all hops */
-		skb = nlmsg_new(rt6_nlmsg_size(rt), gfp_any());
+		skb = nlmsg_new(rt6_nlmsg_size(rt), GFP_ATOMIC);
 		if (skb) {
 			u32 seq = info->nlh ? info->nlh->nlmsg_seq : 0;
 
@@ -4078,7 +4078,7 @@ static int __ip6_del_rt_siblings(struct fib6_info *rt, struct fib6_config *cfg)
 
 	if (skb) {
 		rtnl_notify(skb, net, info->portid, RTNLGRP_IPV6_ROUTE,
-			    info->nlh, gfp_any());
+			    info->nlh, GFP_ATOMIC);
 	}
 	return err;
 }
-- 
2.54.0

