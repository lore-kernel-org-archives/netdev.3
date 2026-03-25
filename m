Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F20405ADB
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461010; cv=none; b=HRXphOQAWH9MiV0o3+AWdpGu9vFJMGJkfmELtldE0OFO1dEgb+y8YctmJKNQdju+jcgDL3kgSZW+O03BPgnNBCU7jduqzBmyX2gJDZiJQLfoJDi3bIl9UDYzr2pexg14WFYaHAKnYvVvPs7iUa+qHyQoWq+xaIwTSjneXSI0StA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461010; c=relaxed/simple;
	bh=PdQtsgCHoART94zy6tOOGgSNd87xUTXDO3pCydJI9Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b12v18ANvvkc4iT1/xU0OitlDn7EpoY7rAbMDsnMta3kcZ7w8ANGdTRqavY5JVfPvqg4PqzFWlaqQXCNCa4XyD6bXm1Qr0Q9K+Q6YqtWHcNI2GFy8gVWmoMalJKzsaTHdW/+51iGUCTQfV6OH9Hr7CLy8tlomyLRZeJIgbqzwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFgHWcPr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFgHWcPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86881C4CEF7;
	Wed, 25 Mar 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774461010;
	bh=PdQtsgCHoART94zy6tOOGgSNd87xUTXDO3pCydJI9Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFgHWcPru4CtNV7YMbNxgHENmgvvrQ5T0fonkFyz9tzDx+AywhvkkM542n+rgWNaO
	 AFGFnI3rs0k0FR2tXgFud5BcMTS9UCcoI3XJrb1Qxe9wDLi5JonsXtPvjzSgDTpa5k
	 Skdr3qOQxli9NLY4FYjTG52kWeP4KceilLhbjdw4Vi723KyUrlu93NGpkDaGKPskmg
	 bV8csEaz1VRdFPd5s53r/0cn8NHjtVn9nOgDFXQVlJ3J9nO+fkpvZEslVautcQ04d/
	 2UphGg5wCFvvkS/e4bK+l3IGa7fU4qevTk4JEYwN/1GngBmDu2zmm0r1RtvN/dssl1
	 QwPVhEErGUY6w==
Date: Wed, 25 Mar 2026 17:50:06 +0000
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, yuanzhaoming <yuanzm2@lenovo.com>
Subject: Re: [PATCH net-next] net: mctp: avoid copy in fragmentation loop for
 near-MTU messages
Message-ID: <20260325175006.GK111839@horms.kernel.org>
References: <20260324-dev-mtu-copy-v1-1-7af6bd7027d3@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-dev-mtu-copy-v1-1-7af6bd7027d3@codeconstruct.com.au>

On Tue, Mar 24, 2026 at 03:19:56PM +0800, Jeremy Kerr wrote:
> Currently, we incorrectly send messages that are within 4 bytes (a
> struct mctp_hdr) smaller than the MTU through mctp_do_fragment_route().
> This has no effect on the actual fragmentation, as we will still send as
> one packet, but unnecessarily copies the original skb into a new
> single-fragment skb.
> 
> Instead of having the MTU comparisons in both mctp_local_output() and
> mctp_do_fragment_route(), feed all local messages through the latter,
> and add the single-packet optimisation there.
> 
> This means we can coalesce the routing path of mctp_local_output, so our
> out_release path is now solely for errors, so rename the label
> accordingly.
> 
> Include a check in the route tests for the single-packet case too.
> 
> Reported-by: yuanzhaoming <yuanzm2@lenovo.com>
> Closes: https://github.com/openbmc/linux/commit/269936db5eb3962fe290b1dc4dbf1859cd5a04dd#r175836230
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Simon Horman <horms@kernel.org>

