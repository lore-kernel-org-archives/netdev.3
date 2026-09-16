Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024514AFE36
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552237; cv=none; b=Zn4o1A5jgqoo0AtJWolrcIx2a8XJXCLFjkG9DXNQMGZyZVFr2tsowELmSRX9oHaqAn36HaeqTjT2S9CC8FCgMtG14vlWuLHdBnLmmwFy4aTM2y3kz3Q4JRXFf54OG0x3BzTEAoa383Ml2OfBgfI7ko1GxxpxVMPO9pN2xuaNqLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552237; c=relaxed/simple;
	bh=zVftL0e6KTn1Fup/RmgkkUqXURXldH56P13A6WLi8KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvuW2wu0JrwkKffhsBwEiTbL3x85G/WjTg6IG3zFQTj6v8974C2+nhbZ5ppYd2zuDft/Y762SdjfzUH/TecgOubiT1YsNseLYeF++65+3ffERNSw8cRI7I4zqGWMvrgDPyRJDqslcgoVcQtIDQcv/kM1t7KHB5gIiFnaoPwGq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dzby88uf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzby88uf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so4145585e9.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789552219; x=1790157019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=Dzby88ufsV19pEuHSQnO0Z3r75FgiJ44qF/jXgKTm3w+wAYVSGDUH6LyexeTQiqa/g
         mb7EWvB3UuhKI7YAj+i2TOZr9/Z0Jn4HnQ3SO6kUkIrvAwSnRTzKzvfGb0So06LetuEf
         Ts3VEs9CM5zHiWBu1V4JZ71jpXN6ZkETnLDwqKE7PV3aA5kY0+ABvWOim6YHWnbq5cCK
         nHzOneSJDYvvXY/C7BkTDDo/hN/r3+9IBjrwRhsKYcoz9kdWM+uOTg6K8qjcDaH6D7EX
         KA0rYEGGzwyipB5cM3imDGmhTpbUuWgcSiyW3ZIBr1TR7/Q7dN5mD7jr++kuJyreI5UR
         skeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552219; x=1790157019;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79YAdtaHEv3S3nDvYc6X9C5ar06F3FncZEtUncQdJQ4=;
        b=OkTmwtsQ8gRGBgRXw1eMHRlzHzKxl9XjZ13lqEqH/1NnjeVShT8hNo5xzoWOE+mRYp
         8UBb4brv6sk8QqEXnAYmVOD2eaDPhjAPxDsk+k05ZblYscV83i0bvya6GNWYp6Xg28xI
         v06SyLkv4MPbouEAy+Bj8ZpBuR08x1pP+2IL+DL9O9PjnqvBS3h0qRewPpJ51Ngdc/Qn
         wp/DyCfppH6eDTGzOh6Bfz7a4t++lmAY9BDQIKaAn31CZK4x7j7m9LTliXLwV3ciBjDa
         jOoVT/F0cSftZYn24J5GjHyCot8YMpIk8AFv7UipfqVaPIu7d1h2rjHQ0e5SSqljdssC
         qnUg==
X-Forwarded-Encrypted: i=1; AKwUvBysT2wgf/Lvv6t4rAmBvUtPbz+Wz/USkhRbiyjupVLHhbOjJsJGbgsqsFZ1lPZS+wA4cY/zvDY=@vger.kernel.org
X-Gm-Message-State: AFuF++lVn0SI80vQzWOLYXNZfxoYFJ17etZzrqckJvhflrRl25feDo7f
	0tl+dCpVcCBmgAgEjEVRmfnGEvVUVpWpErl7tsMby3UK7Ln101/h1vtp
X-Gm-Gg: AYBFou1HJ/iNMs3X64+XLk8XO3KbbLGPDRJ/cOduBH56EN8R/W+c4+2rXeAebqxVtlv
	Lcd0bdu4paiL8oXBZGFOa3OGLi4Wak/lM5zpDN3hWjqr5ikL30BQ8PcnMb4N94U6XT0Rro9LK0t
	kheMFVXjU+LD+JP2CpFzkKUiQVJTPr8z+xz54kSBrWHX9yeuFGFEodO2Rv0FWfUJeCMb5CU4qW9
	jhgaY5DP+pemfgia4pCOT3oqpNb0AovLhtRDa5XG1ZXi7opSCeV0keXGshifz60XJNWltf2JE1o
	Bf9l6XUAGd0XpXot5FY4288mdAbaGaN6TNuJj3DVr4U5R9nFFQc0VWAY8VT9fnWQdAylrV3lR2y
	+gO7cl+5A7hodV2x1nwH/PS7vNF7+lyEsREPwXlbkRWXgESw63AnpqHrRQf2bjighBW1d6OHqcW
	1SlzN8xvV02FlkdUGN6Pz66j+MFBpfPFfX5mhSK/GkYbhYVVntn+//LCKrPlt6fpuSi50plmWbj
	3AwpPqpu9PGsMbz2MHG7Hj7jRc5p9U49MSGvMsniZ5bOHY=
X-Received: by 2002:a05:600c:4ec6:b0:49c:fea3:8633 with SMTP id 5b1f17b1804b1-49eb732aec0mr19444455e9.24.1789552219000;
        Wed, 16 Sep 2026 02:50:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83b02245sm84055225e9.10.2026.09.16.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:50:18 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:50:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Jens Axboe
 <axboe@kernel.dk>, io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
Message-ID: <20260916105017.13ea5e36@pumpkin>
In-Reply-To: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
	<CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
	<CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 12:08:57 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
> >
> > Is this mainly about stuff like "we installed a file descriptor and
> > then the following put_user() failed"? Because if so, I think a nicer
> > fix would be to have a policy of "if userspace provides unwritable
> > memory to a syscall, just keep going and pretend the access worked",
> > and maybe have a sysctl that kills the process when this happens to
> > emphasize that userspace should not be doing this.  
> 
> We've done that before, where we just ignore put_user() errors and the
> user gets whatever the user gets.
> 
> It is maybe not optimal, but it's fine. You can find quite a lot of
> unchecked put_user() calls with a pattern like
> 
>         git grep '^[[:space:]]*put_user(.*);'
> 
> and some of them are in core code - see the two in kernel/fork.c, for example.
> 
> One of them says "if userspace has not set up a proper pointer then
> tough luck". The other one doesn't even bother with a comment.

I think the code should try to return EFAULT (IIRC that is too hard
in one of the exec cases).
Otherwise very unexpected things might happen if the memory is just
readonly.
If you ignore the error and the pointer is invalid the application will
get a SIGSEGV and (usually) die.
But winding back kernel data because a user copy failed is likely to
be problematic/difficult and at best have error path code that isn't
really tested.

As well as writing fd numbers to userspace, some sockopt code tries to
wind back if the write to optlen fails (which has been read earlier).

I've forgotten which Unix converted EFAULT to SIGSEGV in the system
call exit code - I'm sure one of the ones I've used did.

David

> 
> The scheduler has two cases too, although one of them is admittedly
> for another error case.
> 
> So yes, saying "if you pass bogus arguments, you get what you get" is
> a valid model. It's perhaps not the *preferred* model, but it's not
> wrong.
> 
> It *would* be wrong to take code that already has error handling and
> remove the error handling, though.
> 
>                   Linus
> 

