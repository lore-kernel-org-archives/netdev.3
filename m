Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673900;
	b=DwJbkf4grAqPFB7o4quGpe9vECjsiTxe8wVz/tSw7iVxzx8PMGhaHo2qevEJdtJ2POtF
	 AmgxMGjshUNlmpkG9HASeu7EYd2jUl4y7bWezVnbtPUfnNTFUhZpMF3k6BaXvGVI3q+XZ
	 gLiuXQfjX6vB+OPk+EDb5+HiIgJVLHYqVODZ/yiDlAfY0rIXztjH9KQkX3WXwMAJPRAj+
	 7PANL4xpnYHxMt7g9fOYcrL0eLa+ob9JaM7zaiw5xJS/l7d0Yif7QmDxyaLgAbqYyCQuA
	 JlZEFWeJVXE//17UGSRtd/HKq3/csuzyga2yDLIp2iX5dUX7vGNfsu4XQEk7LVf7X1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673900;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+y1K/aWGH6oaTGR8AaGUm8uDDh2ORJLAY2tcU/RT7Ss=;
	b=fgafRka5enJnBdn75UNcaUynFK3cyl8rUbok/q7dVLb/BQsZngkynYrNzYSBIPZbvker
	 b79cOIMeOftfnabNccSah/vLdocCdRLuvVqH+fTXaK7/dO8E/2j20LGFi8g4EBWHNvtn+
	 eSgoTiFgdOO69y5oZ5CbpkPGqbJMXpfTJ3sMC2zzigSkN1A/NfwxyBEf0Ug7cnToqcFEE
	 4hXeoUO6NJOdp0oGo4+4JIxaDAMbIWpR3VebNTeZlIbvhmdHpKWeJ7rsjlJ4aLRlkRmH7
	 wK1owHDpI6yNeYzqNSxLnbFKNLj+0n+i1QsY182+cJyaq0z6zdzlcu6phL+Y1V2uqNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOQZ1Dse;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E9606A320;
	Thu, 22 Oct 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOQZ1Dse
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A1B1F000C2;
	Thu, 22 Oct 2026 12:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673899;
	bh=+y1K/aWGH6oaTGR8AaGUm8uDDh2ORJLAY2tcU/RT7Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SOQZ1DseXpQrKmekZL3IEfrzzRNZ81u3L1vRcm9BznD/+56innnLAQ1Yca0yDYtKb
	 VXgHJ3cO5dOt/3Etib/aeAWd9fD97Ni7LMIhKOhp5ML57Ejt66VrAeaP3mU4b+wGq7
	 vqUEqSInv3EyNpsDt7nlqgg5sR9bDpRb7PZJYgb8yPzXUEIP0Px7o24L7R/0RkV5jz
	 UK5ty0rMjGih5MBQgdonyf+oIdMzlinnbKmsYktCYXLtiHWtx+oU3JJbVCq0BP8wNE
	 +gF8zMpufhLrPqVbL5kw4Jmuse34QzsCQs0TG4nfpb+Noabp8ReVGgzK/eDy0qF2SU
	 tWCciq6C2NVOQ==
Date: Thu, 22 Oct 2026 13:58:14 +0100
From: Simon Horman <horms@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>,
	Alexey Orishko <alexey.orishko@gmail.com>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Greg Suarez <gsuarez@smithmicro.com>,
	Breno Leitao <leitao@debian.org>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mikkel Eskildsen <mke@visotia.com>
Subject: Re: [PATCH net v2 1/2] net: usb: cdc_ncm: don't enable BHs in
 tx_fixup under netpoll
Message-ID: <20261022125814.GE708417@horms.kernel.org>
References: <20261021-cdc-ncm-netpoll-v2-0-8818965bbb69@tipi-net.de>
 <20261021-cdc-ncm-netpoll-v2-1-8818965bbb69@tipi-net.de>
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
In-Reply-To: <20261021-cdc-ncm-netpoll-v2-1-8818965bbb69@tipi-net.de>

On Wed, Oct 21, 2026 at 09:56:18AM +0200, Nicolai Buchwitz wrote:
> netpoll holds the txq lock and calls ndo_start_xmit() with IRQs off but
> BHs on. The spin_unlock_bh() in cdc_ncm_tx_fixup() then runs pending
> softirqs. If one of them transmits, it spins on the txq lock that
> netpoll holds. With netconsole on a cdc_ncm device this ends in a soft
> or hard lockup.
> 
> Use spin_lock_irqsave(), which is safe both under netpoll and on the
> normal xmit path.
> 
> Fixes: c84ff1d6dff3 ("cdc_ncm: reduce driver latency in the data path")
> Reported-by: Mikkel Eskildsen <mke@visotia.com>
> Closes: https://lore.kernel.org/netdev/PRAP189MB185019A5A8D411482BB6E0CDA9982@PRAP189MB1850.EURP189.PROD.OUTLOOK.COM/
> Tested-by: Mikkel Eskildsen <mke@visotia.com>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Simon Horman <horms@kernel.org>

