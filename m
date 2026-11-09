Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206474;
	b=Uvp4OUq8KI8hnfordEwcNRGaxfCFhViyr3WvmRhTsXHdC8zXp9NQBIVKmnAAIt88PZFH
	 DNwThQeTeAcw3A317s2kxGnwwYLD9AGcu3K/iPrrZLtMl5PDsiUtCoWgKffzcX8DNadfP
	 4arvf+Dmq4TxLH2+/5C7EYq74urKxaXPOvgEP2DqQdNBGkhs8CP7ObWfKVz/Mn1WVS40+
	 F3aZEx/hBp4BlSDKIuXsFyvBrQXUermu3GqW/H2HtNJy8oCsZx0KZiiw6P5x1foc6xN5w
	 sUtt/DtqVN2//FARlM1/aGZZsjprsOEyA357S7Erl3YzuLkJjay487qINLYZgkdmYxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206474;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q4pq2LP10uD9GXhbYxSTeiDxrDfkSErB9nBqJX/up+c=;
	b=rMXXdZhTv0W3Dqt82zTr9d6tCLgXjlWD0nTqgfBPM4+9fYjaUxrEa7gGFlKEasi/6mJ5
	 pC4riwwxsFxs0IwfjkDaraQ6/n2iwtBDjxUT57pXLXK+oMXm6CVA3aIriS41ZanCPiDp/
	 qjPO71bCGJGNfzcC+OkFEoJ7v2K3Ge0ZW9YcYNAzeb0U3UQ/uRA0kZKTNOE7zJmjwLU/a
	 ZEz9l2MA2iK4eWzjwcrlQUe8qxhVZ2qPz9ud+UveDxhmXxItnG/QPHKSeTRGK/y1LjZ0l
	 UNnY4tlKsj1E8f8pfd8Ec77jickoKVfp6bOQUA2l7lTTqH8W2l8ct1OsCBjX8VSlhxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="cCdxhP/c";
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D77B606A323;
	Mon,  9 Nov 2026 06:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D77B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=cCdxhP/c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=cCdxhP/cquZbpMhPeYMJ6TkSZjAgP6t/8QSyLr2sEB07EiYP+XIUn7zvH8K4mestMOd7xvQcYIpSl
	 WcQhbAZRTrnTSTVS5n8yZKUJ/NC1pRz+5f4fF2PSPVjYRH5zSre+3L+kuZShyrVGCR2n2eLWO3hgIM
	 Q5AlDnGNmqeGwl14=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af16b07907-616b9;
	Mon, 09 Nov 2026 14:41:11 +0800 (CST)
X-RM-TRANSID:2ee46af16b07907-616b9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af16b05ab1-848cb;
	Mon, 09 Nov 2026 14:41:11 +0800 (CST)
X-RM-TRANSID:2ee56af16b05ab1-848cb
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
Subject: [PATCH net] net: usb: cdc_ncm: don't underflow the NDP room check
Date: Mon,  9 Nov 2026 14:09:13 +0800
Message-ID: <20261109060913.526268-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

Reported-by: syzbot+1994e2ecf323ed90f255@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1994e2ecf323ed90f255
Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
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



