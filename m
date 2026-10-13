Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774DE53D9EA
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923911; cv=none; b=Fhs0uEawmfm6vbWqWjcIiQW1+SiVZaauKUhyW2YuMCi353EfP67f+lRxMpHF8iVudYS0TW4yrkLLNmAOSFpGN4eLS/SHx4bx3SK/ewFkh4WU7Hi5axOuWQNJ/25/l7ApxfIV6iZFOzJo6hJXq1O7om50UUlU7oH9hUwnBkQ/VMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923911; c=relaxed/simple;
	bh=31zs8sR/R/SmtXARin9KLj4k0/40iZWjwag/VVg2T3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij9GBKR/j7POXW/ponqvAMszoeOMnzeSqECh1wde4b5MCP2TtVlreM7RPLWZsjgobHjYqXrr4Tzt+aYoUZ4BkfIWG89qdOh/l2KsXgOYHnXfWRHIMyX1RblaA7dXw4n+slmiAPN14WV8Ujfe6nOqarmgZqsjJgrWKFVF+Ki3+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqcytlGg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHrVaRK3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqcytlGg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHrVaRK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791923909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1QlmvDXTmRUU9nYKkcaNrdZ6s9iHMpAA+451lF8KTl8=;
	b=LqcytlGgNmVZUdYVQWLdafcFApilMu3fsJDeGZ+wPaNRTl+e+anhMI4maDnKn692vS2oDz
	IThuOGJt9UTpsK2WvlbWQK/h3m5dC46RBKfY17sNpo7KzR2/bdvLjmcpDkArCHTj62gjxk
	tqUfwf8JOws+1jP7vWJQxt7JxZo/fCQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-qP4OleUrOMKDZ1j3l76JDA-1; Tue, 13 Oct 2026 20:38:28 +0000
X-MC-Unique: qP4OleUrOMKDZ1j3l76JDA-1
X-Mimecast-MFC-AGG-ID: qP4OleUrOMKDZ1j3l76JDA_1791923907
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso26094495e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791923907; x=1792528707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1QlmvDXTmRUU9nYKkcaNrdZ6s9iHMpAA+451lF8KTl8=;
        b=AHrVaRK3+24yZGmukKCTaVSJBZl2Xp3EVz1T0J9MXR0rLlJ3VGDZMrw0LensKtgJo2
         XPVf6PoWMBdGYPTOgvIf3pr3Zvw3XN3Ep8z4WlMU88+Bw43KG1wJZAgNpMWXJQgNqJ3k
         kkd8kAsi2+iA0MxOz0X+VuxR1S06mMqDPy6/4jZJPWYSlwtBcZ27cJ1q1iH/GFnV0w+F
         cGxl+by5cjZEXUQwCjXXE3Wt7gKOmWmxPPVfCJuc8GOQ2zHunDQeIBUZvkNtcI+n6h4o
         thB8VFzqahpia8U7A+f9EgtwAOSnO37cWrHEetXCCQM1LyvnvdPXwQzCoHgWzU/QU2nE
         FAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923907; x=1792528707;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1QlmvDXTmRUU9nYKkcaNrdZ6s9iHMpAA+451lF8KTl8=;
        b=d7jz38XInSJ8dmWKvQlTIhNxL/g2tmKucq/v7pX85m6o+qvFWfnmMGfG/2DoL+34vX
         xOErvZ0xXyANQESDaPeZl1pk5DHzp0AYzxcI51AdxNA33x2oGyNImN781k3JIDdaKixg
         uiY1kVglaYTgaw6iq7AtKpBMBB4xQuci7NxhPFeV8n3flSmgWfjSwjDokxVWYW0oabsb
         yPSijhrc86LMPhG4dvX2eTrD3SivczHjfDD1eka4+9S3QD3Gz5cZ7wx2MtIOme8zd7Wo
         td/5RF1NCiOC4m/W7hk6GqWEkW/2MNJpzr3jazbEmCI8MclVpNcP/puPu1JUk8wQaX0L
         Fiqg==
X-Forwarded-Encrypted: i=1; AKwUvBxspAqrZ3IBM26t6HPWQ2mKyqcc1u0DcludNtevHFo0a+MWPNiKS7EHxrn6QC85/bE6yjzauqg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPNAgG6U1H+wytREMItcKtl31WZpPW+EPR1TBhCIh7h6/5uME/
	jjJqc/3w2IbA+PusicovRAv+5T0TtrBrrB+dscWkfMhimFNM1i4spEHwIqQKd/CZsUqZsNjy5Hz
	Q2diXowSnrnFiIM4hjpMXX5zNeq877wP96t6qlU5cXd1254uSIvassY+Phw==
X-Gm-Gg: AYBFou305HXgbr1z2yGO5cTHfNe4ZK16vWx9sAzvJ+EX9GQu8oRNKMOTsQY1VLzGUs/
	4/E6keomzSE9kkBKvIZtL4YsCG+X0IfMLSLe3hSZRYmhtlwinoKJeEUDthYXQNAfjhlB5hjik7M
	dnlTIqJrXwHVnuw1J3l+1bI6tpFecfLHsNLX/h/FEU3qWgUuPBBkHXNVfT5Kp4v7ZnZXotl3hE1
	kgbYyHAWNAUCLIUpQ9Nv/5FMiq4Xu+iunrwyjXw/VHzAtRwEDokbXSXeMdUewb6egiDFKgET7UK
	krnsVD/5snmJ758ezkns9NOMZrzug1m3IGPK6xTj2dQCjKMo6sXY2bZklBAUcjsNY6DuiA==
X-Received: by 2002:a05:600c:58d3:b0:4a1:9388:7f40 with SMTP id 5b1f17b1804b1-4a193888295mr163023985e9.4.1791923906936;
        Tue, 13 Oct 2026 13:38:26 -0700 (PDT)
X-Received: by 2002:a05:600c:58d3:b0:4a1:9388:7f40 with SMTP id 5b1f17b1804b1-4a193888295mr163023725e9.4.1791923906449;
        Tue, 13 Oct 2026 13:38:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4edfsm7923045f8f.26.2026.10.13.13.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:38:24 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:38:21 -0400
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
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261013163706-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
 <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
 <20261013070549-mutt-send-email-mst@kernel.org>
 <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
 <20261013143335-mutt-send-email-mst@kernel.org>
 <CAF=yD-Lz92nGVFab1Dq8M9VusDsKf-ioda8KrZoyh28x3Xtg4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=yD-Lz92nGVFab1Dq8M9VusDsKf-ioda8KrZoyh28x3Xtg4Q@mail.gmail.com>

On Tue, Oct 13, 2026 at 02:32:26PM -0600, Willem de Bruijn wrote:
> > > > > +
> > > > > +     if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > > > +                                            inner_proto))
> > > > > +             return 0;
> > > > > +
> > > > > +     if (skb_is_gso(skb))
> > > > > +             return -EINVAL;
> > >
> > > This is a risk the commit message will have to call out.
> >
> > I tried with this:
> >
> >         > > > We can't easily "complete the checksum" for GSO we don't recognize - GSO
> >         > > > assumes knowledge of the protocol. We could segment ignoring the
> >         > > > checksum then do whatever csum_start and csum_offset say, but that
> >         > > > seems like an overkill for something that should happen.
> >
> > I guess I can add a more detailed explanation about what the risk is?
> 
> Let's just explicitly mention the consequence: non-standard GSO
> packets that previous would be sent may now fail.
> 
> >
> > > I don't see a simple way around it. We discussed segmenting here too,
> > > but that requires intrusive changes to all callers too.
> > > Alternatively,
> > >
> > > 1. call segmentation, but only to see it remove the SKB_GSO_DODGY and
> > > thus verify that the TSO/USO packet is valid. Still drop otherwise.
> > > This also does not add overhead, because it would be called later
> > > anyway.
> > >
> > > 2. a failsafe off-by-default sysctl + static_branch that skips the
> > > drop when set. Messy, but so is the situation we're dealing with.
> >
> > Tack this on top or do you feel it's needed straight away.
> 
> Not urgent. Can even wait until a report appears. But worth taking a
> look sooner if either of us gets around to it.

Maybe if people intend all this for stable, I'll feel safer with this in
there.

Just to make sure, the branch would just short-circuit all checks, yes?

-- 
MST

