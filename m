Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FAD372B26
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775530648; cv=none; b=cePqaLsFJbXFQgXLqnH/MOLz0+E4Y5Gd53zlxncm3GwTDirqP1K+4kg8TVWVeG/iChUd6vV+fZtGHD7n7Uy58pw/qrUMV/i7kFrgtbGPfX68SFa4U7WuT9FxGELqOeWeCWf1vmCa9c/nTwdqcx2pyqzqtRd4ty5WG+1aNab0nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775530648; c=relaxed/simple;
	bh=2b7f4vUUVw+Nif1beU/Mv0gX1l5DIhn/5UT+42ERHBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdoYCbCfxoVnVMtQwMXCgMo4ghGjhbj/5Xgq/jnS4qmqob8dTfOeOi+1nAjzGCB6DHE0jlw5wg+9uFiFeqMkQ/bYhCr88ljbsV3jKk4gzdqy083o/EJyTyghY+qoHeZP/B7as8z9gxfe+0mxK2h42Se/phOPVjPT+KZaW5k3z3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1775530595t656d93df
X-QQ-Originating-IP: 2rWl839C35sNy4Mwak6xS9UpfuvLbb/sZNhtXCjRo1I=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 10:56:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17349234110553223132
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 1/9] net: ngbe: remove netdev->ethtool->wol_enabled setting
Date: Tue,  7 Apr 2026 10:56:08 +0800
Message-Id: <20260407025616.33652-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260407025616.33652-1-jiawenwu@trustnetic.com>
References: <20260407025616.33652-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MPEorwW6cFo9+lFpStj350HpHlDcrnq7MvxVf3uKukjYfNrSFffeuI4T
	M0GogEOXK/3AWdOLQl3adndP2CjbBE2d7rkQ6K9muXOsz7eJDh+HffAZ4IrhHaPlVjcEM4g
	6mfepdcIYn7/vtgZ99pM0LMARWvg2n+MqiM+2hgMNrsVaVPMAJkCgaOFDarpwqHlnmZVsX4
	iT0XUFMiMOotg2RYe2DX3ZNYSU7MihfrKBirjdfbRPbsV095qF6xSOzq5+6jZapUtPfDZPL
	sX9Hj0nU+q5v5OwvcA86PTFqBbRwL7RsJJSapkq83gtpnjci/5N0UF6W73Rp63GxHZqEdpf
	PUZ4fl7nk3RXeT9koGO+7iTXhubw9OSdadShMHYJ56ek/gbJAmrro+PjFTVDa8R492XFbUv
	8oken+cKDesrnaiCG0xla4tQp82SlgfNB75evRAzIaY0ozCBKfGbp2uFuhHxfCe4S8hHuDT
	BrsnhI1p73kbOHO9CSYZADvAHDbg8cR9DduUGH2AvjZA23PjU9YvJXXC/HY/q21nHkwNPJM
	m2nfrtlmu56lYst2jF/Fo5KkIwhagudgejZspmPsfl5yw0z8/YkdbM5xTlp+ZOGArmy7JAJ
	fi6QZyltoybArPdfLgepAlj2xGuBvWufIWaZuscdviCjPw2gpCnCobNUuvRmlFZysTv5X7L
	xEK2wcIk0rRlPYHAcyTeJ54ckUv5QHd+SX273v68EdgiNo6m1vnFFdY9SDlwO/0jAhx9yLi
	Sk9Olp0XR1qIT4vMnipEWx8v/Bt7bSaqpcIR7jkEzjWdTnyL1hb0ao2hQgadcMvSOM9MWad
	6KDVwTtU36gt0CDSPnZI+nC0kD0+F85cWocVmG0VQamzTOTLKuGbTc1TkdFz+cdbmIIYFoi
	xuCEDr++ud0Eaeu3aA+uib7ajta1v6G9azMBKmXnDAml7HpW2pX5xH89njzet2ebBtovUYp
	MLouIWjzef6Jkx2+nAYjPD6XKFDmXrAPf3Hv9ru5mCiG3L9MNJ9E6+pOqyGH43l9x/ai6kc
	4YIMYQDu20uMlRWqXWu/hoKfsD5gil2KgxKdJSzFXJUddsOuCCctnIdMRQcw+9PQ3kW9U3V
	fsLj4UZ8AVt
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

netdev->ethtool->wol_enabled is set in ethtool core code, so remove the
redundant setting in ngbe_set_wol().

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index fc04040957bf..40779fee0fdf 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -37,9 +37,8 @@ static int ngbe_set_wol(struct net_device *netdev,
 	wx->wol = 0;
 	if (wol->wolopts & WAKE_MAGIC)
 		wx->wol = WX_PSR_WKUP_CTL_MAG;
-	netdev->ethtool->wol_enabled = !!(wx->wol);
 	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
-	device_set_wakeup_enable(&pdev->dev, netdev->ethtool->wol_enabled);
+	device_set_wakeup_enable(&pdev->dev, !!(wx->wol));
 
 	return 0;
 }
-- 
2.48.1

