Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F654A2601
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053029; cv=none; b=ovmP3JTMJLxC1CnDvjwfZk1cHdisEHDBHmiC3d7WC0/C5jbeSqQA5Do5OhTwTdgnelKMwC+Wm4qqr3DpXq+iDDgcEYTI2DOmHVomj0treUTl7wU8RVVAEl38JqGtOd5iDGolXEvaz6Fh6PXjuRq9xxxpuQ4ZeDHNBW7GwlH6RVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053029; c=relaxed/simple;
	bh=Ldo9pmXtfI4QS/WKHDQsUpM/XMQ8/GUoVg15bs4b6dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXX1pjLrfvBDrcTjFeKgy5nme2gPL+2bLbjTEi1RIcyiVQr+oHZSYtjYRZZxfAoawF+AEIpQCXprExSW9XPB/8ZXMoqYhnwTphjinUO9AS0Ii5ldG6MPP4U/ddp9k1UBoAiOlEl4PJhHgrxOuu1LzCztqa12Hif+c/X5dbyPy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wCBtnoRq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wCBtnoRq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DC077C653E5;
	Thu, 10 Sep 2026 15:10:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5CA355FA2F;
	Thu, 10 Sep 2026 15:10:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AAC911C799CC;
	Thu, 10 Sep 2026 17:09:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789053010; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DAmpgL5dNVrNQnJh+yD//pzzGZfsNROOX3umq9ugYFc=;
	b=wCBtnoRqIjXEwv87TBg6OzGvf4AYIGWYUwYDwRdo3W/063xJ94d+OSKsgMGIimBrTafcT9
	7bBe8MvW0FcdG5b/Zat/CGay4ASlLq5dbaDpkz1FsUQmLU9g1ha+8K0R12FlyZBWPOU5Em
	6yRHGT9vo/CH14PdQ/sBhKP+vh9Z2rYyHJTD/DMHu/drBC07oSHyxyDwLPxlH7nv9X9QwJ
	rDZygzKwDpm9TrjENagEJDo129nx96Aq7IsQc+052w2rtxVb50VuHrUy85q3NvXIdaw6Tl
	730yhNgMdHGw3DHwokypk7Y2f+MIG63CJLaSBVqJbhZyIOIfMc0ix2BGKaXG0g==
Message-ID: <a8b81a01-b790-47e3-85e8-c8d82cc6273b@bootlin.com>
Date: Thu, 10 Sep 2026 17:09:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] net: stmmac: selftests: Validate EEE based on the
 actual LPI timer value
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
References: <20260909074740.1247762-1-maxime.chevallier@bootlin.com>
 <20260909074740.1247762-3-maxime.chevallier@bootlin.com>
 <2f268c9ff187ba59f69d37dd4e4ba99b@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <2f268c9ff187ba59f69d37dd4e4ba99b@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/9/26 13:32, Nicolai Buchwitz wrote:
> Hi Maxime
> 
> On 9.9.2026 09:47, Maxime Chevallier wrote:
>> The EEE selftest is a 2-step test :
>>  - It validates that we enter in LPI mode with the
>>    irq_tx_path_in_lpi_mode_n counter
>>  - It then validates that we exit LPI when sending a frame, with the
>>    irq_tx_path_exit_lpi_mode_n counter.
>>
>> The current state of the test lacks 2 main things :
>>
>>  - We don't know exactly when was the previous frame sent (it's from the
>>    previous selftest)
>>
>>  - The timeout is hardcoded, while the LPI is entered after a
>>    user-configurable delay. On top of that, the timeout loop uses a
>>    pre-decrement iterator (--retries) that actually only iterate nine
>>    times, so 900ms while the default LPI value is 1 second.
>>
>> Let's therefore make it more deterministic :
>>
>>  - Send a frame at the beginning of the test
>>  - Wait for more than the lpi timer value, we timeout after about twice
>>    the value,
>>  - Then send another frame, and verify that we do go out of LPI, also
>>    with a timeout.
>>
>> Note that the test's goal isn't to validate the LPI timer value itself,
>> only that we enter/leave LPI mode.
>>
>> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> ---
>>  .../stmicro/stmmac/stmmac_selftests.c         | 33 ++++++++++++++-----
>>  1 file changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
>> index 6503678b646e..4564b9f29194 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
> 
>> [...]
> 
>> -    memcpy(initial, &priv->xstats, sizeof(*initial));
>> -
>> +    /* Send a frame, then wait to enter LPI */
>>      ret = stmmac_test_mac_loopback(priv);
>>      if (ret)
>>          goto out_free_final;
>>
>> +    max_duration = usecs_to_jiffies(2 * priv->tx_lpi_timer);
>> +
>> +    memcpy(initial, &priv->xstats, sizeof(*initial));
> 
> Is the LPI entry already counted here? AFAIU with tx-lpi-timer=0 on dwmac4 the
> MAC goes directly into LPI after the frame, before stmmac_test_mac_loopback()
> returns. The loop below would time out although LPI is working.
> 
> Snapshot before the first frame, and take a second snapshot right before
> the second loopback for the exit check?
> 
>> [...]
> 
>> +    memcpy(final, &priv->xstats, sizeof(*final));
>>      if (final->irq_tx_path_exit_lpi_mode_n <=
>>          initial->irq_tx_path_exit_lpi_mode_n) {
>>          ret = -EINVAL;
> 
> nit: -ETIMEDOUT here as well, to match the entry check?

I ended up changing my mind and following you call here, V2 is incoming,
hopefully with all the patches this time :)

Maxime

> 
> Thanks
> Nicolai

