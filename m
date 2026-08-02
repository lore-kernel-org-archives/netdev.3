Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DC3BD224;
	Sun,  2 Aug 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682955; cv=none; b=Kxsc1nC3l8r9V4zcYmhehnjvJMgYdAsjnoT+0OyLxjUPUiL459kQ89a7h21vYzj1FXYfYMyZFVPbiQm5FDr/mU0ItcrdaZSOz2DzD4fpvb9ycbU5BG8lY2R8+esfUwekn6ejTNXSWiXxR5+b0DbTZde9k6ZQ0t4tTvoHTH4fYJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682955; c=relaxed/simple;
	bh=bpOtL6QI5TJCqqJU3CxBONtWOAb7CNo8aWVEeGA3Cf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8IKFPwSjU29vDnIPdksY04pUPfVhLlvR8TQasA8BCqtcgVoUq5ms8ADFnesCFOdB59J4bhxBNNqEjPk+T/Wo7IP4ZBj1Y/kAxzztkMfrBIxRlF4+Vennq+FAISVEho9hO3O2uKs01Kn4nIo45cfT3SZFf0RwBq3tcscFGPTVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xmowSal7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xmowSal7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xLT0nYUZfgrQIfwgHzReTeSdEFhpRIhjhhekCFsbM6E=; b=xmowSal7u0s+kzQGmyUMBwtMj4
	IVWXC5+B4CyEczCVDAcIOuPU2BdnHDnRsl1Awfi3SIVhW3SVcfSCuhB14cl+C+s9Nm/pePX0jK6C9
	rd94MGaTt9BhWFZXFdeXy6cPOH02VfstvYE9wRKCnhAloU/Av7AYTciYPUn3FUz93CoU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqXhn-00FaJs-7O; Sun, 02 Aug 2026 17:02:23 +0200
Date: Sun, 2 Aug 2026 17:02:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 1/2] net: stmmac: ethtool: Comment the magic
 numbers in RIWT computation
Message-ID: <d82898bc-2d03-4701-8cdd-47716256c55a@lunn.ch>
References: <20260802114015.214212-1-maxime.chevallier@bootlin.com>
 <20260802114015.214212-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802114015.214212-2-maxime.chevallier@bootlin.com>

On Sun, Aug 02, 2026 at 01:40:13PM +0200, Maxime Chevallier wrote:
> Receive Interrupt Watchdog Timer is an RX interrupt coalescing mechanism
> used by some variants of dwmac. It allows waiting a bit before
> triggering the rx interrupts, allowing for batch processing.
> 
> The RIWT is configured with a granularity of 256 stmmac clk ticks. Let's
> add a comment for that and wrap the raw "1000000" into USEC_PER_SEC, as
> we're computing "how many clock cycles in one microsec" with that step.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
