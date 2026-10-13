Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EBE446074
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857261; cv=none; b=IGf9bzmmTn87jz351dCYfMO0k4UHSEcKAJw9+cNy9ntzKoFhyRK7QpyiuBHhgtspudUT6lF7W7oV12LBDeZe/EbhQftyyFghaPxKgqP0+EM9vHtMGf5s/Z51oVcuIO8x9HnJt+hX1h6ujfIrPqfJzRc9BuhyIFxc1cM8ir9ygeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857261; c=relaxed/simple;
	bh=e+0jBn7c0D7vLzkUgim8r4xzFUNzcK5Av9eWbyX52IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rq46VNxDmMiQPHd7lQqSGySmeRMcjLrHj4Vwy09QTPNMMAVB5L6NVti7ztQfB1fEWGQFIVC1irTr3WeJvMfEH80uhHhzVuTPmPU0zain/ufaKXxYS5H7bPDzvcw+yEyynrODC8tMgspPJFNtpB8CwFBlEHwSzceA0Wu6ZoqHoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1791857204t5ed1c865
X-QQ-Originating-IP: UEd6M4OhHtVSZdrYskK1TjpLsjfNg1UXoRRNIL41nJY=
Received: from lap-jiawenwu.trustnetic.com ( [115.198.217.6])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 10:06:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15894885111485079008
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
Subject: [PATCH net v3 1/3] net: wangxun: keep NGBE OCP cards MAC enabled
Date: Tue, 13 Oct 2026 10:06:24 +0800
Message-Id: <20261013020626.5548-3-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OLiMdF5B5RXDhQPt2aXy7oWt7xD6u9D3r/dHrncYb8oGXcrCtLeY8xc6
	PSpblWG23jhPOPTlzUcjbL4fy8tB5RSMlsZLMAXVYpjfnkfUyDNw2/79WBnFdL7rghrCnuZ
	2Q7qZcUFxB/45lRi4RyEWTM2f0OTErG8sDIBicLEsntcyiZY/XJkBnCOYZCSMf2PlU8JfRo
	TOVY4eyjkERwH7mUsWX/nVKreZ/zl42Lf4YzhAO03hjID/R358u6NU2/eHaPikCQOZpNK8m
	+RYNPvxtHZG2acBsHr7r/9DX2FnV8HtWDUKYjdmmhAcExJU3215IB/MFST+in9XficUf+zA
	lKFcs4i9kF4s3Fm/h0JfMHGXQQMqdu5M8QBYn1m2x8XQAnOfH4lWH/kj+xJCI0Z4a9Gn56Q
	iQhrY8X92Cr3Xpnp/x+Nb4Fk7x80XeQNSTalzfMRu7igQ2qqS3X5rYNUxJTO3AtanbJNlBx
	5hmSXj1Vze33ck6feBrRlzFgYLoGOOwiR09HA1TaF6c0eVlTlf+y3whkCfusOgyrXRDchxa
	QszAgZBLtTwmD4xtMsYt6Zr7L9cbtQ5r2+DQVD15RMcklfigJYebeNaurjqx2Zupmz8Z7GB
	lrS/0j84iI4PbrzguysZwW8Kr/5XmJ1Us+DVr82K2zmhexXb4R4rVVEr9KNlBB23vC9UOtf
	onqc/L2tTP+UXfr8vfI30F0uHkLxzj7GJrU/lpHh6VAQGAHLp3n3QcmBAhD9FIDP0+1Ryy9
	s+d2hFeIE/8nMXzyUAvkKQLVaNF0O9nLel9SVwXwpF14/5/QQHEsyzzNMHUDxL5EAwfg8zC
	Ov/jz2KtIofrx/MM/B1TruMRadQt3/qyI48UfBmLBj5qaQ4MjOT4SRVf3kjUDVaV1AZmk3X
	cqAsa5/93m5sPigCKaHUPq3y49LCHRHaSa1woCfe3pFEhf1P2xd7AuEFnSaOBVbUB2sLLZ9
	YKh/XRzwGjfeX+dhiY9Fbd3PnDCPFGYvQcYK3RwwTeXAjemknIrdgjJ3PKbo0S7iCZIW4bZ
	3XUxTbuZgUcu6QyJ+Boy9Q6oSmyJ6A2KXnFalDF9YJAYgCAMn/XRUHd0zzq+J2CtpodWT2r
	fSY7IFb4KO6AhtoYg20WeZ1ZyJliybiwQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

OCP mezzanine cards are NCSI capable by design, so the NCSI semantics do
apply to them, and they need the MAC receiver to keep running for
out-of-band management. The inline test does not cover the OCP card
type, so on such a card that does not have the NCSI bit set the receiver
was turned off on every path reaching wx_disable_rx(), and management
traffic was dropped.

'wx->ncsi_enabled' is the correct value for NGBE to determine whether
MAC RX/TX should be kept enabled. Use 'wx->ncsi_enabled' instead of
open-coding the subsystem ID check, and initialize it for txgbe as well
so that both drivers share the same condition. No functional change for
TXGBE.

Fixes: 02338c484ab6 ("net: ngbe: Initialize sw info and register netdev")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c      | 2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 113552586be70..1c0c59436890f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1313,7 +1313,7 @@ void wx_disable_rx(struct wx *wx)
 		rxctrl &= ~WX_RDB_PB_CTL_RXEN;
 		wr32(wx, WX_RDB_PB_CTL, rxctrl);
 
-		if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
+		if (!(wx->ncsi_enabled ||
 		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
 			/* disable mac receiver */
 			wr32m(wx, WX_MAC_RX_CFG,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index eb91c4f28ecd4..a60a711e8e1b4 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -267,7 +267,7 @@ static void txgbe_disable_device(struct wx *wx)
 		wx_set_all_vfs(wx);
 	}
 
-	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
+	if (!(wx->ncsi_enabled ||
 	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
 		/* disable mac transmiter */
 		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
@@ -381,6 +381,8 @@ static void txgbe_init_type_code(struct wx *wx)
 		wx->media_type = wx_media_unknown;
 		break;
 	}
+
+	wx->ncsi_enabled = ((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP);
 }
 
 /**
-- 
2.51.0

