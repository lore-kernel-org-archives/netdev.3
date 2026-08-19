Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4F3F7884
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126956; cv=none; b=GWsVON+W1RM9QvItRuF43Djt8+d3F9ybUqAhAyzI6ZUHUx6BXLksNwXyTQjLyLKB8Jfn20S71Kon4BfTi3vwjtz2bFdKHuHCOA41GZ8A2K2t3Kt1me2wimRK/J6+P5wnf8NDNxiyt3n3vPEM1iSwbIWIqho0WwPVapcX0tKi4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126956; c=relaxed/simple;
	bh=j+gVWaBheHtgcMbGe74/jYIUWmpVeo4REI3joDdZInY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxnfv2GWa2IgAwunIIAGuGozg8t+ExI5B3A+dwzHuSkOJsniAUaEm6xy1ZhvU4LzCNQjp8V75h1tTpTDJISrcmB48zsKOMYopdweuDdYRJ8lNezUJ+8q9qgznORVoYs6+zOLLfSkZBl83P4xjRcUZDX86yzoYrNluiQwjxWaBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVBJTL3c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ocxDZE/j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVBJTL3c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ocxDZE/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787126954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nxIGNpX1bEb8ZoU7IALqEmofFiDxquDbYKReTWVCnAw=;
	b=FVBJTL3csZWvfO7fUFs3z0+Co2ydTF7OBCJZ0ocEZLtZ0bfFpOHRU7vqW2XcMQCSM+WK5n
	B/x4bdtsrhDQVjvTJyEH4ZElLXykdY/euG4vGsl/GqBZTLYtZ1D78bSmHPyf3xfeWfEBKm
	Zu0T6wfVJY4P/pIZVm8+mZwvXVJOwwM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-BT9NPvg_NWCn1VPZ3MjK4A-1; Wed, 19 Aug 2026 04:09:07 -0400
X-MC-Unique: BT9NPvg_NWCn1VPZ3MjK4A-1
X-Mimecast-MFC-AGG-ID: BT9NPvg_NWCn1VPZ3MjK4A_1787126946
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so6451625e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787126946; x=1787731746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nxIGNpX1bEb8ZoU7IALqEmofFiDxquDbYKReTWVCnAw=;
        b=ocxDZE/jBYRUubeT25u82XQO367Fbvu+S+tevEZkn5BP3rMSZqL9fjHQYO+vm/awZ6
         fTTJQHa5daT98enzMWDntj93FZdzyG6BSvARXUqlauTDfc/937ENssB5fPPl5Uy+d5lk
         3nP66fVVizQEqfjUtj648sFgQgDiuoWzAgRDhyUWvKMo8WHHrb+tSOha/vxfROrWJ/JY
         LXTBgP6DrDQK6KXOKjPIu0g/ztyD7oGir0qbaffqPiFCteqbJr6SVJktjlJ6cCIbYBFJ
         T3/RV7nh1GyxH9c++f+20jz0erPA+J5u7cNiIwWP5HlL0v1neGyd6mghW6KdRVmuGWm4
         tALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787126946; x=1787731746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nxIGNpX1bEb8ZoU7IALqEmofFiDxquDbYKReTWVCnAw=;
        b=Wz+GRPMFroLOh/bki5XMYTM86u2e27uf/Ghm9142z+KqBrq94epXwWeOha8hH2RN+f
         Mu2ZjXRBjA3oEeMQ07wGJCRDg3fffpkPMPwPzSfhzqZZcNfDJ9ODG19wLtIonjAtH9yr
         b90NtmkRPKrvuRCZrbqK287LvKbcCAPcxUPhtkk+kJ/D80qbaXbmXkAAts21euAfxjGw
         9IlXXvPvR7pr3/JINvZJqkxXPYdThojeclXu29x1GJ5Pc8mcatNtQhufi4DH8KotzXEX
         3FRuuPptB2ClzG/IJIzxSMTLEXjwrrsULAu6y4+pt52qJSX60K96xTVQ442XZtvuS0tE
         OsEg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9TlxuE59HTDFXiqSNZzKbkH+ncur807fLTX4t0puVi2PUdxdzutBCI4LA8S87IF11xVJoJmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8VW8PAF4VNjK+pOBNrwHXuhyGgMft6J/JoZXdTPlDZN5IIJK
	O+snDHPKgY0GDkQAEtUaY3YtbuP43i6ILb7U0p2O0HGP0ZPiWzCL1lt2jPucnSBzDFbS43zJ6YF
	QZqpJeRxvm0fYJRGn7UUFgR4v9oeSu5EzOBtZXDG+L5p8+W+H6r2C75J42w==
X-Gm-Gg: AR+sD12SxruliG8BgcJrbGLJSC1zou9wAa/z7AMkXQ1NTZJa3mU6e4qfoIB4nbz9Ztf
	5I0kTib72SpsJKoew6hbiAMwGD3Tf427jc0OyQrrne1Rf7q4HYFKXopTc9fezJv1avJpeLV0jQy
	Z/d8sjKRns5c8/s4YsANGg5JoUZHxKje3mM0vuRVlHMGUy0FcooHnbp+jJpiwCI9aENjlJ6qN1A
	x1YeKfxIad6c4jMrnhUnfPRiwp2SFMH8tA4HdRcbWQ327EQPoDm03wbYNlSuSXQfGnvuFW0EuTo
	4RSXIBK7jPzg6mbUdJO6DT+PYY/cFMzE+j64orLH5FHbOdUPQ/eKjNrlZdLQRRBTblt+EmF5AM1
	08N3XQ2fZ7++jl2Kcezg5ilXnaGdHJEM7/rv6psLIyyD12KsS3fgd
X-Received: by 2002:a05:600c:a42:b0:499:484a:98e7 with SMTP id 5b1f17b1804b1-499aa1ef085mr46678885e9.14.1787126946075;
        Wed, 19 Aug 2026 01:09:06 -0700 (PDT)
X-Received: by 2002:a05:600c:a42:b0:499:484a:98e7 with SMTP id 5b1f17b1804b1-499aa1ef085mr46677575e9.14.1787126945570;
        Wed, 19 Aug 2026 01:09:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e00bddsm36778675e9.3.2026.08.19.01.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:09:05 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:08:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	stefanha@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] vhost: invalidate vring access on IOTLB
 transitions
Message-ID: <aoVkRe_BN6L_5XZn@sgarzare-redhat>
References: <20260818042613.281125-1-physicalmtea@gmail.com>
 <20260818042613.281125-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260818042613.281125-2-physicalmtea@gmail.com>

On Tue, Aug 18, 2026 at 12:26:11PM +0800, Jia Jia wrote:
>When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
>used change meaning with the address space. Clear the cached vring access
>state when the device IOTLB is installed or removed so stale IOVAs cannot
>be reused as direct userspace addresses.
>
>Keep device IOTLB initialization idempotent and apply the mode change even
>when a virtqueue backend is attached. Drop the device-wide IOTLB first,
>then clear each VQ state under its own mutex, and keep the old table alive
>until every VQ has completed the handoff.
>
>A successful live mode change leaves the backend attached but invalidates
>the cached vring addresses. Userspace must configure the vring addresses
>for the new address mode before data processing can resume.
>
>Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
>

Please don't leave spaces here!

>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 53 insertions(+), 1 deletion(-)


This patch doesn't apply, I tried vhost tree, net tree, and master.
On which tree is this based?

Stefano

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 4c525b3e16ea..9f74537b1c1c 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
> 		vq->meta_iotlb[j] = NULL;
> }
>
>+/* Caller must hold the virtqueue mutex. */
>+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
>+{
>+	vq->desc = NULL;
>+	vq->avail = NULL;
>+	vq->used = NULL;
>+	vq->log_used = false;
>+	vq->log_addr = -1ull;
>+	__vhost_vq_meta_reset(vq);
>+}
>+
> static void vhost_vq_meta_reset(struct vhost_dev *d)
> {
> 	int i;
>@@ -1911,6 +1922,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
> {
> 	unsigned int num = vq->num;
>
>+	if (!vq->desc || !vq->avail || !vq->used)
>+		return 0;
>+
> 	if (!vq->iotlb)
> 		return 1;
>
>@@ -2270,11 +2284,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> }
> EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>
>+/* Caller must hold the device mutex. */
>+void vhost_clear_device_iotlb(struct vhost_dev *d)
>+{
>+	struct vhost_iotlb *iotlb;
>+	int i;
>+
>+	iotlb = d->iotlb;
>+	if (!iotlb)
>+		return;
>+
>+	/*
>+	 * Drop the device-wide view first.  Each VQ then drops its
>+	 * per-VQ view and its cached ring access under its own mutex.
>+	 * Keep the old table alive until every VQ has completed this
>+	 * handoff, since a worker may still be using it while waiting
>+	 * for its VQ mutex.
>+	 */
>+	d->iotlb = NULL;
>+
>+	for (i = 0; i < d->nvqs; ++i) {
>+		struct vhost_virtqueue *vq = d->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		vq->iotlb = NULL;
>+		vhost_vq_invalidate_access(vq);
>+		mutex_unlock(&vq->mutex);
>+	}
>+
>+	vhost_clear_msg(d);
>+	vhost_iotlb_free(iotlb);
>+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
>+}
>+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
>+
> int vhost_init_device_iotlb(struct vhost_dev *d)
> {
> 	struct vhost_iotlb *niotlb, *oiotlb;
> 	int i;
>
>+	if (d->iotlb)
>+		return 0;
>+
> 	niotlb = iotlb_alloc();
> 	if (!niotlb)
> 		return -ENOMEM;
>@@ -2287,7 +2338,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
>
> 		mutex_lock(&vq->mutex);
> 		vq->iotlb = niotlb;
>-		__vhost_vq_meta_reset(vq);
>+		vhost_vq_invalidate_access(vq);
> 		mutex_unlock(&vq->mutex);
> 	}
>
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 0192ade6e749..3c75e8089373 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
> 			    int noblock);
> ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
> 			     struct iov_iter *from);
>+void vhost_clear_device_iotlb(struct vhost_dev *d);
> int vhost_init_device_iotlb(struct vhost_dev *d);
>
> void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
>

