Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC6345CA1
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773270; cv=none; b=Pq0BD69EoMTvHTgatiVs2r3ecd17tqih6kmomE43kT97ZL8ToMRK8O1fCbo+XpDfOHJlRKmia6qKus+XgS1RXzU29njmlqun3yT/H3+1pZ5lRu2rPfiK39pn4A0IGTxhqGydi/TfAD4x90iTFmagvrtbbKgeaJquAxHg6dQFGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773270; c=relaxed/simple;
	bh=ZseRgTJAwo05O2DD2YkpqFiqUIpZMU7SmGFGHXFSi3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSjL7sDE9v5CvCoPfval8uYi3TQYcoTo06m7xT7iYkdsNY9+wYcCV24ng0/VxRzyX4fiarHJf5/1M4jFKvIDFoWNJ75xiF/Bn7LRDvumr6SCUEGK0wPYoKj8YieAql/u+9MDVIs0Vqg4JobHIFRmX8B2azO51K/clAAntjmm6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgcFwN0O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAxcwLe7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgcFwN0O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAxcwLe7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785773268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KF1qmdEimkgXxg6otcgk7H45mi45bXhYYW4FiUYh4Uc=;
	b=bgcFwN0Oqt0jAb9XjmwYvwb5XMtYVhpCMjGcuCN/vmiej0pG0xOUvK7BYYvB3O67HAbExD
	0YzyL1vlPSz+vKnxr2v6SJ/Z1buKxEcUDb/6sBmLR9Rpnl7lRdpcUd2tdvLC7AkN+r1ik4
	i4FuSw1G07qqyJUhySX2uuf6PiIO1aM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-8ljeebqhOlmB_nhftm2vbw-1; Mon, 03 Aug 2026 12:07:44 -0400
X-MC-Unique: 8ljeebqhOlmB_nhftm2vbw-1
X-Mimecast-MFC-AGG-ID: 8ljeebqhOlmB_nhftm2vbw_1785773263
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47407691804so2661326f8f.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785773263; x=1786378063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KF1qmdEimkgXxg6otcgk7H45mi45bXhYYW4FiUYh4Uc=;
        b=MAxcwLe7sobQyXQ3QBJETGjM9kAxUYa92U9cMa+28MkhS3KwMyCPW8vDj3noEKC0La
         YNnZXOoiDRqEwDaxmG1NXTFPQMDublk6JpI3xbNYGxbh5Nf9mOz/fiqhEKSy6FsqPa8Q
         DniShVR7ho5CtQELy4BpDqKLgruMB6++fyp/oNbpakXzqfCmKCvmU+ziJBbwH7Kjtgz5
         MQmdmLbEYn78tWdgwMCUalvOqH+KA76Pf37VoT1G5avIGyVOT/AaL3zqT03C//2OMU8J
         tN5aM+zm1/fbHoaj0FCE6L7BEt6pn07myvlkc935LkFKP09aEI0iPrn8lto4URVyo38/
         e72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785773263; x=1786378063;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KF1qmdEimkgXxg6otcgk7H45mi45bXhYYW4FiUYh4Uc=;
        b=ZluUZygf0pIVgeX51yGN0ET1e/mXTkTFci1/8O9cv/2gHLgHlI/XjTmEDDvfhtstZU
         /XF3PwAE14KQ4EqjdGqn2JVMH5dTagpsn+xCGrYQoDrh1sn8ypvZ7vEGhT1D9ajA7ZQz
         +C+dxHqmvknO4dudP5CUm11OUSlpEUCgjifRQ2kX2+0F9NqPaE5ke7VTywlfcXcytIP/
         oPyx9d2QPH+U54RCRPGSqzDc59t/HRKdLAQ0F1syqxOHkETTY3gBWfda3+E+5HVZWuyn
         edi7tiPaIAzKQ5oemuw4/ScOvX3yV0r0P06WiSta5bZgsrKrFgBpAEcbEx5WZklGpRxX
         TLNQ==
X-Gm-Message-State: AOJu0Yx1gbDkcZoi19QuwG48TZkwi59MoKbrJSidBmafl+RFw9ZUG1X+
	mKc3qFPwq+8+WPMS9dGgcTNgcKYETJYoGnjOYpQSqbfwEUI+gcK2RV4X8yGo+ibCXPC6JDM5nRb
	REj2ECGdOkaKPTNjULoMWGpSwLfVONUBdd6v01dRqbm0GwJfCsfm0MAszew==
X-Gm-Gg: AR+sD12fbvDWHlYE49Ezpb7vsQsyL8g2nQxUpoeMZFgOsuqOWMtZTAPyESpWIQuZNl6
	3bbcIpucIMdJOYcdGNAfjWMGNB4K15A3B58tlvyqdJDVfgLP1vsEUDJCVpSu3J/sB1uuG6ILX9M
	9Rdev1MgJ6zUyvq/7kDn4wSaVVn8uxXxwJpiOWZ8/HPvzIvYrbbgL8mYcID0301UjxTlqJAS7Cw
	k54CYV+f/WO/IvTbXwZIFLEJxYIjawfF8PMLj6gccesrkgWwhudBdMMI01JrlqMwfSfgVCt3Vwi
	9iXgk5lVA31ajz+IwBHVEXpI7t1cOvAjiKVVL3CTnMa8almENU0pqzrs6MdyqbBSeOGEH12/XEb
	iJuYLFxbKCF8vaIFTCpCkjg==
X-Received: by 2002:adf:fd10:0:b0:46e:c978:7ddc with SMTP id ffacd0b85a97d-47fd72bf1ddmr20522222f8f.24.1785773263389;
        Mon, 03 Aug 2026 09:07:43 -0700 (PDT)
X-Received: by 2002:adf:fd10:0:b0:46e:c978:7ddc with SMTP id ffacd0b85a97d-47fd72bf1ddmr20522117f8f.24.1785773262795;
        Mon, 03 Aug 2026 09:07:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bb4esm33075414f8f.30.2026.08.03.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:07:42 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:07:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 02/13] virtio: Add config_op for admin
 commands
Message-ID: <20260803120238-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-3-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803140721.1871678-3-shshitrit@nvidia.com>

On Mon, Aug 03, 2026 at 05:07:10PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> This will allow device drivers to issue administration commands.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 2 ++
>  include/linux/virtio_config.h      | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index ef4a64eb9982..a18683761aa5 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -1238,6 +1238,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -1258,6 +1259,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
>  
>  /* the PCI probing function */


So the issue here is that vp_modern_admin_cmd_exec has been
broken for a while:


        spin_lock_irqsave(&admin_vq->lock, flags);
        ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);



which is pre-existing but now that this is going to be triggered by userspace,
we need to fix this.

I guess admin vq lock must be a mutex and complete through a wq?

> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 69f84ea85d71..e36a32e0a20c 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -108,6 +108,10 @@ struct virtqueue_info {
>   *	Returns 0 on success or error status
>   *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
>   *	set.
> + * @admin_cmd_exec: Execute an admin VQ command (optional).
> + *	vdev: the virtio_device
> + *	cmd: the command to execute
> + *	Returns 0 on success or error status
>   */
>  struct virtio_config_ops {
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
> @@ -137,6 +141,8 @@ struct virtio_config_ops {
>  			       struct virtio_shm_region *region, u8 id);
>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>  	int (*enable_vq_after_reset)(struct virtqueue *vq);
> +	int (*admin_cmd_exec)(struct virtio_device *vdev,
> +			      struct virtio_admin_cmd *cmd);
>  };
>  
>  /**
> -- 
> 2.49.0

