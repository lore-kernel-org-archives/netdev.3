Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7037BE8A;
	Fri, 26 Jun 2026 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486659; cv=none; b=CiN/jTodj69j+wvuMnOr4gfOL3ucVn6FvYqZjP8zffuCRkT+HDSl8AUi+SmzNPr65D1z5TKg9BZfhKQm1gvl+nniuOJAQ2eoZHAnCsZswdRIiTTvaRv1wf+M6HJQ5gLKzM9KLj1qOZztYHLlIRT939bJZmlbs7NgxP+JaxXyom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486659; c=relaxed/simple;
	bh=EXG0HhmVZnvqVgn/dshv6gKk0n1/VKraBkkrriRbZhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I91GE1TkzV+HfpiUIqZyBMwXN0LogH3rLmDid/ORpxa60rAwrgM7s9/wptmscD7FLwtbjX6Lfqg8wdPYS7NoF/Z8Fw9BxJbz3OH1fEZWLuwSh/dTZH9j3/SHAqXWYo5jkTuNbleaCEHJ9nIx9g4CJlVh667dFo6Xn7dEe8FBSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G1h62niQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G1h62niQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BCB881A09EB;
	Fri, 26 Jun 2026 15:10:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8750960232;
	Fri, 26 Jun 2026 15:10:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5000104C976A;
	Fri, 26 Jun 2026 17:10:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782486652; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=RIDSW4QSN+EL196dH0Hkhfs2WUAzhZ9MQ1BBZjgBM6k=;
	b=G1h62niQqlh9fdwTRptlTS4dlNEaeDSca/KWRTACRbEf/8BU3A61klMmetMCWiFxjywELB
	8AL3p/XkWsIa8g7+MWFuaL8aHrRXbVdtNsTPWxrEHZx3uZiNTDhSBUDxO4PHFPOx0uUcG0
	KSDKXGC++qqDjaNzmEPK2U8nGqyh8h30Fh/Hu5Hzk5DEzO8ZaOb64Op/w05VRFlRIaW+wi
	xJoheRJKHp+ZdUuwRsHOokMQpp+bDBOQspihj5C51dc7BC5JceVRqIKTdMe3wM5s4Veo9T
	6WVdIVOdT5DKmsLUUVtBR4z1/zYVjYWtRcXbels8EDf1lilKLIobvsRv40XZrw==
Message-ID: <f729897a-c2a5-4925-9d8a-9d29569113ec@bootlin.com>
Date: Fri, 26 Jun 2026 17:10:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] net: phy: mdio-i2c: defer RollBall bridge
 probe to PHY discovery
To: Petr Wozniak <petr.wozniak@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 Bjorn Mork <bjorn@mork.no>, Aleksander Bajkowski <olek2@wp.pl>,
 Marek Behun <kabel@kernel.org>
References: <20260624084814.20972-1-petr.wozniak@gmail.com>
 <20260624084814.20972-3-petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260624084814.20972-3-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Petr,

On 6/24/26 10:48, Petr Wozniak wrote:
> commit 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO
> bridge in mdio-i2c") introduced a regression: the RollBall I2C-to-MDIO
> bridge is not yet ready to respond to CMD_READ/CMD_DONE cycles when
> sfp_sm_add_mdio_bus() runs in SFP_S_INIT.  The 200 ms probe times out,
> i2c_mii_probe_rollball() returns -ENODEV, and sfp_sm_add_mdio_bus()
> sets mdio_protocol = MDIO_I2C_NONE.  By the time sfp_sm_probe_for_phy()
> runs (up to ~17 s later on affected hardware), the bridge is fully
> initialized but PHY probing is skipped because the protocol has already
> been changed to NONE.
> 
> This affects both modules inserted before boot and hotplugged modules on
> hardware where bridge initialization exceeds the 200 ms probe window
> (confirmed: FLYPRO SFP-10GT-CS-30M with Aquantia AQR113C, hotplugged).
> 
> Move the probe from i2c_mii_init_rollball(), called at bus-creation time,
> to sfp_sm_probe_for_phy() in sfp.c, where it runs after the SFP state
> machine module initialization delays.  Export the probe function as
> mdio_i2c_probe_rollball() so sfp.c can call it.
> 
> For RTL8261BE-based modules the probe correctly returns -ENODEV at PHY
> discovery time, causing sfp_sm_probe_for_phy() to destroy the MDIO bus
> and set MDIO_I2C_NONE, eliminating the 5+ minute PHY probe retry loop.
> 
> For genuine RollBall modules (e.g. FLYPRO SFP-10GT-CS-30M with Aquantia
> AQR113C) the probe now runs after initialization is complete and
> correctly returns 0, so PHY detection proceeds normally.
> 
> Reported-by: Aleksander Bajkowski <olek2@wp.pl>
> Fixes: 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c")
> Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
I finally got time to test this with a RollBall module, and I
confirm what Aleksander says, the RollBall module's PHY doesn't
get detected even with this patch.

It does work on v7.0 though, so before the bridge probing was
introduced.

Maxime
