Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191853;
	b=MTIbBHFNg7SMTB0onkHQqsmm+xFOjnmmEeQaniKnjP9+xneCNlfilt4A8hr0EDb4Z6dx
	 o4djWytsmAaDu0MkTUXg0TieXLniCPBt6CF+eg+O7A8RptTSvqjc2WNNaSQj0OkpXJI7G
	 gpmVBrYQh9loAp9ZINHWQ1wIoePD7v1RnXuvZu/IJiZjoVHQq5iXysj5jPR0Ghm/ErKQ2
	 pV4AHNWXrTutPrxVmOeTuFJz/ueiDJghOCVGpiKF+SzT0nHM4Pwc1W/EOqLdQ6/xYhlZH
	 NQWuMgEbmUd1grIHH3hHkqN9Hnbb5tQSfAGlM+sqavw37rYK4CN068XGi9vcPww61CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191853;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=I4SUzivYpnSYJ/lCx6y810yaNKGFV1PRYqvuX0xqFq8=;
	b=a7mkAJmbtqThwiudnxrPX+21hf2IXlAdnoDI0yCI5IkhNd7+VdSn/Gj69VCdTd+xn3XV
	 Y2iKVdva9t3c4U1JhQiEHJDntZ1x1aLbwL0Y39gqxMhPFazsx9YSfOedPlMoF3z+5VIid
	 D2ut2CxXdclE6Hh0tc0BYNijMzZBifXPGhl8RA2JbNc57jS+l7cYNSKFzu9vmuAa0yDKD
	 XrTczwvH3pNvQlEQ+QN3c59iV5WVhiyWuoIb31a7xt6u3UeSplFKad4L0ZgZaEHcBQTH9
	 oNV5/qCoWaEUT7hJpFRY4d2YYdx+HBytpah/MgasC+tHrvUspORqndlXtxGXWYttPUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=L2CZxSC3;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA7606A31A;
	Wed, 28 Oct 2026 12:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CCA7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=L2CZxSC3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=I4SUzivYpnSYJ/lCx6y810yaNKGFV1PRYqvuX0xqFq8=; b=L2
	CZxSC3XYnCB0mWsCoxLLDP7tsZQ3O+vCkrBcl1ZvrnZe/rISNVHUXadwbWPnvd7KZmcLEJOKBESDL
	Rhs2CCQdnkd1e6sj5lBOvh5UvmTVsYdu3ZHwfWpLbUR+lQEfmkKYCtbVNI6W5alqLNjyqY7pDqj3m
	Ox59MrqCo/upT3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xM36y-00D6p1-71; Wed, 28 Oct 2026 13:50:36 +0100
Date: Wed, 28 Oct 2026 13:50:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com, daniel@makrotopia.org,
	linux@armlinux.org.uk, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com,
	b.larsson@gmx.com
Subject: Re: [PATCH v3 5/7] net: dsa: mediatek: support MDIO switch
 downstream of MMIO switch
Message-ID: <bdde8389-008a-430a-8d0d-14edcb4050b4@lunn.ch>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-6-cjd@cjdns.fr>
 <f6fe9c7a-5617-475b-babe-da24cda815cc@lunn.ch>
 <acf55987-e96d-407f-a4a7-1c78178a0c7a@cjdns.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acf55987-e96d-407f-a4a7-1c78178a0c7a@cjdns.fr>

On Wed, Oct 28, 2026 at 12:59:23PM +0100, Caleb James DeLisle wrote:
> 
> On 28/10/2026 03:20, Andrew Lunn wrote:
> > On Wed, Oct 28, 2026 at 01:13:15AM +0000, Caleb James DeLisle wrote:
> > > The MT7530 / MT7531 can connect via either MDIO or MMIO. In MMIO mode
> > > the switch provides its own MDIO bus which connects to its integrated
> > > PHYs, but also can be connected to other things, such as another
> > > switch.
> > > 
> > > If the MDIO bus contains another switch, then the upstream switch
> > > will register but it will not setup the DSA tree because the
> > > downstream switch is missing. Without the complete DSA tree,
> > > mt753x_setup() will not be called on the switch and therefore
> > > mt7530_setup_mdio() is never called so the downstream switch never
> > > registers.
> > > 
> > > Update mt7530_setup_mdio() so that it can be called multiple times,
> > > export the symbol, and call it again after dsa_register_switch()
> > > from mt7988_probe().
> > I would suggest just moving it to probe. Don't also have it in setup.
> > KISS.
> 
> 
> I don't think there's a way to do that which will work. And I guess I need
> to add a few comments to explain why. Basically when dsa_register_switch()
> is called, one of three things can happen:
> 
> 1. return error (often without calling mt753x_setup), typically this is
> EPROBE_DEFER because the ethernet driver is not there yet.
> 
> 2. return 0 without calling mt753x_setup (because not all switches in the
> tree are yet probed)
> 
> 3. call mt753x_setup, complete setup, and return 0
> 
> 
> In case 1, mt7530_setup_mdio must not be called, because it would be setting
> up an MDIO on a driver that's about to get deleted.

Which is fine, because when the probe fails, you unregister the MDIO
bus. That should work. The second time around, you do have the netdev,
and it should work.

It is not great, you are doing extra work, but many DSA drivers are
structured like this, the MDIO bus is registered in probe. The bus is
scanned, PHY are found, and then the probe fails, and the PHYs are all
thrown away etc.

Hanging one switch off another switch like this using MDIO, kind of
pushes you in this direction. Typical DSA setups don't do this, there
is one MDIO bus which all switches hang off, sometimes with a
multiplexor to make one MDIO bus act like many.

Something to look at which might be interesting, Vladimir had some
patches which allowed for partial switch topologies, where you could
take a switch in a DSA setup off line. Maybe there is something in
those patches which help, you can bring the switches up independently?

	    Andrew

