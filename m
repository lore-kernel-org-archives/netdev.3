Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538CC204C3B
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781451140; cv=none; b=Lk/oviJcHhq2dFfBrUF4gAPCtBs59SWdshbGepF4EaBkLxqGynkRw70sEr9vxlrqmNwUr/7cJeUF/UNUkW4wgTPod4xp2Q4oaWADUiL6aih5i7o1LPc+IcZe0NzqZ1cHeazatUDvIQL1CS858IQ+P+8MRkcoWwWYFy7s9DZkoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781451140; c=relaxed/simple;
	bh=vtG6I1YRkDLmoTi9RIExw8JVs/PFrmG5JoHLnv0oDNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t887JUMjHGyJeMj7RJ1gLjG5NxhTa1eSVyhJ6ISeiXdwbxQ1S0E4uaCV6vbvBkCmQAYokw17pMWRqshVNmjUXdQsnyY+2hSniQvSK4/tZrZkiXfVPfR9P6fBOV9XYv7lgLPenkn8uGWvTnxLcHp5awYe2YPFvuy6UPuBkcVkmuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=usrtVg5H; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="usrtVg5H"
Date: Sun, 14 Jun 2026 17:32:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781451137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=it8LMlVWF10Lwo6oFL3Mcq2DPsP7nH+z8zyDQbz1dIc=;
	b=usrtVg5HC9eNBVVGTLTYRbwuNMph3MKh8bS8buqXecP5vUTHBMmu/wMsevZ0IAXdf/RUbU
	3lsj+HioYVGV2DDimCAf6br4KG37ypnSZWrKck9f1rSWei0UmQ2/zmLYecszF2iTfMsVvI
	xdbaYaFH240yuhPIobIftIMaM5JCzqs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RESEND 1/6] sock: add sock_kzalloc helper
Message-ID: <ai7JfHTFgFt6YN_K@linux.dev>
References: <20260527082509.1133816-8-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527082509.1133816-8-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, May 27, 2026 at 10:25:11AM +0200, Thorsten Blum wrote:
> Add sock_kzalloc() helper - the sock equivalent to kzalloc().
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Patch 1/6 needs an Acked-by: from netdev maintainers for the series to
> go through Herbert's crypto tree:
> https://lore.kernel.org/lkml/ahVkZOxZtFes6Huf@gondor.apana.org.au/
> ---
>  include/net/sock.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 76bfd3e56d63..b521bd34ac9f 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1913,6 +1913,11 @@ void sock_kfree_s(struct sock *sk, void *mem, int size);
>  void sock_kzfree_s(struct sock *sk, void *mem, int size);
>  void sk_send_sigurg(struct sock *sk);
>  
> +static inline void *sock_kzalloc(struct sock *sk, int size, gfp_t priority)
> +{
> +	return sock_kmalloc(sk, size, priority | __GFP_ZERO);
> +}
> +
>  static inline void sock_replace_proto(struct sock *sk, struct proto *proto)
>  {
>  	if (sk->sk_socket)

Gentle ping? Patch 1/6 still needs an ack from netdev maintainers.

Thanks,
Thorsten
