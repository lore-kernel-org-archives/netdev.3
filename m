Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A33C7E13
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166063; cv=none; b=PPLxQ/Y3DRIKtlnO7EUzCQL0ZbyyHOtaKNS4oLqF+Xvn+igV1W8kk5GehghPWT0s6tuFciTNYxIi1zOGHm/1FbndCDoWWnv78oyxn4tYfzcY/i/djGYkOtob88JGQiKMrG6eWXLm7NM1QtSAoytNNkAZqE30XgRndTV12Q9rGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166063; c=relaxed/simple;
	bh=qO/mY1lfUtaDHpwskTKeYLSEyKzXr8YSSWgWVeTZH+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xyqn6Eox+/Y/OW1TWZBgCZcu8AReYo1BWDKVISRB9QcSuoeg0Nli3AvkOdkxfdEoOU5mlxZwZpnzjSCh3YVdPWsD+tZ6OqfQ1B65or0TaLnLUkUvJ86oV7Ap/kVfgGyRr8FfVLhzzA41Lc+SxKQGYwUwoXM/JtTFIMWNu6EbuoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZ5emLkU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKLs+y5X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZ5emLkU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKLs+y5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788166060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REKs3juXaUqDY91aw9czwxYsepaMH/aWl6qmQKLk4PU=;
	b=BZ5emLkUouNRPhVYDwooWGd0U4Xzu1Eqfm9uiyPOPES55B5lzdeKxfj+W6Gf8TIIB+p+2E
	Al6khnSjl9XxLD6VBbZsWmnXxHCiQGETYY11POoK6i/+XUSt0bD9ENyt3FHUoAvp+kJc4G
	5o9xJNJhu17mBV7DXRnm5BrujanA59U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-IXR1c0mGODGMJBWA4gq63Q-1; Mon, 31 Aug 2026 04:47:38 -0400
X-MC-Unique: IXR1c0mGODGMJBWA4gq63Q-1
X-Mimecast-MFC-AGG-ID: IXR1c0mGODGMJBWA4gq63Q_1788166057
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49b7c1dc61eso22775895e9.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788166057; x=1788770857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=REKs3juXaUqDY91aw9czwxYsepaMH/aWl6qmQKLk4PU=;
        b=FKLs+y5XGj5kdOt+ejL2IAt1/CIH5JnxUBdpakmCNJAIT/5kxNrWBpKplX53smyMbd
         bF0CsDyeVxlOfMQm5FTyedLtYvYHxPCSpNJa63HAojbIyGwd71+2mgHeFVnZV4J/FdDy
         dTZHFVKMHzvms9af9kcM2vnTqsMnBKyyvZvbWhYyBWYTx2h791/H0lecj7jVKdUWuWDC
         UlDYMU3f/tRMiGgGjzcbe+1IlIEVHIkp4C31UO4xmHrDarGZytmGOQTCqxVsQy2avdCY
         pH30VV5C1GhgK1KdVphy09y8Klfqe+QEqm4Ru01aB/svg3KUk07UYt5YjuslUjL/pTCL
         zyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788166057; x=1788770857;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REKs3juXaUqDY91aw9czwxYsepaMH/aWl6qmQKLk4PU=;
        b=p5Pv9Qaw8ANCCKvbBJGNkCf998yEs6qVJPekEAyYMVOUSgLHX21nuE7ctAnwU33Al6
         vvIWyfvm+FtIVMV8WqtlBWS+3he0hM5vnza6bXoJKOmirG3y4fM/ag4Djk0ENt+6LJid
         fujVwS+kSuqjuJ6sxih7l42Yuoxb+PBIVXX3hUbpzDBuXWGa4jJtzklkMP12Dd/z/v9t
         wN1fLzrJazdofX6D8nIDxrX1nGqh/YaplXJz6mDpMD3/sGFWIHsJluvtRuOhKH+1PsTE
         WjyhkT3uXlFXZkn1aEomumv8bu/AFHTd3ZfsZETux5kY26myQ4wcLBGHqIu7IBx3irbw
         O6Iw==
X-Gm-Message-State: AFuF++l5fvEhIMmP3LZmihHzdYt2ieiTLTr0ghIoJx7C/7fnc8w0BcCQ
	eYJx5qlWzA9O/ynyrZ7wwYtiTb0MV0nvQ3nxv90ePyFrnqWL2V1jGeyC01oY8hha0wDgdNNrCjC
	idLKIOGwz3pHukfT5ozBibokaUdCH0NHxHNpUP26eWJ4l1qZUnagiGujlVg==
X-Gm-Gg: AR+sD13Kyoh9yKVVZOTjcUhT8ttvGdaE4awdZPY8xvD9P3fx8Y23DHGV7DLcP9dft+z
	nJfK+oP1c4NHCyzMmlwhqQZZKLszFpfmeKYFze9GWLyybMTrKoAHgK0e0+izSHMGq56OUQ36uhT
	xh8O0AnBTYMBNOijah+TQQhmRZExSRhvTQ8CmnIw/nI+yFlJP2nAInQNyIUVBT3icavtPX62vRD
	JAvCkMSU7fU7jZrEvX5Zh97EF3FMZtTwTo6NylejokOsbmdJSVT1XfNjFDOPvgxbH3lSD+10qZU
	UnVoapmi4e6NTBVkhNHJ9rEZdyT55h5cY2luiXOtHeaaMEYiAIK8ZNTedydxDP7GZ4WRZIMdyUN
	b+v7Z3WGcnj3hTGu5YDydr0Y=
X-Received: by 2002:a05:600c:1d08:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49b91c2e145mr368384995e9.1.1788166057113;
        Mon, 31 Aug 2026 01:47:37 -0700 (PDT)
X-Received: by 2002:a05:600c:1d08:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49b91c2e145mr368384105e9.1.1788166056589;
        Mon, 31 Aug 2026 01:47:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843310ab29sm13646829f8f.0.2026.08.31.01.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:47:36 -0700 (PDT)
Date: Mon, 31 Aug 2026 04:47:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v22 05/14] virtio: Expose object create and
 destroy API
Message-ID: <20260831044442-mutt-send-email-mst@kernel.org>
References: <20260831075807.2891426-1-shshitrit@nvidia.com>
 <20260831075807.2891426-6-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831075807.2891426-6-shshitrit@nvidia.com>

On Mon, Aug 31, 2026 at 10:57:58AM +0300, Shahar Shitrit wrote:
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
> index 60d92875da23..08b41f38baea 100644
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
> +	data = kzalloc_obj(*data);
> +	if (WARN_ON(!data))
> +		return;
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

Maybe pass err and let the caller do it? Some callers can't handle an error but
others (ethtool delete) actually could propagate it to userspace.

> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> index 1177c4a20e53..9095a0481495 100644
> --- a/include/linux/virtio_admin.h
> +++ b/include/linux/virtio_admin.h
> @@ -86,4 +86,45 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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

