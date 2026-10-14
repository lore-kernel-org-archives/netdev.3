Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2D729B216
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001966; cv=none; b=YiVdOKgs+Q+1Fq7Br7Iy4S7UsRYBJR+JTk6CRUpA+stMi4fLmGU9ms8hWM+PZRn/ew1yZ0mH+B6i3MTe6igOboXZE30wZp9Zw/xncjP8IdkDkSOu6ifmiCQmhu5zDcRRZynzuPZYGtZNvaqw9DJQ2aVj5JJYClPYO+dtdzh4iaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001966; c=relaxed/simple;
	bh=ns6TSLqqG4MTOMfmi5q4AEKowCQ3XE4tUlVyn7TDXTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbWtURHZ1d+RsvSJ+mZFGWA2FKGQRhGSlyIDYRSdSzBaVJmc1uOGZu6/xU5D/PmfAxo/kzWaRzuQt3IlO49a8LVmymPLDL7otlbLQh2NBo0mQQ/vneVB3aIOyI93X1WjF8IQZCR49t6YSk6D4uH46hyDCG2THK6NBK0Ukh7zK0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhpmkG++; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhpmkG++"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e60e97f158so25963515ad.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792001964; x=1792606764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J+nXTg+yHO+HzCVCOfYL3HGecRLoANolWSsL+AcPHcg=;
        b=NhpmkG++AUZjpTpJcz6F0akp8q7eVDxKm6KUCXT6uUZDfqFtm6OB0qDw0JU9QyhYhJ
         e4pMAqLCQwaYl1RwUIsN6qgtAcuQYoMY7tAiLEmvf9pAGs4yZrN/cGnks6OomyLARrMl
         BOHiNY8bdlFwfzt0qgNkzh0MzIutjp1F2p42Dwv2+FkDo0lUnSV9xjk3Zwe6j3lrlCKl
         21fvHIfd97IfgScYtYcH82sgh+lL4gclBPZSgVg7py1rwCCPam7iKaU4y4K+PBkfqa9l
         a7PifLjZ8tYu3uw2xSY6pSUoTQ5H4NBhNSMno9rqj40OSwTb9a76JDKJ0rvngDB8XHDZ
         kLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001964; x=1792606764;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+nXTg+yHO+HzCVCOfYL3HGecRLoANolWSsL+AcPHcg=;
        b=rkO2rizJJQodDJ6JOD08u4DhJceOOMPf5xTxrhp2kjQ+CkhwZ1WsQMSVX3dqpQRqhy
         pqW3L3VJov2tdzWqQDz/+WpHQT5kyt4W1YO5xcj0ZIKWrQvw3hk2RVBHsbXtxdpbv8vl
         ARmZu9MJv4KTGom1s5UwXic3a4GTe11KcEtW6LUigPBpz3kKg91RD8vQUka5g7XkgaZt
         6Moh2g+owKwMdWQzKi4P+GTOoTeV7ionDyu4IIrcKZ+A+YyVYTZxfbdYH7rWfsfEsaPc
         1bNA7naeqRn96a6dsPQ3oJRWybYeUKGHm6M75IcY6a1s6nwQflUVAjQNb15jP3G/lVTU
         Uy/A==
X-Gm-Message-State: AFq9FYIfIynfkmqMBUrlGLf0nKqT2qM0yeqcU/pzq8zWuQYUjx/7RFVR
	G7WifA7Y9WAjZ82RdPg6CRTTjq8UJvl/nCOkzuwrLw9rm5YiO3Kiyvd0
X-Gm-Gg: AYBFou0YpsPPs6PMejrWEtCQtbjlr7aEgdfhogofDdsWKZCGfoVtXsaVZnavhBMTXkc
	6FFPdUb3UwYJEbsZRrS7oOPWSpj91wLWLilta+5sOeNUVDFrQ7DAZGnQES5umQyrJSxS2KHKWws
	o5+jot7dXiN8qWx5mM6lAK7mz7O2tKshb1UPYHj2Zd1kt/uvpZFkCmp2ph3u5gHWay6LA/Tgqjh
	ICZ5WGGsWZovjtSkmjEBcwkHaFDXurWr3jiVXGGmZABmwNmfawooEMJNHYSrYcZgBAcKsL+W4Xx
	xeJOZCGliO6HT5ZZrM2fxHAjvFQIq5RhboVqM9KoqcpHZoWOCrYXRX6ooQqWLMxL6mnu8Z3e8Ap
	7V0Mpbk3QU+V2eRGKiupi7IRhrQhKdZdd4ZtghXCWJiTqifEL7qjcASrAd9TD78oP2L15Vcj81p
	mZl5CRPefn00arapa3eq2hnCIV7T9j6qpEQsDCpxNNjdA2kHdIgD0kg2TdSFZimtd17WY79EFd
X-Received: by 2002:a17:903:1a6f:b0:2e9:4b9f:b81f with SMTP id d9443c01a7336-2e94b9fb975mr15782815ad.31.1792001964091;
        Wed, 14 Oct 2026 11:19:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e525sm74136655ad.16.2026.10.14.11.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:19:23 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:19:14 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Erfan Sharafzadeh <erfansh@meta.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, almasrymina@google.com, 
	kaiyuanz@google.com, willemb@google.com, asml.silence@gmail.com, sdf@fomichev.me, 
	bobbyeshleman@meta.com
Subject: Re: [PATCH net-next v2] net: devmem: allow peer-to-peer dma-buf
 attach for bindings
Message-ID: <as_HT7Dfp8MIkTfa@devvm7509.cco0.facebook.com>
References: <20261013210954.2170175-1-erfansh@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013210954.2170175-1-erfansh@meta.com>

On 10/13, Erfan Sharafzadeh wrote:
> net_devmem_bind_dmabuf() uses dma_buf_attach(), a static attachment
> with peer2peer false. Exporters must then keep the buffer reachable
> without P2P; amdgpu does so by placing it in GTT (system memory), so a
> device memory binding silently ends up in host memory.
> 
> Use dma_buf_dynamic_attach() with allow_peer2peer set, so an exporter
> that can do P2P to the device keeps the buffer in device memory.
> Dynamic attachments are not pinned on map, and devmem cannot handle the
> buffer moving, so:
> 
> - pin it with dma_buf_pin() before mapping, which keeps it in place for
>   the lifetime of the binding, as before;
> - wait for the exporter's kernel fences after mapping, interruptibly,
>   as the core does for static attachments.
> 
> This follows the pinned RDMA umem path, including its limits: the
> binding cannot be revoked by the exporter, and once a P2P binding has
> pinned a buffer in device memory, a later attachment to the same buffer
> that cannot do P2P may fail to pin it. Exporters that cannot do P2P to
> the device place the buffer as before. RX and TX bindings both go
> through this function.
> 
> Signed-off-by: Erfan Sharafzadeh <erfansh@meta.com>
> ---
> v2:
> - Target net-next and drop the Fixes: tag. This adds P2P placement
>   rather than fixing incorrect behaviour, and it relies on recent
>   dma-buf core changes, so it should not go to stable.
> - Wait for the exporter's fences interruptibly, as the core does.
> - Describe the revocation and mixed-attachment limits in the commit
>   message.
> 
> v1: https://lore.kernel.org/netdev/20261012170754.669462-1-erfansh@meta.com/

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

We never with proper in-tree exporters (rather than "mock" udmabuf) so
here we are :-(
