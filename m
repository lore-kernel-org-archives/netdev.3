Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B342316D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828396; cv=none; b=GudHHShHqGQsH7CFDd4F/ycU3jlDMkR5RoKsIXpvKKcgNhoVxOsr7tnNSoLvdGP3k4hacTzyG6ByY/Ofdz5bOleQQm7xJQ2jAjQ5TtLfMPWwqKVS/hm1yX8Cy1yeJhkvrPten6ibLrNTms18hy4yPoO3nYibZm360I0/txYZGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828396; c=relaxed/simple;
	bh=AGYnK8Y229cy2pULgFBWan1ATTD5fF6JHa5iBdp/dZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsgaT8YYWKQr7ZUJalaUMYAo0FOOWRSj0rxIydH+ZegrEExXMfhEAj2q+Qwyq1cTPhRSYNaLT0heMWe3vjFrAjQqAsB4URP2d+cpCIcM/9PoNtkK56uwuhIa4mE5S0E/x8EPAm0kSde6ATI5ORO4k758DtwZOt7JmRHdxGsHzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=R78WvwtA; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="R78WvwtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OE7kaThEXzmWHJ+vL8/Sll0PpMgBMOG7wZO9WyyOoi0=;
	b=R78WvwtAhpCvWYI04JrJvK9a/3wQdA/xlEyEfxVDslavU/7H2wCDgFVkAN2AheZ/uanrQX
	yzHgTGr+/LMKDIHBZI1ZRNweenkZhHy82D7KPke+hT4q1a0fT/UG+Z0K0Jxy1kijgBHj0X
	6MY4uWrCw7/s+C3zh4OKtDUrJ6+9qijtkyZHVvrTHkU4KoL6FVrbsoCIN+m0Fuu+st6bCL
	OlxrmNImdhkq4JL4sm+IOP/C20iTAFlNZTrIiXBbMIvCFc9hwDkx4bYMs+E+95YxnSwUz6
	3Igq4U5uT84QUFCdpQuQuvXDWJJLah6WEDDbKBeM0H2DNeA4EYdlvnmpoE7aGw==
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
Subject: [PATCH net-next 11/15] batman-adv: tp_meter: simplify unordered ack calculation
Date: Tue, 30 Jun 2026 16:06:19 +0200
Message-ID: <20260630140623.88431-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

When batadv_tp_ack_unordered() goes through the list of unacked sequence
numbers and checks for now closed gaps, it is first calculating a delta of
the sequence numbers which could be acked. Just to revert this calculation
in the next steps to the sequence number which would be ackable.

Skip the delta step and directly work with the sequence numbers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index c2eea7dbc4883..b7fee6e55f032 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1493,10 +1493,10 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 		if (batadv_seq_before(tp_vars->last_recv, un->seqno))
 			break;
 
-		to_ack = un->seqno + un->len - tp_vars->last_recv;
+		to_ack = un->seqno + un->len;
 
-		if (batadv_seq_before(tp_vars->last_recv, un->seqno + un->len))
-			tp_vars->last_recv += to_ack;
+		if (batadv_seq_before(tp_vars->last_recv, to_ack))
+			tp_vars->last_recv = to_ack;
 
 		list_del(&un->list);
 		kfree(un);
-- 
2.47.3

