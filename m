Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295448;
	b=zBKTbfGg+QGFUssGpyEtUo7ZSxtvAuXrgk6oVPHTs1MTQzSMgstM5VSlnblUoHP432Q4
	 Hb89LIWYSZtjP0FPo6pd6uBCA2QqSReAP0EY6xCgFkUymkFrc9Fd0WeZ1UL9IQniCpfUF
	 QeqUvvZ19F0StpfUyYJRFUXQHBqMpJNnAEgmc/EHYHRQgQfeaqLXPTJCqSYToZl5gozxD
	 TKYJj3k4I1qrGseGHsAsIWaYAqVmct129yZBFjp4ZW4qRDH1SbDkHSZHF/fERqEK/u/Se
	 On6I/N0Lc/UuBwtfSJhyOJ4sZW+GWIr1o/w/xjlPsM3OgRjI3FbE52GIvor/QKU9PUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295448;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NSZoFUu6O8ixTtkZVDN0mU18cE9zXsccDQTW2Dn17D8=;
	b=S3Hff4zOYKAyLojACQ3S6Ei55jCjaOGtlLcVDFexT5GzcbcERXrU0uUv+PhAXfmlBHYW
	 vJvXObyWtoLNL8TeI9nKUbhGBvsFZRv1i5mLZnWffjsa9R3D0br1x34eadCeJ/kaUwgKT
	 Xp2hwHz4U8W1KkSHtQGxGyEmkTjDgYrvP1bQ3W/j26BqKx4Gsv/KrTqV0Fg6Z5BBF2ER9
	 nn5wz9dz8ocuCQAqxqmMdjdSQPblgBXNJGckZ2A/+6X8a9DB5FQwfrPgqqC8V5vfBXsAW
	 NdKXQlEtekOZ3XPgYL+A7E8rx0x3P/ijoDGz5D1Eo0KGiBO8CY7yBAt3AA+XNZVizBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=obqhgN+v;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D81606A31C;
	Tue, 10 Nov 2026 07:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2D81606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=obqhgN+v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=obqhgN+vOUd+g67FXf8vOAtxIGCCDZIHqIxpLkJrq1Mvk/YoDHOFodovG9iTnS+pZl4iQjYjarRxm
	 eWq3jWz+ybMu8Z5zOsR/NIBQYbat9J74F/RTTnlkPDMaI658bJyqRO4psMh9DqSrwANGkSel3xIiex
	 wL8Qsn8pRjGjIGWk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af2c692552-c9ac3;
	Tue, 10 Nov 2026 15:24:04 +0800 (CST)
X-RM-TRANSID:2ee56af2c692552-c9ac3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af2c692cff-aba86;
	Tue, 10 Nov 2026 15:24:04 +0800 (CST)
X-RM-TRANSID:2ee76af2c692cff-aba86
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: Oliver Neukum <oliver@neukum.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1994e2ecf323ed90f255@syzkaller.appspotmail.com,
	xujiahao <xujiahao@cmss.chinamobile.com>
Subject: [PATCH net v2] net: usb: cdc_ncm: don't underflow the NDP room check
Date: Tue, 10 Nov 2026 15:16:24 +0800
Message-ID: <20261110151624.696101-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109060913.526268-1-xujiahao@cmss.chinamobile.com>
References: <20261109060913.526268-1-xujiahao@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cdc_ncm_ndp16() and cdc_ncm_ndp32() verify that the new NDP and the
datagram fit into the NTB with an unsigned subtraction:

	if ((ctx->tx_curr_size - skb->len - reserve) < ctx->max_ndp_size)
		return NULL;

tx_max is only clamped to max_datagram_size + max_ndp_size + the NTH
header size, so tx_curr_size is just big enough for one datagram and
one NDP.  A second datagram in the same NTB is therefore exactly the
case this check has to reject, and that is also the case where
skb->len + reserve exceeds tx_curr_size: the subtraction wraps around to
a huge value, the check passes, and the skb_put_zero() of max_ndp_size
bytes that follows overruns the buffer:

  skbuff: skb_over_panic: text:ffff80000db33558 len:428 put:172
  head:ffff0000c2c66100 tail:0x1ac end:0x140
  kernel BUG at net/core/skbuff.c:200
  skb_put_zero include/linux/skbuff.h:2595 [inline]
  cdc_ncm_ndp16 drivers/net/usb/cdc_ncm.c:1132 [inline]
  cdc_ncm_fill_tx_frame+0xdf0/0x30e0 drivers/net/usb/cdc_ncm.c:1309

Here end is 0x140 = 320 = 140 + 172 + 8, i.e. the one-datagram minimum.

The room check in the aggregation loop cannot catch this, because it is
done after the NDP has already been pushed.

Rewrite the test as an addition, which cannot underflow and gives the
same answer whenever the original subtraction did not wrap.

Fixes: c78b7c586657 ("net: cdc_ncm: refactoring for tx multiplexing")
Fixes: 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
Reported-by: syzbot+1994e2ecf323ed90f255@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1994e2ecf323ed90f255
Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
v2:
 - Add the Fixes: tags reported by sashiko-bot below.  No code change.

 drivers/net/usb/cdc_ncm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 19db5a668..e92dc7f01 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1125,7 +1125,7 @@ static struct usb_cdc_ncm_ndp16 *cdc_ncm_ndp16(struct cdc_ncm_ctx *ctx, struct s
 		cdc_ncm_align_tail(skb, ctx->tx_ndp_modulus, 0, ctx->tx_curr_size);
 
 	/* verify that there is room for the NDP and the datagram (reserve) */
-	if ((ctx->tx_curr_size - skb->len - reserve) < ctx->max_ndp_size)
+	if (skb->len + reserve + ctx->max_ndp_size > ctx->tx_curr_size)
 		return NULL;
 
 	/* link to it */
@@ -1180,7 +1180,7 @@ static struct usb_cdc_ncm_ndp32 *cdc_ncm_ndp32(struct cdc_ncm_ctx *ctx, struct s
 		cdc_ncm_align_tail(skb, ctx->tx_ndp_modulus, 0, ctx->tx_curr_size);
 
 	/* verify that there is room for the NDP and the datagram (reserve) */
-	if ((ctx->tx_curr_size - skb->len - reserve) < ctx->max_ndp_size)
+	if (skb->len + reserve + ctx->max_ndp_size > ctx->tx_curr_size)
 		return NULL;
 
 	/* link to it */
-- 
2.43.0



