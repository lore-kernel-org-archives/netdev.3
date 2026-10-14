Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C8551982
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995640; cv=none; b=IrQcgQGaolsfT8GTcK91FGRwzOJKQu5E6T8N3WErW17rtj9bh79MDguYgJbGpL6XQuJbgcd1rm7jI+EqRXiObsuSokcmSu1hZo2tJIcAbARe+U0D27lLk35ETeWnUpBwLYOtRAor5Wdgv03KwoLmq8pzLu750K4sFZFyM7dOXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995640; c=relaxed/simple;
	bh=03prvWYuPM9S8kmgrWoC3fCmFozkGleIo9XhNkVgCtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od1ODIx2Z8pVyFApgiwLAFDmdx5sXeTluMBhoVlEUyF8JB+CfFp6EuG8cfq3QA/xeIFdZxp9KeBRyEDFkZnboEGMhVJiPQBHgqYo6i8g0/o1WY5OjjI7f8SFxy3HH1F9SqLSwQ69Y5zToU+U1fzGAvY3xMysVq36x6INOWs/KuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pd7irBGa; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd7irBGa"
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cc790c60953so252207a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791995639; x=1792600439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gzw9aMKz/xODwzz6jPerfVV+ZDaTeiwtt+GIjli64uI=;
        b=Pd7irBGaIfGk47A4W8byWcdXxiyBIqvKEbA9YhOh3SRQ6mJyIKIRRLuIPMYQAvnKMs
         TiiQbQe1X9LW8PMlgREmTed2G73VpjPu9b/hQC6M7174NlPobQQvYC7JbWww84NvkGVc
         jaPpkkunMPeYYbs7LRpYE1NB3orJeiitk5w+ztYeo5vRK1StrQIIlrqN8LPbbwn/q7pl
         LyTa9PdacwnhwmfVzvAYeCHjMCxA/kI1BexjubiZ4KYMJIByLay2i2hNOuiNpYiGNnZr
         oredyfHyKPao1I1MMDdfl/UgbblGTGEjrFSK49edHqKhn/nAtTq070F5HAFN7V6SOwU9
         2M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995639; x=1792600439;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gzw9aMKz/xODwzz6jPerfVV+ZDaTeiwtt+GIjli64uI=;
        b=auvlHfK1//JPnQUpxy9WkTdGSmpVsbcHcAx3CkUDnNMOFBQOTM/soZ0ZGHFn1sA8RR
         Fnzfpv8wttIsk/RzQ75BAdVbqs6ZPa80HekzwXWpeplQp0LG7lWrK9gECPg5vyZtWAAK
         7kxKi2EeuCYecwQnXkzf0wNUbPDFJJ2/otYzBvo4Jt/6BnN88M/UsPquB92wGVaZLf4+
         Pu8C7jBMsU4/WcMB6vnXzlxBPPyAUIBeyX7fIqIQr+CvqrbmpB0/N2fSGpCrBCYy9i8a
         S+3cpfiwuaTqBAQC8yy48uyFxl15t0c9NVKvOPGf3BJCdZJr02+VYP1JoUwqAN1OqQAo
         czsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOr885sELI6Ic1kKpVWka3oqA6U69EPIlmC2nzK+WL0oJz6w3jnvzpDXwJuIXvu5TrUT2MkcM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeTyeS46+wOp67B/Ma8sZvLhnf/kp56CuT34uj3DPe1rHWDw2s
	GXiF7cHHD7Q6EEXjHWZtLaEI8YH44fCY6j2eWouqM5W6UuQp6EkAijRQ
X-Gm-Gg: AYBFou2y8K74OJCauG05SRV9+CmNo/3GQ36MJAfIPiknpIvf6ZV9wKO2bIwiE4D6a1w
	+e68A4qWVztFWWU+5L2W+NaYFo3FUGVXaiAIR2TN0P/k9p47lyG+4B1Oqi0929Vvoj4yJ/AvKD0
	SRDwOBEWmBaXDyiyfK1YpDsJeVVgWCep52pu0l5wbD7HsmlPv2VVIPoJBUeGXgN64PqNlrmpkv5
	xMnUIyYkloWpXu6DXAiCwJVMjpFX5rvKQ4aA1FZSZaPtQ3fj93Ds3VuRxEyvtle8+Nz3m0Xp2M5
	3RTq+zXFWz8KlZR+CcJpZvtLjTYCeKe11jUDpPtviu9Gvn/qPnidKFeCbNtD2T6H5YPEVNMpd2W
	JdWxYIs5uqZhc6964F3jTw3UoUSR4mPCa466uu+xHcP7KHWVconOAUKS6JxHGiWvyxuRLRtdlOh
	hg2JYy3WuyxHvFpzWrwCKzitbam/dMnH9GKTvCS9UcO2kyh9G+yblvo1puliDz8SHr
X-Received: by 2002:a05:6a00:8c4:b0:891:a63c:df97 with SMTP id d2e1a72fcca58-897c6443681mr15560946b3a.15.1791995639007;
        Wed, 14 Oct 2026 09:33:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d80511d47sm1291926b3a.54.2026.10.14.09.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:33:58 -0700 (PDT)
Date: Wed, 14 Oct 2026 09:33:38 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Taehee Yoo <ap420073@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>
Subject: Re: [PATCH net v2 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
Message-ID: <as-uBvRisS7HxLHJ@devvm7509.cco0.facebook.com>
References: <20261012174300.2338784-1-almasrymina@google.com>
 <20261012174300.2338784-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012174300.2338784-2-almasrymina@google.com>

On 10/12, Mina Almasry wrote:
> When a bound net_device is unregistered while userspace still holds a
> netlink or TCP socket reference on a devmem binding,
> mp_dmabuf_devmem_uninstall() clears binding->dev to NULL so
> netdev_nl_sock_priv_destroy() will not touch the unregistered
> net_device, but leaves the dma_buf attachment mapped until
> __net_devmem_dmabuf_binding_free() runs later on socket close.
> 
> Because dma_buf_attach() does not take a reference on dma_dev, device
> removal frees dma_dev while the attachment is still mapped. Closing the
> netlink socket afterwards triggers a slab use-after-free in
> dma_unmap_sg_attrs():
> 
>   BUG: KASAN: slab-use-after-free in dma_unmap_sg_attrs+0x76/0x2b0
>   Read of size 8 at addr ffff88810fae64b0 by task kworker/3:1/53
>   Workqueue: events __net_devmem_dmabuf_binding_free
>   Call Trace:
>    dma_unmap_sg_attrs+0x76/0x2b0
>    unmap_udmabuf+0x8e/0x100
>    dma_buf_unmap_attachment+0x145/0x330
>    dma_buf_unmap_attachment_unlocked+0x96/0x130
>    __net_devmem_dmabuf_binding_free+0x156/0x2e0
>   Freed by task 9:
>    kfree+0x1b8/0x550
>    nsim_bus_dev_release+0xe/0x60
>    device_release+0xcf/0x250
> 
> Add net_devmem_dmabuf_binding_unmap() serialized under binding->lock
> and null out binding->sgt and binding->attachment after unmapping so
> unmapping is idempotent across queue uninstall and deferred binding
> destruction. Call it synchronously when the last bound RX queue is
> uninstalled in mp_dmabuf_devmem_uninstall(), except when a leased
> queue is unleased: the physical device is still registered and, if
> restarting its queue failed, may still be using the binding.
> 
> The same use-after-free happens when the netlink socket is closed
> before the device is removed but RX tokens or the pending release work
> keep the binding alive. Such bindings are no longer installed on any
> queue and were already erased from net_devmem_dmabuf_bindings. Keep
> bindings in net_devmem_dmabuf_bindings until they are freed, hide
> unbound ones from TX lookups with an xarray mark, and on
> NETDEV_UNREGISTER clear binding->dev of unbound RX bindings for the
> device and unmap them, unless the device is a virtual device leasing

[..]

> queues, for the same reason as above. net_devmem_lock serializes that
> walk with the final free.

Can you explain net_devmem_lock a bit more? In
net_devmem_dev_unregister, why can you not net_devmem_lookup_dmabuf and
then rely on the binding->lock? The rest looks good, but the
new lock seems a bit excessive?
