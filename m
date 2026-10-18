Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0244949ED
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359757; cv=none; b=g3Qiztg3B4kJbxKnLHqd7zMLC8XHUIQOA3Fl+bCtZpdtw65RBikqEtFrf5j0v6/lLfPuYLbv7xJKFHhUjYUUYiQGTlfiLzYdCxKIAb/c/z9HUJdsbH5LDMo15hrces0QehXZ4UJVwLBQaywQlb5Vqtbx+bBb5gPYv/6z96OA80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359757; c=relaxed/simple;
	bh=a3AmrwR8v2jihgGq5kU4YfBXbpArfNYrMAioQAluXE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlHvGzvMoFaEnqNteqeg6OsCxefMArXz8jQakGJTV6NKo5dMtTEnuYpjpHxSP8i+yfkiAUKUvnJn47av2q7WO23zcuzTJxcMZ7chzIzLQ53Jnucggq9+ouSutWacQgtrUAYNs3TjXY9K+JFbEeaJBgNdA6TRdBxmk4PNfaDk9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDvAhuUF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKI2lXZ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDvAhuUF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKI2lXZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792359755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5kyv1GQkP0lF5khYckjfpPeq+O6vgVUGzl8O+44HLM=;
	b=ZDvAhuUF3AEuZ0JZXrKiPWXudF/gK1F5MWiEEA8SkwC+sbYOGbWYFd8M4SPyWCqBvhbHu5
	WNA5GhDGvMN3GrnTyD8OvRFRipylQRJay8c+g0cx6aAvhAe4lRlBOhewK1ny7/JsbmbMNM
	qtJwa8KWOVbWBdosU+Xp6O6JAw7o7z4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Q4FlFcbNOG-GLly06waocg-1; Sun, 18 Oct 2026 21:42:34 +0000
X-MC-Unique: Q4FlFcbNOG-GLly06waocg-1
X-Mimecast-MFC-AGG-ID: Q4FlFcbNOG-GLly06waocg_1792359753
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so10692255e9.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792359753; x=1792964553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l5kyv1GQkP0lF5khYckjfpPeq+O6vgVUGzl8O+44HLM=;
        b=OKI2lXZ/F3By2sizfNp0kecR99IZCO3uiOxglct6RUkFwAEDmQU5R6FCA2zgzwY+Df
         NO6mFCmgyg/nsCPpDTX6a7aBbbwFulHDPWsiWB+lQPwyeF5+A8CKdhRZDUvprskxxiL8
         OEOURYfpupBNkzMYV6UpXbgX3ZPqwtml7uQQ0FnG89PPiXHV0bJMgT1lnKoh5tAZdBnE
         EpLumLQfEgP/kyVtXEnQlDWQbW30EZYO09qt+5CAVHfGTX6ZxWtmHse6+ckNpp8B3+Sn
         nofWAtQMLKuuQ0I99O2yydU8ronbovtSAHOLvsfooBTxlsevWOE3iDGk94PUEexzYloP
         Twmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359753; x=1792964553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5kyv1GQkP0lF5khYckjfpPeq+O6vgVUGzl8O+44HLM=;
        b=VjroaKfjz6GZ3KlbL83hXG2LarNRsHXBVcidn2CSq3FlEQZ5va03vOcPBAhJ6aJ0wy
         DGJkMODCIfMFrR9wPo33vwhPxU37JcpdHBwVHh2kXEA84xJYNXcx8NFQrdJV8/Uqb7Ay
         QFAlYSc1HU2WIHQGRXXeRXWNIoq3y7coLKBtnLvM812buwbANBkirnSKyniPmz1t4BU0
         892fgvzh7Se3Gene+uv5Mod15z7re+6b+ZH/8L//oTW4HzAqo+W3aIxnhPYLgzIVxs26
         FZ3lL9Hi1c8Jql6JqiX2jDolbg+qGJ57CcZwRFJxDTTPFov6++72yJm0pbgfWJdKFbhO
         cDWA==
X-Forwarded-Encrypted: i=1; AKwUvBzFtKr+US2ZGcnk0iffFD1l/dP8UW9YVn6Pt1r9motiNbiVgx/R4i0jr54O4tjycEd/tec1y9g=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9rOorymQc7fwL95J7Su7VGOJrUg8aTc4B38CtcMq6bAJmGElr
	77i/pUUynVJummZCeSY06W/qyGTv8ofAMB+Ucsro5VqWorDw38v4zD5YaS/LB9OsA8zuK90KFTS
	W9Z8m3N2GsdoUEUrHkQOi7sdyL6tGj1oTP+pyv0DExeTgxPSt9MW2HLqS7g==
X-Gm-Gg: AYBFou2VnT9zWRElispp1zjHFAijrjy/SIxdC7rSGvXocnUHI0kRfKwEe7pMkOR6KRu
	ykv95Hj5970h9x5jd6YLvST35iZ0GRmmbDyTQbp0d758MMdcbIYNa5stkludwgv0nY1aPZ3a24x
	QHC5Cknrr7+B6Ev74KfOCrkTbtW2/P1zCX3jHku0W7g/M6tlIP/vKHfeZdza3+wIdC6tkCzGKNz
	GcllOWmyy4LYJZniuDPU3xwD1PNZ6GIMwfhDQgKEpPCl270o5YRdO/Wk/WqZFsDMNv6l97nfc45
	1ralRu2ql5wbzwMCI2xt3Jz3eiJ0Yiq6El6goWRwfrZCU3WKm1RgtdWCdm9cQW9wUeczDg==
X-Received: by 2002:a05:600c:6289:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4a1dadf98d1mr105366545e9.23.1792359752770;
        Sun, 18 Oct 2026 14:42:32 -0700 (PDT)
X-Received: by 2002:a05:600c:6289:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4a1dadf98d1mr105366305e9.23.1792359752289;
        Sun, 18 Oct 2026 14:42:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ae6d2esm226529615e9.6.2026.10.18.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:42:30 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:42:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018174144-mutt-send-email-mst@kernel.org>
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

Now that you mention it, yes. Thanks!

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

