Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D53BED38
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216144; cv=pass; b=dV1n1c/4utMawwSi+QxzdmdrExvqDDLcl4AKz4iurwsFKMH01LuCUKLmOGj4VpH0klyAgu0lIxw26p6jFnTu7INkrvV3HytGcyVH2eOMvm/saq2CMIAO5WLTKYpzd+x2SWcEDWJ9uiZJYZMnZybN2/Od4tRC1f+5/g3uPBsrunI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216144; c=relaxed/simple;
	bh=u2srwtIURoWJNKL9GOJUQTifUvW2ecbh8OdnwhyADKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPWWDFvZMi05eOUvZIxR20qcne63Tc+Zr9jMmXbNMrRTuhaPC8ogVDrBVjM/wjsgfxbdf6mwAg/x+3CtJg6ucYTJvYquURk2Ik+s1gljNldQt/BJadEjVKFRJcaCJ8XWVOmljRoFihKgYBFYEIgNTq4OVvTqxb6KR3mdUjXitXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c1CQdwvh; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c1CQdwvh"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso4320253a91.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 15:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788216141; cv=none;
        d=google.com; s=arc-20260327;
        b=f5eKSBk6YMsiijNRPGlB1WEvyGsfxQRG14thW2PGZyIccJTVSynKniX2XDALfgv3ba
         YQ1QHW7+9fasxCD4XXFsR2nbKe9NJGm0CmIP0f8E8HiAblVxcCggVcrIIdA6N1h+ZCKK
         7hAWcQnxBAQGu9jLBiD9dksf+en7175x9N38DndfyMp3s70Js3KndLkKM8dlMtIR6+X4
         S9ENt/+tvTPQbxcoY9ikgWSSXbLlJMBuGG6U6fQkIR6BSN2XZPTmkk2v1lyYqkdoPyJK
         CUH6sqZuvCZBUGMXtWQRRVbDY+VGG7DbRtjCLniGYulniMlEwJ7lkMBbFS/MqWAtJBu3
         EE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vI8geleWwO5pOrRfS8mUYjVkQLKJQrHeDg+75fEyICw=;
        fh=eh1tkZsktwiKZ1WBbFHDGPo2CdD1rxIa7WvuFq9UTcs=;
        b=Jhlw6KqmuX9T8342hqrCPY6anmuSjLAzX7oK4GVFvcy61+0RkNwy3dZtasF8ITSNV2
         7/t/21RX5MrRNjy7rZf5LBmSHyre4eiWva5KQxuj1FLbYKAXe2XWBnWdkphEyRHOZX6n
         /ev0Z09A1VmSKEn/lhTYw+/dmJVj1KTx0WKDvETe2HELjx+4eNAKmXVFA0yOhB0PDI40
         r5c2JZT4WVq+gU02QpOCn3K9Lisql6ZIfuMhOEO2eKOiaFlAyikEpHM2ArcmbOA1/4mj
         dWIxoCHgHNTWWdSY+6frVRmYNCYGshYsLhYmTJdY7D6B4YwowOOZ83uofiClc/nNdvGH
         jXIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788216141; x=1788820941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vI8geleWwO5pOrRfS8mUYjVkQLKJQrHeDg+75fEyICw=;
        b=c1CQdwvhuHPaR1kj1yJsymkZHoVBtWUGSZL+YH9WDrc2IVZfW8BJuViw1xfnlVvCxZ
         8Sp2/tgSgJKD4+qnEJwFUiTjXekz0h0Fxir8zOvhxXbuRgz70hHOTXEvyqR94GdhQJdq
         a71sWc4v+5a8MKIcxhLvD2RkO+bGv6GWolo5QCfiPAOBTNkJAxh6i6lIdqhjbupwPl8s
         IaCew54tSThOP6a+lc+rUnN136LTCX8KoFxnDLVaiYqgBgo+OWLMVIlOATJlu6k2a93N
         WuqnjN6BDi7LT4ldz6e42P1AVAB5al3vwNm3sED8y1pXw86cfYWwVkkFNOf9MIkZLkEY
         dK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788216141; x=1788820941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vI8geleWwO5pOrRfS8mUYjVkQLKJQrHeDg+75fEyICw=;
        b=pYH4b4P7c7biZw9MkYF3zFhs+2oLRsy/Ivr6qtgpx5U6d8WD3uEXmjteDYatjJ3LBj
         nNrNFshAfxAv19alv7V5+Ob4DJNbbEUSVVIIDw2ZdK4kz1YB2oXbaWVmbA62xAHB4wdH
         g01ycF5deKczCKbtT7ZtcDW9JA2tvVO8g3SvzGolgDCFa3M1eWvBU4wWSG8QB6vpoBuF
         IOHPTkeQKqh3ySA+oBbVFsSdnSgkaFcMZTLMX+UNmF3FWqJ8KWcfGQxpiZnDvtKSRQ+K
         kW5p/SleE9Ied7fFQRmiQyvPvPZeTx7+9x1jJceYqRzLDMtCcq9TpSxdQ47IiKHiyTbC
         5zsw==
X-Forwarded-Encrypted: i=1; AKwUvBxVHU5t1lsGnB44HBHShV6iX1/GA9CFfqXNmqnk2CztX9mxKaMu8WD25HT0nEu8NbwcPYmJGvY=@vger.kernel.org
X-Gm-Message-State: AFuF++k8OYJZ9aHyND3ElH+KFy4LJ4AYFa/++aVQ8rA4exUs89gjDH6N
	cmACKUwpYpGjcVJXgXkhJHjfwnYdmotHs8fggPAfld4SgkMOPGRHQ46cNbylS2X9E7e+f312lyK
	xo8n53YTgfF2vksma01+m2Z2laVFyVS80lD3jyKmR
X-Gm-Gg: AYBFou3dPXRS51okFBZSkbPAldotjfHzgvW/s8jEubSx/TB80wStwaZ8lt4sV76qXWP
	ptL1JyAgvqkm6KSsx9FlvSYFckgJodDYKEVg7t2pyGtnt0uRELxEKaVOikepQ3JBOyjrc/CsA2g
	kLI0f5fbwK1fG8FpsV3F0QGu4lLzz3c6EI9otzhRpd+tE7nXCoBlakC7t4IFPn3Lm4pqJ3ojLf7
	ywhCsA9/xDGIHxe15jKr8texET35ig9HLZuPTj2MAPXcY4jm6cD2HVGeeHip+t7HYm7S463cLLL
	ZIcCzqBKqWY9GFIWnBhv5KGB2GGxemNdiTN+eNJ0DUAF
X-Received: by 2002:a17:90a:2ca2:b0:398:bee5:61d6 with SMTP id
 98e67ed59e1d1-398bee5663dmr14737593a91.24.1788216140807; Mon, 31 Aug 2026
 15:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831110934.241898-1-a.s.protopopov@gmail.com> <20260831110934.241898-2-a.s.protopopov@gmail.com>
In-Reply-To: <20260831110934.241898-2-a.s.protopopov@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 18:42:08 -0400
X-Gm-Features: AcwNN1UCNECLFYeBCknRn3HYL6duonlMTll2FvhXvryaFxITMxED4MtxRIMPUxE
Message-ID: <CAHC9VhT7=wMsB9mERWoiM6pF+_T1=2tyAsSrxMphhtdE2NPHMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to
 more hooks
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, lsm <linux-security-module@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, John Fastabend <john.fastabend@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 6:59=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> The BPF LSM programs are allowed to attach to LSM hooks, all of which
> are defined in the <lsm_hook_defs.h> header file.  From BPF's point
> of view the set of attachment points is defined in the bpf_lsm_hooks
> BTF set. By analogy with existing code, add a new header file
> <bpf_lsm_hook_defs.h> which will also be included in the bpf_lsm_hooks
> BTF set.
>
> This change allows attaching BPF LSM programs to more functions.
> The actual hooks are added in subsequent commits.
>
> Each BPF hook calls a [__weak] noinline function each time a hook is
> reached. This may be too expensive for hot paths if a BPF program is
> not attached. A future commit will optimize this by adding a per-hook
> static key and inc/dec it on attach/detach. This way disabled hooks
> will be bypassed efficiently.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/linux/bpf_lsm.h           | 12 ++++++++++++
>  include/linux/bpf_lsm_hook_defs.h |  6 ++++++
>  kernel/bpf/bpf_lsm.c              |  2 ++
>  4 files changed, 21 insertions(+)
>  create mode 100644 include/linux/bpf_lsm_hook_defs.h

Adding new BPF hooks in the kernel is one thing, but adding new BPF
LSM hooks outside of the LSM framework is likely to be problematic as
these new hooks operate disconnected from the LSM framework (callback
and LSM kernel object state management).  We've seen bugs in the past
caused by the BPF LSM trying to operate independently of the LSM
framework, something like this will only make that worse.

--=20
paul-moore.com
