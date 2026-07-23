Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF006470E96;
	Thu, 23 Jul 2026 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784768689; cv=none; b=hnKUNUV4OOwgvf91pYWf6JFMYVJjdyf3sSpS/J5RCo+IQX/ZwQs3QWgy2HM7dJYzGc9dwLU8eDfAY5s3vaow65RHAEe8KIZO7c8kySU8bUV0+r1d/hoS/BO2wnCxrjCV+dEZ9B87aKugj5tBm3CZ3dzYNrX9uNd6s5VX5eIhO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784768689; c=relaxed/simple;
	bh=NQ3TH2/FOtjQtb2Raa+I9n3MtjHyM9tMCx5y/ojUNps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efgxejmiNkWZpLmc3Km1g2tMNeTHGKKa7IHYrN/7yGpeJb9CpTzRhw9kZZpMAFEdhAYBXlTex3ko2zp/7lkh21mIzoXCJcnMypcKiBD6Xrt0YeFQuMY/xugh7v6QEKcirxEvxd7BWzGdIxPTz/JEc7A8B0o1VPCKDAgxXZntXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PSBtoAoC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PSBtoAoC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kdArbP/jiOXvzq/geRcwKkqwmTgaLyKHNpOSh9OdpN0=; b=PSBtoAoCnSET4TbcxUFIxUiXSN
	OCNav7qO1TtXSAvZsZ8cfc3r5tzvXiSSs52W5IUU3O+yhDMWjrEX/uJByG6eR1eeZzQkuaE1ej4tk
	wLqgvlMkNe9yfb3bYmcGJixzcaZfpWP4Su9WdlXcKPMJL7MnUETI5NUaijXA0G7fDujU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmhrZ-00DidJ-4L; Thu, 23 Jul 2026 03:04:37 +0200
Date: Thu, 23 Jul 2026 03:04:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, linux@armlinux.org.uk,
	enelsonmoore@gmail.com, daniel@thingy.jp
Subject: Re: [PATCH net-next v7 3/7] r8169: add support for phylink
Message-ID: <bb3be7c9-2f7f-4871-9b3c-bc5958cdb6d6@lunn.ch>
References: <20260722022906.271-1-javen_xu@realsil.com.cn>
 <20260722022906.271-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722022906.271-4-javen_xu@realsil.com.cn>

> +	if (jumbo_before != jumbo_after) {
> +		unsigned long caps = tp->phylink_config.mac_capabilities;
> +
> +		if (jumbo_after)
> +			caps &= ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> +		else
> +			caps |= (MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> +
> +		phylink_update_mac_pause_capabilities(tp->phylink, caps);

The name suggests it only changes pause. So i would expect the caps
parameter passed here to only cover MAC_SYM_PAUSE & MAC_ASYM_PAUSE. So
i don't see a need to look at tp->phylink_config.mac_capabilities.

	Andrew
