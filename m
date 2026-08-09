Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E06383C95;
	Sun,  9 Aug 2026 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786297507; cv=none; b=f5v4K12R1dQU3vwTjTXOOnjtazbdPwI4Ue7q6M44/O0RJ3zJpR5JK8R7gTtXpJipsQNp0FYxB9mccuIqwiUiJcQfwum8EGePubde/MHIRdE9GODzsPQC6DuPsD51xdcDGuEcaDsxGJQuWQHrKwkpZLcg+2121b9Pt0ZYaeDbFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786297507; c=relaxed/simple;
	bh=1ZDTtViuZZo9p3Px3qbbEDk5yZ19M7yzr95nTJZTqG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYzFT1P8+Y1sf3qKL2jSI1r8p4eV23X2jFCrF3qiAV1lYsql++h2y16vySp6ThM9RFr1yFXBMa6Grer2WSM8oR/u0ztvEYcJDUODtSy4FSWACcjrBo92LRVbpSUAJxV1097stldYjY1uYlU8YKJfSkCC2L0/+dxFxMl2oFXM3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C3nZo2n6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C3nZo2n6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eg7DRK6dMUJej+ht+LW9yIFJ4JaBecaPx8FR8PWTaeA=; b=C3nZo2n62+uKCCnCUZs/k/kw1Q
	/sKvWP5860UuBFknFOYWHzw0S8560ib2H1PAO/rV+/icA9W6bfCBdg+GBsdBvZ7/qUUr1//nnO5D3
	XJJXKG4aCO4sAfaMjs+jZR/v9dvTUDAoXvevblCehV4mZjObRmrKqIn1YQyKrxZNnJlc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt7Zv-00Gq0k-SA; Sun, 09 Aug 2026 19:44:55 +0200
Date: Sun, 9 Aug 2026 19:44:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v11 00/12] net: pcs: Introduce support for
 fwnode PCS
Message-ID: <4c595c15-17d9-4c23-bb44-344c48d36e9a@lunn.ch>
References: <20260807131301.192060-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807131301.192060-1-ansuelsmth@gmail.com>

On Fri, Aug 07, 2026 at 03:12:42PM +0200, Christian Marangi wrote:
> This series introduce a most awaited feature that is correctly
> provide PCS with fwnode without having to use specific export symbol
> and additional handling of PCS in phylink.

One of Russells complaints was the phylink has too many bits of code
for ideas which did not work out and were replaced by new ways of
doing things.

We want .mac_select_pcs to go away, this framework should replace it.
Please could you convert one of the exist users of .mac_select_pcs, so
we get an idea of what that involved. If that conversion is pretty
mechanical, i think we should have a second patchset which converts
all the current users, and then remove support for .mac_select_pcs.

Overall i think the direction of this patchset is good.

   Andrew
