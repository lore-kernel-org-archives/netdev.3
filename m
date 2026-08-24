Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E8422E2A;
	Mon, 24 Aug 2026 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577612; cv=none; b=UkOZg620JAA+Q7WPvQRBGLDXVsYH5gFCSvG3IE6dstICP+1kgUZdv/7WpmYXbyMP4JKxfTrkGJiVq/WgTiYExdIkkWgyA1sqOZtTrVxa8J7nXDiOcsCuxqYLnX92FsECiAiJ+6xkOFbKIluCIhNDUOW20dJOQajq5CIeYVdx+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577612; c=relaxed/simple;
	bh=HPd8tvlAjRUOeEobAEyALdyT4TBP0fKvqWpUgesG7tc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c8y5DK04s18qE89yvxzAkMoolIaNTfUKjkNVn5mgbq0jBsD3tt7o8h0rRyzeENfK0tuSvW/2WwmqY9BMxDKhlcfuHHz7ryyumVhyJ7lLHjtoqO8ounyOX7ok/6BceUaVjpskCg7NYdN781JXFbzyjmdrOjljj7UIs12VieAyiqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E6QUcRym; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E6QUcRym"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F30BF1A17FC;
	Mon, 24 Aug 2026 13:20:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BE24D5FFC1;
	Mon, 24 Aug 2026 13:20:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A585711C794F1;
	Mon, 24 Aug 2026 15:20:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787577606; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DC7nFQT/pTbwg2uD11ECk4kgDtuYsLL8hiclC7MfSTk=;
	b=E6QUcRympFgTENQsMSUa8GGT6yjUAP5laBWRMf+CK2RoR67C6bjRw1gEPBp9GgyL8G/LGF
	smsFQ3NDMfz53Vhi8JtaVr9oDxk2DZ6PKm4xmKJlsRqf5AsAw1Laye4BsudT4xJ0H6tcF8
	aP1HdAcMZxt49SXBT3gg6KUXjd/5ljPCez4UCiA6JlXli8pnFCvNnvMusKDB3aOuxkLWTb
	cbn1UZQ6esYAYDZDgnLnXd4OYxBMEFE9s1bv7QmkC/CyhS3Zrn/599y6zaDSIF2aPKqofQ
	oMxH97kOK/6lS9L/rN1Xm0hlY/tbtLeYH4rUD4jBiYpmYx7BHOmTXvDpd7hrTQ==
Message-ID: <73cd1654-b97f-49a2-9bc3-eea90857feac@bootlin.com>
Date: Mon, 24 Aug 2026 15:20:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next v4 3/3] net: phy: own phydev->psec via PSE
 notifier and remove fwnode_mdio hook
To: Carlo Szelinsky <github@szelinsky.de>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bac5e6e9-7358-4ccb-87fc-9c40baa33682@wp.pl>
 <20260823170921.1429827-1-github@szelinsky.de>
Content-Language: en-US
In-Reply-To: <20260823170921.1429827-1-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 8/23/26 19:09, Carlo Szelinsky wrote:
>> This patch causes a deadlock with the etop driver (lantiq arx100 soc
>> family).
> 
> Thanks Aleksander, and thanks for testing it on real hardware. It's a real
> deadlock and you're right about the cause.
> 
> The cause is that this patch makes phy_device_register() take rtnl_lock()
> around the psec attach. etop registers its MDIO bus from ndo_init
> (ltq_etop_mdio_init -> mdiobus_register -> mdiobus_scan ->
> phy_device_register), and ndo_init already runs under rtnl inside
> register_netdevice(). So the second rtnl_lock() deadlocks. It only shows up
> on drivers that register the bus from ndo_init - most do it from probe,
> outside rtnl - which is why it didn't turn up here earlier.

This is a known issue that some netdev hold the rtnl during phy register 
and removal and some don't depending on the path.
I faced the same issue when working on timestamping, the reply from net 
maintainers was that we should add rtnlock in the netdev drivers that 
don't take the lock. I started the work but never finished it due to 
missing available time.

> I don't think we should revert. As Jonas said, this should be fixed in the
> patch. My idea for the next version is to stop using rtnl for the psec
> attach/detach and use a small dedicated mutex instead. A private lock can't
> recurse against the caller's rtnl, so the etop case would go away.
> 
> Kory, others - does that sound like the right direction to you?
>
> One thing I want to flag: rtnl there wasn't only guarding the attach, it was
> also keeping the ethtool code that reads phydev->psec from racing the detach
> that frees it. So the mutex would need to sit in two places - the phy side and
> the ethtool paths in net/ethtool/pse-pd.c - otherwise the deadlock is gone but
> the use-after-free comes back. Just so we pick the right approach.

You can try it, but don't forget to enable PROVE_LOCKING to be sure it 
works well.

Regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

