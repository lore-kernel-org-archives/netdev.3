Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1404A35B63B
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780126472; cv=none; b=WiidSdSu+3E/5SmuAGVuEDReF1ZYIxTf3qHkfKxQ88DZUEWXnRFpQy/hx09IVvb9RWAur8ki6NQ2Ck910IVMAwWDW2fNixcun/+wmvMXQxQJ7xEpQ3Jf2ddP0ogy/1zoYoIDzDQ/COSOs61nVkoKen004hcKwrajxeowQg+D0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780126472; c=relaxed/simple;
	bh=tG0VZHtBvJ1ZXkKD9SJmAbBR0seVpOIPLwh8LfAnE7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTntqDM/Ey08KYz1Q3ZzLZv4QxRVNQ1Tg1kAYJYTLBebimePtfbHFPH5kiPeitzsC0RiFSDMW/4gFCQdj0k2R1LauF2fxvXcf0PEYEpC8GgRFAkaYN+cd7tgNs9MuAS1LF6m1ZCfSJcqGeRuA4Tr3FRcE0ZYkzncQY0YR36adTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NaQav2kn; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NaQav2kn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 47A1DC6246A;
	Sat, 30 May 2026 07:34:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 21DEB6073B;
	Sat, 30 May 2026 07:34:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E10710888054;
	Sat, 30 May 2026 09:34:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780126467; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7YjPBHFuZfX3KRlMkrmnn37ShYoU9I2CtLcVhv8SyFU=;
	b=NaQav2knx8QHvIC0u/1gEfCF08gjJMs+gMA0s81gv8QV+XOsvmIFeJK4jPs4U4uK0t9Auo
	dtAXp3Xv3M3G05wS7oTOSEHVZ+16Uz3jLNPHbo46jgciWim8RoQ5qPve6SuLETEK/p1QGB
	mGG5pHfhz5ELUv+I8sJ2uDfXtwphrX9QmS9KOLT8LcAetewVgQBaFM50cUtWIJimZ9d+hr
	izyarf+EUa5gAoWy6k+7uhmqMNzGRuFKG8T1DvlUfI9fhBxjjkQ+R8Os8iVEvLmkIBkA6k
	ZcV4ibK4arNZszT0ih1yIE1zrkPcZlYabrXc47ShMbyI0x8nRDgnjMOHyWtlUQ==
Message-ID: <9503e0ff-baf8-4b49-9efe-d4e2800baa17@bootlin.com>
Date: Sat, 30 May 2026 09:34:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/10] net: phy: Create SFP phy_port before
 registering upstream
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>
References: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
 <20260521121040.1199622-5-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260521121040.1199622-5-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 5/21/26 14:10, Maxime Chevallier wrote:
> When dealing with PHY-driven SFP, we create a phy_port representing the
> SFP bus when we know we have such a bus.
> 
> We can move the port creation before registering the sfp upstream ops,
> as long as we know the SFP bus is there. This will allow passing the
> phy_port along with the upstream information to the SFP bus.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

On this patch, sashiko reported a pre-existing issue, with a temptative
fix here :

https://lore.kernel.org/all/20260530072706.3167745-1-maxime.chevallier@bootlin.com/

Maxime


