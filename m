Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD943B4B7;
	Mon, 24 Aug 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582328; cv=none; b=SxQ+cP5Twb9/u202bkJ5zQ0dpjGO8Wdu0yi3iiIJvSWkxI0KazYrHbqYkCfn1T5RcDV2hKKLR5Ahz342ObXB/5nEyI86mLT7tOqJ7vu/yP1wy8L4v6a61gLdeO7D+tCgBexEsyALGjzHoDQ28xiiPc9ORBV8POS69MAbLW7YbDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582328; c=relaxed/simple;
	bh=jUigzigMBcY5CrlT5RAFdIlrgtxpRzKYr/n0EcHb0Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BejVb7FudRN1pwnJfEMDqKXek9up8ulRV7SuSqJvwLM35rS/R9kaU5rckvy1+k5JtpgLkNC5GmOeiW8F2HRx/CBp6Ix4oaDwP5jaUsE+oC3OnFkyY5Xvuz0vV/zAkmQz3Nhxi+3BFpxNu194kCd6If+CvCb0HjdXsvCD5ExUk2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s8dem5j4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s8dem5j4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qcLGE5Hm4FT0E+fW505BXxxdkurB7ngutgUzW66D6h0=; b=s8dem5j4EECqgL4n69tts7Ty4n
	f7Gf1yEUTwN3+xDsXasT7PfQrNk+97ki+wQDehc2qU6m0818dCkZ7GmLuydc2gSoRwHyfil2z7ooS
	REZcne4zX+bfCYW5Ifpm1rUH3+Be3BozY6a1Qe38/0f5hDgN7GpOuWahidF6qgK+hRXE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyVor-001FT3-Jy; Mon, 24 Aug 2026 16:38:37 +0200
Date: Mon, 24 Aug 2026 16:38:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lucas Poupeau <lucasp.linux@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: 8139too: use unaligned helpers when setting MAC
 address
Message-ID: <01d2ce1d-7864-4f77-b6a5-995e01638935@lunn.ch>
References: <20260824103709.98373-1-lucasp.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824103709.98373-1-lucasp.linux@gmail.com>

On Mon, Aug 24, 2026 at 12:37:09PM +0200, Lucas Poupeau wrote:
> From: Lucas <lucasp.linux@gmail.com>
> 
> rtl8139_set_mac_address() accesses dev->dev_addr by casting it to u32
> pointers. Besides potentially performing unaligned accesses, the second
> read starts at offset 4 and reads 32 bits even though only two bytes
> remain in the Ethernet address.
> 
> Use get_unaligned_le32() and get_unaligned_le16() to read the address
> with the appropriate width and endianness. This also fixes the Sparse
> type warnings caused by passing __le32 values to iowrite32().
> 
> Signed-off-by: Lucas Poupeau <lucasp.linux@gmail.com>

If you are targeting the net tree, you need a Fixes: tag.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Does this bother people?

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

    Andrew

---
pw-bot: cr
