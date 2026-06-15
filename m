Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F94071EA;
	Mon, 15 Jun 2026 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538688; cv=none; b=dNEKclnxHr/zgKeF0SdNFS2UiaJWB6gMKrBEM2R7BuUVLJLR20ImatlhsvuQSnB9FkZpvSXwWX6B3QkBcP/O1oPiaeZ/HX8gCYDFHksOywx0p/ERt2EeqdyV180wIdmOgskmkCPH4roQ4xCRjFNBrz+nAoXeNwtGAt2bs01zuFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538688; c=relaxed/simple;
	bh=4z/uY/EvQNS4KgzAeXR8/1Nr6WYglooJLUqRNxAlzeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmTWh3omFfCljcT90fOGUqV7JxkeHusVANY+LfHN4Nbd4Wp1XKciA42KcKA2Dzk4ij7YsKoKZPMIBFUlWQCUbY0hz8azaRkvYwKOPCbPqsR3X0Wa3YjVKUUKuld45fUPkTJgK9h2K3FY/cBgBPk1DQoCPnImGjfOqLuzcYF/fpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v5jxVVPI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v5jxVVPI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EpUVm5FvAZB+cwzYPr0pG6CACwBH5F8UeDFzMUUGM8w=; b=v5jxVVPIxsMcqBUyG+Tj8zyFoh
	TB3IGW6RQDDAkVQISfIc/sExJ/Z0lFCSwE2BQbQFr4YcZq/TtXM7Tdrc3ZTdvaUWFscLM6OZvTb6O
	wOQwWJu6zWk5iaIhpfJcqxrX5705WnEforwmhLYrOysPQ3ckztU3Rk3hpyjXJSScAjVM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZ9ao-007pOC-0V; Mon, 15 Jun 2026 17:51:18 +0200
Date: Mon, 15 Jun 2026 17:51:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v5 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
Message-ID: <0b4b3deb-1c6d-4d06-8e7e-edc0643a842f@lunn.ch>
References: <20260615090817.429-1-javen_xu@realsil.com.cn>
 <20260615090817.429-5-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615090817.429-5-javen_xu@realsil.com.cn>

On Mon, Jun 15, 2026 at 05:08:16PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for loading firmware. Download some parameters
> for RTL8261C_CG.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
