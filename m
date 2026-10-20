Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516386;
	b=wv3uUyVUyCFWmD+u3HNSF+zNfDagkI/kuqyjvWeqiMyOFOP5eDmMY2oPRGBWhNPUfE+9
	 pP5zFs2c9+NSQRinjqnqN3QhwVPl2UeJq7/SMUW79pXeqSQNVBJQB8nv62G2ribusJd3A
	 jkamHV3D529gZT/elnsjASbX0ykr+eDZ443ht6z0AbFx36RJU04HBBeEQZ3eszvb8nd3p
	 xoUwnzwxpihWzrGiWZxgSW+Xnecx4uYfWIZDlyiTMf6fm0B3F8Srr/s5UiNBSZtjdpSNe
	 cP25PMngsC3PD+cBEWVkbfkjmGHvHeJ1a/UxCA71JnZMgGTOE+qBQaJNSpzu/3kJg5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=D2s/g2GEILYW7pj1lYTz5AwKFHrnddXFQJWKMWAQH08=;
	b=1jOhiGAWjUBmdY1dHi+6sOsQcbQVL2CWk/7aP3WlkNzvEIM/OPIsOX+kFkp+ZcuPEdsX
	 Ye1t/cQp1zBDPSf9Gngrmr4j+rPAyYLrvlzdRD8QtXhXZZ8w1uw409NfAU4gCorB1dApj
	 a0n4zway+f4pLWHcC4W2E3JNmd9J6/ACnccmN1RIVtS7LDiM5HlkyceMcD/DpOhOnyebK
	 Djsl74bQ+Z4hiu3H3cPyEb3pUtHkmhvJ6MieRSD/RdZZ9bWauYR0TZVlhkV5dG7trQukP
	 +cHjMWWEQbVIHMogQDsTRbRg+SjCW2Z0IU2a5yF2iGEQMci8LAZDRYI27mQcEaTmYmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=G7cvO9Tq;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FC6606A330;
	Tue, 20 Oct 2026 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1FC6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=G7cvO9Tq
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 3DFE7E831F6;
	Tue, 20 Oct 2026 19:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2s/g2GEILYW7pj1lYTz5AwKFHrnddXFQJWKMWAQH08=;
	b=G7cvO9TqV6FE+JS/U8V0XnyCj/h5MisQnbEsfip6Rnmaffe67qNiHAgbibMndE0Xhg1ww2
	rnL9T4d6QzgQ1m+PbTowZtZG27dQR3qN3P5hT6s5DDaT67llvhkLzRkqJafFS0gkH0Ogef
	wX9mHkhdhYfsWDN1IVvwJSE06bBJk5llJm8i713QkB9aBilyxav0aha8zuobxwRs6AFqaL
	254OlKFXGLP18y8W2wuNWbVW2/NGXiVq1OgU5A4wOUIgGKcg3g1zhAhIjezF4Pz48JjXDV
	P45CJsj+0CDmcB+I9LH206qGF9Qy0XxD9sVbmfFc1MT9qRdDyjR4TtLaln+2zw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 8h0qnv94P_Ba; Tue, 20 Oct 2026 19:13:04 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:03 +0200 (CEST)
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
Subject: [PATCH net v2 03/14] net: pse-pd: fix module refcount leak in pse_control_get_internal()
Date: Tue, 20 Oct 2026 19:12:38 +0200
Message-ID: <20261020171249.853085-4-github@szelinsky.de>
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

pse_control_get_internal() takes a module reference, but when
pse_pi_is_hw_enabled() fails, it skips module_put(). This happens on
any I2C or UART error. Each time, one more reference leaks, and the
PSE driver can no longer be unloaded.

Send this error path to put_module, like the regulator_get_exclusive()
error path.

Found by code inspection. Not reproduced.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 03da633c6382..c6612232b820 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1426,7 +1426,7 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 	 */
 	ret = pse_pi_is_hw_enabled(pcdev, index);
 	if (ret < 0)
-		goto free_psec;
+		goto put_module;
 
 	pcdev->pi[index].admin_state_enabled = ret;
 	psec->ps = regulator_get_exclusive(pcdev->dev,
-- 
2.43.0

