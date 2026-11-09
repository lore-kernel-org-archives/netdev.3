Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190034;
	b=ec0mjb29fN4aq+2eaMjHNxtffvPJ3F0tXUkQy+F0XrLSOAPDs9Jo3P4n881IsVF3WMWA
	 hah0GWVfcjeKNGYxPV4z5T2E8LLK+FgzxIH85oK0mTzP5XfTgXxfC89030tBSeDMWzvdA
	 FDB8ouGXkOyAwbJBGgwA2nOGeJBVRXyTRGGfCCdS/9TgnAMSuFgOXnp3FqMMaQ1A7fNSn
	 cfgc7oC1CViEjw3wJYfdu+w8eLSB7/1SWk83h32aMbSA3ecFv1x9v1czo5GapObOXJZgQ
	 rFds7dcT7FcJg/ZCMoFiT+WOiSYdZCsuB7wpeF828C4nmEA5QSD0SqsD6sEFho/xoDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190034;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aP5F1SQLGFw3CwSUVsyeH935mxe5M3m3IupmBje0ewo=;
	b=WVV17ecJwiPyEickmikOX0Fqk+yqRBdmd9HE/79ZaW98FE+e+5GC6Cba8Ma8GFpN3gPk
	 5MiKVBmcm6O8YaoCqbtcjJJRqK1yjZIxX+39D1Hy0mv+ydqHFMb+LZAlrsR6H3nvjdTVw
	 r04O0nBEikBvzz8ws8Rqh9G2xec+jt8dJA/Lg7ts8AOqW40cOR5kqDOJ1rjVI3d2Sk2ok
	 wocpmT9+q04Dv7lGVt6fwHd4/CzrBFdTby4nhDwgVouwlSgcOrqSHNekERtpvneAm1xk/
	 IXrX++kS2Kdqhu5dDE0Rv+309ns8Jdw3tTaTSzoNwjx1aIzNhUQkptd2U6QoJdB/Hgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ErRgJEzd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1D606D80C;
	Mon,  9 Nov 2026 02:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ErRgJEzd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFE11F008A5;
	Mon,  9 Nov 2026 02:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794190033;
	bh=aP5F1SQLGFw3CwSUVsyeH935mxe5M3m3IupmBje0ewo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ErRgJEzdWwnZjK5fm13vAsFYkNMeRAHhh6yw+ZxtdQNcnskOXSh1eJ1ErZ2DUd2Bo
	 HM+LyrIQXCknnulgCm8Dn2ksAxYilaXxgT+zqZdW5nTu4R3m18p9r9stXZ0O4uoL9K
	 SsIs/ksuh8LSmnyJ4PKIRorxKXRSwMn1zMcv38or7CWuA17Dcj499whHUCxfoGFr9s
	 qHk+SPEHG9pUMOlL3VfZVhGdYSw/KyHJ6qcgMYrH1z5BXW+GMhV1k7aZqHUYESA6kA
	 pqeAOHBfuBBmlbQpyC//kP4sh2stHc8/JoErQ2+Ag8OrFfLpKKsasEyJ/fGgIUnRjq
	 3bDYhqrmK+oGw==
Subject:
 Re: [PATCH net 1/2] net: do not run out of frags in alloc_skb_with_frags()
From: netdev-bot+sashiko@kernel.org
To: yanhaishuang@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 02:07:12 +0000
Message-ID: <179419003251.994134.13120616805502524032@kernel.org>
In-Reply-To: <20261108100617.23840-2-yanhaishuang@cmss.chinamobile.com>
References: <20261108100617.23840-2-yanhaishuang@cmss.chinamobile.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes the run-out-of-frags case in
  alloc_skb_with_frags() (net/core/skbuff.c) only when every high-order…

--

net: do not run out of frags in alloc_skb_with_frags()

This patch changes how alloc_skb_with_frags() picks the order for the
tail of a paged skb. When splitting the tail into smaller pages would
need more frags than are left, it uses one rounded-up page for the
whole tail instead. The aim is that a data_len that passes the up-front
size check can no longer fail with -ENOBUFS, which vhost-net retries
without end.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 8da53d5b76fc2..93e7b04ddfe63 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6902,8 +6902,18 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
>  	while (data_len) {
>  		if (nr_frags == MAX_SKB_FRAGS)
>  			goto failure;
> -		while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order))
> -			order--;
> +		if (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order)) {
> +			unsigned long pages = PAGE_ALIGN(data_len) >> PAGE_SHIFT;
> +
> +			/* Rounding the tail down to smaller pages takes one
> +			 * frag per bit set in its page count. If not enough
> +			 * frags are left for that, use one bigger page.
> +			 */
> +			if (hweight_long(pages) > MAX_SKB_FRAGS - nr_frags)
> +				order = order_base_2(pages);
> +			else
> +				order = ilog2(pages);
> +		}
>  
>  		if (order) {
>  			page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |

[Severity: High]

Can alloc_skb_with_frags() still run out of frags when a high-order
allocation fails? The fallback just below this hunk has not changed:

net/core/skbuff.c:alloc_skb_with_frags() {
    ...
			if (!page) {
				order--;
				continue;
			}
    ...
}

This lowers order for the current chunk and for every chunk after it.
Nothing checks that the MAX_SKB_FRAGS - nr_frags frags left can still
hold the rest of data_len at the lower order.

The up-front check assumes the caller's order is used for the whole
loop:

	if (unlikely(data_len > MAX_SKB_FRAGS * (PAGE_SIZE << order)))

Take CONFIG_MAX_SKB_FRAGS=17, 4K pages and the order 3 that
tun_alloc_skb() passes. data_len can then be up to 17 * 32K = 557056
bytes. If the first order-3 allocation fails, every later full chunk is
16K, and 17 * 16K is only 278528 bytes.

Wouldn't any data_len above 278528 then reach nr_frags == MAX_SKB_FRAGS
and return -ENOBUFS?

The new tail logic doesn't cover this case. It only runs when
PAGE_ALIGN(data_len) < (PAGE_SIZE << order), and that is false for the
remaining full-size data.

The tail logic also relies on its own bigger allocation succeeding.
Take the 516536 byte example from the commit message:

- 15 order-3 frags are filled.
- The tail is 7 pages, hweight 3, with only 2 frags left.
- The code picks order_base_2(7) = 3.

If the order-3 attempt and then the order-2 attempt both fail, the tail
is filled with 8K chunks and the loop runs out of frags again.

These high-order attempts use gfp_mask & ~__GFP_DIRECT_RECLAIM with
__GFP_NOWARN. They fail whenever no order-3 pages are free at that
moment, which is common on fragmented hosts. handle_tx_copy() still
treats the result as transient:

drivers/vhost/net.c:handle_tx_copy() {
    ...
			if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
				vhost_discard_vq_desc(vq, 1, ndesc);
				vhost_net_enable_vq(net, vq);
				break;
			}
    ...
}

Each retry starts again at order 3 without direct reclaim. When host
high-order pages are scarce, can a guest that raises its own TSO limit
still cause the vhost worker spin and the device stall described in the
commit message?

The KUnit patch later in the series doesn't touch net/core/skbuff.c,
drivers/net/tun.c or drivers/vhost/net.c. So this case seems to stay
open at the end of the series.

Would it work to treat the frag budget as a hard limit on every order
reduction? For example, lower the order only when this still covers
data_len:

	(MAX_SKB_FRAGS - nr_frags) * (PAGE_SIZE << (order - 1))

If it doesn't, the code could retry with direct reclaim, fail with an
error vhost doesn't retry, or have tun_alloc_skb() put more data in the
linear part.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108100617.23840-1-yanhaishuang%40cmss.chinamobile.com
