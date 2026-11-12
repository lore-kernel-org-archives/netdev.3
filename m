Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523843;
	b=3sOzLbbqhovE6Ht4Wtr7FGj1w3cplqJPyWbYiOh7GB5adEVUiIiM2j0+YNh4PgkVpLTO
	 W9PzCgBmKvB1nye25uySE6Mu3M/D4Zh1CkZW6/t9SSp6wvv0Vnn7+d4y4e/lmZfpsuUkG
	 JsG5JJkNP5WjF4ELTXP41smoievb9L6ugb3UrL9VRMjcxnMcAh6BoWLOhFEGUF6G1ISQe
	 7+qvaQL3WTTzJgB+ATBSiqeK5YDsGTpx3pUjSrYQehWac3ER4iNR1VdSdrtwWJeJm2Ddy
	 Qac6NnX6m6iu82BrwLrUzh0bq+UyfWgtO4daPyxUodETxcfxi/5iyAVv/P9f3b0bK3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523843;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Bbe/QF3Vlv0xyp1ygk/EdM2oUtmqFKixGf2vCzmUwiY=;
	b=TTZSQYGcnQ4KbZntbzlYq4z0RySRMJBq/fuxDZwka3u8UMG+JWH0oCDnrXTUKGpXlAmO
	 twAtZVhjZdAqc+mxzrLBoxCHTFAaD0lOb4rbwl4VpETEOE2Z7zt1robct5BKPFIQunmXE
	 l4gWR+0RZ1m+kLZcSfYcFell+TcwIDoGmhPCHg0qPZCkgwzJuDkt+AsB4lRIwFUKIxky9
	 5QXIECShm2XTYf+9I+8w8+m1s6chP/qUeRZ5JQfK23P8nsYBpg4NwSusgYgurcCx8RX4U
	 lDnnW6Tzd4sAeN1MXQ4EdsR/7N9fqRJvHQEVZBtJ08Gz0Mm405fHwqjbetweky9tE6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DA7QxRQf;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TiMhGZQG;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05D2606A32E
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 22:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F05D2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DA7QxRQf;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TiMhGZQG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794523842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bbe/QF3Vlv0xyp1ygk/EdM2oUtmqFKixGf2vCzmUwiY=;
	b=DA7QxRQfymFLrTc9EZu2fKOCEnLMFsvpm148RAGiFAbg2IAAJXxeyKj+LlCguOoZvdvVd4
	RVoTul9R033MOj6v0D+RafOExm9e48be9Pbq70pweuSHMKFOBVcxgyktM3QXbrO/mLpyBs
	xQyDDCQGGUjrf3288Rp4+/zt8Ha9zNQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-XL-Sg-6vO2y9Wt9McPl_Vg-1; Thu, 12 Nov 2026 17:50:38 -0500
X-MC-Unique: XL-Sg-6vO2y9Wt9McPl_Vg-1
X-Mimecast-MFC-AGG-ID: XL-Sg-6vO2y9Wt9McPl_Vg_1794523837
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso1606115e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794523837; x=1795128637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bbe/QF3Vlv0xyp1ygk/EdM2oUtmqFKixGf2vCzmUwiY=;
        b=TiMhGZQGcmsWzXfd/aehsrvx8dYoHjh0tbt5hxAl8efFWVColaGD8vd3eA4hcILa7c
         6iB+VC8H/aNfS1JocurQ0X8szb6uh8R2VO++92GgKcIYIKIe1mYK+fGOb+BlPcGxo/OY
         lNnE9t6nGr1J1Kdomjkj53WVwEN+PH2u+rzM9cQmDOebBtva1vg+HFj5hsbkH5M5DEqn
         1wHakh6prdWUDifbo731fZiPMvsC6qqQ5IkR+3Y9GEDChRJEW+eCxOdYencqt1NF/k37
         TmvyKmGulzRJCDABQBq7r5MN0TfawwmJLgGmib2zY3sKvMgEcCEAo7iGLa0CdBa42JXx
         sRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523837; x=1795128637;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bbe/QF3Vlv0xyp1ygk/EdM2oUtmqFKixGf2vCzmUwiY=;
        b=a7LujgX2+Jb/S5oKewrXMEbgHD4ZDVVulAwvSwL8TihOTKZ189qOcuV/w3xx5AFD4B
         uRnPOUJ1RzvQihpvj5fSZ7UraFDwWotBJyX0D3XVYJrBgrn0lRnbEoe3+EycaT+SW2m0
         pQvXbB2MWTiZA4Ay1ECZDK+NJ0LRkx20F8gP3skR0yL1YojDlkcZAuYBY9FWsaGUuTCD
         zjI12kyAgPCI0z233iH0h8TTGDGfgWeIwEJRUKFQJqbO3z/Quzf2jrfFxDXX+L+/8yzg
         DqmW3z9O1qxwGivpOzsUFGp04PONfTW9WpZK20VenGR/ItAi4RmFnC80x8tYUndFf/TQ
         W3wg==
X-Forwarded-Encrypted: i=1; AL+hErGUZz4b1QCkhY/E2gqX+rBIV6jV8O0gb+HZgFELqDERr2Xo1m7cAsrrobOUnvznY8BPqn0wd6c=@vger.kernel.org
X-Gm-Message-State: APuU4Z92lQs2JbR73uytsgF5AbQyBEUaw8Io+liL26D3lYJKLmIs9cjP
	vDXZ/zrgqPqUxfg+NjXD+GmTZW16KTgheQqMSsxLI7Lu4ANRgFqG3EW74Pew/uilshj0JPIUpVS
	ksEC2ICcu0jjIsDMUPJKHf4rObajTv7M5wapHNhvN5dv2W8bgvQy+Kq0mBQ==
X-Gm-Gg: AYBFou24H/XvW28U7Q+8OY4VbwoXiejrBAyNuumluAv4rt7tkh0DOPeaPaL3YvmrNv9
	DnY8amhZ8oHy0lVBqHQllV8GDwu/JTvaRBTB1lEMnC8o7eAlqs/IVzSkEr3J9gIZxslPFauUzfa
	Qw+LsU7Z/eKISDeMGgNCkxourZSs972oACmoRML4ovcjQWa5R1XnRl69jzpzyJNjXN+KaNQWIM9
	JHmYlYxUZH+2QbCw4vUPtZ0BiLdOIl4skUviPLHPXyTlXbAci+EqdtoUgIAe2yLZEpe0vsrJCSh
	xMdbfVsT7N70M8P6hyiCtjstyAj0RzaTlzzzIrt/k5RDbQ/BbhFABMIwLAiVfrbDtWjV1ZIszab
	l/Tbrv1ucZfLkhUY8htrv8MJenXJexUwn8UtZD7HxPA==
X-Received: by 2002:a05:600c:310e:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4bb55a5212fmr12640285e9.17.1794523837328;
        Thu, 12 Nov 2026 14:50:37 -0800 (PST)
X-Received: by 2002:a05:600c:310e:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4bb55a5212fmr12639975e9.17.1794523836829;
        Thu, 12 Nov 2026 14:50:36 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac1159sm12604485e9.4.2026.11.12.14.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:50:35 -0800 (PST)
Date: Thu, 12 Nov 2026 17:50:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: kuba@kernel.org, eperezma@redhat.com, jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH 1/3] virtio: add virtqueue_get_last_used_idx() helper
Message-ID: <20261112174936-mutt-send-email-mst@kernel.org>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-2-lange_tang@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109094310.103979-2-lange_tang@163.com>

On Mon, Nov 09, 2026 at 05:43:08PM +0800, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> Export a read-only accessor for the last consumed used ring index.
> It's useful for drivers that need to detect whether the device has
> produced buffers that have not been consumed yet, by passing the
> returned value to virtqueue_poll().
> 
> The split ring now writes the field with WRITE_ONCE() (the packed
> ring already did) to document that the new reader can run concurrently
> with the poll path.
> 
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>

This is not a good API, packed ring does not have a used ring at all.

> ---
>  drivers/virtio/virtio_ring.c | 18 ++++++++++++++++--
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index db678f5a80e0..6d8485c73881 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1001,7 +1001,7 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
>  	detach_buf_split(vq, i, ctx);
> -	vq->last_used_idx++;
> +	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> @@ -1068,7 +1068,7 @@ static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
>  	ret = vq->split.desc_state[last_used].data;
>  	detach_buf_split_in_order(vq, last_used, ctx);
>  
> -	vq->last_used_idx++;
> +	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
>  	vq->last_used += (vq->vq.num_free - num_free);
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
> @@ -3227,6 +3227,20 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> +/**
> + * virtqueue_get_last_used_idx - get the last consumed used ring index
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Returns the index of the most recently consumed used buffer.
> + */
> +unsigned int virtqueue_get_last_used_idx(const struct virtqueue *_vq)
> +{
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	return READ_ONCE(vq->last_used_idx);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_last_used_idx);
> +
>  /**
>   * virtqueue_enable_cb - restart callbacks after disable_cb.
>   * @_vq: the struct virtqueue we're talking about.
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index f923e42cfd01..1aed4d9235c8 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -112,6 +112,8 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
>  
>  bool virtqueue_poll(struct virtqueue *vq, unsigned);
>  
> +unsigned int virtqueue_get_last_used_idx(const struct virtqueue *vq);
> +
>  bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>  
>  void *virtqueue_detach_unused_buf(struct virtqueue *vq);
> -- 
> 2.51.0

