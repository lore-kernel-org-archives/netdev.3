Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C7B1DED42;
	Wed,  2 Sep 2026 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308222; cv=none; b=jvQu8oX5CqYR4hH1TDXy1MPpWo4y+4l92scFYoFjbzos0P63LVfMSNlClFP8b0ecaqyoWvNGeLBYgGrHnsYlEnI9o9MDiPm1bA00EL20LrTG7MBonFTfi9hhGgJhSi3tA1V/sC45ngv9Bpq+eWi7EtHJEjxPZonaTxMgAubbtPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308222; c=relaxed/simple;
	bh=S/QFOI9rzdW/dw88X4bRGG42ZAhkK5BfPRcpPqDPyy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8FpVKF+2dVC7dDXI+xkYsR8MzJt3PcvApbnWtR2l7eqrBgUtT4eAlBwryrdWt/RcDbCB4gPNDzE/Ym0NaiLqwYMLM4+6yhPXVlrCzBxHzC3ikthSOPCPZb16Dvd2MvKVtyD/nROcB55SVRK40eL0+Awo4K23nFaCgxUlRtevH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zny+YwzG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zny+YwzG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yPNmW9+fZWe2SfqHomg5zZaCJo8JWJXV4MhjHZQA2cQ=; b=Zny+YwzG8NYRiiwo3CZQKAwdee
	bBbYyU3iye+dFywhxQHDO9wWe1y7kwoj66XjvrXv3Aa+CNsryHmm31NWHdWWdi71DLrRjmFn7NEL0
	z5SUTVqNNR4hlV1+G91etUU+PHQRuU1BE3ViEFU2iSwI4x5VlTheRg2J0wIDpCjKnReQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1Yen-002RcU-UO; Wed, 02 Sep 2026 02:16:49 +0200
Date: Wed, 2 Sep 2026 02:16:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v15 10/13] net: mdio: realtek-rtl9300: Open up
 C22 and C45 space in parallel
Message-ID: <10c57912-ef5e-4755-9609-f59b3f6ee328@lunn.ch>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
 <20260831143439.2404484-11-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831143439.2404484-11-markus.stockhausen@gmx.de>

On Mon, Aug 31, 2026 at 04:34:36PM +0200, Markus Stockhausen wrote:
> Until now the MDIO driver supports either access to the C22 or to
> the C45 address space of the PHYs. This is due to the fact that
> the polling configuration favours one of the address spaces and
> limits access to the other space. E.g. when polling is set to
> C22 most of the C45 space can not be accessed.
> 
> There are however some exceptions from that. EEE register access
> is allowed independently from the polling mode [1]. As the
> downstream driver already allows parallel C22/C45 access [2] do
> this in upstream too.
> 
> [1] https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/files-6.18/drivers/net/phy/realtek/realtek_multiport.c#L349
> [2] https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/files-6.18/drivers/net/mdio/mdio-realtek-otto.c#L1072
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
