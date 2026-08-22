Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F031DD97
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435175; cv=none; b=uJHafpOP3ZcVVH/z4ZDdMNnMqj42XzjUJtglgTiATrGkUVPvc4OAVZKWGk5LS5xvOjJ2sB4k76GR/1j4qReKe6L21tRvuBuZ8MoJs95izaV1c71mnnJneBHoZ2mAf6zy9kOEt1ABHuz8At4n8/iP1MLT9JvgA4tQjCYwl5EASE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435175; c=relaxed/simple;
	bh=UmgvCKUP0H8uODNulO701AA2T0o+efkbq8XvmXjShdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQgrMZimVRVJVNl5emTV1sbNI81BGt7x2UbqsvzuxwxIGaACMgOiAu6/Hn0Av1R8FgVbdBv8grLM3UqZXfdQyHAl1dwJAiiaXUVqNuEG50gp1nY+cG8zT/tfh5JPkH5pJ6cW2p8aCNWKfONOI1tSyIMII3Msbugq3HYkFjPyTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcBnJ1LX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcBnJ1LX"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49800c6a846so19307935e9.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787435172; x=1788039972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FrBapT21Y1aERBdCT2Syr4G7i9enRjq/X+87/IKMeRY=;
        b=XcBnJ1LXjJ/1Hb0F0dJM0irUZkrFiTrUtCy5SEcmg4pCRI/4ipF3niWUyzLIvwel5t
         uQU1IfuLrWDeC/Bc55pDAuihL0RJdPYL8SDeNurCWFqTtkfbDQmxyxuW7nY/siwC0sa5
         UFlFX2WP9aanUte4rr3tAB4mttuvtswHsg7LbUH6XXGrcHRDZpLmmsZqf6y87PgHanx6
         BnqhaQmXEW7qovFkC+kzXqiZICoV8o8otSKhH3beanrV7LEMv6gLSRux4kxO7HJ5kGn6
         WTSNTodQmPAFxRcFQ0eCZ+CdSjR87IHEQymLG6lIiyEdI/+M0+ZxbowJ0+ylibvALg4r
         UZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787435172; x=1788039972;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrBapT21Y1aERBdCT2Syr4G7i9enRjq/X+87/IKMeRY=;
        b=rg7QQPkbT0pYPcTtJeH+Lg1ehDtmUA1dhxr+Z4x8bvaogqpzXcEtdtIc8Y7kpzoeST
         WpqBTgYx0dW+HA89p1UJXomrt/qs6R+W3p7lD4nHtTzKeYz8rk8r0/iFAQMaQnmiGul+
         zoqxmXKdgbQzQQzpzyobu9zRDIAFuodsro1xsuOBQWT86caI/uwdQE/qbrKh5AFCooXG
         RPEtxQFl14QBByEvE0A0fUqcc+QXxg4hTcaxCjlKVyWfRPd0y9l94pdJEveg2bfbqKar
         Mb8upCrBq7W8dwE2Vw2BSKuzEfLOE/YEP711BdnN+5gFH5XJRuGrrVmDv4Q1+EYYgA+P
         8yeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6Vk8SGcTqaF7BBGBM5Hn/AlrAxlgz9xoEWh5Pslhy75JY4srCXxY3WHpDwJedpmiRYx7i9xo=@vger.kernel.org
X-Gm-Message-State: AFuF++lDCaDyTBuSPEN5vxCT5PpUj7kipVPg5ChMxxvlHMpYZ14Bzctv
	83w+uTZLKtPjd6kBy0HffYoz2LAz3AUtkgZuXPScz26hLRzWxA7U0xXz
X-Gm-Gg: AR+sD13MIrlLF74LI9KvrX1KRNQxG+R9eCO6qr7iz4wRiVK3fgnfUW68NViEalR73YQ
	olo+sOFwclY1Kh0WJlKgT7eXvc2yLE/VAzZ27WmOo/IoiUT4YQFpYx6+KCk6BJcOiINNrSF9ce+
	YyLo7g9ppVMMf9UB0vA3Np8f9HC8t8ofpQw9HENh3dQ0iaciDg54E1e9UE27pDB8NG9APTRSlZm
	O2KEex7j5p5h9KU9qXMtxlKHNrww6YedlnQCLjl+uogzxKtspzRKkP9Vhc/Gxud6PhiWHFVQ/QG
	RyyIjpLdPZFyz7n8ZX/i79ua8tUDjgJMTWf9k2OuItm/Stya4/FSA4MWKfwfHlwHsCxKVknxpvR
	42Y0hbFQcM65UNm3jDwFHfNDjAlrJsQYk+ijtZZywFHsj7pBgsahqYKY53yTeRW1i6L/Pmcen3e
	mshmXlQ46Jf0kPjBsKUlMgialXdVKQNoRLeuXAysEVkr6aQRdiqFtvFcTenx3lXkRIOeAkPtzqv
	v+heG30SKdZuwOE1GzUOSrcjQ==
X-Received: by 2002:a05:600c:8b77:b0:499:48bb:417e with SMTP id 5b1f17b1804b1-499b82f4163mr208115045e9.2.1787435172108;
        Sat, 22 Aug 2026 14:46:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b915c6ccsm71423695e9.13.2026.08.22.14.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:46:11 -0700 (PDT)
Date: Sat, 22 Aug 2026 22:46:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Martin KaFai Lau <martin.lau@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH net v2] net/socket: remove unused
 do_sock_{set,get}sockopt() exports
Message-ID: <20260822224607.3777abf2@pumpkin>
In-Reply-To: <20260822123957.694f2812@kernel.org>
References: <20260821-hch_not_export-v2-1-c62b62ec459f@debian.org>
	<20260822123957.694f2812@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 12:39:57 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 21 Aug 2026 01:28:32 -0700 Breno Leitao wrote:
> > do_sock_setsockopt() and do_sock_getsockopt() have been exported since
> > they were split out of the syscall handlers for io_uring to reuse.
> > 
> > io_uring is the only caller outside net/socket.c, and it is never
> > modular: cmd_net.o is built under obj-$(CONFIG_NET), and both CONFIG_NET
> > and CONFIG_IO_URING are bool. The declarations in <net/sock.h> are all
> > it needs, so no module has ever been able to use these exports.  
> 
> FTR I'd prefer this export (or something along these lines) to having 
> to add individual helpers for every sockopt for in-kernel networking
> socket users. Maybe other maintainers disagree.
> 

As a 'user' I'd re-instate the kernel_setsockopt() that was removed in 5.7
before sockptr_t was added in 5.8.
Before I retired I supported some code that contains:

int xxx_setsockopt(struct socket *sock, int level, int optname,
	void *optval, unsigned int optlen)
{
	sockptr_t koptval = KERNEL_SOCKPTR(optval);

	if (level == SOL_SOCKET)
		return sock_setsockopt(sock, level, optname, koptval, optlen);
	else
		return sock->ops->setsockopt(sock, level, optname, koptval, optlen);
}

I suspect both bpf and io_uring have to do the same.

The code does need one getsockopt() - SCTP_STATUS to get the negotiated
number of output streams, any code using SCTP needs to do that.
However that returns the wrong value for kernels 5.1 to 5.8 so the driver
digs the value out of the sctp internal data structures.
(Not exporting functions doesn't make much difference!)

David
