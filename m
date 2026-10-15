Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CD4522693
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068732; cv=none; b=L2WAvkVvbeloMhLQuXl9fk09Sh6f8NwHF2dj/hIAw3mUQQYGRlS70/Iyk7beaAZYaJk/mUrR7/JYkcYYh7Q11DUsATIVx/XR9dx2NQCpFMRUtAn8eBQyyqxcF9vrKounx2R2v1KGPwz0mxLuRem+3QNlHTu15CU3zdiFtLrIiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068732; c=relaxed/simple;
	bh=Vqs2r6yrFjKU91M2JbFSTZKNGVccvtHOSjGLjryQhTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6rYkbE98L0c7ijLUS3CWj8kifQDPrGU1vQ3xeCRUu5UxOzEALKHKF2CqEKXmOJ9sl1yC7Ia5Zxax93bfc7MA1H2anze22yxs2cVMu6B3T2f/93tuCFY/Ujb4GDv9OwnVbTtEecV9KOpuwW07XRoIrH6tXt50gcdc8D9T8trvuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByzE9tDl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ynd5bVtD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByzE9tDl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ynd5bVtD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcpnk+xBeaA1jme1SdTW5ccMBBDrq+w8aENCxtFQmP0=;
	b=ByzE9tDlhZuR7BUm/yMYbFh6PnZfxcQD02n4Ol/2e7zNKnLrlU3LoIrvXv9nDdljK4P83L
	ssbc3as+3Ihd3zVr/xC4G4sYDTfXdU1l+QYDNKqzz0M0HIaWJ7kW8jVC935rs8YG55EVhI
	cUbzHYbP4QNOyXkLP5Eu5j8ZU2+P3pU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-kVhpwjNKPrqlwplZSMYbXA-1; Thu, 15 Oct 2026 12:52:07 +0000
X-MC-Unique: kVhpwjNKPrqlwplZSMYbXA-1
X-Mimecast-MFC-AGG-ID: kVhpwjNKPrqlwplZSMYbXA_1792068726
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dfaaea30cso11690f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792068726; x=1792673526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wcpnk+xBeaA1jme1SdTW5ccMBBDrq+w8aENCxtFQmP0=;
        b=Ynd5bVtDVfvYsl85STueeMMSH4C6BauLrOpiH/iHyycH2KpTyhHopr92DaKS0VZ2Zy
         80BUALQxHiOhfvHZnmT+MzTnWxtl443K46fEzi+2RcmUulqD2q7g6ZFhT4EsFDnWJAzf
         SDg3PkUucl4tvew0paA7F4f9s7+CD/w4EzYKg1fXjTwxNZynrWJGHhBQc8H5bCSO29jH
         IRAHjbcNPzAGe9t2k6d0v+LOt/YSsuTA80bKjmeWzNQrk+5GAWnLn4+C3JMyp/UDz9oO
         nsKgPAB32y8l8wfebv297oN08AfLq1VgaNl5vTgNAC5yOUIIHB3pf6+W0256fo+699ev
         ZTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068726; x=1792673526;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wcpnk+xBeaA1jme1SdTW5ccMBBDrq+w8aENCxtFQmP0=;
        b=BYPf51LpSEjkNgyczrgtEyJUSD19hb3p+6iZ2Ku14Q3yKWL1SKa4/YHTNmS5Gfasn8
         PmWFYv+7G4x2qIMd/ZelrGt+sioA04qgSDpo3jHL/7zI1V6UbyvF+0kRaUhPi2wIGy8a
         3ya/wqBYq9/e7K0J5PEMuWg+JW/BpPs9hZGfh/d/HqYUJbkF9jtbF1ZouWW3p9foF4Ib
         R5pugrWK/XmcyJfzbmt1QxSMO6x5iTul2QSclRUsaihi6/xstRYUD3LYV3nirUWuAXWr
         iE7/um71cvtwQCJ4+rCNdumpOo1t9oe0GVK/fJ2H2sg7GXAu9+iCfavUAXn9vgKH4RjA
         V7Ag==
X-Forwarded-Encrypted: i=1; AKwUvBwBUD3D/hrLyVUW1LsyDdjnCHCgRCEFozZqlKEqfFRP/Ybgqo4a355ZX0JTSWSdtZ43DeK93Xc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ84/oRKxNWd/33VDYJwpThUFgPSWm71JN0ZXAxuIWk8kpGiGSR
	Tl6PJkEhz/cTHmKbH9uAHyviVro0/QD7aokbsk+bTjDUG1TAgi5pwslqWs75KBBjKVT/mSrOi3T
	LKGxBFqRqJL+nLP9i9cATCaiIXwW1/XWTqAU79/JwgZeyIBOTVb2UmCvjyg==
X-Gm-Gg: AYBFou2RxeMML5zSVc013jAUZIKyMguRGUToQz27OYQpk4uUp+NtmSxR7KCQu/AycjK
	yx9OkCqgoOx0yEpJ/BONWeiC6v0VDXLDBrKnpt3V8bULKhwCuWUNs/nkgwjMTvSFhepmygVYnLX
	j0OAajoY+mCUNXWRLlYPFwUs09/t8gQNlXthSbMuj6WNIUuc2L3XQkualA5o8Fl+p7xfLjkBR0z
	mKHdnCxUsjxcJYylfzro19vyZnhxn/3AJJUg4N4TE9rUmlZ3KkeUBMqzLAkKzkx0xy94lR0BuB7
	pdX+2IeWm3UiVADV1UZTbT8+WytT3Cjsq6AzAryDU2zyoHgcMmmYQRY4VO4IxFzbxUYGHg==
X-Received: by 2002:a05:6000:25f2:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-48dbacdc419mr37642976f8f.36.1792068726349;
        Thu, 15 Oct 2026 05:52:06 -0700 (PDT)
X-Received: by 2002:a05:6000:25f2:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-48dbacdc419mr37642912f8f.36.1792068725766;
        Thu, 15 Oct 2026 05:52:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa9f9sm18793273f8f.19.2026.10.15.05.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:52:04 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:52:01 -0400
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
Message-ID: <20261015085119-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>

On Thu, Oct 15, 2026 at 02:47:01PM +0200, Johannes Berg wrote:
> On Thu, 2026-10-15 at 08:41 -0400, Michael S. Tsirkin wrote:
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
> >  	return 0;
> > 
> 
> Seems it'd be simpler to just
> 
> 	return virtio_net_hdr_to_skb(...);
> 
> As far as I can tell, the function only returns -EINVAL or 0 (never a
> positive value), and the caller only cares about negative (error) or
> positive (no checksum needed), so that'd be equivalent?
> 
> johannes

if raw_verify_header can safely return any errno - i did not want to
audit it.

-- 
MST

