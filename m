Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B5C37BE9C;
	Thu, 10 Sep 2026 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073577; cv=none; b=eeMGENVxtLaab8MuPaoxw8lPqScAXdKA4zEMB2SzPQLOoACTWzBDRubDAtaCLdDVT4sXysDItKMvx5CHugiTjsLX+j5YkEwGhP/pHJfnla2S+kcBn2iuer6fjsB9iRVJef0aK7rIu4RYp8NrdPGnxDbjQu3V1P/eA7/UPT4uxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073577; c=relaxed/simple;
	bh=T+RLxEAh4h/uBxHwW1aDtU4HjzZWwORy7CE6XPL1anc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ctzn6YL53JNhx+zmcS0OTM0DQT5SAoIHXGKUggYoLFJzsMcUhhpgIxjXeqHBq7S/kVOP80R4YjvZMAYOLu5Vmn2NhPyJnN61UgCpysBf6RAqCXKSO0Nh0ctqyuzqlKXnbVS2dJtVdbcpV+/jcKdimoYTZG1JsJjEJ0pkY7KNlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YWJQ4XhA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YWJQ4XhA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B10E91A0125;
	Thu, 10 Sep 2026 20:52:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3E0685FC38;
	Thu, 10 Sep 2026 20:52:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B70E811C78B21;
	Thu, 10 Sep 2026 22:52:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789073565; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xmpBs3Sc2Rd3g3al60wsjbWjXR4zflzMIihvsD8kR+8=;
	b=YWJQ4XhALSRdp3ZCacqDTDWT1MXlCqIWaNVKZtMf8wNwnsvCs0w64wzfl+Fd1GM/5jLMCo
	zqf4YS6yVu7f44qgkulGPy0ZarkECYFmGeh5o4U7Ob7PCYgC9rheSM6TnSB/ws+u8B7iRG
	RB7TBdoaHjWyMDI5wulzm3wbfkU7NYM1LNZlPMuljsBBNNnT9L6RfPQt+CkZV/mwHbZKaI
	8iGy22dKG0r5b0cs711QIyEQ0JSKP59BkQkvuabwI5bseQtlzW0FTPWmYsXnL1/C/eifUO
	ZxEf/S9VyBPIUZ+OE+CkPsTJqOC0LX9RWA3H+6baBRmJwwPPiQw8RzYP1S+xvg==
Message-ID: <d62d2894-cec1-4538-b57a-cb228d89495d@bootlin.com>
Date: Thu, 10 Sep 2026 22:52:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/6] net: stmmac: selftests: Validate EEE based on
 the actual LPI timer value
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de,
 David Laight <david.laight.linux@gmail.com>
References: <20260910151404.976753-1-maxime.chevallier@bootlin.com>
 <20260910151404.976753-3-maxime.chevallier@bootlin.com>
 <6af83ee5b9ddeeebcc6e4cc29989b856@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <6af83ee5b9ddeeebcc6e4cc29989b856@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Nicolai,

On 9/10/26 20:50, Nicolai Buchwitz wrote:

>> +    max_duration = usecs_to_jiffies(2 * priv->tx_lpi_timer);
> 
> tx_lpi_timer comes direct from ethtool as an unvalidated u32. So if a (arguable privileged
> user) does 'ethtool --set-eee eth0 tx-lpi-timer 1000000000', the code will sleep ~2000 seconds
> under rtnl_lock. Tge old code capped it at 900 ms regardless of the timer.
> 
> Thus I think we should clamp it at some sane value. Feel free to keep my R-b with the clamp.

I was wondering if 802.3 said anything about the LPI timer value, but
Clause 78 says :

  78.1.2.1.3 When generated

  Specification of the time when this primitive is generated by the LPI
  client is out of the scope of this standard.

I'll clamp that as a safety precaution.

As a side-note, there are other limitations, that apply to both eee
and flow control. Even though we're in MAC loopback mode, the link
MUST be up for the selftests to run, and both EEE and Pause are
affected by the autoneg results, and this will affect the selftest
outcome.

I'll address that in another series though, but I'll send a V3 for the
clamping still :)

Thanks for taking a look,

Maxime

