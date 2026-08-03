Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C038239D
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773956; cv=none; b=UpqyzY9vqimBKXmOre7L1P6SJ4puDi25sXnnVJe9yIoDXfmkd6m6y+RwCYRVr2K+njSObGtZcfBeVbwxrJ1XBfzawmzrBXjs5WFzJ2DqylmSZBPZRRAaW58iG8x20jw4fI6x14KEW8LqtmFFV8PZWgjj2P9MMJ+0B/MnPaaBKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773956; c=relaxed/simple;
	bh=ebzqMbBWlBJDcRk1PnHzXvWCwLfqZCWdZIn3AancDwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5aohzyTfjjVN2YTXHth+2W1mf4G492s1KP1lSqnicMCCDIZQKxeh7Ud0VkrvISu0IG6SDw79IR3Hbg/oX0ZboGyPP2qAsgfI42NIHlClxkSnVJEuwdZYNSMB5XIqwRgfNhpriPmaXJp2X5zcFQnd65h4I4SC8fqScmakIhSfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnH6WmMe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nht8rSOh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnH6WmMe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nht8rSOh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785773947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KOGJawteY0C9D8I0OHiQMOclk5H32QNM3UDZcM/y4g4=;
	b=CnH6WmMecsKoojoNJg8nGKGkRPJ7xba2SPbogtTiWqauCNz1o3kO8C2G7/0UrB98dgdvgK
	RP31auXBpT7rxn/H2Q24B9OSoJK5HrZTGzyrregv9SaoLR5IF6+PeSDmoHgnEaiCFnKmqD
	prMyPd9wo/6ODhJ833gKZZGOuRBNB1A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-VHDi9I-bOv-9GEcvP3N6OQ-1; Mon, 03 Aug 2026 12:19:06 -0400
X-MC-Unique: VHDi9I-bOv-9GEcvP3N6OQ-1
X-Mimecast-MFC-AGG-ID: VHDi9I-bOv-9GEcvP3N6OQ_1785773945
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4957287363bso14739095e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785773945; x=1786378745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KOGJawteY0C9D8I0OHiQMOclk5H32QNM3UDZcM/y4g4=;
        b=Nht8rSOhwtCmGoW27H8p1R0fcdIDeqtbXHfi2h75nxbEw/VsNTH1XRtxYBM+2QGbLW
         a5bHwOtijTFm6S0EZ5M85dzSa6eZ7KsHannBA1zTNns2h2T7S6ALKzJdj9VH8i4V5yK/
         hUt8AbSb02aK0U8PSckYm1LqtIQ3MfgeuBFYpw1tinUuoX9ZMhXKz7Z+nz5cR2wgydpj
         Hn9TFIsX65scmgK6zvi/ju3RKb/hm8uHAMeO/znchM+knaLoI30pJaEWtThhxiBx1Cu2
         LY9cQHy/TwzOdQDgmFNMtm05LBWW3Ui7Xv9I7i4SySeaAHaL30fSRX0aHVb3an4D5mUs
         7vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785773945; x=1786378745;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOGJawteY0C9D8I0OHiQMOclk5H32QNM3UDZcM/y4g4=;
        b=Q94Ibs3HXfK/l/OlVVoNvjfty4QCJGxAdWY8pfthEASMJ1arHLLQ3u47ZIBnioRAzz
         gb1TouNGJAjAVqjnHB+CX+5t0jyfwhTUvFucVIhO8ITad1ihDFuGIs4IOHs4k2DWtGl6
         GSDt7PGQ6Y9cqacsrPZF2cjJN40S+d78gUrs3L3zaGzIJjdME66nNmV5WkmQMffM1OZa
         g8ixLRprhe6p55Ktg7cFlTXxBB+TydJHUs3usRvXiQWWivT5ZPYNajUoKq7fOcsjOs/G
         yacYKgKyVMLWnxWeYY9yvktg8T74naKyHP64u/CdjH0WmpXV2A41IY7S0zNKuPjxSbk3
         dUhw==
X-Gm-Message-State: AOJu0YwB8UZIICZn//k4VaMj9FVmT8eoMB9hRVyJbf5kzaWbcB2/Cgr5
	s5hV7/7kF5/2ZjBXjb18PFBhy/MhW/f1XW1zDc61KkqogjkUVrVV+IperDZ6WG73AYbGXpZb1UK
	TK+i0c5gHYEpUajVGB/DVzAeiBlY/OZuK9EgtFGnzXMahOeAHvMRb38PcpA==
X-Gm-Gg: AR+sD13Y78Pt+C9iEK5+6QQ00+JlqjHMWtnP1JYYnZ2rRVUtB4wIFghH7mu2leuTVYr
	t1PptlSjC5KBEVW30RqvrSMs2SbwP1g/gBXtS1XudANma7rsd59bK5tlzjrBoY9KYjP+z/E0KCL
	VveR4Pev67Dj6VIUVoKpRwJThh/lIoDrtWjIuo/K7jLP8bCY1qz8Z/U7ZgUnIsWMdBOcw4VrgdI
	B/wloLl6F4ipD9yc5E81iN3IBo1Yit0ErpVpWJbtaimcQGyD+VP+y6Fg6EPYL6caqDf20JwTb4U
	g6P2ITcSZUqdnGRgiLD70v3o3sX9/lol+J39Krg62Lhw36VPsaixf9v4RCAkHqFmkPT7RHcGgat
	fLObo/znhR1yv45NCwaN/wQ==
X-Received: by 2002:a05:600c:4f84:b0:496:bbcb:b0bb with SMTP id 5b1f17b1804b1-4980c674e31mr242640505e9.18.1785773944517;
        Mon, 03 Aug 2026 09:19:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4f84:b0:496:bbcb:b0bb with SMTP id 5b1f17b1804b1-4980c674e31mr242639385e9.18.1785773943802;
        Mon, 03 Aug 2026 09:19:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fdf392sm5482925e9.11.2026.08.03.09.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:19:03 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:19:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shahar Shitrit <shshitrit@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, danielj@nvidia.com
Subject: Re: [PATCH net-next v21 03/13] virtio: Expose generic device
 capability operations
Message-ID: <20260803121116-mutt-send-email-mst@kernel.org>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-4-shshitrit@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803140721.1871678-4-shshitrit@nvidia.com>

On Mon, Aug 03, 2026 at 05:07:11PM +0300, Shahar Shitrit wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> Currently querying and setting capabilities is restricted to a single
> capability and contained within the virtio PCI driver. However, each
> device type has generic and device specific capabilities, that may be
> queried and set. In subsequent patches virtio_net will query and set
> flow filter capabilities.
> 
> This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
> to do because this data is written by DMA, so a newer controller can't
> overrun the size on an older kernel.

yes but these APIs do not return the size written, so callers
do not know how much has been inited.
which is ok in this patchset since callers zero initialize the
structure, but if this is the assumption pls document it.


> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/virtio/Makefile                |  2 +-
>  drivers/virtio/virtio_admin_commands.c | 96 ++++++++++++++++++++++++++
>  include/linux/virtio_admin.h           | 83 ++++++++++++++++++++++
>  include/uapi/linux/virtio_pci.h        |  6 +-
>  4 files changed, 184 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/virtio/virtio_admin_commands.c
>  create mode 100644 include/linux/virtio_admin.h
> 
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index eefcfe90d6b8..2b4a204dde33 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
> +obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_admin_commands.o
>  obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
>  obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
>  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
> new file mode 100644
> index 000000000000..be9144b25d84
> --- /dev/null
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_admin.h>
> +#include <linux/overflow.h>
> +#include <uapi/linux/virtio_pci.h>
> +
> +int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
> +				   struct virtio_admin_cmd_query_cap_id_result *data)
> +{
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist result_sg;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	sg_init_one(&result_sg, data, sizeof(*data));
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> +	cmd.result_sg = &result_sg;
> +
> +	return vdev->config->admin_cmd_exec(vdev, &cmd);
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_cap_id_list_query);
> +
> +int virtio_admin_cap_get(struct virtio_device *vdev,
> +			 u16 id,
> +			 void *caps,
> +			 size_t cap_size)
> +{
> +	struct virtio_admin_cmd_cap_get_data *data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist result_sg;
> +	struct scatterlist data_sg;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->id = cpu_to_le16(id);
> +	sg_init_one(&data_sg, data, sizeof(*data));
> +	sg_init_one(&result_sg, caps, cap_size);
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> +	cmd.data_sg = &data_sg;
> +	cmd.result_sg = &result_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_cap_get);
> +
> +int virtio_admin_cap_set(struct virtio_device *vdev,
> +			 u16 id,
> +			 const void *caps,
> +			 size_t cap_size)
> +{
> +	struct virtio_admin_cmd_cap_set_data *data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	size_t data_size;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return -EOPNOTSUPP;
> +
> +	if (check_add_overflow(sizeof(*data), cap_size, &data_size))
> +		return -EOVERFLOW;
> +
> +	data = kzalloc(data_size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->id = cpu_to_le16(id);
> +	memcpy(data->cap_specific_data, caps, cap_size);
> +	sg_init_one(&data_sg, data, data_size);
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DRIVER_CAP_SET);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> +	cmd.data_sg = &data_sg;
> +	cmd.result_sg = NULL;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
> +	kfree(data);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
> new file mode 100644
> index 000000000000..0caeb6314a77
> --- /dev/null
> +++ b/include/linux/virtio_admin.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Header file for virtio admin operations
> + */
> +
> +#ifndef _LINUX_VIRTIO_ADMIN_H
> +#define _LINUX_VIRTIO_ADMIN_H
> +
> +#include <linux/types.h>
> +#include <linux/byteorder/generic.h>
> +
> +struct virtio_device;
> +struct virtio_admin_cmd_query_cap_id_result;
> +
> +/**
> + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
> + * @cap_list: Pointer to capability list structure containing supported_caps array
> + * @cap: Capability ID to check
> + *
> + * The cap_list contains a supported_caps array of little-endian 64-bit integers
> + * where each bit represents a capability. Bit 0 of the first element represents
> + * capability ID 0, bit 1 represents capability ID 1, and so on.
> + *
> + * Return: 1 if capability is supported, 0 otherwise
> + */
> +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
> +	(!!(1 & (le64_to_cpu(cap_list->supported_caps[(cap) / 64]) >> (cap) % 64)))

Why is this a macro not a function? maybe inline if you like.
And maybe  BUILD_BUG_ON to validate it is in range?


> +
> +/**
> + * virtio_admin_cap_id_list_query - Query the list of available capability IDs
> + * @vdev: The virtio device to query
> + * @data: Pointer to result structure (must be heap allocated)
> + *
> + * This function queries the virtio device for the list of available capability
> + * IDs that can be used with virtio_admin_cap_get() and virtio_admin_cap_set().
> + * The result is stored in the provided data structure.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or capability queries, or a negative error code on other failures.
> + */
> +int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
> +				   struct virtio_admin_cmd_query_cap_id_result *data);
> +
> +/**
> + * virtio_admin_cap_get - Get capability data for a specific capability ID
> + * @vdev: The virtio device
> + * @id: Capability ID to retrieve
> + * @caps: Pointer to capability data structure (must be heap allocated)
> + * @cap_size: Size of the capability data structure
> + *
> + * This function retrieves a specific capability from the virtio device.
> + * The capability data is stored in the provided buffer. The caller must
> + * ensure the buffer is large enough to hold the capability data.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or capability retrieval, or a negative error code on other failures.
> + */
> +int virtio_admin_cap_get(struct virtio_device *vdev,
> +			 u16 id,
> +			 void *caps,
> +			 size_t cap_size);
> +
> +/**
> + * virtio_admin_cap_set - Set capability data for a specific capability ID
> + * @vdev: The virtio device
> + * @id: Capability ID to set
> + * @caps: Pointer to capability data structure (must be heap allocated)
> + * @cap_size: Size of the capability data structure
> + *
> + * This function sets a specific capability on the virtio device.
> + * The capability data is read from the provided buffer and applied
> + * to the device. The device may validate the capability data before
> + * applying it.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
> + * operations or capability setting, or a negative error code on other failures.
> + */
> +int virtio_admin_cap_set(struct virtio_device *vdev,
> +			 u16 id,
> +			 const void *caps,
> +			 size_t cap_size);
> +
> +#endif /* _LINUX_VIRTIO_ADMIN_H */
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index e732e3456e27..96d097d3757e 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -315,15 +315,17 @@ struct virtio_admin_cmd_notify_info_result {
>  
>  #define VIRTIO_DEV_PARTS_CAP 0x0000
>  
> +#define VIRTIO_ADMIN_MAX_CAP 0x0fff
> +
>  struct virtio_dev_parts_cap {
>  	__u8 get_parts_resource_objects_limit;
>  	__u8 set_parts_resource_objects_limit;
>  };
>  
> -#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
> +#define VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE __KERNEL_DIV_ROUND_UP(VIRTIO_ADMIN_MAX_CAP + 1, 64)
>  
>  struct virtio_admin_cmd_query_cap_id_result {
> -	__le64 supported_caps[MAX_CAP_ID];
> +	__le64 supported_caps[VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE];
>  };
>  
>  struct virtio_admin_cmd_cap_get_data {
> -- 
> 2.49.0

