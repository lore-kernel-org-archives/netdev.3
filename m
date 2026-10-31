Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793433680;
	b=HowSbyr5KlcWm+CrYvmK7/KOjBslPWaF9K5gjtWVmEpCFTrILNMVemfz5ODzZBjU1QPm
	 F63Aa1nHj8K6UBmDIfTgTXMOF08TX7rJ67pyBYvvPngzb1SvoHo7fpP6pDo9igECBoSW4
	 wrMNv3i62IoyVyaC5dK/BT+Gxa7NFUDRz6+3QcJw4cMAYESpnPQH3ohC4C5U0viSTzVaK
	 kwg10rb3FApihx1ZTBIi9APnSJzBxxr2YCS+INftdx/P0+VHH+lIAG704S49SsZkGtP36
	 22QnsZM87GX6nAFWX/UhPXIAaKALht7ooyApz96NsAAnfwIyQHnHZH1de1+CESd7eEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433680;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aXpL5P4gFJ6lTi7GY7hCuH5B2anrQK6TIJlTE6quzOA=;
	b=z0mT1TpidDaVhvLzF5kUMTsf9nlQfi24s5DArfug1MwnNLBVDsT4O4UCv4OR3SrpJWw2
	 vogg+rb6vr2gH7+5maYPHf93B+HrxnR9BHbu9CHyv+cO+nUTebkRbOXsuRPLOhoM1QwAt
	 Abx6hKFbbIiHNkGVlAuRUVvvNC6LXtz9a4KscSUxbqRbjcU29t7F2Z1ZvVWXhg4R4im98
	 7lHiRDBSd0pDhDQbsJpxMhxqgOFcQr59s6uueOb1hJ5hTg7lzPJnUddZ3APlNFR79Qq/k
	 iDOslGGRRLjxTr62ZI7b0u9tJ5APmbQaPw8JVsGu1UbZ1llWr13eFkQ5fNLEIHlUXOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEu2eo4R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF8606A31F;
	Sat, 31 Oct 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEu2eo4R
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793433679;
	b=eIy1VwaP5Q5iXErgip/Tc7cRHHAEeTOuRdJQ/H4/7/go2KCJsdQ267rGlTjNPZnw807T
	 av+6E1cqwVFlM6yRKndeUENkYWmMpfZizTsB9wkdUlhziiAPxi+q4bq1mlCMs+k1F3vOJ
	 UVuMRNiMHa4sWzO+7Fsaub4NACvGY7yEzEz5umi6SWlj7mLFYpsIxEHe5OXhcRM0pgJhB
	 ya2AAmRRpuAkmdfITc1VgOi6zyGJOOSuxqQECw+NyiPVpGLe3NVzWUOtIz92QAW0jQmQV
	 cWQgHUnkk/IWIANAao4p5M34ueB+/GL2X794/N614GaODl2+OMZb858x7nX/5mqfl/g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793433679;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aXpL5P4gFJ6lTi7GY7hCuH5B2anrQK6TIJlTE6quzOA=;
	b=aI0Fdl/qZLKNrUNzmQ3wgrGakrvgwGbVU98YbjrExTDf/WChWgFcTOyha4jy/xSImiIp
	 nDIqWnjtY3Vaec47FI24toixxhTH53YoyMIylNeC9Cb20xAAzTIj+w1HoIkq4JqV6Whhu
	 IbwVUtzQ/68upxDtxjD4LescuuXw8i4RyPQngH/EVOTq/UsWSwTxOd90iMVP026V1Fqz0
	 lnTFUg6n+RxUgQgJ/meL3VGrniTncyS+LuVcVr25okJVOFWrLbfmYLRz08+bHDNwDy8Ln
	 oBPX84b3BEtqcQKWGC0pkdFv0DbPtdlAyNRSgnvHS6fYm3kJDDXao5mnoxrBsYDr8cw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 024521F00A15;
	Sat, 31 Oct 2026 08:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793433679;
	bh=aXpL5P4gFJ6lTi7GY7hCuH5B2anrQK6TIJlTE6quzOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gEu2eo4RhkDqtwkhb17Zj3G6gzhrpUcneJUNVHBz8TxibJWRqMKfN20nwVFJgtaz3
	 kJA3MxPG2Drh6RoMiqMeHU/7OWIkwJDt8LP6mRcp1kRsVvEb6PtPo04Un//JLNx3Pu
	 gq+E1XlskMJVHVMItyF75zeTFcgbCjRJVLX9z4vv0TkNPJZn9bGbvQ1TZrbZvUnjw5
	 AtoQENUXbURuyvDQEHe7Tdta7Z1f1RxD8pCaFbuj2optIVaQeK/veeOQzq9cxNM25D
	 7nV8RpxAlcYmoBhJ9t8gMpBhP+TyOzS0fh+FCbEG4qopYStP6kfhwXa/ph2p8sfvaw
	 XIj2DZPUS6Log==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7DAF545E56;
	Sat, 31 Oct 2026 08:01:17 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sat, 31 Oct 2026 08:01:15 +0000
Subject: [PATCH net v4 4/5] net: phy: stop postponing PHY interrupts when a
 PHY PM callback fails
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261031-b4-phylib-mac-pm-irq-v3-v4-4-5ba23b3ff9a4@iav.lv>
References: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
In-Reply-To: <20261031-b4-phylib-mac-pm-irq-v3-v4-0-5ba23b3ff9a4@iav.lv>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Wei Fang <wei.fang@nxp.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Paul Barker <paul@pbarker.dev>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, 
 Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2660; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=AMBusW+D9sd+roS3h8dA/iGRRagd/TAxSjS7ZWRcGGw=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFlPF3irMb5Zbvn0dEa+JufUGSYN4e9/vE1/Kbyjonnyy
 rRMh81vOkpZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBE1kxk+KdTfeHms7wHzzve
 nNXjFgqJuPnYU363yKwDB5PvhAtE9tgwMryc4fMlQq/LfOtNw5/V33aeuK7+wS1tP3PkBvaqmWc
 XX+YFAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

When phy_suspend() fails in mdio_bus_phy_suspend(), irq_suspended
stays set and the state machine stays stopped: the PM core does not
resume a device whose suspend callback failed, and the next PHY
interrupt disables the line until the next resume. When phy_init_hw()
or phy_resume() fail, mdio_bus_phy_resume() returns before the rerun,
with irq_suspended set and a postponed interrupt left disabled.

Undo the postponing and restart the state machine when phy_suspend()
fails, and rerun the postponed interrupt when phy_init_hw() or
phy_resume() fail, which gives the line back to the other users of a
shared line. A handler that then cannot read the PHY reports it through
phy_error(), as most PHY drivers do on any MDIO error.

Fixes: 1758bde2e4aa ("net: phy: Don't trigger state machine while in suspend")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/net/phy/phy_device.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index ef5e1cd3a831..390069ec13ca 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -366,6 +366,7 @@ static __maybe_unused void mdio_bus_phy_resume_irq(struct phy_device *phydev)
 static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 {
 	struct phy_device *phydev = to_phy_device(dev);
+	int ret;
 
 	if (phydev->mac_managed_pm)
 		return 0;
@@ -383,9 +384,20 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	if (!mdio_bus_phy_may_suspend(phydev))
 		return 0;
 
+	ret = phy_suspend(phydev);
+	if (ret) {
+		/* The PM core skips the resume callback of a device whose
+		 * suspend callback failed.
+		 */
+		mdio_bus_phy_resume_irq(phydev);
+		if (phy_uses_state_machine(phydev))
+			phy_start_machine(phydev);
+		return ret;
+	}
+
 	phydev->suspended_by_mdio_bus = 1;
 
-	return phy_suspend(phydev);
+	return 0;
 }
 
 static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
@@ -411,11 +423,11 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 
 	ret = phy_init_hw(phydev);
 	if (ret < 0)
-		return ret;
+		goto err_resume_irq;
 
 	ret = phy_resume(phydev);
 	if (ret < 0)
-		return ret;
+		goto err_resume_irq;
 no_resume:
 	mdio_bus_phy_resume_irq(phydev);
 
@@ -423,6 +435,10 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 		phy_start_machine(phydev);
 
 	return 0;
+
+err_resume_irq:
+	mdio_bus_phy_resume_irq(phydev);
+	return ret;
 }
 
 static SIMPLE_DEV_PM_OPS(mdio_bus_phy_pm_ops, mdio_bus_phy_suspend,

-- 
2.43.0


