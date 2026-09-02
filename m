Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53489372EE9;
	Wed,  2 Sep 2026 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367101; cv=none; b=ZrXsBlTo0tdqU3z0X6vVpO0g4jGlgYgv1my+iUGkLjkfdcJYm2c4mfFgbpLGITSK4fr2ysmM3E4Hi/Y7Tfcs6F3XInApxq0KIkF36aLvB90Wkf8661+3yBRcwwHSUujQUcUMwFPJt14Wx/AhemYTdP1KEX6GTOIqv1IluhpT0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367101; c=relaxed/simple;
	bh=Jiv/uvDhqSjmO+z4kgraUnXXSwMGtIxdXaplkk1LVxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7bt6Va+lHyPLqmNLu9VCO9MjLiRWQzSI9q0u21fKZTlwTAy7v7jLLBvr2IJxRiqM7MFDmgMJHwReT7aTT5UEwR01ZUWD4e/GJh8wlgSFAQY3Z0BZOVCQxgKl010m/LRe8sujCCA6XTM/B9APGxfbGLnaOH8BtJsGqJnZhiyJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VE+2OqCU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VE+2OqCU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EWeXWohaF0gzugvpU2x0ULJvddgDp8nmDFnaa9FuDxA=; b=VE+2OqCUf6vSFIEBMwIwZnbmys
	SyX+ZFN9kaqMrOFkZgwR9iqBlTYL1Zaf5B/EiR6GeDy6vKc26LhPHC/+l0m0mHcMOz1aMIA8y6V7s
	XOIej0TsVotjBXszzgpfsnQC4/MbhFxUjiDunBPGDBbOBrL+tA1sa/W9/kMwdEe+7xk0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1nyJ-002YOk-MP; Wed, 02 Sep 2026 18:37:59 +0200
Date: Wed, 2 Sep 2026 18:37:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Thu00e9o Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: macb: reject an unknown link speed in the
 taprio setup
Message-ID: <cb6da9c8-aea0-4740-9709-d718462481e9@lunn.ch>
References: <20260902080528.2211468-1-f@lex.la>
 <20260902080528.2211468-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902080528.2211468-3-f@lex.la>

On Wed, Sep 02, 2026 at 08:05:28AM +0000, Aleksei Sviridkin wrote:
> speed is a u32, so SPEED_UNKNOWN arrives as 0xffffffff and passes the
> "speed <= 0" check. A taprio schedule installed while the link is down
> then has its hardware interval limit derived from that value, a limit
> that rounds to 1 ns, and the first entry fails with a misleading
> "exceeds hardware limit". Name the case instead of relying on the
> sign.
> 
> Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index a43855db1e45..81530b9257b2 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4324,7 +4324,7 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
>  	}
>  
>  	speed = kset.base.speed;
> -	if (unlikely(speed <= 0)) {
> +	if (unlikely(speed == SPEED_UNKNOWN || !speed)) {

Can ethtool_validate_speed() be used?

    Andrew

---
pw-bot: cr
