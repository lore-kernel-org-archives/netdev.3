Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5153ACF0A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270413; cv=none; b=m3xs1XyVkczgsxXE/pRXO5TAxBzZ41NkYksUmu0tjmnzWp2IST6G8G3MXCGbtTkygT8RdHjixvuJUDosiM1gmjFcyJ3QYo/9Fp75E7Fs0b+JyLr3ithR6QkCBmN2IJWBE12Ox3jBkxOVikOX0QoNB4UFPFcw0zcVQ9qnERNyJOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270413; c=relaxed/simple;
	bh=mPvj7W/QG+PiUipbHXku7C2+y2BmQD18DdrM2kXT+qY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nLL5J3/QATC9eaGZ/xXqHeHCELNYxtvV9In7J87wcC0+FUwHGonJAC8weDOx3CtF81kkbvo5hdOiOpliUHm4fzQBudgx9ID4YxXuI87Iskk79qSvv8nlUGm9A1/RKiqIFsLalg8CFcbof/dFFL5V6Wn+x6vY3uYpWyz7YKImkjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6fhUXEf; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6fhUXEf"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-82395ae2ea8so2502487a34.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 00:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791270410; x=1791875210; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DsH0G6S1GKPGvSb0ocmL5fv+2ES1Y4yXt8zV4U+kiqc=;
        b=V6fhUXEfOxr+vr4uqNbgwQHze/VvMKCHp7PHlg5MA5IkI4lda44Xd8yLbjluocsTc+
         DOBUu2ELW6Wh/Tw4DhkTc2lRsVQkSUXcERkLKBmJCXQtUwa9tq3m+w2rGboZTPTM3zwP
         yMRJa9K2nKwEqGqMrdJUo2DHQgDBdxCedeIP5hYnygHl7UcJYxoeZslnUrdrXLjJmJ7y
         aSL4Nw7dAxZ9sWfztGvh6dFymvjLw+xFNPP8um26G3fyT1bhBbcs1R9EtQgxYR5nkF0b
         W/vGDuru22Q+SjK69QXLtBYRlWNoU+8vqTs4Ec+XYO+stvimH3QxnNqyPua6vRjhA7tH
         jADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791270410; x=1791875210;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DsH0G6S1GKPGvSb0ocmL5fv+2ES1Y4yXt8zV4U+kiqc=;
        b=YRAqkBLwV6/0w1MKhyqZwWFC5AsZ/JDCazy0kXnfXMjpIseSG7b0PigK8MXSvxnVJt
         IwsIwA+4uLw7KUEOGv8Y3bEDrZe9/FtWP7WekmcGeVhYyRSsgD6NXYHhCn3ZP9ciH3ne
         nGVKyU7lJzL+TBNd6qIf3IxUPXergs86XF9JKHk9B+/RHrS6SzmprvW4sGYfGeLy+H5P
         8J8VphAktHMJX/6LzxAFtwU4Esc/jeWFUEuNkni77K/4zTRzn2bIpxE2oFVoRWiE2XUz
         TtFMtpO6D5X4hvWFGf1vcwiu1ZChClHHCANvrQgohR+o/eodVMCAUPeqM5I4BfRyEqqK
         7KzQ==
X-Gm-Message-State: AFuF++lAg+2ajVnYPCzFh5ZEvrGRSMAMz1ayPWlWlfyiO8sLD9yY+pp/
	8iVn0DoT0D0Cd+Rroo5AVU1JhSFXz+6yZI2CQu0U0+hk9ugQmKvShneh
X-Gm-Gg: AYBFou2o7o4dL/c5+F74FPORIJyr1MOdNOUExVPRASGlCFG9l9r/qlG/utEQ6zQ5vmv
	rajIZEWstdUVwLuVEqWuyZWzRugdLXJGhnDN+8FCfI+VHmxbp08sMcPz06VI/OtM5BuNQJe0h3M
	Tk6vibX1ZzXEHIU2T0OFg/7ppflX3oGuTTraInMsesnbTrbQKoX/WPVowXGdZAx7aAtCdMhXdbp
	vcpRyrolT81k6IBzfpNmw2Bmhzw8IAsJ+mmGkS8jswDZORaNwvE7zZJ0pRIeKBWY8MOiwu1Hjx4
	7j3u3mlXr4WOhn5Zh/x11Vqi8ObnJuvq4GYtoor/LCMq8iQnrV6dwulyQc6H5urFqFpRf35yi+w
	LLdzLZ3wi34X+RgPSfiBtgO1ElV3aeS1ZbzramXY9SdBV3+U4U5fu953seSRx14DMg3ArU1w39g
	Veuf5vu7RMfBIn3v+In/hzgXk6WFk8QyxcYFPATjNAhICy1Vfm4851RrT5201DOY7+YAWHtBnT9
	NJppGcM/IS4sZACQ+EBMUuUJZonJ1REZ65cbslXn+ZB7NLhCdjJWNIcTHZ05hueGYnHfeNpVMlr
	5GSXzFdvU/0XBRh0jWiF0GO/1HbHFFkko6gYwBQJsJ54k9xAWsOkcHR3ZalnvTsnOFt3eIcamus
	EE36xJ9BGn58+ghVpkSo+Sw==
X-Received: by 2002:a05:6830:918:b0:81f:1790:6ad8 with SMTP id 46e09a7af769-823fe60d648mr10940977a34.31.1791270409780;
        Tue, 06 Oct 2026 00:06:49 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-828209a9efbsm1939854a34.21.2026.10.06.00.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:06:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 06 Oct 2026 01:06:48 -0600
Subject: [PATCH net v2] net: stmmac: unwind the WoL IRQ after a safety IRQ
 request failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-stmmac-irq-unwind-v2-1-194591c87460@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OwW7DIBBEf8XiXKoFgoGc+h9VDgveJisVuwHiJ
 or870Vuzz3OjObNPEWlwlTFcXiKQitXXuYu9Msg0gXnM0meuhYa9AjBgKwtZ0ySy1Xe5m+eJwm
 R/BhAjcZPove+Cn3wfWe+i5maOP2aha63zm9/ScRKMi05czsOk0UAF0M8WJeCshgVWqO1Ix9Mo
 AMojxgc7qwL17aUx/55VTvsn3urkkpC8gjWuFEl93bOyJ+vfVqctm37AaB4rr0DAQAA
X-Change-ID: 20260930-stmmac-irq-unwind-0be86901638d
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Serge Semin <fancer.lancer@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Nicolai Buchwitz <nb@tipi-net.de>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The safety IRQ is requested after the MAC and optional WoL IRQs. If its
request fails, stmmac_free_irq() frees the unregistered safety IRQ and
leaks the WoL handler. This can warn about an already-free IRQ and make
the next open fail.

Move the safety and WoL cleanup labels into reverse acquisition order.

Fixes: 5c2215167d12 ("net: stmmac: Add driver support for common safety IRQ")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Changes in v2:
- Drop the claim that later per-queue IRQ failures also had broken
  cleanup; those paths already released both IRQs.
- Add Nicolai Buchwitz's Reviewed-by.
- Link to v1: https://patch.msgid.link/20260930-stmmac-irq-unwind-v1-1-0c8a053761c7@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b837e8e27a35..0403d434c9b9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3799,13 +3799,13 @@ static void stmmac_free_irq(struct net_device *dev,
 			free_irq(msi->sfty_ce_irq, dev);
 		fallthrough;
 	case REQ_IRQ_ERR_SFTY_CE:
-		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
-			free_irq(priv->wol_irq, dev);
-		fallthrough;
-	case REQ_IRQ_ERR_SFTY:
 		if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
 			free_irq(priv->sfty_irq, dev);
 		fallthrough;
+	case REQ_IRQ_ERR_SFTY:
+		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
+			free_irq(priv->wol_irq, dev);
+		fallthrough;
 	case REQ_IRQ_ERR_WOL:
 		free_irq(dev->irq, dev);
 		fallthrough;

---
base-commit: d5a007b9b457c915ab1a53227e8939e4018aa97a
change-id: 20260930-stmmac-irq-unwind-0be86901638d

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

