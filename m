Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74617313273;
	Wed,  3 Jun 2026 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492783; cv=none; b=ayG43/nksdmrroMwnAMIbKfOFWGk0D3zp8648ItEZg4hPj3bl4APeoDH6KTaMm1ZCHSd72tARpA2GSUbLgAGWJeHR+JfX2kJ6ZUpuPucCmXa+1opElFqhSQMgztqF/oIk/u5Bv5o0pBhDlOW6ZB922hI3qxMKEK7+ZXmB5cW5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492783; c=relaxed/simple;
	bh=NFa6KQ3vjWeXZnXrSWmWKuTvoErpt/AEQU9kJhkTnuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLwuCoi0ZqYFtDwwV9MAYo4oQR4Iw+724niYXWEb0awV1XW0jMcQaFNRFKHLIQ54X8G9cYA0cl0GMTnRcwAfiknwik287GpFhcIfKzXDVGnv0iZRfouAfJnVsP5GWOoG6Wk6i/Pt68BrVARQseLOPYYAuCBa6OywcccCvZ4mKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rB4Hfr0A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rB4Hfr0A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xDdnXZVSz7c9OiCPekiUjQRgKeTsn6b8bC3uiCv3KQ8=; b=rB4Hfr0Avy20E+sifmGlDGIdFL
	MO5bBtsgOAtcAK07Nrmerqgu/JDWXsg2VSe8KiyGQfS5EPgFnFgVz1/sxo3MDrYroznINuxexdV2t
	FZ9TU2VW0esFFPPDB78JsX6GLb9jNaZB7gMuQSlZ89QipppsSup7zHY/lNpSYEgnq3s8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUlVM-005snt-CD; Wed, 03 Jun 2026 15:19:32 +0200
Date: Wed, 3 Jun 2026 15:19:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] net: stmmac: L3/L4 filter fixes and improvements
Message-ID: <c56e74c1-fc3a-4d76-a17e-8a7d365d1e70@lunn.ch>
References: <20260603072925.27890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603072925.27890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Wed, Jun 03, 2026 at 12:29:21AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> This series addresses several issues in the stmmac L3/L4 TC flower filter
> implementation for the XGMAC2 core.
> 
> Patch 1 fixes a register corruption bug in the L4 filter port configuration.
> The XGMAC_L4_ADDR register holds both source and destination port match
> values in a single register. The original code overwrites the entire register
> when setting either field, silently erasing the other. This is fixed by
> using a read-modify-write sequence.
> 
> Patch 2 fixes the basic flow match parser to properly reject unsupported
> offload requests with -EOPNOTSUPP instead of silently accepting them.
> Unsupported cases include partial protocol masks, non-IPv4 network proto,
> and non-TCP/UDP transport proto.
> 
> Patch 3 fixes a stale action bug on filter deletion. When a filter entry
> with a drop action is deleted, the action field was not reset, causing
> it to persist and potentially affect subsequent filter configurations.

Please base these on net.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> 
> Patch 4 adds L3/L4 filter match counting to the ethtool statistics by
> reading the L3FM and L4FM bits from the RX descriptor status word (RDES2),
> allowing users to observe filter hit rates via ethtool -S.

and this one on net-next.

    Andrew

---
pw-bot: cr
	
