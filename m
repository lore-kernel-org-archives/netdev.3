Received: from mail-oo2-f19.google.com (mail-oo2-f19.google.com [74.125.231.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E848FF9F
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578034; cv=none; b=oHWhpQWy+rwEC+gDgtFwBGdm4xmhzEDvzVnZItHMRQrkqyk7fJ5ge0s5ndv8ZxrzxjfkLgFCpUovmwiRE7TxpusGB7jHqK3elZhBZDbU73Faj+xlpcIxnuEg8jpj6df2+8NwFTHwYTDB4M4UecFuLvBI8gWxkAqMT3KB+NwP+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578034; c=relaxed/simple;
	bh=Ky6tqUlPctwf9kmSA68nL3wRxEYqHtONMZuz2rSl+Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz7hQoaWZzDlHAvVmVEc1z1a78Z28m+wd89uA4rjbEuIAQSonnhwnMkHyKGY0l0BLo2Fsydyk4NpN4Pxtzcvs1VLCRSVtOUcuqgpFIUuERn2J0lnVqETgDFM0xn9VycHDtVu5y//emRFM+lot0wEur7dHcFOcYxnF/gOT3fNSfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwleqU+q; arc=none smtp.client-ip=74.125.231.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwleqU+q"
Received: by mail-oo2-f19.google.com with SMTP id 46e09a7af769-7ff1e4ffb3aso827440a34.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789578026; x=1790182826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kV5xMCFq0mEVtZsKF5EmMvJNOJj0hLOiv+MHAekOLlU=;
        b=CwleqU+qwDJqo0nfZyXSHaniEuvEjmfULs6m04T6ewFsw9SzfvGPJvlX9oI70uDtFn
         iKChCRYV7Qdr0g5vnglAOA0bs8/kgb5MGs1MzJF/8vovGSYvEyoA5YF/AvlX/ETDbeZ6
         R+Ua9WdMASXl1NPG3EGT5F8W6VSLE+hCNHSGsGxE1GDs+RIPYNOaRg/qYo1maPOqZkGO
         S3jk9YUPE8eg2eGHwpOLLBt/hF6tveJZWcQ77RIkfmzqWpfHG3hFOTT30/czZqE1EkUC
         LooNvuRExj1xly26BNGdCcM3Aoxlbunrlq8jhSaanWYR/HihhpypzvaAoooFm3L9STlw
         RgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578026; x=1790182826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kV5xMCFq0mEVtZsKF5EmMvJNOJj0hLOiv+MHAekOLlU=;
        b=KoPoU3U0kLnUfiVsR1kZXrwFD3YF6I3omqw5XyVq2HcE7krGyioce9nBPCY1JSlaSd
         lNkaOdFqWdnc8sX94s9UrslZ+OS0qBNf2fIa6z+WtxAaTBVVXPaKpDV1LE9tyBBqe5Z6
         RcEY8VU6I/kK7V43fgK+ewcibj6zorpJzirXHG1sey7kSAihsZ2tmbeZsxabfmPzLybk
         jo+CJzHrLFj9UndAlmRwHy6jV8OJR5vGu95R00KdnLLwBe+GeZbzTsE7tb4DWAZ54XXJ
         dhKoSQdsSvGwnJPkekkq/vTCz2SWRiq7NmVl5iI49l116iIsxpexkhwQGzmnecsusB1a
         xSdg==
X-Forwarded-Encrypted: i=1; AKwUvBw+GZ5XhGI9IRhhNq2p6r/edPJoeEC/VgagGNINox5MA0To0QVUYfBRnFFCAMrAhJuyJ9eIa/s=@vger.kernel.org
X-Gm-Message-State: AFuF++kGgMF+jPpPRybZPQWLVKLpWsVsXTnFJ2iEVmbp3iL16+42lGQu
	O4g4fyomDeMcKdxW+668kREZlNCM4+AjwJN9ERauu/wnYdSIzU+KZBBL
X-Gm-Gg: AYBFou3BcX6vSx8abOA7KBDxsWgtyCGsxC85bNqK/Eo57yiSuBG4zFErrVVp+s9c6Oe
	qLNp0ypjFRRwpnWH+Wtvbws47+xD7w+3lM0ziUkgln+Fd6Xb7/XaTv3jEFezUZ2scMokx58Cdqp
	OYYuWPA6CXieoyN1BgSiSQQS/5O6y7SRUzyE6i6KxO/aO3Xy58CrDjEtQvnZuvVmPZAm7/3bpyP
	5ms3s+jp+Mn4V3xiqUIkD2RRjBA6kJ294EZzeaLiMf41EcAcnX6tgvSMONwx5MbHWkh/NVxLMH5
	C24TKbS3Zi9RnipepP3Ncm5C0udwoFD83Tq07qeS/7XohsBlmIFGPAuoiGQvUwdnNOz6F1ad6p9
	bPP3eOCBhxLZClsrTPbrvEdJwCKmW2o0W65ytCZHUqrTiCFiqRPhBMJXN6XxcWpLmokDDPdLRQk
	qwKJY+n5Mcvz3nhwNA2oVSm1srQL32N2b/oBISjYaJTEyonRsqy0q9v57irejcJdM0nmxH9DxDD
	fpbklIov/kUV5DkstYj
X-Received: by 2002:a05:6830:67d5:b0:7f6:96ad:36a8 with SMTP id 46e09a7af769-80b2d416a86mr4148110a34.8.1789578025959;
        Wed, 16 Sep 2026 10:00:25 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c4619a868sm391941a34.8.2026.09.16.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:00:24 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:00:21 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sargun@sargun.me, jlinbox@meta.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 0/6] vsock: assign the guest vsock device to a
 network namespace
Message-ID: <aqrLJWnHJ8DxK8cF@devvm29614.prn0.facebook.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <apqGcFDFm9_Wtw4q@sgarzare-redhat>
 <apsANK7ySuRzzK0V@devvm29614.prn0.facebook.com>
 <aqkaTXHDf5nfPL9w@sgarzare-redhat>
 <aqmDuxMuEN5lS/0J@devvm29614.prn0.facebook.com>
 <aqqNEl6Hyk_h9C8r@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqqNEl6Hyk_h9C8r@sgarzare-redhat>

On Wed, Sep 16, 2026 at 02:36:07PM +0200, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 10:43:23AM -0700, Bobby Eshleman wrote:
> > On Tue, Sep 15, 2026 at 12:16:47PM +0200, Stefano Garzarella wrote:
> > > On Fri, Sep 04, 2026 at 10:30:28AM -0700, Bobby Eshleman wrote:
> > > > On Fri, Sep 04, 2026 at 10:55:17AM +0200, Stefano Garzarella wrote:
> > > > > On Wed, Sep 02, 2026 at 04:00:46PM -0700, Bobby Eshleman wrote:
> > > > > > vsock network namespaces let a host put each VM in a namespace of its
> > > > > > own. A guest has no equivalent yet. It has a single G2H device that
> > > > > > cannot be assigned to a network namespace.
> > > > >
> > > > > Thanks for this, I'll do a proper review next week, in the mean time some
> > > > > comments below:
> > > > >
> > > > > >
> > > > > > This series lets a guest move that device into a network namespace. A
> > > > > > new ioctl on /dev/vsock, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, assigns the
> > > > > > device to the namespace of the calling process. The namespace's existing
> > > > >
> > > > > Why an ioctl?
> > > > >
> > > > > I'm asking because I'd like to know if you've already considered any
> > > > > alternatives (sysfs, netlink, etc.)
> > > > >
> > > > > How do you think the ioctl should be used? Should we provide an userspace
> > > > > tool, or extending some existing tools?
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > >
> > > > Really only because /dev/vsock exists and the prior series used it.
> > > 
> > > Yeah, I vaguely remember that we may have discussed switching to netlink in
> > > that thread, but I can't find it.
> > > 
> > > >
> > > > Considering netlink, it might be the better option because there is a
> > > > lot of prior art solving problems we might have in the future. For
> > > > example, I was thinking about when users suddenly lose access to vsock,
> > > > with just the current assign ioctl there is no way for apps or users to
> > > > figure out why this happened. We can have an ioctl() setter for user,
> > > > but in netdev world users can actually get a notification via netlink as
> > > > to which namespace the device went to and what its ifindex is there (see
> > > > __dev_change_net_namespace() for the RTM_DELLINK and RTM_NEWLINK
> > > > messages). There is probably more, but that's the case that comes to
> > > > mind.
> > > 
> > > netlink seems like the right way to go, do you think it'll be a real pain to
> > > implement?
> > 
> > It is really not bad... it'll include a yaml spec in
> > Documentation/netlink/specs/ of call names and perms, a new target for
> > generated code in the Makefile, a handler, and then
> > tools/net/ynl/ynl-regen.sh generates the plumbing.
> 
> Ah, nice! So, do you want to try that direction?
> 
> Thanks,
> Stefano
> 

Let's give it a go. I have a draft of it for v2 and looks reasonable to
me.

Best,
Bobby
