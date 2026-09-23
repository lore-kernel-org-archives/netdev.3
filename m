Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052F37DE9B;
	Wed, 23 Sep 2026 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131376; cv=none; b=UhNGmrA+YqxC4o6JDIhdO+0Ow3UHFSHEl7CAEB4A+EDaeNUxyQ8rA8sDAsqswbEOzxJ85eU04v19yD/xbFCMYpG3LeD1RB1yWcArBy/po05k0vu4gNjIwvcGGRIJdS3o8hlnA6fvSI6K9NO01M7g/z4uBJiQP5zMJ/ylE10WS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131376; c=relaxed/simple;
	bh=vJb9uf/jdi3jbki6AlcOolFNNk6fxf/X4UTvtcdcgs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJO8hbwPrMjJAQwrR3/7AzlN3p6m9j0YUH/KukIEP/tI1rlImNxRiyU8AcllPCRUfZXyVy2B6hRJTaq6nPWHCnaJHqmeYIvjmbXBx8PNqKDRb1WcLx+aHuiBRLpeGXKWHn5QRgWooo+j764wBYfsPnVGIcNSqQTiCMcF9z3KfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ6Wb4c8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ6Wb4c8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CCD1F000FF;
	Wed, 23 Sep 2026 02:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790131372;
	bh=FTFpAHh4tW3apuxYTeVsLcNRDuDDUhJPLdMX2YZxx30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CJ6Wb4c8CX7La0KYXfPThYZR4K/rirKYFKbKZIcsAtH6zPSuaKCVjL5WwwvLR+zUw
	 vTTG1utBFyyIw2l44lYStjKB+wD2PJTdjaYzTBxTcZ9HE6tKomx7IDoIIpsMGCH8Kv
	 DRvJlAQp4zNsn0ZD1Q/3heNOtuaFMwYqr/Zhrm/fcBYEg045cwbx/xljUpda8CfkzE
	 b2idF6Bg3FFs/Y/ayObDFBJEtR2jcSuj0pnjTtWxah36uszN9/jHu7x8eQsnBA4fXg
	 QR1bQlODSdgzNaTjoslsgx3EuxeyOkpBB71vbD+ITC4Cjbzal8T1XOAL7AluItOYLJ
	 ppPD1nS6ceROw==
Date: Tue, 22 Sep 2026 19:42:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Florian Fainelli
 <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: Introduce a selftest
 for ethtool flow control
Message-ID: <20260922194251.06e00e2e@kernel.org>
In-Reply-To: <20260920164732.349744-2-maxime.chevallier@bootlin.com>
References: <20260920164732.349744-1-maxime.chevallier@bootlin.com>
	<20260920164732.349744-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Sep 2026 18:47:27 +0200 Maxime Chevallier (Netdev
Foundation) wrote:
> Future ethtool selftests are expected to use the same, these helpers
> are put in the net selftest lib.

Please resist the urge to create libraries.

If you're doing this I suspect you didn't even read the README and=20
you expect people to search around for libraries?

Put the code in your test, the duplication doesn't matter.
If you _absolutely have to_ you can create a local lib under
tools/testing/selftests/drivers/net/hw/ but please think really=20
hard before you do.

> +    :param cfg: test config

If you have nothing to say - don't say anything =F0=9F=A4=B7=EF=B8=8F

> +    :returns: tuple containing :
> +              - return code of the ethtool command,
> +              - rx status,
> +              - tx status,
> +              - aneg status

Have you seen much code in netdev selftests using this style=20
of comments?

> +        defer(cmd, f"ethtool -s {cfg.ifname} autoneg on", fail=3DFalse)

Why are you putting fail=3DFalse on the defers? IIRC defer errors are
logged and ignored. Is ethtool reporting an error when there's nothing
to change?

Those are just some things that immediately jump out :)
Please also fix the pylint --disable=3DR issues?
