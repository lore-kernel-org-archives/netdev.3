Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828621A2545;
	Fri,  9 Oct 2026 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548033; cv=none; b=UqJhAeV93KL8/z+LCffZsJLxbB+QiF/vGXPmVWGTIy7LNaODDwfsPF3U/AHWTTNihfUb/NuLwb/QeiK86SpU6FlDQDCMx8ejMsbp0TOO+RXZP105CXI5wJG0vC1/2dC6zosk3j5NqktbvKai0neSduJKeVdp8cBBbpB/Zuu/9OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548033; c=relaxed/simple;
	bh=ZEOOr0h2KmQngFhv//6cIoONgVkd+R+SnXyQvfgJrlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGXqhe+z7Oo8ajGIFGGd9FSWaE/lpQuvkIXrLohdmYZq1GhXL+ASj/VH/HzUGi+a3J14lhlM+S7fTj2kZQZvSDemdTbMom7nDBoHjobFleRcDKXeaIiuR/zbbnxM6nv3CjAErXtvBTs4yooF3VeIwrsdmboAy+3REA8F1yCXJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tzeHbJbf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tzeHbJbf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iYqcn+lw0qC/zQadO5fheUsN/NkKlBYECjVpCgptZMM=; b=tz
	eHbJbfn2hJXhR7bctqrOQsxWGFsATvqH5M7FqEGjCw/KIWeIC4TlP70keu4PnxMShE7R1Ghh/x90I
	4T5wSY81La24TnQgk+SKelca7e0mnBsktaMOF1VvENjiTXcdre/8LuPXR37vafMP1+H1RTzD2lY6Y
	X4HQUO3qpsENWVI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xF9TY-009mY5-CL; Fri, 09 Oct 2026 14:13:24 +0200
Date: Fri, 9 Oct 2026 14:13:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/7] Add ethernet support for the Amlogic T7
Message-ID: <3a037c87-e4c5-4a4e-9522-cf505e1c6399@lunn.ch>
References: <20261007082627.63807-1-tanure@linux.com>
 <d23dfdf3-5837-459f-afd6-6c198a05c13c@lunn.ch>
 <CAJX_Q+2au4x99kj=UBqn4joQCM3-D2kbaJ0zro9Y4RXka7ePvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJX_Q+2au4x99kj=UBqn4joQCM3-D2kbaJ0zro9Y4RXka7ePvQ@mail.gmail.com>

On Fri, Oct 09, 2026 at 06:59:49AM +0100, Lucas Tanure wrote:
> On Wed, Oct 7, 2026 at 2:01 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Wed, Oct 07, 2026 at 09:26:20AM +0100, Lucas Tanure wrote:
> > > The T7 pairs a Synopsys gigabit MAC with the same glue registers the
> > > G12A has, but nothing described it. This adds the binding, the driver
> > > support and the device tree nodes, and enables the port on the Khadas
> > > VIM4.
> > >
> > > Unlike the G12A, the controller reaches DRAM through a pipeline stage
> > > with a gate of its own, sys_ampipe_eth. Nothing else claims it, so
> > > clk_disable_unused switches it off and transfers stop.
> > >
> > > v2 changes the RGMII delays, after review. phy-mode describes the
> > > board, not which chip adds the delay, so this board is rgmii-id.
> > > dwmac-meson8b did the opposite, and ignored the *-internal-delay-ps
> > > properties. Patch 1 fixes that. The VIM4 needs it because the RTL8211F
> > > transmit delay does not work here.
> >
> > What is special about the RTL8211F?
> Maybe nothing, it may be this board. I cannot tell from here.

Yes, look at my other reply. The RTL8211F is very likely correct. It
is the MAC drivers handling of delays which is broken. You get to fix
it for this new device.

   Andrew
