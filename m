Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9213542E5
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113420; cv=none; b=EdDC5Voo0/vs+X7aHCYSH04hEBqCRfJ7WaFZtzIIE+yS/zFdddIqkjKVRm69Q/bW5Wx+rR/45ltmOKzG4jYZQhn1ccVOMQ+vtF/swt2pC53YijNIrekwc/7e3ej80NhGvmI+I3MvU6LvSeQEfdxx5iogsgEQcSrQ5L8vaV6s+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113420; c=relaxed/simple;
	bh=z5ggFBTCYXZ4iQPoi4R7C2G+I1mDqrCkwTxUWC2hdKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCqHhVUp3b3c5lycozR1KMyxwvVvDf1cGmohnJZ5WuePALHBOkFCfg8ClvJgJnkQgdJumJepquiYOMoGK3tPgZ+1RAwDzYuCJ0F+QAZQf/OMCQBVEwjIGcHPdma+9dhUQFdirbZoVLC+W/+K7mUu613G3yi1r4s0pr84NQMUys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESXWXt2D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESXWXt2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95926C2BCAF;
	Mon, 13 Apr 2026 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776113420;
	bh=z5ggFBTCYXZ4iQPoi4R7C2G+I1mDqrCkwTxUWC2hdKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ESXWXt2DCvlxBlS7DZFuJv6w9UMrL4eE5LY548srRAAVL4+tOUroVEm7DEP0ExrgZ
	 acDFtv/Xo/9kU1VNXyqRF4YSya1rtvAnYin/psxase9mwTnDBn/GlmFhYlpRqOGtEr
	 +QLv+mUlypfngz6t+344btCEjXgGEV2JjqtVJyq5aOQaW2qxC3zU6dxcUxUX3Ouib0
	 rST9qZKgnReNi1aCQIUK2sLSj2i6je8te6XykaDgjpMnTWM0+zw/w9j5HOhjZiYa6y
	 dQS/AUAm2WL3Ab/jvMMXvzUPHJUTzVX5MQ2LmHMrc7QmsEuJsWFNCk8MX96Utz8ofa
	 EWSduCx8bT47A==
Date: Mon, 13 Apr 2026 13:50:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>, Sam Edwards <cfsworks@gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Message-ID: <20260413135018.59fbd3a1@kernel.org>
In-Reply-To: <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
	<20260413110222.49fc3759@kernel.org>
	<ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 19:49:46 +0100 Russell King (Oracle) wrote:
> > Firing interrupts when Rx fill ring runs dry (which IIUC this patches
> > dies?) is not a good idea.  
> 
> Well, I'm thinking that at least on some platforms, such as the Jetson
> Xavier NX, unless a different solution can be found, we need the RBU
> interrupt to fire off a reset of the stmmac IP when this happens to
> reduce the PAUSE frame flood on the network.
> 
> If we can't do that, then I think stmmac on these platforms needs to be
> marked with CONFIG_BROKEN because right now there doesn't seem to be any
> other viable solution.
> 
> My intention with this patch is merely to start collecting the already
> existing statistics so other users can start seeing whether they are
> hitting the same or similar problem. If we're not prepared to do that,
> then we should delete the useless statistics from ethtool -S, but I
> suspect they're now part of the UAPI, even though without this patch
> they will remain stedfastly stuck at zero.

Understood, thanks for the extra context. And the statistic we are
talking about is rx_buf_unav_irq ?
