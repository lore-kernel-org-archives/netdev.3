Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937246EF72
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983592; cv=none; b=hlDKFD5eoUperKZi6OApTvVeZ60CEN7P6L7Hw00hoANzfdLurDc7PNKNMtHQmj+1p2Rcf2OWBf+SgHfGK4GmGcTlhdFcluqeLMbQ9peLCu5iabD451KZXH0/wfhFbqnXCBWr7FBPWT57gdPae1WavlVkMcbr829W4+f3gDQ6azI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983592; c=relaxed/simple;
	bh=Kn8Sqg3MCF+ZAhhwHPR4OX7VWS71WUpLjOUZtRczz2s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lmz1mAOYw7+Cmxmyf34RCkwfs7u2sWjr3PJO/ecdOe5geN3jnYaSXd0RlgKSosCDmCnKLNW37n94Y5xYqbdQyW11tEdHWzlwscxoAsAFnIB/FjV8zTYS6JugtZiKVEDLIbN1vpJcgIrNHGV3SVMN4BNjtHzzJlonfij2TGgqeYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASQgcKJV; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASQgcKJV"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9390a2c895bso206479785a.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789983590; x=1790588390; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mlAd5pVjz3GHh5HVWW7qo4VxebOVdwoeCM32zrjzZwQ=;
        b=ASQgcKJVjlN4OTGwC9gO64AcjBq8h1n8Cqf1iNex7B86TDR44hchLNwPHF2B6MiVFk
         E3fHDtu7JjOwYA0xZdyPtAWUf7siE6KaxFo08ah7yx2TnUSJe2N3yW0gXLkKkeMySNTE
         bFE3eLhVCil5iYe1/39LeI1WtCIiB5Id6aI/RhbT/a/66tjWI08g4Hx1fX34SAeAUxTe
         R7Y9MWhtq68HEybAF7lYI8N+eubYoMkcr6jvKr9sgJ6/JwKCf/+D/fksEu57OptC2BWF
         3owon8OH5fum6h/JDfvn1707jbaoxXUQNwOXrcEaV8LlK3Nwenecr91Q1xbFJL1cDNTB
         5reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983590; x=1790588390;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mlAd5pVjz3GHh5HVWW7qo4VxebOVdwoeCM32zrjzZwQ=;
        b=tqZeioGmby12nRRvlMqRLQoqo/O3h0/TkaQSU+fy+BkvgBXz0ubD6mjvP+I4kEbwTP
         dBT1IBtIPs2Rgq4DIIz2XYdTaTd8666k1IUepeKL6Mz8XnNJscB+7pkGHZnNn/5PC+/h
         b4eQq2So1Yj+NWcyUap2XcmZ8+3A4wxu+qE/cAQf0SphpejD6y5MimNYRpNvLR/Fx5CV
         HQk7kpcCXQmPuwKXljab3RwqclQgJLRajD+ytQOY9Rc1k2XclLUs5M4W0qWCZ9Ogm8zy
         Y9jgRlDQmVUJtbwl1MWzSSL72ikFM3VnmBDeooQRNxyjX7JufOY8gbKHxaaOI+dAkovc
         l3DQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvZsjoJyMrvaZXvDzIeErfw6Yip/A5RghYtdOUmkkVibguDCljo9cKR+G5TLY0v9FxnCxKCI4=@vger.kernel.org
X-Gm-Message-State: AFuF++nNxkAvv8QNKGM/L9AqJU82PHi6qhzecsCtObfDMSAyLI9u9az7
	NXbZS9fpjo03yOGZfGod+49lBawvFPX4Lh9oqX6gDtiV++xXR+1yDgodyQMAL8x9UbPmMsUep0M
	X2XmAuQX4KOvufw==
X-Received: from qkbo18.prod.google.com ([2002:a05:620a:6dd2:b0:93a:1aae:ff42])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4102:b0:939:acf1:dbc1 with SMTP id af79cd13be357-93bf55589dbmr928452485a.23.1789983589766;
 Mon, 21 Sep 2026 02:39:49 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:39:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921093947.477658-1-edumazet@google.com>
Subject: [PATCH net-next] netlink: remove dev_hold() and dev_put() in __netlink_deliver_tap_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__netlink_deliver_tap_skb() is called from netlink_deliver_tap()
under rcu_read_lock().

dev_queue_xmit() does not require the caller to hold a device reference
count, and the device lifetime is already protected by RCU (the netlink tap
is unlinked and waited for via grace periods prior to device destruction).

Remove the redundant dev_hold(dev) and dev_put(dev) calls.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netlink/af_netlink.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 1e594baf7adf2930096f290b898d80bfa6aff4e5..6d2530e33540dce6dfc3c6ef01463a040c72812a 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -293,8 +293,6 @@ static int __netlink_deliver_tap_skb(struct sk_buff *skb,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return 0;
 
-	dev_hold(dev);
-
 	if (is_vmalloc_addr(skb->head))
 		nskb = netlink_to_full_skb(skb, GFP_ATOMIC);
 	else
@@ -310,7 +308,6 @@ static int __netlink_deliver_tap_skb(struct sk_buff *skb,
 			ret = net_xmit_errno(ret);
 	}
 
-	dev_put(dev);
 	return ret;
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

