Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529982;
	b=IS84fzJv/oSnZ/sbvXtqG5D4tR4gyzr10pdgBdUG+nxhinxBoeU+n79BMB5X/XH2wxKv
	 PM982ScE+o/h0yAkXLhW66VL7qh/XTBB15GbaCsh9Nfrel+7ibHGUhctqajGHKNqSIgBv
	 0VczLHUlMPvgM6EmfgtcqIIXHogIa/feaNgFs2KbnSxPhDWtFOfAoyrR6UhLFZR4KnK8E
	 EQkO+9gTiTRyKyZnPE9lCrGCZ9KOT1cJqxCof2B6AUSjVQbVt26Z3IRrTcRFxjro3YlFU
	 66T72Jhgs2nfX2DJ/7o3VQGpBQYCl3XkuCjN2W2R5x0D99MeWUvY4CfhKkBYtlCBkLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tZz2M5xBh1hnWs4WB52jPhyOeCPAanAx0iFskLPL39o=;
	b=wOQ4H4s9NK59CnJmZ/1NDhXN44v2MJ17d5llPkr4lUtBQwBm/8tHc3dwqY6f5S9v8B8q
	 8m/84EZP91k3mNtgLDRtyaUzLEH1C5gkccXxHRYw0eKIM7g6JPomSuymCbUEO+QdWL5tE
	 nojall6RUdZFluXR+yJ2gaCn6qeCZ0NlavSpoGXJef0WTNi14crPOS4u9XDYtjiu0ofCN
	 VQkQeukqyNB/2XXEgcPaYggw+jLCdpnEbTBOmCorsfzAtVcERmoSeCdI/2tucglpKe5U8
	 QkFsGUJ6Z9ZRxry6CBS+FLIYjKL88WZt/SkGnGlmiPSIesLbwo05gBOD7M/EAkDpSxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hvc5nTip;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE360606D1A0
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE360606D1A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hvc5nTip
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490f38e9688so251950f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794529980; x=1795134780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tZz2M5xBh1hnWs4WB52jPhyOeCPAanAx0iFskLPL39o=;
        b=hvc5nTip96B3WypW3uIihCn6m8UOACa8UlNljKTVWdH79x19MqSyI6cgBLaNQ4armv
         gR8pniwHo58MdOPpy9Ukwzglxfj3KcC5cr6L+Yb765dR5Q0PbO959wtZ0DHb05+sjQGF
         pfGBu50QH2Eqdr0+4WGWB5f991ce9Dzos758e6uJ7mhb4ywCnuakfKLb43SiZwt7anMk
         3e3dB1WPyfASjC75criq6sW0pRMCmip6CZI+4WzVf1fPvbkMkD5QQl8ESvcThHzMjgVK
         TQFjnFz3Rnwcp9D1iVWIBERA0Jvj/QA9HgmHxLofrtZ43PCStJF6hlx3zDiVc/CYGHo+
         /rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529980; x=1795134780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tZz2M5xBh1hnWs4WB52jPhyOeCPAanAx0iFskLPL39o=;
        b=Rd65knAFcf+mZs/9ETaoV39ZsCJGM16mkpNVD3ovQ4cNzXiPDFy7g1jD1EWA2zlNWk
         fvVgQSd/h5TeFQjQ1SRKe36Gx6ZiKCRFEEXED5XlQNE/no/lR0KpO8Y/B0rvhzUINhXC
         QLD9npueLVaqzz+CMrr10XliPC1Ih7OA74TTV19oUYlPlw1yucyGy5cbsg0M64fhZ/IH
         f9pPGfgk2YZjpSygVfIq8toMHs45RHxIHDQqmK79iW6MBOVkjGDy24Zgr/XTBG7c+laI
         JVME/vtBw7YZKAPZRTAoSg3pkqdt5M21KfDgslBsHUOG/ARBPU3k8RtcwvHyObJ4eARB
         DDxg==
X-Forwarded-Encrypted: i=1; AL+hErGjUQLJG22K+y5Ix3ut6wTpN8zUo+ayrEs/67LRC47SiKJQyZm7YLy0NTR68P7ycaizNbH4Hb0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8X4kLLhLMF9ncnpvR63m8LLiB+yxcyyFoASv102HkocEYNXe2g
	EnhZ32CXtPcObf6pCYwHZKyGlKxnQAXcWmcmCQm5UMmo7CjIT/fhjlFn
X-Gm-Gg: AYBFou0km5ZlASiLG8OLIQTcGHyS7KWW2mg9lZHT5vVurH9+mYg0MvTi7VeYBPw+t3c
	Zqo9L0mt5VdF38z7/s5Zy+GdRapPcGR+4N6T67nuaQGHsH0mfIp3lYQh3IztMyCinN5PhB0gPIo
	NOi600p3Sy7vmMIHD2CUBMLtvkUMKuu58MbwS+81oKDik65ADP9d7Hm0PqON7H2d2SANzRNMKLW
	ws2rUoA8nXmoBqiDKTKfbB6BWbpcSw6ngTilKzWoKCHzsiOv5HtOi4XCSLbhj3n2sYPaKXwtcmA
	U6byOXTC7S/Vi4wdkIzSICbWKsIqdD5sQHfbxDoYrz3TEP/I38yUBAIgyukxuFmlBuqFVydutzt
	ENQAkdDXjcHvJXVzTJWW6JT15BlW9OtwG4jhMGzvzvTYJUHGHO6Uv476jsAFqzoDBpxvi6KWjIr
	gA9ftVq4H6Srcx/oXTvTzoPbTSVAe7Synp2O1gMNP3KL5GxwxBiJyzyV/SszmUgxsckm30PP1DR
	e0NBXN9uQ/ORUVMomhngiSatDb77Tx81OeYTb5mUMW949rFn0ZJ9Fjlx9mRm+6/9Y24gjnenfhx
	5yyKXNB6qjQkbVnmXHCYfQoMQ4a0MkxPAF0irM9j/OUwK/SQF/gi+nHzhSuDiVtmRyYHJpasJud
	fYmk7HRnPe4d3McdcKjPwUuYusyU6xtdywKpoTWD+hPsS7tKXu2kHEQ==
X-Received: by 2002:a5d:4531:0:b0:491:eb12:e133 with SMTP id ffacd0b85a97d-49c6fc9db4emr1471691f8f.11.1794529980179;
        Thu, 12 Nov 2026 16:33:00 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (host-212-171-11-167.retail.telecomitalia.it. [212.171.11.167])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm2029768f8f.23.2026.11.12.16.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:32:59 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v19 12/15] net: phylink: add .pcs_link_down PCS OP
Date: Fri, 13 Nov 2026 01:32:02 +0100
Message-ID: <20261113003217.197757-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113003217.197757-1-ansuelsmth@gmail.com>
References: <20261113003217.197757-1-ansuelsmth@gmail.com>
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

Permit for PCS driver to define specific operation to tear down the link
between the MAC and the PCS.

This might be needed for some PCS that reset counter or require special
reset to correctly work if the link needs to be restored later.

On phylink_link_down() call, the additional phylink_pcs_link_down() will
be called after .mac_link_down to tear down the link.

PCS driver will need to define .pcs_link_down to make use of this.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c |  9 +++++++++
 include/linux/phylink.h   | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 7f91cf3eb951..4f1e494beb8d 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1050,6 +1050,12 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		pcs->ops->pcs_link_up(pcs, neg_mode, interface, speed, duplex);
 }
 
+static void phylink_pcs_link_down(struct phylink_pcs *pcs)
+{
+	if (pcs && pcs->ops->pcs_link_down)
+		pcs->ops->pcs_link_down(pcs);
+}
+
 static void phylink_pcs_disable_eee(struct phylink_pcs *pcs)
 {
 	if (pcs && pcs->ops->pcs_disable_eee)
@@ -1762,6 +1768,9 @@ static void phylink_link_down(struct phylink *pl)
 
 	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
+
+	phylink_pcs_link_down(pl->pcs);
+
 	phylink_info(pl, "Link is Down\n");
 }
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 418e8bec311d..e8c3f693336a 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -528,6 +528,7 @@ struct phylink_pcs {
  * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
  * @pcs_link_up: program the PCS for the resolved link configuration
  *               (where necessary).
+ * @pcs_link_down: tear down link between MAC and PCS.
  * @pcs_disable_eee: optional notification to PCS that EEE has been disabled
  *		     at the MAC.
  * @pcs_enable_eee: optional notification to PCS that EEE will be enabled at
@@ -555,6 +556,7 @@ struct phylink_pcs_ops {
 	void (*pcs_an_restart)(struct phylink_pcs *pcs);
 	void (*pcs_link_up)(struct phylink_pcs *pcs, unsigned int neg_mode,
 			    phy_interface_t interface, int speed, int duplex);
+	void (*pcs_link_down)(struct phylink_pcs *pcs);
 	void (*pcs_disable_eee)(struct phylink_pcs *pcs);
 	void (*pcs_enable_eee)(struct phylink_pcs *pcs);
 	int (*pcs_pre_init)(struct phylink_pcs *pcs);
@@ -690,6 +692,16 @@ void pcs_an_restart(struct phylink_pcs *pcs);
 void pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		 phy_interface_t interface, int speed, int duplex);
 
+/**
+ * pcs_link_down() - tear down link between MAC and PCS
+ * @pcs: a pointer to a &struct phylink_pcs.
+ *
+ * This call will be made just after mac_link_down() to inform the PCS the
+ * link has gone down. PCS should be configured to stop processing packets
+ * for transmission and reception.
+ */
+void pcs_link_down(struct phylink_pcs *pcs);
+
 /**
  * pcs_disable_eee() - Disable EEE at the PCS
  * @pcs: a pointer to a &struct phylink_pcs
-- 
2.55.0

