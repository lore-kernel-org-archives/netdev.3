Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794126063;
	b=Ej3eNF+vwEnK40UtynFKEbrzF/qpDifrWvkZtytDuv8CieRuDtm/7KyXBUfz4nhpMO7u
	 jVX6gKXK1WNDPpFskYtYXXLRg6IiPEuABvuzIW2nlOS9q2C7U0buoOpfFrHR67iXlQXvV
	 ehWcnyF4hv9N8XA6D0ufqw7k5HPP5Y1wRxah+dwAciF6CimubN90ARsmdzPziSWjUhwBV
	 7UdNG/8gixOuiiKuygtv6AtDRgFWAti/p2ea767detUB3KUoAwz2iRRFUcO28h7XZUulB
	 w/1CHffj1yGUQ4WVZABtD9wlqpJU8acRho/11i2lzSewqwoU5YI2qYFJ/nOcv0YxO2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=znRaDR7z4oQEzsVvO4SttQcnEqRJogT5i5RITknD6U8=;
	b=kOv44C8qoXIHvCI+rwGUWUmVfeHdWeSbctdCXeIfn6F25QnbhBLu1vD9Z7gwcmCWUvQN
	 /4TgzXKfHuHdv1k/dafiiBzc27P/3MF+bo9/5YD4GQJnXLyNbnJedNfunsAt1XZxp/h7s
	 yRmBSBTfGIcnZ2GtrsCE2qt048cKQ/Cln9oOWW25mKo61W+xPbqxYKgPQy3295MHuBJxi
	 JUR+ZeZrnfkzl9WjdfgzZ27aWuYF8hFFXru1gDIwBw79F1t6O31Yr+PYVXVSRCwgr7GcA
	 +BAKAfyyrNlz+tjSe3s9lAmMpZjvvNMFo8OCJcFODCTEBcf9mPBYRBARk+Hg5vviWOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+lUdZGG;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F63606A321
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7F63606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S+lUdZGG
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36f6295304dso273747eec.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 00:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794126062; x=1794730862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=znRaDR7z4oQEzsVvO4SttQcnEqRJogT5i5RITknD6U8=;
        b=S+lUdZGG/6N92nUw77FQqILRd8Hd8MMfNp8Nu4V7QEBCeWZbn4GjBbhObxS+s0mFfx
         Ytijt0WABYyPO2LpqX+y1y6SnG8Qp+rWJ9l3cONVMRkW/VBEDETzTQVXI60ZldK49xqK
         ez6Q7iEX9pObwylcu0McP/cfnST5jU7eCXs4mGDt1j2ylsDZmQ6vIAFtvmioptqtpejp
         LG27bbRxdAhNuO+k6jplT5n0lGF1zE0qGoLrb7fVjcJjkk2d3kluft/SKjNmbSGHgqh8
         YSPzBt5He43VCM+XtGn8NIDAZ+6tAeP5sgc3cS+kWvyd3BF0kRgrrK/63CyiQdLotdDH
         hUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794126062; x=1794730862;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=znRaDR7z4oQEzsVvO4SttQcnEqRJogT5i5RITknD6U8=;
        b=hZsmrt04ba8Rh5C3b7HiYNP0Y7hGfTzTOSdfbdh9QopP0jFJYf+oyeyor8/TIvX1z5
         +Tj/roJbhbZvghLxupXf2/F25WN6zFvvTdF5AEscy7t12UG+r7OHzTNI9im+/dsNk4uA
         wOYGkHNSw/PoQoWKkruGnrfNb/voAhKryEvhMYVQl+ZP6CEIYowuKALZ9cokPOghFNqR
         5pM1wwv2uQPgo72YfYnhsSMlORjLGmv0hgzlaPao/zxGYMKXnO8O8FmWW3PkZ4tbViZc
         3o0C/U96gZPgf1LWyKvhGsh9YnUyIlTOBseW9lVrv8hD/K7/RMzoomY1jn61NN3iKvkA
         6OPQ==
X-Gm-Message-State: APuU4Z9rddYpCzSQccFUmnb821mrHlU1zQbEoPk9nght1ypDJ3De0G09
	20GFkQmtl5IZqynrbNf4zIOH9qBY7MLWfgRMl2+XWEHapoB82klsje9D
X-Gm-Gg: AYBFou29bslm6uMdyjh+wqf6Tm7/jQqYeOqU6gU/tWFH4LkOR9NRumMNIZlUzl+4SwF
	D1mNtOsfeyb/KWhBzB3vxQSANUnx3tYjpyG9FBFoQh6KZ0S5AdOSLHQlKm4lIytXn8UXTHbGa/9
	cRRIU7jOO8v/+Ow8ohlnas3jJvM3czxh9cqx9UQB+PbBE1DcZbCmJY9OihyOIj2QkTTQcAfQkbA
	ctHADNUiEFRYPgO649PFxps3rPeB2mbcH0ObvZrM8207jqzl6oQdE0N91neyk7IEW4K5Y2+2fmI
	09/y+O0qqESYZDL8QRMg4hu1tzGzRD2n/Knv0exuoues7/u3iy+JDYdhkSewDvWJivM0YRllUeh
	6kp74rzSbMX1WNL2+Fd09nqjpdtaI7AJ7hDe63QBQoo+FsZwpkfUB2RAMdqwkXhRZCGez5fDYxN
	kw9AwtaNXCCDsFiO+/maLKlCkTlMVUQmqFWILwcFNQJt/gMwp7kD48lcD90/oitOXTkfY6qBVQw
	Bgyy8nYRZvgNi+HlKzINb06ahuNwO6YL2jeePqbOR1PQs/oPBF27yVgrrBT4Ak094lNzlCrCMnp
	LtajVfUD2pTSXJE69FHiQLtoX4NO
X-Received: by 2002:a05:693c:65c4:b0:36a:1f8:a56e with SMTP id 5a478bee46e88-372570db49fmr1159844eec.23.1794126061804;
        Sun, 08 Nov 2026 00:21:01 -0800 (PST)
Received: from gmail.com ([2a03:2880:9ff:64::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372665db733sm3349203eec.23.2026.11.08.00.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 00:21:01 -0800 (PST)
Date: Sun, 8 Nov 2026 00:20:11 -0800
From: Narcisa Vasile <narcisav.kernel@gmail.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: do not run out of frags in
 alloc_skb_with_frags()
Message-ID: <avAwu/1w6+2TJoE6@gmail.com>
References: <20261108100617.23840-1-yanhaishuang@cmss.chinamobile.com>
 <20261108100617.23840-2-yanhaishuang@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108100617.23840-2-yanhaishuang@cmss.chinamobile.com>

On Sun, Nov 08, 2026 at 07:06:16PM +0900, Haishuang Yan wrote:
> alloc_skb_with_frags() rejects data_len above
> MAX_SKB_FRAGS * (PAGE_SIZE << order) up front, but then rounds the order
> down for the tail, so a tail of N pages is split into one frag per bit
> set in N. A data_len that passed the check can then need more than
> MAX_SKB_FRAGS frags, and the allocation fails with -ENOBUFS although
> every page allocation succeeded.
> 
> With order 3 and 4K pages, a 516536 byte packet is 15 * 32K plus a 25016
> byte tail, which becomes 16K + 8K + 4K, so 18 frags are needed. Sizes
> between about 480K and 540K can be affected.
> 
> tun hits this when vhost-net hands it a GSO packet of such a size from a
> guest. Nothing on the host limits the size of a guest's GSO packet to
> 64K: virtio_net_hdr has no total length, and tun_get_user() sizes the
> skb from the descriptor chain. Today's virtio-net drivers stay at 64K,
> but a guest can send bigger packets by raising its own TSO limit, and
> the host must not depend on the guest for that. Worse, vhost-net treats
> -ENOBUFS from sendmsg() as transient: handle_tx_copy() puts the
> descriptor back and retries it, so the vhost worker spins at 100% on
> the same packet and the device stops passing traffic in both
> directions. On an unmodified host, tun_get_user() returned -ENOBUFS
> about 620,000 times per second, the tap's rx_dropped counter climbed at
> the same rate, and this went on with no traffic until the VM was
> destroyed.
> 
> Keep rounding the tail down when the remaining frags allow it, so no
> allocation that works today changes, and use one page rounded up for
> the whole tail otherwise. This is never larger than the full-size
> chunks already used.
> 
> This was triggered while prototyping >64K TSO for virtio-net, with a
> one-line guest virtio_net change raising its TSO limit; the host was
> unmodified. The fix was tested with that reproducer and with the KUnit
> test in the next patch.
> 
> Fixes: 09c2c90705bb ("net: allow alloc_skb_with_frags() to allocate bigger packets")
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> ---
> Base: net 30c71476d842 ("ipv6: Check the Home Address option again before its
> address is used"). The reproducer below was run on net-next 303d91a15925,
> where alloc_skb_with_frags() is identical. On net: KUnit net_core 20/20
> (kunit.py, UML x86_64), and allmodconfig W=1 build of net/core/ (arm64)
> with no warnings.
> 
> Reproducer: x86_64 KVM host (i7-14700) running net-next 303d91a15925 with no
> local changes; vhost-net, a tap NIC with mrg_rxbuf=on and rx_queue_size=1024.
> The guest (net-next too) has a local one-line virtio_net change setting
> netif_set_tso_max_size(dev, GSO_MAX_SIZE), plus
> `ip link set dev ethX gso_max_size 524280 gso_ipv4_max_size 524280`; then
> iperf3 guest -> host.
> 
> Without this patch: iperf3 fails, one vhost worker stays at 99.9% CPU,
> tun_get_user() returns -105 (31014 times in 50 ms, kretprobe), the tap's
> rx_dropped goes up by 34M during the run and keeps climbing at ~690k/s with
> no traffic, and the guest can no longer ping the host until the VM is
> destroyed. With this patch (same setup plus this patch on the host): 81
> Gbit/s, no drops, and the vhost worker is idle afterwards.
> 
>  net/core/skbuff.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 

I think we should decouple the two parts you've pointed out:

1. For valid packets that pass the initial data_len size check,
this patch avoids running out of frags by putting the tail into one
larger block of pages instead of splitting it into several smaller blocks.

2. The vhost cpu spin: this patch fixes it for the sizes in (1), but a
modified guest can still trigger it by sending a larger frame (above
~4.75 MB on x86).

In that case, tun_alloc_skb() asks for a linear part above the
kmalloc limit. The alloc_skb() allocation in this function can never
succeed and returns -ENOBUFS, and vhost-net retries the same frame
indefinitely.

Should we also return -EMSGSIZE when header_len
is above the kmalloc limit, like it already does for an oversized
data_len? I'm not sure whether the errno change is acceptable?.


> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 8da53d5b76fc..93e7b04ddfe6 100644
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

nit, feel free to ignore, this might read more simply as:

 /* If splitting the rest into smaller pages would need
  * more frags than we have left, use one larger page.
  */

> +			if (hweight_long(pages) > MAX_SKB_FRAGS - nr_frags)
> +				order = order_base_2(pages);
> +			else
> +				order = ilog2(pages);
> +		}
>  
>  		if (order) {
>  			page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
