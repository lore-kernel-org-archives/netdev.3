Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B794A36167B
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792360688; cv=none; b=YT1MyxAJdpco9QivXm+hDDME1mqCmKgM0GL1OGFa/PnLJPz8dFzIQdyKRYvINaMziB4CfByTg8YWj86FbnjmdhnHYqtlaUd1P0YlUUztnhhS/qRCnE46bOFbp2PvVQrtBfQ+xNYZ0jAD0OUW5VMN5PFkKB+nH92eP7inlgSYdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792360688; c=relaxed/simple;
	bh=zrU6pncxkNvGO8lsm0RmeCOS8yCv8qbs+XOEF524iU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD4eu6CGe9Ir3ewkZyzWlLqW1rkqOnaarTkreqL3simK08d1U0c0MVJ9mf2Lvq8eTLuwiHNNOKweykQIKKpHjtdi/ryLrsuhN3quyfd2YytJAkahTk/nK1trvqYfJyjAD/oOmKI+vFAuGP1aGuf/S4w8ULUQMfAZC1nt/fFOmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkRCrQ1B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bn5CuQgG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkRCrQ1B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn5CuQgG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792360685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SW7smKPvwjLXka19f8Byx3O0NkEWaQaf/H2rebSp6ws=;
	b=AkRCrQ1B9uMZ/ADimeSIcvu5u1c2MiYJg2dv0Tbqt6q6t/kVYZZob/S1dSOE7kU529/7rm
	O1x5PrOMa+28mB+pSzyURWiVW/YGcFXtuX0FI31S1kRRFq62+I8xcy2E6ZZewgbK9dOIM5
	lNbiFzZSXA5zHYKg677F+9HAwFSElqY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-_HXCrg0-N8G112lhv26a3A-1; Sun, 18 Oct 2026 21:58:04 +0000
X-MC-Unique: _HXCrg0-N8G112lhv26a3A-1
X-Mimecast-MFC-AGG-ID: _HXCrg0-N8G112lhv26a3A_1792360683
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c7fe9736eso1313754f8f.0
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792360683; x=1792965483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SW7smKPvwjLXka19f8Byx3O0NkEWaQaf/H2rebSp6ws=;
        b=bn5CuQgGxwT7QhbmoRfxAUQMWL+M98ql5vbyoyPz8/OhejUwYrYdSkeJFJL7zs+4aq
         V/eOU1MBHPO3ChvBnNHHO+QQY3x25f4Y9K1ePRJH7DTP07JHsmgS8WyCsB9HztKjJw0M
         7LdXTG66rJ2+5EQZuwHEsFPjDaaQROAPGfiT4xroMoj/QImNqlios7BXe+XOXks3lEpg
         UFAr7zzBiz1ZrK/fk9ajb93EugDvSJHxCwIgN5FKldNWcpL8NMFGfa3paEwQP8o0IYc6
         PlvJraMsLRjVmPyy36XD6u9UjzrHygD2o7kfilLnMXT5/CtWu8+5RMaa97S7EUz2HynI
         4DNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792360683; x=1792965483;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SW7smKPvwjLXka19f8Byx3O0NkEWaQaf/H2rebSp6ws=;
        b=UUl90G22omKZlWTtjfj+T6d2QXxzI4xxp59bVuG/GYpZoSBWT9HcJwKEl8gV47uueV
         Aa2d5b81qpT6uHBGfSSioJTGH7LY1ntjYTvShCny7hDYszKRNYQpl5GsOydxSj+g6SvK
         2X344t0mnmrnguf57julx3Rji5NRKpVjokzAtsUr7rlSDOmoo7mbFFMfITJeXvUW6KVC
         R9+ZYAZsh/f2ZhJVFTASr5a1wxKHcJPhu3ZW5M7HXm+wV9vWdrEO1CQ7DqicYPXqHd3G
         Ad2kGBR830QfUOjZEOOXVMvQ9aIHM9y+3SVUQKCzVM/uXKLkUx3smIavd9ZXtA4GjkmV
         8M2g==
X-Forwarded-Encrypted: i=1; AKwUvByR3Y8x/EUItyP4plZ/YuB5HvrMvXtVJ42vbg1xEKLOzvwXB4Ma3BzjVYlWad0I/DelTnUQ3B4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9tTsZLHK6vZYamiuvZ7ImRtcsOwy3Q1juaWcDvMB8Sykwvu/d
	K3RTeCetdI59islzTxq9nMJeXsKcxy8cYS/RxKuU8kbe7iFMtWxhsT5IhhIzEm1VuINVQeSz3B/
	oSX1m/jUiw9UaK+D6yLBLTJ1eSsPS0Vsi0vvR5R/6kxZ8AcMNPLz2HMiIww==
X-Gm-Gg: AYBFou3U20okFpdnJ3CslJEThTOdIhZi1dTMqeoPhtLRYL6of2cVgE9sKOVp19R38Lp
	PQpmgsUYN6p1PIR/NhUWR0I/FPXckIXBmayDjX2io06ZTED4JX6Q+3fvSoofJHDbYso4qm9VmrN
	iCtWsVDYPNMfy8NAULcvu//fWmxBMndJyxpgnMvRt9K5pQjbr33k7k4MyCsj4mkFi17b44NzTWt
	E9Jj29qLsmnxhk/nxYA44KetL29Qghf3jrVLGvDWJtmnWGQV/WK5SgKOI4q+nhAx18vTMUT35ud
	2++zSHc9Dw+ED3BxVVgHKamUTWeV23y0XIG2Jjm1E53KjgH+3eCWMn3cp5A0B/FGhkMcig==
X-Received: by 2002:a05:6000:2887:b0:48c:571a:a1aa with SMTP id ffacd0b85a97d-48e07bbc6e6mr11848838f8f.19.1792360683019;
        Sun, 18 Oct 2026 14:58:03 -0700 (PDT)
X-Received: by 2002:a05:6000:2887:b0:48c:571a:a1aa with SMTP id ffacd0b85a97d-48e07bbc6e6mr11848818f8f.19.1792360682562;
        Sun, 18 Oct 2026 14:58:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5008e7sm18703089f8f.43.2026.10.18.14.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:58:01 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:57:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018175347-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <20261018204838.4080b238@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018204838.4080b238@pumpkin>

On Sun, Oct 18, 2026 at 08:48:38PM +0100, David Laight wrote:
> On Sun, 18 Oct 2026 15:24:41 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Oct 15, 2026 at 03:23:45PM +0800, Haoran Wang wrote:
> > > I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> > > getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> > > against the 7.2.10 source tree. I have reproduced the leak on an
> > > unmodified 7.2.10 kernel.  
> > 
> > 
> > This should fix it I think? Can you confirm pls?
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/vhost/vringh.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 9066f9f12ba1..4b097170bd36 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1213,7 +1213,11 @@ static inline int getu16_iotlb(const struct vringh *vrh,
> >  		return ret;
> >  
> >  	if (vrh->use_va) {
> > -		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> > +
> > +		if (!access_ok(uaddr, sizeof(*p)))
> > +			return -EFAULT;
> > +		ret = __get_user(tmp, uaddr);
> 
> Can't that be a normal get_user() call?
> 
> David

Ugh, actually no. This is called under local_bh_disable.

get_user would splat on might_sleep.


> >  		if (ret)
> >  			return ret;
> >  	} else {
> > @@ -1251,7 +1255,11 @@ static inline int putu16_iotlb(const struct vringh *vrh,
> >  	tmp = cpu_to_vringh16(vrh, val);
> >  
> >  	if (vrh->use_va) {
> > -		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> > +
> > +		if (!access_ok(uaddr, sizeof(*p)))
> > +			return -EFAULT;
> > +		ret = __put_user(tmp, uaddr);
> >  		if (ret)
> >  			return ret;
> >  	} else {
> > 
> > 

