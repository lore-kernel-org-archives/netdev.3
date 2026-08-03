Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F632345CA1
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774455; cv=none; b=bkeC8uVzmG1XxaJFeEaBvBj1gfP0L3GXmt/paOFM8m5ArH7OSOHMfpJikw0FtfndhDua/bUGg/AGBU4fCozp1Q8BNPkpQgtm4WS5ax1utiwm/Qf79EiyXqzLUvs91UwPCiWU2KW2xhVxhHdj0w7CHJf8rpv02ykjje0is87KXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774455; c=relaxed/simple;
	bh=UF6O9F39J8n8fKJc/y8OVNohdfFt+8aJyoZuzER7254=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibynQR4VhGmgWYAbMHcVVxFNdZ77EOQjRaD6E3T0vhgo1Fo6AkRGShHihFO/l49cW7ffTgJeSiID1ZZku6PVSXISEe+uRUp34JPUWnG8eRxmNC1czRQ2Cm/Nl7Di92Z7gcPY1cKP235e2kEo8boZ8J1YU+WZth2d11Ay/2ukDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebkCK9q2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=offWOpjY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebkCK9q2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="offWOpjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785774451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUqgLCxIKnIX8Jqf3kKgChjSUuGf8d0wCJjX0G98IIE=;
	b=ebkCK9q24mTrHgRio1bv0WaggyvWg5TlpPyXQ+wQ3A/42phRD3D7nBOCu5hIT+TTp65XUt
	gJploaxmVZN+ugx/uoALgoU5QeeYTe35TiUZwbichwnOCCqyHEoiwfjH8972/P4w2WtH2L
	7SVR1l7LwuYo7016/9BpWKPrBcIDG14=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-SA6WVakcNKq3s-C5XeXCYg-1; Mon, 03 Aug 2026 12:27:20 -0400
X-MC-Unique: SA6WVakcNKq3s-C5XeXCYg-1
X-Mimecast-MFC-AGG-ID: SA6WVakcNKq3s-C5XeXCYg_1785774439
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4956c1655c3so14131065e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785774439; x=1786379239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IUqgLCxIKnIX8Jqf3kKgChjSUuGf8d0wCJjX0G98IIE=;
        b=offWOpjYOD71O1jE1VDj6xz4TMQKTaI6nUEtBhG1n0RtR2api3GcG64wmykrjI4fcC
         ERVHi0Rax1AIgOkv1Q2ZU2Pk+nM4lmm3Po31+OqNGWasFrQmRIVnCxSMNdfaGhEev9Yb
         vNCCRoiL/809DDf2xiIyFOxPGsGPWHOLSG/wPHeMhOVDKek82dsUXg9PaWNGHh0L606v
         T+x9ZCeGXYRNuWXDSOq5IaSL50j7ZwSHxWmzlY0In7cNavfHyLSjgT2zKGfT00Sm6WOV
         l8pekzM62JpRpq3lPdAlLXohA5hKFg799IxtX/S9P9shG6TcrgQ3P8L080EVQ8vmXc66
         A44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774439; x=1786379239;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUqgLCxIKnIX8Jqf3kKgChjSUuGf8d0wCJjX0G98IIE=;
        b=UiHCyHhiVkG+LkbVedr4rjnBJ7PYrJjFfMQW0ms8psDKYl9XqFVmfWju0cA8qD2s8f
         7KYFCTzEk2rk6RwaqQ+JDoKJ+Vl2/+Rp3uXDAdbQF6JqHRRekAXxMe3QshNs5sDHcHRT
         mVpT3STJCIrsbwhvuSxH4OXuhQc2OzBhjSEmtEFMjADIfKC14Ikm0Xt+iZq9rXwLro18
         /YNhWtrwE4jZsP2nTgFeCjQG1bztfdm7xhhTZMeT7Ju1ty1JHkqA0MMaFHArW3RPDdpM
         0vbmt7gNCOJDIJnBJDVFKFnqic+Iy9ne1H7xiEZgFW14pzLY1+72czz/nVsHbBZ5it1O
         +kiQ==
X-Gm-Message-State: AOJu0YzEH0iXjDstSIojwRJeEg4E/aTapYPQRDItowARMvyanYXtAKOL
	N/3YlMX++/ClvXgVITnj6O86kj09DE8OSFog0m/Blc9LbeeSKc3Qs3vFGcyEsg5cbYoEqYyB4XG
	bbva/gFxIWu7BE+vwiHw06pZQe4ashv+NEQRtxTllXZ5adSU6QVULuazs9Y1MQe6pDQ==
X-Gm-Gg: AR+sD12QYk1Ls7NhMaWprkkqWPAbXtBmKTPpVbRVEljOy+Jj7W+lWH0qE8uvFehW3KV
	wn27SM72Y3LNO9uk9nixNk+8qtX2S7/+VuH1AH1Gq6ovQk+uDtOEVypFWZtR80ghnE4AGdHXWnm
	nNAqmoDx2J6MvG482JR+bEtOLJT/HQyqhDTF+kkdF5Gl2JeSpXNT8x08FcxQnDuqEGOSK1tT9Ew
	Rypo9q457K+K8pWzXI1DxnLx8rC9cG5XYWGoUSdTS6drzr5WRwLSP7wBvWoKXIh7FIiAF+UvhM8
	fAb8ybSG+DZAJyz4iSOWrK+r4CTDaMUuC/xNVqYk0KBCxWikrftQSVthTDjPxtqK3N7S89y/2kv
	sg2Uqr+MTCj5SHgvxGPamyA==
X-Received: by 2002:a05:600c:8b54:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4980c674f25mr283760875e9.9.1785774438912;
        Mon, 03 Aug 2026 09:27:18 -0700 (PDT)
X-Received: by 2002:a05:600c:8b54:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-4980c674f25mr283759915e9.9.1785774438409;
        Mon, 03 Aug 2026 09:27:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm36574846f8f.27.2026.08.03.09.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:27:17 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:27:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 06/13] virtio_net: Create a FF group for
 ethtool steering
Message-ID: <20260803122249-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-7-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803140721.1871678-7-shshitrit@nvidia.com>

On Mon, Aug 03, 2026 at 05:07:14PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> All ethtool steering rules will go in one group, create it during
> initialization.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0d1f5a6cfd12..e11e42583243 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -287,6 +287,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>  };
>  
> +#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1

why 1 and not 0?

> +#define VIRTNET_FF_MAX_GROUPS 1
> +
>  struct virtnet_ff {
>  	struct virtio_device *vdev;
>  	bool ff_supported;
> @@ -5749,6 +5752,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>  			      sizeof(struct virtio_net_ff_selector) *
>  			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_net_resource_obj_ff_group ethtool_group = {};
>  	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
>  	struct virtio_net_ff_selector *sel;
>  	unsigned long sel_types = 0;
> @@ -5839,6 +5843,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	ff->ff_actions->count = min_t(u8, ff->ff_actions->count,
>  				      VIRTIO_NET_FF_ACTION_MAX);
>  
> +	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
> +		err = -ENOSPC;
> +		goto err_ff_action;
> +	}
> +	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
> +
>  	err = virtio_admin_cap_set(vdev,
>  				   VIRTIO_NET_FF_RESOURCE_CAP,
>  				   ff->ff_caps,
> @@ -5886,6 +5896,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +
> +	/* Use priority for the object ID. */

and how is this ok?
spec says:
 Each resource object has a unique resource object ID - a driver-assigned number
  in the range of 0 to \field{limit - 1}, where the \field{limit} is the maximum
  number set by the driver for this resource object type.

and limit here is 1, right?

> +	err = virtio_admin_obj_create(vdev,
> +				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				      0,
> +				      &ethtool_group,
> +				      sizeof(ethtool_group));
> +	if (err)
> +		goto err_ff_action;
> +
>  	ff->vdev = vdev;
>  	ff->ff_supported = true;
>  
> @@ -5913,6 +5936,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  	if (!ff->ff_supported)
>  		return;
>  
> +	virtio_admin_obj_destroy(ff->vdev,
> +				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> +				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				 0);
> +
>  	kfree(ff->ff_actions);
>  	kfree(ff->ff_mask);
>  	kfree(ff->ff_caps);
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> index f9e771a0baff..b0780e49df9f 100644
> --- a/include/uapi/linux/virtio_net_ff.h
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -12,6 +12,8 @@
>  #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>  
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
> +
>  /**
>   * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>   * @groups_limit: maximum number of flow filter groups supported by the device
> @@ -88,4 +90,17 @@ struct virtio_net_ff_actions {
>  	__u8 reserved[7];
>  	__u8 actions[] __counted_by(count);
>  };
> +
> +/**
> + * struct virtio_net_resource_obj_ff_group - Flow filter group object
> + * @group_priority: priority of the group used to order evaluation
> + *
> + * This structure is the payload for the VIRTIO_NET_RESOURCE_OBJ_FF_GROUP
> + * administrative object. Devices use @group_priority to order flow filter
> + * groups. Multi-byte fields are little-endian.
> + */
> +struct virtio_net_resource_obj_ff_group {
> +	__le16 group_priority;
> +};
> +
>  #endif
> -- 
> 2.49.0

