Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9ED254B18
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999967; cv=none; b=UsdnwrQK3OTqETaXGledRYyBrDRMt+k+y0G26QYGapESwdR+7dhrEa3+IQVOL01tgEBto1/1J4HtDnqwY1oku9pBAv6Ffgr88lB8EK4ST5HU7KnRhZ0k5dTCpCqhyACXewnGJF7WLA7YAfYaBJ331kEDkAn7bLqj+cswe8Opzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999967; c=relaxed/simple;
	bh=mhFy3kw0pBtNxl+pMm5FL4NOsSRkTaVTs3CH4v2wuQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dS1bWgCMJ6WbsTDuCn4pL7xd/OaHYJGKcS5HopFyxBfQyw8AMAbjFq0z+L+cW28ArvzxSA5Eq1h/N0YhFRNzFKQhIqjg+IQsWuuxPXwGWv8ttY+WPuNH7aaS8eu5G4q/dnxFU18xwJyy39/4p/n44LKZJc8U+0/FABQYRL0bUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIkTYGR7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIj8C8rn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIkTYGR7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIj8C8rn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773999965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=07FEaUp+g6rgOtBILVCLBQVXaOzxOR0jWN+qcAWtOUs=;
	b=JIkTYGR7c3dBBvOm7AjpTTamir6tzeiE8i4VH5dKsqbX5bmHIvB95gYoaMgoa4Ub+NHrYU
	CnWHGe0KUKLcvrc1n2fX7NR/J2uqYZtDXtRDuf0MidObYt+hfF4tWyxx3auvdqKZXFM/4G
	F3Ir1JZZNEwd7mErYBW9utRwG74VoC0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-q4fLkPwONeOf13DM6mKo4w-1; Fri, 20 Mar 2026 05:46:04 -0400
X-MC-Unique: q4fLkPwONeOf13DM6mKo4w-1
X-Mimecast-MFC-AGG-ID: q4fLkPwONeOf13DM6mKo4w_1773999963
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b4d3919e4so1356868f8f.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773999963; x=1774604763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07FEaUp+g6rgOtBILVCLBQVXaOzxOR0jWN+qcAWtOUs=;
        b=aIj8C8rn76H5r0fDfai0w6TDHUCVidPJShtNCAT16vhyCaZBx1ixOzN9/iaa6eW3Hz
         Wcid8OXoAngaaAHXXlY4rYxc0dVPNFkc3UIES+qRp+9uVsECecobhej0GqzY3aU1xPUU
         PSS6s1OmyMU2XU43k8GZW66WnYB8d0+tQoikM27J6u6uWewis5Nsqmecd3/FjuLthqkA
         OmSt0Kf8b+GOs7tNjYncqdN1J4Q2aXP51w7FnFa+GrgCcLaLajaSaSa3CrqOY3Uw1kbc
         TOpjALiG0ESym5fxei1mZ91sDL7t5ezWweLJ3sCxApgjq5Vv9XZ9GO5QXoJZIhuoiHlV
         EWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999963; x=1774604763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07FEaUp+g6rgOtBILVCLBQVXaOzxOR0jWN+qcAWtOUs=;
        b=GpUTZhVV0Cwx0x+du4moHCp6UZpy3rhAkTWegEE1r8UAEId5yNW8OBGKG2LgQVnD8g
         tQ2f/MbjTuJZZ7RCK9kchzfUQLTyTUApCFtgHKkGti2bSa7IKEJynDS3+dDQ1Fc/sh+L
         ZVVT7kraPf4c6bHPbwT4wVePweKvuGMcvJ8bGP1i6L1HNmgVVuLXtViMgbygQQWDVCMP
         HAMdOWc+1THUoq20QMqww7+Xra4b6DtgRkMmnuGDBPmw11+JBeJUtrig0ro5FW8C1Ek6
         6fFqaSv0QMdtHKzSrJRdHFMQHldKhX71865Lt5YsuUCI1uUonp1cYuKPREo18LJYx59j
         uxtQ==
X-Gm-Message-State: AOJu0YwYfWWSxy2OeRz64kQDNR+iush6u4dePL3dlW+tFYKjVOxCofvF
	SJXAWGNUQEFjwLGjgyZKZLxNX1GdZ0azt/ypaTKolXTRrd/WUfgXjeyWnSUNZ04zkCwtof27oer
	bEBarEstJ4UxmacolA2fQAAQvbRHaIQdtR4EL2+KV/1xqqFk2WJPt/51E3g==
X-Gm-Gg: ATEYQzxmyyPqxBoQBRjA4LJmHrQ/k5+1zvmoHE71yORWvQpJZaM+5b4UvhTns6ZvWFW
	WfsG1vVJbM4QoBAWp6MkbHcTp8GbvbPZCQv/59OAt7siGZ1KyF6xa+BGMY4FYRTtoTgDw4tW6Pn
	9JQS1cJWxdTmAf/oTVtVjVa5mzJjDYeUNOlMgOSZOn3CTaYW4/Rjf+MNNUcDpHxBMw+DQ4zvtFh
	Aav/7cepYwTGX27UcAy/vc2oppElGM33TvF0H87VgxsCG9SRu3SIxx2rLtApbPb7ydagVKQRn4a
	QnvdHDKLUO40xIsF8dhhF0SzpUAoUF0aO7is40lkCmRCNwCkZSb+12oRSBrViuheL4cXBRSE7sX
	P59nWuS2j74y2cnyT
X-Received: by 2002:a05:6000:24c9:b0:43b:3c32:d8fa with SMTP id ffacd0b85a97d-43b6428269dmr4456095f8f.46.1773999962864;
        Fri, 20 Mar 2026 02:46:02 -0700 (PDT)
X-Received: by 2002:a05:6000:24c9:b0:43b:3c32:d8fa with SMTP id ffacd0b85a97d-43b6428269dmr4456034f8f.46.1773999962228;
        Fri, 20 Mar 2026 02:46:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae048sm5323478f8f.1.2026.03.20.02.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:46:00 -0700 (PDT)
Date: Fri, 20 Mar 2026 05:45:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net] virtio-net: correct DMA unmap vq mismatch in
 virtnet_xsk_pool_enable()
Message-ID: <20260320054334-mutt-send-email-mst@kernel.org>
References: <20260320013531.36931-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320013531.36931-1-xuanzhuo@linux.alibaba.com>

Patch itself is fine, thanks!
Yet something to improve in the log:

On Fri, Mar 20, 2026 at 09:35:31AM +0800, Xuan Zhuo wrote:
> When enabling the XSK pool, the header DMA address is mapped against
> the send queue's virtqueue (sq->vq). However, the error handling path
> incorrectly attempts to unmap it against the receive queue's virtqueue
> (rq->vq).
> 
> Ensure the unmap operation uses the same virtqueue used for mapping to
> maintain DMA API consistency.


DMA API is fine: we end up with:

void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
                                dma_addr_t map_handle,
                                size_t size, enum dma_data_direction dir,
                                unsigned long attrs)
{
        const struct vring_virtqueue *vq = to_vvq(_vq);
        struct virtio_device *vdev = _vq->vdev;

        if (vdev->map)
                vdev->map->unmap_page(vq->map,
                                      map_handle, size, dir, attrs);
        else
                dma_unmap_page_attrs(vring_dma_dev(vq), map_handle,
                                     size, dir, attrs);
}
EXPORT_SYMBOL_GPL(virtqueue_unmap_page_attrs);


So what matters is the device and it's the same for all vqs.
A better way to put it:



	While harmless (both vqs share the same device for DMA) it is cleaner
	to map and unmap using the same vq.


> Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")


And I'd drop the fixes tag.


> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>





> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..7c6f304b7be5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5917,7 +5917,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  err_rq:
>  	xsk_pool_dma_unmap(pool, 0);
>  err_xsk_map:
> -	virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
> +	virtqueue_unmap_single_attrs(sq->vq, hdr_dma, vi->hdr_len,
>  				     DMA_TO_DEVICE, 0);
>  err_free_buffs:
>  	kvfree(rq->xsk_buffs);
> -- 
> 2.32.0.3.g01195cf9f

