Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC5E374735
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278087; cv=none; b=DslQ+UikJpcBlaccI7CMrL8DmwIZq5B+nrkisKO96W+XtJCW9KJvaWf2bhuO9KGcFuVG2HszpVasKVrXXOl4a9ZPDyMPegjNtW3rFu3+EU25SXdksvEhKZcpxiLc2xOCsmtxKYZeSYZAgZ0AxwFiA8J+WS4NySjBoHqc9yYd1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278087; c=relaxed/simple;
	bh=nnNzkkg+3E9iQ3+AsnfUiCVCCAtF4jPSr7cWTn0sRcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTqa/WnTWTu02ssLuNz+Cgq2AvYjKwxdv3Xnq0YBWoB+9HBtBxfg1VVqDptjZWTJf+/u4ooDKfeIPRy0VSbXgYFuU757EcEpsi/R0twiBbrxSF6AMHgj5pLHcLf3ZSdWbxbbT5Jkt+gBvgM4qwL5Zc7Lur4Nbwq7sI2Np3YVC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=doep+AuU; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="doep+AuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779278077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VICMVO0Qn5I2jNrf8UyRCEpSmXvVIwvSF9ANzWZQvI0=;
	b=doep+AuUZfWjiLEffB/51cKZFYGfBJUj812Ae1XG42+7eY13BZwQo7aqZvWJOeJ4DLRmcm
	SIPNnm7Lv5Av71GXY2NT5bpVY0dPnD0e97qgDVDw166OwcE6y8+zGHabfTndc69chH99By
	qCRQ5+tGf27Pl+e0b6BIzUdJIZaW9CVCWL67GMfj/kjrEiPGn25DHpCq2ly5FXPGoqHy3u
	yWetZNZwv2ZjguL+1fh/0oleh6y7Ie4NeNuz2b3b4Ax0xU+oJZjb6diZjioqvphnEYG43/
	kYohpse/lK0FwvelxKuyESL30FVNBDgs8Z7WBDQ6vDLzgnBUl/hTlZvAHZ7egw==
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
Subject: [PATCH net 01/11] batman-adv: fix batadv_skb_is_frag() kernel-doc
Date: Wed, 20 May 2026 13:54:12 +0200
Message-ID: <20260520115422.53552-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520115422.53552-1-sw@simonwunderlich.de>
References: <20260520115422.53552-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The kernel-doc comment for batadv_skb_is_frag() contained two errors:

* the function description referred to "gain a unicast packet" instead
  of "contains unicast fragment".
* the Return section omitted "merged" from "newly skb", leaving the
  description grammatically incorrect and inconsistent with the
  function description.

Fixes: bc62216dc8e2 ("batman-adv: frag: disallow unicast fragment in fragment")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 4a594aa2ebf66..e9553db423491 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -305,10 +305,10 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 }
 
 /**
- * batadv_skb_is_frag() - check if newly merged skb is gain a unicast packet
+ * batadv_skb_is_frag() - check if newly merged skb contains unicast fragment
  * @skb: newly merged skb
  *
- * Return: if newly skb is of type BATADV_UNICAST_FRAG
+ * Return: if newly merged skb is of type BATADV_UNICAST_FRAG
  */
 static bool batadv_skb_is_frag(struct sk_buff *skb)
 {
-- 
2.47.3

