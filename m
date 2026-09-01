Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0338D6AD
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240417; cv=none; b=AGhxwyAFFuWZwAx0jNJkFJ6Jz7Z07FeNkroXxOgMsEG+88h/SFSmx5dbfJnTKSq5C4c50T+dq7g0UCJma6GuY7lWaN4nCFzMB+CnVQ1hbXh6Kbt2M3tfBzH0x/UwDI1iak++3LQ/RZLJmpbFFHsYOJQY10mJ+XLIHBz3opxBhlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240417; c=relaxed/simple;
	bh=zBDuPlWK43z/mwwJ2RRlSidLeEP8btkBxl9QlHzYQEY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ii7En6FsOT07tYYtjPTG6qstVkBU7BQ7J288qx4GEQvrSfqLI2j85Q8vPnF6sKxTYZ63pCLI1wnKDEknz11znwj9HivUTvfsUxzXEBVUabjzcJV+5vfrOYVB//AfC0/x27Q4GD6b8RQWNXpaYJaoI+3PhAGU2mHKarXwDm/dh6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Mk/nQcao; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Mk/nQcao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788240405;
	bh=zBDuPlWK43z/mwwJ2RRlSidLeEP8btkBxl9QlHzYQEY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Mk/nQcaog7TpWyIGT2spwZtR0GOzEsDIzDyw73jAij8D3WsI2FJctf6uvHMsSqZ8K
	 RLo6Gwb16zf51OkkAPHUoX5Uc3Gpb0dAvmGeNv1fu0v/F6gRASpYR6CHeHuKnNC3TR
	 F1EAIXowfwUdTJRdzydbKyANkebriuNvXU9oYXYERo0OY4bwZlEUvNc7Z5BvY8oO/b
	 Jvs7f3khp8dTCpHtocURnj1xHRgNR3Erdm0Oet82y0HdnBduNqDh37/a5T5kY5jFbM
	 fSxdu7fQ+HsRzuwuLZY8hpCgf/XsfvWc1ksmiLatXgpkEpul4qnhVDPK/SJAIH/uWD
	 ogOK5sw9o0ggg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D533667854;
	Tue,  1 Sep 2026 13:26:42 +0800 (AWST)
Message-ID: <3393e21a6d0f17ebf3408ab63d5285408075974b.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 2/2] net: Make skb_ext_put_mctp() idempotent
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, Florian
 Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski	 <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, Matt Johnston	 <matt@codeconstruct.com.au>, Steffen
 Klassert <steffen.klassert@secunet.com>,  Herbert Xu
 <herbert@gondor.apana.org.au>, kernel-team@cloudflare.com
Date: Tue, 01 Sep 2026 13:26:42 +0800
In-Reply-To: <20260831-skb-ext-prep-work-v1-2-ecc2a8542fd9@cloudflare.com>
References: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
	 <20260831-skb-ext-prep-work-v1-2-ecc2a8542fd9@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

> The MCTP flow extension can be released either when it is deleted from an
> skb or when the last skb holding the extension block is freed. Handle the
> release in __skb_ext_del(), which is currently missing, and make
> skb_ext_put_mctp() safe to call from both paths.

Looks good. We don't use the _del() path currently, but it also makes
sense to have the two forms consistent.

> This will let __skb_ext_put() release the MCTP key without checking wheth=
er
> the extension is present first, which is needed if we want to reuse skb_e=
xt
> chunks area after skb scrubbing.

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Thanks!


Jeremy
