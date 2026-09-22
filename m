Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FE552939
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089296; cv=none; b=foT/lxf7aDqMIw/hKOsTvmJIXH/89ZyhfjrWt31hlDfm8bUSA8ArQsu19h30bpxk0O0lFZE4FpNHCxDGbrgwADHm3rccxM2Qvc4dHVOm7gfRvs3WZDXklT3UePFSw2UMV6Kw92RCAtc0hjEMNvYBvnYjgqL5yJgU+m4QnI9dtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089296; c=relaxed/simple;
	bh=WXXtKunRs9PlwuXX6rnWPRmpl1Gc3yK+6odGmlPkSso=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KNWgb2sUCUgh0zqfVEt1XW0QYJYzWEssjBPg9LrIUmiQwQofNRGxpCi5D0c8k8LUQHBZCQDpj2iWZe9X4PTPyiisvjHgFKb8fbNeEF2+PsNHn1dBXYa/jUDPxKU86kbM7ngsP0Sm/8kQW7g5cEjrBtudne2bC+vzRbGigO1I0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTiE2YoY; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTiE2YoY"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-6729ca45e37so2876258d50.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790089293; x=1790694093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SA3R0WIR1hmURqC/sP5IyTdS3yL7U8cZKfY5iZZJBrI=;
        b=RTiE2YoYYSTH6vFJU2gtWE+vYTwRKjA4OgWIoQSW3ljjZpAlUmPAF08+jv9L+6QcoA
         PhFYMsMvHgWXRQolLhXbMvniPYEnWtiS0EqTMkyFrOTEbiNzuX0AMpKgEmS2g5Lxcv6q
         Q6ftz8yJRf1GZAV1Avv8GJVDG6UGD9NKb+jIae3FQX6s/AXehFv7r9jCnKLCwjiei7na
         nRb9w1yhdbU7cosm0txqeFDF7r2Lix8DKcjaQxVWErKlR8WKw6LgttElufkX9YVW/Wzf
         k8azDdItCqrssSJzbU7dBJmlK9S8XQoAbtaQsMOmpJq4Yc1L/y/fGG6YQz8Ts4IxMvQB
         316g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089293; x=1790694093;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SA3R0WIR1hmURqC/sP5IyTdS3yL7U8cZKfY5iZZJBrI=;
        b=tFlUgMTycRMLEioBDqcxeF/nF6E5fy62VGOuEo43e1Q9x+bkGLxRY8QwKRpiyqRoQa
         t7Uv57iCi4KZWDp1lO3+X2jO8+zUGpRR2iebO13MV2xvLIFzeXzGFo3MSw8BshxWKdTg
         b2VjrmQzmZNw3mF4Gh+ZgKXhNCBUTc1xovPUxkoD8kMiCyQOiQPqVxThbDVApN+o6If2
         y0Y+a6t8ac58gnG9SdlM5g3grY4mOayONfteCGMPYfvy9nO5moY8dOZuEnJJl0CnwAoy
         OGt3eZ3Y6D1Uy+KEdgJ3M4KfGxiiMwMN99/wf1zf467/nB2LXRR2U7kjMpjtWE0/dGVV
         5OTA==
X-Gm-Message-State: AFuF++lT3WbZSQ6/jHYIw9zyiRWDSYeKrqqFcqujnlg3tD2+m4S0QNXs
	+K8E0WAXxAFupwcO6pvsoumU1yB6groCL8FSjjNmZdNvmsWjEY/Y7std
X-Gm-Gg: AYBFou3kVsjTqoaEwe5gMIQZRuIPeZKIh4CSl3+/toH3TAxdq+nUNm6yxLoFfIu9NO8
	71c4ecAKWd/W5o2lKW+iTx/V4EC+np3wgMiM8nwyvzprujIYaHwDBnGAxNVtytWJNbg5QiUR6PN
	kHG0PlVoaJe6VSi5/xgBvqr19KH+6XfWI/Tl3GDfup+w/G3j7L2UMO3p+QEckTM5X6Rs7trsdSr
	/wXC7YF26nvqfNyV/7yhkwRA/Q+zVXuRAbokYigj+2WtPrgGMcSY0S+vxB+cfuedJ8kBsD7SI3e
	lAYVH+6Ytw8VMJPvA9irid6isjPvciNcNKLqIxYH9Ln5rVXiKK3iXDghGEMm2yiyigTFLOGz0QW
	ncT5AwKm0/G+B3q0cFtkfHA0yVv8jsdYIhFaUB7IDQ7A+b1FG5aF0e7IxUeMSLDmgxoj0cZRFRL
	gmp7uNgIz2ZrLyEUTsSh4LZOgC3AvohWKHeu6wCUpBV9m5Hr4eB8zf7N8yT+kUgjsm+Vp5Sycrc
	2r6HFGKtnPj5pzGiErUSbmkAUP0lBiJgVAW+JfMfJxbPwnCXo3X
X-Received: by 2002:a05:690e:4852:20b0:672:99e0:ec01 with SMTP id 956f58d0204a3-67299e0f03cmr2401266d50.153.1790089290971;
        Tue, 22 Sep 2026 08:01:30 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672c74a2adbsm859465d50.2.2026.09.22.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:01:29 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:01:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 willemb@google.com, 
 kleaver@janestreet.com, 
 doebel@amazon.de, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1284d8ebcba4c@gmail.com>
In-Reply-To: <179004896394.2160803.10158228819458028402@kernel.org>
References: <20260919004748.1463985-2-willemdebruijn.kernel@gmail.com>
 <179004896394.2160803.10158228819458028402@kernel.org>
Subject: Re: [PATCH net v2 1/2] virtio_net: copy zerocopy frags in start_xmit
 without NAPI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0 (1)
> =

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchw=
ork
> know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> (one such reply per series is enough).
> =

> - [Medium] Commit message mischaracterizes the defect being fixed, whic=
h
>   matters because the patch carries Fixes: 5cd8d46ea156 and Cc: stable.=

> =

> Pre-existing issues:
> - [Low] This problem wasn't introduced by this patch, but after it
>   start_xmit() contains two logically identical drop-and-return-=E2=80=A6=

> =

> --
> =

> virtio_net: copy zerocopy frags in start_xmit without NAPI
> =

> When napi_tx is disabled, start_xmit() now calls skb_orphan_frags() bef=
ore
> transmitting, so zerocopy frags that do not set SKBFL_DONT_ORPHAN are d=
eep
> copied instead of being handed to the virtqueue and then orphaned. On c=
opy
> failure the skb is dropped, counted in tx_dropped, and the new kick_vq =
label
> is used so a pending xmit_more batch is still flushed.
> =

> A couple of questions below.
> =

> > virtio_net: copy zerocopy frags in start_xmit without NAPI
> >
> > Virtio-net without NAPI frees completed skbs lazily on the next
> > start_xmit. Senders waiting for in-flight zerocopy buffers can
> > deadlock if they cannot transmit more packets, as then no
> > completed packets will be freed.
> [ ... ]
> > This fixes the tpacket_snd slot reuse bug on skb_orphan for
> > virtio-net, and prevents PACKET_TX_RING from running out of slots.
> =

> [Severity: Medium]
> Does the leading description match the tree this patch applies to?  The=

> patch carries a Fixes: tag and Cc: stable, so the described failure mod=
e is
> what a backporter will look for.
> =

> In the current tree, tpacket_snd() installs a destructor:
> =

> net/packet/af_packet.c:tpacket_snd() {
> 	...
> 	skb->destructor =3D tpacket_destruct_skb;
> 	...
> }
> =

> and that destructor releases the slot, drops the pending count and comp=
letes
> the waiter:
> =

> net/packet/af_packet.c:tpacket_destruct_skb() {
> 	...
> 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
> 		packet_dec_pending(&po->tx_ring);
> 		complete(&po->skb_completion);
> 	...
> }
> =

> The pre-existing skb_orphan() in start_xmit() for !use_napi runs that
> destructor within the same start_xmit() call, so the slot is returned
> immediately.  Given that, can a PACKET_TX_RING sender actually run out =
of
> slots or block in wait_for_completion_interruptible_timeout() before th=
is
> series?
> =

> The clause about "the tpacket_snd slot reuse bug on skb_orphan" looks l=
ike
> the defect that exists today, and it is the opposite of exhaustion: bec=
ause
> skb_orphan() runs after xmit_skb() has already linked the ring pages in=
to
> the virtqueue, the slot is marked available to userspace while the devi=
ce may
> still be reading those pages.  That is silent payload corruption rather=
 than
> a stall.
> =

> The deadlock and slot-exhaustion wording appears to apply only after th=
e
> follow-up patch that converts PACKET_TX_RING to ubuf_info completion an=
d
> removes tpacket_destruct_skb().  Could the message lead with the
> data-corruption case for the current tree, and keep the deadlock argume=
nt
> scoped to the follow-up patch?

[Medium] the request is only to change the emphasis of the wording
of the commit message. No code changes suggested:

Focus more on the data corruption bug and less on the deadlock that
can occur when not releasing the slots prematurely (that data
corruption).

See this statement in the commit

  This fixes the tpacket_snd slot reuse bug on skb_orphan for
  virtio-net, and prevents PACKET_TX_RING from running out of slots.

Maybe it should be moved up and say "while preventing".

Seems a bit of a pedantic comment to me, honestly.

I will reword if the other patch requires a respin, but this does not
warrant one on its own imho.

> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index e34c52d059d3..bf82ef9874ab 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3349,6 +3349,14 @@ static netdev_tx_t start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >  	else
> >  		virtqueue_disable_cb(sq->vq);
> >  =

> > +	if (!use_napi &&
> > +	    unlikely(skb_orphan_frags(skb, GFP_ATOMIC))) {
> > +		DEV_STATS_INC(dev, tx_dropped);
> > +		dev_kfree_skb_any(skb);
> > +		kick =3D !xmit_more || netif_xmit_stopped(txq);
> > +		goto kick_vq;
> > +	}
> > +
> =

> [Severity: Low]
> This isn't a bug introduced by this patch, but the new drop path and th=
e
> existing xmit_skb() failure drop path in start_xmit() now disagree on t=
he
> kick protocol.  The new path computes kick and goes to kick_vq, while t=
he
> older one returns directly:
> =

> drivers/net/virtio_net.c:start_xmit() {
> 	...
> 	err =3D xmit_skb(sq, skb, !use_napi);
> =

> 	/* This should not happen! */
> 	if (unlikely(err)) {
> 		DEV_STATS_INC(dev, tx_fifo_errors);
> 		...
> 		DEV_STATS_INC(dev, tx_dropped);
> 		dev_kfree_skb_any(skb);
> 		return NETDEV_TX_OK;
> 	}
> 	...
> }
> =

> If xmit_skb() returns an error such as -ENOMEM from the indirect descri=
ptor
> allocation on the last packet of an xmit_more batch, do the descriptors=

> already added by the earlier packets of that batch stay un-notified unt=
il
> some later start_xmit() on the same send queue computes kick =3D true? =
 The
> -ENOSPC case is covered because check_sq_full_and_disable() stops the t=
xq and
> netif_xmit_stopped(txq) then forces a kick.
> =

> Would it make sense to route the xmit_skb() failure path through the ne=
w
> kick_vq label as well, so both drops behave the same?

[Low] but I'll respond: pre-existing issue is out of scope here. But
probably makes sense as a separate fix.=
