Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516386;
	b=wd9UT5XBNB1SQRErLDBW97jLo42MthDWP90Kkyc8Spsb+teCwcIfYIoJ0RxKi4dTIWMH
	 Jn2dF84wc42h5PJ4JA52qjVi2fybsugpuB7MplWbBZjmb/0vCJBW0M/IvLqpr5aYHzLI+
	 bIPTNhSCQmjvg/nDyLKmX5ofFibukzZCNx+vajlEjpW73Oa/kbR+bAylTE2mAnVhSCB2p
	 FmOqE4+kHi3LK4O2q692J5uIAuru6cEIn+IHwL6auNrQdHnPu8zfJIa+cO1/6Ky5K0kGp
	 k4+8mgv6BteAMHk92NMiCkQwEN4Jf+kzUlmOg7TMEl3k08oPPwl62ivfssvdGIpt3Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=M7J4rTeDC57JmFqj4G3eGC/UEMKw9RCgvsZhnvdt2Po=;
	b=PF+WUoMArLTmz7NmA+NQspCW9Uhd8pLhYGYpd8QomwJDFPZhD5Ccd6LRJwPCnGqtgQnm
	 sI/sAcdhUzix7rM1pq4wr1jy5ssmUIgKi8yy/Xb0r0td5U8jVk5T5V5xLAUidiIetlPd+
	 ZNJUD6FXanyn9M1hEvNfJ9TeYefwdxmL5+CYuvF/lEFZndndwNrF4gNK4cX4dN9Gu1DLn
	 3G1F7Vl/2iZ4172loMC6wnqqeJx/4MvrLekFjctLvcRBQbkLHET0WJCIaov09swa2ljSs
	 8k1HrEdvhweCy76I0xfPOeJC9yO1M8kueJdSOz5swyJT8lWCed0qPhbPBC5hwkHWAtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=QXIGF6Xl;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B010606A336;
	Tue, 20 Oct 2026 17:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B010606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=QXIGF6Xl
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 91DCDE8334B;
	Tue, 20 Oct 2026 19:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7J4rTeDC57JmFqj4G3eGC/UEMKw9RCgvsZhnvdt2Po=;
	b=QXIGF6XlZi6jMUflS0l43O7Yp+p1l96yGJEAAOfmh63Cs11WOCOfub816E4X9Ch1aIzYVW
	DdZui6loHy57M/mpI3jyz2UD8smV7al8kZyScdDfvy4oT3mxqu0GS1HGM4TNstfNMpQWRu
	1DL5li5MverBFjCYgiQhFgaDLzYnKV4Z/eNYYMoGo2pbKCqzfZFj0PaatkkA8NMKMIFr1L
	h/VF/6Lxwcof1HmKzrLVDB/Lw2XsW8RxTzTX2Snw9no3QQTo2URwBOvbrltlRE8Qy8A1JD
	P5aKbjfv1RWWztr72hPzs0zz5249QWyWPh63eTvGVPQy8WGcs8D0YsDM/cwxuA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id gv4g9eF9Fzz5; Tue, 20 Oct 2026 19:13:04 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:04 +0200 (CEST)
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
Subject: [PATCH net v2 04/14] net: pse-pd: do not keep a failed IRQ in pcdev->irq
Date: Tue, 20 Oct 2026 19:12:39 +0200
Message-ID: <20261020171249.853085-5-github@szelinsky.de>
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

devm_pse_irq_helper() keeps the IRQ number in pcdev->irq even when the
IRQ request failed. The failed probe then runs
pse_controller_unregister(), which calls disable_irq() on that line. If
another device owns it, that device stops getting interrupts.

Clear pcdev->irq when the request fails. It is now set before the
request, because pse_isr() can run as soon as the IRQ is enabled and
pse_pw_d_is_sw_pw_control() reads it.

Found by code inspection. Not reproduced.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index c6612232b820..eab7e25f2039 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1343,14 +1343,20 @@ int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
 	if (!h->notifs_mask)
 		return -ENOMEM;
 
+	/* pse_isr() can run as soon as the IRQ is enabled, and
+	 * pse_pw_d_is_sw_pw_control() reads pcdev->irq.
+	 */
+	pcdev->irq = irq;
 	ret = devm_request_threaded_irq(dev, irq, NULL, pse_isr,
 					IRQF_ONESHOT | irq_flags,
 					irq_name, h);
-	if (ret)
+	if (ret) {
+		pcdev->irq = 0;
 		dev_err(pcdev->dev, "Failed to request IRQ %d\n", irq);
+		return ret;
+	}
 
-	pcdev->irq = irq;
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(devm_pse_irq_helper);
 
-- 
2.43.0

