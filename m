Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B633C183
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774111; cv=none; b=gV0/Uzub0Km8CvPkqa5b2AJoBwpBu/SVzUo2R34CdkDBm3uCwBuHg7OPCYHuY6BiaznbWFKA/nlcM9KPWp8UCLJAFHNI1FNPLi4Aut9VyzQfZrzalwX/9L4w5ZYu3KhPzNW61NfuC+wuNELA5ifJ5IwvNbL0aQNhYWxQ99xorW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774111; c=relaxed/simple;
	bh=mxvErE4pX4Hqqc4ZQt/QtHfkjmGt3sB7BTMR/B5lycI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meTVLMl7/an0+hNPEv70PS8aY41dkn3VlNnzYU89X+ZfP979vaykVBOt7M4nLGQh5PMJ82G4ssO/fkre552CHSuzVcNMf+DvVZt9WtH0O0ywvxZo/lRUB1P6TQDNumarjPyZUoMJLDflZOqx2gsE03W5GuAzYfFKeqNgY+pRBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXrR9w5V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UsyaYNTa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXrR9w5V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsyaYNTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785774108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=67EPPEWPpi81KHunPYngQD+wz52WPe6LPPC6b10KAdA=;
	b=VXrR9w5VxlVCbEAFEtjdOLujp1X4VA35BMhpH/WAEkx6wN81lRpYcgu7mnsLUOCeM5ES1V
	qEP9t1vSGkhz4EZEFHb/gWTTTbe6pvLXWsDU8/XHhv6/Ci/svtl/amcweRXDLkKXOGWRIY
	Nwi2plnP9gkHf31ZBJnKEw4fQBg4Zrc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-pPDnI2j5O-S-QnpR_vnRPQ-1; Mon, 03 Aug 2026 12:21:47 -0400
X-MC-Unique: pPDnI2j5O-S-QnpR_vnRPQ-1
X-Mimecast-MFC-AGG-ID: pPDnI2j5O-S-QnpR_vnRPQ_1785774106
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954fe32d6eso10195385e9.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785774106; x=1786378906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=67EPPEWPpi81KHunPYngQD+wz52WPe6LPPC6b10KAdA=;
        b=UsyaYNTa8a0+SRwUt6Mtvmdz+gvIBkyP+7wyuh1j8LjHbcvP1z73TXCEnWYFqLIw66
         eD9YVgkqqo1K8MVyHy21SLYJQFTcXXiY/Dp8zmeUDWicLcUZiGkm9+wPOM1dEJZ9VeVR
         j38OepxsIAWsji7B5GqGe+hbQNDta3IzPvEEir/bdi1by18Z0COwKAeM6ih2RtvYbTIN
         FPJ6BrWCVLyggNUKHU+CYYFr7zmpIwfxLhXAYQl5eCbEDKd66esPX/ec0hzZwFSqBeSM
         YpPyJ3m5ROQxX8+TPYNRUxeOi+2KMVQIVB2wKsHD7dQUJPcVgV5DyH8S59DJ2OwnmyUl
         JqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774106; x=1786378906;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67EPPEWPpi81KHunPYngQD+wz52WPe6LPPC6b10KAdA=;
        b=SwlokfR4fJR1YMvdMYsWMbDeQaRsTRe6L623YtxzrAGoFFuDDlSwoE8UosoFRwravN
         AMQhzK262hvDRnPue2klx2+f7uARpAI6xeNvfUiY5ijRGJ7hcPUbDRAY/wjuJW3Es8wQ
         m2drf6YzMT9NCulAt/oc5PExa7WMCltMIW9rlea6tzzGKQ3WJEI4/Suaiof1ZpTzK/9B
         rhTG2+wYyG0bH544/2EuAhFe8huSdzOZEzVInsfmDiKh3zHmdqLcomvjjEMF7hYTZKPH
         4momZCBHv3flUAFc9aRhlxScJFi9/2iSPsG3vY8AeGu5DS4rMAupgZJc6lt/usyasH1V
         jlCA==
X-Gm-Message-State: AOJu0YxZoBK0VuX3stqFkawV4WLvO74SD0R1uRy6wg936yWY8rHqoN2n
	qT8hU2Q/P1kzDXRwk8+MymQp4lDDiOcr33V2HRNKV0P6aVt6OgSwvj0hYklKC5pXumcG7h/8gUg
	f1KhEe7HQ+euhBcuSgX+kC6YFgj4q3R+KOS4I1UVKXgmqozjj/1fACpU7gQ==
X-Gm-Gg: AR+sD13JG5af5CAqdCiDDb1Y6M02vHf0BFBNgiq8+1mUcCSGZL5QTJReDNk+zay0JaU
	qhLrxyUvaLEo6vh4lJv7D79XOYOVNXrl34YFAxMZ3wciIzkxsX7iyK0GMccRTXTpFfoemyidBj6
	hb1NvDsfnBFFiooLHIl3GiUoWplP0kA1PylyBEGk8nMFVK6ZCwsnGmwpuIhjTHbXUcnksH6Ad90
	bAMuKd68N9WU3OzoRaZ38PxxxMNdfg6W1+crsc+Lr5pGcEqatBfK3oCgK61ZjCKRSSWBoLlgXX6
	d9LTfo754UZLVdxqyAt8ayC+2zNXs3NYMegQW6YRo8x1a33S9y74s/A3K3Se3vtAuLFFNp8L/UC
	bVKbD+kGUUDOFcKjPm+v8JA==
X-Received: by 2002:a05:600c:3b1f:b0:495:4bf3:2150 with SMTP id 5b1f17b1804b1-4980c6452c4mr199253245e9.8.1785774106246;
        Mon, 03 Aug 2026 09:21:46 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1f:b0:495:4bf3:2150 with SMTP id 5b1f17b1804b1-4980c6452c4mr199252265e9.8.1785774105687;
        Mon, 03 Aug 2026 09:21:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f66168sm5128835e9.0.2026.08.03.09.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:21:45 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:21:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 04/13] virtio: Expose object create and
 destroy API
Message-ID: <20260803122022-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-5-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803140721.1871678-5-shshitrit@nvidia.com>

On Mon, Aug 03, 2026 at 05:07:12PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> Object create and destroy were implemented specifically for dev parts
> device objects. Create general purpose APIs for use by upper layer
> drivers.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/virtio/virtio_admin_commands.c | 77 ++++++++++++++++++++++++++
>  include/linux/virtio_admin.h           | 41 ++++++++++++++
>  2 files changed, 118 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> index be9144b25d84..d9b65be2d09b 100644
> --- a/drivers/virtio/virtio_admin_commands.c
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -94,3 +94,80 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
> +
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +			    u16 obj_type,
> +			    u32 obj_id,
> +			    u16 group_type,
> +			    u64 group_member_id,
> +			    const void *obj_specific_data,
> +			    size_t obj_specific_data_size)
> +{
> +	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
> +	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	void *data;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	if (check_add_overflow(data_size, obj_specific_data_size, &data_size))
> +		return -EOVERFLOW;
> +
> +	data = kzalloc(data_size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	obj_create_data = data;
> +	obj_create_data->hdr.type = cpu_to_le16(obj_type);
> +	obj_create_data->hdr.id = cpu_to_le32(obj_id);
> +	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
> +	       obj_specific_data_size);
> +	sg_init_one(&data_sg, data, data_size);
> +
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
> +	cmd.group_type = cpu_to_le16(group_type);
> +	cmd.group_member_id = cpu_to_le64(group_member_id);
> +	cmd.data_sg = &data_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_create);
> +
> +void virtio_admin_obj_destroy(struct virtio_device *vdev,
> +			      u16 obj_type,
> +			      u32 obj_id,
> +			      u16 group_type,
> +			      u64 group_member_id)
> +{
> +	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return;


I guess the assumption is this never happens?
at least WARN_ON if it does ...

> +
> +	data->type = cpu_to_le16(obj_type);
> +	data->id = cpu_to_le32(obj_id);
> +	sg_init_one(&data_sg, data, sizeof(*data));
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
> +	cmd.group_type = cpu_to_le16(group_type);
> +	cmd.group_member_id = cpu_to_le64(group_member_id);
> +	cmd.data_sg = &data_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	WARN_ON_ONCE(err);
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> index 0caeb6314a77..81bbe88694f2 100644
> --- a/include/linux/virtio_admin.h
> +++ b/include/linux/virtio_admin.h
> @@ -80,4 +80,45 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
>  			 const void *caps,
>  			 size_t cap_size);
>  
> +/**
> + * virtio_admin_obj_create - Create an object on a virtio device
> + * @vdev: the virtio device
> + * @obj_type: type of object to create
> + * @obj_id: ID for the new object
> + * @group_type: administrative group type for the operation
> + * @group_member_id: member identifier within the administrative group
> + * @obj_specific_data: object-specific data for creation
> + * @obj_specific_data_size: size of the object-specific data in bytes
> + *
> + * Creates a new object on the virtio device with the specified type and ID.
> + * The object may require object-specific data for proper initialization.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or object creation, or a negative error code on other failures.
> + */
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +			    u16 obj_type,
> +			    u32 obj_id,
> +			    u16 group_type,
> +			    u64 group_member_id,
> +			    const void *obj_specific_data,
> +			    size_t obj_specific_data_size);
> +
> +/**
> + * virtio_admin_obj_destroy - Destroy an object on a virtio device
> + * @vdev: the virtio device
> + * @obj_type: type of object to destroy
> + * @obj_id: ID of the object to destroy
> + * @group_type: administrative group type for the operation
> + * @group_member_id: member identifier within the administrative group
> + *
> + * Destroys an existing object on the virtio device with the specified type
> + * and ID.
> + */
> +void virtio_admin_obj_destroy(struct virtio_device *vdev,
> +			      u16 obj_type,
> +			      u32 obj_id,
> +			      u16 group_type,
> +			      u64 group_member_id);
> +
>  #endif /* _LINUX_VIRTIO_ADMIN_H */
> -- 
> 2.49.0

