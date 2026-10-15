Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24253E009F
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792040843; cv=none; b=tXd0xL3lS0GIVbEK8tiPjeydxyecDNir3Atl3c0w7EzYiNfIljuOQfx0DcRiwwkekykMnvF7SgN0+zguAiIwxDlFGPvApQSIjoYSTkkYW1h2VMSn1VMAcDJeYKQcMim86CJx1tEzagote1XFEgrhFNEsUO0EOzp219QB6SMDt/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792040843; c=relaxed/simple;
	bh=5QnK27Mi4gF8Os92Ye4At3N2Dx/p3ENx/C7QLtY+b8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prvm+LqckTDBjItxjIC0t/y9TxufJ/zJaLHicZDuFMXH1K3uVwx7SQbBhvi7txO5Z82BzFxvpNrTzJOrjMB9fiEoTNFnGJyR/oQIQANEm/bZQhAbbKIrTpgi3mCCvM6bydhKgOh6WYwuYlWdFvCk+ciUlfRVjSypr4srxTQFzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rG3eBLD9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG3eBLD9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8ad5b31c7so28393675ad.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792040841; x=1792645641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZrMZ1EzhfMYxX8A1FtoB4N7lHSMJS/8Ps17souRyYLQ=;
        b=rG3eBLD9Q9QV2kmDUtB7TjfJUYRVf6T13dwlx9AeQPMVwBein7YlbLsFpIg7fkKEkF
         iV7pK5MMKaJKoYW+O6QZ+4Bq88Dru0fjz64K707DDqwEUSeI57Gtfx6rgpSbXp30hZtr
         1FPGD3RdfY9TEF0PS9n5h+SkFFeuA3QYayE9TqPkcPD7NRq+fBRno7gSmh9G0s6cBPyC
         VBd+q4ULdU/B5pX7Qs7rreMh/lXSYlGtrzlDwYRwWgUGYkcIM8qzJ985u8c3otqYFm+y
         yAQsdNJeKn6U4CK4CXZRd0PUz0cc5sDdhH0SYNlfOtmZhNhJ/gf/66JwFGMdIsvPZiaf
         EdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792040841; x=1792645641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZrMZ1EzhfMYxX8A1FtoB4N7lHSMJS/8Ps17souRyYLQ=;
        b=E3npERtCYro7o63ls6F8I2MkyfJ6hqyakGpb79VhQ+p/9UpVxKKVVBUaZryanwes9f
         cZKjS1S5DQKTtNe1qWlqhU6neBwbHBK+mPvD+lkc6YijTGpwO0VkKRFrTqqPGuouCttt
         mYtI2hwYq+WybNiBzZGTM5R2F10x/B5VQngObawr6V4Clp5G8RqGiQ520gDoNLA3MWFQ
         KN30diXI14XjPoOAPL8GVhHSZeWgtnhY4yUPWx3fN5dcPQtg1g3Ivo21yYfq37y/EDun
         DCGOzG7C/2FV1GThQlSv8gqLRG9cyzz070t6Hmizx804kshb5CZsOLiOWJjGZnNc08XS
         6uQA==
X-Forwarded-Encrypted: i=1; AKwUvBzOfXvD5PfQp77ta9SIENFdhA65sc2Fg+IoQ6DratvMTloCNV5g2KfaKkXUQZ5jeG0eJ9Ti0Vs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkj0A+nZRt+pEDMhd72JWjCQTxF0DqhcjQy73hq68x1g3nzMZJ
	/m4WFOCDRCvL/gUe3ZkHAyIWMu5v8D7wH4U23eu96q0Z8nfQ1PIpOlmB
X-Gm-Gg: AYBFou36AWMcZF65s3KRQnTPQpAlTiQlTCpKWGivwrT/AIE6haJG3JWcNy2bxVZ9AKN
	eTUPIX599jynx9guwT9niumqfm+NTRlLRhmUe/ohjjkWY1luCReScTlGryYjkcgPNL/YFmQnkJe
	1dTB0yog7A68q0pFsXvWEn3pJXQ5r287qmq41/2n1sfxgppBBlHpyPfSbApVb1Xt8DRM9SMJmY0
	1BqHE5mqLD4imWd1MJAfhYWAK4Z+jwM0PLFz3quEIZGGzOMlzIWhPP98lzJiYwVdS2j4XJTJEXA
	2N9eTdXq+2G2Dgcjz9+F2Ehax7rJuwA7padNBRKywKf2vPpUfcyMS7e5+20J8epPsBYYXjRMHb/
	F25YpB+AuUAneB24NycIaZ7k2SsX7Ob+FI+zqGr9Vw/kzOSmOr00So7le8JgdTuImSW+h8JD71l
	egKnRMSJXWzDdYo4ngODx3NwFp+27WuOHnqOSF7oZJwV7IAzYLj10maahtgJgXgjPsErika5S/b
	H2CWwf8d3aFJCW6Jh7QPg==
X-Received: by 2002:a17:90b:5823:b0:3a7:cffb:8b96 with SMTP id 98e67ed59e1d1-3ab3a60f9aamr15354818a91.18.1792040841080;
        Wed, 14 Oct 2026 22:07:21 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9449ae48sm2548033a91.13.2026.10.14.22.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:07:19 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v4 3/4] ipv6: initialize temporary ifaddr before publication
Date: Thu, 15 Oct 2026 14:06:50 +0900
Message-ID: <20261015050651.1841557-4-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015050651.1841557-1-4ncienth@gmail.com>
References: <20261015050651.1841557-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_create_tempaddr() holds a reference to the public ifaddr, publishes
the new temporary address through ipv6_add_addr(), and only then stores
the reference and final timestamps.

addrconf_ifdown() can remove the temporary address before ifpub is
stored, leaking the public ifaddr reference. Publishing ifpub alone is
insufficient: manage_tempaddrs() can then find the object before cstamp
and tstamp are final, update its lifetimes, and have the constructor
overwrite its timestamp with an older value.

This follow-on was found by source review and was not separately
triggered at runtime.

Pass the public ifaddr and both timestamps in ifa6_config. Initialize all
three fields before adding the temporary address to either the hash or
per-device lists. On success the existing public-ifaddr reference
transfers to the temporary object. On error it remains owned and released
by ipv6_create_tempaddr().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://lore.kernel.org/r/179122559913.434549.12720841717630168470@kernel.org
Link: https://lore.kernel.org/r/179161099665.434549.5858601179492551889@kernel.org
Link: https://lore.kernel.org/r/20261007164548.GA1153540@shredder
Link: https://lore.kernel.org/r/20261012145240.GA779501@shredder
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 include/net/addrconf.h |  3 +++
 net/ipv6/addrconf.c    | 20 +++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index e6764245995f25..6818057cf72750 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -81,6 +81,9 @@ struct ifa6_config {
 	u8			ifa_proto;
 
 	const struct in6_addr	*peer_pfx;
+	struct inet6_ifaddr	*ifpub;
+	unsigned long		cstamp;
+	unsigned long		tstamp;
 
 	u32			rt_priority;
 	u32			ifa_flags;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3bede30d4e989b..df566681226195 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1155,10 +1155,19 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 		ifa->flags |= IFA_F_TENTATIVE;
 	ifa->valid_lft = cfg->valid_lft;
 	ifa->prefered_lft = cfg->preferred_lft;
-	ifa->cstamp = ifa->tstamp = jiffies;
 	ifa->tokenized = false;
 
 	ifa->rt = f6i;
+	ifa->ifpub = cfg->ifpub;
+	if (cfg->ifpub) {
+		ifa->cstamp = cfg->cstamp;
+		ifa->tstamp = cfg->tstamp;
+	} else {
+		unsigned long now = jiffies;
+
+		ifa->cstamp = now;
+		ifa->tstamp = now;
+	}
 
 	ifa->idev = idev;
 	in6_dev_hold(idev);
@@ -1491,6 +1500,9 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	cfg.pfx = &addr;
 	cfg.scope = ipv6_addr_scope(cfg.pfx);
+	cfg.ifpub = ifp;
+	cfg.cstamp = now;
+	cfg.tstamp = tmp_tstamp;
 
 	ift = ipv6_add_addr(idev, &cfg, block, NULL);
 	if (IS_ERR(ift)) {
@@ -1501,12 +1513,6 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 		goto retry;
 	}
 
-	spin_lock_bh(&ift->lock);
-	ift->ifpub = ifp;
-	ift->cstamp = now;
-	ift->tstamp = tmp_tstamp;
-	spin_unlock_bh(&ift->lock);
-
 	addrconf_dad_start(ift);
 	in6_ifa_put(ift);
 	in6_dev_put(idev);
-- 
2.55.0

