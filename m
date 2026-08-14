Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A127433049
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694559; cv=none; b=dt4F93eHdHfJuYAwBF3vUR6e9vazBPubwWMknM4YTgleEM2Meef0Yf368404zWLUFkew3lY/8dLOxMnf+3yVYJ9/eAYGEtflH3rMz5I/V2I7Fw3xbe9L1lT+GCJ5eTkPMtefRaAnc4jywMvSNEolGDUeSiqPoeMs/w5N4NK8ckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694559; c=relaxed/simple;
	bh=Vc1VdbJaZLwkkuXSzA3lP748RejM2wNnDWqBh3Asdxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANOz+wVQwIjrWnhKXP/Xh4VlxwFAXHGWZWmCww2bkViCcGiKqZvPv7j2XX6/2mkLoURXBF65lEe+Aqpnaph/3OoRnYj5q7Fop1zMl6nyYxw/lny0H93jSvTXHe5i+eCE1iDymiJ+BdPyWcoFymKw70dG6zOO7jNAL5rHtiLt5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wnmx3PW2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJ5XS4HY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wnmx3PW2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJ5XS4HY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuTGLTHVcUVUR8K491MTuND5/r0LYsPN8mtppCx6Zuw=;
	b=Wnmx3PW2YbDJQpl7xSFVDFO0WdEFQ+ewrkfhxVj9uDmCB1M2ed6X4noenfpEhhEA+08f77
	eMTnovVMnHjWcoH7TcwjDlSxN1+f2/FQ29QRSI3ILVzPwHTW7SbuPRKjMzWPfjHTYrzt0U
	FJptWthJeqbnifISfweAAcUia0qO8ao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-I8Pau__pNtKhvG8fkoQUmA-1; Fri, 14 Aug 2026 04:02:34 -0400
X-MC-Unique: I8Pau__pNtKhvG8fkoQUmA-1
X-Mimecast-MFC-AGG-ID: I8Pau__pNtKhvG8fkoQUmA_1786694553
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954b1c6310so6958855e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786694553; x=1787299353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xuTGLTHVcUVUR8K491MTuND5/r0LYsPN8mtppCx6Zuw=;
        b=dJ5XS4HYRcGv2kO6+u4pnL35LDewVkD4y0fH50FuSZocOQnEGBOSz0EgIuYKu1aaAU
         yaVk6ou1kGuMD5kHT8oOSJqj1MvmIa/1ihQMUewYBbUaITMHQAmc5Smys0ggBrtzTLcB
         Fdb566LRWIa/9qlimEF+43iMNY4xbF1x/ufMDVcHSECHdefHSc+0qrFNClAHk9g1RcNb
         wmGW6f2yUfavOiCwOdPOn41Kq2m7knnXJ5bWIXHfYGbjCZZnyBFXAPP8OEtswOZArmYu
         uxPh6fgltzxHF0L+95ahm8Qc/V7WfaDylT0v5e56eVKvNOu6TBIVVcAJW/WMm3EbRoXq
         2BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694553; x=1787299353;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuTGLTHVcUVUR8K491MTuND5/r0LYsPN8mtppCx6Zuw=;
        b=pwJ1MfOYnSxEfko2AzZJAHPeBDx4jJS89EskrROsMaWOp0vYZjOGBGJ66+3NDmJ2V0
         SDsqnn1UGuMtK/hDX/oaK4YMsLEur5nQkHrCu/T837DB4bm6oN9lsRlV5h6xbhnD2pRR
         N6EQ1sSlpgcNsq9BTPZ1tgZUu6WTbmdO9ROheAS07hj4N/CoUN6KUgoEje0L/05MP9pc
         U3jyBTfxVaQQ/mjgQaTBZUZg4lFov3gswpI8RXCMNmCf1M1+HvfI3zTMI3Sk1v41CYfb
         u6tTwW0qIckljwu/++fof5MayN0aNfVvXQbjJTI3ICUihMFJoWz5aW+tg4raguB8K1DM
         +53g==
X-Forwarded-Encrypted: i=1; AHgh+Rp/MehskKLJibmQD08rVNrX/PTFwumMvT/ocify9KrynvV8Ek73Qh4qAJhyNHEM6XAEsT+4buw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysXMru93QK+SUCM1QKneLURIThYSvYKedNYXbAherKOQScs4cU
	wnT9mKuDa0a8r4MhQU6IgoRZBlIJBqRGyIzCpSVo38dlTlx8co32r80p1bXGLIs2uaUmiKnAgRH
	DCwHLDihjpNsrMN8Sn0JDU+DYCWXyBvCI7rW8MoQSx8cFD6Zl7auE8pg9MQ==
X-Gm-Gg: AR+sD10zdPwcOnz2lfQACJfJeUa3Xe1FR0mhO1XRwG6mm2ujnxua2Qbl1KQC6KWay5l
	6er5yzh/uR4xxmBnu7ei+EgiPX55uIBywfXNRr6xX32oCRhOofvbur7Ah+OTCfyhKAPYx9E5Hy8
	w20t45L5tONS564ZzEIaDGZlgRrfeUbs85K88BLtn4xKRaBvYYi0ncl/eOIDvKcYe5jfz01hNX2
	cjsrv+0bCpwfVhf2DRjg0wKimX2O2wPLL0Jy4ADfHzi6fcOytrwKgr1FCS/sCzR2T8i242DhhKv
	psmeyV8QieQNxwPZWreGNaP9RkIOFH3cooc3cg6NoZEUR3xONPJpA1DZgayC5K2YdkDqpojYuqK
	71XyrISe15D7oay9mKEMv6kpzpdsPy+iOPMGIgPnn1VcTBJgZxN41
X-Received: by 2002:a05:600c:3e15:b0:498:ee7:e407 with SMTP id 5b1f17b1804b1-49987999622mr51703105e9.17.1786694553398;
        Fri, 14 Aug 2026 01:02:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3e15:b0:498:ee7:e407 with SMTP id 5b1f17b1804b1-49987999622mr51702145e9.17.1786694552788;
        Fri, 14 Aug 2026 01:02:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988adfbd5sm33234215e9.1.2026.08.14.01.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:02:32 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:02:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] vhost/vsock: keep IOTLB across feature updates
Message-ID: <an7KyotZ5vZOURu2@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-4-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260814072903.124991-4-physicalmtea@gmail.com>

On Fri, Aug 14, 2026 at 03:29:03PM +0800, Jia Jia wrote:
>VHOST_SET_FEATURES is also used to update logging while a device is
>running. When ACCESS_PLATFORM stays enabled, allocating a new empty
>IOTLB on every call drops valid translations and forces avoidable
>misses.
>
>Initialize the device IOTLB only when one does not already exist.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b69c260eaeff..9142fa1143b2 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -869,6 +869,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 	    vsock->dev.iotlb)
> 		vhost_clear_device_iotlb(&vsock->dev);
>

Ah, okay, now I see why you did it in the other patch, but if we move 
dev.iotlb checks in the functions we can still do that.

>-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
>+	    !vsock->dev.iotlb) {
> 		if (vhost_init_device_iotlb(&vsock->dev))

IIUC vhost_init_device_iotlb() handles the case where dev.iotlb is 
already initialized and override it. Here we are preventing that.

Will we do the same in vhost-net? If yes, all the callers will call 
vhost_init_device_iotlb() with `dev.iotlb` NULL, so should we remove 
that behaviour and add the check we are adding here inside the 
vhost_init_device_iotlb()?

Or there is an use case where vhost_init_device_iotlb() is called with 
an already initialized dev.iotlb ?

Thanks,
Stefano

> 			goto err;
>-- 
>2.34.1
>

