Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E043FE67B
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644017; cv=none; b=ncQDyLlyr26ac7Qq16mQopiOU+dAs00c94B7oWF9nYJ9rkNQJ/xyhiPTmpJYOZK9fp0bbhx8Bb0BSv0oABdsyQspYibJpF7QPaAn2l+dZCZiyK9tpVzEuGqO6t4lyXBqujn82D+A8Lig0c/Dmc/WxvAS+ii9bkC/vbRAtA8paV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644017; c=relaxed/simple;
	bh=B3SR2OjkOxvGM8I6oFC3OJ+w7UoeNauLTSn27eaKkxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3v1zClIEYllnf/HzpuGygDuzuww5gyN3kB0uOhaq0ddh11umValNDu7o1F/qNLObL11GOUeShyTDwkaGYVFt3jnFCsPGxoB8jecwprF6flD1I2AbEWlfqL9Oe7PtorwFvBIc/9dNgIY/k0PfhgNgFkta74w2LOzRFQ4HMZuIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=k/zYiKnl; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="k/zYiKnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5VjgMR6R+zmUaoqlylF20/UjikHzP0+tYEYge+V4aQ=;
	b=k/zYiKnlGSijjO53aH3e9I0c/Rcyd75R9R5vr9LMGh+BLm162CyI5A/q28zQ0Qg8HBI9q6
	rKTWtEUtQBEJVj+pPHF33UN0QkPc7nPM4lLJHCcIIIun6Pmz4LEXk1mCXT+NUQWf1bwJSk
	yzMWH0v13R+LdHKSyfuRzy5ZzImInKViqyL9e6RQ3LuiAxrC16E4Xzcstk6ewWmcgtZ5B+
	ADoNPYRgQ8vy64ufaowBvYvvJAU+ii+7Kc+f9OJDERSqfwqmZeXojuN3mG4zhCqxtDG5fx
	EBUMfrtHxzk1B0KmFXzN8i92tdh3os4pbe5ok/d6g7kW3ogfP16WtW8z3iAuZA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 03/11] batman-adv: drop duplicated wifi_flags assignments
Date: Fri,  5 Jun 2026 09:19:57 +0200
Message-ID: <20260605072005.490368-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

During the initialization of the batadv_wifi_net_device_state, it is enough
to write the wifi_flags once before the batadv_wifi_net_device_state is
added to the batadv_wifi_net_devices rhashtable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 43ebf86e7b368..96b8130375a3a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -987,7 +987,6 @@ batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
 	if (!device_state)
 		return -ENOMEM;
 
-	device_state->wifi_flags = wifi_flags;
 	netdev_hold(net_dev, &device_state->dev_tracker, GFP_ATOMIC);
 	device_state->netdev = net_dev;
 	WRITE_ONCE(device_state->wifi_flags, wifi_flags);
-- 
2.47.3

