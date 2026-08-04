Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D363CB57D;
	Tue,  4 Aug 2026 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809694; cv=none; b=SSknZgFRJxYKI6Ay8peme4xPwdT/I3xRJCGPtaQSSP1E64qjN42qDoGrtxDm3DWl27VNn7NevR1LYp5LT8Ahsak0FhjbR3yF5FVi2FWqsYmwnXmFePgiD375q/8OHlwt/LYgDmfLUEsFvOkxBrMtwnW9udg0lLMaqZkRNiZm7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809694; c=relaxed/simple;
	bh=Y5JZSp+ix4qHbZ7GCC0VqnV4NZLgImWXiB5VmcXvnlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ1SqwAKr4oqNSLIC+JP9K2y9hMXwqxX6F0U+d6TtwDitAvAYQWRb3oAlBdhLYmrYzGMDSpaDjB/73GwuDjoYgG6NKf2WsycPMfakkQKinu9AKHBkCoMmT6hbiXs+JrHyM8B5q3fOqbphbefIqRNShZtDcss2BhXs3d+FGf2Oj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1BzwMrQX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1BzwMrQX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=T/VCzwTsflXecE/LA8NyIZCc4wUo9vJUkRVnEi64uVk=; b=1B
	zwMrQXY2R+8GeQDMzsLBwl6+lx+XH0qy31zRwG5Txtcd53Z/UlGiB6G+y5UhWYsL9szKklFS2hqpJ
	E36k88HZ7acZi6srmdwxRvrAT02FdtDrUWOIB+f7FBXIept5AilXRMX/CG37Nz9GwNDvmWkBfub4S
	UeDNHgYSFUZp1r4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr4fn-00FtNy-Ck; Tue, 04 Aug 2026 04:14:31 +0200
Date: Tue, 4 Aug 2026 04:14:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, mfd@lists.linux.dev,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 08/21] dt-bindings: mfd: x-powers: add AC200
Message-ID: <fa80d6f8-8ddf-48e1-a879-a70f228c79f9@lunn.ch>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-8-0a53cd9e21cc@gmail.com>
 <2c0210b3-2c68-41f1-aa33-3f1693454849@lunn.ch>
 <CADvTj4pfNFVGrQV86T7X+nZQYUamxEYLLWuxVXk=av0da_XocQ@mail.gmail.com>
 <CAGb2v67Wo+WG47jF_vBUOwv0Vw1SDygXMdBgpsy3R1AQ_LLfHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v67Wo+WG47jF_vBUOwv0Vw1SDygXMdBgpsy3R1AQ_LLfHw@mail.gmail.com>

On Tue, Aug 04, 2026 at 12:51:57AM +0800, Chen-Yu Tsai wrote:
> On Tue, Aug 4, 2026 at 12:45 AM James Hilliard
> <james.hilliard1@gmail.com> wrote:
> >
> > On Mon, Aug 3, 2026 at 7:18 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > +            ethernet-phy-control {
> > > > +                compatible = "x-powers,ac200-ephy-ctl";
> > > > +                nvmem-cells = <&ephy_calibration>;
> > > > +                nvmem-cell-names = "calibration";
> > > > +                phy-mode = "rmii";
> > > > +            };
> > >
> > > What do you mean by an ethernet PHY control?
> > >
> > > I assume this is not an actual Ethernet PHY, but some control logic
> > > around it? Where is the ethernet PHY itself?
> >
> > Correct, this is not the Ethernet PHY itself. It is the package-specific
> > sideband control block that must be configured before the normal Clause 22
> > PHY registers become usable. For AC200, this control block is accessed
> > through the parent AC200 I2C regmap. For AC300, the equivalent control block
> > is accessed through a separate non-PHY Clause 22 address.
> 
> Basically, all the PHY behavior that is normally configured using strapping
> pins on a discrete PHY is done over this I2C channel.

To me this should still be part of the PHY driver, not a separate
driver. The driver drives the hardware, it should drive all of it, all
in one place.

	Andrew
