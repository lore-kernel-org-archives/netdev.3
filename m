Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784384;
	b=bFwyp7UVVKcHQMFI0bKGB1KaFe4i71TDwjZIiSIw3uzMXUW/ynFcCN6Zlh6qt+KQ7Oh+
	 /DNwWakaLqTvvBEEpS2IKY8pg58A213koRw1JwRdQpLePDuMxI4uNRvvIGLNTzYvv91EJ
	 GZjku1v3yEsCDn4kHftJXlnBDl4+7i2hzJHQFNbeKoC8wanHdQbo+tY+8ndT8dwnehFgr
	 sZDCR/uEuXL4qdt493KRKrHHpkdkG6Sm5DXdJzvnuyJaG43FAK9mGopoFsaeFMsPwRrcy
	 KUuHl2D3fM7ICJlNGE/hBcs4RzZ1AWtV5Kabdj5O9BVRvRPN5hZJQkcz5C1bXTj9SPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784384;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=4pw2w5TX2D1rqXpzVEo3CKWGtWhwTLpbdQMFSbOSiU0=;
	b=EfoHhyK52RU1J/mrMW946hOg0+T+jTC6wcXKYGx6/oy2nxpwhZh5Z8UltwdPRdZzEOGP
	 o2eijk+odqaUQsduEJkOdBeL6JfYcun9p1uZRXHlJWJyTezL4wsNvAXcFd6nVv5TEW+Kr
	 KvnydrdvYUMahc4ni+PaGfSHBsQQSSserbolce5APY+LCTjsReX8r79I4Spc2PBMJwcFg
	 IUtft6jIA2l5CakcciGumUJEw1xGzBUqW+p0J90TBzV9V9i+uL4/jrHV2xWeZa7gj2hsz
	 W80Yz7zD/I2PPL1edG73lC4LcRXx5T1Kc9C+PRL85h2hAWISdiYnx49MIy9ypH/c0rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QxeH4739;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4BE606A335
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4BE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QxeH4739
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6F057C8F46C;
	Wed,  4 Nov 2026 09:27:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7209560770;
	Wed,  4 Nov 2026 09:26:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AE2B1032912A;
	Wed,  4 Nov 2026 10:26:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793784378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4pw2w5TX2D1rqXpzVEo3CKWGtWhwTLpbdQMFSbOSiU0=;
	b=QxeH4739fwoLhz0ukYQzV6AsMjONbp5QSomsJ41SMZ1kGtMIhp0IkZD2VMRKg0s4BQx7mC
	VVTLpP2Og3F8/hZ8ws3JQPAN0rEbD9e04H94QwE8ZZLvxuvqSj/95XVG87xULXJW6trTnK
	lbDpP5+rZu/S4b9Y0SWU+44qKu5esBVtDfSmUDFngdjUqFWnYD+/rRBl3r7Rzd/h9Ua7iX
	UqMU1y0H/p42JuTGo2GR6oj5TtGqa9BadHKfIjsAuLZ5JPBIxb6rbtMSXe3g+kjbAO7WRW
	4aGIRrEXwnttIVKDiPd1tamr6KCG6PYJgHpEVHxlUXFQikUfxOmZRDxyr5eUxA==
Message-ID: <4244dde8-9efe-415e-bbf5-7b95f36ad379@bootlin.com>
Date: Wed, 4 Nov 2026 10:26:08 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net] net: stmmac: ptp: fix support for PTP_EXTTS_REQUEST2
 ioctl
To: James Clark <jjc@jclark.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261104052504.1886335-1-jjc@jclark.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261104052504.1886335-1-jjc@jclark.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 11/4/26 06:25, James Clark wrote:
> Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
> ptp_clock_info") modified the PTP core to validate the supported flags
> of external timestamp requests, rather than relying on each driver to
> check them.
> 
> stmmac_enable() and dwmac1000_ptp_enable() ignore the flags, and
> neither stmmac_ptp_clock_ops nor dwmac1000_ptp_clock_ops was given any
> .supported_extts_flags. Since PTP_EXTTS_REQUEST2 always implies
> PTP_STRICT_FLAGS, the core now rejects every PTP_EXTTS_REQUEST2 for
> this driver with -EOPNOTSUPP, where before that commit the same
> requests succeeded. Only the PTP_EXTTS_REQUEST ioctl still works.
> 
> Tests on an NXP i.MX 8M Plus (FRDM-IMX8MPLUS, GMAC 5.10a) show that the
> auxiliary snapshot inputs timestamp just the rising edge. The reference
> manuals for the STM32MP13 (GMAC 4.20a) and the Cyclone V HPS (GMAC
> 3.70a, which uses dwmac1000_ptp_clock_ops) say the same.
> 
> Encode this in .supported_extts_flags. A PTP_EXTTS_REQUEST2 for the
> rising edge then succeeds, and one for the falling edge or for both
> edges fails with -EOPNOTSUPP.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

