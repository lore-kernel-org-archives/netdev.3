Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B93C5536
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171323; cv=none; b=IxuRqe8Z0DrDqGcgKGLDDDmzlGwcYe4ml01A+EUk49QNfHQFC149aOizXpVpuUwfmdW2ZgnVopNhe2rstNwfB/ih1sSTQOfmMizcFUIj12Y+fGCzm1JynKr9CIHNYTJ55Ec49rknaOWbP2wgFPp5wbQU/kujZK8TFxhIlCcdcTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171323; c=relaxed/simple;
	bh=m/eXo++qysxw7lybczOtxAQVK9dhV3toSMRwZYW/4jM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ww8/mDRhAykQ1NPjXwuvpEKktqFfQZvr+tmvqT09/dKH2LdY0+vnkLYvMon3C468/BMHWDKGGMqSBPnaaQbufAtIhg6LnJR1Pe7/Qb2hehCzCRDSNKJ9WnZPqXiTp33H5GYluvJhqKPSxiQzzVv+8byV3yiqwrIDIN0aRb/tT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+uZzwNQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+uZzwNQ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so63617065e9.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781171319; x=1781776119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PnrMx3F3Mo06rwgwVZw+wlkBVdU2ASIomiMmAPzODI=;
        b=I+uZzwNQ+AZRKaacuqz6/gsH8qoFMqjbkbzC2XffDzyayJd/uO4Gr0yMWh9m8iE4R3
         ltvNI+r+DhKVuwCtjqT7O0BcdelTYOkxPHjnNC5aKSE0T5ecTzxcez78kf6Pta9MR7b4
         NoRdgkJElCB29PqEg7CXIGuOeB9qCztrUUL2lW5URaATkS5/MF0QGYTXrD2CrlOViibC
         mKWDFdUBERznrZcPo/PAhGlVtHHDUsICe7Azy+c7RZJ5yQaH4Rt7c0qOkjaLRFDCcdhx
         XifpwF5QRMTLRAeh0nnl+rYuTSiUVlS+FiDpLvSIs4IsCe2bMvAqPLeaOoUujYIhvVIH
         fnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171319; x=1781776119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0PnrMx3F3Mo06rwgwVZw+wlkBVdU2ASIomiMmAPzODI=;
        b=M+BdHhYq99tCR5FQpgQqqmL7DOlw686sXpQH0dImGvUBYGZQe3fMoJUzDuXCKUSM9c
         mqLzDXZbffmPfk3w3aKr1YPZ5odpB++TobmXe9wHQHncetr6LJ8N9KzoZWT7EwRyiC3Y
         PnBO/yWhcZoWxjArRvif8ah3fYLRuI7YYSvMw2ZIi86MuRUP4wykPd0HWF1y+f/67gJ4
         usH9QPiMA5BlCdPEQ/PMyhSuQUa9qVBUJG7Q1XPOAJDPF6d42dPy/hyT34dyqClRbAVu
         jO6aHsHNhTfVd+IqMdCJf0XK+/yY8/9iN1eX4VJkFWROO4GcW/9o/UDe/zvQFe1jAgH1
         c8iQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HEWHdPhjkcyWRwZ7cLOQzLCVQF7Wn27uvN1S5LrOZKKu/WibX3pYUeu8Nj6GuGBvax0KecW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywex3X9eCYh4Sr/hRgzCm0PklZHDCz66DXnym41TSWSMTEhgKZQ
	b+bJN4ISOhHvYRIEWhjtAi0AYdxd7CYKEyQn5Zis8IVG7xauAVHGF+te
X-Gm-Gg: Acq92OGEu2GqzltRX6/IOrAKhzAVo8QcpXW9CY3vHtt2iAunPPPY2MZUQpkGUjcB35s
	K6W5kcKHV3ylKF/f1TF7JvRTxdHJnL2iIC+87jQXeEJ7TrW6vp1w+H1FtlFkTuFZC0zSwqYkE7Z
	EWZD/LpoR7Ag8VHS6ZwaGEk+Eq1TjdwSgvgEJYz9jQhF262mORXY8QFecR6nGM9oRbI94FDwZOm
	bRCyQ5NfKhNy2F+vMvdY3xeek4bXQG5pGXJzhSv1TyT0hrxbbIikE0Cx6n75Zv9t77y1tWgrstR
	tR37wxS+voVB9eSX5ElEbKSEq5boMWs7683d5HY8lywGx0IoLDF3CguAVtiMKuKOnjjDc7PQi8s
	AMhnnn9bWsPafCkLwYoxaOEmr8jAP6hDfqyRUEM9vOEZIbhgPfU6kfYSzT/9gSnDhw1oqu/O37H
	qONeqK1wIBU0RRSCmzhcJ4Fmf4lv4e6Lrf+bDX0zsNCLMeUfZJmXhVASs9fBsvmjGlpNyI5Mk=
X-Received: by 2002:a05:600c:3b19:b0:490:e5c1:b8c6 with SMTP id 5b1f17b1804b1-490e5d0fffbmr23778935e9.8.1781171318970;
        Thu, 11 Jun 2026 02:48:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e4228768sm38905995e9.0.2026.06.11.02.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:48:38 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:48:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
Message-ID: <20260611104836.469610b0@pumpkin>
In-Reply-To: <20260610221606.1091465-1-xmei5@asu.edu>
References: <20260610221606.1091465-1-xmei5@asu.edu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 15:16:06 -0700
Xiang Mei <xmei5@asu.edu> wrote:

> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len == 12 case.
> 
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
> 
> Bound len by the size add_recvbuf_big() actually advertised.
> 
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..afe73eda1491 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> +	unsigned long max_len;
>  	struct sk_buff *skb;
>  
>  	/* Make sure that len does not exceed the size allocated in
>  	 * add_recvbuf_big.
>  	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> +		  vi->big_packets_num_skbfrags * PAGE_SIZE;

That looks like a constant (for the vi).
Probably worth saving rather than recalculating all the time.

-- David

> +	if (unlikely(len > max_len)) {
>  		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> -			 dev->name, len,
> -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +			 dev->name, len, max_len);
>  		goto err;
>  	}
>  

