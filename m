Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744972;
	b=bMdCL8wiPg0AfWWFWYak+efkE0UT7q+mWRS8Gwq5n57QbXtoVqQnAJevpxkep2jVpQSX
	 ZDPsIecp6Duz2lI77242PmcAm/dHqH8rYVhjMSYDVwU7ppPpAIvw7IL2mEsCun2S2jTFl
	 Zn4hR7zyzO84al58iG1KJKFcZf4rCEaE+nXHrElqBpsCFeV3YWH/ShMQIXJnB3h/FSeEv
	 zdYXRPe97vbujYWowTTwZPDj5veGyPUWXkna/+feRiyo0b8wrDptSFp774bhPnpJ2m4IN
	 /8kEadbh18s2disvwac9P5G79tr/mvMCtFuKZ416ULsBZtvC4IT6SrOem94PIx5EaHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DOXFLcMdzp97ScI6g7OdqTG+VcIwt6mpvGRghEu/arU=;
	b=D+TPhktCIA3K8LCI5BDOU7nzIJ7UqyEZ+F6JA04bx7I8AIzyWp7vZN4RofP5YgBG4QSz
	 NyH52ohwD+7Jad0tdyhqDeXhH0SI7XKJCC9coXTl0DSLhmjsIrwocrCaXbpw/Yhka45tZ
	 1W5XdltVTQwT3oW6PiE1j+pnx/q8hI29rhzg+K/uW37I3NECY3SeysxlJESI8aF8RRHQq
	 svWu2V186yCf1E+qgAHT8BXiTiA++U/q6DhtSsROmOrU5QwYBMTXVLObjIekT5Q5DbuUq
	 rVliGeDNzex+z4gHHY/8xbEW4A5ntdTC60jCkziHtTENwcB5WNyuaNC2iJUIeaJDcdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VJqLCa3f;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CA606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 603CA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VJqLCa3f
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48df54150dfso301897f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792744971; x=1793349771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DOXFLcMdzp97ScI6g7OdqTG+VcIwt6mpvGRghEu/arU=;
        b=VJqLCa3f1s7x1UWu6dzQX+eVQtVRBs3tDsT2/kibrG0GQ3VJRSsXqoKuikw2Zt7zj2
         Ewrd/aZtxuLupdenCUYqfraGlr4mwE2NPwRE84wx9Qr8cmhaHtcsKECWrgdg/rq04t9Y
         193tYNi+GbAx7RmTDJlsKD2JuzIbYai+quvBKg1H0g51ALGejWRKNHXptihpJgr/6ZJ1
         o9tQDsMpIwsRDstE4pyccL/bm4Dqqcs3/B9DLrLBX/r4TAuJ5g3tpv7XZe5pVfIWxBjV
         7Zg8j8mFX2Zs+TzJt3EZWwXdiIgRk5S+cy3NWm2SiTdgJLXF5qh2tN0KwWvXaIzng6ei
         hU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792744971; x=1793349771;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DOXFLcMdzp97ScI6g7OdqTG+VcIwt6mpvGRghEu/arU=;
        b=dKVfIcuyIjA+yjOxA+cB3Od5HVw0Hj2iIRXwq63QBRTHKpOVhB3noGIBOVJ+qh4W05
         nQpJeKDPTV1JlHvnQy0e9kcLeklylnnqXo6N3UwPd07Cy968Uh7I+CCsjEgROXjLHmtJ
         x44O2nwrgOirL5Z/WEo2Mj2pBSOiKidDGpLMw6bV0iKRvvhs9Rl1TnY3hmESYs3r06kf
         JwcKKPtYYicGtzUUWh6FTrj3//3QwRRYauIoLqyUpvJz+E4DvRWBu/vfIjnN8t7yW5E6
         wX6KNoQ7YK84Nt5KkfPuyKG4ggywP0GOwuepUdYLSJLLnrVdzjJxCywDofYdEoCYQI4I
         wZ0A==
X-Forwarded-Encrypted: i=1; AKwUvByjn+qDJH3fj9/G7gaZfwtp4yOozaPs2PlyfgAGk4VDX/dzARA/z4HhH0f0ZeG5xMl9u1MngfE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpFuhDQgTLd6yoyVYlisrQYHC5MwT2AFuo2GURenyok9kt1SvT
	adRt6aX5cmkFqF1vaFwuJvKsR3Db8FU1lq2fzKvgl6CHBKmlN7m1948x
X-Gm-Gg: AYBFou1GQURoKBXrJu8w3aDTq32Hqh7mkB4DZSDDD41fIgwNGA/A3E1sJlW8VkrebB7
	XcNah5pIYzR4sryYpapwSvpJHz1D92lJRhSDi5nY10hPd8blFfLTu1PlYapQ/AJ+EOcl2FV1AiW
	ZPMwmN3AVqcTTanoFnnclGzHztg1kESoze7GeqUCMdiTV15qKhbJ1HycoQf/Si//LPneTKdho/p
	TQKBR3cCNlnyte6RRug4ENoFMdyJnxu/g9cx32289kMDzTLTteG46jUPMY3pk+2FTE4KwAlaBip
	S1CIr1oYt+Cb8fvxiF5l9keCNcU2r1BDTerItU+X4B6b7Z/YwgK2k8mvosx4wcl3k2VsxUADxto
	TMwhf0FN0vIB/ekZLUVz4x/GR8LAtFyKOZM7tFrswSAENSLO/rGEwlBijeFXxbGNw80FG4zR4oe
	kCbX7tzuKdQA6EoS5NWQy8Kk/T5MogaV75gpAkIUxc81h90gzVucxg+dylcWMjYnZPurY+krds2
	tzyrRIvN9rZLRSpocNtlvZeC+whO7dCWZwGNdtGdudToq5YqouumMNkV7IOJtuS9sSj5MjM7gMl
	nxQBRrXX1ZyMsAxLQYQ=
X-Received: by 2002:adf:f6c1:0:b0:48e:f07:160e with SMTP id ffacd0b85a97d-48e385b1528mr1642537f8f.38.1792744970559;
        Fri, 23 Oct 2026 01:42:50 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edef81sm4070033f8f.5.2026.10.23.01.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:42:50 -0700 (PDT)
Date: Fri, 23 Oct 2026 10:42:48 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, willemb@google.com,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	netdev@vger.kernel.org, sdf.kernel@gmail.com,
	yonghong.song@linux.dev, jolsa@kernel.org, kuniyu@google.com,
	memxor@gmail.com, emil@etsalapatis.com, almagui@kernel.org,
	martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_ksock_bind() kfunc
Message-ID: <atseCFvfx9FbTXP3@gmail.com>
References: <20261022181620.247201-1-mahe.tardy@gmail.com>
 <e31194dd72efd3c182707e870b7e7a6d67b78be23cea06aded0275678373c64c@mail.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31194dd72efd3c182707e870b7e7a6d67b78be23cea06aded0275678373c64c@mail.kernel.org>

On Thu, Oct 22, 2026 at 06:45:34PM +0000, bot+bpf-ci@kernel.org wrote:
> > bpf: Add bpf_ksock_bind() kfunc
> 
> TL;DR: bpf_ksock_bind() called from a bpf_wq callback runs with kworker's full
> capabilities, so a CAP_BPF-only SYSCALL program may bypass the privileged-port
> (CAP_NET_BIND_SERVICE) check; the review asks whether to block it.

Honestly don't know if it makes sense to prevent it given you are
creating this kernel socket from a BPF context, if anyone with more
experience on this can help?

If the answer is yes, I imagine preventing bind() to run from a
workqueue is the easy answer so that all creds are respected as usual
and it's not a huge limitation (we mostly care about being able to
send()/sendto() from a wq).

> 
> > diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> > index 37168f43c16c..c7b487d90cd0 100644
> > --- a/net/core/bpf_ksock.c
> > +++ b/net/core/bpf_ksock.c
> 
> [ ... ]
> 
> > @@ -178,6 +178,33 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
> >  	return NULL;
> >  }
> >
> > +/**
> > + * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.
> 
> [ ... ]
> 
> > +__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
> > +			       const union bpf_ksock_addr *addr, u32 addr__sz)
> > +{
> > +	struct sockaddr_storage sa;
> > +	int addrlen;
> > +
> > +	addrlen = bpf_ksock_addr_to_sockaddr(addr, addr__sz, &sa);
> > +	if (addrlen < 0)
> > +		return addrlen;
> > +
> > +	return __sys_bind_socket(ks->sock, &sa, addrlen);
> > +}
> > +
> 
> Can the CAP_NET_BIND_SERVICE check for privileged ports be bypassed when
> this runs from a bpf_wq callback?
> 
> bpf_ksock_bind() is added to ksock_init_kfunc_btf_ids, the same set as
> bpf_ksock_connect().  Commit 60bbe76a3f9e ("bpf: Allow ksock connect/send
> calls from wq") made the kfuncs in this set callable from bpf_wq callbacks
> of SYSCALL programs, and tools/testing/selftests/bpf/progs/ksock_wq.c
> already calls bpf_ksock_connect() from such a callback.
> 
> bpf_wq_work() runs that callback in a kworker, where current->cred is
> init_cred with cap_effective set to CAP_FULL_SET (see init/init_task.c).
> 
> The bind path is:
> 
>   bpf_ksock_bind()
>     __sys_bind_socket()
>       security_socket_bind()
>       inet_bind() -> inet_bind_sk() -> __inet_bind()
> 
> and __inet_bind() then does:
> 
>     snum = ntohs(addr->sin_port);
>     err = -EACCES;
>     if (!(flags & BIND_NO_CAP_NET_BIND_SERVICE) &&
>         snum && inet_port_requires_bind_service(net, snum) &&
>         !ns_capable(net->user_ns, CAP_NET_BIND_SERVICE))
>             goto out;
> 
> __inet6_bind() has the same check.  With init_cred, cap_capable_helper()
> walks up to init_user_ns and finds the capability raised, so the check
> passes for any netns.
> 
> For example, a task holding only CAP_BPF can load a SYSCALL program, since
> is_net_admin_prog_type() does not ask for CAP_NET_ADMIN for that type.
> Such a program could bind its ksock to UDP port 53, 123 or 514 from a wq
> callback, while the same call made synchronously from the SYSCALL program
> returns -EACCES.  A bpf_task_work callback looks like it has the same
> problem in a different form, since the check would be evaluated against
> whichever task the work was scheduled on.
> 
> Commit 60bbe76a3f9e only argued about LSM checks ("bypassing LSM checks for
> BPF-created sockets could be acceptable"), and connect and send on a UDP
> ksock have no capability gate.  bind appears to be the first ksock
> operation that does, and the commit message does not address the wq
> context.
> 
> Should bpf_ksock_bind() refuse to run from kthread context, the way
> bpf_ksock_create() does with its PF_KTHREAD check?  Alternatively, should
> it be kept out of the set that is reachable from wq callbacks, or should
> the commit message state that bypassing the privileged-port check is
> intended?
> 
> No fix for this was found in the provided range; 76406b1f799f
> ("selftests/bpf: Test bpf_ksock_bind() kfunc") only adds tests.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39831790314

