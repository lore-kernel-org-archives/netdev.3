Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B493D16EC;
	Fri,  1 May 2026 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777665060; cv=none; b=B8Oe4MUZMX15yVDdtZIvaYJ2hNG9gtvbocKjALbYJxxEQqHOorHUTcGDNVE+ljejfJq9ah8YO8inHMPBZUbbNYRl45RnMLwPrIdPlYHuHLnvimvIdDe8shXU+3349SXGv5snP2sjzvWE5BrtKTvHZxIgIf6tYLHyVXXebFwr92g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777665060; c=relaxed/simple;
	bh=gdlpFoKQ5Fd8FZlEOdFbGv92Av+KpzKBa2SRXvR5myA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFe83uLRxT2DkB+JH4YykoQKeqGqTE9E++OP8YdT51tu27ZsUfnvtG9DbjS4iXGKhb+lceuOPztXI7BqBUteJ33od77gbSE4QBdRMi3lUrD/PgZr95VpQzQ3nc7vmTaXX8Jy2LXHUKeX8M1cfkG70ikrKnCcbyKykuTAttsT+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mZ6iBDmk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mZ6iBDmk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yLFN8irE77lm8fnATteJhJbZbnMZ9hU23uSs3yBunLo=; b=mZ6iBDmk1JBKlg+ikRrdCA2LKL
	JxckAVEm/r6spFud5h3AdBcIPLEsaFTapwMNKo5KHycB7alDZc0pRiK1MLEhaQqWxRo/aKtg4U16U
	zQ3Ko6V/Be9xNWFxGHJXQVGPDeWd7iFah/d0JiKKjam9tay0H1cP71fJx0Igu5yC6EeM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wItss-000s9J-Dy; Fri, 01 May 2026 21:50:46 +0200
Date: Fri, 1 May 2026 21:50:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/5] net: phy: ncn26000: add support for TS2500
 internal PHY
Message-ID: <c8bd5b56-bfca-450c-8819-8895b0df0c2e@lunn.ch>
References: <CY8PR02MB924929303200D28EDEB66F4783322@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB924929303200D28EDEB66F4783322@CY8PR02MB9249.namprd02.prod.outlook.com>

> +/* clause 45 vendor specific registers */
> +#define NCN26000_REG_PHYCFG1_MMD       MDIO_MMD_VEND2

Please use MDIO_MMD_VEND2 rather than obfuscating it.

There is a lot going on in this patch, with no real explanation in the
commit message. Please break it up into a number of smaller commits
with good commit messages.

	Andrew
