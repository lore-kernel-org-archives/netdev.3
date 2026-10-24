Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848220;
	b=xrwrfWJsAORQo1Lm+SrS3sCaG/gf/J8aG+run62dsWcepQI7Adc1LDDPsYRD8EOmqTS+
	 Bh0P/qWN9Xop6QriZXIGSFuGbxBJs3ZubWaDXPQpUGuHa6KxelHdjpFI9kM0V0uwUhCoS
	 eeKnMyBI6ndtYhhh0nfwXU23GhaUEjM+ZS/w81EOha2Gj9ob9i81O9nSbsUJBTh8SL/qf
	 94+V3uYgbBePJ/p8QGU/of3PAmJan2yudmaV5fn4Q4Kjk/+abFtr57bmewyTwjzSA3WZj
	 uOmXtoy09Cjg+XulsQErC9XTEIMHRW5NFd8OmX7G6pZN4Y1hkv4YcQ/PVOM0lBxfSrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848220;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=p6phy3NP+L8YktmM+nQw4wId5NrdzZO4MGgGl8ypPUg=;
	b=RSF/1HJS+QnRrvfa7rExoYLQEPj7wkpDEU3ePKXn2cAH9HwAtskjm2Op7toV5J8GIbsj
	 n2FnccBjOIV2xRvRjQj21jBA273Z0fCs1+gOGAwnVn4fbdo/QP8dqKSadbOv/yOjCL8Hb
	 na9MQX3JQagGFaSzbIYClj1lkboaNCPN5I7toU9kKNkcs3+CYy9C62TZ4KD/oA2pZAY4m
	 AQOcTSYPlvUxJs6daDZYgABHpYhQ9OWQ3XcaPNQEITN8DVfOyaMoALRWI1mOEwRwoelEN
	 tPuUT8LMUMtDij/mZvD0/8Pa2F8I98jGTAbOv8EKFDhvcHvz+44edo9Xmdbnh9xCf4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=BsWiFEiy;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8985606A31D;
	Sat, 24 Oct 2026 13:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8985606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=BsWiFEiy
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 831B0A15A3;
	Sat, 24 Oct 2026 15:23:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792848215; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=p6phy3NP+L8YktmM+nQw4wId5NrdzZO4MGgGl8ypPUg=;
	b=BsWiFEiy81tuti50BNPS58/f3aiwyiyoFfLBnFN6TKt4iVoj3mbFhjh7vHQxk2wwJPlIWl
	QmPGbGyIgKP5RGokXnLSJcf7rLz9UnL5ZiegW/z3Gl0VRfy9/qdyJlyPYh6QlsZCWNJHME
	VIDB0in6ChGfcYWC5VAOOQ8AJUBdM4sWW17nCZuGaMLuoxHP5fEjo1pZBKk+sFNEDfbzmO
	UsvX29fnjMGjmDeYlb/iFmqdDotiWYPPygUA/pjUAjI/fIqz7B207X3QfjQFNWh6hpFUBx
	gmR9f4XFXsXVzD5F32uiMsZN041ld5UVOlaM5ZMM6PP/ZG/o0W6UibU72kZzAA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v3 0/2] net: usb: cdc_ncm/cdc_mbim: fix netpoll lockup
 in tx_fixup
Date: Sat, 24 Oct 2026 15:23:05 +0200
Message-Id: <20261024-cdc-ncm-netpoll-v3-0-6284ca03f967@tipi-net.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ6CMBAF4KuQWVtDC5biynsYF/QHGaOFtLXRE
 O5uqRujcTkzb743gzcOjYd9MYMzET2ONg3VpgA1dPZsCOo0AysZpyUridKKWHUj1oRpvF6Jbrq
 m563WTClIX5MzPT6yeIQUgtN76e/yYlRYrTU2oA+je+beSHP4b0WkpCRcMCrqStSybg8BJ1zPW
 22yH9mnQH8FlgQhqGj5TkrJv4RlWV60htN8CQEAAA==
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

Patch 1 fixes cdc_ncm. Mikkel tested the v2 version of it. Patch 2
fixes the same code in cdc_mbim and is untested.

Changes in v3:
- Use plain spin_lock() instead of spin_lock_irqsave() (Jakub)
- Drop Tested-by and Reviewed-by tags since the locking changed
- Link to v2: https://lore.kernel.org/r/20261021-cdc-ncm-netpoll-v2-0-8818965bbb69@tipi-net.de

Changes in v2:
- Reverse xmas in patch 1
- Link to v1: https://lore.kernel.org/r/20261020-cdc-ncm-netpoll-v1-0-682184384b49@tipi-net.de

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Nicolai Buchwitz (2):
      net: usb: cdc_ncm: don't enable BHs in tx_fixup under netpoll
      net: usb: cdc_mbim: don't enable BHs in tx_fixup under netpoll

 drivers/net/usb/cdc_mbim.c | 5 +++--
 drivers/net/usb/cdc_ncm.c  | 7 +++++--
 2 files changed, 8 insertions(+), 4 deletions(-)
---
base-commit: 044ad3c90d9d2df2c5cb3325ae17b4e9603a311f
change-id: 20261020-cdc-ncm-netpoll-d7a7f69dd2cc

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

