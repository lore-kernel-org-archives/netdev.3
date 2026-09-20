Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882163E6DC9
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789894306; cv=none; b=feUZQu1tF5pxhHb/k9dyWMbFyIPkWz6jAcp9XAJt1TjMRXkgj+xRrt8FmhygSxDlOR/lk18R2KbJtkr/NAfEahuGowRiHxoNoq8id7/t3huhPfGFwAscp9vvBqTMXtk1TWcIBSNhRtk3cKS6NrjcS+WJ0PLkk7qj9XjlPXS1ySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789894306; c=relaxed/simple;
	bh=TGAsbbfpuBIHPTeNdWkJPgxwlnr/1br/4PiWBd3A1Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BE9CCajnYkAiQq60HnuD0eCV+tclUjyAFd89tbvKCAiP0KH6VkmIozymExzqRekQ/nNDObl7mTiZH0PwslzafacbAdCXoNVoQCSH1gr45p+6u3EN2w50SwUEyS6dbWFmyhuAtDl4ry1FkPI4tEKtThjOeYz/ueGRS6TCtWa278M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1789894296tcb4479b4
X-QQ-Originating-IP: uRNUNN4tU8quGjW/uqIyvac0AZnywNA6GDSqc9ypZQw=
Received: from w-MS-7E16.trustnetic.com ( [125.118.25.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 20 Sep 2026 16:51:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12767132841650681202
EX-QQ-RecipientCnt: 14
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net 3/3] net: txgbe: keep MAC enabled for NCSI and WoL for AML devices
Date: Sun, 20 Sep 2026 16:51:14 +0800
Message-ID: <F0254A6194B2FD5C+20260920085114.1062503-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260920085114.1062503-1-jiawenwu@trustnetic.com>
References: <20260920085114.1062503-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MDGUoPnBmw7sE3SjZCMuyaPRfWzQNiKK5Ikp49To7Ua2gpdfFWl0dr/F
	8YHcUHWrKZMi8lHEgT/sX2ggjCfwqhVIQR59rFtOrYqrLYi05ymAT2H324vuObqycCBvOQ0
	BKzJ5ZyCjonROEtoOSlWQzNeha7A06zcr9ocBg/aSDkvO/ljmVnqR+VyFg/8hlMiLqfEyaK
	/Q1Q/k9fuRAEvLTiYkrDRebw1fy8v0TJUx5/4BfDyOyiGWw4k7Ij9ISx6v+K/O9VecqSH7+
	Im+sA/8jXil9nvaxfZN16DJmfFa7yr86iujY73GOhEPib8e5k1/JyRFxfuYH0kWfB/438yt
	IhOHdP9aWtYwowSfNLZxF0bl3/UH7aAefRVkRbCudUhfjTrnK6Havh2YSKQX6mbnvdG2uER
	yMPhheE0VKn2M5aYfEXZMfGGJtWMoNVHPD93teoAecxpwgFoXk6Nwj2B9BgHnTSElHa3gIm
	Uk3+r73SPkxodvM+J4XzVTQTc9Zeen7KttApkPsG41pp/ldtj7yAIONrEFi4udnwwuWEB4u
	Le5YdNz0gw1ltQC1ByPp6ofSsYpjt4qV1xhtV2uXyGb+l7GwZGAlPqOR6aT74w3Ei+n02Er
	LW5Oot0lLBe4N32UDuVhpQPfh2IHhLh4vNMMUxR4hyaCXxwuu6CeIqe7MoEcqZLhOZB4Kbz
	Jb8lEDfqZxypNoEWJy30F+kvK7DBnT6Sd7sQfRcqII8jCyW/trJfnxHLCCC/AHYDysIFAb1
	Vk1qEc4GNl/RrmBkMmV6ir4ST26++DWXn8Zdly5NKKB85wLt9CYX/v0ZCNDzhfHVFT7EgU6
	MOnG5ynaccNLadmVAt+CeduKKBkty5ormuAKJG6kOmR1gyeheZxKLFDzco5uyuEFmv48hHW
	5rt6RJgysqnKb5rcZfxpTaD3fth6jzMysAIP+eSfLjoGfrqzlCLLl2Bplz4P01fdMP1j4+k
	7HQFy6FMmegS19CLloyU1ttSldV2/iQNI/73SccYyTRj9V7QiCsjPhx3aoe9p/1r0EWl9d7
	0qWJLaoSnCpCOt467Ze2sfHLW8g8HPnQUsKy/58YeD7CoOIFiLoLyJlBIHrMPJtuc5USEyy
	240m7h3fW8ch6LxRUcqmMw=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

The .mac_link_down() in phylink callback disable MAC TX and RX
unconditionally. This is not suitable for devices using NCSI or WoL, where
the MAC needs to remain enbaled after the link goes down to support the
corresponding functionality.

Skip disabling MAC TX and RX when the subsystem device ID indicates an
NCSI or WoL device. Keep the existing link-down handling for other
devices.

Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 26d0cfc58ee2..572ad655eb9c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -458,8 +458,11 @@ static void txgbe_mac_link_down_aml(struct phylink_config *config,
 {
 	struct wx *wx = phylink_to_wx(config);
 
-	wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
-	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
+	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
+	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
+		wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
+		wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
+	}
 
 	wx->speed = SPEED_UNKNOWN;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
-- 
2.51.0

