Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451C3DF01C
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030902; cv=none; b=iuQ+lAO6C+FW8HAE9TsEAUbnQg5vfND9A4UvlG3MoM0PA2SIk8IWGKo208Vn8arHBkhT0UkwfylRH+3O/DHUrCg2XXPRfu7TuQ0Pa97gLZKew1MgbOOwN0ULl+QIl+5BfP+6M0gppmp898LQxRuz1jgh5xIsnoLGkBQFMVZbzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030902; c=relaxed/simple;
	bh=1qOiklvTtnsD2yXRLJknPEOXVu0hrGmFrv5D9jTxI/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQPhnjpbPsX5YCB7FktSItLUTY82VT/AYockdY6LABMhohxeyQqn2/R0yxjyq7xUUlxERSJ7YpgrQJvFpKYdQBqzruuv1ezVNGxVoDV56nmzAS/GuGw8YUnV4ftYPg2AcXl6hUG7k68XSg5BhP9R/afSIepd34zZhKBdeUHsOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmGCuqcZ; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmGCuqcZ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874aso952235f8f.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789030890; x=1789635690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AUQQGZZN7QEXDMbD59CT5uaYffxlADRJRdOW5f3RXTg=;
        b=pmGCuqcZ0nWSppph6SOa1rQIP+D7hCXu28cJA+AEKVEeUNQ3qu4gmoVLPP4OLBfQlA
         YJ7u6u3O2QDrZHmNQrKIhQiA7LfLHsd++/PIwRMyfQLCBH81qpvzB+jpW4XVr7hECqKm
         xkwcKbVq+w6hu3xT1aSqZQdZJeULAyyenYRDSCQK943wJ6ZgDQxpNB2IhLQH3009CFLy
         Ut/wkWyjUh+GpE8dn4CY3q8b+/K+jRPllCa85xUu0YX6588xDqeqh6Kgd5+VEXf9Qi/3
         9L4OKMByR/HtMn0a/IXs0rfJtfD/vbkj9fh/B0Xhl9GWgozmwpO7f2wXyTTMdnSiP5QY
         TGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789030890; x=1789635690;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUQQGZZN7QEXDMbD59CT5uaYffxlADRJRdOW5f3RXTg=;
        b=N51j3NJMy0u9fIoifFUqfr3kH1yWA0MFefymv3amrlNU6UijU6T5Ht79+7nTeCfPtQ
         i59gKGj9C7Ccfwn9XIQbetpeZkorxJuHt2B3oJ/Nn7YY0+xe3OvI4BxOWnVgm8+vu16S
         hxuDQyaAigyvKGJ7rBUGdHyCFTzNpGd7YJN8/PdS71W7iYNelR1GOhiCegk5VgieYkPt
         mujGI6hSve0tzPrOIZW6GOAJQZsQCJ37XN9XL4DBTUcRJxsQykFgR9OgU4KMSm4mj4M8
         YGAY+ofrO8IxXzfltOizc14R5xgD/nQOCS1RD+tp7yvZavgudSWDUGBgtc26CvoZWBnU
         VT2w==
X-Forwarded-Encrypted: i=1; AKwUvBy08y32SQxsnDYCJEcyLLk88o/nip7HnUaD+k+zrt9x2JtDCOjsXyrJDgimAQ532iw252sefyk=@vger.kernel.org
X-Gm-Message-State: AFuF++mZQ9u6MY33Y/tgET+8sJy8Pc8f5yLESVBrwG8TpvueFBsR/HjX
	Q1FjRjCqFS2ZhSXgxi6vmk51AceSYE1x2LNCOn03Ap9CsBBlRu8L/Ttz
X-Gm-Gg: AYBFou3ADDo/0Za4m++S896AP0T4sEsC24bcOXb4iDx2S6sMVHIwwdC1b72goFFb4/o
	eJRVukENzj67xJT4ib8FrI3Owu/hcI1eqLGB7L6hMy0FZ1/PMpwsIsm4Mesd5KDpRHG+dZ8BC7g
	vXI0oWX30yBQLSiAS1gzKf7sk1zqDiIFhIrq3HnQgGaOEQt8AO6rkNpOkbImxI2IoY5cb6G1e5X
	cxIyyrbeeThyEETb8bU31j4w6qdHDNA8+zSC8uQapQ7PepGNNPXnoiJ1wdJmrrz5KaV6Gf7M/4w
	6GltcSaJt3Dt/bwfdk838Nj9IAEs5dC6DIJWKmVcYHnUOjHNPEbGDcbNEU31/oM83UfXcGNoumJ
	G+WJEvCIuNuv1tM/owctyOBhFR1TJJTx5TzTya7MsWvhBpH+vxm1mi5Lf2zswcvJ89ZVuTbD5JA
	F2dIZxQbNE1PckUC6u8PxZg3gnxLZMCpM7hA0OJgNqig+7QpUEy5Btdc0YSlUd+mdKkf4E53C10
	ab7mUiPvxuYnloyvmz8LHxzEwGih/SnhC2U
X-Received: by 2002:a05:6000:26cf:b0:486:e727:a9cc with SMTP id ffacd0b85a97d-486e727a9e8mr112600f8f.6.1789030889052;
        Thu, 10 Sep 2026 02:01:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm48344103f8f.22.2026.09.10.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 02:01:28 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:01:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: omermetekaya0@gmail.com, netdev@vger.kernel.org, oneukum@suse.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net v4] usbnet: fix smp_processor_id() use in
 preemptible context
Message-ID: <20260910100122.205d2608@pumpkin>
In-Reply-To: <178899045475.219967.8804711454240391662@kernel.org>
References: <20260907214727.692307-1-omermetekaya0@gmail.com>
	<178899045475.219967.8804711454240391662@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Sep 2026 21:47:34 +0000
netdev-bot+sashiko@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>=20
> - [High] usbnet: dropping
>   u64_stats_update_begin_irqsave()/u64_stats_update_end_irqrestore() in=
=E2=80=A6
>=20
> --
>=20
> usbnet: fix smp_processor_id() use in preemptible context
>=20
> This changes usbnet_skb_return() and tx_complete() to fetch the per-CPU
> pcpu_sw_netstats pointer with get_cpu_ptr()/put_cpu_ptr() instead of a ba=
re
> this_cpu_ptr(), addressing a smp_processor_id()-in-preemptible-code report
> from syzbot.  Along with the pointer change it also switches the seqcount
> write helpers from the _irqsave variants to the plain ones.
>=20
> Closes: https://syzkaller.appspot.com/bug?extid=3D04cd90bb99c6ef81a65d
>=20
> > diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> > index a19ecf718f36a..3df72b0c6bcfc 100644
> > --- a/drivers/net/usb/usbnet.c
> > +++ b/drivers/net/usb/usbnet.c
> > @@ -325,8 +325,7 @@ static void __usbnet_status_stop_force(struct usbne=
t *dev)
> >   */
> >  void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
> >  {
> > -	struct pcpu_sw_netstats *stats64 =3D this_cpu_ptr(dev->net->tstats);
> > -	unsigned long flags;
> > +	struct pcpu_sw_netstats *stats64;
> >  	int	status;
> > =20
> >  	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
> > @@ -338,10 +337,12 @@ void usbnet_skb_return(struct usbnet *dev, struct=
 sk_buff *skb)
> >  	if (skb->protocol =3D=3D 0)
> >  		skb->protocol =3D eth_type_trans(skb, dev->net);
> > =20
> > -	flags =3D u64_stats_update_begin_irqsave(&stats64->syncp);
> > +	stats64 =3D get_cpu_ptr(dev->net->tstats);
> > +	u64_stats_update_begin(&stats64->syncp);
> >  	u64_stats_inc(&stats64->rx_packets);
> >  	u64_stats_add(&stats64->rx_bytes, skb->len);
> > -	u64_stats_update_end_irqrestore(&stats64->syncp, flags);
> > +	u64_stats_update_end(&stats64->syncp);
> > +	put_cpu_ptr(dev->net->tstats); =20
>=20
> [Severity: High]
>=20
> Does dropping the _irqsave seqcount helpers here re-open the problem that
> commit 2695578b896a ("net: usbnet: fix potential deadlock on 32bit hosts")
> closed?

Looks that way.
I think you need the following sequence:
	local_irq_save(flags);
	stats64 =3D this_cpu_ptr(...)
	u64_stats_update_begin(...)
	...
	u64_stats_update_end(...);
	local_irq_restore(flags);

David


>=20
> The reported splat is about the per-CPU pointer being taken outside of a
> preempt-disabled section, which get_cpu_ptr() addresses.  But get_cpu_ptr=
()
> only disables preemption:
>=20
>   include/linux/percpu-defs.h
>   #define get_cpu_ptr(var)						\
>   ({									\
> 	preempt_disable();						\
> 	this_cpu_ptr(var);						\
>   })
>=20
> so nothing masks interrupts across the seqcount write section anymore.
>=20
> usbnet_skb_return() runs from usbnet_bh_work()->rx_process() (and from
> usbnet_resume_rx() in BH-disabled process context), i.e. with hardirqs
> enabled.  tx_complete() below is the urb->complete callback, and for host
> controllers that do not set HCD_BH it is invoked straight from the
> controller's hardirq handler:
>=20
>   drivers/usb/core/hcd.c:usb_hcd_giveback_urb() {
> 	if (!hcd_giveback_urb_in_bh(hcd) && !is_root_hub(urb->dev)) {
> 		__usb_hcd_giveback_urb(urb);
> 		return;
> 	}
>   }
>=20
>   drivers/usb/core/hcd.c:__usb_hcd_giveback_urb() {
> 	kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
> 	urb->complete(urb);
> 	kcov_remote_stop_softirq();
>   }
>=20
> There is no local_irq_save() around urb->complete().  In-tree only
> ehci-hcd, xhci and dwc2 set HCD_BH, so on OHCI/UHCI/musb/max3421/sl811 and
> friends tx_complete() is a hardirq-context writer.
>=20
> Both sites write the same object, since struct pcpu_sw_netstats has a
> single u64_stats_sync shared by the rx and tx counters:
>=20
>   include/linux/netdevice.h
>   struct pcpu_sw_netstats {
> 	u64_stats_t		rx_packets;
> 	u64_stats_t		rx_bytes;
> 	u64_stats_t		tx_packets;
> 	u64_stats_t		tx_bytes;
> 	struct u64_stats_sync   syncp;
>   };
>=20
> On 32-bit, where u64_stats_sync is a real seqcount, can the following
> nesting happen on one CPU?
>=20
>   usbnet_bh_work() -> rx_process() -> usbnet_skb_return()
>      u64_stats_update_begin()          /* seq odd, rx_bytes half written =
*/
>         <HCD hardirq>
>         usb_hcd_giveback_urb() -> __usb_hcd_giveback_urb() -> tx_complete=
()
>            u64_stats_update_begin()    /* seq even again */
>            u64_stats_update_end()      /* seq odd */
>      u64_stats_update_end()            /* seq even */
>=20
> A reader coming in via dev_get_tstats64()->dev_fetch_sw_netstats() (for
> example "ip -s link show") would then see an even sequence in the middle =
of
> the outer update and accept a torn 64-bit counter without
> u64_stats_fetch_retry() firing.  With lockdep on 32-bit, is this also the
> "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W}" report that 2695578b896a
> removed?
>=20
> This is the constraint documented in include/linux/u64_stats_sync.h:
>=20
>    * 3) Write side must use the _irqsave() variant if other writers, or a=
 reader,
>    *    can be invoked from an IRQ context. On 64bit systems this variant=
 does not
>    *    disable interrupts.
>=20
> Since the _irqsave variant compiles away on 64-bit, would it work to keep
> it and only change the pointer acquisition?
>=20
>   stats64 =3D get_cpu_ptr(dev->net->tstats);
>   flags =3D u64_stats_update_begin_irqsave(&stats64->syncp);
>   u64_stats_inc(&stats64->rx_packets);
>   u64_stats_add(&stats64->rx_bytes, skb->len);
>   u64_stats_update_end_irqrestore(&stats64->syncp, flags);
>   put_cpu_ptr(dev->net->tstats);
>=20
> The changelog only mentions the get_cpu_ptr()/put_cpu_ptr() conversion and
> says nothing about dropping the IRQ-safe helpers; could that be spelled o=
ut
> if the removal is intentional?
>=20
> > =20
> >  	netif_dbg(dev, rx_status, dev->net, "< rx, len %zu, type 0x%x\n",
> >  		  skb->len + sizeof(struct ethhdr), skb->protocol);
> > @@ -1298,13 +1299,14 @@ static void tx_complete(struct urb *urb)
> >  	struct usbnet		*dev =3D entry->dev;
> > =20
> >  	if (urb->status =3D=3D 0) {
> > -		struct pcpu_sw_netstats *stats64 =3D this_cpu_ptr(dev->net->tstats);
> > -		unsigned long flags;
> > +		struct pcpu_sw_netstats *stats64;
> > =20
> > -		flags =3D u64_stats_update_begin_irqsave(&stats64->syncp);
> > +		stats64 =3D get_cpu_ptr(dev->net->tstats);
> > +		u64_stats_update_begin(&stats64->syncp);
> >  		u64_stats_add(&stats64->tx_packets, entry->packets);
> >  		u64_stats_add(&stats64->tx_bytes, entry->length);
> > -		u64_stats_update_end_irqrestore(&stats64->syncp, flags);
> > +		u64_stats_update_end(&stats64->syncp);
> > +		put_cpu_ptr(dev->net->tstats);
> >  	} else { =20
>=20
> [ ... ]
>=20

