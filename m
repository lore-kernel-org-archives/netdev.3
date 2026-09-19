Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7F39B972;
	Sat, 19 Sep 2026 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822757; cv=none; b=K6G2xDtaLe9ZU1+VA5ZB61dqfFItIzIboYAn+a7nwB7OzQXZM49g/NGs6H0BHqHPBV+iZ1Y7cv031YdCgRrPZnWkt5qfy1aecCxIgGbz+0EQk4N83NjNg2rzdzJswC7pXuMeZy+MiDGfGXuq0GGukA0nLSEdfXXRxxAovwVgSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822757; c=relaxed/simple;
	bh=9JZ5cvTdaX+RzQxA9l000u9tju594xM+xbp79AVjPJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4pONp6cA//xPlAWyp2Nejs3+sX5FdgIR72db/Do4WD7kXceQK66NXmXMyliMwJCE+/d+Kb1M8R11rA+CodT52vSwqx9/ErrLq9S8qxbzFwzFFtSKLW+LlpRWk5xbMVeG2oI6UFjzQl3em3V4H6MbMykpZZ6GmishGwNxJtXyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fy4lTE0r; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fy4lTE0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9a
	mai/fCedQ3sHwz5sdKcEJq4hBV8gzILMhbJO3+SBs=; b=fy4lTE0rS3nxNjt4yZ
	9TLv9BGIXW/1Ao761kWE4dv5n0/g9Dzjosg6C/S9XIxVEMsSyc4LDUPUL6VkFY4K
	Qwl2AH0c0nRsbsALFYZ0tnxyChAav28R87tbiGr5FjeT25juKLEPcc6ftlNBxCQt
	y9CamrVitNDyzrywYN8JDEKzw=
Received: from hpl-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3Rprlhq5qpMqHBg--.54511S3;
	Sat, 19 Sep 2026 20:58:14 +0800 (CST)
From: peilinhe2020@163.com
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peilin He <he.peilin@zte.com.cn>
Subject: [PATCH net v8 1/2] net: stmmac: selftests: Prevent RXC from being disabled in LPI
Date: Sat, 19 Sep 2026 20:54:12 +0800
Message-ID: <20260919125413.18058-2-peilinhe2020@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919125413.18058-1-peilinhe2020@163.com>
References: <20260919125413.18058-1-peilinhe2020@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3Rprlhq5qpMqHBg--.54511S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy7Cr1rAw4UJrWDZF1xuFg_yoW8Cr1xpa
	97Aa4jkrn7XF1xJan8Jr48ZFy5Wa90yFW7Cw12ywnav3yUtFWSqrWS9FyrZa4UWrWDXFy3
	ZFsF9a43uan8ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jweOJUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/xtbC8gYh0mquhub-1gAA3K

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

RXC is critical to the RX path and some register banks in stmmac, so
it is blocked from being disabled in LPI when we know we're going
to need that clock.

During selftests, we're in MAC loopback so the PHY may enter LPI and
stop its RXC. This will prevent the RX path from properly receiving
the looped-back packets, hence failing the selftests.

As NETIF_F_VLAN_FEATURES may be empty on some platforms once the
software VLAN stripping is removed, the phylink config attribute
'eee_rx_clk_stop_enable' may no longer be unconditionally set to
false, hence allowing RXC to be disabled during LPI on platforms
that don't have any VLAN features. This is already the case for
CONFIG_VLAN_8021Q=n builds.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Peilin He <he.peilin@zte.com.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 664d7cfde2f1..4f4d61a9c098 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1847,12 +1847,14 @@ void stmmac_selftest_run(struct net_device *dev,
 		return;
 	}
 
+	phylink_rx_clk_stop_block(priv->phylink);
 	for (i = 0; i < count; i++) {
 		ret = stmmac_selftests[i].fn(priv);
 		if (ret && (ret != -EOPNOTSUPP))
 			etest->flags |= ETH_TEST_FL_FAILED;
 		buf[i] = ret;
 	}
+	phylink_rx_clk_stop_unblock(priv->phylink);
 
 	stmmac_set_mac_loopback(priv, priv->ioaddr, false);
 }
-- 
2.43.0

