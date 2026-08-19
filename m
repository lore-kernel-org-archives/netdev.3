Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E32192FA
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148595; cv=pass; b=dHBWbsZ5yBEG9nectPjLmZpMXxzK3TtkuQS9qYac8K6+oR4r7R35dY+vDDAuntr8MtF6m6I3Osk7Hu/TUXqgtu/Y9yQh7FsHS6dB0CPuulNG/AcrtudHpUqOsrH+bOuzUvw0YDVvjMqCjFRMVs3e4qJaL8+5BrvM+drOqMI1WlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148595; c=relaxed/simple;
	bh=mQJhKOEjw9O3sNOjoGU+M3F8LtVcSFzmDVvu0spcCd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtOrZP5c08vdCSfncC67p9HOZQONx4Y0pecVvQStNccQ9nzB8PUyJAZqzrV+7JhRiqvBmtfdQeAUUgCorJBdtOmBZ+x1dz0CaMMkL/lvMOKwq1p3BtGHnIYcb8dR7xr3Ti6/lh9mUlrG7EBhyLnzqjF4BXsD6yvq2ZNGHoVRdGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkcJpyf3; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkcJpyf3"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930f4e5eed1so73194085a.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787148592; cv=none;
        d=google.com; s=arc-20260327;
        b=NpNkv14Ok7BFcSLUmXD878T/mVRal3lw/E+Kh8+vt0+U6JiB4KCHagPL/VyM1CMtYB
         YoetgcOCCx/Q6MNIBqtTR+Lh72MbkX2ZdFoPJC9aOf08ZJmZeUHvD1coY4XgqgjksL1G
         CLQZqpixGE7QqBJoeXV9uAf8mm+rBBPlaM5warLOmqClTlCO0chZWVTI7SD2iZER46j9
         yC5oozb7k9vm4iiksxCLSHH9jGJjTpkQMGDdis7pWPRSjNXwTN3iGia/GplMmfK9Dl0q
         J7VjHik4FEMifM8EKXVNbFWAckNNfkWUxly9TOIQvmX/EYOJ4jRHxGnJ8wI9u/j6LSCQ
         xp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3K0kn1fHbJEcdZDTCVctcTgJzJz/9hoM0nwTQCh+f8E=;
        fh=+DKtr5cbhmlzHiq7Xr24YZr5bZw1rLu92iHAJsEjlck=;
        b=aveL9rMXdCB/FOE2JtDxzcJLN9JV2F9vUFNbQbf6WOL/RbtV9YLPTtpDs65oxXsV6b
         buHMMqyvuMv89FNJPX4/+RpUUjzQmJGFTDiH9xhIDGsqR0asjRKnyavnZtGvL6SCW2Re
         t4MH27hcYsm7fzAWZHbSQ6mSbie1tMo55gnPioqjPX8TgtSzJDxWFquPuCBhiTWcVWYI
         2gDHB0nFPs+Q563pwWCMhTL3vKvgbS1wdAqpTiUlMIt/wkhSwJNoh9TwHj5THD5H/o1x
         RapMXWkgFGOGNrSezs5K20h/0fAfoZnaeeAomFZ8EFUnRfjhTW78pZqsriU6/vObv4yM
         7CyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787148592; x=1787753392; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3K0kn1fHbJEcdZDTCVctcTgJzJz/9hoM0nwTQCh+f8E=;
        b=gkcJpyf3J3p6BFsKympMW9+6ubgXYD/0yXt/Wo3eQyE+bACdgsXfJquQ+ZLqsUL3D/
         fQQKASBYvm7tLPpxfsaA8cU9hJ/OWAhCrJSAFCbkdtE7HR0p1PTKFbYPZgPWREgrS2oe
         4wqO4Fo5O3+KK8Hir9B+5j08VJxzpYuwyU1zv5JM7iEcjPH9xUTlIFvhSAby9brzi600
         1BI0Oa7cZBjWbfHafqC+kZeuVw6+sP+mxEb+vEmE+LaL4b8K/rfo4jiYHFqGDh2d/iVH
         eWiFy3pBOHuKEoQG/dTROxDOhp9ivfAsR9ecLaU9cqY1gr8w1qf9oXunaTsmMeUseXAj
         Dhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787148592; x=1787753392;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3K0kn1fHbJEcdZDTCVctcTgJzJz/9hoM0nwTQCh+f8E=;
        b=DJ1LlrNd8UMGOPldea17sqmoZOmZQ77hMQMQGnoXnBERsi3iwndNOxs7mU4xcm0CFT
         iMZqyZrn9nsDu1dtVnCV0EKS/PGi8AklOk5u2v74vkOOEeXUocslzttm1RV6gQF+LS5H
         VrX+eBBRUxRuCbqOamuXq0CtO1/cbG9yhQW4cXDSD8Bg/0vQ5Ou6PZAgxsv8k7+r28zm
         1rfMfxMDPd3u051tYk3VeemYqwYpa1g3IATN+lDe3aW4E/nL1WfvxyiMsOZN01sciC2P
         ROoN/FK4NJtTQqMOD1UH8gnjycVCe011+R7uCQV5PirK93CbJ4wDRWotp5eN/9Pkf6l3
         dOWw==
X-Forwarded-Encrypted: i=1; AHgh+RppW9WRFWdRH/u1XmxZMGB91dspAFdqXJqsl//hfLV6zldQZgAg+NbJNGhSso5fuiNbCtr9/X0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtr1EVxWYtortjkDyqJmCMGTUY476XxXMfsie7AHycpzA6b4y+
	u3YzgOuWVkyAWmZtxc3YxhNQ0EWzOE2DWwmKjku56TKvs5vVLIVlFyXwtQR9ilLNt1mi0UlC38p
	+MaFR7rIHGqkLLotthHIZCUn8JDW5RlQ=
X-Gm-Gg: AR+sD12DJuvsvdhZEySAvHLGOVkHTsH/Z43cfYfXMt8FV55cIsWzxpZDMcuWU5QVfm2
	UcyRkbKMmuolDXVYX+52c33p3uearxpmW2kICxNWGjiuSylR77AjqXXV9QruUOLStN2sVCZ1XKq
	XApPLkEKWeoCl1PD3tAO9A/4ntRBuvCzhtWKrHPcVCJjbjRW1apWpdwPyFRJAE7jg2s8yOojUHM
	9VBQXNV9NEa5cAf5zsrW9imuwqzi+rBle3HFrQ7WO09cL74j/dJ+6Pt2lrZkYE2UknzmHwTm2Ux
	VIDOJ+bLrb18lFocUe0YePk/HsbIQdaK+HxbMZGGGcOyKw==
X-Received: by 2002:a05:620a:6989:b0:915:6a2b:6265 with SMTP id
 af79cd13be357-9371e67768fmr433513185a.44.1787148590518; Wed, 19 Aug 2026
 07:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818042613.281125-1-physicalmtea@gmail.com>
 <20260818042613.281125-2-physicalmtea@gmail.com> <aoVkRe_BN6L_5XZn@sgarzare-redhat>
In-Reply-To: <aoVkRe_BN6L_5XZn@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Wed, 19 Aug 2026 22:09:13 +0800
X-Gm-Features: AcwNN1Wyv_sTsBQBf0-FqnHUDP5OfgUj3xn0SY-WfGW-HK_cGsBtdxAB-mDAfmg
Message-ID: <CAJwVaML_qrz3hu-7ZyFDEz2M3vAsGPnmNua35dAgn52E+jOxUw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] vhost: invalidate vring access on IOTLB transitions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	stefanha@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Aug 18, 2026 at 12:26:11PM +0800, Jia Jia wrote:
> >When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
> >used change meaning with the address space. Clear the cached vring access
> >state when the device IOTLB is installed or removed so stale IOVAs cannot
> >be reused as direct userspace addresses.
> >
> >Keep device IOTLB initialization idempotent and apply the mode change even
> >when a virtqueue backend is attached. Drop the device-wide IOTLB first,
> >then clear each VQ state under its own mutex, and keep the old table alive
> >until every VQ has completed the handoff.
> >
> >A successful live mode change leaves the backend attached but invalidates
> >the cached vring addresses. Userspace must configure the vring addresses
> >for the new address mode before data processing can resume.
> >
> >Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> >
>
> Please don't leave spaces here!
>
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> > drivers/vhost/vhost.h |  1 +
> > 2 files changed, 53 insertions(+), 1 deletion(-)
>
>
> This patch doesn't apply, I tried vhost tree, net tree, and master.
> On which tree is this based?
>
> Stefano
>

Thanks for checking. I confirmed that v6 was generated from an older
local linux-next snapshot with local changes on top,
so it does not apply cleanly to the current tree. Sorry for taking up
your time. I will fix this first. Thanks again.


> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 4c525b3e16ea..9f74537b1c1c 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
> >               vq->meta_iotlb[j] = NULL;
> > }
> >
> >+/* Caller must hold the virtqueue mutex. */
> >+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
> >+{
> >+      vq->desc = NULL;
> >+      vq->avail = NULL;
> >+      vq->used = NULL;
> >+      vq->log_used = false;
> >+      vq->log_addr = -1ull;
> >+      __vhost_vq_meta_reset(vq);
> >+}
> >+
> > static void vhost_vq_meta_reset(struct vhost_dev *d)
> > {
> >       int i;
> >@@ -1911,6 +1922,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
> > {
> >       unsigned int num = vq->num;
> >
> >+      if (!vq->desc || !vq->avail || !vq->used)
> >+              return 0;
> >+
> >       if (!vq->iotlb)
> >               return 1;
> >
> >@@ -2270,11 +2284,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> > }
> > EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
> >
> >+/* Caller must hold the device mutex. */
> >+void vhost_clear_device_iotlb(struct vhost_dev *d)
> >+{
> >+      struct vhost_iotlb *iotlb;
> >+      int i;
> >+
> >+      iotlb = d->iotlb;
> >+      if (!iotlb)
> >+              return;
> >+
> >+      /*
> >+       * Drop the device-wide view first.  Each VQ then drops its
> >+       * per-VQ view and its cached ring access under its own mutex.
> >+       * Keep the old table alive until every VQ has completed this
> >+       * handoff, since a worker may still be using it while waiting
> >+       * for its VQ mutex.
> >+       */
> >+      d->iotlb = NULL;
> >+
> >+      for (i = 0; i < d->nvqs; ++i) {
> >+              struct vhost_virtqueue *vq = d->vqs[i];
> >+
> >+              mutex_lock(&vq->mutex);
> >+              vq->iotlb = NULL;
> >+              vhost_vq_invalidate_access(vq);
> >+              mutex_unlock(&vq->mutex);
> >+      }
> >+
> >+      vhost_clear_msg(d);
> >+      vhost_iotlb_free(iotlb);
> >+      wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
> >+}
> >+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
> >+
> > int vhost_init_device_iotlb(struct vhost_dev *d)
> > {
> >       struct vhost_iotlb *niotlb, *oiotlb;
> >       int i;
> >
> >+      if (d->iotlb)
> >+              return 0;
> >+
> >       niotlb = iotlb_alloc();
> >       if (!niotlb)
> >               return -ENOMEM;
> >@@ -2287,7 +2338,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
> >
> >               mutex_lock(&vq->mutex);
> >               vq->iotlb = niotlb;
> >-              __vhost_vq_meta_reset(vq);
> >+              vhost_vq_invalidate_access(vq);
> >               mutex_unlock(&vq->mutex);
> >       }
> >
> >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> >index 0192ade6e749..3c75e8089373 100644
> >--- a/drivers/vhost/vhost.h
> >+++ b/drivers/vhost/vhost.h
> >@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
> >                           int noblock);
> > ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
> >                            struct iov_iter *from);
> >+void vhost_clear_device_iotlb(struct vhost_dev *d);
> > int vhost_init_device_iotlb(struct vhost_dev *d);
> >
> > void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
> >
>
