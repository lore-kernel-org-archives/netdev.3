Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8BE3FE64A
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694319; cv=none; b=X64hfeMuITJbOgFtJIZbj/9xYIObAgUV/k3ngML6/NZIynnBgqIozlaFCqYRQ77gddP+kgAax8DF/0LJhRPfqG6a+lMIH8Nxs1Wh025N+EmuwTwyrb4IzLJ4vEngLYA/+NUj2d3G3spCAPQE1E32RkG3cDhfscTp1CTj/2qgy6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694319; c=relaxed/simple;
	bh=8Kg+ScAaOCNrKwZS1J2hG59QX910+I//yXlSdISGGjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4VRxhAQZWJgpy5nTn73G7iMBoeszAp8ZAq3HLQaeWi41mM7zC5O76FnDQSKcvB0lojYS6rWGAm7TIYpmJR+cJ+qGMtvLSEwWx6a0oEwR5ubaEgsafctps96KIcZkWoXvZRje8oFRJ47kqxyDeVFZV/H1nCiFbjiCUOdX9JQ2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WArXOc4B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0BPZw2N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WArXOc4B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0BPZw2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6DbaUyw6sKBLiPUz6jcZXnW/SRgc1JH0+Ui7OIR+bsA=;
	b=WArXOc4Bhw9+bEq0GAz4sYhVxLlsyJS4myD4peh85HC4JnC9EfUOL/P4m1o0UW7/xZjLuq
	211qGsOxjh5t7NoohFCNpOcCGN2FcyN20gh2NI3tYJrPG3i1QOXH66SzF0DafnnMlNDKnn
	D/IHS2TV5/qcdF4oTN1o0s7RgYRWg84=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-k-o-ZTm_MPyENKEi7jEsLw-1; Fri, 14 Aug 2026 03:58:35 -0400
X-MC-Unique: k-o-ZTm_MPyENKEi7jEsLw-1
X-Mimecast-MFC-AGG-ID: k-o-ZTm_MPyENKEi7jEsLw_1786694315
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso5573835e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786694314; x=1787299114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6DbaUyw6sKBLiPUz6jcZXnW/SRgc1JH0+Ui7OIR+bsA=;
        b=R0BPZw2NCcTfdCB6fl2h9jW3Adxaqi/qjaO+0Wa6PHvDKkuc1f/u35vu4w9bJ+CemQ
         RWko/FdmZjo/NbbyPnjuY2rF+Yg9DfRZgWMHIh4wXsznUkxlz7bBcP3J3sxkkiTjb3s8
         LI8L0hNdTXEak31/LLIGvJIdA0RxqBr85mOzHFdfvQue91373j6Ly2lTvG+YU0hB7pRT
         ol7IWnGFaRiGofgzqHDUGl5/MrUQQcrcoWklUrEGXApLHjQ1qz5LI3U/h5vp9j+VgrwA
         hP1kfp6WFFkMWKph6XN/+MonQ4f0oGhINMIboCJ8CUbDdo/a0VaEAAvrl1XoyXzVapaR
         wfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694314; x=1787299114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DbaUyw6sKBLiPUz6jcZXnW/SRgc1JH0+Ui7OIR+bsA=;
        b=Hdq0JyBtO9qUR6dKwt8pDjNh/rXCfxH/yD+OX/7qFiKYA3w9WPxDRPOkyVWvG9W4LR
         gAVnNWPOyUW+5dr6Cb6qWoYaXhBn7zN/wWlXTs3tzYFKBWMlWRWffp8gD8s6yF0yb8FE
         ngUxqnLyaiAiRtI3f1ntRgDMPc9O1n4H+lb9gIspRjv9U8ytQNtqypYR/UNdOc05QObu
         rghW5JAsmjwTC4pS4EJZwEFuqNICZoF7cPWc5kkcjkOjh5P3CS5+HyZgb3WAyLUnI45h
         eKtDBjXOYwG9FIpY2YxM2/AyWXENKbCOCF0BSqkt3CX+qqE79Kyv9f+g/9JxeVb/IILU
         WUZA==
X-Forwarded-Encrypted: i=1; AHgh+RopswTgBi+1bOq8zZbLMdmlAicxNB8hfzPiXCxctnErV8umvXOUC8wiLvHGKCQotG/O4WTUQjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaPAxSP3bXz6Rb9k6OPk2wWZgsdPb/08vZDFoODCYTDlEah5M
	fVAUH7K3idwpuK2zOhKnT0K0knFpeaTwA++1jDeUq4AAIb7TGf5w5oEaHgSk4h+eONTUBjdQQz2
	+Nymas99coUpQOJDcnv7yRhLQz+AXa68HQiD7Q0beGrJ2hQXqGnAmkwtufQ==
X-Gm-Gg: AR+sD11vjb6kQxBxULoTBJ+fhAoLf9inLyMkhfWG3CUVl0csIdaUgrjsvwrlFT/TcJe
	yDK2XTLCMqkcCnNpS6tRtvRLiHtlRyRxPsgNRGPCXgwEYcsVjebh5aY4khIFP5SdCAhxLuTmqUp
	nxHzl23YYRMkN1rT1DLcOHeHRgmhAlfKwvh85mKWdIPfqG7bry5iHkxT0IFSsKupu6Sa1Rmi9yI
	7p8IZnT3mYSqyQzT6bg0IP0SN7zR85n1eSOM47fEsW3KBw3oqNHxs+gyBdDDn5rVx+KZJ9NpnCT
	GwoYGs0BCuduB2bqbQ4jv9RVDl2mvVS4Z/nXn9TxiXxt9vz9wvybUAquApoFbfah7GPHuYOWGBp
	t7c9z3D1lv39PVPn2Yk/F6ORV8Wzab1BEoIcaZDHN1xk3ybvtYcNY
X-Received: by 2002:a05:600c:8b02:b0:499:88b0:1726 with SMTP id 5b1f17b1804b1-49989e37a3bmr8118255e9.2.1786694314566;
        Fri, 14 Aug 2026 00:58:34 -0700 (PDT)
X-Received: by 2002:a05:600c:8b02:b0:499:88b0:1726 with SMTP id 5b1f17b1804b1-49989e37a3bmr8117435e9.2.1786694314130;
        Fri, 14 Aug 2026 00:58:34 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899afa63sm9164715e9.1.2026.08.14.00.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:58:33 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:58:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] vhost: add helper to clear device IOTLB
Message-ID: <an7KGaKyX_I4B3uQ@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260814072903.124991-2-physicalmtea@gmail.com>

On Fri, Aug 14, 2026 at 03:29:01PM +0800, Jia Jia wrote:
>The device IOTLB is shared by vhost backends, but clearing it requires
>dropping each virtqueue's IOTLB pointer and metadata cache before the
>old table is freed. Add a common helper for this teardown sequence so
>backend-specific feature code only needs to decide when the table must
>be cleared.
>
>The caller must hold the device mutex. The helper does not update
>acked_features; backends continue to update that state in their own
>virtqueue loops.
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 25 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 269efad90369..7eaa61d9ceeb 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2283,6 +2283,30 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> }
> EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>
>+/* Caller must hold the device mutex. */
>+void vhost_clear_device_iotlb(struct vhost_dev *d)
>+{
>+	struct vhost_iotlb *iotlb;
>+	int i;

Should we move the check of `d->iotlb` here? so the callers doesn't need 
to access to an internal details.

Stefano

>+
>+	iotlb = d->iotlb;
>+	d->iotlb = NULL;
>+
>+	for (i = 0; i < d->nvqs; ++i) {
>+		struct vhost_virtqueue *vq = d->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		vq->iotlb = NULL;
>+		__vhost_vq_meta_reset(vq);
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

