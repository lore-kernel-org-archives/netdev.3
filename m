Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16A39524D;
	Thu, 26 Feb 2026 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095311; cv=none; b=Xi661lh18/+p+7flXKfQDUoieliCazrgDg4d6015MkCOKtiD64VisglkQKfSrBnl5tMfXQkA55q5X8DIYcDNU4QCnDsh1oxKTsS8iZPKXuR1fpW+wjcxCUY1RLBnGBORSi7/swcqfQBdFGdruJ12XFlga8QgZkj9PzJNN/Tmn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095311; c=relaxed/simple;
	bh=8ws5UzzRx1iMypszS/OR6cKi4wOVkSHCAJDhFVy3psA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=AKueetAbeCpNoTzZTGlMBf8z0GNmbs0f3Pt0nSySjRSJDlvNRaFPH2B+r2fjNIEtkR0F3ET5W+6vgp3oOX6VHWfkxX+CUWU1cKXeKiNf3UEJqmYGq8KN2GoqymjXJQJftIqcIz3fW2i//akFVV7uQpA4tfKbL9rRdE/YTUl92Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DUxtPIIz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DUxtPIIz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T102HgiYk9Eprd2j6XjBmG3naRhilYQBUn/FKWs93s8=; b=DUxtPIIzICu6lInZVW4gUSYiaT
	CgbVbfEymkj+WgoBmY9POr0jQM9pdNJC4Q5zVIzEmageQwUEKd81dapyGBCLQXTP89AkAmj7k1Wdz
	3c+xeHFe8FbPL6Uc2+UwHy0iHxCEO+Fcjihiui9arM5ng7HTKutVZ8W/wzq1LJgp1eKiRNhC9Trxg
	lDnN1M0oTO4AuRPFNdCZZYfsxjP1OMV7T0Lo5UNSu4D4IxdnYE0dXDqjJz9kSLsmSNCFyojWcXMG9
	Lb8ICxAhwsYNLyRhtlIyHXLyMHBkIFLjfxzdeTdHigfh9N1XKJpt9FG6wevfBYuFL3Faqk+XJImEQ
	9nm4WCGA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39684 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvWwI-000000007d0-2fj7;
	Thu, 26 Feb 2026 08:41:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvWwG-0000000AtKH-2v0r;
	Thu, 26 Feb 2026 08:41:40 +0000
In-Reply-To: <aaAHD_wWv2xCKntW@shell.armlinux.org.uk>
References: <aaAHD_wWv2xCKntW@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH RESEND net-next 4/8] phy: qcom-sgmii-eth: remove .set_speed()
 implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvWwG-0000000AtKH-2v0r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 26 Feb 2026 08:41:40 +0000

Now that the qcom-ethqos driver has migrated to use phy_set_mode_ext()
rather than phy_set_speed() to configure the SerDes, the support for
phy_set_speed() is now obsolete. Remove support for this method.

Using the MAC speed for the SerDes is never correct due to the PCS
encoding. For SGMII and 2500BASE-X, the PCS uses 8B10B encoding, and
so:

  MAC rate * PCS output bits / PCS input bits = SerDes rate
   1000M   *       10        /       8        = 1250M
   2500M   *       10        /       8        = 3125M

Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c b/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
index 4ea3dce7719f..dcfdb7d0e8ea 100644
--- a/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
+++ b/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
@@ -318,16 +318,6 @@ static int qcom_dwmac_sgmii_phy_set_mode(struct phy *phy, enum phy_mode mode,
 	return qcom_dwmac_sgmii_phy_calibrate(phy);
 }
 
-static int qcom_dwmac_sgmii_phy_set_speed(struct phy *phy, int speed)
-{
-	struct qcom_dwmac_sgmii_phy_data *data = phy_get_drvdata(phy);
-
-	if (speed != data->speed)
-		data->speed = speed;
-
-	return qcom_dwmac_sgmii_phy_calibrate(phy);
-}
-
 static int qcom_dwmac_sgmii_phy_validate(struct phy *phy, enum phy_mode mode,
 					 int submode,
 					 union phy_configure_opts *opts)
@@ -341,7 +331,6 @@ static const struct phy_ops qcom_dwmac_sgmii_phy_ops = {
 	.power_on	= qcom_dwmac_sgmii_phy_power_on,
 	.power_off	= qcom_dwmac_sgmii_phy_power_off,
 	.set_mode	= qcom_dwmac_sgmii_phy_set_mode,
-	.set_speed	= qcom_dwmac_sgmii_phy_set_speed,
 	.validate	= qcom_dwmac_sgmii_phy_validate,
 	.calibrate	= qcom_dwmac_sgmii_phy_calibrate,
 	.owner		= THIS_MODULE,
-- 
2.47.3

