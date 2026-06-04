Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCD372069;
	Thu,  4 Jun 2026 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540037; cv=none; b=ZTZCj4U0ylS3buHfNP4TEy2JesG7HoptT5kSpJ3Os+LOfECqN4WBpSDPVYeZPD3w22a+mGnNu5g7pM23pm5zuJKk8Hj3f+mB3rxXAcAeU/v2d0o99VD0/O8Gc7+m1db8dNaOfitMTLh/uegRFgF97aaTW6brZ+954n2e58pHwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540037; c=relaxed/simple;
	bh=D78d217JUW+iFsIwB881grW5B8y3p3CeTZrqusmzOT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smotBDY0+MghGvn+IrgI0kPEH4tHx0aT3oNB6dfSnX5CHrTO0aQexrSUHMgxlhmt5a1Xd/zjh9ZS5VUQDylYDErAwb0uatkPxzC8o8XiRhV/517A2wJr5tb3SuyFfU25TIgiYeUsmY3CbSQGd0RXqvz0XzPJvzcp7RO4o9gmR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5Pt3zLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5Pt3zLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017851F00893;
	Thu,  4 Jun 2026 02:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780540032;
	bh=2hWwEFYNoPk8RDgJA+HdJDWslftrvnBOU4+dDSmlqp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5Pt3zLTjkKJVeiiuCuyALCOHQGelB08HWR9Olx1JXSihXJ+TTSAZCx+YuH7fuwlv
	 uv1agjxExoV2lYlkjPROw+OUi3PQjpsNSVRoE3Y+f5pkI/v0W0n8VvabDWuVho67Ou
	 cEaTRFmhtmB9GEcTIsZ9IQ8E8IgmLr3S4NIs6O4g0bzzhhnaLuLe3Ik3TtHnyuk6Dm
	 Rll3nyR0XWJXnk4lce8eCH2UwUarTmPrBZsd+op19iPZyG6CKcOJf1WzV9aTfVLR+5
	 Qq6TyGzq+NMelYz+Codhqmgn+Wfan2VEtbceF2ud987RiXBLw0rYsK52wa8xbUvLw3
	 YI3BRrMsH+7kw==
From: Jakub Kicinski <kuba@kernel.org>
To: maxime.chevallier@bootlin.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net v2 2/3] net: phy: remove phy ports upon probe failure
Date: Wed,  3 Jun 2026 19:27:07 -0700
Message-ID: <20260604022706.2924974-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601084029.815461-3-maxime.chevallier@bootlin.com>
References: <20260601084029.815461-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: remove phy ports upon probe failure

When phy_probe fails, let's clean the phy_ports that were successfully
added already.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 6ccbfacf7d1d2..a171cbe2a74a1 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3778,6 +3778,8 @@ static int phy_probe(struct device *dev)
>  	return 0;
>  
>  out:
> +	phy_cleanup_ports(phydev);
> +
>  	sfp_bus_del_upstream(phydev->sfp_bus);
>  	phydev->sfp_bus = NULL;
>  

[Severity: Critical]
Is it safe to call phy_cleanup_ports() before sfp_bus_del_upstream() here?

sfp_bus_del_upstream() unregisters the upstream SFP callbacks and acts as a
synchronization barrier by acquiring rtnl_lock(). Before it is called, the
SFP bus is still active and can asynchronously fire events like
phy_sfp_module_insert().

Because these SFP events locklessly iterate over the phydev->ports list via
phy_get_sfp_port(), and phy_cleanup_ports() mutates the list and frees port
structures without lock protection:

Could this concurrent access lead to list corruption and a use-after-free?

This same incorrect ordering is a pre-existing issue in the phy_remove()
teardown path, but this patch introduces it into the phy_probe() error path.
-- 
pw-bot: cr
