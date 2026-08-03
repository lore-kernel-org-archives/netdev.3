Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896422D7DC6;
	Mon,  3 Aug 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765459; cv=none; b=XyZCOHde4M5Cr8sjsM6ZL7NCaFJ7ApGoj4AnqKtL+G2zCb98JwqlalaIUEM4mo7WHOCHqrGq0SqsKKiJdhTJrTAQlLSuUKb/A5/Njg+GrwSRH8MolkCO/yTd6alY20sbuGkNy3nxhOeOGGjNmVGSuueP8lnKPGukDWpG0gHpLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765459; c=relaxed/simple;
	bh=Dc4d7XEH8qpDHXC700mpd06FZ2/4r5bMDGUIeLH8g0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeEMY1MJjXm2Wd1glA6wn7V2+oGKd/q56DZmsrNsJ4fi7RRQJVSnxUnIRaKLHv/gnaVwitS9fpweSB+s5BQxCiI2SictBsDfH1AnY4ldHZqmlTMzhtCr0dQ6RE/xkxUiHYkuT3W977lzxm3ufhG5VeJJS2GNMmsORK53TzItp9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IbtjU+qw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IbtjU+qw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jWLoWn7qIYHBGm7cM6GD67txwG0TCsUk3yorRsLCI5A=; b=IbtjU+qwFlfMTj4xfnlEm9TsFv
	uXSXRaQfrC/wfjDQHtkVt0e5Lnaa2LQW/9Xd1HspaWjIXcKabDFmUONZgYPczRaemhmWbwVCN72Fk
	xi75AjxT+ohCdHxnh4tvbxm/c1doFzINfNyj0OJUcehrflcqCKKNU6uRZkoX/2ECAzmM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqtAI-00Fje7-QE; Mon, 03 Aug 2026 15:57:14 +0200
Date: Mon, 3 Aug 2026 15:57:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
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
Subject: Re: [PATCH 00/21] net: phy: add X-Powers AC200/AC300 EPHY support
Message-ID: <f4697868-4ed3-4980-8c20-6262122dfee5@lunn.ch>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <d2a1f26b-a97f-4cd9-993c-5dbca530abdc@lunn.ch>
 <ae236186-e984-4fa0-ac70-f321068576f1@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae236186-e984-4fa0-ac70-f321068576f1@arm.com>

On Mon, Aug 03, 2026 at 03:54:26PM +0200, Andre Przywara wrote:
> Hi Andrew,
> 
> On 8/3/26 15:52, Andrew Lunn wrote:
> > On Sun, Aug 02, 2026 at 11:14:10PM -0600, James Hilliard wrote:
> > > The Allwinner H616/H618 secondary EMAC is commonly connected to a Fast
> > > Ethernet PHY in an X-Powers AC200 or AC300 companion package.
> > 
> > Is there an open data sheet for these devices?
> 
> Find the datasheets at the end of this Wiki page:
> https://linux-sunxi.org/AC200

Thanks.

It would be useful to add that to patch 0/X.

   Andrew
