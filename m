Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257305;
	b=5ohjCd68QSyj0wVKQYM4YEUMm+Oh4oC/FuOdNgWejlXbkYlrpmNW1DncmlMrCcMhwsNT
	 ozKRZDfirVgYxsQ9bJ62hCUoU5yCtT7iYRp1yzgq9dKPQZyHIJbIJJ1GeaEOUKtH7Lc4T
	 mepKTy/HzTIvxRGP3k3Rh6+Ktzt2MRMUEFPnw1FAbdOQmuxWNPHaPqFQV+aReso8eRgGp
	 il+pn1boBT+zhOLfcmzYWEyxUcPUoO2PUtkmuvDrqsbfWcH1dSB7me6dDE+LQnd5Q8XLp
	 UyX3ln45ONNN8alld8lxTvV5sLkgIUF0SNa6v/iiS8AP/BbFRvWcKObPxEJxMcSeoZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257305;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=cr59Jlw63YR0F4Paf2c41Gc0yvl82l13H2pewUH6kQs=;
	b=fM67+GA/Pr/zdCc+X7QID50J40nNyhBAp1JmGitwQp/3Se4sLEN2lRwSPXzarQQndJDn
	 00c4K0lRvXUKsgyS+w9wMLH1X2i+x6HWXt+GHUSPrYJvM1y+N0FGFeT635IaDFGTtAkcA
	 /x7JFn/LwSydx8PNPKJRuk+xQEqqIxByQ1P1LcEMIiP0H6iZD95oBkxIafL8vW6oIwa4s
	 6LBSqln7io8L0Fp37d/1j+3eT4LqDbWhPNnQhFNK3jj12Pm50fK60gD8aCtcmqRIwBu82
	 EoHKwaweGagtjtOG5wSYBLNwMq34h6DZVA23spgDEt+VBlOutmyHEKaT+Aq35F0R9Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=g8WDSSNK;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4F606A326;
	Mon,  9 Nov 2026 20:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB4F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=g8WDSSNK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cr59Jlw63YR0F4Paf2c41Gc0yvl82l13H2pewUH6kQs=; b=g8WDSSNKQdVFTWx1a5zdBz9zFh
	GUXXz0IRv0IsR/ve1G3+vzg6g1SAwBk8vuJPsCuCEg8frs4/+xAXqU0xhGRsS9CV4b2HvspveUeFD
	yT6aQipWAK7+6yhOCeX9N+sliON8Bw/O70MbuMgjDlUHoX+WMZ1/9xy55ndq4LPBVrxc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQWHS-00FKzw-TE; Mon, 09 Nov 2026 21:47:54 +0100
Date: Mon, 9 Nov 2026 21:47:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/3] r8169: make PHY OCP access safe in
 atomic context
Message-ID: <7791e7b5-fdc8-4c8c-ab5b-dcc7d7a6506a@lunn.ch>
References: <20261109023022.770-1-javen_xu@realsil.com.cn>
 <20261109023022.770-2-javen_xu@realsil.com.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109023022.770-2-javen_xu@realsil.com.cn>

On Mon, Nov 09, 2026 at 10:30:20AM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> r8168_phy_ocp_read() and r8168_phy_ocp_write() wait for the GPHY_OCP
> handshake with rtl_loop_wait(), which may sleep (fsleep(25)). Upcoming
> PTP support for RTL8127A accesses the PTP block through the same PHY
> OCP interface from atomic context (spinlock held, NAPI RX path), and
> concurrently with phylib MDIO accesses.
> 
> Busy-wait for the handshake with readl_poll_timeout_atomic() instead,
> keeping the previous maximum wait time of 250us, and serialize the
> GPHY_OCP register accesses with a new spinlock.

There are many drivers which need to access PHY registers via blocking
MDIO accesses. Why is this driver different?

	Andrew
