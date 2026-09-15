Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7842E404
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494729; cv=pass; b=U7F/9GQDy616fJpIXtKBoJywhV97db++TtMqWxJjc+c0Hv8CqqeDA9qRyUR1JzZxuuMY4nW821m+bDN334UWGWxRAAYdd+untw0l8Gl9QIBk9/XGbqByC25A2lAtoDwSexaWnrlgeyRzvQCVN+hJnC46BDonMGOYUKExsTknOOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494729; c=relaxed/simple;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wl7TMPFlJ8PPi2roC3Rx87K2x2ULHTKuVTh1/2F7eAdtQzKN91MOYGVEI6+ciWfY0qSMV8zPH0LB0SGf6FJYrCdCa7br8g10LF84WSzG6QajOQtxLtyLvezMXiU+F1buEcQWd+wXEhJH8Yu1FsOGMxTywxYniILVDPZDD1kY7LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPgx9Wh6; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPgx9Wh6"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so12065ad.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=ShLtCyMJbSt96KGg+BaemfJoYvGhSENSgzzrGx51tlJs6rbOOcuO2TB29fTnwBwOPS
         NaiECJN4eH2kd8QxGnMb6IYeMF/1She3BlRkmJGh8egwpGRIzZb1C+jJnyZ6OdaBBpRa
         edJxBtAj2IdiFdguU+8bISeyH98JPZSY35374OrDxdLp05FnQuYnCRqBmXk9TTkPfy8H
         VwFp58D3N78iTJzf7XDVgvCxIlWbnn+3D2xDBAnv9qwa9bP4IKSZ8FLT+C5CPk8zKwTW
         2kuFTWheLf9TFBvGqGp9c55b92iX/taRxvw/9WefvbDWrlBz1tAzE9rkrYddQazFmsz9
         J7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=XgpFsJpdYynQrvBJebnzg1hPx6bzToWHg1E/dGSfdMw=;
        b=Ks4qDE7qh4JI5bpuNdUKkE0qx0a/J9tcrSzUDuQiusZWFhxgfrJ19iSJ1/pOElH3l+
         H7fr3YyhnkMP+tXiZJWGco8YmV6j9AUb7rEvgcLu5FtMh9dPZOasQXnd2dD6VhbwO0rF
         EADvYLU48fgiroHcrgOiqiAxBNVRvW4TsP2BdVWk/E+e/VcmWruvnr+V4v/3A2FP9nvu
         me0+BgOYNwpfhYS38omlHwzDfz3pGkxj59nCN74a2QH0u6CLc79dc0hhXszudhYgCPgK
         Ec7+bU6abgHwQ1Ut+AFllscLwoO6plFPmi2tRfJkwFHTget8DjmCW/3/bRj61L8rpns2
         j+gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=WPgx9Wh6g8ehXMOaZf8ZSNtevHb9fzr3lXk5INKsJirqC99dpiARLSwTsIwHA4pbMW
         JbWx8MvBxDUFu6opqA60njTwuSet+XjH0Wga4OKXeEmVhOXoy61UWc3rqiL6EU8/l428
         EjMY1UqvowxmFEZiD+cpXVE0I3gM0Ssco82ZH8FSIs0h6jzSdSLoGG2b/9Ga+W+7Aup7
         R3Y2jKX2VRyqaVjVjF8po02JGQLWYioBTM31SQGX//CGOHsZjgwuKy0KaaC3tSzQflwo
         ISJi8sLOMT0xayOGlmIx3TnuUJAs8/tTEps0xY78QDJPw7a+XDrg4k1OSruo0M4Rr9uE
         eRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=eJKiKkEAnL5CzeMC7U1gjZu40hz4nbYR0BXX1psMrNg0K5dZPLBFMXkBjvyUNrBn4+
         GXpH6wkoD65MtdbmgSUofD1XvvG1JfJfEUzFjoVXqjjE6tskyvJyRLbpqpHCU1EovpsH
         4yBgin221HphztUoNfw8M4sQiPfgJ4/CUxkPePoMXxrkPXe/6OyVp2+U2bF3B/ZIOjp8
         5tHk9orxmGqWR19981pZVJ44XF4QjZsLVzQrXiediaVUNJdLlZAxlpiI/GrJUSD26P8S
         WYJM8GEPVDn+LT4JPnkYbWSjha0fDk9tGBOYNVLsE8C64eoX1I/eojZ2ClGd4Is5MFcg
         mImA==
X-Forwarded-Encrypted: i=1; AKwUvBx/0yuxiF/DKSjU5gtg6RDxSMdGqfkeTSxxUKSV41PfeSJmAqlfZV7/PxW1D602AhoszB2I9UQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kScyOJ9f99kz6iArFbFyu2CcsUMmVfysWnnNhI2fP+hs3oTwX9
	5rakQ7UKGGp2lHfe3Fxmf4cUfdfUg9hpNxo4fzvg+rf4CKmlyUo2vHhbsLgAyCaPxQvQOxXpdz9
	g7LsWWhu9AyIEckpK9PDNoJ5Sc/rKJNbLtoTsWfYr
X-Gm-Gg: AYBFou3KqGJhcgF3zC+rZj7WAVtiRMLfgzczoM1gkw9UmMw63mTyQfxnIJc624IVwXQ
	GqtIiM55kEnAprpImqOyEdt7VPtfDJ58+B4okLZYBLk3SXa/OZ31HhZhihJZaYKIBJB/5YTzBMZ
	KCSmj5nmFk4pZfsnlcz9Wo/aI4KZUFnUTzjfWadK7+qu4Y0IlsxIdG97eyiNH9dWJW8m/0ZO4Ne
	IIvz0ysotnkl4L1Q/ZRCL1cKruz3N8weSpACmbvq2EpSVrudKju0+9uJyFZnyieoR2GAFEtls90
	1ASlSCDKBJQpsSXNlH0at66/E4tWgtc5Id1d1qS7bQ9zNw21whdvVdT/y003G8Bht27b5ZTPcYP
	x1Ka6EB25m4tTHOLDITQMFlGWwetXJtZDa1xFNajj9NPGeb6BPMc=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
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
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.
