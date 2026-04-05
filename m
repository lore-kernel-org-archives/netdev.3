Received: from lan.nucleusys.com (lan.nucleusys.com [92.247.61.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727620DD51;
	Sun,  5 Apr 2026 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.247.61.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775379147; cv=none; b=TULtAi6jR4Ta6gr4oZPZFn03dZ72ix7iZaf0ZSYj1/ZOQP3eSTnjX0f7nYVXLCEC4zdJWlnNRCU1mqVOiD7WahEx2ZnI/sxEoXZL+A3TJ0QI+FDUj7UR2pE2bv0sOOKwlS1ewut7ngangvc1qWBAX+6Vej9Y5Br0xQWEEtnJG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775379147; c=relaxed/simple;
	bh=OKoadIezLR9fls5peFlE5geaTEC8IlLCUpmduXA0xCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4IMVi/JiGkbqmSzn201n0PvBpxhm3EsH5xgpQEqurhzrDvR+uGUNE/RnJZAciy2/gkXx+GStJRAAcA/IpuWaiDI/V9ayaXtvJaL7UFXt8Kp3ZbR2A0V9TA/yy1uelLQcywphJIkuWlkJey/TDfZ0d+BUsbhSt9JY1WSzZd65Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com; spf=pass smtp.mailfrom=nucleusys.com; dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b=CSPqR4Jc; arc=none smtp.client-ip=92.247.61.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b="CSPqR4Jc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nucleusys.com; s=xyz;
	t=1775379135; bh=OKoadIezLR9fls5peFlE5geaTEC8IlLCUpmduXA0xCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSPqR4JcWDAo9vZIBCRiPB2NM/m7bDSNv7UrbzT4e5h1jMd733w9uHGPcWzrPm+6d
	 lwGa49F/QAeoJRJEOO+siTtOLRc/ZbZ/p3dY6IKRYOsgUZuu+2Bp7PD5IWpLzS0Kwz
	 wjeI13R/2hAI5qFv9x+S18nIEgDArL8cPdV1O4KITBsG5OUACB21Aze7ZH41fXQO/O
	 oTPuL/JCpNwGiXFDl7Ptj9A3A0LRviSaBM1hsdeDZ6RF/HAvEzoRJ5DtyuYr0SJk8W
	 5WAi3NHRnXyFbKUmZGAGnbFCLcFxJAimM6p7Y+A+L4jSd9M1MCEqbbAI51jm1W9Xaa
	 SXm5KEv2UqjgA==
Received: from cabron.k.g (186.red-193-153-12.dynamicip.rima-tde.net [193.153.12.186])
	by lan.nucleusys.com (Postfix) with ESMTPSA id 458DC3FB72;
	Sun, 05 Apr 2026 11:52:14 +0300 (EEST)
Date: Sun, 5 Apr 2026 10:52:12 +0200
From: Petko Manolov <petkan@nucleusys.com>
To: Simon Horman <horms@kernel.org>
Cc: Morduan Zang <zhangdandan@uniontech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: rtl8150: avoid using uninitialized CSCR value
Message-ID: <20260405085212.GA8491@cabron.k.g>
References: <93FF85BB9F33CD2B+20260402070743.20641-1-zhangdandan@uniontech.com>
 <20260403154538.GA187715@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403154538.GA187715@horms.kernel.org>

On 26-04-03 16:45:38, Simon Horman wrote:
> On Thu, Apr 02, 2026 at 03:07:43PM +0800, Morduan Zang wrote:
> > Check get_registers() when reading CSCR in set_carrier().
> > If the control transfer fails, don't use the stack value.
> > 
> > Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
> > ---
> >  drivers/net/usb/rtl8150.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> > index 4cda0643afb6..7e32726d3e6f 100644
> > --- a/drivers/net/usb/rtl8150.c
> > +++ b/drivers/net/usb/rtl8150.c
> > @@ -722,7 +722,11 @@ static void set_carrier(struct net_device *netdev)
> >  	rtl8150_t *dev = netdev_priv(netdev);
> >  	short tmp;
> >  
> > -	get_registers(dev, CSCR, 2, &tmp);
> > +	if (get_registers(dev, CSCR, 2, &tmp) < 0) {
> > +		netif_carrier_off(netdev);
> > +		return;
> > +	}
> > +
> >  	if (tmp & CSCR_LINK_STATUS)
> >  		netif_carrier_on(netdev);
> >  	else
> 
> I wonder if we can handle this a bit more succinctly,
> while still making it clear that the error is handled.
> Something like this:
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index 4cda0643afb6..816759ced56c 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -722,7 +722,8 @@ static void set_carrier(struct net_device *netdev)
>  	rtl8150_t *dev = netdev_priv(netdev);
>  	short tmp;
>  
> -	get_registers(dev, CSCR, 2, &tmp);
> +	if (get_registers(dev, CSCR, 2, &tmp) < 0)
> +		tmp = 0;
>  	if (tmp & CSCR_LINK_STATUS)
>  		netif_carrier_on(netdev);
>  	else

I was wondering if calling netif_carrier_off() is the right thing to do in case
get_registers() fail.

There are multiple get_registers() calls that don't check the error and if we do
this in set_carrier() maybe we should do the same thing across the whole driver?


cheers,
Petko
