Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48725B092;
	Fri,  2 Oct 2026 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916500; cv=none; b=luD4ZgeQcxjtn4lHTBDdgnoN6wScHmOa8gAm9nJltULvvm7RNUf+w0zKVpkDmf5Ami2fXY9BDfWYtnCgxk9+CjuCIg/dp5uCt7qt0ezxmCDEIlWjtu+4S7UOVmPVAAhs2QS+/ePVqC0rO0QpqI0f77iBGXnJyuXoAOWM04fMlUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916500; c=relaxed/simple;
	bh=kO/E0+66Aeswq0UC8BtggpSkLfEi2Vb5MPs3YzxqsDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QF35W3m3+q+KwG62OWwUizJlDObndtW6eVGIFC7mD5WX9UDxaiP61gtFlBLYJVAoMnsc2KpS5v8RBthxqlfRTvfzYuUWgLewKmINQ2RU6B6ZZ/8W9prBMkaun7HA2OZGKC2gSr3gVEcALXytXAFZvN7aSXbo76ID24sXSQEqa20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WdDhlerd; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vQYJyYsX; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WdDhlerd";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="vQYJyYsX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916492;
	bh=kO/E0+66Aeswq0UC8BtggpSkLfEi2Vb5MPs3YzxqsDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WdDhlerdKXihW1HStHAV7QyU4/5ziLQXHjuwSjMfmP+CQqwbZdxMkTM1bpGIDuKWy
	 xHn1HPQ6f6LIRkIyq7qv6gEd7RmiQvBpXt85ZXjJm8bedk3ldOrxc1ZfN13c2tbwPM
	 4FUUnVgTCK3Y4LjQKbqOyR/hJVpTDUmfX5Q8JV0ch1BHgUW7rmJeTTGiabQ72y3QG2
	 A74bV7XW1yI4w7m8N0phTtf8wBBx5OasebH8sbMHEiCJt0fZ5bSbAs6Rr/PUEk0Ype
	 3qRMdfnIHOKH8iFxynX2zYi449PaSvqLeulc/myInImEnEwYKdHVh5GvsKUBYPYbjo
	 6d/G0YBXaGicA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3D4E94818A; Fri,  2 Oct 2026 04:48:12 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790916478;
	bh=kO/E0+66Aeswq0UC8BtggpSkLfEi2Vb5MPs3YzxqsDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vQYJyYsX877CAVo/3d21Ca1ZFVVITTON3pNO1GxeJM5cZ3JU60heovNAB8vj0mTSH
	 VcMnA9EztJNeYetWjOlYr/mJ9WO+479A/4Q1AagW3oCVmK7JdOYVQKUZQUKYF6Ksvg
	 GFyW07wGGh+qaCMRpwJ9CnOfLESo/76Dk5TXNeKngrZCJK6SItOlw1drYJRr2o17v0
	 qrIam8WRz8rkMevs7UrqhGVZuBuC379cfHnBUqMbqbPruHbHaGUZshu0nBoLe+2elT
	 CmruorgpIJyBOkuLuswRGPhTKsohnnSUXzeMxGbQ6UUq/nfUOzCkYnZSON2RhALyem
	 c9I/QvCL3lXww==
Received: from AMDDesktop.lan (p5798b2cf.dip0.t-ipconnect.de [87.152.178.207])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B9FB647E2F;
	Fri,  2 Oct 2026 04:47:58 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 02 Oct 2026 06:47:49 +0200
Subject: [PATCH net-next v15 05/13] ax88179_178a: Add EEE configuration
 support for AX88179A MACs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-ax88179a-v15-5-131d9286fcd7@birger-koblitz.de>
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
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

The AX88179A uses a simple HW configuration for EEE
via a single EEE configuration register without LPI timer support
Add support for setting this EEE enable/disable register in implementations
of mac_enable_tx_lpi/mac_disable_tx_lpi.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/ax88179a_devices.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
index b15eddb0ebe290fcd6da7653afec19918a47717a..96748ca49743dcaef71bbf649a543508be01b8e6 100644
--- a/drivers/net/usb/ax88179a_devices.c
+++ b/drivers/net/usb/ax88179a_devices.c
@@ -395,10 +395,27 @@ static void ax88179a_mac_link_up(struct phylink_config *config,
 			 AX_MAC_RX_PATH_READY | AX_MAC_TX_PATH_READY);
 }
 
+static void ax88179a_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
+
+	ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, false, 0, NULL);
+}
+
+static int ax88179a_mac_enable_tx_lpi(struct phylink_config *config, u32 timer, bool tx_clk_stop)
+{
+	struct usbnet *dev = netdev_priv(to_net_dev(config->dev));
+
+	/* AX88179A does not provide LPI timer registers */
+	return ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, true, 0, NULL);
+}
+
 static const struct phylink_mac_ops ax88179a_phylink_mac_ops = {
 	.mac_config = ax88179a_mac_config,
 	.mac_link_down = ax88179a_mac_link_down,
 	.mac_link_up = ax88179a_mac_link_up,
+	.mac_disable_tx_lpi = ax88179a_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = ax88179a_mac_enable_tx_lpi,
 };
 
 static int ax88179a_phylink_setup(struct usbnet *dev)

-- 
2.47.3

