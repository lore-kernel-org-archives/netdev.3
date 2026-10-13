Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CE3E2AD8;
	Tue, 13 Oct 2026 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883159; cv=none; b=uw8gDkbgs94syoVDVLnSrbTp4NAu1373yJ58zMvtVQe/GLq+ywZE3AW59gFHYBydaB83EjCtZgfCLVSgqVzqyxOpGixQ7l3N6LYeIkXQKprQ49usSWTe4eEAvKspNJxMz9RzllgJmSWVRTMArePwnHmXqKpF+MtKTYJXwISFn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883159; c=relaxed/simple;
	bh=ZiEo/LyxIg3ieQ/yURSFdVujpqUp3YNqG+fhUaDlAlk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PO5Wz2EU2HZpQC39B5yhD1efbCsL0jPZJ0UUySjQ+07vv7dbU9kQ0Tmz7AQbjN5d9Ms6HCchA5SIvv8mxOW/3SiKg7R/mJwoWX8Yv6t0M29DIlYiDWZ58dCbaCcCuJRN2XTWZXU0tHvK5jh5XEqp5Wswf/zb2COddgeE0c6nuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK/jreiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK/jreiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541361F00893;
	Tue, 13 Oct 2026 09:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883158;
	bh=0N4zGrHaxNZRb9Fu+dO3kSzaMrwBFwNNBPMCaUoq704=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fK/jreiKt+lkQMV02PMzTmJTxqFvNNIf+Xn0PUQY+Vi3g/Hb7vQIYUuygnq7eT8WD
	 cLaRIu967Lt9qrFFXW4o/A0RqlviSyh58RBAUmMzZf6UWHhtF2wzeP5jEiEWnbKt6k
	 kgkmGbjyNniBDrjt+zJ5zJVDMWfkbA+3vNBwUmfRGSiRQpfdNJI8yWpl30qGaMlPyi
	 vPn/NxQERUEYaixoXe0iOwJ8XPpP2X4fBhXE9IZ9CNb2RA+/xkCe7YIOtlizAptQAC
	 gvyoUlHU8QSXBx+LtRJGX4qyIHRXAMpF7O/LeItUdftmELlo0sS36CyHY4uKN3l+Zd
	 H9JEr9+yQGJaA==
Subject: Re: [PATCH net-next v4 3/8] net: bcmgenet: allow a continuation
 descriptor without the alignment pad
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Date: Tue, 13 Oct 2026 09:19:16 +0000
Message-ID: <179188315684.434549.13806745531353419743@kernel.org>
In-Reply-To: <20261012-nb-genet-mtu-nn-v2-v4-3-2e2e3bfaf8cc@tipi-net.de>
References: <20261012-nb-genet-mtu-nn-v2-v4-3-2e2e3bfaf8cc@tipi-net.de>
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

- [Low] Commit message accuracy / dead code at this point in the series
  (baseline verdict: discard, resolved later in the series).

--

net: bcmgenet: allow a continuation descriptor without the alignment pad

This changes the RX length check in bcmgenet_desc_rx() so that only a
descriptor with DMA_SOP has to cover the 2 byte alignment pad. A
continuation descriptor now only has to cover the 64 byte status block.
The commit message says this prepares for a larger MTU.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 86c8f8f8fe151..9f9c3fde87250 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2372,8 +2374,12 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  			  __func__, p_index, ring->c_index,
>  			  ring->read_ptr, dma_length_status);
>  
> +		/* Only the first descriptor carries the alignment pad */
> +		min_len = dma_flag & DMA_SOP ? GENET_RSB_PAD
> +					     : sizeof(struct status_64);
> +
>  		/* Reject lengths that would underflow the SKB build path. */
> -		if (unlikely(len > RX_BUF_LENGTH || len < GENET_RSB_PAD)) {
> +		if (unlikely(len > RX_BUF_LENGTH || len < min_len)) {
>  			netif_err(priv, rx_status, dev,
>  				  "invalid packet length %d\n", len);
>  			BCMGENET_STATS64_INC(stats, length_errors);

[Severity: Low]
At this commit, does the relaxed bound change which frames are accepted?
Right after the length check, bcmgenet_desc_rx() still has this
unchanged check:

    if (unlikely(!(dma_flag & DMA_EOP) || !(dma_flag & DMA_SOP))) {
        netif_err(priv, rx_status, dev,
                  "dropping fragmented packet!\n");
        BCMGENET_STATS64_INC(stats, fragmented_errors);
        ...
        goto next;
    }

At this point in the series the driver has no frag_head or
bcmgenet_add_frag() reassembly. So every descriptor without DMA_SOP is
still dropped, whatever the MTU.

The only visible change is in the accounting. A non-SOP descriptor with
len 64 or 65 now increments fragmented_errors and logs "dropping
fragmented packet!". Before this patch it incremented length_errors and
logged "invalid packet length".

The commit message says:

  "The MTU cannot produce a frame past the threshold yet, so nothing
  hits this today. It is preparation for the larger MTU."

Would it be more accurate to say this depends on the reassembly patch
rather than on the MTU change? A larger MTU alone would still hit the
fragmented check above.

The new bound also accepts len == 64 for a continuation, which is a
descriptor with no payload. The commit message only argues for the
single byte (len == 65) case.

Both points are handled later in the series. "net: bcmgenet: reassemble
jumbo frames from status block fragments" adds the reassembly path and
rewrites this logic. The non-SOP minimum becomes
sizeof(struct status_64) + 1, and a SOP descriptor without EOP gets
min_len += ETH_HLEN.

Would it make sense to fold this change into that patch, or to reword
the commit message so the dependency is clear?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc%40tipi-net.de
