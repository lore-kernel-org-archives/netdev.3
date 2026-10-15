Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2E4EF134
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792100100; cv=none; b=cN3aun4gEjIOBAt8HY+DN6UeaGuYjkf4K5Bvg7PmX02fY6cXrgh6xC+LLduT6zHr7oeHnCOLm0820EMaA41QzIltAQlNjzvRSzuRTtiOooZj9t6GjmTFUUTLqe95Hdk5odyp3IyrPm3olLEC6J0BX+uJEweuHnj1e0EtAO/WzNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792100100; c=relaxed/simple;
	bh=Fw/5bVG+Kyih8LLkwOIMRNZ+2G0wXkoBUMuhbWqFVUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8UNxSYMS449vwxVg7D+hTC+liK3T0UUYsWgVQWi4gKYU8SbRtEIbQSy+vtBQ3S+gq8nKrZlD2tcGJ2z6Hcs8fl3w3qydXRaNwUpT8vdsPtuSGOrSAJwF9LEnSByHoSRSVi3FqL+1YDPOO31OgnM+Wdxg6vXYAbWTG3Tkw4/l4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUznG3km; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUznG3km"
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cc75f2924abso4014150a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792100097; x=1792704897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KDrSDxpyrWFU5Ei8Mpj2JURPZsUs0EKdCv3HOvYAEoE=;
        b=rUznG3kmeeZXjBq+AiRB9o9I9AwWxlPug7UWd4ngLXvaX75V6SxMiyOkvbfsG1luT6
         O8VwLa0pkb3NfGvd4uE8AF4KflShhvmnJpSe6KhO/qRM7wBb4cSzW/sF5xzLStLTLgEO
         YSV2ilVhADpSv0DoC0NnZpn0SeR7UWZjN6orVCuTcq1vQxCqbUPuUn7KmwrYaknj39Us
         4AQkwqXRYTtjftqwhsENCMrINt3V95ZAOVM/D3iOrL7M3gKdZZC3bZ+FzV7IV9U3DsHf
         Lw/Zgd/f0Gf/MARgElFM03z9WLFigLhfPjAcDY3RVvihQcagnZD/o8qN0/L4tVBZ4TG4
         AY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792100097; x=1792704897;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KDrSDxpyrWFU5Ei8Mpj2JURPZsUs0EKdCv3HOvYAEoE=;
        b=NH0hynKVF3LIbcgEXqMrvX8YzuceoiNpGEsQDUlxmhKtFicL28sUvgen2ouvTyOiVL
         Ws28E3ptVFOwGGFtc45OnGfH34pxDz/1zgIFU407yNlPy14LerbaKYjnhSUY6vbIZtdJ
         LpwyhQLW3aa0R5kxOFrO5pjD9BsH7w0u2u9XDBgtc6M2NwtndfuDT52LNYIEmaHxJj1g
         KGBbWyzriYOlh1xqtBpyahTDNUNDvgKZM/lQY0oF2cxqSgbDb70B9PRPJ47EHO8sj2lc
         l9fnscTscDqBPPTyjez4D+SAyud8Hni0wXxjcqyEHeK8aVma6ZlYuX4D4USVEuV7IloU
         N/gw==
X-Forwarded-Encrypted: i=1; AKwUvBy7+UGTUmm7O3mIT0iT01XEWhVU9lyamsdc3KathjPaDAYoBAi4GEKHs5dDjnszK/qgKT6824I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhd6Df6yWxmjahnouL7i+rHKt72/tCfiZxXSlgZApnHtI6jih/
	vzqhYXUBvmSM6WxZI9B+tMZrdreTT4WkbOongXixt0ZpQzAz90gs2Kta
X-Gm-Gg: AYBFou2C8Lpcw9Cwhi66Qal70Fazufc+P8EBf9JnujH0zOWLybZ6GV8+65iX9zaVHw0
	rHwtfjQEIQcnNPzhVRDAgHYEcc66scShdZi/dbr2v+IwGXt7y9sflh+rLdnnJ1ZdjJGUjsSevh6
	Ky2gIIQT4MYGapRObZMsWFpfwF0gryNU6oC7+NknnP6V/BNWBZ4Ny4dKazYsJI8noibmKCBdAs3
	tD1xL3VEyzfl1GNs4A0CMUwLsZrbnLNgfQKjKYEAmE43ZS3ej2ZuURN1WTvpurYQcTBzCJgqUAF
	+O651N0M4KG5TpUM4YbqyyyLyG/DSHgUpq1MbQ3hXs3ddzReiGRAvJdJmDa8Maxje5qhKOU6QUA
	6MsvXak4HSS/sDJFbGDzqrivsBjvRyqKP55ekcWOdf9aPh6lEAw0FCz2oGB7EkoMTBnv36kXA/c
	eYTx4c6XPNhqNEHK0i/4yLU9DCo3xa7fwP7eD+J3FPluwDgLVYDcj0k4f0XrLp2ezjWVabk9xVD
	xU=
X-Received: by 2002:a05:6a00:4fd0:b0:891:1caa:3f72 with SMTP id d2e1a72fcca58-897c81b54bfmr17760273b3a.57.1792100097031;
        Thu, 15 Oct 2026 14:34:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f579479f8sm157301b3a.38.2026.10.15.14.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:34:56 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:34:27 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Stanislav Fomichev <sdf@fomichev.me>, 
	Taehee Yoo <ap420073@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
	Kaifeng Wang <kaifengw@google.com>
Subject: Re: [PATCH net v4 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
Message-ID: <atFG1wz_26sNn18O@devvm7509.cco0.facebook.com>
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015163915.1166043-3-almasrymina@google.com>

On 10/15, Mina Almasry wrote:
> TX devmem bindings (NETDEV_CMD_BIND_TX) have no bound RX queues, so
> mp_dmabuf_devmem_uninstall() never runs when binding->dev or
> binding->vdev unregisters. As a result, binding->dev and binding->vdev
> dangle pointing to freed struct net_device memory, and the dma_buf
> remains attached and mapped after device removal.
> 
> Closing the netlink socket after netdev unregistration dereferences the
> freed struct net_device in netdev_nl_sock_priv_destroy():
> 
>   BUG: unable to handle page fault for address: ffff88824ca9b000
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:netdev_nl_sock_priv_destroy+0xbd/0x1e0
>   Call Trace:
>    genl_release+0xf5/0x190
>    netlink_release+0xd01/0x18d0
>    __sock_release+0xb0/0x270
>    sock_close+0x18/0x20
> 
> Extend net_devmem_dev_unregister() to TX bindings, including ones
> whose netlink socket is already closed but which TCP retransmits keep
> alive:
> - When binding->dev (the physical DMA-capable device) unregisters,
>   clear the binding's NET_DEVMEM_BINDING_LIVE mark and both
>   binding->dev and binding->vdev, and unmap the dma_buf under
>   binding->lock. No grace period is needed: the device is already
>   closed, so nothing hands the DMA addresses to the hardware anymore,
>   and concurrent senders only compare against binding->dev.
> - When only binding->vdev (virtual device) unregisters while
>   binding->dev lives, only clear binding->vdev so no new TX sends match
>   the virtual device while allowing in-flight TX packets on binding->dev
>   to finish DMA safely.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Fixes: 1abe839b34ae ("net: devmem: support TX over NETMEM_TX_NO_DMA devices")
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Kaiyuan Zhang <kaiyuanz@google.com>
> Cc: Bobby Eshleman <bobbyeshleman@meta.com>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Kaifeng Wang <kaifengw@google.com>
> Assisted-by: LLM
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
> v4:
> - Detach and unmap TX bindings directly from the xarray walk, without a
>   grace period or a second pass (Stanislav).

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
