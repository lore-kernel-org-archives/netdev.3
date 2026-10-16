Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EA6421A07
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144047; cv=none; b=F4DKFzAMu8WpbUmePNfs2R8Eum22UNKEhZMh5ckkzdFsyb72iwjTQUzx74fc1jRu/HtDEVRPF0R+ru2qN4Yq+YgCsmqku8bHdq965r9XWz2NKy1YVhhqz41yBclMXqHYJTVqfOMbifU0eA+yH4mG5bYvuBUe5P7M5a/HcYV8X10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144047; c=relaxed/simple;
	bh=/6bOhgavwLkfu7osE233gpBu5fCr5YepuuO9BGSvMqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrHT8/aDLr46C9Tu0S0WmL5g3fIjmTcFLZqepRG4Xo3J7oHq+STdLbmvVzESbd5xwb7I3egZmExehJmbe51tuknmldgHZqDkH3WXhW0AMis6/LIwnLaDA2thm3jgtIAMfiB1qqHKCwh+ul1WPe0ibNFH8wNDcc1ONA2Tw8IX7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLJguYNV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYpA+yMa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLJguYNV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYpA+yMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792144044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbR14oJGPzfB2FN3IihSMtrRfZxHPOZ8SpBePeCP3+Q=;
	b=LLJguYNV0QOMOfRRPdJtyj6zslbI5Bwb1pFFt5qx942i/QphEMqtbG3nnHJi5RrE6+TxR8
	mVg0ICtf2U+7O9soqjhg+2/NFD4/gW4MfoCUg9Xlm4Wp1uTNo1bT+Imt8mvqiFiYBnNtHc
	PTkZZHZyflSQpVYWAYN7sAQskjUBaNo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-w6ZL07jZNaaE0yvkxxzpOw-1; Fri, 16 Oct 2026 09:47:23 +0000
X-MC-Unique: w6ZL07jZNaaE0yvkxxzpOw-1
X-Mimecast-MFC-AGG-ID: w6ZL07jZNaaE0yvkxxzpOw_1792144042
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1b11e7837so31658535e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792144042; x=1792748842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tbR14oJGPzfB2FN3IihSMtrRfZxHPOZ8SpBePeCP3+Q=;
        b=PYpA+yMaY0zjApl+C0gkRZ+mOR6fSqZ+7HFs9dYmeFDvWffhZD9G0JmCevu3UwByXF
         sfFnq8FEVL/A9TNpz6Qx/IWNNGYJa2uktUtiqFZl+4KvuOsc4wQNep3V7o4fC4aXOaVG
         JzpTZCDpUi7WgaRiiqfpsZd61H5NcO7kcdZjAKgEh3Ip2vm5LeFuAM8j8AcLowP/4Bps
         bXQBsICdxQTA2eTUErNH/VyNPvVQKv+c4dqXwUmsZ/15q3Dl9NCbD+NhB3iJRMc3vL78
         bkEAiThapeK+neC91FYLuZOBMIo+1LbZFMpxIbXYq0sLEJLdllek1nTRYR3AO9RD+BaS
         y+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144042; x=1792748842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tbR14oJGPzfB2FN3IihSMtrRfZxHPOZ8SpBePeCP3+Q=;
        b=dryfbzSy+oiNdezNHv0L5KiESKXdzRpLIhSomINLmhp6NW0iFNVZiqB2KsrfyB/tw4
         R+0Bxt7iovaH6qlUINUV8kt/7ZKf2DXrfOeZRO6OrYV6DdkIE3epKbJcGmHNdVSjnfrf
         oyqffU723b+q5PAluxUICCz8haBbYqtatsEygIFpVpCzVPa0LMuF/XcPbw8IB2sQWm+S
         Qbke3K9qfvuUQW45NATrlsOCPWOrVRi0Yl0eMsZCWWCJ28mQI4UYdlrgaG8F/CwHEINs
         trUkzwpqJ38vasc3CKgvFtRterNCPYdCyUnV7ZBDX/67SYotDrz8u3dl8YKf68hxT/kh
         iehg==
X-Forwarded-Encrypted: i=1; AKwUvBypFDECQtuUizPLcpiW0bp+2IwX7AmR0xnLWJGqKLAAZdsT5V4tOs7wbSCNXZk6mW3rbgoNNfc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU0VPsCFXYnfNxJrdp4TnFc8ITud+3RXZu3gBhMVdaOLzClpp6
	Qp/pmazanqZarsD1gKWZujlhA3MJrfs+k2d6KRzcocvzXEpYHwFUIVsLVPR25qcMBB6pTtsVvjx
	U+30HPJMDePGY7b4PXkG7RqHqLqfU7w4lU0pc14NOjKqaGXi0u1JKKfO5Yw==
X-Gm-Gg: AYBFou0QlTwU+RT1EydfaA16nTzzeL4x0WIl7WgXYK5yuxygJ286nRuGNAordExmYu8
	wkG7zBxA1KoovS+DQtHlGCG4KiapQkaV1WglcOVENKsHyd1kZw/z2J/kXOukKeI2Yf36R1oPPmN
	aWAMs91pfqBH3CLmxIESjRb4+JtZmgOBBKXPRRbz5my/LoVWIzE6t5MuMRtl08Xy8cg+uC9PSMf
	hIkWM0xx54dHwcneW93AAZCqIiOPq1cZCdPhKpTCkIPYR0tTD7nfSRnTftj1uTYPJD4chyyl1QG
	hQH/A0ivI0SboL6k3+13fzUx9kt966PRavbaZxP9BmuKMM6qtpmW0/vKZjarcphdXqngLA==
X-Received: by 2002:a05:600d:82ea:b0:4a1:cedc:ab49 with SMTP id 5b1f17b1804b1-4a1cedcacd6mr26955455e9.31.1792144042081;
        Fri, 16 Oct 2026 02:47:22 -0700 (PDT)
X-Received: by 2002:a05:600d:82ea:b0:4a1:cedc:ab49 with SMTP id 5b1f17b1804b1-4a1cedcacd6mr26955045e9.31.1792144041692;
        Fri, 16 Oct 2026 02:47:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8d12sm4029612f8f.36.2026.10.16.02.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:47:21 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:47:16 -0400
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
Message-ID: <20261016054558-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
 <20261015085119-mutt-send-email-mst@kernel.org>
 <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
 <20261016054142-mutt-send-email-mst@kernel.org>
 <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18ba10ec7aa6659ee4711f8dd3f3138e314e4af6.camel@sipsolutions.net>

On Fri, Oct 16, 2026 at 11:44:16AM +0200, Johannes Berg wrote:
> On Fri, 2026-10-16 at 05:43 -0400, Michael S. Tsirkin wrote:
> > 
> > > > > > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > > > > > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > > > > > +			virtio_legacy_is_little_endian()) < 0)
> > > > > > +		return -1;
> > > > > >  	return 0;
> > > > > > 
> > > > > 
> > > > > Seems it'd be simpler to just
> > > > > 
> > > > > 	return virtio_net_hdr_to_skb(...);
> > > > > 
> > > > > As far as I can tell, the function only returns -EINVAL or 0 (never a
> > > > > positive value), and the caller only cares about negative (error) or
> > > > > positive (no checksum needed), so that'd be equivalent?
> > > > > 
> > > > > johannes
> > > > 
> > > > if raw_verify_header can safely return any errno - i did not want to
> > > > audit it.
> > > 
> > > You already used an LLM and still didn't want to? ;-)
> > > 
> > > I checked briefly (by hand) and it seems fine, it's assigned to the
> > > function pointer, which only has two callers on the _kern.c side.
> > > 
> > > johannes
> > 
> > 
> >                                header_check = vp->verify_header(
> >                                         mmsg_vector->msg_hdr.msg_iov->iov_base,
> >                                         skb,
> >                                         vp
> >                                 );
> >                                 if (header_check < 0) {
> >                                 /* Overlay header failed to verify - discard.
> >                                  * We can actually keep this skb and reuse it,
> >                                  * but that will make the prep logic too
> >                                  * complex.
> >                                  */
> >                                         dev_kfree_skb_irq(skb);
> >                                         vp->estats.rx_encaps_errors++;
> >                                         (*skbuff_vector) = NULL;
> >                                         mmsg_vector++;
> >                                         skbuff_vector++;
> >                                         continue;
> >                                 }
> >                                 if (header_check > 0) {
> >                                         vp->estats.rx_csum_offload_good++;
> >                                         skb->ip_summed = CHECKSUM_UNNECESSARY;
> >                                 }
> > 
> > 
> > 
> > so any negative is fine, but if we return 1 then it will force to CHECKSUM_UNNECESSARY
> > which I am not sure is what was intended?
> > 
> Right, but virtio_net_hdr_to_skb() cannot return 1, only 0 on success
> and -ERROR on failure?
> 
> johannes

After this patchset, it can, to signal slow path software checksum.
I'm changing callers first so that changing the function itself
does not break bisect. I should mention this in the commit log.

-- 
MST

