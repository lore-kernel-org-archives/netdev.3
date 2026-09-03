Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545F49EC60
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437339; cv=none; b=L5uQJbGpi6ccPfe36SO4e4b/G9xXSq02BFELsHwcTh9mXFwscgs8g68R+H75LPxMUdGyiDnRG5V2Id8NFkpiAD8Qo3sWeblDwxwvmNjcxZnWfhmCDu3m1T8Qr4KrcvgfinDOhMjmegLcZu2fQ7jR5qiRYHa/eZdKGaLWgTksLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437339; c=relaxed/simple;
	bh=I/sSw7h+i5cOyAs9lx3z5D8OIgU3ZvASCdHiXk9+M18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NZN7E/aBiudzDWQNeg/5g+xug+OBAnsk5WkS7sggvHOotSZ+g/9FzApzEOfRAaBEc9zY6L+inRHB4NsKfxtrjqKUCVIrSxu7b6BWMf7XnNo6O9s1uiEDfT+Wrc7J1atFd50o7FNUWRofbyHZ0PeK0ooZQsCkpbRu2QxQbaDOg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ppNXRa/4; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ppNXRa/4"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9390ca1a9abso368233085a.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788437336; x=1789042136; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b72Zt2INziFmaF3+3po+t5q8VOugMM2yEty74rRjZVo=;
        b=ppNXRa/4qbeYq6dvN005gBm9Rp7uI2NlcpFas2fF+4FhnchXdKAnWgxWEiuA3mR1cM
         U//GwFt8CJSoaVzWTbKhgU/3yHqDnrWunJoEY/JJ2ZI7QaEVUGA6cGa4lLD0kII+ErYQ
         xqaez/Z53wXPAX8ilvhvUwByJ+nl6YESpzABag8d9ZzdT+lKM69D65qrvGG5kxll6POp
         NOnOiwU1y4zwLAua4brhacib8VglZmuA9lOrRRW7NibvQAwrENlziNGaKUiPWqJrS+TQ
         HoUM6o6y7CiB2+mpeO6DBnxv7mBIQavDzzrallR4zPzDm25loVLIO14+LymNid2FIGt/
         evkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437336; x=1789042136;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b72Zt2INziFmaF3+3po+t5q8VOugMM2yEty74rRjZVo=;
        b=PA/VxwpaL9K2ZOzXY9cfHnQvEPgK/YBAkPywvGnPpa7XwV8VOF0SE0Ki6AFK2+xHO4
         zMlYpmdiX2Osu/Wz78IJ75FMZYjwzJxY0q55LbHbxVwOnhDnZVUs5O1n1mt9OY35h5FY
         y7yhCfZzCzKFqYu45ghpCzq9XN/NSMT7ZVWoF6Hy/F2PVQZPHPI3SLUt2QElbTe6uALz
         xZfPkd23tHScUNfvhS7joK3a+w/nWjmAEPBNgzRPyCk5KWS/todXkVJ4p3pM4IqdxB2U
         s5iBhDbMjMhE/Gi44lFaRKofHgdbwkS7mJyBKeim7e674ybuEoiJHlejpmfY6DL6gKTV
         LUkw==
X-Forwarded-Encrypted: i=1; AKwUvBwpLcb3U3ZvkZ4IO35Hb/GTz1lhFZGOuXHKgVrkO020SmUBJcfD6OddytDNgESeeH0NkdrumU0=@vger.kernel.org
X-Gm-Message-State: AFuF++ndnxLkWHAGPLMoxlnA/XPgSa5i9egTAWsoUO5CM09SgZ8tzYWR
	p0P5Fjt8YaZs/0kDEUELACq/AV2J2q2Mf8UzaHGPvUPG8llajK6/4eUMJE8ZixETsRDTMSVvx2I
	mvwLMpEfoMj3JjQ==
X-Received: from qknwc9.prod.google.com ([2002:a05:620a:7209:b0:939:61d:40cd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:400a:b0:939:761c:4f59 with SMTP id af79cd13be357-939761c5ee6mr205358585a.16.1788437335886;
 Thu, 03 Sep 2026 05:08:55 -0700 (PDT)
Date: Thu,  3 Sep 2026 12:08:40 +0000
In-Reply-To: <20260903120840.1024153-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903120840.1024153-10-edumazet@google.com>
Subject: [PATCH net-next 9/9] vxlan: no longer rely on RTNL in vxlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that vxlan->cfg is RCU-protected, we can update vxlan_fill_info()
to run under RCU read lock instead of relying on RTNL.

This completes the transition to RTNL-less link info dumping for VXLAN.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 453cac5dde67ffe969edf9d3bdafe834c05632ad..d197f9bfd6c3f6a9ce0f23782f665ed7d75c026d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4706,8 +4706,14 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	const struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct ifla_vxlan_port_range ports;
 	const struct vxlan_config *cfg;
+	int err = 0;
 
-	cfg = rtnl_dereference(vxlan->cfg);
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
+	if (!cfg) {
+		err = -ENODEV;
+		goto out;
+	}
 
 	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(cfg->vni)))
 		goto nla_put_failure;
@@ -4806,9 +4812,12 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		    &cfg->reserved_bits))
 		goto nla_put_failure;
 
-	return 0;
+out:
+	rcu_read_unlock();
+	return err;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
-- 
2.55.0.970.g62bdec98f9-goog

