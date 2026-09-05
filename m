Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFD411CA9;
	Sat,  5 Sep 2026 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644515; cv=none; b=rurmLQcgd8w/sRxea5sqliaOjbPS2vcdt/ZgzLiDPtW1B04vp76dPfrzGyy2g3siH+IT9/2s40x9SsXLoXwKAiPTZ/Iu2+i3bMav0+kLh4SSjvf3Oz9FMw0BSf1sZ84sQ5HrNc8jdMHMMw0gGG5+FasElmLWS8RHw1Wk2YKeTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644515; c=relaxed/simple;
	bh=6xzu/ENOZuXJBV56nadNzjDw7YuOCE/vFYInOFUc4JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcGAagn7LIwr/S1CJF/vJAaAt+wAeuyz1EnPW8YRAjISnp5tvQxwBZP/9Q8QA9JUzfLBRL9sgwF0UchrXnOejUvLBEu/Ej6JmijIZ1s1G8WcoNdqbL/9uF86OPE8IbYsa4ux+kKNSQzrRyEgGLqJ104qTeGbB+pfujzubSy8FWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MyAoIML2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MyAoIML2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AD4E34E41538;
	Sat,  5 Sep 2026 21:41:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 64A6960233;
	Sat,  5 Sep 2026 21:41:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6400D11C783E9;
	Sat,  5 Sep 2026 23:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788644503; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YwVtBYkAtnnDInMBjRwZWDAF3tbzG7Hk9W5jfEaSjs0=;
	b=MyAoIML2H5u1/VtBirLXBojZtl23ACy124PObVUTIHYBmXMXWeeNmpxYkfTirx2dop33cE
	/bUa7RQTPdAyI0vvHro/PvPJpRdpepBqPvdVgnQa6u7n0ss79nbPqGox9GDwP47Okbd9KJ
	pmoskhwvb95r7iNgeDJ9RL62jKeC8p1q/YHUucp/SDOFatIOXQ2EBcuyX/kfXc7+Docqxy
	U7oTBSe37IQZ8VQz8UER8lttfvKi6ddcu4LUQp0zPN5eyk0MKiEXHqM2+SptoVYgmNEink
	sE1CCrF8nMbWky8WsjYaTMBm91y//5RwSL7cxlCJ/nKnHzRCTnWUnrc/mBMmNw==
Message-ID: <b11a5ca0-1f0f-473c-9890-6128b83aaeaa@bootlin.com>
Date: Sat, 5 Sep 2026 23:41:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 00/10] net: phy_port: SFP modules
 representation and phy_port listing
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>
References: <20260902212135.1805948-1-maxime.chevallier@bootlin.com>
 <20260905133052.62d1b224@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260905133052.62d1b224@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/5/26 22:30, Jakub Kicinski wrote:
> On Wed,  2 Sep 2026 23:21:24 +0200 Maxime Chevallier wrote:
>> Here's V16 for the phy_port improved SFP support and netlink interface.
> 
> ynl says 🙁️ This needs to be squashed into the patches:
> 
> diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
> index f9d8794eabc1..660e0c08a766 100644
> --- a/include/uapi/linux/ethtool_netlink_generated.h
> +++ b/include/uapi/linux/ethtool_netlink_generated.h
> @@ -78,6 +78,9 @@ enum ethtool_pse_event {
>         ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
>  };
>  
> +/*
> + * type of physical connector
> + */
>  enum ethtool_port_type {
>         ETHTOOL_PORT_TYPE_MDI,
>         ETHTOOL_PORT_TYPE_SFP,

Aw :( I did run the ynl regen, something was likely off I'll address that

Sorry about that,

Maxime

