Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F43DDDD3;
	Wed, 25 Mar 2026 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467990; cv=none; b=Fj3WC8aNrL6Hp9HtJRiwDnEYRQwP5RVQbT+MgQfl/l1Da26zqkVMCpfFmPKuYZGVum2TpQtN/wpv4fkJNR/QnDGyTtbHOSoMRC/1QfEpD3rrs1y5AYRFoFNW5oLyLJQTAaI183OUoJTlPM5kvG0w5ED9suNg4BbDzt5e4edJ9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467990; c=relaxed/simple;
	bh=Jb3L4ICqeroI6Gyf9PM/GhshoEIuMXl08eMVhHGaW5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifo7ppa6KUFHmVKVfav0/vMf/vJzct+ctZ9Zqm5wsbvu92AytKcVTNFrmWHZIbSGWpc6/ox9Z+2WVcstm3y0rdmn0b2nwoc0Cgo1qXP37xZ4SE6MgMFwsCK9M87Ekhqj8KjtSw7eIQ//G6u9a3zFK9fPTX/EcxCkWgQNch/VvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0X/v1cF5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0X/v1cF5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7LYOU/TLhQLEYy/E7Cpnl7qWbK1lzoWToXQcIDhc9hU=; b=0X/v1cF5lfqypgKdvgWcxL3F1E
	WNiHNjrWD0/SmejAkVNBaFX2ZuNNM04cylxPRGXzxsJhshZjfd/Xx2s0eBtWZett7oYiM8229zId9
	Jm8WCuaVgwxARfFNLd65aMwzFHKDWl8bBCUniK96alDmsGNfCL4EtdARV96JZvLv4Xr0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w5UAw-00DLrq-Pm; Wed, 25 Mar 2026 20:45:58 +0100
Date: Wed, 25 Mar 2026 20:45:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: Introduce Airoha AN8801/R Gigabit
 Ethernet PHY driver
Message-ID: <75c10c97-8355-457d-9458-0d88d598445e@lunn.ch>
References: <20260304-add-airoha-an8801-support-v1-0-0ae4ee5a2f9d@collabora.com>
 <20260304-add-airoha-an8801-support-v1-2-0ae4ee5a2f9d@collabora.com>
 <3fbfabf7-b3af-405b-ade4-4f62db2c1c45@lunn.ch>
 <199e674cfdbccad104db761964611b1d6352f9f3.camel@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199e674cfdbccad104db761964611b1d6352f9f3.camel@collabora.com>

> > You configure the PHY to support downshift. If it has performed a
> > downshift, does it report the actual speed in the usual registers
> > read
> > by genphy_read_status(), or is it necessary to read a vendor
> > register?
> >From the tests I've done, I got the actual speed read correctly by
> genphy_read_status function.
> I did a test by adding in this function the vendor register reading at
> the same time and comparing it and did not get a discrepancy too when
> switching with ethtool between different speed configurations.
> 
> Would it be more reliable to use the vendor register instead?

It is unusual to report the actually speed in BMSR etc, which is why i
asked. But if it works, this is fine.

       Andrew
