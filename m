Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446703B7B98;
	Mon, 10 Aug 2026 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356300; cv=none; b=BC1dKh279pNF6pz2PsRwVgFX5NnEF2GWQgx0pD5NpHmbKhyEEiBvdjSLP61Lr+TpEpl3ZDfAPjtK5EZFlyw+MlBH72pEm7rX2/j7zMpYjDe2h4wE1DS5mkoXV5gSrqrB/S/2ZR7U0uA0hJ5GsKEgNZHRSZ9Sru1Ely/08OHJKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356300; c=relaxed/simple;
	bh=nLJy5RFq+qNvEvHyKa5SYt+oatIeTAdpHGUJ8jjna+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7dcDECXbtJ9bAMjztmyEarPj8mUSdrJgGKQ5Ytijx/NQSmcfssS990F4rBAbuZV9baL4L6iYYFnLYr7dPoRn3mGpduhcTenYpBlr48gvWVdVjjkBgzpGG0ay3nLuAfZyZk0oiEe4QTUQmRRmF9GyHR4/bp6NUoztwekOy5KPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpON7hn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpON7hn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4691F000E9;
	Mon, 10 Aug 2026 10:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786356299;
	bh=hpF/uSTu4FzRghZ4UE2TKDSh72Kia8nAI1cquBVmHsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NpON7hn9BMjj9hcn7JFP+AoFn/y4j6dhAXvEZEt9x+DvB6MGJYbXcY1EzIIDuOjtP
	 wgVEklKvB73k8LL5rmHEXOfuBRguP8NsThZXUP8BbWQhAEv88vpzDZ36E1DOtPkeMJ
	 Hlew1P7+70bMth17ZYexhJGBOl4b0+iI6yoQplXNEHJQeVujU0wuscvrhdiO/cuLJY
	 sWlBQgAx360etiGvx/oQzo8MfIdka36z8qlbKncEU4B9s8faPIbN67K3Fzemz6yd+p
	 v14RS02wfY0+7fT3QwAdzzO0irLpEIO+nuIz7nFG+yQz1JjJzehu9AOKRHxAKvjgqr
	 xD/ET+D88y/BA==
Date: Mon, 10 Aug 2026 11:04:55 +0100
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tim Bird <tim.bird@sony.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] keys, dns: Drop unused NUL terminator from
 upayload->data
Message-ID: <20260810100455.GQ51943@horms.kernel.org>
References: <20260806200454.245444-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806200454.245444-3-thorsten.blum@linux.dev>

On Thu, Aug 06, 2026 at 10:04:54PM +0200, Thorsten Blum wrote:
> upayload->data includes an extra NUL terminator even though it is never
> used as a C string. In-tree users access only the first
> upayload->datalen bytes.
> 
> Remove the redundant NUL terminator and allocate one byte less for
> upayload->data in dns_resolver_preparse().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v4:
> - Drop patch 2/2 from the series and submit 1/2 as a standalone patch
> - Reword subject and patch description
> - v3: https://lore.kernel.org/r/20260427114422.313356-3-thorsten.blum@linux.dev/

Separating this patch out makes sense to me.
And the updated patch description looks good.

Thanks.

Reviewed-by: Simon Horman <horms@kernel.org>


