Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912134DCC7
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790451485; cv=none; b=GAzX8+BCrHrWS2jDWBfJeCb08gyez1T2JgBZ0vG9wtKhERLY9Q0X2tbTVnAHJ8vIgjI57k2AlYRXoPWHrD5GKfNzZX/Y/IVb3oQ0oR1sV4J5Z/RwZeBQggX79Qk7p4YvCvSaF3kXztZ2umw2wFDyJ9mLDF2kSkdpJ04kUVlZwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790451485; c=relaxed/simple;
	bh=oOHfhi247zMtuLyK1q4PKkchbGpzpT8eojBKkcJnM6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioFbKTrhZ+D6POTO/TEubp4O5v5pNwoza7vUFekrSUGw3EhDpuf2mt8l3Zg4lgV0KGfdCpnnjqKmTu871v/hvctjw675L1EO3JWC7OjVrsE674MNJXgcvR/U2I/sxb0IpbjTHHK0akgN1TBa8uAq5AMm78I5CmYxeQ7Pxd7ftUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R62xE1mT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R62xE1mT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C58EF1A0D4D;
	Sat, 26 Sep 2026 19:37:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8F51860749;
	Sat, 26 Sep 2026 19:37:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4A73102F1E4C;
	Sat, 26 Sep 2026 21:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790451477; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LYe49kOMn0vSPqjYDLCxciDWRAv8kzL3j3Sod1atpTY=;
	b=R62xE1mTaQxatCb33DR/HwgfJGSTvghkJi850RfagXCdxe6q46ez5v2SX72SXW4yBSE4l9
	rS1AGxMot7mXdZ6ZiC0HGfcyLmdjqBYB3gCnBNj7XTrhmmwpAuwTZQhhX2VYlEVCWSP6fy
	bSXQ0pHL2S2TtsU/oEmWEJ3N4CLe2YTORmjsGbJzfMZ53ie3vSfXpObeIcWob32y/adB02
	+JDblpk8pw4wnFDkKML0eBbTOnVHhCSE4H1QcuKH/ZZX1myiGgTIq7Ve091r2xE0AUOqn6
	xoVQjWJs5rEmiBEJJIWA8uQO9/v3DZIMxlEq4A4N0rFlfGssXUgN2HTbsD0QkA==
Message-ID: <3bcac28b-71ce-4c08-97a2-4cd59ab76c8c@bootlin.com>
Date: Sat, 26 Sep 2026 21:37:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: Don't set or get RSS parameters when not
 supported
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>,
 Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>,
 thomas.petazzoni@bootlin.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260926093343.292181-1-maxime.chevallier@bootlin.com>
 <250ecb58e80b191865bcf03f7146f7c2@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <250ecb58e80b191865bcf03f7146f7c2@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Nicolai,

On 9/26/26 20:41, Nicolai Buchwitz wrote:
> Hi Maxime
> 
> On 26.9.2026 11:33, Maxime Chevallier wrote:
>> The RSS kselftests fail on stmmac, and this is partly due to the driver
>> reporting bogus data for the RSS ops :
>>
>>  - ethtool -x reports an indirection table and a key while the hardware
>>    doesn't have any of that
>>  - ethtool -X fails with -EINVAL.
>>
>> Let's return early in the rss ops if we know the hardware and platform
>> don't support RSS.
>>
>> Note that RSS is currently not supported on any devices upstream, so
>> code that was already useless is now effectively dead. It has been the
>> case since 2019 when the code was added, as platforms need to set rss_en
>> in their plat data, and no glue ever did that.
>>
>> Russell King ran a poll in february 2026 [1] asking if the code should
>> be dropped, without any reply going in either direction.
>>
>> Jitendra Vegiraju from Broadcom sent 9 iterations of a Broadcom PCIe glue
>> driver [2] that actually sets rss_en = 1, so there's some hope that this
>> may be used in the future.
>>
>> [1] : https://lore.kernel.org/netdev/aYd4BkAeNW6d0iIC@shell.armlinux.org.uk/
>> [2] : https://lore.kernel.org/netdev/20260402213629.1996133-1-jitendra.vegiraju@broadcom.com/
>>
>> Fixes: 76067459c686 ("net: stmmac: Implement RSS and enable it in XGMAC core")
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> ---
>> Jitendra, do you have plans to continue iterating on the BCM8958x glue ?
>>
>> Thanks,
>>
>> Maxime
>>
>>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> index 1be5310ca766..4e917a448271 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
>> @@ -927,6 +927,9 @@ static u32 stmmac_get_rxfh_key_size(struct net_device *dev)
>>  {
>>      struct stmmac_priv *priv = netdev_priv(dev);
>>
>> +    if (!priv->dma_cap.rssen || !priv->plat->rss_en)
> 
> Should this pattern become a helper? Counting 6 instances so far.

yeah why not :)

> 
>> +        return 0;
>> +
>>      return sizeof(priv->rss.key);
>>  }
>>
>> @@ -934,6 +937,9 @@ static u32 stmmac_get_rxfh_indir_size(struct net_device *dev)
>>  {
>>      struct stmmac_priv *priv = netdev_priv(dev);
>>
>> +    if (!priv->dma_cap.rssen || !priv->plat->rss_en)
>> +        return 0;
>> +
>>      return ARRAY_SIZE(priv->rss.table);
>>  }
>>
>> @@ -943,6 +949,9 @@ static int stmmac_get_rxfh(struct net_device *dev,
>>      struct stmmac_priv *priv = netdev_priv(dev);
>>      int i;
>>
>> +    if (!priv->dma_cap.rssen || !priv->plat->rss_en)
>> +        return -EOPNOTSUPP;
> 
> Not a blocker, but a full netlink RSS dump (like the one in rss_ctx.py)
> now stops at this device. Naybe rss_dump_one_dev() should skip -EOPNOTSUPP
> like ethnl_default_dumpit() does?
there are other drivers that report -EOPNOTSUPP, we could have that as
a separate patch yeah

Thanks for looking at this,

Maxime

