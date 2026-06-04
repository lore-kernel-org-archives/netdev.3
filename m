Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2A33C53D
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613247; cv=none; b=hkVX2IFb7dXWISAxD21/V8ie0HwkKeRLPPVz+sv7gpt2c9ifY7HVN78NSv2wrb0X2wAHh7OoeXLyvNvxIsU+UYftxh7B5nxYrUU94O61UpDen7X5FoVmvGrhIXvqz7hbKqbsTrUOw+SFH4WGDktdXwSZYhlftGo42Y74psGqHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613247; c=relaxed/simple;
	bh=MtT4gOSihYpssX1cQ+A4JC0zzPVZM8ThLrix0JO1Zg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GZufOkIiP2h30AkWBgAyqO3GJT/4Eoy20MVZEAX+LJ7xCZuCXbeXZAUN82WOwpdvwvA+iYpDWFkkQERkU2qm231XyMpLN+D0W5F1g3Paq9hxor9mRw2blMnvWHGRy2Pxylo32C1g2VBgXCcb0vCliRmH8S1ZeMSOl03ZCrgxMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0KV32J1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0KV32J1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842688fa7b8so1920445b3a.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613244; x=1781218044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWtlQFcErObgwnW5qWwyAOeNxf6gLpMB52GFsBWkwig=;
        b=F0KV32J1DQSWbOjmaOEYXsuOfg8/bWKV6+Zn1VBzkB3DGGcDYYzCiIFH+WZ7PIWNcL
         ajtm1ntR2ZtfbOq2W8zpziILGV6ZuGAgGQT/rvDmFB1B2ye1+NfscA2542D2WGKY56HB
         Dlwv3AhaCAc/CS0oX+AyMoJTWe58mqEx5gc0Mj5qEwvq9wCTodRN2f/zWM7KiSSM/imN
         DOVKlTsNJUYcPPxP1CIZChlxMT+CvkRc0Vp2mDMApJzlcigkJ88U0H276A6pEZ2T1iTn
         axNmOQ5rkfR9rd5+f3FZhL8RW587UYzYj7Zw9rXm1nGm1kbjCDMdadPfsCGfCx1UYV8p
         SbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613244; x=1781218044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWtlQFcErObgwnW5qWwyAOeNxf6gLpMB52GFsBWkwig=;
        b=NOC0cz/ZFXjHCCG/CqVaN1UjbdmXejhKoWEENZPcWAfqK/Ym3zeNArLcmftqLaDx9z
         nLoAZFQSS3Z7Oupgv5bWvk/PnCkLtHdv4cXOfr3sRATDpXbaZMnBupWHC41GDz2csL74
         PT1+NpLZQx/0VgS3cyc+oiXfEFZaeRtntTLXFljxZpvp2m8o23UYXncHg5JxAIdUdM6X
         3vfiwvZ+KC8NtyWrTLfvEAYe00oEEvyJ+UBHhqBPHAmeEBCicxAcGSr0dGKdf4p8ovIV
         27cAnuPgfJRnCfKhUVzqWpzB6Tn8G2LRXas/D9GskeNgi4xyk8PEATGxsnC03D/V5aX1
         qQBA==
X-Forwarded-Encrypted: i=1; AFNElJ8OVkubo+6sOtcKAqveccfU8S0YIf23TMejO05kzATO/tjRa1uJJ69bRiKWTOVyaeCUfVV0AmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMehPdFRl0kNa5k6apfllVILw4OOwBlQeHsq2EM2M2LwuIEQe
	Ee6xNTNZMZ/Hpv8Yiz/vUC+HOIxsRfUPMq+cRctPP5bRSpTIKR683votEnFpL3zUuy61ndkOtWQ
	5+mn0zw==
X-Received: from pfbli4.prod.google.com ([2002:a05:6a00:7184:b0:842:7837:bd51])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10c9:b0:842:3d30:6251
 with SMTP id d2e1a72fcca58-842b66a945emr17332b3a.8.1780613243459; Thu, 04 Jun
 2026 15:47:23 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:24 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 06/15] ip6mr: Convert ip6mr_rtm_dumproute() to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip6mr_rtm_dumproute() calls mr_table_dump() or mr_rtm_dumproute(),
and mr_rtm_dumproute() finally calls mr_table_dump().

mr_table_dump() calls the passed function, _ip6mr_fill_mroute().

_ip6mr_fill_mroute() is a wrapper for ip6mr_fill_mroute() to cast
struct mr_mfc * to struct mfc6_cache *.

ip6mr_fill_mroute() can already be called safely under RCU.

Let's convert ip6mr_rtm_dumproute() to RCU.

Now there is no user of the rtnl_held field in struct
fib_dump_filter, and the next patch will remove it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 51ba22f59506..380e5eb9416d 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1387,7 +1387,7 @@ static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] __initconst_or_mo
 	{.owner = THIS_MODULE, .protocol = RTNL_FAMILY_IP6MR,
 	 .msgtype = RTM_GETROUTE,
 	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute,
-	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 };
 
 int __init ip6_mr_init(void)
@@ -2746,15 +2746,17 @@ static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct fib_dump_filter filter = {
-		.rtnl_held = true,
+		.rtnl_held = false,
 	};
 	int err;
 
+	rcu_read_lock();
+
 	if (cb->strict_check) {
 		err = ip_valid_fib_dump_req(sock_net(skb->sk), nlh,
 					    &filter, cb);
 		if (err < 0)
-			return err;
+			goto unlock;
 	}
 
 	if (filter.table_id) {
@@ -2762,17 +2764,26 @@ static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 
 		mrt = __ip6mr_get_table(sock_net(skb->sk), filter.table_id);
 		if (!mrt) {
-			if (rtnl_msg_family(cb->nlh) != RTNL_FAMILY_IP6MR)
-				return skb->len;
+			if (rtnl_msg_family(cb->nlh) != RTNL_FAMILY_IP6MR) {
+				err = skb->len;
+				goto unlock;
+			}
 
 			NL_SET_ERR_MSG_MOD(cb->extack, "MR table does not exist");
-			return -ENOENT;
+			err = -ENOENT;
+			goto unlock;
 		}
+
 		err = mr_table_dump(mrt, skb, cb, _ip6mr_fill_mroute,
 				    &mfc_unres_lock, &filter);
-		return skb->len ? : err;
+		err = skb->len ? : err;
+		goto unlock;
 	}
 
-	return mr_rtm_dumproute(skb, cb, ip6mr_mr_table_iter,
-				_ip6mr_fill_mroute, &mfc_unres_lock, &filter);
+	err = mr_rtm_dumproute(skb, cb, ip6mr_mr_table_iter,
+			       _ip6mr_fill_mroute, &mfc_unres_lock, &filter);
+unlock:
+	rcu_read_unlock();
+
+	return err;
 }
-- 
2.54.0.1032.g2f8565e1d1-goog

