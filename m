Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571913EC837
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762108; cv=none; b=oRCRuYg4LM/zatI7u61G7ps1/skyFnniWMe3VKh4nAtg/60/yFPFNZlJk2xvIb+KGZhHKMa3RGEGd3pH6/2eFypBdKU2aBAr3lKB/yF1VNu4D7nm5cHnUgarrQW1E1BMQTKkz9nLavTjEp5QUZ1FJKc3vTRZzXDUTHPPheuH6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762108; c=relaxed/simple;
	bh=JyCS+nTEfy4ZICa4LGKN4xw5cmug8vZRseZPUWH3J10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpIlMteJMV5NVCtOAX6r8b5656vHUgY2BkcGobmGRAhKLkMTqhMizM3DWIJ2AGpNAtwMrLBqDHLhA/zaPD0ALGCWc15hxBUyebEF3N3iR2992BDqsuYp4FCoM7wt0113R5smw52MDnMXUrqlXU1GqUm8fLP0tKFr1pPOrL2b8fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=sh0rFtDv; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="sh0rFtDv"
Received: from kero.packetmixer.de (p200300C5970e81d8Cf20E45A7328d917.dip0.t-ipconnect.de [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 5903EFA039;
	Wed, 30 Sep 2026 11:46:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7FvKmxdngUtp9PuXFaNx+zdH0flyh6Lqbv9pg5G+UE=;
	b=sh0rFtDvw4P8IU0NAyTjrkpfv3RXbEcG3pPbapFZrvX92I87skcT2McHsuiAI4scKtBd11
	4ESuRZFvP1CKIyIGug8+2WmAbjrmDD31P/4756Bggqdy/nTFbyWvu9X3PEzf4MdMma3oJD
	mAwqHT3//mPCQhwXuh8Us568ylmIS6mOkrOUsojZP9friUXCQnvdT3FpQBxPrvq6w8BgLR
	2l0c/QPc6VQaIA/NHQDYk2kA/oB3rEkxoiZgTAXGDdvcu/9ZY9kzo9Y6DrwSjG7RPyb6CS
	YZv7UuGZEY2uvyfmmvheiUkfi+cAYk+UtQxGxxjYE8a+uPDJA+wT48Wh2zaGmw==
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
Subject: [PATCH net-next 2/9] batman-adv: tt: clarify kernel-doc for batadv_tt_global_purge_local
Date: Wed, 30 Sep 2026 11:45:51 +0200
Message-ID: <20260930094558.3723766-3-sw@simonwunderlich.de>
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

The new kernel-doc didn't mention the "non-multicast clients" limitation.
It was also not clear that the roaming flag gets cleared when the
announcement didn't contain the roaming flag.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de?part=9
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 12ea557cb8033..6d8fa6d28fee8 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1870,9 +1870,10 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
  * @tt_global_entry: the global TT entry of the announced client
  * @flags: TT flags announced for this non-mesh client
  *
- * A client which is announced by another originator is no longer a local
- * client. Remove it from the local table and take over the WIFI flag it was
- * tracked with.
+ * A non-multicast client which is announced by another originator is no longer
+ * a local client. Remove it from the local table and (for the global entry)
+ * take over the WIFI flag it was tracked with. Reset the roaming flag in case
+ * the announcement didn't contain the roaming flag.
  */
 static void
 batadv_tt_global_purge_local(struct batadv_priv *bat_priv,
-- 
2.47.3

