Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A43394788
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512934; cv=none; b=lAFRIcdWcNsOZFcb+ZbDB2fsu1q0RyTgzJRm5S4lgVbTvP3tyDrOb7qR2qCYE2BB532f07HSSWsHix7Bt6jHQ7CEtrlyhJF30LJxl50c0/bCjK/lyNXehkNMCoDUyn/PWSgDxPNQpBV/e7O1AH+bmlASLBldDz1d4A1On1YPUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512934; c=relaxed/simple;
	bh=O68dElmS/Mk1Yb/V2hTOB5Nm9sVhBXSpARMuMurzr4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caHwDaWcBwFymRew7I08dDir7zfwxO0a0NwAVZz7ic/z0knaFLEbci6bqhJ4zFU2uztWQOmp5EtVp3HmuaSaIbwBfkf22/O0BjReWZico6Rq6hG0V00FOn18e/kxfIaLKE1C2+K16tNDaWADmuDvO7zzxqQBNDeA/zIw27P30kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bap0xy/F; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bap0xy/F"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2E90E1A0FDB;
	Sun, 27 Sep 2026 12:42:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F2D5F604FF;
	Sun, 27 Sep 2026 12:42:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CD81102F1E73;
	Sun, 27 Sep 2026 14:41:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790512922; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+h6WZaEjIYng93IBLp9Rybw7ShEOIP9ec51gcF7q9oc=;
	b=Bap0xy/F4P7xqpuPokoT6a0u6uo3HNjAyONeXhtwAapBAlVDzQzhOhKVp9lL84oP8mJw+9
	+wU1j5a5q0rSOhs6uoNh9UTqZA8zkORPleCuRt99Wq+P8hKHkre7JAkqHVhht2RL3uvIkW
	zwZLQpTKmows82wFSwbLxrPsFsj9OJlud74AowM9wdHtsNu7MgHQns9TFy+gEtXQagqFjD
	PbAGW5ucSb/bW7jCNriu38K+srLlqSLTfKxV9/RvE/WfyJNT/6lyJmxWlY5NiAVhXKQ1r0
	y3de18d56JrF5Cy2say4dkXDU5mtRlHJ404sgo6rY4Adi6y8QALg2manoPh+Jw==
Message-ID: <d2c915dc-45a6-4bf4-ba1a-6c7efa9c0164@bootlin.com>
Date: Sun, 27 Sep 2026 14:41:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v17 00/10] net: phy_port: SFP modules
 representation and phy_port listing
To: Aleksei Sviridkin <f@lex.la>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
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
References: <20260910170103.1029108-1-maxime.chevallier@bootlin.com>
 <20260924220118.2129522-1-f@lex.la>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260924220118.2129522-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/25/26 00:01, Aleksei Sviridkin wrote:
> Hi Maxime,
> 
> I ran v17 on a Keenetic KN-1012 (MT7981B + MT7531). Switch port 5
> (lan4) goes either to an SFP cage or to an EN8811H copper PHY, and the
> bootloader picks one devicetree variant per boot. The series was
> backported to OpenWrt's 6.18 kernel together with the phy_port base and
> its fixes, with PROVE_LOCKING and DEBUG_ATOMIC_SLEEP enabled.

Thanks for testing :)

[...]

> 
> A module port follows the netdev's admin state rather than module
> presence. With lan4 down, a module sitting in the cage isn't listed,
> because sfp_module_stop() runs phylink_del_sfp_mod_port(). After ifup
> it comes back under a new id, so every ifdown/ifup renumbers it. Is
> that intended? From userspace, "port 3 upstream 1" isn't stable across
> an ifup.

Yes that's intended, we don't really have a choice here. Module ports
should be considered volatile in their id (this is best effort) as they
may disappear / reappear with another module later on.

> 
> Tested-by: Aleksei Sviridkin <f@lex.la>

Thanks !

Maxime

> 
> Aleksei

