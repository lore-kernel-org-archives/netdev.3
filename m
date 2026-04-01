Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAEF2135AD
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028838; cv=none; b=lyU7DE1FoO1kevc0Ii6gXyoyypiCv+skHDhY1eyT2BvoBBfSeakGI+za9kzO3fgAOeY7dB4kiUGz03mWQ/Ng8xtexheEZNofdqhb8vAPcDV8Xp7Vv/Y5mCBjk0oBzfMHnuxPbFifDlSJhegIENmD3Ls2lfwP/YKWy1c27xSV+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028838; c=relaxed/simple;
	bh=gZGiGnsfC/d+64wqmpHAt9CUrjDY2JKgCXf5EK8b7Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1RwoQfrm1Vg4mIDgMqn4b51IIKuOsN28I89ojzZ3h46hThe3P05Uc2jmXlQ9SpK/VbZy66QvdaOZWrg3yyN6zb7R3zHODzqBYR3IfVW7EyBIwJnjdvJ3hB5t+0Yab2CoUgB3/dfQWfPMOQePYjdKYmfN297bwjlr3bQ4Fqb90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q57-00076g-TL; Wed, 01 Apr 2026 09:33:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q57-003Ahd-1X;
	Wed, 01 Apr 2026 09:33:41 +0200
Received: from blackshift.org (unknown [IPv6:2a0a:edc0:0:701:a82f:fdef:12b2:33d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 20390513378;
	Wed, 01 Apr 2026 07:33:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 5/6] can: rcar_can: Convert to FIELD_MODIFY()
Date: Wed,  1 Apr 2026 09:30:13 +0200
Message-ID: <20260401073338.5592-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401073338.5592-1-mkl@pengutronix.de>
References: <20260401073338.5592-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Use the FIELD_MODIFY() helper instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/ee2e6aaacd5e061c972716ecaf8a929be7ef5f2e.1772705647.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index fc3df328e877..2727c5ce029c 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -496,8 +496,7 @@ static void rcar_can_start(struct net_device *ndev)
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* Go to operation mode */
-	ctlr &= ~RCAR_CAN_CTLR_CANM;
-	ctlr |= FIELD_PREP(RCAR_CAN_CTLR_CANM, RCAR_CAN_CTLR_CANM_OPER);
+	FIELD_MODIFY(RCAR_CAN_CTLR_CANM, &ctlr, RCAR_CAN_CTLR_CANM_OPER);
 	writew(ctlr, &priv->regs->ctlr);
 	for (i = 0; i < MAX_STR_READS; i++) {
 		if (!(readw(&priv->regs->str) & RCAR_CAN_STR_RSTST))
-- 
2.53.0

