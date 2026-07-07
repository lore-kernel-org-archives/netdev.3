Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90783E6392
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422616; cv=none; b=Qcu+msxGWmq11Kh2mQ/nXtuTjeVNhZmmj8L0JM9hwh9lc3iZ5+5+/or3tblfQqiLI69zUbG4IqyLz9WuveHCANyG8SRbqSjSjHpy0mWvt3YpnWrBI8nAGD1DNoI6SxdlndMk5WWnatsRWvmdPwfvkivTvk72CraEr42VAxZS4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422616; c=relaxed/simple;
	bh=HbrxnkhkBloL8pgj3H5uTbv6oVtfAv7MakqvR3BMI3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYycVru0CTxMxjZh6VKjRwsYfWnh2h7KpkYwz54IHvF78QlVFREsl87GmENdeE4lznIcACdx8Mbx8QiGYS2HZR68M7QEdvxOtaco75pK5CUlHLyq8+4d3UJMt/Qicoz54WugPWNWO/qolBCEe7RFx9kG3Y7pEIk2OTc0tkN3V30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fbct+YP2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fbct+YP2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3647C1A0EB7;
	Tue,  7 Jul 2026 11:10:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 087C7601A3;
	Tue,  7 Jul 2026 11:10:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42C9F11BC150A;
	Tue,  7 Jul 2026 13:10:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783422610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6XCXmOjphQkcXnm91iLeRRCWQdQMqmpt67g9KghxGOI=;
	b=fbct+YP2HBJM3/5c0slj9Qm0giNfSh4VoTfPYOYLPwSxPGzVs9tCCYO0eqHRy7vfJUuNoK
	hRrq8rh7Qt8PXJr1tMrNckUDtyofg5X/KIk10vevbVPXmEOTOd3SF8FEUUUvhwx0sl/+lQ
	zcLcvvIcLZsxlLHXfVqp+7/FJh8b/lxQOkWgy5pvU9r/GLpAdyNcLIggcn3Txdvw0sjfqX
	qpSO0xjE/K6rbOp1Kt3SGQCOvo6H/AzrJGT2ciGuT3M5RoQwu/2ypvq5+kxErSb624GmGV
	9r23o/ZvzpGg6c9xbko+Xj7eHCPNTfDHiO4PRieyX/zyZImM4toHBaopHIa7DQ==
Message-ID: <a5dcf2a7-8291-4ac9-bbf4-513b43524f10@bootlin.com>
Date: Tue, 7 Jul 2026 13:10:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/8] net: phy: phylink: add helper to modify
 pause
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org, linux@armlinux.org.uk, enelsonmoore@gmail.com,
 daniel@thingy.jp
References: <20260707091637.371-1-javen_xu@realsil.com.cn>
 <20260707091637.371-3-javen_xu@realsil.com.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260707091637.371-3-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi, 

On 7/7/26 11:16, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> For Realtek nics, when we enable jumbo, pause are not supported. So we
> must check the pause capabilities from ourself and lp.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v5:
>  - no changes, new file
> ---
>  drivers/net/phy/phylink.c | 66 +++++++++++++++++++++++++++++++++++++++
>  include/linux/phylink.h   |  2 ++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 59dfe35afa54..c450ee33b75c 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1828,6 +1828,72 @@ int phylink_set_fixed_link(struct phylink *pl,
>  }
>  EXPORT_SYMBOL_GPL(phylink_set_fixed_link);
>  
> +/**
> + * phylink_set_mac_capabilities() - Dynamically update MAC capabilities
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + * @mac_capabilities: the new MAC capabilities mask
> + *
> + * This function allows a MAC driver to dynamically change its capabilities,
> + * such as losing/gaining Pause frame support based on MTU size.
> + * It recalculates supported link modes and triggers renegotiation if needed.
> + */
> +void phylink_set_mac_capabilities(struct phylink *pl, unsigned long mac_capabilities)

This is a step in the right direction, but this is maybe too generic, as
mac_capabilities represent both the MAC's Pause support as well as Speed/Duplex
support.

The speed/duplex parts shouldn't be changed dynamically, I think the helper
needs to be specific in its naming that this is strictly about changing the MAC's
Pause / Asym capabilities dynamically, and be either passed some booleans, one for
rx one for tx, or fail if we try to change anything other than MAC_SYM_PAUSE and
MAC_ASYM_PAUSE.

Maybe something like "phylink_update_mac_pause_capabilities" ?

The 'update' part makes it clear this may trigger re-negotiation.


Maxime
