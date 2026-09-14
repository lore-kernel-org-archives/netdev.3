Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FFF48F03E;
	Mon, 14 Sep 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398440; cv=none; b=r71hBacOzB/D7K2KmxhKdbdZg0O6AwAZf783HCS0fc2impxyv+oEKotdX/bWHJpjiRqCtYb7oyPsrr1El7ikGJfttvtplzwIfJRAsoo3CYlZA8PxbvJ4ImrOUOKH9EB0f0+IE2JyDWnqZ71cdhgLGEDLjGEtrAMVGWAVgnlNBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398440; c=relaxed/simple;
	bh=MyocKcel6lN+1d0IEZBxawowlpdWUbUp59xpAPwwpxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWdEjpSCvmTzBCzAUEoaIF8PW9tEZ2dmMektGJlRw35f0m1t238BJffLC6BbCtf0gJeHzAQM/3w1VPgDy21RkIS/N8IIJaevfBieDQ97QKw+ckhK27LDFo06D1dHS4oSCWZsmFqCswr1Z8c6GQpF44oc8BTyLeQIQTivjIKFbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IlsxCCB+; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IlsxCCB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2S
	ohUjq7PjiqTtPPk0xhVnoINci+7I7nPB9Q5MsHbSk=; b=IlsxCCB+yHcnMCoBuV
	FCVP6bCgIsougS4IAxqSPRaG/ZUiow5X5HWDfvFCaxlRsw42oplGQuXSn2dtWzIO
	hD27VtRotpg9aJkEpSavZ+hwNnC4ldfjOyK467ZhlQNTWO9+YTOvCfVSvqM1jPrM
	lpvS+Y0JigLcLO1PT9KXkZ0rI=
Received: from hpl-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDn_3pkDahqCSeIAg--.42971S3;
	Mon, 14 Sep 2026 23:06:13 +0800 (CST)
From: peilinhe2020@163.com
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	he.peilin@zte.com.cn,
	jiang.kun2@zte.com.cn,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	pabeni@redhat.com,
	vbridgers2013@gmail.com,
	xu.xin16@zte.com.cn
Subject: [PATCH net v7 1/2] net: stmmac: selftests: Prevent RXC from being disabled in LPI
Date: Mon, 14 Sep 2026 23:06:11 +0800
Message-ID: <20260914150612.9798-2-peilinhe2020@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914150612.9798-1-peilinhe2020@163.com>
References: <20260914150612.9798-1-peilinhe2020@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn_3pkDahqCSeIAg--.42971S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy7Cr1rAw4UJrWDZF1xuFg_yoW8AF4kpa
	97Ca4j9wn7JF17J3Z8Jr48ZFy5Wa90yF47Cw12ywnavayUtFWIqrWS9FyrX3WUXrWDWFy3
	ZFsFka43uan8ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5cTPUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/xtbC8gUh0mqoDWVC2QAA31

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

RXC is critical to the RX path and some register banks in stmmac, so
it is blocked from being disabled in LPI when we know we're going
to need that clock.

During selftests, we're in MAC loopback so the PHY may enter LPI and
stop its RXC. This will prevent the RX path from properly receiving
the looped-back packets, hence failing the selftests.

As the NETIF_F_VLAN_FEATURES may be empty on some platforms once the
software vlan stripping is removed, the phylink config attribute
'eee_rx_clk_stop_enable' may no longer be inconditionnally set to
true, hence allowing RXC to be disabled during LPI on platforms
that don't have any VLAN features.

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

