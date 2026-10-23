Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788403;
	b=ndvE9ZCsQt/LOOBuqA3n6lTH2uVTzribCi8GaI4qBCjAtVSUGhzyevekgwWR2PxJmodc
	 H8gJO6RSLXmznnoYoIDGjRJKAmySmTaz37ssgtEfKx+5CFmFBm56PYUp6xU34MFmPhOkT
	 JnCaC5Hwu1oMeHQtRVeXVLRHHDkC3oCN33FozGzWNKnzoscaniAxQkp8r/mGmnrKuUsw9
	 l3xWqx+OQQtyOkuKVNCsdVnK5YzblHair5HtdN0EDo8k9Omr6qMvotNQvXZDon2x0r1yJ
	 jFBjKjOnRhnwGziPQ/DYpD+zef6cgDF96IP9hK1aBGsXVSfYgfsiRhR9t/H0Ewxp5cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788403;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OOrBgVIZ+5GFZQ2Ei4auzJjSzt/8ZsdJTOLeQUj42io=;
	b=igCOIzVMlvBXOl49JPMveWWD4WwwOpo1u88bdlIPfv8iVMUHj7yWlX6lqqViYN8uDNTx
	 TW+eQLgP+0dLTFRcurf4g6Ah0n9jrvIhd1BbyX5IyWz4gulHadMk6l670nOKtD45wU6xQ
	 CWtSQXXFzC1SRtXuoEXcTzcJMV051Ne9lFw+HRZDWyw/vt0O6p5+zBf7LQZMPzYdDV4A0
	 L65mxjQkAHZMjlNjXMe6031wB6uu7boOo3ZWtO07dWFEsQF41A3Fy/EApukhKz5fTIKEV
	 yBgtcwABNm2Awaf6D2IhITVZYsKIx/iTTnV+NqMDUFbZT9r5tzqwmvmv5Cp3WZWO3cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRyxz1CV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4E606A31B;
	Fri, 23 Oct 2026 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRyxz1CV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099AB1F01825;
	Fri, 23 Oct 2026 20:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792788402;
	bh=OOrBgVIZ+5GFZQ2Ei4auzJjSzt/8ZsdJTOLeQUj42io=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NRyxz1CVk7OUj1Ho0JA9ipiZ8cXedzU4ixCRaaAx+fS88LbYEQVonzSnbS6kvGAK4
	 uI5gms4ARQtIeoK1VFD+SbcACPkKEryt6LEpHVdAlsm54W3pw+SK++EljoS20GF9z4
	 9NfQ5Jj5vGzbZKyeulrToTYyjjNSBmJf+NQG2j1FzbPvEGFhUqa6wtX8Dno6icPVhi
	 F2IYnctZpRrQ5ubxoyfTEucA61fXvOaRAwrT/PmmugqaIv3m/QZBw55LC+OaBsfWJt
	 GrHQz9DD9yTWZRAOOMdOYzMUYDv1JFfsv4xEDw0fi5dHcdcM6qG9pDnCO1La7bEmJ+
	 qa4NDUEjNEaxA==
Date: Fri, 23 Oct 2026 13:46:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sjur
 =?UTF-8?B?QnLDpm5kZWxhbmQ=?= <sjur.brandeland@stericsson.com>, Alexey
 Orishko <alexey.orishko@gmail.com>, =?UTF-8?B?QmrDuHJu?= Mork
 <bjorn@mork.no>, Greg Suarez <gsuarez@smithmicro.com>, Breno Leitao
 <leitao@debian.org>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: usb: cdc_mbim: don't enable BHs in
 tx_fixup under netpoll
Message-ID: <20261023134641.4c08e3b9@kernel.org>
In-Reply-To: <20261021-cdc-ncm-netpoll-v2-2-8818965bbb69@tipi-net.de>
References: <20261021-cdc-ncm-netpoll-v2-0-8818965bbb69@tipi-net.de>
	<20261021-cdc-ncm-netpoll-v2-2-8818965bbb69@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 09:56:19 +0200 Nicolai Buchwitz wrote:
> -	spin_lock_bh(&ctx->mtx);
> +	/* IRQs are off and BHs on under netpoll, see cdc_ncm_tx_fixup() */
> +	spin_lock_irqsave(&ctx->mtx, irqflags);
>  	skb_out = cdc_ncm_fill_tx_frame(dev, skb, sign);

Sashiko is concerned that we are now running cdc_ncm_fill_tx_frame()
with IRQs disabled, I think the suggestion to use plain spin_lock()
would work? The xmit lock shields us from recursion here.
Same for patch 1.
-- 
pw-bot: cr
