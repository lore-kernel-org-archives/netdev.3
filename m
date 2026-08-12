Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51643ACF04;
	Wed, 12 Aug 2026 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542081; cv=none; b=TTYuQedaYe72D06YAiacSzljpkPFSK71MrT8ZjawQjuLapQUzbfHYz+UyCRhsaBiser56FjbRe5D6NsLEAUQE+8VUM5woANRAqKpVt9TBmyJ4Ne9DEGrHArfrTM259k9QAtqsugpIygsfd7JBn2SXbV7c7jCB5kg9KkzklYfxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542081; c=relaxed/simple;
	bh=jdMxm6VOc2CDxbTzRbRwNeLpZCDzlr+TuHGjsca/scA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV0IWj9neNQboumL2nmcWTW4cBolRVprbF3WnFUvZS/5wvZSgYrh0rTQsHqF7roCHJw/MJrrNmhmnIQoVpoGrAiVjAFTBtqiR+0oKdQ9dbGV6a/8Px3ZUhJU5SlHMy4iVMyS2aVCQCJmY0MppiTx2kkhpEJSk5LcdhkEItEUfLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VRB3ntXK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VRB3ntXK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H5lzxPX1S6HpYAx8FiJBOcWaGdrknD9jTB0fM4YeOJI=; b=VRB3ntXKxHSKUahFaYeM9VTEWW
	1BFu2pV6QwKJXewn8l1zT66jNoRc0Vmc0m8vyVM9zNKFGgGBgzf342cTyCkbdZzRKPXiJjX/t7PPf
	C7iX9sGWZTwwVIGZY41psaCCVbzfiHH1/vf8b5533eRu4/3MRc7Bu53H9svDCwwakcps=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wu9CX-00HH5B-Cs; Wed, 12 Aug 2026 15:41:01 +0200
Date: Wed, 12 Aug 2026 15:41:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v1 1/2] net: phy: split phy_probe() error paths
Message-ID: <46ae1474-5abd-4908-9955-a364ec3e2f99@lunn.ch>
References: <20260812125127.106255-1-xuanqiang.luo@linux.dev>
 <20260812125127.106255-2-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812125127.106255-2-xuanqiang.luo@linux.dev>

On Wed, Aug 12, 2026 at 08:51:26PM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> phy_probe() uses one cleanup path for failures at every initialization
> stage. This runs cleanup for resources that have not been initialized
> and leaves phy_setup_ports() relying on its caller to remove an SFP
> upstream after a partial failure.
> 
> Make phy_setup_ports() unwind the SFP upstream before removing its ports.
> Then split the phy_probe() cleanup so each failure path unwinds only the
> resources that may have been initialized.
> 
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/phy/phy_device.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 0615228459ef4..f8e434daab66e 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3556,6 +3556,9 @@ static int phy_setup_ports(struct phy_device *phydev)
>  	return 0;
>  
>  out:
> +	sfp_bus_del_upstream(phydev->sfp_bus);
> +	phydev->sfp_bus = NULL;
> +
>  	phy_cleanup_ports(phydev);
>  	return ret;

This does not look correct. phy_sfp_probe() may fail, and you then
call sfp_bus_del_upstream() on something which never happened.

Also, it is not obvious that sfp_bus_del_upstream() is the correct
thing to do. You are trying to undo phy_sfp_probe() so i would expect
you to call a function like phy_sfp_release().

It also looks like phy_sfp_probe() does not correctly clean up on
phy_setup_sfp_port() returning an error. But that is a different
issue.

    Andrew

---
pw-bot: cr
