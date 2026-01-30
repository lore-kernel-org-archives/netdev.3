Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249F34A794
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792940; cv=none; b=Y+QKSLk+bWTNqLrjBxn9whNUCwUJRxf652MMi6gYZupo90JCx8Lg/O9zV6P7UON2B96sW2wIogsho+bpcfdqRY0Ns8jCicLWHlF5B4z1WGRCHqn//b74f/8OGL8/SIYW12L1xIOYul8RdWlQ2sngDD94YQIksCqCYg7pYOTJRNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792940; c=relaxed/simple;
	bh=/RvhCIrP3097qf3ngUMcUP9uD0Waf4smlT2OPGGZad0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9Vu5VXeR/SwRN6n7p25oANhACY48jsTm7jwU8FzX7cQWmGeHM2OtA4KxFndZE9lZc55LJ6k9CBZJKkreLYCC2X+zp2MrgW8N+O03EyrZu4BTXdqT433bqAgJSuwgiJEVA7LCK51gv51HMU9pDz3DNNWsMc9yw38L4quZj2xQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xk3VtVhS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xk3VtVhS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 38F521A2B3D;
	Fri, 30 Jan 2026 17:08:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 038236075A;
	Fri, 30 Jan 2026 17:08:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69E3F119A8890;
	Fri, 30 Jan 2026 18:08:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769792934; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=9ynhhTVfJX+9wMDK7jU25/Hkm3GSOpSiJRLcK/KvzLw=;
	b=xk3VtVhSq0ZhmWisZuEZydXqIWZpPRBenoBJUh6uneH7xhY/twCtYQVjtA6IG9D3tDdf32
	kgTGM/8YGS+6jb5ALFpIW4puKJOhb/FGXwvJB4cHzohGrwxKHFGYGaMtbIE8pTMeck62BW
	IYPdcMSlcobuM6CWLrlCoN7aBuXy5il8IRFE6v3JN4I3IXt+OWdAAFRpKk4a+Mwcwwk1IX
	4IsB10ZTp0y7/eE869H/j/YujmR9HbLwC4jhJc1D8MuQoendqIw5AOs+AiqY7+8nyVIovI
	Gpvpkx9jyXQRQNPGhOFOaZM7Q09iJAQDsoZZADg+n3rVbA078npoRB7BmLD/YA==
Message-ID: <9354d336-dfc4-426f-9c2f-6e4d4211991e@bootlin.com>
Date: Fri, 30 Jan 2026 18:08:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/13] net: sfp: Add a sfp-bus ops when
 connecting a module without PHY
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127134202.8208-7-maxime.chevallier@bootlin.com>
 <aXzaGg3AkHOdP30A@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aXzaGg3AkHOdP30A@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 30/01/2026 17:19, Russell King (Oracle) wrote:
> On Tue, Jan 27, 2026 at 02:41:54PM +0100, Maxime Chevallier wrote:
>> The SFP bus infrastructure notifies its upstream when a PHY device was
>> discovered on the module. However, we don't have any indication when a
>> module with no PHY was inserted, except for the .insert() and .start()
>> notifications.
> 
> That's the way you tell - if you get the .start() callback but you
> haven't had a PHY connected, that means there's no PHY.
> 
> There should be no need to add this callback, since you shouldn't be
> thinking that the module is fully initialised until you have received
> the .start() callback.
> 

Ok fair point, thanks for the feedback ! I was about to send V3, but
I'll implement something that doesn't require this new callback then.

Thanks for taking a look :)

Maxime
