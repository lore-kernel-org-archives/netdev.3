Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A173B5DE9;
	Sun, 11 Oct 2026 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791727414; cv=none; b=XOJeBW7a5Z5/QfkbW73fmgyO7tFZ6OM9YieOa9w+SSDdqkqJyzuWOrcvkZOOtn1yA6ItRRffUbKq47hdZNoIdNMLEEvP5AwzA/6XXC+S5AOzZ3CdE//P5gFfZM8Re3dEKde4kvIEjH1gM6uy8y9gzE/vLIYPTvKCvyUTLNUTrgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791727414; c=relaxed/simple;
	bh=9uqDncAMTl5P2VSMH/pHdeIOoyPmNYjmmYJ61B9M9kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CivU3ZBp53szdB0ADmBxYbkRWua2LOMbnegQChCAD62p5K3KL9fjpGhldqKYvg6QKzc9RlDSiWk9ocHHVkihprTZpLzDUoR9ZS/U22YYiMEvc3VcMm8nxAXtvyG9kP2My6P7ZU2d24+H+gnm+iadFBU+KUKBhmMT1eroaEAWBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FU4ghXFY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FU4ghXFY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kvVGXdUzefD5UnSYSHpYeKXkvrjPwC2QJQ3YuSj4xLw=; b=FU4ghXFYbQwlJ3yejskGS5D2iX
	zf7Fkeot93FMBiCOmXmm/H3TYIYATmwcex/mITM2Fpapjo/k8UjLkamciQxm6spuS5XbwPRTc03Wm
	0tu/aFYaq9b05YL2V+TGIfQ8RK/9/PXzR8DCdRzisHGv7l5JJO7Xan/HP12XoWNZW+9M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xFu92-00A6Ww-18; Sun, 11 Oct 2026 16:03:20 +0200
Date: Sun, 11 Oct 2026 16:03:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Clark <jjc@jclark.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: mdio: add timestamped write operation
Message-ID: <af97fa4b-d817-4e8b-bbd7-aaefa23d4d7a@lunn.ch>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-2-jjc@jclark.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009143506.2507607-2-jjc@jclark.com>

> +/**
> + * __mdiobus_write_sts - Timestamped version of the __mdiobus_write function
> + * @bus: the mii_bus struct
> + * @addr: the phy address
> + * @regnum: register number to write
> + * @val: value to write to @regnum
> + * @sts: system timestamps bounding completion, or NULL
> + *
> + * Return: Zero if successful, negative error code on failure. Returns
> + *	   -EBUSY or -EINVAL if the system timestamps are not valid. If @sts
> + *	   is not NULL, -EOPNOTSUPP is returned only if
> + *	   mdiobus_supports_write_sts() is false.
> + *
> + * Write a MDIO bus register, with system timestamps bounding completion;
> + * a transfer is considered complete on the rising edge of the MDC
> + * that clocks the last data bit. Caller must hold the mdio bus lock.
> + *
> + * For clocks that can be stepped, validate the clock generation through
> + * the raw time of the upper bound.
> + *
> + * If @sts is NULL, perform an ordinary write.
> + *

Please don't do that. We don't want drivers calling this when they
don't need to.

> +		if (!ktime_before(now.monoraw, sts->post_sts.monoraw))
> +			return 0;
> +
> +		/* Cap the wait at 1 ms, which is more than any single
> +		 * write's delay. This guards against an aux clock being
> +		 * disabled and reenabled, which restarts its raw time.
> +		 */
> +		if (!ktime_before(ktime_get_raw(), deadline))
> +			return -EBUSY;

A bit banging MDIO bus might be slower.

Also, i've not thought about the mux case, where the write gets
blocked until some other operation is performed on the shared hardware
of the mux.

> +	/**
> +	 * @write_sts: Perform a write transfer on the bus,
> +	 * with system timestamps bounding its completion. Set only
> +	 * if timestamps can always be provided. Must not return
> +	 * -EOPNOTSUPP.
> +	 */
> +	int (*write_sts)(struct mii_bus *bus, int addr, int regnum, u16 val,
> +			 struct ptp_system_timestamp *sts);

I suggest putting C22 in the comment. At some point, somebody might
need C45. And that gets complex because of C45 over C22.

Is there any need for read_sts?

	Andrew
