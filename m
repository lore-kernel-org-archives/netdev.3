Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C463F4835
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744860; cv=none; b=d203K3ZCDK36YYh7n+cenUAbTLOEEQCsEQNC6ehSYHoCT32O0+m45B8Qm/NGpUB5CPnGcXNQcNKvZOFwzTyJUPZRvJYaDYs1zC+Dh+9XGMCmfx/MdJE7oRPGG/Gje/EgXSfp5MA+EWB511Z6pr5Bpn855nWyWHayGsUDHaSUyNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744860; c=relaxed/simple;
	bh=qu8L4Z0Qjy010uI9XNszwHCG69kbR0jceUP/NQxbomk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNytYRRzU6SVazXLepK8s/caRgf1egP+CkmzSvzMdymEu4PQrWpe60tMxpEoeS48w5fvGZdQtA942GYrVDFoIbY/oINcVw44tCWwgGbBHEwnMjdEgYLkMHc5dch07taUV3VS7E+rIsGJE1+PsMn0QoFpjsSX66zWNsn297E04v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/q+Ht0L; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/q+Ht0L"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fcd903839so6178926a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784744858; x=1785349658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CbBKwHfKRVYGj68CsQiUTwpd2GkW2R3DspriFVDsZpw=;
        b=k/q+Ht0LGaViH9T632hTCFfGav8kn/Y48n8Pv5hcepYTsi/4RiC3atrlQFqr7SC9i7
         ZlgbhQfr1JSMKp7fRNcBSdAyNjaSKaOlhrkC8c3SIgKYlSOmfOaA+9ekv/JYiPMZAmzy
         sT0a7CIv/S2LLyP0TUdnlmooeVR6uhwjU/246TgNyMr+8f49DXK/PX2LO92YKfx6iF9O
         VwduyT+vYX8IOI7ZEhnDtLogHF6yIeVEGjypM7v3a8i/vZqz7CwUBycb3uUU9Ho9inUT
         Ly/ZnoL1Ym6R4ErEdJNbbKb9iVSljaTUEqJ+6nIwxCautnU7J9lvo44TcyMJA28EwpT0
         IJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784744858; x=1785349658;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CbBKwHfKRVYGj68CsQiUTwpd2GkW2R3DspriFVDsZpw=;
        b=HlIN1zPvw9YwC+7z9+3tdqr6Km92OtdFcoxN7PYoSM1IDGODfs6UrdV7XJGo0y5kBD
         CWh81Vrm96fH2nTvRtTZzHarArqpe57OQ/ovSftS47a/ENxB/HmRz4HIkRpnJtWX3MNq
         315UvypaxAcmDNPtPEAt8lxNRZ+OcLTGwvAlRMoM6Dnt5LVkT3agrUhmXUU0a5TKfzYM
         fPiQEmhd9orb5BYF9LsuTs37BTxA480mLzV31N6T3/4j7MQERUkKhHmiBplZ1WHS2EkU
         ShDCl0rwtuBK6Ugr0yD5idNHUQjqS58vTYIGTw2yCvCxrlpsbL/oBzrskN2cEIdpvYPd
         MoUg==
X-Forwarded-Encrypted: i=1; AHgh+RpwraydKqdX4L8Ro/KQ8jvtArwC42JnZ5YJNgZV5JdTk+txwrA5Or/CMMFe19Rz1ODZ4SdTDYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPiWZMMCJ5dSKwgjmdoZuOhvtusYzNqYTItuHLPj0UZVuwD0S
	56DmnkxstPptOOS0puxikSpxF7TyrugS1UmLjVUHp4Kv06BAXBXaGMPj
X-Gm-Gg: AR+sD10k+CuIA8AMYRhAt7TPSiNWQoP7y6nLI5jwb3haungLFLbKFhSCvYEfe7mTyb8
	TmU4wHY+wpEJNk3tDB6xEYzJ1FDyGx0dKMYpi1WlAl1buGjjuzWaOTFkw5HQjkbipyaRMEvPW6h
	+QvfCvhC49IO37MTR2s4ZUb9TLDhEeLRPfZMZO+DcJb6aNaNTGE0ll8a0EntuRnTwFO4RSDOazU
	3R6ugXB66ojMAvMOLRfUdm1rc/wNVVGjzt/bf8ejbTgtDuKvOKQh/1rwEsuLKsO68tC3asPjWea
	Je6eb+0Am8VRyAiDNxE749t2gtx4yDSkpKGjHZ2bjx7kWeLauvPupMMpKd5HfYCgr8+T3x9TwgK
	82+zJKXriU0Igx8P4XIPwJMOHo76+1jXOY5XxkGJOJmzrRGCKU/aCur4QbC0yhUD79TZVsr4=
X-Received: by 2002:a05:6a00:80b:b0:847:8504:9946 with SMTP id d2e1a72fcca58-84e2b8aa7femr41883b3a.25.1784744858012;
        Wed, 22 Jul 2026 11:27:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17604d76sm1678369b3a.61.2026.07.22.11.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:27:36 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:27:32 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org, 
	ameryhung@gmail.com, kuniyu@google.com
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Add ksock kfuncs
Message-ID: <amELAv1bgc9DP6WT@devvm7509.cco0.facebook.com>
References: <20260722104454.165911-1-mahe.tardy@gmail.com>
 <20260722104454.165911-3-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722104454.165911-3-mahe.tardy@gmail.com>

On 07/22, Mahe Tardy wrote:
> Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> sending data. This provides a mechanism for BPF programs to emit
> telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> socket types with IPPROTO_UDP protocol but could be easily extended to
> SOCK_STREAM and IPPROTO_TCP in the future.
> 
> The API consists of five kfuncs:
> 
>   bpf_ksock_create()   - Create a socket (sleepable)
>   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
>   bpf_ksock_send()     - Send data through the socket (sleepable)
>   bpf_ksock_acquire()  - Acquire a reference to a socket context
>   bpf_ksock_release()  - Release a reference (cleanup via
>                          queue_rcu_work since sock_release sleeps)
> 
> The setup kfuncs bpf_ksock_create, bpf_ksock_connect, can be called from
> SYSCALL programs only. While bpf_ksock_acquire, bpf_ksock_release and
> bpf_ksock_send can be called from SYSCALL and LSM programs.
> 
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration). The kernel socket is wrapped in a refcounted bpf_ksock
> struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> may sleep.
> 
> The kfuncs are only compiled when CONFIG_INET is enabled, as they
> specifically support AF_INET and AF_INET6 sockets.
> 
> The socket operations go through the expected LSM hooks instead of
> by-passing them like many kernel sockets since those are created by BPF
> programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> exposed to LSM progs, has a re-entering protection to avoid recursion.
> Also, because of the LSM checks, we prevent the use of the kfuncs from
> asynchronous workqueue as the current value would then be invalid.
> 
> In bpf_ksock_create(), we copy the arg values to avoid TOCTOU races
> since the kfunc can sleep and the arg values could be stored in a map
> that could be re-written by BPF progs or even userspace programs if the
> map is mmaped.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  include/linux/bpf_ksock.h |  46 +++++
>  include/linux/sched.h     |   4 +
>  kernel/bpf/verifier.c     |   3 +
>  net/core/Makefile         |   3 +
>  net/core/bpf_ksock.c      | 361 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 417 insertions(+)
>  create mode 100644 include/linux/bpf_ksock.h
>  create mode 100644 net/core/bpf_ksock.c
> 
> diff --git a/include/linux/bpf_ksock.h b/include/linux/bpf_ksock.h
> new file mode 100644
> index 000000000000..a2e06e3d604d
> --- /dev/null
> +++ b/include/linux/bpf_ksock.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2026 Isovalent */
> +
> +#ifndef _BPF_KSOCK_H
> +#define _BPF_KSOCK_H
> +
> +#include <linux/types.h>
> +

[..]

> +/**
> + * struct bpf_ksock_create_opts - BPF kernel socket creation parameters
> + * @family:	Address family: AF_INET or AF_INET6.
> + * @type:	Socket type: only SOCK_DGRAM supported for now.
> + * @protocol:	Protocol number (e.g. IPPROTO_UDP), or 0 for the default protocol
> + *		of the given type.
> + * @reserved:	Must be zero. Reserved for future use.
> + */
> +struct bpf_ksock_create_opts {
> +	__u8 family;
> +	__u8 type;
> +	__u8 protocol;
> +	__u8 reserved;
> +};
> +
> +/**
> + * struct bpf_ksock_addr_opts - BPF kernel socket address parameters
> + * @family:	Address family: AF_INET or AF_INET6.
> + * @reserved:	Must be zero. Reserved for future use.
> + * @port:	Port in host byte order.
> + * @scope_id:	IPv6 scope ID for scoped AF_INET6 addresses, or zero.
> + *		Must be zero when family=AF_INET.
> + * @ipv4_addr:	IPv4 address in network byte order. Used when family=AF_INET.
> + * @ipv6_addr:	IPv6 address (16 bytes, network byte order). Used when family=AF_INET6.
> + */
> +struct bpf_ksock_addr_opts {
> +	__u8 family;
> +	__u8 reserved;
> +	__u16 port;
> +	__u32 scope_id;
> +
> +	union {
> +		__be32 ipv4_addr;
> +		__u32 ipv6_addr[4]; /* in6_addr; network order */
> +	};
> +};

Do you add these because of BTF type checking? Can we have something a bit
more orthodox like:

union bpf_sockaddr {
	struct sockaddr_in sin;
	struct sockaddr_in6 sin6;
};

?

I hope we can just pass these to sock_create and make it do all the input
checking..
