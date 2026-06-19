Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79FB17A30A
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852459; cv=none; b=hmYm7xovEcKfPBJQV91GK9vBx2pTtn4HeHFcyOqvFo47SA7g+QM2kwOBuDoLcESbd8iFvks2020vbhM6AKEaPi06cCWMJAgSisWVo2O1NotKLULnI3QBLs/7g1dnGAqSwesqpCLT9AXSKUhHvrFy/tPGQ2Nhn2xDkpMjZD8r9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852459; c=relaxed/simple;
	bh=MHa8YmOq4XZWBQFbXMJDrb+1BKQSuYru/dXpcej0gZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3QV8TNxJ71gnGk/suHN5oJKQgZasVA77NAjZ2sLpKxky3K1aOBb8zh8h5jRwl5Hbgh6f8RI1dgv7E4czj4g6LA3eaAr0ZcrrUkA3MPneppQmfoy5YL9bxmIUg2b7w9RrI5pUAJwnfWE6wyp3XXa3jkxVebDh9buPsGyzilSVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=15P/FOiS; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="15P/FOiS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sh8/d19dTv+BnqITWKo5mUC2hJ8B05RbL/Sh5BlrDOo=;
	b=15P/FOiSb2Egdx0WhrFpCTQj9sySCwZgzZwDyYL0e77yC8mkiuk4VeimCv0VY/KtLttsJh
	bBibLQ268eFDIJTvUNUbhDsmIvFhrjZV+/iHpxe0fNzPu+ncBBH7XBtpYj5EP3hFTFxLXN
	JiM8xMnGg3tSIvoOr8LTr0q33u7Jh+k5ZHQkPE7fyoUH3ys2Ur5SuNuDOJSol/I6L9Nv7z
	SSapBJsqbrAkRob71AxQWiVMvpl8TMgns9J+6mOz+/MK/8Ue7JzA/X3NU6M2xtYMz9DyQ3
	YKUImU8YR7sd5AZ7Sw4IyR+/42o2gXDXEnThW32i3oKwhv7nnXyURdnfeRGCKA==
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
Subject: [PATCH net 11/15] batman-adv: tt: don't merge change entries with different VIDs
Date: Fri, 19 Jun 2026 09:00:41 +0200
Message-ID: <20260619070045.438101-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_tt_local_event() merges/cancels events for the same client which
would conflict or be duplicates. The matching of the queued events only
compares the MAC address - the VLAN ID stored in each event is ignored.

If a MAC would now appear on multiple VID, the two ADD change events (for
VID 1 and VID 2) would be merged to a single vid event. The remote can
therefore not calculate the correct TT table and desync. A full translation
table exchange is required to recover from this state.

A check of VID is therefore necessary to avoid such wrong merges/cancels.

Cc: stable@kernel.org
Fixes: c018ad3de61a ("batman-adv: add the VLAN ID attribute to the TT entry")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8b6c49c32c892..016ad100153bd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -447,6 +447,9 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
+		if (entry->change.vid != tt_change_node->change.vid)
+			continue;
+
 		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
 		if (del_op_requested != del_op_entry) {
 			/* DEL+ADD in the same orig interval have no effect and
-- 
2.47.3

