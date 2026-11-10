Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316867;
	b=thcBKonBsfcGyrU6VI1YJVq2U62/Lu4orQTPijD3tOGybHncAxPA8FwYy5lwPTeXl/UX
	 3KDQF2Rdnph6/4Sc8UfqK/8OoiN88LLkNpDbIPr+UyA/ueYj2WvuotQHk8C79uWGfLwMl
	 jTMf+wvCtpbnse0YZjyXXPO1vQWdzhW7gvsn6webQAnVxJHtn5IA4BeN0xCQXtDK7gLJ2
	 6usANq2pj+XNyOM+gii78qpkQ0znisHc3tf2t3F4B7hpGg8hbv5c+SjBAP7xcxHljtkjo
	 uJt69iag7pVcUY/2mMkpdyAk2uwndq0RQl37Z8ToAFUIzhr4pUga+kSv9Ag60k49tzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316867;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3KmJj98pjmOS6ArH+mC3Dc/dvsMdB1K1uCEscB7vPCo=;
	b=leaWMnW65iVUx4U0yRvAkbRVyHNOuSu8pOo6z9L4HVtDlY+4wYBCVc9EDMyg2UxtN1jj
	 BRKyX1UD7l39DBPK0DQvb8W2CPuM66WaHlHa+pn7XUJN9FZj9M2LDpsvmK4alIkAHjFFh
	 2/9AHAwKVWJob3lC98YcwIfTX9FMCJVptnk/EFH89vZafBdoJlub+/IxOqo4/Iyfwp9fz
	 coUUz7IFvAd5bQQ+y1uOy0B6o8y+433K5Tcf6XXLBePVkhAC2OTZCA3uYr92x07OgKAq3
	 q+DE+MkcB6qR8RIXAYZdkEcNNFuVQGdeYypea5xrCwdKTZeIQJxc+oVzawhJb/jG41g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=cdCgFvD+;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4166606A770;
	Tue, 10 Nov 2026 13:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4166606A770
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=cdCgFvD+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3KmJj98pjmOS6ArH+mC3Dc/dvsMdB1K1uCEscB7vPCo=; b=cdCgFvD+aak+2qa0hM9tdatBab
	qqdGTPrKvq8aqPIMf6w2hUUL0KPAJFsg8lAR0hB/H7RM1sv3966DWWDRh16DIj8zg5JxrKDZvlxkU
	mUD34+iB4j0eUii+Ce21fShvOT/JFYiZsk14Tck+NnXJ+XS0K5Zc9q3wflJScWf+xYjc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQlmV-00FU5O-PR; Tue, 10 Nov 2026 14:20:59 +0100
Date: Tue, 10 Nov 2026 14:20:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev-bot+sashiko@kernel.org
Cc: mmyangfl@gmail.com, netdev@vger.kernel.org, olteanv@gmail.com,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: dsa: motorcomm: Fix stats64 error
 counter mapping
Message-ID: <84b7c0d7-c167-43ab-9384-869c0bb40ea5@lunn.ch>
References: <20261107132040.1066996-2-mmyangfl@gmail.com>
 <179414774671.994134.1756882573318817305@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179414774671.994134.1756882573318817305@kernel.org>

> [Severity: Medium]
> With the tx_fifo_errors mapping removed, TX undersize events are no
> longer counted in any rtnl_link_stats64 field, and that includes
> tx_errors. Is this intended?
> 
> The tx_errors kernel-doc in include/uapi/linux/if_link.h says:
> 
>  * @tx_errors: Total number of transmit problems.
>  *   This counter must include events counter by @tx_aborted_errors,
>  *   @tx_carrier_errors, @tx_fifo_errors, @tx_heartbeat_errors,
>  *   @tx_window_errors and other errors not otherwise counted.
> 
> A runt frame may not be a FIFO underrun. Could tx_undersize_errors still
> be added to tx_errors as an error not otherwise counted?

It should not be possible to send runt frame, i expect either the
hardware, or the driver to pad them to 64 bytes. So i don't think what
the LLM is saying is valid.

However, it would be good to get this counter reported somewhere.

	 Andrew
