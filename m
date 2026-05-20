Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500583F54C7;
	Wed, 20 May 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290653; cv=none; b=adiHTF5qN6w6OI2ARwpQnIP95ewKhcpmQarGplxPyT3F0/VH6r8Zltnm4dgSHH0+22uD6s44HNbaVEbbufn7poMSOeAyqIaZ0v8lLnSq6hJKSVWOplodYpain8GJAT8pErBdBSBEm//ZUEPX4qUUwUEuoelHAKqHIpDQ8etISWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290653; c=relaxed/simple;
	bh=+4TUUHSVoLge4jScH/ArRe91PO3BRFBmxSGsw7iHkyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5ibn5rooyhG+c+el74Xq50qvZfm34yPiMMIkvpqW7hfjoWuH4jRI377UAHVslinhQKQci2deeJhScxlThvR8PazW0J2FSupvHWc8kYLFkE1a6RrOG3vvL5Gsqw+aFXOO+WXhuC//TUkTTZVbRRTY9pE3pIFOwOmKkZRmuPw8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zy4qsVk2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zy4qsVk2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kNMIfVK1t4JwfaOevWXD8LztlJ1NDF/MO/IaQ8lcPZc=; b=Zy4qsVk2VIEMXyiH3/0AgPbuHI
	imrSS+xEi3g3I8muamtJQPNS4ZyzploNR06neqgcgrMmWdqIYg2XD3fTQzJVwxjjqkH9WpftUKUBf
	7nIsN1zJrRIkh0soZxllX1rlIq1bwo8hbvr1LEeswq5t6/p93YFrEKT6IW0naIzUkRGg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPim7-003r0s-Jl; Wed, 20 May 2026 17:23:59 +0200
Date: Wed, 20 May 2026 17:23:59 +0200
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
Subject: Re: [PATCH] net: stmmac: mmc: Remove duplicate mmc_rx crc
Message-ID: <bd8efd40-e203-4cdc-af25-12b1e2727922@lunn.ch>
References: <20260520-xgmac-mmc_rx_crc-cleanup-v1-1-7133f529859f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-xgmac-mmc_rx_crc-cleanup-v1-1-7133f529859f@gmail.com>

On Wed, May 20, 2026 at 02:25:12PM +0000, Abid Ali via B4 Relay wrote:
> From: Abid Ali <dev.taqnialabs@gmail.com>
> 
> Double read of mmc_rx_crc_error in XGMAC is removed.

The commit message should explain "Why?". I can read the code add see
what the patch does.

Why remove the double read? Why is this safe to do? This is hardware,
maybe it has latches values? Or clear on read? Maybe two reads are
required? So the Why? Is very important, more important than the code
change itself.

    Andrew

---
pw-bot: cr
