Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A23BE14D
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414664; cv=none; b=jpgzZwn1rkXqtP+OUY8N9xJ/xCEOs6lRGZeBxdOZY0l6vY6oRdsHvYesjxGGH6XsRQdKVJdmfmgcs03vAY5JErEMBatokYcHAiIbR8vsRCvvNIHcsZgObDHby4iOl2SvCwz5jBZ49YwwsZ9AzORzch6TYaXvYQalM8wz3u1XL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414664; c=relaxed/simple;
	bh=mNCwouhEN17Ia0dJNDPGIKLEvTsNZIAvbPqxXsUkGLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3lPp7vNXlE0FdZ8caas2NovdMZKfrarLj/BBaatKPGVGhR1Al0AqOubfUTZXA7LhnuYbFRa78ZMfeHi3rDnz0susY550qTqfLiGnzZeGpzG6MDSu71nRDNGHLBoejcKkBQ/44Y5a0TvvEZq2WtEoGsZzQJmb1wSq/nXSCv/R6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rggD72kC; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rggD72kC"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ccc2e84048so16514055ad.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789414662; x=1790019462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EuYJrEjbVWQ9XMhAMaw1RSdGZ7efm/cFkVNyEiVrURw=;
        b=rggD72kCkYVJPPWRGPD4cM9CxByr6KT/cytOBS9D8QFMEUueEiC8biGMLnnhynEKIE
         yv20cabhoiLGGQb4OtU5GRHFoNzRA40NmPrGC2Qfk7zujFeUyK9dExGBtlzXr3mj+oDF
         Veh4UQ/AIPlz5q2+PbexSWLmeUlE7OeWQpby8BKz0V+3zzEvtUBv503PuzSSHBTGmb5V
         4G/10Rt3A0TyLrlWNNkGutEVyLbsNM0CQSR05mZu2qZ+IRXTc9OKZnhWQtKdPLWfborQ
         LC1MbM/LqP6NaovDecuXmkoNsiIAn9zoZKl6twStZPmR9RRjNZtwq4RKZ+o9jNB2WdXR
         Ha9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789414662; x=1790019462;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuYJrEjbVWQ9XMhAMaw1RSdGZ7efm/cFkVNyEiVrURw=;
        b=1VjyBDiNjCusLTbFVQ15TUE89Ku7wHbrEEmKyyyX/yse9ELT/g8Lem4Ga/7whjg5bY
         ZEEWd7mnXOuBYrXe3UhS+uu/+i1/sXbSfQtcvYVRuHhDV4KHjyV6qkAbO47ak+BDdaaL
         zKcbTzAti09B6g3cSNoy9gIBfXv0xosa+JoWGV+dohyHHgPmhGSxElPKs+v0GPRgKCSq
         t42Ewk0mIlgIohyhlSTa5pxZeaKdpY2oH/OKAP+BN/0dW1u6ISiOniKL3tcYE8hd6khS
         FMqeaKSY8c33aSFx6mtTh/bEEaXZTy2nx/kD4+yhpmlCNLUazCz6YoHRmhwgJGRFWtCz
         aD0w==
X-Gm-Message-State: AFuF++mGpoL3MFtWPn3Ykb/UVFFfGvfI+WhjQOZGGDCw1TKOjgqJC0He
	kCu4elWUgNxGGtigZpHDjn1JOvS6W57Cm2jgPyuA0a5k0fF96ftEsLjI5S4rR706
X-Gm-Gg: AYBFou3yRn7EDriOh6zjYSnQAA31Cw1/X5drhrAo8wP5hocVby7MwqItq2NkehMBc2q
	GyzLTFSl1OSKFCOkDAAmKuFQajkHPs27cxrCEP5GO+rmY0fk2tMrIYPxuHdQgrXOzS8gWOnwrw6
	EjuALUvHoiggk88Xemt3PMQQnfRIKidb4hGHqpXs5Ese4uX5Ghmw9fjbKcEwRcVP3cYf3oJn81D
	nnML+Jr7Zc/TvTdWtKlsS7rZ6WpJvLhYpw1ZWFBN65+gOFyh6zFuOplweK73u748iJufLkcC3sQ
	xqtXaXGXjjIteWYTk2Y9g3/x7Prs1G/Nwz3d8HAWHnuOGaLKfw+Tc2geccJuQc4M3AzfnqtZK0R
	RM0DjyyWKmelra+DAsNlBOxc4/Imw/OrEwA8fKWx92XIkUr8oCtUWtAUHIj2KLOWPL09ZV5iMyK
	B30fwP8iHCcd/navwe+yhfPgiHJTG/Zkg7jnTh5cuh07umHb2QDwkaaB+Xk4alHs5n
X-Received: by 2002:a17:903:3585:b0:2d5:2f49:b3f4 with SMTP id d9443c01a7336-2dd6c5bdd34mr93003365ad.2.1789414661060;
        Mon, 14 Sep 2026 12:37:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd3f0faed5sm47949435ad.10.2026.09.14.12.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 12:37:40 -0700 (PDT)
Date: Mon, 14 Sep 2026 12:37:35 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, bobbyeshleman@meta.com, 
	almasrymina@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: devmem: embed net_iov_area in
 binding
Message-ID: <aqhMeY0r7ye0kuAw@devvm7509.cco0.facebook.com>
References: <20260911154555.739041-1-sdf@fomichev.me>
 <20260911154555.739041-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911154555.739041-3-sdf@fomichev.me>

On 09/11, Stanislav Fomichev wrote:
> After replacing the gen_pool with a binding-level freelist, devmem no
> longer needs a separate chunk owner object. There is only one
> net_iov_area for the binding, so store it directly in struct
> net_devmem_dmabuf_binding.
> 
> Derive the binding from net_iov_owner() with container_of(), matching the
> pattern used by io_uring zcrx. This removes the leftover
> dmabuf_genpool_chunk_owner wrapper and its allocation/free path.
> 
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/core/devmem.c | 41 ++++++++++-------------------------------
>  net/core/devmem.h | 26 +++++++-------------------
>  2 files changed, 17 insertions(+), 50 deletions(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 4883eb7f3a95..7949f8425bcd 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -29,15 +29,6 @@ static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
>  
>  static const struct memory_provider_ops dmabuf_devmem_ops;
>  
> -static void
> -net_devmem_dmabuf_free_chunk_owner(struct dmabuf_genpool_chunk_owner *owner)
> -{
> -	if (owner) {
> -		kvfree(owner->area.niovs);
> -		kfree(owner);
> -	}
> -}
> -
>  static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
>  {
>  	struct net_devmem_dmabuf_binding *binding =
> @@ -55,7 +46,7 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
>  	     "can't destroy dmabuf binding. total=%zu, free=%zu",
>  	     binding->total_niovs, binding->free_count);
>  
> -	net_devmem_dmabuf_free_chunk_owner(binding->chunk_owner);
> +	kvfree(binding->area.niovs);
>  	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
>  					  binding->direction);
>  	dma_buf_detach(binding->dmabuf, binding->attachment);
> @@ -271,23 +262,14 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  	}
>  	binding->total_niovs = total_niovs;
>  
> -	owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
> -			     dev_to_node(&dev->dev));

There is a leftover owner var, the build fails, will repost later this week
(to give some time to review for whoever is interested).
