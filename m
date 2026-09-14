Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C621545A2B4;
	Mon, 14 Sep 2026 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390004; cv=none; b=OV46aonO6p24PKhTOumeNw0f9+eb5bqtBCC5BQBOWSYAEVNCHxUuDtPg5zcBufV+Fi0rhks+nRkz+jDKFfXYtTwm5Ibgfig5uihmGGmxyKRSgT6tO1KYSkprKX61Aejcq37J6FYQrGMoQlDDnYGYDheZZNoqTCSwqdW2GEeLfHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390004; c=relaxed/simple;
	bh=iSGPFL+n7r0eZlKJTxRw3A+7EzAyrMv/M0GqDKlLVhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YcPpImv2A/6sBk20ThIKZRxdKjaE9ZjBer82eYBWybBSFbF5zKLjTjqqlLzI1GUCGBTVCHO0LEHbpBfM1pJQzAenHsgCy5+WGDIBue1foecXmWLgo/xVFOo05vjtLLkYEmDCZsTcOHyFqXv7ogntckrev5XZGUd5jF1HUYsLbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=cZXImopE; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=r/yZTeQo; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="cZXImopE";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="r/yZTeQo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390001;
	bh=iSGPFL+n7r0eZlKJTxRw3A+7EzAyrMv/M0GqDKlLVhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cZXImopEfXF6dunVAk1lNNTKzZ7ZxjhzXiGQa5qb+/yUiTHg39TI/cBnkC0zPAGHu
	 Tv3epmmp7K0RyvzjVlwZ8B/WaWpclHNwAng4bwtLnmrFSS//f4GyF0LOSWwQY8Xotv
	 ikuBaUvzD4YiYrot7aOIizhWf3tFEJSErA6zNv6H756xhDRJDredvH6Fd4OClAbhTk
	 93EIGzNsr0kJoj696Q/vsMVppRIhEGK+XORVtV2uvEvsI8c6m8Pt5OynCmPldjFyyf
	 cbwuXosEHdtS0zsfPUzYZdhO4dxq+ShPOwtaZTzI6MNgflE2Z7lXFg4eYsZVg/03tM
	 +b1mOw4gjVFUQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 202933F6E4; Mon, 14 Sep 2026 12:46:41 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789390000;
	bh=iSGPFL+n7r0eZlKJTxRw3A+7EzAyrMv/M0GqDKlLVhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r/yZTeQoNxCbzPJ2hrg47YY54UsBDuFLCVIQSUHtfivB/Ren146j4FHhxFcOPpacA
	 LF6XfYkIP/dn7pKOT1cSrPtuxHvo53CZ/fT8VQRGfT6phOCyLfHDH2ucQHZD2/l01K
	 H1N2ZkMz/84rlkRtWAHLFF1zVPqEjbBOykK9M8FQzluYnoTOl75GIcbGC7MZpLCA+e
	 WI2fjfxEZY+hYMe+BYQOarDl94OCAaYBxn+HtKZiaJ0ZEc/B/6xYtm1BTbtH4tLTEP
	 tC16MJ56y3sE5wQvNDp9NnvCvXf9qI8XxVvBs/oQTW7WNdO5HvpwVk2rzo2mNgY2rS
	 FKjHKbeZPOr7g==
Received: from DELLLaptop.net (unknown [IPv6:2409:8a62:2532:dca0:14f4:3e22:1e7c:23c2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 023393F6BD;
	Mon, 14 Sep 2026 12:46:35 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 14 Sep 2026 14:46:11 +0200
Subject: [PATCH net-next v11 02/15] phylib: Add support for PHYs with
 broken forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ax88179a-v11-2-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
In-Reply-To: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

Add support for PHYs which only supported auto-negotiated
speed modes. This prevents a kernel warning and stack-trace within the
phy_state_machine when PHYs return -EOPNOTSUPP from config_aneg()
because they do not support forced modes.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phy.c | 4 ++++
 include/linux/phy.h   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be3304b408c9f3ec9b5b95c76d3680a88..b83f938fe7c3bd619ae453434fd9582c0a055a57 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1190,6 +1190,10 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	      duplex != DUPLEX_FULL)))
 		return -EINVAL;
 
+	if (autoneg == AUTONEG_DISABLE &&
+	    (phydev->drv->flags & PHY_BROKEN_FORCED))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&phydev->lock);
 	phydev->autoneg = autoneg;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5f8d65868e0ff558c163421cfea5a6f3bd73a53e..d5f8e527ce8dfefd40a8b34e7c2f9adbcd6c87c1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -64,6 +64,7 @@ extern const int phy_basic_ports_array[3];
 #define PHY_RST_AFTER_CLK_EN	0x00000002
 #define PHY_POLL_CABLE_TEST	0x00000004
 #define PHY_ALWAYS_CALL_SUSPEND	0x00000008
+#define PHY_BROKEN_FORCED	0x00000010
 #define MDIO_DEVICE_IS_PHY	0x80000000
 
 /**

-- 
2.47.3

