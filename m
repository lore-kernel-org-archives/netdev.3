Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4AA43C05B
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769121; cv=none; b=VZ5bCZx5kCHnB1Y5IBHHdON0InMoUq6rPWsbbkXCFA//8nmXCe7jB7jGgqayyj939EMfnXgrNkXpB0XrN1nvIvvPCYRynXunzbEG6xKdu7tmzaq3YvebDZRiHioW1cahRiwP1ighR8yS01koWUGjak75iv5ZymOYSKzbl5wn8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769121; c=relaxed/simple;
	bh=2gnrmmaV3lSbgycKmC8C3RvEgfUkfWQK5ztf+339H0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFClOcgm1sJ5V2ATrIHyptXx/YtBQx+52GSL+v35MrCJdSZNFu7Inpcl4wGRu4sESgH2S8DGg6BLVydZEEE/8bY/3/mZfo0W0yorIhKCRAio+VSLgiYfy7vxkMlEEL4JR2TIhvjYGPgtlr+MXwFrMJqD1XQOBwr8CyhtyusBEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=rKMo3nDI; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="rKMo3nDI"
Received: from kero.packetmixer.de (p200300c59748d0d8c3747188E6dfE6C0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 0A7B2FA2BD;
	Mon, 07 Sep 2026 10:18:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9rQSC+FIYXUADrhMRF8yRSXEy/HeHKFN7qzVUBx+7A=;
	b=rKMo3nDILbx7sTQ+U+lxWEcAQsbzz9lwWFwcPyuRroQz2EBH+Z0Cf9psWLkO/Z4KXScQAp
	PoaVpEikdbm9Y74Fs8bPwxsFl8K0ZNfZuFNPY/HdwIb8LwyiSVm9mjMVltCQV+TfQIEVuy
	GtMAfRbme4zZdU4WDifhat0IxVcTlutMqfdsi7nVVECN0GBqC2jKG4pkBhQkXA+9GBPNd+
	7XJlJyOHXRAtMjOAncZmlaaQbneysb1nolAHmgCJwg3Tf1alV/IGoVQjUQ/kJxIJg9RJ2/
	0fSXOJzhW15pN42YDUyjfdzE1thXx9wMQ1HEeHrA5TsO1qhf+LbnaN798v0vLw==
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
Subject: [PATCH net-next 08/15] batman-adv: tt: replace add_orig_entry goto in batadv_tt_global_add()
Date: Mon,  7 Sep 2026 10:18:17 +0200
Message-ID: <20260907081824.2474040-9-sw@simonwunderlich.de>
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

The "add_orig_entry" label was only used to skip the flag merging of the
non-temporary path. Which means that the code jumping to it and the code
below it are the two halves of an if/else.

Both halves now only decide whether the originator list has to be purged,
so turn them into an if/else and purge the list at a single place.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 67e4ade5ae997..760acc7be973e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2021,15 +2021,16 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
 							    orig_node, NULL))
 				goto out_remove;
-			batadv_tt_global_del_orig_list(tt_global_entry);
-			goto add_orig_entry;
+
+			delete = true;
+		} else {
+			delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		}
 
-		delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		if (delete)
 			batadv_tt_global_del_orig_list(tt_global_entry);
 	}
-add_orig_entry:
+
 	/* add the new orig_entry (if needed) or update it */
 	batadv_tt_global_orig_entry_add(tt_global_entry, orig_node, ttvn,
 					flags & BATADV_TT_SYNC_MASK);
-- 
2.47.3

