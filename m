Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF7443A9B
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229574; cv=pass; b=SH8e/MHHownsPyLJkuKDuIzFNaDOgu7ofq85jyz9zhwwaRqjexhXAnEOAYh3WJL1+yerhIIAgnpucUBiiTrLpzGV6Z2QyzJBriNCngX8LuO64fa4zVYi1td4jyNBnHSqnhNtzQG/bJS1nfIMTwMFRYrWq7v3QkXzVWeQ00owOkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229574; c=relaxed/simple;
	bh=aL5TuuMwAaQVwOyXsLkpLSm0ZpL31g9SvuoVklTboFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAmUIzOqpwGNh3Cgt3gHEto65ae++wd0b8d3RLMckEw2hM9NI2RpoxYo3QQG9SyVR6TQ3gqpLxj8Y3+BuVdM/I5dTUyA4hfNyehP6VYawmok6cqVc6nLCBr8av/bCDZwpaQ5iPYXoe5SO5veKWs3hq2hEqNlFgtIzMVQg+PIXQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHFdxZCm; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHFdxZCm"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-936c02e58dfso151248685a.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 05:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229572; cv=none;
        d=google.com; s=arc-20260327;
        b=oCXEYWKkangnnhcZw+DXEXVfCuHOIPwdINUpeVXQZqAl8+286kKLOWH7/BZ1y0XunD
         tVU7Fmo1HMPUX/xhy58Beh/ypm66eANHGR6pP9LHyIPkIeLasB1u6qupN2QxtFH2xopQ
         43g02fsJnX+J4f7sl2B4YnM9UOsiek9PDNTH3SZo4Wzoj99ySs3JXQiGzFnucbCDDwW6
         ZNdsf8vYYF29bYEd7b0hiQ40DKe3agWE12GUcPgFjU2F6+9FaBSeS6Y6p9oGAw/LPaMp
         WvMppv18kxF/7b5phz0jarH/qRZbf/zjregChZzAyomhJVyxcmsrhINasV1fDzILv0A2
         s9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uohgdUdRgrY842N3nbUM8yhr+cf5Gqn3ftN8ZqqRYvM=;
        fh=tU/Qi2ibts59Nn907SoWKP4SN9B88KH6tjL2MOZi//Y=;
        b=Q05c08PN+I0cDUCotS4OgSCgVwYaaANdUvsqi95BZZP3+WUdlhtrGV8k/g7TZxKlRN
         qhtcUD/xdTJRSdiVHTbi17SZ63keBN4HzV9fsmSga0WRm4LqEW1q7MKQyAfSxYcgraO1
         xJ9z5WlQdEW1g42g/QAO9kL6In17ncEL2ulzdDavUUX55VW41mdHk/7M/n5C6XAACc4X
         gbrSW2HX4SjCZxzcS/uJHX80uQK1xvIKYINQBhekWoKonFrS9GJPs3gmboGVCz51u0/R
         1Yjpi42GoDb9/PQoGzpoo8XDpgPLKAryv/oP8jqIi0+CUDBVWxLr99qI1IZDbfNMsBCd
         1pkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787229572; x=1787834372; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uohgdUdRgrY842N3nbUM8yhr+cf5Gqn3ftN8ZqqRYvM=;
        b=PHFdxZCm2Dmv5fzgK/Y4Z3EnFWqeIPggZptGYjJ77AfC07SRxeVOGct9jYrvS16igd
         6IYMQ3KzzINLdo0dmGcvUxKDNOxpn50JLaGEG+yqKjWTN2UhtjegyFgu3m/+lnEX6mZN
         3+mvxoArlHfGc+C8znUTdjf18aQbJASVwG8lE41dwDply2elorcQku9LLaTxd2z1BKuM
         h/B1B8+HJA8/JTA4x4L1BW3dKH5Xe1/RGVwKWPzZGtQCICe0ngFEn8CXv4yuj/mPPmtN
         i4huB9c2+i0njLuzgbcSmizhQ/kfTWlb5alZzZotI5mmU13XQy6Dzkye3APyUWG97FM6
         cWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229572; x=1787834372;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uohgdUdRgrY842N3nbUM8yhr+cf5Gqn3ftN8ZqqRYvM=;
        b=cSmixrNZmTGiH5LDBvXHKCJs90mSpoFBkBayzvgG7uq+ToFJEb9FH8+XMTocn6XolD
         /RjQ4NaRKK4Pai8P865szUXYvaE9UKwr4/kdex8F9Bp0FGlL+Lh6BDxp9xuyH8IWTsN/
         hefAj4jPpoRciPxs0aVaTVxRK74cAf0AFwhZuDPMYB6hjllVbEKQjsg+E7WTzWn1ef3H
         R0Vq34JRbcpWt1I6ia3qFppIJs2KoT/dH7SEKi0I4v2utBwFP2nLOxRnT8zUkegy0RRp
         BZEDKHUd2t1e83mCltveUzVOP68M9PqcfET2QWgdcOBou6KskGTub+/ZYGxmy4Nu99at
         qiEA==
X-Forwarded-Encrypted: i=1; AHgh+Rqt3l7YWVJsvx3kwF1EhQms1w2E1gUxH1bfe447BQGAmu0G95g2wz1zqfu7lJ7yN4TIrULCULo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbHpWLa0BTogwLFvIjOssFZ2qjiWg7XnJ1KzvvVSH5Y9AH11Kn
	F1wQ4L8DXuC8cd+cUXIbzcQiQ3UdQShaZhEAB7dADrKp3m7JGBX+c3e395WeZqn6wV6xkpNEjbi
	uAKXUESErNB74s6CMzSb4IuobBXeXYbM=
X-Gm-Gg: AR+sD124Yn4/30ymOLTd8LHUp9hnb72UVpdoqOndw+IvBMhRetbl4EMGP4VNcfz34Zk
	u5rfsq9h6O7I8n1aU2Nqz8ggxZ7c6Aiq2TnsOXS5oFIQMYoskckaCPHO5ooM1BEVv1CyQVoP9IY
	dreKGkA3i1EUgL9QIUBdZJ7LadewHxWdAll2HvdEUQPas2HBDWbF5/UN4yT2Gjt5wKt2w5Ed03+
	ntt3LcyhFTAx9THLJngAM6T8q6jl1I3+68CrIEzo7dqAYsSHetqcmAb2msPufRJhVcNdZvsulNN
	mBAHFeQjmQEdwX7CcJuGLPZ2n04K9i+r7AIUQ4N7Zp38617tuoOHgeM=
X-Received: by 2002:a05:620a:404a:b0:92f:199:b035 with SMTP id
 af79cd13be357-9371e252a0fmr1102568885a.3.1787229571662; Thu, 20 Aug 2026
 05:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-2-physicalmtea@gmail.com> <aobCds-JDgs3BiSp@sgarzare-redhat>
In-Reply-To: <aobCds-JDgs3BiSp@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Thu, 20 Aug 2026 20:38:55 +0800
X-Gm-Features: AcwNN1V_ozKiep3YvThC-YsxIdIa8Rks0gJmRuoU636bafPM8R_uE-RRSwSYMDM
Message-ID: <CAJwVaM+WZhw_GCfqcEkNpe8vsTmW_OSRpiQVBXR8cpuvWiTjmg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] vhost: invalidate vring access on IOTLB transitions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Thu, Aug 20, 2026 at 04:03:30PM +0800, Jia Jia wrote:
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
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> > drivers/vhost/vhost.h |  1 +
> > 2 files changed, 53 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 14637cff0bd4..31fff9800045 100644
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
> >@@ -1918,6 +1929,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
> > {
> >       unsigned int num = vq->num;
> >
> >+      if (!vq->desc || !vq->avail || !vq->used)
> >+              return 0;
> >+
> >       if (!vq->iotlb)
> >               return 1;
> >
> >@@ -2287,11 +2301,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> > }
> > EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
> >
> >+/* Caller must hold the device mutex. */
> >+void vhost_clear_device_iotlb(struct vhost_dev *d)
>
> Is this the right patch where introduce this function?
>
> IMO should be introduced when we use it.
>
> About that I'm not sure if it is better to squash the other 2 patches
> with this one, otherwise will be this bisectable?
> I mean with just this patch applied (and without the other 2) who is
> going to free the old iotlb?
>

 I'll rework the series so that the helper is introduced together with
 the vhost-net and vhost-vsock callers, most likely by squashing the three
 patches. I'm also reviewing the existing IOTLB replacement semantics
 before preparing the next revision.

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
>
> IIUC after this patch `oiotlb` is always NULL, can we remove it?
>
> Thanks,
> Stefano

  Thanks, I took another look. I don't think we should simply remove
  oiotlb while keeping the early return, since the early return itself may
  be too broad.

  One case I need to examine more carefully is vhost stop/start. QEMU
  unregisters the IOMMU listener while vhost is stopped. If an IOVA
  mapping changes during that interval, preserving the existing kernel
  IOTLB on the next VHOST_SET_FEATURES may retain an entry pointing to the
  old HVA. A later lookup could hit that stale entry, so no IOTLB miss
  would be reported and no replacement update would be triggered through
  the miss path for that IOVA.

  The original replacement path, including oiotlb, installs a new empty
  table and safely keeps the old table alive until all VQs have switched.
  I need to review this lifecycle more carefully before deciding whether
  that replacement semantic can be removed. A logging-only feature update
  may want to preserve the IOTLB, while a restart boundary may need a new
  one, and d->iotlb != NULL alone does not distinguish those cases.

>
> >       if (max_iotlb_entries <= 0)
> >               return -EINVAL;
> >
> >@@ -2307,7 +2358,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
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
> >--
> >2.34.1
> >
>
