Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65E306744
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997829; cv=none; b=bwG3BUGJPeMy1C3c4OGR59kUVvNfBA0TMi1xHev+bSYnQQ094KTfeafFVM7UjBHXfvKs9ikGifmYfD1UCQVQIa9A8OyRjctbdo2qFS9jA9Sa3W0R27e1iYGUSNE0WFV2feVn73a80mMPhgJ2QJGzuerE9ZmFWHX0PytocnQOYbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997829; c=relaxed/simple;
	bh=hOfibfgccbpFHS8RGrgxLKixnaNm+kSKD0rSKn37nTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmtEHJ/gIQ18PpDVU54ZvCkk9XUoEvkpkZTq5U5Eh2V+zi9nSzQKE/lWemeUy19wt9rj5hUCBQDP7wt3O0qof/KxOWDKEHaIUuSsbHsgWYRyQy2OzoYKp/Y6sQCyG7YoM/cYwwALANf98wgpK5TGopEyhteaCUjFdnFRkC78Zs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePP3lsOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePP3lsOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E980E1F000E9;
	Mon, 17 Aug 2026 20:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786997828;
	bh=R1V4OLO5cfE2Jc32tzuF23JtAozOuo5x3cnRwIWCL8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ePP3lsOTvCzf0NEodJo1GRFSjCVhk6QcjXhCledD4WdnGnIvY1NJqUoT5qGMZuQlO
	 PwEjGxTonmvaieo/63FEnHiLmL38/TwZoUvT3kXuoG5EFTXTpteDVkxwiKOzef4Hx4
	 0u8OSVNElYFzIq9yRJKEkyG85J4siNzEQegg50qXqUI/vAaCakGNAUvvOeu2dyKYyu
	 dLyqKB3BKaobIHwEF4datiw8enXPsxoggZpRIAIy5ULX7OVNLgtLZsxvbQvowEBBtz
	 CMCVZXBmryYwlgCANUjlyuwWxRqfmBsP7rz8GtV/pp/xVX9+mUF1q6RluB2JG32Y3P
	 mfRaXg+HrG+UA==
Date: Mon, 17 Aug 2026 13:17:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: idosch@nvidia.com, netdev@vger.kernel.org, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, tom@herbertland.com, vega@nebusec.ai
Subject: Re: [PATCH net v2 1/1] ip6_tunnel: use skb_cow_head() in
 ip6_tnl_xmit()
Message-ID: <20260817131707.4622a7b7@kernel.org>
In-Reply-To: <30807a062ccc5c9c8a5ec2c5eb805ef279c50bdd.1786452593.git.zhilinz@nebusec.ai>
References: <cover.1786452593.git.zhilinz@nebusec.ai>
	<30807a062ccc5c9c8a5ec2c5eb805ef279c50bdd.1786452593.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 21:31:11 +0800 Zhiling Zou wrote:
> changes in v2:
> - Explain that ip6gretap and ip6erspan clear IFF_TX_SKB_SHARING and
>   already call skb_cow_head() before ip6_tnl_xmit().

sounded like Ido feels pretty strongly about this, so be it
