Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294490;
	b=GjfZo+WwsunpoCfoXf865pDX5jhK4lSPFIK+9q2pxj+xvP7rQXVxEpg24DjqT1Ga5wRm
	 ar3iRTPbWPywmR7Xn0rLkf3Q/v+17Vh67sGo1GKtTvaimqvd8OoAB5C5/mqlJYSKzdJN4
	 N+Q/UYGAyjD2P707SLEhmBY5U2BBOBl03LkqjES4uqhsmGfp7R6AaRfZfNyqRa36eo9Ak
	 UY4KytiOYTZp+R7FZ/CsDvoGa6ZQzwoJMwo2ghbPGcmvce8vyxlnmNKWwR+UxQdy20/nQ
	 JPCUhCp296JfJLKfY/KkAwmR+1GsOrX6eej4Jf9zddrS0pX7B/qqisST82EEYHqlD6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294490;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U2+SodBIaHMuWdorFSAdkZgaGLGBkZxWWlyQ/kLwRFc=;
	b=ZJqAcuFt1dF61ar/Wi/yPKFQHwoCNtM/N0bbW7sy2HGK0xjG7tnfRHWzxlKKaIR5gC23
	 xr86kpEP3LAx0xbQRfJeP2QrVuiy6sPAdec7T0XUp51SGGqvXkaK4Umz8WWhZjMY8lNN3
	 kHA9+Q6jfVZqUi88s0ANPhG5AwqjCF2tyWHOk6QXnE7wLxOGd3LbD4BAPIbMqyMANZ+fT
	 TV0SR1dHuVrggv3bHdJ0T0a9m6BwjrhyVJwiH3LmQx+SudStD6KUYBrFEnyXXmNIebC4y
	 Ei9D2aWu18hMWkySbhBjduqGA8U5ev/LIfN2/7dgdt6og7p0uHfWRLBArE2lQkFggyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=NFfvQe2s;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB1A606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB1A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=NFfvQe2s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=NFfvQe2sOhMcO+ZvSyyGf3r0YdZqbWhOyQtsn04cLnvDGQWpvQulU+7GlVSK4nppi6de5j8dPuSL3
	 L1wM1G3SfXkJi2sDB9o6FMcUgSmuk7hTT9vnPV3OiSMiQRb4tHOyq03wHm9Kz56S0U7TuG3mv0p9Gf
	 ynkrYb3IZjp+8Y1E=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af2c2d81b3-d148d;
	Tue, 10 Nov 2026 15:08:08 +0800 (CST)
X-RM-TRANSID:2ee96af2c2d81b3-d148d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af2c2d35b4-ab42e;
	Tue, 10 Nov 2026 15:08:08 +0800 (CST)
X-RM-TRANSID:2ee16af2c2d35b4-ab42e
From: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Imre Kaloz <kaloz@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 2/2] net: ixp4xx_hss: fix OF node leaks in ixp4xx_hss_probe()
Date: Tue, 10 Nov 2026 15:08:02 +0800
Message-ID: <20261110070803.1099-3-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261110070803.1099-1-zhaofeng2@cmss.chinamobile.com>
References: <20261110070803.1099-1-zhaofeng2@cmss.chinamobile.com>
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

From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

ixp4xx_hss_probe() resolves the NPE and the six TX/RX queue phandles
with of_parse_phandle_with_fixed_args(), which takes a reference on
the resolved device node, but the references are never dropped, so
the NPE and queue manager device nodes are leaked on every probe.

Drop the references with of_node_put() once the phandle argument has
been consumed.

Fixes: 35aefaad326b ("net: ixp4xx_hss: Convert to use DT probing")
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
 drivers/net/wan/ixp4xx_hss.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -1426,6 +1426,7 @@
 		return dev_err_probe(dev, err, "no NPE engine specified\n");
 	/* NPE ID 0x00, 0x10, 0x20... */
 	port->npe = npe_request(npe_spec.args[0] << 4);
+	of_node_put(npe_spec.np);
 	if (!port->npe) {
 		dev_err(dev, "unable to obtain NPE instance\n");
 		return -ENODEV;
@@ -1437,36 +1438,42 @@
 	if (err)
 		return dev_err_probe(dev, err, "no txready queue phandle\n");
 	port->txreadyq = queue_spec.args[0];
+	of_node_put(queue_spec.np);
 	/* Get the RX trig queue as resource from queue manager */
 	err = of_parse_phandle_with_fixed_args(np, "intek,queue-chl-rxtrig", 1, 0,
 					       &queue_spec);
 	if (err)
 		return dev_err_probe(dev, err, "no rxtrig queue phandle\n");
 	port->rxtrigq = queue_spec.args[0];
+	of_node_put(queue_spec.np);
 	/* Get the RX queue as resource from queue manager */
 	err = of_parse_phandle_with_fixed_args(np, "intek,queue-pkt-rx", 1, 0,
 					       &queue_spec);
 	if (err)
 		return dev_err_probe(dev, err, "no RX queue phandle\n");
 	port->rxq = queue_spec.args[0];
+	of_node_put(queue_spec.np);
 	/* Get the TX queue as resource from queue manager */
 	err = of_parse_phandle_with_fixed_args(np, "intek,queue-pkt-tx", 1, 0,
 					       &queue_spec);
 	if (err)
 		return dev_err_probe(dev, err, "no RX queue phandle\n");
 	port->txq = queue_spec.args[0];
+	of_node_put(queue_spec.np);
 	/* Get the RX free queue as resource from queue manager */
 	err = of_parse_phandle_with_fixed_args(np, "intek,queue-pkt-rxfree", 1, 0,
 					       &queue_spec);
 	if (err)
 		return dev_err_probe(dev, err, "no RX free queue phandle\n");
 	port->rxfreeq = queue_spec.args[0];
+	of_node_put(queue_spec.np);
 	/* Get the TX done queue as resource from queue manager */
 	err = of_parse_phandle_with_fixed_args(np, "intek,queue-pkt-txdone", 1, 0,
 					       &queue_spec);
 	if (err)
 		return dev_err_probe(dev, err, "no TX done queue phandle\n");
 	port->txdoneq = queue_spec.args[0];
+	of_node_put(queue_spec.np);
 
 	/* Obtain all the line control GPIOs */
 	port->cts = devm_gpiod_get(dev, "cts", GPIOD_OUT_LOW);


