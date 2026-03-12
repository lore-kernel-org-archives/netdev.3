Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2EB3C0628;
	Thu, 12 Mar 2026 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310337; cv=none; b=Jr2KSgbcmy34QvyG+5r+MwEF/fkHpumO/VC/VaKCk3njIVI+259q9uIiQt4zYuwErsrqjM1nBWuAlQPjEd93AAyg1V/q/WXilgspIRzjL6vrGD+dOBaAeL0TEM7D2BpRxUVWZmn9BS/UqN8WRipyJpNFrrAEijmqKiqtmOe2fas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310337; c=relaxed/simple;
	bh=1snz4nu932BQaPGj1m5kJt/2+RkGMe8mWiHUlyDrJnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rtl2+VuZxfH3K8950BDUc2nuwLFwe8DKl7Ubz5KmJU2uYt+9ujgmZpCX6dWw0EU+ONiKo0ih+s5ayoKe2jxP/gCOBXr5E6RtpjXy1HY5TTamQhZpOS5nLpAOmIp8Iewu1soZt7PJXGsDqIgeO8Cmcso4GzrHB0KHOQbgW7hGdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=04hDAdl8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="04hDAdl8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D25371A2DF0;
	Thu, 12 Mar 2026 10:12:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A38075FDEB;
	Thu, 12 Mar 2026 10:12:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1111D10369D7E;
	Thu, 12 Mar 2026 11:12:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773310333; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x8skTqfbUD9JCb+byF4bxHeI2j2p4qGQHJqCgQ+a5aQ=;
	b=04hDAdl8RvFZx/TOY2lTFmGctnnSllSuRGcHq5JwcC/6m7SIzb3AaUnyuLGuExembkBapt
	frxtQrPrA2QqzhznosGaeVJNWuOsdpBq1zCCXGP5TMzKsnCc2lYS4YOXw29f2Gj7x4Eo6x
	qTF3AAfBwWsHxobvSJQXKBym+nIc403gb2R+PtFvdSunV4zSERva++eiBn60+5Qf1mABt+
	W/erSgrUVW7G62f3gNiWu0jbdPDtZ7l6uUf/3PoGR1IRoPWAG7+4Q2i0yf1EK2FDMYpxEc
	9HJV2xkPllL+3TaRDULBsVrX3kZ1qo8aVEnxXIUmaP1F1/18MdtOK97hMa3V/g==
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
To: theo.lebrun@bootlin.com
Cc: Ryan.Wanner@microchip.com,
	Valentina.FernandezAlanis@microchip.com,
	abin.joseph@amd.com,
	alex@ghiti.fr,
	andrew+netdev@lunn.ch,
	aou@eecs.berkeley.edu,
	claudiu.beznea@tuxon.dev,
	conor+dt@kernel.org,
	conor.dooley@microchip.com,
	conor@kernel.org,
	daire.mcnamara@microchip.com,
	dave.stevenson@raspberrypi.com,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	gregory.clement@bootlin.com,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	richardcochran@gmail.com,
	robh@kernel.org,
	samuel.holland@sifive.com,
	sean.anderson@linux.dev,
	thomas.petazzoni@bootlin.com,
	vineeth.karumanchi@amd.com
Subject: [PATCH 3/3] net: macb: drop usrio pointer on EyeQ5 config
Date: Thu, 12 Mar 2026 11:11:38 +0100
Message-ID: <20260312101138.465482-3-theo.lebrun@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312101138.465482-1-theo.lebrun@bootlin.com>
References: <DH0PZN0WJZC5.26KLH464PMMTP@bootlin.com>
 <20260312101138.465482-1-theo.lebrun@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

USRIO is disabled on this platform, drop its inherited usrio config.
We will end up with MACB_CAPS_USRIO_DISABLED on this platform:
 - We have no config->usrio so macb_configure_caps() deduces that the
   feature is disabled.
 - Anecdotally, we would also land in the runtime detection codepath
   that reads DCFG1.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 972499aa4191..0e2200cf4206 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5592,7 +5592,6 @@ static const struct macb_config eyeq5_config = {
 	.clk_init = macb_clk_init,
 	.init = eyeq5_init,
 	.jumbo_max_len = 10240,
-	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config raspberrypi_rp1_config = {
-- 
2.53.0

