Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E942885E;
	Thu, 13 Aug 2026 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651664; cv=none; b=Z7o/Uq9lSEP9Iv9XPeHegeaMgQwnnfQch0JB0oIqowf1x8vVXE22PSenVJ6djs0oA/f3WZnZHABMT+2xauMESTwW2JDLrkmEhPznKFMMjYPwgO75TPE6j1TX+sM3y0mpWWO1m8niIjFayqPRQh73aAgIP9H6KmYIj3PSGC6CRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651664; c=relaxed/simple;
	bh=wbp9h6Y5pc52QtRNdeDBp+B/zauhDHGFiKaLuutiUP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSqlCD0cr4s7jw5GWsjh7A7oS4mKMXS/53I1r/HIurXSMipRZKYV1T54hC6a2CMn5rFTVU3u8MzunQt8mFM0IWRyPpJpixSSUyXRg3SdY2rNLk6HT51GbtyFEEeG4mVwwsQkIsWb7dLziFxIRlqL7dn7b9UQKta4zuM/3uZ01pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=UWeEOw3t; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="UWeEOw3t"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id A425BE838AA;
	Thu, 13 Aug 2026 22:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1786651660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzAAq1WSL4B2IHkIqrCExFbnnVrV58+QG9UkUyf/Foc=;
	b=UWeEOw3tmyLK6gfROiozfwVZGo4UgWoEKIcujSuH97SzNmNY+g4Gh/Lj4l6ZbjvjK6Aj9X
	pR7QCFNLWo5xPdFlwZJcfGMS1sKv8a7Rmjpb6HC93B/G4aIdiWkEXFhYRm1UYD9DNCGe+s
	pN2qghoeALO70Q0tlh93bV2/8MWaDh/PabYJAV7gndDoItoY5V6xDjBAQtIdtWt8EVByhw
	hsx48hXNltTSrvpymJeRACB02O3eMzll13Q9lHktAxYuijLHBFUxQBKH4Ci1NWifxjeu0m
	NNUD0cMahCe7gtlSXibSHg+l3anO3aQtyznkpOgFI5jNm6JdCjFAXVqqFSOvww==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id aInJslAs_sWf; Thu, 13 Aug 2026 22:07:40 +0200 (CEST)
Received: from p14sgen5.. (163.6.106.80.static.otenet.gr [80.106.6.163])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 13 Aug 2026 22:07:39 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v3 3/3] net: pse-pd: unregister from the controller list before freeing PI data
Date: Thu, 13 Aug 2026 23:06:53 +0300
Message-ID: <20260813200653.980170-4-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813200653.980170-1-github@szelinsky.de>
References: <20260813200653.980170-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pse_controller_unregister() frees the PI array with pse_release_pis()
while the controller is still linked on pse_controller_list, and only
removes it from the list afterwards. A concurrent consumer probe running
of_pse_control_get() walks that list under pse_list_mutex and calls
of_pse_match_pi(), which dereferences pcdev->pi[i].np. If the walk lands
on a controller that is being torn down, it reads the freed (with the
previous patch, NULLed) PI array.

Move the list_del() ahead of pse_release_pis(). Both the lookup and the
removal serialise on pse_list_mutex, so once the controller is unlinked
no new lookup can reach it, and any lookup already in progress holds the
mutex and has matched against a live pi before the free can run. No NULL
checks are needed on the lookup path.

Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 21ccb5146616..2a9a07dc8c48 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1143,11 +1143,15 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev)
 		disable_irq(pcdev->irq);
 	cancel_work_sync(&pcdev->ntf_work);
 	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
-	kfifo_free(&pcdev->ntf_fifo);
+	/* Unlink before freeing pcdev->pi: of_pse_control_get() walks the
+	 * list under pse_list_mutex and dereferences pcdev->pi[] via
+	 * of_pse_match_pi(), so a lookup must never reach a freed array.
+	 */
 	mutex_lock(&pse_list_mutex);
 	list_del(&pcdev->list);
 	mutex_unlock(&pse_list_mutex);
+	pse_release_pis(pcdev);
+	kfifo_free(&pcdev->ntf_fifo);
 }
 EXPORT_SYMBOL_GPL(pse_controller_unregister);
 
-- 
2.43.0

