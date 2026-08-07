Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665847D44E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108417; cv=none; b=fKM2diPHWdFPdInacFkoqhYCu8Zmei3uK11dGAQvahqr7NOMKOw2Q2yTpVgmDtAp2MvI5Ep2oIt0UqPm7bb8zdftV1/fm4PNOeINDGZ6I6Fr+IfCBjRALy+LloArWzJyViEmNNlogJEVba+2Zr+Qn/aVtwGpWCVW8njmS16niOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108417; c=relaxed/simple;
	bh=5d+hRQkdxu+LjRODiJUvapBBo4xPqnB4Ft+vBXpNH3w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WdURNhWU+yntaMV4MATCGVysvpPAZelVycZouVBphy2MzOWmTrnEKzbHXesrLxX41KAxIEpSSLQDZ2pa0LZb+D60O9D0BFpADG6fJk6oZlAKPRN73Bf7luIHeLcaTq/OhuMq56AgVfCDJsaFoHon79Acyig8WsA6t6dK90anPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdo+oygW; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdo+oygW"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so30702575e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786108404; x=1786713204; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HGYHTnBNWXBO5YtuxGe140ai7SrQVWiUjgzwen/fgVg=;
        b=hdo+oygWe0rPzp23ojuSSEtFbTeMm7E681KX3KeFipmGfzRrNtTzybEPraxuTxUwx9
         o8ZyoDq68Pj+F7ttitldpfJYMXiLSkTqa67PIAXERWnJS4+5DxkAULhnI+cE3PEY6z/L
         twlKWWEHbhskWq+chjmW39YFLey+0g6maDT0BQwdjIpot8LNu02ZQkEP7cRrUlAb+XsX
         pr4dH6WuEjx2W/5Nh3MalEpO4fgaDttiRAPseJzhmV5USkl6CEGkHkfI/M3MdayhMEMf
         tsIScd4NQvGmPXJOaT7HfVS372yVFYY15ZW8Hz3Te5OnKMbteFLkIknXNJq2Z5nAvS3x
         XAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108404; x=1786713204;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGYHTnBNWXBO5YtuxGe140ai7SrQVWiUjgzwen/fgVg=;
        b=V7uEFhf/2fMntzLDM/mW/FY2q61APwylQ63wyLoglff1UeN54blBHLEv7bVXA+R+Cb
         cbO4VWXHQrq0WpctoFchYJS3JuJ85M3d3kPgxP3b6w4mbx6y5TO5UVWGfWfjwmcBPN1A
         90gqV74Y0aP8gxV5ey6Ke5UbOfxEiJh5U/l8MPk8gyCvV2YO9yohL/cWTSJNlnuvm2gu
         xBPuIsSVNbeJdjflH3Bv/6iyzpGvBxUv0CVRvvWOcutgQ0Nt6WwwyHLzhshGni0BVN3T
         +gnPbPwXGzO3dP2xU7dbAg7OFhNMuxL1Eh29lbO8vT28bVOHkN5XuJ9aWw28uoKfkjGG
         5Omw==
X-Forwarded-Encrypted: i=1; AHgh+Rpem3PrD05ArZwOODUiU8xrQuDNEjDZPcp/xLr/H9LwhozLzXa/J7MqmqVsZfRku0VoFKtzqtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvKgswrh52yZjXkuEMvh9Tnw6K+ds57R8f9YRuwC+0PGbY3ZP
	sTcNz8WM/ArT2Hm0tA/Tl2TscnkngBqp3onDvy72ZgmKTeh7BLz1NVCKGDWgC4luojAy3o67+jl
	eYQ==
X-Received: from wmlz10.prod.google.com ([2002:a05:600c:220a:b0:487:3739:c5c4])
 (user=pimyn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:840f:b0:493:cc25:85cb
 with SMTP id 5b1f17b1804b1-4994e71edfemr292204985e9.8.1786108403646; Fri, 07
 Aug 2026 06:13:23 -0700 (PDT)
Date: Fri,  7 Aug 2026 15:13:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260807131300.2677228-1-pimyn@google.com>
Subject: [PATCH] ipv6: addrconf: drop "BUG: " prefix from pr_warn()
From: Pimyn Girgis <pimyn@google.com>
To: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com, 
	Pimyn Girgis <pimyn@google.com>
Content-Type: text/plain; charset="UTF-8"

Kernel warning messages emitted via pr_warn() already have the
appropriate log level (KERN_WARNING) and should not include manual
prefixes such as "BUG: " or "WARNING: ".

Explicit "BUG: " prefixes in log strings can mislead testing tools
like syzkaller, which scan kernel console output for "BUG: " to
identify kernel oopses, panics, and fatal conditions.

Remove the manual "BUG: " prefix from the pr_warn() call in
__ipv6_ifa_notify().

Fixes: 2d819d250a1393 ("ipv6: Handle missing host route in __ipv6_ifa_notify")
Reported-by: syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ded267b328e950a7c0c4
Signed-off-by: Pimyn Girgis <pimyn@google.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f6fa2715b450b..8c714b4c0a9ba 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6318,7 +6318,7 @@ static void __ipv6_ifa_notify(int event, struct inet6_ifaddr *ifp)
 		if (ifp->rt && !rcu_access_pointer(ifp->rt->fib6_node)) {
 			ip6_ins_rt(net, ifp->rt);
 		} else if (!ifp->rt && (ifp->idev->dev->flags & IFF_UP)) {
-			pr_warn("BUG: Address %pI6c on device %s is missing its host route.\n",
+			pr_warn("Address %pI6c on device %s is missing its host route.\n",
 				&ifp->addr, ifp->idev->dev->name);
 		}
 
-- 
2.55.0.654.g21b8a5bc05-goog

