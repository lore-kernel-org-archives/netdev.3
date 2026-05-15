Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0BA44A73E
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838961; cv=none; b=Ut0rVOyxN1Cz8O3YVb5WOOu+E3c8VcGtfBEuBhSgaNQp5FCG2Pva8MpjLTKCn+06Rg+Pt7SZ51PV3oNxfvP6AwBwRiIPXlj70FrkPt0JvTtfBU1NWCGYT7vSjO7Wj88XeKEM+BbVgQGMIw6OcLmeDf10pJNpK0l2k5DXsfHBkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838961; c=relaxed/simple;
	bh=XCQRyRU02uiAirdw9ArZr9s5/BX3a14e6N07R5kjeIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8FWx9Z5IJFpRkLgG23jOFYvXkchaPz6E3T126RRF6ZJxNO+97Ra3oSNqpXjwt0DGw9Fbu6QaeSQiAyYwEbH/AtpILEvfjpn9yw8D5tdJmFgjTH/ybab4i473BGJbOOke+KgIlcC3XXVB7qR9MeR5KRlm/EZO469wAOHGBvBf74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=b/P/WA5h; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="b/P/WA5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/qkFKT8Qr7l15xFxytFFUVwsMDuYQMQoM7YNKCJOr8=;
	b=b/P/WA5hCs7nMi+QKuSlg4ffP2GRtM0t+oyAbQe5gjVUvZk13tSXWlvxH7Gb1jAB7ng0WR
	3reWJ8lkEZh893acthADvWJ2CHznddReHOcV03oCKCukXXRoDDZ7BQGTKNhjMQA4M6QFV0
	k6SFjDpyL6lQXXPAlMGqKVpYDcS6Old9uHTp91v9t9JZX+ur9Sxdf8/JnHe9vmmso5317v
	kPxFvSUAEPXCqWitibmzf0BCReeD8MLJACBfwwNuxF4r3fLbQhWBWBtuNjrM6dvrFFOcy+
	hyS4FjywW7TthNZ1nn0mDiEdL4zklbpBAZfeJO/EsLQpMUiif67vbYq+aV4qrg==
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
Subject: [PATCH net 04/14] batman-adv: tt: fix negative tt_buff_len
Date: Fri, 15 May 2026 11:55:29 +0200
Message-ID: <20260515095540.325586-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_orig_node::tt_buff_len was declared as s16, but the field is never
intended to hold a negative value. When a value greater than 32767 is
assigned, it wraps to a negative signed integer.

In batadv_send_other_tt_response(), tt_buff_len is temporarily widened to
s32. The incorrectly negative s16 value propagates into the s32, causing
batadv_tt_prepare_tvlv_global_data() to allocate a full sized buffer but
populates only a small portion of it with the collected changeset. All
remaining bits are kept uninitialized.

Using an u16 avoids this type confusion and ensures that no (negative) sign
extension is performed in batadv_send_other_tt_response().

Cc: stable@kernel.org
Fixes: a73105b8d4c7 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b9c0b77791226..888f337a194bf 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -452,7 +452,7 @@ struct batadv_orig_node {
 	 * @tt_buff_len: length of the last tt changeset this node received
 	 *  from the orig node
 	 */
-	s16 tt_buff_len;
+	u16 tt_buff_len;
 
 	/** @tt_buff_lock: lock that protects tt_buff and tt_buff_len */
 	spinlock_t tt_buff_lock;
-- 
2.47.3

