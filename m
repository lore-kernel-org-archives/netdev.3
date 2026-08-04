Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D793F39FB;
	Tue,  4 Aug 2026 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866678; cv=none; b=TXXYh74cskFnxTJK38SAZlgU6bnQfhiz8lKRYa1bwlKYbE8oA1vQMYPqMcMVGN6H0wGsIkJ8phS3Bw4XhzBZGD4zSUpCFwI4CKXMfHqnW8cOHS4z6ab5Bf2bQqtZsVE0PSVkDNQ2b8zhj6Ue05Ws6iv5JcELJc4lz8a9yszDFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866678; c=relaxed/simple;
	bh=oSbzrf2gZXQ5aIHUZP5l+a3hnfIEAA025EIH9RhNH1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRkSH2sGIsuqGYcdSo40+hqRLb4yz1XoojUkipejLgLd0gOTLnfPXit9Yk3rCV3wkPN3OnbIFBls0Vp44dVct20WbYCL8u07NFhSmqaMmmHf/rW+4xRAg2VAWgUnrGI3U12vi8Azh51UeFBjALCO0xZNNeQ8H5djynRdblVuAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rDpIfwRl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rDpIfwRl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6ln+CAvuRtS5oR8LHPuiaJ0WpvoDOfRfT/ABchjoNpM=; b=rDpIfwRla/EZd1ILBlwJNco4l4
	WfJIK/HAgFAq5aphrTk40f+vvHDbygWv7o6Z7/8p18JwxCsd4QtQBJZVg+Rnl0bNsCpPhaUSIko+w
	PNJecubs0awQArL1qJnq1JoKDLrt4q0JC6qril3QrQLMaSHRvwF9enPKiJ6onGEd4yYU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrJUz-00G286-VC; Tue, 04 Aug 2026 20:04:21 +0200
Date: Tue, 4 Aug 2026 20:04:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
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
Subject: Re: [PATCH 10/21] net: phy: add X-Powers AC200 EPHY control driver
Message-ID: <fb6f8065-a655-4d53-acfb-8171b2e003dc@lunn.ch>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-10-0a53cd9e21cc@gmail.com>
 <05b1e6a2-725e-4b8e-8629-249637bbcb81@lunn.ch>
 <CADvTj4o0JdjoO+FC4pO=qnjEQ8MRyzQdKp2Hxy9NsPU-gym5OQ@mail.gmail.com>
 <9b8be475-1fde-409c-a82e-be4b2e402650@lunn.ch>
 <CADvTj4pBovti19MXgQjFpxm=7aRm0sYQz9jxfo8bu3txH94THQ@mail.gmail.com>
 <a9ce53dd-0873-41c0-ad6a-fb42e6cc7aaa@lunn.ch>
 <CADvTj4qpHU3F0DrEmc0vFi+JiwTNERniiMHKo1LmBd8sg58wJA@mail.gmail.com>
 <205e9051-8e43-44bb-a4b5-4ec69a192fa3@lunn.ch>
 <CADvTj4qmXWbDsc-vigcSrF1N=zpxmZWGp3YaZ9PFcWK551h3mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4qmXWbDsc-vigcSrF1N=zpxmZWGp3YaZ9PFcWK551h3mg@mail.gmail.com>

> > No they don't. There are extra registers in different address domains.
> 
> The block diagrams make the distinction clearer. Both diagrams depict
> an EPHY block with the same internal organization: MII/RMII, auto
> negotiation, auto-MDIX, 10/100 TX and RX PCS/PMA blocks, LED logic,
> clock/reset, PLL and EPHY AFE.

The block diagram is a vendor diagram, the vendor can draw whatever
diagram they want. What does the Mainline Linux networking block
diagram look like?

O.K. I've somewhat had enough of this discussion.

For the Networking parts: NACK

To get that revoked, make the PHY driver drive the PHY.

Hide away as much of this bad networking design in the bootloader.

You are free to continue working on the MFD and other parts which are
not networking, because i'm not a Maintainer there.

    Andrew
