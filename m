Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299604;
	b=47PG+Z8T2TYU5WCWW8X86ESjWcTy1ZL44I8lWDlLcT3eo/IKB65HY1ZIbW5+xmr3laZF
	 EzOgeuPyMKV2RKr50xhN179hTBEgKpiuKwnELaJfkZFyeKHrCaz4bIxxGk2PATgxpInJ7
	 OkAlTpStz4J+fqdT8LaWuRDauOYcB/1gw+uvyW7gKjDOZ0+eezEWrsWBQHURBtyYOpKC9
	 S69FMm+XKsWUKhgjLqGo+gecEyqoLbNvde1vvPnNA02xWGprlE9GyxH0GxlaT2yI8WSqS
	 emfy9zjovV0HLM8Dt8OW48GctYEplP9QPyNlb2RbuO9Wx6LIcP5LBvzn4dFfzfzWVjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299604;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=S1sqnnCjlRyaPfFD2qC02MEhZfl6DMtUczd0Q0Ki+2I=;
	b=TA1ayhjV5PHAEITQNh7daf9ENM1lH0ft23IcuE1VY77L6iKa7kQvgG7tx4EK11VnrVmH
	 uqUXbIO1xog4ZSPNLZXBB1kjAVw5ji7cO5lJKxqmkuOe0Qs/ylhxdMgnTNyi5xEw9CaLC
	 QsHfjRJG6MsAt8cNzHis9gws0YcKlxC34aQzQvx17lcCBwP1RK4hDLMC8pxRB7byfSAZR
	 L9l21mHNTnAlMzAR55zboVCkJPVv6YfaLkWFXnicOTjunX6HUDxMNC7mssZjDGau8nvoi
	 5gIrNKrzaBAoajZFY09YJhOGYO9ecnafLLBmw4j2pYkuIX4h0ByOyf/6i8qTpm3+eYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b="K+31T/Z0";
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA64606A31A;
	Thu, 29 Oct 2026 18:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA64606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=K+31T/Z0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C1B0B1AA5A6;
	Thu, 29 Oct 2026 19:46:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793299600; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=S1sqnnCjlRyaPfFD2qC02MEhZfl6DMtUczd0Q0Ki+2I=;
	b=K+31T/Z0FT7iq67pGafGa9MfRWGCryCiNanA3KAjiXb4E9m47xLVXgbhRXp8hAczcEY4Yd
	dI2pHubkLPVqJlRRGiOEZqVb96UJJqyXpgV3VB3tvOu23L/77EbSm9fqsNg2W9rTkHS78J
	1omgZ4mxaeIcwXAz/iACGd5Rj3BXaEiV1BZI1RdVKswxHU37h6y7k0HjkjOSRiqoLUJPlq
	4QeZxGTaS7wgy8u0BgEUFkDdIcGH05Sa/CTheN1ybyFg4S7qkg/dVxneUBsMwsRR8SRnER
	zzPUpAYwXY11/C516pFTPu8hBk3YCFEUUxdlARcMEK0byTN/qf2/KGWYI6AXRw==
Message-ID: <59118c64-5115-4eb1-86b3-9414087c4fd8@cjdns.fr>
Date: Thu, 29 Oct 2026 19:46:30 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 3/7] net: dsa: mediatek: add support for passthrough
 mode
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, linux@armlinux.org.uk, arinc.unal@arinc9.com,
 Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 naseefkm@gmail.com, b.larsson@gmx.com
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-4-cjd@cjdns.fr>
 <734d4f06-26af-4bea-9c83-eb92c1b3b894@lunn.ch>
 <18472c61-efe2-4529-971b-82d877df6b15@cjdns.fr>
 <2b406479-8c3d-40e6-93e2-e7ad01d5f432@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <2b406479-8c3d-40e6-93e2-e7ad01d5f432@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On 28/10/2026 13:35, Andrew Lunn wrote:
>>> What is actually left?
>>
>> In v2 I was using special switch ops, and it looked like this:
> Sorry, i did not look at v2.
>
>> /* No manipulation of forwarding rules allowed in passthrough mode */
>> static const struct dsa_switch_ops mt7530_passthrough_switch_ops = {
>>         .get_tag_protocol       = mtk_get_tag_protocol,
>>         .setup                  = mt753x_setup,
>>         .teardown               = mt753x_teardown,
>>         .preferred_default_local_cpu_port =
>> mt753x_preferred_default_local_cpu_port,
>>         .get_strings            = mt7530_get_strings,
>>         .get_ethtool_stats      = mt7530_get_ethtool_stats,
>>         .get_sset_count         = mt7530_get_sset_count,
>>         .get_eth_mac_stats      = mt7530_get_eth_mac_stats,
>>         .get_rmon_stats         = mt7530_get_rmon_stats,
>>         .get_eth_ctrl_stats     = mt7530_get_eth_ctrl_stats,
>>         .get_stats64            = mt7530_get_stats64,
>>         .port_enable            = mt7530_port_enable,
>>         .port_disable           = mt7530_port_disable,
>>         .phylink_get_caps       = mt753x_phylink_get_caps,
>>         .support_eee            = dsa_supports_eee,
>>         .set_mac_eee            = mt753x_set_mac_eee,
>>         .conduit_state_change   = mt753x_conduit_state_change,
>> };
> I think you should be doing something like this. Either two
> dsa_switch_ops, or you add generic implementations for all the ops,
> which then call device specific implementations dependent on the
> compatible. This is how many DSA drivers handle different families of
> devices in one driver.
>
> I would avoid putting "if (priv->passthrough)" everywhere.


I just send v4 with a separate dsa_switch_ops for passthrough. Instead 
of "if (priv->passthrough)" it is numerous empty functions because they 
have to exist and have to do nothing successfully. I'm not such a fan of 
it, but you certainly know drivers/net/dsa better than me and if this is 
the canonical solution then I agree to align with it.


Thanks,

Caleb


>
> 	Andrew
