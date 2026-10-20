Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480637;
	b=HsUBhscXovPlwaQtiPAHZqvaXRFIW1FVpGkpLl9QNHze2AW59WBGUCBhBX1aRG7vVA8w
	 MwESqS49u4q4uWSWMWZ3sIvYBJTrwjzaDWzuYHCXNdL672cgvQGYnC+rYpIl2/d3KAjDt
	 Z5SBPCL9NjXGVSl2k8hmkHOH0wCUF4n9NZu7sLzprDA5K2mwOsXdKCdTKeJwBub1a7xyL
	 WsIM1isQn1XZb/lOtqbKyiviop1IFKdNkMClClEhGLrj78pRZ64NMR8yxK6wK+bGV1sBM
	 9Z6yWjRIsjwmrt3dWwYih13sZ6Z+ub5hHU6z2Xd+B+cL/gk5tJrUyfUX6nrvhA9Qw7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480637;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=zKoG1Y27u5lxRf/K5y/SpxjMEPsJ6IGeF6f+oULx/sA=;
	b=EH6GDThlN3MBhSDrP0h0I9r4TOEq+MvBOoiw0QDuhai04spXxL77Vm5o7zwAKBbZ2Wpj
	 Yz/NwsQHyPJMHJjGqueepAWescFt7La1NslEpeeTJwAbz3T8hkhFtJK2yWjeknmV4rfSa
	 /gd4/HZcn9XAYHgC/u+oh+JqhDepjuRYRhQl+kJlUTOYO9qsy5r0ZjC9mDMeJBw+Cb6ph
	 29OhGpzg0lRNCLfJP/KBx8WVaViyixlncCDxQCaNzK+vGQhgVp/5lgERULMEcHNLGo5Zz
	 dLePA9HREiDUngoK+L9hEK8MeuNCYhSqZFQL7WL4ehp3J2pj7LGmcef8k7GH2fZKQkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=oCLxCk6L;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A1606A319;
	Tue, 20 Oct 2026 07:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C2A1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=oCLxCk6L
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05702A15A5;
	Tue, 20 Oct 2026 09:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792480630; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=zKoG1Y27u5lxRf/K5y/SpxjMEPsJ6IGeF6f+oULx/sA=;
	b=oCLxCk6LYN9H1nikHlyUXQhBehQQp1G0JMqUAjS9c03psxicB9+0hPZpOgEwMaGl9nx7OG
	sTYURu0a2sk6jAG4DFzmSkE9KDk64QB4m4jE8LCsoc31AV5u52kcl16wDY5T7bGbWsYm6h
	yM3lpDCmzVROU/GUA3jZrUdzRLF19/fbYThzm6zbL+aGyEJQDMELC4C7NwBUuKdHw5hqGO
	8vyuGU9aeUGh4IETGR0IM8xPCaYBtt3D4R5SnjwzlUokMw/DoVvGi1yXOXEsZ51P+hDNtz
	Gvk5rpKh83XWo/NkGdg/D6CjAFs2TnJYWUcI/0Tds84z+rPPywZvwclRVOKpKQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 0/2] net: usb: cdc_ncm/cdc_mbim: fix netpoll lockup in
 tx_fixup
Date: Tue, 20 Oct 2026 09:16:54 +0200
Message-Id: <20261020-cdc-ncm-netpoll-v1-0-682184384b49@tipi-net.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDQBAEvyJ9zsC6B8V8JeSgM2MyYlbZ1RAQ/
 +5qjtV01Yak0TThXmyI+rVkU8hQ3grwuw0vJZPM8M5XpfOOWJgCfyjoMk/jSFK3dV81Ip4Z2Zq
 j9va7ig/kE57/Ma3doLycLez7Af+Hjlt4AAAA
X-Change-ID: 20261020-cdc-ncm-netpoll-d7a7f69dd2cc
To: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Sjur_Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>, 
 Alexey Orishko <alexey.orishko@gmail.com>, 
 Greg Suarez <gsuarez@smithmicro.com>, 
 =?utf-8?q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
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

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Nicolai Buchwitz (2):
      net: usb: cdc_ncm: don't enable BHs in tx_fixup under netpoll
      net: usb: cdc_mbim: don't enable BHs in tx_fixup under netpoll

 drivers/net/usb/cdc_mbim.c | 6 ++++--
 drivers/net/usb/cdc_ncm.c  | 8 ++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)
---
base-commit: 044ad3c90d9d2df2c5cb3325ae17b4e9603a311f
change-id: 20261020-cdc-ncm-netpoll-d7a7f69dd2cc

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

