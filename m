Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD03B05BB
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337719; cv=none; b=i2MPyUgV0GQJ0IAliKi6yqKUwe7sGF/fZMWhgLxMozdqm+q2MvDw1Vx1pj59uQdnrRU+w1S27i3t5ocHJvZ1lmR4TBQWn02ynQIRuq4ZIrEXqmDPU9keD/55rtFaHOsEBCznr3OfjppKlAzNzeQsw/JG1tt/6ZPtHyCk9CmG0sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337719; c=relaxed/simple;
	bh=4EjahhFFPHHEI9xCTkc3CbQvF3cBzffgusdMVoeHEBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHEfxJjbtGmmiTDQuKmAGdpuIzU0wV0XguaCxuGR43iROWNCEcJJB22TscIcJyq3Jba5BWsPjgaQWhuJzyvIyiXPkb32LIxwWVDzaXci9/Xd5qxT8e+z+HuRNH3upTuTqpfiKEMh+YkFRaw274cXqMS2JRb2JBkwcQ5lF+kw6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hEYICALn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hEYICALn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D02674E40FD7;
	Wed, 29 Jul 2026 15:08:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 84BDC6039A;
	Wed, 29 Jul 2026 15:08:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A05C211C14FB5;
	Wed, 29 Jul 2026 17:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785337709; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=J1Vg6BlOZ9ZGipKyOXTO4yGk1nIk6WX8XUetJBU5miM=;
	b=hEYICALnesdXVzcVYgnzSxl3wLM6zu0i8AACNW1rRLecEaH/SvGzI5ZOeuECX3qbWixjc+
	2QLlxf6FlOq/yn00vJ30eGejmWV092BjFwaf2u1JaZmkcEbVeB+7XkaQnfRVsu3wru0H2j
	UnlnyT3F1iSGn4iPpZWobyJZ5+p1xysX8yW1GnF3DVATb10GDHhl6yjqFmTkAgnO6o7P++
	W/DB43IUEyyEtuAP59cQ9X3qhL10Aj8ZO5mM0XB2XernAFEZ3QSqsyNquZQ5/IFHi0jFZP
	kBdqhXI+whrE1y4lSO58ntGXzAMrrZdxYJum87IX1yPGo6L/zmCUEeSgUBlIzA==
Message-ID: <fe1b129c-0a9a-4874-a7f9-9b277678a159@bootlin.com>
Date: Wed, 29 Jul 2026 17:08:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net: stmmac: Remove VLAN perfect matching dead
 code
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "mcoquelin.stm32@gmail.com"
 <mcoquelin.stm32@gmail.com>,
 "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
 "joabreu@synopsys.com" <joabreu@synopsys.com>,
 "jun.ann.lai@intel.com" <jun.ann.lai@intel.com>,
 "yi.fang.gan@intel.com" <yi.fang.gan@intel.com>,
 "boon.khai.ng@altera.com" <boon.khai.ng@altera.com>,
 "matthew.gerlach@altera.com" <matthew.gerlach@altera.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
 <20260729095110.164157-2-ovidiu.panait.rb@renesas.com>
 <dfe9ee00-6a8a-418d-9440-339631b31e52@bootlin.com>
 <OSCPR01MB12769620094BA8C4DFA8DE361D3CA2@OSCPR01MB12769.jpnprd01.prod.outlook.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <OSCPR01MB12769620094BA8C4DFA8DE361D3CA2@OSCPR01MB12769.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/29/26 17:02, Ovidiu Panait wrote:
> Hi Maxime,
> 
>>
>> Hi Ovidiu,
>>
>> On 7/29/26 11:51, Ovidiu Panait wrote:
>>> stmmac_vlan_update() falls back to "perfect matching" when the VLAN hash
>>> filter is unavailable (!priv->dma_cap.vlhash). This fallback has been
>>> unreachable in normal operation since its introduction in
>>> commit c7ab0b8088d7 ("net: stmmac: Fallback to VLAN Perfect filtering if
>>> HASH is not available") because the NETIF_F_HW_VLAN_{CTAG,STAG}_FILTER
>>> features are advertised only when priv->dma_cap.vlhash is true.
>>>
>>> The fallback is also duplicating the code in vlan_add_hw_rx_fltr(),
>> which
>>> is always available since stmmac_get_num_vlan() returns at least 1.
>>
>> It's not exactly dead code, there's an stmmac selftest for that, see :
>>
>> https://elixir.bootlin.com/linux/v7.2-
>> rc4/source/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c#L973
>>
>> It does exactly what you say, it fakes the fact that we don't support
>> vlhash,
>> then exercise the perfect matching path.
>>
>> But is it correct to drop that feature altogether ? Or should we just
>> relax the conditions for NETIF_F_HW_VLAN_{CTAG,STAG}_FILTER to be
>> advertised ?
>>
> 
> We are not dropping the perfect matching feature by removing this code.
> Basically, there are two perfect matching code paths that duplicate the
> same logic and which diverged over time:
> 
> - vlan_update_hash() has the "if (perfect_match)" path that has never run on real
>   hardware (unless running the selftest) because NETIF_F_HW_VLAN_{CTAG,STAG}_FILTER
>   is only advertised if the core supports VLAN hash filtering.
> 
> - vlan_add_hw_rx_fltr() also has a perfect matching codepath, which calls into
>   vlan_write_single(). This runs unconditionally and overwrites what
>   vlan_update_hash() did anyway, as it runs after stmmac_vlan_update():
> 
> stmmac_vlan_rx_add_vid():
> ...
> 	ret = stmmac_vlan_update(priv, num_double_vlans);
> 	if (ret) {
> 		clear_bit(vid, priv->active_vlans);
> 		goto err_pm_put;
> 	}
> 
> 	if (priv->hw->num_vlan) {
> 		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
> 		if (ret) {
> 			clear_bit(vid, priv->active_vlans);
> 			stmmac_vlan_update(priv, priv->num_double_vlans);
> 			goto err_pm_put;
> 		}
> 	}
> 
> This path is also more correct because it takes into account cores that support
> extended VLAN filters.
> 
> Therefore, I think removing the perfect matching code in vlan_update_hash() is
> the right choice here.

OK makes sense. Then the sensible followup (not necessarily for -net) would be to
update the selftests, as there's no point messing with the vlhash cap then, if I'm
getting this right.

Thanks :)

Maxime
