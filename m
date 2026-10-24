Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848220;
	b=rO8XF/nHhHrFuvOIn3Jk54ytMO2JBV5Kj79rMieQisb3gGhBnDkHu7VXy2AA+ceMuSrn
	 V4JYBzm1Dk99348n95Bt+eb9kbMbe+mqkcVaBqA+1nh3NjaWPKUjMi32GjZoTkt4tFyv+
	 ekCCOOiPHeE3AcnHWCTtLzZnjQU/5PM4hDM6Jg1G0QuHx/iBbIAWzEEntRbBlRD2N6yg7
	 rU0ERVAg95leMss35Ikp3pMgdYVnAn9iIb/wg1Sz0KNkHNVx/H1x0+cfVeyPRJ5m8CtID
	 0GhlUKc0jMFd7VvetlBTikn3VPHbzwveTZQWY014NzY/e1DXzVF0Fu4aw73JC3yM1nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848220;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=hKhp0+hBPl/Si84K7ssm9WFLyQf8tf4APvt6PCqVxbk=;
	b=FEOCV7SYNsrTPuKuPv2i+Otkd0+ysejpbL/1J1i7lfYO1SLEOoOepyfRmhBbCaAGVutx
	 ogKDjH9Xp+KPh7Nrp3SfDYl5dvO6tLPaHmH27cldl4/1He59W3IcaNvonJieFu0yUxnZt
	 NKG4Xy4gEg5UlVUBB57FkX0/Gu7y30ErRAbY68o2cxquo/oMWNSN2aD5TBBhvgLWlV54G
	 i5Vw7D+cgQMc7rT2fnekQnqtA2QDRneEiBWIoGUbqzCs+CNj60dJe1T3MMh54KcsCiFhR
	 x8Bn2AB4AC3g1TbjyPsJs5QEla83MDbW7Nh/CtJRULRCdxm9+HFSLLrQZYvYES9R3zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=jJsXt40s;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8DC606A31E;
	Sat, 24 Oct 2026 13:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D8DC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=jJsXt40s
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45D8BA21B9;
	Sat, 24 Oct 2026 15:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792848217; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hKhp0+hBPl/Si84K7ssm9WFLyQf8tf4APvt6PCqVxbk=;
	b=jJsXt40sWubnYxxk5m/PtfJqaJ37niR6M4WsVBlWopOKT3yCpnkMG1hsL5Q5UtDFjIEUL8
	3ud0dsHX5MdIoEdkFVCbIPSbc+pdAsEmmk7kSv71I4zCrArZNaHMxMP9F4hQyPIA5ICO3I
	11FtNTj+69IUIfYOdyNKvOBRoKYUEOytMkcBC5e/pN3wwEHkOxoZYMijkAKwF5A/MB/mN6
	t8ft2yXR2wCe+cgIuLCRwkFd5Z/1rxvde393M4cvFDFO1gYLQp+0Aj/RnNZtOGs/RMdGeb
	nX/2rBKmk3mti6dUUslnau1RnCtsvDzmdNN7IicNB1MQ1kiNMl3cLcTpvScI0g==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sat, 24 Oct 2026 15:23:07 +0200
Subject: [PATCH net v3 2/2] net: usb: cdc_mbim: don't enable BHs in
 tx_fixup under netpoll
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-cdc-ncm-netpoll-v3-2-6284ca03f967@tipi-net.de>
References: <20261024-cdc-ncm-netpoll-v3-0-6284ca03f967@tipi-net.de>
In-Reply-To: <20261024-cdc-ncm-netpoll-v3-0-6284ca03f967@tipi-net.de>
To: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Sjur_Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>, 
 Alexey Orishko <alexey.orishko@gmail.com>, 
 =?utf-8?q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
 Greg Suarez <gsuarez@smithmicro.com>
Cc: Breno Leitao <leitao@debian.org>, linux-usb@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

cdc_mbim_tx_fixup() has the same spin_unlock_bh() as cdc_ncm_tx_fixup().
Under netpoll it runs pending softirqs while the txq lock is held, and
a transmit from one of them spins on that lock.

Use plain spin_lock() as in cdc_ncm.

Fixes: 9bf211a30b3f ("net: cdc_mbim: adding MBIM driver")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/usb/cdc_mbim.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index a7010a0664c7d..8f5734ac35b8c 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -289,9 +289,10 @@ static struct sk_buff *cdc_mbim_tx_fixup(struct usbnet *dev, struct sk_buff *skb
 		}
 	}
 
-	spin_lock_bh(&ctx->mtx);
+	/* BHs or IRQs are always off here, see cdc_ncm_tx_fixup() */
+	spin_lock(&ctx->mtx);
 	skb_out = cdc_ncm_fill_tx_frame(dev, skb, sign);
-	spin_unlock_bh(&ctx->mtx);
+	spin_unlock(&ctx->mtx);
 	return skb_out;
 
 error:

-- 
2.53.0

