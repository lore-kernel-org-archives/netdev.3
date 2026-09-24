Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F23CF69C
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215357; cv=none; b=m+lcso5LNUrEpSTwcaQktr2FmEsczI5ts1VdYFV6cEvCpPFDj4hqFO3XxWiipz4vyhiNvtSnTbHK7hXzDQddkgeL2FUjoSCrev05vUDq5sEPH285siF9xFHbmuUAlt8RHHtnzCg870M2BR9TJUhqMKmXd0Y6t1LWq0eVlG8tqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215357; c=relaxed/simple;
	bh=TP49+s+HuvXzFZsy5WYLYpQfI6Wr93yBFR++MK7Yh9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WaUoDBOEZC0CNwUOIyeXUywMJF5eAYlFAfam3Cxrnlp0W9R4tUmjr/USIZiQgOw2OC17RrWZRoHGODaHa7qJenaQ8DI4JfrOG1ZHENPRCtGK+9OjESHcx0XLIEmGGA6+OVZG9S7WrUnXg5ONOWoIiHYVZUD+oNCI5TpC6125afI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1790215325tb3cd9e96
X-QQ-Originating-IP: MWD1shbA6B4D/r5jQO9zUjyDs6RUG1BG2HxP0e5ZkMw=
Received: from lap-jiawenwu.trustnetic.com ( [115.205.193.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Sep 2026 10:02:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16398744908607698614
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
Subject: [PATCH net v2 3/3] net: txgbe: keep MAC enabled for AML devices that support NCSI
Date: Thu, 24 Sep 2026 10:01:49 +0800
Message-Id: <20260924020149.30800-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260924020149.30800-1-jiawenwu@trustnetic.com>
References: <20260924020149.30800-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NfoSpfPk0k6cfkqT7TRhMM5bIlt4jI+6cI7Hlq0AgxYneVZPRCD4HLkW
	eUOflNAaJfJESDfbmr1RL1KI/i00H4SbwB6iLoFnb0dB1jQ5ZeL2Kks+wLtdwXoXlo4NWNZ
	CDpbNe/DNIZphkC8VfIAZSiABmXrVJuG/ZQFzS9WSP+wHgQ6v+Hbh4hrS0vVIDxkT/4TUYd
	j79APMpx8sKZJHBnSerQSIroIkVfeUP8Rp0MgfTqH7aHQlRnHWWX0WXOXflCqrlcbtWbpgp
	x6IavI5uXB93WiC++53ZfVkrYSbPxGN2j87/wBxDZ3aqcclMBr6Jfg9hueQL68A1ap3Biw/
	nxu+yge11hXTCHZv96NXdIgOcDpB6ywZs4gNXIk7d4fSBH12GOPVgROSlBuAq4GSOPZY8Lc
	jAgYTMiajlYXnmRg4AqesBgftnPF8NummtsIwUbhg8QyuU03t+XC0B4lOXUeAEmcvYZ9ifu
	nokkXBhTRtk/SiELBdlsqG/WWd2KVXxdlMG0O9cmiaK+Jv7/UCNd800p7kMc+Zhk7LWz9Qj
	qRIbbRFp479hiRr8tTXR5bsJwFe77dQQLM+0yO18CyvY2vbaUcYoZgHQSDalnklDpq4NkuS
	3h23+5i4hFIAoThbvqxnUwBACHmwlIBRu0m5zR3HswNcXYKT03IUAvj76i1N/ufg0mpF0QS
	DUOzq68jfKqnEKHTWe0xIkEiAHbU6TuLApCxtRlOuFfxW4UCSwzS6vXfgfBJYF2GyeRFx5K
	/oeWWWjli6UHFWlId9QJCY98EMybn77gcUDB3V8ImTTHZUhpG577YL3MSQDjAwhKa0dgd69
	g3Z/i3P4mQ9bx01KT/YFHm73QzS3OjhegOLnrlw2wPPepaXIZJNNYAEJVii9VnAUkUcXVB9
	9Z/vKihZJ2jVT6m1bbaNspOdvZb22/mF2+jlOyXYFg6dQd37N6OwMTCduZP/hu9DB4cg1ko
	5A3k/pnRb/XREzjq3Rurz9VIQ2DcWuc4Q8/Au7uZ68VePen9XOqRSErenaJC2ojL/TVmG38
	1EREL8gBBXkeUogcDXfm5ywIt+OTcKn/WwXAaPY4ySYa60xoeFyLWZ4bciblnPQg0dSeFt6
	uZJb+LAHH3i5jgziaz4HTbz6CnrVsfoPQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

The .mac_link_down() in phylink callback disable MAC TX and RX
unconditionally. This is not suitable for devices using NCSI, where the
MAC needs to remain enabled after the link goes down to support the
corresponding functionality.

Skip disabling MAC TX and RX when the subsystem device ID indicates an
NCSI device. Keep the existing link-down handling for other devices.

Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 26d0cfc58ee2c..16b166b010ef6 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -458,8 +458,10 @@ static void txgbe_mac_link_down_aml(struct phylink_config *config,
 {
 	struct wx *wx = phylink_to_wx(config);
 
-	wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
-	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
+	if (!((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP)) {
+		wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
+		wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
+	}
 
 	wx->speed = SPEED_UNKNOWN;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
-- 
2.51.0

