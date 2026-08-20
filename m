Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8936DA14
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217099; cv=none; b=HwQBLUwTRJUFClTvOdiJ2hLRYNj4EAX7B7Hl11Fcd87T5kzr50PEqRwYoD0wpDsRKpUAsGVIL0bGHB+ZRAbad6RzVFuVDPmOubhYAYDmSpRg0YlAOEfTX6uUIqqOu3H4dB8ACRWlNkWQ/a0+WUbhIImHmH0YQdNOLxr/Rux0IHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217099; c=relaxed/simple;
	bh=Pqhe1/gUDvPffZ3kxx5/azyvzD1TsrTgTISNWYyFtgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QH7EuTZmi9wLRqyl0CMcKgrFabFCebjq/pKNd5IIGgggVyfYLjSmaj6wVQcVDV+yu1VeiFmb9SxZlp9UN42rCfGhlovoFpiUb/LY10dBH6YeQWDWhyX4abUZ5vvv38OfdD7/sY5ZTYrTjIZLJiko1VH+y61BAV/9suPlzlo7DfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWXg3Nif; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VN5EgLDD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWXg3Nif";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VN5EgLDD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787217097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3/buro2KkWnv5c3F843d2AiVyWVMTzzCYjAgiddcY8=;
	b=TWXg3NifZY9mmJlE88lxFAU/+zTc+yZNGyOYkHtdjI7ZarQNFgKCx3fMwu35Rm4ZQHCcxT
	S5Y/9owXflqk0LT0B33hxejfNS84TNk17rnzZP3mlZmFyM3SHxhyoag5sZ9HtqbxbRfNVc
	+kBj1q5s1MlU35KsqPTzNVvxLRMadYw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-zuSUm8BPO_2FhpB49-sdFg-1; Thu, 20 Aug 2026 05:11:24 -0400
X-MC-Unique: zuSUm8BPO_2FhpB49-sdFg-1
X-Mimecast-MFC-AGG-ID: zuSUm8BPO_2FhpB49-sdFg_1787217083
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47fe85684b9so1825398f8f.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787217083; x=1787821883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V3/buro2KkWnv5c3F843d2AiVyWVMTzzCYjAgiddcY8=;
        b=VN5EgLDDFX2vOytakAjfysoBoH2G+XB+v+dLjx7hQ9SuzELKhvlrU95sVs/wgWEl6F
         mNYr4/CcLohk+0tlermMoZp2iTWeCfKMDoOdEBBdtTPkrFJnq3MiayRR1pfaI+vXxnMv
         G+acpWborldEikVGcmBsnirIFmuXwHMWI2eaYDGOyDcObzZxJ8LJRXLHoQKtDKwoN1RY
         +ft8MBJ0KT4FL7mhPCZFH2GDegRV7oU2uO/qkmjC7lmGlnQYoN+znKpP+V9/62yMip+F
         y0FC0jqrBJdKLphMxY+kfDiyX1b8E+juGldkSpCdngM66Kmz6IB8gW+3e398iEiKqZPQ
         L9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217083; x=1787821883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3/buro2KkWnv5c3F843d2AiVyWVMTzzCYjAgiddcY8=;
        b=XfrvHVbSUURTTpiamUWQbjoWL5pkpMn9Qf3gwxASjJGvua95qMcvhr37tnYMEAK0mH
         Mn/M4fSmIqoNpwMpf8s2ZK0TurutZ16Ienbr7pAJBDF7lgp7U83pQOuBaGGt9Mokbgvt
         niCsGEtw218DyU4qJ4tJfUAETzbTY63xLqzxRI7wPb96JiWfZE3Luzet2YEh7sofwU3I
         iuZubSir3ZyiAiVJ1TwcEOZY5UZH6vFl/HHWgRMaK4BnUC130p65t1dG2CznYC5W2zKh
         /vYIHOKse5piq7P6aKkD6MuJIGylafKxCrWe++TbDVMwUpU2SGu7bTM7sxfjGEo+pWpF
         tAdg==
X-Forwarded-Encrypted: i=1; AHgh+Rp46pJmJ0CPX2OpQpCU11xZGCwVDtcZDfE8HeSjpdAAQ86pv1uYZqnNYSjsReqf/Tl8ar+2YMk=@vger.kernel.org
X-Gm-Message-State: AFuF++k5RssHovDqXATCZcnio8/+gJpHQq7f5QK//ph1chXehLQU09BC
	HQ1c7U5nu5udQroU43yP6+V7vJlSp7184JGcNP1GX/B32RAV+Q15ozk1aOIo7AosNDOyl7RIaB6
	d18+9FZ84ZnQQOvBWUi0EfOE+olSM28JtMReeWHhYCabLLgVo4fDlQqUHeA==
X-Gm-Gg: AR+sD11NSyfOO6ODQmFBmfjedGdtTucwxopiG1WbL6tsYcuL9wKsa5K2+uc+2Dq4bEe
	Ttcb6fDU44nGfTin0JRi3+GXGxjJ5Awm2SeCj6M8GN4ICETJEXYxveicEeZ2n3EpoklEqD0BvRj
	GEm/00AXez4uuvUv43key+Jq7PxiqKYaI8Js7VHTuEu+lT2UqxvFiO0/h+Sq8HVHw6rEFMoOUAJ
	hjzduwdvhf+5j63+MLiP4+FT6zFSn1GnNj9XILeOBOrhuoPl/FEmhJ1ReK9izkvkGZ4ajiDtPGr
	YfDpFshWFqePmCfxRh3K6SQJuaLC19vwt+GFezJbHbCjut/zkicaXf30REEhnIuLiwa7rmI8uxi
	eW/93YPnZQ1gJ8HK1MFJvZYZTNSKKdgoLs7FzHjKt05DsjKXQcQjL
X-Received: by 2002:a05:6000:310f:b0:480:ca53:280f with SMTP id ffacd0b85a97d-482b1e844cfmr18067506f8f.2.1787217083007;
        Thu, 20 Aug 2026 02:11:23 -0700 (PDT)
X-Received: by 2002:a05:6000:310f:b0:480:ca53:280f with SMTP id ffacd0b85a97d-482b1e844cfmr18067399f8f.2.1787217082530;
        Thu, 20 Aug 2026 02:11:22 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8038sm10520293f8f.20.2026.08.20.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:11:21 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:11:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] vhost: invalidate vring access on IOTLB
 transitions
Message-ID: <aobCds-JDgs3BiSp@sgarzare-redhat>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820080332.313933-2-physicalmtea@gmail.com>

On Thu, Aug 20, 2026 at 04:03:30PM +0800, Jia Jia wrote:
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
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 53 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 14637cff0bd4..31fff9800045 100644
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
>@@ -1918,6 +1929,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
> {
> 	unsigned int num = vq->num;
>
>+	if (!vq->desc || !vq->avail || !vq->used)
>+		return 0;
>+
> 	if (!vq->iotlb)
> 		return 1;
>
>@@ -2287,11 +2301,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> }
> EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>
>+/* Caller must hold the device mutex. */
>+void vhost_clear_device_iotlb(struct vhost_dev *d)

Is this the right patch where introduce this function?

IMO should be introduced when we use it.

About that I'm not sure if it is better to squash the other 2 patches 
with this one, otherwise will be this bisectable?
I mean with just this patch applied (and without the other 2) who is 
going to free the old iotlb?

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

IIUC after this patch `oiotlb` is always NULL, can we remove it?

Thanks,
Stefano

> 	if (max_iotlb_entries <= 0)
> 		return -EINVAL;
>
>@@ -2307,7 +2358,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
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
>-- 
>2.34.1
>

