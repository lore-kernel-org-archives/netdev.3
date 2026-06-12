Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF5374187
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283887; cv=none; b=TWUlGiLXp/PnTPwHpaeTb4JdxI8umtFZ2vHB2FfCd2XVaICeN2lOy/nQlpm3++MAwMTNNxzFr3M3aQf7lPBJ854a+1yKM2FTAVb/MrlmrcCiLc6eZduOpv7OLfJs/9WAxVRIEG/uLQK92J8LSJ3R4xPdAY7RQaVlyqzm7zDOLgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283887; c=relaxed/simple;
	bh=0CApkXmZ8cFRmogIeruT+sllr1qfJkrGK+GQGWkAc3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWhipKeNPgzSjqI53dkxIvfiSWFhdsLUIMUjqH6w43bOO+4oR446sKfzMtTQCU5UMZar6BOzFAcpjrUjRla+JovNpSDoytMMjcyQ+F99BYOUwq1ZHQdrA3Gns0ar/a9eMm69wFqVfTTr7ieuPF3/uxxg/JroMtkcngr0S823xvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=CUyvfB24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CUyvfB24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295B31F000E9;
	Fri, 12 Jun 2026 17:04:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=CUyvfB24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1781283883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e9CJoAueQwHMFCx0W99qLzYpcrg/Sh9Sf4ytwv9E+Ps=;
	b=CUyvfB24erVTFw+KPmvFXPqEZYvhtW8R8S1LTF/fNvRHB19cq0QQSyydwI6p4cD6JHFdLp
	Urj2LkOaPuWeoW+IY84r1y7oRrhzefndCWlTA5G3nLgFwn4I4+sOFLjvQR8tL9f1kW90eH
	gBLJlngnmL0h1td+FUW0B1BTcxO9vM0=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 68bba821 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 17:04:42 +0000 (UTC)
Date: Fri, 12 Jun 2026 19:04:36 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, Alice Mikityanska <alice@isovalent.com>
Subject: Re: [PATCH net-next v7 03/11] net: Use helpers to get/set UDP len
 tree-wide
Message-ID: <aiw8JPsgG1K4D3z_@zx2c4.com>
References: <20260611192955.604661-1-alice.kernel@fastmail.im>
 <20260611192955.604661-4-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611192955.604661-4-alice.kernel@fastmail.im>

On Thu, Jun 11, 2026 at 09:29:47PM +0200, Alice Mikityanska wrote:
> diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
> index eb8851113654..275fe1bc994c 100644
> --- a/drivers/net/wireguard/receive.c
> +++ b/drivers/net/wireguard/receive.c
> @@ -62,7 +62,7 @@ static int prepare_skb_header(struct sk_buff *skb, struct wg_device *wg)
>  		 * to have UDP fields.
>  		 */
>  		return -EINVAL;
> -	data_len = ntohs(udp->len);
> +	data_len = udp_get_len_short(udp); /* GRO not expected here. */

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

However, I don't think that comment is necessary and you can remove it if you
wind up needing to roll a v+1. But also, I was thinking:

> +static inline unsigned int udp_get_len_short(const struct udphdr *uh)
> +{
> +	return ntohs(uh->len);
> +}
> +
 
Do you think it'd be better to call this udp_get_len_nogro(), which would then
make its usage rules more explicitly without needing to litter comments?
