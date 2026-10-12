Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A68537997E
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830743; cv=none; b=DaN29A1KDVyckgbVzyLohCzCl8npD7Q4pC2RPysJ3j7AP6PnvOUhQbbVwD1n8HlX2nGI/SD286dMD2dwRpAnV72qHhTAW+2r9m4dNf2cmTcGd0e7YSWMWXwBJyvnnFQKTVuLAdXTDfC69eQ6g4A6q80EQtZLk2Y0q7/ZHyEsMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830743; c=relaxed/simple;
	bh=K4IPJrW6RiIsVCw0u9e788oMyroMERPnwNoMGOOwsB4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WLjbsFPDvcBdMMymWspS3RfB4I1WyDhHjflTX1o4o/lF3+wpz83YSJNP3rqU8S+QWuyrVEsIlw4MCMLqcPKCXNlKWp6FBmad00p6jdlJBP20yA/EyfdUvANsXEIiJuHgvXiYQbDzMiPx4R0ktnKdrY8Lq/kEgeuo5fp4+KlREdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5sgLYp1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5sgLYp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375171F008A6;
	Mon, 12 Oct 2026 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830738;
	bh=L1phGaFpRigTaog3pNLeRQSFNSF41lujL8EZtWtG7UE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J5sgLYp1UZ9MU7l6muqftr4jXNZi42pQnqe9GauC4/NRXNR1+sClSZwF4N7S5rxtP
	 dmzy+tnFrXZTFB8HH7lRcWhp8Hz14FpPY7fWtqCcsXmG/S0SqVtLixlD0va0R/9w6Q
	 26lcbM4YtuwxmjhwwS5sZI87VTv9gQ8B2nfUZY12DhK21IVCVki3tmOrq4Funt6TIW
	 x8Cpj99PrQYT45kXmP0e48a5WDeborBnCneKi3ELXqUtfABJMhJBeI9rIT6FI1sy4l
	 CqxXLTiOXTTBj+AJrQnT7ALalQ3R663xN+ZNVVkbZkWIP4hNiVTLSNKK+q/pn6zqf4
	 peNeUbGmrM4FA==
Subject: Re: [PATCH net-next v4 12/15] net: ethernet: cortina: Account RX
 buffer size in truesize
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:37 +0000
Message-ID: <179183073778.434549.16430286511659863391@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-12-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-12-4b1631b08f5d@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit "net: ethernet: cortina: Account RX buffer size in
  truesize" fixes a real bug but has no Fixes: trailer.

--

net: ethernet: cortina: Account RX buffer size in truesize

This changes gmac_rx() so that each page fragment attached to an skb adds
the full posted free queue fragment size (freeq_frag_len) to skb->truesize.
Before this change it added only the received payload length (frag_len).

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index d8bafcdf4d5f1..43fd8fd773e3c 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1849,7 +1849,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
>  		skb->len += frag_len;
>  		skb->data_len += frag_len;
> -		skb->truesize += frag_len;
> +		skb->truesize += freeq_frag_len;

[Severity: Low]
The code change looks fine, but should this commit have a Fixes: tag?

The commit message describes a functional problem:

  "short packets understate their memory use to GRO and socket
  accounting."

The old skb->truesize += frag_len line in gmac_rx() has been there since
the original driver commit:

  Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

Other patches in this series already carry this tag, for example "Keep
shared free queue parent-owned" and "Correct free queue DMA mappings".
Without it, stable tooling won't pick up this fix.

The freeq_frag_len local in gmac_rx() is also missing from the tree
before this series. An earlier patch in the series adds it, so a backport
of this fix needs that patch too. Could that dependency be noted for
backporters?

>  		frag_nr++;
>  
>  		if (word3.bits32 & EOF_BIT) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
