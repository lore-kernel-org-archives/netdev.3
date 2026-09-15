Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48441CB4D
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488502; cv=none; b=d/DuwAlS+pYJQqj6sMZNJmWFJY9hztenLz7sAdKlAN0aswZLZHAV3jR01cPT5wi4BBS5ySv11gnwpSQSrF/ijh7upAqFa8NVa5mOfqiC4ztroOy5S03hw1tpXxKSLc+oLFZ5S75mkRuL5/OOxewbN5+pTuf4Vway/FqtaWdONsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488502; c=relaxed/simple;
	bh=TaD3IKHcoZf0PQ+wUUh3mHvOgYZf6uXYuUZRFHNcE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOXp2JJki8QKKc81WYzQ/Y5ZqyYDpYHjq099IdZQw1lxsKNmy/YekDynOKKHNw4VxoW1B6jGhJVspKJnIQCA59j1bXsZXxv+hmt8fWPDO2qrhMC/wfXghXe5Oh1nCkN2Nhq9dPk+44hNOcEkHvlo1nJX7Q/mQaK9o1zvM1H3OyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NgSxOPyh; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NgSxOPyh"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c264788fd58so555168866b.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488498; x=1790093298; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=NgSxOPyhWn8JpG65Q1voFdGS71xuDz3Xct7bhbO5QbS5UL5p21g3UvCawoI5cBSZhc
         NE+9EwxmagMaipwQc75VcKA+GnRdKQHJpoxe/JyoJ+G4b0E8jOD6o52HsuQhKyqEEaut
         IDBzAhudCRu0UCmYw3x48RYAoAIqvoOSAtXdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488498; x=1790093298;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=f1T+i4bZa/SyQTi1+1h6H2S1KGTHLPXdbbQvAiw9yJKESKuy0wZJXIlFItZdHS3eVq
         W6pgwTOcBPG7w0xZ8vcHA6Q6OtcTgJPzeCvZzzzIK7EKVaueVSYTpA/Tmkf/chAEh+Zu
         kZj0/ZfErrx3MYMH8EO2e8fh+137PgUFx7bdyL7LwCkiUfr8nUkhZdgnLzbUtyq/Wy4U
         RPziDefNGZv9VC+P/tBg3kRGOrKqGHY/rqbrP1ayxAGyZT/sAZQr9K6Tn+QPW5753NFm
         MZakDf0EC0z+ThAvVP7UqoPsbq1mHjFDEdxxlxUgheiwqdJlI1NcQRLV1aQL7c5AeBns
         Pgkg==
X-Forwarded-Encrypted: i=1; AKwUvBxo85d/3jD0ST1w+antgkWEvFHmKmBKeBbe9UNo8SJqlfNnMr1ahIalclGT3vAzYpvylTVcgiE=@vger.kernel.org
X-Gm-Message-State: AFuF++nB1nq8t+dyqzCrZPdEgKLQZJOQQIeexBXAwn3eccGZs2no0iH2
	wukQMyLVK+AuEjvsXu7bHB0GltM3hvKgNMwAt/Llg3Hk+Fg4uotvVO7fCx8l+DTI4juRfZ4Ptdz
	AY319Urw=
X-Gm-Gg: AYBFou3075Mow5PQALH1tUAafCrR/32yup8NJkgQqqaOpaMqpdkWVLtricNx3/SBkIH
	UHDyxI63JfTDb2uuCN890OZTFVfFwQvNuq4GftpBVcSjX2SWAq+DLIIs5BUGbo+KqNdzxEkamNn
	YOdxy+33xB+tVgiwLGozS56AdCxY3o+psR7B/lSkDhYfjVw2pEaMz8r9pqbKkVidfQg7X6+PuEX
	sSGpchwZTVczxF70zPOPSL4jwGsOZkxLPKLQZKrYE0YQzvSLT7u/NMGPH1hmWLHWEVJCNs8a9Al
	g5e5DPL4eTMnvuSEwyyq1q4m4mLaSFmROJRJJPncfZAAur86b3YbOK4tA1rrG4i3udF5fazl4qY
	WYpR+qHjC9gnY7dLn2A4/SOpkV8w2xTpY31ALNkvnRZG8JVMIddCVFGSAczt/Omdla5OQ930fbl
	uwAyQ5N2pREamrx5rYWfoBfZjQvYsqCtsmxPgHgHyPLs/qPBwOFTt4c2QUxShyiTi0zct7y0VXl
	ydTPg9vcBnKVx1HiBWUuyb9uWjIzCoQIauPtYSrMsIVzRtnCe1hRGpKwcgkLQ==
X-Received: by 2002:a17:907:94c2:b0:c21:8c6a:c680 with SMTP id a640c23a62f3a-c29b863d918mr563908766b.22.1789488498417;
        Tue, 15 Sep 2026 09:08:18 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de602065sm393066b.47.2026.09.15.09.08.18
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:08:18 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c264788fd58so555165466b.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:08:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwxer3vg6LWmvjpCP6rB8izbVPMTZY/VhEv3A7mBj2zfsKyRpPz7a1xQtbysiy09lHEK9DYbTg=@vger.kernel.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus
