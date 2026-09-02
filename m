Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273546C84B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788393504; cv=none; b=NrWfB7/Pmn9lFWZAxdZdAkMTf1CzeOUIadTm73GQxvVtIf9kjYzLS9bJ6GXcBFhUhTLHr0LDxrkv39GZU0LjFWB1iRR6W1oNJqQyj5zWshR8nbN3FVGoN+LkMoJdw/8/XTvCumpGyscNM7+5wpyYczPv8hPLEhfhsAb5/dbxnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788393504; c=relaxed/simple;
	bh=y0BmfY76mN/0WPfH4Hr0Ikh4CCr4ip0xHhPT2cF1Sd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVJ9faOlafr3XGaKI3fJu/Y+Nr/mhglTRh50aJSEO/8GzsdfZSRcEFtXS6515wcpjooMGxA8ZTPL8Hmxow1X40quRz7KC2OK4y8I7WsEzrAwoqN3Ln2O7XBhdzor3KuD74MOooMlKKGjnQlhZF2Ta1bbBs+PL1uIDpISzL7m1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEdOUHVf; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEdOUHVf"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-459281bc13bso1224947fac.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788393499; x=1788998299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o6TxE/PuYRNxck14tJMx6uhlVO4Uxr/vKzSJJkM4qzE=;
        b=UEdOUHVfSio8B+/4dM4jV06dcybCNduoYcyLhiSa7adKNY4niM8QiLriUdwA83jyjZ
         CmwYdf8FH4RwJ2KeSlBbbF/BIJcKBZaow2l2Ly5TaZ4ly+GHSrLdlYTmCH3RP+WjdG/q
         P+NmQnMi6eTff/mH6Ufkx396ThYmRiziHf3skgb3TvqJHxHOi8rMRwF/dU8RF+kYeVnE
         Q0823yATERFU7Prvd5NdqsktbGuC6jSmEji3NSc0SsS+kDt/+MIPrXsD8+ZhfRzC4gkf
         uxYr1h1xizIUWxEm2gThxF5+1MFl7LrerD8/IM5xJLTW+XurNJCcetK3Jn0Tcutulgfv
         CXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788393499; x=1788998299;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6TxE/PuYRNxck14tJMx6uhlVO4Uxr/vKzSJJkM4qzE=;
        b=Odua6uuoOxj4k+gy/FkqxNiLCuG2zTuhGwSknv9AGQlJYZxlzMS6SNMyc4la7rK8Sd
         0fIXcKk/e5ygz+8EecGd25vK0uwmLzBYpP35ArE1/wukHTGQnS3fKMbsMU9XyVefet5f
         bz9dBAhPx5KnITQnVqLD5bmILoDAVXDOGYaRYgT+TTpNVvk6g0uhYWkTUPcybn58lJeS
         kG+45aMi5YDVIdA3xyoG2fDt/C6iaN87sonJ2LeQMENx9ujOi7FjioZ/GMiPz2exZcn7
         QiBeNkoiSp0MTU8+RQr74kmPkRZqLDCSyspmtUPL1AgoObx1ivLM0r8GVMV5ZJXO7Lzd
         2gOw==
X-Forwarded-Encrypted: i=1; AKwUvBxFlOnXledOxQYzf94jki6cqxRx1IlVb0BvK7p61GY3M5LyL9yj3jAIBMkDC+m1IgPZANIGjSc=@vger.kernel.org
X-Gm-Message-State: AFuF++mprmSzYs4/DybiPcqQRmLFHulTyyG5ZqDIsJCzkQkLES9ULEVu
	55PeCdgwduysRrXc4+1bZHUnr7mJjFbaiUyXbAGybU/V1QWs7FkpbTGv
X-Gm-Gg: AYBFou2HHsHueAGomWZxBxFxJmB09tPz6hC0H/BJ4+W3+5R5r5yAIxNhQLB0OfNKaMq
	eWjq3EnEzgVZErFtpGUTsg+u4xJech9d1taaAFx74LKmzuSYgzLQfvnTfrvzVZSdabe5r1LxfSk
	lTwpTlac3JCZ9Lw6hO7xERyQ7ly2pvXBSJVLzLMLl5UVcdmHTt9coMf3gKq0bt3Exd7lxIk5xgn
	IeQHs2hS4n9s5PCH/0G2DjSBcvBM6S3n8mMDdKLCVtBm1INPEnl0bjH7jCMRmjLyhHY+N92b3Tz
	3rpDK+ybw8u13sX/jV0dFRMG4HaJqRG5rr1m/0T7u7CYI8+Xkq5e5ACZMm4W4VVRlxAxHHy8sBz
	+VU0NMcsEl8/HxwXNJwpgmWj6mZe8xpzlEV5M7qpdS3HdxwOqhvXgH8dFTiohcUWJug/H8Iywbc
	Fm8Xf/l94RlY40Ucvf64ohQF9KnMsQO5M8Zxwo7T2fitAipteX+kS0A3Ch2nVIu0+ycOJzmfHBE
	b8fOZD05XyZRe/zP5kU
X-Received: by 2002:a05:6871:c8dc:b0:465:8554:94b7 with SMTP id 586e51a60fabf-46f87ca935fmr7744412fac.12.1788393499274;
        Wed, 02 Sep 2026 16:58:19 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f330822basm5626041fac.15.2026.09.02.16.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:58:18 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:58:06 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 2/6] vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
Message-ID: <api4Du1bQzieFvA9@devvm29614.prn0.facebook.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
 <3a581439-6664-4339-8627-f1704db35bb0@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a581439-6664-4339-8627-f1704db35bb0@infradead.org>

On Wed, Sep 02, 2026 at 04:35:59PM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 9/2/26 4:00 PM, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Namespaces let a host isolate a VM's vsock traffic to a specific
> > namespace, but in a guest vsock traffic cannot be isolated to a
> > namespace. The vsock device is hardcoded to global mode and can't be
> > moved into a local-mode namespace.
> > 
> > Introduce ioctl IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS on /dev/vsock that
> > gives userspace a way to move the device to the calling pid's namespace.
> > The call requires CAP_NET_ADMIN in the root user namespace. A privileged
> > user wishing to "unassign" the device can move it to the init_netns,
> > which is hardcoded to global mode (so no unassign call is necessary).
> > 
> > A getter to read the current assignment back was considered, returning
> > either the namespace's net_cookie or its nsfs inode number, but neither
> > seemed useful enough to bake into the uAPI now. It can be added later if
> > a user turns up that needs it.
> > 
> > Add a transport hook to indicate support for guest namespacing, so that
> > transports may opt in/out. A transport that opts out keeps the
> > reachability rules it had before this ioctl existed.
> > 
> > Sockets are reset when the underlying device moves to a different
> > namespace, so as to prevent reachability from the previous and now
> > disallowed namespace.
> > 
> > Following the approach of netdevs, the device returns to init_net when
> 
> I'm confused by the use of "init_net" several times and "init_netns" at
> least 2 times. "init_net" is the initial, boot-time net namespace.
> 
> And is one of these what is referred to in the Documentation/ file below
> as "initial namespace"?

Good point, init_netns should be init_net everywhere here (and in the
Documentation/).

> 
> > its namespace is removed. Care is taken to not break flows when the
> > device is inside a global namespace that is being torn down and alive
> > sockets are in a different global namespace. In this scenario, the
> > device's netns getter pre-emptively falls back to the init_net (always
> > global) so that these flows are not disrupted. If init_netns ever
> 
>                                            maybe    init_netns()
> if you are referring to a function...

Same here, should be init_net.

> 
> > supports local-mode in the future, this logic will have to be changed.
> > 
> > Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> > Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> >  Documentation/admin-guide/sysctl/net.rst |  18 +++
> >  include/net/af_vsock.h                   |   7 ++
> >  include/uapi/linux/vm_sockets.h          |   6 +
> >  net/vmw_vsock/af_vsock.c                 | 198 ++++++++++++++++++++++++++++++-
> >  4 files changed, 228 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index e586e17fc7a5..1e9c0d2be7b8 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -515,6 +515,24 @@ their hosts. The behavior of VSOCK sockets in a network namespace is determined
> >  by the namespace's mode (``global`` or ``local``), which controls how CIDs
> >  (Context IDs) are allocated and how sockets interact across namespaces.
> >  
> > +In a guest, the vsock device owned by the guest-to-host (G2H) transport belongs
> > +to one network namespace at a time. The ``IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS``
> > +ioctl on ``/dev/vsock`` moves it to the namespace of the calling process, which
> > +requires ``CAP_NET_ADMIN`` in the initial user namespace. The namespace's mode
> 
>                               Is this the caller's namespace?

Yes. I'll clarify that in the next revision.

> 
> > +decides who may then use the device:
> > +
> > +- ``global`` - every ``global`` mode namespace may use it.
> > +- ``local`` - only that namespace may use it, which reserves the connection to
> > +  the host for it alone.
> > +
> > +The device starts out in the initial namespace, so until the ioctl is issued
> > +nothing has moved and no mode has changed.
> > +
> > +Connections made before the move, from a namespace that can no longer reach the
> > +device, are reset. The device returns to the initial namespace when the
> > +namespace it was moved to is deleted, so assigning it to the initial namespace
> > +is how an assignment is undone.
> > +
> >  ns_mode
> >  -------
> >  
> thanks.
> -- 
> ~Randy
> 

Thanks for the review.

Best,
Bobby
