Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB03264C8
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 04:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681871; cv=none; b=U4sh1mEsjr3BGIGv8PniiDrHTbeP6CTfDUlf45DdCI2hF3slH/xOmHcJySitdiLp+ka3+YK1m83e3GpsILaVfaoQxMQO1iXbwTIXEEVd4NUsjWLVXmX0AHvdQaakbblaULdeievM8gP4G4HuzV9SxO9mDRFUFafVgANQO0oN4Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681871; c=relaxed/simple;
	bh=mHRHVvf60GH9AoSxXUVzVeU7W3fjsuyIMYHqU/lZpyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhfGJtPYzERyBhfZhTlgWkDxb12pyTkfhApOVZLGS52zpi5DyPT6TO29iipIAJHT4cOVOlSh5vC7UsfbDj63/gQJSGTEFxogehNIGOODTkpqnDFTzUzQMd5oB7vlB4IW+fxC4tpSbx1KZtsJW1Ejww3GZgM6UyMbPYcUTgMNeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFZW5Awc; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFZW5Awc"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so676995a12.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 21:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786681869; x=1787286669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZFnJtKJCWIEEeDVMRtp70GTjEuRFU7I+mzBwGLiw1QY=;
        b=FFZW5AwcG6WALJLQ/ygpjB+hZDMeGyxIHz6Lumzgrkl9QT4LiM22Ne/GFrAOIjR4FL
         2BykSNvOIHskDx+gkxQgkm8eH4Agyqv0qCT9SpGuL1VYjHXLZoGJwNPk/x2zU2gOUiFR
         rHxafoPvl0BknQjbdobteTFraYsk2fi8eYbEvUgj+f+fr/EANzTL/Id5KnyBHVE7YtSn
         WXwtBfAzXRd4FZOslKTzllYBMlY22KljfkWGidUS7f3vtFD+cMNWEJAp53tUg5esz16M
         OmgKlmhpfkWtNFsCrJRxnVfCMi3ffD1V6kANdyOX9HKyuPqTFzdGyMMxgw2RW11UyWCn
         Hccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786681869; x=1787286669;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFnJtKJCWIEEeDVMRtp70GTjEuRFU7I+mzBwGLiw1QY=;
        b=G1JimJJfMYTXMATN+HMo40RKuwTv30656qeFw3YHwbpzz37cfqw0uDAhAQSQyquG5o
         JLUCR//UFInZQjZJ+26nszi+0Ckl5D/290/xmHqcVdNC4qiABbCA8fsG2gCYRM24ujk9
         agLuZ6wy9JPBKuBmPH4WLQr92bPFUP1kxFxc+oXNQwcgB69bWAewlFqDSQ3qdNWgxDDS
         C1UUEZrwWsZUdETqDHVw3i5NR0lKXWtLI3nLoSXoUh+q2AmOEiOXkPHLl74abRIoMQOG
         Aqp4b5tiTBmt32yyteHTWrbhYHuej07nR/g1RwyZKZIhp4hIBkchoomGywGT9utcdVO2
         XvvA==
X-Forwarded-Encrypted: i=1; AHgh+RpNWUaYXydFZNQm+vD51g89ITzMZdmOiwJY4AHUt/muF9kHb3cMr0MMWQl+RrKfb6qA0h6EWcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxePwDmegnO9rSD2TXP9/Q93c/CcJIzGmbxBHEaMOCq9Lhg54Xr
	bzVEojnWZW5V3ExRE0ubL1GJnkUyQwTw9mYYmnfslf6b6icDbYNYe0CG
X-Gm-Gg: AR+sD11j/l6dZ/6cGSvXkfAmq+egzJQdqkJTZKG8ZjP17PAWA3qFdTLyUdEU74UXdZr
	6pRKbnBTLtPq9PA9KpiEHRn7gLQ43AqsdK9HF1Lu9/94VRm42f1aawc11CWF+1tyXGBjK9NKBdi
	Tu2gyMzwg8FG3sDJb7tULOn+VyOHREFE5dwBeTGwfSK0obYTBsGbZOzXi4J7RNcRhqwVSU0HWfN
	mOifdNXAb07VffiWWHzVvjhAY/gu6JPEHyUNGIIjy6sHK7yY1Xn+wB0enoD8Si4EDd7iRZ+QGo9
	gndxzCdo6ifYSTRe1l7p4ixpv4IBGyVNKw6TxozjxvHsNVZbH8AQJxwMOqy/AhfgJ9DcpD5RD2S
	2996UR+p6V+CnUPrtcRTayCdHkPCGocG04z34bM15wf5j6F6ev+1/2X4x7bIPRk1WjQbFmAyEM9
	scrolCCInsqeYkEQt/Vz7qecYknJji8ZWsDLP7UArpv2k/DwbOELd0zrv4dkr9/1E=
X-Received: by 2002:a05:6a21:e8b:b0:3cb:eb06:ce09 with SMTP id adf61e73a8af0-3cc71de3b98mr3091566637.25.1786681868451;
        Thu, 13 Aug 2026 21:31:08 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887e3e7sm4283985c88.9.2026.08.13.21.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 21:31:07 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: stefanha@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 14 Aug 2026 12:30:52 +0800
Message-Id: <20260814043052.59578-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <an2KTuUm-mZ0nnDQ@sgarzare-redhat>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
 <20260810134018.143973-2-physicalmtea@gmail.com>
 <an2KTuUm-mZ0nnDQ@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> You can assing vq before the mutex_lock() and use it there too (and in
> mutex_unlock()), as we do in all other places in this file.

Sure, will do.

> I don't see anything vsock specific here. Would it be better to move
> this to vhost.c and reuse some of the functions we have there?
>
> I mean something like this (untested and may be incomplete):
>
> void vhost_clear_device_iotlb(struct vhost_dev *d)
> {
> 	struct vhost_iotlb *iotlb;
> 	int i;
>
> 	iotlb = d->iotlb;
> 	d->iotlb = NULL;
>
> 	for (i = 0; i < d->nvqs; ++i) {
> 		struct vhost_virtqueue *vq = d->vqs[i];
>
> 		mutex_lock(&vq->mutex);
> 		vq->iotlb = NULL;
> 		__vhost_vq_meta_reset(vq);
> 		mutex_unlock(&vq->mutex);
> 	}
>
> 	vhost_clear_msg(d);
> 	vhost_iotlb_free(iotlb);
> 	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
> }
> EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);

Thanks for the detailed feedback. There has been some evolution behind
this patch. The work originally started from a vhost-scsi bug. After
Stefan Hajnoczi pointed out that vhost-net and vhost-vsock might have the
same underlying issue, the first version used a feature-change rejection
approach. The vhost-net patch from that stage is:

https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/

Michael S. Tsirkin then suggested that simply rejecting the change was
not the best way to handle the IOTLB transition, and suggested discarding
the existing IOTLB instead. That led to the current vhost-vsock patch.

The vhost-net patch already preserves an existing IOTLB when
ACCESS_PLATFORM remains enabled, as in patch 2 here. For clearing
ACCESS_PLATFORM, the two versions currently use different policies:
vhost-net rejects the live change with -EBUSY, while this vhost-vsock
series accepts the change and tears down the old IOTLB. The vhost-net
patch also addresses a separate live IN_ORDER transition issue.

I initially kept the helper in vsock.c because I was unsure whether
changing the common vhost code was appropriate. Looking at the code,
however, the IOTLB teardown has no dependency on vsock- or net-specific
state. Unless there are other concerns, I will move the helper to
vhost.c in the next revision and apply the same IOTLB teardown handling
to vhost-net as well. I will keep the acked_features updates in each
backend's own loop, while retaining the vhost-net-specific checks for
IN_ORDER and other unsafe feature changes.

> TBH I don't like this mix.
>
> Why assigning acked_features inside vhost_vsock_clear_iotlb()?
>
> IMO it's confusing. I see that you're saving another loop around the
> VQs, but this code is not easy to understand IMO.
>
> I think we have 2 options:
> 1. leave the loop for acked_features and don't set it in
>    vhost_vsock_clear_iotlb() (less code touched by this patch).
>    This is also what to do if we move the clear_iotlb() function
>    in vhost.c.
> 2. change the code to have a single for loop with if block inside to
>    reset IOTLB stuff if needed. In this case maybe better to avoid the
>    function and move the entire code here.
>
> I prefer 1 with clear_iotlb() in vhost.c, but I'm not fully against 2.

Thanks for understanding that the original intent was to avoid an extra loop.
I agree that assigning acked_features in vhost_vsock_clear_iotlb() is confusing,
so I'll follow option 1 in the next version.

Thanks,
Jia
