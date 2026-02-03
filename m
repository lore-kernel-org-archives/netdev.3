Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953332693F;
	Tue,  3 Feb 2026 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142348; cv=none; b=prIaCKvmBaBm32Aa68Jx63CMVNZhI2TcjsNwqN7myAm074GVG7MHc05HDI5quVmTmNPv8YnnO3Xo+ys9WRG1JVDCjG40eEOu5E7s9kFYwdYyMxIUlbIl8kVQDZlc6HA9gsL2QaPU7vq6r50AgKAQYjXQAtk/yFSa8n9rxg+iwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142348; c=relaxed/simple;
	bh=y5GsAopZikx1vLw5N6IlLqyBOY8W9lcRaURsuG275sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKY0b+58TvCwSEoftBhJh7E1qWkQZFoCSjr4mMdCLk2wwGJGsIuFhdzFQ5X8w+ATUthZ2erCz62NZCYoy8hHwnLwf7ZhBxada7Ni7zitJ5KfB49TOxyD4RXnnqoJrBqXrdkz+VDtY/rT7Sq9pKc67pG1oJjNgxRkkahexN7rSWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vs2LDm6c; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vs2LDm6c"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A0DC44E423E4;
	Tue,  3 Feb 2026 18:12:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7855360728;
	Tue,  3 Feb 2026 18:12:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B848119A8888;
	Tue,  3 Feb 2026 19:12:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770142343; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=j9eEii8CtOD3T3WlH803AHmufnrBS1E6wpf/iOVv4YQ=;
	b=vs2LDm6c2Y7xYpHssTc2VXg/W8y3z32+63+Gmv15wlDyTDUUDRGCXqWxwRqyGssZgRmXM8
	zK96lJrkVRzn8Rigz8iLMLZ68XdIw29jM3Ij+Xxu0ygHJc7E6bjUVIi9DVsm0FfBTSh6SC
	slqENv90TXbeh8t64m8TbVdJ1uxgLRFjaiNVZaWLMWl/N8ALt7CEkkFOBnGz1iDxJ8R4Z1
	EJKYDCx15Nd/iWpzSsOXyavIM9YQLEp/R6hKVzaH9Zns6nYRnHhJwg9qr3SaJ7gndTMQqH
	GlkFG33f7DKywsqTrSEUZ1TQqFl4we5IG2vG5MLnOBFwLC29sJwrj38fc27pNw==
Message-ID: <849815af-9f8f-4703-bab3-167b65cd7b69@bootlin.com>
Date: Tue, 3 Feb 2026 19:12:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v3,05/11] net: phy: Create SFP phy_port before
 registering usptream
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, edumazet@google.com,
 o.rempel@pengutronix.de, andrew@lunn.ch, christophe.leroy@csgroup.eu,
 kuba@kernel.org, pabeni@redhat.com, thomas.petazzoni@bootlin.com,
 nicveronese@gmail.com, kory.maincent@bootlin.com, mwojtas@chromium.org,
 daniel@makrotopia.org, dimitri.fedrau@liebherr.com,
 herve.codina@bootlin.com, linux@armlinux.org.uk, vladimir.oltean@nxp.com,
 kabel@kernel.org, romain.gantois@bootlin.com, f.fainelli@gmail.com,
 hkallweit1@gmail.com, netdev@vger.kernel.org
References: <20260201151249.642015-6-maxime.chevallier@bootlin.com>
 <20260203180311.2175469-1-horms@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260203180311.2175469-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Simon,

On 03/02/2026 19:03, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: phy: Create SFP phy_port before registering usptream
> 
> This commit moves the creation of the SFP phy_port to occur before
> registering the SFP upstream ops. This reordering allows passing
> the phy_port along with the upstream information to the SFP bus.
> 
>> net: phy: Create SFP phy_port before registering usptream
> 
> This isn't a bug, but there's a typo in the subject line: "usptream"
> should be "upstream".

That's aleady addressed in V4 :)

Maxime
