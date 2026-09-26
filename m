Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264737A833;
	Sat, 26 Sep 2026 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445225; cv=none; b=pEMh/rtV9xNt/QTOed8hw6l5idHoaXRzZWFS2flKZSvxf5gqFwF3Tiebuv1UETa4KbAyXZYCae+PVudfcXpj8fXF3m5Nm0nOuGZT3KBEsFsfBPtnCPe68nLVXMXw7y2GbdUm+CUBpqQkBnXwOX6cGzKsd4ux8zbRQWGDYGjiqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445225; c=relaxed/simple;
	bh=MXFr+fOiF5Ffh3T+LxIy33Fwj6GdgYR1H76vVcZJvec=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ztv3Pn9S+SVMlibSwiNXw5uK9gT0f6tyosX+O3aDWIH/zecdrgnGCC1tgGvZhTj3SeJhXE+raEkMGqtApGDPa4Bu8c1Pga1yejrFm9aVr19gPtW7Gp4okasiUR3pZkQrp/eb/nDtlRAkYtl7zNxPZKAJdk541VXxZPy6Qr4Hel4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=hgnTbjs8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="hgnTbjs8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 33919A4AA6;
	Sat, 26 Sep 2026 19:53:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790445212; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IHgaDYoTf1ik/hLoPc5mzO47voPOdPZf2/fg6ZzfKGk=;
	b=hgnTbjs8btJNiJqjiA6yimjktwQSEXcFGXxFPihrDZnlmtwvF7LH3QTmajFvfR3oVQjDER
	EbiEtL+7Om1L8cOw33N+WFbkwx8bTpXQso2ON6xmOe+ktkGu9v48qkwW2SBiso1ELhyemn
	LUmNpW++zxIfVDJzUcxYsB6YeVN9Vy0wjxgT4158BLDCZ7+xhEUzYSSa6gmCWFYozM2ujn
	us1q9Fqmnr5cM5ou1H9ChYft2f7FLiUJUVUKRV5XUlsQZ1SnAebN3EFiXZeSKnyZ8J6680
	FY4V3kehbtrcAgNkgDS49sCncXQRAl4DQH8wYUu+UmYLmkQ2KfObB5BLq35WNw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 Sep 2026 19:53:29 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: ethtool: let tsconfig reach a PHY-only
 timestamp provider
In-Reply-To: <179043085090.2160803.7251184093173489740@kernel.org>
References: <20260925135237.3432266-3-nb@tipi-net.de>
 <179043085090.2160803.7251184093173489740@kernel.org>
Message-ID: <5ee2fdb9e5303f23b2d61c06479df489@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi (Cl|S)ashiko

On 26.9.2026 15:54, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let 
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your 
> reply
> (one such reply per series is enough).
> 
> - [Medium] The removed ethnl_set_tsconfig_validate() required both
>   ndo_hwtstamp_set and ndo_hwtstamp_get.
> 
> --
> 
> net: ethtool: let tsconfig reach a PHY-only timestamp provider
> 
> This patch lets TSCONFIG_GET and TSCONFIG_SET accept a device whose
> timestamping is served by a default timestamping PHY or an already
> installed hwprov, even when the netdev has no hwtstamp NDOs. It removes
> the set_validate callback and moves the check into 
> ethnl_set_tsconfig().
> It also stops selecting a netdev source without ndo_hwtstamp_set, and
> adds a NULL check for ndo_hwtstamp_get in dev_get_hwtstamp_phylib().
> 
>> diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
>> index 6be3aa5d4bc1e..2db0e7ba8b9f5 100644
>> --- a/net/ethtool/tsconfig.c
>> +++ b/net/ethtool/tsconfig.c

> [...]

>> @@ -313,6 +305,11 @@ static int ethnl_set_tsconfig(struct 
>> ethnl_req_info *req_base,
>>  	if (!netif_device_present(dev))
>>  		return -ENODEV;
>> 
>> +	if (!dev->netdev_ops->ndo_hwtstamp_set &&
>> +	    !phy_is_default_hwtstamp(dev->phydev) &&
>> +	    !netdev_ops_lock_dereference(dev->hwprov, dev))
>> +		return -EOPNOTSUPP;
>> +
> 
> [Severity: Medium]
> 
> The removed ethnl_set_tsconfig_validate() required both 
> ndo_hwtstamp_set
> and ndo_hwtstamp_get. This new check in ethnl_set_tsconfig() only tests
> ndo_hwtstamp_set. The matching check in tsconfig_prepare_data() only
> tests ndo_hwtstamp_get.
> 
> What happens on a netdev that has ndo_hwtstamp_set but no
> ndo_hwtstamp_get, and has neither a default timestamping PHY nor a
> hwprov?

There is no in-tree driver with ndo_hwtstamp_set but not _get. All 73 
files
have them in pairs...

Even further, the asymmetry is on purpose. The get side tests 
ndo_hwtstamp_get
and the set side tests ndo_hwtstamp_set, each gate testing what its own 
operation
needs.

If anyone insists on the symmetry, a v4 could add || !ndo_hwtstamp_get. 
But before
I respin again, let's hear if this is really needed.

> [...]

Thanks,
Nicolai
