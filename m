Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999085;
	b=h5mYVmy8oCZOASqLM+Pu4PBPZigflyxsqqtiTuJLFZe/1rt/kTPUR0QcYRqawWzZNPOL
	 T/0ouvQ5oY9INe7Uqmf6ViWp9Gpmwt04t6fleSxojuVpxOjoXAiP5AvZebP5r3PhrNHSE
	 I3zWvodmQnzgrfc5h/Vjdx9We3htHvUXgDy94NIFHOPXcviz7BBfIU41eE9yDz5RkWuIg
	 2l1xssvL4HBEL9M9KRXo6ZVNXM/kZiaX0rupNuidoL4P+r8pbWUx2UA2wYm1lOmbdsiQH
	 gkYrhzjSrm5oLe2lA7PrAPz41AXgyRlXXz/EuhfeFk3upr4wKkljXWyScsN3/w+54Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999085;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9mCSh537Zkc+/ONs3x2e17S7D98n9pmc/4cO5WOehrg=;
	b=slMhkJqeQ8u/82KIhDrvbNCo/s7Ms3ZTUE7u8ZeD2sIaVwWFnts2sdcLaDMwdobXxebm
	 PFvT3i3kjzff8WN1tPfnnPtUUFRsydnpZ/SiEZGhHc/QpjA2UmzG4U15n4yaW1Y5RgIi2
	 gYEJHWULh0rPSLBRz8CRawZ/5na/pTnNN+Jjgts6Zq0hK5pMnbQsyLkol8XtkN+yu+DKH
	 UH1F9+EOGDP81tUfpwclYCxv9LZt1QuMBfTGShdDbRSv+EI4iknvLKGbEy6WIJnqulpJy
	 ksteMvngLXNB9yddAYRrgPgr91PzribfW4atciRHYhI9vIuizORrBDV2jQQLofCmqrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTXFCK7J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB9C6083606;
	Fri,  6 Nov 2026 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTXFCK7J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0F81F00900;
	Fri,  6 Nov 2026 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999085;
	bh=9mCSh537Zkc+/ONs3x2e17S7D98n9pmc/4cO5WOehrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nTXFCK7Jc+NTi8DsdFSnKpsTSYiR0EiS80aHQjEiSi3hWiS8rGRqGMbGIjDc7ypdk
	 jic6wILiR9Ven4Zdv+oRYeiuo/FsLjienATkzwOlxOcESC3psfpemR2N47BmQ6NWmo
	 dyItIFYQVBVx8JlQSN9vuxohag9Uw0Wz7w1XIqEPWf7VVdgK8TiO5B5dEBKvKvlHwl
	 tTtUEXwJVTxBqg5ZDYMNrknrDPfVLpT5fOV0pA03cYBsgwI2GM+RFGeL+SVPSAZ0Tb
	 LQI64lX6ru2lcPMLPw3J0+zjR+ML3n2ZigVi+7xvNnUYCdJ3IUth7JOWkv755VOhhe
	 PNJssHfgQeoTQ==
Date: Fri, 6 Nov 2026 13:04:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Romit Sagu" <romit@romitsagu.com>
Cc: <netdev@vger.kernel.org>, <linux@armlinux.org.uk>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [PATCH net-next] net: sfp: add quirk for OEM
 SFP+ONU-XGSPON
Message-ID: <20261106130442.5ad3327b@kernel.org>
In-Reply-To: <20261103011849.181392-1-romit@romitsagu.com>
References: <20261103011849.181392-1-romit@romitsagu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 01:18:42 +0000 Romit Sagu wrote:
> This XGS-PON ONU stick (vendor OEM, part SFP+ONU-XGSPON)
> needs the same handling as other Potron-based modules. Without it,
> the module fails to connect and the kernal shows these errors:
> sfp sfp1: module transmit fault indicated
> sfp sfp1: module persistently indicates fault, disabling
> 
> This module requires TX_FAULT/LOS behaviour and boot delay tuning.
> Add a quirk using the existing sfp_fixup_potron.
> 
> Signed-off-by: Romit Sagu <romit@romitsagu.com>
> ---
>  drivers/net/phy/sfp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 85e57a16bb52..9435b25b54c9 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -623,6 +623,10 @@ static const struct sfp_quirk sfp_quirks[] = {
>  
>  	SFP_QUIRK_F("YV", "SFP+ONU-XGSPON", sfp_fixup_potron),
>  
> +	// OEM SFP+ONU-XGSPON is a XGS-PON ONT stick with broken TX_FAULT
> +	// and slow startup, just like potron.
> +	SFP_QUIRK_F("OEM", "SFP+ONU-XGSPON", sfp_fixup_potron),
> +
>  	// HORACO HC-10GE-113C uses Rollball protocol to talk to the PHY.
>  	SFP_QUIRK_F("OEM", "HC-10GE-113C", sfp_fixup_rollball),
>  

PS. AI also suggests mentioning LOS in the comment, since you have to
respin

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103011849.181392-1-romit@romitsagu.com
