Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8E38C42F
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779559; cv=none; b=Tfo9C87Lu+dFdab+mVEumusyu3c6Giz7vVlkglbB1gHdPkbvxRST+P/TWOY3MLyXQLWIPXtB6f/mwi6j59FvNYJWF84UGoAAoVqJzjlTfOIUNcxvsyRwTYRjAi4yNreW6LzXrHcBfr2US/8depxmlkFQ1Nn+19iNjyVMzXv85PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779559; c=relaxed/simple;
	bh=TbVUQwFSkyX4nGSCAZPhq9WL1+mOGhIkm5GNz6CAkDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocU6lvL4gRMXc3YOH+y/9oTi690dVwX+TpwECQs4sjqE+i7eIz7WeAwny0IYl0co5aHK5Xi/f9qh7Cfo0imPXjgEk/+/XXrZK2dJ0AwaBoeF+m0P8T2BoHS3I2IgO4QAqJM/YRHUw5r7VRsKgwVo5RMWD7QmWl8L/ZWol1JE5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8C5086032B; Wed, 26 Aug 2026 23:25:55 +0200 (CEST)
Date: Wed, 26 Aug 2026 23:25:54 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next] net: Use fixed slots for skb extensions
Message-ID: <ao9Z4vK-_pzu03uu@strlen.de>
References: <20260825-rfc-skb-ext-fixed-offsets-v1-1-8050ff33bec9@cloudflare.com>
 <ao9UV9S7rUkyQ8jv@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao9UV9S7rUkyQ8jv@strlen.de>

Florian Westphal <fw@strlen.de> wrote:
> (or maybe use &= so as to flag something as active
>  that was never enabled).
> 
> Regarding skb_ext_maybe_cow() in above function: Why not ..
> 
> - Fix skb_ext_put_mctp to be safe against double-put.

Should be done in any case.  __skb_ext_del() also lacks
SKB_EXT_MCTP handling.

Once thats fixed, skb_ext_scrub() could look like this, no?

static int __skb_ext_scrub(struct sk_buff *skb, unsigned int keep)
{
	int i;

	for (i = 0; i < SKB_EXT_NUM; i++) {
		if (((i << 1) & keep) == 0)
			skb_ext_del(skb, i);
	}
}

AFAICS that handles all cases, also, doing skb_ext_del() for
all active extensions is supposed to be equal to skb_ext_reset().
