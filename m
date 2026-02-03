Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2467A3644A0
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142301; cv=none; b=mOiyOGxbZlsuBEZOxvnCc/b7gNGYmAW3jPsbECZRWSg1ydsNmJoP2tKVfucakwDLXi15vnGUvDCfSh/+621JO5Rh8LWeQB9iEQZBzgfYEAn3bAZisSr0kcaUjU0uEDEyKXmwsSLFNHYY4RBMNi9d3ME4J0bhOFPU2pTmtkTJfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142301; c=relaxed/simple;
	bh=GdXUXaELabW47pyAqEei6y9IzjZ5ijZqiOVtAz+8u9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZ7j1tvyiu9vRstjl+NJctLw2sO0dRGQfsuSbyCKslq5u1dVQ6GLi4DQOvU5OVrGjMmG5dLLSV6+5EK+q1UAGFwpdWM53RgTW6CCsa41aHWVa3OXQ4rA92mNvPtoMgnK+PgCWoxVQwOUklpaMWawmz9lwqrZ+UOQZjqG+txWOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kms6Q35K; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kms6Q35K"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9C6854E423E4;
	Tue,  3 Feb 2026 18:11:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69B1260728;
	Tue,  3 Feb 2026 18:11:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D6AD119A8888;
	Tue,  3 Feb 2026 19:11:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770142297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=hKEzJiCJRQMcpRsvbFlhBZR3MXysEs3/7WuHOZgjpjY=;
	b=kms6Q35KjtRoblKVI6glY2iESh7WWUDMed8Ly2o8NjcZdUPhloAy7nxB1kyjBLvlbSnBay
	f6DaPJW+/HYsWf9pxolFv+ChWwATbcMu3ObD1GusbN8huMeDoX4kIhBwGWrKV630eT/Drm
	0JAEciGvQGw09ecU7P8eRiVZQ+/al8z/IbiMY9W6ahIw8OykMsDeYUpZGi00CaWMxzFlgD
	70izgv8DaCiMjXi9hUhOgEEFyBuu7dOTEP4YxaBmlXgwvyLsE4beqZhGcLK/0VMf28qn7k
	MY1yw38LZeMAnepqKvjXWuECXX3+bqD5liRiq14dqA4aWF+wofoYs5Qr7gvblg==
Message-ID: <669d63db-2507-4020-bfe7-319159b710d5@bootlin.com>
Date: Tue, 3 Feb 2026 19:11:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v3,03/11] net: phy: phy_link_topology: Track ports in
 phy_link_topology
To: Simon Horman <horms@kernel.org>
Cc: hkallweit1@gmail.com, nicveronese@gmail.com, f.fainelli@gmail.com,
 pabeni@redhat.com, edumazet@google.com, dimitri.fedrau@liebherr.com,
 thomas.petazzoni@bootlin.com, kabel@kernel.org, kuba@kernel.org,
 vladimir.oltean@nxp.com, andrew@lunn.ch, davem@davemloft.net,
 romain.gantois@bootlin.com, linux-kernel@vger.kernel.org,
 o.rempel@pengutronix.de, linux@armlinux.org.uk, kory.maincent@bootlin.com,
 mwojtas@chromium.org, christophe.leroy@csgroup.eu, herve.codina@bootlin.com,
 netdev@vger.kernel.org, daniel@makrotopia.org
References: <20260201151249.642015-4-maxime.chevallier@bootlin.com>
 <20260203180250.2175436-1-horms@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260203180250.2175436-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Simon,

On 03/02/2026 19:02, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

> 
> xa_alloc_cyclic() returns 1 when ID allocation wraps around, which is still a
> successful allocation. The check at line 126 above correctly uses `if (ret < 0)`
> for the phyindex allocation:

I already reported that to Chris, this review is incorrect.

xa_alloc_cyclic() doesn't return 1 upon wraparound. __xa_alloc_cyclic()
does :)

Maxime
