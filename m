Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA63E4C94;
	Mon, 31 Aug 2026 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170891; cv=none; b=VAB0NFMBp1Qw9kWcNOrLfdl3G2LDMEispLfI1MAJ2iyRV6J/4kz4hjPuE7P6lvfecoPxjgYzrFHxtKR0x3xtx4t1+T0kQ300QLbVUj65pR+AEyxRhiBGlfygiOJ+tkr5KAz7t9TO8ZTcwHuHmCED1rt6mIexUHSosOSUw97CZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170891; c=relaxed/simple;
	bh=Fz2uf0tPnU/Y4m5DeWMKXkg3rFzA0IH7d6hBVf3YE8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dssAVt0nFSX2z43QkAhIty5IPqlNmiFRSAdoBN3p8rKmtjiplgXBNk61FJYxmxv8duO3DtG7xSeYWAwSac+DdRYfWPhktyXzlnmm1iDRYh/JwiEGPOdeCFEWYj0iwMvXheKQpyarl00C0msh7D44/X9+T3GK9LZ62miyMTQms+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=va2fxk+a; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=AjxUk8Uc; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="va2fxk+a";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="AjxUk8Uc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170339;
	bh=Fz2uf0tPnU/Y4m5DeWMKXkg3rFzA0IH7d6hBVf3YE8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=va2fxk+aqXfH85aihJt743i4t8WIRlljzIN1TR+6sa7my4ZQiAi/+9hayRccMgMNP
	 5noVSMXU/xgNUs1wEVbi23K8aINULqDBHnaAOj2ZIphcvprF+QB7j5pWaiyM/0i8ge
	 B0nhG6weRBNpgz5nEKdXsYd3rfslhq/477FiROHS2CibNVsMSzN+HiiMXGk7aKL5A1
	 e5pfKCGiU6voPXZzxMFgW89xVixwpQc/L+qv3gtHtRN+i+nVRpEAQU0HJyOUFPLAAB
	 qXKSLQl0NluNS9TiBeLglmIcTbrJzTN9IcxWeqUlVtcPTg4exruLSAWcqjx43wuiyE
	 KQ2fh1g2z+fug==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 66EE83EC8A; Mon, 31 Aug 2026 09:58:59 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788170337;
	bh=Fz2uf0tPnU/Y4m5DeWMKXkg3rFzA0IH7d6hBVf3YE8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AjxUk8Ucc6y/XlJ588gJj6IRbLIMwfumgU1nhngGHkheV72IosQn/RbqP/Ticjb1L
	 zZjyWv7YI4S+3UeUqIOYy507fFZr4R2+e9nJyv6F3WXBDKpweOT+pgd8xhT3jRGisv
	 tZabHYDg4Zp1xTbvhF9TYvExa3aUB2eLO+ApmwaUpGiOMp1Bt9odCAidcsaPf4J0qO
	 nOmqqAmLa9LVz/IWPVif6JqlrGJt5HEBVn+6JiNyAljeDdawBZOX4J8KyPsPmQ/GGG
	 ZLPq/il9XWFUnHNhTNd6MCp2zN534a/YFcUiTlWqhXyKzc5tLtLLZbeuYfdsMcgeLl
	 vDA3goVHnjiVw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 2E2763EC4F;
	Mon, 31 Aug 2026 09:58:57 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Mon, 31 Aug 2026 11:58:51 +0200
Subject: [PATCH net-next v8 02/15] phylib: Add support for PHYs with broken
 forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ax88179a-v8-2-de905f2ee426@birger-koblitz.de>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
In-Reply-To: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
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
index 199a7aaa341bfd9b13731e996a8de7e1aea586ff..8169c0b0fd28f3a52d2905611820ec8954383587 100644
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

