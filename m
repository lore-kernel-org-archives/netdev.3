Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743368;
	b=FgNArD5Qy9rb/mRPBb6BaRL/Szn4e66Cs7QiFuFTabQP3Ds4BVOSlxUS1ot56FUQbDgt
	 QO9MUK2PlQZBI4cvrSwxygU5fi2wHkOsmfvXvbrtRWNgUfGNoFfQMdSVsujnP9fJxICv9
	 gUbv0YmaluNvUCn7Q671SsESM/dhV5tpP/+bl6ndZ7ovjuJCD5b6r9Wv281Cq3Um71Qau
	 wYww/MkKUxMkdKHcsJYcrdn5RrcAEGfUajXxeptIHXSih7ShYGSWJdwFE/der7ONwz47s
	 Sy+qELp3tY6MYQx6lZx1sCmcbcVxukKK2girhXO4YnXCbq0qj7bw1mT7EO8wgvgS+dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=FX6KKoJf2k5Ej65mMgishCXyJEmNd3pH83A4dCayU0Y=;
	b=35AlbQL2TBJb/+S5OkeAJM6pjBCMjneGIYV3ISJYqPL6wjXfXkarpaD1YlRXs2UFdKQe
	 ytxRqlJjPXwZPOwbZCNzyiRbyoyNywxIrCarD8tUYiJrjC8U6A9y8TZFl1lu/vmj3m+rt
	 /O5ocYGJYSkeghXzKiHVY5QYpIhchbVhn8kT4Egf7LfnurFjCqt1kE48xYwVIN3ryQgK3
	 6oxVtcki1pRDYE+HI13OMH0pUd18/UT2IJ0jt69YwhlXsy2mkUoqxDxl7Cx10l7Hmr21y
	 J6uiYDM7E83cm00qJoJsuQgWh8gOCpfcnruKCKgCX1CL8ZjgbLDRdHUqRcz9wx+nuJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=c5FDVJ8Y;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63957606D80B;
	Tue,  3 Nov 2026 22:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63957606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=c5FDVJ8Y
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 3E741E836F3;
	Tue, 03 Nov 2026 23:02:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FX6KKoJf2k5Ej65mMgishCXyJEmNd3pH83A4dCayU0Y=;
	b=c5FDVJ8YftVEbhUve5nD8syhA0ZaHht0kp5onlfjgHwEbD1Q09yWIW94ewUUOGcajCK3JI
	K3Clc4KOxM5MrEmLdID3abCIOcTwfxb1wLXhhvE8MNsSOzFyI+PefMcjD3e8b7fqfDeMFf
	y71EuiZkPoVvUyPAsLt/3478DUaVjq8RpIX6OsO4TtDF1NRQ+EZQhjWN3II3cbXY6gKFc+
	6hsRYrxDYBOQjqTsbxBJ248J9PJS6Zmo3Yr8HmjOLJST+rTzzdC0dSq5jop/EfwzRJrWdf
	fl4zxK2nAFvjogtvNSufWFFaJaYZnF0Qq5bQ7NxMoLGlJpw2Y1NrQyyT8vPQEw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id VlE5DRZkpaiK; Tue,  3 Nov 2026 23:02:44 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:43 +0100 (CET)
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
Subject: [PATCH net v3 10/14] net: pse-pd: keep the PI data until the PI regulators are gone
Date: Tue,  3 Nov 2026 23:02:13 +0100
Message-ID: <20261103220217.1131971-11-github@szelinsky.de>
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

pse_controller_unregister() frees the PI array, but the PI regulators
are only unregistered after it, by devres. Until then their ops still
run, for example on a read of the regulator's sysfs "state" or when a
consumer enables or disables the PI, and they read the freed array.

Free the PI array from a devm action that is added before the PI
regulators, so devres frees it after them. This also frees it when
registration fails, where it was leaked before.

Triggered in QEMU (arm64, KASAN) with a test-only PSE controller:
reading the PI regulators' sysfs "state" while the controller unbinds
gives

  BUG: KASAN: slab-use-after-free in pse_pi_is_enabled+0x294/0x2d4

With this patch it is gone.

Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 43f6e304fe5e..eccbdb3acbee 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -147,6 +147,11 @@ static void pse_release_pis(struct pse_controller_dev *pcdev)
 	kfree(pcdev->pi);
 }
 
+static void devm_pse_release_pis(void *data)
+{
+	pse_release_pis(data);
+}
+
 /**
  * of_load_pse_pis - load all the PSE PIs
  * @pcdev: a pointer to the PSE controller device
@@ -1123,6 +1128,13 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	if (ret)
 		return ret;
 
+	/* The PI regulator ops use pcdev->pi until devres unregisters the
+	 * regulators, so free it from devres too, after them.
+	 */
+	ret = devm_add_action_or_reset(pcdev->dev, devm_pse_release_pis, pcdev);
+	if (ret)
+		return ret;
+
 	if (pcdev->ops->setup_pi_matrix) {
 		ret = pcdev->ops->setup_pi_matrix(pcdev);
 		if (ret)
@@ -1194,7 +1206,6 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev)
 	mutex_unlock(&pse_list_mutex);
 	cancel_work_sync(&pcdev->ntf_work);
 	pse_flush_pw_ds(pcdev);
-	pse_release_pis(pcdev);
 	kfifo_free(&pcdev->ntf_fifo);
 }
 EXPORT_SYMBOL_GPL(pse_controller_unregister);
-- 
2.43.0

