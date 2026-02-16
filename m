Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33A1C3BEB;
	Mon, 16 Feb 2026 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771221486; cv=none; b=sFsELFuWYUxadVE2V/mFKcNnRtXaUBRJVdkWCT7QQyPM2CVdOM4ZlEDRuM6HZukqaTTGY+8GeoqhX7R122iAW8mt3R1oc5NbFJvoZSG0WHmweUq3SS/a4BLtccsW2CNPLd0ayzEO0oDL/Yx8I0P28OjYa/Ri1KXUum38gcjiz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771221486; c=relaxed/simple;
	bh=S7LLKBzs/5OSn5yVqH6sE8ECiA829uB0vrw7fcy1/uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atqhDHys6jRaC6+CdVBl7HHrtvYcxy4ps5bJ1SY3e5ZF+76ilCL5B06TW2Z96AgB1wkgKtdY9B2f8GLZvct25M6jSSfbqe5SEuGPhCz2CKwGD5we04TYfM6HYtxpwNkU9u0X6+OpKh+lk5ATEwshkXFRUavNyqXpkowGJ0M61Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1bXeTiF9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1bXeTiF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEA0C116C6;
	Mon, 16 Feb 2026 05:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771221486;
	bh=S7LLKBzs/5OSn5yVqH6sE8ECiA829uB0vrw7fcy1/uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1bXeTiF9yIS+rNu7XFca9IZHoN5sv2fmwwYKwHMfBkxSqKZBy2u88RNpu5EaEJpjj
	 o6oIWf9Rgv++SWuQcSrp3kCwm73ERmDdYFfb0yf4b0Tu89SdAu06XsScROQUWJhxzh
	 mZuSYbb1uR9kgonNAQX73abe2kLg0pd6fPs9EKHc=
Date: Mon, 16 Feb 2026 06:58:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin =?iso-8859-1?Q?P=E5lsson?= <martin@poleshift.se>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: lan78xx: scan all MDIO addresses on LAN7801
Message-ID: <2026021651-helpless-chirping-5eaf@gregkh>
References: <0110019c64da3c2a-d4a4adbe-c78b-4051-a95b-e7ed5db247a1-000000@eu-north-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0110019c64da3c2a-d4a4adbe-c78b-4051-a95b-e7ed5db247a1-000000@eu-north-1.amazonses.com>

On Mon, Feb 16, 2026 at 05:09:09AM +0000, Martin Pålsson wrote:
> The LAN7801 is designed exclusively for external PHYs (unlike the
> LAN7800/LAN7850 which have internal PHYs), but lan78xx_mdio_init()
> restricts PHY scanning to MDIO addresses 0-7 by setting phy_mask to
> ~(0xFF). This prevents discovery of external PHYs wired to addresses
> outside that range.
> 
> One such case is the DP83TC814 100BASE-T1 PHY, which is typically
> configured at MDIO address 10 via PHYAD bootstrap pins and goes
> undetected with the current mask.
> 
> Set phy_mask to 0 for the LAN7801 so that all 32 MDIO addresses are
> scanned during bus registration, allowing any external PHY to be
> discovered regardless of its address.
> 
> Fixes: 02dc1f3d613d ("lan78xx: add LAN7801 MAC only support")
> 
> Signed-off-by: Martin Pålsson <martin@poleshift.se>
> ---
> Changes in v2:
> - Added Fixes: tag
> - Link to v1: https://lore.kernel.org/r/20260214-lan78xx-phy-mask-fix-v1-1-3baa100861e4@poleshift.se
> ---
>  drivers/net/usb/lan78xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 00397a807393..9d8f1ff7028d 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -2094,8 +2094,8 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
>  		dev->mdiobus->phy_mask = ~(1 << 1);
>  		break;
>  	case ID_REV_CHIP_ID_7801_:
> -		/* scan thru PHYAD[2..0] */
> -		dev->mdiobus->phy_mask = ~(0xFF);
> +		/* scan all 32 MDIO addresses for external PHYs */
> +		dev->mdiobus->phy_mask = 0;
>  		break;
>  	}
>  
> 
> ---
> base-commit: ee5492fd88cfc079c19fbeac78e9e53b7f6c04f3
> change-id: 20260214-lan78xx-phy-mask-fix-a4260de15a4c
> 
> Best regards,
> -- 
> Martin Pålsson <martin@poleshift.se>
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
