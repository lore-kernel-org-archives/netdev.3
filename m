Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70B4A64D1;
	Wed,  2 Sep 2026 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368255; cv=none; b=dZHN6n6OnFoAQHlRtZBX7SMLF+Sf4cOvPzGBh74HtcnhpMQFz0j1gfAxvJ1V++FyukoTroDwiJDKARy7To50xv05yqHUxtquRMoVVu2InGqHCvjIhE3UQziUwAFEyeuCLTKWBpTynhlkALTn7vLxd40UdvSBJACKuU15pu6neAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368255; c=relaxed/simple;
	bh=iSGPFL+n7r0eZlKJTxRw3A+7EzAyrMv/M0GqDKlLVhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GA99n9oga22a4HNm6tWZ5DUj/Qrlqjou9XXhExe+JhWKVwFNVBb5B/XQfTUx19Xy9FO+9NPxHCR0QtJtoauqT/XKtJdB05il7s3HVW6mjMrqpI2o2bz7CjRk3rkhQdEU31Z+/hYzOFvDJ8tf09k0us8uTfAwPmXLOuLCOl9spoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NhkLzjBc; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=jnWX4dWX; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="NhkLzjBc";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="jnWX4dWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368246;
	bh=iSGPFL+n7r0eZlKJTxRw3A+7EzAyrMv/M0GqDKlLVhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NhkLzjBc3gx/qlSIlpxWs6ErfOZnvkO7nPO7g/RPBX/exIxolGkwRnSsj2wvsl3O2
	 HI148YnPMMQ32xdG8ZqEELdEi4BEszIfwVyIpYlHYwnVEUIhkLIgkFIHdwBlTz6yaF
	 9AcQy0U1V7LQSKcK0RbC8Ix3xisyvGVqhfc81nFXpSjuxxTXisC0LqTFda/s/LMtIA
	 YYZIQpOhTSmWRvmEeN89WkGTqaiJvoRsrtiTIb2KwMcw9EKJfrlvyiZuV+L3mIbsOs
	 nvZ9CmToMi70NjPhUYHrBv9GgPl9lbrDyOSVrBKGiP8D2UYgbZ6QUBnSfb09n6csym
	 WmT+aOWIaYbGA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 06F423EF22; Wed,  2 Sep 2026 16:57:26 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1788368243;
	bh=iSGPFL+n7r0eZlKJTxRw3A+7EzAyrMv/M0GqDKlLVhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jnWX4dWXTeCK5eETi2wD/10wWHCIxzYKjJdZgD6Dxu/c5sMDnVC8Qi6oO7skshKNO
	 PYXaMbYohNazI4YipT+Tt95sd081jmM9xj7W/22MJ27s61Io8KK0upvDahyJHAiAOk
	 0+NEmMFv6BJBBZAfEjp/Q0xFubOxblGZ9AtDSQ9jrUFhHRYAroKNq2UPwG5+zpMdog
	 rUVFgx56pu17cxQxHsC3gse4H+uFmq2U1QY4ghJ/vTUfp8p5iADsrVaM/2y/0SKw41
	 kmlEz+/zQaNmweH6Pt1WYR79NH5555qCaKyN2XmxktRAmtzW59Cv/bf0Phi7SWP/si
	 TtYJC3bLYrXHg==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:c4e4:2069:f0cb:22e2])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id AAA293EF01;
	Wed,  2 Sep 2026 16:57:23 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 02 Sep 2026 18:57:16 +0200
Subject: [PATCH net-next v9 02/15] phylib: Add support for PHYs with broken
 forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ax88179a-v9-2-8e6d7710a2ae@birger-koblitz.de>
References: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
In-Reply-To: <20260902-ax88179a-v9-0-8e6d7710a2ae@birger-koblitz.de>
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

