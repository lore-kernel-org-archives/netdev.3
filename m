Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354735;
	b=wK4JYJ59089or2qPnBUe+TH9A1hkb0j9zIu1PMv97NlJx8Kx4Fm+cIFTO0No26rLQO+c
	 2nMF1/ytJDQni4KVqs7NqowPO6icxItsD6iJ3+J4O4yYpE5rhZaTfHYhM1B94MWZUozJa
	 rt4ouheyOaRk6IlwoeJNeDenWjVUwrMi/g4rDdvx686xQM/5IbwrSQVa9ADT+ogNqpT5I
	 8BjmthVrsmNcTHHVsioa+G4t4GkiuIcMOEpahc+j8+6Iqs6DxgAqev2Jum0+scZpjMAKZ
	 K7PlnEzN/Mj5+1RtvIaaz2F+NoykQgFFA50aG1soAI3gplVa5CsuUWmZLG0NrL4Jq0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=9rj8EzBjlrHZ5xAlf0shYcxqn1sb5NbiDhyrmTtYevk=;
	b=dLn7ONLU3X5VcMEYnBM30TtYzSElMLhkvGgw0FBhb5s3kH01EdQAr9CxO8KYyrD4AlIR
	 73ffh1PHIumLT9V/ztKphoZHN4tperorMjiS/1US4Qk9nCOJSSUkw9Cr+9kui+yPsAHW3
	 6i2xpn3JNAiHa88nL3H/gYht1zFsUdHGFgItxxV4qPBGgfzirInkWkmuv3X24Gmc4Zhdn
	 Bf41jf9cMZ2So9RoIYvr6lqUA5xPjoJMNx9c8E6ROa8EHpM7N/C2axxt7FlcOLX0IRTVB
	 KW2YEnDBolgpVUoeF1P2ejLafdyCHdzc1A9syF6lJoNakm46RzUC2xqOJUiz/fI6PwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6tfZ3GZ;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F48606A33C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F48606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6tfZ3GZ
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso1801034eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354734; x=1794959534; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9rj8EzBjlrHZ5xAlf0shYcxqn1sb5NbiDhyrmTtYevk=;
        b=F6tfZ3GZcndbrP3lQEGGVjId/xyZ9fHyzdAFR7MjnNcR+YLS6rmMlSKOvR7hICxc/h
         vKplz3pzZDEQ2Cb5IMOufB4Mfj7/QqLl5oTWW1/Gkgs6k5ksb+vRPmASdWSaEt3tFRAd
         J03GrlKVRUIVttm4Uv3b9pgD513Fqkq0Vk2pxqnQMc2nyEoz0+oJkK+MWHh4sFXuJM4M
         anpzZFRcCOL+w1IplL2L9VFP0n2srzF37IT4NPsouN3mKDiWukkZiJxCpiNGV6K65w2B
         7uuYihcagjJpW/96eJhFSw+nddMIsP2/yxEv3vPjYlqNjUT/9fXhotKbNPEdV6cOW0Rp
         00OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354734; x=1794959534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9rj8EzBjlrHZ5xAlf0shYcxqn1sb5NbiDhyrmTtYevk=;
        b=mYpKJsGXfRqUsuUCP0MedhpSC2vJxWkIlb2yDwJ3UOrGkyPZO1zTaxU4xGoCep79F+
         w5k6veSpTdqB7/STT0DJAoJFMsJguTfNgJ1JBgarjIw/94eV7c+ixL6JmIYhdt9fhNUa
         2mastFLU8gU+ZSWWjij/mqkgYnQtLyOtvCyJCkW3si6ttIbvmS9zTQEAydktTWTMVle3
         L0AXfO1SWq8xEbPOftxxoU5c9zP0HdDxrF521IRrOd7CjTgvsQB9cg+mFgj5s4butKYP
         MsmJQWpvKBYHHPdwibOt0E5saoggw9lSjfF0TPRpW0wR9RuYVqN/HQzk6zwGluCxGcNR
         pQzQ==
X-Forwarded-Encrypted: i=1; AL+hErH6o2v8420hlgK2SJUI0F+e28k0FjvvvKa8iGAadYxzekMaRPzXcwX0pQS0xmut/29SKMrflcM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zUu6wAI2ChG/Cd68XngQs0bOEx7FVy048GvBAAFujfg40HyMq
	Bcy73JcHi9MP5yRMo0t6SlS90utgsZnOfc7pAM/X55qzUB5bCoY/BHxP
X-Gm-Gg: AYBFou02OuUpSeR9Rgu1SS7VhmEDIpcz2I9QgHvOWG8SbmqRAahudG1VjzJimxPBs3Q
	OScjoOfvBTYzKcAkNzscJKCpuGxQVOXqLkAXU15R3KwI93E+PIzspVK4DgCtp75n+8iyp5SkoW6
	1W48I+oeft7/2PtEoQ1+BpONejizb8/nS9NkRgiHe3ryenqlBhBh5FB/+E7MntrdE3KfX17t7Sf
	RFEBrH0eEbFtSBY9ng+g/ovrRIdLzovzCf8zVIjA3PouMgDyjMTgGBETKZRnXwQYaMuOU4Zz4MX
	JB3K0fudl5SonSV1z+6XVPZw571QbO23+xHyzAW0aF9P2Hd2LB3TQeasPxZac208bJgOupwpuLm
	IkuMQ2riFX3eBAZ6GcUF9k47qwr4n069gMh4E1TbDNinJo4eOfIIj3vYMtbwKykdFZjqlFHRISV
	q7WguWPZzr2eTJdI3/V8OOhzpt9I4TyFRkNqDm3nYrZAHqW4hQ/alfF5mGa20FPtq44tTGdOsAK
	MyMDs7YLtgHOU1PsZti7U0EuWZLhJ2Rif2veBEdY3u1zgSzIZnaNq7c+S9m9YAHfc8iBdGjKEZP
	eTEUxLF7Di9xe9v85ker/Sk=
X-Received: by 2002:a05:7022:7e88:b0:1b3:c0cb:d231 with SMTP id a92af1059eb24-1b3c0cc5d12mr447595c88.45.1794354733614;
        Tue, 10 Nov 2026 15:52:13 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:42::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4ecccsm8750104c88.13.2026.11.10.15.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:52:13 -0800 (PST)
Date: Tue, 10 Nov 2026 15:51:21 -0800
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
	io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 06/11] page_pool: Coordinate refill with
 memory providers
Message-ID: <avOtxBw_grmuDJae@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-7-bjorn@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110102039.1002605-7-bjorn@kernel.org>

On 11/10, Björn Töpel wrote:
> A UMEM has a fixed number of chunks. When a refill finds none, and the
> chunks come back later, nothing schedules the queue again: RX stalls.
> Kicks after each queue operation are easy to miss.
> 
> Drivers report the end of each refill with page_pool_refill_done().
> The provider then asks for another poll, or wakes the queue later
> through the NAPI that the core publishes while the queue runs. Socket
> wakeups use that NAPI too, so such drivers need no ndo_xsk_wakeup.
> 
> With XDP_USE_NEED_WAKEUP, the FILL flag stays set: a flag set only
> when starved can miss an entry posted at the same time.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  Documentation/networking/netmem.rst     | 10 +++
>  include/net/netdev_rx_queue.h           |  6 ++
>  include/net/page_pool/helpers.h         | 24 ++++++
>  include/net/page_pool/memory_provider.h |  2 +
>  include/net/page_pool/types.h           |  6 ++
>  net/core/dev.c                          |  4 +
>  net/core/dev.h                          |  4 +
>  net/core/netdev_rx_queue.c              | 97 ++++++++++++++++++++++++-
>  net/xdp/xsk.c                           |  4 +
>  net/xdp/xsk.h                           |  1 +
>  net/xdp/xsk_pp.c                        | 73 ++++++++++++++++++-
>  11 files changed, 226 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> index 39cb75339704..74c73d7d126e 100644
> --- a/Documentation/networking/netmem.rst
> +++ b/Documentation/networking/netmem.rst
> @@ -136,6 +136,16 @@ Driver RX Requirements
>     circulation times, such as when userspace holds a reference in zerocopy
>     scenarios.
>  
> +8. After each RX ring refill, call page_pool_refill_done() once per page
> +   pool, with PP_REFILL_FULL only if all rings that use the pool are full.
> +   Rings of a queue that take buffers from one such provider share one
> +   page pool. Keep buffers in each of them, first in a ring that every
> +   packet needs, like a header ring, so that a provider with few buffers
> +   does not leave them all in one ring. If the call returns false, poll
> +   again soon, for example by returning the full NAPI budget. Register the
> +   NAPI of each RX queue with netif_queue_set_napi(); the core schedules
> +   it when provider buffers become available.
> +
>  Driver TX Requirements
>  ======================
>  
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index 989120cbf452..ca12cbf7b825 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -33,6 +33,12 @@ struct netdev_rx_queue {
>  	struct pp_memory_provider_params mp_params;
>  	/* stamps the page pools of each queue allocation */
>  	u32				mp_gen;
> +	/* NAPI of the running queue, for memory provider wakeups. Set while
> +	 * mp_armed, and if the provider has a refill_done op. Written under
> +	 * the ops lock, read under RCU, see netif_mp_wake().
> +	 */
> +	struct napi_struct __rcu	*mp_napi;
> +	bool				mp_armed;

The comment should explain why mp_napi != napi? (I do not understand why)
