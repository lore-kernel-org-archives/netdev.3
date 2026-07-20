Received: from shout01.mail.de (shout01.mail.de [62.201.172.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F4342CB4;
	Mon, 20 Jul 2026 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546672; cv=none; b=tiUKIRyXsATxsXCY+u5Ik6n3r4Lb2VTsGXiuBgAtJvpc2o6Zly9xncT9nn0kyZ1fxAXTvDWmTHmRdzcrM1uply2eC9Amj/28akOJ0x1B6j/C1VBFKuDpVU1Jecn8jyKXI3knipp2KufuGOC1m3DDV6BawbQYd7A+IcLwzIDkBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546672; c=relaxed/simple;
	bh=7W8Be4Q+aMUMH8sP5FmymS0/HjtVRdtikJu+5xOVoqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2hAeDIAgmu/hwfX6I+cyC2lJynPUzcoO0TV4KVJajki5kCAIXJrYOamf1z3prwTck3vNOGc5YdneqDu9fhKqVleHWRsutboIEwGuDH9qpPClkDkvewVWazaFJmakvIPZxMYAIZxx6kocLtj8q3nFJT0LAxU93ibs67t6NeW3No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=qBQyp9dO; arc=none smtp.client-ip=62.201.172.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="qBQyp9dO"
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout01.mail.de (Postfix) with ESMTP id 203C02407D7;
	Mon, 20 Jul 2026 13:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1784546664;
	bh=7W8Be4Q+aMUMH8sP5FmymS0/HjtVRdtikJu+5xOVoqs=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=qBQyp9dOT81x/mh7BONt6JyJMtF3kl/BzkEoN+sUFYIUN06rCN0mHwcKSy4mNb/sy
	 xbqpSZfr1SvSFD7RKjdQXnMzCn6VsXy1qRe1i6H07t/SZ5iVTCqlPYH9GvEYUFCgI/
	 110tolbNIfLQV0tOluTUNb44z1KlTTRGNPtJnRPAY7z4dJJkvxWzgcdd2jHLB6xusn
	 LG148hRs6X8vFVvOW8uUphYXQjYFH/VHXk+ZU8Byu6GK65dZbPGN8lXamfeSUOXUgX
	 p4RTWHsenuahnT8Td/cyKDaaWOMxORjIZMht/fZNlaCXhQWPdfr+0onxThkSq7UGbG
	 XyLH4DchkSUpA==
Received: from smtp01.mail.de (smtp03.bt.mail.de [10.0.121.213])
	by postfix01.mail.de (Postfix) with ESMTP id ED54F2400B7;
	Mon, 20 Jul 2026 13:24:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id C49C6240A4A;
	Mon, 20 Jul 2026 13:24:22 +0200 (CEST)
Message-ID: <f141897b-6570-4a80-95bf-a8efd9d25785@mail.de>
Date: Mon, 20 Jul 2026 13:24:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: stmmac: dwmac4: mask interrupts before stopping DMA
 in suspend
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Rohan G Thomas <rohan.g.thomas@altera.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <20260718152802.83553-1-luis.la@mail.de>
 <5cc0d788-c78d-40f2-998f-235d40f567f2@bootlin.com>
Content-Language: en-US
From: "luis.la@mail.de" <luis.la@mail.de>
In-Reply-To: <5cc0d788-c78d-40f2-998f-235d40f567f2@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1194
X-purgate-ID: 154282::1784546663-A86FBC36-B0B68247/0/0

Hi Maxime,
> This is almost perfect for a new submission, only 2 things to improve :
> 
>  - you're missing the tree name in the patch subject. As this is a fix, it should be :
> 
>    [PATCH net] net: stmmac: dwmac4: mask interrupts before stopping DMA in suspend
> 
>    you can find instructions for this in the doc Andrew linked :
> 
>    https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
>  - When submitting a patch, do so in a dedicated thread, and not in reply to
>    other threads.
> 
> You should send a V2 addressing the tree name in the patch subject.

Thanks for the feedback, I addressed these changes and sent a v2 patch.

> Sashiko noted something on the patch :
> 
>   https://sashiko.dev/#/patchset/20260718152802.83553-1-luis.la%40mail.de
> 
> It looks to me that sashiko is just wrong there though, I can't make sense
> of what it is saying.

This seems to be because strictly speaking the title of the commit was wrong,
the interrupts don't get deactivated before stopping dma.
I changed it, but only read after that it is discouraged to change the Subject, sorry...
I hope the patch now meets the requirements,
Luis

