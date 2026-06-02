Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9463CC7F4
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403058; cv=none; b=XXCs44e1UzxlYzVzsQFYZzf8XaN/46zDKgk6uOowKhn4KV173ActC00HWo0L8ngERunwSTmYHv87yIUCWrqS4fUbNkDUtn/aaTAgTEp7xKci83yD0ZYayv2PILcnkdwGX2C/63WIyfZjXGmlm982pO/G/z8ZCcaSoNBkTDD6GG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403058; c=relaxed/simple;
	bh=JPM+en6EcNTlPjTu9LC6nmKnPrVs69VzRnaCBMOC970=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk1XnUzSHCgCpXZrdU7fZX9tXTxiIgSIncyT2IGJtxcIs4Uda8vaeTnAgL24K3k9JnlCw1L4xtI3oe5IrH/ln3hc+Im6FkzGEpLHzrefCOooYp2yPClWzTXIE8wFnKFFQ9SCAcMyhPUvlAh2SXxwoBy63G7JwLgmDd8f/uITJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=41ZFq7BF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="41ZFq7BF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MKePJJlsHF3YCrXp8Y2rqpvWz1d+QV1eomqbDiUBnDg=; b=41ZFq7BFcg2hUjqDWLN6lfJnL/
	2pR+MFhtgSCy+Ph5NFAkacThSWVEkoQm9BfkE5ar7+LLUQBUvnt3moFF97RHJujAtRbfENQD2qwPb
	RVftjORAjT9vAvIot3jaVi1sOUrwOoQ/78XNSUExKtVcofSq9CEN2hMKH+p1CxJBkVRo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUOAC-005gWM-TR; Tue, 02 Jun 2026 14:24:08 +0200
Date: Tue, 2 Jun 2026 14:24:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, mensi@mensi.ch
Subject: Re: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate
 topology setup
Message-ID: <d56efb0d-c288-43d5-b3c4-922a164fd29e@lunn.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-7-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602052640.93083-7-markus.stockhausen@gmx.de>

On Tue, Jun 02, 2026 at 07:26:38AM +0200, Markus Stockhausen wrote:
> Until now the driver sets up the port to bus/address topology of the
> controller after all buses are set up via otto_emdio_probe_one(). This
> does not work for devices where U-Boot skips this setup. It is not
> only needed for the hardware internal background PHY polling engine
> but essential for access to the PHYs during probing.

Talking about polling, when do the locking issues around polling get
solved? How many more patchsets before that appears?

	Andrew
