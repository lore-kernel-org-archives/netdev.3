Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3D58FD39
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988061; cv=none; b=sNRPoBHrfOo4X/9szIMYTPaoXzc7lgXTarIyjgSW23gU+6ZqgmYvNBSrKldFQbMsREGylVEn+YNppvQhjc8IyHiExaUMo9biRETj9Iqin3HyA9sUDl/68jm3DnqAz4LvJVK7PWS//1Y9WqQF0OywHDBwPsZyWbzikWZqHZ5tE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988061; c=relaxed/simple;
	bh=T2hP5E8synOJ8Yud2/bdGMh3E/n/gJVwYMhXSsApqBs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YvYePd+gQRy3DNpb+Y1mPMUpv5k6JTqo+E16OaVIdDQqbuFiEpLNLiShbRYowkJjgmP+kJ6He1wllPMQCzQsZ0xtqE4ZefqKNjSoW5662WegPNmNSIfX4mA3DWsa79ycgcu76giqha3WRsQZdp2Ai3VkB17PY4M9XE+0oM/oEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/AdwZeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/AdwZeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0A41F000FF;
	Wed,  9 Sep 2026 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788988060;
	bh=TGLGilqS33J2RxYAb96SYC9so6AlMXKOHXw5e+1h71E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l/AdwZeBeEtbUeTCg5WjwwQXLEEac3Kr3hmq8z1rksOv1TzBz3zwPgyhzl9JQPQw9
	 podgfTEaYISqsqgR/sf8KFV+bV3FXlBohtAA8KVyPLlEb5rWHoIpjS/7F8q4l/NNAA
	 itQJsstaMsoLCrWDaDWOY1frG/R3DHNWEfcPQs+cEPKBwLwGrmhaf+aYlqqCqW5d3k
	 8zcJEEk0814LVmpK+uXEFaxNX7AmuxxQGsv17fBGBNjuwPqC0KPWq6byjiviRx+TrH
	 A3X4n5MX5ck1Vm0FWHvoMjDlLFbJtWOP5D4waGV2yNgv8YTOZ/fRO2zgkG23jjoAFq
	 n4eWsBvLreWxg==
Subject: Re: [PATCH net] pppoatm: ensure a writable skb header
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, mitch@sfgoth.com, 3chas3@gmail.com,
 qingfang.deng@linux.dev
Date: Wed, 09 Sep 2026 21:07:39 +0000
Message-ID: <178898805913.219967.13489586928492348974@kernel.org>
In-Reply-To: <20260908090519.339696-1-edumazet@google.com>
References: <20260908090519.339696-1-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] net/atm/pppoatm.c:pppoatm_send() — the SC_COMP_PROT "undo"
  heuristic on the `nospace` path now makes its decision based on…

--

pppoatm: ensure a writable skb header

This replaces the open-coded skb_realloc_headroom() dance in pppoatm_send()
with skb_cow_head(), so the LLC header is pushed into headroom that is both
large enough and writable.  It also removes the temporary skb allocation
that used to happen when the ATM socket buffer was full.

> diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
> index 6da52d12df68e..4ce7fa6e493e9 100644
> --- a/net/atm/pppoatm.c
> +++ b/net/atm/pppoatm.c
> @@ -317,21 +317,12 @@ static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
>  
>  	switch (pvcc->encaps) {		/* LLC encapsulation needed */
>  	case e_llc:
> -		if (skb_headroom(skb) < LLC_LEN) {
> -			struct sk_buff *n;
> -			n = skb_realloc_headroom(skb, LLC_LEN);
> -			if (n != NULL &&
> -			    !pppoatm_may_send(pvcc, n->truesize)) {
> -				kfree_skb(n);
> -				goto nospace;
> -			}
> -			consume_skb(skb);
> -			skb = n;
> -			if (skb == NULL) {
> -				bh_unlock_sock(sk_atm(vcc));
> -				return DROP_PACKET;
> -			}
> -		} else if (!pppoatm_may_send(pvcc, skb->truesize))
> +		if (skb_cow_head(skb, LLC_LEN)) {
> +			bh_unlock_sock(sk_atm(vcc));
> +			kfree_skb(skb);
> +			return DROP_PACKET;
> +		}
> +		if (!pppoatm_may_send(pvcc, skb->truesize))
>  			goto nospace;

[Severity: Medium]
Does this change how the SC_COMP_PROT undo heuristic behaves at the nospace
label for skbs that arrive with less than LLC_LEN headroom?

The head expansion now happens on the original skb, before the
pppoatm_may_send() admission check, so when admission fails we reach:

net/atm/pppoatm.c:pppoatm_send() {
	...
nospace:
	bh_unlock_sock(sk_atm(vcc));
	if ((pvcc->flags & SC_COMP_PROT) && skb_headroom(skb) > 0 &&
	    skb->data[-1] == '\0')
		(void) skb_push(skb, 1);
	return 0;
}

For an skb that entered with zero headroom, skb_cow_head() goes through
pskb_expand_head(), which allocates with kmalloc_reserve() (no __GFP_ZERO)
and only copies the old data:

net/core/skbuff.c:pskb_expand_head() {
	...
	data = kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
	if (!data)
		goto nodata;
	size = SKB_WITH_OVERHEAD(size);
	memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head);
	...
}

The new bytes in front of the copied data are never initialized, so is
skb->data[-1] here reading stale slab content rather than a byte this
function pulled?  If that byte happens to be 0x00, the skb_push(skb, 1)
prepends a spurious zero to a frame from which nothing was ever pulled at:

	if (skb->data[0] == '\0' && (pvcc->flags & SC_COMP_PROT))
		(void) skb_pull(skb, 1);

Before this change the same case took the skb_realloc_headroom() branch,
freed the copy and jumped to nospace with the original zero-headroom skb, so
the skb_headroom(skb) > 0 test suppressed the push.

Frames written to /dev/ppp look like they can hit this: ppp_write() does

drivers/net/ppp/ppp_generic.c:ppp_write() {
	...
	skb = alloc_skb(count + pf->hdrlen, GFP_KERNEL);
	if (!skb)
		goto out;
	skb_reserve(skb, pf->hdrlen);
	...
}

and pppoatm never assigns chan.hdrlen, so pf->hdrlen is 0 and control frames
with a non-zero first protocol byte (LCP 0xc021, IPCP 0x8021, PAP 0xc023)
arrive with no headroom and no entry-time pull.  With the VCC queue full,
pppoatm_may_send() returns 0 and the goto nospace path runs.

Would it be more robust to record whether the entry-time skb_pull(skb, 1)
actually happened in a local bool, and test that at nospace, instead of
inferring it from skb->data[-1]?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908090519.339696-1-edumazet%40google.com
