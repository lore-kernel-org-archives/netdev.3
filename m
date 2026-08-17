Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C53ACA77;
	Mon, 17 Aug 2026 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979509; cv=none; b=aFKiliJuTC+vMlyCZwzH1ZHPULuhK7ciOo1I62d6SnESOyVaI8nq49vm19BB/km8TK/V4DK9c4xyTqQPMF0DUroinR77T2EflouZ55OkzlKP/f1MQOX/1WmgSUqkTg/m0clgsmkqS4hQKC6awiWdzom4Xa20OcqlUro9fXI4VCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979509; c=relaxed/simple;
	bh=pUXXKAp7ueUZR2/wkIIZ8EplRAE5xNaKvwCEeKJXJ2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnxoZVTI7KqKlJxMm+32G5o7OTR/32HD97OcXbav3DdBlEZoEsWnqDvHB5PQpSpScKTEzZFuJx+qzWdqVs19IBzVUeE9GSwkCBz4LoVt5w8cdJmA9Pk6fh4KWSzhTPmQcTeNEmIDKg7kEQAmeS5aahXTfhdAq/OnXoyYSRv9y1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W07hdha9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W07hdha9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vT9LtbdSjo1IhkViMMSJNbvyCQ9RTnfCWdTe2e0sGlU=; b=W07hdha9p6N5uJf36fL3/RjDAA
	fn1EAF4s5gZCUg17UNMbprakzUhU4HZXmUGsKxXH3VXCOWHWF2GesnKU4kqh620ERCxc38BDfHMGW
	ZwUuBC3zw3s0opyWXXHLnqN7zO4Kirl9WIzwLTEVqDvrbpr4Cp1t5Nf2f99Cr9AVZ7tE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wvyzz-000KWz-Iy; Mon, 17 Aug 2026 17:11:39 +0200
Date: Mon, 17 Aug 2026 17:11:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] 8139cp: fix Rx and Tx not being disabled in
 cp_suspend
Message-ID: <ccb60b40-513f-4284-b02f-15eba32ee384@lunn.ch>
References: <20260817043057.20099-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817043057.20099-1-kmehltretter@gmail.com>

On Mon, Aug 17, 2026 at 06:30:57AM +0200, Karl Mehltretter wrote:
> On QEMU rtl8139 model, frames that arrive while the interface is
> suspended still end up in the stack after resume. With pm_test=devices,
> which keeps devices suspended for 5s, 200 frames sent to interface
> during that time and 50 frames after resume, eth0 reports 113
> received frames.
> 
> cp_suspend() is supposed to stop receiver and the transmitter, but
> the mask is wrong: (~RxOn | ~TxOn) is ~0, nothing is cleared and Cmd
> still reads 0x0d when cp_suspend() returns.
> 
> Use ~(RxOn | TxOn) so both bits are actually cleared.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
