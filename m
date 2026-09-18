Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE754347BA7
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735548; cv=none; b=ldiEeF0YkmNgwn0lg+rcXXbdSNNIwlPKNChAT9hy7yvrrIOlL/UpHJ5mNtMHnNFFISt9zv1egYtnxEe5K6sblPFwdUb2y14sAbnxU8oBX3ad0+K2z36CqXmS/0g8mycpZLS3GGLpBn/jFc+MCenGh9c3a/qA2VhKNr26DHR5ans=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735548; c=relaxed/simple;
	bh=iWjO1eSo+3/EJWsO63nQhJLs5VsBn4+/GTQ15xaFdP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sb+Gjhq8wkviEkYpU11cCYp8GdsjHDLdxSeCVt0bP0BIv0lyyTaTFHLvV4I+Stw+MIRnPe2dOAMOWTZZHOpON6Ifk/+a/i+QWLEapYWsRJvbO/LwwbMsB1eKfzqAveIge5Jd9U8TXu/GGuHEKOrJ4nbwIxjhibrUzHsI4MLNFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=meBchw49; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="meBchw49"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A669B4E40880;
	Fri, 18 Sep 2026 12:45:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6718860649;
	Fri, 18 Sep 2026 12:45:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8411110328E57;
	Fri, 18 Sep 2026 14:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789735534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wDnz042JhVx8TouMwH/GponpahIwHIiyB0UKPpUXJhA=;
	b=meBchw49EU3xYhJ2R+QquSCXhUZhoes8nlbjSzVB+TRW9BDqkMcAIzkt7zkR3aylnWG62l
	oePWdC51PtWnOwkOOT8oKe57qmJqDqkCKcZh528nSwchgU4a8YN4KI+v+/JmMuRpuaDwPy
	E2r7s5g5hDvOYsl+iapbu9v1lF+xdb9ErqBX4CrqhfkKQH+TtYM2XQSEhq54G//LXFFr/O
	t+R7rRJf11mzaF2Pd0I7175KWvgQYWbm3xYThqxJl4PnVbbmJWKepTfvr+4AQuuZbPUD+p
	nRhotCmyam8ZPHAby10qIsjAKFO09pGUbrxmrdI788XtveRAHzOLobph5sYUFQ==
Message-ID: <fd937877-306e-48c1-8b14-e8dc62986420@bootlin.com>
Date: Fri, 18 Sep 2026 14:45:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 5/7] net: stmmac: dwmac4: Use the correct bufzise
 when the len is exactly 8K
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
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
 <20260917215339.2022523-6-maxime.chevallier@bootlin.com>
 <4b3c26c482ac1d26f39b53fea072e4d1@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <4b3c26c482ac1d26f39b53fea072e4d1@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/18/26 14:25, Nicolai Buchwitz wrote:
> Hi Maxime
> 
> On 17.9.2026 23:53, Maxime Chevallier wrote:
>> DMA bufsize selection isn't made on the MTU but the actual frame length,
>> so including the L2 header. On DWMAC4, if the len is exactly BUF_SIZE_8KiB,
>> the next larger size is incorrectly selected.
>>
>> Lets fix the comparison and while at it, rename the parameter from len
>> to mtu.
> 
> Isn't it "[...] from mtu to len"?

:(

Bah, if respin is required I'll fix this

>>
>> Fixes: c3efed5ad1b0 ("net: stmmac: Enable dwmac4 jumbo frame more than 8KiB").
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 4 ++--
>>  drivers/net/ethernet/stmicro/stmmac/hwif.h         | 2 +-
>>  drivers/net/ethernet/stmicro/stmmac/ring_mode.c    | 4 ++--
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> index 2994df41ec2c..c6a8f8d73501 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
>> @@ -474,11 +474,11 @@ static void dwmac4_set_sarc(struct dma_desc *p, u32 sarc_type)
>>                        sarc_type));
>>  }
>>
>> -static int set_16kib_bfsize(int mtu)
>> +static int set_16kib_bfsize(int len)
>>  {
>>      int ret = 0;
>>
>> -    if (unlikely(mtu >= BUF_SIZE_8KiB))
>> +    if (unlikely(len > BUF_SIZE_8KiB))
> 
> Should we drop set_16kib_bfsize() instead?
> 
> After 6/7 it looks to me like the same test as the first branch of
> stmmac_set_bfsize(). The caller ends up there anyway when it returns 0
> and chain_mode_ops doesn't have it at all.

True yeah :) however maybe we can wait for this to be merged and have the
cleanup in net-next ?

Sashiko is getting crazy with the "pre-existing issues" everytime we touch
stmmac, cleanups are long overdue and this could be included in there :(

Maxime


