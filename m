Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794464249;
	b=BK7rVpvefrVX5DG/LR+4yUgFgjnzevf7zhjo4k1nbAkPA7vSUtqOR/k65qOZ61b5sl4l
	 I/iWp7v7Bx6Oqf/4b2HMsikBKjZUgWgnUvi1HkgYkYWjAP4GAMgr573NltjWjLDQBL9H7
	 gttcXbuheRe2wHAX3fVwThmHc2+qKSWaJUMg+LxaXPV5Tokq1YnUC5X0+gDRsE++f2AtJ
	 arMg+MVHVOPtk937cIPTnJkrlDpVu/Ym1Zwyf9H79haVa3mWUbrbeUdUZn08OgAGNJ3C7
	 +uYbM87UYAQpeSDO3b0udjV9MQhzkbfwCaP6b1U+kaPudoiE/dIgagUI4Ncj8FsBqSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LBkvWiELYKcawLYZyUR8viHzi3N0cQ25eaouxLSJFuI=;
	b=A0rerzFqcyaDiUaeZG+NlLGmUOFeTKP5tYU/PfDamNq7sLXqaEu9xcY2UoYdDj3Uj7MG
	 yv44FSTgorUoOgQUrjFlYVSNZGFzu+xnwww3RduY6b/p2kX6aRinPSuxOkuntOeLmMwwW
	 qxLWeDixwFhIbca2jBpobViNMqWK5GUZF1xZpPBx1VBncph0k+q4uDY3H1zz2szrAgxdE
	 aGL0jkVu8xbORpVYIlg1Lhms9JjPJCGhtuOEDg90pCDvroP0EAR0IM+DnI9OiHe8/gDDy
	 9pjHuksrtczQAGnSbqdQd/g4BNPv7HhWaVKSP9NCB2GUsX0kpgLuQBjEPQ4pWZV2vEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BEvEvhBA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDC2606A324
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACDC2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BEvEvhBA
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c5059958d61so99618266b.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:17:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794464247; cv=none;
        d=google.com; s=arc-20260327;
        b=ZEOmeOJm/ICP0FiiXJVfIvv/YBrUyzYggId4o9TybEvkf9srf9Zn7tnfMzc+vcArkZ
         0XM+CkJKecJo6XtjqJFig/AQ+vLyYH9JICShC2fDv4uNJAEDZydK6HTzPPZLAw/2gInd
         XXS3nMW76Gp01z5BzM4qC1tu2WQSIxoBuFGxAxIIgw8XpACGnz9brAsG3C79dgBvkuPZ
         BZqCwRq0FRsMrdAc5lp2uUyjGEIgRfa/6NhPWeNg42HpwvzlTyzLhfo8OfkZfCtagT0L
         zdFCbje/R0oUa5SL1nEH361wLLMbdN5TvJoNqNh20R1v9PNFyL9r4Zmwt0JoM2cbSErC
         x73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LBkvWiELYKcawLYZyUR8viHzi3N0cQ25eaouxLSJFuI=;
        fh=OgfrbtZst7hO9k+KDqAG37XZdai6ER9l3N8nEkf2a9w=;
        b=nQuVgugOJsREbi7y6O3PiaU4Y50D3wTSg1Ns881ESjCJmpalt7VEckFCoZIx9pK7WO
         6jMBLSsDOVXBIPlohAZbWUuucXAGCsvQgZqqV9g4DLquCzgsuZYCMkLuFwpboXObNXfH
         oAKHodNhQywrjc8N17iPlgVh8CH7W+O/lGqJgtt12TUquaqcMxTNeMwTOoGvDqEHdBQ/
         jiv49d3ZsSma9ScsxUJMJC/lXfBumvgB2gNWdm9iK3JtNu5AcrB+QnPU3v8TVCAl03ds
         CJ9lMWZCTVbIxdUy3CTiYxiZSsR7p+0wI550BMfsOmprJ9xQ9s1CMIM8TxqjYdoapQgz
         8Brw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794464247; x=1795069047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LBkvWiELYKcawLYZyUR8viHzi3N0cQ25eaouxLSJFuI=;
        b=BEvEvhBAped+W5UE0YDULfJk/MUxg512y1lESWE230SPAvsBVXdB3keD/zpqDobK0u
         7COYueevNkjlf0zFKBFHoXcBzhi4QEIEfN5Kg4heVi/9xtJ2zZNL7w3fXYlRamv43NdM
         eCGXRU3y4VqWzSfkmvdr1pzQXmm4r+ToFh5kGf6hEraJnfOKZV+8mCkSZNy/rzNuDxJr
         fa8j5QyIbKMMLqTEBTuEQfN5vlbbRpqk+SRZqVtOoRN0vwOpRyevhlHlrg96k8o83YiX
         QO6x6FbUgpXUgzY3Bu4Si7EFbB3bi8mBaFssTI2UeO07Df3kl1nvqGp3+e4/Ly3z/l2B
         2idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464247; x=1795069047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LBkvWiELYKcawLYZyUR8viHzi3N0cQ25eaouxLSJFuI=;
        b=tZ8Nn4TwArX3+4tVy9v3fa/jI2U6/X6zH8BbpX0UgpKxF8dJpVS4OHdO/9lOiUCQXs
         AhFgXrAsdd5sI6psi9H7nLvT+fraJGANZ9DkuX76fyAxOtmw3dbQ5PS5uE8+uJBB4Af8
         qBJd+jZ7gA7gSpaWv0KOm3Np9JIQghcisHlSyLQWqIYoqh+9VJVQISTZ5TtDW7u4y2od
         /IHIW5iwIoyYyYS7ozS9O4NulGqW1obsziMGzuzSPXTDn6zmLis2X1ZFbh1CfsPCz7rn
         zuJCR0p+2UQ7FTV5em7j8xlbgcOgMHHm6m13bGFlIg/bgW17ZOFnFkmeDIYvTms48f3W
         XP8Q==
X-Forwarded-Encrypted: i=1; AL+hErGgw1o60xbylQbOUb1LYenS3NuIxdYctWVnolQm+wmoyFB1uoPDRw91vXW8nYqKIyt+RJ8+GD4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FxZ/zy0pC+TZ4QeAPoUmdumj2qc2KxIeMvaxX+my+/c9zVobq
	MvHAHWk99WELBO9u3hRW/qLzLFFdTyaWQBpyKOoliwIwguT2Gh3m3FuP9DWSf+AJHXOdKxbfYma
	uDSsRxlm/yyvppdMCdGw1lmps6M7h2w==
X-Gm-Gg: AYBFou19c6mnYU9JR2h2lELBTe/IdNKNumrg34Sf7gXkMMl98ImSLu058A26IPz2e7D
	OvHfkpCMAvjW6gduIWJdB98Zec3MbIlvKEzw3ATfHF3RjGMK9z5mUiHgOpqpm/ZInwn/O9VTvq0
	OBJc0eDhkO7JU0BzvDDlAUgcceoM1+ztA5CSYFUXZfotGxPtun4elryARmmKG+zXdDbUA8gCZXI
	+lb6py8MgebrRFAlcRBQi0UqXXyJt/1MRc+Rt5KBOm0YVwDF/7uHmjeRDyfxfrNUhK2V5StXqwi
	vD6NkbeqHtzm6jpeb7SjXnQ8pD/+UntXvasxBQTqLoTWzV8gH7LG7EWFzhqrZTcAlpyYvUv2KAX
	td5f+CUH3DGBrwn5YPbFSIHFxoHzCZkJVVfFLnpPCu33RX3FLln85FMGJzYuCh8ZQP64quvzQ35
	a6N4rJWsJh569YrjNPbmhTLV2RHXwT2TrpSl5EeeHpasCWFGgT+yQBgWhUg2ja/W2Z9q/L
X-Received: by 2002:a17:906:d54e:b0:c50:8612:d441 with SMTP id
 a640c23a62f3a-c508612d6e1mr32110666b.21.1794464246673; Wed, 11 Nov 2026
 22:17:26 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110043016.56986-1-mhun512@gmail.com> <179445789040.2199510.7426210198945271595@kernel.org>
In-Reply-To: <179445789040.2199510.7426210198945271595@kernel.org>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 12 Nov 2026 01:17:14 -0500
X-Gm-Features: AclHuK_N4Kjnino_xgsBrqlpbKR-zvn6NbL5YTvL81RB09JJGEvG7Ht4_NlvG2c
Message-ID: <CAGEsz8Gocd4J8-K0sngFmF6NwQqNQh5KtCMp8GrM8fusCNaF5A@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: rtl8150: fix rx tasklet use-after-free on disconnect
To: netdev-bot+sashiko@kernel.org
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, ae878000@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

Thanks for reviewing the patch and preparing the additional fix.
Please go ahead and submit it. I appreciate your help with addressing
the URB resubmission issue.

Thanks,
Myeonghun

2026=EB=85=84 11=EC=9B=94 11=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 11:31,=
 <netdev-bot+sashiko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (2) =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch's new tasklet_kill() calls in rtl8150_disconnect()
>   cannot reliably stop rx_fixup() when it keeps rescheduling itself, and=
=E2=80=A6
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the stale
>   dev->rx_skb pointer can lead to a double free or a device DMA into=E2=
=80=A6
> - [High] This problem wasn't introduced by this patch, but pegasus.c, the
>   driver rtl8150 was derived from, has the same late-completion tasklet=
=E2=80=A6
>
> --
>
> net: usb: rtl8150: fix rx tasklet use-after-free on disconnect
>
> This adds a second tasklet_kill() in rtl8150_disconnect(), placed after
> unlink_all_urbs(). It is meant to drain an RX tasklet that a late
> read_bulk_callback() could have scheduled after the first kill, before th=
e
> driver data is freed.
>
> > diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> > index d51e43170e033..98c36c3779564 100644
> > --- a/drivers/net/usb/rtl8150.c
> > +++ b/drivers/net/usb/rtl8150.c
> > @@ -971,6 +971,8 @@ static void rtl8150_disconnect(struct usb_interface=
 *intf)
> >               tasklet_kill(&dev->tl);
> >               unregister_netdev(dev->netdev);
> >               unlink_all_urbs(dev);
> > +             /* A completion may have scheduled it after the first kil=
l. */
> > +             tasklet_kill(&dev->tl);
>
> [Severity: Medium]
> Can this tasklet_kill() actually end the rx_fixup() reschedule loop that =
the
> commit message describes?
>
> The commit message says "disabled endpoints make RX resubmissions fail, s=
o
> rx_fixup() can keep rescheduling itself". It then says "tasklet_kill()
> drains any late tasklet and prevents self-rescheduling".
>
> rtl8150_driver has no soft_unbind, so usb_unbind_interface() disables the
> endpoints before calling ->disconnect(). The device is still attached, so
> usb_submit_urb() passes its -ENODEV check. usb_hcd_link_urb_to_ep() then
> returns -ENOENT, or -EPERM while usb_kill_urb() is in progress:
>
> drivers/usb/core/hcd.c:usb_hcd_link_urb_to_ep() {
>     ...
>         if (unlikely(!urb->ep->enabled)) {
>                 rc =3D -ENOENT;
>                 goto done;
>         }
>     ...
> }
>
> In rx_fixup(), -ENODEV is the only error that skips the reschedule, and
> nothing checks RTL8150_UNPLUG:
>
> drivers/net/usb/rtl8150.c:rx_fixup() {
>     ...
> try_again:
>         status =3D usb_submit_urb(dev->rx_urb, GFP_ATOMIC);
>         if (status =3D=3D -ENODEV) {
>                 netif_device_detach(dev->netdev);
>         } else if (status) {
>                 set_bit(RX_URB_FAIL, &dev->flags);
>                 goto tlsched;
>         }
>     ...
> tlsched:
>         tasklet_schedule(&dev->tl);
> }
>
> tasklet_kill() only returns once the waiter sets TASKLET_STATE_SCHED
> itself:
>
>         wait_on_bit_lock(&t->state, TASKLET_STATE_SCHED, TASK_UNINTERRUPT=
IBLE);
>
> tasklet_action_common() clears TASKLET_STATE_SCHED and wakes the waiter
> just before it calls t->callback(t). rx_fixup() then sets the bit again
> before it returns. All of this runs in non-preemptible softirq context.
>
> On a CONFIG_SMP=3Dn non-RT kernel, or when the waiter runs on the same CP=
U as
> the tasklet, process context would only ever see TASKLET_STATE_SCHED set.
> Wouldn't rtl8150_disconnect() then sleep in TASK_UNINTERRUPTIBLE forever
> while ksoftirqd keeps running rx_fixup()?
>
> The first tasklet_kill() already had this limitation. The new call relies
> on the same assumption to close the use-after-free.
>
> For tasklet_kill() to be reliable here, would rx_fixup() and the resched
> path in read_bulk_callback() need to stop resubmitting and rescheduling
> once RTL8150_UNPLUG is set?
>
> >               free_all_urbs(dev);
> >               free_skb_pool(dev);
> >               dev_kfree_skb(dev->rx_skb);
>
> [Severity: High]
> This is a pre-existing issue, but can dev->rx_skb still be stale when it =
is
> freed here?
>
> read_bulk_callback() passes dev->rx_skb to the stack, and if the pool is
> empty it leaves the pointer unchanged:
>
>         netif_rx(dev->rx_skb);
>         ...
>         skb =3D pull_skb(dev);
>         spin_unlock_irqrestore(&dev->rx_pool_lock, flags);
>         if (!skb)
>                 goto resched;
>
>         dev->rx_skb =3D skb;
>
> The pool has only RX_SKB_POOL_SIZE (4) entries, and only rx_fixup() refil=
ls
> it. rx_fixup() is also the only place that replaces the pointer. If every
> GFP_ATOMIC allocation in fill_skb_pool() fails, it just reschedules:
>
>         skb =3D pull_skb(dev);
>         spin_unlock_irq(&dev->rx_pool_lock);
>         if (skb =3D=3D NULL)
>                 goto tlsched;
>         dev->rx_skb =3D skb;
>
> Suppose rtl8150_disconnect() runs in that state. The tasklet_kill() calls
> stop the loop but leave the pointer as it is. Would dev_kfree_skb(dev->rx=
_skb)
> then double free an skb that the network stack already consumed?
>
> Something similar looks possible across close and open. rtl8150_close()
> does not kill the tasklet or clear rx_skb. rtl8150_open() then reuses a
> non-NULL rx_skb as the bulk-in buffer:
>
>         if (dev->rx_skb =3D=3D NULL)
>                 dev->rx_skb =3D pull_skb(dev);
>         ...
>         usb_fill_bulk_urb(dev->rx_urb, dev->udev, usb_rcvbulkpipe(dev->ud=
ev, 1),
>                       dev->rx_skb->data, RTL8150_MTU, read_bulk_callback,=
 dev);
>
> Could the device then DMA packet data into freed memory?
>
> [Severity: High]
> This isn't a bug introduced by this patch, but pegasus.c, which rtl8150 w=
as
> derived from, seems to have the same late-completion tasklet problem. Thi=
s
> patch doesn't change it.
>
> In pegasus read_bulk_callback(), when the resubmit fails, rx_tl is schedu=
led
> without checking PEGASUS_UNPLUG again:
>
>         else if (rx_status) {
>                 pegasus->flags |=3D PEGASUS_RX_URB_FAIL;
>                 goto tl_sched;
>         }
>         ...
> tl_sched:
>         tasklet_schedule(&pegasus->rx_tl);
>
> During unbind the endpoints are already disabled, so the resubmit fails w=
ith
> -ENOENT. It fails with -EPERM once usb_kill_urb() has set urb->reject.
>
> The only tasklet_kill() is in pegasus_close(), and it runs before the URB=
s
> are killed:
>
>         tasklet_kill(&pegasus->rx_tl);
>         unlink_all_urbs(pegasus);
>
> pegasus_disconnect() then goes from unlink_all_urbs() to free_netdev()
> without draining the tasklet:
>
>         unregister_netdev(pegasus->net);
>         unlink_all_urbs(pegasus);
>         free_all_urbs(pegasus);
>         ...
>         free_netdev(pegasus->net);
>
> Consider a completion that passes the netif_running() check before
> __dev_close_many() clears __LINK_STATE_START. If it reaches
> tasklet_schedule() after the tasklet_kill() in pegasus_close(), rx_tl is
> left pending with no later kill.
>
> rx_fixup() returns early on PEGASUS_UNPLUG, so there is no endless loop.
> It still reads pegasus->flags, though, and tasklet_action_common() touche=
s
> the tasklet_struct inside netdev_priv(). Could either of those run after
> free_netdev()?
>
> Does pegasus_disconnect() need a tasklet_kill(&pegasus->rx_tl) after
> unlink_all_urbs() too?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261110043016.56986-1-mhun512%40gmail.com
