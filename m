Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71F515970
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913035; cv=none; b=UhFoOlLw+NPTbRZM+YQA8RMu5w0B6sYkrAsAMSd/MfITlcVtEQjsuhzgDTEn4T5TkWEMt0YhGJU8s0BU4oFs6Ypju05Fj2gP+hM7Gp60ZnCkhRAxeZiyz0XezA2qbbLr1DdbnSDy/4OBoFiY0u8FMxGeNfnAEOwUQrPwrcvGXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913035; c=relaxed/simple;
	bh=2MQnYF+IT59P84pyzCWUUmbxrt2pBgiQSCNIzZNtj1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DEXHjASXxaRtwNrN3q3y9nDtu6FuMvaEG1m/64YSr+Hfd70XCCFxuf13PU3BZiHrL83B++oa83tPO3qadk6eiykhIzJVghfLXSM2x7yJTniVmUD+xeR/tt8xyZOIeSTs3QcHCIsAUl9x82V/B7zagqsjxqKi64YFcRmONNniI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPi1He8b; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPi1He8b"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-822ddb835fbso2392018a34.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791913033; x=1792517833; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1BLtIj0xEvl7cfZrXbIf/98tRmcqVQkUnaAEHoiODWY=;
        b=fPi1He8bgFUdd44Vzb4eCvyCtxM8VoE1DDb2VMz9DGd87pJyOfRNnlEvtvR48nAq+S
         doQ7Ksouj9d0p8ntmMhlZtRNP75qeL27DEqd3IRMf+INBkB5X92aJSwOm/uLZo/blqCP
         0MvzKP+q8f53iF7C5/CvQ+C1btDk2EYp6GIU2zzTKQeVpv+hlZlA516MkJTahIoh11d/
         arJ0vuk6FsX3aozYX/ShzILK6bLgLgKHO7hQgd5xVv1xsex5uGI9dnF0qrv89u6GzX/8
         U7FMps3ZRsDF/wLVQSwvC83abfHT+ACGoqOIOTSJJohFGeAjtQb81RAShHvoVpNfg663
         FBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791913033; x=1792517833;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1BLtIj0xEvl7cfZrXbIf/98tRmcqVQkUnaAEHoiODWY=;
        b=AvAUzOf4ZdgxSmVCr1kDAymCERT9BYTeOk1PTmenEytLJbdXssNQ2U1RqS2Y10v56V
         65aaEz7SzwHA3sQXHHtVJ5iNhuBOcaDQ7ToTCYhX9Vs0tkndKD7FSAb/qJ+T7frjlsZ7
         XbslIX0WMs4TifyB3g0DaAghc1C9cvV0QfUW8xRPhsVCH9u9OvAZ/lkJ1I+tP5rdB8Wn
         elaPibIglAfoV4fkylfjD277Imhy01qK/C8nKXVtLC3oimqzfSW/96ztaJpRsKLU5YVY
         xaik0rHLNj3LcsOhEIbN+fjn5xVl6mDbzslvcRsyVllbomg53e8x86Iw2EE2ZBZXjvkF
         FkVA==
X-Gm-Message-State: AFq9FYKRbeUN0REp6pNeQ/wTVQ24vleklcNMc0oJLvtHC71DqZf03tBR
	rmb2QLedsgV2UCbGkqC+Zcdg7zlO75fKWk2x44a9Aua4H+7DRofXoQ/u
X-Gm-Gg: AYBFou0Fp/OTQDsVKL78l0HavCewWneRRhS5Yp6IE3O/NfPYZfvpnsv5gOl8MvM/sPQ
	ql9GGIEhSTp/Gev48VB1xkgiwqQzBWM/QlxIgzm81pwwQmMKG6HCtI3GZQjbOTHth8b7d+/gY3K
	TeAw+OldiRC1WGgLrQzRM/AKc/eTSico6agI1wA3xWJ+lNwspdmXKbJO5ar9eCjZrRPk+DDQFUF
	eFfKPsIAVZKLI6CfP/Y8+wi5fR6WF6+bqvR8WZ0W5CWtHQx/NzJRSyvEwzz1zWc4r9sStZW2xAQ
	LY4J813VJo0ZlWu1DZasLWCSmG/oLqaYifTaZBsbaR8fqgbNjLrcKcXnRMGKZybP6XnY5e1kqDQ
	CDhrKzKItnO/InJAXEYdBsBqq5CMUCuPM+rp3q8RkqUMxlAFpjfuJRa1nZ3v15xBkiQO4LZsHM3
	zn/NBC04zMs8+yexXTNx7el/JbnNs7m7p99OFUQOSwR6LdFt/Jc5wmOU/1qLbnDD5qug1uAe4I1
	aul7+H55fdVW2rfzqFTdp44G/urj5cXx33CMlg3N2PL6ykH0dAfXiz+cZxm0tOsbyD3+zk9aVFm
	F1tsiaRCX8y6XWl8PM94aqrPicALABN++qmtODgNBsKzdv9z3m5KKr1ZcSm1k1oQ4ZvGUEsYZZ6
	SoHbSRYYihKpuuGpg/V1+5avC778YYnU=
X-Received: by 2002:a05:6830:a1d9:20b0:83c:73b7:e7a7 with SMTP id 46e09a7af769-83c73b7f03cmr848517a34.15.1791913032755;
        Tue, 13 Oct 2026 10:37:12 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a60c458sm14564908a34.26.2026.10.13.10.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:37:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 13 Oct 2026 11:37:11 -0600
Subject: [PATCH net-next v3] net: stmmac: unwind the WoL IRQ after a safety
 IRQ request failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-stmmac-irq-unwind-v3-1-fff4e2db805a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OQW7DIBAF0KtYrEs1YzCGrHqPqgvA4wSpxg0QJ
 1HkuxfRquqi6vLra96fB8uUAmV26B4s0RZyWGMN4qlj/mTjkXiYamY99AqMAJ7LsljPQzrzS7y
 GOHFwpJUBVEJPrN59JJrDrZmvLFLhkW6FvX01ic6XOlK+a2czcb8uSyiHDgY3ABoHODsjpXBgL
 EmahLQzohisBqul1806hVzWdG+Pb9iwf37ckCMHry0MYlTox5fjYsP7c51u2tb/CAig/hL6KqC
 Rg0GvR6ngt7Dv+yf4gEz5SgEAAA==
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
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The safety IRQ is requested after the MAC and optional WoL IRQs. If its
request fails, stmmac_free_irq() frees the unregistered safety IRQ and
leaks the WoL handler. This can warn about an already-free IRQ and make
the next open fail.

Move the safety and WoL cleanup labels into reverse acquisition order.

This was found by code inspection while working on the stmmac MTU/resume
recovery series. Injecting a safety IRQ request failure in QEMU with
mocked MAC/DMA hardware reproduced the "Trying to free already-free IRQ"
warning and leaked WoL handler. The failure has not been observed without
fault injection.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Changes in v3:
- Rebase onto net-next and drop the Fixes tag as requested.
- Describe how the issue was found and reproduced in the commit message.
- Add Maxime Chevallier's Reviewed-by.
- No code changes.
- Link to v2: https://patch.msgid.link/20261006-stmmac-irq-unwind-v2-1-194591c87460@gmail.com

Changes in v2:
- Drop the claim that later per-queue IRQ failures also had broken
  cleanup; those paths already released both IRQs.
- Add Nicolai Buchwitz's Reviewed-by.
- Link to v1: https://patch.msgid.link/20260930-stmmac-irq-unwind-v1-1-0c8a053761c7@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 56d89a696272..3ce2d5994c61 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3821,13 +3821,13 @@ static void stmmac_free_irq(struct net_device *dev,
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
base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
change-id: 20260930-stmmac-irq-unwind-0be86901638d

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

