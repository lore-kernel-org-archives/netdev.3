Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DE396567;
	Wed, 26 Aug 2026 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768487; cv=none; b=qycp8nHRReFGhXYA2un+hrWT+jVXiqRTbSn/35VzqRhARmqhkz/hfdg/7R76hS55hQ/b8YQV9RPKm2spOA+KgVKym4OICg5qlGjnJVMTqhQCi7cLDsV5eiIajjWQWBLIdqvX0pcHkOA82QoiEU6KxBfm7QWHJ1x0m59c5C58obA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768487; c=relaxed/simple;
	bh=JgD2d7SIptm6DFoVcl9RCSGcBv1v8yNovnJe+tuCm2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWbKKdremAXA1GEjRu1jTpw9uX64j2H3qMiQpaPHU2/YPtf88wB1DDpjLPvIDQJnBQxO2p5dZlrYevpNeXPJ1pB+zjhHRvC3q5GtkLaZo0pybVGtM+FBsMG0IeEYjm2FOP/6mTGZRX1Tx+xB6sHQgDjsjgWqRf9e1fqMAmgA7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GBr9mD6w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GBr9mD6w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bvjnU/RvNADb0e9qLUeiWXcrPjao4d1WYghYICkJhk0=; b=GBr9mD6wUCO5gtan9XqkSdHu7Q
	zX0uovq9pQeL8KVS513UKS4UFXKp9aEEsFp2zBmpa8DhJtD87i6IqlHdJpJbaiaFnLE0Q8oZBERJc
	KCbL4EQvODDrg+0Dxqk5y0pUVFg6T42lcB1Suy6Pp/cYxq5RSVP/DvosEA/CaEcsBsxM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzIFB-001Yhh-Fo; Wed, 26 Aug 2026 20:21:01 +0200
Date: Wed, 26 Aug 2026 20:21:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Minda Chen <minda.chen@starfivetech.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net 4/6] net: stmmac: dwxgmac: Account for the primary
 MAC address for UC filtering
Message-ID: <a8174fa4-4c10-4b45-972b-76f353c87f9b@lunn.ch>
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
 <20260826140500.616466-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826140500.616466-5-maxime.chevallier@bootlin.com>

On Wed, Aug 26, 2026 at 04:04:56PM +0200, Maxime Chevallier wrote:
> The same filter slots are used to store the main MAC address as well as
> the address for the unicast filter. Let's account for that when deciding
> whether or not to use promisc when programming the UC list in hardware.
> 
> Fixes: 0efedbf11f07 ("net: stmmac: xgmac: Fix XGMAC selftests")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
