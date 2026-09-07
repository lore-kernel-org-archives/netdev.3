Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0154279F9
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769124; cv=none; b=t3BRwSOgKrHnF15Hq/CyIQZtnLE/CwpY1wTL34c2VmdHg7nFyHNbil62wDgoZxd/KhIEYrvgtwQSbHhjHdNs6v3e5RiNyNq0v8nWM0IcHE35wLeD/C+Ba3NVKJVErIxoBd4L4992zoLSg1lukDiQYr14yk9u+a1A+wFdumTovqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769124; c=relaxed/simple;
	bh=nJRJpgRknAQWH8qbhbi8zQKvuUcWXdIjH/ZLzANVrUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVvzpIUkM5hewizbgc1DnPKYjmvFm9tLjdU2zPpZanbIj/v82XSgIkxPAP4o2lWRdTNId3MM3gYemfa2LpA39KHzovC+ESSirVKqh+/6TKzLg1el5j8ZNV9Jskfee/eHo6aYhOtcaSQ6pX0crdew7UPJoKV6gOcE1p3Kjbw17Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=XjsWQZZg; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="XjsWQZZg"
Received: from kero.packetmixer.de (p200300C59748d0d8C3747188E6Dfe6C0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 359C9FA2C2;
	Mon, 07 Sep 2026 10:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGLTaECVpqUfSVRQGkJFUTj3HfISWwCWpMLjQze0xA4=;
	b=XjsWQZZgn0oicjBABbWO5CY0KavJAYkuV8xZ2Xs3jmRWQQuMuzxMx/2k7JqGRHUL+Lh3+S
	S3NN6sPzewShRPggRcfdrftmLT1fWOym4LFdb8oIFmee/v8Iup1mDxSCA3B3m7HpN/XCPe
	SXTcBQBZ2R3PFcgC3uqipMTzjKcrIwGzENzXDGFYo1wAeXvpp3nMSvXVLZS8Ri+XtNVUh/
	nOM3YonCWtxK3NvA739xQdSe1vB7YGy5lr3Auy+NvI8e10I8VVlZeAqKij3JqfJNy78NqE
	hIaVtAepT9IWMA9pzW1Dfsuqmjv9e9ZzS+HGvHzaQuIPNDJ10ksYxQ6Ux6tiDw==
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
Subject: [PATCH net-next 13/15] batman-adv: tt: clarify kernel doc for batadv_tt_local_set_pending_event()
Date: Mon,  7 Sep 2026 10:18:22 +0200
Message-ID: <20260907081824.2474040-14-sw@simonwunderlich.de>
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

The function batadv_tt_local_set_pending_event() is no longer setting the
BATADV_TT_CLIENT_PENDING because it must be done with the flags_lock held.
The kernel-doc must therefore correctly state that the flag must already be
set.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=12
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6c65d195f3756..12ea557cb8033 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1422,13 +1422,12 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 /**
  * batadv_tt_local_set_pending_event() - trigger events for TT pending removal
  * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local_entry: local TT entry to mark
+ * @tt_local_entry: local TT entry which was marked as BATADV_TT_CLIENT_PENDING
  * @flags: TT change flags to announce together with the pending removal
  * @message: debug message describing the reason for the change
  *
- * Schedule the TT change announcement for the entry. The entry is kept in the
- * local table until the next TTVN increment so that a consistency-check
- * response can still be answered.
+ * Schedule the TT change announcement for the entry. The caller must already
+ * have added BATADV_TT_CLIENT_PENDING to the @tt_local_entry
  */
 static void
 batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
-- 
2.47.3

