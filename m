Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AED448B95;
	Fri, 28 Aug 2026 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787923211; cv=none; b=OcOx/1YIlSaqCBNOZRbjcgjD3Mq6Inrkyv/lgGr99J7mQWWtkKp7sQiAfm/9VHsSW5OqDPnlVpUIUanary0YawWmHzfqhD459hqdOiynXHAOIuctLFjsFGo3Rt/NcpPIebsh8I0ur/HSWccGnfE8mRboL6HQOZteLPvCj3Xuj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787923211; c=relaxed/simple;
	bh=Ex5vOC+LUEcBTFT/o+t5phdslOqFz172rhzcADsqSLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkJeuZpnUx1jBRS/9WF25hcAaoCNtmp7E1U7aS8mafbbxtUrYg204NtgAF2DNPXGwOJIRP/NcvDXdGQpwk2lccrX/AlozZ8Sorb8GQg/7XLaEPsF3Dcas/50JkczOwSuiHHNsF9bz+MQ/tcQG2GePc7wY+q0KUoeHyQWY8Lch/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yBuix4px; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yBuix4px"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Vchko25pYKVSr4oaZ/OL59g91b0pE1vVHZrmkSjJqpw=; b=yBuix4pxASxEU3o+zcoKA+J8AT
	/jRUY7cahy2wsOM3KwY5slnLdz+5AVE7WZgY8uH3JQbo3Skif+vpkdLz6gTHGWnhJaGTqwpUJfNTx
	wzfSK1UFroNYNA/TFPfJyyhiz66IwKodxexN/EPMUXXjv7Pjy9bEKICzwumxUSqPCeZE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzwUu-001oiK-6X; Fri, 28 Aug 2026 15:19:56 +0200
Date: Fri, 28 Aug 2026 15:19:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com
Subject: Re: [RFC net-next v2] net:dsa:yt922x: Add support for Motorcomm
 YT922x
Message-ID: <d3c8d8b7-7998-42ef-a518-9acb9a4c6038@lunn.ch>
References: <20260820080542.2017118-1-kyle.switch@motor-comm.com>
 <10c23416-dce1-4ec6-91bd-3e9eda9b18a3@lunn.ch>
 <3e87da63-420b-4582-956c-2ecd853b0619@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e87da63-420b-4582-956c-2ecd853b0619@motor-comm.com>

> > > +static int yt922x_port_sds_init(struct yt921x_priv *priv, int port,
> > > +				phy_interface_t interface)
> > > +{
> > > +	int addr;
> > > +	u16 data;
> > > +	int res;
> > > +
> > > +	addr = yt922x_sds_phyaddr_get(port,
> > > +				      YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
> > > +				      YT922X_PHY_REG_SPACE_SGMII);
> > > +	if (addr < 0)
> > > +		return -EINVAL;
> > > +	/* write protect */
> > > +	res = yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);
> > > +	if (res)
> > > +		return res;
> > > +	/* CDR */
> > > +	if (interface == PHY_INTERFACE_MODE_100BASEX) {
> > > +		res = yt921x_intif_ext_write(priv, addr, 0x406, 0x0);
> > > +		if (res)
> > > +			return res;
> > > +		res = yt921x_intif_ext_write(priv, addr, 0x416, 0x3458);
> > > +		if (res)
> > > +			return res;
> > > +	} else {
> > > +		res = yt921x_intif_ext_write(priv, addr, 0x406, 0x800);
> > > +		if (res)
> > > +			return res;
> > > +		res = yt921x_intif_ext_write(priv, addr, 0x416, 0x4558);
> > > +		if (res)
> > > +			return res;
> > > +	}
> > > +	/* PLL */
> > > +	if (interface == PHY_INTERFACE_MODE_USXGMII) {
> > > +		res = yt921x_intif_ext_write(priv, addr, 0x43a, 0x1006);
> > > +		if (res)
> > > +			return res;
> > > +		res = yt921x_intif_ext_write(priv, addr, 0x43f, 0x3029);
> > > +		if (res)
> > What is this function doing?
> Ans: Complete some init configuration according to serdes interface mode.

Sorry, missed this email until today.

Which SERDES? The switches SERDES, or the PHY SERDES.

We normally refer to the switch SERDES as a PCS, and have a PCS driver
for it. Sometimes you also need a generic PHY. Please look around at
other devices and understand the architecture.

The PHYs SERDES interface is configured by the PHY driver. The MAC
driver should never touch PHY registers. Same as the PHY driver should
never touch MAC registers.

       Andrew
