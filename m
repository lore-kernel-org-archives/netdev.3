Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54733AA4ED;
	Mon, 15 Jun 2026 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538444; cv=none; b=MuQX+pSLwMxHVgX4HLwv3CEAWpojFQUH0l/K2EE2aXfWsacpWPuu+YNgJvjrinVmTjukecr9Lmy3iQsJoFqyOilBBNtJbhLBkqfjBfCVJO0L75jSDbREzUquufKxIf0uyusyHUzWW8bGQa9jpSLGkrTGV5F89iQjblEmifUQNrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538444; c=relaxed/simple;
	bh=ODPoqvUZvmQ0lvE4hImQyI+r1CdbyQtfWgdW9JBM1UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqyVtsZ8Caf8gLFR0Xda0g9KMM/SFNvAjPAoLO/Z7YHO+zTWYIFR2q2jUuTMzmpKcZAYAZjTUhUW0STtdk2E1MtvU0Ti4Kh77Sp/r5hTy6e/O7PUdnPQjjoYGd0Vlx3cneOnTiZcNHdPbjNbhVTyaqFRDXoHa7kue3qnvgltWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DN50c2KJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DN50c2KJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J4Dxmbmydt3VIHFZ27EBOzcW64ZoZHqTVSYTx4qzqME=; b=DN50c2KJi/eNRsABmuGas8AhF6
	1iFReYKgAkeXDyIayNjuqIZfVO3FZEX0vyxBWjcJw1FKSeYhqREftIVUOv6gEEEdSRXLzRu66YqSY
	VsvToT3kVXv1brXyoDTI+jTT6hrcIJKj35hRQ+KhgQE/k2t5nBx738Na2TvxSIxPjKaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZ9Wg-007pLf-5S; Mon, 15 Jun 2026 17:47:02 +0200
Date: Mon, 15 Jun 2026 17:47:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v5 2/4] net: phy: c45: add
 genphy_c45_config_master_slave()
Message-ID: <4893389e-e945-40df-b706-dfb53853c8ad@lunn.ch>
References: <20260615090817.429-1-javen_xu@realsil.com.cn>
 <20260615090817.429-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615090817.429-3-javen_xu@realsil.com.cn>

On Mon, Jun 15, 2026 at 05:08:14PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic helper to configure forced master/slave mode for Clause 45
> PHYs using the 10GBASE-T AN control register.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
