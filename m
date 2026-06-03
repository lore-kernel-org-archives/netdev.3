Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9443C061
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524757; cv=none; b=Sl1AwyeZYGGe26mytRV7AlBQ5wOBa+eUM3Yyk/gVfW3CwgTaYEHsq8cS4ynPxvrZSjB7HLFIFIFBcDS2Jk6J9kcvkjEzW9r/tNiuPiI2pL8sPEKhGsKdFI2GC1LSjU2QQJKjryGbX8ifjsGM5UZE+mh8WoAmzB5Si/6FnIAbD5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524757; c=relaxed/simple;
	bh=m5uQLcScS0ZfKU3Svk4zmwu3YI1nuCzDlh+qylhiGa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXbNAXxfVViazPZ7a1jLHMcVC97mY5shWyu/nVSocA2BpNqgwX8oOllpW700lqq+5uFx1seLVRwo1iI7Kt/n2s0bPgs2lGWtav7AgqwHdWR2XOYpSBXoljPjpdd6vEAdNt+rcDkX/0kNWnQ6dF1Co5qEw14ETBqkBnRXIPKIKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lhhbq13r; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lhhbq13r"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36bdb11bf8bso8657a91.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780524755; x=1781129555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJDVJnZRGyqGtwmDDNLRn29L8olqenMgNSPzxVIi8YQ=;
        b=Lhhbq13rPve81uYXuhWvv8tEC+9kRZVT8ZJvKSuUS/WAtWAYimm7IP59zZgqI/w0Aa
         26mnwxD+GRnNhx7qra+aS4Vj1sSX/snoY9yCILDJhTnXtLR6aMINmNwTGKbcwLZXh0xa
         QOzrpAJHhI0Rzc5SUQAubeBgkZrZErZV09MCDXj4r2aMCPGmcjk2aunuwlN6IsnCGTUA
         GvZ9wnhKJblAF/oIPKFR07kE1m6t41BIiFLKe3eyw2zEozA6QeGVB8EwwyQvQ/1Z/UKA
         ef/Nz+stYzMDz7udR3Mfayl1XSTx7MPhfwXIjSpAa6RZ6UJ2P/FXQVyZWZICBPxuvini
         wgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780524755; x=1781129555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJDVJnZRGyqGtwmDDNLRn29L8olqenMgNSPzxVIi8YQ=;
        b=QHko3kAk7MVefoHotHJzaE3rRiZgKjgIFO7Ymypy/0YfnOPxj8GsCrNe4tq2MS7Uw8
         TviuiKCi5fY7ql5DmPWogbcTh2e+t2a+wfBr8Ld1khKWACzhthsj9/+zLvE/PJAXuPHn
         LxiWZGhvQuAUleY75/L6Pjr2OjTPhxLyaNX7/AXQRld38sfIPM2EPk9RdcQ7+GYmJloQ
         /9v6/4D5JWvY/+HfvWSgpgrLKzdKrOt8QDlFxZ2HjrakeICRZUlMyGavcyxcSXuEPby/
         aUxord4adnjorObDsvep8GnmUx+o2Ld6sicoL0boDRbwlsXwAd4oBF4hadnWZiq7SizK
         Xgwg==
X-Gm-Message-State: AOJu0YwJDJDRxAVNdCcMIHlnW0Jq6MEjqALwQt/94mS8pUvwj3hfY+72
	yDfXuB0Cq8cGO4r1f5BZR4NBAT+sspDU6O0HheyMZWrI4bL6RQ5ZaIEyEyWYsluC
X-Gm-Gg: Acq92OFEfbC0ADfzvwIeRqXEdcuMyC8eQ1xVymkbZ5k780ZYKms8yUFfYMnhRdx9QbW
	r23zK8285i03j0ojQUZFIb6v2CK4WOzlepKDle0TB4B53IoqCeajZOFxKUCyNO6hBYjw2O2FWA1
	hFidgV1z1L+C3egmYDgy0UBkRtvHWCcY8lH0WUf+IwUVJnrUjQmfHc4zgnVtGCbvu9RWtbZDlHp
	KT4K586q1Nl4k4ZL01qDWgXztJd6TgY7CkFg21dbD6L1Z/ZyQpsUMVgTFzaA+fOPyPHpODNmb+6
	Oy3cAKQ+BvwwCkjTynI2OJtSh2cJhMUKW0Fopc2/V+lJhu8PBxCHtlTQe9Cbr7mz4UCi67veaEc
	rCWGgiXHbVE5z99CtcXc3fNo4pC0UDpmqryzgKpO0zZpvp/deV50MEFJNDg4hK0YK+nqim70Max
	XWj5r5W0mVvo5jgOolcflj1MkMaqRzkZaPc3ujZgQ1aKMY4q0OH64c2+NGX8g8qvyECNQPGmzi5
	PDJMT2mDt5bUZxn8WxYYysBIuA1brNEicuPGpxN/O4ffw==
X-Received: by 2002:a17:90b:3eca:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-36e2eeddae0mr4873969a91.4.1780524755174;
        Wed, 03 Jun 2026 15:12:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6ea172b8sm709908a91.17.2026.06.03.15.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 15:12:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ibm: emac: Fix use-after-free during device removal
Date: Wed,  3 Jun 2026 15:12:17 -0700
Message-ID: <20260603221217.55592-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver was using devm_register_netdev() which causes unregister_netdev()
to be deferred until the devres cleanup phase, which runs after emac_remove()
returns. This creates a use-after-free window where:

1. emac_remove() is called, which tears down hardware (cancels work, detaches
   modules, unregisters from MAL)
2. emac_remove() returns
3. devres cleanup runs and finally calls unregister_netdev()

During step 3, the network stack might still process packets, triggering
emac_irq(), emac_poll(), or other handlers that access now-freed hardware
resources (dev->emacp, dev->mal, etc.).

Fix this by replacing devm_register_netdev() with manual register_netdev()
and calling unregister_netdev() at the beginning of emac_remove(), before
any hardware teardown. This ensures the network device is fully stopped and
unregistered before hardware resources are released.

The change is safe because:
- dev->ndev is assigned very early in probe (before any error paths that
  could bypass emac_remove)
- platform_set_drvdata() is only called after successful registration, so
  emac_remove() only runs for fully registered devices
- unregister_netdev() is idempotent and safe to call on any registered device

Fixes: a4dd8535a527 ("net: ibm: emac: use devm for register_netdev")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index d9bbcfbcf60e..00a36c839d82 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3151,7 +3151,7 @@ static int emac_probe(struct platform_device *ofdev)

 	netif_carrier_off(ndev);

-	err = devm_register_netdev(&ofdev->dev, ndev);
+	err = register_netdev(ndev);
 	if (err) {
 		printk(KERN_ERR "%pOF: failed to register net device (%d)!\n",
 		       np, err);
@@ -3204,6 +3204,13 @@ static void emac_remove(struct platform_device *ofdev)

 	DBG(dev, "remove" NL);

+	/* Unregister network device before tearing down hardware
+	 * to prevent use-after-free during deferred cleanup. This ensures
+	 * the network stack stops all operations before hardware resources
+	 * are released.
+	 */
+	unregister_netdev(dev->ndev);
+
 	cancel_work_sync(&dev->reset_work);

 	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH))
--
2.54.0

