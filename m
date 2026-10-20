Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500522;
	b=0wYDOeZFlC2nFosQnBGoFcKfLqLs82rwfCaux4cn3LA1SuAJYmxY6g5ybfu+SxdiBeHD
	 E/k/A+cGDI7ayOy58fzazghNbhbzkVGNcmArsh3lHOK5STh5bQR7VGM0ZnaGqme+94kVS
	 kutGX1jAIH5v1P0vWCmB4VV8GhjAQLxZwKxphZQcMC7cAsdJaqddVLsjjCcPi1YnRV/id
	 jtl17T6eJ1/Liscsk3EL0/03XWyr1jQ3u9Mv0BRnhptZVlJ3czu9N2u0Cy7Y1iePQdiMG
	 kTMChBEJP2fJxtMDRflqLsuWl61uiJWexc3NwRV4sqq6+Y/ueOxohAuzQgF5hFGbm4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500522;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=an/MkoGUpLxIL+QOVWmZO/4MIBDB91IY5U2Qe4qB+TQ=;
	b=asqtpshFJMmZqUO6CTQlA+6K9GvL3u5XdtZEZbv87b/P2++/u9ROgu6lC/038/dwBY01
	 uD7I2pavqdHVPsal/UL+qLBtnpMj0J3HEioAsYUmqAO4DOG0IMCgap8W3aA/X3dFzSzNV
	 AOH2Hz4/tr/a5ra9Q+ahClvgBnxAEhrSPkRsPmV1w1m31qcF+Es8gPF6JTTMrTj+CWkc2
	 o9J++q+EV2ttU8VM5m9i3GHfcUwbtnJzPj8dwa6YaayBkLzDDK9sGWc/7BI08y+cXChNa
	 ch2ofI9UKs0iZmx/vR+VRTd0RxtG4jxFVtXqcwJJssrGx1FJ2oByrLofbWjrGvl7ztg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=QSJQh+c2;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF6606A319;
	Tue, 20 Oct 2026 12:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABAF6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=QSJQh+c2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=an/MkoGUpLxIL+QOVWmZO/4MIBDB91IY5U2Qe4qB+TQ=; b=QSJQh+c2sCY4DyJ8tdoAJ6DLqc
	qIJ2cddTyQ3xWVhkXhXiUlHXJu67l9mwG/WJhWEdZuYJOQUHa57Z2eOpj/Y7GOdfVjCRrm586y7YP
	wOSm3Fini7uoLKOIVKcpMTZQ+HZHeRdSKN5GwFHOnGcgFdnesAUibwSGiPHTjmSe1BT0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJ9Gb-00BqmS-1z; Tue, 20 Oct 2026 14:48:33 +0200
Date: Tue, 20 Oct 2026 14:48:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, lxu@maxlinear.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, lgirdwood@gmail.com,
	broonie@kernel.org, michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lrosu@maxlinear.com, luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v3 3/5] net: phy: mxl-gpy: release MxL86211C
 Super Isolate
Message-ID: <21892f3a-8e0a-4c72-938c-b2e77b9f0dbf@lunn.ch>
References: <20261020093655.344585-1-robert.marko@sartura.hr>
 <20261020093655.344585-3-robert.marko@sartura.hr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020093655.344585-3-robert.marko@sartura.hr>

On Tue, Oct 20, 2026 at 11:35:36AM +0200, Robert Marko wrote:
> The MxL86211C can be strapped into Super Isolate mode, leaving the PHY
> halted after reset until software releases it.
> 
> Release Super Isolate before gpy_probe() reads the firmware version. Do it
> again in config_init, where optional VDDP setup is reapplied after each
> hardware reset.

This needs expanding a bit. All reset actions by the core should
happen before probe. So why is releasing isolate in probe not
sufficient?

If the MDIO bus voltages are lost, what else is lost? Should
phy_init_hw() be called again?

	Andrew
