Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1A47CC8F;
	Thu, 17 Sep 2026 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636125; cv=none; b=s8F+KkBF5sXtcg3STZtQ6hi6aXLWO6qp1q5xdR/OEUtTdM9v5CDOYC7jFGaoylAmthFzMMN/dlH4q7KpL+0nAttHPQ3fFnv7T32BP3clSD4xho4AV0eLiUL8y5XV1QimUyKX30Fd2zDhVy/2lEPkgZz/ZKwpSicUiosu5vdO2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636125; c=relaxed/simple;
	bh=2ScCc0OepfhSsYTnQ76bG/Bvm4xN79bqyIZX5um0K78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0sk3fdc2hE0vgBZoLrwPnjpd2CQ0DzLOOEFibu56LqJOzud2vZXWS1W+I8BD715St0S4gEzSQuo5VxSY1LIvwNgYFUyzonk+Eum8D7BliQhefeO2MxLRkhwY8alxhB0DfFMW4BHDRU8+YRSgxTeYbGH2y0i8asb1B3sWGH+2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0Fk0mm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0Fk0mm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D281F000FF;
	Thu, 17 Sep 2026 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789636122;
	bh=vY3m/vwF9FHK+yR+LIlV5WHJI9mpj+7r7W70mHMu4JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J0Fk0mm4Wh0Gc+87ftA9DSSDmBI8+GF8g118M1Cj5sy+cTXMqylQJgvFXs0XUikfe
	 t8kNYNhEXCVOgCfrKsKnLJE2hRubp5nWoM5sOR/ojHaTEDcveuEJl5qBBl9H3u8AMh
	 57GmgD03owi8oaHahZy0mD44opFH4WMKckl86N7hgOoiuMrhwIA+XC79rar4AqzLKC
	 Cal4S2GHmlYsHM0YrkCPlPm7cqeqwBmMzm4al5kZDl69VJy6roKBaxj6SmD4I8BU5r
	 ZEJUePucaDyBWdTrVEZzz19onkUe4M9woGgGfgiILkSKvxZBuaP0fxAyNdgFIejm/h
	 vz2IpIgVY1fmQ==
Date: Thu, 17 Sep 2026 10:08:38 +0100
From: Simon Horman <horms@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: usb: catc: bound the RX packet length in
 catc_rx_done()
Message-ID: <20260917090838.GY51261@horms.kernel.org>
References: <AS8P251MB00015FD7716F38C345619B56C8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB00015FD7716F38C345619B56C8BB2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Tue, Sep 15, 2026 at 12:06:58AM +0100, Aamir Ahmed wrote:
> catc_rx_done() walks a multi-packet URB, reading a two-byte length from
> each packet header. Its bound, pkt_len > urb->actual_length, ignores the
> header offset and compares against the whole transfer rather than the
> bytes left from pkt_start, so a crafted packet header makes
> skb_copy_to_linear_data() read past the buffer.
> 
> A length below ETH_HLEN is also accepted, including zero, and
> eth_type_trans() then reads a MAC header from the uninitialised tailroom
> of a shorter skb. The is_f5u011 branch takes its length straight from
> the transfer, so a zero-length URB reaches the same path.
> 
> Track the bytes remaining from the current packet, and reject a header
> that does not fit, a length past what is left, and a length below an
> Ethernet header.
> 
> A transfer shorter than an Ethernet header, including a zero-length one,
> previously became a runt skb passed to netif_rx() and counted as
> received; it is now counted in rx_length_errors and ends the walk.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> ---
> v2:
>   - reject pkt_len below ETH_HLEN, covering the is_f5u011 branch too (Sashiko)
>   - hoist the remaining-bytes calculation so one check bounds both ends
>   - drop Cc: stable; no conforming device reaches this
>   - add Assisted-by: LLM
> v1: https://lore.kernel.org/netdev/AS8P251MB00013A0DCA600A79DC58B0FEC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/
> 
> Sashiko also suggested a sanity maximum on pkt_len. I left it out: PKT_SZ
> would reject the 1537-1600 byte transfers the is_f5u011 path allows, since
> RX_PKT_SZ is 1600, and dev->mtu excludes the MAC header that pkt_len
> includes.
> 
> Built with W=1 (catc.o) on x86_64; no warnings. I have no CATC hardware,
> so this is not runtime-tested.

Reviewed-by: Simon Horman <horms@kernel.org>

