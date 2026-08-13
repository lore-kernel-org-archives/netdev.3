Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE144C664
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786618804; cv=none; b=Th78NAnCg7lHZnfk3jEFpHHbx7gBXu5E0e0LXnUh1vvbYeJ/QF4HYzZhEoV8Ap+89+icziADJ61+t0ChAtfon5Dh689BYaKGCCPUs5EcWUxyBHYfG+/RfTTqnJc//41WLJ0Utz3yKE5Mbput13bpKWJI1WSqEJXveuVk+PAwiWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786618804; c=relaxed/simple;
	bh=9XJazPGW57FRRlIcZ+PDty0gQb2K86aLEuWT2m7Zwhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtF66MgucQfBooydgp2RDz/GOx50XOEmyn7V5r4EJYR98hOwn260MX6dZzPVn1Z8kujuR8ecrEnEyPsSOuuNCCQVqjVR+o9t8Va3jGKloGyjlwVS9jO/FgXca2XsxYnhDMCNGqhnSEkh+oMObTyl91YWMt1py7DjD5YJYp4N+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4BxWcIk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4BxWcIk"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47fde295992so607557f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786618798; x=1787223598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s+pxb2YLlm32O+smzeiqgo5X03klezdNOrEJBa+gI0Q=;
        b=D4BxWcIkw7voPUwZkYokuShXZI5UUUDXHqahb8FdbIqfw6CeRBL9+hABu6LIvgJ8la
         wgVIlmw5XDFOKumEDDIXRmeeSH6wITR9tRPMDsOgISJSIdYWBZEfHVOLDGV1p70jb+/u
         UPLR/fvj6N3ZmiaVDlwBkSapQUSuYbEn7fXOrBeJ2V+tij6IeUSGG5uqtPo+L6Cc7F09
         8nvoJLxpGamY9P6R8pMsQQD6KQJMXiLrP44aX9B12wYyXpA4B4pqYZAL/kfH5EgJVOZM
         Ajv8jtyheit0QRY3gI4zH4KHhZV2tSuFdFVO8T5twO0Gn2fj2nOhNMD/d6A88sMB7gEj
         vakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786618798; x=1787223598;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+pxb2YLlm32O+smzeiqgo5X03klezdNOrEJBa+gI0Q=;
        b=H0NYgkTOZHEiynaJORtEYxG8sjohqlPTTYOW0xuQuNmvZxf5JLRGlPQua90LcpjyAb
         u/Kj+ONpvIfsgDA5qXfKVW2LRUQy/ERNeN1DH7G87pqmKCej0FWdBqYhTSpnJv3NrWQA
         7gyUkH6kJzV94vLY+IDRXCxNJzHdTfPX/7/vDZ3Pz3awTkHu38DhpVsrNBahxOYevEey
         5y0eALVEqO0Oem5y9NbVDehvC7tEwc6tVHl2LT8koicWU3frZ1w3lHnfcN1VBPv3+6Fv
         LUUhWc5xoYDruD5O1FUvns/Q3Szbe0GB/qNFH4QwoymRMFVfsBdBnWvw94bceF/aD5kr
         m8dA==
X-Forwarded-Encrypted: i=1; AHgh+RpMBYLwZ/NieP03hjeQa05+kpupWrgINd6Dw/NjJDaAmbhIkxnNDwGsMu9bbbnVRlQH5sfPtTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTck/sXZc7eB8eRNIxS+FjCKWiOZ8FgMHVOF4mq6didTN2kMR
	Ylk1VSnoke1Toir8aCLC2i47/wzLVOrG36nIYmor05unb2ICyBA9A22b
X-Gm-Gg: AR+sD12MS4rOYOmvDDrmyMWZQKhwH1uQG0yQ4Ko0/eBxktEWIgrLE3/fXy94qrfV6WQ
	+aHVYU9Bs9k1Jmz2oW6aBIPUzxYysRkaV/5dHLJuctLNxEwp5GNc/0Gn2WgnqAhyR6M09ONGj4K
	9fmemUyspfzs5XmN3GHHPTpQp8Ky633fSHtOY/srMbWzdnII4hXDnAd4jY1FfiVKpHVuCopJq8M
	Jl+gKLvGSRAwUJocauPuxqKW6AV1YB16SJCyWIzRqfpqq6XLY9whkVjQqhc9/3wdTUntQ+p6s4F
	DEKpICU850RB+3Qft8MF2Y/EVLCdmOfrc40Qn22Kb6wP04Lg1K2NuRvbLUBnwQ7I5dbf2IML6dC
	vWCHihPnxmZAoz3rUApCQ2PBT8g+UcJKOY/oONq7LbF4djzfGKUK8ahReIymqEvWSrEw+lNHVoC
	HpmRyzcNut2iXtmNXP3xLE9WqK16Z073uH8WF1t5Vep4ZQ9zse4yEFC1eFCfjFoWvpJXQXht49s
	tcPpKtwXw7AXdDpe5tU
X-Received: by 2002:a05:6000:41e4:b0:47f:9158:5924 with SMTP id ffacd0b85a97d-4815a5c91e2mr6047841f8f.9.1786618797838;
        Thu, 13 Aug 2026 03:59:57 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a561296sm5821100f8f.4.2026.08.13.03.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:59:57 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:59:55 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com, jiayuan.chen@linux.dev, sdf@fomichev.me,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 2/5] bpf: Add ksock kfuncs
Message-ID: <an2jqx36_iYFbVqm@gmail.com>
References: <20260812154328.72834-3-mahe.tardy@gmail.com>
 <bfa71c9ba8543efcd226101c79e3de51aa6531f56ca0874c7239f1567e1f457b@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfa71c9ba8543efcd226101c79e3de51aa6531f56ca0874c7239f1567e1f457b@mail.kernel.org>

On Wed, Aug 12, 2026 at 05:39:05PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/net/core/Makefile b/net/core/Makefile
> > index b3fdcb4e355fa..a9295b7859010 100644
> > --- a/net/core/Makefile
> > +++ b/net/core/Makefile
> > @@ -44,6 +44,9 @@ obj-$(CONFIG_FAILOVER) += failover.o
> >  obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
> >  obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
> >  obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
> > +ifneq ($(CONFIG_INET),)
> > +obj-$(CONFIG_BPF_SYSCALL) += bpf_ksock.o
> > +endif
> >  obj-$(CONFIG_OF)	+= of_net.o
> >  obj-$(CONFIG_NET_TEST) += net_test.o
> >  obj-$(CONFIG_NET_DEVMEM) += devmem.o
> 
> This isn't a bug, but would 'ifdef CONFIG_INET' be preferable here to
> match the rest of net/? There are zero occurrences of 'ifneq
> ($(CONFIG_...),)' and fourteen occurrences of 'ifdef CONFIG_...' across
> net/**/Makefile, and this is the only conditional block in
> net/core/Makefile.

whatever is fine by me.

> 
> > diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> > new file mode 100644
> > index 0000000000000..d65200679b65d
> > --- /dev/null
> > +++ b/net/core/bpf_ksock.c
> 
> [ ... ]
> 
> > +/**
> > + * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
> > + * @ks:		The BPF kernel socket context.
> > + * @addr:	Pointer to an IPv4 or IPv6 socket address.
> > + * @addr__sz:	Size of the address union.
> > + *
> > + * Connects the socket to the specified remote address and port.
> > + *
> > + * This function may sleep while connecting the socket, so it can only be used
> > + * in sleepable BPF programs (SYSCALL).
> > + *
> > + * Return: 0 on success, negative errno on error.
> > + */
> > +__bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
> > +				  const union bpf_ksock_addr *addr,
> > +				  u32 addr__sz)
> > +{
> > +	struct sockaddr_storage sa;
> > +	int addrlen;
> > +
> > +	if (!bpf_ksock_has_user_task_context())
> > +		return -EOPNOTSUPP;
> > +
> > +	if (!addr || addr__sz != sizeof(*addr))
> > +		return -EINVAL;
> > +
> > +	/* Kfunc memory arguments may be unaligned. */
> > +	memcpy(&sa, addr, sizeof(*addr));
> > +
> > +	switch (sa.ss_family) {
> > +	case AF_INET:
> > +		addrlen = sizeof(struct sockaddr_in);
> > +		break;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	case AF_INET6:
> > +		addrlen = sizeof(struct sockaddr_in6);
> > +		break;
> > +#endif
> > +	default:
> > +		return -EAFNOSUPPORT;
> > +	}
> > +
> > +	return connect_socket(ks->sock, &sa, addrlen, 0);
> > +}
> 
> This isn't a bug, but could the #if IS_ENABLED(CONFIG_IPV6) guard be
> dropped? struct sockaddr_in6 is defined unconditionally in
> include/uapi/linux/in6.h, and union bpf_ksock_addr in the new header
> already references it without a guard. bpf_ksock_create() accepts
> opts_copy.family == AF_INET6 unconditionally and relies on sock_create()
> to return -EAFNOSUPPORT when IPv6 is not built. With CONFIG_IPV6=n, the
> net effect is identical (-EAFNOSUPPORT either way), so dropping the guard
> would make bpf_ksock_connect() and bpf_ksock_create() validate families
> the same way.

Yep let's drop this if unecessary.

> 
> [ ... ]
> 
> > +/**
> > + * bpf_ksock_send() - Send data through a BPF kernel socket.
> > + * @ks:		The BPF kernel socket context. Must be an acquired reference.
> > + * @data:	Pointer to the data to send.
> > + * @data__sz:	Size of the data to send (max 65535 bytes).
> > + *
> > + * Sends data on a connected socket, best-effort and nonblocking. This may sleep
> > + * (kernel_sendmsg), so it can only be called from sleepable BPF programs.
> > + *
> > + * Return: Number of bytes sent on success, negative errno on error.
> > + */
> > +__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
> > +			       u32 data__sz)
> > +{
> > +	struct msghdr msg = {
> > +		.msg_flags = MSG_DONTWAIT,
> > +	};
> > +	struct kvec iov = {
> > +		.iov_base = (void *)data,
> > +		.iov_len = data__sz,
> > +	};
> > +	int ret;
> > +
> > +	if (!bpf_ksock_has_user_task_context())
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Early check for UDP. Exact limits enforced by kernel_sendmsg(). */
> > +	if (data__sz > IP_MAX_MTU)
> > +		return -EMSGSIZE;
> > +
> > +	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
> > +
> > +	return ret;
> > +}
> 
> This isn't a bug, but is the 64K cap intentional for AF_INET6 sockets?
> The early size check uses IP_MAX_MTU, an IPv4-specific constant (0xFFFF),
> even though bpf_ksock_create() also accepts AF_INET6. udp_sendmsg()
> rejects len > 0xFFFF so the bound matches exactly for IPv4, but
> udpv6_sendmsg() allows up to INT_MAX - sizeof(struct udphdr), so AF_INET6
> sockets are silently capped at 64K by this kfunc rather than by the
> protocol. Also, should the comment say udp_sendmsg()/udpv6_sendmsg()
> instead of kernel_sendmsg()? kernel_sendmsg() performs no length
> validation - the limits come from udp_sendmsg()/udpv6_sendmsg() and
> ip_append_data().

I think we can just remove this check for now.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31618864886

