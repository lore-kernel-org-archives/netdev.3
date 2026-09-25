Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71CB499F1F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336350; cv=none; b=hOgfeCH89RSjAyJt17wRZ8IGIlDO4nLk4tCfFDrevwbymaAIJBNFNiZmhsdCuCSN3cj2icCG2KJ3cxcOYE8BhM7Jog7d8+E7nzo7f+lEdUtw+G9OQLhgYq6e+C966jMdlMV3L07Y/sRCpZbeqZbPe3eQQjZ8GG3hfZLLqT80zHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336350; c=relaxed/simple;
	bh=BsgZWdO5bLd4DVeG8425aUEVscrrAndNjBHFpTf6PXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7CKoFJgaqILv9u3rwnO55wqiF1z4RdVkX8S5mLjPH08nl1IR3XTQOxllrJw6J06JeuJAE0GiCu/FBi++XxWin96Z9tS+1qNtW1zROuMozL+ps5aKHgl+zWedd56FQE+4m9VnDNFca2ShLfxvsZyWS+QYqHZ1XtLhsYRcBHFwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DbaOVFry; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DbaOVFry"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7C4AC4E41073;
	Fri, 25 Sep 2026 11:39:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 515016073B;
	Fri, 25 Sep 2026 11:39:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5A6F103295CB;
	Fri, 25 Sep 2026 13:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790336344; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ozkQcZ2Q0dthWB4fUbaMbJU38C/FrxFUvT0/wrofu5w=;
	b=DbaOVFryCWzKrOGvEJ+1SMrAEuPDeols0FEMQ6VX+xdL+7kX9rURFHWCTiMs2KaeMIAKB3
	h1SpMKOy3g3b/zYZgp8BKJjq1bLDQBIUe6hEndWRt99dW+qnN2y9yrrzZZ9T3cZ4phZ6kL
	ZNEU4rlFgw1glF4FYDZ//tlDru3o3iR3CEWEledaAPMjT0i2zqa74Ivr6wWhLut72spFHM
	qPxJlS7L6Brqrsj11IDgjZrxBk7nY31G23saJtombrSSajdRBN4wxFLSxq4JGMYIsaXXHO
	wwwmoB4Gik1WLfTOMaOD+FqOJcvyv8+x3i1wv6TvkYcLnhPBlb59nWxT2sPxbQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 25 Sep 2026 13:38:51 +0200
Subject: [PATCH net-next v4 05/11] net: dsa: microchip: extract PTP
 callbacks configuration from PTP registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ksz-perout-v4-5-d675bd21ce49@bootlin.com>
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

KSZ8463 also has periodic output capabilities but the way its outputs
are driven differs from the other switches. It will need its own set of
PTP callbacks to implements this behaviour.

Extract the PTP callbacks configuration in a dedicated function to be
called before the PTP registration to ease the use of others callbacks
when needed.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         |  2 ++
 drivers/net/dsa/microchip/ksz9477.c      |  1 +
 drivers/net/dsa/microchip/ksz_ptp.c      | 20 ++++++++++++++------
 drivers/net/dsa/microchip/ksz_ptp.h      |  2 ++
 drivers/net/dsa/microchip/lan937x_main.c |  1 +
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index d7498132064e..37b681d9e20f 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -2589,6 +2589,7 @@ static int ksz8463_setup(struct dsa_switch *ds)
 		if (ret)
 			goto free_girq;
 
+		ksz_ptp_set_caps(ds);
 		ret = ksz_ptp_clock_register(ds);
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
@@ -2898,6 +2899,7 @@ static int ksz8_setup(struct dsa_switch *ds)
 	}
 
 	if (dev->info->ptp_capable) {
+		ksz_ptp_set_caps(ds);
 		ret = ksz_ptp_clock_register(ds);
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 3ee995545c57..72528a53b67d 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1781,6 +1781,7 @@ static int ksz9477_setup(struct dsa_switch *ds)
 	}
 
 	if (dev->info->ptp_capable) {
+		ksz_ptp_set_caps(ds);
 		ret = ksz_ptp_clock_register(ds);
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 1889698691e9..fd27e5851003 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1031,17 +1031,12 @@ static int ksz_ptp_start_clock(struct ksz_device *dev)
 	return 0;
 }
 
-int ksz_ptp_clock_register(struct dsa_switch *ds)
+void ksz_ptp_set_caps(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
-	const u16 *regs = dev->info->regs;
 	struct ksz_ptp_data *ptp_data;
-	int ret;
-	u8 i;
 
 	ptp_data = &dev->ptp_data;
-	mutex_init(&ptp_data->lock);
-	spin_lock_init(&ptp_data->clock_lock);
 
 	ptp_data->caps.owner		= THIS_MODULE;
 	snprintf(ptp_data->caps.name, 16, "Microchip Clock");
@@ -1055,6 +1050,19 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	ptp_data->caps.verify		= ksz_ptp_verify_pin;
 	ptp_data->caps.n_pins		= dev->info->n_pins;
 	ptp_data->caps.n_per_out	= dev->info->n_per_out;
+}
+
+int ksz_ptp_clock_register(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
+	struct ksz_ptp_data *ptp_data;
+	int ret;
+	u8 i;
+
+	ptp_data = &dev->ptp_data;
+	mutex_init(&ptp_data->lock);
+	spin_lock_init(&ptp_data->clock_lock);
 
 	ret = ksz_ptp_start_clock(dev);
 	if (ret)
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index eb3827203b96..b23040f47b9c 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -32,6 +32,7 @@ struct ksz_ptp_data {
 	struct ptp_perout_request perout_request;
 };
 
+void ksz_ptp_set_caps(struct dsa_switch *ds);
 int ksz_ptp_clock_register(struct dsa_switch *ds);
 
 void ksz_ptp_clock_unregister(struct dsa_switch *ds);
@@ -64,6 +65,7 @@ struct ksz_ptp_data {
 	struct mutex lock;
 };
 
+static inline void ksz_ptp_set_caps(struct dsa_switch *ds) { }
 static inline int ksz_ptp_clock_register(struct dsa_switch *ds)
 {
 	return 0;
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 86ce3a86705f..3a209122fc7d 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -867,6 +867,7 @@ static int lan937x_setup(struct dsa_switch *ds)
 		}
 	}
 
+	ksz_ptp_set_caps(ds);
 	ret = ksz_ptp_clock_register(ds);
 	if (ret) {
 		dev_err(dev->dev, "Failed to register PTP clock: %d\n",

-- 
2.55.0

