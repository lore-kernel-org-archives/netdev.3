Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3963AEF2E
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338704; cv=none; b=bfLl1fSadWXaK2+YELyzniJQ8NA/O9S5JhcxdoEBzp1S5Z6QaytJtjoNx2vAx4f9Y5yI7vF0gZS2B2nkE8IYds7EHKpDtTS2eamj3GB0GdFfOCN2+N1flqvji4fyuY0ypVH7Oj+/qs5lERN3No9DLJnqfdv5v6MhoTeZrmIiyzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338704; c=relaxed/simple;
	bh=bWOb68S0VOYF+sRsmpB6j9hAdltyOnUDkJBg1gYmP1Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYGpWqMeqeXho0l8t7q2vMleMYbd/7QfXJN77+MQE+fYFdH4rwmhTndvyAR80Gk1195HxLwtiIf17ySTKKHUXlYftzWdqeVXfFoT2zaTwAjH+Gd/fAbiblAu+PCU1N76+HNHENGL2puJLJ/Tshc/VDvoDrW1CThytFPTCdW4tpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8LQF08F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8LQF08F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76CB1F000C4;
	Sun, 18 Oct 2026 15:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792338699;
	bh=DMT4TdNl8IpNQb6hIuxidKBGBIOMFR6l3r95Gg73020=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D8LQF08Fgy7/iQxnK7X1VoSv1lFvlmNIbZ4oa+jzh5Xgf9jWNcAQ7gG5T4Ps9McaW
	 eJY02LgECqxvNa/UeYTvTWZOq0TXt6r7a1N+GLRT3+C+73aWuCzpa7ghqL52Y3jORs
	 RtBsAw5CDOuG8HRF7kbdF2+rg/PCVbZ+uDy2qfplgV8c3hYylDjVTrJ3KFq7du77ky
	 0gmolmLKo75gzXKFrdttsYlmP4UfBY/J5rt0oF1PInSJ5lvdQ2nENbPKluj7ZnF+CI
	 mflxTA+Fdyu82dm5zZVh8QU/3eJd1qxQEMxPQwyU+lAig8h/TXZn+Vc9SFMRHu6Yn5
	 gDUNqkkrmZy4Q==
Subject:
 Re: [PATCH net-next v9 2/8] hsr: Use skb_clone() while adding the HSR header
From: netdev-bot+sashiko@kernel.org
To: bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, j-rameshbabu@ti.com, andrew+netdev@lunn.ch,
 c-vankar@ti.com, danishanwar@ti.com, d-qiu@ti.com, davem@davemloft.net,
 fmaurer@redhat.com, kuba@kernel.org, neelima@ti.com, pabeni@redhat.com,
 praneeth@ti.com, pratheesh@ti.com, richardcochran@gmail.com, horms@kernel.org,
 vigneshr@ti.com, willemdebruijn.kernel@gmail.com, daniel.machon@microchip.com,
 edumazet@kernel.org
Date: Sun, 18 Oct 2026 15:51:38 +0000
Message-ID: <179233869819.3135.906589936438355086@kernel.org>
In-Reply-To: <20261014-hsr_ptp-v9-2-2d20a2a0f816@linutronix.de>
References: <20261014-hsr_ptp-v9-2-2d20a2a0f816@linutronix.de>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] hsr_create_tagged_frame() (net/hsr/hsr_forward.c) calls
  skb_cow_head(skb, HSR_HLEN) before skb_push(skb, HSR_HLEN) and…

--

hsr: Use skb_clone() while adding the HSR header

This commit changes hsr_create_tagged_frame() to use skb_clone() and
skb_cow_head() instead of __pskb_copy(). The goal is to keep the
skb_shared_info part, which holds timestamp requests. It also replaces
the open coded memmove() with skb_postpush_data_move() so that skb
metadata is preserved.

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 44f6d9c83180a..6cc1812be15ad 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c

[ ... ]

> -	/* Create the new skb with enough headroom to fit the HSR tag */
> -	skb = __pskb_copy(frame->skb_std,
> -			  skb_headroom(frame->skb_std) + HSR_HLEN, GFP_ATOMIC);
> +	skb = skb_clone(frame->skb_std, GFP_ATOMIC);
>  	if (!skb)
>  		return NULL;
> -	skb_reset_mac_header(skb);
>
> -	if (skb->ip_summed == CHECKSUM_PARTIAL)
> -		skb->csum_start += HSR_HLEN;
> +	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
> +		return skb;
> +
> +	/* Ensure the cloned skb has enough headroom to fit the HSR tag */
> +	if (skb_cow_head(skb, HSR_HLEN))
> +		goto err;
>
>  	movelen = ETH_HLEN;
>  	if (frame->is_vlan)
>  		movelen += VLAN_HLEN;
>
> -	src = skb_mac_header(skb);
> -	dst = skb_push(skb, HSR_HLEN);
> -	memmove(dst, src, movelen);
> +	/* The entire header area needs to be linear */
> +	if (!pskb_may_pull(skb, movelen))
> +		goto err;
> +
> +	skb_push(skb, HSR_HLEN);
> +	skb_postpush_data_move(skb, HSR_HLEN, movelen);

[Severity: Medium]
Should the skb_cow_head() call above also reserve room for the skb
metadata? It currently reserves only HSR_HLEN.

skb_postpush_data_move() moves the metadata HSR_HLEN bytes toward
skb->head. skb_data_move() requires the metadata to fit in the headroom
that remains after the push:

include/linux/skbuff.h:skb_data_move() {
    ...
	if (WARN_ON_ONCE(meta_end + len != skb->data ||
			 meta_len > skb_headroom(skb))) {
		skb_metadata_clear(skb);
		goto no_metadata;
	}
    ...
}

__skb_cow() only expands the head when the requested headroom is larger
than the current headroom. Consider a clone with at least HSR_HLEN bytes
of headroom but fewer than HSR_HLEN spare bytes in front of the metadata.
No expansion happens, so after the 6 byte push meta_len is larger than
skb_headroom(skb). Would that fire the WARN_ON_ONCE() and clear the
metadata?

Such an skb can come from hsr_handle_frame() on the interlink port, or
from hsr_dev_xmit() after a redirect. Both paths reset mac_header to
skb->data, so the first half of the WARN condition holds and only the
headroom check decides the outcome.

Other users of skb_postpush_data_move() include meta_len in the headroom
request. For example, __vlan_insert_inner_tag() does:

	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)

and __bpf_skb_change_head() does:

	ret = skb_cow(skb, meta_len + head_room);

Would something like this be needed here as well:

	skb_cow_head(skb, skb_metadata_len(skb) + HSR_HLEN)

Without it, the metadata preservation described in the commit message
("The clone also preserves metadata so skb_postpush_data_move() is used
instead of memmove()") would not hold in this case.

> +	skb_set_network_header(skb, HSR_HLEN + movelen);
>  	skb_reset_mac_header(skb);
> +	skb_reset_mac_len(skb);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014-hsr_ptp-v9-0-2d20a2a0f816%40linutronix.de
