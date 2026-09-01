Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F047ECC1;
	Tue,  1 Sep 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268945; cv=pass; b=CiWevPy1yLZCDmuUQIaehE77K7bs17v1FvMbBfEUDPphsNqBbCbq+mo8nNlEDrDq/mB4lhMR56LgVsqkXYyal7LKa4gqHRVsi5HS3ajJkuI2++Ink3am3RQlc905i8uN8HpKVpoSm19qzlAGz5b9D/NfiyQ+ZwI+8Or0dlGA6hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268945; c=relaxed/simple;
	bh=WqScErXHLIxXCEjTed+lPGyvHThfPzNMYs1ezWOako8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGrPYaK2wAOMwTX0QUB1UkzDkGvfMF08uW2dYa5YKli/LaThbFppZ24nCZJGiM1kLiUaWFgPIr8IlAh3fOF2cvn8QoJ5IBnkVjjvEsMFUEsIXpD7Wt2jdx83urlHRcrTioh2+VcE6gimCZptCn19+1OfeZU55PWPBssYQlHAHv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ys4pOgVd; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ys4pOgVd"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ63G68JWz49QPY;
	Tue, 01 Sep 2026 16:22:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJzg4P4QLrj75qtjVLOwYgEJe07MA1YoOLZt79qoTIA=;
	b=Ys4pOgVdzbseZALIplz9Jqsb6/qT3W7Yvp+NODMaSaCfbyMVZYB3KkBSPUr0YQ9vtAxvcg
	3/FrX8P1Qis2Lq/aO9oZeyG02WYQGG3AsC0lwzNw6sg2zkoWKx2sZ9SrYRtFuJXtZVymQX
	HZPTug0G/mFalMhQETM1UvgZMGodQWIlvZ12jCnPoYEe34/EBIcqXBooQxr/ivuBB9W6Ts
	igpcAG01w4yHFSLF2eTgO9tk9S5drZvZn2dbeXj4UXT45zRZ1pXP32hMH3QBVjnaGbmBfa
	yNvzv1O9qCX/GT6nlHasIionM7+2hv7A8wJCYmIVkO+MWg7Fo3o/Eb5KXKWIhA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268938;
	b=sEETn95gXP7RItB8nXWiM+2AI8RKy1qlva3xFX6s9CcG3kdDQVK0W9OAtyqojavv9hDcfc
	YjxM+Sq7fBSm3UfYlVeWML0pg/x+eTUOwUMELORXXSBXDVlWiLEE5DIC7zrpqmFrZNQQym
	N3T3NM6cd4m5yBq7TNndq2AAHeMi6yVe++G+48nXjEtH7C9+C9r9bf99sUbMsJ88go/NT9
	TtBUzw4deOxgJzRhaYaCAG+DqBu9EQTmk1Mkt2NtVQt5KQkHdM5/DFpID5e7IBWuoDUF5q
	avsrgNCgyNJDy29bZpYW5RaKG7Pah8j9ddr04OXDO3lvpgzQhTo9HgaYqpMxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJzg4P4QLrj75qtjVLOwYgEJe07MA1YoOLZt79qoTIA=;
	b=GD+OTkRo94ka+5cyDWoanhOs+BIhcB9Ae7U3W2xB3sEUIhw+1Jf03rFldCMVEXrq5DS2Rx
	aUQ07XNcTuEXYa5Qxkkms4pgq0+P6YevRZY7r0eLUbrJNeTJNjdd1aWLpmK8Qw0J4cLKdK
	LMFwgN15HSLQAJQAWlxrKsbbUfQZEjqi6Lz94+SxYVD0hZbXKKp5CtUMcpsKJbMydaKI6+
	mHRPUKa3aQJps+6u7a33/YKsCfkqwz6lnia38VXQr6KBrc87s/09X3MJ3vrn4gGghAhEIW
	WDRBoh/XVgc5U2aFHxqBbtJqFq9U4ZQdqttWQaM5v8Md0lMPekPDhI038wtKdg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
To: linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Andy Gross <agross@kernel.org>,
	Mihai Moldovan <ionic@ionic.de>,
	Denis Kenzior <denkenz@gmail.com>,
	Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 14/15] net: qrtr: use nid modulo 65536 in 32-bit lookups
Date: Tue,  1 Sep 2026 16:19:33 +0300
Message-Id: <20260901131934.225991-15-juha-matti.tilli@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The node id is chosen by the device firmware, and is generally a small
single number. However, there's nothing to prevent the device from
choosing a large node id. Use node id modulo 65536 in 32-bit systems to
allow it to work in cases where the node id is large.

NOTE: please don't merge yet. This commit will have to be either
squashed or removed.

Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 net/qrtr/af_qrtr.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index f1601c0701fdb..960e6e816be41 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -497,8 +497,11 @@ static struct qrtr_node *qrtr_node_lookup(unsigned int endpoint_id,
 	unsigned long flags;
 	unsigned long key = 0;
 
-	if (endpoint_id > QRTR_INDEX_HALF_UNSIGNED_MAX ||
-	    nid > QRTR_INDEX_HALF_UNSIGNED_MAX)
+	/* nid is chosen by device firmware and is generally a single
+	 * and small number. If firmware chooses otherwise, use it
+	 * modulo 65536 in 32-bit systems.
+	 */
+	if (endpoint_id > QRTR_INDEX_HALF_UNSIGNED_MAX)
 		return node;
 
 	key = ((unsigned long)(endpoint_id) << QRTR_INDEX_HALF_BITS) |
@@ -529,8 +532,11 @@ static int qrtr_node_assign(struct qrtr_node *node, unsigned int nid)
 	if (nid == QRTR_EP_NID_AUTO)
 		return 0;
 
-	if (node->ep->id > QRTR_INDEX_HALF_UNSIGNED_MAX ||
-	    nid > QRTR_INDEX_HALF_UNSIGNED_MAX)
+	/* nid is chosen by device firmware and is generally a single
+	 * and small number. If firmware chooses otherwise, use it
+	 * modulo 65536 in 32-bit systems.
+	 */
+	if (node->ep->id > QRTR_INDEX_HALF_UNSIGNED_MAX)
 		return -EINVAL;
 
 	spin_lock_irqsave(&qrtr_nodes_lock, flags);
-- 
2.34.1

