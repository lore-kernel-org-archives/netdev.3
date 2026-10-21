Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594116;
	b=pJ00FlrSuzbzrPY9Hh3D4U66f9v1E6TCPX9SSmUAfTUMT8KLIK7P5uEm8JVPpD0LGggS
	 TX60e1wgobSf+YYVwNOgsieyEFfNCbqqIvsVaAZajBA+lD/gyaw1tX1Dj6/SqCzFUorTh
	 TGSsxQD6YZlN2yrkvqJEytPQEruS7uAYcqH9GAa+jUEjAHVLgJv9/KDTxlzoO9UW77ZFI
	 uzdqzFe3g9bWtgV1DojgXZdSeNat9B43zgD5R3Lqqj8e+dRxvrGYlJPxEol8jsTKeaBqN
	 1ObtLnWQ9ATn8/AgjVjbCWtHBrnQ55mirSfHvLHWaMqCcAL6urFDKY8BAbFYEX/38pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594116;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SmJ9OXsty5Y5g1BzjJKCDHvS5cZX+eNMR2/LJaR9rBU=;
	b=W8lcYli4fZgMef0BT4rX9et3R7xM+AINULpDsTY5i65T/pU/C3O6UQAAYxVMRgGE6rZE
	 vaJt7Rcug5zniQ39PfGuN8xMAZ2c9YlOVhJbbqF+3sX+3CNgcnuiCQPEjME2zuUAFmdNN
	 lphWnTi4NNJSa6IAfbkrKjfGPEJXT1VdvVbc3qFBE5jIg7MCrl8c4/kTJmEIkVVTrhsUb
	 xiAbapFJvLGv6ZWbBVkK59DPqYQk1rT3sSuqFZo52WcEbNFvisKh1y2dEY2Asx6wsqxnm
	 hO6Cbke4TNnmjEuLxgRbnAlsRxJW3ctMgA22EBnlz3+NMeXg/0qM5fOHfXUDuD4BfdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PArwaFH9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D9606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PArwaFH9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AF01F000C1;
	Wed, 21 Oct 2026 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792594114;
	bh=SmJ9OXsty5Y5g1BzjJKCDHvS5cZX+eNMR2/LJaR9rBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PArwaFH92OrGAgcAjUxpsP6UUzTwNv8U3PYv0qFnfwZiAxHjO9j5cbXC1PJixG89B
	 dKmGjJA1p5itUnsxCmmJEDuDa6OQPlWfqvT2SIKu9hBGtOOAb3Lf5KN30vV6GbG3Z8
	 Hc7J+Eb24T43sAQaNkyw5qzmqtA5PzNW2vx8KX4sqCdhjl3qhQkHpNcZH6oeKPbH5G
	 IL0Cvr8+DTuzUjzD9Jx5XcvxKHzolsybcbVL10xQfHU4up6+ZkDIUREzHn6xBp8RiL
	 QbZs2BLNLwYjVrbaMLbO9RQ4hQXejPUU/qwqdPYlqcJ6d1jv/7Xo8LDum0xHdRiwp9
	 M9gQWs+LBGnIQ==
Date: Wed, 21 Oct 2026 15:48:30 +0100
From: Simon Horman <horms@kernel.org>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] net/rxrpc: Simplify rxrpcpeerseq_next()
Message-ID: <20261021144830.GA708417@horms.kernel.org>
References: <20261016065011.105764-1-chelsyratnawat2001@gmail.com>
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
In-Reply-To: <20261016065011.105764-1-chelsyratnawat2001@gmail.com>

On Thu, Oct 15, 2026 at 11:50:11PM -0700, Chelsy Ratnawat wrote:
> Remove the redundant initialization and conditional handling of n,
> as it is always set to 1. Use the constant directly when updating
> *_pos and starting the hlist iteration.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>

It might be nice to use some #define rather than the magic values 0 and 1.
But as a clean-up I think there is value in this as makes the logic clearer.

Reviewed-by: Simon Horman <horms@kernel.org>
