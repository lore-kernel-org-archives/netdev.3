Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3813158DCF;
	Wed,  8 Apr 2026 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652260; cv=none; b=CeKr/quCUYgi8YyXFQSQG4Q1PxZY8BQhDKKhTe8psTqwCqkR9aW9KF68zc5hPVnJu5lciZiLX69E7rDCrX80DcH+ygw35mulR+BCfFYoveEY8hBCZ9iGQWiYuwHa56SUqxPFoSmKeLFK+FqYIwpCCtOdzuPYCB77HFb/cONLZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652260; c=relaxed/simple;
	bh=TgjzrzyJzHUlpFIzy1QkJi78ontK3CCZ8Rp076oR4y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9WSBx/6a3CX8Fb3vae8hjGiSoR4xKDliBJUKYLfuL00l2Bg1RrXg+r5zwFonkUh2AJ4UiVXfSfGBllLRTj+JB1UanfgGCp9gM39iab5OYHSjTg8XP4wjIbGwG7lbhkpsxovomlbMOQGeh6rlDsg6Lmosh1X7cL9CzFRyo2tNvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TkqLPu2o; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TkqLPu2o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NI0RBYEm/rMp8zTgbMG+UV0FEMVt6T/n4ACoaqabMPI=; b=TkqLPu2oYXo+TT6MXa816aoUG5
	bkQiQZdpSvS+C/DtVUvz80tWRBT7M+wpwj0b7X8SGBgaj32XZF0MWqSGeFQUrB7mGZpYUtg7Yopxe
	1COWs8pbIAx5147IGlVMR3yNavQ7YbbJ9wdKW6mt4Ho6j1/4p7SRhepYLasqdzOHTuxA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wASGC-00FHrK-9L; Wed, 08 Apr 2026 14:43:56 +0200
Date: Wed, 8 Apr 2026 14:43:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: Re: [PATCH v2] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
Message-ID: <a350c4b7-d816-455b-83c0-f4d98299c637@lunn.ch>
References: <20260408-ksz87xx_errata_low_loss_connections-v2-1-9cfe38691713@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-ksz87xx_errata_low_loss_connections-v2-1-9cfe38691713@exotec.com>

> The control register defines the following modes:
>   bits [1:0]:
>     00 = workaround disabled
>     01 = workaround 1 (DSP EQ training adjustment, LinkMD reg 0x3c)
>     10 = workaround 2 (receiver LPF bandwidth, LinkMD reg 0x4c)

There was a comment, which i only read after making the suggestion to
use two bits, of exposing the different low pass filter bandwidths,
rather than just picking one value. How useful is that?

       Andrew
