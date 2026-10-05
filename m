Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4764AB3DC
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211216; cv=none; b=s7e0dBfTS5hGQTr3A3f8zBhxpB9uXU/Xw3xvKKbH/TfDhcLfrYM6aE2u8htWJDPzld0toXoDDEh5DbFv+KzD4lCx898OCNo5tyi/pTVi7zFvv93DWBRDPq2OmeUCOQcvKigjNQdtqu+M8sXs9/qcs4d2vyW44+6OI9DwTFWxO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211216; c=relaxed/simple;
	bh=RRWozVHTotAkW5kYj0hU5Xgt5Xu3zoj4m11js62A+Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzhIPdtmyVeym83P3E1fkBhNKi1yZA+GNwE67OkTxQFvlMpDXNJ39tO72p+kBib3euje4F0BBt2FMcpC2b3C3V+cHcMHVplpuAAEZXmPV12EmD8Fvxz9eyWD+dbnsOG2s+HpFTs9CdlJSPoNgAOBRFisrwDPGsjyvgfec+NHhcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Eaa2vtHt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Eaa2vtHt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1728d8dfcso9523165e9.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211201; x=1791816001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYtXcI173soT5vTdt1+eussUhxIt+D0gw4zaR9j1Ifc=;
        b=Eaa2vtHtArGw+c0LU/cidC5sjdu4dMfFYrJKwjU73xNWJlJ8mStNxfnInDwUE+/V5F
         qoIi4xmTrG9f7zuV0+1XPvw5LKZm4W0e01EXJYkOXPu05zA21mrLlSNSNxLX+KZKrQiD
         WaawX5HgxH9wCHBZPLe2q63+CByHscMZycDeFDST7Vl2i/gIxpaffQ7LiJEgC0gmquKU
         FzW9fg8Em8yA/QbpQXUFCccLBYFfPD4imwBPrdARm4upEnKg5FpcDDxM0qLdp5cYD+lP
         hjmlUD5a7yW74vaozYRw+uC/9sJkkAhxWqELloD5v2nLVCZyuOAxiRC5+JFxu38/V6yd
         eIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211201; x=1791816001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EYtXcI173soT5vTdt1+eussUhxIt+D0gw4zaR9j1Ifc=;
        b=aOBI8+uWcUHs+Km4PxAR+MoquwgHOQ78iMntN7FEGf4b9Av2fLBF5m8oAeGOtGjMP5
         Fewo/MxjBGMJMZ76uFlQh6nSBmktGUMftHboupu4Mreg3ExjPYLofDWBk4K8qDvfv9we
         kef1VngSufe1Z9oRg76Px6u0djMQvH9fXmcSXTcCjWA/W0cD0B0LjCYT+vE7hSYGRSlr
         zhf9A3+O2cXoQxBsKaxjoB+nh4Mo1B7f22LwY4dzCe3ZpdVqT559X1hgkh9Gojzj6V7h
         GfyqV5Is5lYp2kSviqKgFqEeCbmjFm0LUAINgZ9ytGs+gsVvGmrwH9+X6b0e6ajlgI20
         wKHg==
X-Gm-Message-State: AFuF++l0cCTEXiKSUCoc4qWJgmOC7QU+FBL3e8SuXTwfWN8QVoRHvOg2
	oCR+jlWu3bTEbYf8O3BsUoU5d8p9ogfTJU+XVsE3YZZRjpjCDtc1UFIPHRwoq3hcRewZeM9rVxA
	OSkEc
X-Gm-Gg: AYBFou2tdwUZeQluavvxHqfReDL1d/R7RI0JNQ64Ztlg4SIMikYiJt7JMi9EbtNXJFi
	+yxHUYf68F6oSiz7fyFb0840SIgal62vtrlLQ3nm1Q1edKRhzcI3xlJLu9aR+7y6utmN3UneGlD
	tmb37xVsPGjHwqi9RK89A7edWNW0X2PVIjRr+TOWoC+xVwNBUHyUNsFKk7fSVyvx9MT2o/3UTr+
	LIeirtezmU2H9HT+/aTU1v+wqlmwUY9nYuqk3j5cT7ff5yY8rL2jd1mRKnYEXwNn1YLvP47ii3v
	uDcqCq+rPrZ91e9AJ1wfH6qIGETmTaOrASC1L6BRyUPD+0HRuPniglBsWvzQeJK4xqNh70p8s2M
	D/KamXVl8htsGioxgz7qLTKUAGmRflUjWJTnfztAW1DbHSI264nHinIkg/+MhrqkZ40ZHVes4Uh
	XT3hPRoTkwhXQuBQ9iNceExrd6mfh4UWPppWC2TyXbj8yvGPi4vNlNApJgsuqofclBZwfbYE5Qr
	uZKu9AMP97RSqG37tEx
X-Received: by 2002:a05:600c:3b01:b0:49c:ffab:551f with SMTP id 5b1f17b1804b1-4a1680ed179mr109451445e9.22.1791211201035;
        Mon, 05 Oct 2026 07:40:01 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a02752aeb3sm359304555e9.0.2026.10.05.07.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:40:00 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 6/6] net: bridge: fdb: use the entry key in __fdb_update
Date: Mon,  5 Oct 2026 17:39:37 +0300
Message-ID: <20261005143937.877466-7-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
References: <20261005143937.877466-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The address and VLAN ID passed to __fdb_update() match the key of the entry
just found, so we can just use it.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 927e5f23df5b..b601245ad923 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1000,7 +1000,6 @@ static void __fdb_update(struct net_bridge *br,
 			 struct net_bridge_fdb_entry *fdb,
 			 struct net_bridge_port *source,
 			 struct net_bridge_dst dst,
-			 const unsigned char *addr, u16 vid,
 			 unsigned long flags)
 {
 	struct net_bridge_port *old_port;
@@ -1012,7 +1011,8 @@ static void __fdb_update(struct net_bridge *br,
 	if (unlikely(test_bit(BR_FDB_LOCAL, &fdb->flags))) {
 		if (net_ratelimit())
 			br_warn(br, "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",
-				source->dev->name, addr, vid);
+				source->dev->name, fdb->key.addr.addr,
+				fdb->key.vlan_id);
 		return;
 	}
 
@@ -1055,7 +1055,8 @@ static void __fdb_update(struct net_bridge *br,
 	}
 
 	if (unlikely(fdb_modified)) {
-		trace_br_fdb_update(br, source, addr, vid, flags);
+		trace_br_fdb_update(br, source, fdb->key.addr.addr,
+				    fdb->key.vlan_id, flags);
 		fdb_notify(br, fdb, RTM_NEWNEIGH, true);
 	}
 }
@@ -1075,7 +1076,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 
 	fdb = fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 	if (likely(fdb)) {
-		__fdb_update(br, fdb, source, dst, addr, vid, flags);
+		__fdb_update(br, fdb, source, dst, flags);
 	} else {
 		spin_lock(&br->hash_lock);
 		fdb = fdb_create(br, dst, addr, vid, flags);
-- 
2.47.3

