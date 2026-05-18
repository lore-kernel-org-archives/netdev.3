Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4B40584D;
	Mon, 18 May 2026 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107457; cv=none; b=ZfYzumbY/9MH0HctuD5/2R4jJEPuuJEg+A1a6MmC7aGzKvasdu7+HwGpwt1TUhR+lr9PHJCGhB+K7LLppIV/zN/815pWlQQOyxahgm1XHTzncAChx9dS7eyQ9wKuVXP+jkKsfGw/ANtwcI5y9H0dpeiD+KnX86CsP5PacyMjF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107457; c=relaxed/simple;
	bh=b7oPXc29+tBaITwHwDLxg6vvyuyYX/k+KxIRH92k+aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7Z86W6EGD7Djyzra/lCYpUWqK6XKBXCPwFv5udtpR63bXDV8WkS+OjXsCLC417HT+DiBwoWVzepE7IW6Y/R8kxpzOu03Pj7cf/PKm00dOlnEasvt2M+cqOkYTfPZmu6qmEFEvS9sdSV4pErGpA/wFTzuOrLtnKdOvUKje6FCN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifUa1FAE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifUa1FAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565F1C2BCB8;
	Mon, 18 May 2026 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779107457;
	bh=b7oPXc29+tBaITwHwDLxg6vvyuyYX/k+KxIRH92k+aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifUa1FAEtV5kq7X1+0Vl41+BYg/LS7soynVaSq/zQA3wPJ4WATAW4w1LQjBAPXf8/
	 hKvg1X6AaXohzblZzISiYIiU1e8KNNn7AuJs/q5p2qSwrUNtlXPL3qm8umt/Rl/tnQ
	 gP0Qynsg2PnBIWBkN8r8eY26gYqRPBBMU1C192LNrsZTEvtBkoGaXn5YJVZuknbeN5
	 1GIs49FZBlzsBYmYGlQZqepcRbB3nlDBHWbXwDX2AsUfsC2Af+CJU8fTPnbmZYcr9h
	 tcFVKbn0YB6SarhyKjZg+5hd/ddhzjfU9w+9779wMkmvFCRiYK8AQyHEzH873RJNAa
	 dus+imnhAu5gA==
Date: Mon, 18 May 2026 15:30:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: =?iso-8859-1?Q?G=FCnther?= Muller <gunther.muller2008@gmail.com>
Cc: steffen.klassert@secunet.com, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xfrm: fix missing headroom check in
 xfrm_dev_direct_output
Message-ID: <20260518123054.GS33515@unreal>
References: <20260517111940.8987-1-gunther.muller2008@gmail.com>
 <20260518080410.11119-1-gunther.muller2008@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518080410.11119-1-gunther.muller2008@gmail.com>

On Mon, May 18, 2026 at 10:04:09AM +0200, Günther Muller wrote:
> Ensure the skb has enough headroom for the hardware offload device's
> hard_header_len. If the headroom is insufficient (e.g., when routing
> through certain virtual or tunnel devices), __skb_push() underflows
> skb->data below skb->head, causing silent memory corruption.

Could you please provide the steps required to reproduce the issue?

> 
> Fix this by using skb_cow_head() to dynamically expand headroom if
> needed, and switch to the checked skb_push() variant.
> 
> Fixes: 5eddd76ec2fd ("xfrm: fix tunnel mode TX datapath in packet offload mode")
> 

Extra blank line.

> Signed-off-by: Günther Muller <gunther.muller2008@gmail.com>
> ---
>  net/xfrm/xfrm_output.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index cc35c2fcbb..35f974d209 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -649,7 +649,10 @@ static int xfrm_dev_direct_output(struct sock *sk, struct xfrm_state *x,
>  	 * to netdevice.
>  	 */
>  	skb->dev = x->xso.dev;
> -	__skb_push(skb, skb->dev->hard_header_len);
> +	err = skb_cow_head(skb, skb->dev->hard_header_len);
> +	if (err)
> +		return err;
> +	skb_push(skb, skb->dev->hard_header_len);
>  	return dev_queue_xmit(skb);
>  }
>  
> -- 
> 2.39.5
> 
> 
