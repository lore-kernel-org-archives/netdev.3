Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526A49C4C9;
	Wed,  9 Sep 2026 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954042; cv=none; b=aSoVhmZuhhmzhDpxoDh2umDKtzzN45ReZpK9Cg8Hyw3op9OyTHU5HOW7H5ddnjkDYUeimqFmNcNHQSH6b4Qvwdz4YJRJwPdu9tj1A7qmqWeSZy4r+f3Q229GT4McEriy8ZkBpbHjAOnY90yWCMSEyQpEO+mFIbePkt7qO75HCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954042; c=relaxed/simple;
	bh=xAVlZfZLEGbbU40oKhZEA91vYjEhKBfMFqfjt71fBA8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B/j+QdiI7yewKnJDPX4FcslphIivNq9k1TfHH2uZILXl1VJBC2hIjEOSieVOURnhlXh2J82XRRUbszc+48DK61nK9xm/xtoe/hxsDD6N0Jrdk3SZfxs5Sgg0kC0hALF1HWvgY2re+wySFKZdNQ809mQZDvuYegYG8HEwq8InbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=UCW0sfqp; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="UCW0sfqp"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D256BA02CD;
	Wed,  9 Sep 2026 13:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1788954033; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=u+hfF2sligk2pwLDscB0b7RdHNzp0oqc/go4KSuevLo=;
	b=UCW0sfqp9M2+I6GheTSOUVlXhz+8HvA77Q3R5znvsRFr5T+rMkBPerLtb/QUunGzJh93x3
	icEZ6K37filKerQX9eo+PBClihzkMjr4e1GJ4+7srhnNRUFhyhQsx2V9sBNGrU+dFYNe4a
	y+4Gr5XiTzmVsmxdaraRy3ZP/S4xwABUTrYccl7YIAu0nCkKu7YRffil8OCzMVjUxnnVL4
	+dw+rJwdsWBGGZT2yg9+XwS2XmMARNp5+Gvvs5vwgJf0rioIMgihiDPxTpapzvD3IvZ6+f
	iDcDPp6CBzR2JAfZmvYJ0gG5+c4zN+kR74AxT9ss8xsgrHTKZS0lFh+8dkx/0w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 09 Sep 2026 13:40:26 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Emil Renner Berthing
 <kernel@esmil.dk>, Minda Chen <minda.chen@starfivetech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jan Petrous <jan.petrous@oss.nxp.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Jose.Abreu@synopsys.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de, David Laight
 <david.laight.linux@gmail.com>
Subject: Re: [PATCH net 2/6] net: stmmac: selftests: Validate EEE based on the
 actual LPI timer value
In-Reply-To: <20260909074740.1247762-3-maxime.chevallier@bootlin.com>
References: <20260909074740.1247762-1-maxime.chevallier@bootlin.com>
 <20260909074740.1247762-3-maxime.chevallier@bootlin.com>
Message-ID: <00bfad8f52784677c6042ccd6c3fd6ed@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9.9.2026 09:47, Maxime Chevallier wrote:
> The EEE selftest is a 2-step test :
>  - It validates that we enter in LPI mode with the
>    irq_tx_path_in_lpi_mode_n counter
>  - It then validates that we exit LPI when sending a frame, with the
>    irq_tx_path_exit_lpi_mode_n counter.
> 
> The current state of the test lacks 2 main things :
> 
>  - We don't know exactly when was the previous frame sent (it's from 
> the
>    previous selftest)
> 
>  - The timeout is hardcoded, while the LPI is entered after a
>    user-configurable delay. On top of that, the timeout loop uses a
>    pre-decrement iterator (--retries) that actually only iterate nine
>    times, so 900ms while the default LPI value is 1 second.
> 
> Let's therefore make it more deterministic :
> 
>  - Send a frame at the beginning of the test
>  - Wait for more than the lpi timer value, we timeout after about twice
>    the value,
>  - Then send another frame, and verify that we do go out of LPI, also
>    with a timeout.
> 
> Note that the test's goal isn't to validate the LPI timer value itself,
> only that we enter/leave LPI mode.
> 
> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

> [...]

Forget to mention in my last comment:
The series seems to be broken. I can't find patch 3 and also the cover
letter is missing on lore and my inbox?

Nicolai
