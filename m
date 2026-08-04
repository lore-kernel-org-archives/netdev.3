Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30644427FBB
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828109; cv=none; b=MlBakqv3x/6chXYaprFF63HH9fMg9woxRuuzEeAYvyiPNmF4gj8vUG9T4urzOQo+aOfEQMiHqFHXTZNUjP+2b8QCv4V6xOqn9WUEjKKXg84E3RBjBf6ppBrL1BSiW30Sz2FUCm/zs1tHsN574VU5kD70CIA4rvgjPwU4NRKCi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828109; c=relaxed/simple;
	bh=CSYP6Io4DRAEop9lfgOCE/wj06+2PTEfgqOlW5OlE9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2QgCjzvttwFvqiOmIjscuKvIVDHZZWKjQgZ6KMLgpU737uCkBncJrAX4mV0oyuoltkBgphHDpAch89nlw/iC+S6h6BlAb3kmBiYGhdmnTkpADUNMkHYPqAzp+y1812AJhfHf8iAU6iX1W3Sj5SuLsyBJyQIVb46JvSt0kq4foM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dD2Otqy2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dD2Otqy2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5384B4E410CB;
	Tue,  4 Aug 2026 07:21:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1C1D86029E;
	Tue,  4 Aug 2026 07:21:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FD7311C323E2;
	Tue,  4 Aug 2026 09:21:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785828102; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=GVt/k3WsbW8BGM9REjtRXzCwiVcIn92ftdHj2akMofI=;
	b=dD2Otqy2ZvfPFp6kaEB4jvvpubX+6uyTYj1jm6nSeGKwVmI6Ff2plvXdEbEIT5pVMMoMgi
	KENVTxTU7j1q9zIlzZ3h2ePhA+bo4R6viRox1iGWVDeYY6bOPbdwrbrCsTO9RfWd1Jk3zD
	ehX+4n+OzYw6LWc9TI1W3jv2NhdXx/amg4xfwSkcPG/pUNy3q/5TybwY2XcmdzPb/dzZfK
	s7QQ+uMTWrmSjRM/HrVof94nVdvZzFhvaK/QZUX7S07iSdmmx1ozkenWkIzB3nUkwnBIzB
	lz2XBl0CTa8WEDiiq4WeID6O4hDImDCVBIxzRteTvfq0V+hs11ovm9OPuXIDUA==
Message-ID: <5c1b3bdd-37a9-45d0-90d2-1afc78125972@bootlin.com>
Date: Tue, 4 Aug 2026 09:21:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 00/10] net: phy_port: SFP modules
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
References: <20260801074332.98755-1-maxime.chevallier@bootlin.com>
 <20260803140431.2bbe2949@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260803140431.2bbe2949@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/3/26 23:04, Jakub Kicinski wrote:
> On Sat,  1 Aug 2026 09:43:21 +0200 Maxime Chevallier wrote:
>> Here's V15 for the phy_port improved SFP support and netlink interface.
> 
> Breaks YNL build:
> 
>   In file included from ethtool-user.c:10:
>   ethtool-user.h:8523:42: error: field 'obj' has incomplete type
>    8523 |         struct ethtool_port_get_rsp_dump obj __attribute__((aligned(8)));
>         |                                          ^~~
>   ethtool-user.c: In function 'ethtool_port_get_dump':
>   ethtool-user.c:8833:18: error: 'ethtool_port_get_rsp_dump_parse' undeclared
>         (first use in this function); did you mean 'ethtool_port_get_rsp_parse'?
>   ethtool-user.c:8847:19: error: returning 'void *' from a function with return
>         type 'int' makes integer from pointer without a cast
>   ethtool-user.c:8851:16: error: returning 'void *' from a function with return
>         type 'int' makes integer from pointer without a cast
>   make[1]: *** [Makefile:52: ethtool-user.o] Error 1
>   make: *** [Makefile:57: ../generated/protos.a] Error 2
> 
> You need to specify the reply for dump, I didn't check if it matches do
> but if it does:

Ah correct, that's my bad I disabled ynl build temporarily as it doesn't
play well with cross-compile, let me fix this issue and see what I can
do with the ynl build in itself

Maxime

> 
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -2896,12 +2896,12 @@ c-version-name: ethtool-genl-version
>  
>        attribute-set: port
>  
> -      do: &port-get-op
> +      do:
>          request:
>            attributes:
>              - header
>              - id
> -        reply:
> +        reply: &port-get-op-reply
>            attributes:
>              - header
>              - id
> @@ -2913,6 +2913,7 @@ c-version-name: ethtool-genl-version
>          request:
>            attributes:
>              - header
> +        reply: *port-get-op-reply
>  
>  mcast-groups:
>    list:

