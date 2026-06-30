Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C12D373C1A
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828395; cv=none; b=uVjKsRb6QcWn8OPZgGWMFStkBzErK0Z8EI9rKnuurlY1eHEB3tx2MtBCVdKJ3ydr5HR/nVXKlLGsDh0O1e22LxXFc7q4R7eG1Rpt23Wot1Yz2UdYhXUaStHpTjnMAUgZN0yoHRRe9n1engN879bJTHv2LRpnt6V29qQzcnUruVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828395; c=relaxed/simple;
	bh=7cKpNlxq64MPmBveT5IAw9hWYkp/ummsEPYyySbVBg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YR1WsJuEkWMqiEe0CExDoSfoanqgwDWhu8mH6CpYwjJcr6Fh3OsAQYVRa/UtaDMWf75gN4Ry4L4Y8mwJM2nmBRkhV4MrfePRiDz4pnizkrYWu3kEkvImXykIrNauq4i30sD5zlyZ54N4LUKsI3QCVPIM/5486aefBb4tNYqSRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=hh07csOy; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="hh07csOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1ZELRoiRhncnhMIWdvQ7ngTvJlPWJEpZajpuDkFiYU=;
	b=hh07csOy2nL3ivGlk8Cxf30CmRD5xdl9Myk6ogk3v8NH5VfkV4y2XzOb1MdYisv1GKzcuB
	Ksb14e7qx5yvtwGK0oyeqgQ3FsZmWgq5bS+47z6n0sDornW56XIU8j8jUOASgjA/gRlVCh
	Bgo8UfdT9tOAEWV1hYK6vHF+GG55+Vd67w+SrJoCWaDSBJ39k7mwGwyo+Url3UDUawj9V0
	U443fjMywviDg74jB2QxnwgVqc+swxFeUWUempr5EPyVCF9XezWiRkMDlnMgLoaLotpSFN
	ivn/sZMh4FXmwSBqsYHqG78s5VaeN63nFexCYhQyEJ0+aYZzbr0Ppr5xrL57gg==
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
Subject: [PATCH net-next 09/15] batman-adv: iv: drop migration check for batadv_hard_iface
Date: Tue, 30 Jun 2026 16:06:17 +0200
Message-ID: <20260630140623.88431-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

With the immutability guarantee of batadv_hard_iface->mesh_iface, the check
for "changed" (or NULL) mesh_iface is no longer necessary because a
batadv_hard_iface can no longer migrate from one batadv_mesh_iface to
another one.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 4514c51bba777..22622283f59b0 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -404,23 +404,14 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 /* send a batman ogm packet */
 static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
-	struct net_device *mesh_iface;
-
 	if (!forw_packet->if_incoming) {
 		pr_err("Error - can't forward packet: incoming iface not specified\n");
 		return;
 	}
 
-	mesh_iface = forw_packet->if_incoming->mesh_iface;
-
 	if (WARN_ON(!forw_packet->if_outgoing))
 		return;
 
-	if (forw_packet->if_outgoing->mesh_iface != mesh_iface) {
-		pr_warn("%s: mesh interface switch for queued OGM\n", __func__);
-		return;
-	}
-
 	if (forw_packet->if_incoming->if_status != BATADV_IF_ACTIVE)
 		return;
 
-- 
2.47.3

