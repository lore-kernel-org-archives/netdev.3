Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B624779A4
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644019; cv=none; b=T7nxGBcx7aBZs6AUMFmiraJiPf0PFwLx4Nx9o4xDHQTH0Lsaec1k9lkSvyCrrCfc5Qy3JNQrj/2KqxdoAd60OEAy3kquPcSrxfhuncQfytq66MXDuAOPuT7N5h4bubesOMPQL8u8yOqKqU7qRAZRDbRwDImTvl/1NmLycZBEkNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644019; c=relaxed/simple;
	bh=D/wckMpF5g6yPgv8xuCi13Jyz63l2jCi3EQWSuGDDVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8VC94MZIksCT9D7KXU7/rK0w6nG98cj7rCg0PdVNFyhU2RnngvNyOUMrO3kj2WDtS/E4yP20v7cP2Mj1AT9KmUs7l+lSR+y4aFxiJGES30YTTqrbpnTFqML0ENsVsLeywSpkGHLw0ALtcRp3fV4LqNfaRKfEANirTxX6hqYv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=cXBNq0Ea; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="cXBNq0Ea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMORY68y61x7YxYlF+M8ex7S25F3TE7zGYk45tfFhIo=;
	b=cXBNq0EapxrU8iHPDLsl+B+vEPW1yjT49Yf9HZ9UzfW5E+7JKW5Mbw/jVY7/km8GqWmje3
	cESEqihQPhMuYk3a581JrlktxmktXj5QmyKHD4HnPQ1oo701G547ifzJRhevVjCTcxY7OC
	Sp0F3NU0nm8DNmKVme4leBWhjxFf48f7KGPh+QLiGoR2R+TtazA0KgWzUIXBpFjxB0sl/f
	irvmwWhE5Uy3IaImqydrLanRPkl1gc3esRMW4OmwPyUmL4z9F3amqOxVp5/S1qLWisllHF
	YPqHjtS7E+uwy7CyM2gvgVSVKE1tWSE6X4RD6lRiuYw16/gtcjMAkXh+d4QnjA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/11] batman-adv: tp_meter: initialize last_recv_time during init
Date: Fri,  5 Jun 2026 09:19:55 +0200
Message-ID: <20260605072005.490368-2-sw@simonwunderlich.de>
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

The last_recv_time is the most important indicator for a receiver session
to figure out whether a session timed out or not. But this information was
only initialized after the session was added to the tp_receiver_list and
after the timer was started.

In the worst case, the timer (function) could have tried to access this
information before the actual initialization was reached. Like rest of the
variables of the tp_meter receiver session, this field has to be filled out
before any other (parallel running) context has the chance to access it.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 978e32d94e6c3..cc72468ca2abe 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1511,8 +1511,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 
 	tp_vars = batadv_tp_list_find_receiver_session(bat_priv, icmp->orig,
 						       icmp->session);
-	if (tp_vars)
+	if (tp_vars) {
+		tp_vars->last_recv_time = jiffies;
 		goto out_unlock;
+	}
 
 	if (!atomic_add_unless(&bat_priv->tp_num, 1, BATADV_TP_MAX_NUM)) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
@@ -1539,6 +1541,8 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	kref_get(&tp_vars->common.refcount);
 	timer_setup(&tp_vars->common.timer, batadv_tp_receiver_shutdown, 0);
 
+	tp_vars->last_recv_time = jiffies;
+
 	kref_get(&tp_vars->common.refcount);
 	hlist_add_head_rcu(&tp_vars->common.list, &bat_priv->tp_receiver_list);
 
@@ -1587,9 +1591,9 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 				   icmp->orig);
 			goto out;
 		}
-	}
 
-	tp_vars->last_recv_time = jiffies;
+		tp_vars->last_recv_time = jiffies;
+	}
 
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK
-- 
2.47.3

