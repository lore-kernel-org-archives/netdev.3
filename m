Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6640D57D;
	Sat, 27 Jun 2026 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521197; cv=none; b=VQRs16vU4dvtqVkCsYx/FhZPKV5R/BN9HZPEt6ZW70qOE00s+zVmnAz+9n5YA5Jgevl6sVKt8RCsBaK3boSWn4s/5dpQR5ApqRGmVaik1PiLz/XdhIpMduZvG1h7J4Sr999EtkhlyXv/NAwrLsVGt+sBdbcNFHeTpIWwip2RmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521197; c=relaxed/simple;
	bh=NWuSmhMmyeLgLdiGZL9kRFiRj045XoP70lSp+zhpnFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5NzBuUWSRgPKKGYIm7mrEG9LdfuMbRfxKJbOzNCIfoTUVJiDq14jjAkylxWop8G7K8WGICeSnLbWr+24eh7wzYNb5MMS8fqu2kpSX8SvwCdjC5bMWURGjBzFGV0YU0NXWp2uh+//ZmnByK8MmbW4Kky1X0obPikMepcpmwNAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPuKfqkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPuKfqkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BBE1F000E9;
	Sat, 27 Jun 2026 00:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782521196;
	bh=RpncTxnbJ7Ss8uCIuHkdvpbtV/TGKZbOx7F+JNIfP9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gPuKfqkVq1sUTk1El35/d1fRnIADgNgxf+pwhC6C32OxcZ19+orIpfPXA4cRM0d7P
	 agUC0Ng41AlBCKQ5CPGkq9eFLhBB2XmVzYDjkohtqWDDs6dhn/dle3NAcfNs7ZVZ9Q
	 13/G+VQnSrb7Yhk/Dn/bTVeGLkpJSwqtIraVhmSq957WfZ/R5FVNS5tSGyNX1xJ29i
	 N7Oys4yCOszTyY4cr/teRqivJqwDV/dnCeItJMBsMo9uDf+Xo4SfsnwFVOrl8gKGuB
	 VxB8mOJ4+1nmsTGmUGBtWIn9rPpY+9qiDovAkoRCpGPd27xmNLs+gLYvqs2Xb09JD2
	 M8cQSgI2uVPyw==
Date: Fri, 26 Jun 2026 17:46:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Corey Leavitt
 <corey@leavitt.info>, Jonas Jelonek <jelonek.jonas@gmail.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: decouple controller lookup
 from MDIO probe
Message-ID: <20260626174634.1fd06473@kernel.org>
In-Reply-To: <20260626165929.2908782-1-github@szelinsky.de>
References: <20260626165929.2908782-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 18:59:26 +0200 Carlo Szelinsky wrote:
> Subject: [PATCH net-next v3 0/3] net: pse-pd: decouple controller lookup from MDIO probe

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.2,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after June 29th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed
