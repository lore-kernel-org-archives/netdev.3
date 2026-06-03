Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF793FE64B
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471543; cv=none; b=K5TWMBQbHYgqgtS5mwkCTF/KhU7wAT8p95XQoc0OQ+kXQpAhgJrCYdcQAL5t6z93aSSFaasDlrVFnZ1YP0BfVK5wTUm9C5QJ1yyFLCURkFTW2MwZBCf04txps2gfchmJuKaHMNXnFY73FNYj82cFQKkv8VU4UK7kjlUFxwgpNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471543; c=relaxed/simple;
	bh=cmCRWkY0/BBs3A2NuF2drWTYTw8fX3+5gizUITxSNbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s03JnygkruKsgf9IWnjRcJ4FAIMJsl01wBYlq1TJVw2qmQPZxAd8lMm4gH5TcA+jh+ot2DHBni62km+UetYEXeQcaQdZ6b9LPhdYe9Frh9r+a/OFbE4KLHceuM3/umGwIcyrG5Z9Vzt7i/RYKWq/aTJsswszvHx/c51SCMymMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=RztcarUb; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="RztcarUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDF86/s12Hcq7URPeYXLwBebd69VHUBVLakWo5c4jsI=;
	b=RztcarUbW5Q5EFPM8K8dMVhr7qrnm6kHJA9UyOMuAI+1YfyFwkpN1/eBmWlrNz2N8vDtzW
	lFpCz+6R7l36AA9tEr2sTTWbijEa4ssWGjGN2/47rhvn1qXCi7jMzK56te0oi/u6v7ecpP
	z00i8LT6GXzwayVQO1lkzAoKC51ndi17Cm11Q9sISJqaGLe8g8+3ZTy8BMvadP1Ig5IiWZ
	DoHxzhIYJALQxd0i5mexCP9xPTB+u+7ZLBuEC9WzMLsZvgq+Q30n5clo7ai6N2GyeZDYxn
	ncqRdiTpBLOTDY4NRhuW4TdH+hf/i08GVvDoD2Qp9de1G8BtpHljsC4GQOQ7UA==
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
Subject: [PATCH net-next 07/15] batman-adv: tp_meter: handle seqno wrap-around for fast recovery detection
Date: Wed,  3 Jun 2026 09:25:18 +0200
Message-ID: <20260603072527.174487-8-sw@simonwunderlich.de>
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

The recover variable and the last_sent sequence number are initialized on
purpose as a really high value which will wrap-around after the first 2000
bytes. The fast recovery precondition must therefore not use simple integer
comparisons but use helpers which are aware of the sequence number
wrap-arounds.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index ae6acbc60c8ed..3d3d06c88e1c9 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -733,7 +733,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (tp_vars->recover >= recv_ack)
+		if (!batadv_seq_before(tp_vars->recover, recv_ack))
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3

