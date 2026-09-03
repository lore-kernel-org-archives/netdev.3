Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6643CE7E
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424055; cv=none; b=NbzMKkEdd5AtZPQ9JSpXGlOUxQKkRSRijoo4Eo+Ay0aZdCe9VnDD44aL+cd8+Ir3tt+DQK2j15SWZEnd3ecGC3BbNYcSi+Poa/bJaHlIt1Iz2BdY/q6909s8DC1W2taZYkRcP3gjEJNH0Rww0F66URI5c1J3w7wgJMtEDytJ5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424055; c=relaxed/simple;
	bh=67/91FpklvfDsnTt3gW3LRXC7Q4MrhTlEM2ATgBsutM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=rJ+SIsAM0PT6t2bbINY2CTnHs6Naq1J/BSkIgBrVecdYdhKK5AL/pwG8SQkfJxjGGtx7nMTkrIrMbLxnNt11CAw15BHgwyO0eJobjYHsUtUmsE4jCVOfC5UdKjPNpHVLoutruolWeoLn/yaAieHKhrOsdDWzL0G+ZtXtw9MDO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TUdfXqNl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TUdfXqNl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8D2851A195F;
	Thu,  3 Sep 2026 08:27:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F268602B8;
	Thu,  3 Sep 2026 08:27:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DCBD11C79EFB;
	Thu,  3 Sep 2026 10:27:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788424041; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SiOl0TmdJANJFeVHr7GBo8ro7wF7gFtpcORo8twwUpM=;
	b=TUdfXqNlUrI8/DL5Md0y88/hJ9tptWYCZ/7H4AbYl5vpOdq+lWd+b7GH/jHqcxwViiO4LH
	1Q/WrMIGN22dnaUxI9tUswRNlho/mwMZsR3CM9EsRQPYO96frTZ8zbR2sggFPg05ka1e7i
	KF2oi5JHcfPknduoAzdaeM1uo8sHWSjH6RJNsXpMjD29kb7R0nv5kuKp4qdCP51YXu5SBB
	jdTEwY174TJUUVi/WNG624vQxXJhm6LLp6o1syVHt06eb/wXjR8lt3DsI5ufycG9xpcuyK
	2gUoWjf4++hrJLxs4oKx4zy6QgtllU3Xb+SkV+FGY97omEqrImIFdVmCa08bwQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 10:27:17 +0200
Message-Id: <DL5JESSS9JQK.2EV7XV479M0UW@bootlin.com>
Cc: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>,
 <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net] net: macb: fix NULL pointer dereference on unbind
 with fixed-link
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260902102836.2019355-1-vineeth.karumanchi@amd.com>
In-Reply-To: <20260902102836.2019355-1-vineeth.karumanchi@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vineeth,

On Wed Sep 2, 2026 at 12:28 PM CEST, Vineeth Karumanchi wrote:
> When the device tree describes a fixed-link and has no "mdio" child
> node, macb_mii_init() returns early without allocating the MDIO bus,
> leaving bp->mii_bus as NULL.
>
> Two cleanup paths then dereference this NULL bus:
>
> 1. On driver unbind, macb_remove() unconditionally calls
>    mdiobus_unregister(bp->mii_bus), which oopses:
>
>   Unable to handle kernel NULL pointer dereference at virtual address 000=
00000000004a8
>   pc : mdiobus_unregister+0x14/0xa4
>   lr : macb_remove+0x38/0xa4
>   Call trace:
>    mdiobus_unregister+0x14/0xa4 (P)
>    macb_remove+0x38/0xa4
>    platform_remove+0x20/0x30
>    device_release_driver_internal+0x1c8/0x224
>    unbind_store+0xb4/0xbc
>
> 2. On the probe error path in macb_probe(), reached when
>    macb_mii_init() has succeeded but a subsequent step fails, the
>    err_out_unregister_mdio label runs the same unconditional cleanup.
>
> mdiobus_unregister() and mdiobus_free() do not guard against a NULL
> bus, so guard the calls in both macb_remove() and the probe error
> path.

Agreed on the patch! However as we are there, I looked at all
bp->mii_bus usage and macb_phylink_connect() might crash if bp->mii_bus
is NULL.

bp->mii_bus is NULL if
 - no children mdio DT node AND
 - DT declared fixed-link, see of_phy_is_fixed_link()

In macb_phylink_connect(), phy_find_first(bp->mii_bus) will be called if
 - phylink_of_phy_connect() fails AND
 - we have no phy-handle phandle prop

Those two overlap right?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

