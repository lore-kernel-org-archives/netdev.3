Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743365;
	b=Z1OYdjfICRKR1jvPIN4lofFmgvvf6Lt19oAKbw3IWCFXRdX2fxDAaX0pNgXOowMLYJY7
	 vYJ30xglnPT06uAlJwHL3e8d05ulgWOZi5dvx5lVImnIAzHoj724sA3jAtPMRSuxQJDwC
	 DrslfNSAkY563hGBSXt97qYdqb/6JX1o/Hb32AGLdZWhZeEDpChSxPtXL/sXy75LR2YRd
	 bLcPUkG6ILYe6B2xr5033/0tLEgtoTiWhbK9O8kBOj0TQ0h9XQ/AqlVcQ4tFg537DJ6yd
	 s8FSS/jLJX+uEnmHB0EVsSabCF2Jzb4TNWK4VwjaTajk5CbzNctcqNfQxMeQg5Z3U8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=9SSLU/cmjzi+NG52o7mzgI2/KMBzu3Zf7RPtTnadOkw=;
	b=jSxt1GOXIg2fK9tySbbdV+1objp4HHxwvbARKp383KwGaKzYewyMi2aXMw9GaquXgfAo
	 NoMDdaVPk9SKI+eI+z14E3tuFYzxJiOPWMdkpU7UPncDzTeD3R3NFCWcJTqUvSyZk4yta
	 WGIsjCpLmX9ugkHHUjcY6MYyVfMagd+gf/tetHLXHE5yVXF2+KzCyWOkKK67sLvtP5HPk
	 D6EdIn0jKTQYj32WrR2a07o1yC/XO8rqcNRE7LHqi+CAt5HRIHvB7AWTkjmGRi/015NKi
	 nrnihCpG0MTFYS5qPj8fcQ8tKrcqD4YQU+RqVaKtMTaSsf7jkwa/mVkodA8Sc4yduFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=d+kiTKRs;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E864606A330;
	Tue,  3 Nov 2026 22:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E864606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=d+kiTKRs
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id A4C1BE835EF;
	Tue, 03 Nov 2026 23:02:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SSLU/cmjzi+NG52o7mzgI2/KMBzu3Zf7RPtTnadOkw=;
	b=d+kiTKRs7TevC2iZVJONiP+c55g6pDTGvX31fmN2XfAamADzjaoT8fjsm7VRpFEeuKU4nh
	pR/54rgabSQfB/d8YhNrdV32bMLR4+OwGy896yZWXhgJpsiw7jWUR8pJ3i9hGoaXu6TmsS
	ssjaa469n3WFXDR6EA8AcEqDTX182d+28s8HSB/zpQNY8HvGsLI3tlH+YnMwMSE53lVky4
	NWLWCgLGNt/YzNiQGVB3gJ1JvwFumCxhNbFICH0Zk4ManWd+WEFJg4GOzgW8hEPeQwMmDm
	1Fek8r+x6PQBJ7Q7PBPmtlBSKIUiFRbroXwSKyqKaGzHhvB5KohWkSsISiz7Uw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id KAQJ5cEX5N2F; Tue,  3 Nov 2026 23:02:37 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:37 +0100 (CET)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v3 02/14] net: pse-pd: remove dead pi_get_admin_state() checks
Date: Tue,  3 Nov 2026 23:02:05 +0100
Message-ID: <20261103220217.1131971-3-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103220217.1131971-1-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pse_controller_register() already fails when a driver has no
pi_get_admin_state() callback. So the checks for it in
pse_pi_is_enabled() and pse_control_get_internal() are never true.
Remove them.

No functional change. It makes the next patch, which fixes an error
path in pse_control_get_internal(), smaller.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index c0573cbbba5b..03da633c6382 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -412,13 +412,8 @@ static bool pse_pw_d_is_sw_pw_control(struct pse_controller_dev *pcdev,
 static int pse_pi_is_enabled(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
-	const struct pse_controller_ops *ops;
 	int id, ret;
 
-	ops = pcdev->ops;
-	if (!ops->pi_get_admin_state)
-		return -EOPNOTSUPP;
-
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
 	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
@@ -1425,11 +1420,6 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 		goto free_psec;
 	}
 
-	if (!pcdev->ops->pi_get_admin_state) {
-		ret = -EOPNOTSUPP;
-		goto free_psec;
-	}
-
 	/* Initialize admin_state_enabled before the regulator_get. This
 	 * aims to have the right value reported in the first is_enabled
 	 * call in case of control managed by software.
-- 
2.43.0

