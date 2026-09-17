Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF95221CD
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651740; cv=none; b=I12RdCjGbWhjnKNojF6o9phhnQiRIkQQdI9JnCP8ag8jRjk+bK+QfIjnat+8YBkgf6Z6mWcvCDWmdl+SbS+dD1M/mtaAuQdWhJD56/HC3PEscsqoMVuDMBCRg/O1LCn7DK7rxm7AlKCHjceLwccY0RkeUMvZn1h8tCsl1HRR2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651740; c=relaxed/simple;
	bh=NAsObRyll4WV6QYy9rKgLDobFjajI231zXddko/aXE8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pKAHJ6tK/dOsMxPLrPilxK1Y3neDb2CY1O4GCgfDj5faQM7hSrzj+3fCccwRJJmpwZGnZyGjSVquEMowm5TE6u5zYKz51TKHrGZ/mFGBGkbQolsnc/hkAXRvS9ww7sgTHmWLBhjlo6liU/8y9htv2VLCh48A3T30wNcGZ885Gig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIzwt6Da; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIzwt6Da"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab222dfso772814d50.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789651737; x=1790256537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sAeZPfLxO8gIQtw5sZuH3fSTsOPDUndxs0gC4xI6QHw=;
        b=AIzwt6DaGWdkrsP+WPfMtXn+lcvGLyBCfA/tMUdWSveQy62wAGF6NDg11ujcOhHKbM
         b0+EKsHVGdCOKHc7SMrNPPqgmoAoqYHLnPtCHfhCXByPYW61VX5aMEGiUVBsz/dtAuUK
         uwyjUQ6tr9GD/B/UHylM6JlocVwx+D/YhHjg2gIS6yHMn8ZI0EgiuEgBqY+Z9F0OaJke
         S3yvGj+kIoKTlriPwv2XCRIEvHOvxUtIDqHvEahHBPTfQ/uI7egMScd43UDJVjQYizjv
         9ZtuRvuVNTwAXIhT9xDYHKuUJC1ZRqTnksVChrldtyX58Vll8NYnlzqvMifWQvT4Kp8i
         DWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651737; x=1790256537;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAeZPfLxO8gIQtw5sZuH3fSTsOPDUndxs0gC4xI6QHw=;
        b=bV4Aknx0I3PTGj/6Uhkevotcg81KA1sh5zBTkRY1UixSKZBzXj9rKzhftglDmlc8k+
         LlQ5FZzZ3ZiI38dCU3Omg5qG4IOoRLNXWvLSkS8GNkQLUPytBKBjkfAD3XrzSF7G3CK/
         eVz3od/BFNzLcGlFC+G+/XyZvwQB1i8fo7VAkru68YDnkz2BnKeLsJAAbVyBajtNDCDO
         8vRIMmtekrflsxXif3py8evhqiOKx7r3Q55ZTrY/uv6fFbs37v9zueVafyu/VdYnStj/
         /z9hHfRoaPBBFyGMR8stYf7PuyPbxBL9zQKcmPv7zN9A7Lec6AJbW4FqulaO1w1vrXVr
         6DuA==
X-Forwarded-Encrypted: i=1; AKwUvBydx01P9IuORN8DTScSgpCeNcglf2ZksUjU2CBrU7Ww0i79HMPQynvKm4od/U0btIfHfr3JXYs=@vger.kernel.org
X-Gm-Message-State: AFuF++m/fvFAKjNcMfo9db7pGUB4HuvI+g+kOXoEo+2HFIntX+EER7gY
	lOWotrKZLP//eN60cYoixBuRvr0/ohA32vEuW6MoV4Kw8myHcUnvfoQM
X-Gm-Gg: AYBFou0H82I4QHVXY/VZnWouYHdIeNiwak45ohI8l0cAAaDqsVCOq38sWST2NkJIWM2
	zRKV2fgejM/GmDbu5SG3Lm+Pc2QnSISi/L7HWhgnSFf/BTCetTPvJz52Ndmlm3N4YW+S8sXZEaP
	4iYn6RP+Kp8OpIWV6hy0DgZwA5HOnXhi/rSwhsVmIlLGlNoAQMOm9LIMOBkV33whv+N2a2TdR09
	9FGfC0r1i+UCwKgonRI7FCp/x5HjSFnQzS/9YtXAELAj2l0qxKrKEJMq3JRr25ga6c12qp3WCRO
	cWGRB/75FMDZAlDaPBOw5uCc+Mvip+3Up2IEvL0nSz9TFlgwLbrn6huN/ggV8ENXOYdwInehUYm
	X5dU6wEph133bdxl6ICJkeQEDfGBX4z3xAuOTUqJlS7N8kNq28xZlMFKsuShrLHvsf3lDF6RTik
	2GFIpu0uNAjzcmb/rRt0Lry5Lsmx9zbnyVWQWHgKMnm6jxShnLpG28pkhESM96ynKb1B45GFzE8
	wgl5LShlcFkBs+YH/TDJZW6A3VXaJwCeSXh3uJb8vatsbSCdAwp
X-Received: by 2002:a05:690e:11ce:b0:66f:c719:616a with SMTP id 956f58d0204a3-671631be447mr2244247d50.3.1789651737398;
        Thu, 17 Sep 2026 06:28:57 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6715f79a963sm2544539d50.20.2026.09.17.06.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:28:56 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:28:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 Willem de Bruijn <willemb@google.com>, 
 Katherine Leaver <kleaver@janestreet.com>, 
 Bjoern Doebel <doebel@amazon.de>, 
 stable@vger.kernel.org, 
 kylebot@openai.com
Message-ID: <willemdebruijn.kernel.217ba36e55cae@gmail.com>
In-Reply-To: <a0b83186-7399-4d79-8226-ff43611184d7@redhat.com>
References: <20260914214229.1674102-1-willemdebruijn.kernel@gmail.com>
 <20260914214229.1674102-3-willemdebruijn.kernel@gmail.com>
 <a0b83186-7399-4d79-8226-ff43611184d7@redhat.com>
Subject: Re: [PATCH net 2/2] packet: use ubuf_info completion for TX_RING
 packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 9/14/26 23:37, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > tpacket_snd sends skbs with frags pointing into its ring slots. Slots
> > are released when skb->destructor is called.
> > 
> > A call to skb_orphan calls skb->destructor before the skb is freed.
> > This can cause the slot to be reused while still linked into the skb.
> > 
> > Switch to standard zerocopy completion (ubuf_info) so the slot is only
> > released once all references to the payload are freed or copied.
> > Restore skb->destructor to standard sock_wfree.
> > 
> > To prevent userspace from aliasing in-flight state on shared ring
> > slots, allocate tpacket_uarg per packet, rather than per slot. This
> > adds a small allocation to the transmit path. Use standard kmalloc to
> > allow backporting to stable kernels.
> > 
> > The uarg holds an sk_wmem_alloc reference, rather than an sk_refcnt
> > reference. packet_free_tx_ring waits on sk_wmem_alloc before freeing
> > the ring pages.
> > 
> > As a result a slot is released when its payload is copied, which can
> > be before transmission (e.g., in skb_orphan_frags_rx). Any slot
> > timestamp then reflects the time of copy, rather than of transmit
> > (or skb_orphan).
> > 
> > Revert the now unused previous skb_zcopy_.._nouarg infra.
> > 
> > Reported-by: Katherine Leaver <kleaver@janestreet.com>
> > Reported-by: Bjoern Doebel <doebel@amazon.de>
> > Closes: https://lore.kernel.org/netdev/20260909085542.3370986-1-doebel@amazon.de/
> > Fixes: 5cd8d46ea156 ("packet: copy user buffers before orphan or clone")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Willem de Bruijn <willemb@google.com>

> FTR both the 'high prio' sashiko finding here and the mid one on the 
> previous patch are IMHO worth addressing.

Absolutely, agreed.

I hadn't gotten around to responding to the bot yet, sorry. Was still
reviewing the options.

Simplest is to enable the deferred worker that Kyle also for page
backed rings.

As the commit says, I'd rather send something much simpler to stable,
but after exploring many paths did not found any with fewer risks or
obvious regressions.
 
> Also I'm wondering if the extra alloc/free is visible in perf figures?

It should not, compared to the skb alloc. But I don't have hard data
on that.

> Out of sheer ignorance, can't the ubuf be carved out of the ring?

It can, I actually had that first. But that has more risk. Userspace
can overwrite the ring header status to TP_STATUS_AVAILABLE,
possibly corrupting uarg->ubuf.refcnt. It might be fixable, by
incrementing refcnt rather than initializing to 1. But that is less
obvious(ly correct).

