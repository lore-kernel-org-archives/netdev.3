Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05F23A99F
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445807; cv=none; b=ZublrwthnPURhyuTpj7e8sMO2VX+zpJFg/bRBtcMLDC43FwhIagYoRaYLcEol34xS+afXz7ZZuic+VQh3KvDfo8EYpIHClWIbuQrmxECshfl1JEnwZnPGXNn4ApiCnHDU6jfTCmGMWwtcyO9HEo9CErVUFOV+IHMCYJOIMtF5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445807; c=relaxed/simple;
	bh=/fN6v7s/2DMzMfOOebxiqtenShDEcVAznAC+gi5VXdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AexXOsa7hDuPF4/gY2CE20jHyAhsOBRczSQUBsZVJxxQ5gM/USmJML8WrsFhA1p9WX08buAmsZ+SjCSXAbTs47yhsbmQcOcZ9j/CuV0i2a+n9Ldus/uE9aKiL7nkslYoh6MmA5seDgnU6HMHDlnocp1aru1o608O/dTtjaR34fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JT4N0nQe; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JT4N0nQe"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4DEB84E4106B;
	Sat, 26 Sep 2026 18:03:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1153860749;
	Sat, 26 Sep 2026 18:03:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47FAF102F1E44;
	Sat, 26 Sep 2026 20:03:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790445799; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7wqWo6d2hoyTR3HXYt29yOqJzvILVhwYEixBLkEwFTw=;
	b=JT4N0nQeEv/BW+V5n4nDtHLXhmivbbaO2uIzJv5//eicL9pePAwXJdKNWG1s4KsBOi9PjH
	RTxePoj2rc7W/jKGwoLAIcEYI6ud3MKeWM+34BVsw7blcGtyqzVZMWAL1pqWIb8xt7yyS7
	5m/s4cstfj/vRH+15dJXd9KX/LPda7TZNl4glLZCUwEkZiH6JxDpy3j5iZ40ezWGRTkwSm
	gxntcLwhXJoPZe95FPCvoh3u0FYNU/+ovGiKL48Hl+4nxK/620I/k5aLrFgKFh2HTLnBka
	WUQn50+oT3mELzGEhcHKgWpoMe8ziTuqf6faGN4JtKJUEpqr+w1EQeT8UFwvzA==
Message-ID: <8100d62f-7615-4129-a633-7f4c7404a0e2@bootlin.com>
Date: Sat, 26 Sep 2026 20:03:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: ethtool: let tsconfig reach a PHY-only
 timestamp provider
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260925135237.3432266-3-nb@tipi-net.de>
 <179043085090.2160803.7251184093173489740@kernel.org>
 <5ee2fdb9e5303f23b2d61c06479df489@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <5ee2fdb9e5303f23b2d61c06479df489@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/26/26 19:53, Nicolai Buchwitz wrote:
> Hi (Cl|S)ashiko
> 
> On 26.9.2026 15:54, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [Medium] The removed ethnl_set_tsconfig_validate() required both
>>   ndo_hwtstamp_set and ndo_hwtstamp_get.
>>
>> -- 
>>
>> net: ethtool: let tsconfig reach a PHY-only timestamp provider
>>
>> This patch lets TSCONFIG_GET and TSCONFIG_SET accept a device whose
>> timestamping is served by a default timestamping PHY or an already
>> installed hwprov, even when the netdev has no hwtstamp NDOs. It removes
>> the set_validate callback and moves the check into ethnl_set_tsconfig().
>> It also stops selecting a netdev source without ndo_hwtstamp_set, and
>> adds a NULL check for ndo_hwtstamp_get in dev_get_hwtstamp_phylib().
>>
>>> diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
>>> index 6be3aa5d4bc1e..2db0e7ba8b9f5 100644
>>> --- a/net/ethtool/tsconfig.c
>>> +++ b/net/ethtool/tsconfig.c
> 
>> [...]
> 
>>> @@ -313,6 +305,11 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
>>>      if (!netif_device_present(dev))
>>>          return -ENODEV;
>>>
>>> +    if (!dev->netdev_ops->ndo_hwtstamp_set &&
>>> +        !phy_is_default_hwtstamp(dev->phydev) &&
>>> +        !netdev_ops_lock_dereference(dev->hwprov, dev))
>>> +        return -EOPNOTSUPP;
>>> +
>>
>> [Severity: Medium]
>>
>> The removed ethnl_set_tsconfig_validate() required both ndo_hwtstamp_set
>> and ndo_hwtstamp_get. This new check in ethnl_set_tsconfig() only tests
>> ndo_hwtstamp_set. The matching check in tsconfig_prepare_data() only
>> tests ndo_hwtstamp_get.
>>
>> What happens on a netdev that has ndo_hwtstamp_set but no
>> ndo_hwtstamp_get, and has neither a default timestamping PHY nor a
>> hwprov?
> 
> There is no in-tree driver with ndo_hwtstamp_set but not _get. All 73 files
> have them in pairs...
> 
> Even further, the asymmetry is on purpose. The get side tests ndo_hwtstamp_get
> and the set side tests ndo_hwtstamp_set, each gate testing what its own operation
> needs.
> 
> If anyone insists on the symmetry, a v4 could add || !ndo_hwtstamp_get. But before
> I respin again, let's hear if this is really needed.

The current way LGTM :)

BTW, I raised that point a while ago [1] but now that you're properly handling
the "MAC can't TS, but PHY can" case, we may be able to get rid of the
SIOCSHWTSTAMP code in phy_mii_ioctl() ? as a followup of course :)

Maxime

[1] : https://lore.kernel.org/netdev/20260718143848.677531-1-maxime.chevallier@bootlin.com/
> 
>> [...]
> 
> Thanks,
> Nicolai

