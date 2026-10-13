Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1108F440A3E
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857257; cv=none; b=rwJFq7Vy5RrcBa/NTwqvueAyEAaEfB4fVzU9cyPCSQeVCLhW48ify5G/hTGXZHH9uJUkgrgeksIcJcCMIFN0c9OSeS++XUCiaJAACLV0B2+RZ61m2HYKzL6wanGUTvnXR15ELCHNNaKShXyJeP2lYkjK3fBIcZcIKPEtj4u9LgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857257; c=relaxed/simple;
	bh=B2X/IRuVkPsH0ZJIOwQmN7nk8w8dOOLnMav0o/Ij1gQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhZz69nfYgcihfQ/BbAuYL8MPrJ/lXMOEZEwyR8hepYp9WKC1jmGQHavuNwFHGhfGPtnT6zXKvjk3dTDm8blAr+X3sinoBk/r6iW9FW0b5gpoyA++Gkv1DIEkr4c0Y8KDen2LNH4dN8l3HfTI1GxsxhSHKcmVUK3jgeGl6U+T9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1791857211t277985bd
X-QQ-Originating-IP: W1mJDYfbc1B/oMqcAJuq8YoqaN2CwBAlgdvElVGjo3s=
Received: from lap-jiawenwu.trustnetic.com ( [115.198.217.6])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 10:06:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9455529463459812031
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 3/3] net: txgbe: keep MAC enabled for AML devices that support NCSI
Date: Tue, 13 Oct 2026 10:06:26 +0800
Message-Id: <20261013020626.5548-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20261013020626.5548-1-jiawenwu@trustnetic.com>
References: <20261013020626.5548-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Od9qnhE38AUtekj+f0AtfhahWWgS1qpYuFbL1T1yGxD+iym7mwsw4MZe
	M9h9UEHFKlmfvbKaM+elZ93LA9Z1w0GF3MCpLjgVSb9cwY25WFI6YF+HebAVfipEINISqWS
	98+IBSEP29jCTvhCpj3ANkaWf49ukqaqSxtLvdrL3hb33nL2ONTQvlgs2l8fMd1NOPWjR5w
	HTE0lcZv4nYwmyvg/ckx2iHWKuyc31wL3VmU5xduuuZHezo15qQF3hhvu6hc8XBCcsPCDLE
	AO0FdwB+KIg3epuZdVXcxa43MgLelFHBxGDqzxCTs1ySf+PXjE5GfU+zh3QdY4QnM9pudvj
	Ylzc4oyIS7hJv9ClTMplmf2mzw29K9Q4ifi6Y5iNY4KEc9Ccv9uvWtbKvgUaD1jGC87YImT
	sEeZT7YCcBJQpNmExAG1F1wlqu6X+pJ0sT++aYzd1VABs0m/s0Wn3E3TmgoogJZeVQa27W4
	SLZ4JwBovRPCmPwuGNfY+VBTDmr5asXMusBCrxfwWTpdJKRU3YSGA2qJCeAMbt1oO1iBSZQ
	p9IwUYrqxsOv2A2/w+WeoHFpNcQ8PxndwjTuk4liz5+S+wn8/QjI3XLShzcPzGLeY3hSdq3
	BQsQpaAZDW5F5ZLMfSCbvbGCzpQzVffBbAk0WQS/Q9/xBgUWIrvGOrif0AXpgPtY8LL2gWy
	f5ScEmTYGJr7SoIAWkMwXptpQAcz0UPOaAS8+5fw6atN45fugYtNk/ieBpKNwi5lmwvPYIO
	2heDcLhg6BeGkJg1nJd6fOkBwcg6bIfhE62JBr2STdycK+3b9MU7MqlgVGKtzZx6aCD2pw8
	gGzxTfOIUsh+lUMHhmbJ1YVm/UsJiFRdEVZm73RYDWZnR8qflGObGQuyprQaSDk3mOsPFJN
	VV6z53npWLnV+Vgy30L0+oO1U0aP690YeaxAbc47kGAiD4smQZqYgkhCzoyRFv1zQ0LQV9f
	g56GOEj4iEqm2yiNou7Tl4+YFuzQXXnNToYA13Fk1SG+3pvJU1sHp3E6dMVnh7GVAQsRVlb
	sCaAwCzwIgvQd2pG/MI+RtcS6sG+G8tc8DCLHxFJDYAmlTT7OpbZc8n+LwtFRB0kFV/S5dg
	kEjBsD00Sx8vCsJaTEXrVA=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

AML devices using NCSI require MAC Tx and Rx to remain enabled after
the host link goes down. However, mac_link_down() disables both paths
unconditionally. On AML 10G/25G devices, txgbe_down() also disables the
TX laser when the host interface is closed, blocking BMC pass-through
transmission even if MAC Tx remains enabled.

Skip disabling MAC Tx and Rx in mac_link_down() when ncsi_enabled is
set. Also keep the TX laser enabled for these devices in txgbe_down().

Fixes: 343929799ace ("net: txgbe: Support to handle GPIO IRQs for AML devices")
Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c  | 6 ++++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 26d0cfc58ee2c..9f1ce3e2e3a4d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -458,8 +458,10 @@ static void txgbe_mac_link_down_aml(struct phylink_config *config,
 {
 	struct wx *wx = phylink_to_wx(config);
 
-	wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
-	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
+	if (!wx->ncsi_enabled) {
+		wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
+		wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
+	}
 
 	wx->speed = SPEED_UNKNOWN;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index a60a711e8e1b4..7f0cef24ec28b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -295,8 +295,10 @@ void txgbe_down(struct wx *wx)
 		break;
 	case wx_mac_aml:
 		phylink_stop(wx->phylink);
-		/* Disable TX laser */
-		wr32m(wx, WX_GPIO_DR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
+		if (!wx->ncsi_enabled) {
+			/* Disable TX laser */
+			wr32m(wx, WX_GPIO_DR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
+		}
 		break;
 	case wx_mac_sp:
 		phylink_stop(wx->phylink);
-- 
2.51.0

