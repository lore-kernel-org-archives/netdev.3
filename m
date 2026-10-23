Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775435;
	b=aU0qqxfneWXxusQTm08RC+f4OgVOg+nN8uq3my/V8SEhhRaJbsuiJ7EfupDkcnp+Fno4
	 DhwbHsKcJnD1oDHjv3GXp98Jat7xf8xzfvQlDllVQmzXtQbLCPtsUI4tLdrMwP5Ayn0O6
	 98feav3sk0vU6cviFHssVue8OEwuau51hIZ6ixqpwGCplMImK44+QeL2/U5/7PK+B+5xw
	 O3lpOjXoXy83jnw+p9NfIci8xOzooiDVi/WFYQrYoovsk0MKw3x/VVNcVfMgVDTOjM7gb
	 dZ+UPf4j6Y4mJYzWGvoJMQJcCCgUt/9SiFTSQRIiSOSljoCu7eVT+5QWFiWri+14Z5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Btr7hr0LuMAaYdMP/tMMJLFSICUnfP+fAjhqSakVwX4=;
	b=eIoGvAhhAtzRF1c0NC5+BmuKO7FqG94mVh6m6VJrEAweIfRf10jTbvQZWjR6lnC34etN
	 oxjvjE28XwWtkD/uSh647t+3Fz490T571Lpmmf+1NA2/eNW+ZBRXmt7PBgF90lKeqISUY
	 kbxRyTkk9v+tJP/p7dx+ORI4+q3aoNIlM8WtS11dou9gB+pSZeiCZUiNW52SW1qGLSiJV
	 4INi/shtuzexnidoK2c+5yL/Ty5YPi+BElSKxKmUV9ctX5NMEc+UWbwovRQWNSfYf6t0p
	 WIN0yoQN1Qycz7DeUzGBVD816aXeWOuE8lKLoht2vVTQSkOl0nqL3m3xEqhdYjv3+0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AgxEKTUH;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DD8606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 17:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07DD8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AgxEKTUH
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e60f9af6e6so8810345ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792775434; x=1793380234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Btr7hr0LuMAaYdMP/tMMJLFSICUnfP+fAjhqSakVwX4=;
        b=AgxEKTUHy8ctoDubMdjyFor88pmJ1RUyuatzX0e1CxVswHag9pSZt/fX79EjQFEGNU
         UeU4P9O/uPbnk7q2aER+bvaCtX2F4ZXJ2BoPAL8LIUZmukK6ssFsHs8iApGCIRb9OBix
         RcZn56fnq9qRI1pqtDeAf+LiZrK5ClPHVu8o7KvZXU4GVrxpMYMjq4u+UQszTMoXvlaN
         7NaDsCWT7jwkU0bVC5uBrYfFAvM9qoBViOgJ510w99hI+Y6HDdNk2eO4KGKlPhDmvB9C
         C41eXmKdNvYwOPy3XERwh+Ns+0VoJU7ggY2oHXg2tWndpPaAyd8pbgSr0iP0O2nquuQ3
         GbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792775434; x=1793380234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Btr7hr0LuMAaYdMP/tMMJLFSICUnfP+fAjhqSakVwX4=;
        b=vOhWhCb1jGAGmL5ddMhI2njVyuNIndhDq+6jMwdv1sg74E9unMjBOY54kyS++L6Zfq
         EBjFrVZnGGCKq/g2kkBLn8ds8nTzQz2KP7778cqMz1xVZvKChNkZ+wBgxqc76uwwqw4z
         YqPyilV9nimWmS6p15bGnlsNiYnUvIuPoGQT+ZOVF3MnMJouKS8jh9Y/ElygKY4KB6bN
         2x685iEfwdVOusBya6LNh32J/Y2KhVqDbVHTaI80qLRhgGwEvaXxCbSKUPSEoqIbW/bK
         ZaEv5s9e9zc741AJ603YwabVJHSft2gaJt5LZsNVnibCqqsgBzZVmWVRPiprtqr4vO22
         GUxw==
X-Forwarded-Encrypted: i=1; AKwUvByIrT0LUH2boWHqCJz2UOxWFgrx5uLkGxmnbuaYHjgAne0CSxvgqh7ufjN4tvkeUdKBFJFgMrY=@vger.kernel.org
X-Gm-Message-State: AFq9FYItEEdZy9xg9LaKyfxqGm3M+4GvYWUTKgcl6N9z640pUyZ+ATVO
	5GL8Z8RY7K3FryafWLth6TsofH9xy90rqLWk8M9V6SjznxKmVBpwdYCU
X-Gm-Gg: AYBFou0zv8Xl3tq5t83PbWCqXu6U5fTwSkLNG8p13lgPp8/lOTRdrvQDVtrPfcpGZfp
	/K4LzSrZ5Jnrf+THVvcdhGQl4lvcOgXIbWC7J0wYYQ/X/O/xDcNmhNW2HguhZtHIHCRJ+qgeyTF
	DhXIDZ2Xx3awGUPu+BTpLBKv+H5IJevPRbc+pjX7AKPhIx9G1lRkYIDV4yVShslJG6VTVyQXHJA
	XvxY+BI/Llc1JRMB5t7lKyoETQrtEcoNqAGNKmUc1CHSzb3PjAY312cR/mefbKZSuOzWqqbImx4
	YiKt3p+U8vAgURYJuFmZbPIGNHpQ5in2nuEu94BSGJLHjpKbrNjudtjLyUkn2vdXoGWWCrQSpJ3
	yoZe4IUdBOfm7BvrsvhYfA6a31rJZG8TdkP1qujpcUHaw/ATTOMpDVtjjZXqRVkMEvjdmyQG3En
	gjB7/u10/8aYxtaOA9XeRWr+bvTi7QQkZ2FFuwJDiMdFGGUVh3JJYgr51f2xKnJKHMflChB2BBG
	8ZmD+4etiw63VCTsF0PGn1Yl83Uu4f5nXbxhMmteS0xbjNcMCpuq0h3RVW3Na6/AIGcYnCnWWm1
	bWGdtU/2d360nyeT
X-Received: by 2002:a17:90b:1344:b0:3a8:c0cd:57fb with SMTP id 98e67ed59e1d1-3adce0cff80mr2343177a91.42.1792775434342;
        Fri, 23 Oct 2026 10:10:34 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3addd78d4a5sm919619a91.0.2026.10.23.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:10:33 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:10:16 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Alan Maguire <almagui@kernel.org>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	willemb@google.com, eddyz87@gmail.com, edumazet@google.com,
	john.fastabend@gmail.com, kuba@kernel.org, horms@kernel.org,
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
	song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
	yonghong.song@linux.dev, jolsa@kernel.org, kuniyu@google.com,
	memxor@gmail.com, emil@etsalapatis.com, martin.lau@kernel.org,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_ksock_bind() kfunc
Message-ID: <atuU-BE4wssJaH4_@gmail.com>
References: <20261022181620.247201-1-mahe.tardy@gmail.com>
 <e31194dd72efd3c182707e870b7e7a6d67b78be23cea06aded0275678373c64c@mail.kernel.org>
 <atseCFvfx9FbTXP3@gmail.com>
 <b28db1fb-ea02-4f83-be99-c8d4b180dc6b@kernel.org>
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
In-Reply-To: <b28db1fb-ea02-4f83-be99-c8d4b180dc6b@kernel.org>

On Fri, Oct 23, 2026 at 05:05:10PM +0100, Alan Maguire wrote:
> On 10/23/26 9:42 AM, Mahe Tardy wrote:
> > On Thu, Oct 22, 2026 at 06:45:34PM +0000, bot+bpf-ci@kernel.org wrote:
> >>> bpf: Add bpf_ksock_bind() kfunc
> >>
> >> TL;DR: bpf_ksock_bind() called from a bpf_wq callback runs with kworker's full
> >> capabilities, so a CAP_BPF-only SYSCALL program may bypass the privileged-port
> >> (CAP_NET_BIND_SERVICE) check; the review asks whether to block it.
> > 
> > Honestly don't know if it makes sense to prevent it given you are
> > creating this kernel socket from a BPF context, if anyone with more
> > experience on this can help?
> > 
> > If the answer is yes, I imagine preventing bind() to run from a
> > workqueue is the easy answer so that all creds are respected as usual
> > and it's not a huge limitation (we mostly care about being able to
> > send()/sendto() from a wq).
> > 
> 
> I suppose one way out of this would be to forbid bind()ing to the privileged
> port range; that would sidestep the issue I think. Hard to know how restrictive
> that would be in terms of real use cases, what do you think?

Yeah this is another way around it but I wonder if keeping the ability
to bind from a wq is more important than beeing able to bind on a
privileged port.

Otherwise we can probably guard bind with:

	if (current->flags & PF_KTHREAD)
		no

If the assumption is correct i.e. you can load and run any SYSCALL bpf
program with just CAP_BPF, then indeed having this would allow you to
circumvent a CAP_NET_BIND_SERVICE check which is kinda unexpected even
if we could maybe discuss that those are BPF sockets, which are pretty
limited for now, etc. The reason why I'm thinking like this:
- I already tried to import existing network resources limitation when
  writing the initial patch set, like limit the number of BPF sockets,
  and I was told it was unecessary.
- I did this whole annoying dance with LSM hooks so that ksock goes
  through them and I was kinda told that it was maybe also unecessary.
But the more I think about this the more I think the concern is valid.

> >>
> >>> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> >>> index 37168f43c16c..c7b487d90cd0 100644
> >>> --- a/net/core/bpf_ksock.c
> >>> +++ b/net/core/bpf_ksock.c
> >>

[...]
