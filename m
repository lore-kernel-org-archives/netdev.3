Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569395;
	b=K/kMxOiMJYkIUC7X5WMmXGU4RdVEsV0FhqfUEFbHTBnQhYWrmnqpmMUPG0TavWSyUmz/
	 0wlsIHn9N+8zt+ziLYQdwSIY+8iGtAl9VpM2wPFCKOYIcVX8TNRaXb326RCW01bmaAE7k
	 /+71o185LrUyKyouKXoVjxsxTcXy3xIhlW5xiEK3U9BqRGyGWa8djjtPXuyDZK8gUGBEZ
	 jItRbKUkpsOEENhJN0zPIP3fLrOAjNVwipc8O6Kvz7pB7WHdxYD4YEMC1x10fKbvyeERn
	 Fdm392TWmxPtPNceXNmL8eEodydXrATzHmVNJr1IowUCEqfWqrNT4UqKZp55F3qEzkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569395;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=aD7zHKGFhWmsXZ4dKfGhDgucVB9qbuaiYAYuijAD4Ik=;
	b=OHF//v/MUNT7gfG3eMqNkVw51v62JUvZrfxM/xZzjZPpPBYIfvChsC0VTiHBHrjwsZJV
	 4FvDtIpqT41t98W1JmyDP3kO8nn0c2yNtgS5Sz1vgU+ekmUS3Cg+jBZarYGlyKXOjo0mD
	 naAPOjzMjKfTsBC2ArQoY79O29kvAYossCe+dSAWruQcOG4q7dUsI1UQYWy3drub3hxCh
	 EWRSKEGse64clIzT8vdeuOjYjkZ+7akTogKUMl90iVU6UMG63I+VEOML/RPGQdwtA9fpj
	 AtX+lo//To3AVIjmBgTZRtlu9qVIkE+yG7aRwnz1gdYhsoO8kUKFu9B9hUUYCdBtZww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=KJ0Sxadc;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DD8606A319;
	Wed, 21 Oct 2026 07:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91DD8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=KJ0Sxadc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78072A02DC;
	Wed, 21 Oct 2026 09:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792569392; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=aD7zHKGFhWmsXZ4dKfGhDgucVB9qbuaiYAYuijAD4Ik=;
	b=KJ0SxadciDSku0NZHZsFt1RE4hx3/iXqxDCMSflIz7lyr4kdg+DmaetmfOiENIsBOTfB9n
	lI4sHt6zuaEWpXB2MpwyNOPjzVqRDjH3j5Q3TdcwnX1KRGjmEs3tXO/XwXBUStEZ4s6xdT
	6b2Na3ClFX+6CEKy6oHCSRzquVIGvi6CxrTmm3K1yCWBD5mLNTAv5BPiG2LmwndnLQJ3eG
	ploxes5FXRTBpcTw21LsIFj+gv1ef95fsghYS6mBWpdSmiZhJFKHl+dDE58hByRhJ6n0/W
	6ONNeZHHxWWg9RphOUvu3w1gfuPneDH/kEPRRzu12JXV8VYVUcX4jWImKbzLdA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v2 0/2] net: usb: cdc_ncm/cdc_mbim: fix netpoll lockup
 in tx_fixup
Date: Wed, 21 Oct 2026 09:56:17 +0200
Message-Id: <20261021-cdc-ncm-netpoll-v2-0-8818965bbb69@tipi-net.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNzQ6CMBCEX8Xs2TVtJfx48j0MB9gusgYLaSvRE
 N7dgmePM/PNzAKBvXCAy2EBz7MEGV0S5ngA6ht3ZxSbNBhlcq2MQrKEjp7oOE7jMKAtmqLLK2s
 NEaTW5LmT9754gwRB/TPDq30wxW1rw3oJcfSf/XfWO/z3YtaoMC+NLrNzmbVZdY0yyRafLEO9r
 usXQRQG0ccAAAA=
X-Change-ID: 20261020-cdc-ncm-netpoll-d7a7f69dd2cc
To: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Sjur_Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>, 
 Alexey Orishko <alexey.orishko@gmail.com>, 
 =?utf-8?q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
 Greg Suarez <gsuarez@smithmicro.com>
Cc: Breno Leitao <leitao@debian.org>, linux-usb@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, Mikkel Eskildsen <mke@visotia.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Mikkel reported lockups with netconsole on a cdc_ncm device. Further
analysis showed that netpoll calls ndo_start_xmit() with IRQs off but
BHs on while holding the txq lock, and the spin_unlock_bh() in the
tx_fixup paths runs pending softirqs. A transmit from one of them then
spins on that txq lock.

Patch 1 fixes cdc_ncm. Mikkel reproduced the lockup and tested the fix.
Patch 2 fixes the same code in cdc_mbim and is untested.

Changes in v2:
- Reverse xmas in patch 1
- Link to v1: https://lore.kernel.org/r/20261020-cdc-ncm-netpoll-v1-0-682184384b49@tipi-net.de

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Nicolai Buchwitz (2):
      net: usb: cdc_ncm: don't enable BHs in tx_fixup under netpoll
      net: usb: cdc_mbim: don't enable BHs in tx_fixup under netpoll

 drivers/net/usb/cdc_mbim.c |  6 ++++--
 drivers/net/usb/cdc_ncm.c  | 10 +++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)
---
base-commit: 044ad3c90d9d2df2c5cb3325ae17b4e9603a311f
change-id: 20261020-cdc-ncm-netpoll-d7a7f69dd2cc

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

