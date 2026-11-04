Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827225;
	b=4kSR5TjvVWOlJhQ+AT7E3ORlT+Qy5sv9f8L+289XTCipkogVm0Wz1l2L/Y2xnwDIQ3oU
	 f7zSU2DFAGEVpBcoAUxiVRctjAM1BU5x/eItXC4Gf9gElVSg/ZSYpBNtCAesINNJggpFv
	 A5YYqKf4EK2N3YEE66IFjiVHV8RYGjTnbhq1oJBbu2QIBkxyu05W6dJZb4CbzTUIdEJLL
	 wMqdGMWIKF5mWJI293w4cEnPq64dyocxb4AaZO5dWWozoHsPVmMBN0myvvJe+WuqEidjc
	 7W6M43KnGXWqP9cOVspk/Kc31qd28sdoUr3K2W1ymk/t7obXVkP3rgVYBqGJzQihQ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827225;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=FrGxsTdCdc6qgTFxU8Grw7WOtNLPMD9rEo6YljyHB+s=;
	b=EKouK8T4PbJemTp454NIBsGapdfQ1NGQL6iBYpDzsm9cFItJaqPR+TmSra0hMWqy4v5V
	 hcLyAG+ljMwEU9N9g1KKsoxnjoYy3fvRmQv12fL4wx48X1x5gesiHavjONcDn+gbfEKdX
	 TJJ85b7CN+Azi5icCVPWDz6Bex7m0vHK2ew41AAbX3viYAdAQHC7VP6oxGOWe3ySdlsFt
	 k9VC0IzQt4wbLtg9s7zhRtmuhddbyK2VqRvOI/sCbC89VWCX53D1mv9enfEOlxL1YG+SQ
	 C+AD0qddpEDvdnK9WHwukSB+s312xZd6gYPIR0LIYZlaCC7YeVU9bnaClafLe7TNo6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=HeP9FOMs;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250E606B3B7;
	Wed,  4 Nov 2026 21:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1250E606B3B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=HeP9FOMs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FrGxsTdCdc6qgTFxU8Grw7WOtNLPMD9rEo6YljyHB+s=; b=HeP9FOMsIlnnGHHsw7JD43qbbu
	J0BnErIZWlaquTZA0D5oTIOvfjqcim6xuRF645y43YhyparG1rWp9bZP4pb3jx7LojQonCBgs0lEy
	uBFAvDZxgrUQeMKAdZmbb39QhjxtV5Ks9uSnNO/ksYJ7UfeJjpsVA/JJ4HskyP8utCeM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOiP4-00EOFu-4K; Wed, 04 Nov 2026 22:20:18 +0100
Date: Wed, 4 Nov 2026 22:20:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: BeaCox <0xbeac@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] net: ethernet: disable async work before teardown
Message-ID: <d1c79ee3-a0e6-4835-8c0f-88744fe29715@lunn.ch>
References: <20261104063245.23402-1-0xbeac@gmail.com>
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
In-Reply-To: <20261104063245.23402-1-0xbeac@gmail.com>

On Wed, Nov 04, 2026 at 02:32:42PM +0800, BeaCox wrote:
> Three Ethernet drivers free the netdev while an asynchronously queued
> work item can still dereference it.  The queue sites and the handlers
> differ, but the lifetime rule is the same: stop the producer, drain the
> work, then free the object.

No need for a wall of text nobody is going to read. The commit message
should be terse. Please tell your LLM that.

Do any of these problems bother anybody?

If not, please target net-next.


    Andrew

---
pw-bot: cr
