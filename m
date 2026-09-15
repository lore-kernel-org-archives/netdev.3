Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F804854F2;
	Tue, 15 Sep 2026 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509382; cv=none; b=exMe04F3WfwjZE84hB98JTmF+TLLuhWp3u8Y+5FgKgdWYoN90sIyp/qUwCubhfSElAC13pet0s+5znSH4t7isAbzpgLc7Oa6qUXFgM2BDfKJ5RWPv5KXpAX3aR0PUVXiEySUQHe9a4yorTN/xM515yZj3H/h6dbslXa1HEhOhPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509382; c=relaxed/simple;
	bh=BMdPq1/VKXvWkYIWhlSzXEn1BU7p0i34lFV6avR5xRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTTqemz2w/vPfnCX0CrpbFHXpweYYVqfVfff1q7eXHCGtbm2mZM5WU0sUITHwB4th3CF8NY0RibAa8/s5IgAlazCQCo1e17CXK/2oD4+1XZ4PAKY4P+Sja7XhHGqjKB9nljFmHHAc1H/PPEQ35jiDILJ4MDXYweb065ouYKhP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dt7jZt3j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dt7jZt3j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PzoiITKlBLXLGeAi+rEGF1gOP/gOqIhjg40FFryu9dg=; b=Dt7jZt3jUKrYF/Bw0fRTELgb0P
	6fc4mYCyF6yEvUxSgYkrD2a7by0LYTtdU52Weo9aVMHP6kC04ezNoZmbET8Wp1jVF/QqX3AsGkR2f
	ps92mR6CaPMOPQ7pdj9vKxEWxQTBPRDFSCGiDbIPdXKo2FzABqsc1l9IfBJohh+6izAI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6b8F-005LpS-5k; Tue, 15 Sep 2026 23:56:03 +0200
Date: Tue, 15 Sep 2026 23:56:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: allwinner: add H616 EMAC1
Message-ID: <7854c5d1-5eec-4d9d-8d52-c597e6fbfcde@lunn.ch>
References: <20260915-submit-h616-emac1-v1-v1-0-195de0bb1f8a@gmail.com>
 <20260915-submit-h616-emac1-v1-v1-1-195de0bb1f8a@gmail.com>
 <5df35a3e-d2c6-4576-868f-d3194de3deb0@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5df35a3e-d2c6-4576-868f-d3194de3deb0@bootlin.com>

On Tue, Sep 15, 2026 at 10:33:12PM +0200, Maxime Chevallier wrote:
> Hi James,
> 
> On 9/15/26 21:03, James Hilliard wrote:
> > The H616 secondary EMAC uses a separate system-control clock register
> > and supports only RMII at 10/100 Mbps. Add its distinct compatible
> > without an older fallback, since using the primary EMAC clock register
> > would not work.
> > 
> > Constrain the PHY interface mode to RMII, matching the hardware. The
> > EMAC1 clock register also retains the three-bit TX and five-bit RX delay
> > chains, so allow the existing Allwinner delay properties for this
> > compatible.
> 
> I don't think there's such a thing as RMII delays. RMII has a single
> clock, contrary to RGMII that has a TX and a RX clock with a 2ns delay
> between clock and data.
> 
> I think it's just a leftover in this IP from the other variants that
> can do RGMII ? You should just be able to drop the comment changes here,
> and same goes for the dwmac patch.

That was my thinking as well.

     Andrew
