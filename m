Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AE3A425B;
	Fri,  4 Sep 2026 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788494237; cv=none; b=czdOag3so9IiTf2vSrlzLlPBesQe3ovrOdKcKSbhK+JX/RwkyItJIyxpMVe2k9zbvCfGhpL3+sQKVetl7lYRh2fWfDxGp2Ub/GO89dR1Li9UzsotH9vTEqkgJFjDJ4Ug7uyASuj8VHSu4K1UAGxXTISZxe/so3S2KJlCKFqkRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788494237; c=relaxed/simple;
	bh=zoWcNchu1mDL4dZvwXmtA2OBYF7gnt3GvrOFN02XtR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JKFFCSZIjowfh4ra/EOKYHckY5bArieZfmpvlLq8BfzlmlI/oZ5BHquXZqzfOAHEA3Cc6gvBH+GxGk7zytqephelHtGU0PaBywtmZo9fbryHD34OUKp87mb3M6koDfC9JLK2KO5I4VTuqNONNyTlZ5u+xEOaPzA348vvVIUikgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi882JGQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi882JGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FF51F00A3D;
	Fri,  4 Sep 2026 03:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788494235;
	bh=/NNRv+mWVY7vxTEqqjw7M6mHixxw3bgVvoFQRIB0Z5o=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Vi882JGQTJxafuONFRXAFYRLP16gRfu16JANJ3Lz+fXSGem3L55jZIY/83GiivmaU
	 tZ/t6Ia36FIWJf0wINR/DeYdP3vBRocJWZm/WSEuTiUvX59daaA6J90DEOXncBT4M2
	 A5U/dYKgb22lspaZtMOkzaPeWR9wpoGSEufNZtf76QLKOtTJgAt7STdEv90y2HSfGb
	 Ha2kH5OBs4vP4Mo1v+GG5wCPtQZCEl5ZHG/4XGF8CRJYk+6ALzs7rexUnrm/njiJzb
	 4dV/zO09NWjERCCSYPdqbViLPH7xrEVpyYDsnKFvq/rdD/TqSyOYwk3GNBsf0Ic8gt
	 7fEZZAHtxe6hQ==
Message-ID: <927e0f8f-a656-45e4-a937-9de88b783073@kernel.org>
Date: Fri, 4 Sep 2026 05:57:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ppp: pass private data to channel callbacks
To: Qingfang Deng <qingfang.deng@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mitchell Blank Jr <mitch@sfgoth.com>, Chas Williams <3chas3@gmail.com>,
 Simon Horman <horms@kernel.org>, James Chapman <jchapman@katalix.com>,
 Kees Cook <kees@kernel.org>, Breno Leitao <leitao@debian.org>,
 Felix Fietkau <nbd@nbd.name>, Asim Viladi Oglu Manizada <manizada@pm.me>,
 Eric Woudstra <ericwouds@gmail.com>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net
References: <20260904031153.30304-1-qingfang.deng@linux.dev>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260904031153.30304-1-qingfang.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 04. 09. 26, 5:11, Qingfang Deng wrote:
> PPP channel callbacks receive struct ppp_channel only to retrieve the
> driver's private pointer. Pass that pointer directly instead.

We had type checking at least. What's the purpose of this patch, actually?

> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>   drivers/net/ppp/ppp_async.c   | 13 ++++++-------
>   drivers/net/ppp/ppp_generic.c | 12 ++++++------
>   drivers/net/ppp/ppp_synctty.c | 13 ++++++-------
>   drivers/net/ppp/pppoe.c       |  8 ++++----
>   drivers/net/ppp/pptp.c        |  9 ++++-----
>   include/linux/ppp_channel.h   |  6 +++---
>   net/atm/pppoatm.c             | 21 ++++++++-------------
>   net/l2tp/l2tp_ppp.c           |  6 +++---
>   8 files changed, 40 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
> index ea7fe9608ffd..e73b0fce86b9 100644
> --- a/drivers/net/ppp/ppp_async.c
> +++ b/drivers/net/ppp/ppp_async.c
> @@ -91,13 +91,12 @@ MODULE_ALIAS_LDISC(N_PPP);
>    * Prototypes.
>    */
>   static int ppp_async_encode(struct asyncppp *ap);
> -static int ppp_async_send(struct ppp_channel *chan, struct sk_buff *skb);
> +static int ppp_async_send(void *private, struct sk_buff *skb);
thanks,
-- 
js
suse labs
