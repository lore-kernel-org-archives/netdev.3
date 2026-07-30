Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21E33E34B
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394532; cv=none; b=VCVh+hYqEXtf4SSw/hOfhSTlJRFA44UBfp40YvPEVIzG3KprTdmk/9P4UcRvG6ZDeGnf3LkDKYeL2CwqeD24GpcPhheZUMYA4hG+h/QLZIw4aO3nzZs0tzrYvCgbpVZhBRVIG2tw1pU/y4NfPuBo5nZos1vXJyEc+9+/ts3tVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394532; c=relaxed/simple;
	bh=A34EmNtDqk78hJCdgjY65kl+GGpL3e/oswL8dIrndXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeGXetp0U3Hufug+TgiV4rgrw7S1TeBv00SuC4coWOjqZIMo8/00jc4nPKSKfy92IySpPuz0ImWY1XE2ePuOrkPA/D1idSeKYuKLQ7Kayv81T1u6su3VTvkilzwMW6WH9nwZ87iUfp/kvsRCY/FBw8RKQcHDrRInzi+YLswzJMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1785394459t2b25c3ec
X-QQ-Originating-IP: GTJnlzywHgWcMAc7n/NLsctRObRnur6JGBzr4bbTNps=
Received: from w-MS-7E16.trustnetic.com ( [115.200.224.93])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 14:54:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7253533830393453052
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next] net: ngbe: correct misleading interrupt comment
Date: Thu, 30 Jul 2026 14:54:09 +0800
Message-ID: <147244C2750FF990+20260730065409.50807-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Ngen99C70FsODgGpgLFBqzyC0jgZg/41aI5jgVkBtebovKNNBRm+/x0z
	vKHJMahZPyma9lxHz10xyl3dMPAcwysBUkPDthkmOpcOBKyt2qVwNKNyLz550IJy874+Pk/
	GuPz+Vk+6eONhEM6Mew7pXKkqguhzTcpUymDyoibUEIPVjBN0I+vvSN98m41s/YJWtxkJ9v
	RbgiymTGOMaFn6Qz4NKoQG5q9ffp44PAkcOH1C/6KcfehqKGbZeObeUn5GuM7rr9beUju/S
	WF4Iz9zxKf0mQR348jV/6cFWVaqlA76KXkJ01OpKO4QorMUcPEVn6FkSErB3Rk/q4VyMhQD
	9KbjfSLB6JJo3QxEVH0/ulst/hPqzXoZJTpq+O48WQ8MUPZo+2eOSMnlxSVoVs7lLa5L6Z3
	dBZaEQN+KEitnUesa1zRqYyPHVDriTpI+qQoxgGIGT/lXeFo/vLgdr3HoW3fptr+mV2yImK
	NVCR+7dx5pQLNI1sctNKzgG9bCff79IydvyzdQc795IxHdIufWQilVJSmMGk6RthmfAIUAx
	1GEAimgy/Kc0jMqqjmyRbmwhgb7hh0+Rj5b4zjGV3Pef5J+kaUJyVNbm3c9b44DuTe2aRex
	VVLp/aFGeGx1iWMUxetZ4zo5uVRr07HLG2FmuqNYdWaFLdBxKc1llAlA1Z5JStL150I5J6Z
	ylBbjHO5VdW7SNcUhSEA8muOGFyETWABTuqtMKrFpEJS0l5pOYQ9QDbq0LLzeGX+U4iQUHA
	B91k9axzLTc6za0lWRpCkkXf1W/DNkB3MHQ6Xddr2ymK6taWiz4YjJkVBbmqxtEcNfaDqe0
	kySkLO8dxT3aMiCWhnlDpbRF+29f9g37yL2c65f8CbkAJGhnXoyDQgv2mJtCZHFgSqlCOS+
	NVPUDR2wCpARkI6Fv8KULXL44FbBa4jGh197VLMXBr/fKWBcmOYVqGemmtuS+DmyUZNN3bh
	zjmHi7bQRIoYltEJf6kPod9rxwGgqm9C3BalIYaukBW6ivnqbzUVV+coCVK+7DwCQISVl/2
	9jZXCVCtbtpyqYneJHcOnURWogWg7pc3f1qlnL5JO2m+TRPMsycOZn6YFWeTs9goS4wbWWb
	hvikjWHmHQ1
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

In ngbe_irq_enable(), the code subsequently calls wx_intr_enable() to
enable interrupts. However, the preceding comment incorrectly stated
"mask interrupt", which means disabling or blocking interrupts.

This patch corrects the comment to "unmask interrupt" to accurately
reflect the actual behavior of the code. No functional changes are
introduced.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index a16221995909..bfdff6345303 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -177,7 +177,7 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
 
 	wr32(wx, WX_PX_MISC_IEN, mask);
 
-	/* mask interrupt */
+	/* unmask interrupt */
 	if (queues)
 		wx_intr_enable(wx, NGBE_INTR_ALL);
 	else
-- 
2.51.0

