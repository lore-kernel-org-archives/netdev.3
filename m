Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B415474F
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484264; cv=none; b=tWchJ1+X7tvD7VEgvw/goMnvyvkBm3ux+ZfX0/sVMPD0kmDi3GTGoBVRnriq77IEHso0FJWmT8UCZA2QamvQJYI8X4FOYmByaH5QpE432gXNGi8LPuh+Sq2EZvB98fEC9IhwJRurTgXaCyPxkzyadfN6LgWLs5K8laAYuLxQGKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484264; c=relaxed/simple;
	bh=fddozhyQf31fTYoY7LfGPvhVHHlANi/h5bUS8zs3tpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PT4mUAE3q/alGIE/l6D9qUYi2EESKBm3YoGxDWD0/0cI4cLoRtzD9lab/pByL2mKHw0MZgfv+xrzf7LMB51Y5rGZTzzqsIn81X5uCLlVTLr/QXa3zer6pb/Rd8yELEOAuWutgm7oSuNnyo2lUy7tyVIBRdOkdn+lWfGPfH8lm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1785484216te4c601c1
X-QQ-Originating-IP: iu8LHYPV0IAdq6+MlikbgQsPNm7an76Hiq+rMVkKr5M=
Received: from localhost.localdomain ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 15:50:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12739412285086252571
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 5/5] net: wangxun: add ndo_get_stats64 support
Date: Fri, 31 Jul 2026 15:49:58 +0800
Message-Id: <20260731074958.19333-6-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260731074958.19333-1-mengyuanlou@net-swift.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MQYXLRAkMyae+pX/ENtA0ZjKH+Nm4/j99khEpCjjywozqj1ToZzbBY7b
	eahuWT7LXpJgNNei+Shkxf/3jvxUJZzK2Qwkul/Z+uzqHPK1PL2JLI4DQVVCRxojixy8l87
	o+nk+uTbyMFuv5j+OZG04l7sQzehAzndZjWy4L0srPLxaXnSjwhRL2mo+Ko9HuwaoedcgMF
	j4pZGRsb+/XSJUWiEEqMq3/xSQRlytRDxuIzGr1ssOjzWhG3SyhUw5xBVzrSlEqrTqVpcii
	gdYNe8Seb5beN6ke1kja0TBb5+uUUkTdcRhxPjJsY99+bunYCAjaV4LW8/UnP7oBKrrB14x
	R1klhYdAqAyQr/G0U2MJR9gJJuvu0yHIDtwdFGZ2ZK4kGbVG+qcpiQkeCaVO/MqZNh3UClY
	cQQULswt0IcTTqYKBGuRVHN6qIvYf+c7zNPhMrr7/T+nIqoaTNYOAzrOpmp8aIOVIyLLs+L
	V6Hm4w0KVcGogBOOtRl9+rCsfmEWaWknG5RygiA30A6KgEmQXiTpqN0+otSuQzjLUAzNLv9
	Grf4VXMYeG6ioMc8U7bMjFH5JF8pY8bMWfQ+ufXwn8vLPJEQwcJ5ocvazk3zKIYqu1JWg8e
	TzrIgaKGrqTL4lIYlfjW8JHT6p0QBte0Aqt2W9cTGOWlMXKv5VNqCKg27jtSLzlK9n7Dtcv
	ogkkrRkeLa3Kr8Cn2KatE0pTiGYzgw7bgfT4b9qGsiNsmbwfF+naajpQxq/UvTykWpVlm6u
	0+J/5WJ0w1QP1mR8TaHRxjDqNLjdBGIcb/jdXK4R+FiLvyxnbQm0AjLPsPkW86LngPbiyRc
	pq1wmxPK60AEYIYhOomoudAJM1UFAfPasdIQuezoep8WH0frX9UK6gfWJ7EMHV+o+UXAoM6
	b9MKpJqK2ZuregGFdGAXlTHVEsm9R2g+n/GJw3JljiD3PfWgRUgTrxUcnVPPjeIWwbFX7pV
	EKkpMbZHaGUlnWmzZb48Vlhu8mvddk3p7WKD9DxN6mLf8yQruRTTk3gS5XY/dfEZPweJ7YF
	ccF/9Tt4RSAntYR6xOWgIns7YiyTOQXZXbSd5FwimrRv+qzi3PLm+23HPttdBKv2c6nc+sS
	tZw6+6USkNDXIc8UBO9l2428fEJC/+NqxB4ItIiQAzSABMBgM+m3It7VC4sNgnu5aBJ8ESH
	LcGZ1g+gAEF2LsCtrh/17rIb0tl1dgptO7Ymx/LhCAM1jys=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Expose network statistics for Wangxun VF drivers by registering the
ndo_get_stats64 callback.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c         | 2 ++
 drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c   | 1 +
 drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index ae20733c703d..a4ca01c18c6a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3092,6 +3092,8 @@ void wx_get_stats64(struct net_device *netdev,
 	}
 
 	rcu_read_unlock();
+	if (wx->pdev->is_virtfn)
+		return;
 
 	hwstats = &wx->stats;
 	stats->rx_errors = hwstats->crcerrs + hwstats->rlec;
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index b6bab050837a..b4817c58992b 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -48,6 +48,7 @@ static const struct net_device_ops ngbevf_netdev_ops = {
 	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac_vf,
+	.ndo_get_stats64        = wx_get_stats64,
 };
 
 static void ngbevf_set_num_queues(struct wx *wx)
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 2dd119bd52e5..1e30d8f2183a 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -44,6 +44,7 @@ static const struct net_device_ops txgbevf_netdev_ops = {
 	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac_vf,
+	.ndo_get_stats64        = wx_get_stats64,
 };
 
 static void txgbevf_set_num_queues(struct wx *wx)
-- 
2.30.1

