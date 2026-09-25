Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0987049B203;
	Fri, 25 Sep 2026 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336350; cv=none; b=RlEge6nXErArMpbhMdQg5NncUyvkN364gBDLP4WbtZiOByCqk1AhfoXGiZp/b7OJgq3G97O+KTrKpv05L5IjVNZ5D5ZU1osQtNJvVK+3nY1AUDbmbUqFTTxED6YkOJ83f+Sc4ZYzb89SmhxBtoIoJ2qHniXPAgrSFLBT1yUUoO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336350; c=relaxed/simple;
	bh=gKD0w4n7sTjvVtYJvYYETCkCfkPjJGiDzi8qI5DeW8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2fePU5BizcqUQ3/58h68HF4Tx4seXIyMwUYwL4MUEtCAqPqXxd3HObsgmudZc+0hA1zW5DnLnr2PdAFtLKBI7cLSLTQMZEOGZXdX133RT8O4BWGOF911HjB4TA0iTuFoOkcddJEwWdWieluxf/DM3u9zAR+x59S+314rHUfSM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0+1rIiD1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0+1rIiD1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6586BC13996;
	Fri, 25 Sep 2026 11:39:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92C596073B;
	Fri, 25 Sep 2026 11:39:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A46DE103295C9;
	Fri, 25 Sep 2026 13:39:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336346; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iDh8kYmtj07PEpW72UoHlhvtVczz+CQ1iXnrykQUJu4=;
	b=0+1rIiD1KaRde91bryt9LWwKTd8c3S+qW7sPsMWXFYXIW6fGeOAE9t/AM54twiLhsuOYsA
	mx0UmUVpl15kssbdqHA0qVAWsquCyPYQJ3qrqtZ/Yt1GSZkPssd/HhcWfR6WSifWoqTtpU
	ew5t+nr/tkNwEcfQOUZb1PnR7Pc1n3XtwF5pYqrNCUK83bRZ4pcMD0Salv3Ar/YKgSFmCg
	EV3TAPWVIf1E8NC9q0807cmKXRl/jpAzrdZjuHcPMiSvjwOM7wCIAka8T/q6y0Tgg9xCTA
	LjaJlqm2fKikOveAwOKAE51xrBJcgtVnQcp+l61rALhd+89eknClRR5Y8kHZUA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 25 Sep 2026 13:38:52 +0200
Subject: [PATCH net-next v4 06/11] net: dsa: microchip: extract ptp_get_pin
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksz-perout-v4-6-d675bd21ce49@bootlin.com>
References: <20260925-ksz-perout-v4-0-d675bd21ce49@bootlin.com>
In-Reply-To: <20260925-ksz-perout-v4-0-d675bd21ce49@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The KSZ8463 supports periodic outputs but doesn't handle them in the same
way as the other KSZ switches. To add proper support for the KSZ8463, a
dedicated ksz8463_ptp_enable_perout() function needs to be created. This
function will use the same algorithm to select the output pin as the
common ksz_ptp_enable_perout() function.

Extract the pin selection algorithm into a dedicated function so it can
be used later by the KSZ8463 support.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index fd27e5851003..79520d345efc 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -183,6 +183,26 @@ static int ksz_ptp_configure_perout(struct ksz_device *dev,
 	return 0;
 }
 
+static int ksz_ptp_get_pin(struct ksz_device *dev,
+			   struct ptp_perout_request const *request)
+{
+	struct ksz_ptp_data *ptp_data = &dev->ptp_data;
+	int pin;
+
+	if (request->flags & ~PTP_PEROUT_DUTY_CYCLE)
+		return -EOPNOTSUPP;
+
+	if (ptp_data->tou_mode != KSZ_PTP_TOU_PEROUT &&
+	    ptp_data->tou_mode != KSZ_PTP_TOU_IDLE)
+		return -EBUSY;
+
+	pin = ptp_find_pin(ptp_data->clock, PTP_PF_PEROUT, request->index);
+	if (pin < 0)
+		return -EINVAL;
+
+	return pin;
+}
+
 static int ksz_ptp_enable_perout(struct ksz_device *dev,
 				 struct ptp_perout_request const *request,
 				 int on)
@@ -196,16 +216,9 @@ static int ksz_ptp_enable_perout(struct ksz_device *dev,
 	u32 data32;
 	int ret;
 
-	if (request->flags & ~PTP_PEROUT_DUTY_CYCLE)
-		return -EOPNOTSUPP;
-
-	if (ptp_data->tou_mode != KSZ_PTP_TOU_PEROUT &&
-	    ptp_data->tou_mode != KSZ_PTP_TOU_IDLE)
-		return -EBUSY;
-
-	pin = ptp_find_pin(ptp_data->clock, PTP_PF_PEROUT, request->index);
+	pin = ksz_ptp_get_pin(dev, request);
 	if (pin < 0)
-		return -EINVAL;
+		return pin;
 
 	data32 = FIELD_PREP(PTP_GPIO_INDEX, pin) |
 		 FIELD_PREP(PTP_TOU_INDEX, request->index);

-- 
2.55.0

