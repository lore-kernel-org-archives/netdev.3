Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA350376BD9;
	Mon, 27 Jul 2026 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186299; cv=none; b=BXme+vBaArhGhJyO58N65vQxgQ+BSB0jUr7s5ARdIn4Gg1BtlBBuV8cEf7KYYBIDfxJmHcyfBjB3FNhNjyKAcX2T2w3XqdxBsZrRXQFhzTCK9bwafKar0kBSb/zyCA/xMxlnoM5h/LNS1R34rrPuw86BMoPbSMnLsMl0CbnOAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186299; c=relaxed/simple;
	bh=GsdZBvsIB2Vrj/HUk+diXAQGfvUuBlNSvjjerh52pBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kq+jjXIeyoANjzMANeY5KVij4i2KB4Syk7U0f3UZ+zOmmETmQ+VpwgtAKgDPY02XzNyUP5deN1StQPB0W2ydf//UNgjLtlQvKljgSMIhhMOieGIsnr/icAz07ANsQhLB0CFSxKJdf7Ism+WsS/K3e+Etq7wUns0OLVUGBt2AreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=uwWqwKtX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kaHKKOxJ; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="uwWqwKtX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kaHKKOxJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id C5F371380352;
	Mon, 27 Jul 2026 17:04:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jul 2026 17:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1785186295; x=1785189895; bh=Gj2UQrCd+P
	7ULpKHUCvxGN1/m+bONEHd6VT/A5Ll7fg=; b=uwWqwKtXhKD4q3vjzIE49D06HA
	+/D/aycDMyHQXcCbH9rzfrXlLDaGglry2cdy0lwLV2Hx8E66TRb84qCwFGbb1Chm
	DphzYl9DKaEN4fLvH52+c9GyZH9+ncDAjMmd44siqNaUshewOh31QZMm2oFDNcJ/
	o4xFePRRdjhigut9L2bSNxkCaQD5ZpSeSNPAlBtsZFPt3xjLtrI/DvGjYsumG5Rh
	PTwVCqfANTSg/DqARWEZNlPH9JJHfLx+6zYLKJSVQTznU8jEpX05kzpfdho8NQEI
	MAPIjhNDHBVek3txoDjFA+BOASEVW2uMfQN+pWAA4Q1OdnXlGYfcjq/jodjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785186295; x=1785189895; bh=Gj2UQrCd+P7ULpKHUCvxGN1/m+bONEHd6VT
	/A5Ll7fg=; b=kaHKKOxJosydwElG3siQu+UNGR9YzoAv318L7tGnq2xiF4YYYTc
	203kI6k02IT29WqUUmbjBs2UkBhzvAktF3htuSuOpOyhLLV5WH4mMwX+86iWur3B
	d1J8FM62H01dTxmA5PDk4VziGh3mTJUmObPKpz76YX1eUcm/K1+gveWMXymHHBtQ
	IK99TecfBHkl4pN/HGxqRyqv3lwM7F7C7VoPkvJgO7Z3nXADm36p6SJKsjWz1C01
	qD61z70BFlKXutJmVGcwNjw51oLFDJl4XRZqiv5fMFKYpzRRul6DaQFULcFxDwEs
	dCJb13tPC/EQMtzVctsm99HLwZ1uJ9npj9w==
X-ME-Sender: <xms:9sdnas40HMZsXvpz3iuJxtlMzok843KJVKpz2d5sFOvm3v7oxtg92g>
    <xme:9sdnasbN4eJH1Qwn8MRvuS0H7c6Xh2SSFWjFglXw6fQKUhDrgpwNEVDJUAWsn1cTl
    pcdi8H5CcsvBpKDTsdvbC65flz-H8FoUcZ3pqR4G9ZMANARmknh-Q>
X-ME-Received: <xmr:9sdnaiSdiFWOtV4sIqGEZ93gQ5eWbcBhn7JYiT21EzzOhCM08s2tus1AmJvTZPCRoXdmRRl8TQ>
X-ME-Proxy-Cause: dmFkZTGdc7ldtVL6ZmoEG55poed0M+Xbr4/QLkOQEOQmjqWVy5sL38J7tkMCB42dVVmv+H
    xpO3GdPyVXVQPxNlNTwgMvzSbv9cO7T/FGemPW01tDriu2bCjiQPZu4OpRdNZ2x6e3Jv9q
    Yn76Z6An+/7KzaM4CRiHSZln7VC8DEQwpH5Nuu2oXlZsgme1wnJ4OQFhZqVqcovIbDTldn
    fLtEaUfeLT26WAg+69Bh3bFIo+/GcjHgh4x2wmbyMDcDBhceXoADN/LHh6jgNC4+HXDlJ6
    Ola4bZL6hfhdxm2AUVXbOA2vpE7C4AIs8knAG6LFLSRFIIlWN1r2Ik8BpGYznjAPtDfJWp
    bHpVqYGQx8HjYxmolaMNole5TIKTrj3u64+YfuxojUDI5n3E4ikYMx7LyOgOhQGRrUhx3D
    KRP/IQKuZXCg6Q8vE35Jk4164EdKzbRahDZB3LAcmPOhsR6Ij+nSOi+M3cQMBeDra6F6b0
    jUFrbsJ/jW5o+J9ZeUpJBUlBFpI30PVw9SZi2uatp/93+J7z/okDB1b1HTnEYvycCzPpwn
    YHPD2fGnX5VAE3BfTNKzKPEVrgoRAkS9u86emxzq8carJ+w9GSFMrnXO0ZiGNOxX/pWaLB
    Anqx/jtt2cYV6Ncu0kC5/LZmLqcbzs4ocix1CNlWNGncBW4w5kRv60dQXoeQ
X-ME-Proxy: <xmx:9sdnahKM7w4WC5gzHhsIEFQnz4MIC3fRNF61uewJCHLnNdeKeYRrkg>
    <xmx:9sdnaoUNbiCT9usAJsuS3hHHw3fxC7XQv44-3iAQDH1zc69z49WJmg>
    <xmx:9sdnati91bfF1nPEw0e9KSu8ZGem7pQ-u26-c7sNTz4w8ucwfQnC6g>
    <xmx:9sdnasvqXoDxu_HviT56AgCmjid8jLddVnwjnpDSLE9dnw5qpJtboQ>
    <xmx:98dnalJsHPiblTYBzI5Q9UeAi0RuLmwXzZglAUhV8J-Dqzlsl4VmNpER>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 17:04:49 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	heiko@sntech.de,
	linux-rockchip@lists.infradead.org,
	attinagaoxu@gmail.com,
	alchark@gmail.com
Subject: [PATCH net-next v2] net: phy: motorcomm: enable the reference clock for YT8521 and YT8531
Date: Tue, 28 Jul 2026 08:56:02 +1200
Message-ID: <20260727205602.1188008-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These PHYs need a 25 MHz reference. On boards without a local crystal
it is fed from the SoC and described as a clock on the PHY node. Get and
enable it in probe, via a small helper called from both yt8521_probe and
yt8531_probe, so the PHY is clocked before its registers are accessed.
The clock is optional, so crystal-clocked boards are unaffected.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---

Changes in v2:
- Factor the clock enable into ytphy_get_and_enable_refclk() and call it
  from yt8521_probe as well, so the YT8521 is covered too, not only the
  YT8531. v1 only touched yt8531_probe.
- Carried Andrew's Reviewed-by; the enable itself is unchanged, only
  moved into the helper.

v1: https://lore.kernel.org/all/20260719034555.3623003-1-gahing@gahingwoo.com/

A second crystal-less RK3576 board with a YT8521 needs the same handling
(see the RK3576 GMAC 25M refout thread [1]), so v2 covers both PHYs. This
supersedes the withdrawn dwmac-rk MAC-side series. The DTS that consumes
the clock (rk3576-armsom-cm5) goes to the rockchip tree separately; the
clock is optional so this patch stands alone. The YT8531 path is tested
on an ArmSoM CM5-IO (links at 1000 Mbit/s).

[1] https://lore.kernel.org/all/20260727021048.3375444-1-attinagaoxu@gmail.com/

 drivers/net/phy/motorcomm.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 708491bc1..32eb5ce93 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -6,6 +6,7 @@
  * Author: Frank <Frank.Sae@motor-comm.com>
  */
 
+#include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -1043,6 +1044,29 @@ static int yt8531_set_ds(struct phy_device *phydev)
 	return 0;
 }
 
+/**
+ * ytphy_get_and_enable_refclk() - get and enable the PHY reference clock
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * A crystal-less YT8521/YT8531 takes its 25 MHz reference from the SoC. When
+ * that reference is described as a clock, enable it for the life of the
+ * device. It is optional, so crystal-clocked boards are unaffected.
+ *
+ * returns 0 or negative errno code
+ */
+static int ytphy_get_and_enable_refclk(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct clk *clk;
+
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get and enable the reference clock\n");
+
+	return 0;
+}
+
 /**
  * yt8521_probe() - read chip config then set suitable polling_mode
  * @phydev: a pointer to a &struct phy_device
@@ -1064,6 +1088,10 @@ static int yt8521_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	ret = ytphy_get_and_enable_refclk(phydev);
+	if (ret)
+		return ret;
+
 	chip_config = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
 	if (chip_config < 0)
 		return chip_config;
@@ -1171,6 +1199,11 @@ static int yt8531_probe(struct phy_device *phydev)
 	struct device *dev = &phydev->mdio.dev;
 	u16 mask, val;
 	u32 freq;
+	int ret;
+
+	ret = ytphy_get_and_enable_refclk(phydev);
+	if (ret)
+		return ret;
 
 	if (device_property_read_u32(dev, "motorcomm,clk-out-frequency-hz", &freq))
 		freq = YTPHY_DTS_OUTPUT_CLK_DIS;
-- 
2.43.0

