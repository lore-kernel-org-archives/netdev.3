Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660F3EB7E9
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762108; cv=none; b=ijIRYYdZe0ll5czb9c8Uy2zsAV0QbXUFbpMQ8/Og2IoMC6NjNqgQxF+jxAP4LulpUzBtEVixluugBCHHIONkqxPpIVRrfa7JnKvm/q5MmKEx5GvwCXNSSMQCVStLNSt8Sqoq9rXTxIpfKSE/DqMbX2pX2iGTmAxz7ulJeZ6nE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762108; c=relaxed/simple;
	bh=/7I/VCnq5pZaIr72EkAMGkNNmPWsNzI/7TN/Xfw32is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMxJpbN8gM0HCjwReT/qmMUbYb/jkntWv/wZm9q6Ehd7cph4yytRyYweoaHaTZz0kojODDjfS4d05mAATmpwkyIRdDt8nMR+xP/EMUwlnpbA/U3qrvt7bqAlNkYATvLHShhJjHKi6PspPuBl6mpez14eIr8wqdM2AVYdBhhDvD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=e4KWLpEr; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="e4KWLpEr"
Received: from kero.packetmixer.de (p200300C5970e81d8CF20e45A7328d917.dip0.t-ipconnect.de [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 5E3F6FA1B1;
	Wed, 30 Sep 2026 11:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5s65kUEIQ6lts0wP4b/pMJdL00+yeUg9JgdP+cJ2r+E=;
	b=e4KWLpErfZYR/+NkF+SFWZab7WqucmE9TZeA/3WQVN2ePjceeZXLuryDHaFTETg/IMSoUi
	hCrhPU23qL1VO+kubijT2OhFLpVlO27V4doIMwibnCqxIdrYb5lqAcQzCI/Qd0xS6/mRMH
	R83SQsE2dWB2MFsQloLIgjL9GrI1dIoIpZH8V5NlFl26DFAmNRWzYOpKut/Fagee5iZdl0
	SeETHjy+f+T0EOJf1H409fXp6IvYzx2Hasl8N9HJ8Mo8jCEreSqIWCiZQRePqgYTCgJvkC
	wBF6gD7zdUr0lC/nsMX1wS44F52o9ksBORX5NK2OvBqdwPhrKHeDMC0SURYXZQ==
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
Subject: [PATCH net-next 4/9] batman-adv: tt: soften kernel-doc for batadv_tt_local_remove_now()
Date: Wed, 30 Sep 2026 11:45:53 +0200
Message-ID: <20260930094558.3723766-5-sw@simonwunderlich.de>
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

The "never announced" statement is too harsh for an entry which could have
been actually be announced by a different context while the
batadv_tt_local_remove_now() is in the process of being called. "not yet"
might be more appropriate.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de?part=11
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 78f032c9ad65c..354d9416c1b75 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1478,13 +1478,16 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
 }
 
 /**
- * batadv_tt_local_remove_now() - purge a local entry which was never announced
+ * batadv_tt_local_remove_now() - purge a local entry which was not (yet) announced
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local_entry: local TT entry to purge
  *
- * A client which was added right after the last ttvn increment was never sent
- * to the other nodes. It can therefore be dropped from the local table without
- * waiting for the next ttvn increment.
+ * A client which was added right after the last ttvn increment was not (yet)
+ * sent to the other nodes. It can therefore be dropped from the local table
+ * without waiting for the next ttvn increment.
+ *
+ * If it was still announced by a parallel context before it was removed from
+ * the hash, then the local TT size adjustment will be handled automatically.
  */
 static void
 batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
-- 
2.47.3

