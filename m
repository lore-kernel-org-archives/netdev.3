Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49701327C0D
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741720; cv=none; b=FK1VABfMpgxlvV9BY3M/nkYG4pHLWkMMv7q0INUqOQVzYwJ8mwMEQIDezaFYV/LK4MW0Upbza6p0RsxJDICXw7LrqF860bmqgIoFfuqHYB9QWR5FdRxg+fa0r0pRyTTD+c4Gykb39SeBg8VX5j1NfIf2ZF9lhEf5d0GeUI53dgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741720; c=relaxed/simple;
	bh=XiSip5NkYwpTVKym8Zp3OfjSpSaIKI3DSevd3VTWsHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fjvWlBqWd4UOr5IesOme0/1ugjgl3wfldyTtUpKmvHrri9rt32TJ59N9m2Xo3cTl735Cg2xf5A7CIIysPRdAondj53X40473REhDjN/V+MQaV3qSybNVb+g0mKsyvIx2dFjp1V1vILoFQVuYFfNwctPoDwa2zyIKHGecwqsvYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1785741631tf9385852
X-QQ-Originating-IP: 1BTopSDNXaXnmsW6O/RhWl0IcdXadLaQrPKtbsciz3Y=
Received: from w-MS-7E16.trustnetic.com ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Aug 2026 15:20:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11675927200111275037
EX-QQ-RecipientCnt: 13
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2] net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling
Date: Mon,  3 Aug 2026 15:20:21 +0800
Message-ID: <5FE44222ED3FAC4B+20260803072022.377406-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mj9MILefhhyFumB6JSuSGQa3jl9AAreS+0/BBzsAQV0TabGSO/L8Di7P
	apT4/9tVuj6X6evGGQbR42jO5RFWNAPBlJ1WaW9cXvhKMoDcDnIg/JBPwGnshwwHdDi3qN1
	snLF+lQbvUNK3bM8ldGw3E6S/N17KPeJ7SUEeliFcOJMx65PYIZIpT3EIXJ6pLiZOdUhJbS
	dtFWUpJ3G/Z8IC6hRjRh7aZ6x0rzg0mhhXeR9ZS1a5qVRLt7MdRwg8ErNwjcPrxvyHk/ZUz
	B9gI26WBwPWjsULZBtQUT0HNJUvAPMTYPRDQWcv8+sR05sRM2YitnT1hzsmfdLGr1zZD4e2
	yBN/nDc9iB1g+lkhf3D4AMQn4olKYFQlz5GdUdOARsGtxoYxEK9nYNYy12y23YLWgtjb9F9
	qQGlZsrFBQUUxegEElkBzRefrH+rZXMQ+Z2G2PGnlCY4C/v7yu0euB3s8IxsK/pfVAfr49Q
	pQFrw+xnaUR1isfxh7EbMQKR4hq+2bukugc/Ny2GcoG9YcUCrlWXs1/Sz21CQeAu9JlAwW4
	AFYsmGu0E5dg/jCmMyimnL58dZQ7gIv3b67n8fzTjjYKASIo7GlrFzoH2zGLxMSiMsOkv2U
	Us6dq7f0UQPn/6BEuLBOakUxwt71vhubUVItj0d7ec18wVJXtPow7NKU+evss7ohGyaYFI8
	r62jU543WUVtjy1fauUuMakNd2qgYJ6r54A78iIv/xHRvbI58ltkjeQxuE7w8xppo09BZdr
	uTDHE5xKBYPMYhqqlccSM9ogLa5OKKuwo9qw5HNXoQVYn2LUV/hznhABlOilIZa5oNfIjW7
	fa0qqUw9vWAZjqgFVV1ZVvNknLJJ/GCWs7qIs6Ie78FNPvI3tV7v6DQWF95615gqgiMGdPD
	wleH91naQlGPiT08QFcxAzKljPDGJ5TWqC0jBlxwiTRzTGms9tTSlfDbwHzje9kWzr/LrXf
	/ejsBz5kq5H/mRMwo79cyyG/Qd9ih1p97pwuZ0z8VR0vqJJVCDwANGLanDB0sXocccCmh6X
	crIwTgl57hBSJon1sURDpNp5jGIzj0ATS5enHXdTvxYh22GG5QQgnnicQY/IC4UPnka1yyP
	5j3Flf0mg5+bXjby6EomdTuEqXAOxBQ8db4DOTtm4oFLKELpRoAhPE=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

In non-MSI-X mode (such as legacy INTx or single MSI), wx->msix_entry is
not allocated or initialized. Calling NGBE_INTR_MISC(wx) dereferences
wx->msix_entry->entry, leading to a NULL pointer dereference crash.

This issue was introduced by fixing the IRQ vector when the number of
VFs is 7. Fix the issue by explicitly checking `pdev->msix_enabled` to
determine the correct vector index.

Fixes: 4174c0c331a2 ("net: ngbe: specify IRQ vector when the number of VFs is 7")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
v1 -> v2: Use pdev->msix_enabled and reserve NGBE_INTR_MISC.
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index a16221995909..cb653861aad8 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -180,8 +180,10 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
 	/* mask interrupt */
 	if (queues)
 		wx_intr_enable(wx, NGBE_INTR_ALL);
-	else
+	else if (wx->pdev->msix_enabled)
 		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
+	else
+		wx_intr_enable(wx, BIT(0));
 }
 
 /**
-- 
2.51.0

