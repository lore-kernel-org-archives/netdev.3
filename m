Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8C3F3264;
	Sun,  4 Oct 2026 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791092360; cv=none; b=IyxOF3ZIfOYP/mC4bcIL+XPrrG3hVDmCUJdag7Ckh4ZFQAJGuszwEvhHG/iTelMyCuzLiWfkZA3IJBsa3F9ixGSLatK2ugFNYmbclW6sCBkc/jqrGbn5f1K91dYKa7AQ01MNGvGYtusnfuNBwrNEfk5EFq49g3Vz/57997YqneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791092360; c=relaxed/simple;
	bh=ubIcdq3VTwvXgfbEaAznkN58/LJ8FGtSs+1WH/LjGLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pEYSuKdhTw0uTMiSyLK47wyeHwHmqT4Kqo2w1cYCHghskmnoDex0eGxbbAacLbVARFx0BPCQV54FHDZpE6TbZQOfCcdSGyoX+hnjDBWiWzlAvCYfiKky4dt9ZUUCTUkJ57kRdu3Sb9Xaw0708gE1U/PsvUfP82AcdAFYVCsS840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=wo/1Ssu8; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=FEcTrnJr; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="wo/1Ssu8";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="FEcTrnJr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092350;
	bh=ubIcdq3VTwvXgfbEaAznkN58/LJ8FGtSs+1WH/LjGLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=wo/1Ssu8cPNhUnInTjXC1kib38IfkdlORuuEr8ud7/KKThL0bnrrg6JYtQc/nMBjq
	 k2GR9XLjMj1Gd9L6jl8ck+2RqXqxAM9PtOMQF0OYyDG5/frJLhxMUl8fkyPUxPDrYm
	 Ge8tIP2Ux/dvUGG/43fFEjNz0V1gTYXpm7CUqnWKMH/+5h4W0DsJR7IPmIFdilDAnt
	 ZH4vFYZasTrB0KQuzLJ/vGiUsmnh742QqVHPLbZrCW8EkQjLkD6XeEdhro30qpJg1K
	 Wn50jTjt83p1XYpg95v70NVCLFImzSGku3nU7WrTL3wgu0nesfbfAX6554REi1S8nN
	 K/QrwWFbdjmzA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 1B749483AC; Sun,  4 Oct 2026 05:39:10 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791092347;
	bh=ubIcdq3VTwvXgfbEaAznkN58/LJ8FGtSs+1WH/LjGLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FEcTrnJrPtBzT5xoVp9Oz+u1fT0gMhxbFrcc21dg6696zfnJkMueJ08qVowk1Yi3r
	 IhFyajl/c16Ca0rDpXIAqJGniu/70Q4lLycYyhRzupBFx97wzTBTul7+C7dr0yQCwr
	 0Gep+azuEevVgY+bZOnBmimSO1austDpWHB09+zQfq5xpCv9E6VRXJgd1ZZxGGjKSO
	 qa3LRwQl86y5IE0dFUM/GYGNf6aL44VCSb9fJ0BVr0BtikMAK4mycwZyoZb/zURYHQ
	 G/GXJoEQ9oDvq9EgFSv/ip7ch2UdS+ZfBTVAjldklJl8KgD50MIbErBNujzs3Ajy4v
	 swzJOry7dGsFQ==
Received: from AMDDesktop.lan (p5dd1ef42.dip0.t-ipconnect.de [93.209.239.66])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C79ED4830E;
	Sun,  4 Oct 2026 05:39:06 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sun, 04 Oct 2026 07:39:06 +0200
Subject: [PATCH net-next v16 02/13] phylib: Add support for PHYs with
 broken forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-ax88179a-v16-2-2a9ae4e68f7b@birger-koblitz.de>
References: <20261004-ax88179a-v16-0-2a9ae4e68f7b@birger-koblitz.de>
In-Reply-To: <20261004-ax88179a-v16-0-2a9ae4e68f7b@birger-koblitz.de>
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

