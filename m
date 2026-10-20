Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516389;
	b=NUCZunHptycYPJrky8x0TAnXCSOIyYiLcurpsehLZ98OkPRKNt/FKOf9U031V6PRPbsD
	 O7yON85nUp3Kg1uwhaN+MEhrC0D2bR7CfAHrEKuiozleoSQpR+4Sniqx0kWj25JCS4Yf6
	 lkXavcdORxrouopxhhroM4iAa14z03RwsYfEfh2mk3P1y6NlMXe/MtDQ0w4y/sFHYbrTK
	 8lGJj48EvYO4/D/H9CfRbeQWpC1pq00MlQj3m5B3Kf/cl4TVrZEAh1oYkm/qh3NkKv9+X
	 0d+vaZTuJXaSS0Ugl69rbHpE6R2j0VrXLkRkju7OPu2HQDnd5lPTJmnT2dgcHNqeX3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=UpfR0l4rFdTHu2SB/T5U0b/UIosYvrWyx1jT7HeevAk=;
	b=JBYwvZrmou1KNvwysHqak5WmYTkUKsk6ako1Gm8IQsERd/mwpj1K87w889UPhFtdMeX6
	 esl/Ze8NUfMXNqPi7N1mSSVd2rebLYB5PpuWX5XZ/6K1acpTCA/cVlRnDhRgtfGCNpkZ+
	 /ftfz16tcwmgB24UHa1dqgLnyGSPqyYWonGa9O+T/K+Tf02vg2Jcj/O2DG8n9/sYY//fJ
	 wquhVDvPaHem6ZOTDnqCqjWZsQiL0mQ2oZchqFXIPHrH6y/SPXFNK7st33UYcXxanc2So
	 G4IPGGzLq8XR27GU4UJcTe5oGF9T0diwR1SZtpgd/h4ngpp5pdWaY1XRiMjbAGOucWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b="cbMrH/6c";
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F6560A382F;
	Tue, 20 Oct 2026 17:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32F6560A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=cbMrH/6c
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id C229CE83537;
	Tue, 20 Oct 2026 19:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpfR0l4rFdTHu2SB/T5U0b/UIosYvrWyx1jT7HeevAk=;
	b=cbMrH/6civP38SLikI+hyLb7JHbRY/ZW2PxidvjVgRCm3Sqt1no5lpg5g6uPBj77/i4dWX
	Pm0z7xXG9Gbg2lt/20yaIodUaC9sfZEYDYCGEHnUIg6d7Rxe8S++8vmOgNcwog2v6oUKAb
	uCF+ZHFlXoAWzZGUGB1iDrBVUMoENmoeApHSOTL3qdHamkSvKflH7W03bjffHZwBUgX5uw
	/2R09NO7j3JRVXqZCAM/8AZB950wFoVVaO1TrcUj6CcUDamBnh59WSc2i79xotY/qzwHZZ
	jeZv32kysYEr2kSjGbJ+EpHrtFbvF7ss1K78mGUOuYxY1H8C5Dda6+zZD7vaJw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id afana9v-2rYI; Tue, 20 Oct 2026 19:13:07 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:07 +0200 (CEST)
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
Subject: [PATCH net v2 13/14] net: pse-pd: pd692x0: release the manager power budget through devres
Date: Tue, 20 Oct 2026 19:12:48 +0200
Message-ID: <20261020171249.853085-14-github@szelinsky.de>
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

pd692x0 reserves a power budget on each manager's supply in
setup_pi_matrix(), but gives it back only on that function's own errors
and in remove(). If probe fails later, or the request fails for one
manager after others succeeded, the budget stays reserved on vmain. Each
probe retry, e.g. after -EPROBE_DEFER, reserves it again until nothing
is left.

Release the budget from a devm action instead, and drop the explicit
release calls.

Found by code inspection. Not reproduced.

Fixes: 1c67f9c54cdc ("net: pse-pd: pd692x0: Fix power budget leak in manager setup error path")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pd692x0.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 209de9cec849..34f0dfbccd06 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -1224,8 +1224,9 @@ static void pd692x0_of_put_managers(struct pd692x0_priv *priv,
 	}
 }
 
-static void pd692x0_managers_free_pw_budget(struct pd692x0_priv *priv)
+static void pd692x0_managers_free_pw_budget(void *data)
 {
+	struct pd692x0_priv *priv = data;
 	int i;
 
 	for (i = 0; i < PD692X0_MAX_MANAGERS; i++) {
@@ -1279,31 +1280,39 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 	if (ret)
 		goto err_of_managers;
 
+	/* Frees whatever pd692x0_req_managers_pw_budget() manages to
+	 * request, on any later probe failure and on unbind. Added after
+	 * the manager regulators so that it runs before devres unregisters
+	 * them and their supply goes away.
+	 */
+	ret = devm_add_action_or_reset(&priv->client->dev,
+				       pd692x0_managers_free_pw_budget, priv);
+	if (ret)
+		goto err_of_managers;
+
 	ret = pd692x0_req_managers_pw_budget(priv);
 	if (ret)
 		goto err_of_managers;
 
 	ret = pd692x0_set_ports_matrix(priv, manager);
 	if (ret)
-		goto err_managers_req_pw;
+		goto err_of_managers;
 
 	/* Do not init the conf if it is already saved */
 	if (!priv->cfg_saved) {
 		ret = pd692x0_hw_conf_init(priv);
 		if (ret)
-			goto err_managers_req_pw;
+			goto err_of_managers;
 
 		ret = pd692x0_save_user_byte(priv);
 		if (ret)
-			goto err_managers_req_pw;
+			goto err_of_managers;
 	}
 
 	pd692x0_of_put_managers(priv, manager);
 	kfree(manager);
 	return 0;
 
-err_managers_req_pw:
-	pd692x0_managers_free_pw_budget(priv);
 err_of_managers:
 	pd692x0_of_put_managers(priv, manager);
 err_free_manager:
@@ -1855,7 +1864,6 @@ static void pd692x0_i2c_remove(struct i2c_client *client)
 {
 	struct pd692x0_priv *priv = i2c_get_clientdata(client);
 
-	pd692x0_managers_free_pw_budget(priv);
 	firmware_upload_unregister(priv->fwl);
 }
 
-- 
2.43.0

