Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4336C360ED0;
	Tue, 18 Aug 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065642; cv=none; b=rucji7LF+K+s9kixAayU1Iq3E9tt+IBJX+6YLc1geaOMxOcrmvSXGV53Cx3J84saW0OlZOZG7VRG22qohfqRcE6saIjk6ZVnDeGKzr5EP8Yu4Y44MnnpOHnClmAvKIKygon4ccG+0HN/DLqF7bzCfs16v+J8x4vwPpQn6mwZdf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065642; c=relaxed/simple;
	bh=4C3TKIko3gSyohe+5IpZITUsFptF3QxLaQk/wLWlwD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdwKV5jr5d1sO5AaWBYmnU6irxFryLqG1gL0YaT06afK7yCjfxnI75q7/PC8+obMEc9RxWq15SEdLsQmPvTHZGVT4wQejcD4Z79YdIQgE6aVKQYBxeB2j6g7rjowMNyo/3tGFYEPuu2/WsJAx/4pdhnDWKiUNf/dCv9og+Mdt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HJDwoHnu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HJDwoHnu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pdPRxrEVxkRTnxbxy0G0Bkwkh+T7ymPVpHD7pAR7Pis=; b=HJDwoHnu3Lv5yPBl2QlpYWnyja
	0lc9+AOiFMWkuC81qlWE4K869ndtt3h3JzViNs2AVgGp75Ielx8YIvI+ykbucFWEHSCTS0mrcSmxW
	Lu3PN/KRU5qISeg6NbwJk72o3e3lqbPZFo948aIVDxZWWNu/GG+ySJlJnuzdoCeuBrOk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwLPC-000UDp-I8; Tue, 18 Aug 2026 17:07:10 +0200
Date: Tue, 18 Aug 2026 17:07:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
	richardcochran@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	muhammad.nazim.amirul.nazle.asmade@altera.com
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: dwmac-socfpga: mask
 XGMAC_TSIE during cross-timestamp
Message-ID: <b53e9ebc-64c3-4291-a691-5b7ddd118cc5@lunn.ch>
References: <20260818132722.1852876-1-zxyan0222@gmail.com>
 <20260818132722.1852876-3-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818132722.1852876-3-zxyan0222@gmail.com>

On Tue, Aug 18, 2026 at 09:27:22PM +0800, Zxyan Zhu wrote:
> The Agilex5 smtg_crosststamp() handler arms an internal auxiliary
> snapshot, toggles GPO0 and then polls XGMAC_INT_STATUS for TSIS in
> process context to learn that the snapshot is ready.
> 
> Once XGMAC_TSIE is unmasked (done by a companion change that enables it
> in XGMAC_INT_DEFAULT_EN), the DWXGMAC2 timestamp interrupt handler runs
> from hardirq on every timestamp event and clears TSIS by reading
> XGMAC_TIMESTAMP_STATUS.  That read can win the race against the poll
> loop, which then times out and makes PTP_SYS_OFFSET_PRECISE fail with
> "Wait for time sync operation timeout".
> 
> Mask XGMAC_TSIE around the snapshot trigger and FIFO read so the hardirq
> handler cannot clear TSIS while smtg_crosststamp() owns it, and restore
> it on every return path.

Did you look at the other system which implement crosststamp?
dwmac-intel.c? Does it need similar changes?

	Andrew
