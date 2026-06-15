Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371683E557F;
	Mon, 15 Jun 2026 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530425; cv=none; b=f8hT3nMT8rAUseuHEkiBRxNZBFBfiz3WfZ4g4RTYhgdHrXCUEcuvmF/xMLh2VvZUHehBC6jVeoAWW7Dn/XXkPC+3J6civ22dPluH/7VZA9BTqh8IOaZrVv1+8v410vMEHHMlFtsn8LJoiLGdmorwjjhmkkbUwSqGBVwy362eq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530425; c=relaxed/simple;
	bh=N2ntj/ynlOh+zA/3YbsZL3cEPB1z9yqFqBmhPLgjqNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hHxxqujLMO7p9OUxol6dt3nE/5Akx13lBGLH3/QHajBtDTaQs4Lk5hJY+tMfW4tSaMORSZWSDpkv08b6Mpv6BUWyomEc7BqsV0wNzoj9WVu6I852pLnBNvT0SCJLyZTqaY/lsGzqTpd71UdZHG1yYgr9FAVO8WZDzQUi+M1kyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cN8CNMsq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cN8CNMsq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E272F1A37CE;
	Mon, 15 Jun 2026 13:33:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B16B360015;
	Mon, 15 Jun 2026 13:33:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 61CB9106C94F2;
	Mon, 15 Jun 2026 15:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781530421; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dOWrt41fp9ZkdsfONhl/POwO170vOA3eDS7WRaAIv2Y=;
	b=cN8CNMsqV3vnmukdqV8G3Kzmq5G8amSuHqLO4tp10lfiI1kRuxOzzSVIOf7+6AuuwloL9i
	EG6SwhRzQHIXAoItTEt3q0xG5RNm3La0F1DIV0asn9qRlDZg4i6V45E0qd0ChV4jh3qjXT
	inGsCfhmYmkyv6LTBNRDy2xV4NQjVWHZntpev9zX9XStGsTgIhLlMTMf9yoUXdQCN9YRwv
	t/XfzKsI8HZSndynjUihh3WNXfQmnYPID0ISfu59px6MIQgnFV/lBYoPkbtdYnQ+r1vduy
	l+wlZo1hfEKbr7/6vnPBb9a5YhLqeYxBhb/ysDmThYVw9njwNSrwJliPypg9Kw==
Message-ID: <371a1df7-084c-4431-bd00-0045298e3212@bootlin.com>
Date: Mon, 15 Jun 2026 15:33:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 01/12] net: phylink: keep and use MAC
 supported_interfaces in phylink struct
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
 <20260615122950.22281-2-ansuelsmth@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260615122950.22281-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Christian,

On 6/15/26 14:29, Christian Marangi wrote:
> Add in phylink struct a copy of supported_interfaces from phylink_config
> and make use of that instead of relying on phylink_config value.
> 
> This in preparation for support of PCS handling internally to phylink
> where a PCS can be removed or added after the phylink is created and we
> need both a reference of the supported_interfaces value from
> phylink_config and an internal value that can be updated with the new
> PCS info.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/phylink.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 087ac63f9193..4d59c0dd78db 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -60,6 +60,11 @@ struct phylink {
>  	/* The link configuration settings */
>  	struct phylink_link_state link_config;
>  
> +	/* What interface are supported by the current link.
> +	 * Can change on removal or addition of new PCS.
> +	 */
> +	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);

Can you clarify a bit what you mean here ? Is that the combination of the
interfaces the MAC supports AND the currently in-use PCS ?

Maxime

