Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9A4BE448
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494921; cv=none; b=ftEUSk9N52gPYI215945e/Vq/L7TZjqBXTmmx0HazolKhpN9anRd84ztKqtmNKbasoODVicrqE8hfRn7TVqUwOaBMYW2LD/z0F8bf4ct/l27KJdFZSpqWhvvcR6VHEAu/SMU9TXKn33+kcPqeDecRc6mSszXm3TLeqx0htpWyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494921; c=relaxed/simple;
	bh=sHl9v+lheihwEgZ/O0dEfHtSmSz3Jv5vlvaTiu7YrTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eufNyZNKR3DFPNO5VR4qvw0XPm6/2czfncZ9bPDe85nvYcSCJNvQrZrq46UImR8HKh8kHBKGDaF9YTium4MrsRhBcgW2yb19E6gExeMpmjEgsIqxFI0bWQ2KPgUBArwdiTYlr6UKmji/Rv/0zGljsFkATEdDY6B3C2QxtNzsxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/7AwqNH; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/7AwqNH"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so1192477585a.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494914; x=1790099714; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3YkrMstywv0wS0TT5lzuOp8DbRwKNlgNPs9zZNqcTQ=;
        b=D/7AwqNHdA/+ukv4cJATjuWj2uJHWQKDE6X+Da6JQ/jfXF+IowD9QMa7NZs1eShjxx
         V7GiUd/XSiRAJ06mjHr4YgZBctjcHQwEJTaHMXpxm+mNtaQ6HQKIDGSsVtUlUqzeT/Jd
         8OO9+8ZNJVvCY2lk0XSmdmNbQ+pYCJ5QinOldB6PYg9W6EhE+kLrnWGGhuO4XRHq+sGE
         SiPIJfERXUn9xtQb1tuRQP1BaZaAfyyQ1BAD9CilsFcgAgZKKxxtifHpBcBJK0VU0XEO
         PyZA6xkcAS5B03F90v9+AHy0kStKohW2Zw4aY+KayONcxPvxJlpQ7vTejbun4E+/rP6b
         bsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494914; x=1790099714;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3YkrMstywv0wS0TT5lzuOp8DbRwKNlgNPs9zZNqcTQ=;
        b=2jh0gn9ZrV/7FPOVVklX7rB+2WWKKGIqFBAacBL9bePBK7un8emr6683mdh/FtzLNy
         PmMSlcSrAsFTnViRm4eFoL2G+8AkJbwLmNvNCm5k3ShWL7uzwmY+4mI0frZXcUWPmjaa
         r7PkI2b1qXzE1Cui9/nyo63bNwN4teFLfUs4RKfOxpjefaI44KV4Lg8NSbTkKa8zR0Un
         uijM6Z/iWTuh3ea7i7kuMYC0glnhpamCY8ImLCEJMkyt74JsNF6vBDmE+LpzQl/dyD1h
         CHscqH1+C4XZOtuc/yj/jBh2fD4OEiLcFL45C5Wt+xIwD46OAebZqW5rSXYMvsnJP8qn
         CGkg==
X-Forwarded-Encrypted: i=1; AKwUvBx4pPJbtdDVQeLW9kLY4fl0awrcXrTgO3Tyn+8M78m3PrGFH3eCyFtzic0EZCRFJITvUGyb/kw=@vger.kernel.org
X-Gm-Message-State: AFuF++lLoRygYehBP3ypU1XgjkQqYAchXAF8ENlYl7H65A/43jtOzOKQ
	jlKiYL0/vKmeYOWfuz4I9b3b1o/LnYkDfi7PScM5pR4p0dOhvBI3mpai82VnAwJciCvs490fgkZ
	YUCDj2RBtCAR3dg==
X-Received: from qknus27.prod.google.com ([2002:a05:620a:6b1b:b0:93a:221b:f869])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6086:b0:937:1097:feb8 with SMTP id af79cd13be357-93a299f9709mr1253184685a.24.1789494914192;
 Tue, 15 Sep 2026 10:55:14 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:55:01 +0000
In-Reply-To: <20260915175501.391567-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915175501.391567-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915175501.391567-9-edumazet@google.com>
Subject: [PATCH v4 net-next 8/8] vxlan: no longer rely on RTNL in vxlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that vxlan->cfg is RCU-protected, we can update vxlan_fill_info()
to run under RCU read lock instead of relying on RTNL.

This completes the transition to RTNL-less link info dumping for VXLAN.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index dd823d377fd39145dff4098c5753d19494cb086b..63b707deb7fd0ece708f57b4d094df27b078a8f2 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4727,7 +4727,8 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct ifla_vxlan_port_range ports;
 	const struct vxlan_config *cfg;
 
-	cfg = rtnl_dereference(vxlan->cfg);
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
 
 	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(cfg->vni)))
 		goto nla_put_failure;
@@ -4826,9 +4827,11 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		    &cfg->reserved_bits))
 		goto nla_put_failure;
 
+	rcu_read_unlock();
 	return 0;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
-- 
2.55.0.1032.g73a4cd73de-goog

