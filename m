Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5054F55C4;
	Wed, 30 Sep 2026 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773366; cv=none; b=VPoPsDi1dSLqto+U2i3MWjc8+7u6a7cs1ppssXG7IdrnPyIWfrIyMBsuyTsWr3vVT586JCLW4Fi5Y3+38/Zcxik9dyjutV3H3m8OAmaF+eLsdYfMWQiN3Dv0M2R6SHYcngi0RDeLtki/C+6yO7frAItTYjm5JdDSfZVF6NJY2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773366; c=relaxed/simple;
	bh=r66RUjuVcIaDoxK766ozvbgI9SlqHhZNfg3qpPjbv+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0TrwrbsXGeiI5KcgQ7cPaoL9Vg8syna4bnO8luXcNvMFQwNM9cy1oRjPgSQYyBEJnGwt8a10rqSfzGAqjADqVR5hbGE0q7wcessOv76cmnBiHf1WvQtnZmaLmTKWn2U5xty7E93ym3lR5NZiSDQO2P334QVnoBCNaOExH30dFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rXgekqfM; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rXgekqfM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B11BC1A1074;
	Wed, 30 Sep 2026 13:02:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 819BB60749;
	Wed, 30 Sep 2026 13:02:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29EC1103296D3;
	Wed, 30 Sep 2026 15:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790773351; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=iRFYrMLclr7JRNfJikJcaPbxBlFtEulP6hvn4CGejvo=;
	b=rXgekqfMf4XBKEbXD9pjdGMiqMNX356WJ9E2GlX1gPrD1QJAwPO+IbYtVi7FY8ClaJUTu0
	f6dC/AD0+97BsMYqgBjfgEQy0EEQfiZIaYyBvDVjYaDhPwF66BomQIIhyqWnwrwmVB2pI4
	5Febhq7M/6/1auj4YoSKFH+d/YYF5ZyxyvZOKWcbP/zA34IKDQ7Qsi4SbzQO4XCXRP2z4A
	xKzepyRNoPg0wNBcw/h68KYmz3szyTADR4J0GEXDO2ivsKa5GCRGj+ta4n2ElkVN+IhQT7
	dvnulXJB/HPGoM1He1u9ZlDnwEa/YCZ21rAWIQF8K/YIRjladqHXwRNkc7t1Ng==
Message-ID: <4c205c02-9f9e-49be-8e8f-6fcff1ac523f@bootlin.com>
Date: Wed, 30 Sep 2026 15:02:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 02/10] net: phy: phy_link_topology: Track
 ports in phy_link_topology
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la
References: <20260927133619.955236-3-maxime.chevallier@bootlin.com>
 <179064231143.3145.13494941094645193325@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <179064231143.3145.13494941094645193325@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/29/26 02:38, netdev-bot+sashiko@kernel.org wrote:

> A second path involves MAC drivers that connect the PHY in ndo_open and
> disconnect it in ndo_stop (for example mvpp2 or mvneta via phylink). With
> a module PHY present, taking the link down runs phy_detach_internal(P) ->
> phy_link_topo_del_phy(dev, P), which removes only P's own ports.
> 
> When the module is then unplugged, sfp_sm_phy_detach() -> sfp_remove_phy()
> -> phy_sfp_disconnect_phy() sees P->attached_dev == NULL and skips
> phy_link_topo_del_phy(dev, M). phy_device_remove(M) -> phy_remove() ->
> phy_cleanup_ports() then frees M's ports without erasing them.
> 
> xa_destroy() doesn't dereference the entries, so this commit alone won't
> crash. However, a later patch in this series, "net: ethtool: Introduce
> ethtool command to list ports", adds an ETHTOOL_MSG_PORT_GET dump with no
> admin permission flag. That dump walks xa_for_each(&dev->link_topo->ports).
> Its port_prepare_data() copies port->supported and port->interfaces and
> dereferences port->upstream_port.
> 
> Wouldn't that dump read freed memory? phy_del_port(),
> phy_sfp_disconnect_phy() and phy_link_topo_del_phy() are unchanged at the
> end of the series.
Hmm I just tested and no, the port is correctly cleared...

The phylink_stop() triggers the phy_stop() machinery that takes care
of clearing the ports up

Maxime
