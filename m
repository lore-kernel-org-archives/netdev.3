Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C4342524
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762108; cv=none; b=WXy+JY3o0QsQ1/fU/QMgjWSmm8qWLFB/gtoVUtfy5g30CfRDEuaIt7wNK4h0X9G3v/9XwwWVxTT6GxfPRloNdMxfIOhQAhVnzPwdZ23jn48IsIsd0i2wswVedHOMhDnz8xexMkfDTG9heG9SxSrbR3FQAeSITG6x9gEaUDqiaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762108; c=relaxed/simple;
	bh=FMTFEQoRZLRg8bpJcJg5UWj5XaXieriInCbDD+amYsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csU5HVX+JjN4W/gkIxMHbbaLuHNwxu2R5y5exSJMyeA0iV2uc6uU7/wmk2cqnOLCsAXA7mGO4XoD3Iv15Jslugd4YhHKq6HFzruLbrPjRaeREWzM6e9Uhla7LUli2p3MpAOWIDWBnkLkidBImHk1zM8ULJhvkJ8SDj3RAPt9w3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=msxMsA10; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="msxMsA10"
Received: from kero.packetmixer.de (p200300C5970E81d8cf20e45a7328D917.dip0.t-ipconnect.de [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id A8C1AFA010;
	Wed, 30 Sep 2026 11:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ckik62FEDM7SnJBf3jmn4RXxhxdn1SStuKJKv5O4BFE=;
	b=msxMsA108AqgIgdQsLRlEmSGcIxIyC40CTCyNa0+wTX5dIIns+WJHUFj2sKOBXxh7y6Wxl
	GMRVohWkB6MPyEHygS0u26vKN86aO5IxqHTt47MuB7zxOj3oESd7ALBJ5mVUMOs6/Bz5pD
	nF6LWZDvUcPtbBdMIE3b4p6obkfCMW20Pp1uiGCRZaWu+AzogtAAhQ+iJ0UkWv6eU+t/hN
	K6iukOAnaEVPhXBeTlbcAUr69Js07/es5/39IIwiFz7fYs4oSu2ZymeyN5C58sSvats+JS
	df1HrVVZt1xrUVxwqkfpmh0On/LlDj5wTR5Uh1WmLmyTr3FawrfRHj7fAk8blg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 1/9] batman-adv: bla: avoid double free after failed backbone_hash alloc
Date: Wed, 30 Sep 2026 11:45:50 +0200
Message-ID: <20260930094558.3723766-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

When batadv_bla_init() fails to initialize the backbone_hash, it is freeing
the (previously) allocated claim_hash. The initialization function will
then return an error and the net_device initialization will stop. The
destructor will be called instead and (indirectly via batadv_mesh_free() ->
batadv_bla_free()) will try to free the bat_priv->bla.claim_hash again.

The pointer must therefore be set to NULL after freeing it in the
initialization error path.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=6
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ad6ab4a50658f..a96f269da8d37 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1625,6 +1625,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	bat_priv->bla.backbone_hash = batadv_hash_new(32);
 	if (!bat_priv->bla.backbone_hash) {
 		batadv_hash_destroy(bat_priv->bla.claim_hash);
+		bat_priv->bla.claim_hash = NULL;
 		return -ENOMEM;
 	}
 
-- 
2.47.3

