Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3214AD0D
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702559; cv=none; b=WdM9McPFcyDUY5NOOGIZscPXSmX1uurz5UKLIPi8QgLalzFxZyQJ2rXb1RGNuWURqi/qcLYDIAcch3KPv6CecpIuAOveflrrHUPdA47Q2IG9ezMdzgCyQXbY0IREkAI9Lv++01isKWJEr1klCkdNVjcLrf6hc3ImxRQhZO0Z08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702559; c=relaxed/simple;
	bh=7VFxiajtNPEz8wd2qW7G25tWjW6JMDTpFm13VJwoHK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXgp50lNp8G/NwR3V56nYlDqym8d2J8MxNGoV2GM60Q5hbFXLw0adebthRYcEnppGStMc6L9dyndqOFfVahPc1pV5W85O5C4suLZXEAkuJQkkbqd1sHZ6U7NywND0EFaa/hoj5wyjS2ZvCg7aaq1aqFtenKtOYBhiZU+XPgPymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=q2lN9NrA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="q2lN9NrA"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so379883a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 17:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787702557; x=1788307357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Utmg/kSt4ut5hrQSIKyhDScZLEzGOdoo3IAf81kK6dA=;
        b=q2lN9NrAZgc1U0CyW707xwP9OjqAt1k869suvt4/yr3Z9XkiAr4lFAYKBbkaqaOIiv
         3GL5DCdxxVugVdeFcUM2/EiXdn8RCc5NfGuJu7PoVnKM+cucyCIWZcf4LAdEJYtHHnZZ
         IluaiPDzbFstwaywB8hJ8FKk2sAcodFw6/6AT94keBoAGV3Nxa0WfiWq7+jtEUNoiYcx
         6N+K+lQ/6IZA+kkk1a7b7cWFCc096/b9ibeYvblDUj/gKQZ5bVegjhkLkGKvE9Ax5ogp
         0801p9jsUY1Zy6RshCAu9/LBbTFrN4AgHOi70ZEcQzKMK9r6sCrF1XwBsBO+RnRAXazv
         R0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787702557; x=1788307357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Utmg/kSt4ut5hrQSIKyhDScZLEzGOdoo3IAf81kK6dA=;
        b=iY8TiqZl0geW0OaMuXcPk09z/vMhqauwx+x3w4scu2J41EUc4lYpxAd7PYuoJU0h+G
         u6mmv4ojBQ1Wl8yY7fJgp5+RWf9JnYU+8+vz3+pmdAS53fCU+ZFfQco+3WKOeCgokgyh
         hFGF2HQDNQUY5ckXXSKzPDRjrjuWe9StjFFkoZtCQaufWrOYY/X95Di0VLBNqG6s+77J
         lkFMqb+28k728jffmviKJFBcqum1ePfkPK38a1SWBLc15lT+qZ8wHBo2cnVlLZp50Lul
         rPbnViVWfwBhH/QewHdcvHQdPFM3RfVPfBq/pOJxDKUnRQkS1j/EDEm2nJk2kKIg1dh4
         3FxA==
X-Gm-Message-State: AFuF++lrGG922XvVARE4g+vDwU9KnJrDlBVxvPoLpRv2YNRDiG008dhh
	sBNlBAT2iP4xvtmWavlH7VeD8Mgch3jRsfMykgGqIYYhzU4ypcWHkNJbsJY7sBstpka0SePnjqi
	7yoCDlgw=
X-Gm-Gg: AR+sD11DhzQQ/S2SzBTCZa+BI5ZUDv0jfDVdKwvEnLNF9qKZ7/6xCEcjCsTD0KrQNFQ
	6Fy7fInEnXy+nJxwKVlv9KS4dVOTZTUs9AfgKKQgSMAGlAKigmedAH/eJwPIguwRlxETCr5URaK
	TC2YerK2FYHV0pGHT3IIX2Fn8w26pyuob37ZnTpwmRn6EsGjeUPhPH6YEZticCldtgeNOs/IjK+
	g0xQkDLlorjuPmTKH/nmAg3i91h3RmwzWGXkqU9rLM58ALRAgGFOGuQwC6XI+cc0zj3B186hI2T
	QNCh9G/kmEYgB8/n2z6btpcuck86VYi7sN8J/iOUx51PVwNIEDy7NJOZBnn9zcxoN1+0mebj11V
	xM7JJJDWBbZilx7ZQdo35lkoX6LpUwZbnAj5oFmykR2R52N1uPNpchQHYSl/4WK/0ev1etCVdzJ
	3AHK6DlWdsNfeu09W55R1ltEVad1Itylk/DY1bZPjnaUo=
X-Received: by 2002:a17:90b:560c:b0:396:67ed:da2d with SMTP id 98e67ed59e1d1-3966d4931a0mr5782303a91.15.1787702556523;
        Tue, 25 Aug 2026 17:02:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645da08desm5362829a91.17.2026.08.25.17.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 17:02:35 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Simon Horman <horms@kernel.org>
Cc: kalesh-anakkur.purayil@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	stable@vger.kernel.org
Subject: [PATCH net] bnxt_en: Write doorbell when linearizing skb fails
Date: Tue, 25 Aug 2026 17:02:33 -0700
Message-ID: <20260826000234.2031564-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the driver is handed a burst of packets, the doorbell is deferred
until the end. If the last packet has a huge number of frags, but fails
to linearize, the doorbell will not be written adding latency on TX for
any packets in the ring and holding their DMA mappings until the next
TX. Note that the queue is not stopped, so this issue would delay
pending BDs until the next TX.

This issue was discovered by Sashiko and reading the code verifies that,
while unlikely, it is possible.

Fix this by jumping to tx_free, which replicates the same pre-existing
logic but also writes the doorbell.

Fixes: b91e82129400 ("bnxt_en: Linearize TX SKB if the fragments exceed the max")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9c2cc50276a5..d59bcca73a2b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -502,11 +502,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
 		netdev_warn_once(dev, "SKB has too many (%d) fragments, max supported is %d.  SKB will be linearized.\n",
 				 skb_shinfo(skb)->nr_frags, TX_MAX_FRAGS);
-		if (skb_linearize(skb)) {
-			dev_kfree_skb_any(skb);
-			dev_core_stats_tx_dropped_inc(dev);
-			return NETDEV_TX_OK;
-		}
+		if (skb_linearize(skb))
+			goto tx_free;
 	}
 #endif
 	if (skb_is_gso(skb) &&

base-commit: dc4b95b8fee95113587e93ca116356032d271371
-- 
2.53.0-Meta

