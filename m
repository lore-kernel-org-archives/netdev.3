Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1573E5A05
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674872; cv=none; b=hwKG3W7VmQ6HXbVVAAq9JYKy4fshfGKuAABtr2P2wcc3Z7vLfVe39p6zTj0rYgYzynUt4PeYOtFDrBsmoIrQwf4ib0K1wPhYTGVdCkBpFgj5tfu7qcJ13L1m/3K2brbj/8aDdAUudW2ROGV8ZFqQA+6kLcjqfrt+04yF2yu8fk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674872; c=relaxed/simple;
	bh=Fj3s5frbyB6TsqrxQjPY0GZVgFWhmiPiWsC9BqFUZ+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK4upyzKEkkv1gR5Gsq4xZwgIKuOCdS4cNO/lpfL2fJcpcNjhUYWRSdQhms/ADQcZQXAjrMDX7SkPfrskFMcsX58HVrDE14Ddrf+6xn8qU1YHkEUPN0q4KZb0kXO+XUrrA1GVbmPsy2pPCJf9rVb8JmLb98zEIdEcOf1RK/XqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NDV8lzCh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NDV8lzCh"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bef47b1ac01so333379666b.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780674866; x=1781279666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hPSWEkREGIx4yoYWkytVFmLCkNUDGfpLW+35vC71FY=;
        b=NDV8lzChw4oKMyXkX9t5IqYYUJVCOTbJRWXrdeoBqfCJ9UZQyjtjuJtu9fzIq2hekM
         ljZQVDEd7BscYS+U2Wmt5ID50BZgMNpKiouciRCfcgMIaAnQ3+XVDDTzpIBlUXWpFBHc
         ECPsyTNrrD1IGyNRZsshdS1n9hzOF+PQcH4Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674866; x=1781279666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hPSWEkREGIx4yoYWkytVFmLCkNUDGfpLW+35vC71FY=;
        b=qRUKVPKOOeG7rvxCj5bg/Ogg3awBFzo4PjC6bYQgAd5omZ7x5RAHmBIvnxKuKIsPpl
         wcCfYWcblMWWSZe6cGhR+E5yVhfMZKWb17xVZRZU/G3T4wibsMjqLkUQvVo7TNrqRIbP
         aA1RO93zhXicnpToyqwxmlLh1uFxc16of2UDcEeoxgyiKXYQEcusXgOg0KTCLrO4C7MA
         Wa1Qpsfym006HjDwNUH3PFwkgyBGYJTNsrqlLxJQy6tkwt9VYZvwwBA581QXUfUi/xGT
         hCCwTSg+oFu092bLaPj6Vni1Z+lVX6KS0LxQaiPVGi17vgr2EOnt+gn3tC32f1ek4AV9
         zctQ==
X-Forwarded-Encrypted: i=1; AFNElJ+U5iKcRv6B7O/SHhiauCyiA59Wecx7z6VZOuYzfj6b+YjG/miAHUN+Js31Ut2je+uwHl13+cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg278uLQ3pUGcMUqWOmUCzup/CMErOrfNY2LQcuVEZRyAIGZRa
	Bx1+1QlkrTRoVOTMU998QDQsQD7Q6dMrjfEsXVJOP0yK4+1QyUnaLQ0S/Uqn6Keh4odeNw75ept
	PZUuM2mlTKA==
X-Gm-Gg: Acq92OEvTns1XY+CTobCh5WnY+1FuJE42L3v0w1qawHkY1LHMBihS2St1qn8YueLgW9
	bHBmEBkzk+7UOfdWSkBUA1yenfCcpEEDWXsDPXcOMlAMLf7tFbC1NsEs2c9hUg1GtP880zlASo8
	nVfq/ktUcK46Eiakc0iPXBNS5Vtsa/XxJ8dfkz04aH95vHcv/XEAZ7tN5Vjzlov7MRGWaOBVIqo
	HkDnh6pAJq59Ro+qdDCvAM7wLwqAVro+KTVr+3igDypWqN1Zr0gxEyi5QwEoArywBnW9oUUJG4k
	b6SeYHbomGM6jc8gKYl+/tOL5hOg1wmYVESvnkuKJNg70a6KWWhSBZAOfnewTVXcFCj8ND+bSjs
	amax3AaAzoSrB1rAHkmUpyRnBVM4Hu6u2+S6Ywj3DTlW/78/Mhv7DJJliLurkopNr8xrMb9khYq
	SEQ3vWhgyvgtqXQ+oG61JSYkaiACjN300/qdsvGVwH6YuIM9sPvOaoJAUiE9/2G1Hn9sjRelnFE
	6ZPaHmXFQU=
X-Received: by 2002:a17:906:9c96:b0:bec:de7b:163c with SMTP id a640c23a62f3a-bf3729333c5mr210144966b.35.1780674865794;
        Fri, 05 Jun 2026 08:54:25 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051770994sm485110966b.13.2026.06.05.08.54.25
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:54:25 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so2841899a12.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 08:54:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/x8kLJc5KT0MhO6iNX59uxVIOkRbhdd1kmyG/prPUhIBzXOz/Y35OEA2HmLJvpcAACaD2ICrQ=@vger.kernel.org
X-Received: by 2002:a17:907:741:b0:bef:d760:93ea with SMTP id
 a640c23a62f3a-bf37234c965mr227182666b.30.1780674864895; Fri, 05 Jun 2026
 08:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
 <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
 <20260604183829.63c35fd9@pumpkin> <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
 <20260604223216.73468830@pumpkin> <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
 <87se71jps4.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87se71jps4.fsf@oldenburg.str.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 08:54:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
X-Gm-Features: AVVi8CdvqDsmiM-EYrTUflKR5aYKg4JuQO6h_hoIzVtXJtUhEM3tfPOlti75Shw
Message-ID: <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Florian Weimer <fweimer@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, Askar Safin <safinaskar@gmail.com>, metze@samba.org, 
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 02:33, Florian Weimer <fweimer@redhat.com> wrote:
>
> * Linus Torvalds:
>
> > x86 really doesn't *care*. If the caller zero-extends or leaves high
> > bits set randomly, according to the x86 ABI that's perfectly fine: the
> > callee will only care about the low 32 bits. So the high bits are
> > simply not relevant for the ABI.
>
> Please note that Clang does not implement the x86-64 ABI and requires
> zero extension.  We see increasing problems from that, now that we have
> more C code calling Rust code.

Uhhuh. But that is only specific to 'bool', right?

If it were to have the same issue that powerpc(*) had - that 'unsigned
int' has to be passed to functions with well-defined high bits - that
would be bad.

And I'm pretty sure that clang doesn't do that.

Anyway, for the kernel, this shouldn't be an issue simply because we
typically avoid 'bool' in arguments or structures that are exposed to
outside.

(I say 'typically' because I'm sure it happens in some broken UAPI
thing anyway).

                  Linus

(*) I may mis-remember. Maybe it was s390, not powerpc. The s390
compat layer independently had a similar issue wrt pointers, where bit
31 had to be cleared. s390 dropped the 31-bit code entirely fairly
recently, but it caused some "interesting" code in the already
disgusting syscall argument handling wrapper macros.
