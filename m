Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CC2F7EE7
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703698; cv=none; b=NU4MTnZ9Jj/FejWVxeNzauQMZEBSoba3pbi1+ipVBjFiFgDA448cSzJ9pnAFupbwxB2mCQ3as8KNCp/l+n6OPLKPdmry7dR85DSTQUClfL0kQepJMlMy9IjDIzQmFeyw3cbdGkD/rQqFCF6xUFsFV+J5YUK1XEiX5ObEZ5w8B+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703698; c=relaxed/simple;
	bh=TEb6cmuYJfPTENVrAfCtApqrrcbJHz/gheUSvizeR88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aiC1f/LFv8S6No/prDgF18V+E/cK/E1uYojypwSX0xpqzvQ0sh1/ikfJCgs4pHzlA2A/y2dxICjXShzpVd5AfWUDrrgufD7jhmyv4/ciZgXziPdn1hPJFyuVZ7uasvytPpGp4BNvQsinQ3v9TfVmgupqjLw85HTaxvEvLO3VSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1779703557ta607b378
X-QQ-Originating-IP: LiPXhzScXza1pb6rJY7YzYvPcr17Etb5NpO/jieDNdw=
Received: from lap-jiawenwu.trustnetic.com ( [122.231.28.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 May 2026 18:05:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 944353387482229234
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 2/3] net: wangxun: avoid statistics updates during device teardown
Date: Mon, 25 May 2026 18:05:42 +0800
Message-Id: <20260525100543.27140-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260525100543.27140-1-jiawenwu@trustnetic.com>
References: <20260525100543.27140-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MABkn+BX1UZ4ovff1MRaRd8Sf+mpvRixVkWMNIlNAqCYarciDxJGb/yR
	cIvGb3InyZf3uKiqprXns8pitGcm0LwAvp9DGai5kiHOnIjYSzbT8r/ZUhE8xUl6OYnOhPx
	lLnjiO0pNV3tXxpd36JK7c8QFz91IbhyQwmxwRhkBF/UeqMF0cE+1hXArzINrJTMVFaZHrQ
	ssG7wvj9LYnsFqL+LNUBWUBiutstV/a6kAAeqq1KM2jXPK34LO35tfAWW36YJD4OjzDBzcK
	mAC9rVQjRPTQc4ZoouI5MJe/Lz8sU4jN4QpRi2pw/fAmy04myB6TSxmwCpkSz1u3U9ICnFr
	sQGTXRCXR1wo1emQYV05/3dH/mMQPcHLi30+GB7IvqqvG6oc6tZHljVTtO0yI34XEAJOcRh
	NlFdG4+zlUNlTLJBFAlq3fAkwsAYPPV2EL4F+N/S7c8ULL07UZ6MgV6ei//MKugtUTO/eCt
	Ky+OlZpLK5qE99+el5cXK5WoDl8pGc1q9JDSWnYNoVlTKqvixb4JReihle7NuXXHMEKbJ8/
	q9VT240xDDCGsZGjMhlo0jNvps15pH/py6V09wIU2iVr1mMj3EkQwLgem1veYi+xlHohdZR
	pjAZFuwU6RaTyNYJyfC2gJAsKfyINLqfyWmie4MviyD8NEAeW2fM8FbxJUvXXb3s3PrqYu0
	ZIJwONO74Z0lQaB5RPrgOCgoTS5/GoI1Ohp3XkfD9CbzYHw2kEerHWJCoBZhV5cHPhBX2KQ
	q+FmZPZUNjgQ7KYBvKblDxh6x/EyD3F3J09zTRexe8MSjEFvzeebpaK5AO5E7FxC2oxC0S1
	bYn156iqRZuksiwFmnfVEBm8q8X1FNgSbEK4nzuuThxsj9xuiCY/fF3rHliQ5KUmH0B8369
	XHak5XRoZWfoiOehWDPunzktgx6E99zFKrWfUcekPYlBEYixeurderd4weEP2d0j9x/DlHT
	B+BBUBFoz9U5vI5uZ+SYRMwySwpRzgGbVaIX7w9aaN0IyTtQ/deTPZUBuZB0EZ0+shjJgEl
	+S0Rjsg8rU9WPwNX260CjfuBFBenEFF4E4D+r1WvlGRU26ER1hXk+qhI0VVt3G230esD1cA
	Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

After introducing WX_STATE_DOWN, wx_update_stats() now explicitly skips
statistics collection while the device is in teardown or reset state.
Calling wx_update_stats() from the device disable path therefore becomes
redundant.

Remove wx_update_stats() calls from ngbe_disable_device() and
txgbe_disable_device().

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   | 2 --
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index f4a2dd6fa493..8678c49b892a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -404,8 +404,6 @@ static void ngbe_disable_device(struct wx *wx)
 
 		wr32(wx, WX_PX_TR_CFG(reg_idx), WX_PX_TR_CFG_SWFLSH);
 	}
-
-	wx_update_stats(wx);
 }
 
 static void ngbe_reset(struct wx *wx)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index f9cd1caaf0a4..6755464b4637 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -265,8 +265,6 @@ static void txgbe_disable_device(struct wx *wx)
 
 	/* Disable the Tx DMA engine */
 	wr32m(wx, WX_TDM_CTL, WX_TDM_CTL_TE, 0);
-
-	wx_update_stats(wx);
 }
 
 void txgbe_down(struct wx *wx)
-- 
2.51.0

