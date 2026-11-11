Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372276;
	b=kFI6A5TuIZwvYggo1XRktYyefakspkjGWIqnQglISiUVsNPERv4NrP17iNNbAoiau/bV
	 59/I4XxNhuFlvYMt4uoUeyTbEpaP0OvarRPYoZOQjZzvbs+Lwwaa65opgtKqrlSvHSPl8
	 1fa7YD0/Qo7xgbeT0KdfO0Gfrh+2FOYsraN7YNID65HYledeAZ2sbiCOgi0qvvXfmZfTQ
	 WOd7V07Wdqa4mRCWaBSLD67ZmvE07VAQnGLcAYMqfAeX2PLfZVONS8H0kBf1uDuCV7X9d
	 C2+CRg9N9IT/EHWhEUxZ5EhnnNKri/jlFcCgM/aFQ5+xW3vIKaEnQ9ASmWMvr80P/+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372276;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0tpJxveKxPfHNRpCKirl/FgBZeOcOoofUH5Nbrkohs8=;
	b=CHmg8Ke55tgCK5umugQzfTpvAOejVjVtpUDCTKx/oY62SDil73nHAShx0wdB2W6Diwcg
	 FS0umrwh6ZyQT4VN38nnjjyrHmBZHzW8pxR9h+AIM2VwVIZ1nrHlj6uz1cV8jkaUt954b
	 YAxkFHmQ2/lEOwcl6pSaS2avZoH80c2u82HwaQTY1v/H/xwFJo2oTDHfHzsxH/T440PhR
	 YQAnbxsXQcsqfCWY0IhA1kQNNmmr+8xExl+cLIqIcocbw2RL5+pzj8n+AE6wDQH6w8SNy
	 +BbvDrWeylb9Ns4l8W3ZXjYGpyOdBOamnsW2mV0G5mSKl66D3qhlt41XDjg8IDOb/Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OXhlpFnj;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EC060A3824;
	Wed, 11 Nov 2026 04:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9EC060A3824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OXhlpFnj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=OXhlpFnj2Kf2ekPpI1i/ZAyg8b3+gf+c0OdhJY6WuVE4cPpc4pZ02u9wJndR/z82wQxfskykOwClT
	 RartZnLUMvHtxYuqb8jsHG9r34eXyTmX1dM23TJeQsEOXLwn3TlhxeNSuq6FEd7/TUeZIyhkUUEoIe
	 LmI1vk3xMBDkcLyk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af3f2ad898-d1e81;
	Wed, 11 Nov 2026 12:44:29 +0800 (CST)
X-RM-TRANSID:2ee56af3f2ad898-d1e81
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af3f2abab6-ceb90;
	Wed, 11 Nov 2026 12:44:29 +0800 (CST)
X-RM-TRANSID:2ee16af3f2abab6-ceb90
From: Jiahao Xu <xujiahao@cmss.chinamobile.com>
To: Oliver Neukum <oliver@neukum.org>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, David S . Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot+1994e2ecf323ed90f255@syzkaller.appspotmail.com,
	xujiahao <xujiahao@cmss.chinamobile.com>
Subject: [PATCH net v3] net: usb: cdc_ncm: don't underflow the NDP room check
Date: Wed, 11 Nov 2026 12:41:56 +0800
Message-ID: <20261111124156.637661-1-xujiahao@cmss.chinamobile.com>
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

Nothing guarantees that skb->len plus the reserve stays below
tx_curr_size, and when it does not the subtraction wraps around to a
huge value, the check passes, and the skb_put_zero() of max_ndp_size
bytes that follows overruns the NTB:

  skbuff: skb_over_panic: text:ffff80000db33558 len:428 put:172
  head:ffff0000c2c66100 tail:0x1ac end:0x140
  kernel BUG at net/core/skbuff.c:200
  skb_put_zero include/linux/skbuff.h:2595 [inline]
  cdc_ncm_ndp16 drivers/net/usb/cdc_ncm.c:1132 [inline]
  cdc_ncm_fill_tx_frame+0xdf0/0x30e0 drivers/net/usb/cdc_ncm.c:1309

Here tx_curr_size is 0x140 = 320, skb->len is already 256 and the
skb_put_zero() wants another 172 bytes.

Two device controlled settings make this reachable:

  - dwNtbOutMaxSize = 320 caps tx_max at 320.  The lower bound computed
    in cdc_ncm_check_tx_max() is max_datagram_size + max_ndp_size + the
    NTH header, but cdc_ncm_setup() clamps tx_max before
    cdc_ncm_set_dgram_size() runs, so max_datagram_size is still 0 and
    the bound is only max_ndp_size + the NTH header.  It does not
    reserve room for one datagram plus one NDP.

  - wNdpOutAlignment = 256 is accepted by cdc_ncm_fix_modulus() as long
    as it is smaller than tx_max, and cdc_ncm_align_tail() then pads the
    12 byte NTH header up to 256 bytes right before this check.

An NDP can also be added to an NTB that already holds datagrams through
cdc_mbim_tx_fixup(), which uses a different signature per MBIM session.
On plain cdc_ncm the chain lookup in cdc_ncm_ndp16() returns the
existing NDP for the single signature, so there the create path is
normally reached for the first datagram of each NTB.

Rewrite the test as an addition, which cannot underflow and gives the
same answer whenever the original subtraction did not wrap.

Fixes: c78b7c586657 ("net: cdc_ncm: refactoring for tx multiplexing")
Fixes: 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
Reported-by: syzbot+1994e2ecf323ed90f255@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1994e2ecf323ed90f255
Signed-off-by: Jiahao Xu <xujiahao@cmss.chinamobile.com>
---
v3:
 - Correct the description of the trigger and of the tx_max lower bound,
   as pointed out by sashiko-bot.  No code change.
v2:
 - Add the Fixes: tags.  No code change.
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


