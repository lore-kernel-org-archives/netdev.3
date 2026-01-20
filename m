Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D43EF0B4;
	Tue, 20 Jan 2026 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916932; cv=none; b=J1HIwov2F9dpre9A+ZxkFNBRtP5nv0ZOnfq1Gib9DDxSr+RsSW03y3XnJwhAmAHgCTTHaUGrY7Mr9rxFGJ8as3x0udl7V7i7SyptaR23bZjX48YY74HbVu3NnhQRtd3UD+7kGkJtoPL3RGvVXL5g6DunI5pZ/0m4A8M8adY54xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916932; c=relaxed/simple;
	bh=LETeOTo2J7pSknqlHUKIDWdt3aghLlL9yWsh8I0B2E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFO3prUA5QEGnsf7EvUCrIfoS+SCPCMK/QHKI1ARdQgCSPbg8jzaSf3kd6F1k/aMZjsDjUxk9YTSwEoBYdto2epR7NlJeYpWtzPceoBsSXnUldlibjDjWels5RWDS2MnkoDcsp6iwcQnkBQnrVHE4Hl0jzOqmWkClwptvAU0Dhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sxbab9wU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sxbab9wU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qyLmoKDip8mb9xeBIhPS2JElYYtGvtICGd4heml4sBM=; b=Sxbab9wUBTL3beDPBjlCANIkOu
	0pvVFyMTIUssN8KrOHq2Ohdgune2ofMMYij8VIOwcnEonn1KJM3X4MrFmt1RtFGU3r4KEubWXyuxF
	s4S6Fqly7efORJ5dkw/biM3rPfErfBr34I3BA2QdIFhst29jEQbmpqL9aTu6h95/OVbE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1viC5c-003gSB-9P; Tue, 20 Jan 2026 14:48:12 +0100
Date: Tue, 20 Jan 2026 14:48:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Yao Zi <me@ziyao.cc>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: Add support for Spacemit
 K3 dwmac
Message-ID: <9334905d-d11b-49d4-92b1-61e8cf644f0f@lunn.ch>
References: <20260120043609.910302-1-inochiama@gmail.com>
 <20260120043609.910302-2-inochiama@gmail.com>
 <aW9fL7r0AM0flALJ@pie>
 <aW9ou-lsQQ5dVzqW@inochi.infowork>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW9ou-lsQQ5dVzqW@inochi.infowork>

> IIRC, the "phy" clock is used to pass the phy from the mac core, I will
> double check if it is possible to connect to the phy directly.

Are you saying this is the reference clock output from the MAC being
fed to the PHY? That would be a clock provider, not a clock consumer.

Or is it the reference clock output from the PHY going to the MAC?
Then the MAC would be a consumer.

And there are some designs which have a third party generate the
clock, and both the MAC and the PHY consume it.

     Andrew
