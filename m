Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288B3C8737
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778355496; cv=none; b=Z+ABjjLS62t+rpQ918WYrkM6Eaw4gRkdJ1dag6tZK8Zpci/Yfgbrc9H9YDELMTFdrIt/ddMsqy2BOVNANGybos3FHuZMBOGNYsCGbuFh2g4ULnqB4bI7uMcBug77DBq/Yv3vuTw4jBNroLzo0YwMHlUujfhN+wbHy1csM4muyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778355496; c=relaxed/simple;
	bh=LJ8prTqaJOJKTib6YJYHS9vdeOjI1c4LQ/IGaYQNqtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FExPTaiaq8AJsx+hYVIDBLbkGkKITEBdWIvPiy/2c/BrpHBxPscYa3vN/9uZPoD25CogXJwz77b8ZKa/fRlM/16UH9Etm5Q4n/RLUDRVgIlv4J97kY0JRz1HBGdJmhUoyjSjKlZJ/K0/iphe87SETDNYXn0AGqLl7vBzC7KpSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0u61/nd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mXgzdtgB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0u61/nd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mXgzdtgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778355494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ANPZRIsHdOb2XjLaWGPcru90KA3pfrVWtS2xY3q4MU=;
	b=M0u61/ndpHV6xKpjX76veishfMkvifWXokHZG4am3OczRXVkUYfL+jqLHQovMCvwV/GvIF
	1IGQB9z0Hd75EMXC0Y1b3sGTGNjDVZrpJSlTN+K6mKHvbVeahG4DS9o8/Caz6pIH22EDRp
	gc2Ifrm6HqLLB+XSq/S3SbYFfAgN9Co=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-Btr15px7MZ-wf2Jya5HOmg-1; Sat, 09 May 2026 15:38:11 -0400
X-MC-Unique: Btr15px7MZ-wf2Jya5HOmg-1
X-Mimecast-MFC-AGG-ID: Btr15px7MZ-wf2Jya5HOmg_1778355490
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso18731085e9.2
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778355490; x=1778960290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ANPZRIsHdOb2XjLaWGPcru90KA3pfrVWtS2xY3q4MU=;
        b=mXgzdtgBOga7z50tShzYs/7rN/lCb0HwMI53jZM3JLWbW5zDRvExR6JGr1GAONIzon
         Ep9VtLE0pmu4YpbKzqkplbgLP+/XpS8QtybXLPeknJJ4KZzpGqQP8tsSdzsbHTaebmtA
         8GePYpwdziTypHhrOE9aJE6YZs/uFVqGcbltaPHdmkmdnKGLtyrNdeDXurvSnrDLOEKj
         pHwHnZP4Tl7mACXRbpKm+mnWoaRLM/3tcv+MmOzAuiA19rW8RsrnyPrT0d9Mv5WNx7Br
         pVAvhktBg2TmubXo1pZJgT/9s+WXz4DrMQtyKPlQXRQPDpkhnxvdVGUEyNtbiERFljao
         gumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778355490; x=1778960290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ANPZRIsHdOb2XjLaWGPcru90KA3pfrVWtS2xY3q4MU=;
        b=qesMHN6C8WEK6gsc63tB8jOiJAC+ImExtfGnDVvJqcD1vHWyyV7JHQ9ye5J+deu3mI
         UpEVmrkBooLwi1dkTY17e7OnDc+aJas+NesFcJoePTsYwlw4B1hN6nCMfQyf6its/W/y
         nnzn/VKw2utq1OPXdxDFoW/nQW8icl4dVNRtl0PavvvHqA/lz1ZCgma1y0EqI23GeJ9Z
         AOidB3vcu/4WzS8QRI2TQdi2NYCw7UoC91Ax4SbvFojJXYgNHBHnOM5c8kglIs6KYeX7
         cd1y6n+P7zgrEr4DoW66ah92lXvkiAklwZEmn47R+hWhVH5GG4DJAZ+9BbCHGViGX+Rm
         ZlZA==
X-Gm-Message-State: AOJu0YzxEzrrwyHkEouBWUnSbNam43VMg4ZWbA53ky7yjaqhreXD7qcz
	8nTv0iIHARYac31YhBmafoJxd6P7acULM/tGpW4nvOVc0PQK29jeBOKobLx6BgBz8D0KctKNvVx
	Mx9c4Cs3NgVP+BcJEn6hcKQBV3vo2fJn/jmRWZ/S5FwjKdHF3sQKtPxhe+A==
X-Gm-Gg: Acq92OHVxBFv41ly4eotQyczD2ba2TaQfo0UbtTqNCtA4ptJVxdXzoxCZXxnWUcrEGh
	VWjGGh0iEElfvtnOLsvCS0V1rSLIfCLAF9FwjJy6waHqSJCfpifPXuvPld6kRaKLuPg0j9V942c
	n2fr0CVN4Gy/Ylu6YxzYnir3G2VQwW1IRzP2RDQrDrF/7p+OsfH2l8prMjc68s6qNcpFIENDUs/
	5H2xIE1b9TZyDM4nPDNoIm+69TR4t4KS9OzfEd0SgbbGi03cR7cHUxCAUGyOj5Mmsi84hWFyS3K
	1yByM+1Pvxd8kfGXTGvFGWrkhjhisa9zy3oAU6sm0ivtXwerrWBfrqu+3x7EY7ayEU45Wz9+SIl
	m0HGka9ufxEZ648tE+bT9a+lG7ke6qrbfTFakK8KF
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr165361335e9.2.1778355489625;
        Sat, 09 May 2026 12:38:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr165360785e9.2.1778355489118;
        Sat, 09 May 2026 12:38:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db0fed0sm28105665e9.25.2026.05.09.12.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:38:07 -0700 (PDT)
Date: Sat, 9 May 2026 15:38:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Yiqi Sun <sunyiqixm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net 0/2] vsock/virtio: fix vsockmon tap skb construction
Message-ID: <20260509153755-mutt-send-email-mst@kernel.org>
References: <20260508164411.261440-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508164411.261440-1-sgarzare@redhat.com>

On Fri, May 08, 2026 at 06:44:09PM +0200, Stefano Garzarella wrote:
> While reviewing the patch posted by Yiqi Sun [1] to fix an issue in
> virtio_transport_build_skb(), I discovered another issue related to
> the offset and length of the payload to be copied in the new skb.
> This was introduced when we did the skb conversion, and fixed by
> patch 1.
> 
> Patch 2 fixes the issue found by Yiqi Sun in a different way: using
> iov_iter_kvec() to properly initialize all the iov_iter fields and
> removing the linear vs non-linear split like we alredy do in
> vhost-vsock.
> 
> It could have been a single patch, but since there were two affected
> commits, I decided to keep the fixes separate.
> 
> [1] https://lore.kernel.org/netdev/20260430071110.380509-1-sunyiqixm@gmail.com/


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Stefano Garzarella (2):
>   vsock/virtio: fix length and offset in tap skb for split packets
>   vsock/virtio: fix empty payload in tap skb for non-linear buffers
> 
>  net/vmw_vsock/virtio_transport_common.c | 47 +++++++++----------------
>  1 file changed, 16 insertions(+), 31 deletions(-)
> 
> -- 
> 2.54.0

