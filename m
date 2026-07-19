Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB8D29405
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784441416; cv=none; b=hRNyah1MANqB1PcrspDUWpRwgfTQIqbBivYnwzui+/fStmaa0SQrqQFk+sb4jMWZUeURZ1JrXwpe36wd2sATqfbqV/6HdhuDVUSqHLrNObnpCoAWikHGkSkLN123RiLQ9uEPLHNb1di0T7ra2L5OAMIabNcJNYbNRWlo4843NcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784441416; c=relaxed/simple;
	bh=/n3YTvwRmG9LsJGiFUD9FzKAMNI7j7f4OM4/d1lFYU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAWILFN5v0RchHKndslR58jozu93NT+CMXF9os88fTchLpIFwphhhqK1+xaiPIAaEJmxN9WCjgGadYFNIBPgCUpxkXBS9ORnFAkf7HcjCV4GgvIlIxOs1Kem/9h1Yinisi2Gk+/kjsrLJrMRaAi44hl1aMLa8IxxC6DDGpPNvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wpMkk4zm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wpMkk4zm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 584611A1011
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 06:10:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1E2D0601A5;
	Sun, 19 Jul 2026 06:10:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57C3E11BD0C60;
	Sun, 19 Jul 2026 08:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784441409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Kmh/pShA1CEkT9iOhnylq71NWk9OFmZlNZWjbFsDhMw=;
	b=wpMkk4zmDMavcovEaFfKnXnI6bmiJLH/2fOV+LSCsresBaqCQHcP+roG0EKgYB5upP3pA2
	2wNics3IsKCyeHYC3NjP6K6nX6KTbODWTtv7yhK0LmzSDknhRH2FxWpitu1TKyg+HWZzZA
	8o7sMNYC+vkt9SxDuJdTWZaXj/nVGzOwTqOGtgkw+5+DfrWE5/ECr7VmGSE6mHMtmvFyX6
	dA+8v38fASky90/KpjWx5CGalrX8sYC2o0VQwnkChO5JnMjKdz2a797MyliV3Wg94hxFHm
	qwWhxVuuZ1cRwF2jOAxbyZM3X22MzOWLjyWnYscNI2SjkT4V9IssRRrIdBcOLA==
Message-ID: <eefe0521-86d3-44f4-ab54-bee29ea0fb56@bootlin.com>
Date: Sun, 19 Jul 2026 08:10:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question: MII media mux for external PHY/SFP combo ports
To: git@elinell1337.me
Cc: andrew@lunn.ch, netdev@vger.kernel.org, olteanv@gmail.com
References: <178442713834.7.10284519099797443296.1492041940@elinell1337.me>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <178442713834.7.10284519099797443296.1492041940@elinell1337.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Pavel,

On 7/19/26 04:12, git@elinell1337.me wrote:
> Hi Maxime,
> 
> Sorry for the duplicate email. The previous copy was rejected by the list because it contained HTML (default mode in Proton Mail).
> This is a plain-text resend.
> 
> I am working on upstream support for the Banana Pi BPI-R4 Pro 8X and
> would like guidance before writing any board-specific mux code.

It's still an ongoing topic for me, I'm iterating on the prerequisite for
proper MUX support that is phy_port (i.e. expose the ports of the mux
to users), the next series will be about muxes :) Depending on when the
current phy_port gets accepted, I expect that mux support will start being
upstreamed in a few weeks from now, I'll make sure to CC you.

In terms of testing, I have :
 - Combo-ports where both SFP and RJ45 are connected to the same PHY
 - Combo-ports behind a DSA switch (a Marvell 6190x)
 - Combo-ports with a mii MUX driven by gpio (turris omnia)
 - Dual-port RJ45 with 2 PHYs

> 
> The board [1] has two independent RJ45/SFP combo connectors. Each has
> one SerDes lane, a GPIO-controlled passive external mux, one AS21010P
> copper PHY endpoint, and one SFP cage endpoint. One mux is connected
> to an MT7988 MAC. The other is connected to an MxL86252 DSA user port.
> 
> The downstream policy selects SFP when a module is present and copper
> when the cage is empty. Each combo must keep one logical network port,
> its MAC address, and its bridge/VLAN configuration across a media
> transition. Switching either combo must not affect the other combo or
> the remaining switch ports.
> 
> I have downstream reference code [3,4], but it polls MOD_DEF0 and
> replaces driver-private MediaTek or DSA phylink state. I am treating it
> only as bring-up evidence.
> 
> The phy_port documentation [2] added by commit 62518b5b3d8e describes
> external MII mux topologies and identifies an MII mux framework as
> future work.
> 
> Does runtime MII/media mux follow-up work already exist or is it
> planned? If not, is phy_port the right starting point for a generic
> design that covers both MAC and DSA consumers?

Yes it'll cover both, the new DT binding will be generic, and the SW
support for MUX registration will be done directly by phylink. What
will be needed it the logic to drive the MUX

> 
> I can provide the exact DTS topology, downstream references, and a board
> for copper/SFP hot-plug, traffic, and concurrent-combo testing.
I'll CC you for the next iterations, what really helps if you need that
going forward is review and testing of the code.

Next revision will go out next week, and hopefully I can start sending
the mii mux work soon after :)

Maxime
