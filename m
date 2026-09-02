Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3004CCDEE
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308126; cv=none; b=lJixCKuoW18mzepcscYHO+nUj023dFjJALxkUKLGY94Onu6KnURfvFo1hLNkbnL1XOv5kP6CZOHU9oxLuWP2UQTdtnPuGnJsQ1WPmhVHzOki3TXQHKL3TBv1Xzv0i6ZriHu65ttfN5Fe7KjxVR/TLDc/d8sa8WCSfTJo4M10lWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308126; c=relaxed/simple;
	bh=lFh/kmKrXf8S8EYKtD5EdokINgOiQk82uIrTMpnpzqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdWLSy2ULWqkzB8LJEu+cgvYFg2YEu4o3dksXL+hUeQw33DeV6RvS3hGB1qYUdtAHDliRlznVnMWmJpW3VG7rGrJfh+2skwJN2JG0MoQ0RkrBxMXEpJo0sT8FhGXHssvp2+TqrGflju4N6kjsZDi95Z4lJTY2M7jGDF6mC/eVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emK+TKpS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emK+TKpS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55D01F000E9;
	Wed,  2 Sep 2026 00:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788308121;
	bh=DiPogeIcIDmwsklJP8Ehy2Qgdnp1+BNjc+r1VhEC5WM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=emK+TKpSIOwXiIcWmcyj432UOi1Fm/PZKNLTu15NjluETXLVjVMt6z+KgfLep9sCc
	 lzdVjidjFILQcz1TTAY40kgL7UPRx4COpO3N9kCnEspOFkGA1H+k+WprYf3/0pVpJi
	 TZGyTQJwbhYE2DEdoD/WEZIUjzfOYyC9+CwL2uCCvQZ5e+OVEd7ncvQdOcaqBxNp6b
	 kf6nz54IQ9ztpmN6la4MEfLa++jxQvZCpQ2n/vKGqtSENAIOFytuPUvz4hZC70cKGE
	 cc8d0gkxZtUfca0OOT+jTxJexu9YiMIIwhbj4GWnu630fOJgOYvIZq8zdX6FwlMHXO
	 gL8GVbg21z3vw==
Date: Tue, 1 Sep 2026 17:15:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jeremy Kerr
 <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>,
 Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next 1/2] net: Make skb_ext_put_sp() idempotent
Message-ID: <20260901171520.072acdd2@kernel.org>
In-Reply-To: <20260831-skb-ext-prep-work-v1-1-ecc2a8542fd9@cloudflare.com>
References: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
	<20260831-skb-ext-prep-work-v1-1-ecc2a8542fd9@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 08:27:38 +0200 Jakub Sitnicki wrote:
> +	if (!sp->len)
> +		return;

Somewhat mixed feelings about explicitly checking what is the loop
bound, anyway. But I guess you can argue we shouldn't write len?
Probably not worth a respin either way

>  	for (i = 0; i < sp->len; i++)
>  		xfrm_state_put(sp->xvec[i]);
> +	sp->len = 0;
