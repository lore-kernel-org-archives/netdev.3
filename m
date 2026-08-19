Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC4424655;
	Wed, 19 Aug 2026 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129761; cv=none; b=mg2CJzdkBXT/fF+XWQw0IvZ7vGlse6yg/k0jcLptbadUxnFS2TxrP+ixX6Pd8f7Gzr29lcB0vCVq1ZffmzS6FXf3ejgx+SzJ2AiwapBmbnkILwTnhTib0pOrXC7jOBE3UWA/8ThNrvSYKPgYlYsjVrP0De1s8NyTFzXmbGH2o8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129761; c=relaxed/simple;
	bh=yj9wCK8gIFBTEnSeyi2JzjGORp7JwGP3z8S0caO30mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRPhHg2PgZCIvjvAt5vVXLF0Q+YgavZSzm7BWZV5nvK4SLEBxih3SSenyvNKhLBJVq13jT14O2KD7i4HgSa3cnpRWgyvmHlpv+Y54kMpSO6rY67vjNAyR2IKgY+F8W1jL8JzZeNxLVCAw9eF0cHREQ01BzXYVOQWCDqYmlQUNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAn0kDvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAn0kDvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116641F000E9;
	Wed, 19 Aug 2026 08:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787129752;
	bh=TVvgndVD51jhfZkfvFE5Pk3WKHC2WPQYGtbmSuWw6F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TAn0kDvFSUQwU9caqZDWU67xHVQvmrxEj3O0JU13kxWwtekNyZ9sxv3G3sZxxm+jf
	 vnwYM/v4d+iySTd8Fi5p0WPw7bNodUKGIB1wqchm3QBHOpmYjy4mpm37a9sqrrs2TV
	 BySFbX+MInnE3WXbFxLxs7MrfeZgMIJsouZQRD4hok0EDAzwfIyW8he8PzKQZCaisc
	 8Nus76yowB1/P2YDcibmHjAO3z5ulT+hhdEMk9uvu1rPWbVofF9qMDiYMDRCSH/HlA
	 FeiFC+ml2SzOxZjN5j1bxQNX3Qh9sNe3Lcc49KWcUrSCEOG/umQX44xY6i2fP7tPja
	 SPaRXdBW8MdTw==
Date: Wed, 19 Aug 2026 09:55:47 +0100
From: Simon Horman <horms@kernel.org>
To: Marek Czernohous <mczernohous@gmail.com>
Cc: netdev@vger.kernel.org, Rain River <rain.1986.08.12@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tobias Diedrich <tobiasdiedrich@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] forcedeth: stop the tx_timeout register dump
 past the requested window
Message-ID: <20260819085547.GN265046@horms.kernel.org>
References: <178682367884.3748309.5288746298966501007@gmail.com>
 <178682367886.3748309.6978554332066826294@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178682367886.3748309.6978554332066826294@gmail.com>

On Sat, Aug 15, 2026 at 09:54:38PM +0200, Marek Czernohous wrote:
> From: Marek Czernohous <marek@czernohous.de>
> 
> nv_tx_timeout() dumps the register window in rows of eight dwords:
> 
> 	for (i = 0; i <= np->register_size; i += 32) {
> 		netdev_info(dev, "%3x: %08x ... %08x\n", i,
> 			    readl(base + i + 0), ..., readl(base + i + 28));
> 
> The loop bound only checks the row's starting offset, so the final row
> reads a full 32 bytes from a position that is below the end of the window
> but too close to it. base is mapped with exactly that length:
> 
> 	np->base = ioremap(addr, np->register_size);
> 
> so the tail of that row is read from beyond the length the driver asked
> for. Per variant, the last iteration reads past register_size by:
> 
> 	NV_PCI_REGSZ_VER1 (0x270): row 0x260 reads to 0x27f, 16 bytes over
> 	NV_PCI_REGSZ_VER2 (0x2d4): row 0x2c0 reads to 0x2df, 12 bytes over
> 	NV_PCI_REGSZ_VER3 (0x604): row 0x600 reads to 0x61f, 28 bytes over
> 
> This happens on every supported device, not just one of them. Note that
> it is not a consequence of the sizes being odd: with i <= register_size
> the offending row is reached whatever the size, and a size that were a
> multiple of 32 would overrun by a full row rather than by a remainder.
> 
> To be precise about the severity: the reads stay inside the BAR. Memory
> BAR sizes are powers of two, the driver only accepts a region with
> pci_resource_len() >= register_size (forcedeth.c:5757-5762), and the
> next power of two at or above each register_size already covers the
> offending row: 0x400 for 0x270 and 0x2d4, 0x800 for 0x604. ioremap()
> also rounds the mapped length up to page granularity, so the reads land
> inside the mapping the CPU has as well. What they leave is the window
> the driver asked for, not the BAR and not the mapping. That is still a
> driver reading registers it did not ask for, and it is trivial to
> avoid, but nobody should expect a fault from it.
> 
> Changing <= to < is not enough: register_size is a length and every size
> above is larger than its last row start, so i still reaches the offending
> row. Check that the whole row fits instead.
> 
> The trade-off is that a partial trailing row is no longer dumped: 16 bytes
> for VER1, 20 for VER2, 4 for VER3. That seemed preferable to reading
> outside the requested window, and to open-coding a second, narrower dump
> for the remainder in what is a debug-only path. Extending the dump to
> cover the tail can be done on top if anyone misses those registers.
> 
> Only reachable with the debug_tx_timeout module parameter, which defaults
> to false. It has not been observed at runtime: forcing a genuine TX
> timeout on the reference machine is not something I can do safely, so this
> rests on the arithmetic above and on a build test, not on a reproduction.
> UBSAN does not catch it either, since these are MMIO reads rather than an
> array access. It was found by reading the function while fixing the
> saved_config_space off-by-one in nv_suspend() and nv_resume().
> 
> The dump was introduced with a fixed 0x400 bound while ioremap() mapped
> only NV_PCI_REGSZ (0x270), so it read about 0x190 bytes too far from the
> start. Commit 86a0f04387bf ("[PATCH] forcedeth: fix initialization")
> later replaced 0x400 with np->register_size, which shrank the overrun to
> the remainder but did not remove it.
> 
> Fixes: c2dba06dae7d ("[PATCH] forcedeth: rewritten tx irq handling")
> Signed-off-by: Marek Czernohous <marek@czernohous.de>
> Assisted-by: Claude:claude-opus-5

Reviewed-by: Simon Horman <horms@kernel.org>

