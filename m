Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1F1E868;
	Sat, 14 Mar 2026 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510482; cv=none; b=cStc3D3duQ2FOzLiMJEImLyNh4VWcTzIcEJy3ay2LpyXfX1C1ZvLEKZ85lODX0u4Iy65NPl8G6/vnLZazh2E3ZMhlga9FuJrbkh/VhW+6mlKCMVHoxL3Lrbcu5PBY/+V9ouSMQr2FdNOOGcpZjs2QfcgTqlyW0u7MqiZasfq8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510482; c=relaxed/simple;
	bh=v0zyPxPCpOoAY4XyWSxYcgCTeyTvB6peIZgOiKD+yQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXp3h64EcsNQi8sog6cKCL0ifuS7OQYlsdxz2pVtZEilWxGY2QqB0suSAAm6bfwzbM/TD9LZ70RNiZIZRCbrIC3J64Ch2kpUNVzsP+X2crFcpvmmwt+FQOq+SxDXbMd8YG4DkARgk8wYjddXXnssMKGCwQa6PlcvYJrdKBEvY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPd52y/4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPd52y/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAC6C116C6;
	Sat, 14 Mar 2026 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773510482;
	bh=v0zyPxPCpOoAY4XyWSxYcgCTeyTvB6peIZgOiKD+yQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hPd52y/4xbEUSFeuo/kwG3e0MtkiNnUjXs0bN6pnmLk+Mnmzkrs2ej6eSBYD7wquJ
	 oU7QSyYiBpDzosEe75a4iXvZkpEjPBEeZjavvVEKHhEddRgab9/mhAUF4B7l9hJJhb
	 pyED+c3Swhaw8YV9K9t0zEGbHYEc3Rd34rECvyENMFx17VhtWnP+2cFp0HG3ra2PCv
	 uPsSZIISW8QR9wMFzmH06peZFjuPV1uuzn64o02k3u53lG4usUyU3EcAbc47+JksJg
	 TPn9wHe2LOqQAEjL6YEdCFlszMufScu0zzUMC6CjTpiSvxAxMM9MyAHNCE3gdckoI6
	 6Evxe5K/FrCug==
Date: Sat, 14 Mar 2026 10:48:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Liang Xu <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: mxl-gpy: add PHY-level statistics
 via ethtool
Message-ID: <20260314104800.084fbaa7@kernel.org>
In-Reply-To: <bd75b95a4b78a0f60f2f550cc6cdf7807904e879.1773364582.git.daniel@makrotopia.org>
References: <bd75b95a4b78a0f60f2f550cc6cdf7807904e879.1773364582.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 01:19:07 +0000 Daniel Golle wrote:
> Report PCS receive error counts for all supported GPY115x, GPY2xx and
> MxL862xx PHYs.
> 
> Accumulate the vendor-specific PHY_ERRCNT read-clear counter
> (SEL=RXERR) in .update_stats() and expose it as both IEEE 802.3
> SymbolErrorDuringCarrier and generic rx_errors via
> .get_phy_stats().

This does not apply. The code itself LGTM. One question - the 8b
counter seems kinda narrow. I wonder if we should read it periodically
so it doesn't overflow? Could be an overkill tho, IDK what's normal,
I defer to PHY maintainers..
