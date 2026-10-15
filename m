Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E04F5E0B
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792100099; cv=none; b=p+OdYWhluNUxRzmSmJ4vLWlrx8tNAIZWh/yranXRkg905W7lWVcreb5eJ8owgRxTeb0+ZaXxS7qYGeakP+YpNj/lKVqaew+cdou/aiVNj0E9c7cVs0VJHqLba7I658mu3aQb07hfPdLhEnntchWqCI2JOPbHTvXChhWYRu67BYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792100099; c=relaxed/simple;
	bh=VN5kEFS4f3DhbQuQuGez9j6k054EcTB9lQZnc4iClK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciuwAIIRyZcc8FnnOJhYUXl6QHgYaSn5MtF7WgHctgZd0pTGJ6uMHgjSldvzbP+nLqn/+GUIIfekhrlANeqa5gInnTtlunm/M6nt3t0w9sFRMJeNO0pvHNIrXWnJLt0JnDbtUB/IdX/BWgsq9tPpUoqyB8iSrl+dcptdCwlArjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1x6Uo4w; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1x6Uo4w"
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e97ddaf3c4so690615ad.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792100098; x=1792704898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6tf5XWfDn7dzpD6pWKJEv/C/OLuu0jZ+hahvmMgLmFI=;
        b=q1x6Uo4wWVxB8EiRjGzUXKX5bAHBK0k4IZzXfZ5oDFfLbAjHpXra+fLxkr88aGk4G3
         qkTquQLck3AGtvdOkneWRyfhdWg7I/73gJB6r/UWhu9esKshFkod9Jpdryeo9YXDlEWJ
         5MOgTzp8XBpPYgQmrwFz0XM/V1FjhdszX/LopIVKlZk/k4llXDwpk8B/LmHujpAz3gRI
         0GrEpnDtC9s+GUJKvwPoSg9WrxxWOY9qtZCe8x+XIDUA1XkKMdc+mnST4XjMluqPbwVC
         opdN6atnmS/P7nq8T9IvzyRC/ggx2jD9SoUOAmkrlqr9oeK7SrWcsTF92ZdQf9AsJlpt
         nqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792100098; x=1792704898;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6tf5XWfDn7dzpD6pWKJEv/C/OLuu0jZ+hahvmMgLmFI=;
        b=K+TDKG91cFC7VemKMqAxvNZZEka/KnGyaeZbC09wdS5tzr/riAPLnkPAge0Vygd88m
         vYYZLRrYy66j9Nu5bJMuxZtw2rKdcEU0YZ3aRuMdC29XWJWuGcu57otiLuEEhx8Nviwr
         66XJXuBtKo0c+bkMINQhXi/OMfK+pAP4M/KFIEF3A0dMOVE4MdlFT46mx19XuYxN8mK6
         bTP1sNkf8292sVmWJ9wZhDxNL2OlNE/LxIAiR16ceZFq4JQCt7YkfdBVCmcqnMvQ86vf
         NXYVEfSjwbhEPWRDl8WxjoTFXjpgwyPFPk8fGMKroEG/3PpCnXgqS4gLwxrlO0KTLxzV
         c+0w==
X-Forwarded-Encrypted: i=1; AKwUvBzvimN4UQ+tCsshxrzfUMCFV8htNq3rMLXMhqmWCT6jhOKoPV3hVAhnrJuwheB5IqXvIQmE30o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTFg7itiVcsL9ZzjurahBZlOjYy+xdibq/08huY7yxYjmPVbqz
	rLrODgwKNcufUgPKCxCBc+O8ZynZyCQm7YppWhZsuQEsdwKQd+siJBd5
X-Gm-Gg: AYBFou0fsY2v2ILf3u5imEaVbR7mab2H/3GKqzFOnLsFJFncz+hped8EJeHtmOVtvwk
	mj7+18yuvxh8GKFIZ03iK+mH5YHnQB0IvKYF2+JrljQb0oACrPuPOI0jg1OzRJPBWKtQtvfWwNR
	N4CnkG5t7uHUvyWdVZISvurKgfwN8FfFrdOVJBDZH3Q5lsh7O64pgPPkbuenxQrd89EwWdCGYhx
	o0xLsCg10iy084KcqhdHzVyQJhLsbCXvkbjJjRMADbBRFg8yhh/kTpQ8h2rS/Psa44EyF05xgdO
	uvNDCWH2YJ3fEDzeh3eyOtQfK0htjcZMpd2srGdJnOJxTnDYqxwouqy2TtpdiVLKu3Vqo+B4EY2
	2hB3d9vFrOukIo302leNzZpdpCCxlIkIGuGZE5frDzx4I1kW5YN5roQKH41vaqJpUwXL6MtZec7
	MPLFFb2a6KwiQ/rxWp2GeXXpo9Qu9ZFpLa02KuP5KdGdBdW3kI13mxf1x6/IuU5KS1ln8ogArXS
	rM=
X-Received: by 2002:a17:90b:134c:b0:3a8:92a3:8baa with SMTP id 98e67ed59e1d1-3ab3a953bd3mr17162889a91.27.1792100097999;
        Thu, 15 Oct 2026 14:34:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4991b8asm847025a91.16.2026.10.15.14.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:34:57 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:34:36 -0700
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
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
Message-ID: <atFG5qCMA4PugjFj@devvm7509.cco0.facebook.com>
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015163915.1166043-4-almasrymina@google.com>

On 10/15, Mina Almasry wrote:
> Set a 64-bit DMA mask on nsim_bus_dev, enable NETMEM_TX_DMA on the
> netdevsim net_device, and configure page_pool instances with
> PP_FLAG_ALLOW_UNREADABLE_NETMEM and queue_idx, plus PP_FLAG_DMA_MAP |
> PP_FLAG_DMA_SYNC_DEV when CONFIG_HAS_DMA is set, so devmem bind-rx and
> bind-tx netlink operations can be tested against netdevsim in software
> selftests.
> 
> The pp_hold debugfs file allocates pages from the queue 0 page pool, so
> refuse it when that pool is backed by a memory provider, and take the
> netdev instance lock there so a concurrent bind-rx cannot swap the pool
> in between. The software PSP path checksums the payload when the peer
> does not decapsulate, so drop unreadable skbs there.
> 
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Kaifeng Wang <kaifengw@google.com>
> Assisted-by: LLM
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
