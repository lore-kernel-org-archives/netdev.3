Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC43603D8;
	Tue,  1 Sep 2026 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267038; cv=none; b=sKFydEwAhcw+ySud3lvLFdxotRkS7tkMMmdUV8rlqnafDvaac86pPils+Gu9Vaa8/7vQegU3GnCvMbecdf+XmooJL6imHF/LT3M1FwtY2yo1gQShGrWfVOT3bk/m4jgmMV73KTyg0IpXA1kiKIl1v2ReIpYzUsiDRmfkiAOeRoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267038; c=relaxed/simple;
	bh=jLonyu/ekW4NKBA9nKW4SNryrEm2EzGtjFqYDLiwuVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONQc8vCCwfjqzKMrvMaf/Poswx7ZWu6HWBjMmL542foM0rNp9wlnvOBwuAFUj04K0U9jHCwR5PhZEMB1flhza6mQcFZLbcQu4QmfurLd2fBdMx50N4Qvj2JCXMTWAzTyedNYHdVGDxXiWi/gmiylEuy0nqwZtSLbzFFnXfM9QNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dzTDo7UW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dzTDo7UW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OUGnto1UaSVcuSLfG7pwMcvHQ5YpEL5urexadRMv+b4=; b=dzTDo7UWrxhi/79t+KXfXVjfZj
	iSMYrlWJogstEozyrLiHn7FSbOc6etkayF5o43T1k/alRXkAUHA7U+9N1A8B7GTk/QJw+lW78DYO4
	ivXWA2g52xJApIuPXUZLRhCD0HoWDz3T1g/gUKh2/paEgSc8yn6JPezMO3iRjW8oAYDQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1NwZ-002MA8-Mz; Tue, 01 Sep 2026 14:50:27 +0200
Date: Tue, 1 Sep 2026 14:50:27 +0200
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
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac4: Use the full perfect
 filter ability for UC filter
Message-ID: <5a5b9bcb-f845-4b05-b213-7b7f09721198@lunn.ch>
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
 <20260831070121.349778-3-maxime.chevallier@bootlin.com>
 <285c8969-2f0d-46de-b098-60ff10f30cf6@lunn.ch>
 <493afde2-8603-41e8-b6ce-f8e399c53275@bootlin.com>
 <c7819431-d33d-4e9c-ab36-be55b94d29f4@lunn.ch>
 <6f395b75-d5ed-4536-9f9b-9de2f56dd9fb@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f395b75-d5ed-4536-9f9b-9de2f56dd9fb@bootlin.com>

> Looks like it yes. I'm starting to wonder if we should maintain this
>  kind of TODO list in the kdoc. I know these types of lists have a
>  nasty tendancy of falling into disrepair, but this could help.

drivers/staging has such lists. You could follow that format.

	Andrew
