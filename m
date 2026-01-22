Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222330F815
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088468; cv=none; b=o2o6RYYADEntmzf3wRIT8lj+xvzcrAZsRZGgxwIkcOTXrGWdsuc3asw4aMfGixwfNltIgr7GLSUIXlj6NnKmdY+Ig1k49ZQVo96pBL0Rr99WRzIsNa/hAFKWnLr0agxlwt1T5t1wndvwEyIpvdjgl3d1KuoAKfhl1TKOmVm6mFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088468; c=relaxed/simple;
	bh=Mq588nrNPw+uc5oepjcOMjmGegEoAI+0BQA2zqK9rvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbDokwJY014E8xXTtN4EvtrRjdmjGDWha5wU/V0CAXLt2kUs+8hLg9m+wM/AvTL49q+Y9AcG8+cqMFhUAQYN6QnfF7+hYMNIVvETLdooRmFKbd5KvW7Wr243bLo4CX43VgKR+3Z50qh19T3pd97rF7avKwr4FZ0qvnEshvYJErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f9dPqI5/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f9dPqI5/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 335321A2A77;
	Thu, 22 Jan 2026 13:27:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 09244606B6;
	Thu, 22 Jan 2026 13:27:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12C53119B8048;
	Thu, 22 Jan 2026 14:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769088464; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=msjsmNWxtn13jWdt/GBOpxERpRumsKymvRVrflpMg/g=;
	b=f9dPqI5/wxvMfe/vpf3D4gFN6zcEJ6HqZK/+NZ+SfEXtt55ozHFzZ9QdA+3AmUMKUnHSjx
	syfjLwZ186SBGLQBmV8tDVL2kpOUQYBm1ZDmHJsdmak6RfVOGxmwqiVGK54gXRmH9YvNWY
	Ht/Z5mZkKAdGRsHRiz9ouYTUeoOpouhtkj9RIxbhImDnsCbGirBKh460HQB4n2lklOqkAD
	JzuDJZL/Vqhj10hP5mUW6u3wF0TOxyYBA6ORp63e+q46vJF9jl1GNfRoCRwXAni255NiUj
	mvzjg0OCxtLrQfNJUPzJTnhcHRr2ftUlb0mdcybyWmxXSXg+LkhCwii7wRuHnA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 22 Jan 2026 14:27:36 +0100
Subject: [PATCH net-next v2 2/8] net: dsa: microchip: Decorrelate IRQ
 domain from port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-ksz8463-ptp-v2-2-b6683f5ce50b@bootlin.com>
References: <20260122-ksz8463-ptp-v2-0-b6683f5ce50b@bootlin.com>
In-Reply-To: <20260122-ksz8463-ptp-v2-0-b6683f5ce50b@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

KSZ8463 has one register holding interrupt bits from both port 1 and 2.
So it has to use one IRQ domain for both of its ports. This conflicts
with the current initialization procedure that ties one IRQ domain to
each port.

Decorrelate IRQ domain from port so a port can use an IRQ domain not
directly related to itself.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 4a2cc57a628f97bd51fcb11057bc4effda9205dd..3b0dddf918595e9318c9e9779035d5152dcd9dde 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1099,18 +1099,17 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
 	irq_dispose_mapping(ptpmsg_irq->num);
 }
 
-static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
+static int ksz_ptp_msg_irq_setup(struct irq_domain *domain, struct ksz_port *port, u8 n)
 {
 	u16 ts_reg[] = {REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
 			REG_PTP_PORT_SYNC_TS};
 	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
 					    "sync-msg"};
 	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
-	struct ksz_irq *ptpirq = &port->ptpirq;
 	struct ksz_ptp_irq *ptpmsg_irq;
 
 	ptpmsg_irq = &port->ptpmsg_irq[n];
-	ptpmsg_irq->num = irq_create_mapping(ptpirq->domain, n);
+	ptpmsg_irq->num = irq_create_mapping(domain, n);
 	if (!ptpmsg_irq->num)
 		return -EINVAL;
 
@@ -1162,7 +1161,7 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 		goto out;
 
 	for (irq = 0; irq < ptpirq->nirqs; irq++) {
-		ret = ksz_ptp_msg_irq_setup(port, irq);
+		ret = ksz_ptp_msg_irq_setup(ptpirq->domain, port, irq);
 		if (ret)
 			goto out_ptp_msg;
 	}

-- 
2.52.0

