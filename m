Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926937FF43
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317417; cv=none; b=Y4KVdgZE257K4IfkaN0sMgpnz6CCy0WyU5F1aM009m/NFRUmceoWFcqohNUW+pGZqN20owVxDUohHzRTE95Z5xi9VP/NXhR468+/8Wuvhmf0tTWZexsO+rUPcMpi+hqF6KspheIkmGUfjr+imC8xt/kLP2/UzNfK3Tqu+aM01ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317417; c=relaxed/simple;
	bh=YhRqEqVa5MTp/VVq/5fPEqPiVlRzxzF4drm+Yqgo4UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StlEAsXWlhZbuJe/wXMlU9B6icsjUQVg3tOM08b1/B5DXcxHQKm9xQtmz7yIOZn98PBjVwoZrIFcmTuAIa8npHXKUqgwAD2h7O+aRm0RrJwa4SUoCRJjU/WSRL5TRc0S8YjWq4Q70kKb/YYX3rTZZVd4Hqt36m9y9xgndFUIyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=BKokBU8l; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="BKokBU8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780317413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4x7fYtKt6TJrTs4d6ISmPTw7WCMg1rpDK5hrgQIb/fw=;
	b=BKokBU8lE+K6Fe0Io/S+cQ/6Z3y6DMKYCm7vopirP7gGxGzR4TAczIXlwwEHxNeoSD5iiK
	C0AGnsAvKo7cBcQjXlxDKEQ4EqSTwIhBYPoCU1agIr03HP25Lzr3KV75kZDfiv18/jeeYs
	Fl/FaTkJ+6DJtJkxbssOsXF0vwTY4lhz8j3jL7T8UFCWatJonfGPhfA709PkJgRqV0V3T0
	3Nn16WhBs4qs4Zo+JJZBwjEStjhgf7bwLV10IANPn90fBzRvvyClB8MCic1vdqLb4reYNd
	kInv+M0+fUTCZ3Fx2mDY6iNG46/xaTpNlPbK9Z03crHKm7u/zmRElkkyMbldaw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 13/15] batman-adv: tt: replace open-coded overflow check with helper
Date: Mon,  1 Jun 2026 14:36:27 +0200
Message-ID: <20260601123629.707089-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601123629.707089-1-sw@simonwunderlich.de>
References: <20260601123629.707089-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The commit 6043a632dd06 ("batman-adv: reject oversized global TT response
buffers") introduced an open-coded check to ensure that the allocated
buffer size can be stored in a u16. The check_add_overflow() helper can
perform the addition and overflow check in one step, so use that instead.

Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8903b2f84f512..5e134d08a80fd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -799,10 +799,10 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 {
 	u16 num_vlan = 0;
 	u16 tvlv_len = 0;
-	unsigned int change_offset;
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_orig_node_vlan *vlan;
 	u16 total_entries = 0;
+	size_t change_offset;
 	u8 *tt_change_ptr;
 	int vlan_entries;
 	u16 sum_entries;
@@ -826,14 +826,11 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	if (*tt_len < 0)
 		*tt_len = batadv_tt_len(total_entries);
 
-	if (change_offset > U16_MAX || *tt_len > U16_MAX - change_offset) {
+	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
 		*tt_len = 0;
 		goto out;
 	}
 
-	tvlv_len = *tt_len;
-	tvlv_len += change_offset;
-
 	*tt_data = kmalloc(tvlv_len, GFP_ATOMIC);
 	if (!*tt_data) {
 		*tt_len = 0;
-- 
2.47.3

