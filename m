Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082E3CB2DC;
	Thu,  8 Oct 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487254; cv=none; b=CdVEMO5sy3YYeFKGD1layRjpPZ6z4FFDr5Bt8cC4ZmEtDJrHqsy7mW5oxFYi6laH5yPe2KLJ67shGOcUpzteejdkb+BseFlOtXpUCLsVLYmimlk3sk6VhRGgluV58KYLDTIdrwTu1vjZdVQs51HgTS6HxIn11EoGlmqwp3gpqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487254; c=relaxed/simple;
	bh=Lr0YofJuvB/cxUVYTgtX2pzsLj7GIcMD5H+4H6pC/DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WufUV4J9x3NnjOjwdhqhULdAY4GUb2qyBfrJRkCmwsRnp5DWRVVNYdwlOFzm2dYGlkY9G/h5NMzkWAt559Nv1mS43CYIRqPFad3Z3y6HJAwVgddhsJ601lxUknpRPyqt/JkP8tLNgGMGhY5YtcTstPZxyIT8VzUCBXWa01H6/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MMtJ4nEe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MMtJ4nEe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Vw8k6LKBeC1Nrn51i6w9hRTe6YpUNnGX7Cuj7Kwd6OA=; b=MMtJ4nEeF047037huGqtilTYHh
	kXCbtNmbi/IbSzHxlOT8wiH4mHhWSxxkIsKsaFPQoE8Y4Sxh411/Q0sbbxZf9LASBKSAwuFmjn3av
	Ft25AZJXzKsbLGURP2lsRRhsZ9bSCwCzrjBRelZWjj/psJdlIaiY/EKINsd4MIjdogyw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEtfX-009gHz-P9; Thu, 08 Oct 2026 21:20:43 +0200
Date: Thu, 8 Oct 2026 21:20:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Josua Mayer <josua@solid-run.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mvmdio: fix clk reference leak in orion_mdio_probe()
Message-ID: <d751e352-8f67-40cf-97ba-89f40adb8a69@lunn.ch>
References: <20261008165328.2702289-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008165328.2702289-1-vulab@iscas.ac.cn>

On Fri, Oct 09, 2026 at 12:53:28AM +0800, Haotian Zhang wrote:
> orion_mdio_probe() calls of_clk_get() with index ARRAY_SIZE(dev->clk)
> purely to test whether the device tree declares more clocks than the
> driver supports.  of_clk_get() takes a reference on the returned clk,
> but the return value is only checked with IS_ERR() and never released,
> so both the clk reference and the clk allocated by alloc_clk() are leaked
> whenever the DT node has more than four clocks.
> 
> Store the returned clk in a local variable and release it with clk_put()
> after emitting the warning.

net-next.


    Andrew

---
pw-bot: cr
