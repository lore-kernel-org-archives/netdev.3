Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C7413798
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867679; cv=none; b=PahmRqQzhqg6jWmjqb0V25DuOYP2wDhYsueY8yfnEbQFD56P/vv9wQdLhGFvW+tc2NYbX2fCbweQEN1oSLoZNIBHmT6xWFlsMMHqcWH1CmaTGtddnXyc5crKAmgfg7Dp0EW3qLEXEZ1x/2n7hOIr6SrMxo7lXvziAoEivN5a9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867679; c=relaxed/simple;
	bh=wcSb3K/k15u+UVe7tC1mdNd8EoACds8Qbrbv2Hx8Aw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sp98JADa7bqj4JLjxWeUi8CLVKmIE7UfIGPd3VjgLSqfCvr1quA1e8Gmkr8bf4UQ9LHsZ/sb1OBbWQnWzePrUBSEm/U0Uy1VB1UwKMZKGtuvi869Lai5ywwdufWRpnCQsv/A1x0QN+uTsNo18Lpo1+ZcGVT5Kc3RDBDzUqoLS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553b57612so201935e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 11:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867676; x=1786472476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ma4Ldq9UjxOPbQexWFI1LZ8qoNpbcnRDyoCVpCSFXuo=;
        b=NxMJlrkybTSjjf/sDBPE+TSozv86FL7UAXyIQOY4KAMr88w5CKjKqkz+TlczyW9zvw
         DfHIXaqYmqd4bD5loepDEyawi+fZ1MS/Rw5ob1/sau7CMUcdmlh/z0p9RiMMVSwX2luv
         NshVZsR9NQZqLFy9GtyMQKhzIbQzbNlepo3l4e8ieLGTzzgSZg3XYNqGu4ZOwJlsIRX5
         ia8ESWN2Qhm0cMgkHl72xZJKbhLrjK7VEHq9ap9Ra+WXJwTCrmwVwv3XI31TMQLnJh3F
         Pr6nci6/rJYMt5Ay/lEXqt6HUkd8JK8ElnMGKLI/D5OCk/zQ3G4WV0HuljLScEwGxwxN
         /Pww==
X-Gm-Message-State: AOJu0YyvpZw4PZSYbQnLENGo+r4d/wBJIJ67rUNgL+de3bm5DOBzPFC0
	dLS9Ke+9JwbvK/KPpjO4xUvdP/3J76v1AvrpV0CKPyhvP09dHBnBKdFogaiQ9/RJMiQ=
X-Gm-Gg: AR+sD12Fqx9RePdWEt5RkktRLT6aBL63mcgRfpD4bpM2wrOqE8ZaXqsPTq5qIZCygSE
	GzxvYcC+GGBvDoAEwpkaMbztb+9eAd4rSafL3EgIyVxAcU2rmm+yJaFL0EKUVX+fsRoJ81Hc3yI
	r1+8IPej73Rm5LTFDcV2jrMdI77dPfuOSgiU3yy6n16nbWx3KMtxeKzAF4Wc9GvzxwktDK7GWLC
	ejmK66o5cRsyqjZuhuDr33NBtihzNjejOprhdF+kWBmwt3YiMzrz+PMOiTnF6a2JzgJzj/tGuxJ
	c6kEw6tMurzkpmYZ6hqDZWP60ruYE1qDLCzwQB6suA+u6pH9V6AvyCYfrW6f0forkdayWBwXLUq
	l1oSo9d7rxwkC0yv36bO7KV/XrdmodMgNpdbcN0FinJJXk6EwiHyxby7P0B8LIDtxj/LwutN1gk
	tZeeJVj8Io8XKpg3vm0JTGdCAo3s6nHeHOAsDUZJy7GMKUkpE/+frxWd2hPcdLHRZN750kTi/Cy
	2GguBss7pUu1O/NqkUrgOsLsB2QIA==
X-Received: by 2002:a05:600c:5251:b0:499:4dd6:3cc6 with SMTP id 5b1f17b1804b1-4994e73207amr3320315e9.5.1785867676079;
        Tue, 04 Aug 2026 11:21:16 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4bf5c1sm4946925e9.2.2026.08.04.11.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:21:15 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next 4/6] net: geneve: remove unused geneve_dev_create_fb
Date: Tue,  4 Aug 2026 20:20:38 +0200
Message-ID: <20260804182049.2289754-5-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804182049.2289754-1-i.maximets@ovn.org>
References: <20260804182049.2289754-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only user was vport-geneve in openvswitch and now it is gone.

This also removes the last exported function in geneve module,
significantly reducing complexity of the locking analysis.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 drivers/net/geneve.c | 49 --------------------------------------------
 include/net/geneve.h |  5 -----
 2 files changed, 54 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index a6a8978e3b81..0ab729f055ea 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -2670,55 +2670,6 @@ static struct rtnl_link_ops geneve_link_ops __read_mostly = {
 	.fill_info	= geneve_fill_info,
 };
 
-struct net_device *geneve_dev_create_fb(struct net *net, const char *name,
-					u8 name_assign_type, u16 dst_port)
-{
-	struct nlattr *tb[IFLA_MAX + 1];
-	struct net_device *dev;
-	LIST_HEAD(list_kill);
-	int err;
-	struct geneve_config cfg = {
-		.df = GENEVE_DF_UNSET,
-		.use_udp6_rx_checksums = true,
-		.ttl_inherit = false,
-		.collect_md = true,
-		.dualstack = true,
-		.port_min = 1,
-		.port_max = USHRT_MAX,
-	};
-
-	memset(tb, 0, sizeof(tb));
-	dev = rtnl_create_link(net, name, name_assign_type,
-			       &geneve_link_ops, tb, NULL);
-	if (IS_ERR(dev))
-		return dev;
-
-	init_tnl_info(&cfg.info, dst_port);
-	err = geneve_configure(net, dev, NULL, &cfg);
-	if (err) {
-		free_netdev(dev);
-		return ERR_PTR(err);
-	}
-
-	/* openvswitch users expect packet sizes to be unrestricted,
-	 * so set the largest MTU we can.
-	 */
-	err = geneve_change_mtu(dev, IP_MAX_MTU);
-	if (err)
-		goto err;
-
-	err = rtnl_configure_link(dev, NULL, 0, NULL);
-	if (err < 0)
-		goto err;
-
-	return dev;
-err:
-	geneve_dellink(dev, &list_kill);
-	unregister_netdevice_many(&list_kill);
-	return ERR_PTR(err);
-}
-EXPORT_SYMBOL_GPL(geneve_dev_create_fb);
-
 static int geneve_netdevice_event(struct notifier_block *unused,
 				  unsigned long event, void *ptr)
 {
diff --git a/include/net/geneve.h b/include/net/geneve.h
index 5c96827a487e..ba2c14d61e90 100644
--- a/include/net/geneve.h
+++ b/include/net/geneve.h
@@ -68,9 +68,4 @@ static inline bool netif_is_geneve(const struct net_device *dev)
 	       !strcmp(dev->rtnl_link_ops->kind, "geneve");
 }
 
-#ifdef CONFIG_INET
-struct net_device *geneve_dev_create_fb(struct net *net, const char *name,
-					u8 name_assign_type, u16 dst_port);
-#endif /*ifdef CONFIG_INET */
-
 #endif /*ifdef__NET_GENEVE_H */
-- 
2.55.0

