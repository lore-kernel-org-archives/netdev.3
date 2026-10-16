Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56119B3CB
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143648; cv=none; b=DH5rQ3qMcPAPkopKOzez+hNdTggStkgA2tbaugogjY6hWPSN4iX0PjnSjnCM8ry55jpe60e1xtIh/63R5DBECjYVyiM+/l0eOmjO4tOKSXtZUz1y0oALYlmYrDsDXBCDYWMzL6evd3iiiXeREQS/PDWHUCgKj5YHuXQ36yKioQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143648; c=relaxed/simple;
	bh=IKOHADwHNZP3jA6qSOzuBaSk53iOphiCQ+dLK5PVi2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWiiD3nHxLdH8lqj+oo3WUQuikR1ECq8v03hCtvucynWFGAFvFl6vSCegqL6yoXqwjPZxG7+cSZves2GtwXhbQhSpc1daPtbytzG2coQGjZeda8qJCALXdwuwprmPB+Kz1jJl1CiBGnSndRb/dGxCl/msfOeJ/Xa55FR5wUgL+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQFaKQjp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZDzX18i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQFaKQjp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZDzX18i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792143646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UvLeihu7ioIdym0eRq5JcGIMM6YkZ/1Kjyy9X0VEuuI=;
	b=EQFaKQjp2JExAMfWZ1XZWNa8YlxA5GgG2caacgr8rh5OjrE1ZC1/Fc2Z/wgAjz+rGE9644
	W5PNg4FWIJDiGjdro1x72PXAisVK+kMNin2qBoMnidMuXu7NNZ2feEZfQYLlgr7WHjYQpD
	VGSTxf/GNwHpSCXOESjm5fz0TxbxrEo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-i_Q6isfGMmyob5vBMQOdCQ-1; Fri, 16 Oct 2026 09:40:44 +0000
X-MC-Unique: i_Q6isfGMmyob5vBMQOdCQ-1
X-Mimecast-MFC-AGG-ID: i_Q6isfGMmyob5vBMQOdCQ_1792143644
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dee35b50aso2177712f8f.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792143643; x=1792748443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UvLeihu7ioIdym0eRq5JcGIMM6YkZ/1Kjyy9X0VEuuI=;
        b=CZDzX18ib20xEPl00AX2zbc9/rrfIDa0YZCg+PsnWqjE0yxAm/EjfHErgSy0mDsndO
         d4d1WNSzWEaBiWds8VDwJpXqHzdTLjQBMZ28ZvLoypIsQ6SwXYoSz55dalngNOqrSsBw
         P8BhB1lvtA+Z5ioJlZJ+i44TaBpmuEjfqKBYokh1Xv2rw5MdH4gX4DuiOcBEb4zqN6MT
         24+5UNw4bPmVqutKAAuqxDz06UA6meGZEd/uW7dlDI1rNPRI5ZxY08o7hKtunVm7n4T3
         iQ7ohKCBWGHCjtY0fKSWawuAV+x2p7g6Vbpu0Km/RlTMiQ3Ip3ixLTNUOwwgcuKTPfEY
         1JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143643; x=1792748443;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UvLeihu7ioIdym0eRq5JcGIMM6YkZ/1Kjyy9X0VEuuI=;
        b=UYaRvwsMALeqoBY8BtTWiYDPgFUsMu91OwisbKFbsI55lNQ2qV6lDK5xcA3yzOhB7I
         OSz3N9UEIhVhP01Yy71TQ2BMVQB5jNuOk0S+EgIF+YHARfxqW3T492CB0EENgE7OpRKD
         TbbJ6qgSr6bAGNcwDLU/Q2+a9Q/lAXsa6WU0kA0Cauz0ZaRP0el5qpxfEd5fF+/Z6Ctk
         2SLFxSqPYieveRo+ZgeIVv33k/8clN8TqQde+hraTneMy2L7NPb0zQKHTgNdZWfrlMRj
         9Sqk76JNHTOx8Mk00/juYK0APJJ1/tC9fUDMTlZP+s2yRbYOt5Mvw4pcEZe1bR8uCbfQ
         RL2A==
X-Forwarded-Encrypted: i=1; AKwUvBwxRId7w0xwdJNgHLdTSRfnANQz16+SPHEzrlx/kTtPyaHfwCByLwUe/1gb0LvRfFno73rufos=@vger.kernel.org
X-Gm-Message-State: AFq9FYImGQAPeLEWjE8amrGORlhOJ1CG/6SthiTyJXj1W1nZZCukDDYz
	PxFKet0PzAE2J+ZxJKaUW3UAmj7GntHM124U6b/aGp7dJmhb3ATrne+TzLImISGxw2yZSlWQrht
	mPUudp0xCByFZ/F8/WOuDPhYQSwiAo/PfQVF4eR/Fo7VMCply7/Tcs1sj8A==
X-Gm-Gg: AYBFou2iZpgo88hmrap+pKN1px+eurckPPrSsFSZQ8KeqRcWoGhOhkroia1QxO0Qb8n
	HsA6P5i7I58Ir16xYBTarcaKIYqWobZdXKjqAwfCArBIaRc/Vc2D4rPQ4Htr5GlcKs7M/OuBf2j
	DqgEuGU4Q+BdcIUrSf1Ra5t6OeC0JyHCNZUplmqW3lDwlnWV1c88kJ0biLeIklIuvv+1C6LqmIX
	mdHshUEtuqEG+hZltPuQvt0juaj+fZqNKi8GeAVN/nKsxMFuB2FLe+dmkx9xblO7rm9L6BIgsNm
	4SRxQxETnoit//+g6+iGuqdaUvHH/vBZJpPYCQ3qXvN5vQEj21KP8h7NkfQSupE/wAzyug==
X-Received: by 2002:a05:6000:2212:b0:488:84ba:ae2e with SMTP id ffacd0b85a97d-48dba6f54ccmr42368072f8f.0.1792143643379;
        Fri, 16 Oct 2026 02:40:43 -0700 (PDT)
X-Received: by 2002:a05:6000:2212:b0:488:84ba:ae2e with SMTP id ffacd0b85a97d-48dba6f54ccmr42368022f8f.0.1792143642782;
        Fri, 16 Oct 2026 02:40:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a64sm4255797f8f.6.2026.10.16.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:40:42 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:40:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Message-ID: <20261016053930-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.10294d16149b7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.10294d16149b7@gmail.com>

On Thu, Oct 15, 2026 at 01:19:22PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> > it cannot make sense of, but the vector raw transport ignored
> > its return value: rejected packets went on into the stack with
> > their metadata unvalidated.
> > 
> > Propagate the failure.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  arch/um/drivers/vector_transports.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> > index e1fb2a76fdff..8b7548458663 100644
> > --- a/arch/um/drivers/vector_transports.c
> > +++ b/arch/um/drivers/vector_transports.c
> > @@ -210,7 +210,9 @@ static int raw_verify_header(
> >  		return 1;
> >  
> >  	skb_set_network_header(skb, ETH_HLEN);
> > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > +			virtio_legacy_is_little_endian()) < 0)
> > +		return -1;
> 
> Should this return 1, like the above?
> 
> Not sure whether the verify_header return value is well defined beyond
> just boolean.

                                header_check = vp->verify_header(
                                        vp->header_rxbuffer, skb, vp);

                              if (header_check < 0) {
                                        dev_kfree_skb_irq(skb);
                                        vp->dev->stats.rx_dropped++;
                                        vp->estats.rx_encaps_errors++;
                                        return 0;
                                }
                                if (header_check > 0) {
                                        vp->estats.rx_csum_offload_good++;
                                        skb->ip_summed = CHECKSUM_UNNECESSARY;
                                }


apparently? maybe i misunderstand.

-- 
MST

