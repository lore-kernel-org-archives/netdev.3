Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538490;
	b=ieSKEvJyyZT2wE4u363XaudbXzn1gp9THszu504N9ViYBONfkZTtu5W1k/8ovEOV2oYL
	 YTyoY80uBYfYz+dfjKAoed3y6/c6AbgZ95+MTULBmCQyouOiGq2hdmhT+RoNFmkEmmxMs
	 z8I6ESP6wNASGHQgpZyj7CFsBoRM1hl3JDhHw4kNtGwAYGduArl4Hlu9u23FOMrnEvoN8
	 4lYQcLMXvMoLo1gFWKEOE8X8R3r5UNQh9JLQ63SSKxB7bLcoHWh/GIr9+sYeFAom92qMI
	 jXWu2Jrm4LSt6Jemn8QztgKmPLbnhkVDVOsmHU9LgQBnn4bAXNsZa7EM8Y97g2lTDjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538490;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YJVYnLvaEVwucHW+x0AHb90jt4BURilSyy87F4cjKH4=;
	b=bXG1h9cDHCqluhLnt+pzE3fsKxVL/bKqZl2JbdFKTOzJ/dT6ycaeVoL7dPoWpR+r/fZ5
	 680lS3MemNsGK7MsITqAuTo/zthAcCL3hsFQlRMvj7Ggi+fNN7pZBXZbTzrakqT4i3df7
	 8EOMncM2tzCVUIhMQvN355FJLWwOTtb8r7ShVgU4aLRhR9OD9CU3MReDEAzNvEpfwKefp
	 11/b7SRuqcX41fHfLnkMSbVP8jMmiy9bMvv3DRlPs9esTibkt5/SQ3GTMBStTTT7p+y/2
	 KiBHmKC4l5X0dffD0fHUzpLJvK2UhW767uohqJEqDvQhENIPvineyND5iUlh3+n8WKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SPy+1WhH;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pPN38QY+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE7606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CDE7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SPy+1WhH;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pPN38QY+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792538488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJVYnLvaEVwucHW+x0AHb90jt4BURilSyy87F4cjKH4=;
	b=SPy+1WhHri4mdCo0DVD/0prMQsg0YKg1bIKQuhQEVDVfotiW1BoW8unIC0L6g6dk5nMOWR
	33+q/JXF3cwR9sqczFqRlP29LpbzW8kcxmUxMpu7VfDkUyaAG7cCn2Tm2LCUf8IVXWCJgh
	0UQPCEaLQsaP8aVKYlDAAC1Jmdn6DcM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-MwmfriUjMSijJIEnkWxyBA-1; Tue, 20 Oct 2026 19:21:27 -0400
X-MC-Unique: MwmfriUjMSijJIEnkWxyBA-1
X-Mimecast-MFC-AGG-ID: MwmfriUjMSijJIEnkWxyBA_1792538486
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1e489f97fso968495e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792538486; x=1793143286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YJVYnLvaEVwucHW+x0AHb90jt4BURilSyy87F4cjKH4=;
        b=pPN38QY+Q/90GQrL3H/REBLoscFnRJ+2erzMdVFFYQ7fxPVp9i8heH/2YFBk09gPxP
         IrkZz09Yb4encLshue4vKPZYJX/ivb6RIOCn1cndpaYFDaBE1AotZoyb6h4oYiihQB9H
         7ROi6cV/N2uKKUzko2LIjqaqDcXKzo39vgkxWR7YOSM38pTJfqDxmEDvgKNMgIe7rmP2
         TvxNTKvhbGmNkd9lqOo5XnnJKkwXZ+CH6fd4BjRDmXMow9Xk2rcmbBnHmUSkdj1KEl2q
         x0OPglAyN8U+agkavMABQjhIPz0g/ANdyxzPbqzRMAMsCo6Y/C1e2Y9srFkCHn7x4USC
         p52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792538486; x=1793143286;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YJVYnLvaEVwucHW+x0AHb90jt4BURilSyy87F4cjKH4=;
        b=jFQht99UkAllBorCb2qGIvn2fxZz+kRZs68MxCN6G0p/z+AZPa3N1GXWrmdPDfrMFc
         FglUGwpaWi/GbcqMpDdydHB4UnzrNWuitZouk+cAyo9v7ESknJEHf02nd8kkFgm6lms8
         fWdSl0pTzEXNL/7DD7FTsPYqQFo1EsdBRJoTSPB4lnEBv+GK0hvGm7PVHl4QT+dqowPw
         Xr+NSuLSnmRf2gfyt+krHSFkMoJwbDNir31tYf/mj19vPkM9+SNBjHYEdngmnG7LPzG5
         z4VAeuf9OqZwGNfRhGaO9tul/vz7pFvPkI9tUcIHK7gpn9EjBVOi6Eqic54n7tZuvWwG
         qMBg==
X-Forwarded-Encrypted: i=1; AKwUvBw8GMIrKfiy4Dxo5b9GxtDUXRhUBb+GsF8Z4jmPGCk6QhFfTP7g8Kfg05HjioXeZvUfOosUUU0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMdysjG/kBbMsKuiAYwk/NTelF+blQNaPssWHrGUJOaQvmi6w3
	tq+UhLOC/mRKkIyPrwYJ9xRlGrH63X5cw8ba/vSwFoxrg8f/oVOkIkCn7x7XmePuVyu/Bt/Rk3Q
	zfP1RPP6V2+4Xz3GmnAWHdYH3JbPhnz4aG9yn2UYbA6BdVRd8rNpgV6/Yhw==
X-Gm-Gg: AYBFou0cme7cfFksJOdp6Ug93QJtoN++X0tdgq76BF2JENNr4fv7XxJiJTUpjaiEJhZ
	CmI4JtgVgLgSjq3GIChvmkYT7jodliWePJE/EfUI95Aq84ouhgfALkGrWztPEkiF2fdC3Yo5Hl7
	2nHXgtRLgVweJg1kJd0m49JnOwdvMRiBmatMStDw5z+ZIEo7qXlxBHxouf3GKwVmyZY8nPKIw5u
	LP3YTumzz+pdwKPhfhNvBhaYH2SYLeyih6KRGgaRoJIhQvb4RVf7v1NO/Jr7C8qNXJVlg6axGs8
	qg6cHSyFgjNt4KG0vn3rw9qjWEjqH3Aw9xRTBfyIZkioCgxefz7Xm4HWcjGl2Lr70m0EXw==
X-Received: by 2002:a05:600c:3548:b0:4a1:e774:370c with SMTP id 5b1f17b1804b1-4a1fdd145edmr3979775e9.30.1792538486062;
        Tue, 20 Oct 2026 16:21:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3548:b0:4a1:e774:370c with SMTP id 5b1f17b1804b1-4a1fdd145edmr3979245e9.30.1792538485547;
        Tue, 20 Oct 2026 16:21:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm12797555e9.4.2026.10.20.16.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:21:24 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:21:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Message-ID: <20261020192040-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
 <20261020155917-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.2c9decc16892@gmail.com>
 <20261020162048-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.2eabbddbe6528@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2eabbddbe6528@gmail.com>

On Tue, Oct 20, 2026 at 07:12:57PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Oct 20, 2026 at 04:19:41PM -0400, Willem de Bruijn wrote:
> > > Michael S. Tsirkin wrote:
> > > > On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> > > > > Michael S. Tsirkin wrote:
> > > > > > The ingress validation as implemented by the previous
> > > > > > patch is stricter than what it replaced: GSO
> > > > > > packets whose checksum metadata matches no transport header are
> > > > > > dropped, and non-GSO ones get their checksum completed in place.
> > > > > > Such packets used to pass with the metadata unvalidated,
> > > > > > and with no overhead.
> > > > > > 
> > > > > > I judge that this should not affect any deployments, but there is still
> > > > > > some risk that it does.  In case a deployment depends on them anyway,
> > > > > > provide a per-netns switch to get the old behavior back:
> > > > > > 
> > > > > > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > > > > > 
> > > > > > The default is validating.
> > > > > > 
> > > > > > Assisted-by: LLM
> > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > ---
> > > > > >  Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
> > > > > >  include/linux/virtio_net.h               | 23 +++++++++
> > > > > >  include/net/netns/core.h                 |  1 +
> > > > > >  net/core/dev.c                           |  6 +++
> > > > > >  net/core/net_namespace.c                 |  1 +
> > > > > >  net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
> > > > > >  6 files changed, 110 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > > > > index e586e17fc7a5..b1a1c4714b22 100644
> > > > > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > > > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > > > > @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > > > > >  Default: 1 (on)
> > > > > >  
> > > > > >  
> > > > > > +virtio_net_hdr_csum_check
> > > > > > +-------------------------
> > > > > 
> > > > > virtio_net_hdr_validate? In case we do have to add more validation
> > > > > later.
> > > > 
> > > > If you insist. My worry would be what if that validation is again
> > > > user-visible somehow and we need to distinguish users who want
> > > > to disable that future thing and users who want to disable
> > > > just this current thing.
> > > > 
> > > > Hard to predict the future. But I will go with your intuition.
> > > 
> > > Thanks, but definitely feel free to ignore my suggestions.
> > > 
> > > My intuition would be to define as
> > > 
> > > 0: off
> > > 1: everything one
> > > 2+: sadly needed fudge values because we keep having to tighten,
> > >     but some crazy workloads need to opt-out to avoid breakage.
> > 
> > yes you said i just do not get how it will work for userspace,
> > maybe u can explain?
> > 
> > and what specifically is needed right now, while we
> > just have 1.
> 
> Right now the sysctl is boolean.
> 
> If we define it as a narrow, very precisely defined sysctl, then its
> exact behavior is set in stone.
> 
> If we then add additional validation later, that can similarly have
> unintended breakage of weird users, we need to add another sysctl.
> 
> And if that validation is not entirely independent, i.e., builds on
> this, you get a weird set of interdependent sysctls.
> 
> While in general systems will run with all validation enabled, unless
> they do something weird that gets hit by validation.
> 
> A single broadly defined sysctl ("validate input at the source") can
> be refined over time, including to expand to validation of other
> virtio_net_hdr fields or protocol combinations.
> 
> Even if defining it more broadly we can still leave it a boolean:
> all validation on or off.
> 
> Or, optionally, we can also define additional validation levels,
> e.g, 0:off, 1:everything-on, 2:validate-csum-only.
> 
> 
> 

So I will just rename it to validate, we will see down the road
how it plays out?

-- 
MST

