Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF631578E;
	Tue,  6 Oct 2026 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255919; cv=none; b=Oy7hVjb4yiZyoi6hURxvfnziycVA27RDimXw8Jk6CusTEf/zcC02LZv0b5MJg3L2yUoOvpr0QoVywjWDQX/ViwKwe1y+3AfQdgcKZJCHNJRi6Ti498iSY56XvQBa/hF3ZAkaXBXyqJTR1W2NcKJz7ey3Vy2FIjgRsqxEx9qu5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255919; c=relaxed/simple;
	bh=ubIcdq3VTwvXgfbEaAznkN58/LJ8FGtSs+1WH/LjGLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YwUT57FX2inrVczrLobLU112Wc+T65+gV6yK12ffpvVIKJj+EidX0vcpVvEnysSqEbOxf90HensQsVPp8WBg8GczA/WvZsELa3RyqetkFFKD8RCPKHHrvzBdFkS9lQnUQWnsjZfES+9WE2VgyzAilU2HlGRX6QzK8rW7/uDEPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=tBr601qa; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=iaWYeUE0; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="tBr601qa";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="iaWYeUE0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255916;
	bh=ubIcdq3VTwvXgfbEaAznkN58/LJ8FGtSs+1WH/LjGLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tBr601qax1mv3zoUEMzTN/mQWZv+VNfisi4hk7I80NsHmVPQyomd1wlDZinucvStc
	 I4dTiv5VaGoEJKY8C5FbVdGNa3izaFTfneZw+dM2PGe8go+iD1MXuJr51OvyVzvcVx
	 KmrrTMVcQdtVgcQdAH9c76idOZI/TskjGo9f/VUP9eAcR85Lk0ht18GoLgnjIXXEZV
	 zD8RTLKmdZUCo5XB4qR32Ey1IPMQkX8S+adL42RvnyDf0xZX9MNM9bVIC6Ew524T/o
	 o3ZEEcbd0MOm+YJcX4i9plu0zYJAZ/PDs1qfEkwKVyXAfCUZoz/+5kaMK4ng/nNE2s
	 6SJ03432kEOaQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9EEED485FE; Tue,  6 Oct 2026 03:05:16 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791255913;
	bh=ubIcdq3VTwvXgfbEaAznkN58/LJ8FGtSs+1WH/LjGLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iaWYeUE0Ya5/FQEz7SjSfIVYAAC7b1KNem9ee3b4ddgXwRge46xovxxjnz2nwPjbT
	 3B9VVtJpw5jCJXeZ6rKQeUvZ0xjd5dcnVAxoaUNddmHor2D27LFz7+A2w/KlbtfAc+
	 5TxzUTZaJLSaDinhFCRbuJ8rggj7TQaZzyerRNfLeLeP3c4aCkLMAIuWgj1rXnOyRp
	 2FhmtNTii8OWTCBC/dkeCj98o5/ukgk150mBmocc3ikdZB0eJrhTXl2+vmHQGfXFia
	 K5091aALwSaN7ptQZbw/mFq6euEaeM/DLqrfAM4u315y98L5Xn/egkZ2WhEZECPUQ/
	 ieQcA6V21DWrA==
Received: from AMDDesktop.lan (p4fd5971b.dip0.t-ipconnect.de [79.213.151.27])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 42256482ED;
	Tue,  6 Oct 2026 03:05:13 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Tue, 06 Oct 2026 05:05:08 +0200
Subject: [PATCH net-next v17 02/13] phylib: Add support for PHYs with
 broken forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-ax88179a-v17-2-252814fe35ea@birger-koblitz.de>
References: <20261006-ax88179a-v17-0-252814fe35ea@birger-koblitz.de>
In-Reply-To: <20261006-ax88179a-v17-0-252814fe35ea@birger-koblitz.de>
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

