Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91673E5EF8
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524458; cv=none; b=gZAWWDQG6G7b5byjATrN8wa+dPAiufx6wfLDVCJHUltfVYtyZKpRqtcQOAUxXgnzuKEZECS+OAiDpkWQppSxY88vX+D/K+Nlh9oWCZhMK4bh3l8s1l7cmZDThOQtnhhU4OKkGX/hLfT8j/FojAO9zOj35sgzV/ymuTAtNDn3H6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524458; c=relaxed/simple;
	bh=MJhf/VdVlwR4/z1tqw+ESVPZyrpQOjiiuMxVZCsI8gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1DhzUw6FymnukhS43vHfTR8qKthi4dNWe3lEw95ZVj6ni8M2x0FC+M+C75KSwJkXX6UzJmRMV/ADM0bj5Sno92OObWj4wxj2PP5XyeaMM28ALVPbGTBpTFnf5H+Tx4kwHh5w5qjIbi/ukJKc0b2kLt/zDOINIp0/iYX5gtdymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ID1Osszv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID1Osszv"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ccca948203aso2180760a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 22:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791524457; x=1792129257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYDcawsl/q6WnSRicggMNThMT7mmzOe7cZcZv/tuVvw=;
        b=ID1OsszvROSLigPfmbh/ftT8d2CfZqzP9bFi5XVjdQNQUUookgLY2RVaIFRhKXL+Sf
         0+1iW1rtiXqrY4r8YHq5Bqdc11gnQJk5ka3icEKozsrDAXq6PX/ynWENVwxEeWrELi1u
         C45ioX08jqlfQJ1AUWUNjpl/JYf5wbD1DGnpuNyE722v0NkRbqMg6Wc7phgGRNC8easZ
         JKILsX2AAyfBvLRnWQx6lUOBpA9sMDMslJ2rtObTP0zd1TZlo+4E8A0ekn2KO4RUM9/S
         r2BhSqxi1FUwo7oV3zR3WmZejpOi4j7SvwZ+6j7lLEt1vmnlPEL1G+PRyroxYzvx0uUO
         5W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791524457; x=1792129257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mYDcawsl/q6WnSRicggMNThMT7mmzOe7cZcZv/tuVvw=;
        b=J4FGpTOcr8qqs/7BDc4S1nOfQTDt3ow+88jZcT0tfPow3HHt/iYfUVVr8Iv6lne/z6
         DMeVR8dTr0tby5fNsj3TRYUWIOiBBdYPAnP8DIFbZM/hDrUz/XHOHWRWuyNiPf948fR2
         eveMNAZq4U9vRlXyczzLn99epsWLxNI0DgJmPaZAMOwgAus5CKJHmg2onWdXo4A5+zfG
         L/Ea+4csS+3pR7nBJA9mjRcsoQkKij4xMheNzqLsh91XkLOYurwRcKI+ysSQFXg49SmZ
         Evg8pzUgG6x8LBpFXfaNCDIob0MoyRVlXK/j5psvK8d/2h6H3+id/1HRu11/u81e7KEZ
         czOA==
X-Forwarded-Encrypted: i=1; AKwUvBzIT/4qkSVzmyFwJ9BNKCp0jbFDJph8IXVdUuHrY3cggnoi2iN6gpRez6fxTsQA5wK5vNWSGew=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGnacpbKH4pC4Q76U40w2+K4BeFAcDlIJN/WmGAC1oSAHDpZYj
	419KLsR8mDOJDMHfc/6X+cFiSmCHXLVw2HyCnU/ox09sWZ0ncp52VXNc
X-Gm-Gg: AYBFou0fUdTT62Vb604ipJpYszyL0TbL5pyz2RtS/Zq37YrvpBqOzXOhANqv+FLW+j5
	aZHTgmcHeqUqjLyOfGze5ncDOVhtTWdE+Rb6dJpJfpWyGx1/PpBjL4/HGjHSBMSN3Rb2n1W6zul
	kqKDiJhA5iiHzY9MqoUBJJUsVkMNxdDLEWLQzhHZdZ+HWHhYXyGbkL1QVvRuxR2AhOYbaccRY0w
	cGUt8LT/+aKbAXn3aGNXl2vyu4oe+oA7F/M13m8CoTbshqjc7NM9A5V9on53BVCZaCUAm7OPNqZ
	r930bu8Cpz5bEo+QXaznx7mlnRT9teG5A0aHDGK6hE0Xl+fJMobWp7AZ/XdkA65whWd1ShZHbhq
	epfVUVB6986c3t49FJHXkGDco9d8wzItU92M7WjP1CNjPWoC1ZarqilJGGPgUx8N0EqPy3zPVjP
	beVG/VHOU2eRmAHr9ffUrmvXq8nFdGDh0XCT/M8dX5X4Y76emTc5lvxvr8Ls5Gy0R+fxJs8Kmar
	fZY9tvw/O4=
X-Received: by 2002:a17:90b:17c8:b0:39e:6c69:7777 with SMTP id 98e67ed59e1d1-3ab3ac63cc1mr876888a91.32.1791524457160;
        Thu, 08 Oct 2026 22:40:57 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3690474esm2028695a91.0.2026.10.08.22.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:40:56 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v3 1/3] ipv6: serialize address publication with device teardown
Date: Fri,  9 Oct 2026 14:40:40 +0900
Message-ID: <20261009054042.272944-2-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009054042.272944-1-4ncienth@gmail.com>
References: <20261009054042.272944-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_add_addr() checks idev state before allocating an ifaddr, but
publishes the object later. addrconf_ifdown() can mark and detach the
idev between the check and publication.

This happens when a non-loopback device MTU falls below IPV6_MIN_MTU. A
forced interleaving published an address on a dead idev, and later device
deletion waited indefinitely for the leaked references.

Protect the dead indication with idev->lock and keep that lock across
both hash and device-list publication. Use READ_ONCE() for the initial
lockless state checks, then recheck both dead and disable_ipv6 before
publishing. If teardown wins, reject the unpublished object.

Fixes: 8814c4b53381 ("[IPV6] ADDRCONF: Convert addrconf_lock to RCU.")
Cc: stable@vger.kernel.org
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv6/addrconf.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c90ee6dd7446cd..77b3b1154d591c 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1095,13 +1095,13 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 		return ERR_PTR(-EADDRNOTAVAIL);
 	}
 
-	if (idev->dead) {
+	if (READ_ONCE(idev->dead)) {
 		NL_SET_ERR_MSG_MOD(extack, "device is going away");
 		err = -ENODEV;
 		goto out;
 	}
 
-	if (idev->cnf.disable_ipv6) {
+	if (READ_ONCE(idev->cnf.disable_ipv6)) {
 		NL_SET_ERR_MSG_MOD(extack, "IPv6 is disabled on this device");
 		err = -EACCES;
 		goto out;
@@ -1168,14 +1168,20 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 
 	rcu_read_lock();
 
-	err = ipv6_add_addr_hash(idev->dev, ifa);
+	write_lock_bh(&idev->lock);
+
+	if (idev->dead)
+		err = -ENODEV;
+	else if (READ_ONCE(idev->cnf.disable_ipv6))
+		err = -EACCES;
+	else
+		err = ipv6_add_addr_hash(idev->dev, ifa);
 	if (err < 0) {
+		write_unlock_bh(&idev->lock);
 		rcu_read_unlock();
 		goto out;
 	}
 
-	write_lock_bh(&idev->lock);
-
 	/* Add to inet6_dev unicast addr list. */
 	ipv6_link_dev_addr(idev, ifa);
 
@@ -3897,7 +3903,9 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	 *	   Do not dev_put!
 	 */
 	if (unregister) {
+		write_lock_bh(&idev->lock);
 		WRITE_ONCE(idev->dead, 1);
+		write_unlock_bh(&idev->lock);
 
 		/* protected by rtnl_lock */
 		RCU_INIT_POINTER(dev->ip6_ptr, NULL);
-- 
2.55.0

