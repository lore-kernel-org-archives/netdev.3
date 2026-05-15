Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E0328616;
	Fri, 15 May 2026 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863227; cv=none; b=CmHCNXSx1JpRv29SRTSUtJBubZwg/OtsnD4nFXQ346r6rTtB5jqHjcRy9SWQwCG8mWwONLoEfPpIS8wJdxrwkRiHbYU9n/JSLyAK+qqSnZCcqz1ZYmxY712/rzswUi5BN3ruZNEnUjp0tyHHKQqirelcKYj+UxSnu7R+nlvWrVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863227; c=relaxed/simple;
	bh=MK0lOoOb01ATL1ybllX6LaYNKeJXRCfHdg7GjnhodWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY2oPluN9dI7RDyTo09OI/+0YtyQCukBQriVT92JbrltAd3XBuYnD5PimC0L9nciewfoQsdc6hv/1aqdeu7/K/jyUBtAq4t+umNUH3RSSL296A8YSxjbfYOAABejkFdfH3flEabVlwd2K5qm87bZXhE08KLcPAYAkCPCf7JjSVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLE3f5vb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLE3f5vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2229DC2BCB0;
	Fri, 15 May 2026 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778863227;
	bh=MK0lOoOb01ATL1ybllX6LaYNKeJXRCfHdg7GjnhodWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLE3f5vbh8c/Kfzkv8oDOLjrGyecegLfqPgZVupwaKJZoOuR6fRqtk5SsJqmZ6Zo6
	 NLsuPml9je1MnrW+5sPBikXt7As0UZdwWwZLwDvxu/PR1QBf2sT1x/bkVgaOF/dsDc
	 FgTBUDahQWBsI1O7lUaUTsHgIHgHIxW46Cg3mLy1lKMhKWsJ6b/HK8vTYYJAVLSMf0
	 QDxbg53J4FcM4aQTlFip+BTiqe1g2gMkGoEEbwl/erSbxogiZnFOSWU0j4IMMMTAZz
	 robT9EwrnAXSDIq8m4ygch3KGxVzu6EtrY+RztGq9TryUIaO6fYR8d2jp0vyg85o8f
	 81oE8kfqIz7Jg==
Date: Fri, 15 May 2026 17:40:22 +0100
From: Simon Horman <horms@kernel.org>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no
Subject: Re: [PATCH net-next v7 2/2] net: sfp: extend SMBus support
Message-ID: <20260515164022.GD227382@horms.kernel.org>
References: <20260507093301.1144740-3-jelonek.jonas@gmail.com>
 <20260510164741.1401430-1-horms@kernel.org>
 <d2a56757-8e57-4c06-91e0-dfd33855ad86@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a56757-8e57-4c06-91e0-dfd33855ad86@gmail.com>

On Fri, May 15, 2026 at 03:55:22PM +0200, Jonas Jelonek wrote:
> Hi,
> 
> On 10.05.26 18:47, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> >
> > [ ... ]
> >> @@ -756,50 +757,110 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> > [ ... ]
> >> +static int sfp_smbus_read(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
> >> +			  size_t len)
> >> +{
> >> +	union i2c_smbus_data smbus_data;
> >> +	u8 bus_addr = a2 ? 0x51 : 0x50;
> >> +	size_t this_len, transferred;
> >> +	u32 functionality;
> >> +	u8 *data = buf;
> >> +	int ret;
> >> +
> >> +	functionality = i2c_get_functionality(sfp->i2c);
> >> +
> >> +	while (len) {
> >> +		this_len = min(len, sfp->i2c_block_size);
> >> +
> >> +		if (functionality & I2C_FUNC_SMBUS_READ_I2C_BLOCK) {
> >> +			smbus_data.block[0] = this_len;
> >> +			ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> >> +					     I2C_SMBUS_READ, dev_addr,
> >> +					     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
> >> +			if (ret < 0)
> >> +				return ret;
> >> +
> >> +			memcpy(data, &smbus_data.block[1], this_len);
> > Can this sequence leak uninitialized kernel stack memory to the output buffer?
> >
> > When performing an I2C_SMBUS_I2C_BLOCK_DATA transfer, i2c_smbus_xfer()
> > updates smbus_data.block[0] with the actual number of bytes read from the
> > bus upon success.
> >
> > If the adapter or device returns fewer bytes than requested (a short read),
> > smbus_data.block[0] will be less than this_len. Because memcpy()
> > unconditionally copies this_len bytes, it appears it would overrun the valid
> > data and copy uninitialized memory from the smbus_data stack variable.
> >
> > Since the SFP EEPROM data is accessible to userspace via ethtool, could this
> > expose uninitialized kernel stack memory to userspace?
> >
> > Should the code verify that smbus_data.block[0] == this_len, or use
> > smbus_data.block[0] as the actual transferred length?
> 
> Valid point, indeed uninitialized memory might be leaked here. I wouldn't
> use the proposed fix though. Maybe I missed it but It doesn't seem to be
> the contract that I2C/SMBus drivers need to update that field after read.
> So using that for a check seems wrong. As a fix I will just make sure no
> uninitialized memory is leaked.

Yes, that sounds good to me.

> 
> If there are other suggestions please raise your hand, otherwise I'll
> sned the follow-up soon.
> 
> Regards,
> Jonas Jelonek
> 
