Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2D3C1F59;
	Thu,  4 Jun 2026 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601449; cv=none; b=D0+0IdUKjHW7HwDEIeYoiUuifwq0Lrx3LCbVTyUYYCtDeZkYHaKHfOKP3OIKOiCLjoq8UI4/3ydvSrXuF/0isQvFBTgXlxQGFNZDxC1OW4SC0eSv2yg49AZ2cQSqXMFI6AR0rTrBig8sIQHhcbang2R3+Zf9haRVSJpmOfIU7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601449; c=relaxed/simple;
	bh=8zZ53qUWtpc9lfspHmPHZfxf/sGT48x8/4ctpKhWEAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4pgj7+49mY4dtkFkUxocSgaS3dYCQwjxb1Cq0kIw4f+goblUbm9eV7TvfoPfbPA8BRcSXf9izhr+5qcHnM0fxm+Lu4hriItL6ctIk1WWZ9HQGwhV2hqWmWufXZygjineKQB1ghlhA7SjgQOZPTtgHeuX9El1pOf0YTLv7pCaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=slfLOmVx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="slfLOmVx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IaCXd5wjCRGzbKHIR9+FYqT0US6hNPWlc17eCJ4MZU0=; b=slfLOmVxzFHAm5z3XOZdkZKopo
	dhmJyGySYYNgAvu5KAP+LUKa+WlwLx2EyIvM7tI163tOWov4+J1zp5j1fB0gnGbYsG6VWegbN/SVL
	zAqVHmqWXW9v4XE4cENCeyHruvjQWneXnzm/KJXPDPBLYvIhK1KbwcLeB44qOZPBlFCo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVDlv-00661J-0o; Thu, 04 Jun 2026 21:30:31 +0200
Date: Thu, 4 Jun 2026 21:30:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: xgmac: report L3/L4 filter match count in
 ethtool stats
Message-ID: <5e912b43-7c06-4d04-9ba0-8f929150429c@lunn.ch>
References: <20260604083037.24407-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604083037.24407-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Thu, Jun 04, 2026 at 01:30:37AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Read the L3FM and L4FM bits from the RX descriptor status word (RDES2)
> and increment the corresponding ethtool statistics counters. This allows
> users to observe L3/L4 filter hit rates via ethtool -S.

Are there any more bits which are missing?

dwmac4 has RDES2_L3_L4_FILT_NB_MATCH_MASK for example.

       Andrew
