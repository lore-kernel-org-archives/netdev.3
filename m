Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8702BDC28
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771554012; cv=none; b=jkuyN9KkExnt44tAZ8uf+H9Z3oKR0oRjIW5td4yudut/Ati6B1txfAKEtcMikTUXotbla9qJnow1y05VT8XW+JPsNRboEOA0jZorB0JAZH/v4oziahIEDnL6oi3cgtKms/pIEKEa1Q2WLLL/BpdsGSVP2S1V7vVL6XMW8EaLyI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771554012; c=relaxed/simple;
	bh=rZiuIMhkMsKmv6L4yKMkGETytLUnkf9qArtZhO/vcSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJmgC7sJokVBYzfsHi3Ox/j/u4sQ7Ku8RfN+Hx/mf7iesuRQKJQmxcvmj6ZWIB22Nq3bCVpgYrY4dWmJAPl3ZplkCg2TE8atZNGl3xhFDJLiZKX4INjRl0o7NkzmGv+cUg2X/2dwIzeLqVfrpgemRex4NdcGBU2mId0n45R/v+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKJhS24i; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKJhS24i"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79628fb5c05so13679927b3.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771554010; x=1772158810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4POBYQSP3NtQUs6h8lOqxUK4xnDwwBeCf4pQ96aVpUs=;
        b=MKJhS24ipmDlmm49D1/LiNxN07xlcuCvU1yXRI5e3fzTE4KnH8z7ZeUXCRAYGLraxB
         hXwuNnSTY2YUVY65ucR+z/QocS5Qon1sVGoP7Uk/mLk9FWgwwp96PmsmTwuCUW+T8J8v
         GQNxjLImvSj6ZNhi+o3NsFCt7zTMazoptEQ9N0dHKPrmvwYd2tcfwMjZoyIloQ3OP+yV
         4GHYxEmHF5KGbQoQFUAgynoOuvPjqH+fX0qcv+jhHGO+OBzQOlwezaqDXMyaIu/FiQeu
         HH90avG+JwBqJnenzOBs/d1wUbuNZcLr9FG6NXmX/6RD+vMVyiztyjog6SYfXnIpTGo3
         Sb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771554010; x=1772158810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4POBYQSP3NtQUs6h8lOqxUK4xnDwwBeCf4pQ96aVpUs=;
        b=ECdUM+tuNQnjwGOoeBO6CLW0mPjEN1k/PS8l3EpaksvSpPz2RwXROzlGodU9FGilZk
         jGNNDID5Bo708INiznd0+x7wmHHoRvditlzbH/Emod+avhDK+Q/tTF0iJhawrOskpRbt
         aD+mGfmK1MqOnpmx9dyu9IQ5CHmfYCKDc/zRGXGyMzLx0stD81A+HNXtvR7Vvrwe25lt
         4STpDnXa0r/FEB573Gmg0Dfabzx4vEp82DhNysrOdzDsXvG2Gc2y+pny3cHw0G+tTn1C
         nTbmWCiixBA8D9mL91rpdxUWJvhixSiY4KczloY8IGWys3tIwtrUmnsxrBWHM5QbfLyF
         zvnQ==
X-Gm-Message-State: AOJu0YzkRhL/ttqxOkWXilu06lGWEht/UUaps2lzOzq//FD5SnLb6dLe
	1lobmFodsfaetUtPqFxWBeAfPp2rkbCnx4mZoE049+rq8AdTQ9XGpOuEcGxhz1onZew=
X-Gm-Gg: AZuq6aKS1MzCWMsHPxNfEVZEQwt3hEPqJpEmfzCCt1jq/OTsNbfkj0Mq24vMcldMPFn
	lEEJnBgHWTDfMWbw60TV6EYAIbF5bkQfj5dqkkRVfLUMN9N4roeWDvMfgOksB09w9Gh7b3DAY9d
	VIxQHVF/8+6m357/awnMRbqY1txJBit3UzE4JKWd/+BKpg6TW4Hm3ustcr8kdcFvxMw+GqTozSr
	hDV3Ofw9eeHQWpzIaM9uX9DgnxRq7RgCrJLZX+o2Gud7x2ymRmTI9qPt8PfQkdXy8nIVLHpOdTH
	3FGlQYXW1GugZ0nDx49tCGZ73hXDstWc5eJDlf01PuJOm++w6ii0YLkn1prd4l61/zqZ6aTap2V
	IBrIeO8sORgVFkUEfZhRTB43zVSSbp+lSfJeWd0tIlomz9FEt3K+rVNfK/i50aEeTE2jF
X-Received: by 2002:a05:690c:4a02:b0:796:6d46:8f8d with SMTP id 00721157ae682-7981cdeb482mr444877b3.41.1771554009873;
        Thu, 19 Feb 2026 18:20:09 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-797d142c2dbsm45550347b3.47.2026.02.19.18.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 18:20:09 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] net: ethernet: cortina: use devm to enable clocks
Date: Thu, 19 Feb 2026 18:19:48 -0800
Message-ID: <20260220021949.40817-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220021949.40817-1-rosenp@gmail.com>
References: <20260220021949.40817-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid manually disabling them. devm can handle this.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/cortina/gemini.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index a55f4b82d1ba..8726e5ffbce7 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2348,7 +2348,6 @@ static void gemini_port_remove(struct gemini_ethernet_port *port)
 		phy_disconnect(port->netdev->phydev);
 		unregister_netdev(port->netdev);
 	}
-	clk_disable_unprepare(port->pclk);
 	geth_cleanup_freeq(port->geth);
 }
 
@@ -2475,14 +2474,11 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	port->irq = irq;
 
 	/* Clock the port */
-	port->pclk = devm_clk_get(dev, "PCLK");
+	port->pclk = devm_clk_get_enabled(dev, "PCLK");
 	if (IS_ERR(port->pclk)) {
 		dev_err(dev, "no PCLK\n");
 		return PTR_ERR(port->pclk);
 	}
-	ret = clk_prepare_enable(port->pclk);
-	if (ret)
-		return ret;
 
 	/* Maybe there is a nice ethernet address we should use */
 	gemini_port_save_mac_addr(port);
@@ -2491,8 +2487,7 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	port->reset = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(port->reset)) {
 		dev_err(dev, "no reset\n");
-		ret = PTR_ERR(port->reset);
-		goto unprepare;
+		return PTR_ERR(port->reset);
 	}
 	reset_control_reset(port->reset);
 	usleep_range(100, 500);
@@ -2554,24 +2549,16 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 					port_names[port->id],
 					port);
 	if (ret)
-		goto unprepare;
+		return ret;
 
 	ret = gmac_setup_phy(netdev);
 	if (ret) {
 		netdev_err(netdev,
 			   "PHY init failed\n");
-		goto unprepare;
+		return ret;
 	}
 
-	ret = register_netdev(netdev);
-	if (ret)
-		goto unprepare;
-
-	return 0;
-
-unprepare:
-	clk_disable_unprepare(port->pclk);
-	return ret;
+	return register_netdev(netdev);
 }
 
 static void gemini_ethernet_port_remove(struct platform_device *pdev)
-- 
2.53.0

