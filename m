Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337633F5A5
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772761; cv=none; b=jMywi7nh0R4o692i7zMkP6dDwhc96gtq/r4Qmc8ZDofamW+QFWVxjIdcv+UG48fgUkwrS4RDTjM9NYTQtLfDkgxTiRcvKxMBKuyPBQIxpqIuRVA3YGAVvDa29QHSPHil9WOJZOms7ADGYxTiptYhfCWTa/g4gtBPdVIJddy30P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772761; c=relaxed/simple;
	bh=HKQ49Q+y0fHa0axoY1Gzw3algxTgziFVoosMR2RzR94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtpRSfZpHfd31jBAbdDAwdWTPgWhHFlQZKcnIz+XmtX5mK2UVCeXNbR/JodFIGLKfKDT1o3UUvna6TUnlXetCHe//Hz1KFZp1+D0oievPUVgQyVssB1i4Ta4n/JHVy+ZKlppS6zJ9ZhB7KcAtfNjcmSf24l72N12dXb9P3zkyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avBiExNp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkIle99n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avBiExNp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkIle99n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785772759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qcr8lbIWdqcfVMMmUoW0rBUoTTmgc4FAMwlbi4adWtY=;
	b=avBiExNpv6LtKL9ag5swvPMsMZ/UpCwzyLaNFyqkm5WBL6/9+BjFsqv3bA4Ig8D4Y+yJ+v
	8hLJohmXmcU/EYHaNWO9G0KLDNExezzVDhllXyLvSPVyrotruSgcocUa5261biuo31h0IN
	JUC3toICGlhh355juCSnfIOhxQ/kbHo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-j7Mby2NjP3yDYYs1JxhgIA-1; Mon, 03 Aug 2026 11:59:18 -0400
X-MC-Unique: j7Mby2NjP3yDYYs1JxhgIA-1
X-Mimecast-MFC-AGG-ID: j7Mby2NjP3yDYYs1JxhgIA_1785772757
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-475e540a0ffso2320439f8f.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785772757; x=1786377557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qcr8lbIWdqcfVMMmUoW0rBUoTTmgc4FAMwlbi4adWtY=;
        b=SkIle99nxPn3LITnO7R3Wl9eb5STNgDJ+3oaVsuldiU3JkTdqt8TKyznhOMMZQsw3A
         rno88OO5y3xhKbgHYMfHnCDO4ZoHgiUIsUaB/gPSyp5L+oenyUADqsc59f0uOW2Nqtnw
         l6Cq3ABD2hYqg7mWEE/yddAhOyOeFmk2kDPLDpGDHgweMov3RMxlVvfd3wL1uteG/0+R
         0FlLKDmN87ZvUWL5Lb70wfoXWbs3VptkaSDkgUe1jTMPVrru5s1Sdwz+ji+zJvx+RIvn
         n5P0ibGBwVWB8KkCcp1BwYVmhCQrm2jyOHnKtOT4ihiVyzOESfpT3BKeWcb25DhTftzj
         4GQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772757; x=1786377557;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qcr8lbIWdqcfVMMmUoW0rBUoTTmgc4FAMwlbi4adWtY=;
        b=M+rCeMOX4YnsNAUKn6i2TgkrPnSM7twM2lQFYW9nyY2ADx96mmFbdJSdXg2trLb0yP
         Qtm0RIbNCQczvnZWIXp9ztq2vo83c855vLBjmSHVIegNNWZHkSeceLv2cIcscAF3golY
         sINXxbh1iscUAtgE9xlyQ69gez1qRKN7Mk4RycPjLg2xquBvpio7dtMV7YjvstDG4T4z
         w3shVH482xPRzLR8VF0dzcdSm9eIifeXIldJDOZBwZfQjIMsnAS+bYvi9V8yIkGBmnda
         +tFa4Pxm9mj8MR06mTBbVwQL5VdVLMPK0nd1REgiN7SuflEyOtWyEODQBxsbx/c7x5Pe
         QDtA==
X-Gm-Message-State: AOJu0YxB+QAcDfGTmw6+KDsRO/PyDVxepJknmpeY/Mlra6Eao3eOoDcS
	BCcX4QsWGM3NaAgsJWAfXqldtYRzB58skxUYJLItPU4Gs4FX8AfyCPsP1mMf5lQe5PpPDgyPbkD
	nFZYTN2MiHH2sGYAc5hjFmXuOwCj+TGLcH/0fyWBLWQpta2gmMlgHyKe/lskxxsyzDQ==
X-Gm-Gg: AR+sD10WmQf+sdMLRYq+pEvR+ddBzie0VDFWcvTyH7N9zz1z7fLmVJAM6rAW7PmYsze
	rIkkCAxQ3VPyMInfoF/Be0/4mFACgotdFOdORDO2ra1xnmm+Z4e7//5po9fstErWg0AjF8afAkk
	7m+8muebkSvSYPdUk1jwYMHjbx6W7bLKTMQ1epVD6vPBtmjgnAttoJtIhltxWC7G+7D2GcCiUHi
	b75nVBmtFpsjnzPtq8nc0olNC6Gmzd+52y6PPHuZef1hOTjYn0KwERxF5G/psiQavv59hPTPxLB
	ggHnDxSTdvmd69dc6bvswGFm6wFSsuOxKeYI63RCbs3DXhaLhadx5kW5m9ABlKwzk2Vi3RerZL2
	Epb7Ugm4MYxot6qpB+kjzAg==
X-Received: by 2002:a05:6000:4615:b0:47f:918b:fa07 with SMTP id ffacd0b85a97d-47fd72d4500mr29228307f8f.22.1785772756836;
        Mon, 03 Aug 2026 08:59:16 -0700 (PDT)
X-Received: by 2002:a05:6000:4615:b0:47f:918b:fa07 with SMTP id ffacd0b85a97d-47fd72d4500mr29228215f8f.22.1785772756323;
        Mon, 03 Aug 2026 08:59:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d0064sm33017363f8f.5.2026.08.03.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:59:15 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:59:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 01/13] virtio_pci: Remove supported_cap size
 build assert
Message-ID: <20260803115219-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-2-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803140721.1871678-2-shshitrit@nvidia.com>

patch is ok. commit log isnt:


supported_cap is not a thing.

better subj:

 remove supported_caps cache and build assert


On Mon, Aug 03, 2026 at 05:07:09PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> The cap ID list can be more than 64 bits.

what does "can be" mean? I think what u mean
following patches make ....

> Remove the build assert.


> Also
> remove caching of the supported caps, it wasn't used.

it's not "also". in fact we remove supported_caps and then
the rest of the code handles data->supported_caps of any
size, transparently.


> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_common.h |  1 -
>  drivers/virtio/virtio_pci_modern.c | 10 +++-------
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 8cd01de27baf..fc26e035e7a6 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
>  	/* Protects virtqueue access. */
>  	spinlock_t lock;
>  	u64 supported_cmds;
> -	u64 supported_caps;
>  	u8 max_dev_parts_objects;
>  	struct ida dev_parts_ida;
>  	/* Name of the admin queue: avq.$vq_index. */
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 6d8ae2a6a8ca..ef4a64eb9982 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -304,10 +304,10 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
>  
>  static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
>  {
> -	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
>  	struct virtio_admin_cmd_query_cap_id_result *data;
>  	struct virtio_admin_cmd cmd = {};
>  	struct scatterlist result_sg;
> +	u64 caps;
>  	int ret;
>  
>  	data = kzalloc_obj(*data);
> @@ -323,12 +323,8 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
>  	if (ret)
>  		goto end;
>  
> -	/* Max number of caps fits into a single u64 */
> -	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
> -
> -	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
> -
> -	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
> +	caps = le64_to_cpu(data->supported_caps[0]);
> +	if (!(caps & BIT_ULL(VIRTIO_DEV_PARTS_CAP)))
>  		goto end;
>  
>  	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
> -- 
> 2.49.0

