Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794041877;
	b=FLk99Fs4En7ulhZvD/305XygXP9Cb5hEFuknmOLINrHMUl4Dl0PhRUJKqp092u8x7hP+
	 O9ohlX/8Et0fhTNjZ+vX+a018bX6eRX08odT+c0I0n5WuOfXz+QFG95hhQ+egU7AWPmFA
	 dyffN3A3ivktOLLyRu0jmh4S2WdmLu9awx4py8d4a2LJrbSt2HGBJG6wWLC4OJtzoiTPO
	 bDEQrdv+I8oWpRMb1skfyiuy6c/yNpqi/hZTJRFQYnXAhALTZDzDl2nPwtpTW8JsWJf/4
	 TdK1Skw2nwu94mB5Rx01wB8JwqCrhHqXmV8G079Nwzr6jCmG0hEkLJZ3IIGddXNTmkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794041877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=kw2zLGhVUDQnO5rFq8cwt1gUENr7fOzbT4vb4xG8V9g=;
	b=Lkr3B4+4XH4zrnF0jk99rDN+KqWjxiUn8I1ZTLG9fqawgzqpT0XbCWFqcc0cnpkiOOch
	 s4woQZHeMFIjMzzMi/K7Tu7JHGb8N+O528DmH/+iScmotfucD8Esvjg781x7sw4UhNNfp
	 tHqrxDnOmk7VyK4x/WObJEfzO8qJAqBHahOEcU8TmcexgmfGynow/tIJIQ3/4MrX5D5X3
	 PG9gBw/flTHLPTDW3d7CKXwCqxDiaFta0oBeBayFjkeiokYrRk7xR0+EGn+FKN9Hx7fN1
	 6DSXPDPFTvP+02b6plvxxzPrcrAk0zEax9EYy24FQ/N5gsZjfeDfUuA9rajAW6VszOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lRpHPSXl;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD9606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 08:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29DD9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lRpHPSXl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so14989525e9.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 00:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794041875; x=1794646675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kw2zLGhVUDQnO5rFq8cwt1gUENr7fOzbT4vb4xG8V9g=;
        b=lRpHPSXl3OIr5GNRw75fM5ZVnwTATltcAGYuVDQrLmWlSaBacYmaetJd4o5f9uMRYU
         DMX7l+/tuuZFYvaoIeUpeGqnN8iBg54fGc4dx9tLUJVuWK/+HFoYsScHTNkhMM7GVBxB
         mLyHawMWuiONSA8LiJKkIrHvjPDEc3AbES34AOLSaJxGBQAde/NUpJ/ThkRJJ4+RS4RB
         sC8YxfIrvJ8/GJmqqXRCc6x9YLqpY4tlKjYhYzsOrOaNhbyyI+Cw28y5pLNJvgoWuw0E
         YPcPunJtCM2x/5gGAKnET9uHIB7H8FPhQzVHOBFNpmXv6dhQHtcVQEg2DDWQWYgFFWo5
         mgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794041875; x=1794646675;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kw2zLGhVUDQnO5rFq8cwt1gUENr7fOzbT4vb4xG8V9g=;
        b=Deb+y/5H8fkV8jILVoPYe7HBqlLGD+P4OVo13OSuVMgUHN3J35Jo/HCJZ1OMxanr7Q
         nQ5oN/1L1uPccjeYYWIyz1DNteUstgkyZSQ7hgVGmwW9Ubk+t5YtgizweCSPyFN4GpEQ
         oYwHmmIptDgCIwkSKp9RIBNc/RUpsfFbEy/JplknYUakEA60JtECdHoxNqDHNFdt7WG0
         umy+I8aznyvkKgbccZAcqipp7tfjqTZbJRSpfvThmMOsaW5Vp5xmb9CBgx/Fgex74YmA
         Hhq7FXpI7nHyi4aK4CWpSDvmE3HbSM+wkdJaJi/7dLKVAPoTCXYS/EFFK+X6c1elltQE
         K1lg==
X-Forwarded-Encrypted: i=1; AKwUvBw4UMQW6Oiv88qlIY1MuMhAEmmoo70Nw+fpXmurd0q0I3qze15dB45eV1Ou6J9dVsIXbz2dno8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0Z963FTJkdqOG9uSsyD+/sUX+Nd+lGFkGy6Mpsfs+fs4oqQoS
	DhuEiaAY/35xdrKJbjO615zvyAkQ1mUSQ4++tRGqaTgNKoudVTTTSMks
X-Gm-Gg: AYBFou2rkCsMCqiWegIKwC8XHIulpcnNrqCEfWlQBBAE9JvpaDkx+ujsN7OwYLzdUJT
	jJs9vfRehv0voPK3WX/Rj8HscupJOxjMhbhC/hh/3+3+u0W5Rzwl0MlmkeXWjNIQELKY6edwf8J
	9biikI0mSIR2L+kr/L8vDAsQQdgRFWsyMwLWVgJRGbsFJY5txU3jCaJChGiVr9FHe2m5iYGE0NB
	rGVH5hDXN6qNDTqyEilopNi50hJymzAa78n6My4nP3rbeQ98KgxfPmUs9AfAFfVKqsjR8sNXY1G
	OIVN7xlrpGugGNV6lLDnJOnDypyFXJ8hbFDtwA4cJlPenETTRkBn0X/KnAApe4dQH++muDAVwhu
	PqD5GcrUdUn7ZyckMpcFms3rV/CGkS6DbFPUjJvjau9WZy7jc2qtGuEtn/ucmQGqhpeIU/CPeMa
	IElEt08k5Er4XC9R02w449QwxB5PLX0QPWliftbNO9DBs5tzQx+FngHsfFeEyOUKrBkDS4NfcMW
	vGtudfyyKQrTA6JCSR98X7mopQqdjEFWoIo0phuRti/sIY0DA/JO489+IWuj8pElJ9ClboME2nD
	G7RgjdVyjEupZOag/Cbted82hkhOb4HFBnROE6Dlfy0/3TPDJJxmhEVW9SSxQvnf8vmczb0+S7j
	gzUmPzsUOYGa0msLz3kUTYZOlUBXESqwSMCEmLUlgT/83emC/ilqUNP0mS3QP3VR5
X-Received: by 2002:a05:600c:a015:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4b6df028f04mr88902585e9.14.1794041875269;
        Sat, 07 Nov 2026 00:57:55 -0800 (PST)
Received: from unknown748F3CBA5068 (dynamic-095-114-115-226.95.114.pool.telefonica.de. [95.114.115.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7701af6sm8597238f8f.38.2026.11.07.00.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:57:54 -0800 (PST)
Date: Sat, 7 Nov 2026 09:57:22 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Matthew Brost <matthew.brost@intel.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org, 
	iommu@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>, 
	zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/23] dma-buf: Let the exporter select mapping type
 at pin/map
Message-ID: <au7mBMbRC8q6NILj@gmail.com>
References: <20261105-dma_mapping_type_v4-v2-0-78b8dc9ae80a@nvidia.com>
 <20261105-dma_mapping_type_v4-v2-6-78b8dc9ae80a@nvidia.com>
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
In-Reply-To: <20261105-dma_mapping_type_v4-v2-6-78b8dc9ae80a@nvidia.com>

On Thu, Nov 05, 2026 at 05:40:41PM +0100, Alistair Popple wrote:
> + * A pin or map that fails after dma_buf_mapping_select() may reopen the
> + * choice only if it was the one that made it. A selection that predates the
> + * call belongs to a live pin or mapping and must survive, otherwise the next
> + * pin or map would reselect under it without an invalidate.
> + */
> +void dma_buf_mapping_unselect(struct dma_buf_attachment *attach,
> +			      bool was_selected)
> +{
> +	dma_resv_assert_held(attach->dmabuf->resv);
> +
> +	if (was_selected)
> +		return;
> +
> +	attach->selected = false;
> +	attach->selected_idx = 0;
> +}
> +

After dma_buf_invalidate_mappings(), attach->selected is false while
attach->selected_idx still holds that mapping's entry for a pending
unmap. 

If a pin/map fails before that unmap runs, was_selected is false and
dma_buf_mapping_unselect() resets attach->selected_idx to 0.

A subsequent dma_buf_unmap_sgt() then uses matches[0].

>  int dma_buf_pin(struct dma_buf_attachment *attach)
>  {
>  	struct dma_buf *dmabuf = attach->dmabuf;
> +	bool selected = attach->selected;
>  	int ret = 0;
>  
>  	WARN_ON(!attach->importer_ops);
>  
>  	dma_resv_assert_held(dmabuf->resv);
>  
> -	if (dmabuf->ops->pin)
> +	ret = dma_buf_mapping_select(attach);
> +	if (ret)
> +		return ret;
> +
> +	if (dmabuf->ops->pin) {
>  		ret = dmabuf->ops->pin(attach);
> +		if (ret)
> +			dma_buf_mapping_unselect(attach, selected);
> +	}

dma_buf_mapping_select() sets attach->selected = true before ops->pin()
and the map callbacks run.

In patches 14/15, xe/amdgpu migrate a VRAM buffer to system memory
during pin and map when the attachment does not accept P2P.

That migration calls dma_buf_invalidate_mappings() and clears
attach->selected on every attachment, also the one being pinned/mapped. 

When the callback succeeds, the attachment stays pinned or mapped with
attach->selected == false.

A later map/pin on the same attachment can then reselect without an
invalidation.

Thanks,
Karl
