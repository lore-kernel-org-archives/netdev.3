Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B61FCF41;
	Mon,  3 Aug 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763847; cv=none; b=Klq3ZiCaHI/nsNpbEPKpo0a5lHPn455liN4P28SWjgtqMTQRAlHTrmoSWhe6hROeALIB3Sa2/NTDmAuV9cDgOMoKxWC4xZFXK0GqZNeea84RhmlhasUoT4klJFD1+CT2FrpGNrv/rGR/sBoJIiV/O0LGVM5eMFsaYCjbeLzVUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763847; c=relaxed/simple;
	bh=kO8Br3YMLtRFslGCiQwZo+9kGlBMhC8lw66HVFjVC38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twNB6WRCdjXSc3Exq8KE+iQpvvNOhb1X1yHxg2C5T7o3EEdLgp83j+I9pGRuwcegeG49BZr7iGqcWs8LvlnIgN39/ByDXUHf9Sl441e5Vr+9Opi0CDAVNnU3n3oWs5qcAf774oMDuwpazw0BQMXoMU18JBwxKBiCgI3bTSl83dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DFsKnY+g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DFsKnY+g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s0Nn8hdIgXmWzmhcG99Oh2fhpDgLrw7IOOOOFJwYqeY=; b=DFsKnY+gVEOvTe+do19wn9YHgk
	jRtADcklHMwQYphjMhoDQN3im0vzjhJqZ+cZcdQM2GvtsYAPRMsh0XeCmjR+RO9EVWjPvFEyPxI3L
	mV4GVOWX7lPAQ81k17dC9bRNcl+WjRpzx1/y0tvhwiSHxj9sDpNY3vCz1EMcEb8ZaSwc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqskO-00FjGe-HJ; Mon, 03 Aug 2026 15:30:28 +0200
Date: Mon, 3 Aug 2026 15:30:28 +0200
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
Message-ID: <19241d58-1a69-4776-8d91-012de9fc421c@lunn.ch>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <aaec8809-8218-4412-a60d-931406dbf287@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaec8809-8218-4412-a60d-931406dbf287@arm.com>

> Just to bring that shallow discussion we had on IRC to the list: I wonder if
> this is the right solution? Alternatively I was wondering if just patching
> the DT in U-Boot would simplify things, and also help other DT users like
> *BSD or U-Boot (proper) itself, to not boil the ocean, but just allowing
> them to follow a standard DT description.

I've not looked into the MDIO bus probing changes in detail yet, but
that was also what i was thinking.

     Andrew
