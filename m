Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84293BE162
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143796; cv=none; b=sYW/lGDru1Bv+B7nHNJBeLh6vy1/QBC28HYZxLVrJdRmYhbgtch8CYjv04VJy4NIXwAabboTNfP87H+9xc5q02oc8Schfb0RPwTfAIUBQPvRz7omPenQhoEivX+kyKmQBQpNjuego18kqq+P05jR1pcJYWlFCxXdhGVrs5ewCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143796; c=relaxed/simple;
	bh=wNZ412Ae3m8jBXHfRGmC8hQuWMi22RyrCtR8KESTa9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpbiC6rLQZhWyiH5fgAcz6WQuIoXsgTOyhbKH8swZKuXtM4/NGfk12SA60MZ3XzKfFI7vgE7AnEu+oDzGkkpsyxZdVysRutGwrj2qPAyFMUC4P4IgJbcHh57S6dQ9tRjLrLctwETyt4XsdC6z5C6Qkpxjwg8YkUTNdf2feSBT8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITGRvE4o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rK1a8Mgg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITGRvE4o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rK1a8Mgg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792143793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GSsULpZ3pzORBRFAex1hz9lIvJDrQuTo9GJjL73TxMQ=;
	b=ITGRvE4oUiBAQFl660cMWj4/GzXPJSPLXhho6Jd+M1sBhvZ/LGFDGYuphrQMlNDhQQKAyc
	clKbw6gZNrhImOEPGGtnSSTk1t3se/etUEOi/eaxhArMYF+DAAsaBD9DtyAusSV0Od3S7E
	dYav2hjkm+PvBe73ncil4h2G7MjFkjo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-pCOt9xK7N_293gjSi5d5eg-1; Fri, 16 Oct 2026 09:43:12 +0000
X-MC-Unique: pCOt9xK7N_293gjSi5d5eg-1
X-Mimecast-MFC-AGG-ID: pCOt9xK7N_293gjSi5d5eg_1792143791
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a16fefb7acso47883055e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792143791; x=1792748591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GSsULpZ3pzORBRFAex1hz9lIvJDrQuTo9GJjL73TxMQ=;
        b=rK1a8MgghtNewRlm0NAHOdDFaA/miMIXIX0n4Z/YQyWJ3zv3b2/AJbqT+u67rPDXlG
         LyT1nCYZ+9XbjtgRGaZNXfi15Jp+m8BFYFsp2mobDQb9XIO248ja+X35XvIZCm3af4Bt
         F5XwYf6XnuCRoV3YFlosxIKeqxzE+cm6Mf06S1UBN6FW4gGwSc06K56x1wczhbNkZAgb
         nIXndl3wufQoN795A88IbkaX+VKPctOCSZF82Jb/+ZkUt3mYNyAesR+aNQJ0sHjyQ9Ku
         /+0k+OFFaWFGsb9DJ3UhWDZ87AozK2WQanPPHpu0WZ8H6CLP5Gw8HKMl4E+Zt0UhVjnX
         jZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143791; x=1792748591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GSsULpZ3pzORBRFAex1hz9lIvJDrQuTo9GJjL73TxMQ=;
        b=ntqlDGuBUGXjmMIkJ7D/3MvOWwujvz4QYJji79AVB26juNO8VoJYzMKGJvcqa0GHMI
         Rg9soxxHKTJJZZBqCf/Uc0sPA7VXw9Rv/27F3DYpMBXkbumker6wTrUtIkeZL4zlzj6z
         05SsqvJPHBj5xPqW1Yg8tmqeCxV8bVUjJV8Ev+bV8EPWot/ct2ER+mavhw3dNLXbzCQ8
         IGUgDfkfiCi9VsOn0BejHEqxZZTLVINOw+CA6kJu2YLUtMwpVx2RaAyvnAlk2veccda8
         oJ/iVoqJcgHsmLVjFqqnVpk27Kpq8UbEXywxTf6JLmgzhr1IYUUwGI92/eh8UmT3B1Q+
         WFGQ==
X-Forwarded-Encrypted: i=1; AKwUvByYf0Vu6bcs0lam9nmZZf83OMhAY9B+bC1Cf/Io4gGw09WHqiW36LQNQrqFuwktMtKIUQk/9TY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqy/JslB+1GpwJ6jw36cNpBPBB7uWTM+i9YDp7C1KvkHzuKAk0
	18zy3UYU2Jtx80pXjih0csteWL2iZfgjkRoRwImGUXQrCm+lABU3x1J/tjt0TUPJ+y55OJ3VS4h
	zWNz7hTubpfb3a25aYIejKQ7Vru4I0dumxDppUN+9BznYKqiwYdBJ/oCfKQ==
X-Gm-Gg: AYBFou3uxLbL/DVx2IcSDSkTB4ABb9k2RJaj1UDtqLN/aZCfpQZ35LDf3g5JbRtGeF9
	+R5klSpvbkXd8Wrb7I3nzVUHO8BQPr4gZ/jR5rfRQsBPI6tIuQ6jBew6zEb04teMZ7u6i3g78cS
	KAvh6NfMxp1r9YFP5LmF0n7KWTnDWacbYJvstk0Dmv+euDzr8Ndpb7xxk8wg2fs3WFsGL9DHU5n
	HSiMWiB2RZtXMDug7NiX6+i2+QrSRoUuc1Rti6qJduziP8PG0tl+iNrD4cZKlK++jW4ajos1oLK
	uGXL2cmZjms4bb9OCThGUX5EZ6FrHB/4gx1WglcM3HvePNadN2Q/Sekn+3OqrHgz1Q72oA==
X-Received: by 2002:a05:600c:6388:b0:4a1:6f78:8419 with SMTP id 5b1f17b1804b1-4a18e3ee8f9mr441048105e9.0.1792143791201;
        Fri, 16 Oct 2026 02:43:11 -0700 (PDT)
X-Received: by 2002:a05:600c:6388:b0:4a1:6f78:8419 with SMTP id 5b1f17b1804b1-4a18e3ee8f9mr441047565e9.0.1792143790656;
        Fri, 16 Oct 2026 02:43:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5957sm3899658f8f.9.2026.10.16.02.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:43:09 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:43:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
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
	linux-um@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Message-ID: <20261016054142-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
 <20261015085119-mutt-send-email-mst@kernel.org>
 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>

On Thu, Oct 15, 2026 at 02:55:23PM +0200, Johannes Berg wrote:
> On Thu, 2026-10-15 at 08:52 -0400, Michael S. Tsirkin wrote:
> > On Thu, Oct 15, 2026 at 02:47:01PM +0200, Johannes Berg wrote:
> > > On Thu, 2026-10-15 at 08:41 -0400, Michael S. Tsirkin wrote:
> > > > virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> > > > it cannot make sense of, but the vector raw transport ignored
> > > > its return value: rejected packets went on into the stack with
> > > > their metadata unvalidated.
> > > > 
> > > > Propagate the failure.
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  arch/um/drivers/vector_transports.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> > > > index e1fb2a76fdff..8b7548458663 100644
> > > > --- a/arch/um/drivers/vector_transports.c
> > > > +++ b/arch/um/drivers/vector_transports.c
> > > > @@ -210,7 +210,9 @@ static int raw_verify_header(
> > > >  		return 1;
> > > >  
> > > >  	skb_set_network_header(skb, ETH_HLEN);
> > > > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > > > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > > > +			virtio_legacy_is_little_endian()) < 0)
> > > > +		return -1;
> > > >  	return 0;
> > > > 
> > > 
> > > Seems it'd be simpler to just
> > > 
> > > 	return virtio_net_hdr_to_skb(...);
> > > 
> > > As far as I can tell, the function only returns -EINVAL or 0 (never a
> > > positive value), and the caller only cares about negative (error) or
> > > positive (no checksum needed), so that'd be equivalent?
> > > 
> > > johannes
> > 
> > if raw_verify_header can safely return any errno - i did not want to
> > audit it.
> 
> You already used an LLM and still didn't want to? ;-)
> 
> I checked briefly (by hand) and it seems fine, it's assigned to the
> function pointer, which only has two callers on the _kern.c side.
> 
> johannes


                               header_check = vp->verify_header(
                                        mmsg_vector->msg_hdr.msg_iov->iov_base,
                                        skb,
                                        vp
                                );
                                if (header_check < 0) {
                                /* Overlay header failed to verify - discard.
                                 * We can actually keep this skb and reuse it,
                                 * but that will make the prep logic too
                                 * complex.
                                 */
                                        dev_kfree_skb_irq(skb);
                                        vp->estats.rx_encaps_errors++;
                                        (*skbuff_vector) = NULL;
                                        mmsg_vector++;
                                        skbuff_vector++;
                                        continue;
                                }
                                if (header_check > 0) {
                                        vp->estats.rx_csum_offload_good++;
                                        skb->ip_summed = CHECKSUM_UNNECESSARY;
                                }



so any negative is fine, but if we return 1 then it will force to CHECKSUM_UNNECESSARY
which I am not sure is what was intended?


-- 
MST

