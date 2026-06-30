Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F736C9D5;
	Tue, 30 Jun 2026 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827922; cv=none; b=Hbzldw7Y3t3VEC7+Vodpohb//GLSbeVg5H3Vt0/tGxKUL1HknYeHPD+RJvznUK75qpWzFR3Tz4eZkl5RJqLtrC/1hZGs0ZzZfBioTXqhFHNIPn7FdhaLuR8/hq5589bwF0TWjWRSEKwO+ZwN0PeDaPS/UsEmvOXRAsQMtPc4heU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827922; c=relaxed/simple;
	bh=Zth9Owsv3U7Sb/m0v94pNUDMpF5vCb1FZ6RW6NCXVFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1ne113e2RQWbut2AFNwosNvM+HMFAFDy3WYWVbisE4FaVvwYoOacgIRDzSPPyLi/9/B4CfG7Y6zgvR4erK1PLfJLkSx4QoIlgarSgnbjRW1UZfDOudvgszPn8dk6kGn4uqMng5SJGWtnlz+STo/zS3N+4QeqZySWHPj7afa1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hThqMAS+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hThqMAS+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h2ZClkJNcOlGLeERLZdhE0/N0+ZPPh65+LxTgmB6ghA=; b=hThqMAS+a4TWmMfM7VJInRiSw4
	JiPBK5OrvSbMh0fd4+QFbDA74JID9m3EGbNoK3D8olAO4UbMtxGI098ZMDmoe5ExLAvbG8zocWd57
	fFCqI41RsVZTiTGWhMH87Izf1da27Qmqy5/gxG4d9spXVG2C1/fzpX0sy9oQIenM9N9E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weYyo-009zDS-Go; Tue, 30 Jun 2026 15:58:26 +0200
Date: Tue, 30 Jun 2026 15:58:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: dinguyen@kernel.org, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org,
	robh@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2
 board
Message-ID: <edf84080-a5e0-478c-9977-af2376cb71c5@lunn.ch>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630133108.27244-3-muhammad.nazim.amirul.nazle.asmade@altera.com>

> + * gmac1 is the TSN port. The MAC operates in GMII mode internally
> + * while the PHY-side interface is RGMII, so mac-mode and phy-mode differ.
> + */
> +&gmac1 {
> +	status = "okay";
> +	phy-mode = "rgmii"; /* TX/RX clock delays provided by Agilex5 I/O hardware */

Could you provide more details about this. I want to understand the
big picture.

Normally we talk about the PCB providing the delays. This sounds like
it is the FPGA? So i need convincing this is correct.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

	Andrew
