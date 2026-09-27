Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647073E6DD0
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790513199; cv=none; b=mEfMKyeobuOxJAkNWiNeBn/2ybo+MoBU5t66oSJeAyNfk9SWqyAnRuk9zdtLAlQ2o753pNqzVUaVOXKtvbIQ90bclWCYUi6AIota32Brfxg6iJ+LAZS0dZFiRCZIlZOjMjQf5ijhYFcmoRPMztUSH2OUei5hQvM4MVAEkXagTPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790513199; c=relaxed/simple;
	bh=xG8fQs+Nv8hzYaB47vBOWqr+MR+BJEmuFuZwRxqnET0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyUSPGtas6sdSyGJ2vvfMVjT4GeSY6gvdnfbrJtP1zAn8C8JXHRJNuinB0hDVzj+ijmsU+RkIG03vzAtJUVPhNocfsszuoJuB3E+yBYNa8jxUsStFZMtd6yH8QPCNl5jrlBTwdiiQXiS0oJtd/8kXx+jG99u6gB6eybMXBg8IgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVcT70Yq; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVcT70Yq"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so16093175e9.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 05:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790513196; x=1791117996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6TBF9avaY/bTBgvPOC6p2G/lL798dgydRUW2YJl/tA8=;
        b=GVcT70Yq1sylQT1Id4B3ZvvKj8khaXua+PnNtiVOWLBmIYmmwlCFaSHL3SNN5JT6TU
         iVtMHmSgdt1HPiAjgpRWfvk1zHGEl/9TkWV5Q+MV04O2/p2DEjzjxrjr+QNh95vKBOU4
         GCWIIM7N9pMaaGAVf70vVuY7Q39e3Lor+PzwjPu0tm6Kc8VZxmmRRtDeXttGbweubOKt
         mM54+UFwr2N7a9dDlYtRAxoAiehBd3JyjN+eBmZEiC3AeoUC5vGkthBmtv45q0S5ZPsp
         fFfOVI3+sqi0n1Js98WKLZQFs6MMEjlKtUkjjeYT3GxjD1fH6jhcoaGohxNGz1c7tqVc
         Vxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790513196; x=1791117996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6TBF9avaY/bTBgvPOC6p2G/lL798dgydRUW2YJl/tA8=;
        b=HBJtBs8Br5RdB65GANXJpDWaP6Ee2sF/ryGDTbYx+7q8VtnsK7SRINdzBtwAupdkyM
         Wucu7Js7B1HvexTt0wVGV2NJsgTmoLVFuzDb98sO+NfRpVqpGUsen9y9/f8UOHeF/DBe
         +THgAWd/z8lnLsUkXoZ7ER42QyPKWKbxEEaP6t6ssFekmg8vU8h+JFZhep6Bv+4+63PN
         zE3x0s4S8Bbh07QANSEZ4hTKvBXjxoBIIa02YTSdRW8/SqP6qfgoJduzves7kqqlTHIs
         sBbbiFManS0ztKrdsWLgfoaqxFvdFnm40Bx2Xaf6trEHQZuVSPe5olYCia4sb1+BW3kS
         rxZw==
X-Forwarded-Encrypted: i=1; AKwUvBwyIiltLbfyGZfcW6Ei2AUZIVrovNKIcnlDOrJdLCT8M/k2JGcMvKyjN8mVpm9lIoiHTEDW/Iw=@vger.kernel.org
X-Gm-Message-State: AFuF++maG+n1cWsF0luFJyCm8C9co+Z3XFdTTBb1sYe+OJ89oM2XPaMt
	UvNb2TFpTXfkIqKkPRXE1jytr+qg33tkVNOfIuxzpYAfWDCYXSchc6gD
X-Gm-Gg: AYBFou3DpYX4yd7EZy0MWi6vHy1U/mMU7v9qDkXpN+U/mwMptNcVSAYSJ0cgxd1Eh2H
	sA7O/JPlQqDKPehuDkbjtZKfRq29oJMWERyc4BBr0nhGRPMG+wXlpL5+PQM5/L7GsDgA1f0oMZT
	XDJ0kZYOeYSh2IhoXL3C+HNXXHZgxfcR00dSF0GDIm+IyKhwuLaJUndJNp/hpw52kO8MtLyT35x
	8aRdmoj2cbkHfF6FLcbtdu6sqpL0lZAvqU9XxrzZYTsody+wuLUDbspziWEtQ7x4MeS1sHuC8S8
	tOCEDGQU5qua+vh9YHYmc7r+OSuEZSILSXddLsebxeBKQds2nCARq7b71huBveU2P9t2JDLCSq2
	Or8gKdyaeY6iCkrvCBiR7/2JAdtICKOaPz0ZQ/vVw3r8CCR9z27YGcExi/858ueTQvaDUTxYt1n
	jVexn4ZcbSH+iI0uHkpEs0PmWfsXBga0TfKaPq2TSZEf4c+as6B2EV5udMaf3Q7/R988U3ki8JH
	w3So47StuWT+fb7bDGkjvjhWvtvjP3jOz74+Y7Ze8+PsFy8nxv8PoSFQG3TvSc8Aeuqv7gRaFsg
	0bJe+u5Z9KvrUwcwc9hLg7Qbh5AzehCd
X-Received: by 2002:a05:600c:8b34:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a000b647f1mr30425705e9.0.1790513195410;
        Sun, 27 Sep 2026 05:46:35 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60da94sm148440605e9.4.2026.09.27.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 05:46:34 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 02/12] net: phy: micrel: Check RMII clock select property presence
Date: Sun, 27 Sep 2026 14:46:17 +0200
Message-ID: <095af7bdb3b28e7776bac12bb4f3f661d057216f.1790512621.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790512621.git.stefano.r@variscite.com>
References: <cover.1790512621.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

The micrel,rmii-reference-clock-select-25-mhz property is tested
for presence, but of_property_read_bool() warns when the property
has a value. Encoding it as <1> to satisfy the DT schema unit check
would therefore produce a warning at PHY probe.

Use of_property_present() for the presence test. It accepts both
existing empty properties and the new numeric form without changing
the RMII clock selection.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v2->v3:
 - New patch: use of_property_present() for the RMII clock select
   property so its numeric form does not warn during PHY probe.

 drivers/net/phy/micrel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index ae830781824b..acb481a29c25 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2791,7 +2791,7 @@ static int kszphy_probe(struct phy_device *phydev)
 
 		if (type)
 			priv->rmii_ref_clk_sel = type->has_rmii_ref_clk_sel;
-		rmii_ref_clk_sel_25_mhz = of_property_read_bool(np,
+		rmii_ref_clk_sel_25_mhz = of_property_present(np,
 				"micrel,rmii-reference-clock-select-25-mhz");
 
 		if (rate > 24500000 && rate < 25500000) {
-- 
2.47.3
