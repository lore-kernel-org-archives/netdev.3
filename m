Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561CD360EC9;
	Fri,  2 Oct 2026 04:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916491; cv=none; b=atodfUg3GxOtshPYMXOhbzKwiKeW8WtDLBUm3539CmKXl1FL9vSWnKIBuIxaQIc2Z2etIsMS/TrY3aw8eZIiKlp7X8kWbo4+N2nX+ADYvBwmSaNX+lvAFt/RjxePqcbrvHoOFIgwKdoihxDPfoyAl8a8mTtWQfA4VBk9li+8jkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916491; c=relaxed/simple;
	bh=ubIcdq3VTwvXgfbEaAznkN58/LJ8FGtSs+1WH/LjGLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akxWrhtnZBqEbIL5CASi4w9ih1SCagyAUw0KBZgLO/44YSAEMnisiF1XP1OR3xZqQpTOaPV9nVXz57He1nhreBYSIiEo0Dv6B7LBL5qUD9yVK3CovELv0Ovo+WLKwTAwzgjzCvM+x1Tg0JPTKdQMQaMC35DOoVda58R7cAGJIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=dPSfCsky; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=FU0AvdBI; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="dPSfCsky";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="FU0AvdBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916481;
	bh=ubIcdq3VTwvXgfbEaAznkN58/LJ8FGtSs+1WH/LjGLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dPSfCskyNzw3yJpuiiH4XHo9ckStEYzLIJmIZeasPs3KRv6fsaVJxB4L4K5ZXzr97
	 PKrZLuUI86o6viRYg/bQYREFqzqnz2UXveN6NleZZKHiWGLTpDbsetgiKA38u8V4A7
	 KiWkOi51RiDexGPMBZ+W2ehnSOCvQhWmumsL6dMgfnqznKYYTo59PBchkWVkCpX3rw
	 KCzfTDK//Ilhb2r6xDxwTHRpQseyiT4idOKGLd9orG0/E1aYt0doSCMzjosol2qzGg
	 ceh2otqoooTd8hGnKl6Xv8Irudz5wy27XUZVpOWRox5AOOuVmeAgXHYoON1JgSdrB/
	 AuljYCA35Y18Q==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 0CE39481F5; Fri,  2 Oct 2026 04:48:01 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916478;
	bh=ubIcdq3VTwvXgfbEaAznkN58/LJ8FGtSs+1WH/LjGLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FU0AvdBIY21DnSqO8Crxqxx3CZd4/dtWPVKWFfELXvW2bMv11yBA19nHs0R/aw9VT
	 4mxRGmOM12QDkQPArEYgQo3l6TENqAEtg1tgR238TlteiOmUJ3F1DYg/dcnh7A74Sd
	 ShbCpRrs+2/7wcnqp15OOL9WnbVjCM7RBvPQGopQWUS+lmVAUVmltW1HEnigWF11CN
	 q+ozpgHkw373ZSGYyFKeE1LeYeDfXoUUwo0lhdzPO4CXdbMec0wK6ZSAqLdxDSefk0
	 DEs+uSse61ngX581p+my4D8kFkgrAQ3qTcdzKct8pSIcSjzdrQIISH0fuX+/Xt/Z+t
	 gp348DDBsoEJA==
Received: from AMDDesktop.lan (p5798b2cf.dip0.t-ipconnect.de [87.152.178.207])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id EFBDC47E04;
	Fri,  2 Oct 2026 04:47:57 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 02 Oct 2026 06:47:46 +0200
Subject: [PATCH net-next v15 02/13] phylib: Add support for PHYs with
 broken forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-ax88179a-v15-2-131d9286fcd7@birger-koblitz.de>
References: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
In-Reply-To: <20261002-ax88179a-v15-0-131d9286fcd7@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2

Add support for PHYs which only supported auto-negotiated
speed modes. This prevents a kernel warning and stack-trace within the
phy_state_machine when PHYs return -EOPNOTSUPP from config_aneg()
because they do not support forced modes.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
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
index 7c5098a0dd6cd1ffbfc5f55240cd68e41bfb2d73..4143bffdcdb9b293a6e717a41816c05a2c5a252b 100644
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

