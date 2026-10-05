Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A74D0CFB
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219133; cv=none; b=uyCZwW6sFoP4dcMcqLLW8Qy0QBZzZh+pt+oQOLpTw7WAo6La48Za84u/sqaL49gBBk68icvBCvz0NMNDojKVWEZeHTOY+t6EatKOc/6R+toUD2Nruh54g7Wy/Gz1U0XwXLQ5HiN2JflBmKtaB/HoSusQvhHmir+itwESlwGWG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219133; c=relaxed/simple;
	bh=/tRm15v2eDHO+loamV84hQyUIYclpqiL/2I9jixRE6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc9k0ruzyH2C5/CHG1SZGEZ1qCCNDc3xAcm+A/6Z5V1TzO2/XJHVKROT7As/Dul3cbT5aIOhQAaSnoUN+iXtCPEvDyrfVbJJLPvxo+phfcBqnGdcTva7kUfbsVi+7ueKxCWh7TLfTOfrRJBhEPRoveUEVhCdrch9dYK6VYN5EkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbbmpGgO; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbbmpGgO"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2dd9bce707bso8490115ad.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791219131; x=1791823931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Ml/WHArCmzzGX3zR0T2czoQ4pKZKMdyG5OJbl9EXA8=;
        b=pbbmpGgO5iRj7JGDznK88nBraAxrqQ5X6sHI5PiSenjpQy8uK4emegnE+ROD1z7APm
         zJZ/406PYtFGWr6L3fMWI2/v8ZKrZcHjL3vpO0IyQmXZWy6oHlWXolXs+Zq4kvUrBAys
         TBNV1oGAi4HRVWNJbLARt+d9Eu/Ft/ETjIeGee2HK4F7hmlOARFh5g+P1FtZ3gDyz6Lv
         Coi3Kqgp2vt10/QzhSN4jMbCqEgr0dyNwW3xOsirh0STCyMtNkPo4qXJlmm5s7lpmAZ2
         gsj7DlO/2GibNPe7Rdrbjd8VX/feM6mGIT2oPR6cB4swQ2egQkcNMWZa+aSoKvAUx/5s
         2MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791219131; x=1791823931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0Ml/WHArCmzzGX3zR0T2czoQ4pKZKMdyG5OJbl9EXA8=;
        b=OPQI+BzKf8yuxxNnsZ82pvzzDXdwuDSXdRh/9/ilKqG+egK4seOHk6lrEOCMaKUxLS
         UmsK4i0Fqls4JAOpkR5S+GlIBqp/tS5IQhfEC9bghau0B29DFIKTL/xbGkduJh+ovJLR
         rJ1NIfYY+KLG5Ryv6np+lpAXVGbjtCmSCf4rRUiBRuwKI9jRjHOJSOHKwwGu+3muhlYU
         SyrgZL8TXKjkX8GquQPo7ugw6Z3cPuRbruh77Sf6vGXsK61em3kJTAtMdY2DSomFyFUn
         XLvmgWIDjvYkLx5VTKHgy08pjwCMZWtIS10jXl9etTIODb4HpE9OT8qTIvNGombsv25S
         btow==
X-Forwarded-Encrypted: i=1; AKwUvBwz4bixD45hP3jET07BIEWEd9dd1qPI67gcPSQIi/pTlVysuy2RKbkjffesFvnJqQABhZCGm9c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIV9STlCuw3u0XSgqexZxi0RalAGhU651oj6w2UfmdenaCx3yjO
	mQTjztDsby65Z5IEwy0tg+o5oXnUrMp57UDy8T4PoYFICbPMdhIFh4LZ
X-Gm-Gg: AYBFou3gaN9Wdg8NkyCO6bEnx+9R4T6NvQF8fZ+ITt8iq7izMVpoyloq0fcN4T+bkSo
	bBJgexQxwciPPkFrLZ6je0sIvj7clzIoaxBLd7YmnY0EGyzle15QtK4VSNEW2ZHoDi2qT/zjJUH
	yR9fGH3jWhpiNwwVntZDMcY84pm9VDYSzuQUt3/259iWEdYTjvF0HmgHD1nbh4DfW2lpj6t98/R
	b6NKvGaQ4Ty6XTG0K1AGfb4BN7K4O5X2xQtw7Iyha8+OTtkMubdbHeO4SSBEM0WRfwyYiIvGkq6
	qAMz5hDmsag29tVoU3SjSalo9F3RhEnkCPVU0QBf4S+YL6aJkU9cQu7mEuW/zY0yJPzSm7VdG62
	7ceV552GTGUanl5fFy5yNZ0b84uKKzlAEm+blT0LkXhNDSfwnjtWh4STfR/SLburASq9YwJDsSF
	pdME+/cgq0XFVEeCN6k1Q0eyJJ/ItYsmeeaCZOTaUZp9F9RJE2Y5jzPJ2ybd/zkH4d
X-Received: by 2002:a17:902:d2c4:b0:2df:a4d8:57ad with SMTP id d9443c01a7336-2e49b699f84mr98443455ad.72.1791219131179;
        Mon, 05 Oct 2026 09:52:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5f001d9sm10692365ad.79.2026.10.05.09.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:52:10 -0700 (PDT)
Date: Mon, 5 Oct 2026 09:52:05 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	io-uring@vger.kernel.org, "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, 
	Weiming Shi <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>
Subject: Re: [RFC net-next 04/15] net: Let memory providers set RX buffer
 headroom
Message-ID: <asPVkD_QwZtqVLs4@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-5-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002190018.696925-5-bjorn@kernel.org>

On 10/02, Björn Töpel wrote:
> AF_XDP lets userspace choose a headroom in front of the packet data
> in each UMEM chunk, and the kernel adds XDP_PACKET_HEADROOM to it. A
> driver whose buffers come from an AF_XDP memory provider must put
> packets after this headroom. The driver sees only the page pool, so
> it has no generic way to learn the value, and nothing checks that
> the driver supports it.
> 
> Add rx_headroom to the provider parameters and to the queue
> configuration. It is the full headroom, including
> XDP_PACKET_HEADROOM; zero means the driver default. Add
> QCFG_RX_HEADROOM. A provider that sets a headroom can only be
> installed on a queue that supports it; otherwise the install fails
> with -EOPNOTSUPP. The driver checks the value with the rest of the
> queue configuration.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

This is also a bit confusing to read on its own. Do we not need to
convert existing users? The next patch does not seem to use this new rx_headroom?
