Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877C3FE364
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471542; cv=none; b=XkGS/f0WkzuxKzGOW3ADstqqF1YbJNbTSmmRMd7n0+/iTLMyS28fnTRN+dJWWRSdQ1ZTi0Yjo/88LHx94IU0daOjSc7yTpGItPopBxatqlEvQreTdznMVvcnEZYiMjuOYipkl2lmIUodY07tbKhSwb6yZ7gxaUPGjVhGxdmJZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471542; c=relaxed/simple;
	bh=LPC7SeW5GoqoFfJ85WsrZgiTuDGi7Z/Uatcb9DXBzSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thFvCqZgkT8M4kvAgclf2EsvhzazycGVCZJEtT5sBf/zUk/Vw3almCHAxBqUOPSgFCsiK6yWw8eFrjiF6oxN4+XxDly1ByRw6RZY69+Lqsxd0kdX2OXQh4agG35HQr3nLJu1CLQCM+qvNfJU2+sHxfZ18T8sfgZ75FXzblTh2/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=OaLCIkh+; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="OaLCIkh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNPt4ar3dn4CAbmsfhCbcgmKlApMaNd5nDAF3TibFV4=;
	b=OaLCIkh+HwYBqXAwOP37DN506EdhBTARq5qsH6XjQiw5qdhRNQTNamEdWgvif63IyMWqhT
	HwVqmRFULX9O2MacuVfL8UuZQhe4fk9vfIxK0YgkSrX4u/qU0mr+qE3l20RlixIufAGD75
	IykulebofzGoOw3vjaeahHsoRac2GvMnM8rRYFVH/0Z1yCqZ2H3zX81SCNUqBSElD5mn7Z
	S/zF7MVLa/Nr8j+Ol8/qGHozCS8Fd8ayt5MVsQO1KrtbSu0Vl7mnkGqLu+kJ8bu76qdbPB
	bPxbqHnHqUbNh1LniJoMlDkwQ8zrHdleNdfm9jD8+i4JrweJ2VpAEtVMRuYUOw==
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
Subject: [PATCH net-next 06/15] batman-adv: tp_meter: fix fast recovery precondition
Date: Wed,  3 Jun 2026 09:25:17 +0200
Message-ID: <20260603072527.174487-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The fast recovery precondition checks if the recover (initialized to
BATADV_TP_FIRST_SEQ) is bigger than the received ack. But since recover is
only updated when this check is successful, it will never enter the fast
recovery mode.

According to RFC6582 Section 3.2 step 2, the check should actually be
different:

> When the third duplicate ACK is received, the TCP sender first
> checks the value of recover to see if the Cumulative
> Acknowledgment field covers more than recover

The precondition must therefore check if recover is smaller than the
received ack - basically swapping the operands of the current check.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 1655f181c9293..ae6acbc60c8ed 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -733,7 +733,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (recv_ack >= tp_vars->recover)
+		if (tp_vars->recover >= recv_ack)
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3

