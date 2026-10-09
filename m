Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BB3EDE4D
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524466; cv=none; b=pmcMuDukrcLc6K8D/8YNaVH8tHYSqYyTnV8Ec/71fyM4NtpWxURkts/9UuQ2RbzukByrMY/DROHYEG0CRiBwgvWQwQqabdkG5O+35jQA/bxnsDczcOeCFo39/QfvCYKscpCX+VwrP7s3G9LoMfJVKg3CkVkBXdZjaDYCs2Uzbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524466; c=relaxed/simple;
	bh=ryJiLdCZYKDRrZJ0GmbFPL6IPmKh0Xv95mN8BwKTmSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqF3VVf7cliioSXf6OV5IcxDNREBTc4iBktrLDlESTwXn/D0jIiA0wvJAbKUYKxMWhdlR0qnx+QcHUiWTI1uK5ouAbUtbD7Tex9YdCvUXavEcilK8BN0Vip8G+ayeLa0iokZJvtW2WpfzVG63OxqXrB3IYhYCe55bxZvqMO9BdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHTNId88; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHTNId88"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so2757538a12.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 22:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791524465; x=1792129265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UYqAcwLoVqq9IZplP9tc0FEh/RKvgixApCPDYec8LCo=;
        b=dHTNId88jy9U2vKLeH7Q6VD5HZ2+/nNpWi4cTYd8WMRHOuZKmOJJj6rZsm1QAD1o+M
         n1BMxHd8ncPugVIPy6d55iiICSVsYCEycBKLCf4/K/pDxLyubd+mXlUzQOc6yn/tyUl0
         EkCg7aEKDjG5GefyhUbPie70okg1rae1Sp6PozmXCBuOyjqKyTAkwXazjFLVgmXpV+iM
         NKDXyzmcLgV4wKONPI9x5l/PQShNY+Yj7xRcgh/oX+eM3sxZI0I8F+mAiyho+0NkkqYC
         ilSzxJuWSPRfhw3dODtpyzeZlEnLk96750dhnYWERrDH+U1dpOQKfQFEufPndnFPWJ5X
         CM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791524465; x=1792129265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UYqAcwLoVqq9IZplP9tc0FEh/RKvgixApCPDYec8LCo=;
        b=sY5OMlTQoVzROZtqM1jc6ECRW/cqtVCqMQE54X9cmJFPF7AypmWdIeVXr+MDuZurIA
         Tyhia6w3oa5UUe6jPl0QPZjgO6/lNtL92qTWgMwAhHIEuIru3209emwvoz6VJZhNm/k7
         59GxWwg5BkKjr/bJYtFTcv6UMWso5XkKvChxUm2uaoslshRW7QELZtsWqjPHQILu9/zM
         9a7x55aqV99j9+7dahUl4MjxyHVZCoF1olccf8GvGoceJ/t9eDjTqZE4F6+OMIV8Dk9O
         qcqizEX+tbWSfFD+b0rONovuG/1OrgrTcDpvTSenE300F5q06cNjsabp+ZBE2NUMIWik
         yAjw==
X-Forwarded-Encrypted: i=1; AKwUvBwG2DBTaHytWjffmtb0VR0r68TkTbGONgOvmN+52d4aruy/edayroa0Fg/9qmSetMcXFkGUye0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmOhymBHu7rXUKCJx/nuuMJSLjcSvsJuD82mdM9dyagPgMIPan
	lrnEokOILYy6jXbJa1yrRysSOoWkKX62GAU0lSNSHZ67+hlV7f4vyznC
X-Gm-Gg: AYBFou15dun+2R4KIf9Xedpur4dKttElR6D2rpM6/paqV0gMw/2mWufeMwRTt0f+VP8
	kNxBHfUAcbHpTv0yl7yC68Ap7njj+b78KUcedrjqHA2jxyafe9MWSrNGdsY0bICMh7Gq3mwnhQI
	6gdfpEgNG0GvkmDPm0KfWumxrVENQYlW3IveA6riu7I/eC9pXNoKxrjTcvdG3OqiYGs/R4RAogz
	Qbh/DhIRhn3egSufVwhkEbNP+EOzWuDliKTiJYZT1Lqbqwc8UF0cEkKZdW/WlybgF9xAPEzsphC
	KAYe56HuGgQncZQGWy6YxnrDyetME4JypBf2QKxQWsxBgQcQgZaSdCh/IBR7vkkkndNt9KvjnAX
	zxJIjtBp6iiMZURNQMq+cwnk6EM/KXPpOzfNggf2HqwmKhg9AWDu6CygqQ9BKGEfMNlMDVriTiS
	/0aGWddENI9oql7T3kDjXoiU0HHV2Da5ppH4USAPCY8ABOFf4qkGhNLXjoUjolgwxCe6/G0BoqK
	VVevHWpK/I=
X-Received: by 2002:a17:90b:384c:b0:3ab:189b:6985 with SMTP id 98e67ed59e1d1-3ab3a9a8d5bmr914195a91.35.1791524464909;
        Thu, 08 Oct 2026 22:41:04 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3690474esm2028695a91.0.2026.10.08.22.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:41:04 -0700 (PDT)
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
Subject: [PATCH net v3 3/3] ipv6: initialize temporary ifaddr before publication
Date: Fri,  9 Oct 2026 14:40:42 +0900
Message-ID: <20261009054042.272944-4-4ncienth@gmail.com>
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

ipv6_create_tempaddr() holds a reference to the public ifaddr, publishes
the new temporary address through ipv6_add_addr(), and only then stores
the reference in ifpub.

addrconf_ifdown() can remove the temporary address between publication
and that store. It then observes a NULL ifpub and cannot drop the public
ifaddr reference. The later store survives until the temporary ifaddr is
destroyed, pinning the public ifaddr, inet6_dev and net_device. Later
device deletion can wait indefinitely for these references.

Pass the public ifaddr in ifa6_config and initialize ifpub before adding
the temporary address to either the hash or per-device lists. On success
the existing reference transfers to the temporary ifaddr. On error it
remains owned and released by ipv6_create_tempaddr().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://lore.kernel.org/r/179122559913.434549.12720841717630168470@kernel.org
Link: https://lore.kernel.org/r/20261007164548.GA1153540@shredder
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 include/net/addrconf.h | 1 +
 net/ipv6/addrconf.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index e6764245995f25..848bed306ec98f 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -81,6 +81,7 @@ struct ifa6_config {
 	u8			ifa_proto;
 
 	const struct in6_addr	*peer_pfx;
+	struct inet6_ifaddr	*ifpub;
 
 	u32			rt_priority;
 	u32			ifa_flags;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5a7e7129d43466..699d058f5c7868 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1159,6 +1159,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 	ifa->tokenized = false;
 
 	ifa->rt = f6i;
+	ifa->ifpub = cfg->ifpub;
 
 	ifa->idev = idev;
 	in6_dev_hold(idev);
@@ -1493,6 +1494,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	cfg.pfx = &addr;
 	cfg.scope = ipv6_addr_scope(cfg.pfx);
+	cfg.ifpub = ifp;
 
 	ift = ipv6_add_addr(idev, &cfg, block, NULL);
 	if (IS_ERR(ift)) {
@@ -1504,7 +1506,6 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	}
 
 	spin_lock_bh(&ift->lock);
-	ift->ifpub = ifp;
 	ift->cstamp = now;
 	ift->tstamp = tmp_tstamp;
 	spin_unlock_bh(&ift->lock);
-- 
2.55.0

