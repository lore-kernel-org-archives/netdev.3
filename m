Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516388;
	b=lZUjHaQ+6ar31qQkF1zJGi1Ha1EaBXB4o3bRawmw3CokYCOPj+IrvrdNUcpmX9G/24Ii
	 pOehfn3DCGISgRleHUYbPB5CjPEEFXQX/jQSzAZ2rAM0axluvg9KZPlHPEDotrt7486by
	 REhmdEiP/32kIES7M++nwJSzvyszuSP3stV8qi1Mdika0RukPR3oYAvbDMRX0cpeYM6AR
	 22KqoVwIjKVjreyXILOqAS8aIwyF/hLca5y3RcYfpkAi7Ks0F8fw6x4zIKn4WwBh8kYqY
	 u7xO7Wova79M3hgU7MgRHWYfHc1Wz+wI78+s1IAi3a/tCJzW8DpFqACESueNd6o1CvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=RFERCa8DCR2vdTbb2FixmCy9PfR1ZNAdP07XGVwfL3k=;
	b=XLedzh2jxSacoKD7mjduU/VEgj9ZBGuytsuZcGo2PXPWb8nC+m3y/GV64Fxbl/y/cvqh
	 4sFhYHVwLsr9KO+X02CkaedIdrgEntuUCrrlEkn3lixOwTUHHTRo8OaOP3wjuYwZbjbQm
	 jciSzU9jErSgJJVnW7iGKvOu4sD5u6y8vzlPCipxuX8CIZoC58szrSHJBlmqjQNfIUNSb
	 qINnMEpf+BR/LcAlNBfny5O7M2N61kzelUR+hOSOL7UxWyoKhQPD20PaALXq8go2OPEO3
	 V+5DdQduTmg58wBO241R+a30WUy8Q0/zv4umnlTAVnnHvO8xQv2uHkAZRinkriiy0og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=dHMiLQoS;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164860A2631;
	Tue, 20 Oct 2026 17:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D164860A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=dHMiLQoS
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 79F00E833FB;
	Tue, 20 Oct 2026 19:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RFERCa8DCR2vdTbb2FixmCy9PfR1ZNAdP07XGVwfL3k=;
	b=dHMiLQoScV9KgedWPnUXWGgHTBmvbxheQ1uBbzRb1MSw4D/6iVTOqps6JknNHwZvqg650p
	CXAxvd7qyLWyeTw6ZjEfneuLPkgX9ER6fblkhd2f/a1c6h7nM1Hf3aWmucySTIo0V4fw7o
	0Pc+VB2S4XEu9OLAdTQiNoqVoTe65KAieYNS0lzKNTFRgMICJJnffyMaUQ0R6JZoZnuE0B
	4V5m/HJ5SBD/rqtNWlAzjz8+Fe8Xct2vMMRmGwrWDRnvoya/4ep7vIiVw8GArGjmfqNTxc
	bQatekXOYo+Ma2gARXV551Zs3jdXhh1eGWCtGJYtKX/sX1sdh9glI8/6SQyw4A==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id XG2FCzZtsmOr; Tue, 20 Oct 2026 19:13:06 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:06 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v2 09/14] net: pse-pd: unregister from the controller list before freeing PI data
Date: Tue, 20 Oct 2026 19:12:44 +0200
Message-ID: <20261020171249.853085-10-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020171249.853085-1-github@szelinsky.de>
References: <20261020171249.853085-1-github@szelinsky.de>
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

pse_controller_unregister() frees the PI array while the controller is
still on pse_controller_list, and only removes it from the list
afterwards. of_pse_control_get() walks that list under pse_list_mutex
and reads pcdev->pi[i].np in of_pse_match_pi(). A consumer that probes
at that moment can read the freed PI array.

Remove the controller from the list first, before the worker is
drained, the power domains are flushed and the PI array is freed. Both
sides take pse_list_mutex, so once the controller is off the list, no
new lookup can find it, and a lookup that is already running finishes
before the PI array is freed.

Found by code inspection. Not reproduced.

Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 21280479312e..f266cc24f6a2 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1143,13 +1143,17 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev)
 	 */
 	if (pcdev->irq)
 		disable_irq(pcdev->irq);
+	/* Unlink before tearing down: of_pse_control_get() walks the list
+	 * and reads pcdev->pi[], and must not hand out a new control for a
+	 * controller that is going away.
+	 */
+	mutex_lock(&pse_list_mutex);
+	list_del(&pcdev->list);
+	mutex_unlock(&pse_list_mutex);
 	cancel_work_sync(&pcdev->ntf_work);
 	pse_flush_pw_ds(pcdev);
 	pse_release_pis(pcdev);
 	kfifo_free(&pcdev->ntf_fifo);
-	mutex_lock(&pse_list_mutex);
-	list_del(&pcdev->list);
-	mutex_unlock(&pse_list_mutex);
 }
 EXPORT_SYMBOL_GPL(pse_controller_unregister);
 
-- 
2.43.0

