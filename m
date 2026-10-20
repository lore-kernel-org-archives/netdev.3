Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494513;
	b=AvMadKofHoZyDHm+XYBCYvuTj9k/U477ZNNUIJquISn6CYoxndyH86akLTH8RZ2ekViB
	 A8dydmYiJVbc/uL9KgPosk0lhnkq/QrAUgQXjH942O56dGXDPZ4HpKx5FZ37ZTgHCGMJZ
	 IZYRLWm3U5TD5mw4dVzrm1h2H11bBjDowbrpNwv5wW0hpjul33Bl0Nss+HlW+JM1ZuPx4
	 aOmPAqb0Hoe5GyOHh4UkY8wPxB1T+uf1W8nJtXcfZiLukLmH2jGMSeOm23WjGmto0u9c9
	 q7c8xzwFem9DWcXPHDCM+tNzewSP06s8vK9sHav3QNY3EQcTi59nnTTliiOw3cMEy2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=l1w3z7wsHrNCpDU9HOuKzDVQA7NKxsTiYS/eUjNMV8Q=;
	b=TQQLvyrIo/1KGBRBHl0w805sekM2WNuE5L0SE/z/fDIdCdB1tNdFio+msY64RJq1TWiB
	 4WBcb5XiExPYajqyEy/UKiGgzMA4Hv/TIJa6WnLQOWcwN8QCX0C6WuSM2zsdUzjdl97Nw
	 1YE9AFOL8SkMzg6oBmNguu1xqihrVI+1kavs4KcKiBfNMBinqswvEaDn/G5Fr04dXPgad
	 oYUYir7l7ib3OOx/MBwh1pxc5QCRgQyho49lutmzzzX0rMS6MXiLiG/rfInYiqWLi+Vyh
	 Lz1pY/2Uwlz0QQZfjT2hUd4QFoQFYGIIMgaANPaC+sso3L0eszDrEfZHtna2z98Monw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B5mbK8HO;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228FF60A263F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 11:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 228FF60A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B5mbK8HO
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4be28b82so2392498f8f.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792494506; x=1793099306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l1w3z7wsHrNCpDU9HOuKzDVQA7NKxsTiYS/eUjNMV8Q=;
        b=B5mbK8HOWHEzAEgbVkWU4S7v/Fu1/V9AeuFLHABONe267bAmAZ8rNKYCFUCvAdcUIS
         yN/XnGQ5LeJwZUxceQ00R5lbaIiwhgWcwaCzuUx+eU4H4hKdemUi0+iMRPER1F1ib1rC
         DV9MHOY23bjZrP9aNo6nrYGVG2V5XOy3AQoZk6cF8XhZV9Rc6oaEruPqiqa88CgMz658
         HGlRc9p+MMQQz6KVoeIiQcdkGptgJ4kzadgwffW5AaRvFTOkBvmjnLIpAnJwpAAVxElu
         N8oJYdQc1ulwIJqcbo1LzEdydF2tCl9qArHgFkjdatjD3IhlqFeG68uIMKqm5zPD4qDS
         vsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494506; x=1793099306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l1w3z7wsHrNCpDU9HOuKzDVQA7NKxsTiYS/eUjNMV8Q=;
        b=QYzrhsJaiH2DFKiJg43oiGcHP1o5eLGdna1pz33QIBYV9xhzSzzbLuHA92zIHCQWeJ
         n3ExEQVewiw/N8n+iEV6Ju6tdnSF+VdATppliyb85fIs0og4wySkM/LHkxQUbri2Shmy
         /NuoRajmsAYM0uDKVdcJx6ajOFq6MybgmVU5C4BdjTuJF2zTnQX7j2R82qPlypwnR99G
         KKp2ktLq4UwoQ0vb86WrexPAMzzYdrKfd+vGjTVQYS11aSPsgwbS1GsFE6+WvpLwhXMq
         9iCBSefn4/9bWKYRPC6Drcs5yWonUo8WNnsUEb0HxD893BfHj5A0uPXjXiupROI2jG4C
         xsoA==
X-Forwarded-Encrypted: i=1; AKwUvBxMfipFTfrjEf8SJqXfWsnDq2uz6JHAjieJ0DQo+D+2wDhrg9CG9aH77GyTlAVJqfu/hKm1MPE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLao57Vguw6fEnjwiuH8yUp3PHMomok3dI7oEi55gbpe/1MCEc
	XAvaWxyYDKML4rHhrsUOlEgWraP7WrG+d25VjgTAq7b8EmSzmw+rTRd4
X-Gm-Gg: AYBFou3yhTYkpNDuAAkcaUQ3ckhJsHuNRT5WeP4i54cYMAjE4uEpzKFjVeGyzY4nH25
	oImxK1oC7quOdrci4MVIztJSScy567NKnSgPsAcrA5cWNy73OYxRI0SgSxQrxcy/+LWd9gE6HHH
	KRwkrSdZJu1jTv/ccf0TCC71/L01PjXfKDJ+Q/6WC0bxXaUxr3DEi8oipZESDReIJflUcNkxHQk
	i/7g7OsJGdLpSehswsXLZFDV4VedQS0mMUmTtOzEPXeiyElxh5q1kjPaFp3zK/smcZmxoqkGSNw
	Snu/ieTzGYKJ1qzzw48l30Tsv9Mc27ipTtmCCiNaivFKl0n0JcrjdkeWy6SjxCyDUP0D89DRHd2
	JbShkpM6Fy0o8TNtmF7Ptua98Xam+pRe5WUmD/SVgOdAVMqvg1jeJZ65PZT2UGNRtiD9Jpd8o8M
	rhtxlefcYkFAlG2xlOM+N0BkXcDGLKhJ+i/7pZmpdp86P1TDgFYL0pVMiqRbgcxgIBmXTg3fniR
	zjypSlPp2iif41w4vJNUWTwQelX08feIYdE
X-Received: by 2002:a05:600c:8519:b0:4a1:722a:d2a3 with SMTP id 5b1f17b1804b1-4a1d760d830mr284575105e9.23.1792494506378;
        Tue, 20 Oct 2026 04:08:26 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d43242sm59681765e9.9.2026.10.20.04.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:08:25 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:08:24 +0200
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
Subject: Re: [PATCH bpf-next 7/8] selftests/bpf: Test forbidden
 bpf_ksock_sendto() LSM attach
Message-ID: <atdLqLm4HEa1C4SS@gmail.com>
References: <20261020102512.518479-8-mahe.tardy@gmail.com>
 <0f730af064fbd00f1b18405237995d4e78b3672fb4ee14eeaa26784aad4b9228@mail.kernel.org>
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
In-Reply-To: <0f730af064fbd00f1b18405237995d4e78b3672fb4ee14eeaa26784aad4b9228@mail.kernel.org>

On Tue, Oct 20, 2026 at 10:52:16AM +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach
> 
> TL;DR:
> - Selftest calls bpf_ksock_sendto() without a prototype until a later patch,
>   so the test may not build or run here (bisectability)
> - Double blank line nit
> 
> > diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
> > --- a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
> > +++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
> > @@ -33,7 +33,26 @@ int BPF_PROG(socket_sendmsg_ksock_send, struct socket *sock, struct msghdr *msg,
> >  }
> >
> >  SEC("lsm.s/socket_sendmsg")
> > -__description("bpf_ksock operations other than send are allowed from socket_sendmsg LSM hook")
> > +__description("bpf_ksock_sendto is rejected from socket_sendmsg LSM hook")
> > +__failure __msg("calling kernel function bpf_ksock_sendto is not allowed")
> > +int BPF_PROG(socket_sendmsg_ksock_sendto, struct socket *sock,
> > +	     struct msghdr *msg, int size, int ret)
> > +{
> > +	struct bpf_ksock *ks;
> > +
> > +	ks = ksock_ctx_get();
> > +	if (!ks)
> > +		return ret;
> > +
> > +	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);
> 
> Is there a BPF-side prototype for bpf_ksock_sendto() at this point in the
> series?
> 
> ksock_common.h declares bpf_ksock_create(), bpf_ksock_connect(),
> bpf_ksock_acquire(), bpf_ksock_release() and bpf_ksock_send() with __ksym,
> and this patch only touches progs/ksock_lsm_verifier.c, so nothing declares
> bpf_ksock_sendto().  vmlinux.h carries types only, not function prototypes.
> 
> With a recent clang this should be a call to an undeclared function, which
> is an error.  With an older clang the call would be emitted as an undefined
> external symbol without __ksym/BTF information, and libbpf would fail to
> open or load the object.
> 
> Either way ksock_lsm_verifier.bpf.o, and therefore RUN_TESTS(ksock_lsm_verifier)
> in prog_tests/ksock.c, would not build or run at this commit, which breaks
> bisectability.
> 
> The declaration is only added by the later patch "selftests/bpf: Test ksock
> sendto()" (65327a57ba55), which adds this to ksock_common.h:
> 
>   int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data__sz,
>                        const union bpf_ksock_addr *addr__nullable,
>                        u32 addr__sz) __ksym;
> 
> Could that declaration move into this patch, or this patch be reordered after
> that one?

Yeah I re-ordered the last two patches last minute and forgot about
this.

> 
> > +	bpf_ksock_release(ks);
> > +
> > +	return ret;
> > +}
> > +
> > +
> 
> This isn't a bug, but there are two consecutive blank lines here after
> socket_sendmsg_ksock_sendto(), while the other programs in this file are
> separated by a single blank line (checkpatch --strict reports "Please don't
> use multiple blank lines").  Could one of them be dropped?

sure.

> 
> > +SEC("lsm.s/socket_sendmsg")
> > +__description("bpf_ksock acquire and release are allowed from socket_sendmsg LSM hook")
> >  __success
> >  int BPF_PROG(socket_sendmsg_ksock_allowed, struct socket *sock,
> >  	     struct msghdr *msg, int size, int ret)
> 
> [ ... ]
> 
> > @@ -103,6 +122,7 @@ int BPF_PROG(socket_connect_ksock_allowed, struct socket *sock,
> >  		return ret;
> >
> >  	bpf_ksock_send(ks, send_data, sizeof(send_data));
> > +	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);
> 
> This call to bpf_ksock_sendto() has the same missing-prototype problem
> described above.
> 
> >  	bpf_ksock_release(ks);
> >
> >  	return ret;
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39408886865

