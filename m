Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCA470422
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714959; cv=none; b=R1TnOix4v5BJ6++wH6EEQFX+6DLlLZoHlDqJsoTIBAZhsjYKelc9JvSrGIwTStLFH2EdQNtktG9EWOIdav0AnfjiBhM62u0q/WR04L3XfFnF2swLkV7yBuQLuLj7ok+bRMWibtps+snzqS+Teq/m9LvzEJpSwAig+rTkM7ZqBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714959; c=relaxed/simple;
	bh=urM1Ez5AKgAVckZqy4lwPptZkRQY3xrKlWi5RgIOXls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZ2nLOfBQ/pciRZ3QdoInNsijBT+VUnqkCIXEqEciPcW/QJnqLKGi/v03bTPMW7yVxp0iXRFqBfYtkMJCowDmVJYoK8wqdirpeofkGZC8T1agy2QsEVf4dSV92MzdNP+eWY7js0dUYxbTQNtK0m4Hw0UVGMQOBQcAxfsvbZoZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5rnwbMU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5rnwbMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73061F000E9;
	Fri, 14 Aug 2026 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786714958;
	bh=G2wlQ++SrqOjnyYGzGvnChmHZ65blav55hsa9U+uC3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C5rnwbMUSf8pKazm4MARh/SExoTMDWkXsiQpfR6v5WlUVhf7Q9StHnFdphpSUY2OF
	 yNf7FG1kaAsUBVc9jWEY0xijUf2KgvAME5kZE5G3uVgk3Z/l5c6KG2GJNk0ANSwJdi
	 ilobYx9zHRjHfEtQNzzWx6HRaB9K2whVGz8sxhvmRD5rHJ3bXtYkW96+uTwFfAyIz2
	 u8VFw6lJyJquAojv2s8yIfBAx/xllGTNevA5tVgUmb+KI2zU7NP0rodwKNA/eTh+xP
	 +ur57zdG7r2nPvmhBfWqKamTFYrZTai7R5ea8Dw59vEsNpBdSnFUo0J+yerHR9ZTAq
	 Qatz7J6s+Fo3w==
Date: Fri, 14 Aug 2026 14:42:34 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v4 net-next] gre: fix ERSPAN o_flags race/corruption in
 xmit and fill_info
Message-ID: <20260814134234.GM265046@horms.kernel.org>
References: <20260812142257.21283-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812142257.21283-1-edumazet@google.com>

On Wed, Aug 12, 2026 at 02:22:57PM +0000, Eric Dumazet wrote:
> For IPv4 ERSPAN:
> In erspan_xmit(), the driver clears IP_TUNNEL_SEQ_BIT (for version 0)
> and IP_TUNNEL_KEY_BIT directly in the shared tunnel->parms.o_flags
> structure. Since transmit paths can run locklessly and concurrently,
> this leads to a data race.
> 
> Furthermore, modifying tunnel->parms.o_flags permanently alters the
> tunnel configuration. To work around this, erspan_fill_info() (which
> reports config to userspace) was setting IP_TUNNEL_KEY_BIT back. If
> erspan_fill_info (running under RTNL) and erspan_xmit (running locklessly)
> race, erspan_xmit might see IP_TUNNEL_KEY_BIT set when it shouldn't,
> leading to GRE header corruption (injecting a key field into the ERSPAN
> GRE header).
> 
> Fix this by:
> 1) Passing flags as an argument to __gre_xmit().
> 2) Using local stack flags in ipgre_xmit(), gre_tap_xmit(), and erspan_xmit()
>    to prevent TOCTOU data races with concurrent configuration updates,
>    and passing them to __gre_xmit().
> 3) Removing the racy modification of t->parms.o_flags in erspan_fill_info().
> 4) Forcing IP_TUNNEL_KEY_BIT in the reported flags for ERSPAN locally
>    in ipgre_fill_info().
> 
> For IPv6 ERSPAN:
> ip6erspan_tunnel_xmit() was locklessly clearing IP_TUNNEL_KEY_BIT in
> t->parms.o_flags even though it does not use these flags for building
> the GRE header (it uses local flags). This permanently corrupts the
> configuration and races with ip6gre_fill_info() which reads it.
> 
> Remove the redundant and racy modification.
> This should remove false sharing in a fast path.
> 
> Add const qualifiers in ipgre_fill_info(), erspan_fill_info()
> and ip6gre_fill_info() to clarify that these methods are not
> supposed to write any live parameters.
> 
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Fixes: ee496694b9ee ("ip_gre: do not report erspan version on GRE interface")
> Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v4: addressed sashiko's feedback.
> v3: https://lore.kernel.org/netdev/20260811095237.2314234-1-edumazet@google.com/
> v2: https://lore.kernel.org/netdev/20260720135132.3957146-1-edumazet@google.com/


Reviewed-by: Simon Horman <horms@kernel.org>

