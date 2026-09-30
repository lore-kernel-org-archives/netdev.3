Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE13D5C06
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761573; cv=none; b=nZH/bUPF8hJ1X11eeuOx4k8zdTSScyGGSN0oozlDONkEd7BrgpOi/KWMEXdt2DjeKHlr6l14h7g5PhdPmYQISazpjMJf/pANdrBaqlVwW2F68oLlScRAN8DOFMCcrnNjkMfdLJDNc7eSMlyXbqXJq5dXzQRnwM1bSMBhVnu2bIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761573; c=relaxed/simple;
	bh=qzMu+9u10htwDXuq2+q1WRXuB10ZJ+efLCHY6f0LbFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2CB5+zWpeJf48ZrvANyux1woghHItzMp7AbOz+7fRExkGGCducYt0jZPp1KIeLl0ryruS+szdqtvYDFqd/Ykfi8/q9txPu5ajQ4WCnolpUvy1DVeyIJduOYiAX6OXeX2N6f/zHqb57x7x+spOXPEP9DkP8gdIqyzUa1fk9mSBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=tVKBNLIr; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="tVKBNLIr"
Received: from kero.packetmixer.de (p200300C5970E81D8cF20E45a7328D917.dip0.t-ipconnect.de [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 49F88FA1B2;
	Wed, 30 Sep 2026 11:46:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ5QnYvBUumJeGg47RpMHA7VjJ81SfVOD5rbWWyI2XI=;
	b=tVKBNLIrhMoJednZQeRfCIZrdcFXxKgB9BOlmyu32dP2XMnqIalovt51lMdFG5dyMJ8CGi
	uBhVGPTyjEUQC32pKpDTE6PG8gh/QGe5FkGiYYqntlDQgXZwvUgmlgL1KUakQiJnkDoJeW
	3phlc7fXEmuQBhaxziTJ9mBLqg8dUNxrnZSO2j0b2VTLlNQS/7082P13MKe/3UrTWnLqK+
	DYrcLs5MwCxe3gFllYV2ESqIdm8wrRzAM08Rkl1jX64Dt+3qXKjtNXS9fdPv7UYrU7XRtG
	fds0Tpj8ER/Omg+KUEmb7y2NB9aHk8QWqChIawRinzNDx8O0GgZUGoYeVrnCiQ==
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
Subject: [PATCH net-next 5/9] batman-adv: tt: only queue local del event after successful unlink
Date: Wed, 30 Sep 2026 11:45:54 +0200
Message-ID: <20260930094558.3723766-6-sw@simonwunderlich.de>
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

When batadv_tt_local_remove_now() finds another local TT entry with the
same MAC + VLAN, it will not try to remove it. A delete event must not be
queued because it would otherwise cause the queued ADD event for the other
TT entry to be dropped.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=8
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 354d9416c1b75..c904d67791f8f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1496,8 +1496,6 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct hlist_node *tt_removed_node;
 
-	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-
 	/* remove exactly this object when still present in hash */
 	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
 					     batadv_compare_tt_entry,
@@ -1505,6 +1503,8 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	if (!tt_removed_node)
 		return;
 
+	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
+
 	/* batadv_tt_local_transition_new() may have committed the entry and
 	 * thus counted it in the local table size since the
 	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
-- 
2.47.3

