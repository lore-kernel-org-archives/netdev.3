Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5A4F7CDE
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792100100; cv=none; b=ANadEgUgX+LHSKu788XjVzS1RqcQIn8vlL6stW9o100ZLLbwyoFO+iJiZ/A8rf1Jjfha55gKy/JknZy8BmPdPvykNcMk40hE2OLChQGWgOCEpGYt8kTEg3/uWjzEwFDhjZ6b0mS+jzIL7huhMFpESmV+UdFZJA21gaDSXlrUY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792100100; c=relaxed/simple;
	bh=p1GOe0U0AvmHyfaWL4dZiAn0LDZMD/k/d2Jjq/xAvbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2VWL1lGJYkq/cQA2z2HiV4xqJeeuHFFTx/RE5bYOmx9PVs7da3CQmWyvBPjYMm4l0TUrJpfyaVTHllG3hklaAotRBueI4C5KvO+AdNypU2i8ENp8/dS5wuaGq/mRyqiqLZZ48vnbLybG0NbWcsmnPf+MDdoui+NSyMbHwDlGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz269ree; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz269ree"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac6fe4aff0so1419718a91.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792100099; x=1792704899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pQimVVD9drWSngFOzWOAmVd128tPGcg8NvVnNLLNcbY=;
        b=Oz269ree3dZATYiimdp3jQcnAvwEyYVSMIy+rniSFMJDfm4J1MtCbzGWYkyA/TawLs
         +K8FIxcmF9ZhQZcg/7lDQGHRuCFaR4/yqgkwoXMQgMDjAIoQCup7Lj/2SvQ7RpIsAGeF
         jCU7hk+EJ8kCYj89Tc6gUEmb+TQjGhXskc+v23ACvxGFfyCqZ4y91bD34AYAg1Kg5cXR
         dZAemonm1K56VRePTjO9G+RTvHj+LYXHJThN4bejVrFXiqmhjqUqOxzRcFWsdogAf434
         pMsfOX2bzSiIhw9rumwGp+cefYPEGhiPG18AEsGvH8Hu7guVDQsVqpdu7G3CrsHNTJ0l
         ApiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792100099; x=1792704899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQimVVD9drWSngFOzWOAmVd128tPGcg8NvVnNLLNcbY=;
        b=B57VeRgQo0MO2ZwrpN6AQOCsAxwSdFWbe02qL8pk11bYm5f9gwHqGPUvaEMV6lkXMT
         Ory4rY0/ZY4dHBjtvL+m79qHVS09oCHnQ7nLDEsHPnnEVyYHJpbFbbqJhkwDqUoIHtc0
         IF/13CgmdrzZqgZAsHGeGyajfevPXqm8ItsAqvqtVG+adopitOu3hwFePYHSGXNlK8cC
         37+IiL+ztp5LKUN57xTZlRPlSYXJRUm/pyoyBoehMyCka/4JzJglHt1+VyQb7P026uVM
         9NGYN/7KqDTfmQpye/hs1Wx5qtPK/5b3klTx69+58+NeCmYfUmLaaPzPN824TJrrOEv6
         h0qg==
X-Forwarded-Encrypted: i=1; AKwUvBwGTbeONcuHvn7vYHyW0IhzdTo3PzW1XNCbsa+j0hxRBX9/UKokznRWZEuppMrdr7efCBWr7tc=@vger.kernel.org
X-Gm-Message-State: AFq9FYISipYBlNaB6tA8fa8xHRfKAHNhvMf2VNJ/4sfwT0t5LKNL8T/y
	hyIyhl45e7wg3Td4SiXmrkpCEbyrLiA2CsSwlXaCCUOpNblQlcF5fzAh
X-Gm-Gg: AYBFou1LyVZWqnnZ7ze0Y/JNb53iveltX4m2tw0sHUJ/7HR9AzUXQC0y5GS0KbgzmRE
	BQhQzdbVzVV37+c3wW7SLRwpKPhA8kG5RYayh2Wtbj9pZqf5dwe7uouCNXkbfmJsf/1FZqqhz+C
	TiL5w1i4u8UkNb8tz4RhnS9T+unxkuZKiR1jDT9mnOfOotHXxOIGhLKkoZ0FfngvoVSWrp/xuDP
	M2iUneUsyE6QZIanREsm43OipACME7ZfUQNza+1kC6LZ7cxQ3lhmrKVqlNgXFeIV+73+N6j2y3T
	z6biMbxHUU5InIcOp5PHCRMlP0jtcOT8i8woBBaEFLEgYQvm6ohGbamoPUYAY2PBp6kSLBkwZRW
	LpynAaY8egDC3AuyKFhWJ8KNDK4qG8+L/ovCnZujF+52aFeegiotvZY3BYU/W8wt5Xl0+uVhOfZ
	WoE8IbS7e1ffFfdQ4k/qRL0TgQt/FjsguwZdHPzYxhdJOsAcfTqaXoB0GfWMkzEUHyxg==
X-Received: by 2002:a17:90a:ec8c:b0:3ab:24b2:9016 with SMTP id 98e67ed59e1d1-3ab3a9a8d8dmr19267667a91.25.1792100098937;
        Thu, 15 Oct 2026 14:34:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549f175bsm119893a12.21.2026.10.15.14.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:34:58 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:34:45 -0700
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
Subject: Re: [PATCH net v4 4/4] selftests: net: add devmem RX and TX netdev
 unregister tests
Message-ID: <atFG77ZcuGHOsKgW@devvm7509.cco0.facebook.com>
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015163915.1166043-5-almasrymina@google.com>

On 10/15, Mina Almasry wrote:
> Add devmem_bind_rx_unregister_check and devmem_bind_tx_unregister_check
> to nl_netdev.py to verify that unregistering a netdevsim device while a
> netlink socket holds an active RX or TX devmem binding synchronously
> detaches the dma_buf attachment and cleanly closes the netlink socket
> without use-after-free or page faults.
> 
> Add the dma-buf, udmabuf and devmem options the tests need to
> tools/testing/selftests/net/config.
> 
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Kaifeng Wang <kaifengw@google.com>
> Assisted-by: LLM
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
