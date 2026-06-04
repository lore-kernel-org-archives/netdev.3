Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2C3FDBF7
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607753; cv=none; b=Usl/j9rkMDSwKI72DfplyQOFbCmvRwgIJAf+qNBBPRiITPCUpOgAELMTdMDcjGfNMOqfW0fIXHPsmIvbNKoISzEEnZt74VvgZ01MrG6B+l2G5Bzcl21dppyIMncvs/UnuUWokfFaApQnQx3OniBNqSuPP6hjpzEEOKPmihtE4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607753; c=relaxed/simple;
	bh=uzi1qKKF319w7qp7uCB9CjmvG2HW8sHhqSjX68MC+M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sx1F22qb8gAPd91GliXu9IvpTdu1Hixoc3hbzzE6eGorEh2Z5A5S/N7BPgSIEs400IUkeAS++6FAugQ4uDMLdxzZipuQw7h3jfChn+64R6tu9fK8Cbfxl2ML8RBXMiFi36N8woq9EurS9G1px9h9Y7sog2TLmjFRGDGI0FTfM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qhD906c7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qhD906c7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8581B1A07A0;
	Thu,  4 Jun 2026 21:15:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CB325FED1;
	Thu,  4 Jun 2026 21:15:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F4213106A1D59;
	Thu,  4 Jun 2026 23:15:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780607746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pOjBojSdOqI950HvFqUStTBY/H0OP5HMjT8uY3n8qDo=;
	b=qhD906c7wi4RO3tIb91H7sy8JaNxOpSMGv1l/u2cm+PbpftHyD7b1Hm3sRfQIOpxiQpCvX
	RlUJRkvbdBmWK+G8kqf4MwdhkCl0aAYjOU36maQaM3pWaTmUvVFIQEr15FlXOqlH/5c31U
	IHsOF98kHZErzXd8dh9ppSmEjReUgyn6+eudB+HOOmPKWmOp9+FqZx7NokfmQaZkQoMt93
	L0ErMuNAyB9Z8c47SUg394hGcXMnf3YAFtOflutq3WNQWaviB8O8Z75P+nHjui/WmSkAYo
	GsohIC1ElgtKK/AVaHOA5BIayJ5IgFcTQpmG/aXooGeYWF/Q9q3fKQEd8DcpyA==
Message-ID: <f7c713b9-7674-4b2e-82ac-01485d128c05@bootlin.com>
Date: Thu, 4 Jun 2026 23:15:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: mdio-i2c: defer RollBall bridge probe
 to PHY discovery
To: Petr Wozniak <petr.wozniak@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no, olek2@wp.pl
References: <20260604181207.17468-1-petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260604181207.17468-1-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 6/4/26 20:12, Petr Wozniak wrote:
> commit 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO
> bridge in mdio-i2c") introduced a regression: for SFP modules inserted
> before system boot, the RollBall I2C-to-MDIO bridge is not yet ready to
> respond to CMD_READ/CMD_DONE cycles when sfp_sm_add_mdio_bus() runs.
> The 200 ms probe times out, i2c_mii_probe_rollball() returns -ENODEV,
> and sfp_sm_add_mdio_bus() sets mdio_protocol = MDIO_I2C_NONE.  By the
> time sfp_sm_probe_for_phy() runs (up to ~17 s later on affected
> hardware), the bridge is fully initialized — but PHY probing is skipped
> because the protocol has already been changed to NONE.
> 
> Move the probe from i2c_mii_init_rollball() — called at bus-creation
> time — to sfp_sm_probe_for_phy() in sfp.c, where it runs after the SFP
> state machine's module initialization delays.  Export the probe function
> as mdio_i2c_probe_rollball() so sfp.c can call it.
> 
> For RTL8261BE-based modules: the probe correctly returns -ENODEV at PHY
> discovery time, causing sfp_sm_probe_for_phy() to destroy the MDIO bus
> and set MDIO_I2C_NONE — eliminating the 5+ minute PHY probe retry loop.
> 
> For genuine RollBall modules inserted before boot (e.g. FLYPRO
> SFP-10GT-CS-30M with Aquantia AQR113C): the probe now runs after
> initialization is complete and correctly returns 0 — PHY detection
> proceeds normally.

I'm not sure I'm getting it, how come the init doesn't have time to complete
for modules that are present at boot, while it works for hotplugged modules ?

I'd expect modules to take even longer to init for hotplugged modules, as they
aren't sitting in the cage during the whole linux boot.

Maxime
