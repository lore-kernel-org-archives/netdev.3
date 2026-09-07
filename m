Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C943F089
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769123; cv=none; b=ZsEK8AMKG2dX1CPlqPnKxThIqsE1o6StwvWbt0p3X+ktLe+AgeckG0aDZ9i1yAWJo7HRRBuukxtFjDP0UdIv8tr/PnvS8KDpjkj5u4ZniEFObKNoozbsCPzK7gY0yu4WRMm0K3KvzVMOt0/Revscw9xzi8X87ZaE7Ra0B5Z7yPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769123; c=relaxed/simple;
	bh=O2+gD2mMhIdau0qWf/cMNi/RCk/Sg8AV2fH5przqFrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/xIUuMFMyLYyScSZLHiNyDDtFiikzlgMAqHqByaU81RlOJ44gfpQ6Y4rRhl30Ff9xIgz/YBDHP8k285rRBWWLnpKfghVnzFzec0VNuhDnfx+6UmTUCUpRMsE9kb1KLgH4bNqTSPGseoIPMlNZfRdu8PZ6bmYIcdMVvliq/YPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=GkvY26hH; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="GkvY26hH"
Received: from kero.packetmixer.de (p200300C59748d0d8c3747188e6dfE6C0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id E0962FA2C3;
	Mon, 07 Sep 2026 10:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPBQnSTr3ybdpUxRTeJH+n9deVsj7/2bOs4cDMU5/88=;
	b=GkvY26hHpwu5PRnxOhvZFkEbFDQzT0FhN+MyR80xl9wXnytw5lP0XgNiE8WT287TnwlLs3
	OMxcO5mmr8urxuvz3HbeSGcZ/ufqWg90RY44vgvsDFt7dwonDNDjjqOeZ1kYRM0DoiENvC
	Em+vaifnZys7nvnUpueF0HXPd+Bc3llCObjG0mLE6o7kNxOQoNZSJrXglJ4N3mzvlPE8+p
	L6wrLymKKqVXU54oolFaPVKb4rv3dqiJ8FzaXtdQ67UY2rI5DjrGPfXtBsPIYHpcjbfQjf
	UwSgdMn0A0d7gK+V9XqYn4PAgNs7oKCyKMXvUO53CZN1/kSjJIRCLYF7e7byxw==
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
Subject: [PATCH net-next 14/15] batman-adv: bat_iv: fix ogm_neigh_is_sob parameters references
Date: Mon,  7 Sep 2026 10:18:23 +0200
Message-ID: <20260907081824.2474040-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The batadv_iv_ogm_neigh_is_sob() kernel-doc summary line is still
referencing the old parameter names "neigh1" and "neigh2". But these are
now called "candidate" and "reference".

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=5
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 3fe09b4c30463..89b499f7a37dd 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2422,8 +2422,8 @@ static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
 }
 
 /**
- * batadv_iv_ogm_neigh_is_sob() - check if neigh1 is similarly good or better
- *  than neigh2 from the metric prospective
+ * batadv_iv_ogm_neigh_is_sob() - check if @candidate is similarly good or
+ *  better than @reference from the metric prospective
  * @candidate: the first neighbor object of the comparison
  * @if_outgoing_cand: outgoing interface for the @candidate neighbor
  * @reference: the second neighbor object of the comparison
-- 
2.47.3

