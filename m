Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263C13A1A26
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343965; cv=none; b=BAWfqNp5Vwmb1JXF9U33GKhxW0GvQODJvwyYiamFyp21R1/HzXPAEubFXQFHFCP4dU/Z///XjgI1MK8isozaCPRkLvaXwZoiN75ic1nix4G7ZuY40nNhKQmpd/H++/ZtkL5FFmiaWN0p14UzFIvZfHjNvG+8mvIyS47jJqDJDTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343965; c=relaxed/simple;
	bh=dqztLAEjQt25I4z6TvIhZhRmwvhsEHhSiihQ+t4gxPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSWe4+sAhbnr4OfAJrSMjyL3yxof+DYzwzhyE6Y5UBc6aNnD0Fq1Zzea3zgYYCgC6PBkbckbXNyz8i6rvMpGCyolKgrkxhYYKSUC/1eOloljdWSm3ufEoWoRA1dJyV0RC5FsmVKwzCEPv3lqqjtFJvi50g9WUGcJ08cBZ2oRNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a7QG3wHI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a7QG3wHI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wmCkvVLaR+rDdpiswuyBWNbJIzNwVmoEfscdzHsxPY4=; b=a7QG3wHIEqBeNup0aOP/3SXNCK
	b/fgiENDUdqt+qKEejNuut+mH5qWjF2CL2uJ6na0VbQ8wRYS7cePRgEg1o0e9cjIj9ef3zN8kkKzh
	iYQu6H38mK8vhU3EZxbXH06yBS6N7LYIISBgvOsB8V2CbLLtp5ttvduJVWmcNBQ5W010=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wxVo3-000yLH-Ea; Fri, 21 Aug 2026 22:25:39 +0200
Date: Fri, 21 Aug 2026 22:25:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH net-next] net: stmmac: stm32: Set TSO/TBS Tx queues
 default settings
Message-ID: <5d48515a-862d-4990-b4b4-12d86fb6f3b0@lunn.ch>
References: <20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de>
 <20260817103337.74c30adc@kernel.org>
 <87mrujzzjv.fsf@jax.kurt.home>
 <20260818075335.48936b08@kernel.org>
 <87h5kq1s1f.fsf@jax.kurt.home>
 <20260820144528.7107ba90@kernel.org>
 <87y0e0x7ic.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0e0x7ic.fsf@jax.kurt.home>

> No objections here. I've briefly looked at the TBS thingy. I think we
> just need to reconfigure one Tx queue instead of doing a full
> release/open cycle. The XDP/ZC code does something similar. So the
> infrastructure seems to be in place.

I suggest you look back in the list. There have been a few emails
about people working in this area. You should try to do some
coordination.

There are some symmetry issues which would be nice to solve.

	Andrew
