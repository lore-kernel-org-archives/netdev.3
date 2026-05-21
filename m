Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9D3EC2EB;
	Thu, 21 May 2026 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779389109; cv=none; b=lKO3FTIjZpdoEIECViMaHIcIQ7u0BON6gzJY99WxMBtVcq2+pccvoXBst1A48iMcnWSHz+Qj4pr9w5pR3CzyBZQFpIVLuRa53oHtUfbW14WbzCce0CC8xwVg7AHfGX6kir1PRXFzhv6rxbJxpaXsQO3CYYRc0ZE9LxvdaD5CVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779389109; c=relaxed/simple;
	bh=xPHxHf67eksGxHjI9Mm/Cej9PQHE/Hocx+6W0rL5TIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBlDm4xH0JIqkPoDDHRxFQUBb1E8YxRmkOYP4D6BySi7ZLJmrQj2GMQZ71i/n1cM/MHzBqhEEhKJbIjse0NTdUYl6g5x8smWb1h93a3NdQTXGsFAnv3arybwWiPqIwKJT+dRRmUWXpi0UnvqkPJKXtzkWpLVhWMsv23nt4WTkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eIi62Trt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eIi62Trt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L4Jky2OwCqDUqRvRq3+TtsxjzZyj4RpGbXfiPseYZ/E=; b=eIi62TrtPwYQcUULc7kqfNFt+q
	AAcv2p0aeF2I4iBzc/MVRzSkgeQqKn+jVrIH59Pc3pj8gS1xkqKjXx9mtRp7o7FaD0lwE3NjsaVmp
	3IRfHEDX0JLHIedipEVqyivVKBcQmab/tHfM9M/vNOMOM4LEpN8Pmm4STOsn4kLJbqBQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wQ8O5-0044cj-QY; Thu, 21 May 2026 20:44:53 +0200
Date: Thu, 21 May 2026 20:44:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: dev.taqnialabs@gmail.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: mmc: Remove duplicate mmc_rx crc
Message-ID: <2d702678-5b2b-451e-b692-228efcbbefc4@lunn.ch>
References: <20260521-xgmac-mmc_rx_crc-cleanup-v2-1-7d9de09f5898@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-xgmac-mmc_rx_crc-cleanup-v2-1-7d9de09f5898@gmail.com>

On Thu, May 21, 2026 at 04:32:46PM +0000, Abid Ali via B4 Relay wrote:
> From: Abid Ali <dev.taqnialabs@gmail.com>
> 
> MMC_XGMAC_RX_CRC_ERR is clear-on-read, and just a single read would
> update the mmc_rx_crc_error counter.
> 
> [1] commit b6cdf09 ("net: stmmac: xgmac: Implement MMC counters").
> The duplicate read appears to have been unintentionally introduced in
> the intial MMC counter implementation. The databook does not mention
> MMC_XGMAC_RX_CRC_ERR needing the additional read.

Thanks for the updated commit message.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
