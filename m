Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3181446C1E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083866; cv=none; b=GzHGS81EOrmTpkeQJ3T91L81xNe5vMU3SZFrjFD6FguIU9jDJ44Fsp/KJaLqG8AZ+j2rLWdaduOjqkZOJbI2XvICYXGjt+AajFXti+AlieuwBXsJ98nTnDPbIeHLDetDLbZ46jC8rGH1XlCFXM80HYo/xm85RRbCYTP6roEHcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083866; c=relaxed/simple;
	bh=AgjoWKMjNN83lU06iJ73TgimwAnvJwieGjzSHYcV8Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/h02uW0A4yhE5ic6A6pip9uURrCedA9wzUqsWyL2+UjCdPsmfMbeZoexCfUPZ4N0N+4hCI3q4c2WH/Ju2cFV9S7tvLvmy6iZyizMs/N3v0Bs05xNBXDXu4vdC6Bx7ci9e2T3XhQD8r/ZrkiQRwGEXF7cJ4plvclfwb4+kZWhpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1786083751td23ea071
X-QQ-Originating-IP: /i4nBbNHIv68Oo2wS3/yG4XHtQUowoRltZLA8f0l/Os=
Received: from w-MS-7E16.trustnetic.com ( [122.235.196.25])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Aug 2026 14:22:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9136410163996304089
EX-QQ-RecipientCnt: 13
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net v3] net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling
Date: Fri,  7 Aug 2026 14:22:14 +0800
Message-ID: <B2693E9A8BFAD110+20260807062214.410838-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NBYSVrzI/FJoMaYbt2pLCOI70MOjt1DUIwqhVRLmvQFIdnPgeXZYY1Oz
	eaqxFFgifBUL6LF3GwfFK0nK6GlFJeXYbIy7l7clWngm0DHQodkf/iePKXuP4p6nXWzE6a4
	va4Z8+fn5/2RPirFOW3CwdXfTry75xs50eXq9KszkO1IpDlEz0fAciBYgPbtzUyOWsAwnvj
	HV/m301H0hxQmD+oNbJV50QZPegfvqmCxiVra/MnuG2lqJI16YGoYkd2sekUWYvDJcibAhE
	qvXZwqGXRi7z9XK7mdpo7fm+T++gj6VAJZcaWhvXC0D59nl9kPDtTD1lOEGmORPGSI8WECj
	Nr/n5Is9kel3wLhfBykBRJSk8rK0rX+C/gh17EK7uXmlGEk0twDJI190lYBpRyQ3s/AsOU9
	m2xMnzEx1do1MlAbB5kQcSy6DnPyp1jsMYTpQ7dTGSOZcIAgOjxpH09j+Dvy40frWtA9rx/
	JaClKjCVMhNhT//7Sktcz07WebjahD0Q0bnLdIJUPlI3Fsaq3Xn9lGLOKZJfJIxdBnF+bRB
	lSsDHWrKxuzUL9m6iRKAnYcP/Av4sSnL5iRGEbP8nztRQx3IDoEwyF4iBxwwBxVxFWk4dNh
	41PYg1mbxTB4oMaTJvWo28+/T+WTKtP2KmgYU7nZ+8edluR6K5Mq1i4BRTNcB+IWj0MbTsZ
	XSbyyVyReXqdPtPLAqGbXZtiWBLc53uM3dhk09NRHNatK8jo1AlQVfIV4VcIDvkU/MNhXWl
	/9mpJQpme9TpsUXrSAzxVBfn02EiXFi9RL1cnpka5QAnDriDO1adVWmA9sKvu8tt8wBk0x6
	XiBHYovFdP766HPLvljtiRVh/CFj6odpJ32fQsRT6w+zOfrtEzFw5z1Sdjbsy1t3OcrrO6N
	kmM5pcaTYBuagYiYQJkGGAlT5cClYNGzyZ8/2YxiZ/7GBLa3Ec2CWmozssCFLwLx3DE87aL
	SOPY6IhMBkPOen93Vx2YomeZyKcRD1ltcJ+u+pMnpbUC7KqE5SOfz9txBy7Xj8+zqSdc7Qe
	x6PEHb92o+yRKbtUujZNnYlTjHYFVooOz17TonPVLXgo71h/umG6CF5riYUxu4GV4iVx6yU
	hsHCIbzizwz
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

In non-MSI-X mode (such as legacy INTx or single MSI), wx->msix_entry is
not allocated or initialized. Calling NGBE_INTR_MISC(wx) dereferences
wx->msix_entry->entry, leading to a NULL pointer dereference crash.

This issue was introduced by fixing the IRQ vector when the number of
VFs is 7. Fix the issue by explicitly checking `pdev->msix_enabled` to
determine the correct vector index.

Additionally, as a side fix, set the interrupt mask to BIT(0) for the
non-MSI-X fallback. In MSI/INTx mode, the MISC and queue interrupts
share vector 0, and the WX_PX_MISC_IVAR register is only valid in the
MSI-X case. Thus, BIT(0) is the correct mask for the miscellaneous cause
when MSI-X is disabled.

Fixes: 4174c0c331a2 ("net: ngbe: specify IRQ vector when the number of VFs is 7")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
v2 -> v3: Detail the commit log.
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

