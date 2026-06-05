Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56144D68A
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644017; cv=none; b=P4fnfmQRT4mP6hzVPDgZvJ8u0oZ8NSZpY2pWXWzEFJLRt5Tp5+Ba8gLKlAG/NX2mSs4sc/OLCQdswDACkUWqtao1kFh1fhQwm+XJgdhA/Zgv/JJZYbbrzJm7v9S6/2UTtBy1u4RcvnaxbgoF7WzteiZtjABZenCiPmUNcj3KeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644017; c=relaxed/simple;
	bh=SGUYZ1nkXx80Zqb4tRp2lab0rilcBvn2REgWKpj6wZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBK2bbrSR5HBXynwFtRaoXd8PoLK4lFWBsnwv8kmzEePkEnVfVuQbUMRT4FG9zm3eCf92EK/kg0cMM/LHdWpUOQn8bSKT+kv+rVLQGPophNKEBUz7IIILUWjC4oog3tffE7xMPrOd7LIqjzSjMnlhLXf+6Hnm1XOVeoGhHP/zi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=gS2LJBm/; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="gS2LJBm/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdWoGEypLT0hA4oET8XmjqY81On+S12Bc4UStp9tjaE=;
	b=gS2LJBm/VjTOKGxFoTLo1ffpyMs5uutNlKIeDzb5eUDOyKUpABtuoNt61FC2shV3GMoag1
	56ncRJtsezrEuJw890ipKzVO0sa1aAPJloagU2iYU3LYgIQ0ZQFwI1q+TCtsxV5JAa3tUm
	KxIOd5l4iEkIxTiMe+8NxYpDg9t8wUCqk1pbdlTy0cPLYyvudQN/jKfbk3IagbwYWo/8We
	wljn19pDaT1sZTsdBmh/82go/dGrlz9bCGS5bz9Tq2uR5cLr5Fp14HLwyFB+QX3RpZSUwY
	CJWkkUdPAEtSudGILXV5YwJ34cPHHVrpDLumIItPhUjvI+UTGGpAkiWqjxq/aA==
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
Subject: [PATCH net-next 04/11] batman-adv: use GFP_KERNEL allocations for the wifi detection cache
Date: Fri,  5 Jun 2026 09:19:58 +0200
Message-ID: <20260605072005.490368-5-sw@simonwunderlich.de>
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

The batadv_wifi_net_device_insert() is called with ASSERT_RTNL() held, but
not inside a spinlock or another context which prevents "might_sleep"
functions. To relax the requirements for the allocator, use GFP_KERNEL.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 96b8130375a3a..04b227ec80525 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -983,11 +983,11 @@ batadv_wifi_net_device_insert(struct net_device *net_dev, u32 wifi_flags)
 
 	ASSERT_RTNL();
 
-	device_state = kzalloc_obj(*device_state, GFP_ATOMIC);
+	device_state = kzalloc_obj(*device_state, GFP_KERNEL);
 	if (!device_state)
 		return -ENOMEM;
 
-	netdev_hold(net_dev, &device_state->dev_tracker, GFP_ATOMIC);
+	netdev_hold(net_dev, &device_state->dev_tracker, GFP_KERNEL);
 	device_state->netdev = net_dev;
 	WRITE_ONCE(device_state->wifi_flags, wifi_flags);
 
-- 
2.47.3

